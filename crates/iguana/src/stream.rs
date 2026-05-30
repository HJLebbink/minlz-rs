// Copyright 2026 MinIO Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//! Block-framed **streaming** layer for the whole-buffer Iguana codec.
//!
//! Iguana itself is whole-buffer (its rANS stage is LIFO and its control framing
//! is written backwards), so streaming is achieved the same way MinLZ does it:
//! the input is split into independent fixed-size blocks, each compressed with
//! [`crate::iguana_compress`], and framed as
//!
//! ```text
//! [4B magic "IGZS"][1B version]  ( [4B LE compressed-len][compressed block] )*  [4B LE 0]
//! ```
//!
//! with a zero-length end marker. This bounds working memory to ~one block and
//! allows incremental encode/decode via [`Write`]/[`Read`], at a modest ratio
//! cost for small blocks (the LZ window and rANS table reset per block).
//!
//! Because blocks are independent, [`compress`] and [`decompress`] add a
//! **multi-threaded bounded pipeline**: blocks are encoded/decoded across worker
//! threads with a bounded in-flight queue (memory stays `O(threads × block)`)
//! and written strictly in order, so the output is byte-identical to the
//! single-threaded path. Decode runs each block through the AVX-512 kernel.
//!
//! ```
//! use iguana::stream::{Reader, Writer};
//! use std::io::{Read, Write};
//!
//! let mut w = Writer::new(Vec::new());
//! w.write_all(b"hello iguana streaming").unwrap();
//! let framed = w.finish().unwrap();
//!
//! let mut out = Vec::new();
//! Reader::new(&framed[..]).read_to_end(&mut out).unwrap();
//! assert_eq!(out, b"hello iguana streaming");
//! ```

use std::io::{self, Read, Seek, SeekFrom, Write};
use std::sync::mpsc::{self, Receiver, SyncSender};
use std::sync::{Arc, Mutex};

use crate::EntropyMode;

const STREAM_MAGIC: &[u8; 4] = b"IGZS";
const STREAM_VERSION: u8 = 1;
const HEADER_LEN: usize = 5;

/// Trailer magic for the optional seek index (appended after the end marker).
const INDEX_MAGIC: &[u8; 4] = b"IGZX";

/// Default uncompressed block size (1 MiB): near whole-buffer ratio while
/// keeping per-block memory and latency small.
pub const DEFAULT_BLOCK_SIZE: usize = 1 << 20;

/// Reader safety cap on a single compressed frame, to bound allocation on
/// malformed input.
const MAX_FRAME_LEN: usize = 256 << 20;

/// A block index mapping each block to its `(compressed_offset,
/// uncompressed_offset)`, for random access. It can be **detached** from the
/// stream — produced at [`Writer::finish_index`] and stored out-of-band (e.g. in
/// object metadata), then [`load`](Index::load)ed and handed to
/// [`SeekReader::with_index`]. It can also be embedded in the stream trailer
/// (the default [`Writer::finish`]) for self-contained seeking via
/// [`SeekReader::new`]. ~16 bytes per block.
#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub struct Index {
    /// `(compressed_offset, uncompressed_offset)` per block, ascending.
    entries: Vec<(u64, u64)>,
    total: u64,
}

impl Index {
    /// Total uncompressed length the index covers.
    pub fn total_uncompressed(&self) -> u64 {
        self.total
    }

    /// Number of indexed blocks.
    pub fn len(&self) -> usize {
        self.entries.len()
    }

    /// Whether the index has no blocks.
    pub fn is_empty(&self) -> bool {
        self.entries.is_empty()
    }

    /// `(compressed_offset, uncompressed_offset)` of the block **containing**
    /// `uncompressed_offset` (the largest entry whose uncompressed offset is
    /// `<= target`). Decode from the compressed offset, then discard
    /// `target - uncompressed_offset` bytes. Mirrors MinLZ `Index.Find`.
    pub fn find(&self, uncompressed_offset: u64) -> (u64, u64) {
        if self.entries.is_empty() {
            return (0, 0);
        }
        let t = uncompressed_offset.min(self.total);
        let idx = match self.entries.binary_search_by(|&(_, u)| u.cmp(&t)) {
            Ok(i) => i,
            Err(0) => 0,
            Err(i) => i - 1,
        };
        self.entries[idx]
    }

    /// Header-free serialization for out-of-band storage:
    /// `[u64 total][u64 n] (n × [u64 comp_off][u64 uncomp_off])`. This is the
    /// detached form (no stream framing) — store it in metadata and recover it
    /// with [`Index::load`].
    pub fn to_bytes(&self) -> Vec<u8> {
        let mut p = Vec::with_capacity(16 + self.entries.len() * 16);
        p.extend_from_slice(&self.total.to_le_bytes());
        p.extend_from_slice(&(self.entries.len() as u64).to_le_bytes());
        for &(c, u) in &self.entries {
            p.extend_from_slice(&c.to_le_bytes());
            p.extend_from_slice(&u.to_le_bytes());
        }
        p
    }

    /// Parse the detached form produced by [`Index::to_bytes`].
    pub fn load(b: &[u8]) -> io::Result<Index> {
        if b.len() < 16 {
            return Err(io::Error::other("iguana index: too short"));
        }
        let total = u64::from_le_bytes(b[0..8].try_into().unwrap());
        let n = u64::from_le_bytes(b[8..16].try_into().unwrap()) as usize;
        if b.len() != 16 + n * 16 {
            return Err(io::Error::other("iguana index: size mismatch"));
        }
        let mut entries = Vec::with_capacity(n);
        for i in 0..n {
            let o = 16 + i * 16;
            let c = u64::from_le_bytes(b[o..o + 8].try_into().unwrap());
            let u = u64::from_le_bytes(b[o + 8..o + 16].try_into().unwrap());
            entries.push((c, u));
        }
        Ok(Index { entries, total })
    }
}

/// Serialise an index into the **in-stream trailer** appended after the
/// end-of-stream marker: `<Index::to_bytes> [u32 payload_len][IGZX]`. A
/// sequential reader stops at the end marker and never sees it; [`SeekReader::new`]
/// reads it from the tail.
fn serialize_index_trailer(index: &Index) -> Vec<u8> {
    let mut p = index.to_bytes();
    let payload_len = p.len() as u32;
    p.extend_from_slice(&payload_len.to_le_bytes());
    p.extend_from_slice(INDEX_MAGIC);
    p
}

/// Write the end-of-stream marker, optional padding, and—if `embed`—the index
/// trailer. `comp_pos` is the bytes already written (header + frames); padding
/// rounds the pre-trailer length up to a multiple of `padding` (≤ 1 = off),
/// filling from `padding_src` (zeros if `None`/short). Shared by [`Writer`] and
/// [`ConcurrentWriter`] so their stream tails are byte-identical.
fn write_stream_end(
    w: &mut dyn Write,
    mut comp_pos: u64,
    index: &Index,
    embed: bool,
    padding: usize,
    padding_src: Option<&mut (dyn Read + Send + 'static)>,
) -> io::Result<()> {
    w.write_all(&0u32.to_le_bytes())?; // end-of-stream marker
    comp_pos += 4;
    if padding > 1 {
        let pad = (padding - (comp_pos as usize % padding)) % padding;
        if pad > 0 {
            let mut b = vec![0u8; pad];
            if let Some(src) = padding_src {
                let mut filled = 0;
                while filled < pad {
                    match src.read(&mut b[filled..]) {
                        Ok(0) | Err(_) => break, // short source: rest stays zero
                        Ok(n) => filled += n,
                    }
                }
            }
            w.write_all(&b)?;
        }
    }
    if embed {
        w.write_all(&serialize_index_trailer(index))?;
    }
    w.flush()
}

/// Streaming Iguana encoder. Implements [`Write`]: bytes are buffered into
/// blocks of `block_size` and each full block is compressed and emitted. Call
/// [`Writer::finish`] to flush the final partial block, write the end marker,
/// and recover the inner writer.
pub struct Writer<W: Write> {
    inner: W,
    buf: Vec<u8>,
    block_size: usize,
    entropy: EntropyMode,
    header_written: bool,
    /// Per-block `(compressed_offset, uncompressed_offset)` for the seek index.
    index: Vec<(u64, u64)>,
    comp_pos: u64,
    uncomp_pos: u64,
    /// Round the stream length (before any index trailer) up to a multiple of
    /// this, filling with bytes from `padding_src`, so a length doesn't leak the
    /// object size. 0/1 = off. Mirrors MinLZ `WriterPadding`.
    padding: usize,
    padding_src: Option<Box<dyn Read + Send>>,
    /// Reusable encoder scratch (the ~2 MiB table etc.) + compressed-block buffer.
    encoder: crate::encoder::Encoder,
    block_out: Vec<u8>,
}

impl<W: Write> Writer<W> {
    /// New writer with the default entropy mode (ANS32) and block size (1 MiB).
    pub fn new(inner: W) -> Self {
        Self::with_options(inner, EntropyMode::Ans32, DEFAULT_BLOCK_SIZE)
    }

    /// New writer with an explicit entropy mode and block size (clamped ≥ 1).
    pub fn with_options(inner: W, entropy: EntropyMode, block_size: usize) -> Self {
        let block_size = block_size.max(1);
        Writer {
            inner,
            buf: Vec::with_capacity(block_size.min(1 << 20)),
            block_size,
            entropy,
            header_written: false,
            index: Vec::new(),
            comp_pos: 0,
            uncomp_pos: 0,
            padding: 0,
            padding_src: None,
            encoder: crate::encoder::Encoder::new(),
            block_out: Vec::new(),
        }
    }

    /// Pad the finished stream (excluding any embedded index trailer) up to a
    /// multiple of `n` bytes, so its length does not leak the uncompressed size.
    /// Fill bytes come from [`Writer::padding_src`] (zeros if none set). `n <= 1`
    /// disables padding. Mirrors MinLZ `WriterPadding`.
    pub fn padding(mut self, n: usize) -> Self {
        self.padding = n;
        self
    }

    /// Source of pseudo-random fill bytes for [`Writer::padding`]. Mirrors MinLZ
    /// `WriterPaddingSrc`.
    pub fn padding_src<R: Read + Send + 'static>(mut self, r: R) -> Self {
        self.padding_src = Some(Box::new(r));
        self
    }

    fn write_header(&mut self) -> io::Result<()> {
        if !self.header_written {
            self.inner.write_all(STREAM_MAGIC)?;
            self.inner.write_all(&[STREAM_VERSION])?;
            self.comp_pos += HEADER_LEN as u64;
            self.header_written = true;
        }
        Ok(())
    }

    /// Compress and emit the pending block (no-op if empty), recording its
    /// stream offsets in the index.
    fn flush_block(&mut self) -> io::Result<()> {
        if self.buf.is_empty() {
            return Ok(());
        }
        self.write_header()?;
        let ublk = self.buf.len();
        self.index.push((self.comp_pos, self.uncomp_pos));
        self.encoder
            .compress_into(&self.buf, self.entropy, &mut self.block_out);
        let len = u32::try_from(self.block_out.len())
            .map_err(|_| io::Error::other("iguana stream: compressed block exceeds 4 GiB"))?;
        self.inner.write_all(&len.to_le_bytes())?;
        self.inner.write_all(&self.block_out)?;
        self.comp_pos += 4 + self.block_out.len() as u64;
        self.uncomp_pos += ublk as u64;
        self.buf.clear();
        Ok(())
    }

    /// Shared finisher: pending block, then end marker + padding + (optionally)
    /// the embedded index trailer.
    fn finish_in_place_impl(&mut self, embed: bool) -> io::Result<Index> {
        self.flush_block()?;
        self.write_header()?;
        let idx = Index {
            entries: std::mem::take(&mut self.index),
            total: self.uncomp_pos,
        };
        write_stream_end(
            &mut self.inner,
            self.comp_pos,
            &idx,
            embed,
            self.padding,
            self.padding_src.as_deref_mut(),
        )?;
        Ok(idx)
    }

    /// Flush the final partial block, the end marker, optional padding, and the
    /// seek-index trailer, then return the inner writer. An empty stream still
    /// emits a valid header + end marker + (empty) index.
    pub fn finish(mut self) -> io::Result<W> {
        self.finish_in_place_impl(true)?;
        Ok(self.inner)
    }

    /// Finish the stream **without embedding the index**, returning the inner
    /// writer and the [`Index`] separately. Use this when the index is stored
    /// out-of-band (e.g. object metadata) and read back via
    /// [`SeekReader::with_index`]. The written stream has no `IGZX` trailer, so
    /// [`SeekReader::new`] will not find an index on it; padding (if any) makes
    /// the whole output a multiple of the padding size. Mirrors MinLZ
    /// `Writer.CloseIndex`.
    pub fn finish_index(mut self) -> io::Result<(W, Index)> {
        let idx = self.finish_in_place_impl(false)?;
        Ok((self.inner, idx))
    }

    /// Finish the current stream **in place** (flush + end marker + padding +
    /// embedded index trailer) without consuming the writer, so its encoder
    /// scratch can be reused for another stream via [`Writer::reset`] — the
    /// writer-pool pattern.
    pub fn finish_in_place(&mut self) -> io::Result<()> {
        self.finish_in_place_impl(true)?;
        Ok(())
    }

    /// Point the writer at a new sink for a fresh stream, reusing the encoder
    /// scratch and buffers; returns the previous sink. Resets all per-stream
    /// state — call [`Writer::finish_in_place`] first if the current stream's
    /// bytes still matter. Mirrors MinLZ `Writer.Reset`.
    pub fn reset(&mut self, w: W) -> W {
        self.buf.clear();
        self.index.clear();
        self.comp_pos = 0;
        self.uncomp_pos = 0;
        self.header_written = false;
        std::mem::replace(&mut self.inner, w)
    }
}

impl<W: Write> Write for Writer<W> {
    fn write(&mut self, mut data: &[u8]) -> io::Result<usize> {
        let total = data.len();
        while !data.is_empty() {
            let take = (self.block_size - self.buf.len()).min(data.len());
            self.buf.extend_from_slice(&data[..take]);
            data = &data[take..];
            if self.buf.len() >= self.block_size {
                self.flush_block()?;
            }
        }
        Ok(total)
    }

    /// Flushes already-completed blocks downstream. The pending partial block is
    /// intentionally *held* (flushing it would fragment the stream and cost
    /// ratio) until [`Writer::finish`].
    fn flush(&mut self) -> io::Result<()> {
        self.inner.flush()
    }
}

/// Chunk size for serving non-codec input verbatim under [`Reader::fallback`].
const PASSTHROUGH_CHUNK: usize = 64 << 10;

/// Streaming Iguana decoder. Implements [`Read`]: each framed block is read and
/// decompressed on demand, and its bytes are served across reads.
pub struct Reader<R: Read> {
    inner: R,
    block: Vec<u8>,
    pos: usize,
    started: bool,
    done: bool,
    /// Emit non-codec input verbatim instead of erroring (see [`Reader::fallback`]).
    fallback: bool,
    /// Assume the source is positioned at the first frame (no 5-byte header to
    /// consume/validate); see [`Reader::ignore_stream_identifier`].
    ignore_magic: bool,
    /// True once we've decided the input is not an Iguana stream and are passing
    /// the bytes through unchanged.
    passthrough: bool,
    /// Reusable decoder scratch (arena) + compressed-frame buffer.
    decoder: crate::structural::Decoder,
    cbuf: Vec<u8>,
}

impl<R: Read> Reader<R> {
    pub fn new(inner: R) -> Self {
        Reader {
            inner,
            block: Vec::new(),
            pos: 0,
            started: false,
            done: false,
            fallback: false,
            ignore_magic: false,
            passthrough: false,
            decoder: crate::structural::Decoder::new(),
            cbuf: Vec::new(),
        }
    }

    /// Skip the 5-byte stream identifier (magic + version): assume the source is
    /// already positioned at the first frame. For resuming a mid-stream / already
    /// header-consumed source. Mirrors MinLZ `ReaderIgnoreStreamIdentifier`.
    pub fn ignore_stream_identifier(mut self, yes: bool) -> Self {
        self.ignore_magic = yes;
        self
    }

    /// Point the reader at a new source, reusing the decoder arena and buffers;
    /// keeps the `fallback`/`ignore_stream_identifier` settings, resets stream
    /// state. The reader-pool hot-path reuse (mirrors MinLZ `Reader.Reset`).
    pub fn reset(&mut self, inner: R) {
        self.inner = inner;
        self.block.clear();
        self.pos = 0;
        self.started = false;
        self.done = false;
        self.passthrough = false;
    }

    /// Enable pass-through of non-codec input: if the stream does not begin with
    /// the Iguana magic, its bytes are served **verbatim** instead of erroring.
    /// Lets one read path handle a mix of compressed and uncompressed objects.
    /// Mirrors MinLZ `ReaderFallback(true)`. Set before the first read.
    pub fn fallback(mut self, yes: bool) -> Self {
        self.fallback = yes;
        self
    }

    fn read_header(&mut self) -> io::Result<()> {
        // Caller asserts the source already starts at the first frame.
        if self.ignore_magic {
            return Ok(());
        }
        // Read up to HEADER_LEN bytes (the input may be shorter, e.g. a tiny
        // non-codec object), then classify.
        let mut h = [0u8; HEADER_LEN];
        let mut got = 0;
        while got < HEADER_LEN {
            match self.inner.read(&mut h[got..])? {
                0 => break,
                n => got += n,
            }
        }
        if got >= 4 && &h[..4] == STREAM_MAGIC {
            if got < HEADER_LEN || h[4] != STREAM_VERSION {
                return Err(io::Error::other("unsupported Iguana stream version"));
            }
            return Ok(());
        }
        if self.fallback {
            // Not an Iguana stream: serve the peeked bytes, then the rest verbatim.
            self.passthrough = true;
            self.block.clear();
            self.block.extend_from_slice(&h[..got]);
            self.pos = 0;
            return Ok(());
        }
        Err(io::Error::other("not an Iguana stream (bad magic)"))
    }

    /// Read the next compressed frame into `self.cbuf`. `Ok(true)` if a frame was
    /// read, `Ok(false)` at the end-of-stream marker / EOF. Iguana mode only.
    fn read_frame(&mut self) -> io::Result<bool> {
        let mut lenb = [0u8; 4];
        match self.inner.read_exact(&mut lenb) {
            Ok(()) => {}
            // Tolerate a truncated trailing marker (treat as end of stream).
            Err(e) if e.kind() == io::ErrorKind::UnexpectedEof => return Ok(false),
            Err(e) => return Err(e),
        }
        let c = u32::from_le_bytes(lenb) as usize;
        if c == 0 {
            return Ok(false); // end-of-stream marker
        }
        if c > MAX_FRAME_LEN {
            return Err(io::Error::other("iguana stream: frame too large"));
        }
        self.cbuf.clear();
        self.cbuf.resize(c, 0);
        self.inner.read_exact(&mut self.cbuf)?;
        Ok(true)
    }

    /// Load the next block into `self.block`; returns `false` at end of stream.
    fn next_block(&mut self) -> io::Result<bool> {
        if self.passthrough {
            self.block.clear();
            self.block.resize(PASSTHROUGH_CHUNK, 0);
            let n = read_block(&mut self.inner, &mut self.block)?;
            self.block.truncate(n);
            self.pos = 0;
            return Ok(n > 0);
        }
        if !self.read_frame()? {
            return Ok(false);
        }
        self.decoder
            .decompress_into(&self.cbuf, &mut self.block)
            .map_err(|e| io::Error::other(format!("iguana stream: block decode failed: {e:?}")))?;
        self.pos = 0;
        Ok(true)
    }

    /// Discard up to `n` uncompressed bytes moving forward, returning the number
    /// actually skipped (`< n` only at end of stream). Works on a non-seekable
    /// source — whole blocks past the target are dropped **without decoding**
    /// (their length is peeked from the frame), so a large skip is cheap. Mirrors
    /// MinLZ `Reader.Skip`.
    pub fn skip(&mut self, mut n: u64) -> io::Result<u64> {
        if !self.started {
            self.read_header()?;
            self.started = true;
        }
        let mut skipped = 0u64;
        while n > 0 {
            let avail = (self.block.len() - self.pos) as u64;
            if avail > 0 {
                let take = avail.min(n);
                self.pos += take as usize;
                n -= take;
                skipped += take;
                continue;
            }
            if self.done {
                break;
            }
            if self.passthrough {
                if !self.next_block()? {
                    self.done = true;
                    break;
                }
                continue;
            }
            // Iguana mode: peek the next frame's uncompressed length; drop the
            // whole block if the skip covers it, else decode and consume within.
            if !self.read_frame()? {
                self.done = true;
                break;
            }
            let ulen = crate::structural::block_decoded_len(&self.cbuf)
                .map_err(|e| io::Error::other(format!("iguana stream: bad block: {e:?}")))?
                as u64;
            if n >= ulen {
                n -= ulen;
                skipped += ulen;
                self.block.clear();
                self.pos = 0;
            } else {
                self.decoder
                    .decompress_into(&self.cbuf, &mut self.block)
                    .map_err(|e| {
                        io::Error::other(format!("iguana stream: block decode failed: {e:?}"))
                    })?;
                self.pos = 0;
            }
        }
        Ok(skipped)
    }
}

impl<R: Read> Read for Reader<R> {
    fn read(&mut self, out: &mut [u8]) -> io::Result<usize> {
        if out.is_empty() {
            return Ok(0);
        }
        if !self.started {
            self.read_header()?;
            self.started = true;
        }
        loop {
            if self.pos < self.block.len() {
                let n = (self.block.len() - self.pos).min(out.len());
                out[..n].copy_from_slice(&self.block[self.pos..self.pos + n]);
                self.pos += n;
                return Ok(n);
            }
            if self.done || !self.next_block()? {
                self.done = true;
                return Ok(0);
            }
        }
    }
}

// ---------------------------------------------------------------------------
// Multi-threaded (bounded-pipeline) compress / decompress.
//
// Blocks are independent, so they compress/decompress in parallel. A bounded
// job queue caps the number of in-flight blocks (≈ `threads + 2`), so working
// memory stays O(threads × block_size) rather than ∝ input. Results are written
// strictly in block order via a queue of one-shot result receivers, so the
// output is byte-identical to the single-threaded path at the same block size.
// std threads + channels only; no external dependencies.
// ---------------------------------------------------------------------------

/// Read up to `buf.len()` bytes, returning the number read (`0` at EOF).
fn read_block<R: Read>(r: &mut R, buf: &mut [u8]) -> io::Result<usize> {
    let mut filled = 0;
    while filled < buf.len() {
        match r.read(&mut buf[filled..])? {
            0 => break,
            n => filled += n,
        }
    }
    Ok(filled)
}

type DecBlock = io::Result<Vec<u8>>;
/// Compressed block plus its uncompressed length (for the seek index).
type CompBlock = io::Result<(Vec<u8>, usize)>;

/// Multi-threaded streaming **compress**: reads `reader` in `block_size` blocks,
/// compresses them across `threads` workers (bounded in-flight), and writes the
/// framed stream + seek index to `writer` in order. `threads <= 1` uses the
/// single-threaded [`Writer`]. Output is byte-identical to [`Writer`] for the
/// same `entropy` and `block_size`.
pub fn compress<R: Read, W: Write + Send>(
    mut reader: R,
    writer: W,
    threads: usize,
    entropy: EntropyMode,
    block_size: usize,
) -> io::Result<W> {
    let threads = threads.max(1);
    let block_size = block_size.max(1);
    if threads == 1 {
        let mut w = Writer::with_options(writer, entropy, block_size);
        io::copy(&mut reader, &mut w)?;
        return w.finish();
    }

    // Job = (one-shot result sender, uncompressed block).
    type Job = (mpsc::Sender<CompBlock>, Vec<u8>);
    let (job_tx, job_rx): (SyncSender<Job>, Receiver<Job>) = mpsc::sync_channel(threads + 2);
    let job_rx = Arc::new(Mutex::new(job_rx));
    // Ordered queue of result receivers (one per block, in input order).
    let (ord_tx, ord_rx) = mpsc::channel::<Receiver<CompBlock>>();

    std::thread::scope(|s| -> io::Result<W> {
        // Writer thread owns `writer`, drains results in order, builds the index.
        let writer_handle = s.spawn(move || -> io::Result<W> {
            let mut w = writer;
            w.write_all(STREAM_MAGIC)?;
            w.write_all(&[STREAM_VERSION])?;
            let mut index: Vec<(u64, u64)> = Vec::new();
            let mut comp_pos = HEADER_LEN as u64;
            let mut uncomp_pos = 0u64;
            for res_rx in ord_rx {
                let (block, ublk) = res_rx
                    .recv()
                    .map_err(|_| io::Error::other("iguana stream: worker dropped result"))??;
                let len = u32::try_from(block.len()).map_err(|_| {
                    io::Error::other("iguana stream: compressed block exceeds 4 GiB")
                })?;
                index.push((comp_pos, uncomp_pos));
                w.write_all(&len.to_le_bytes())?;
                w.write_all(&block)?;
                comp_pos += 4 + block.len() as u64;
                uncomp_pos += ublk as u64;
            }
            w.write_all(&0u32.to_le_bytes())?; // end marker
            let idx = Index {
                entries: index,
                total: uncomp_pos,
            };
            w.write_all(&serialize_index_trailer(&idx))?;
            w.flush()?;
            Ok(w)
        });

        // Worker pool: compress blocks. Each worker keeps its own reusable
        // encoder so the ~2 MiB table is allocated once, not per block.
        for _ in 0..threads {
            let job_rx = Arc::clone(&job_rx);
            s.spawn(move || {
                let mut enc = crate::encoder::Encoder::new();
                loop {
                    let job = job_rx.lock().unwrap().recv();
                    match job {
                        Ok((res_tx, block)) => {
                            let ublk = block.len();
                            let mut out = Vec::new();
                            enc.compress_into(&block, entropy, &mut out);
                            let _ = res_tx.send(Ok((out, ublk)));
                        }
                        Err(_) => break, // queue closed
                    }
                }
            });
        }

        // Producer (this thread): read blocks, dispatch.
        let mut producer_res = Ok(());
        loop {
            let mut block = vec![0u8; block_size];
            match read_block(&mut reader, &mut block) {
                Ok(0) => break,
                Ok(n) => block.truncate(n),
                Err(e) => {
                    producer_res = Err(e);
                    break;
                }
            }
            let (res_tx, res_rx) = mpsc::channel();
            if ord_tx.send(res_rx).is_err() || job_tx.send((res_tx, block)).is_err() {
                break; // writer/workers gone
            }
        }
        drop(job_tx); // close queue -> workers exit
        drop(ord_tx); // close order -> writer finishes

        let writer_res = writer_handle
            .join()
            .unwrap_or_else(|_| Err(io::Error::other("iguana stream: writer thread panicked")));
        producer_res?;
        writer_res
    })
}

// ---------------------------------------------------------------------------
// Concurrent streaming Writer (a `Write` sink that parallelizes internally).
// Same bounded-pipeline shape as `compress`, but driven by `Write` calls: a
// dedicated writer thread owns the sink and drains per-block results in order,
// while a worker pool compresses. Output is byte-identical to the single-
// threaded `Writer` at the same `entropy`/`block_size`. Mirrors MinLZ
// `NewWriter(sink, WriterConcurrency(n))`. Requires `W: Send + 'static` because
// the sink is moved onto the writer thread for the writer's lifetime.
// ---------------------------------------------------------------------------

type CWJob = (mpsc::Sender<CompBlock>, Vec<u8>);
/// Writer-thread result: the recovered sink + index entries + totals.
type CWDone<W> = (W, Vec<(u64, u64)>, u64, u64);

/// Streaming Iguana encoder that compresses blocks across a worker pool. Implements
/// [`Write`]; call [`ConcurrentWriter::finish`] (or [`finish_index`](Self::finish_index))
/// to drain the pool and recover the sink. The MT counterpart of [`Writer`].
pub struct ConcurrentWriter<W: Write + Send + 'static> {
    buf: Vec<u8>,
    block_size: usize,
    padding: usize,
    padding_src: Option<Box<dyn Read + Send>>,
    job_tx: Option<SyncSender<CWJob>>,
    ord_tx: Option<mpsc::Sender<Receiver<CompBlock>>>,
    writer: Option<std::thread::JoinHandle<io::Result<CWDone<W>>>>,
    workers: Vec<std::thread::JoinHandle<()>>,
}

impl<W: Write + Send + 'static> ConcurrentWriter<W> {
    /// New concurrent writer with `threads` compression workers (clamped ≥ 1;
    /// `1` still uses the pipeline). Default entropy (ANS32), 1 MiB blocks.
    pub fn new(inner: W, threads: usize) -> Self {
        Self::with_options(inner, EntropyMode::Ans32, DEFAULT_BLOCK_SIZE, threads)
    }

    /// New concurrent writer with explicit entropy, block size, and worker count.
    pub fn with_options(inner: W, entropy: EntropyMode, block_size: usize, threads: usize) -> Self {
        let block_size = block_size.max(1);
        let threads = threads.max(1);
        let (job_tx, job_rx) = mpsc::sync_channel::<CWJob>(threads + 2);
        let job_rx = Arc::new(Mutex::new(job_rx));
        let (ord_tx, ord_rx) = mpsc::channel::<Receiver<CompBlock>>();

        // Writer thread owns the sink, drains results in order, builds the index.
        let writer = std::thread::spawn(move || -> io::Result<CWDone<W>> {
            let mut w = inner;
            w.write_all(STREAM_MAGIC)?;
            w.write_all(&[STREAM_VERSION])?;
            let mut index: Vec<(u64, u64)> = Vec::new();
            let mut comp_pos = HEADER_LEN as u64;
            let mut uncomp_pos = 0u64;
            for res_rx in ord_rx {
                let (block, ublk) = res_rx
                    .recv()
                    .map_err(|_| io::Error::other("iguana stream: worker dropped result"))??;
                let len = u32::try_from(block.len()).map_err(|_| {
                    io::Error::other("iguana stream: compressed block exceeds 4 GiB")
                })?;
                index.push((comp_pos, uncomp_pos));
                w.write_all(&len.to_le_bytes())?;
                w.write_all(&block)?;
                comp_pos += 4 + block.len() as u64;
                uncomp_pos += ublk as u64;
            }
            Ok((w, index, uncomp_pos, comp_pos))
        });

        let mut workers = Vec::with_capacity(threads);
        for _ in 0..threads {
            let job_rx = Arc::clone(&job_rx);
            workers.push(std::thread::spawn(move || {
                let mut enc = crate::encoder::Encoder::new();
                loop {
                    let job = job_rx.lock().unwrap().recv();
                    match job {
                        Ok((res_tx, block)) => {
                            let ublk = block.len();
                            let mut out = Vec::new();
                            enc.compress_into(&block, entropy, &mut out);
                            let _ = res_tx.send(Ok((out, ublk)));
                        }
                        Err(_) => break, // job queue closed
                    }
                }
            }));
        }

        ConcurrentWriter {
            buf: Vec::with_capacity(block_size.min(1 << 20)),
            block_size,
            padding: 0,
            padding_src: None,
            job_tx: Some(job_tx),
            ord_tx: Some(ord_tx),
            writer: Some(writer),
            workers,
        }
    }

    /// See [`Writer::padding`].
    pub fn padding(mut self, n: usize) -> Self {
        self.padding = n;
        self
    }

    /// See [`Writer::padding_src`].
    pub fn padding_src<R: Read + Send + 'static>(mut self, r: R) -> Self {
        self.padding_src = Some(Box::new(r));
        self
    }

    /// Dispatch the buffered block to the worker pool (in order). Returns an error
    /// if a worker/writer thread has died (the real cause surfaces at `finish`).
    fn dispatch_block(&mut self) -> io::Result<()> {
        if self.buf.is_empty() {
            return Ok(());
        }
        let block = std::mem::replace(
            &mut self.buf,
            Vec::with_capacity(self.block_size.min(1 << 20)),
        );
        let (res_tx, res_rx) = mpsc::channel::<CompBlock>();
        let gone = || io::Error::other("iguana stream: pipeline thread gone");
        self.ord_tx
            .as_ref()
            .ok_or_else(gone)?
            .send(res_rx)
            .map_err(|_| gone())?;
        self.job_tx
            .as_ref()
            .ok_or_else(gone)?
            .send((res_tx, block))
            .map_err(|_| gone())
    }

    fn finish_impl(mut self, embed: bool) -> io::Result<(W, Index)> {
        self.dispatch_block()?;
        // Close the pipeline: workers exit, the writer thread's loop ends.
        self.job_tx = None;
        self.ord_tx = None;
        for h in self.workers.drain(..) {
            let _ = h.join();
        }
        let (mut w, entries, uncomp_pos, comp_pos) = self
            .writer
            .take()
            .expect("writer thread present")
            .join()
            .map_err(|_| io::Error::other("iguana stream: writer thread panicked"))??;
        let idx = Index {
            entries,
            total: uncomp_pos,
        };
        write_stream_end(
            &mut w,
            comp_pos,
            &idx,
            embed,
            self.padding,
            self.padding_src.as_deref_mut(),
        )?;
        Ok((w, idx))
    }

    /// Drain the pool, write the end marker + padding + embedded index trailer, and
    /// return the sink. Byte-identical to [`Writer::finish`].
    pub fn finish(self) -> io::Result<W> {
        Ok(self.finish_impl(true)?.0)
    }

    /// Like [`finish`](Self::finish) but emits no trailer and returns the [`Index`]
    /// separately. Byte-identical to [`Writer::finish_index`].
    pub fn finish_index(self) -> io::Result<(W, Index)> {
        self.finish_impl(false)
    }
}

impl<W: Write + Send + 'static> Write for ConcurrentWriter<W> {
    fn write(&mut self, mut data: &[u8]) -> io::Result<usize> {
        let total = data.len();
        while !data.is_empty() {
            let take = (self.block_size - self.buf.len()).min(data.len());
            self.buf.extend_from_slice(&data[..take]);
            data = &data[take..];
            if self.buf.len() >= self.block_size {
                self.dispatch_block()?;
            }
        }
        Ok(total)
    }

    fn flush(&mut self) -> io::Result<()> {
        Ok(()) // completed blocks are owned by the writer thread; nothing to flush here
    }
}

impl<W: Write + Send + 'static> Drop for ConcurrentWriter<W> {
    fn drop(&mut self) {
        // If `finish` wasn't called, tear the pipeline down without detaching threads.
        self.job_tx = None;
        self.ord_tx = None;
        for h in self.workers.drain(..) {
            let _ = h.join();
        }
        if let Some(h) = self.writer.take() {
            let _ = h.join();
        }
    }
}

/// Multi-threaded streaming **decompress**: reads the framed stream from
/// `reader`, decompresses blocks across `threads` workers (bounded in-flight),
/// and writes the original bytes to `writer` in order. `threads <= 1` uses the
/// single-threaded [`Reader`].
pub fn decompress<R: Read, W: Write + Send>(
    mut reader: R,
    mut writer: W,
    threads: usize,
) -> io::Result<W> {
    let threads = threads.max(1);
    if threads == 1 {
        let mut r = Reader::new(reader);
        io::copy(&mut r, &mut writer)?;
        return Ok(writer);
    }

    // Header is read on this (producer) thread before fan-out.
    let mut hdr = [0u8; HEADER_LEN];
    reader.read_exact(&mut hdr)?;
    if &hdr[..4] != STREAM_MAGIC {
        return Err(io::Error::other("not an Iguana stream (bad magic)"));
    }
    if hdr[4] != STREAM_VERSION {
        return Err(io::Error::other("unsupported Iguana stream version"));
    }

    type Job = (mpsc::Sender<DecBlock>, Vec<u8>);
    let (job_tx, job_rx): (SyncSender<Job>, Receiver<Job>) = mpsc::sync_channel(threads + 2);
    let job_rx = Arc::new(Mutex::new(job_rx));
    let (ord_tx, ord_rx) = mpsc::channel::<Receiver<DecBlock>>();

    std::thread::scope(|s| -> io::Result<W> {
        let writer_handle = s.spawn(move || -> io::Result<W> {
            for res_rx in ord_rx {
                let block = res_rx
                    .recv()
                    .map_err(|_| io::Error::other("iguana stream: worker dropped result"))??;
                writer.write_all(&block)?;
            }
            writer.flush()?;
            Ok(writer)
        });

        for _ in 0..threads {
            let job_rx = Arc::clone(&job_rx);
            s.spawn(move || {
                let mut dec = crate::structural::Decoder::new();
                loop {
                    let job = job_rx.lock().unwrap().recv();
                    match job {
                        Ok((res_tx, block)) => {
                            let mut out = Vec::new();
                            let r =
                                dec.decompress_into(&block, &mut out)
                                    .map(|()| out)
                                    .map_err(|e| {
                                        io::Error::other(format!(
                                            "iguana stream: block decode failed: {e:?}"
                                        ))
                                    });
                            let _ = res_tx.send(r);
                        }
                        Err(_) => break,
                    }
                }
            });
        }

        // Producer: read frames `[u32 len][block]` until the zero marker.
        let mut producer_res = Ok(());
        loop {
            let mut lenb = [0u8; 4];
            match reader.read_exact(&mut lenb) {
                Ok(()) => {}
                Err(e) if e.kind() == io::ErrorKind::UnexpectedEof => break,
                Err(e) => {
                    producer_res = Err(e);
                    break;
                }
            }
            let c = u32::from_le_bytes(lenb) as usize;
            if c == 0 {
                break;
            }
            if c > MAX_FRAME_LEN {
                producer_res = Err(io::Error::other("iguana stream: frame too large"));
                break;
            }
            let mut cbuf = vec![0u8; c];
            if let Err(e) = reader.read_exact(&mut cbuf) {
                producer_res = Err(e);
                break;
            }
            let (res_tx, res_rx) = mpsc::channel();
            if ord_tx.send(res_rx).is_err() || job_tx.send((res_tx, cbuf)).is_err() {
                break;
            }
        }
        drop(job_tx);
        drop(ord_tx);

        let writer_res = writer_handle
            .join()
            .unwrap_or_else(|_| Err(io::Error::other("iguana stream: writer thread panicked")));
        producer_res?;
        writer_res
    })
}

// ---------------------------------------------------------------------------
// Random-access seek (`SeekReader`).
//
// The seek index lives in the trailer after the end marker; it maps each block
// to its `(compressed_offset, uncompressed_offset)`. To reach an uncompressed
// offset, binary-search the index for the containing block, seek the file to it,
// decode that one block, and skip within it. Seek resolution = the block size;
// the only cost per seek is decoding one block.
// ---------------------------------------------------------------------------

/// Random-access reader over an indexed Iguana stream. Requires a seekable
/// input (a file, not a pipe). Implements [`Read`] + [`Seek`] over the
/// *uncompressed* byte space.
pub struct SeekReader<R: Read + Seek> {
    inner: R,
    /// `(compressed_offset, uncompressed_offset)` per block, ascending.
    index: Vec<(u64, u64)>,
    total: u64,
    /// Currently-decoded block and our cursor within it.
    block: Vec<u8>,
    entry: usize,
    block_uoff: u64,
    pos: usize,
    abs: u64,
    decoder: crate::structural::Decoder,
    cbuf: Vec<u8>,
}

impl<R: Read + Seek> SeekReader<R> {
    /// Open `inner`, loading the **embedded** seek index from the tail (written by
    /// [`Writer::finish`]). Errors if the stream has no `IGZX` trailer (e.g. it was
    /// written with [`Writer::finish_index`], truncated, or has a bad header). For
    /// a detached index use [`SeekReader::with_index`].
    pub fn new(mut inner: R) -> io::Result<Self> {
        let end = inner.seek(SeekFrom::End(0))?;
        if end < (HEADER_LEN as u64 + 8) {
            return Err(io::Error::other("iguana stream: too short / no seek index"));
        }
        // Trailer: [u32 payload_len][IGZX].
        inner.seek(SeekFrom::End(-8))?;
        let mut t = [0u8; 8];
        inner.read_exact(&mut t)?;
        if &t[4..8] != INDEX_MAGIC {
            return Err(io::Error::other("iguana stream has no seek index"));
        }
        let plen = u32::from_le_bytes(t[..4].try_into().unwrap()) as u64;
        if plen < 16 || plen + 8 > end {
            return Err(io::Error::other("iguana stream: bad index length"));
        }
        inner.seek(SeekFrom::End(-(8 + plen as i64)))?;
        let mut payload = vec![0u8; plen as usize];
        inner.read_exact(&mut payload)?;
        let index = Index::load(&payload)?;
        Self::from_index(inner, index)
    }

    /// Open `inner` with an **externally-supplied** [`Index`] (e.g. loaded from
    /// object metadata via [`Index::load`]). The stream itself need not carry an
    /// index trailer — this is the read side of [`Writer::finish_index`], and the
    /// equivalent of MinLZ `Reader.ReadSeeker(index)`.
    pub fn with_index(inner: R, index: &Index) -> io::Result<Self> {
        Self::from_index(inner, index.clone())
    }

    /// Verify the stream header, build the reader from `index`, and prime block 0.
    fn from_index(mut inner: R, index: Index) -> io::Result<Self> {
        inner.seek(SeekFrom::Start(0))?;
        let mut h = [0u8; HEADER_LEN];
        inner.read_exact(&mut h)?;
        if &h[..4] != STREAM_MAGIC || h[4] != STREAM_VERSION {
            return Err(io::Error::other("not an Iguana stream"));
        }
        let total = index.total;
        let mut s = SeekReader {
            inner,
            index: index.entries,
            total,
            block: Vec::new(),
            entry: 0,
            block_uoff: 0,
            pos: 0,
            abs: 0,
            decoder: crate::structural::Decoder::new(),
            cbuf: Vec::new(),
        };
        if !s.index.is_empty() {
            s.load_entry(0)?;
        }
        Ok(s)
    }

    /// Total uncompressed length of the stream.
    pub fn total_uncompressed(&self) -> u64 {
        self.total
    }

    fn load_entry(&mut self, idx: usize) -> io::Result<()> {
        let (coff, uoff) = self.index[idx];
        self.inner.seek(SeekFrom::Start(coff))?;
        let mut lenb = [0u8; 4];
        self.inner.read_exact(&mut lenb)?;
        let clen = u32::from_le_bytes(lenb) as usize;
        if clen == 0 || clen > MAX_FRAME_LEN {
            return Err(io::Error::other("iguana stream: bad frame at index offset"));
        }
        self.cbuf.clear();
        self.cbuf.resize(clen, 0);
        self.inner.read_exact(&mut self.cbuf)?;
        self.decoder
            .decompress_into(&self.cbuf, &mut self.block)
            .map_err(|e| io::Error::other(format!("iguana stream: block decode failed: {e:?}")))?;
        self.entry = idx;
        self.block_uoff = uoff;
        self.pos = 0;
        Ok(())
    }

    /// Position the reader at uncompressed offset `target` (clamped to the
    /// stream length). Returns the new position.
    pub fn seek_uncompressed(&mut self, target: u64) -> io::Result<u64> {
        let target = target.min(self.total);
        if self.index.is_empty() {
            self.abs = target;
            return Ok(target);
        }
        // Largest entry whose uncompressed offset is <= target.
        let idx = match self.index.binary_search_by(|&(_, u)| u.cmp(&target)) {
            Ok(i) => i,
            Err(0) => 0,
            Err(i) => i - 1,
        };
        if self.block.is_empty() || idx != self.entry {
            self.load_entry(idx)?;
        }
        self.pos = ((target - self.block_uoff) as usize).min(self.block.len());
        self.abs = target;
        Ok(target)
    }
}

impl<R: Read + Seek> Read for SeekReader<R> {
    fn read(&mut self, out: &mut [u8]) -> io::Result<usize> {
        if out.is_empty() {
            return Ok(0);
        }
        loop {
            if self.pos < self.block.len() {
                let n = (self.block.len() - self.pos).min(out.len());
                out[..n].copy_from_slice(&self.block[self.pos..self.pos + n]);
                self.pos += n;
                self.abs += n as u64;
                return Ok(n);
            }
            if self.entry + 1 < self.index.len() {
                let next = self.entry + 1;
                self.load_entry(next)?;
            } else {
                return Ok(0); // end of stream
            }
        }
    }
}

impl<R: Read + Seek> Seek for SeekReader<R> {
    fn seek(&mut self, pos: SeekFrom) -> io::Result<u64> {
        let target = match pos {
            SeekFrom::Start(n) => n,
            SeekFrom::End(n) => (self.total as i64).saturating_add(n).max(0) as u64,
            SeekFrom::Current(n) => (self.abs as i64).saturating_add(n).max(0) as u64,
        };
        self.seek_uncompressed(target)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn roundtrip(data: &[u8], entropy: EntropyMode, block_size: usize, write_chunk: usize) {
        // Encode, feeding the writer in `write_chunk`-sized pieces.
        let mut w = Writer::with_options(Vec::new(), entropy, block_size);
        for piece in data.chunks(write_chunk.max(1)) {
            w.write_all(piece).unwrap();
        }
        let framed = w.finish().unwrap();
        assert_eq!(&framed[..4], STREAM_MAGIC, "missing stream magic");

        // Decode via read_to_end (exercises many internal reads).
        let mut out = Vec::new();
        Reader::new(&framed[..]).read_to_end(&mut out).unwrap();
        assert_eq!(
            out,
            data,
            "stream round-trip mismatch ({:?}, {} B, block {}, chunk {})",
            entropy,
            data.len(),
            block_size,
            write_chunk
        );

        // Decode again one byte at a time (small read buffer path).
        let mut r = Reader::new(&framed[..]);
        let mut out2 = Vec::new();
        let mut b = [0u8; 1];
        loop {
            let n = r.read(&mut b).unwrap();
            if n == 0 {
                break;
            }
            out2.push(b[0]);
        }
        assert_eq!(out2, data, "byte-at-a-time read mismatch");
    }

    #[test]
    fn roundtrips_sizes_modes_blocks() {
        let mut rng = 0x9e3779b9u32;
        let mut next = || {
            rng ^= rng << 13;
            rng ^= rng >> 17;
            rng ^= rng << 5;
            rng
        };
        // Text-ish, compressible data of various lengths around block boundaries.
        let make = |n: usize| -> Vec<u8> {
            (0..n)
                .map(|i| b"the quick brown fox jumps over "[i % 31])
                .collect()
        };
        let sizes = [0usize, 1, 63, 64, 100, 4096, 65536, 65537, 200_000];
        for &bs in &[64usize, 4096, 65536, DEFAULT_BLOCK_SIZE] {
            for &n in &sizes {
                let data = make(n);
                for mode in [
                    EntropyMode::None,
                    EntropyMode::Ans32,
                    EntropyMode::Ans1,
                    EntropyMode::AnsNibble,
                ] {
                    roundtrip(&data, mode, bs, 7919); // odd chunk size
                }
            }
        }
        // A pseudo-random (incompressible-ish) payload spanning many blocks.
        let rnd: Vec<u8> = (0..150_000).map(|_| next() as u8).collect();
        roundtrip(&rnd, EntropyMode::Ans32, 16 * 1024, 4096);
        roundtrip(&rnd, EntropyMode::None, 8 * 1024, 1);
    }

    #[test]
    fn empty_stream_is_valid() {
        use std::io::Cursor;
        let framed = Writer::new(Vec::new()).finish().unwrap();
        // header (5) + end marker (4) + index trailer (16 payload + 4 len + 4 magic).
        assert_eq!(framed.len(), HEADER_LEN + 4 + 24);
        let mut out = Vec::new();
        Reader::new(&framed[..]).read_to_end(&mut out).unwrap();
        assert!(out.is_empty());
        // An empty stream is still seekable (total = 0).
        let mut sr = SeekReader::new(Cursor::new(&framed)).unwrap();
        assert_eq!(sr.total_uncompressed(), 0);
        assert_eq!(sr.read(&mut [0u8; 4]).unwrap(), 0);
    }

    #[test]
    fn bad_magic_errors() {
        let mut out = Vec::new();
        let err = Reader::new(&b"NOPEx\x00\x00\x00\x00"[..])
            .read_to_end(&mut out)
            .unwrap_err();
        assert_eq!(err.kind(), io::ErrorKind::Other);
    }

    #[test]
    fn mt_output_is_identical_to_st() {
        // The bounded pipeline writes blocks in order, so MT output must be
        // byte-for-byte identical to the single-threaded Writer at the same
        // block size — for any thread count.
        let data: Vec<u8> = (0..500_000u32).map(|i| (i % 67) as u8).collect();
        let bs = 64 * 1024; // ~8 blocks
        let mut st = Writer::with_options(Vec::new(), EntropyMode::Ans32, bs);
        st.write_all(&data).unwrap();
        let st_out = st.finish().unwrap();
        for threads in [2usize, 3, 4, 8] {
            let mut mt = Vec::new();
            compress(&data[..], &mut mt, threads, EntropyMode::Ans32, bs).unwrap();
            assert_eq!(mt, st_out, "MT({threads}) output != ST output");
        }
    }

    #[test]
    fn mt_cross_roundtrips() {
        let data: Vec<u8> = (0..400_000u32)
            .map(|i| b"the quick brown fox "[(i as usize) % 20])
            .collect();
        let bs = 32 * 1024;
        // MT compress -> MT decompress
        let mut comp = Vec::new();
        compress(&data[..], &mut comp, 4, EntropyMode::Ans32, bs).unwrap();
        let mut out = Vec::new();
        decompress(&comp[..], &mut out, 4).unwrap();
        assert_eq!(out, data, "MT->MT round-trip");
        // MT compress -> ST Reader
        let mut out2 = Vec::new();
        Reader::new(&comp[..]).read_to_end(&mut out2).unwrap();
        assert_eq!(out2, data, "MT->ST round-trip");
        // ST Writer -> MT decompress
        let mut w = Writer::with_options(Vec::new(), EntropyMode::Ans32, bs);
        w.write_all(&data).unwrap();
        let st_comp = w.finish().unwrap();
        let mut out3 = Vec::new();
        decompress(&st_comp[..], &mut out3, 4).unwrap();
        assert_eq!(out3, data, "ST->MT round-trip");
    }

    #[test]
    fn mt_threads_one_falls_back() {
        let data = vec![42u8; 200_000];
        let mut a = Vec::new();
        compress(&data[..], &mut a, 1, EntropyMode::Ans32, 4096).unwrap();
        let mut b = Vec::new();
        decompress(&a[..], &mut b, 1).unwrap();
        assert_eq!(b, data);
    }

    #[test]
    fn seek_random_access() {
        use std::io::Cursor;
        let data: Vec<u8> = (0..500_000u32).map(|i| (i % 251) as u8).collect();
        let bs = 16 * 1024; // many small blocks
        let mut w = Writer::with_options(Vec::new(), EntropyMode::Ans32, bs);
        w.write_all(&data).unwrap();
        let framed = w.finish().unwrap();

        let mut sr = SeekReader::new(Cursor::new(&framed)).unwrap();
        assert_eq!(sr.total_uncompressed(), data.len() as u64);

        // Seek to assorted offsets (incl. block boundaries) and verify the span.
        for &off in &[
            0usize,
            1,
            12_345,
            bs - 1,
            bs,
            bs + 7,
            250_000,
            data.len() - 100,
            data.len() - 1,
        ] {
            sr.seek(SeekFrom::Start(off as u64)).unwrap();
            let mut buf = vec![0u8; 1000.min(data.len() - off)];
            sr.read_exact(&mut buf).unwrap();
            assert_eq!(buf, &data[off..off + buf.len()], "mismatch at offset {off}");
        }

        // SeekFrom::End (the `--tail` case).
        sr.seek(SeekFrom::End(-500)).unwrap();
        let mut tail = Vec::new();
        sr.read_to_end(&mut tail).unwrap();
        assert_eq!(tail, &data[data.len() - 500..]);

        // Seeking past the end clamps and reads zero.
        sr.seek(SeekFrom::Start(data.len() as u64 + 100)).unwrap();
        assert_eq!(sr.read(&mut [0u8; 8]).unwrap(), 0);

        // The index produced by the MT pipeline is equally seekable.
        let mut mt = Vec::new();
        compress(&data[..], &mut mt, 4, EntropyMode::Ans32, bs).unwrap();
        let mut sr2 = SeekReader::new(Cursor::new(&mt)).unwrap();
        sr2.seek(SeekFrom::Start(123_456)).unwrap();
        let mut b = vec![0u8; 2000];
        sr2.read_exact(&mut b).unwrap();
        assert_eq!(b, &data[123_456..123_456 + 2000]);
    }

    #[test]
    fn seek_no_index_errors() {
        use std::io::Cursor;
        assert!(SeekReader::new(Cursor::new(vec![0u8; 64])).is_err());
    }

    #[test]
    fn mt_decompress_propagates_corruption() {
        let data: Vec<u8> = (0..100_000u32).map(|i| (i % 13) as u8).collect();
        let mut comp = Vec::new();
        compress(&data[..], &mut comp, 4, EntropyMode::Ans32, 8192).unwrap();
        // Corrupt a byte inside the first block's payload (after the 5B header
        // and the 4B frame length).
        comp[20] ^= 0xff;
        let mut out = Vec::new();
        // Either a decode error surfaces, or it decodes to different bytes —
        // never a silent success returning the original. `.is_err()` drops the
        // returned writer borrow so `out` can be inspected.
        let failed = decompress(&comp[..], &mut out, 4).is_err();
        if !failed {
            assert_ne!(out, data, "corruption silently produced original");
        }
    }

    #[test]
    fn small_blocks_force_many_frames() {
        // 100 KiB with 1 KiB blocks -> ~100 independent frames.
        let data: Vec<u8> = (0..100_000u32).map(|i| (i % 17) as u8).collect();
        let mut w = Writer::with_options(Vec::new(), EntropyMode::Ans32, 1024);
        w.write_all(&data).unwrap();
        let framed = w.finish().unwrap();
        let mut out = Vec::new();
        Reader::new(&framed[..]).read_to_end(&mut out).unwrap();
        assert_eq!(out, data);
        // Sanity: it actually compressed (nibble-friendly small values).
        assert!(framed.len() < data.len());
    }
}

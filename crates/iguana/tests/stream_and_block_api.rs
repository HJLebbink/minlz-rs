//! Public stream/block API beyond basic round-trip: the detachable seek
//! [`Index`], reading non-codec input verbatim ([`Reader::fallback`]), forward
//! [`Reader::skip`] on a non-seekable source, and the single-block [`block`]
//! encode/decode primitives.

use std::io::{Cursor, Read, Write};

use iguana::EntropyMode;
use iguana::block;
use iguana::stream::{ConcurrentWriter, Index, Reader, SeekReader, Writer};

/// Semi-compressible corpus of `n` bytes (repeated English with a varying tail).
fn corpus(n: usize) -> Vec<u8> {
    let base = b"the quick brown fox jumps over the lazy dog. ";
    let mut v = Vec::with_capacity(n);
    let mut i = 0u32;
    while v.len() < n {
        v.extend_from_slice(base);
        v.extend_from_slice(&i.to_le_bytes());
        i += 1;
    }
    v.truncate(n);
    v
}

/// High-entropy (incompressible) bytes via xorshift32.
fn incompressible(n: usize) -> Vec<u8> {
    let mut x: u32 = 0x9e3779b9;
    (0..n)
        .map(|_| {
            x ^= x << 13;
            x ^= x >> 17;
            x ^= x << 5;
            (x >> 9) as u8
        })
        .collect()
}

// ---- single-block codec primitives -----------------------------------------

#[test]
fn block_roundtrip_and_reported_decoded_len() {
    for &len in &[0usize, 1, 63, 64, 500, 5000] {
        let data = corpus(len);
        let enc = block::encode(&data, EntropyMode::Ans32);
        assert_eq!(block::decoded_len(&enc).unwrap(), len, "decoded_len {len}");
        assert_eq!(block::decode(&enc).unwrap(), data, "roundtrip {len}");
    }
}

#[test]
fn block_encode_output_stays_within_max_encoded_len() {
    // Incompressible input must still not expand past the documented bound
    // (the encoder falls back to a raw/stored block).
    for &len in &[64usize, 100, 1000, 9000, 65536] {
        let data = incompressible(len);
        let enc = block::encode(&data, EntropyMode::Ans32);
        assert!(
            enc.len() <= block::max_encoded_len(len),
            "len={len}: encoded {} > bound {}",
            enc.len(),
            block::max_encoded_len(len)
        );
        assert_eq!(block::decode(&enc).unwrap(), data);
    }
}

#[test]
fn block_try_encode_returns_none_when_compression_does_not_help() {
    // Incompressible data: no meaningful savings -> None.
    let rnd = incompressible(8192);
    assert!(block::try_encode(&rnd, EntropyMode::Ans32, 0.05).is_none());
    // Repetitive text: clear savings -> Some, and it round-trips.
    let text = corpus(8192);
    let enc = block::try_encode(&text, EntropyMode::Ans32, 0.05).expect("should compress");
    assert!(enc.len() < text.len());
    assert_eq!(block::decode(&enc).unwrap(), text);
}

// ---- detachable seek index --------------------------------------------------

fn write_with_detached_index(data: &[u8], block_size: usize) -> (Vec<u8>, Index) {
    let mut w = Writer::with_options(Vec::new(), EntropyMode::Ans32, block_size);
    w.write_all(data).unwrap();
    w.finish_index().unwrap()
}

#[test]
fn seek_reader_with_external_index_reads_correct_bytes() {
    let data = corpus(4000);
    let (stream, index) = write_with_detached_index(&data, 256); // ~16 blocks

    // The index survives a serialize -> store -> load round-trip unchanged.
    let restored = Index::load(&index.to_bytes()).unwrap();
    assert_eq!(restored, index);
    assert_eq!(index.total_uncompressed(), data.len() as u64);
    assert!(index.len() > 1, "expected multiple blocks");

    // A detached stream has no trailer, so the embedded-index opener must fail...
    assert!(SeekReader::new(Cursor::new(stream.clone())).is_err());

    // ...but with the external index, seeks land on the right bytes.
    let mut sr = SeekReader::with_index(Cursor::new(stream), &index).unwrap();
    for &off in &[0u64, 100, 255, 256, 1000, 3999, 4000, 9999] {
        use std::io::Seek;
        sr.seek(std::io::SeekFrom::Start(off)).unwrap();
        // `read` serves up to one block; compare exactly the bytes it returned.
        let mut got = vec![0u8; 64];
        let n = sr.read(&mut got).unwrap();
        let start = (off as usize).min(data.len());
        assert_eq!(&got[..n], &data[start..start + n], "seek to {off}");
    }
}

#[test]
fn index_find_locates_block_containing_offset() {
    let data = corpus(4000);
    let (_stream, index) = write_with_detached_index(&data, 256);
    for &off in &[0u64, 300, 1234, 3999] {
        let (_comp, uncomp) = index.find(off);
        assert!(
            uncomp <= off,
            "find({off}) uncomp {uncomp} must be <= offset"
        );
    }
}

// ---- reading non-codec input verbatim (Reader::fallback) --------------------

#[test]
fn reader_fallback_returns_uncompressed_input_unchanged() {
    let plain = b"this is not an iguana stream, just raw bytes \x00\x01\x02".repeat(50);
    let mut out = Vec::new();
    Reader::new(Cursor::new(plain.clone()))
        .fallback(true)
        .read_to_end(&mut out)
        .unwrap();
    assert_eq!(out, plain);

    // Input shorter than the magic also passes through.
    let mut tiny_out = Vec::new();
    Reader::new(Cursor::new(b"hi".to_vec()))
        .fallback(true)
        .read_to_end(&mut tiny_out)
        .unwrap();
    assert_eq!(tiny_out, b"hi");
}

#[test]
fn reader_decodes_compressed_with_fallback_on_and_errors_with_it_off() {
    let data = corpus(3000);
    let mut w = Writer::with_options(Vec::new(), EntropyMode::Ans32, 512);
    w.write_all(&data).unwrap();
    let stream = w.finish().unwrap();

    // Fallback on: a genuine stream still decodes normally.
    let mut out = Vec::new();
    Reader::new(Cursor::new(stream.clone()))
        .fallback(true)
        .read_to_end(&mut out)
        .unwrap();
    assert_eq!(out, data);

    // Fallback off (default): non-codec input is an error.
    let mut sink = Vec::new();
    assert!(
        Reader::new(Cursor::new(b"not a stream".to_vec()))
            .read_to_end(&mut sink)
            .is_err()
    );
}

// ---- forward skip on a non-seekable reader ----------------------------------

#[test]
fn reader_skip_advances_to_offset_then_reads_the_rest() {
    let data = corpus(5000);
    let mut w = Writer::with_options(Vec::new(), EntropyMode::Ans32, 256); // ~20 blocks
    w.write_all(&data).unwrap();
    let stream = w.finish().unwrap();

    for &k in &[0u64, 50, 255, 256, 257, 1000, 4999, 5000, 99999] {
        let mut r = Reader::new(Cursor::new(stream.clone()));
        let skipped = r.skip(k).unwrap();
        assert_eq!(skipped, k.min(data.len() as u64), "skip({k}) count");
        let mut rest = Vec::new();
        r.read_to_end(&mut rest).unwrap();
        let start = (k as usize).min(data.len());
        assert_eq!(rest, &data[start..], "skip({k}) remainder");
    }
}

#[test]
fn reader_read_then_skip_then_read_returns_correct_bytes() {
    let data = corpus(4096);
    let mut w = Writer::with_options(Vec::new(), EntropyMode::Ans32, 300);
    w.write_all(&data).unwrap();
    let stream = w.finish().unwrap();

    let mut r = Reader::new(Cursor::new(stream));
    let mut head = vec![0u8; 100];
    r.read_exact(&mut head).unwrap();
    assert_eq!(head, &data[..100]);
    let skipped = r.skip(900).unwrap();
    assert_eq!(skipped, 900);
    let mut rest = Vec::new();
    r.read_to_end(&mut rest).unwrap();
    assert_eq!(rest, &data[1000..]);
}

// ---- reader/writer reuse (pooling) ------------------------------------------

#[test]
fn reader_reset_decodes_a_second_stream() {
    let (d1, d2) = (corpus(2000), corpus(3500));
    let s1 = {
        let mut w = Writer::with_options(Vec::new(), EntropyMode::Ans32, 256);
        w.write_all(&d1).unwrap();
        w.finish().unwrap()
    };
    let s2 = {
        let mut w = Writer::with_options(Vec::new(), EntropyMode::Ans32, 256);
        w.write_all(&d2).unwrap();
        w.finish().unwrap()
    };

    let mut r = Reader::new(Cursor::new(s1));
    let mut out = Vec::new();
    r.read_to_end(&mut out).unwrap();
    assert_eq!(out, d1);

    r.reset(Cursor::new(s2)); // reuse the same decoder/buffers
    out.clear();
    r.read_to_end(&mut out).unwrap();
    assert_eq!(out, d2);
}

#[test]
fn writer_finish_in_place_then_reset_writes_two_streams() {
    let (d1, d2) = (corpus(2000), corpus(3000));
    let mut w = Writer::with_options(Vec::new(), EntropyMode::Ans32, 256);

    w.write_all(&d1).unwrap();
    w.finish_in_place().unwrap();
    let s1 = w.reset(Vec::new()); // recover stream 1, reuse encoder scratch

    w.write_all(&d2).unwrap();
    w.finish_in_place().unwrap();
    let s2 = w.reset(Vec::new());

    for (s, d) in [(s1, d1), (s2, d2)] {
        let mut out = Vec::new();
        Reader::new(Cursor::new(s)).read_to_end(&mut out).unwrap();
        assert_eq!(out, d);
    }
}

// ---- concurrent writer (WriterConcurrency) ----------------------------------

#[test]
fn concurrent_writer_output_is_byte_identical_to_single_threaded() {
    let data = corpus(100_000);
    let st = {
        let mut w = Writer::with_options(Vec::new(), EntropyMode::Ans32, 4096);
        w.write_all(&data).unwrap();
        w.finish().unwrap()
    };
    for threads in [1usize, 2, 4] {
        let mut w = ConcurrentWriter::with_options(Vec::new(), EntropyMode::Ans32, 4096, threads);
        // Feed in small, unaligned chunks to exercise block buffering.
        for chunk in data.chunks(777) {
            w.write_all(chunk).unwrap();
        }
        let mt = w.finish().unwrap();
        assert_eq!(mt, st, "threads={threads}: MT output != ST output");

        let mut out = Vec::new();
        Reader::new(Cursor::new(mt)).read_to_end(&mut out).unwrap();
        assert_eq!(out, data, "threads={threads}: decode mismatch");
    }
}

#[test]
fn concurrent_writer_detached_index_seeks() {
    let data = corpus(50_000);
    let mut w = ConcurrentWriter::with_options(Vec::new(), EntropyMode::Ans32, 1024, 4);
    w.write_all(&data).unwrap();
    let (stream, index) = w.finish_index().unwrap();
    assert_eq!(index.total_uncompressed(), data.len() as u64);

    let mut sr = SeekReader::with_index(Cursor::new(stream), &index).unwrap();
    use std::io::Seek;
    sr.seek(std::io::SeekFrom::Start(40_000)).unwrap();
    let mut got = vec![0u8; 64];
    let n = sr.read(&mut got).unwrap();
    assert_eq!(&got[..n], &data[40_000..40_000 + n]);
}

// ---- encryption padding -----------------------------------------------------

#[test]
fn padding_rounds_detached_stream_length_to_a_multiple() {
    let data = corpus(5000);
    let pad = 512usize;
    let mut w = Writer::with_options(Vec::new(), EntropyMode::Ans32, 1024)
        .padding(pad)
        .padding_src(std::io::repeat(0x5a));
    w.write_all(&data).unwrap();
    let (stream, _index) = w.finish_index().unwrap();

    assert_eq!(
        stream.len() % pad,
        0,
        "detached stream not padded to multiple"
    );
    let mut out = Vec::new();
    Reader::new(Cursor::new(stream))
        .read_to_end(&mut out)
        .unwrap();
    assert_eq!(out, data, "padded stream must still decode");
}

// ---- ignore stream identifier + level mapping (misc parity) -----------------

#[test]
fn ignore_stream_identifier_reads_a_headerless_body() {
    let data = corpus(2000);
    let mut w = Writer::with_options(Vec::new(), EntropyMode::Ans32, 256);
    w.write_all(&data).unwrap();
    let stream = w.finish().unwrap();

    // Strip the 5-byte stream identifier; reader is told to assume frames start now.
    let body = stream[5..].to_vec();
    let mut out = Vec::new();
    Reader::new(Cursor::new(body))
        .ignore_stream_identifier(true)
        .read_to_end(&mut out)
        .unwrap();
    assert_eq!(out, data);
}

#[test]
fn entropy_mode_from_minlz_level_maps_as_documented() {
    assert_eq!(EntropyMode::from_minlz_level(-1), EntropyMode::None);
    assert_eq!(EntropyMode::from_minlz_level(0), EntropyMode::None);
    assert_eq!(EntropyMode::from_minlz_level(1), EntropyMode::None);
    assert_eq!(EntropyMode::from_minlz_level(2), EntropyMode::Ans32);
    assert_eq!(EntropyMode::from_minlz_level(3), EntropyMode::Ans32);
}

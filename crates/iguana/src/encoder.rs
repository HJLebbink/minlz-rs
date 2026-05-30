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

//! Iguana **encoder** — scalar port of Go `encoder.go`.
//!
//! Produces a valid Iguana stream (decodable by this crate *and* by Go): a
//! Lizard-style LZ parse into the six streams, optional per-stream rANS entropy
//! coding, and the control-command framing. The parse ports Go `compressSrc`: a
//! 4-deep hash chain whose candidate evaluation runs on the AVX-512 match-finder
//! kernel (`asm/match_avx512.asm`, see [`crate::matcher`]), with last-offset preference,
//! one-byte lazy lookahead and backward match extension. Output need not be
//! byte-identical to Go's encoder, only a valid stream that round-trips.

use crate::{ans_nibble_encode, ans1_encode, ans32_encode_simd};

/// Entropy back-end to apply per stream (rejected per stream if it doesn't help).
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum EntropyMode {
    /// No entropy coding (structural LZ only).
    None,
    /// Scalar 8-bit rANS.
    Ans1,
    /// 32-way interleaved rANS (Iguana default).
    Ans32,
    /// Scalar 4-bit (nibble) rANS.
    AnsNibble,
}

impl EntropyMode {
    /// Map a MinLZ compression level (`encode.go`: `LevelSuperFast=-1`,
    /// `LevelUncompressed=0`, `LevelFastest=1`, `LevelBalanced=2`,
    /// `LevelSmallest=3`) onto an iguana entropy mode. Levels ≤ 1 select
    /// structural-LZ-only (`None`, fastest, iguana's `-0`); ≥ 2 add the rANS
    /// entropy stage (`Ans32`, iguana's default and densest). Mirrors the intent
    /// of MinLZ `WriterLevel`.
    pub fn from_minlz_level(level: i32) -> EntropyMode {
        if level <= 1 {
            EntropyMode::None
        } else {
            EntropyMode::Ans32
        }
    }

    /// The 4-bit per-stream code written into the Iguana entropy header (and read
    /// back by the decoder's per-stream dispatch).
    fn header_code(self) -> u64 {
        match self {
            EntropyMode::None => 0,
            EntropyMode::Ans32 => 1,
            EntropyMode::Ans1 => 2,
            EntropyMode::AnsNibble => 3,
        }
    }
}

const STREAM_COUNT: usize = 6;
const CMD_MASK: u8 = 0x7f;
const CMD_COPY_RAW: u8 = 0x00;
const CMD_DECODE_IGUANA: u8 = 0x01;
const LAST_COMMAND_MARKER: u8 = 0x80;

const LITERAL_LEN_BITS: u8 = 3;
const MAX_SHORT_LIT_LEN: u32 = 7;
const MAX_SHORT_MATCH_LEN: u32 = 15;
const MM_LONG_OFFSETS: u32 = 16;
const LAST_LONG_OFFSET: u32 = 31;
const MIN_MATCH: usize = 4;

/// The six output streams plus the rolling last-offset.
#[derive(Default)]
struct Streams {
    tokens: Vec<u8>,
    offsets16: Vec<u8>,
    offsets24: Vec<u8>,
    var_lit_len: Vec<u8>,
    var_match_len: Vec<u8>,
    literals: Vec<u8>,
    last_offset: u32,
}

impl Streams {
    /// Clear all six streams (retaining capacity) for reuse across blocks.
    fn clear(&mut self) {
        self.tokens.clear();
        self.offsets16.clear();
        self.offsets24.clear();
        self.var_lit_len.clear();
        self.var_match_len.clear();
        self.literals.clear();
        self.last_offset = 0;
    }
}

impl Streams {
    /// Emit one (literal-run, match) sequence (port of `encodingContext.emit`).
    fn emit(&mut self, lit: &[u8], offs: u32, match_len: u32) {
        self.literals.extend_from_slice(lit);
        let lit_len = lit.len() as u32;

        if offs == self.last_offset || offs <= 0xffff {
            let mut token: u8 = 0x80;
            if offs != self.last_offset {
                token = 0x00;
                self.offsets16
                    .extend_from_slice(&(offs as u16).to_le_bytes());
            }
            token |= short_len(&mut self.var_lit_len, lit_len, MAX_SHORT_LIT_LEN);
            token |= short_len(&mut self.var_match_len, match_len, MAX_SHORT_MATCH_LEN)
                << LITERAL_LEN_BITS;
            self.tokens.push(token);
        } else {
            // 24-bit offset tokens can't carry literals: flush them first.
            if lit_len > 0 {
                let token = 0x80 | short_len(&mut self.var_lit_len, lit_len, MAX_SHORT_LIT_LEN);
                self.tokens.push(token);
            }
            // caller guarantees match_len > MAX_SHORT_MATCH_LEN here
            append_u24(&mut self.offsets24, offs);
            let token = if match_len < LAST_LONG_OFFSET + MM_LONG_OFFSETS {
                (match_len - MM_LONG_OFFSETS) as u8
            } else {
                append_varuint(
                    &mut self.var_match_len,
                    match_len - (LAST_LONG_OFFSET + MM_LONG_OFFSETS),
                );
                0x1f
            };
            self.tokens.push(token);
        }
        self.last_offset = offs;
    }
}

/// Encode a short length field: returns the in-token bits, spilling the excess
/// to `var` as a base-254 varint when it reaches the cap.
fn short_len(var: &mut Vec<u8>, len: u32, cap: u32) -> u8 {
    if len < cap {
        len as u8
    } else {
        append_varuint(var, len - cap);
        cap as u8
    }
}

/// Base-254 stream varint (port of `appendVarUint`).
fn append_varuint(s: &mut Vec<u8>, v: u32) {
    if v < 254 {
        s.push(v as u8);
    } else if v < 254 * 254 {
        s.push(254);
        s.push((v % 254) as u8);
        s.push((v / 254) as u8);
    } else {
        s.push(255);
        s.push((v % 254) as u8);
        let t = v / 254;
        s.push((t % 254) as u8);
        s.push((t / 254) as u8);
    }
}

fn append_u24(s: &mut Vec<u8>, v: u32) {
    s.push(v as u8);
    s.push((v >> 8) as u8);
    s.push((v >> 16) as u8);
}

/// Backward base-128 control varint (port of `appendControlVarUint`).
fn append_control_varuint(ctrl: &mut Vec<u8>, v: u64) {
    let blen = if v == 0 {
        0
    } else {
        64 - v.leading_zeros() as usize
    };
    let cnt = blen / 7 + 1;
    for i in (0..cnt).rev() {
        let mut x = ((v >> (i * 7)) as u8) & 0x7f;
        if i == 0 {
            x |= 0x80;
        }
        ctrl.push(x);
    }
}

fn append_control_command(ctrl: &mut Vec<u8>, last_cmd_off: &mut isize, v: u8) {
    if *last_cmd_off >= 0 {
        ctrl[*last_cmd_off as usize] &= CMD_MASK;
    }
    *last_cmd_off = ctrl.len() as isize;
    ctrl.push(v | LAST_COMMAND_MARKER);
}

/// Longest common prefix of `src[lo..]` and `src[hi..]` (lo < hi), capped so the
/// match stays within `src`.
fn lcp(src: &[u8], lo: usize, hi: usize) -> usize {
    let max = src.len() - hi;
    let mut m = 0;
    while m + 8 <= max {
        let a = u64::from_le_bytes(src[lo + m..lo + m + 8].try_into().unwrap());
        let b = u64::from_le_bytes(src[hi + m..hi + m + 8].try_into().unwrap());
        let d = a ^ b;
        if d != 0 {
            return m + (d.trailing_zeros() as usize / 8);
        }
        m += 8;
    }
    while m < max && src[lo + m] == src[hi + m] {
        m += 1;
    }
    m
}

use crate::matcher::{HISTSIZE, Match, best_match};

const CHAIN_BITS: u32 = 17; // hash-chain index width (Go `chainbits`)
const MIN_OFFSET: i32 = 32; // decoder over-write granularity (Go `minOffset`)
const SKIP_STEP: i32 = 2; // insertion stride (Go `skipStep`)

/// 5-byte rolling hash into the `1<<CHAIN_BITS` chain table (Go `matchtable.hash`).
fn hash_chain(src: &[u8], pos: usize) -> usize {
    let u = u64::from_le_bytes(src[pos..pos + 8].try_into().unwrap());
    ((u << 24).wrapping_mul(889_523_592_379) >> (64 - CHAIN_BITS)) as usize
}

/// Push `pos` onto the head of its hash chain (port of `matchtable.insert`).
fn chain_insert(table: &mut [[i32; HISTSIZE]], src: &[u8], pos: i32) {
    let e = &mut table[hash_chain(src, pos as usize)];
    e[3] = e[2];
    e[2] = e[1];
    e[1] = e[0];
    e[0] = pos;
}

/// Best `(targetpos, matchpos, matchlen)` at `pos` (port of `bestMatchAt`): the
/// last encoded offset first, then the hash chain (must beat it by >1 byte), then
/// the end-of-buffer 32-byte-write safety clamp. `matchpos`/`targetpos` may sit
/// earlier than `pos` (the chain match extends backward, down to `litpos`).
fn best_match_at(
    src: &[u8],
    table: &[[i32; HISTSIZE]],
    last_encoded_offset: u32,
    litpos: i32,
    pos: i32,
) -> Match {
    let n = src.len();
    let mut m = Match {
        target: pos,
        pos: 0,
        len: 0,
    };

    // 1) last encoded offset (always legal — reuses the token's X bit)
    if last_encoded_offset != 0 {
        let p = pos - last_encoded_offset as i32;
        if p >= 0 {
            m.pos = p;
            m.len = lcp(src, p as usize, pos as usize) as i32;
        }
    }
    // 2) hash chain, accelerated by the AVX-512 match finder
    let ent = &table[hash_chain(src, pos as usize)];
    let chain = best_match(src, litpos, pos, ent);
    if chain.len - m.len > 1 {
        m = chain;
    }

    // 3) end-of-buffer safety: the decoder's final write of a match is 32 bytes.
    let off = (m.target - m.pos) as u32;
    m.len = clamp_match_end(n, m.target as usize, off, m.len as usize) as i32;
    m
}

/// Truncate a match so the decoder's 32-byte over-write stays in bounds (port of
/// the end-safety clamp in `bestMatchAt`). Required for the Go AVX-512 decoder.
fn clamp_match_end(n: usize, pos: usize, off: u32, len: usize) -> usize {
    const MIN_OFF: i64 = 32;
    let (n, pos, off, mut mlen) = (n as i64, pos as i64, off as i64, len as i64);
    if pos + mlen > n - MIN_OFF {
        if off >= MIN_OFF {
            let lomask = MIN_OFF - 1;
            if pos + ((mlen + lomask) & !lomask) > n {
                mlen &= !lomask; // round down to a multiple of 32
            }
        } else {
            let movsize = off;
            let tailpos = mlen - (mlen % movsize);
            if pos + tailpos + MIN_OFF > n {
                let safedist = (n - MIN_OFF) - pos;
                mlen = (safedist / movsize) * movsize;
            }
        }
    }
    mlen.max(0) as usize
}

/// LZ parse of `src` into the (reused) six streams using the (reused) hash chain
/// `table` (port of `compressSrc`): a 4-deep hash chain match finder (AVX-512
/// accelerated via [`best_match`]), last-offset preference, one-byte lazy
/// lookahead, and skip-2 insertion. Caller clears `table`/`s` and guarantees
/// `src.len() >= 64` (`> MIN_OFFSET`), so every match search has 32 B of tail.
fn compress_src_into(src: &[u8], table: &mut [[i32; HISTSIZE]], s: &mut Streams) {
    let n = src.len();
    let last = n as i32 - MIN_OFFSET; // last allowed match position
    let mut pos = 5i32;
    let mut litpos = 0i32;
    chain_insert(table, src, 0);

    while pos <= last {
        let mut m = best_match_at(src, table, s.last_offset, litpos, pos);
        // One-byte lazy lookahead: if pos+1 yields a longer match, prefer it
        // rather than fragmenting a larger potential match.
        if pos < last {
            let m1 = best_match_at(src, table, s.last_offset, litpos, pos + 1);
            if m1.len > m.len {
                m = m1;
            }
        }
        debug_assert!(m.target + m.len <= n as i32 && litpos <= m.target);

        if m.len >= MIN_MATCH as i32 {
            s.emit(
                &src[litpos as usize..m.target as usize],
                (m.target - m.pos) as u32,
                m.len as u32,
            );
            // Insert the interior positions not yet seen (stride 2).
            let mut i = m.target;
            while i < m.target + m.len && i < last {
                chain_insert(table, src, i);
                i += SKIP_STEP;
            }
            pos = m.target + m.len;
            litpos = pos;
        } else {
            chain_insert(table, src, pos);
            pos += SKIP_STEP;
        }
    }
    s.literals.extend_from_slice(&src[litpos as usize..]);
}

fn entropy_encode(stream: &[u8], mode: EntropyMode) -> Option<Vec<u8>> {
    let cs = match mode {
        EntropyMode::None => return None,
        EntropyMode::Ans1 => ans1_encode(stream),
        EntropyMode::Ans32 => ans32_encode_simd(stream),
        EntropyMode::AnsNibble => ans_nibble_encode(stream),
    };
    // accept only if it actually shrank the stream (rejection threshold 1.0)
    if cs.len() < stream.len() {
        Some(cs)
    } else {
        None
    }
}

/// Reusable encoder: owns the ~2 MiB hash-chain table and the stream buffers so
/// that compressing many blocks (e.g. via [`crate::stream`]) doesn't re-allocate
/// — and re-fault — them per block. Hold one per thread.
pub(crate) struct Encoder {
    table: Vec<[i32; HISTSIZE]>,
    streams: Streams,
    ctrl: Vec<u8>,
}

impl Default for Encoder {
    fn default() -> Self {
        Self::new()
    }
}

impl Encoder {
    pub(crate) fn new() -> Self {
        Encoder {
            table: vec![[0i32; HISTSIZE]; 1usize << CHAIN_BITS],
            streams: Streams::default(),
            ctrl: Vec::new(),
        }
    }

    /// Compress `src` into `out` (cleared first), reusing internal scratch. The
    /// result is decodable by [`crate::iguana_decompress`] and by Go.
    pub(crate) fn compress_into(&mut self, src: &[u8], entropy: EntropyMode, out: &mut Vec<u8>) {
        out.clear();
        self.ctrl.clear();
        let mut last_cmd_off: isize = -1;

        // total uncompressed length (read first by the decoder)
        append_control_varuint(&mut self.ctrl, src.len() as u64);

        if src.is_empty() {
            emit_reversed(out, &self.ctrl);
            return;
        }
        if src.len() < 64 {
            raw_block_into(src, out);
            return;
        }

        // Parse into the reused stream buffers using the reused (cleared) table.
        self.streams.clear();
        self.table.fill([0i32; HISTSIZE]);
        compress_src_into(src, &mut self.table, &mut self.streams);
        let s = &self.streams;
        let ustreams: [&[u8]; STREAM_COUNT] = [
            &s.tokens,
            &s.offsets16,
            &s.offsets24,
            &s.var_lit_len,
            &s.var_match_len,
            &s.literals,
        ];

        // Per-stream entropy selection.
        let mut hdr: u64 = 0;
        let mut cstreams: [Vec<u8>; STREAM_COUNT] = Default::default();
        let mut total = 0usize;
        for (i, u) in ustreams.iter().enumerate() {
            match entropy_encode(u, entropy) {
                Some(cs) => {
                    hdr |= entropy.header_code() << (i * 4);
                    total += cs.len();
                    cstreams[i] = cs;
                }
                None => total += u.len(),
            }
        }

        // If compression didn't pay off, store raw.
        if total + STREAM_COUNT + 1 >= src.len() {
            raw_block_into(src, out);
            return;
        }

        append_control_command(&mut self.ctrl, &mut last_cmd_off, CMD_DECODE_IGUANA);
        append_control_varuint(&mut self.ctrl, hdr);
        for u in &ustreams {
            append_control_varuint(&mut self.ctrl, u.len() as u64);
        }
        for (i, u) in ustreams.iter().enumerate() {
            if (hdr >> (i * 4)) & 0x0f == 0 {
                out.extend_from_slice(u);
            } else {
                append_control_varuint(&mut self.ctrl, cstreams[i].len() as u64);
                out.extend_from_slice(&cstreams[i]);
            }
        }
        emit_reversed(out, &self.ctrl);
    }
}

/// Compress `src` into an Iguana stream using `entropy` per-stream where it
/// helps. The result is decodable by [`crate::iguana_decompress`] and by Go.
/// (Whole-buffer convenience; for many blocks reuse an [`Encoder`].)
pub fn iguana_compress(src: &[u8], entropy: EntropyMode) -> Vec<u8> {
    let mut out = Vec::new();
    Encoder::new().compress_into(src, entropy, &mut out);
    out
}

/// Write a raw (`cmdCopyRaw`) block for `src` into `out` (cleared first).
/// Bytes a control varuint of `v` occupies (7 payload bits per byte, ≥ 1).
pub(crate) const fn control_varuint_len(v: u64) -> usize {
    if v == 0 {
        return 1;
    }
    (64 - v.leading_zeros() as usize) / 7 + 1
}

/// Encode `src` as a single **raw (stored)** Iguana block. Output is exactly
/// `src.len() + 2*control_varuint_len(src.len()) + 1` bytes and decodes via
/// [`crate::iguana_decompress`]. Used as the never-expand fallback in
/// [`crate::block::encode`].
pub(crate) fn encode_raw_block(src: &[u8]) -> Vec<u8> {
    let mut out = Vec::new();
    raw_block_into(src, &mut out);
    out
}

fn raw_block_into(src: &[u8], out: &mut Vec<u8>) {
    out.clear();
    out.reserve(src.len() + 8);
    let mut ctrl = Vec::new();
    let mut last_cmd_off: isize = -1;
    append_control_varuint(&mut ctrl, src.len() as u64);
    append_control_command(&mut ctrl, &mut last_cmd_off, CMD_COPY_RAW);
    append_control_varuint(&mut ctrl, src.len() as u64);
    out.extend_from_slice(src);
    emit_reversed(out, &ctrl);
}

fn emit_reversed(dst: &mut Vec<u8>, ctrl: &[u8]) {
    dst.extend(ctrl.iter().rev());
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::iguana_decompress;

    fn roundtrip(src: &[u8], mode: EntropyMode) {
        let enc = iguana_compress(src, mode);
        let dec = iguana_decompress(&enc).expect("decompress");
        assert_eq!(
            dec,
            src,
            "round-trip mismatch ({:?}, {} bytes)",
            mode,
            src.len()
        );
    }

    #[test]
    fn clamp_end_safety() {
        // Far from the end: never clamped.
        assert_eq!(clamp_match_end(1000, 100, 50, 20), 20);
        // off >= 32 near the end: round the length down to a multiple of 32.
        // (40+31)&!31 = 64; 50+64 = 114 > 100, so 40 &!31 = 32.
        assert_eq!(clamp_match_end(100, 50, 40, 40), 32);
        // off < 32 near the end: shrink to whole `off`-sized copies that fit
        // within (n-32). safedist = (100-32)-50 = 18; (18/10)*10 = 10.
        assert_eq!(clamp_match_end(100, 50, 10, 45), 10);
        // Never goes negative.
        assert_eq!(clamp_match_end(40, 35, 33, 20), 0);
    }

    #[test]
    fn roundtrips() {
        let cases: Vec<Vec<u8>> = vec![
            b"".to_vec(),
            b"a".to_vec(),
            b"hello".to_vec(),
            b"the quick brown fox jumps over the lazy dog. ".repeat(20),
            b"abcabcabcabcabc".repeat(50),
            vec![0u8; 5000],
            (0..20000u32)
                .map(|i| (i.wrapping_mul(2654435761) >> 24) as u8)
                .collect(),
        ];
        for mode in [
            EntropyMode::None,
            EntropyMode::Ans1,
            EntropyMode::Ans32,
            EntropyMode::AnsNibble,
        ] {
            for c in &cases {
                roundtrip(c, mode);
            }
        }
    }

    /// A small-value-stream input where nibble entropy is actually selected,
    /// exercising the structural decoder's entropy-mode-3 path end to end.
    #[test]
    fn ans_nibble_composition() {
        // Bytes in 0..16 -> the high nibble is always 0, so nibble rANS shrinks
        // the literal/length streams and the encoder keeps it.
        let src: Vec<u8> = (0..30000u32).map(|i| (i % 13) as u8).collect();
        let enc = iguana_compress(&src, EntropyMode::AnsNibble);
        assert_eq!(iguana_decompress(&enc).expect("decompress"), src);
    }
}

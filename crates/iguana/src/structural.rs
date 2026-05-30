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

//! Iguana **structural (Lizard-style LZ) decoder** — scalar reference port of
//! Go `decoder.go` (`Decoder.Decompress` + `decompressIguanaReference`) and the
//! `stream.go` framing.
//!
//! Handles the `cmdDecodeIguana` path with raw
//! streams (header `0`), per-stream **ANS1** entropy (composed via
//! [`crate::ans1_decode`]), and `cmdCopyRaw`. ANS32 / ANS-nibble streams return
//! [`Error::Unsupported`] until the vectorised stages land (Stage 2+).

use crate::Error;
use std::borrow::Cow;

// ---------------------------------------------------------------------------
// AVX-512 (VBMI2) structural-decode kernel (`asm/decompress_avx512.asm`), a line-by-
// line NASM port of Go `decompressIguanaAVX512VBMI2`. Validated against the
// scalar `decompress_block` oracle via `tests/avx512_decompress_diff.rs`.
// ---------------------------------------------------------------------------

/// Go `streamPack` element: `stream{ data []byte; cursor int }` (size 32).
#[cfg(any(iguana_asm, iguana_sve2))]
#[repr(C)]
struct StreamHdr {
    data: *const u8,
    len: usize,
    cap: usize,
    cursor: i64,
}

/// C-ABI mirror of the Go stack frame the kernel reads via `[rbp+N]`. Shared by
/// the AVX-512 (`[rbp+N]`) and SVE2 (`[x0+N]`) structural-decode kernels.
#[cfg(any(iguana_asm, iguana_sve2))]
#[repr(C)]
struct IguanaArgs {
    dst_base: *mut u8,
    dst_len: usize,
    dst_cap: usize,
    streams: *const StreamHdr,
    last_offs: *const i64,
    ret_base: *mut u8,
    ret_len: usize,
    ret_cap: usize,
    ret_ec: i32,
    _pad: i32,
}

#[cfg(iguana_asm)]
unsafe extern "C" {
    fn iguana_avx512_decompress_vbmi2(args: *mut IguanaArgs);
}

/// Whether the structural-decode kernel is usable on this CPU. It needs
/// AVX-512 F/BW/VL plus VBMI (`vpermb`) and VBMI2 (`vpcompressb`/`vpexpandb`).
#[cfg(iguana_asm)]
fn avx512_decompress_available() -> bool {
    std::is_x86_feature_detected!("avx512f")
        && std::is_x86_feature_detected!("avx512bw")
        && std::is_x86_feature_detected!("avx512vl")
        && std::is_x86_feature_detected!("avx512vbmi")
        && std::is_x86_feature_detected!("avx512vbmi2")
}

#[cfg(iguana_sve2)]
unsafe extern "C" {
    fn iguana_sve2_decompress(args: *mut IguanaArgs);
}

/// Whether the SVE2 structural-decode kernel is usable on this CPU. The kernel
/// is plain SVE2 (predicated loads/stores + `whilelt`); no extra subsets needed.
#[cfg(iguana_sve2)]
fn sve2_decompress_available() -> bool {
    std::arch::is_aarch64_feature_detected!("sve2")
}

// ---------------------------------------------------------------------------
// SVE2 structural decode — Stage 4 of SVE2-PORT-PLAN.md.
//
// The full structural decoder IS ported and live on SVE2: `decompress_sve2.S`, a
// VLA re-derivation of `decompress_block`, wired into `decompress_block_simd`
// below (~+20% over scalar at VL=128 on the GB10; should widen on ≥256-bit cores).
//
// The per-token *sub-unit* `decode_tokens_sve2.S` (Unit 1: token-field arithmetic)
// is a SEPARATE artifact that is ⚠ NOT USED in the decode path: measured 2.7×
// SLOWER than the auto-NEON scalar at VL=128 (pure byte-ALU work, no width or
// capability edge — unlike the gather/FDIV-bound ans32 kernels). It is kept,
// validated, and reachable only from its differential test + the `decode_tokens`
// microbench, reserved for Stage B (batched token pre-decode) on a wider-VL core.
// See SVE2-PORT-PLAN.md.
// ---------------------------------------------------------------------------

/// Per-token flag bits (which streams a token consumes); see `decode_tokens_*`.
mod tokflag {
    pub const VAR_LIT_LEN: u8 = 0x02;
    pub const VAR_MATCH_LEN: u8 = 0x04;
    pub const OFFSET24: u8 = 0x08;
    pub const OFFSET16: u8 = 0x10;
}

/// Scalar reference for the SVE2 token-decode unit: derive `(flags, litlen_base,
/// matchlen_base)` for each token from the Lizard token semantics (the same rules
/// `decompress_block` applies inline). The varint values are added onto the
/// flagged tokens by a later unit; here `*_base` is the in-token portion.
fn decode_tokens_scalar(tokens: &[u8], flags: &mut [u8], litlen: &mut [u8], matchlen: &mut [u8]) {
    use tokflag::*;
    for (i, &t) in tokens.iter().enumerate() {
        let mut fl = 0u8;
        let (ll, ml);
        if t >= 32 {
            // [X_MMMM_LLL]: short literal + match length.
            let llf = t & MAX_SHORT_LIT_LEN; // t & 7
            let mlf = (t >> LITERAL_LEN_BITS) & MAX_SHORT_MATCH_LEN; // (t>>3)&15
            ll = llf;
            ml = mlf;
            if llf == MAX_SHORT_LIT_LEN {
                fl |= VAR_LIT_LEN;
            }
            if mlf == MAX_SHORT_MATCH_LEN {
                fl |= VAR_MATCH_LEN;
            }
            if t & 0x80 == 0 {
                fl |= OFFSET16; // else: reuse last offset
            }
        } else if t < LAST_LONG_OFFSET {
            // 24-bit offset, match length 16..46 baked into the base.
            ll = 0;
            ml = t + MM_LONG_OFFSETS as u8;
            fl |= OFFSET24;
        } else {
            // t == 31: 24-bit offset, extended match length (base 31+16 = 47).
            ll = 0;
            ml = LAST_LONG_OFFSET + MM_LONG_OFFSETS as u8;
            fl |= VAR_MATCH_LEN | OFFSET24;
        }
        flags[i] = fl;
        litlen[i] = ll;
        matchlen[i] = ml;
    }
}

#[cfg(iguana_sve2)]
unsafe extern "C" {
    fn iguana_sve2_decode_tokens(
        tokens: *const u8,
        n: usize,
        flags: *mut u8,
        litlen: *mut u8,
        matchlen: *mut u8,
    );
}

/// Scalar token-decode (bench/diff handle). NOT public API.
#[doc(hidden)]
pub fn decode_tokens_ref(tokens: &[u8], flags: &mut [u8], litlen: &mut [u8], matchlen: &mut [u8]) {
    decode_tokens_scalar(tokens, flags, litlen, matchlen);
}

/// SVE2 token-decode when available (else scalar). NOT public API and **not used by
/// the decoder** — it exists only so the `decode_tokens` microbench can show the
/// SVE2 kernel is currently slower than scalar at VL=128 (see the module banner).
/// Caller sizes all four output slices to `tokens.len()`.
#[doc(hidden)]
pub fn decode_tokens_simd(tokens: &[u8], flags: &mut [u8], litlen: &mut [u8], matchlen: &mut [u8]) {
    let n = tokens.len();
    debug_assert!(flags.len() >= n && litlen.len() >= n && matchlen.len() >= n);
    #[cfg(iguana_sve2)]
    if std::arch::is_aarch64_feature_detected!("sve2") {
        // SAFETY: all four slices have length >= n; the kernel writes exactly n bytes.
        unsafe {
            iguana_sve2_decode_tokens(
                tokens.as_ptr(),
                n,
                flags.as_mut_ptr(),
                litlen.as_mut_ptr(),
                matchlen.as_mut_ptr(),
            );
        }
        return;
    }
    decode_tokens_scalar(tokens, flags, litlen, matchlen);
}

// Per-stream entropy modes (4 bits each in the Iguana header).
const ENTROPY_NONE: u64 = 0;
const ENTROPY_ANS32: u64 = 1;
const ENTROPY_ANS1: u64 = 2;
const ENTROPY_ANS_NIBBLE: u64 = 3;

const CMD_MASK: u8 = 0x7f;
const CMD_COPY_RAW: u8 = 0x00;
const CMD_DECODE_IGUANA: u8 = 0x01;
const LAST_COMMAND_MARKER: u8 = 0x80;

const STREAM_COUNT: usize = 6;
const STRID_TOKENS: usize = 0;
const STRID_OFFSET16: usize = 1;
const STRID_OFFSET24: usize = 2;
const STRID_VAR_LIT_LEN: usize = 3;
const STRID_VAR_MATCH_LEN: usize = 4;
const STRID_LITERALS: usize = 5;

const LITERAL_LEN_BITS: u32 = 3;
const MM_LONG_OFFSETS: i64 = 16;
const MAX_SHORT_LIT_LEN: u8 = 7;
const MAX_SHORT_MATCH_LEN: u8 = 15;
const LAST_LONG_OFFSET: u8 = 31;
const INIT_LAST_OFFSET: i64 = 0;

/// A forward byte-stream reader with bounds-checked fetches (port of `stream`).
struct Reader<'a> {
    data: &'a [u8],
    cursor: usize,
}

impl<'a> Reader<'a> {
    fn new(data: &'a [u8]) -> Self {
        Reader { data, cursor: 0 }
    }
    fn empty(&self) -> bool {
        self.cursor >= self.data.len()
    }
    fn remaining(&self) -> usize {
        self.data.len() - self.cursor
    }
    fn fetch8(&mut self) -> Result<u8, Error> {
        let r = *self.data.get(self.cursor).ok_or(Error::OutOfInputData)?;
        self.cursor += 1;
        Ok(r)
    }
    fn fetch16(&mut self) -> Result<u16, Error> {
        if self.cursor + 2 > self.data.len() {
            return Err(Error::OutOfInputData);
        }
        let a = self.data[self.cursor] as u16;
        let b = self.data[self.cursor + 1] as u16;
        self.cursor += 2;
        Ok(a | (b << 8))
    }
    fn fetch24(&mut self) -> Result<u32, Error> {
        if self.cursor + 3 > self.data.len() {
            return Err(Error::OutOfInputData);
        }
        let a = self.data[self.cursor] as u32;
        let b = self.data[self.cursor + 1] as u32;
        let c = self.data[self.cursor + 2] as u32;
        self.cursor += 3;
        Ok(a | (b << 8) | (c << 16))
    }
    /// Base-254 varint (port of `fetchVarUInt`).
    fn fetch_varuint(&mut self) -> Result<usize, Error> {
        let a = self.fetch8()?;
        if a < 0xfe {
            Ok(a as usize)
        } else if a == 0xfe {
            let b = self.fetch16()? as usize;
            Ok((b >> 8) * 254 + (b & 0xff))
        } else {
            let b = self.fetch24()? as usize;
            Ok((((b >> 16) * 254) + ((b >> 8) & 0xff)) * 254 + (b & 0xff))
        }
    }
    fn fetch_sequence(&mut self, n: usize) -> Result<&'a [u8], Error> {
        if self.cursor + n > self.data.len() {
            return Err(Error::OutOfInputData);
        }
        let r = &self.data[self.cursor..self.cursor + n];
        self.cursor += n;
        Ok(r)
    }
}

/// Control-stream base-128 varint, read **backwards** from `cursor` (port of
/// `readControlVarUint`).
fn read_control_varuint(src: &[u8], mut cursor: isize) -> Result<(u64, isize), Error> {
    let mut r: u64 = 0;
    while cursor >= 0 {
        let v = src[cursor as usize];
        cursor -= 1;
        r = (r << 7) | (v & 0x7f) as u64;
        if v & 0x80 != 0 {
            return Ok((r, cursor));
        }
    }
    Err(Error::OutOfInputData)
}

/// Append `dst[pos..pos+match_len]` to `dst`, honouring overlapped-copy
/// semantics (port of `iguanaWildCopy`).
fn wild_copy(dst: &mut Vec<u8>, pos: i64, match_len: usize) -> Result<(), Error> {
    if pos < 0 || pos as usize > dst.len() {
        return Err(Error::CorruptOffset);
    }
    let mut pos = pos as usize;
    if pos + match_len <= dst.len() {
        dst.extend_from_within(pos..pos + match_len);
        return Ok(());
    }
    let mut remaining = match_len;
    while remaining > 0 {
        let dist = (dst.len() - pos).min(remaining);
        if dist == 0 {
            return Err(Error::CorruptOffset);
        }
        dst.extend_from_within(pos..pos + dist);
        pos += dist;
        remaining -= dist;
    }
    Ok(())
}

/// Decode one `cmdDecodeIguana` block from the six streams into `dst` (port of
/// `decompressIguanaReference`).
fn decompress_block(dst: &mut Vec<u8>, streams: &[&[u8]; STREAM_COUNT]) -> Result<(), Error> {
    let mut pack: [Reader; STREAM_COUNT] = std::array::from_fn(|i| Reader::new(streams[i]));
    let mut last_offs: i64 = -INIT_LAST_OFFSET;

    while !pack[STRID_TOKENS].empty() {
        let token = pack[STRID_TOKENS].fetch8()?;
        let match_len: i64;

        if token >= 32 {
            // [X_MMMM_LLL]: short literal + match length, X = "use last offset".
            let mut lit_len = (token & MAX_SHORT_LIT_LEN) as usize;
            if lit_len == MAX_SHORT_LIT_LEN as usize {
                lit_len = pack[STRID_VAR_LIT_LEN].fetch_varuint()? + MAX_SHORT_LIT_LEN as usize;
            }
            if lit_len > 0 {
                let lits = pack[STRID_LITERALS].fetch_sequence(lit_len)?;
                dst.extend_from_slice(lits);
            }
            if token & 0x80 == 0 {
                let new_offs = pack[STRID_OFFSET16].fetch16()?;
                last_offs = -(new_offs as i64);
            }
            let mut ml = ((token >> LITERAL_LEN_BITS) & MAX_SHORT_MATCH_LEN) as i64;
            if ml == MAX_SHORT_MATCH_LEN as i64 {
                ml = pack[STRID_VAR_MATCH_LEN].fetch_varuint()? as i64 + MAX_SHORT_MATCH_LEN as i64;
            }
            match_len = ml;
        } else if token < LAST_LONG_OFFSET {
            // 24-bit offset, match length 16..46.
            match_len = token as i64 + MM_LONG_OFFSETS;
            let x = pack[STRID_OFFSET24].fetch24()?;
            last_offs = -(x as i64);
        } else {
            // token == 31: 24-bit offset, extended match length 47+.
            match_len = pack[STRID_VAR_MATCH_LEN].fetch_varuint()? as i64
                + LAST_LONG_OFFSET as i64
                + MM_LONG_OFFSETS;
            let x = pack[STRID_OFFSET24].fetch24()?;
            last_offs = -(x as i64);
        }

        let match_pos = dst.len() as i64 + last_offs;
        wild_copy(dst, match_pos, match_len as usize)?;
    }

    // trailing literals
    let rem = pack[STRID_LITERALS].remaining();
    if rem > 0 {
        let lits = pack[STRID_LITERALS].fetch_sequence(rem)?;
        dst.extend_from_slice(lits);
    }
    Ok(())
}

/// Decode one `cmdDecodeIguana` block via the AVX-512 kernel, falling back to
/// the scalar [`decompress_block`] when the CPU lacks the required AVX-512
/// subsets or on targets without the kernels. Same output as `decompress_block`.
fn decompress_block_simd(
    dst: &mut Vec<u8>,
    streams: &[&[u8]; STREAM_COUNT],
    arena: &mut Vec<u8>,
) -> Result<(), Error> {
    #[cfg(iguana_asm)]
    if avx512_decompress_available() {
        // SAFETY: the kernel over-reads up to 64 B past each stream and
        // over-writes up to 32 B past the produced output; the padding below
        // and the caller's capacity reservation cover both.
        return unsafe { decompress_block_avx512(dst, streams, arena) };
    }
    #[cfg(iguana_sve2)]
    if sve2_decompress_available() {
        // SAFETY: the SVE2 kernel does fully-masked I/O within the padded arena
        // and the caller's reserved dst capacity.
        return unsafe { decompress_block_sve2(dst, streams, arena) };
    }
    let _ = arena;
    decompress_block(dst, streams)
}

/// Shared structural-decode kernel invoker for the AVX-512 and SVE2 backends
/// (identical `IguanaArgs` ABI). Pads the six streams with 64 B of tail slack
/// (the AVX-512 kernel does unmasked 64 B head loads + 32 B over-reads; the SVE2
/// kernel is fully masked and needs none, but the shared padding is harmless),
/// builds the `streamPack` + `IguanaArgs`, invokes `kernel`, and extends `dst` by
/// the produced length. The caller guarantees `dst.capacity() - dst.len() >=
/// produced + 32` (Stage-1 reserves `uncompressed_len + 64`).
#[cfg(any(iguana_asm, iguana_sve2))]
unsafe fn decompress_block_kernel(
    dst: &mut Vec<u8>,
    streams: &[&[u8]; STREAM_COUNT],
    arena: &mut Vec<u8>,
    kernel: unsafe extern "C" fn(*mut IguanaArgs),
) -> Result<(), Error> {
    // Tail-pad each stream so the AVX-512 kernel's 64 B over-reads stay in bounds.
    // Pack all six into ONE reused arena (each followed by 64 B slack) to avoid
    // per-stream — and per-block — allocation/faulting on the hot path. The slack
    // bytes are read-but-masked by the kernel, so stale content there is fine;
    // `resize` keeps them initialised.
    const SLACK: usize = 64;
    let arena_len: usize = streams.iter().map(|s| s.len() + SLACK).sum();
    arena.clear();
    arena.resize(arena_len, 0);
    let mut offs = [0usize; STREAM_COUNT];
    let mut at = 0usize;
    for (i, s) in streams.iter().enumerate() {
        offs[i] = at;
        arena[at..at + s.len()].copy_from_slice(s);
        at += s.len() + SLACK;
    }
    let base = arena.as_ptr();
    let pack: [StreamHdr; STREAM_COUNT] = std::array::from_fn(|i| StreamHdr {
        // SAFETY: offs[i] is within the arena, sized len+SLACK.
        data: unsafe { base.add(offs[i]) },
        len: streams[i].len(),
        cap: streams[i].len() + SLACK,
        cursor: 0,
    });

    let start = dst.len();
    // The kernel appends at dst_base+dst_len and may over-write 32 B; ensure the
    // spare capacity covers the produced bytes plus that slack. Total produced
    // for the whole frame is bounded by the reserved capacity, but reserve
    // defensively in case a caller under-provisions.
    if dst.capacity() < start + 32 {
        dst.reserve(start + 64 - dst.capacity().min(start + 64));
    }
    let last_offs: i64 = 0;
    let mut args = IguanaArgs {
        dst_base: dst.as_mut_ptr(),
        dst_len: start,
        dst_cap: dst.capacity(),
        streams: pack.as_ptr(),
        last_offs: &last_offs,
        ret_base: std::ptr::null_mut(),
        ret_len: 0,
        ret_cap: 0,
        ret_ec: 0,
        _pad: 0,
    };
    // SAFETY: dst has `dst_cap` writable bytes; every stream pointer is backed
    // by the `arena` buffer kept alive across the call; the kernel reads only
    // within those ranges and writes only within dst_cap.
    unsafe { kernel(&mut args) };
    if args.ret_ec != 0 {
        return Err(Error::OutOfInputData);
    }
    // ret_len is the total bytes from dst_base (start + produced).
    if args.ret_len > dst.capacity() {
        return Err(Error::CorruptOffset);
    }
    // SAFETY: the kernel initialised dst[start..ret_len].
    unsafe { dst.set_len(args.ret_len) };
    Ok(())
}

/// Unsafe AVX-512 block decode (see [`decompress_block_kernel`]).
#[cfg(iguana_asm)]
unsafe fn decompress_block_avx512(
    dst: &mut Vec<u8>,
    streams: &[&[u8]; STREAM_COUNT],
    arena: &mut Vec<u8>,
) -> Result<(), Error> {
    // SAFETY: forwards to the shared invoker with the AVX-512 kernel symbol.
    unsafe { decompress_block_kernel(dst, streams, arena, iguana_avx512_decompress_vbmi2) }
}

/// Unsafe SVE2 block decode (see [`decompress_block_kernel`]). The kernel is a
/// VLA re-derivation of [`decompress_block`]; same output, fully masked I/O.
#[cfg(iguana_sve2)]
unsafe fn decompress_block_sve2(
    dst: &mut Vec<u8>,
    streams: &[&[u8]; STREAM_COUNT],
    arena: &mut Vec<u8>,
) -> Result<(), Error> {
    // SAFETY: forwards to the shared invoker with the SVE2 kernel symbol.
    unsafe { decompress_block_kernel(dst, streams, arena, iguana_sve2_decompress) }
}

/// Benchmark helper (NOT public API). Isolates the two block-decode *cores*
/// from frame parsing and allocation: it extracts the six raw streams from a
/// single-block `EntropyNone` frame once, builds the padded `streamPack` once,
/// then times `iters` iterations of (a) the scalar `decompress_block` into a
/// reused buffer and (b) the AVX-512 kernel into a reused buffer. Returns
/// `(scalar_secs, kernel_secs, dst_len, token_count)`, or `None` if the input
/// isn't a single None-mode Iguana block. Min-of-`reps` is the caller's job.
#[doc(hidden)]
#[cfg(iguana_asm)]
pub fn bench_block_cores(framed: &[u8], iters: usize) -> Option<(f64, f64, usize, usize)> {
    use std::time::Instant;
    // --- parse a single None-mode cmdDecodeIguana frame (backward control) ---
    let (dst_len, cur) = read_control_varuint(framed, framed.len() as isize - 1).ok()?;
    let dst_len = dst_len as usize;
    if cur < 0 {
        return None;
    }
    let cmd = framed[cur as usize];
    if cmd & CMD_MASK != CMD_DECODE_IGUANA || cmd & LAST_COMMAND_MARKER == 0 {
        return None; // not a single terminal Iguana block (e.g. raw)
    }
    let (hdr, mut cur) = read_control_varuint(framed, cur - 1).ok()?;
    if hdr != 0 {
        return None; // entropy-coded; this helper benches the raw structural core
    }
    let mut ulens = [0usize; STREAM_COUNT];
    for u in ulens.iter_mut() {
        let (v, c) = read_control_varuint(framed, cur).ok()?;
        cur = c;
        *u = v as usize;
    }
    let mut at = 0usize;
    let mut refs: [&[u8]; STREAM_COUNT] = std::array::from_fn(|_| &[][..]);
    for (i, &n) in ulens.iter().enumerate() {
        refs[i] = framed.get(at..at + n)?;
        at += n;
    }
    let token_count = ulens[STRID_TOKENS];

    // --- scalar core: reused dst, no per-iter allocation ---
    let mut dst = Vec::with_capacity(dst_len + 64);
    let mut scalar_secs = f64::MAX;
    {
        let t = Instant::now();
        for _ in 0..iters {
            dst.clear();
            decompress_block(&mut dst, &refs).ok()?;
        }
        scalar_secs = scalar_secs.min(t.elapsed().as_secs_f64());
        assert_eq!(dst.len(), dst_len);
    }

    // --- kernel core: pre-built padded arena + streamPack, reused dst ---
    if !avx512_decompress_available() {
        return None;
    }
    const SLACK: usize = 64;
    let arena_len: usize = refs.iter().map(|s| s.len() + SLACK).sum();
    let mut arena = vec![0u8; arena_len];
    let mut offs = [0usize; STREAM_COUNT];
    let mut a = 0usize;
    for (i, s) in refs.iter().enumerate() {
        offs[i] = a;
        arena[a..a + s.len()].copy_from_slice(s);
        a += s.len() + SLACK;
    }
    let base = arena.as_ptr();
    let pack: [StreamHdr; STREAM_COUNT] = std::array::from_fn(|i| StreamHdr {
        data: unsafe { base.add(offs[i]) },
        len: refs[i].len(),
        cap: refs[i].len() + SLACK,
        cursor: 0,
    });
    let mut kdst = Vec::with_capacity(dst_len + 64);
    let last_offs: i64 = 0;
    let kernel_secs = {
        let t = Instant::now();
        for _ in 0..iters {
            let mut args = IguanaArgs {
                dst_base: kdst.as_mut_ptr(),
                dst_len: 0,
                dst_cap: kdst.capacity(),
                streams: pack.as_ptr(),
                last_offs: &last_offs,
                ret_base: std::ptr::null_mut(),
                ret_len: 0,
                ret_cap: 0,
                ret_ec: 0,
                _pad: 0,
            };
            unsafe { iguana_avx512_decompress_vbmi2(&mut args) };
            unsafe { kdst.set_len(args.ret_len) };
        }
        t.elapsed().as_secs_f64()
    };
    assert_eq!(kdst.len(), dst_len);
    Some((scalar_secs, kernel_secs, dst_len, token_count))
}

/// Decompress an Iguana stream produced with **un-entropy-coded** streams
/// (`EntMode: EntropyNone`) or raw blocks. Scalar reference; entropy-coded
/// blocks return [`Error::Unsupported`] until the ANS stages are composed in.
pub fn iguana_decompress(src: &[u8]) -> Result<Vec<u8>, Error> {
    decompress_impl(src, false)
}

/// Like [`iguana_decompress`] but routes the structural `cmdDecodeIguana` block
/// through the AVX-512 kernel when available (scalar fallback otherwise). Used
/// for differential testing and the eventual fast path.
pub fn iguana_decompress_simd(src: &[u8]) -> Result<Vec<u8>, Error> {
    decompress_impl(src, true)
}

/// Peek a self-framed block's uncompressed length **without decoding it** — the
/// uncompressed length is the trailing control varuint of the frame. Used to size
/// a decode destination (mirrors MinLZ `DecodedLen`).
pub(crate) fn block_decoded_len(src: &[u8]) -> Result<usize, Error> {
    if src.is_empty() {
        return Err(Error::OutOfInputData);
    }
    let (ulen, _) = read_control_varuint(src, src.len() as isize - 1)?;
    Ok(ulen as usize)
}

fn decompress_impl(src: &[u8], simd: bool) -> Result<Vec<u8>, Error> {
    let mut out = Vec::new();
    let mut arena = Vec::new();
    decompress_impl_into(src, simd, &mut out, &mut arena)?;
    Ok(out)
}

/// Core decode that writes into the reused `out` (the produced bytes) and uses
/// the reused `arena` scratch for the AVX-512 block kernel.
fn decompress_impl_into(
    src: &[u8],
    simd: bool,
    out: &mut Vec<u8>,
    arena: &mut Vec<u8>,
) -> Result<(), Error> {
    out.clear();
    if src.is_empty() {
        return Err(Error::OutOfInputData);
    }
    let cursor = src.len() as isize - 1;
    let (uncompressed_len, mut cursor) = read_control_varuint(src, cursor)?;
    if uncompressed_len == 0 {
        return Ok(());
    }

    out.reserve(uncompressed_len as usize + 64);
    let dst = out;
    let mut data_cursor: usize = 0;

    loop {
        if cursor < 0 {
            return Err(Error::OutOfInputData);
        }
        let cmd = src[cursor as usize];
        cursor -= 1;

        match cmd & CMD_MASK {
            CMD_COPY_RAW => {
                let (n, c) = read_control_varuint(src, cursor)?;
                cursor = c;
                let n = n as usize;
                let end = data_cursor.checked_add(n).ok_or(Error::OutOfInputData)?;
                if end > src.len() {
                    return Err(Error::OutOfInputData);
                }
                dst.extend_from_slice(&src[data_cursor..end]);
                data_cursor = end;
            }
            CMD_DECODE_IGUANA => {
                let (hdr, c) = read_control_varuint(src, cursor)?;
                cursor = c;
                // Header packs a 4-bit entropy mode per stream. Read all six
                // uncompressed lengths first (matches the Go control-read order),
                // then per stream take raw bytes (None) or decode an ANS block.
                let mut ulens = [0usize; STREAM_COUNT];
                for u in ulens.iter_mut() {
                    let (ulen, c) = read_control_varuint(src, cursor)?;
                    cursor = c;
                    *u = ulen as usize;
                }
                let mut streams: [Cow<[u8]>; STREAM_COUNT] =
                    std::array::from_fn(|_| Cow::Borrowed(&[][..]));
                for (i, slot) in streams.iter_mut().enumerate() {
                    let mode = (hdr >> (i as u64 * 4)) & 0x0f;
                    if mode == ENTROPY_NONE {
                        let end = data_cursor
                            .checked_add(ulens[i])
                            .ok_or(Error::OutOfInputData)?;
                        if end > src.len() {
                            return Err(Error::OutOfInputData);
                        }
                        *slot = Cow::Borrowed(&src[data_cursor..end]);
                        data_cursor = end;
                    } else {
                        let (clen, c) = read_control_varuint(src, cursor)?;
                        cursor = c;
                        let clen = clen as usize;
                        let end = data_cursor.checked_add(clen).ok_or(Error::OutOfInputData)?;
                        if end > src.len() {
                            return Err(Error::OutOfInputData);
                        }
                        let ans = &src[data_cursor..end];
                        data_cursor = end;
                        let decoded = match mode {
                            ENTROPY_ANS1 => crate::ans1_decode(ans, ulens[i])?,
                            // AVX-512 kernel when available, else scalar.
                            ENTROPY_ANS32 => crate::ans32_decode_simd(ans, ulens[i])?,
                            ENTROPY_ANS_NIBBLE => crate::ans_nibble_decode(ans, ulens[i])?,
                            _ => return Err(Error::Unsupported),
                        };
                        *slot = Cow::Owned(decoded);
                    }
                }
                let refs: [&[u8]; STREAM_COUNT] = std::array::from_fn(|i| streams[i].as_ref());
                if simd {
                    decompress_block_simd(dst, &refs, arena)?;
                } else {
                    decompress_block(dst, &refs)?;
                }
            }
            // ANS32/ANS1/nibble top-level commands — not yet ported.
            0x02..=0x04 => return Err(Error::Unsupported),
            _ => return Err(Error::UnrecognizedCommand),
        }

        if cmd & LAST_COMMAND_MARKER != 0 {
            return Ok(());
        }
    }
}

/// Reusable decoder: owns the arena scratch the AVX-512 block kernel needs, so
/// decoding many blocks (e.g. via [`crate::stream`]) doesn't re-allocate — and
/// re-fault — it per block. Hold one per thread.
pub(crate) struct Decoder {
    arena: Vec<u8>,
}

impl Default for Decoder {
    fn default() -> Self {
        Self::new()
    }
}

impl Decoder {
    pub(crate) fn new() -> Self {
        Decoder { arena: Vec::new() }
    }

    /// Decode a self-framed Iguana block into `out` (cleared first), routing the
    /// structural decode through the AVX-512 kernel and reusing the arena.
    pub(crate) fn decompress_into(&mut self, src: &[u8], out: &mut Vec<u8>) -> Result<(), Error> {
        decompress_impl_into(src, true, out, &mut self.arena)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    /// Hand-checked spec anchors for the token-decode unit: a few known tokens,
    /// independent of the SVE2 kernel, so a wrong *scalar* spec is caught too.
    #[test]
    fn decode_tokens_spec_anchors() {
        use tokflag::*;
        // (token, expect flags, litlen_base, matchlen_base)
        let cases: &[(u8, u8, u8, u8)] = &[
            (0, OFFSET24, 0, 16),                       // long, ml = 0+16
            (30, OFFSET24, 0, 46),                      // long, ml = 30+16
            (31, VAR_MATCH_LEN | OFFSET24, 0, 47),      // extended long
            (32, OFFSET16, 0, 4),                       // short 0x20: mlf=(32>>3)&15=4
            (39, VAR_LIT_LEN | OFFSET16, 7, 4),         // 0x27: llf=7 -> varlit
            (0xff, VAR_LIT_LEN | VAR_MATCH_LEN, 7, 15), // bit7 set -> use last offset
        ];
        let (mut f, mut l, mut m) = ([0u8; 1], [0u8; 1], [0u8; 1]);
        for &(t, ef, el, em) in cases {
            decode_tokens_scalar(&[t], &mut f, &mut l, &mut m);
            assert_eq!((f[0], l[0], m[0]), (ef, el, em), "token {t:#04x}");
        }
    }

    /// Differential: the SVE2 token-decode kernel must match the scalar twin over
    /// all 256 token values and random sequences (every VL chunk boundary).
    #[cfg(iguana_sve2)]
    #[test]
    fn decode_tokens_simd_matches_scalar() {
        if !std::arch::is_aarch64_feature_detected!("sve2") {
            return;
        }
        let run = |toks: &[u8]| {
            let n = toks.len();
            let (mut sf, mut sl, mut sm) = (vec![0u8; n], vec![0u8; n], vec![0u8; n]);
            let (mut kf, mut kl, mut km) = (vec![0u8; n], vec![0u8; n], vec![0u8; n]);
            decode_tokens_scalar(toks, &mut sf, &mut sl, &mut sm);
            // SAFETY: all five slices have length `n`; the kernel writes exactly
            // `n` bytes to each output.
            unsafe {
                iguana_sve2_decode_tokens(
                    toks.as_ptr(),
                    n,
                    kf.as_mut_ptr(),
                    kl.as_mut_ptr(),
                    km.as_mut_ptr(),
                );
            }
            assert_eq!((kf, kl, km), (sf, sl, sm), "len {n}");
        };
        // every token value, contiguous (exercises class boundaries 31/32/0x80)
        let all: Vec<u8> = (0..=255u8).collect();
        run(&all);
        // sizes spanning VL chunk edges with a deterministic spread of values
        let mut x = 0xc0ff_ee00_1234_5678u64;
        for &len in &[1usize, 7, 15, 16, 17, 33, 64, 65, 129, 1000] {
            let toks: Vec<u8> = (0..len)
                .map(|_| {
                    x ^= x << 13;
                    x ^= x >> 7;
                    x ^= x << 17;
                    x as u8
                })
                .collect();
            run(&toks);
        }
    }

    /// Malformed / truncated input must error, never panic (fuzz-safety).
    #[test]
    fn garbage_does_not_panic() {
        let cases: &[&[u8]] = &[
            &[],
            &[0x00],
            &[0xff],
            &[0x81, 0x00],
            &[0x01, 0x80, 0xff],
            &[1, 2, 3, 4, 5, 6, 7, 8],
            &[0x7f; 32],
            &[0x80; 32],
        ];
        for &c in cases {
            let _ = iguana_decompress(c);
        }
    }
}

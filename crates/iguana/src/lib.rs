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

//! PoC Rust port of **Sneller Iguana** (Sneller Inc., Apache-2.0) — a
//! "Lizard-derived" LZ compressor with a vectorised rANS entropy back-end.
//! See `IGUANA.md` for an overview.
//!
//! **Scalar codec is complete and cross-validated byte-for-byte vs Go, both
//! directions:**
//! - 8-bit rANS (`ans1_encode`/`ans1_decode`), 32-way interleaved rANS
//!   (`ans32_encode`/`ans32_decode`), and 4-bit nibble rANS
//!   (`ans_nibble_encode`/`ans_nibble_decode`),
//! - the Lizard structural LZ decoder + entropy composition
//!   ([`iguana_decompress`], in `structural`), which decodes real default-mode
//!   Go Iguana output (all four entropy modes: None / ANS32 / ANS1 / ANSNibble),
//! - the structural LZ **encoder** ([`iguana_compress`], in `encoder`): a greedy
//!   parse whose self-framed output round-trips here *and* decodes correctly in
//!   Go's AVX-512 decoder (verified up to 64 KiB inputs / ANS32 entropy).
//!
//! **AVX-512 path** (NASM in `asm/`, built via `build.rs`/`nasm-rs`, called over
//! `extern "C"`; line-by-line ports of Go's Plan9, validated against the scalar
//! oracles):
//! - [`byte_sum`] — toolchain probe.
//! - [`ans32_decode_simd`] — 32-way rANS decode kernel (~1.95× scalar).
//! - [`iguana_decompress_simd`] — the Lizard **structural-decode** kernel
//!   (`asm/decompress_avx512.asm`, port of `decompressIguanaAVX512VBMI2`). Up to **4.5×**
//!   the scalar on token-dense data; only the ABI seam differs from the Plan9
//!   source (tagged `ABI:` for audit).
//! - the **match-finder** kernel (`asm/match_avx512.asm`, port of `bestMatchAVX512`,
//!   in [`matcher`]) drives [`iguana_compress`]'s 4-deep hash-chain parse.
//! - [`ans32_encode_simd`] — the 32-way rANS **encode** kernel
//!   (`asm/ans32_encode_avx512.asm`, port of `ans32CompressCoreAVX512Generic`), 1.8–3.9×
//!   the scalar; used by [`iguana_compress`]'s ANS32 entropy path.
//!
//! All four Sneller AVX-512 kernels are now ported (ans32 decode/encode,
//! structural decode, match finder); only the ABI seam differs from the Plan9
//! source (tagged `ABI:` for audit). The codec is feature-complete: all four
//! entropy modes encode and decode, cross-validated byte-for-byte vs Go. The
//! rANS math follows Fabian Giesen's `ryg_rans` (public domain); table
//! serialisation is Sneller's.

/// Errors returned by the decoders.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Error {
    /// The input ended before a required byte/nibble could be read.
    OutOfInputData,
    /// The input is shorter than the minimum framing requires.
    WrongSourceSize,
    /// A table-compression mode this PoC does not implement (partial table).
    UnsupportedTable,
    /// An unrecognized top-level command byte in an Iguana stream.
    UnrecognizedCommand,
    /// A valid-but-not-yet-ported feature (e.g. entropy-coded streams, ANS32).
    Unsupported,
    /// A back-reference offset points outside the produced output.
    CorruptOffset,
}

mod structural;
#[cfg(iguana_asm)]
#[doc(hidden)]
pub use structural::bench_block_cores as structural_bench_block_cores;
#[doc(hidden)]
pub use structural::{decode_tokens_ref, decode_tokens_simd};
pub use structural::{iguana_decompress, iguana_decompress_simd};

mod encoder;
pub use encoder::{EntropyMode, iguana_compress};

mod matcher;

pub mod stream;

/// Single-block codec primitives for latency-bound, allocation-conscious callers
/// (e.g. RPC framing), mirroring the MinLZ block API. Each function operates on
/// one self-framed Iguana block — no stream header, no index. For bulk data use
/// [`stream`] instead.
pub mod block {
    use crate::{EntropyMode, Error, iguana_compress, iguana_decompress};

    /// Largest uncompressed block size, matching MinLZ's `MaxBlockSize` (8 MiB).
    /// Callers bound-check their input against this; the codec itself does not
    /// enforce it.
    pub const MAX_BLOCK_SIZE: usize = 8 << 20;

    /// Upper bound on the encoded size of a `src_len`-byte block. [`encode`] never
    /// exceeds this (it falls back to a raw/stored block when compression would
    /// expand). Use it to size a destination buffer (mirrors `MaxEncodedLen`).
    pub fn max_encoded_len(src_len: usize) -> usize {
        // The raw (stored) form is `src + varuint(len) + cmd + varuint(len)`.
        src_len + 2 * crate::encoder::control_varuint_len(src_len as u64) + 1
    }

    /// Uncompressed length of an encoded block, read **without decoding** (peeks
    /// the trailing control varuint). Mirrors `DecodedLen`.
    pub fn decoded_len(src: &[u8]) -> Result<usize, Error> {
        crate::structural::block_decoded_len(src)
    }

    /// Encode one block, **guaranteed never to exceed [`max_encoded_len`]**: if the
    /// compressed form would expand past the raw size, a raw/stored block is
    /// emitted instead. Always decodable by [`decode`].
    pub fn encode(src: &[u8], entropy: EntropyMode) -> Vec<u8> {
        let packed = iguana_compress(src, entropy);
        if packed.len() <= max_encoded_len(src.len()) {
            packed
        } else {
            crate::encoder::encode_raw_block(src)
        }
    }

    /// Give-up encode for latency paths: returns `Some(encoded)` only when it
    /// saves at least `min_saved_frac` of the input (e.g. `0.125` = 12.5%), else
    /// `None` so the caller stores the block uncompressed. Mirrors `TryEncode`.
    pub fn try_encode(src: &[u8], entropy: EntropyMode, min_saved_frac: f64) -> Option<Vec<u8>> {
        let packed = encode(src, entropy);
        let saved = src.len().saturating_sub(packed.len());
        if (saved as f64) >= (src.len() as f64) * min_saved_frac {
            Some(packed)
        } else {
            None
        }
    }

    /// Decode one block produced by [`encode`]/[`try_encode`].
    pub fn decode(src: &[u8]) -> Result<Vec<u8>, Error> {
        iguana_decompress(src)
    }
}

// ---------------------------------------------------------------------------
// AVX-512 NASM toolchain probe (Stage 2). Proves the NASM -> nasm-rs -> link ->
// `extern "C"` -> AVX-512 pipeline end-to-end, with CPU dispatch and a scalar
// twin for differential testing. The ans32 decode kernel will follow this
// exact pattern (asm in `asm/`, declared here, validated against the scalar
// reference in `ans32_decode`).
// ---------------------------------------------------------------------------

#[cfg(iguana_asm)]
unsafe extern "C" {
    fn iguana_avx512_byte_sum(src: *const u8, len: usize) -> u64;
}

#[cfg(iguana_sve2)]
unsafe extern "C" {
    fn iguana_sve2_byte_sum(src: *const u8, len: usize) -> u64;
}

/// Sum of all bytes in `src`. Uses the SIMD kernel (AVX-512 on x86-64, SVE2 on
/// AArch64) when the CPU supports it, otherwise the scalar fallback. Returns
/// `(sum, used_simd)`. This is the toolchain probe that proves the whole
/// asm→link→`extern "C"`→dispatch pipeline on each target.
pub fn byte_sum(src: &[u8]) -> (u64, bool) {
    #[cfg(iguana_asm)]
    {
        if std::is_x86_feature_detected!("avx512f") && std::is_x86_feature_detected!("avx512bw") {
            // SAFETY: `src` is a valid readable slice of `src.len()` bytes; the
            // kernel only reads that range and returns a scalar.
            let v = unsafe { iguana_avx512_byte_sum(src.as_ptr(), src.len()) };
            return (v, true);
        }
    }
    #[cfg(iguana_sve2)]
    {
        if std::arch::is_aarch64_feature_detected!("sve2") {
            // SAFETY: `src` is a valid readable slice of `src.len()` bytes; the
            // kernel only reads that range and returns a scalar.
            let v = unsafe { iguana_sve2_byte_sum(src.as_ptr(), src.len()) };
            return (v, true);
        }
    }
    (byte_sum_scalar(src), false)
}

/// Scalar reference / fallback for [`byte_sum`].
fn byte_sum_scalar(src: &[u8]) -> u64 {
    src.iter().map(|&b| b as u64).sum()
}

#[cfg(any(iguana_asm, iguana_sve2))]
#[repr(C)]
struct Ans32Args {
    dst: *mut u8,
    dst_len: usize,
    src: *const u8,
    src_len: usize,
    tab: *const u32,
}

#[cfg(iguana_asm)]
unsafe extern "C" {
    fn iguana_avx512_ans32_decode(args: *const Ans32Args);
}

#[cfg(iguana_sve2)]
unsafe extern "C" {
    fn iguana_sve2_ans32_decode(args: *const Ans32Args);
}

/// Go slice header (`{ data, len, cap }`) for the encoder struct mirror.
#[cfg(any(iguana_asm, iguana_sve2))]
#[repr(C)]
struct SliceHdr {
    data: *mut u8,
    len: usize,
    cap: usize,
}

/// Mirror of Go `ANS32Encoder`'s leading fields, matching the offsets the
/// encode kernel reads (`state@0`, `bufFwd@128`, `bufRev@152`, `src@176`,
/// `stats@200`). `statbuf` is omitted — the kernel never touches it.
#[cfg(any(iguana_asm, iguana_sve2))]
#[repr(C)]
struct Ans32EncoderC {
    state: [u32; 32],
    buf_fwd: SliceHdr,
    buf_rev: SliceHdr,
    src: SliceHdr,
    stats: *const u32,
}

#[cfg(iguana_asm)]
unsafe extern "C" {
    fn iguana_avx512_ans32_encode_core(enc: *mut Ans32EncoderC) -> u32;
}

#[cfg(iguana_sve2)]
unsafe extern "C" {
    fn iguana_sve2_ans32_encode_core(enc: *mut Ans32EncoderC) -> u32;
}

/// Whether the AVX-512 ANS32 *encode* kernel is usable. It uses `vextracti32x8`
/// (DQ), masked `vmovdqu16` on ymm (BW+VL), `vpgatherdd`/`vdivpd` (F) and BMI2.
#[cfg(iguana_asm)]
fn ans32_encode_simd_available() -> bool {
    std::is_x86_feature_detected!("avx512f")
        && std::is_x86_feature_detected!("avx512bw")
        && std::is_x86_feature_detected!("avx512dq")
        && std::is_x86_feature_detected!("avx512vl")
        && std::is_x86_feature_detected!("bmi2")
}

/// Whether the AVX-512 ANS32 kernel is usable on this CPU.
#[cfg(iguana_asm)]
fn ans32_simd_available() -> bool {
    std::is_x86_feature_detected!("avx512f") && std::is_x86_feature_detected!("avx512bw")
}

/// AVX-512 32-way rANS decode. Identical result to [`ans32_decode`]; falls back
/// to the scalar reference when AVX-512 is unavailable. The kernel assumes
/// well-formed input (the scalar path validates untrusted data).
pub fn ans32_decode_simd(src: &[u8], dst_len: usize) -> Result<Vec<u8>, Error> {
    #[cfg(iguana_asm)]
    if ans32_simd_available() {
        let (tab, stream) = ans_decode_table(src)?;
        if stream.len() < 128 {
            return Err(Error::WrongSourceSize);
        }
        // Uninitialised — the kernel writes all `dst_len` bytes (no pre-zeroing).
        let mut dst = Vec::with_capacity(dst_len);
        let args = Ans32Args {
            dst: dst.as_mut_ptr(),
            dst_len,
            src: stream.as_ptr(),
            src_len: stream.len(),
            tab: tab.as_ptr(),
        };
        // SAFETY: `dst` has `dst_len` writable bytes of capacity; `stream` is
        // ≥128 bytes and `tab` is a 4096-entry table; the kernel only touches
        // those ranges and initialises all `dst_len` output bytes.
        unsafe {
            iguana_avx512_ans32_decode(&args);
            dst.set_len(dst_len);
        }
        return Ok(dst);
    }
    #[cfg(iguana_sve2)]
    if std::arch::is_aarch64_feature_detected!("sve2") {
        let (tab, stream) = ans_decode_table(src)?;
        if stream.len() < 128 {
            return Err(Error::WrongSourceSize);
        }
        // Uninitialised — the kernel writes all `dst_len` bytes (no pre-zeroing).
        let mut dst = Vec::with_capacity(dst_len);
        let args = Ans32Args {
            dst: dst.as_mut_ptr(),
            dst_len,
            src: stream.as_ptr(),
            src_len: stream.len(),
            tab: tab.as_ptr(),
        };
        // SAFETY: as above — `dst` has `dst_len` capacity, `stream` ≥128 bytes,
        // `tab` is the 4096-entry table; the kernel writes exactly `dst_len` bytes.
        unsafe {
            iguana_sve2_ans32_decode(&args);
            dst.set_len(dst_len);
        }
        return Ok(dst);
    }
    ans32_decode(src, dst_len)
}

const ANS_WORD_L_BITS: u32 = 16;
const ANS_WORD_L: u32 = 1 << ANS_WORD_L_BITS;
const ANS_WORD_M_BITS: u32 = 12;
const ANS_WORD_M: u32 = 1 << ANS_WORD_M_BITS; // 4096

const FREQ_MASK: u32 = ANS_WORD_M - 1; // 0xfff
const CUMFREQ_BITS: u32 = ANS_WORD_M_BITS;

const CTRL_BLOCK_SIZE: usize = 96; // 256 × 3-bit control codes

/// rANS renormalisation threshold base: `((L >> M_BITS) << L_BITS)` = `1<<20`.
/// A state renormalises when `state >= RENORM_THRESHOLD_BASE * freq`.
const RENORM_THRESHOLD_BASE: u32 = (ANS_WORD_L >> ANS_WORD_M_BITS) << ANS_WORD_L_BITS;

// ---------------------------------------------------------------------------
// Public framed API (PoC convenience): [u32 LE original length][ans1 payload].
// ---------------------------------------------------------------------------

/// Compress `src` with the scalar 8-bit rANS entropy coder, framed with a
/// 4-byte little-endian original length so [`decompress`] is self-sufficient.
pub fn compress(src: &[u8]) -> Vec<u8> {
    let mut out = Vec::with_capacity(src.len() / 2 + 16);
    out.extend_from_slice(&(src.len() as u32).to_le_bytes());
    encode_ans1_into(src, &mut out);
    out
}

/// Inverse of [`compress`].
pub fn decompress(framed: &[u8]) -> Result<Vec<u8>, Error> {
    if framed.len() < 4 {
        return Err(Error::WrongSourceSize);
    }
    let dst_len = u32::from_le_bytes(framed[..4].try_into().unwrap()) as usize;
    ans1_decode(&framed[4..], dst_len)
}

/// Raw scalar 8-bit rANS encode — byte-compatible with Go Iguana's
/// `ANS1Encoder.Encode` (rANS stream + serialized table + full-table marker,
/// no length framing). The output length is *not* stored; pass it to
/// [`ans1_decode`].
pub fn ans1_encode(src: &[u8]) -> Vec<u8> {
    let mut out = Vec::with_capacity(src.len() / 2 + 16);
    encode_ans1_into(src, &mut out);
    out
}

/// Raw scalar **32-way interleaved** rANS encode — byte-compatible with Go
/// Iguana's `ANS32Encoder.Encode`. Inverse of [`ans32_decode`].
pub fn ans32_encode(src: &[u8]) -> Vec<u8> {
    let stats = Stats::observe(src);
    let mut out = ans32_compress(src, &stats);
    encode_full_table(&stats, &mut out);
    out.push(0x00); // full-table marker
    out
}

/// AVX-512 equivalent of [`ans32_encode`]: the rANS interleave runs on the encode
/// kernel (`asm/ans32_encode_avx512.asm`); the table serialisation/framing is shared, so
/// the output is byte-identical to the scalar path. Falls back to scalar when the
/// CPU lacks the required AVX-512 subsets.
pub fn ans32_encode_simd(src: &[u8]) -> Vec<u8> {
    #[cfg(iguana_asm)]
    if ans32_encode_simd_available() {
        // SAFETY: the kernel only reads `src`, the `stats.table` (256 u32s), and
        // writes within the pre-sized fwd/rev buffers; see the wrapper below.
        return unsafe { ans32_encode_with_core(src, iguana_avx512_ans32_encode_core) };
    }
    #[cfg(iguana_sve2)]
    if std::arch::is_aarch64_feature_detected!("sve2") {
        // SAFETY: same contract as the AVX-512 core — reads src + stats, writes
        // within the pre-sized buffers.
        return unsafe { ans32_encode_with_core(src, iguana_sve2_ans32_encode_core) };
    }
    ans32_encode(src)
}

/// Unsafe SIMD ANS32 encode (AVX-512 or SVE2 `core`): builds the
/// [`Ans32EncoderC`] mirror with worst-case-sized fwd/rev buffers (so the kernel's
/// buffer-expand protocol never fires — single call), runs the core, then
/// assembles the stream exactly as [`ans32_compress`] does (reverse fwd, append
/// rev) plus the table.
#[cfg(any(iguana_asm, iguana_sve2))]
unsafe fn ans32_encode_with_core(
    src: &[u8],
    core: unsafe extern "C" fn(*mut Ans32EncoderC) -> u32,
) -> Vec<u8> {
    let stats = Stats::observe(src);
    // rANS emits at most one 2-byte word per symbol, plus a 64-byte flush per
    // buffer; `2*len + 1024` per buffer is comfortably beyond worst case.
    let cap = 2 * src.len() + 1024;
    // Uninitialised — the kernel writes the prefix it uses; we read only `[..len]`.
    let mut buf_fwd = Vec::<u8>::with_capacity(cap);
    let mut buf_rev = Vec::<u8>::with_capacity(cap);
    let mut enc = Ans32EncoderC {
        state: [ANS_WORD_L; 32],
        buf_fwd: SliceHdr {
            data: buf_fwd.as_mut_ptr(),
            len: 0,
            cap,
        },
        buf_rev: SliceHdr {
            data: buf_rev.as_mut_ptr(),
            len: 0,
            cap,
        },
        // The kernel only reads src bytes (it writes the struct's src.Len field,
        // not the buffer), so pointing at the read-only input is sound.
        src: SliceHdr {
            data: src.as_ptr() as *mut u8,
            len: src.len(),
            cap: src.len(),
        },
        stats: stats.table.as_ptr(),
    };
    // SAFETY: all four regions outlive the call and are sized as the kernel
    // expects; buffers are pre-sized so it returns 0 (no expansion needed).
    let flag = unsafe { core(&mut enc) };
    debug_assert_eq!(flag, 0, "encode kernel requested buffer expansion");
    let len_fwd = enc.buf_fwd.len;
    let len_rev = enc.buf_rev.len;
    // SAFETY: the kernel initialised `buf_fwd[..len_fwd]` / `buf_rev[..len_rev]`.
    unsafe {
        buf_fwd.set_len(len_fwd);
        buf_rev.set_len(len_rev);
    }

    let mut out = Vec::with_capacity(len_fwd + len_rev + 1024);
    out.extend(buf_fwd[..len_fwd].iter().rev()); // inverted forward buffer
    out.extend_from_slice(&buf_rev[..len_rev]); // then the reverse buffer
    encode_full_table(&stats, &mut out);
    out.push(0x00); // full-table marker
    out
}

/// 32-way rANS stream encode (port of `ans32CompressReference` + the
/// `EncodeExplicit` forward-buffer inversion). Output: inverted forward buffer
/// followed by the reverse buffer.
fn ans32_compress(src: &[u8], stats: &Stats) -> Vec<u8> {
    let mut state = [ANS_WORD_L; 32];
    let mut fwd: Vec<u8> = Vec::new();
    let mut rev: Vec<u8> = Vec::new();

    // Last (partial) chunk first, then full chunks back-to-front.
    let src_len = src.len();
    let last = src_len % 32;
    let k0 = src_len - last;
    ans32_put(&mut state, &mut fwd, &mut rev, &src[k0..k0 + last], stats);
    let mut k = k0 as isize - 32;
    while k >= 0 {
        let s = k as usize;
        ans32_put(&mut state, &mut fwd, &mut rev, &src[s..s + 32], stats);
        k -= 32;
    }

    // Flush: forward states big-endian (lane 15..0), reverse states LE (16..31).
    for lane in (0..16).rev() {
        fwd.extend_from_slice(&state[lane].to_be_bytes());
    }
    for st in &state[16..32] {
        rev.extend_from_slice(&st.to_le_bytes());
    }

    // Invert the forward buffer in place, then append the reverse buffer.
    fwd.reverse();
    fwd.extend_from_slice(&rev);
    fwd
}

/// Encode one ≤32-byte chunk across the 32 lanes (port of `ANS32Encoder.put`):
/// lanes 0-15 renormalise into `fwd` (big-endian u16), lanes 16-31 into `rev`
/// (little-endian u16).
fn ans32_put(
    state: &mut [u32; 32],
    fwd: &mut Vec<u8>,
    rev: &mut Vec<u8>,
    chunk: &[u8],
    stats: &Stats,
) {
    let avail = chunk.len();
    for lane in (0..16).rev() {
        if lane < avail {
            let q = stats.table[chunk[lane] as usize];
            let freq = q & FREQ_MASK;
            let start = (q >> CUMFREQ_BITS) & FREQ_MASK;
            let mut x = state[lane];
            if x >= RENORM_THRESHOLD_BASE * freq {
                fwd.extend_from_slice(&(x as u16).to_be_bytes());
                x >>= ANS_WORD_L_BITS;
            }
            state[lane] = ((x / freq) << ANS_WORD_M_BITS) + (x % freq) + start;
        }
    }
    for lane in (16..32).rev() {
        if lane < avail {
            let q = stats.table[chunk[lane] as usize];
            let freq = q & FREQ_MASK;
            let start = (q >> CUMFREQ_BITS) & FREQ_MASK;
            let mut x = state[lane];
            if x >= RENORM_THRESHOLD_BASE * freq {
                rev.extend_from_slice(&(x as u16).to_le_bytes());
                x >>= ANS_WORD_L_BITS;
            }
            state[lane] = ((x / freq) << ANS_WORD_M_BITS) + (x % freq) + start;
        }
    }
}

// ---------------------------------------------------------------------------
// Frequency statistics (port of ans_statistics.go, full-table path only).
// ---------------------------------------------------------------------------

/// Normalised per-symbol statistics: `table[s] = (cum_freq << 12) | freq`,
/// with `freq` summing to `ANS_WORD_M`.
struct Stats {
    table: [u32; 256],
}

impl Stats {
    fn observe(src: &[u8]) -> Stats {
        let mut freqs = [0u32; 256];
        let mut cum = [0u32; 257];

        if src.is_empty() {
            // Edge case: empty input — split probability over the last 2 symbols.
            freqs[254] = ANS_WORD_M / 2;
            freqs[255] = ANS_WORD_M / 2;
            cum[255] = ANS_WORD_M / 2;
            cum[256] = ANS_WORD_M;
            return Stats::set(&freqs, &cum);
        }

        let nz = histogram(&mut freqs, src);
        if freqs[nz] == src.len() as u32 {
            // Edge case: a single repeated byte. Assign it M-1 (not M) so the
            // cumulative freqs encode in M_BITS bits (the missing slot is an
            // unencodable "symbol 256").
            freqs[nz] = ANS_WORD_M - 1;
            for c in cum.iter_mut().take(257).skip(nz + 1) {
                *c = ANS_WORD_M - 1;
            }
            return Stats::set(&freqs, &cum);
        }

        normalize(&mut freqs, &mut cum);
        Stats::set(&freqs, &cum)
    }

    fn set(freqs: &[u32; 256], cum: &[u32; 257]) -> Stats {
        let mut table = [0u32; 256];
        for i in 0..256 {
            table[i] = (cum[i] << CUMFREQ_BITS) | freqs[i];
        }
        Stats { table }
    }
}

/// 4-way histogram (mirrors the Go store-to-load-forwarding workaround).
/// Returns the index of the first non-zero frequency.
fn histogram(freqs: &mut [u32; 256], src: &[u8]) -> usize {
    let mut h = [[0u32; 256]; 4];
    let n = src.len();
    let e = n & !3;
    let mut i = 0;
    while i < e {
        h[0][src[i] as usize] += 1;
        h[1][src[i + 1] as usize] += 1;
        h[2][src[i + 2] as usize] += 1;
        h[3][src[i + 3] as usize] += 1;
        i += 4;
    }
    while i < n {
        h[0][src[i] as usize] += 1;
        i += 1;
    }
    for k in 0..256 {
        freqs[k] = h[0][k] + h[1][k] + h[2][k] + h[3][k];
    }
    freqs.iter().position(|&f| f != 0).unwrap_or(0)
}

/// Resample raw frequencies so they sum to exactly `ANS_WORD_M`, stealing range
/// to keep every observed symbol non-zero.
fn normalize(freqs: &mut [u32; 256], cum: &mut [u32; 257]) {
    for i in 0..256 {
        cum[i + 1] = cum[i] + freqs[i];
    }
    let target = ANS_WORD_M as u64;
    let cur_total = cum[256] as u64;
    for c in cum.iter_mut().skip(1) {
        *c = ((target * *c as u64) / cur_total) as u32;
    }
    // Restore any non-zero symbol that got rounded to zero by stealing range.
    for i in 0..256 {
        if freqs[i] != 0 && cum[i + 1] == cum[i] {
            let mut best_freq = u32::MAX;
            let mut best_steal: isize = -1;
            for j in 0..256 {
                let f = cum[j + 1] - cum[j];
                if f > 1 && f < best_freq {
                    best_freq = f;
                    best_steal = j as isize;
                }
            }
            if best_steal < i as isize {
                for c in cum.iter_mut().take(i + 1).skip(best_steal as usize + 1) {
                    *c -= 1;
                }
            } else {
                for c in cum.iter_mut().take(best_steal as usize + 1).skip(i + 1) {
                    *c += 1;
                }
            }
        }
    }
    for i in 0..256 {
        freqs[i] = cum[i + 1] - cum[i];
    }
}

// ---------------------------------------------------------------------------
// Bit stream used for table serialisation (LSB-first, port of ansBitStream).
// ---------------------------------------------------------------------------

struct BitStream {
    acc: u64,
    cnt: i32,
    buf: Vec<u8>,
}

impl BitStream {
    fn new() -> Self {
        BitStream {
            acc: 0,
            cnt: 0,
            buf: Vec::new(),
        }
    }
    fn add(&mut self, v: u32, k: u32) {
        let m = if k >= 32 { u32::MAX } else { !(u32::MAX << k) };
        self.acc |= ((v & m) as u64) << self.cnt;
        self.cnt += k as i32;
        while self.cnt >= 8 {
            self.buf.push(self.acc as u8);
            self.acc >>= 8;
            self.cnt -= 8;
        }
    }
    fn flush(&mut self) {
        while self.cnt > 0 {
            self.buf.push(self.acc as u8);
            self.acc >>= 8;
            self.cnt -= 8;
        }
    }
}

/// Serialise the full frequency table: a 96-byte block of 256 3-bit control
/// codes plus a variable nibble/byte block, the latter stored reversed ahead of
/// the control block.  (Port of `EncodeFull`.)
fn encode_full_table(stats: &Stats, dst: &mut Vec<u8>) {
    let mut ctrl = BitStream::new();
    let mut data = BitStream::new();
    for i in 0..256 {
        let f = stats.table[i] & FREQ_MASK;
        if f < 5 {
            ctrl.add(f, 3);
        } else if f < 21 {
            ctrl.add(0b101, 3);
            data.add(f - 5, 4);
        } else if f < 277 {
            ctrl.add(0b110, 3);
            data.add(f - 21, 8);
        } else {
            ctrl.add(0b111, 3);
            data.add(f - 277, 12);
        }
    }
    ctrl.flush();
    data.flush();
    // data block, reversed, then the control block.
    for &b in data.buf.iter().rev() {
        dst.push(b);
    }
    dst.extend_from_slice(&ctrl.buf);
}

/// Read one nibble at `idx` (high nibble first within a byte), returning the
/// value and the decremented index.  (Port of `ansFetchNibble`.)
fn fetch_nibble(src: &[u8], idx: isize) -> Result<(u32, isize), Error> {
    if idx < 0 {
        return Err(Error::OutOfInputData);
    }
    let byte = src[(idx >> 1) as usize];
    if idx & 1 == 1 {
        Ok(((byte & 0x0f) as u32, idx - 1))
    } else {
        Ok(((byte >> 4) as u32, idx - 1))
    }
}

/// Decode the full table; returns the dense decode table and the length of the
/// remaining prefix (the rANS byte stream).  (Port of `ansDecodeFullTable`.)
fn decode_full_table(src: &[u8]) -> Result<(Box<[u32]>, usize), Error> {
    let src_len = src.len();
    if src_len < CTRL_BLOCK_SIZE {
        return Err(Error::WrongSourceSize);
    }
    let ctrl = &src[src_len - CTRL_BLOCK_SIZE..];
    let mut freqs = [0u32; 256];
    let mut nibidx: isize = (src_len as isize - CTRL_BLOCK_SIZE as isize - 1) * 2 + 1;
    let mut k = 0usize;
    let mut i = 0usize;
    while i < CTRL_BLOCK_SIZE {
        let mut x = ctrl[i] as u32 | (ctrl[i + 1] as u32) << 8 | (ctrl[i + 2] as u32) << 16;
        for _ in 0..8 {
            let v = x & 0x07;
            x >>= 3;
            freqs[k] = match v {
                0b111 => {
                    let (x0, n) = fetch_nibble(src, nibidx)?;
                    let (x1, n) = fetch_nibble(src, n)?;
                    let (x2, n) = fetch_nibble(src, n)?;
                    nibidx = n;
                    (x0 | (x1 << 4) | (x2 << 8)) + 277
                }
                0b110 => {
                    let (x0, n) = fetch_nibble(src, nibidx)?;
                    let (x1, n) = fetch_nibble(src, n)?;
                    nibidx = n;
                    (x0 | (x1 << 4)) + 21
                }
                0b101 => {
                    let (x0, n) = fetch_nibble(src, nibidx)?;
                    nibidx = n;
                    x0 + 5
                }
                _ => v,
            };
            k += 1;
        }
        i += 3;
    }

    // Build the dense table: slot -> (sym<<24) | (within-symbol index<<12) | freq.
    let mut tab = vec![0u32; ANS_WORD_M as usize].into_boxed_slice();
    let mut start = 0u32;
    for (sym, &freq) in freqs.iter().enumerate() {
        for j in 0..freq {
            tab[(start + j) as usize] = ((sym as u32) << 24) | (j << ANS_WORD_M_BITS) | freq;
        }
        start += freq;
    }
    let prefix_len = (((nibidx + 1) >> 1).max(0)) as usize;
    Ok((tab, prefix_len))
}

// ---------------------------------------------------------------------------
// ANS-nibble: scalar one-way 4-bit rANS (port of `ans_nibble.go`). A single
// state over 16 nibble symbols; each byte is two nibbles (high then low). Used
// as Iguana per-stream entropy mode 3 (`EntropyANSNibble`).
// ---------------------------------------------------------------------------

const NIBBLE_CTRL_BLOCK_SIZE: usize = 6; // 16 × 3-bit control codes

/// Per-nibble normalised statistics: `table[s] = (cum_freq << 12) | freq`.
struct NibbleStats {
    table: [u32; 16],
}

impl NibbleStats {
    fn observe(src: &[u8]) -> NibbleStats {
        let mut freqs = [0u32; 16];
        let mut cum = [0u32; 17];
        if src.is_empty() {
            freqs[14] = ANS_WORD_M / 2;
            freqs[15] = ANS_WORD_M / 2;
            cum[15] = ANS_WORD_M / 2;
            cum[16] = ANS_WORD_M;
            return NibbleStats::set(&freqs, &cum);
        }
        let nz = nibble_histogram(&mut freqs, src);
        // 2× because a byte contributes two nibbles.
        if freqs[nz] == 2 * src.len() as u32 {
            freqs[nz] = ANS_WORD_M - 1;
            for c in cum.iter_mut().take(17).skip(nz + 1) {
                *c = ANS_WORD_M - 1;
            }
            return NibbleStats::set(&freqs, &cum);
        }
        normalize_nibble(&mut freqs, &mut cum);
        NibbleStats::set(&freqs, &cum)
    }
    fn set(freqs: &[u32; 16], cum: &[u32; 17]) -> NibbleStats {
        let mut table = [0u32; 16];
        for i in 0..16 {
            table[i] = (cum[i] << CUMFREQ_BITS) | freqs[i];
        }
        NibbleStats { table }
    }
}

/// 4-way histogram over nibbles; returns the first non-zero symbol index.
fn nibble_histogram(freqs: &mut [u32; 16], src: &[u8]) -> usize {
    let mut h = [[0u32; 16]; 4];
    let n = src.len();
    let e = n & !3;
    let mut i = 0;
    while i < e {
        h[0][(src[i] & 0x0f) as usize] += 1;
        h[1][(src[i] >> 4) as usize] += 1;
        h[2][(src[i + 1] & 0x0f) as usize] += 1;
        h[3][(src[i + 1] >> 4) as usize] += 1;
        h[0][(src[i + 2] & 0x0f) as usize] += 1;
        h[1][(src[i + 2] >> 4) as usize] += 1;
        h[2][(src[i + 3] & 0x0f) as usize] += 1;
        h[3][(src[i + 3] >> 4) as usize] += 1;
        i += 4;
    }
    while i < n {
        h[0][(src[i] & 0x0f) as usize] += 1;
        h[0][(src[i] >> 4) as usize] += 1;
        i += 1;
    }
    for (s, f) in freqs.iter_mut().enumerate() {
        *f = h[0][s] + h[1][s] + h[2][s] + h[3][s];
    }
    (0..16).find(|&s| freqs[s] != 0).unwrap_or(0)
}

/// Normalise 16 nibble frequencies to sum to `ANS_WORD_M` (port of the nibble
/// `normalizeFreqs`); identical algorithm to [`normalize`] over 16 symbols.
fn normalize_nibble(freqs: &mut [u32; 16], cum: &mut [u32; 17]) {
    for i in 0..16 {
        cum[i + 1] = cum[i] + freqs[i];
    }
    let target = ANS_WORD_M as u64;
    let cur_total = cum[16] as u64;
    for c in cum.iter_mut().skip(1) {
        *c = ((target * *c as u64) / cur_total) as u32;
    }
    for i in 0..16 {
        if freqs[i] != 0 && cum[i + 1] == cum[i] {
            let mut best_freq = u32::MAX;
            let mut best_steal: isize = -1;
            for j in 0..16 {
                let f = cum[j + 1] - cum[j];
                if f > 1 && f < best_freq {
                    best_freq = f;
                    best_steal = j as isize;
                }
            }
            if best_steal < i as isize {
                for c in cum.iter_mut().take(i + 1).skip(best_steal as usize + 1) {
                    *c -= 1;
                }
            } else {
                for c in cum.iter_mut().take(best_steal as usize + 1).skip(i + 1) {
                    *c += 1;
                }
            }
        }
    }
    for i in 0..16 {
        freqs[i] = cum[i + 1] - cum[i];
    }
}

/// Serialise the 16-symbol table: 6-byte control block of 3-bit codes plus a
/// variable nibble block (reversed ahead of the control block).
fn encode_nibble_table(stats: &NibbleStats, dst: &mut Vec<u8>) {
    let mut ctrl = BitStream::new();
    let mut data = BitStream::new();
    for i in 0..16 {
        let f = stats.table[i] & FREQ_MASK;
        if f < 5 {
            ctrl.add(f, 3);
        } else if f < 21 {
            ctrl.add(0b101, 3);
            data.add(f - 5, 4);
        } else if f < 277 {
            ctrl.add(0b110, 3);
            data.add(f - 21, 8);
        } else {
            ctrl.add(0b111, 3);
            data.add(f - 277, 12);
        }
    }
    ctrl.flush();
    data.flush();
    for &b in data.buf.iter().rev() {
        dst.push(b);
    }
    dst.extend_from_slice(&ctrl.buf);
}

/// Decode the 16-symbol table; returns the dense decode table and the prefix
/// length (the rANS byte stream before the table).
fn decode_nibble_table(src: &[u8]) -> Result<(Box<[u32]>, usize), Error> {
    let src_len = src.len();
    if src_len < NIBBLE_CTRL_BLOCK_SIZE {
        return Err(Error::WrongSourceSize);
    }
    let ctrl = &src[src_len - NIBBLE_CTRL_BLOCK_SIZE..];
    let mut freqs = [0u32; 16];
    let mut nibidx: isize = (src_len as isize - NIBBLE_CTRL_BLOCK_SIZE as isize - 1) * 2 + 1;
    let mut k = 0usize;
    let mut i = 0usize;
    while i < NIBBLE_CTRL_BLOCK_SIZE {
        let mut x = ctrl[i] as u32 | (ctrl[i + 1] as u32) << 8 | (ctrl[i + 2] as u32) << 16;
        for _ in 0..8 {
            let v = x & 0x07;
            x >>= 3;
            freqs[k] = match v {
                0b111 => {
                    let (x0, n) = fetch_nibble(src, nibidx)?;
                    let (x1, n) = fetch_nibble(src, n)?;
                    let (x2, n) = fetch_nibble(src, n)?;
                    nibidx = n;
                    (x0 | (x1 << 4) | (x2 << 8)) + 277
                }
                0b110 => {
                    let (x0, n) = fetch_nibble(src, nibidx)?;
                    let (x1, n) = fetch_nibble(src, n)?;
                    nibidx = n;
                    (x0 | (x1 << 4)) + 21
                }
                0b101 => {
                    let (x0, n) = fetch_nibble(src, nibidx)?;
                    nibidx = n;
                    x0 + 5
                }
                _ => v,
            };
            k += 1;
        }
        i += 3;
    }
    let mut tab = vec![0u32; ANS_WORD_M as usize].into_boxed_slice();
    let mut start = 0u32;
    for (sym, &freq) in freqs.iter().enumerate() {
        for j in 0..freq {
            tab[(start + j) as usize] = ((sym as u32) << 24) | (j << ANS_WORD_M_BITS) | freq;
        }
        start += freq;
    }
    let prefix_len = (((nibidx + 1) >> 1).max(0)) as usize;
    Ok((tab, prefix_len))
}

/// Scalar 4-bit rANS encode — byte-compatible with Go `ANSNibbleEncoder.Encode`
/// (rANS stream + serialised table). Inverse of [`ans_nibble_decode`].
pub fn ans_nibble_encode(src: &[u8]) -> Vec<u8> {
    let stats = NibbleStats::observe(src);
    let mut state = ANS_WORD_L;
    let mut buf: Vec<u8> = Vec::with_capacity(src.len() + 16);
    // Encode each byte's high nibble then low nibble, processing back to front.
    for &byte in src.iter().rev() {
        nibble_put(&mut state, &mut buf, &stats, byte >> 4);
        nibble_put(&mut state, &mut buf, &stats, byte & 0x0f);
    }
    buf.extend_from_slice(&state.to_le_bytes()); // flush state (u32 LE)
    encode_nibble_table(&stats, &mut buf);
    buf
}

/// Encode one nibble (port of `putNibble`): renormalise (emit a u16 LE) then
/// advance the state.
fn nibble_put(state: &mut u32, buf: &mut Vec<u8>, stats: &NibbleStats, v: u8) {
    let q = stats.table[v as usize];
    let freq = q & FREQ_MASK;
    let start = (q >> CUMFREQ_BITS) & FREQ_MASK;
    let mut x = *state;
    if x >= RENORM_THRESHOLD_BASE * freq {
        buf.extend_from_slice(&(x as u16).to_le_bytes());
        x >>= ANS_WORD_L_BITS;
    }
    *state = ((x / freq) << ANS_WORD_M_BITS) + (x % freq) + start;
}

/// Scalar 4-bit rANS decode — inverse of [`ans_nibble_encode`], byte-compatible
/// with Go `ANSNibbleDecode`. `dst_len` is the original byte length.
pub fn ans_nibble_decode(src: &[u8], dst_len: usize) -> Result<Vec<u8>, Error> {
    let (tab, prefix_len) = decode_nibble_table(src)?;
    nibble_decompress(&src[..prefix_len], dst_len, &tab)
}

fn nibble_decompress(src: &[u8], dst_len: usize, tab: &[u32]) -> Result<Vec<u8>, Error> {
    if src.len() < 4 {
        return Err(Error::WrongSourceSize);
    }
    let mut state = u32::from_le_bytes(src[src.len() - 4..].try_into().unwrap());
    let mut cursor: isize = src.len() as isize - 6;
    let mut dst = Vec::with_capacity(dst_len);
    if dst_len == 0 {
        return Ok(dst);
    }
    loop {
        let lo = nibble_get(&mut state, src, &mut cursor, tab)?;
        let hi = nibble_get(&mut state, src, &mut cursor, tab)?;
        dst.push((hi << 4) | lo);
        if dst.len() >= dst_len {
            break;
        }
    }
    Ok(dst)
}

/// Decode one nibble (port of the `ansNibbleDecompress` inner block): emit the
/// symbol, advance the state, and renormalise (read a u16 LE backward).
fn nibble_get(state: &mut u32, src: &[u8], cursor: &mut isize, tab: &[u32]) -> Result<u8, Error> {
    let x = *state;
    let slot = (x & (ANS_WORD_M - 1)) as usize;
    let t = tab[slot];
    let freq = t & (ANS_WORD_M - 1);
    let bias = (t >> ANS_WORD_M_BITS) & (ANS_WORD_M - 1);
    *state = freq * (x >> ANS_WORD_M_BITS) + bias;
    let nib = (t >> 24) as u8;
    if *state < ANS_WORD_L {
        if *cursor < 0 || *cursor as usize + 2 > src.len() {
            return Err(Error::OutOfInputData);
        }
        let c = *cursor as usize;
        let v = u16::from_le_bytes(src[c..c + 2].try_into().unwrap()) as u32;
        *cursor -= 2;
        *state = (*state << ANS_WORD_L_BITS) | v;
    }
    Ok(nib)
}

// ---------------------------------------------------------------------------
// rANS codec (port of ans1.go reference paths).
// ---------------------------------------------------------------------------

/// Encode `src` (entropy stage) into `dst`: rANS stream, full table, and a
/// trailing `0x00` "full table" marker byte.
fn encode_ans1_into(src: &[u8], dst: &mut Vec<u8>) {
    let stats = Stats::observe(src);

    // rANS encodes back-to-front; renorm emits u16 LE, flush emits the u32 state.
    let mut state: u32 = ANS_WORD_L;
    for &b in src.iter().rev() {
        let q = stats.table[b as usize];
        let freq = q & FREQ_MASK;
        let start = (q >> CUMFREQ_BITS) & FREQ_MASK;
        let mut x = state;
        if x >= RENORM_THRESHOLD_BASE * freq {
            dst.extend_from_slice(&(x as u16).to_le_bytes());
            x >>= ANS_WORD_L_BITS;
        }
        state = ((x / freq) << ANS_WORD_M_BITS) + (x % freq) + start;
    }
    dst.extend_from_slice(&state.to_le_bytes());

    encode_full_table(&stats, dst);
    dst.push(0x00); // compression level 0 == full table
}

/// Strip the full-table marker, decode the dense table, and return it together
/// with the leading rANS byte stream. Shared by [`ans1_decode`]/[`ans32_decode`].
fn ans_decode_table(src: &[u8]) -> Result<(Box<[u32]>, &[u8]), Error> {
    let (last, body) = src.split_last().ok_or(Error::OutOfInputData)?;
    if *last != 0x00 {
        // Non-zero == partial/optimised table, not ported in this PoC.
        return Err(Error::UnsupportedTable);
    }
    let (tab, prefix_len) = decode_full_table(body)?;
    Ok((tab, &body[..prefix_len]))
}

/// Raw scalar 8-bit rANS decode of a known output length — byte-compatible with
/// Go Iguana's `ANS1Decode` (rANS stream + table + marker).
pub fn ans1_decode(src: &[u8], dst_len: usize) -> Result<Vec<u8>, Error> {
    let (tab, stream) = ans_decode_table(src)?;
    if stream.len() < 4 {
        return Err(Error::WrongSourceSize);
    }
    let mut cursor = stream.len() - 4;
    let mut state = u32::from_le_bytes(stream[cursor..cursor + 4].try_into().unwrap());
    let mut dst = Vec::with_capacity(dst_len);
    loop {
        let x = state;
        let t = tab[(x & FREQ_MASK) as usize];
        let freq = t & FREQ_MASK;
        let bias = (t >> ANS_WORD_M_BITS) & FREQ_MASK;
        state = freq * (x >> ANS_WORD_M_BITS) + bias;
        let s = (t >> 24) as u8;
        if dst.len() < dst_len {
            dst.push(s);
        } else {
            break;
        }
        if state < ANS_WORD_L {
            if cursor < 2 {
                return Err(Error::OutOfInputData);
            }
            let v = u16::from_le_bytes(stream[cursor - 2..cursor].try_into().unwrap());
            cursor -= 2;
            state = (state << ANS_WORD_L_BITS) | v as u32;
        }
    }
    Ok(dst)
}

/// Raw scalar **32-way interleaved** rANS decode (`ANS32`) of a known output
/// length — byte-compatible with Go Iguana's `ANS32Decode`. 16 "forward" lanes
/// have their states at the front (renorm bytes read forward from offset 64) and
/// 16 "reverse" lanes have theirs at the back (renorm read backward from
/// `len-64`). This is the scalar reference / oracle for the future AVX-512 path.
pub fn ans32_decode(src: &[u8], dst_len: usize) -> Result<Vec<u8>, Error> {
    let (tab, stream) = ans_decode_table(src)?;
    // 16 forward + 16 reverse u32 states = 128 bytes of framing minimum.
    if stream.len() < 128 {
        return Err(Error::WrongSourceSize);
    }
    let mut state = [0u32; 32];
    let mut cursor_fwd = 64usize;
    let mut cursor_rev = stream.len() - 64;
    for lane in 0..16 {
        state[lane] = u32::from_le_bytes(stream[lane * 4..lane * 4 + 4].try_into().unwrap());
        let r = cursor_rev + lane * 4;
        state[lane + 16] = u32::from_le_bytes(stream[r..r + 4].try_into().unwrap());
    }
    let mut dst = Vec::with_capacity(dst_len);
    // Each round produces 32 symbols (one per state) then renormalises; the last
    // (`rem`) round produces a partial group and stops. Hoisting `full`/`rem` out
    // of the inner loop removes the per-symbol `dst_len` bounds check.
    let full = dst_len / 32;
    let rem = dst_len % 32;
    for round in 0..=full {
        let count = if round < full { 32 } else { rem };
        if count == 0 {
            break;
        }
        for st in state.iter_mut().take(count) {
            let x = *st;
            let t = tab[(x & FREQ_MASK) as usize];
            let freq = t & FREQ_MASK;
            let bias = (t >> ANS_WORD_M_BITS) & FREQ_MASK;
            *st = freq * (x >> ANS_WORD_M_BITS) + bias;
            dst.push((t >> 24) as u8);
        }
        if count < 32 {
            break; // final partial round: no renorm needed
        }
        for st in state[0..16].iter_mut() {
            if *st < ANS_WORD_L {
                if cursor_fwd + 2 > stream.len() {
                    return Err(Error::OutOfInputData);
                }
                let v = u16::from_le_bytes(stream[cursor_fwd..cursor_fwd + 2].try_into().unwrap());
                cursor_fwd += 2;
                *st = (*st << ANS_WORD_L_BITS) | v as u32;
            }
        }
        for st in state[16..32].iter_mut() {
            if *st < ANS_WORD_L {
                if cursor_rev < 2 {
                    return Err(Error::OutOfInputData);
                }
                let v = u16::from_le_bytes(stream[cursor_rev - 2..cursor_rev].try_into().unwrap());
                cursor_rev -= 2;
                *st = (*st << ANS_WORD_L_BITS) | v as u32;
            }
        }
    }
    Ok(dst)
}

#[cfg(test)]
mod tests {
    use super::*;

    fn roundtrip(src: &[u8]) {
        let enc = compress(src);
        let dec = decompress(&enc).expect("decompress");
        assert_eq!(
            dec.as_slice(),
            src,
            "round-trip mismatch (len {})",
            src.len()
        );
    }

    /// Differential test of the SIMD kernel vs the scalar twin — proves the whole
    /// asm->link->`extern "C"`->dispatch pipeline end-to-end (AVX-512 on x86-64,
    /// SVE2 on AArch64).
    #[test]
    fn byte_sum_matches_scalar() {
        for len in [
            0usize, 1, 7, 31, 63, 64, 65, 127, 128, 200, 1000, 4096, 5001,
        ] {
            let v: Vec<u8> = (0..len)
                .map(|i| (i.wrapping_mul(31).wrapping_add(7)) as u8)
                .collect();
            let (got, _used) = byte_sum(&v);
            assert_eq!(got, byte_sum_scalar(&v), "len {len}");
        }
        // Where a kernel is linked and the CPU supports it, the SIMD path must
        // actually be taken (not a silent scalar fallback).
        #[cfg(iguana_asm)]
        if std::is_x86_feature_detected!("avx512f") && std::is_x86_feature_detected!("avx512bw") {
            assert!(byte_sum(&[1, 2, 3, 4, 5]).1, "expected AVX-512 path");
        }
        #[cfg(iguana_sve2)]
        if std::arch::is_aarch64_feature_detected!("sve2") {
            assert!(byte_sum(&[1, 2, 3, 4, 5]).1, "expected SVE2 path");
        }
    }

    /// Direct differential test of the ANS32 decode kernel (AVX-512 or SVE2)
    /// against the scalar `ans32_decode` oracle. `ans32_encode` builds a valid
    /// stream; both decoders must reproduce the original bytes identically. Covers
    /// the tail path (`dst_len % 32 != 0`) and many renorm rounds (large inputs +
    /// skewed distributions that force frequent renormalisation).
    #[cfg(any(iguana_asm, iguana_sve2))]
    #[test]
    fn ans32_decode_simd_matches_scalar() {
        let kernel_present = {
            #[cfg(iguana_asm)]
            {
                std::is_x86_feature_detected!("avx512f")
                    && std::is_x86_feature_detected!("avx512bw")
            }
            #[cfg(iguana_sve2)]
            {
                std::arch::is_aarch64_feature_detected!("sve2")
            }
        };
        if !kernel_present {
            return;
        }
        let mut x = 0x1234_5678_9abc_def0u64;
        let mut next = |m: u32| {
            x ^= x << 13;
            x ^= x >> 7;
            x ^= x << 17;
            (x % m as u64) as u32
        };
        // Sizes chosen to hit every `dst_len % 32` remainder and a range of round
        // counts; alphabets from tiny (frequent renorm) to full byte range.
        for &len in &[
            1usize, 31, 32, 33, 63, 64, 65, 127, 200, 1000, 4097, 20_001, 65_537,
        ] {
            for &alpha in &[2u32, 7, 64, 256] {
                let src: Vec<u8> = (0..len).map(|_| next(alpha) as u8).collect();
                let enc = ans32_encode(&src);
                let scalar = ans32_decode(&enc, len).expect("scalar decode");
                assert_eq!(scalar, src, "scalar oracle wrong: len={len} alpha={alpha}");
                let simd = ans32_decode_simd(&enc, len).expect("simd decode");
                assert_eq!(simd, scalar, "kernel != scalar: len={len} alpha={alpha}");
            }
        }
    }

    /// Direct differential test of the ANS32 *encode* kernel (AVX-512 or SVE2):
    /// `ans32_encode_simd` must produce a **byte-identical** stream to the scalar
    /// `ans32_encode` (the output is part of the on-disk format). Covers the tail
    /// chunk (`len % 32`) and many full chunks, across alphabets.
    #[cfg(any(iguana_asm, iguana_sve2))]
    #[test]
    fn ans32_encode_simd_matches_scalar() {
        let kernel_present = {
            #[cfg(iguana_asm)]
            {
                ans32_encode_simd_available()
            }
            #[cfg(iguana_sve2)]
            {
                std::arch::is_aarch64_feature_detected!("sve2")
            }
        };
        if !kernel_present {
            return;
        }
        let mut x = 0x0f1e_2d3c_4b5a_6978u64;
        let mut next = |m: u32| {
            x ^= x << 13;
            x ^= x >> 7;
            x ^= x << 17;
            (x % m as u64) as u32
        };
        for &len in &[
            0usize, 1, 31, 32, 33, 63, 64, 65, 127, 200, 1000, 4097, 20_001, 65_537,
        ] {
            for &alpha in &[2u32, 7, 64, 256] {
                let src: Vec<u8> = (0..len).map(|_| next(alpha) as u8).collect();
                let scalar = ans32_encode(&src);
                let simd = ans32_encode_simd(&src);
                assert_eq!(
                    simd, scalar,
                    "encode kernel != scalar: len={len} alpha={alpha}"
                );
                // And it must still round-trip back to the original bytes.
                assert_eq!(
                    ans32_decode(&simd, len).unwrap(),
                    src,
                    "roundtrip len={len}"
                );
            }
        }
    }

    #[test]
    fn empty() {
        roundtrip(b"");
    }

    #[test]
    fn single_byte() {
        roundtrip(b"a");
        roundtrip(&[0u8; 1000]); // single repeated symbol edge case
    }

    #[test]
    fn small_texts() {
        roundtrip(b"the quick brown fox jumps over the lazy dog");
        roundtrip(b"aaaaaaaabbbbbbbbccccccccdddddddd");
        roundtrip(b"\x00\x01\x02\x03\xfe\xff");
    }

    #[test]
    fn skewed_distribution_compresses() {
        // 90% 'a', 10% spread — entropy coder should shrink it well.
        let mut src = Vec::new();
        for i in 0..10_000u32 {
            src.push(if i % 10 == 0 { (i & 0xff) as u8 } else { b'a' });
        }
        roundtrip(&src);
        let ratio = src.len() as f64 / compress(&src).len() as f64;
        assert!(ratio > 2.0, "expected >2x on skewed data, got {ratio:.2}x");
    }

    #[test]
    fn pseudo_random_roundtrips() {
        let mut x = 0x2545_f491_4f6c_dd1du64;
        let mut src = vec![0u8; 5000];
        for b in src.iter_mut() {
            x ^= x << 13;
            x ^= x >> 7;
            x ^= x << 17;
            *b = x as u8;
        }
        roundtrip(&src);
    }

    #[test]
    fn all_byte_values() {
        let src: Vec<u8> = (0..=255u8).cycle().take(4096).collect();
        roundtrip(&src);
    }

    #[test]
    fn ans_nibble_roundtrips() {
        let mut cases: Vec<Vec<u8>> = vec![
            b"".to_vec(),
            b"a".to_vec(),
            vec![0u8; 1000],   // single repeated byte
            vec![0x10u8; 777], // single nibble pattern
            b"the quick brown fox jumps over the lazy dog".to_vec(),
            (0..=255u8).cycle().take(4096).collect(),
        ];
        // Skewed nibble distribution (small values) — where nibble rANS shines.
        let mut x = 0x1234_5678_9abc_def0u64;
        let mut skew = Vec::new();
        for _ in 0..8000 {
            x ^= x << 13;
            x ^= x >> 7;
            x ^= x << 17;
            skew.push(if x & 3 == 0 {
                (x >> 8) as u8
            } else {
                (x & 0x0f) as u8
            });
        }
        cases.push(skew);
        for c in &cases {
            let enc = ans_nibble_encode(c);
            let dec = ans_nibble_decode(&enc, c.len()).expect("nibble decode");
            assert_eq!(dec, *c, "ans-nibble round-trip mismatch (len {})", c.len());
        }
    }
}

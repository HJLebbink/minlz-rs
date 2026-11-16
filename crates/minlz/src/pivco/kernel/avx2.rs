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

//! The AVX2 tier of the encoder kernels: a `core::arch` port of the assembly that Go's
//! `_generate/pivco` (`enc_avx2.go`, `avx2_util.go`) generates. It ports upstream's x86 tier as
//! built with PIVCO_HAS_AVX2 and without AVX-512 (`pivco_huffman_primitives_x86.h`,
//! `pivco_huffman_x86_vertical.h`, `pivco_huffman_avx2_pack.h`). The `*_asm` functions port the
//! generated functions of the same Go names; the histogram is generic, as upstream's, and the
//! decoder is in MLIR (`super::mlir`).
//!
//! Requirements: AVX2, BMI2, POPCNT ([`PIVCO_AVX2`](crate::cpu::PIVCO_AVX2)); every entry
//! point is an `unsafe fn` whose caller has checked them. No AVX-512 instructions.
//!
//! The entry points assert the lengths the kernels rely on: reads of src and ranks and
//! stores to ranks[..n] and the packed region are exact; right-side and bitmap stores use
//! [`RANK_SLACK`].
//!
//! Differences from C:
//!   - Reads of src and ranks are exact, and so are the in-place left stores of part_full
//!     and every store to the packed region: the tails run the vector step on the last
//!     ranks shifted down from a load that ends at n (or on an exact small load when
//!     n < 16) and store through exact 8/4/2/1-byte stores. C ends with scalar loops.
//!   - The partitions build their masks with VPMAXUB/VPCMPEQB, which also covers thr = 255.
//!   - The gather returns the largest rank, from a VPMAXUB pass over the stored ranks.
//!   - The natural packs subtract base with VPSUBUSB, so the zero lanes of a short tail
//!     stay zero and give zero padding bits.
//!
//! The 16-lane steps of the vertical pack run on the low lane of a YMM register (the loads
//! leave the high lane undefined, the stores drop it).
//!
//! The D = 8 pack loop runs at about 0.9 of Go's speed on a Ryzen 9 9950X. Its speed depends on
//! where the loop lands in a 64-byte block, which a Rust build doesn't control. D = 8 flats only
//! occur for near-uniform symbols.

use core::arch::x86_64::*;
use core::mem::transmute;

use super::generic_pack::pack_generic;
use super::{RANK_SLACK, vert_split};

// The partitions store 16 bytes at right+nr and 2 bitmap bytes at the tail's offset.
const _: () = assert!(RANK_SLACK >= 16);

/// Sets `ranks[i] = s2r[src[i]]` and returns the largest rank written.
///
/// # Safety
/// The CPU has [`PIVCO_AVX2`](crate::cpu::PIVCO_AVX2).
pub(super) unsafe fn gather_avx2(ranks: &mut [u8], src: &[u8], s2r: &[u8; 256]) -> u8 {
    let n = src.len();
    if n == 0 {
        return 0;
    }
    let ranks = &mut ranks[..n];
    // SAFETY: the CPU has the features; ranks and src hold n > 0 bytes.
    unsafe { gather_avx2_asm(ranks.as_mut_ptr(), src.as_ptr(), n, s2r) }
}

/// Partitions `ranks` by rank > thr; see [`super::Tier::part_full`].
///
/// # Safety
/// The CPU has [`PIVCO_AVX2`](crate::cpu::PIVCO_AVX2).
pub(super) unsafe fn part_full_avx2(
    ranks: &mut [u8],
    right: &mut [u8],
    bm: &mut [u8],
    thr: u8,
) -> usize {
    let n = ranks.len();
    if n == 0 {
        return 0;
    }
    let (right, bm) = (
        &mut right[..n + RANK_SLACK],
        &mut bm[..n.div_ceil(8) + RANK_SLACK],
    );
    let r = ranks.as_mut_ptr();
    // SAFETY: the CPU has the features; the slices have the lengths part_avx2_asm needs.
    unsafe { part_avx2_asm::<PART_FULL>(r, right.as_mut_ptr(), r, bm.as_mut_ptr(), n, thr) }
}

/// Partitions `ranks` like [`part_full_avx2`] without compacting the left ranks.
///
/// # Safety
/// The CPU has [`PIVCO_AVX2`](crate::cpu::PIVCO_AVX2).
pub(super) unsafe fn part_right_avx2(
    ranks: &[u8],
    right: &mut [u8],
    bm: &mut [u8],
    thr: u8,
) -> usize {
    let n = ranks.len();
    if n == 0 {
        return 0;
    }
    let (right, bm) = (
        &mut right[..n + RANK_SLACK],
        &mut bm[..n.div_ceil(8) + RANK_SLACK],
    );
    let (r, b) = (right.as_mut_ptr(), bm.as_mut_ptr());
    // SAFETY: the CPU has the features; the slices have the lengths part_avx2_asm needs;
    // left is not used.
    unsafe { part_avx2_asm::<PART_RIGHT>(ranks.as_ptr(), r, core::ptr::null_mut(), b, n, thr) }
}

/// Writes only the bitmap of `ranks` and returns the number of set bits.
///
/// # Safety
/// The CPU has [`PIVCO_AVX2`](crate::cpu::PIVCO_AVX2).
pub(super) unsafe fn part_none_avx2(ranks: &[u8], bm: &mut [u8], thr: u8) -> usize {
    let n = ranks.len();
    if n == 0 {
        return 0;
    }
    let bm = &mut bm[..n.div_ceil(8) + RANK_SLACK];
    let null = core::ptr::null_mut();
    // SAFETY: the CPU has the features; the slices have the lengths part_avx2_asm needs;
    // right and left are not used.
    unsafe { part_avx2_asm::<PART_NONE>(ranks.as_ptr(), null, null, bm.as_mut_ptr(), n, thr) }
}

/// Packs the codes of a flat region; see [`super::Tier::pack`].
///
/// # Safety
/// The CPU has [`PIVCO_AVX2`](crate::cpu::PIVCO_AVX2).
pub(super) unsafe fn pack_avx2(dst: &mut [u8], ranks: &[u8], d: u8, base: u8) {
    let n = ranks.len();
    if n == 0 || !(2..=8).contains(&d) {
        pack_generic(dst, ranks, d, base);
        return;
    }
    let dst = &mut dst[..(n * usize::from(d)).div_ceil(8)];
    let (n512, n128) = vert_split(n, d);
    // SAFETY: the CPU has the features; dst holds the packed region and ranks n codes.
    unsafe { pack_avx2_asm(dst.as_mut_ptr(), ranks.as_ptr(), n, n512, n128, d, base) }
}

// Raw loads and stores; the callers state why each access is in bounds.

#[inline(always)]
unsafe fn rd16(p: *const u8) -> u16 {
    // SAFETY: the caller guarantees 2 readable bytes.
    unsafe { p.cast::<u16>().read_unaligned() }
}

#[inline(always)]
unsafe fn rd32(p: *const u8) -> u32 {
    // SAFETY: the caller guarantees 4 readable bytes.
    unsafe { p.cast::<u32>().read_unaligned() }
}

#[inline(always)]
unsafe fn wr16(p: *mut u8, v: u16) {
    // SAFETY: the caller guarantees 2 writable bytes.
    unsafe { p.cast::<u16>().write_unaligned(v) }
}

#[inline(always)]
unsafe fn wr32(p: *mut u8, v: u32) {
    // SAFETY: the caller guarantees 4 writable bytes.
    unsafe { p.cast::<u32>().write_unaligned(v) }
}

#[inline]
#[target_feature(enable = "avx2,bmi2,popcnt")]
unsafe fn ld128(p: *const u8) -> __m128i {
    // SAFETY: the caller guarantees 16 readable bytes.
    unsafe { _mm_loadu_si128(p.cast()) }
}

#[inline]
#[target_feature(enable = "avx2,bmi2,popcnt")]
unsafe fn ld256(p: *const u8) -> __m256i {
    // SAFETY: the caller guarantees 32 readable bytes.
    unsafe { _mm256_loadu_si256(p.cast()) }
}

#[inline]
#[target_feature(enable = "avx2,bmi2,popcnt")]
unsafe fn st128(p: *mut u8, v: __m128i) {
    // SAFETY: the caller guarantees 16 writable bytes.
    unsafe { _mm_storeu_si128(p.cast(), v) }
}

#[inline]
#[target_feature(enable = "avx2,bmi2,popcnt")]
unsafe fn st256(p: *mut u8, v: __m256i) {
    // SAFETY: the caller guarantees 32 writable bytes.
    unsafe { _mm256_storeu_si256(p.cast(), v) }
}

/// Loads w (16 or 32) bytes; with 16 the high lane is undefined.
#[inline]
#[target_feature(enable = "avx2,bmi2,popcnt")]
unsafe fn ldw(p: *const u8, w: usize) -> __m256i {
    // SAFETY: the caller guarantees w readable bytes.
    unsafe {
        if w == 32 {
            ld256(p)
        } else {
            _mm256_castsi128_si256(ld128(p))
        }
    }
}

/// Stores the low w (16 or 32) bytes of v.
#[inline]
#[target_feature(enable = "avx2,bmi2,popcnt")]
unsafe fn stw(p: *mut u8, w: usize, v: __m256i) {
    // SAFETY: the caller guarantees w writable bytes.
    unsafe {
        if w == 32 {
            st256(p, v)
        } else {
            st128(p, _mm256_castsi256_si128(v))
        }
    }
}

// Shifts by a count the callers fold to a constant, as the generator's immediates; the
// intrinsics with immediates cannot take counts computed from const generics.

#[inline]
#[target_feature(enable = "avx2,bmi2,popcnt")]
fn sll16(v: __m256i, n: usize) -> __m256i {
    _mm256_sll_epi16(v, _mm_cvtsi64_si128(n as i64))
}

#[inline]
#[target_feature(enable = "avx2,bmi2,popcnt")]
fn srl16(v: __m256i, n: usize) -> __m256i {
    _mm256_srl_epi16(v, _mm_cvtsi64_si128(n as i64))
}

#[inline]
#[target_feature(enable = "avx2,bmi2,popcnt")]
fn srl64(v: __m256i, n: usize) -> __m256i {
    _mm256_srl_epi64(v, _mm_cvtsi64_si128(n as i64))
}

#[inline]
#[target_feature(enable = "avx2,bmi2,popcnt")]
fn splat(v: u8) -> __m256i {
    _mm256_set1_epi8(v as i8)
}

/// Aligns a table to a cache line, as Go's RODATA blobs.
#[repr(C, align(64))]
struct Align64<T>(T);

/// The 48-byte shuffle table {0x80 x16, 0..15, 0x80 x16}: PSHUFB with the 16 bytes at
/// 16+k shifts down by k lanes, at 16-k up by k, zero filling.
static SHIFT: Align64<[u8; 48]> = Align64({
    let mut r = [0x80; 48];
    let mut i = 0;
    while i < 16 {
        r[16 + i] = i as u8;
        i += 1;
    }
    r
});

/// Returns the shuffle at `SHIFT[off..off+16]`.
#[inline]
#[target_feature(enable = "avx2,bmi2,popcnt")]
fn shift_row(off: usize) -> __m128i {
    let r: &[u8; 16] = SHIFT.0[off..off + 16].try_into().unwrap();
    // SAFETY: r holds 16 bytes.
    unsafe { ld128(r.as_ptr()) }
}

/// Loads the k (0..=16) bytes at p into the low lanes and zeroes the others, reading
/// nothing outside `p[..k]`.
#[inline]
#[target_feature(enable = "avx2,bmi2,popcnt")]
unsafe fn load_exact(p: *const u8, k: usize) -> __m128i {
    // SAFETY: every read lies in p[..k], which the caller guarantees readable.
    unsafe {
        if k >= 8 {
            let x = _mm_loadl_epi64(p.cast());
            let t = _mm_loadl_epi64(p.add(k - 8).cast());
            // Bytes k-8..k-1 go up by k-8 lanes.
            return _mm_or_si128(x, _mm_shuffle_epi8(t, shift_row(24 - k)));
        }
        let v = if k >= 4 {
            u64::from(rd32(p)) | u64::from(rd32(p.add(k - 4))) << (8 * (k - 4))
        } else if k >= 2 {
            u64::from(rd16(p)) | u64::from(rd16(p.add(k - 2))) << (8 * (k - 2))
        } else if k == 1 {
            u64::from(*p)
        } else {
            0
        };
        _mm_cvtsi64_si128(v as i64)
    }
}

/// Stores the low k (0..=16) bytes of x at p and nothing else; overlapping stores write
/// the same bytes twice.
#[inline]
#[target_feature(enable = "avx2,bmi2,popcnt")]
unsafe fn store_exact(p: *mut u8, k: usize, x: __m128i) {
    // SAFETY: every write lies in p[..k], which the caller guarantees writable.
    unsafe {
        if k >= 8 {
            _mm_storel_epi64(p.cast(), x);
            // Bytes k-8..k-1 come down by k-8 lanes.
            _mm_storel_epi64(p.add(k - 8).cast(), _mm_shuffle_epi8(x, shift_row(8 + k)));
            return;
        }
        let v = _mm_cvtsi128_si64(x) as u64;
        if k >= 4 {
            wr32(p, v as u32);
            wr32(p.add(k - 4), (v >> (8 * (k - 4))) as u32);
        } else if k >= 2 {
            wr16(p, v as u16);
            wr16(p.add(k - 2), (v >> (8 * (k - 2))) as u16);
        } else if k == 1 {
            *p = v as u8;
        }
    }
}

// ---------------------------------------------------------------------------------------
// Encoder kernels (enc_avx2.go).

/// The ctabR table of x86_build_tabs (primitives_x86.h:907-952), per mask m: the right lanes
/// first, 0x80 fill. Its tabA and tabB0 are [`super::p16_tabs`]. x86_pc8 and x86_ctab_l/pre_l
/// are not needed: POPCNT, and no left compaction by table.
const fn ctab_r() -> [[u8; 16]; 256] {
    let mut t = [[0x80; 16]; 256];
    let mut m = 0;
    while m < 256 {
        let (mut nr, mut k) = (0, 0);
        while k < 8 {
            if m >> k & 1 != 0 {
                t[m][nr] = k as u8;
                nr += 1;
            }
            k += 1;
        }
        m += 1;
    }
    t
}

/// preR[nlo][m]: the high byte's rights (8+k) from lane nlo on, 0x80 fill.
const fn pre_r() -> [[[u8; 16]; 256]; 9] {
    let mut t = [[[0x80; 16]; 256]; 9];
    let mut nlo = 0;
    while nlo < 9 {
        let mut m = 0;
        while m < 256 {
            let (mut p, mut k) = (nlo, 0);
            while k < 8 {
                if m >> k & 1 != 0 {
                    t[nlo][m][p] = 8 + k as u8;
                    p += 1;
                }
                k += 1;
            }
            m += 1;
        }
        nlo += 1;
    }
    t
}

const P16_TABS: ([[u8; 16]; 256], [[u8; 32]; 256]) = super::p16_tabs();
// SAFETY (both): same size, and every bit pattern is a valid __m128i.
static P16_A: [__m128i; 256] = unsafe { transmute(P16_TABS.0) };
static P16_B: Align64<[[u8; 32]; 256]> = Align64(P16_TABS.1);
static CTAB_R: [__m128i; 256] = unsafe { transmute(ctab_r()) };
static PRE_R: [[__m128i; 256]; 9] = unsafe { transmute(pre_r()) };

/// Ports prim_enc_init's 2tab loop (primitives_x86.h:1284-1314): each pair of symbols is
/// one u16 store of s2r[a] + hi[b], hi[s] = s2r[s]<<8 in a stack table built per call (C
/// keeps it in the table as enc_init_hi). Returns the largest of ranks[..n].
///
/// # Safety
/// The CPU has the features; ranks and src hold n > 0 bytes.
#[target_feature(enable = "avx2,bmi2,popcnt")]
unsafe fn gather_avx2_asm(ranks: *mut u8, src: *const u8, n: usize, s2r: &[u8; 256]) -> u8 {
    let mut hi = [0u16; 256];
    for k in 0..16 {
        // SAFETY: s2r holds 16*16 bytes and hi 16*16 u16.
        unsafe {
            let v = _mm256_cvtepu8_epi16(ld128(s2r.as_ptr().add(16 * k)));
            st256(
                hi.as_mut_ptr().add(16 * k).cast(),
                _mm256_slli_epi16::<8>(v),
            );
        }
    }
    // Go loads 8 symbols and shifts the register by 16 per pair; LLVM turns that into a
    // shift per byte, so each pair is a 16-bit load here.
    let mut i = 0;
    while n - i >= 16 {
        for p in (0..8).step_by(2) {
            // SAFETY: i+16 <= n, the length of src and ranks.
            unsafe {
                let a = rd16(src.add(i + p));
                let x = u16::from(s2r[usize::from(a as u8)]) + hi[usize::from(a >> 8)];
                wr16(ranks.add(i + p), x);
                let b = rd16(src.add(i + 8 + p));
                let y = u16::from(s2r[usize::from(b as u8)]) + hi[usize::from(b >> 8)];
                wr16(ranks.add(i + 8 + p), y);
            }
        }
        i += 16;
    }
    while i < n {
        // SAFETY: i < n.
        unsafe { *ranks.add(i) = s2r[usize::from(*src.add(i))] };
        i += 1;
    }

    // The maximum of ranks[..n]; the last 32-byte load overlaps the loop's.
    if n < 32 {
        let mut m = 0;
        for i in 0..n {
            // SAFETY: i < n.
            m = m.max(unsafe { *ranks.add(i) });
        }
        return m;
    }
    let mut m = _mm256_setzero_si256();
    let mut i = 0;
    while i + 32 <= n {
        // SAFETY: i+32 <= n.
        m = _mm256_max_epu8(m, unsafe { ld256(ranks.add(i)) });
        i += 32;
    }
    // SAFETY: n >= 32.
    m = _mm256_max_epu8(m, unsafe { ld256(ranks.add(n - 32)) });
    let mut x = _mm_max_epu8(_mm256_castsi256_si128(m), _mm256_extracti128_si256::<1>(m));
    x = _mm_max_epu8(x, _mm_srli_si128::<8>(x));
    x = _mm_max_epu8(x, _mm_srli_si128::<4>(x));
    x = _mm_max_epu8(x, _mm_srli_si128::<2>(x));
    x = _mm_max_epu8(x, _mm_srli_si128::<1>(x));
    _mm_cvtsi128_si32(x) as u8
}

const PART_FULL: u8 = 0;
const PART_RIGHT: u8 = 1;
const PART_NONE: u8 = 2;

/// Returns the rank > thr bits of the 32 lanes of v.
#[inline]
#[target_feature(enable = "avx2,bmi2,popcnt")]
fn mask32(v: __m256i, thr: __m256i) -> u32 {
    !(_mm256_movemask_epi8(_mm256_cmpeq_epi8(thr, _mm256_max_epu8(v, thr))) as u32)
}

/// Returns the rank > thr bits of the 16 lanes of v (zero lanes give 0).
#[inline]
#[target_feature(enable = "avx2,bmi2,popcnt")]
fn mask16(v: __m128i, thr: __m128i) -> u32 {
    _mm_movemask_epi8(_mm_cmpeq_epi8(thr, _mm_max_epu8(v, thr))) as u32 ^ 0xFFFF
}

/// Compacts the 16 lanes of v by the mask bits sh..sh+15 of m (_P16REV): lefts in order
/// from lane 0, rights in reverse order down from lane 15.
#[inline]
#[target_feature(enable = "avx2,bmi2,popcnt")]
fn p16(v: __m128i, m: u32, sh: u32) -> __m128i {
    let (a, b) = (m >> sh & 0xFF, m >> (sh + 8) & 0xFF);
    let row = &P16_B.0[b as usize];
    // SAFETY: popcount(a) <= 8, so the 16 bytes lie in the 32-byte row.
    let tb = unsafe { ld128(row.as_ptr().add(a.count_ones() as usize)) };
    _mm_shuffle_epi8(v, _mm_or_si128(P16_A[a as usize], tb))
}

/// Compacts the right lanes of v by the mask bits sh..sh+15 of m in order to the low
/// lanes (_PC16).
#[inline]
#[target_feature(enable = "avx2,bmi2,popcnt")]
fn pc16(v: __m128i, m: u32, sh: u32) -> __m128i {
    let (a, b) = (m >> sh & 0xFF, m >> (sh + 8) & 0xFF);
    // SAFETY: popcount(a) <= 8 < PRE_R.len().
    let pre = unsafe { PRE_R.get_unchecked(a.count_ones() as usize)[b as usize] };
    _mm_shuffle_epi8(v, _mm_min_epu8(CTAB_R[a as usize], pre))
}

/// A partition by rank > thr, 32 ranks per step with a 16-rank step and a tail after it
/// (part_full_x86 and part_core_x86, primitives_x86.h:997-1109). PART_FULL compacts the
/// lefts in place to left == src; PART_NONE never touches right.
///
/// # Safety
/// The CPU has the features; n > 0; src has n readable bytes (writable through left for
/// PART_FULL), right n+RANK_SLACK writable (not PART_NONE) and bm ceil(n/8)+RANK_SLACK.
#[target_feature(enable = "avx2,bmi2,popcnt")]
unsafe fn part_avx2_asm<const KIND: u8>(
    src: *const u8,
    right: *mut u8,
    left: *mut u8,
    mut bm: *mut u8,
    n: usize,
    thr: u8,
) -> usize {
    let thr = _mm256_set1_epi8(thr as i8);
    let thr16 = _mm256_castsi256_si128(thr);
    let rev = _mm_setr_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
    let (mut i, mut nl, mut nr) = (0, 0, 0);
    // The last 16 ranks, read before any in-place store; the tail shifts them down.
    let last = if n >= 16 {
        // SAFETY: n >= 16.
        unsafe { ld128(src.add(n - 16)) }
    } else {
        _mm_setzero_si128()
    };
    // In-place left stores land at nl <= i, on ranks a step has already loaded, and end
    // at or before its end; right stores end at nr+16 <= n+RANK_SLACK.
    for _ in 0..n >> 5 {
        // SAFETY: i+32 <= n; bm has 4 bytes per 32 ranks; see above for the stores.
        unsafe {
            let s = src.add(i);
            let v0 = ld256(s);
            let m = mask32(v0, thr);
            wr32(bm, m);
            if KIND != PART_NONE {
                let v1 = ld128(s.add(16));
                let lo = (m & 0xFFFF).count_ones() as usize;
                if KIND == PART_FULL {
                    let c = p16(_mm256_castsi256_si128(v0), m, 0);
                    st128(left.add(nl), c);
                    st128(right.add(nr), _mm_shuffle_epi8(c, rev));
                    let c = p16(v1, m, 16);
                    st128(left.add(nl + 16 - lo), c);
                    st128(right.add(nr + lo), _mm_shuffle_epi8(c, rev));
                } else {
                    st128(right.add(nr), pc16(_mm256_castsi256_si128(v0), m, 0));
                    st128(right.add(nr + lo), pc16(v1, m, 16));
                }
            }
            let pc = m.count_ones() as usize;
            (nr, nl) = (nr + pc, nl + 32 - pc);
            bm = bm.add(4);
        }
        i += 32;
    }
    if n - i >= 16 {
        // SAFETY: as in the loop, for 16 ranks and 2 bitmap bytes.
        unsafe {
            let v = ld128(src.add(i));
            let m = mask16(v, thr16);
            wr16(bm, m as u16);
            if KIND == PART_FULL {
                let c = p16(v, m, 0);
                st128(left.add(nl), c);
                st128(right.add(nr), _mm_shuffle_epi8(c, rev));
            } else if KIND == PART_RIGHT {
                st128(right.add(nr), pc16(v, m, 0));
            }
            let pc = m.count_ones() as usize;
            (nr, nl) = (nr + pc, nl + 16 - pc);
            bm = bm.add(2);
        }
        i += 16;
    }
    let t = n - i;
    if t > 0 {
        // t = 1..15 ranks remain at i; they become lanes 0..t-1 of v, the rest zero
        // (rank 0 is never right).
        let v = if i == 0 {
            // SAFETY: src holds t = n bytes.
            unsafe { load_exact(src, t) }
        } else {
            _mm_shuffle_epi8(last, shift_row(32 - t))
        };
        let m = mask16(v, thr16);
        // SAFETY: bm holds the tail's bitmap byte plus RANK_SLACK; the exact left store
        // ends at nl+t-pc <= n, the right store at nr+16 <= n+RANK_SLACK.
        unsafe {
            wr16(bm, m as u16);
            if KIND == PART_FULL {
                let c = p16(v, m, 0);
                // Exact: the bytes after the lefts belong to the caller.
                store_exact(left.add(nl), t - m.count_ones() as usize, c);
                st128(right.add(nr), _mm_shuffle_epi8(c, rev));
            } else if KIND == PART_RIGHT {
                st128(right.add(nr), pc16(v, m, 0));
            }
        }
        nr += m.count_ones() as usize;
    }
    nr
}

/// The constants of the multiply-as-shift pack (avx2_pack.h) for D: c0 bytes {1, 2^D},
/// c1 words {1, 2^2D}, c3 = 2^4D-1 per qword; RYG_CMP[D] compacts each 128-bit lane's two
/// 8D-bit qwords to 2D bytes (junk lanes zero).
static RYG_CMP: [__m256i; 9] = {
    let mut t = [[0u8; 32]; 9];
    let mut d = 2;
    while d <= 7 {
        let mut k = 0;
        while k < 32 {
            let e = k % 16;
            t[d][k] = if e < d {
                e as u8
            } else if e < 2 * d {
                (8 + e - d) as u8
            } else {
                0x80
            };
            k += 1;
        }
        d += 1;
    }
    // SAFETY: same size, and every bit pattern is a valid __m256i.
    unsafe { transmute(t) }
};

/// Packs the codes ranks[i]-base of a depth-d flat region (2 <= d <= 8, n > 0) into
/// exactly dst[..(n*d+7)/8]: n512 codes in 512-value vertical blocks, the next n128 in
/// 128-value blocks and the rest in natural order (prim_enc_pack_dN, pack_dN_x86).
///
/// # Safety
/// The CPU has the features; dst holds (n*d+7)/8 bytes and ranks n; (n512, n128) is
/// vert_split(n, d).
#[target_feature(enable = "avx2,bmi2,popcnt")]
unsafe fn pack_avx2_asm(
    dst: *mut u8,
    ranks: *const u8,
    n: usize,
    n512: usize,
    n128: usize,
    d: u8,
    base: u8,
) {
    let base = _mm256_set1_epi8(base as i8);
    let nnat = n - n512 - n128;
    // SAFETY: forwarded.
    unsafe {
        match d {
            2 => pack_d::<2>(dst, ranks, nnat, n512, n128, base),
            3 => pack_d::<3>(dst, ranks, nnat, n512, n128, base),
            4 => pack_d::<4>(dst, ranks, nnat, n512, n128, base),
            5 => pack_d::<5>(dst, ranks, nnat, n512, n128, base),
            6 => pack_d::<6>(dst, ranks, nnat, n512, n128, base),
            7 => pack_d::<7>(dst, ranks, nnat, n512, n128, base),
            8 => pack_d::<8>(dst, ranks, nnat, n512, n128, base),
            _ => {}
        }
    }
}

/// # Safety
/// As for [`pack_avx2_asm`], with D = d.
#[inline]
#[target_feature(enable = "avx2,bmi2,popcnt")]
unsafe fn pack_d<const D: usize>(
    mut dst: *mut u8,
    mut src: *const u8,
    nnat: usize,
    n512: usize,
    n128: usize,
    base: __m256i,
) {
    // 512-value blocks run as two 32-lane halves (vert512_pack_ymm_d*), except D = 7,
    // which upstream runs as four 16-lane quarters on AMD (vert512_pack_x86_d7; 1.12 vs
    // 0.89 on c6a).
    // SAFETY: the blocks and the natural rest partition ranks[..n] and the region.
    unsafe {
        if D < 8 {
            for _ in 0..n512 >> 9 {
                if D == 7 {
                    vert_body::<D>(dst, src, 16, 64, 0, base);
                    vert_body::<D>(dst, src, 16, 64, 16, base);
                    vert_body::<D>(dst, src, 16, 64, 32, base);
                    vert_body::<D>(dst, src, 16, 64, 48, base);
                } else {
                    vert_body::<D>(dst, src, 32, 64, 0, base);
                    vert_body::<D>(dst, src, 32, 64, 32, base);
                }
                (src, dst) = (src.add(512), dst.add(512 * D / 8));
            }
            for _ in 0..n128 >> 7 {
                vert_body::<D>(dst, src, 16, 16, 0, base);
                (src, dst) = (src.add(128), dst.add(128 * D / 8));
            }
        }
        natural::<D>(dst, src, nnat, base);
    }
}

/// Packs w lanes at lane offset off of a vertical block whose rows (and columns) have the
/// given stride: code s*stride+l goes to bits s*D... of lane l.
///
/// Always inlined, as the generator unrolls the halves and quarters: LLVM keeps a loop
/// over them that rotates the masks through registers. It has no target features of its
/// own (Rust rejects them with `inline(always)`); its callers have them.
///
/// # Safety
/// The CPU has the features; src holds 8 rows and dst D columns of stride bytes.
#[inline(always)]
unsafe fn vert_body<const D: usize>(
    dst: *mut u8,
    src: *const u8,
    w: usize,
    stride: usize,
    off: usize,
    base: __m256i,
) {
    // SAFETY: the CPU has the features; the rows and columns lie in src and dst.
    unsafe {
        let mut cols = [_mm256_setzero_si256(); 8];
        unroll8!(s => {
            let (j, o) = ((s * D) >> 3, (s * D) & 7);
            let v = _mm256_subs_epu8(ldw(src.add(stride * s + off), w), base);
            if o == 0 {
                cols[j] = v;
            } else {
                let t = _mm256_and_si256(sll16(v, o), splat(0xFF << o));
                cols[j] = _mm256_or_si256(cols[j], t);
                if o + D > 8 {
                    cols[j + 1] = _mm256_and_si256(srl16(v, 8 - o), splat(0xFF >> (8 - o)));
                }
            }
        });
        for (j, &c) in cols.iter().enumerate().take(D) {
            stw(dst.add(stride * j + off), w, c);
        }
    }
}

/// Turns the 16 or 32 codes in v (zero in unused lanes) into 2D packed bytes per 128-bit
/// lane, or for D = 4 into 8 bytes per lane, or for D = 8 leaves them.
#[inline]
#[target_feature(enable = "avx2,bmi2,popcnt")]
fn code16<const D: usize>(v: __m256i) -> __m256i {
    match D {
        8 => v,
        4 => {
            let v = _mm256_maddubs_epi16(_mm256_set1_epi16(0x1001), v);
            _mm256_packus_epi16(v, v)
        }
        _ => {
            let c0 = _mm256_set1_epi16((1 | 1 << (D + 8)) as i16);
            let c1 = _mm256_set1_epi32(1 | 1 << (2 * D + 16));
            let c3 = _mm256_set1_epi64x(((1u64 << (4 * D)) - 1) as i64);
            let v = _mm256_madd_epi16(_mm256_maddubs_epi16(c0, v), c1);
            let xs = _mm256_andnot_si256(c3, srl64(v, 32 - 4 * D));
            let v = _mm256_or_si256(_mm256_and_si256(v, c3), xs);
            _mm256_shuffle_epi8(v, RYG_CMP[D])
        }
    }
}

/// Stores the low K (constant, 4..=16) bytes of x at o.
///
/// # Safety
/// o holds K writable bytes.
#[inline]
#[target_feature(enable = "avx2,bmi2,popcnt")]
unsafe fn store_const<const K: usize>(o: *mut u8, x: __m128i) {
    // SAFETY: the stores cover o[..K] exactly, overlapping for K = 6, 10, 12, 14.
    unsafe {
        match K {
            16 => st128(o, x),
            8 => _mm_storel_epi64(o.cast(), x),
            4 => wr32(o, _mm_cvtsi128_si32(x) as u32),
            6 => {
                wr32(o, _mm_cvtsi128_si32(x) as u32);
                wr32(o.add(2), _mm_cvtsi128_si32(_mm_srli_si128::<2>(x)) as u32);
            }
            10 => {
                _mm_storel_epi64(o.cast(), x);
                _mm_storel_epi64(o.add(2).cast(), _mm_srli_si128::<2>(x));
            }
            12 => {
                _mm_storel_epi64(o.cast(), x);
                _mm_storel_epi64(o.add(4).cast(), _mm_srli_si128::<4>(x));
            }
            14 => {
                _mm_storel_epi64(o.cast(), x);
                _mm_storel_epi64(o.add(6).cast(), _mm_srli_si128::<6>(x));
            }
            _ => unreachable!(),
        }
    }
}

/// pack_dN_x86's SIMD loops: 32 codes per step while the junk of its 16-byte stores stays
/// inside the region, then 16 codes per step with exact stores, then one partial step on
/// an exact load.
///
/// # Safety
/// src holds cnt codes and o their (cnt*D+7)/8 packed bytes.
#[inline]
#[target_feature(enable = "avx2,bmi2,popcnt")]
unsafe fn natural<const D: usize>(
    mut o: *mut u8,
    mut src: *const u8,
    mut cnt: usize,
    base: __m256i,
) {
    if cnt == 0 {
        return;
    }
    // Output bytes per 32- and 16-code step.
    let (per32, per16) = if D == 8 { (32, 16) } else { (4 * D, 2 * D) };
    // SAFETY: the steps read their codes inside src[..cnt] and store inside the region:
    // the 32-code step of D != 4, 8 stores 2D+16 bytes, so it runs while they fit.
    unsafe {
        let end = o.add((cnt * D).div_ceil(8));
        while cnt >= 32 {
            if D != 4 && D != 8 && (end as usize - o as usize) < 2 * D + 16 {
                break;
            }
            let v = code16::<D>(_mm256_subs_epu8(ld256(src), base));
            match D {
                8 => st256(o, v),
                4 => st128(
                    o,
                    _mm256_castsi256_si128(_mm256_permute4x64_epi64::<0x08>(v)),
                ),
                _ => {
                    st128(o, _mm256_castsi256_si128(v));
                    st128(o.add(2 * D), _mm256_extracti128_si256::<1>(v));
                }
            }
            (src, o, cnt) = (src.add(32), o.add(per32), cnt - 32);
        }
        while cnt >= 16 {
            let v = code16::<D>(_mm256_subs_epu8(_mm256_castsi128_si256(ld128(src)), base));
            let v = _mm256_castsi256_si128(v);
            match per16 {
                4 => store_const::<4>(o, v),
                6 => store_const::<6>(o, v),
                8 => store_const::<8>(o, v),
                10 => store_const::<10>(o, v),
                12 => store_const::<12>(o, v),
                14 => store_const::<14>(o, v),
                _ => store_const::<16>(o, v),
            }
            (src, o, cnt) = (src.add(16), o.add(per16), cnt - 16);
        }
        if cnt > 0 {
            let v = _mm256_castsi128_si256(load_exact(src, cnt));
            let v = _mm256_castsi256_si128(code16::<D>(_mm256_subs_epu8(v, base)));
            store_exact(o, if D == 8 { cnt } else { (cnt * D).div_ceil(8) }, v);
        }
    }
}

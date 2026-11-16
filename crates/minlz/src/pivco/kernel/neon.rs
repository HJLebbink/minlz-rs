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

//! The NEON tier of the encoder kernels: Go's `neon_arm64.go`, `neon_arm64.s` and
//! `neon_tables_arm64.go`, ports of upstream `src/pivco_huffman_primitives_neon.h` and
//! `pivco_huffman_neon_pack.h`. ASIMD is part of ARMv8, so the tier is on unless
//! [`NEON`](crate::cpu::NEON) is disabled. The kernels run whole vector steps and the generic
//! kernels finish the tails. Reads of src, ranks and bitmaps and stores to ranks[..n] and packed
//! regions are exact, and the partitions store inside right[..n]. The histogram is generic, as
//! upstream's, and the decoder is in MLIR (`super::mlir`).
//!
//! The `*_asm` functions port the Go assembly functions of the same name with intrinsics
//! and its instruction choices; their helpers are named after its macros. Differences: the
//! cursors are counts, not pointers; scalar popcounts are `count_ones` (CNT+ADDV, as the
//! assembly's VCNT+UADDLV); the gather's max is one UMAXV, which Go's assembler lacks.
//! Little-endian only: integer loads and vector lanes share one byte order.

use core::arch::aarch64::*;

use super::generic::{gather_generic, part_full_generic, part_none_generic, part_right_generic};
use super::generic_pack::{nat_pack, pack_generic};
use super::{RANK_SLACK, vert_split};

/// Sets `ranks[i] = s2r[src[i]]` and returns the largest rank written.
///
/// # Safety
/// The CPU has [`NEON`](crate::cpu::NEON).
pub(super) unsafe fn gather_neon(ranks: &mut [u8], src: &[u8], s2r: &[u8; 256]) -> u8 {
    let n = src.len();
    let ranks = &mut ranks[..n];
    let (k, mut mx) = (n & !15, 0);
    if k > 0 {
        // SAFETY: the CPU has NEON; ranks and src hold n >= k bytes.
        mx = unsafe { gather_neon_asm(ranks.as_mut_ptr(), src.as_ptr(), k, s2r) };
    }
    mx.max(gather_generic(&mut ranks[k..], &src[k..], s2r))
}

/// Partitions `ranks` by rank > thr; see [`super::Tier::part_full`].
///
/// # Safety
/// The CPU has [`NEON`](crate::cpu::NEON).
pub(super) unsafe fn part_full_neon(
    ranks: &mut [u8],
    right: &mut [u8],
    bm: &mut [u8],
    thr: u8,
) -> usize {
    let n = ranks.len();
    if n == 0 {
        return part_full_generic(ranks, right, bm, thr);
    }
    let (right, bm) = (
        &mut right[..n + RANK_SLACK],
        &mut bm[..n.div_ceil(8) + RANK_SLACK],
    );
    let (j, mut nr) = (n & !63, 0);
    if j > 0 {
        // SAFETY: the CPU has NEON; ranks and right hold n >= j bytes, bm j/8.
        nr = unsafe {
            part_full_neon_asm(
                ranks.as_mut_ptr(),
                right.as_mut_ptr(),
                bm.as_mut_ptr(),
                j,
                thr,
            )
        };
    }
    // The tail compacts its left ranks in place; they follow the j-nr vector ones.
    let tr = part_full_generic(&mut ranks[j..], &mut right[nr..], &mut bm[j / 8..], thr);
    ranks.copy_within(j..n - tr, j - nr);
    nr + tr
}

/// Partitions `ranks` like [`part_full_neon`] without compacting the left ranks.
///
/// # Safety
/// The CPU has [`NEON`](crate::cpu::NEON).
pub(super) unsafe fn part_right_neon(
    ranks: &[u8],
    right: &mut [u8],
    bm: &mut [u8],
    thr: u8,
) -> usize {
    let n = ranks.len();
    if n == 0 {
        return part_right_generic(ranks, right, bm, thr);
    }
    let (right, bm) = (
        &mut right[..n + RANK_SLACK],
        &mut bm[..n.div_ceil(8) + RANK_SLACK],
    );
    let (j, mut nr) = (n & !7, 0);
    if j > 0 {
        // SAFETY: the CPU has NEON; ranks and right hold n >= j bytes, bm j/8.
        nr = unsafe {
            part_right_neon_asm(ranks.as_ptr(), right.as_mut_ptr(), bm.as_mut_ptr(), j, thr)
        };
    }
    nr + part_right_generic(&ranks[j..], &mut right[nr..], &mut bm[j / 8..], thr)
}

/// Writes only the bitmap of `ranks` and returns the number of set bits.
///
/// # Safety
/// The CPU has [`NEON`](crate::cpu::NEON).
pub(super) unsafe fn part_none_neon(ranks: &[u8], bm: &mut [u8], thr: u8) -> usize {
    let n = ranks.len();
    if n == 0 {
        return part_none_generic(ranks, bm, thr);
    }
    let bm = &mut bm[..n.div_ceil(8) + RANK_SLACK];
    let (j, mut nr) = (n & !7, 0);
    if j > 0 {
        // SAFETY: the CPU has NEON; ranks holds n >= j bytes, bm j/8.
        nr = unsafe { part_none_neon_asm(ranks.as_ptr(), bm.as_mut_ptr(), j, thr) };
    }
    nr + part_none_generic(&ranks[j..], &mut bm[j / 8..], thr)
}

/// Packs the codes of a flat region; see [`super::Tier::pack`].
///
/// # Safety
/// The CPU has [`NEON`](crate::cpu::NEON).
pub(super) unsafe fn pack_neon(dst: &mut [u8], ranks: &[u8], d: u8, base: u8) {
    let n = ranks.len();
    if n == 0 || !(2..=8).contains(&d) {
        return pack_generic(dst, ranks, d, base);
    }
    let du = usize::from(d);
    let dst = &mut dst[..(n * du).div_ceil(8)];
    let (n512, n128) = vert_split(n, d);
    if n512 > 0 {
        // SAFETY: the CPU has NEON; 2 <= d <= 7 (vert_split), ranks holds n512 bytes and dst
        // their n512*d/8.
        unsafe { vert_pack_neon_asm(dst.as_mut_ptr(), ranks.as_ptr(), n512, 64, d, base) };
    }
    let (dst, ranks) = (&mut dst[n512 * du / 8..], &ranks[n512..]);
    if n128 > 0 {
        // SAFETY: as above, for n128.
        unsafe { vert_pack_neon_asm(dst.as_mut_ptr(), ranks.as_ptr(), n128, 16, d, base) };
    }
    let (dst, ranks) = (&mut dst[n128 * du / 8..], &ranks[n128..]);
    let mut i = 0;
    if ranks.len() >= 16 {
        // SAFETY: the CPU has NEON; the kernel reads at most ranks.len() ranks and stores
        // inside dst.len() bytes.
        i = unsafe {
            nat_pack_neon_asm(
                dst.as_mut_ptr(),
                ranks.as_ptr(),
                ranks.len(),
                dst.len(),
                d,
                base,
            )
        };
    }
    nat_pack(&mut dst[i * du / 8..], &ranks[i..], d, base);
}

// ---- Tables (Go neon_tables_arm64.go). The merge and partition tables are built as
// upstream's init_merge_tables and build_tabs (src/pivco_huffman_primitives_neon.h).

/// P16_A[m0] | P16_B[m1][pc0..] is the index that puts the left ranks of 16 with mask
/// m0|m1<<8 in order at the front and the right ones reversed at the back;
/// pc0 = popcount(m0).
static P16_A: [[u8; 16]; 256] = super::p16_tabs().0;
static P16_B: [[u8; 32]; 256] = super::p16_tabs().1;
/// CTAB[0][m] (CTAB[1][m]) moves the right ranks of the low (high) 8 lanes of a vector to
/// the front; 0xFF lanes look up zero.
static CTAB: [[[u8; 8]; 256]; 2] = ctabs();
/// NAT_PACK_TAB[d] is the compacting TBL and the USHL counts of upstream's converging
/// pyramid (src/pivco_huffman_neon_pack.h) at the 8, 16, 32 and 64-bit levels.
static NAT_PACK_TAB: [[[u8; 16]; 5]; 8] = nat_pack_tabs();

const fn ctabs() -> [[[u8; 8]; 256]; 2] {
    let mut t = [[[0u8; 8]; 256]; 2];
    let mut m = 0;
    while m < 256 {
        let mut q = 0;
        let mut k = 0;
        while k < 8 {
            if m >> k & 1 != 0 {
                (t[0][m][q], t[1][m][q]) = (k as u8, 8 + k as u8);
                q += 1;
            }
            k += 1;
        }
        while q < 8 {
            (t[0][m][q], t[1][m][q]) = (0xff, 0xff);
            q += 1;
        }
        m += 1;
    }
    t
}

const fn nat_pack_tabs() -> [[[u8; 16]; 5]; 8] {
    let mut t = [[[0u8; 16]; 5]; 8];
    let mut d = 2;
    while d <= 7 {
        // The pyramid leaves the 8d bits of each u64 at bit 32-4d; odd d shift 4 more to
        // start on a byte.
        let (s, sr) = ((8 - d) as u8, (4 * (d & 1)) as u8);
        let b0 = (32 - 4 * d - sr as usize) / 8;
        t[d][0] = [0xff; 16];
        let mut i = 0;
        while i < d {
            (t[d][0][i], t[d][0][d + i]) = ((b0 + i) as u8, (8 + b0 + i) as u8);
            i += 1;
        }
        let mut i = 0;
        while i < 16 {
            (t[d][1][i], t[d][1][i + 2]) = (s, s);
            (t[d][2][i], t[d][2][i + 2]) = (s, s.wrapping_neg());
            i += 4;
        }
        let mut i = 0;
        while i < 16 {
            (t[d][3][i], t[d][3][i + 4]) = (2 * s, (2 * s).wrapping_neg());
            t[d][4][i] = sr.wrapping_neg();
            i += 8;
        }
        d += 1;
    }
    t
}

// ---- Encoder kernels.

/// Upstream init_neon: s2r lives in 16 registers, one TBL4 maps symbols 0..63 and three
/// TBX4 the other quarters.
///
/// # Safety
///
/// n > 0 is a multiple of 16, ranks and src hold n bytes; the CPU has NEON.
#[target_feature(enable = "neon")]
unsafe fn gather_neon_asm(ranks: *mut u8, src: *const u8, n: usize, s2r: &[u8; 256]) -> u8 {
    // SAFETY: the loads read the 256 bytes of s2r and src[i..i+16], the stores write
    // ranks[i..i+16], i+16 <= n.
    unsafe {
        let t = s2r.as_ptr();
        let (t0, t1) = (vld1q_u8_x4(t), vld1q_u8_x4(t.add(64)));
        let (t2, t3) = (vld1q_u8_x4(t.add(128)), vld1q_u8_x4(t.add(192)));
        let c64 = vdupq_n_u8(64);
        let mut mx = vdupq_n_u8(0);
        for i in (0..n).step_by(16) {
            let mut v = vld1q_u8(src.add(i));
            let mut r = vqtbl4q_u8(t0, v);
            v = vsubq_u8(v, c64);
            r = vqtbx4q_u8(r, t1, v);
            v = vsubq_u8(v, c64);
            r = vqtbx4q_u8(r, t2, v);
            v = vsubq_u8(v, c64);
            r = vqtbx4q_u8(r, t3, v);
            mx = vmaxq_u8(r, mx);
            vst1q_u8(ranks.add(i), r);
        }
        // UMAXV; Go's assembler has none and folds with EXT and UMAX.
        vmaxvq_u8(mx)
    }
}

/// The bit weights 1, 2, .., 128 of the lanes of each 8-lane chunk.
#[inline(always)]
unsafe fn bit_weights() -> uint8x16_t {
    // SAFETY: the CPU has NEON.
    unsafe { vreinterpretq_u8_u64(vdupq_n_u64(0x8040201008040201)) }
}

/// MASKS64: the partition masks of the 64 ranks in v (byte c for ranks 8c..8c+7): compare
/// with t, keep the bit weights w and sum each 8-lane chunk with a pairwise-add tree
/// (upstream masks64v_neon).
#[inline(always)]
unsafe fn masks64(v: uint8x16x4_t, t: uint8x16_t, w: uint8x16_t) -> uint8x8_t {
    // SAFETY: the CPU has NEON.
    unsafe {
        let a = vpaddq_u8(vandq_u8(vcgtq_u8(v.0, t), w), vandq_u8(vcgtq_u8(v.1, t), w));
        let b = vpaddq_u8(vandq_u8(vcgtq_u8(v.2, t), w), vandq_u8(vcgtq_u8(v.3, t), w));
        let a = vpaddq_u8(a, b);
        vget_low_u8(vpaddq_u8(a, a))
    }
}

/// MASK8: the partition mask of the 8 ranks in v's low half, whose high half is zero.
#[inline(always)]
unsafe fn mask8(v: uint8x16_t, t: uint8x16_t, w: uint8x16_t) -> u8 {
    // SAFETY: the CPU has NEON.
    unsafe { vaddv_u8(vget_low_u8(vandq_u8(vcgtq_u8(v, t), w))) }
}

/// Returns the low lane of the masks and the running popcounts of their bytes.
#[inline(always)]
unsafe fn mask_pops(mv: uint8x8_t) -> (u64, u64) {
    // SAFETY: the CPU has NEON.
    unsafe {
        let m = vget_lane_u64::<0>(vreinterpret_u64_u8(mv));
        (m, vget_lane_u64::<0>(vreinterpret_u64_u8(vcnt_u8(mv))))
    }
}

/// P16: scatters the 16 ranks of v, whose masks are the low 16 bits of m and the popcount
/// of the first mask the low byte of pops. One TBL puts the left ranks in order at the
/// front and the right ones reversed at the back, a second one (rev) reverses (upstream
/// part64_full_neon). The stores are 16 bytes at l and r; the junk after each side is
/// overwritten by the next group or ends inside the step's 64 ranks.
///
/// # Safety
///
/// l and r are writable for 16 bytes; the CPU has NEON.
#[inline(always)]
unsafe fn p16(v: uint8x16_t, m: u64, pops: u64, rev: uint8x16_t, l: *mut u8, r: *mut u8) {
    let (m0, m1, pc0) = (m as u8, (m >> 8) as u8, usize::from(pops as u8));
    // SAFETY: pc0 <= 8 keeps the P16_B load inside its 32-byte row; the caller guarantees the
    // stores.
    unsafe {
        let a = vld1q_u8(P16_A[usize::from(m0)].as_ptr());
        let b = vld1q_u8(P16_B[usize::from(m1)].as_ptr().add(pc0));
        let x = vqtbl1q_u8(v, vorrq_u8(a, b));
        vst1q_u8(l, x);
        vst1q_u8(r, vqtbl1q_u8(x, rev));
    }
}

/// # Safety
///
/// n > 0 is a multiple of 64, ranks and right hold n bytes and bm n/8; the CPU has NEON.
#[target_feature(enable = "neon")]
unsafe fn part_full_neon_asm(
    ranks: *mut u8,
    right: *mut u8,
    bm: *mut u8,
    n: usize,
    thr: u8,
) -> usize {
    // SAFETY: a step at i loads ranks[i..i+64] before it stores; chunk g with c right ranks
    // before it stores 16 bytes at ranks[nl+16g-c..] and right[nr+c..], nl, nr <= i, so
    // inside the step's 64 bytes.
    unsafe {
        let (t, w) = (vdupq_n_u8(thr), bit_weights());
        let rev = vcombine_u8(
            vcreate_u8(0x08090a0b0c0d0e0f),
            vcreate_u8(0x0001020304050607),
        );
        let (mut nl, mut nr) = (0, 0);
        for i in (0..n).step_by(64) {
            // The left stores land in the step's own ranks, so all 64 are loaded first.
            let v = vld1q_u8_x4(ranks.add(i));
            let (m, pops) = mask_pops(masks64(v, t, w));
            bm.add(i / 8).cast::<u64>().write_unaligned(m);
            let pc = pops.wrapping_mul(0x0101010101010101);
            for (g, x) in [v.0, v.1, v.2, v.3].into_iter().enumerate() {
                let c = usize::from((pc << 8 >> (16 * g)) as u8);
                let (l, r) = (ranks.add(nl + 16 * g - c), right.add(nr + c));
                p16(x, m >> (16 * g), pops >> (16 * g), rev, l, r);
            }
            let tr = (pc >> 56) as usize;
            (nl, nr) = (nl + 64 - tr, nr + tr);
        }
        nr
    }
}

/// C8: stores the right ranks of 8 lanes of v (mask m, CTAB half tab) at r; the junk after
/// them is overwritten by the next chunk.
///
/// # Safety
///
/// r is writable for 8 bytes; the CPU has NEON.
#[inline(always)]
unsafe fn c8(v: uint8x16_t, tab: &[[u8; 8]; 256], m: u8, r: *mut u8) {
    // SAFETY: the caller guarantees the store.
    unsafe { vst1_u8(r, vqtbl1_u8(v, vld1_u8(tab[usize::from(m)].as_ptr()))) }
}

/// Upstream part_core_neon with EMIT_RIGHT.
///
/// # Safety
///
/// n > 0 is a multiple of 8, ranks and right hold n bytes and bm n/8; the CPU has NEON.
#[target_feature(enable = "neon")]
unsafe fn part_right_neon_asm(
    ranks: *const u8,
    right: *mut u8,
    bm: *mut u8,
    n: usize,
    thr: u8,
) -> usize {
    // SAFETY: steps read ranks[i..] and write bm[i/8..] inside n; chunk h of a step stores 8
    // bytes at right[nr+c..], c right ranks before it, so below i+8h+8 <= n.
    unsafe {
        let (t, w) = (vdupq_n_u8(thr), bit_weights());
        let (mut i, mut nr) = (0, 0);
        while n - i >= 64 {
            let v = vld1q_u8_x4(ranks.add(i));
            let (m, pops) = mask_pops(masks64(v, t, w));
            bm.add(i / 8).cast::<u64>().write_unaligned(m);
            let pc = pops.wrapping_mul(0x0101010101010101);
            for (h, x) in [v.0, v.0, v.1, v.1, v.2, v.2, v.3, v.3]
                .into_iter()
                .enumerate()
            {
                let c = usize::from((pc << 8 >> (8 * h)) as u8);
                c8(x, &CTAB[h & 1], (m >> (8 * h)) as u8, right.add(nr + c));
            }
            (i, nr) = (i + 64, nr + (pc >> 56) as usize);
        }
        while i < n {
            let v = vcombine_u8(vld1_u8(ranks.add(i)), vdup_n_u8(0));
            let m = mask8(v, t, w);
            *bm.add(i / 8) = m;
            c8(v, &CTAB[0], m, right.add(nr));
            (i, nr) = (i + 8, nr + m.count_ones() as usize);
        }
        nr
    }
}

/// Upstream part_core_neon without EMIT_RIGHT.
///
/// # Safety
///
/// n > 0 is a multiple of 8, ranks holds n bytes and bm n/8; the CPU has NEON.
#[target_feature(enable = "neon")]
unsafe fn part_none_neon_asm(ranks: *const u8, bm: *mut u8, n: usize, thr: u8) -> usize {
    // SAFETY: steps read ranks[i..] and write bm[i/8..] inside n.
    unsafe {
        let (t, w) = (vdupq_n_u8(thr), bit_weights());
        let (mut i, mut nr) = (0, 0);
        while n - i >= 64 {
            let mv = masks64(vld1q_u8_x4(ranks.add(i)), t, w);
            vst1_u8(bm.add(i / 8), mv);
            (i, nr) = (i + 64, nr + usize::from(vaddlv_u8(vcnt_u8(mv))));
        }
        while i < n {
            let m = mask8(vcombine_u8(vld1_u8(ranks.add(i)), vdup_n_u8(0)), t, w);
            *bm.add(i / 8) = m;
            (i, nr) = (i + 8, nr + m.count_ones() as usize);
        }
        nr
    }
}

/// VSLI chain: a with each b inserted in turn at bit n, above the bits already there.
macro_rules! sli {
    ($a:expr $(, $n:literal: $b:expr)*) => {{
        let x = $a;
        $(let x = vsliq_n_u8::<$n>(x, $b);)*
        x
    }};
}

/// Upstream vert_pack_neon_dN, vert512_pack_neon_dN: each column is built with VSLI in step
/// order, which only inserts above the bits already there.
///
/// # Safety
///
/// n > 0 is a multiple of 8*ln, 2 <= d <= 7 and every rank-base < 1<<d; ranks holds n bytes
/// and dst n*d/8; the CPU has NEON.
#[target_feature(enable = "neon")]
unsafe fn vert_pack_neon_asm(dst: *mut u8, ranks: *const u8, n: usize, ln: usize, d: u8, base: u8) {
    // SAFETY: the caller sized dst and ranks as vp_loop requires.
    unsafe {
        let b = vdupq_n_u8(base);
        match d {
            2 => vp_loop::<2>(dst, ranks, n, ln, b, |v| {
                [
                    sli!(v[0], 2: v[1], 4: v[2], 6: v[3]),
                    sli!(v[4], 2: v[5], 4: v[6], 6: v[7]),
                ]
            }),
            3 => vp_loop::<3>(dst, ranks, n, ln, b, |v| {
                [
                    sli!(v[0], 3: v[1], 6: v[2]),
                    sli!(vshrq_n_u8::<2>(v[2]), 1: v[3], 4: v[4], 7: v[5]),
                    sli!(vshrq_n_u8::<1>(v[5]), 2: v[6], 5: v[7]),
                ]
            }),
            4 => vp_loop::<4>(dst, ranks, n, ln, b, |v| {
                [
                    sli!(v[0], 4: v[1]),
                    sli!(v[2], 4: v[3]),
                    sli!(v[4], 4: v[5]),
                    sli!(v[6], 4: v[7]),
                ]
            }),
            5 => vp_loop::<5>(dst, ranks, n, ln, b, |v| {
                [
                    sli!(v[0], 5: v[1]),
                    sli!(vshrq_n_u8::<3>(v[1]), 2: v[2], 7: v[3]),
                    sli!(vshrq_n_u8::<1>(v[3]), 4: v[4]),
                    sli!(vshrq_n_u8::<4>(v[4]), 1: v[5], 6: v[6]),
                    sli!(vshrq_n_u8::<2>(v[6]), 3: v[7]),
                ]
            }),
            6 => vp_loop::<6>(dst, ranks, n, ln, b, |v| {
                [
                    sli!(v[0], 6: v[1]),
                    sli!(vshrq_n_u8::<2>(v[1]), 4: v[2]),
                    sli!(vshrq_n_u8::<4>(v[2]), 2: v[3]),
                    sli!(v[4], 6: v[5]),
                    sli!(vshrq_n_u8::<2>(v[5]), 4: v[6]),
                    sli!(vshrq_n_u8::<4>(v[6]), 2: v[7]),
                ]
            }),
            _ => vp_loop::<7>(dst, ranks, n, ln, b, |v| {
                [
                    sli!(v[0], 7: v[1]),
                    sli!(vshrq_n_u8::<1>(v[1]), 6: v[2]),
                    sli!(vshrq_n_u8::<2>(v[2]), 5: v[3]),
                    sli!(vshrq_n_u8::<3>(v[3]), 4: v[4]),
                    sli!(vshrq_n_u8::<4>(v[4]), 3: v[5]),
                    sli!(vshrq_n_u8::<5>(v[5]), 2: v[6]),
                    sli!(vshrq_n_u8::<6>(v[6]), 1: v[7]),
                ]
            }),
        }
    }
}

/// The vertical pack walks 16-lane groups of ln-lane blocks: f builds the D columns of a
/// group from its 8 steps (VP_LOAD: base subtracted), which are stored at a stride of ln.
///
/// # Safety
///
/// n is a multiple of 8*ln, ln of 16; ranks holds n bytes and dst n*D/8; the CPU has NEON.
#[inline(always)]
unsafe fn vp_loop<const D: usize>(
    mut dst: *mut u8,
    mut ranks: *const u8,
    mut n: usize,
    ln: usize,
    base: uint8x16_t,
    f: impl Fn([uint8x16_t; 8]) -> [uint8x16_t; D],
) {
    // SAFETY: a block reads its 8*ln ranks and writes its D*ln column bytes.
    unsafe {
        while n > 0 {
            for g in (0..ln).step_by(16) {
                let v = core::array::from_fn(|s| vsubq_u8(vld1q_u8(ranks.add(g + s * ln)), base));
                for (j, c) in f(v).into_iter().enumerate() {
                    vst1q_u8(dst.add(g + j * ln), c);
                }
            }
            (dst, ranks, n) = (dst.add(D * ln), ranks.add(8 * ln), n - 8 * ln);
        }
    }
}

/// Packs 16-code groups of the natural layout while a 16-byte store fits in dst[..dst_len]
/// and returns the number of codes done, a multiple of 16. D < 8 is upstream's converging
/// pyramid (pivco_huffman_neon_pack.h) for every d: each USHL level shifts the halves of a
/// lane pair towards each other until u64 lane h holds codes 8h..8h+7, and a TBL compacts
/// their 2d bytes.
///
/// # Safety
///
/// n >= 16, 2 <= d <= 8 and every rank-base < 1<<d; ranks holds n bytes and dst dst_len,
/// at least n for d=8, which stores n & !15 bytes without consulting dst_len; the CPU has
/// NEON.
#[target_feature(enable = "neon")]
unsafe fn nat_pack_neon_asm(
    mut dst: *mut u8,
    mut ranks: *const u8,
    n: usize,
    mut dst_len: usize,
    d: u8,
    base: u8,
) -> usize {
    // SAFETY: every load reads 16 or 64 of the left ranks; every store writes 16 (d<8) or as
    // many bytes as codes (d=8, dst_len = n) inside dst_len.
    unsafe {
        let b = vdupq_n_u8(base);
        let mut left = n;
        if d == 8 {
            while left >= 64 {
                let v = vld1q_u8_x4(ranks);
                let v = uint8x16x4_t(
                    vsubq_u8(v.0, b),
                    vsubq_u8(v.1, b),
                    vsubq_u8(v.2, b),
                    vsubq_u8(v.3, b),
                );
                vst1q_u8_x4(dst, v);
                (dst, ranks, left) = (dst.add(64), ranks.add(64), left - 64);
            }
            while left >= 16 {
                vst1q_u8(dst, vsubq_u8(vld1q_u8(ranks), b));
                (dst, ranks, left) = (dst.add(16), ranks.add(16), left - 16);
            }
            return n - left;
        }
        let t = &NAT_PACK_TAB[usize::from(d)];
        let tb = vld1q_u8(t[0].as_ptr());
        let s8 = vreinterpretq_s8_u8(vld1q_u8(t[1].as_ptr()));
        let s16 = vreinterpretq_s16_u8(vld1q_u8(t[2].as_ptr()));
        let s32 = vreinterpretq_s32_u8(vld1q_u8(t[3].as_ptr()));
        let s64 = vreinterpretq_s64_u8(vld1q_u8(t[4].as_ptr()));
        let w = 2 * usize::from(d);
        while left >= 16 && dst_len >= 16 {
            let v = vshlq_u8(vsubq_u8(vld1q_u8(ranks), b), s8);
            let v = vshlq_u16(vreinterpretq_u16_u8(v), s16);
            let v = vshlq_u32(vreinterpretq_u32_u16(v), s32);
            let v = vshlq_u64(vreinterpretq_u64_u32(v), s64);
            vst1q_u8(dst, vqtbl1q_u8(vreinterpretq_u8_u64(v), tb));
            (dst, dst_len) = (dst.add(w), dst_len - w);
            (ranks, left) = (ranks.add(16), left - 16);
        }
        n - left
    }
}

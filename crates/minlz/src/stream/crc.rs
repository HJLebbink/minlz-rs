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

//! CRC32C (Castagnoli) with the MinLZ/S2/Snappy mask.
//!
//! On a CPU with the CRC32 instruction (SSE 4.2 on x86-64, the CRC extension
//! on aarch64) the MLIR kernels of [`mlir`] compute the CRC, picked once at
//! runtime. Everywhere else a table-based CRC32C does.
//!
//! The `mask_crc32c` wrapper is the bit that differs from upstream Snappy: it
//! rotates the raw CRC right by 15 and adds the Snappy mask constant.  Go's
//! `minlz.go:crc` expresses this with operator-precedence-dependent code
//! (`c>>15 | c<<17 + 0xa282ead8`) that, taken literally, parses *differently*
//! in Rust — see the inline comment on [`mask_crc32c`].
//!
//! Test vectors come from `minlz-rs/_helpers/crc_vectors/main.go`.

use std::sync::OnceLock;

#[cfg(all(
    any(
        target_arch = "x86_64",
        all(target_arch = "aarch64", target_endian = "little")
    ),
    not(miri)
))]
mod mlir;

const POLY: u32 = 0x82F6_3B78;

const TABLE: [u32; 256] = build_table();

const fn build_table() -> [u32; 256] {
    let mut table = [0u32; 256];
    let mut i = 0;
    while i < 256 {
        let mut c = i as u32;
        let mut j = 0;
        while j < 8 {
            c = if c & 1 != 0 { (c >> 1) ^ POLY } else { c >> 1 };
            j += 1;
        }
        table[i] = c;
        i += 1;
    }
    table
}

type CrcFn = fn(u32, &[u8]) -> u32;

static CRC_IMPL: OnceLock<CrcFn> = OnceLock::new();

#[inline]
fn dispatch() -> CrcFn {
    *CRC_IMPL.get_or_init(select_impl)
}

fn select_impl() -> CrcFn {
    #[cfg(all(
        any(
            target_arch = "x86_64",
            all(target_arch = "aarch64", target_endian = "little")
        ),
        not(miri)
    ))]
    if let Some(f) = mlir::best() {
        return f;
    }
    crc32c_update_table
}

/// Compute CRC32C of `data` starting from a CRC of 0.
#[inline]
pub(crate) fn crc32c(data: &[u8]) -> u32 {
    crc32c_update(0, data)
}

/// Continue an in-progress CRC32C with more bytes.
#[inline]
pub(crate) fn crc32c_update(crc: u32, data: &[u8]) -> u32 {
    dispatch()(crc, data)
}

/// Portable scalar CRC32C.  Slice-by-8 inner loop with byte-at-a-time
/// tail.  Selected when no hardware CRC32C is available (legacy x86
/// without SSE 4.2, ARMv7, MIPS, RISC-V, big-endian, …).
fn crc32c_update_table(crc: u32, data: &[u8]) -> u32 {
    let mut c = !crc;
    let (chunks, rest) = data.as_chunks::<8>();
    for chunk in chunks {
        // The 4-byte sub-slices of an 8-byte chunk always convert.
        let v0 = u32::from_le_bytes(chunk[0..4].try_into().unwrap()) ^ c;
        let v1 = u32::from_le_bytes(chunk[4..8].try_into().unwrap());
        // Slice-by-8: process 8 bytes per iteration via 8 parallel tables.
        c = SLICE_TABLE[7][(v0 & 0xff) as usize]
            ^ SLICE_TABLE[6][((v0 >> 8) & 0xff) as usize]
            ^ SLICE_TABLE[5][((v0 >> 16) & 0xff) as usize]
            ^ SLICE_TABLE[4][((v0 >> 24) & 0xff) as usize]
            ^ SLICE_TABLE[3][(v1 & 0xff) as usize]
            ^ SLICE_TABLE[2][((v1 >> 8) & 0xff) as usize]
            ^ SLICE_TABLE[1][((v1 >> 16) & 0xff) as usize]
            ^ SLICE_TABLE[0][((v1 >> 24) & 0xff) as usize];
    }
    for &b in rest {
        c = TABLE[((c ^ u32::from(b)) & 0xff) as usize] ^ (c >> 8);
    }
    !c
}

/// Slice-by-8 tables (the 0th column is the same as [`TABLE`]).  Each
/// `SLICE_TABLE[k]` is the byte-level CRC32C lookup shifted by `k` bytes.
const SLICE_TABLE: [[u32; 256]; 8] = build_slice_table();

const fn build_slice_table() -> [[u32; 256]; 8] {
    let mut table = [[0u32; 256]; 8];
    // SLICE_TABLE[0] is the standard byte-level CRC32C step table.
    let mut i = 0;
    while i < 256 {
        table[0][i] = TABLE[i];
        i += 1;
    }
    // For k = 1..8, SLICE_TABLE[k][b] = SLICE_TABLE[k-1][b] shifted by one
    // more byte position through the CRC.
    let mut k = 1;
    while k < 8 {
        let mut b = 0;
        while b < 256 {
            let prev = table[k - 1][b];
            table[k][b] = (prev >> 8) ^ table[0][(prev & 0xff) as usize];
            b += 1;
        }
        k += 1;
    }
    table
}

/// Apply the MinLZ/S2/Snappy mask to a raw CRC32C value.
///
/// Go's source reads `c>>15 | c<<17 + 0xa282ead8`.  In Go, `|` and `+` are
/// same-precedence and associate left-to-right, so it means
/// `((c>>15) | (c<<17)) + 0xa282ead8`.  In Rust `+` binds tighter than `|`,
/// so the literal translation is wrong; we use `rotate_right(15)` (equivalent
/// to `(c>>15) | (c<<17)`) and `wrapping_add` to match Go's two's-complement
/// 32-bit overflow behavior.
#[inline]
pub(crate) fn mask_crc32c(c: u32) -> u32 {
    c.rotate_right(15).wrapping_add(0xa282_ead8)
}

/// Compute the masked CRC32C of `data` (raw CRC + mask).
#[inline]
pub(crate) fn masked_crc32c(data: &[u8]) -> u32 {
    mask_crc32c(crc32c(data))
}

#[cfg(test)]
mod tests {
    use super::*;

    fn check(input: &[u8], raw: u32, masked: u32) {
        assert_eq!(crc32c(input), raw, "raw mismatch for {input:?}");
        assert_eq!(mask_crc32c(raw), masked, "mask fn mismatch for {input:?}");
        assert_eq!(
            masked_crc32c(input),
            masked,
            "masked mismatch for {input:?}"
        );
        // Also exercise the table impl directly so a wrong hardware path
        // doesn't mask itself by silently agreeing with itself.
        assert_eq!(
            crc32c_update_table(0, input),
            raw,
            "table mismatch for {input:?}"
        );
    }

    /// Returns n bytes from a linear congruential generator that starts at seed.
    fn lcg_bytes(seed: u64, n: usize) -> Vec<u8> {
        let mut x = seed;
        (0..n)
            .map(|_| {
                x = x
                    .wrapping_mul(6364136223846793005)
                    .wrapping_add(1442695040888963407);
                (x >> 24) as u8
            })
            .collect()
    }

    #[test]
    fn vectors_match_go() {
        // Vectors from minlz-rs/_helpers/crc_vectors/main.go.
        check(b"", 0x0000_0000, 0xa282_ead8);
        check(b"a", 0xc1d0_4330, 0x28e4_6e78);
        check(b"ab", 0xe2a2_2936, 0xf4f0_b01c);
        check(b"abc", 0x364b_3fb7, 0x21f1_576e);
        check(b"123456789", 0xe306_9283, 0xc78a_b0e5);
        check(
            b"The quick brown fox jumps over the lazy dog",
            0x2262_0404,
            0xaa8b_2f9c,
        );
        check(&[0u8; 32], 0x8a91_36aa, 0x0fd7_fffa);
        check(&[0xffu8; 32], 0x62a8_ab43, 0xf909_b029);
        let inc: Vec<u8> = (0u32..1024).map(|i| i as u8).collect();
        check(&inc, 0x2cdf_6e8f, 0x7fa1_4496);
        check(b"MinLz\x0b", 0x068b_74c0, 0x8c02_f7ee);
    }

    #[test]
    fn empty_masked_is_constant() {
        // crc32c(empty) = 0; rotate_right(0, 15) = 0; 0 + mask = mask.
        assert_eq!(masked_crc32c(&[]), 0xa282_ead8);
    }

    #[test]
    fn update_is_associative() {
        let data = b"the quick brown fox jumps over the lazy dog";
        let one_shot = crc32c(data);
        let (a, b) = data.split_at(11);
        let split = crc32c_update(crc32c_update(0, a), b);
        assert_eq!(one_shot, split);
    }

    /// Differential test: at every offset/length combination across an odd
    /// size, the hardware and table impls must agree.  Catches bugs in the
    /// 8-byte-chunk + tail handling.
    #[test]
    fn hw_matches_table_at_every_tail() {
        let data: Vec<u8> = (0..257u32).map(|i| (i * 31) as u8).collect();
        for end in 0..=data.len() {
            let slice = &data[..end];
            let hw = crc32c(slice);
            let tbl = crc32c_update_table(0, slice);
            assert_eq!(hw, tbl, "length {end}");
        }
    }

    /// Every kernel the CPU has agrees with the table at every length up to past 1 KiB and at
    /// longer ones, from unaligned starts and a nonzero CRC. The lengths reach the folding
    /// kernels' blocks, strides and tails, and the chains kernels' runs of three 1 KiB regions
    /// (`crc32c_chains.mlir`) and the bytes after them.
    #[cfg(all(
        any(
            target_arch = "x86_64",
            all(target_arch = "aarch64", target_endian = "little")
        ),
        not(miri)
    ))]
    #[test]
    fn kernels_match_table() {
        let data = lcg_bytes(0x0123_4567_89ab_cdef, 70_000);
        let isas = mlir::Isa::available();
        assert!(!isas.is_empty() || cfg!(not(target_arch = "x86_64")));
        let long = [
            1_536,
            3 * 1_024 - 1,
            3 * 1_024,
            3 * 1_024 + 17,
            4_096 + 5,
            6 * 1_024 + 31,
            10_000,
            65_536 + 31,
        ];
        for &isa in &isas {
            for (i, len) in (0..=1_100).chain(long).enumerate() {
                let start = i % 16;
                let crc = (i as u32).wrapping_mul(0x9e37_79b9);
                let slice = &data[start..start + len];
                // SAFETY: Isa::available checked isa's features.
                let got = unsafe { mlir::update(isa, crc, slice) };
                assert_eq!(got, crc32c_update_table(crc, slice), "{isa:?} len {len}");
            }
        }
    }
}

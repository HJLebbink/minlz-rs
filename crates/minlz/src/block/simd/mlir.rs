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

//! The stream checks of chunks, written once in MLIR (`crates/minlz/mlir/stats.mlir`) and lowered
//! by `cargo xtask mlir` for each target into the assembly in `mlir/`, which the naked functions
//! below hold: AVX2 and AVX-512 on x86-64, NEON on aarch64.
//!
//! A kernel takes `(p, n, r)`: n bytes at p, a multiple of 64, and r, where it writes its sums.
//! It returns 0 if every byte is in range. [`tok`], [`ll`] and [`off`] give it the whole 64-byte
//! chunks of a stream; `tok_stats`, `ll_stats` and `off_stats` of the decoder take the rest.

/// The targets with kernels.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(super) enum Isa {
    #[cfg(target_arch = "x86_64")]
    Avx2,
    #[cfg(target_arch = "x86_64")]
    Avx512,
    #[cfg(target_arch = "aarch64")]
    Neon,
}

#[cfg(target_arch = "x86_64")]
type Kernel = unsafe extern "sysv64" fn(*const u8, usize, *mut u64) -> u64;
#[cfg(target_arch = "aarch64")]
type Kernel = unsafe extern "C" fn(*const u8, usize, *mut u64) -> u64;

/// Declares the tok, ll and off kernels in `mlir/$dir/`.
macro_rules! kernels {
    ($tok:ident, $ll:ident, $off:ident, $dir:literal) => {
        mlir_kernel!(
            $tok(p: *const u8, n: usize, r: *mut u64) -> u64,
            concat!("mlir/", $dir, "/tok.s")
        );
        mlir_kernel!(
            $ll(p: *const u8, n: usize, r: *mut u64) -> u64,
            concat!("mlir/", $dir, "/ll.s")
        );
        mlir_kernel!(
            $off(p: *const u8, n: usize, r: *mut u64) -> u64,
            concat!("mlir/", $dir, "/off.s")
        );
    };
}

#[cfg(target_arch = "x86_64")]
kernels!(tok_avx2, ll_avx2, off_avx2, "avx2");
#[cfg(target_arch = "x86_64")]
kernels!(tok_avx512, ll_avx512, off_avx512, "avx512");
#[cfg(target_arch = "aarch64")]
kernels!(tok_neon, ll_neon, off_neon, "neon");

impl Isa {
    /// Returns the tok, ll and off kernels.
    fn kernels(self) -> [Kernel; 3] {
        match self {
            #[cfg(target_arch = "x86_64")]
            Isa::Avx2 => [tok_avx2, ll_avx2, off_avx2],
            #[cfg(target_arch = "x86_64")]
            Isa::Avx512 => [tok_avx512, ll_avx512, off_avx512],
            #[cfg(target_arch = "aarch64")]
            Isa::Neon => [tok_neon, ll_neon, off_neon],
        }
    }
}

/// Runs kernel on the whole 64-byte chunks of b. Returns its sums, the bytes it took, and
/// whether they were in range.
///
/// # Safety
///
/// The CPU has the features of the kernel's target.
#[inline(never)]
unsafe fn run(kernel: Kernel, b: &[u8]) -> ([usize; 4], usize, bool) {
    let n = b.len() & !63;
    let mut r = [0u64; 4];
    // SAFETY: the caller checked the features; the kernel reads the n bytes of b and writes at
    // most the four words of r.
    let bad = unsafe { kernel(b.as_ptr(), n, r.as_mut_ptr()) };
    (r.map(|x| x as usize), n, bad == 0)
}

/// Returns the token stats of a prefix of tok (see `tok_stats`): the summed match length codes,
/// the operations with literals, the repeats and the escaped matches, the prefix's length, and
/// whether its tokens are at most 135.
///
/// # Safety
///
/// The CPU has the features of isa.
pub(super) unsafe fn tok(isa: Isa, tok: &[u8]) -> (usize, usize, usize, usize, usize, bool) {
    // SAFETY: the caller checked isa's features.
    let ([out, lit, rep, esc], n, ok) = unsafe { run(isa.kernels()[0], tok) };
    (out, lit, rep, esc, n, ok)
}

/// Returns the literal length stats of a prefix of ll (see `ll_stats`): the sum, the escapes,
/// the prefix's length, and whether its lengths are 1 to 33. The sum is exact for any bytes.
///
/// # Safety
///
/// The CPU has the features of isa.
pub(super) unsafe fn ll(isa: Isa, ll: &[u8]) -> (usize, usize, usize, bool) {
    // SAFETY: the caller checked isa's features.
    let ([sum, esc, ..], n, ok) = unsafe { run(isa.kernels()[1], ll) };
    (sum, esc, n, ok)
}

/// Returns the raw bits of the offset symbols of a prefix of offc (see `off_stats`), the
/// prefix's length, and whether its symbols are 1 to 175.
///
/// # Safety
///
/// The CPU has the features of isa.
pub(super) unsafe fn off(isa: Isa, offc: &[u8]) -> (usize, usize, bool) {
    // SAFETY: the caller checked isa's features.
    let ([bits, ..], n, ok) = unsafe { run(isa.kernels()[2], offc) };
    (bits, n, ok)
}

#[cfg(test)]
mod tests {
    use super::super::decode::{ll_stats, off_stats, tok_stats};
    use super::super::decode_tests::Rng;
    use super::super::exec::Tier;

    /// Every tier with kernels agrees with the portable stats of the Go tier, which also finish
    /// each stream, at every length near a multiple of 64 and over long streams, with the range
    /// limits and the largest bytes in every lane.
    #[test]
    fn stats_kernels_match_go() {
        let mut rng = Rng(10);
        let lens = (0..200).chain([2032, 2048, 2064, 4112, 1 << 16, 70000, 1 << 17]);
        for n in lens {
            for fill in [0xff, 136, 135, 34, 33, 176, 175, 1, 0] {
                let mut b = vec![fill; n];
                if fill == 0 {
                    rng.read(&mut b);
                }
                let go = (
                    tok_stats(Tier::Go, &b),
                    ll_stats(Tier::Go, &b),
                    off_stats(Tier::Go, &b),
                );
                for &tier in Tier::tiers().iter().filter(|&&t| t != Tier::Go) {
                    let got = (tok_stats(tier, &b), ll_stats(tier, &b), off_stats(tier, &b));
                    assert_eq!(got, go, "{tier:?} length {n} fill {fill}");
                }
            }
        }
    }
}

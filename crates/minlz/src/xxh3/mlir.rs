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

//! The stripe loop written once in MLIR (`crates/minlz/mlir/xxh3.mlir`) and lowered by
//! `cargo xtask mlir` for each target into the assembly in `mlir/`, which the naked functions
//! below hold: NEON, base SVE at 128 and 256 bits, and SVE2 at 128 bits, on aarch64; SSE2, AVX2 and
//! AVX-512 on x86-64.
//!
//! A kernel takes `(acc, p, len, keys)` for [`accum`] or `(acc, p, n, keys)` for [`blocks`] and
//! works on the 8 lanes at acc, with keys pointing at [`KEYS`]. An SVE kernel
//! is only correct, and only stays inside its arguments, at its own vector length. [`accum`] and
//! [`blocks`] read the vector length on every call and run the NEON kernel at any other length,
//! so a thread that changes its vector length still hashes correctly.

use super::{BLOCK, KEYS, STRIPE};
use crate::cpu;

/// The targets with MLIR kernels.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(super) enum Isa {
    #[cfg(target_arch = "aarch64")]
    Neon,
    /// SVE with 128-bit or 256-bit vectors.
    #[cfg(target_arch = "aarch64")]
    Sve,
    /// SVE2 with 128-bit vectors.
    #[cfg(target_arch = "aarch64")]
    Sve2,
    #[cfg(target_arch = "x86_64")]
    Sse2,
    #[cfg(target_arch = "x86_64")]
    Avx2,
    #[cfg(target_arch = "x86_64")]
    Avx512,
}

#[cfg(target_arch = "aarch64")]
type Kernel = unsafe extern "C" fn(*mut u64, *const u8, usize, *const u8);
#[cfg(target_arch = "x86_64")]
type Kernel = unsafe extern "sysv64" fn(*mut u64, *const u8, usize, *const u8);

/// Declares the accum and blocks kernels in `mlir/$dir/`, with the assembler directive `$pre` in
/// front of the code.
macro_rules! kernels {
    ($($pre:literal,)? $accum:ident, $blocks:ident, $dir:literal) => {
        mlir_kernel!(
            $($pre,)? $accum(acc: *mut u64, p: *const u8, len: usize, keys: *const u8),
            concat!("mlir/", $dir, "/accum.s")
        );
        mlir_kernel!(
            $($pre,)? $blocks(acc: *mut u64, p: *const u8, n: usize, keys: *const u8),
            concat!("mlir/", $dir, "/blocks.s")
        );
    };
}

#[cfg(target_arch = "aarch64")]
kernels!(accum_neon, blocks_neon, "neon");
#[cfg(target_arch = "aarch64")]
kernels!(".arch_extension sve", accum_sve128, blocks_sve128, "sve128");
#[cfg(target_arch = "aarch64")]
kernels!(".arch_extension sve", accum_sve256, blocks_sve256, "sve256");
#[cfg(target_arch = "aarch64")]
kernels!(".arch_extension sve2", accum_sve2, blocks_sve2, "sve2");
#[cfg(target_arch = "x86_64")]
kernels!(accum_sse2, blocks_sse2, "sse2");
#[cfg(target_arch = "x86_64")]
kernels!(accum_avx2, blocks_avx2, "avx2");
#[cfg(target_arch = "x86_64")]
kernels!(accum_avx512, blocks_avx512, "avx512");

impl Isa {
    /// Returns the targets the CPU has, slowest first. Base SVE ranks below NEON: base SVE
    /// multiplies only 64-bit lanes, while NEON's `umlal` multiplies 32-bit halves into 64 bits,
    /// and the SVE kernels took about twice the cycles of NEON on every core measured or modeled.
    /// The SVE2 tier builds the NEON kernels with SVE2 on, where LLVM takes `eor3` and a 64-bit
    /// `mul` for some fixed 128-bit operations, and ranks above NEON. The tests run every tier.
    /// A tier whose instruction set [`cpu::disable`] has turned off is left out: the `AVX2` bit
    /// gates the AVX2 tier, the `AVX512` bit the AVX-512 tier, the `NEON` bit the NEON and SVE
    /// tiers, and the `SVE2` bit the SVE2 tier.
    pub(super) fn available() -> Vec<Isa> {
        let mut v = Vec::new();
        #[cfg(target_arch = "x86_64")]
        {
            v.push(Isa::Sse2);
            if std::is_x86_feature_detected!("avx2") && !cpu::is_disabled(cpu::AVX2) {
                v.push(Isa::Avx2);
                if std::is_x86_feature_detected!("avx512f") && !cpu::is_disabled(cpu::AVX512) {
                    v.push(Isa::Avx512);
                }
            }
        }
        #[cfg(target_arch = "aarch64")]
        {
            if !cpu::is_disabled(cpu::NEON) {
                if sve_available() {
                    v.push(Isa::Sve);
                }
                v.push(Isa::Neon);
            }
            if sve2_available() && !cpu::is_disabled(cpu::SVE2) {
                v.push(Isa::Sve2);
            }
        }
        v
    }

    /// Returns the (accum, blocks) kernels to run now.
    ///
    /// # Safety
    ///
    /// The CPU has the features of self.
    unsafe fn kernels(self) -> (Kernel, Kernel) {
        match self {
            #[cfg(target_arch = "aarch64")]
            Isa::Neon => (accum_neon, blocks_neon),
            #[cfg(target_arch = "aarch64")]
            Isa::Sve => {
                // SAFETY: the caller checked SVE.
                sve_kernels(unsafe { vl_bytes() }).unwrap_or((accum_neon, blocks_neon))
            }
            #[cfg(target_arch = "aarch64")]
            Isa::Sve2 => {
                // SAFETY: the caller checked SVE2.
                sve2_kernels(unsafe { vl_bytes() }).unwrap_or((accum_neon, blocks_neon))
            }
            #[cfg(target_arch = "x86_64")]
            Isa::Sse2 => (accum_sse2, blocks_sse2),
            #[cfg(target_arch = "x86_64")]
            Isa::Avx2 => (accum_avx2, blocks_avx2),
            #[cfg(target_arch = "x86_64")]
            Isa::Avx512 => (accum_avx512, blocks_avx512),
        }
    }
}

/// Accumulates p, which is at least a stripe long, as the end of the input, on the kernels of isa.
///
/// # Safety
///
/// The CPU has the features of isa.
#[inline(never)]
pub(super) unsafe fn accum(isa: Isa, a: &mut [u64; 8], p: &[u8]) {
    debug_assert!(p.len() >= STRIPE);
    // SAFETY: the caller checked isa's features, and kernels() picked the SVE kernel of the
    // current vector length. The kernel reads the p.len() bytes of p and the rows of KEYS, and
    // reads and writes the 8 lanes of a.
    unsafe {
        let accum = isa.kernels().0;
        accum(a.as_mut_ptr(), p.as_ptr(), p.len(), KEYS.0.as_ptr().cast());
    }
}

/// Accumulates the first n blocks of p, which input follows, on the kernels of isa.
///
/// # Safety
///
/// The CPU has the features of isa.
#[inline(never)]
pub(super) unsafe fn blocks(isa: Isa, a: &mut [u64; 8], p: &[u8], n: usize) {
    let p = &p[..n * BLOCK];
    // SAFETY: as in accum; the kernel reads the n blocks of p.
    unsafe {
        let blocks = isa.kernels().1;
        blocks(a.as_mut_ptr(), p.as_ptr(), n, KEYS.0.as_ptr().cast());
    }
}

/// Reports whether the CPU has SVE with a vector length that has kernels.
#[cfg(target_arch = "aarch64")]
fn sve_available() -> bool {
    // SAFETY: vl_bytes runs only once SVE is detected.
    std::arch::is_aarch64_feature_detected!("sve") && sve_kernels(unsafe { vl_bytes() }).is_some()
}

/// Returns the (accum, blocks) SVE kernels for a vector length of vl bytes, if it has them.
#[cfg(target_arch = "aarch64")]
fn sve_kernels(vl: usize) -> Option<(Kernel, Kernel)> {
    match vl {
        16 => Some((accum_sve128, blocks_sve128)),
        32 => Some((accum_sve256, blocks_sve256)),
        _ => None,
    }
}

/// Reports whether the CPU has SVE2 with the one vector length the SVE2 kernels are correct at.
#[cfg(target_arch = "aarch64")]
fn sve2_available() -> bool {
    // SAFETY: vl_bytes runs only once SVE2 is detected, and SVE2 implies SVE.
    std::arch::is_aarch64_feature_detected!("sve2") && sve2_kernels(unsafe { vl_bytes() }).is_some()
}

/// Returns the (accum, blocks) SVE2 kernels for a vector length of vl bytes, if it has them. Every
/// SVE2 kernel holds the eight lanes in one vector each, so only a 16-byte vector length gives 8
/// lanes.
#[cfg(target_arch = "aarch64")]
fn sve2_kernels(vl: usize) -> Option<(Kernel, Kernel)> {
    match vl {
        16 => Some((accum_sve2, blocks_sve2)),
        _ => None,
    }
}

/// Returns the SVE vector length in bytes.
///
/// # Safety
///
/// The CPU has SVE.
#[cfg(target_arch = "aarch64")]
#[inline]
pub(crate) unsafe fn vl_bytes() -> usize {
    let n: usize;
    // SAFETY: the caller checked SVE. The asm is not `pure`: the vector length can change between
    // calls, so the compiler must not merge two reads.
    unsafe {
        core::arch::asm!(
            ".arch_extension sve",
            "rdvl {n}, #1",
            n = out(reg) n,
            options(nomem, nostack, preserves_flags)
        );
    }
    n
}

#[cfg(test)]
mod tests {
    use super::Isa;
    use crate::cpu;

    /// A tier whose instruction set is disabled is not in available(): the bit of each of this
    /// family's tiers, held on its own, drops that tier.
    #[test]
    fn disabled_bit_drops_its_tier() {
        #[cfg(target_arch = "x86_64")]
        {
            {
                let _d = cpu::Disabled::new(cpu::AVX512);
                assert!(!Isa::available().contains(&Isa::Avx512), "AVX512 held");
            }
            let _d = cpu::Disabled::new(cpu::AVX2);
            assert!(!Isa::available().contains(&Isa::Avx2), "AVX2 held");
        }
        #[cfg(target_arch = "aarch64")]
        {
            {
                let _d = cpu::Disabled::new(cpu::SVE2);
                assert!(!Isa::available().contains(&Isa::Sve2), "SVE2 held");
            }
            let _d = cpu::Disabled::new(cpu::NEON);
            let v = Isa::available();
            assert!(
                !v.contains(&Isa::Neon) && !v.contains(&Isa::Sve),
                "NEON held"
            );
        }
    }
}

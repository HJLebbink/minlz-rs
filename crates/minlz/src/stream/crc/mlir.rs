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

//! CRC32C written once in MLIR and lowered by `cargo xtask mlir` for each target into the assembly
//! in `mlir/`, which the naked functions below hold. Targets with a carry-less multiply fold with
//! it beside three CRC32-instruction chains (`crates/minlz/mlir/crc32c_fold.mlir`): PCLMULQDQ, and
//! VPCLMULQDQ on 256 and 512 bits, on x86-64, and PMULL on aarch64. Targets with the CRC32
//! instruction alone run three chains (`crates/minlz/mlir/crc32c_chains.mlir`): SSE 4.2 on x86-64
//! and the CRC extension on aarch64.
//!
//! A kernel takes `(state, p, n)` for any n and returns the CRC state after the n bytes at p, the
//! state being the CRC without its final inversion.

use super::CrcFn;

/// The targets with a kernel.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(super) enum Isa {
    /// SSE 4.2's CRC32 alone.
    #[cfg(target_arch = "x86_64")]
    Sse42,
    /// PCLMULQDQ on 128-bit vectors.
    #[cfg(target_arch = "x86_64")]
    Pclmul,
    /// VPCLMULQDQ on 256-bit vectors.
    #[cfg(target_arch = "x86_64")]
    Avx2,
    /// VPCLMULQDQ on 512-bit vectors.
    #[cfg(target_arch = "x86_64")]
    Avx512,
    /// The CRC extension alone.
    #[cfg(target_arch = "aarch64")]
    Crc,
    /// PMULL from the AES extension.
    #[cfg(target_arch = "aarch64")]
    Neon,
}

#[cfg(target_arch = "x86_64")]
type Kernel = unsafe extern "sysv64" fn(u32, *const u8, usize) -> u32;
#[cfg(target_arch = "aarch64")]
type Kernel = unsafe extern "C" fn(u32, *const u8, usize) -> u32;

/// Declares the kernel in `mlir/$dir/`, with the assembler directives `$pre` in front of the code.
macro_rules! kernel {
    ($($pre:literal,)? $name:ident, $dir:literal) => {
        mlir_kernel!(
            $($pre,)? $name(state: u32, p: *const u8, n: usize) -> u32,
            concat!("mlir/", $dir, "/update.s")
        );
    };
}

#[cfg(target_arch = "x86_64")]
kernel!(update_sse42, "sse42");
#[cfg(target_arch = "x86_64")]
kernel!(update_pclmul, "pclmul");
#[cfg(target_arch = "x86_64")]
kernel!(update_avx2, "avx2");
#[cfg(target_arch = "x86_64")]
kernel!(update_avx512, "avx512");
#[cfg(target_arch = "aarch64")]
kernel!(".arch_extension crc", update_crc, "crc");
#[cfg(target_arch = "aarch64")]
kernel!(
    ".arch_extension aes\n.arch_extension crc",
    update_neon,
    "neon"
);

impl Isa {
    /// Returns the targets the CPU has, slowest first.
    pub(super) fn available() -> Vec<Isa> {
        let mut v = Vec::new();
        #[cfg(target_arch = "x86_64")]
        {
            use std::arch::is_x86_feature_detected as has;
            if has!("sse4.2") {
                v.push(Isa::Sse42);
                if has!("pclmulqdq") {
                    v.push(Isa::Pclmul);
                    if has!("vpclmulqdq") && has!("avx2") {
                        v.push(Isa::Avx2);
                    }
                    if has!("vpclmulqdq") && has!("avx512f") {
                        v.push(Isa::Avx512);
                    }
                }
            }
        }
        #[cfg(target_arch = "aarch64")]
        {
            use std::arch::is_aarch64_feature_detected as has;
            if has!("crc") {
                v.push(Isa::Crc);
                if has!("aes") {
                    v.push(Isa::Neon);
                }
            }
        }
        v
    }

    fn kernel(self) -> Kernel {
        match self {
            #[cfg(target_arch = "x86_64")]
            Isa::Sse42 => update_sse42,
            #[cfg(target_arch = "x86_64")]
            Isa::Pclmul => update_pclmul,
            #[cfg(target_arch = "x86_64")]
            Isa::Avx2 => update_avx2,
            #[cfg(target_arch = "x86_64")]
            Isa::Avx512 => update_avx512,
            #[cfg(target_arch = "aarch64")]
            Isa::Crc => update_crc,
            #[cfg(target_arch = "aarch64")]
            Isa::Neon => update_neon,
        }
    }
}

/// Returns the update of the fastest target the CPU has, if it has one. Each update is a function
/// of its own that only calls a kernel: the boundary that [`mlir_kernel`] asks for.
pub(super) fn best() -> Option<CrcFn> {
    let isa = *Isa::available().last()?;
    // SAFETY (every arm): Isa::available checked isa's features.
    let f: CrcFn = match isa {
        #[cfg(target_arch = "x86_64")]
        Isa::Sse42 => |c, d| unsafe { update(Isa::Sse42, c, d) },
        #[cfg(target_arch = "x86_64")]
        Isa::Pclmul => |c, d| unsafe { update(Isa::Pclmul, c, d) },
        #[cfg(target_arch = "x86_64")]
        Isa::Avx2 => |c, d| unsafe { update(Isa::Avx2, c, d) },
        #[cfg(target_arch = "x86_64")]
        Isa::Avx512 => |c, d| unsafe { update(Isa::Avx512, c, d) },
        #[cfg(target_arch = "aarch64")]
        Isa::Crc => |c, d| unsafe { update(Isa::Crc, c, d) },
        #[cfg(target_arch = "aarch64")]
        Isa::Neon => |c, d| unsafe { update(Isa::Neon, c, d) },
    };
    Some(f)
}

/// Continues the CRC32C crc with data, as [`super::crc32c_update`] does.
///
/// # Safety
///
/// The CPU has the features of isa.
#[inline]
pub(super) unsafe fn update(isa: Isa, crc: u32, data: &[u8]) -> u32 {
    // SAFETY: the caller checked isa's features; the kernel reads the bytes of data.
    !unsafe { isa.kernel()(!crc, data.as_ptr(), data.len()) }
}

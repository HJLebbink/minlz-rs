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

//! CRC32C by folding with carry-less multiplies beside three CRC32-instruction chains, written
//! once in MLIR (`crates/minlz/mlir/crc32c.mlir`) and lowered by `cargo xtask mlir` for each
//! target into the assembly in `mlir/`, which the naked functions below hold: PCLMULQDQ, and
//! VPCLMULQDQ on 256 and 512 bits, on x86-64, and PMULL on aarch64.
//!
//! A kernel takes `(state, p, n)` and returns the CRC state after the n bytes at p, the state
//! being the CRC without its final inversion. n is a whole number of [`Isa::stride`] bytes, at
//! least one. [`update`] runs the kernel on the whole strides of its input and the CRC32
//! instruction on the rest.

use super::CrcFn;

/// The targets with a folding kernel.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(super) enum Isa {
    /// PCLMULQDQ on 128-bit vectors, with SSE 4.2 for the tail.
    #[cfg(target_arch = "x86_64")]
    Pclmul,
    /// VPCLMULQDQ on 256-bit vectors.
    #[cfg(target_arch = "x86_64")]
    Avx2,
    /// VPCLMULQDQ on 512-bit vectors.
    #[cfg(target_arch = "x86_64")]
    Avx512,
    /// PMULL, with the CRC extension for the tail.
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
            concat!("mlir/", $dir, "/fold.s")
        );
    };
}

#[cfg(target_arch = "x86_64")]
kernel!(fold_pclmul, "pclmul");
#[cfg(target_arch = "x86_64")]
kernel!(fold_avx2, "avx2");
#[cfg(target_arch = "x86_64")]
kernel!(fold_avx512, "avx512");
#[cfg(target_arch = "aarch64")]
kernel!(
    ".arch_extension aes\n.arch_extension crc",
    fold_neon,
    "neon"
);

impl Isa {
    /// Returns the targets the CPU has, slowest first.
    pub(super) fn available() -> Vec<Isa> {
        let mut v = Vec::new();
        #[cfg(target_arch = "x86_64")]
        {
            use std::arch::is_x86_feature_detected as has;
            if has!("sse4.2") && has!("pclmulqdq") {
                v.push(Isa::Pclmul);
                if has!("vpclmulqdq") && has!("avx2") {
                    v.push(Isa::Avx2);
                }
                if has!("vpclmulqdq") && has!("avx512f") {
                    v.push(Isa::Avx512);
                }
            }
        }
        #[cfg(target_arch = "aarch64")]
        {
            use std::arch::is_aarch64_feature_detected as has;
            if has!("crc") && has!("aes") {
                v.push(Isa::Neon);
            }
        }
        v
    }

    /// Returns the bytes that one fold of the kernel takes.
    fn stride(self) -> usize {
        match self {
            #[cfg(target_arch = "x86_64")]
            Isa::Avx512 => 256,
            _ => 128,
        }
    }

    /// Returns the shortest input that [`update`] gives the kernel; the CRC32 instruction alone
    /// takes shorter ones. Below it, combining the lanes and reducing them costs more than folding
    /// saves. With PMULL it is also a whole block: Neoverse N-class cores multiply on one pipe,
    /// so folding alone is no faster there than CRC32, and only the block's CRC32 chains gain.
    fn min_len(self) -> usize {
        match self {
            #[cfg(target_arch = "x86_64")]
            Isa::Avx2 | Isa::Avx512 => 1024,
            _ => 2048,
        }
    }

    fn kernel(self) -> Kernel {
        match self {
            #[cfg(target_arch = "x86_64")]
            Isa::Pclmul => fold_pclmul,
            #[cfg(target_arch = "x86_64")]
            Isa::Avx2 => fold_avx2,
            #[cfg(target_arch = "x86_64")]
            Isa::Avx512 => fold_avx512,
            #[cfg(target_arch = "aarch64")]
            Isa::Neon => fold_neon,
        }
    }
}

/// Returns the update of the fastest target the CPU has, if it has one.
pub(super) fn best() -> Option<CrcFn> {
    let isa = *Isa::available().last()?;
    // SAFETY (every arm): Isa::available checked isa's features.
    let f: CrcFn = match isa {
        #[cfg(target_arch = "x86_64")]
        Isa::Pclmul => |c, d| unsafe { update(Isa::Pclmul, c, d) },
        #[cfg(target_arch = "x86_64")]
        Isa::Avx2 => |c, d| unsafe { update(Isa::Avx2, c, d) },
        #[cfg(target_arch = "x86_64")]
        Isa::Avx512 => |c, d| unsafe { update(Isa::Avx512, c, d) },
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
pub(super) unsafe fn update(isa: Isa, crc: u32, data: &[u8]) -> u32 {
    let stride = isa.stride();
    if data.len() < isa.min_len() {
        // SAFETY: the caller checked isa's features, which include the CRC32 instruction.
        return unsafe { tail(crc, data) };
    }
    let n = data.len() - data.len() % stride;
    // SAFETY: the caller checked isa's features; the kernel reads the n bytes of data.
    let state = unsafe { isa.kernel()(!crc, data.as_ptr(), n) };
    // SAFETY: as above.
    unsafe { tail(!state, &data[n..]) }
}

/// The CRC32 instruction's update.
///
/// # Safety
///
/// The CPU has the CRC32 instruction.
#[inline]
unsafe fn tail(crc: u32, data: &[u8]) -> u32 {
    // SAFETY: the caller checked the CRC32 instruction.
    #[cfg(target_arch = "x86_64")]
    return unsafe { super::crc32c_hw_x86_64(crc, data) };
    // SAFETY: the caller checked the CRC32 instruction.
    #[cfg(target_arch = "aarch64")]
    return unsafe { super::crc32c_hw_aarch64(crc, data) };
}

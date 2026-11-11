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

//! The pivco decoder, written once in MLIR (`crates/minlz/mlir/pivco.mlir`) and lowered by
//! `cargo xtask mlir` for each target into the assembly in `mlir/`, which the naked functions
//! below hold: AVX2 and AVX-512 on x86-64, NEON on aarch64.
//!
//! [`exec`] runs a whole [`Program`] in one call, so an op costs a dispatch, not a call. The
//! kernel checks each op as the generic tier does before it runs it. Its reads of the input and
//! its writes are exact; its merges load 64 bytes at the cursors of the children, which stay
//! inside the op's K bytes, so they read at most 63 bytes past them ([`ARENA_SLACK`]); and its
//! flats read 64 bytes of R2S at the first rank, and 128 or 256 for depths 7 and 8, which the
//! checks bound.

use super::{ARENA_SLACK, Op, Program, R2S_LEN};

const _: () = assert!(ARENA_SLACK >= 63 && R2S_LEN >= 255 + 64);

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

/// The merge table of the AVX2 and NEON kernels. For the 16 bitmap bits m0 | m1 << 8 of 16
/// outputs, `merge[0][m0] + merge[1][m1]` is the index of each output: a right output holds its
/// place among the right values, a left output 255 less its place among the left ones. Row m0
/// holds popcount(m0) in bytes 8 to 15, where the outputs of m1 start.
#[repr(C, align(64))]
struct Tables {
    merge: [[[u8; 16]; 256]; 2],
}

static TABLES: Tables = Tables {
    merge: merge_tabs(),
};

const fn merge_tabs() -> [[[u8; 16]; 256]; 2] {
    let mut t = [[[0u8; 16]; 256]; 2];
    let mut m = 0;
    while m < 256 {
        let pop = (m as u32).count_ones() as u8;
        let (mut rs, mut ls) = (0u8, 0u8);
        let mut i = 0;
        while i < 8 {
            if m >> i & 1 != 0 {
                (t[0][m][i], rs) = (rs, rs + 1);
            } else {
                (t[0][m][i], ls) = (255 - ls, ls + 1);
            }
            t[0][m][8 + i] = pop;
            i += 1;
        }
        // The outputs of m1 follow pop right and 8 - pop left values; 247 - ls adds up with
        // pop to 255 less the place 8 - pop + ls.
        (rs, ls) = (0, 0);
        i = 0;
        while i < 8 {
            if m >> i & 1 != 0 {
                (t[1][m][8 + i], rs) = (rs, rs + 1);
            } else {
                (t[1][m][8 + i], ls) = (247 - ls, ls + 1);
            }
            i += 1;
        }
        m += 1;
    }
    t
}

/// The arguments of a kernel, in the layout `minlz_pivco_exec` in `pivco.mlir` reads.
#[repr(C, align(64))]
struct Exec {
    ops: *const Op,
    nops: usize,
    input: *const u8,
    ilen: usize,
    arena: *mut u8,
    /// The arena's length less [`ARENA_SLACK`], or 0.
    alim: usize,
    dst: *mut u8,
    dlen: usize,
    r2s: *const u8,
    /// [`R2S_LEN`], or 0 without R2S.
    r2s_len: usize,
    tab: *const Tables,
    _pad: [usize; 5],
    /// The scratch of the kernel, at byte 128.
    scratch: [u8; 64],
}

#[cfg(target_arch = "x86_64")]
type Kernel = unsafe extern "sysv64" fn(*mut Exec) -> usize;
#[cfg(target_arch = "aarch64")]
type Kernel = unsafe extern "C" fn(*mut Exec) -> usize;

#[cfg(target_arch = "x86_64")]
mlir_kernel!(exec_avx2(a: *mut Exec) -> usize, "mlir/avx2/exec.s");
#[cfg(target_arch = "x86_64")]
mlir_kernel!(exec_avx512(a: *mut Exec) -> usize, "mlir/avx512/exec.s");
#[cfg(target_arch = "aarch64")]
mlir_kernel!(exec_neon(a: *mut Exec) -> usize, "mlir/neon/exec.s");

impl Isa {
    fn exec_kernel(self) -> Kernel {
        match self {
            #[cfg(target_arch = "x86_64")]
            Isa::Avx2 => exec_avx2,
            #[cfg(target_arch = "x86_64")]
            Isa::Avx512 => exec_avx512,
            #[cfg(target_arch = "aarch64")]
            Isa::Neon => exec_neon,
        }
    }
}

/// Runs `p.ops`; see [`super::Tier::exec`].
///
/// # Safety
///
/// The CPU has the features of isa's tier.
#[inline(never)]
pub(super) unsafe fn exec(isa: Isa, p: &mut Program<'_>) -> Result<(), usize> {
    let (r2s, r2s_len) = match p.r2s {
        Some(t) => (t.as_ptr(), R2S_LEN),
        None => (core::ptr::null(), 0),
    };
    let mut a = Exec {
        ops: p.ops.as_ptr(),
        nops: p.ops.len(),
        input: p.input.as_ptr(),
        ilen: p.input.len(),
        arena: p.arena.as_mut_ptr(),
        alim: p.arena.len().saturating_sub(ARENA_SLACK),
        dst: p.dst.as_mut_ptr(),
        dlen: p.dst.len(),
        r2s,
        r2s_len,
        tab: &TABLES,
        _pad: [0; 5],
        scratch: [0; 64],
    };
    // SAFETY: the caller checked the features. The kernel checks each op against the lengths
    // above before it runs it, and its accesses stay inside them, the arena's slack and R2S.
    let n = unsafe { isa.exec_kernel()(&mut a) };
    if n == p.ops.len() { Ok(()) } else { Err(n) }
}

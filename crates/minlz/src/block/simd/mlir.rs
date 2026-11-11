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

//! The stream checks and the operation loops of chunks, written once in MLIR
//! (`crates/minlz/mlir/stats.mlir` and `exec.mlir`) and lowered by `cargo xtask mlir` for each
//! target into the assembly in `mlir/`, which the naked functions below hold: AVX2 and AVX-512 on
//! x86-64, NEON on aarch64.
//!
//! A stream check takes `(p, n, r)`: n bytes at p, a multiple of 64, and r, where it writes its
//! sums. It returns 0 if every byte is in range. [`tok`], [`ll`] and [`off`] give it the whole
//! 64-byte chunks of a stream; `tok_stats`, `ll_stats` and `off_stats` of the decoder take the
//! rest.
//!
//! An operation loop takes an [`Exec`], runs its operations and writes the state back. [`exec`]
//! picks the loop for chunks with delta literals or the no-overlap flag.

use super::{MAX_LEN, OFF_TAB};

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

/// The tables of the operation loops (see `crates/minlz/mlir/exec.mlir`).
#[repr(C, align(64))]
struct Tables {
    /// Per offset symbol: the mask of its raw bits in bits 0 to 31, their number in bits 32 to
    /// 39 and the base offset in bits 40 to 63. Symbol 0 is all zero.
    off: [u64; 256],
    /// Byte i of row r is i % r for r from 2 to 31, 0 for rows 0 and 1, and i for rows 32 and up:
    /// the indexes that repeat the bytes before an offset r. A delta reference at position 0
    /// repeats `dst[0]`.
    rows: [[u8; 32]; 64],
}

static TABLES: Tables = {
    let mut off = [0u64; 256];
    let mut s = 1;
    while s < 256 {
        let (v, nb) = (OFF_TAB[s] as u64, OFF_TAB[s] as u64 >> 24);
        off[s] = ((1 << nb) - 1) | nb << 32 | (v & 0xffffff) << 40;
        s += 1;
    }
    let mut rows = [[0u8; 32]; 64];
    let mut r = 2;
    while r < 64 {
        let mut i = 0;
        while i < 32 {
            rows[r][i] = if r < MAX_LEN { i % r } else { i } as u8;
            i += 1;
        }
        r += 1;
    }
    Tables { off, rows }
};

/// The arguments of an operation loop: n operations from the streams tok, ll, offc and esc, and
/// from bit pos of raw, as [`exec_go`](super::exec::exec_go) and
/// [`exec_flat_go`](super::exec::exec_flat_go) run them. st holds the output position, the
/// literal position, the repeat offset and an error flag, which the loop writes back. raw is
/// readable for nraw bytes. The loop keeps its stream positions and a batch of operations in the
/// rest.
#[repr(C, align(64))]
pub(super) struct Exec {
    dst: *mut u8,
    lits: *const u8,
    tok: *const u8,
    ll: *const u8,
    offc: *const u8,
    raw: *const u8,
    esc: *const u8,
    tab: *const Tables,
    n: usize,
    pos: usize,
    pub(super) st: [usize; 4],
    nraw: usize,
    escapes: usize,
    cursors: [usize; 8],
    batch: [u64; 56],
}

impl Exec {
    /// Returns the arguments of n operations from the streams, from bit pos of raw, which is
    /// readable for nraw bytes.
    pub(super) fn new(
        dst: *mut u8,
        lits: *const u8,
        [tok, ll, offc, raw, esc]: [*const u8; 5],
        nraw: usize,
        n: usize,
        pos: usize,
        st: [usize; 4],
    ) -> Exec {
        Exec {
            dst,
            lits,
            tok,
            ll,
            offc,
            raw,
            esc,
            tab: &TABLES,
            n,
            pos,
            st,
            nraw,
            escapes: 0,
            cursors: [0; 8],
            batch: [0; 56],
        }
    }
}

#[cfg(target_arch = "x86_64")]
type ExecKernel = unsafe extern "sysv64" fn(*mut Exec);
#[cfg(target_arch = "aarch64")]
type ExecKernel = unsafe extern "C" fn(*mut Exec);

/// Declares the operation loops in `mlir/$dir/exec/`: plain, with delta literals, with the
/// no-overlap flag, and with both.
macro_rules! exec_kernels {
    ($plain:ident, $delta:ident, $flat:ident, $flat_delta:ident, $dir:literal) => {
        mlir_kernel!(
            $plain(a: *mut Exec),
            concat!("mlir/", $dir, "/exec/plain.s")
        );
        mlir_kernel!(
            $delta(a: *mut Exec),
            concat!("mlir/", $dir, "/exec/delta.s")
        );
        mlir_kernel!($flat(a: *mut Exec), concat!("mlir/", $dir, "/exec/flat.s"));
        mlir_kernel!(
            $flat_delta(a: *mut Exec),
            concat!("mlir/", $dir, "/exec/flat_delta.s")
        );
    };
}

#[cfg(target_arch = "x86_64")]
exec_kernels!(
    exec_avx2,
    exec_delta_avx2,
    exec_flat_avx2,
    exec_flat_delta_avx2,
    "avx2"
);
#[cfg(target_arch = "x86_64")]
exec_kernels!(
    exec_avx512,
    exec_delta_avx512,
    exec_flat_avx512,
    exec_flat_delta_avx512,
    "avx512"
);
#[cfg(target_arch = "aarch64")]
exec_kernels!(
    exec_neon,
    exec_delta_neon,
    exec_flat_neon,
    exec_flat_delta_neon,
    "neon"
);

impl Isa {
    /// Returns the operation loops: plain, with delta literals, with the no-overlap flag, and
    /// with both.
    fn exec_kernels(self) -> [ExecKernel; 4] {
        match self {
            #[cfg(target_arch = "x86_64")]
            Isa::Avx2 => [
                exec_avx2,
                exec_delta_avx2,
                exec_flat_avx2,
                exec_flat_delta_avx2,
            ],
            #[cfg(target_arch = "x86_64")]
            Isa::Avx512 => [
                exec_avx512,
                exec_delta_avx512,
                exec_flat_avx512,
                exec_flat_delta_avx512,
            ],
            #[cfg(target_arch = "aarch64")]
            Isa::Neon => [
                exec_neon,
                exec_delta_neon,
                exec_flat_neon,
                exec_flat_delta_neon,
            ],
        }
    }
}

/// Runs the operations of a with the loop of isa for chunks with delta literals and with the
/// no-overlap flag, as delta and flat say.
///
/// # Safety
///
/// The CPU has the features of isa, and a's pointers and counts keep the
/// [memory rules](super::exec) for its operations.
#[inline(never)]
pub(super) unsafe fn exec(isa: Isa, delta: bool, flat: bool, a: &mut Exec) {
    let kernel = isa.exec_kernels()[2 * usize::from(flat) + usize::from(delta)];
    // SAFETY: the caller's.
    unsafe { kernel(a) }
}

#[cfg(test)]
mod tests {
    use super::super::decode::{ll_stats, off_stats, tok_stats};
    use super::super::decode_tests::Rng;
    use super::super::exec::Tier;
    use super::{MAX_LEN, OFF_TAB, TABLES};

    /// The offset table decodes each symbol as OFF_TAB does, symbol 0 to offset 0, and row r
    /// repeats the bytes before an offset r, row 0 as row 1.
    #[test]
    fn exec_tables() {
        assert_eq!(TABLES.off[0], 0);
        for (s, &e) in TABLES.off.iter().enumerate().skip(1) {
            let nb = OFF_TAB[s] >> 24;
            assert_eq!(
                (e >> 40, (e >> 32) as u8 as u32, e as u32),
                (u64::from(OFF_TAB[s] & 0xffffff), nb, (1 << nb) - 1),
                "symbol {s}"
            );
        }
        for (r, row) in TABLES.rows.iter().enumerate() {
            for (i, &v) in row.iter().enumerate() {
                let want = if r < MAX_LEN { i % r.max(1) } else { i };
                assert_eq!(usize::from(v), want, "row {r} byte {i}");
            }
        }
    }

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

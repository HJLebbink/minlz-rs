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

//! Iguana **match finder** — port of Go `bestMatchAVX512` (`match_amd64.s`) plus
//! its scalar reference (`encoder.go` `match`/`bestMatch`).
//!
//! Given a target position `pos` and up to [`HISTSIZE`] candidate match
//! positions (a hash chain), it returns the [`Match`] (`target`, `pos`, `len`)
//! of the longest *legal* match (offset < 2¹⁶, or matchlen > 15), extending each
//! candidate forward (SIMD) and backward (bytewise). An all-zero `Match` means no
//! legal match. The AVX-512 kernel and the scalar oracle are differential-tested.

/// Hash-chain depth (Go `histsize`).
pub(crate) const HISTSIZE: usize = 4;

/// A located match: `len` bytes at uncompressed position `target`, copied from
/// `pos` (so the offset is `target - pos`). All-zero means "no legal match".
#[derive(Clone, Copy, Default, Debug, PartialEq, Eq)]
pub(crate) struct Match {
    pub target: i32,
    pub pos: i32,
    pub len: i32,
}

/// Scalar reference, mirroring `bestMatchAVX512` exactly (so it is both the
/// fallback and the kernel's differential oracle). Caller guarantees
/// `src.len() - pos >= 32` and every `hist[i]` in `0..pos`.
pub(crate) fn best_match_scalar(
    src: &[u8],
    litmin: i32,
    pos: i32,
    hist: &[i32; HISTSIZE],
) -> Match {
    let n = src.len() as i32;
    let max_ml = n - pos; // == max match length (caller guarantees >= 32)
    let (mut bt, mut bp, mut bl) = (0i32, 0i32, 0i32);

    for (i, &cand) in hist.iter().enumerate() {
        let mut matchpos = cand;
        // Candidate 0 is always evaluated; a 0 in a later slot means "empty".
        if i > 0 && matchpos == 0 {
            break;
        }
        let mut targetpos = pos;

        // Forward: longest common prefix of src[matchpos..] and src[pos..],
        // capped at max_ml (the SIMD path computes the same value).
        let mut ml = 0i32;
        while ml < max_ml && src[(matchpos + ml) as usize] == src[(targetpos + ml) as usize] {
            ml += 1;
        }

        // Backward: extend while the preceding bytes match and we stay above
        // litmin / position 0 (faithful to the asm loop ordering).
        if matchpos != 0 {
            loop {
                if targetpos == litmin {
                    break;
                }
                if src[(matchpos - 1) as usize] != src[(targetpos - 1) as usize] {
                    break;
                }
                targetpos -= 1;
                ml += 1;
                matchpos -= 1;
                if matchpos == 0 {
                    break;
                }
            }
        }

        // Legality: a >=2^16 offset is only allowed for matches longer than 15.
        let offset = targetpos - matchpos;
        let legal = (offset >> 16) == 0 || ml > 15;
        if legal && ml > bl {
            bt = targetpos;
            bp = matchpos;
            bl = ml;
        }
    }
    Match {
        target: bt,
        pos: bp,
        len: bl,
    }
}

#[cfg(any(iguana_asm, iguana_sve2))]
#[repr(C)]
struct MatchArgs {
    src_base: *const u8,
    src_len: usize,
    src_cap: usize,
    litmin: i32,
    pos: i32,
    hist: *const i32,
    ret_targetpos: i32,
    ret_matchpos: i32,
    ret_matchlen: i32,
}

#[cfg(iguana_asm)]
unsafe extern "C" {
    fn iguana_avx512_best_match(args: *mut MatchArgs);
}

#[cfg(iguana_sve2)]
unsafe extern "C" {
    fn iguana_sve2_best_match(args: *mut MatchArgs);
}

/// The kernel uses 256-bit AVX-512 (`vpxord`/`vptestmb` on ymm + `ktestd`):
/// needs F, BW, VL, and DQ (`ktestd`).
#[cfg(iguana_asm)]
pub(crate) fn best_match_avx512_available() -> bool {
    std::is_x86_feature_detected!("avx512f")
        && std::is_x86_feature_detected!("avx512bw")
        && std::is_x86_feature_detected!("avx512vl")
        && std::is_x86_feature_detected!("avx512dq")
}

/// AVX-512 match finder. Same result as [`best_match_scalar`]. Caller guarantees
/// `src.len() - pos >= 32` and `hist[i]` in `0..pos`.
#[cfg(iguana_asm)]
pub(crate) fn best_match_avx512(
    src: &[u8],
    litmin: i32,
    pos: i32,
    hist: &[i32; HISTSIZE],
) -> Match {
    let mut args = MatchArgs {
        src_base: src.as_ptr(),
        src_len: src.len(),
        src_cap: src.len(),
        litmin,
        pos,
        hist: hist.as_ptr(),
        ret_targetpos: 0,
        ret_matchpos: 0,
        ret_matchlen: 0,
    };
    // SAFETY: src is a readable slice >= pos+32 bytes; hist is 4 i32s; the kernel
    // reads only within those ranges and writes only its three return fields.
    unsafe { iguana_avx512_best_match(&mut args) };
    Match {
        target: args.ret_targetpos,
        pos: args.ret_matchpos,
        len: args.ret_matchlen,
    }
}

/// SVE2 match finder (`asm/match_sve2.S`). Same result as [`best_match_scalar`].
/// Caller guarantees `src.len() - pos >= 32` and `hist[i]` in `0..pos`.
#[cfg(iguana_sve2)]
pub(crate) fn best_match_sve2(
    src: &[u8],
    litmin: i32,
    pos: i32,
    hist: &[i32; HISTSIZE],
) -> Match {
    let mut args = MatchArgs {
        src_base: src.as_ptr(),
        src_len: src.len(),
        src_cap: src.len(),
        litmin,
        pos,
        hist: hist.as_ptr(),
        ret_targetpos: 0,
        ret_matchpos: 0,
        ret_matchlen: 0,
    };
    // SAFETY: src is a readable slice >= pos+32 bytes; hist is 4 i32s; the kernel
    // reads only within those ranges (whilelt-bounded) and writes only its three
    // return fields.
    unsafe { iguana_sve2_best_match(&mut args) };
    Match {
        target: args.ret_targetpos,
        pos: args.ret_matchpos,
        len: args.ret_matchlen,
    }
}

/// Best legal match for `pos` over the hash chain `hist`: the SIMD kernel when
/// available (AVX-512 on x86-64, SVE2 on AArch64), scalar otherwise.
pub(crate) fn best_match(src: &[u8], litmin: i32, pos: i32, hist: &[i32; HISTSIZE]) -> Match {
    #[cfg(iguana_asm)]
    if best_match_avx512_available() {
        return best_match_avx512(src, litmin, pos, hist);
    }
    #[cfg(iguana_sve2)]
    if std::arch::is_aarch64_feature_detected!("sve2") {
        return best_match_sve2(src, litmin, pos, hist);
    }
    best_match_scalar(src, litmin, pos, hist)
}

#[cfg(all(test, any(iguana_asm, iguana_sve2)))]
mod tests {
    use super::*;

    // The kernel under test and its CPU-availability probe — AVX-512 on x86-64,
    // SVE2 on AArch64. The differential harness below is identical for both.
    #[cfg(iguana_asm)]
    use best_match_avx512 as kernel;
    #[cfg(iguana_asm)]
    use best_match_avx512_available as kernel_available;
    #[cfg(iguana_sve2)]
    use best_match_sve2 as kernel;
    #[cfg(iguana_sve2)]
    fn kernel_available() -> bool {
        std::arch::is_aarch64_feature_detected!("sve2")
    }

    // xorshift32 PRNG for deterministic fuzzing.
    struct Rng(u32);
    impl Rng {
        fn next(&mut self) -> u32 {
            let mut x = self.0;
            x ^= x << 13;
            x ^= x >> 17;
            x ^= x << 5;
            self.0 = x;
            x
        }
        fn below(&mut self, n: u32) -> u32 {
            if n == 0 { 0 } else { self.next() % n }
        }
    }

    fn check(src: &[u8], litmin: i32, pos: i32, hist: &[i32; HISTSIZE]) {
        if !kernel_available() {
            return;
        }
        let a = kernel(src, litmin, pos, hist);
        let s = best_match_scalar(src, litmin, pos, hist);
        assert_eq!(
            a,
            s,
            "kernel != scalar: len={} litmin={litmin} pos={pos} hist={hist:?}",
            src.len()
        );
    }

    #[test]
    fn diff_fuzz_small_alphabet() {
        // Small alphabet => frequent matches of varied length => exercises the
        // forward 32-byte loop, the byte-by-byte tail, and backward extension.
        let mut rng = Rng(0x9e3779b9);
        for _ in 0..20000 {
            let len = 64 + rng.below(4096) as usize;
            let alpha = 2 + rng.below(6); // 2..7 distinct symbols
            let src: Vec<u8> = (0..len).map(|_| (rng.below(alpha)) as u8).collect();
            let pos = rng.below((len - 32 + 1) as u32) as i32;
            if pos == 0 {
                continue; // need at least one earlier position
            }
            let litmin = rng.below(pos as u32 + 1) as i32;
            let mut hist = [0i32; HISTSIZE];
            for h in hist.iter_mut() {
                // ~25% empty slots, else a random earlier position.
                if rng.below(4) == 0 {
                    *h = 0;
                } else {
                    *h = rng.below(pos as u32) as i32;
                }
            }
            check(&src, litmin, pos, &hist);
        }
    }

    #[test]
    fn diff_large_offsets() {
        // src > 2^16 with a planted far-back match: exercises the legality gate
        // (offset >= 2^16 is illegal unless matchlen > 15), for both a short
        // (illegal) and a long (legal) planted match.
        for &(plant_len, _name) in &[(10usize, "short/illegal"), (40usize, "long/legal")] {
            let mut rng = Rng(0x1234_abcd ^ plant_len as u32);
            let len = 80_000usize;
            let mut src: Vec<u8> = (0..len).map(|_| (rng.below(3)) as u8).collect();
            let far = 1000usize; // candidate near the front
            let pos = far + 66_000; // offset ~66000 >= 2^16
            let pat: Vec<u8> = (0..plant_len).map(|i| 100 + (i % 20) as u8).collect();
            src[far..far + plant_len].copy_from_slice(&pat);
            src[pos..pos + plant_len].copy_from_slice(&pat);
            let hist = [far as i32, 0, 0, 0];
            check(&src, 0, pos as i32, &hist);
        }
    }

    #[test]
    fn diff_edge_cases() {
        // All-equal buffer (max-length overlapped match + backward extension).
        let src = vec![7u8; 5000];
        check(&src, 0, 1000, &[1, 0, 0, 0]);
        check(&src, 990, 1000, &[1, 500, 999, 0]);
        // Candidate at position 0.
        check(&src, 0, 100, &[0, 0, 0, 0]);
        // No earlier match (distinct tail).
        let mut s2 = vec![1u8; 2000];
        for (i, b) in s2.iter_mut().enumerate() {
            *b = (i % 251) as u8;
        }
        check(&s2, 0, 500, &[10, 20, 30, 40]);
    }
}

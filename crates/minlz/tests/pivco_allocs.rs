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

//! Ports of Go's pivco `TestAllocs` (`allocs_test.go`, `kernel/bench_test.go`): after
//! warmup, coding and the kernels must not allocate. A counting global allocator needs its
//! own test binary.

use minlz::pivco::kernel::{
    ARENA_SLACK, FLAG_DST, HIST_SCRATCH, OP_NAT, OP_VV, Op, Program, R2S_LEN, RANK_SLACK, Tier,
};
use minlz::pivco::{
    Decoder, Encoder, Error, MAX_BLOCK_SIZE, MAX_CODE_LEN, Table, build_lengths, kernel,
};

#[path = "../src/pivco/testutil.rs"]
mod testutil;

use testutil::*;

#[path = "support/alloc_count.rs"]
mod alloc_count;

use alloc_count::{assert_counter_counts, check_allocs};

#[test]
fn counter_counts() {
    assert_counter_counts();
}

#[test]
fn allocs() {
    let h = dist_of("english");
    let big = sample(&h, MAX_BLOCK_SIZE, 1);
    let small = sample(&h, 4096, 2);
    let mut tb = must_table(&lens_of(&h));
    for c in &mut coders() {
        let (enc, dec) = (&mut c.enc, &mut c.dec);
        let mut buf = vec![0u8; 2 * MAX_BLOCK_SIZE];
        let mut out = vec![0u8; MAX_BLOCK_SIZE];
        check_allocs("heap buffers", 20, || {
            let mut h = [0u64; 256];
            enc.histogram(&mut h, &big);
            let mut l = [0u8; 256];
            build_lengths(&h, &mut l);
            tb.set_lengths(&l).unwrap();
            let b = &mut buf[..tb.block_size(&h).unwrap()];
            enc.encode(b, &big, &tb).unwrap();
            dec.decode(&mut out, b, &tb).unwrap();
        });
        // Tables, histograms and buffers on the stack must stay there.
        check_allocs("stack locals", 20, || {
            let mut src = [0u8; 4096];
            src.copy_from_slice(&small);
            let mut h = [0u64; 256];
            enc.histogram(&mut h, &src);
            let mut l = [0u8; 256];
            build_lengths(&h, &mut l);
            let mut t1 = Table::default();
            t1.set_lengths(&l).unwrap();
            let mut enc1 = [0u8; 8192];
            let b = &mut enc1[..t1.block_size(&h).unwrap()];
            enc.encode(b, &src, &t1).unwrap();
            let mut dec1 = [0u8; 4096];
            dec.decode(&mut dec1, b, &t1).unwrap();
        });
        check_allocs("errors", 20, || {
            let mut t1 = Table::default();
            let mut d = [0u8; 64];
            assert!(enc.encode(&mut d, &small, &t1).is_err());
            assert!(enc.encode(&mut d, &[], &tb).is_err());
            let d3 = [0u8; 3];
            assert!(dec.decode(&mut d[..3], &d3, &tb).is_err());
            assert!(dec.decode(&mut d[..1], &[7], &tb).is_err());
            assert!(dec.decode(&mut [], &d, &tb).is_err());
            assert!(t1.set_lengths(&[0; 256]).is_err());
        });
    }
}

/// Keeps Program and the outputs as locals inside the measured function: none of the
/// kernels may allocate.
#[test]
fn kernel_allocs() {
    const N: usize = 4096;
    let mut rng = new_rng();
    let mut src = vec![0u8; N + RANK_SLACK];
    rand_bytes(&mut rng, &mut src);
    let codes: Vec<u8> = src.iter().map(|&c| c & 7).collect();
    let (bm, kr) = rand_bits(&mut rng, N, 0.5);
    let input = [&bm[..], &src[..]].concat();
    let mut arena = vec![0u8; 3 * N + ARENA_SLACK];
    let mut scratch = vec![0u8; HIST_SCRATCH];
    for tier in Tier::tiers() {
        check_allocs(&tier.to_string(), 20, || {
            let s2r = [0u8; 256];
            let r2s = [0u8; R2S_LEN];
            let (mut ranks, mut right) = ([0u8; N + RANK_SLACK], [0u8; N + RANK_SLACK]);
            let mut bmo = [0u8; N / 8 + RANK_SLACK];
            let mut h = [0u32; 256];
            tier.gather(&mut ranks, &src[..N], &s2r);
            tier.part_full(&mut ranks[..N], &mut right, &mut bmo, 100);
            tier.part_right(&ranks[..N], &mut right, &mut bmo, 100);
            tier.part_none(&ranks[..N], &mut bmo, 100);
            tier.pack(&mut right, &codes[..N], 3, 0);
            tier.histogram(&mut h, &src, &mut scratch);
            let mut dst = [0u8; N];
            let ops = [
                Op {
                    kind: OP_VV,
                    k: N as u32,
                    kr: kr as u32,
                    l: N as u32,
                    r: 2 * N as u32,
                    ..Op::default()
                },
                Op {
                    kind: OP_NAT,
                    d: 2,
                    k: N as u32,
                    bm: bm.len() as u32,
                    flags: FLAG_DST,
                    ..Op::default()
                },
            ];
            let mut p = Program {
                ops: &ops,
                input: &input,
                arena: &mut arena,
                dst: &mut dst,
                r2s: Some(&r2s),
            };
            assert_eq!(tier.exec(&mut p), Ok(()));
        });
    }
}

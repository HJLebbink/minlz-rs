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

//! Ports of Go's `neon_arm64_test.go`. The shared tests run [`Tier::Neon`] through
//! [`Tier::tiers`] and `vec_tiers`; these are NEON specific.

use super::*;
use crate::cpu;

#[test]
fn neon_selected() {
    let _d = cpu::Disabled::new(0);
    assert!(
        Tier::best() == Tier::Neon
            && Tier::tiers() == [Tier::Neon, Tier::Generic]
            && !Tier::Neon.hist_uses_scratch(),
        "best() = {}, tiers() = {:?}",
        Tier::best(),
        Tier::tiers()
    );
}

/// Decodes every flat size up to 1100 at every depth, split as the planner does and as one
/// natural op, from exact regions and with the largest first rank: the natural loops stop
/// on the end of the input, here the region's end, which every size reaches at a different
/// point.
#[test]
fn neon_flat_sizes() {
    let mut rng = new_rng();
    for n in 0..=1100 {
        for d in 2..=8u8 {
            let region = rand_vec(&mut rng, (n * usize::from(d)).div_ceil(8));
            let first = if d < 8 {
                (R2S_LEN - (1 << d)).min(255) as u8
            } else {
                0
            };
            let nat = Op {
                kind: OP_NAT,
                flags: FLAG_DST,
                d,
                p: first,
                k: n as u32,
                ..Op::default()
            };
            for ops in [flat_ops(n, d, first, FLAG_DST, 0, 0), vec![nat]] {
                let kind = ops[0].kind;
                let mut e = Env::new(&mut rng, 0, n, &region);
                e.ops = ops;
                let ret = dec_diff_exec(Tier::Neon, &mut e, "flat");
                assert_eq!(ret, Ok(()), "n={n} d={d} kind {kind}");
            }
        }
    }
}

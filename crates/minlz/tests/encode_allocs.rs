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

//! Ports of Go's `TestSIMDEncodeAllocs` and `TestEncodeAllocs` (`encode_test.go`): after warmup,
//! encoding into a large enough dst must not allocate. A counting global allocator needs its own
//! test binary.

use minlz::{Level, encode};

#[path = "support/alloc_count.rs"]
mod alloc_count;

use alloc_count::{assert_counter_counts, check_allocs};

/// Go's genEncText of 1 MiB, from SplitMix64.
fn text() -> Vec<u8> {
    const WORDS: [&str; 15] = [
        "lorem",
        "ipsum",
        "dolor",
        "sit",
        "amet",
        "consectetur",
        "adipiscing",
        "elit",
        "sed",
        "do",
        "eiusmod",
        "tempor",
        "incididunt",
        "ut",
        "labore",
    ];
    let mut s = 1u64;
    let mut out = Vec::new();
    while out.len() < 1 << 20 {
        s = s.wrapping_add(0x9e3779b97f4a7c15);
        let mut z = s;
        z = (z ^ (z >> 30)).wrapping_mul(0xbf58476d1ce4e5b9);
        z = (z ^ (z >> 27)).wrapping_mul(0x94d049bb133111eb);
        out.extend_from_slice(WORDS[((z ^ (z >> 31)) % 15) as usize].as_bytes());
        out.push(b' ');
    }
    out.truncate(1 << 20);
    out
}

#[test]
fn counter_counts() {
    assert_counter_counts();
}

/// TestSIMDEncodeAllocs, also at 64 KB, where the parsers have other tables.
#[test]
fn simd_encode_allocs() {
    let src = text();
    let mut dst = Vec::new();
    for n in [64 << 10, src.len()] {
        for l in [4, 5, 6, 7, 260, 261, 262] {
            let level = Level::try_from(l).unwrap();
            check_allocs(&format!("size {n} level {l}"), 5, || {
                encode(&mut dst, &src[..n], level).unwrap();
            });
        }
    }
}

/// TestEncodeAllocs checks that the classic levels take their hash tables from pools.
#[test]
fn encode_allocs() {
    let src = text();
    let mut dst = Vec::new();
    for n in [1 << 10, 64 << 10, src.len()] {
        for level in [
            Level::SuperFast,
            Level::Fastest,
            Level::Balanced,
            Level::Smallest,
        ] {
            check_allocs(&format!("size {n} level {level:?}"), 5, || {
                encode(&mut dst, &src[..n], level).unwrap();
            });
        }
    }
}

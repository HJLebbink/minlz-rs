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

//! Port of Go's `TestSIMDDecodeAllocs` (`decode-simd_test.go`): after warmup, decoding SIMD
//! blocks does not allocate, nor does decoding them with their hash, which streams do. A
//! counting global allocator needs its own test binary. Go builds its block with the test
//! builder; Go encoder fixtures with coded and class tables, delta literals, several chunks and
//! literal blocks stand in for it.

use std::io::{Cursor, Read, Write};

use minlz::Level;
use minlz::stream::{Reader, WriterBuilder};

#[path = "../src/unzip.rs"]
mod unzip;

#[path = "support/alloc_count.rs"]
mod alloc_count;

use alloc_count::{assert_counter_counts, check_allocs};

fn fixture(name: &str) -> Vec<u8> {
    unzip::simd_fixtures()
        .into_iter()
        .find(|(n, _)| n == name)
        .unwrap_or_else(|| panic!("{name}: no such fixture"))
        .1
}

#[test]
fn simd_decode_allocs() {
    let blocks: Vec<Vec<u8>> = [
        "mixed-1126400.L262.mzb",
        "sparse-524288.L5.mzb",
        "sawyer-65536.L7.mzb",
        "textlike-4096.L260.mzb",
    ]
    .into_iter()
    .map(fixture)
    .collect();
    let mut dst = Vec::with_capacity(minlz::MAX_BLOCK_SIZE);
    let mut run = || {
        for b in &blocks {
            minlz::decode(&mut dst, b).unwrap();
        }
    };
    // The best tier, then the lower ones, as Go's simdTiers.
    for mask in [
        0,
        minlz::cpu::AVX512,
        minlz::cpu::AVX512 | minlz::cpu::AVX2 | minlz::cpu::NEON,
    ] {
        minlz::cpu::disable(mask);
        check_allocs(&format!("tiers without {mask:#x}"), 20, &mut run);
        minlz::cpu::enable_all();
    }
    assert_counter_counts();
}

/// Go checks `decodeSIMDHash`, which the stream reader decodes SIMD chunks with, directly; here a
/// reader reset to a stream of SIMD chunks decodes it.
#[test]
fn simd_stream_decode_allocs() {
    let mut data = Vec::new();
    minlz::decode(&mut data, &fixture("mixed-1126400.L262.mzb")).unwrap();
    let mut w = WriterBuilder::new()
        .level(Level::FastestSimdDelta)
        .block_size(64 << 10)
        .build(Vec::new())
        .unwrap();
    w.write_all(&data).unwrap();
    let stream = w.finish().unwrap();
    let (mut c, mut simd_chunks) = (&stream[..], 0);
    while !c.is_empty() {
        simd_chunks += usize::from(c[0] == 0x10);
        c = &c[4 + (c[1] as usize | (c[2] as usize) << 8 | (c[3] as usize) << 16)..];
    }
    assert!(simd_chunks > 10, "{simd_chunks} SIMD chunks");
    let mut out = vec![0; data.len()];
    let mut r = Reader::new(Cursor::new(&stream[..]));
    let run = || {
        r.reset(Cursor::new(&stream[..]));
        r.read_exact(&mut out).unwrap();
        assert_eq!(r.read(&mut [0; 1]).unwrap(), 0);
    };
    check_allocs("stream decodes", 20, run);
    assert!(out == data);
}

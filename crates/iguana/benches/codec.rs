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

//! Head-to-head **Iguana vs MinLZ** bake-off on one corpus: compression ratio
//! (printed once at startup) plus encode and decode throughput (criterion).
//!
//! Corpus: a real, naturally-sized English text used **as-is** (no tiling, so the
//! ratios aren't inflated by artificial repetition). Prefers the Canterbury files
//! in `testdata/bench/` (`plrabn12.txt`, ~470 KiB), honouring `MINLZ_TESTDATA`;
//! falls back through smaller files and finally a synthetic prose corpus so the
//! bench always runs. Tiny corpora are padded up to a 128 KiB floor.
//!
//! ```
//! cargo bench -p iguana --bench codec
//! cargo bench -p iguana --bench codec -- --quick
//! cargo bench -p iguana --bench codec encode/iguana_ans32
//! ```
#![allow(missing_docs)]

use criterion::{Criterion, Throughput, criterion_group, criterion_main};
use iguana::{
    EntropyMode, ans32_decode, ans32_decode_simd, ans32_encode, ans32_encode_simd,
    decode_tokens_ref, decode_tokens_simd, iguana_compress, iguana_decompress,
    iguana_decompress_simd,
};
use minlz::{Level, decode as mz_decode, encode as mz_encode};
use std::path::PathBuf;
use std::sync::Once;
use std::time::Duration;

/// Candidate corpus file names, largest/most representative first.
const CORPUS_FILES: &[&str] = &[
    "bench/plrabn12.txt",
    "bench/lcet10.txt",
    "bench/alice29.txt",
    "bench/asyoulik.txt",
    "Mark.Twain-Tom.Sawyer.txt",
];

/// Load a real English corpus as-is (env/repo), else synthesize; pad tiny files.
fn load_corpus() -> Vec<u8> {
    let manifest = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    let mut roots: Vec<PathBuf> = Vec::new();
    if let Ok(d) = std::env::var("MINLZ_TESTDATA") {
        roots.push(PathBuf::from(d));
    }
    roots.push(manifest.join("../../testdata"));
    roots.push(manifest.join("../../../testdata"));

    for root in &roots {
        for name in CORPUS_FILES {
            if let Ok(b) = std::fs::read(root.join(name)) {
                return ensure_floor(b);
            }
        }
    }
    ensure_floor(synthesize_prose())
}

/// Pad a corpus up to a 128 KiB floor (tiling) only if it is smaller; larger
/// files are used unchanged to keep ratios representative.
fn ensure_floor(base: Vec<u8>) -> Vec<u8> {
    const FLOOR: usize = 128 * 1024;
    if base.len() >= FLOOR {
        return base;
    }
    let mut out = Vec::with_capacity(FLOOR);
    while out.len() < FLOOR {
        let take = (FLOOR - out.len()).min(base.len());
        out.extend_from_slice(&base[..take]);
    }
    out
}

/// Deterministic English-ish prose, used when the Twain corpus isn't present.
fn synthesize_prose() -> Vec<u8> {
    let words: &[&str] = &[
        "the ", "quick ", "brown ", "fox ", "jumps ", "over ", "a ", "lazy ", "dog ", "and ",
        "then ", "runs ", "into ", "the ", "deep ", "dark ", "forest ", "where ", "nobody ",
        "could ", "ever ", "find ", "it ", "again ", "or ", "so ", "they ", "say ",
    ];
    let mut s = 0x2545_f491u32;
    let mut out = Vec::with_capacity(256 * 1024);
    while out.len() < 256 * 1024 {
        s ^= s << 13;
        s ^= s >> 17;
        s ^= s << 5;
        out.extend_from_slice(words[(s as usize) % words.len()].as_bytes());
        if s & 0x3f == 0 {
            out.extend_from_slice(b".\n");
        }
    }
    out
}

/// Print the ratio table once (criterion only times speed).
fn print_ratios(corpus: &[u8]) {
    static ONCE: Once = Once::new();
    ONCE.call_once(|| {
        let n = corpus.len() as f64;
        let report = |label: &str, clen: usize| {
            eprintln!("  {label:<16} {clen:>8} B   {:.2}x", n / clen as f64);
        };
        eprintln!("\n=== compression ratio (corpus = {} B) ===", corpus.len());
        report(
            "iguana None",
            iguana_compress(corpus, EntropyMode::None).len(),
        );
        report(
            "iguana Ans1",
            iguana_compress(corpus, EntropyMode::Ans1).len(),
        );
        report(
            "iguana Ans32",
            iguana_compress(corpus, EntropyMode::Ans32).len(),
        );
        report(
            "iguana Nibble",
            iguana_compress(corpus, EntropyMode::AnsNibble).len(),
        );
        for (lvl, name) in [
            (Level::Fastest, "minlz L1"),
            (Level::Balanced, "minlz L2"),
            (Level::Smallest, "minlz L3"),
        ] {
            let mut buf = Vec::new();
            mz_encode(&mut buf, corpus, lvl).expect("minlz encode");
            report(name, buf.len());
        }
        eprintln!();
    });
}

fn bench_encode(c: &mut Criterion) {
    let corpus = load_corpus();
    print_ratios(&corpus);

    let mut g = c.benchmark_group("encode");
    g.measurement_time(Duration::from_secs(6));
    g.warm_up_time(Duration::from_secs(2));
    g.throughput(Throughput::Bytes(corpus.len() as u64));

    g.bench_function("iguana_none", |b| {
        b.iter(|| iguana_compress(std::hint::black_box(&corpus), EntropyMode::None))
    });
    g.bench_function("iguana_ans32", |b| {
        b.iter(|| iguana_compress(std::hint::black_box(&corpus), EntropyMode::Ans32))
    });
    for (lvl, name) in [
        (Level::Fastest, "minlz_L1"),
        (Level::Balanced, "minlz_L2"),
        (Level::Smallest, "minlz_L3"),
    ] {
        g.bench_function(name, |b| {
            let mut buf = Vec::with_capacity(corpus.len() + 64);
            b.iter(|| mz_encode(&mut buf, std::hint::black_box(&corpus), lvl).expect("encode"));
        });
    }
    g.finish();
}

fn bench_decode(c: &mut Criterion) {
    let corpus = load_corpus();
    print_ratios(&corpus);

    let mut g = c.benchmark_group("decode");
    g.measurement_time(Duration::from_secs(6));
    g.warm_up_time(Duration::from_secs(2));
    g.throughput(Throughput::Bytes(corpus.len() as u64));

    let ig = iguana_compress(&corpus, EntropyMode::Ans32);
    assert_eq!(iguana_decompress(&ig).unwrap(), corpus);
    g.bench_function("iguana_scalar", |b| {
        b.iter(|| iguana_decompress(std::hint::black_box(&ig)).unwrap())
    });
    g.bench_function("iguana_simd", |b| {
        b.iter(|| iguana_decompress_simd(std::hint::black_box(&ig)).unwrap())
    });
    for (lvl, name) in [
        (Level::Fastest, "minlz_L1"),
        (Level::Balanced, "minlz_L2"),
        (Level::Smallest, "minlz_L3"),
    ] {
        let mut enc = Vec::new();
        mz_encode(&mut enc, &corpus, lvl).expect("encode for prep");
        g.bench_function(name, |b| {
            let mut buf = Vec::with_capacity(corpus.len() + 64);
            b.iter(|| mz_decode(&mut buf, std::hint::black_box(&enc)).expect("decode"));
        });
    }
    g.finish();
}

/// Isolates the ANS32 entropy-decode kernel (the Stage-1 SVE2 gate): scalar
/// `ans32_decode` vs `ans32_decode_simd` on a single full-corpus rANS stream, so
/// the LZ/structural stage is out of the picture. On AArch64 `simd` is the SVE2
/// kernel; on x86-64 it is AVX-512.
fn bench_ans32_decode(c: &mut Criterion) {
    let corpus = load_corpus();
    let enc = ans32_encode(&corpus);
    assert_eq!(ans32_decode(&enc, corpus.len()).unwrap(), corpus);
    assert_eq!(ans32_decode_simd(&enc, corpus.len()).unwrap(), corpus);

    let mut g = c.benchmark_group("ans32_decode");
    g.measurement_time(Duration::from_secs(6));
    g.warm_up_time(Duration::from_secs(2));
    g.throughput(Throughput::Bytes(corpus.len() as u64));
    g.bench_function("scalar", |b| {
        b.iter(|| ans32_decode(std::hint::black_box(&enc), corpus.len()).unwrap())
    });
    g.bench_function("simd", |b| {
        b.iter(|| ans32_decode_simd(std::hint::black_box(&enc), corpus.len()).unwrap())
    });
    g.finish();
}

/// Isolates the ANS32 entropy-*encode* kernel: scalar `ans32_encode` vs
/// `ans32_encode_simd` on the full corpus (SVE2 on AArch64, AVX-512 on x86-64).
fn bench_ans32_encode(c: &mut Criterion) {
    let corpus = load_corpus();
    assert_eq!(ans32_encode_simd(&corpus), ans32_encode(&corpus));

    let mut g = c.benchmark_group("ans32_encode");
    g.measurement_time(Duration::from_secs(6));
    g.warm_up_time(Duration::from_secs(2));
    g.throughput(Throughput::Bytes(corpus.len() as u64));
    g.bench_function("scalar", |b| {
        b.iter(|| ans32_encode(std::hint::black_box(&corpus)))
    });
    g.bench_function("simd", |b| {
        b.iter(|| ans32_encode_simd(std::hint::black_box(&corpus)))
    });
    g.finish();
}

/// Stage-4 unit 1: the per-token decode arithmetic (the cleanly *parallel* part of
/// the structural decoder) — scalar twin vs SVE2. Synthetic but representative token
/// stream (~85% short tokens, exercising both scalar branches). Throughput is the
/// token-processing rate (1 token = 1 input byte).
fn bench_decode_tokens(c: &mut Criterion) {
    let n = 1usize << 17; // 131072 tokens
    let mut x = 0x1234_5678u32;
    let toks: Vec<u8> = (0..n)
        .map(|_| {
            x ^= x << 13;
            x ^= x >> 17;
            x ^= x << 5;
            if x & 7 == 0 {
                (x % 32) as u8 // long token (<32), ~1/8 of the stream
            } else {
                32 + (x % 224) as u8 // short token (>=32)
            }
        })
        .collect();
    let (mut f, mut l, mut m) = (vec![0u8; n], vec![0u8; n], vec![0u8; n]);
    decode_tokens_ref(&toks, &mut f, &mut l, &mut m);
    let (mut f2, mut l2, mut m2) = (vec![0u8; n], vec![0u8; n], vec![0u8; n]);
    decode_tokens_simd(&toks, &mut f2, &mut l2, &mut m2);
    assert!(f == f2 && l == l2 && m == m2, "scalar/simd token-decode disagree");

    let mut g = c.benchmark_group("decode_tokens");
    g.throughput(Throughput::Bytes(n as u64));
    g.bench_function("scalar", |b| {
        b.iter(|| decode_tokens_ref(std::hint::black_box(&toks), &mut f, &mut l, &mut m))
    });
    g.bench_function("simd", |b| {
        b.iter(|| decode_tokens_simd(std::hint::black_box(&toks), &mut f2, &mut l2, &mut m2))
    });
    g.finish();
}

criterion_group!(
    benches,
    bench_encode,
    bench_decode,
    bench_ans32_decode,
    bench_ans32_encode,
    bench_decode_tokens
);
criterion_main!(benches);

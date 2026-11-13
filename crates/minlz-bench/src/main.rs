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

//! `minlz-bench` measures the throughput of the MinLZ codec through its public API. Every version
//! since the tag `before-MLIR` has the names it uses, so the same source builds against any of
//! them, and `cargo xtask bench <rev>` builds it against commit `rev` and the working tree.
//!
//! ```text
//! minlz-bench list                 the cases
//! minlz-bench tiers                the kernel tiers this machine has
//! minlz-bench run <case> [secs] [--tier T]         one case, as `compare` runs it
//! minlz-bench compare <base> [--pairs N] [--secs S] [--only TEXT] [--tier T]
//! ```
//!
//! `compare` runs each case in the base build and in this one, in alternating order, `--pairs`
//! times (default 6), `--secs` seconds each (default 1), and prints the median of this build's
//! speed over the base's. A run reports its fastest sample, which leaves out the samples that
//! other processes interrupted. Pin the process to one core (`taskset -c 5` on Linux,
//! `start /affinity 20` on Windows): the runs it starts inherit the pin.
//!
//! `--tier` picks the kernel tier a run uses: the fastest one is what the CPU has, and each lower
//! one turns off the instruction sets above it with `minlz::cpu::disable` before the first
//! library call, so every dispatcher picks the kernels of that tier once. `compare` passes the
//! tier to both builds. Only the names every version since `before-MLIR` has may appear here:
//! the SVE2 bit is written as its number, and an older library, which has no SVE2 tier, does
//! nothing when it is turned off.
//!
//! The cases cover the code that the MLIR kernels replaced: block decode at the SIMD levels runs
//! the stream checks, the pivco decoder and the operation loops; stream read and write at level
//! Fastest add a CRC32C per chunk to code that the kernels leave alone; and XXH3 hashes inputs of
//! four sizes. Block decode at level Fastest uses none of the kernels and should read 1.00.

use std::hint::black_box;
use std::io::{Read, Write};
use std::path::{Path, PathBuf};
use std::process::{Command, ExitCode};
use std::time::{Duration, Instant};
use std::{env, fs};

use minlz::Level;
use minlz::stream::{Reader, WriterBuilder};

/// The operation of a case.
#[derive(Clone, Copy, PartialEq)]
enum Op {
    /// `minlz::decode` of the block encoding.
    BlockDecode,
    /// A `Reader` over the stream encoding.
    StreamRead,
    /// A `Writer` that writes the stream encoding.
    StreamWrite,
    /// `minlz::xxh3::hash`.
    Xxh3,
}

impl Op {
    fn name(self) -> &'static str {
        match self {
            Op::BlockDecode => "block-decode",
            Op::StreamRead => "stream-read",
            Op::StreamWrite => "stream-write",
            Op::Xxh3 => "xxh3",
        }
    }
}

/// One measurement: an operation on an input, at a level for the codec operations.
struct Case {
    op: Op,
    input: &'static str,
    level: Option<Level>,
}

impl Case {
    fn name(&self) -> String {
        match self.level {
            Some(l) => format!("{}/{}/{l:?}", self.op.name(), self.input),
            None => format!("{}/{}", self.op.name(), self.input),
        }
    }
}

/// Returns every case, in the order `compare` runs them.
fn cases() -> Vec<Case> {
    let mut v = Vec::new();
    for input in ["twain-4m", "corpus"] {
        for level in [
            Level::Fastest,
            Level::SuperFastSimd,
            Level::FastestSimd,
            Level::BalancedSimd,
            Level::SmallestSimd,
            Level::SuperFastSimdDelta,
            Level::FastestSimdDelta,
            Level::BalancedSimdDelta,
        ] {
            v.push(Case {
                op: Op::BlockDecode,
                input,
                level: Some(level),
            });
        }
    }
    for op in [Op::StreamRead, Op::StreamWrite] {
        for input in ["twain-4m", "corpus"] {
            v.push(Case {
                op,
                input,
                level: Some(Level::Fastest),
            });
        }
    }
    for input in ["twain-64", "twain-1k", "twain-64k", "twain-4m"] {
        v.push(Case {
            op: Op::Xxh3,
            input,
            level: None,
        });
    }
    v
}

/// Returns the folder of the test data: `$MINLZ_TESTDATA`, or `testdata/` of the workspace this
/// binary was built in.
fn testdata() -> PathBuf {
    match env::var_os("MINLZ_TESTDATA") {
        Some(d) => PathBuf::from(d),
        None => Path::new(env!("CARGO_MANIFEST_DIR")).join("../../testdata"),
    }
}

fn read(rel: &str) -> Vec<u8> {
    let p = testdata().join(rel);
    fs::read(&p).unwrap_or_else(|e| panic!("{}: {e} (set MINLZ_TESTDATA)", p.display()))
}

/// Returns the input `name`: `corpus`, the Snappy benchmark files one after another, or
/// `twain-<n>`, the first n bytes of Tom Sawyer repeated, with each copy XORed with its count as
/// Go's tests do (k is 1000 bytes, m 1000000).
fn input(name: &str) -> Vec<u8> {
    if name == "corpus" {
        let files = [
            "html",
            "urls.10K",
            "fireworks.jpeg",
            "paper-100k.pdf",
            "html_x_4",
            "alice29.txt",
            "asyoulik.txt",
            "lcet10.txt",
            "plrabn12.txt",
            "geo.protodata",
            "kppkn.gtb",
        ];
        return files
            .iter()
            .flat_map(|f| read(&format!("bench/{f}")))
            .collect();
    }
    let n = name
        .strip_prefix("twain-")
        .expect("input is corpus or twain-<n>");
    let n = match n.as_bytes()[n.len() - 1] {
        b'k' => n[..n.len() - 1].parse::<usize>().expect("size") * 1000,
        b'm' => n[..n.len() - 1].parse::<usize>().expect("size") * 1_000_000,
        _ => n.parse().expect("size"),
    };
    let src = read("Mark.Twain-Tom.Sawyer.txt");
    let mut dst = Vec::with_capacity(n);
    let mut cnt = 0u8;
    while dst.len() < n {
        let take = src.len().min(n - dst.len());
        dst.extend(src[..take].iter().map(|b| b ^ cnt));
        cnt = cnt.wrapping_add(1);
    }
    dst
}

/// Runs f for secs seconds in samples of at least 100 µs and returns the fastest time per call in
/// ns and the number of calls.
fn measure(secs: f64, mut f: impl FnMut()) -> (f64, u64) {
    let mut reps = 1u64;
    loop {
        let t = Instant::now();
        for _ in 0..reps {
            f();
        }
        if t.elapsed() >= Duration::from_micros(100) {
            break;
        }
        reps *= 2;
    }
    let start = Instant::now();
    let (mut best, mut calls) = (f64::MAX, 0);
    while start.elapsed().as_secs_f64() < secs {
        let t = Instant::now();
        for _ in 0..reps {
            f();
        }
        best = best.min(t.elapsed().as_nanos() as f64 / reps as f64);
        calls += reps;
    }
    (best, calls)
}

/// Runs case for secs seconds and returns the fastest time per call in ns, the bytes of the input
/// and the XXH3 hash of the encoding that the case decodes or writes, by which `compare` sees
/// whether both builds worked on the same encoding.
fn run(case: &Case, secs: f64) -> (f64, usize, u64) {
    let src = input(case.input);
    let level = case.level.unwrap_or(Level::Fastest);
    let write_stream = |src: &[u8]| {
        let mut w = WriterBuilder::new()
            .level(level)
            .build(Vec::new())
            .expect("writer");
        w.write_all(src).expect("write");
        w.finish().expect("finish")
    };
    let (ns, enc) = match case.op {
        Op::BlockDecode => {
            let mut enc = Vec::new();
            minlz::encode(&mut enc, &src, level).expect("encode");
            let mut out = Vec::with_capacity(src.len());
            let (ns, _) = measure(secs, || {
                out.clear();
                minlz::decode(&mut out, black_box(&enc)).expect("decode");
                black_box(&out);
            });
            assert!(out == src, "decode differs from the input");
            (ns, enc)
        }
        Op::StreamRead => {
            let enc = write_stream(&src);
            let mut out = Vec::with_capacity(src.len());
            let (ns, _) = measure(secs, || {
                out.clear();
                Reader::new(black_box(&enc[..]))
                    .read_to_end(&mut out)
                    .expect("read");
                black_box(&out);
            });
            assert!(out == src, "read differs from the input");
            (ns, enc)
        }
        Op::StreamWrite => {
            let (ns, _) = measure(secs, || {
                black_box(write_stream(black_box(&src)));
            });
            (ns, write_stream(&src))
        }
        Op::Xxh3 => {
            let mut x = 0u64;
            let (ns, _) = measure(secs, || x ^= minlz::xxh3::hash(black_box(&src)));
            black_box(x);
            (ns, Vec::new())
        }
    };
    (ns, src.len(), minlz::xxh3::hash(&enc))
}

/// Runs case in exe and returns its fastest time per call in ns, the input's bytes and the
/// encoding's hash. The exe runs the case with the tier's instruction sets turned off; an empty
/// tier turns nothing off, so the exe runs the best tiers its CPU has.
fn run_in(exe: &Path, case: &str, secs: f64, tier: &str) -> Result<(f64, usize, u64), String> {
    let secs = secs.to_string();
    let mut args = vec!["run", case, &secs];
    let with_tier = ["--tier", tier];
    if !tier.is_empty() {
        args.extend_from_slice(&with_tier);
    }
    let out = Command::new(exe)
        .args(&args)
        .env("MINLZ_TESTDATA", testdata())
        .output()
        .map_err(|e| format!("{}: {e}", exe.display()))?;
    let text = String::from_utf8_lossy(&out.stdout);
    let f: Vec<&str> = text.split_whitespace().collect();
    if !out.status.success() || f.len() != 3 {
        return Err(format!(
            "{} run {case}: {}{}",
            exe.display(),
            out.status,
            String::from_utf8_lossy(&out.stderr)
        ));
    }
    let bad = || format!("{} run {case}: bad output {text}", exe.display());
    Ok((
        f[0].parse().map_err(|_| bad())?,
        f[1].parse().map_err(|_| bad())?,
        u64::from_str_radix(f[2], 16).map_err(|_| bad())?,
    ))
}

fn median(v: &mut [f64]) -> f64 {
    v.sort_by(f64::total_cmp);
    let n = v.len();
    if n % 2 == 1 {
        v[n / 2]
    } else {
        (v[n / 2 - 1] + v[n / 2]) / 2.0
    }
}

/// The cpu feature bit that gates the SVE2 tiers of XXH3 and CRC32C: `minlz::cpu::SVE2` of a
/// recent library, written as its number because an older library has no SVE2 tier and turning
/// an unknown bit off there does nothing.
const SVE2_BIT: u32 = 64;

/// Returns the features `--tier` turns off so that every dispatcher picks the kernels of that
/// tier, or None if this architecture has no such tier. The names are those `tiers` prints.
fn tier_mask(name: &str) -> Option<u32> {
    match name {
        #[cfg(target_arch = "x86_64")]
        "avx512" => Some(0),
        #[cfg(target_arch = "x86_64")]
        "avx2" => {
            Some(minlz::cpu::AVX512 | minlz::cpu::PIVCO_AVX512 | minlz::cpu::PIVCO_HIST_AVX512)
        }
        #[cfg(target_arch = "aarch64")]
        "sve2" => Some(0),
        #[cfg(target_arch = "aarch64")]
        "neon" => Some(SVE2_BIT),
        "generic" => Some(if cfg!(target_arch = "x86_64") {
            minlz::cpu::AVX2
                | minlz::cpu::AVX512
                | minlz::cpu::PIVCO_AVX2
                | minlz::cpu::PIVCO_AVX512
                | minlz::cpu::PIVCO_HIST_AVX512
        } else if cfg!(target_arch = "aarch64") {
            minlz::cpu::NEON | SVE2_BIT
        } else {
            0
        }),
        _ => None,
    }
}

/// Prints the kernel tiers this machine has, one per line, fastest first: the tier of the best
/// kernels its CPU runs, then the tiers of the lower instruction sets.
fn tiers() {
    let mut v: Vec<&str> = Vec::new();
    #[cfg(target_arch = "x86_64")]
    {
        if std::is_x86_feature_detected!("avx512f") {
            v.push("avx512");
        }
        if std::is_x86_feature_detected!("avx2") {
            v.push("avx2");
        }
    }
    #[cfg(target_arch = "aarch64")]
    {
        if std::arch::is_aarch64_feature_detected!("sve2") {
            v.push("sve2");
        }
        v.push("neon");
    }
    v.push("generic");
    v.iter().for_each(|t| println!("{t}"));
}

/// Times every case whose name contains only, in base and in this build, alternating which runs
/// first, and prints a row per case and the geometric mean of the ratios per operation. Every
/// run, in both builds, gets the tier's instruction sets turned off.
fn compare(base: &Path, pairs: usize, secs: f64, only: &str, tier: &str) -> Result<(), String> {
    let me = env::current_exe().map_err(|e| e.to_string())?;
    println!(
        "Speed of this build over {}: median of {pairs} alternating pairs",
        base.display()
    );
    println!("(smallest and largest pair), {secs} s per run, fastest sample of each run.\n");
    println!("| Case | Base MB/s | This MB/s | Ratio | Range |");
    println!("| --- | ---: | ---: | ---: | --- |");
    let mut logs: Vec<(Op, f64)> = Vec::new();
    for case in cases().iter().filter(|c| c.name().contains(only)) {
        let name = case.name();
        let (mut b, mut t, mut r) = (Vec::new(), Vec::new(), Vec::new());
        let mut same = true;
        for i in 0..pairs {
            let (nb, nt, bytes) = if i % 2 == 0 {
                let x = run_in(base, &name, secs, tier)?;
                let y = run_in(&me, &name, secs, tier)?;
                same &= x.2 == y.2;
                (x.0, y.0, x.1)
            } else {
                let y = run_in(&me, &name, secs, tier)?;
                let x = run_in(base, &name, secs, tier)?;
                same &= x.2 == y.2;
                (x.0, y.0, x.1)
            };
            b.push(bytes as f64 * 1e3 / nb);
            t.push(bytes as f64 * 1e3 / nt);
            r.push(nb / nt);
        }
        let ratio = median(&mut r);
        let note = if same {
            ""
        } else {
            " (the builds encode differently)"
        };
        println!(
            "| {name}{note} | {:.0} | {:.0} | {ratio:.3} | {:.2} to {:.2} |",
            median(&mut b),
            median(&mut t),
            r[0],
            r[r.len() - 1],
        );
        logs.push((case.op, ratio.ln()));
    }
    println!();
    for op in [Op::BlockDecode, Op::StreamRead, Op::StreamWrite, Op::Xxh3] {
        let l: Vec<f64> = logs.iter().filter(|x| x.0 == op).map(|x| x.1).collect();
        if !l.is_empty() {
            let g = (l.iter().sum::<f64>() / l.len() as f64).exp();
            println!("Geometric mean, {}: {g:.3}", op.name());
        }
    }
    Ok(())
}

fn main() -> ExitCode {
    let args: Vec<String> = env::args().skip(1).collect();
    let usage = "usage: minlz-bench list | tiers | run <case> [secs] [--tier T] | \
                 compare <base> [--pairs N] [--secs S] [--only TEXT] [--tier T]";
    let result = match args.first().map(String::as_str) {
        Some("list") => {
            cases().iter().for_each(|c| println!("{}", c.name()));
            Ok(())
        }
        Some("tiers") => {
            tiers();
            Ok(())
        }
        Some("run") if args.len() >= 2 => {
            let (mut secs, mut mask, mut bad) = (1.0, None, None);
            let mut i = 2;
            while i < args.len() {
                if args[i] == "--tier" {
                    let t = args.get(i + 1).map(String::as_str).unwrap_or("");
                    match tier_mask(t) {
                        Some(m) => mask = Some(m),
                        None => bad = bad.or(Some(format!("no tier {t} (see minlz-bench tiers)"))),
                    }
                    i += 2;
                } else {
                    match args[i].parse() {
                        Ok(s) => secs = s,
                        Err(e) => bad = bad.or(Some(format!("secs: {e}"))),
                    }
                    i += 1;
                }
            }
            match bad {
                Some(e) => Err(e),
                None => match cases().into_iter().find(|c| c.name() == args[1]) {
                    Some(case) => {
                        // The first library call, before any dispatcher picks its kernels.
                        if let Some(m) = mask {
                            minlz::cpu::disable(m);
                        }
                        let (ns, bytes, hash) = run(&case, secs);
                        println!("{ns:.1} {bytes} {hash:016x}");
                        Ok(())
                    }
                    None => Err(format!("no case {} (see minlz-bench list)", args[1])),
                },
            }
        }
        Some("compare") if args.len() >= 2 => {
            let (mut pairs, mut secs, mut only, mut tier) = (6, 1.0, String::new(), String::new());
            let mut i = 2;
            let mut bad = None;
            while i + 1 < args.len() {
                match args[i].as_str() {
                    "--pairs" => pairs = args[i + 1].parse().unwrap_or(0),
                    "--secs" => secs = args[i + 1].parse().unwrap_or(0.0),
                    "--only" => only = args[i + 1].clone(),
                    "--tier" => {
                        if tier_mask(&args[i + 1]).is_none() {
                            bad = bad.or(Some(args[i + 1].clone()));
                        } else {
                            tier = args[i + 1].clone();
                        }
                    }
                    a => bad = Some(a.to_string()),
                }
                i += 2;
            }
            if bad.is_some() || i != args.len() || pairs == 0 || secs <= 0.0 {
                Err(usage.to_string())
            } else {
                compare(Path::new(&args[1]), pairs, secs, &only, &tier)
            }
        }
        _ => Err(usage.to_string()),
    };
    match result {
        Ok(()) => ExitCode::SUCCESS,
        Err(e) => {
            eprintln!("minlz-bench: {e}");
            ExitCode::FAILURE
        }
    }
}

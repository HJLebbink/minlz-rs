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

//! Developer tasks for this workspace, run as `cargo xtask <task>`.
//!
//! `cargo xtask mlir` lowers the MLIR kernels in `crates/minlz/mlir/` once per target, and writes
//! the assembly that the naked functions of the `mlir.rs` modules in `crates/minlz/src/xxh3/`,
//! `crates/minlz/src/stream/crc/` and `crates/minlz/src/block/simd/` include. It also writes the CRC32C target files,
//! `crates/minlz/mlir/crc32c/*.mlir`. Run it after changing an MLIR file or a target table, and
//! commit its output: building the crate never runs LLVM.
//!
//! It needs the LLVM and MLIR 23 tools `mlir-opt`, `mlir-translate`, `opt` and `llc`, in the
//! directory `$LLVM_BIN` or on `PATH`. LLVM's Windows release includes them. On Debian and Ubuntu
//! they are the apt.llvm.org packages `llvm-23` and `mlir-23-tools`.
//!
//! `cargo xtask bench <rev>` compares the speed of the working tree with commit `rev`; see
//! `bench.rs`. `cargo xtask bench-hw <rev>` times it on every machine and kernel tier; see
//! `bench.rs`.

mod bench;
mod body;
mod crc32c;

use std::io::Write;
use std::path::{Path, PathBuf};
use std::process::{Command, ExitCode, Stdio};
use std::{env, fs, thread};

fn main() -> ExitCode {
    let args: Vec<String> = env::args().skip(1).collect();
    let result = match args.iter().map(String::as_str).collect::<Vec<_>>()[..] {
        ["mlir"] => mlir(),
        ["bench", ref rest @ ..] => bench::bench(rest),
        ["bench-hw", ref rest @ ..] => bench::bench_hw(rest),
        _ => Err("usage: cargo xtask mlir | cargo xtask bench <rev> [...] | \
                  cargo xtask bench-hw <rev> [...]"
            .to_string()),
    };
    match result {
        Ok(()) => ExitCode::SUCCESS,
        Err(e) => {
            eprintln!("xtask: {e}");
            ExitCode::FAILURE
        }
    }
}

/// The architecture of a target.
#[derive(Clone, Copy)]
enum Arch {
    /// aarch64. The code keeps x18 free for the systems that reserve it (Android, macOS,
    /// Windows).
    Arm,
    /// x86-64. The code uses the System V calling convention on every system (the Rust side
    /// declares it `extern "sysv64"`) and Intel syntax, the default of `naked_asm!`.
    X86,
}

impl Arch {
    /// Returns the flags of `opt` and `llc` for the architecture.
    fn flags(self) -> &'static [&'static str] {
        match self {
            Arch::Arm => &[
                "-mtriple=aarch64-unknown-linux-gnu",
                "-mtune=neoverse-v2",
                "-mattr=+reserve-x18",
            ],
            Arch::X86 => &["-mtriple=x86_64-unknown-linux-gnu", "-x86-asm-syntax=intel"],
        }
    }

    /// Returns the `llc` flag that turns jump tables off. A jump table holds absolute addresses,
    /// which a position-independent program cannot hold.
    fn no_jump_tables(self) -> &'static str {
        match self {
            Arch::Arm => "-aarch64-min-jump-table-entries=4294967295",
            Arch::X86 => "-min-jump-table-entries=4294967295",
        }
    }

    /// Returns the file in `mlir/` that gives `@prefetch`: a prefetch into the L1 on x86-64, and
    /// nothing on aarch64.
    fn prefetch(self) -> &'static str {
        match self {
            Arch::Arm => "target/no_prefetch.mlir",
            Arch::X86 => "target/prefetch.mlir",
        }
    }

    /// Returns what starts a comment in the assembly.
    fn comment(self) -> &'static str {
        match self {
            Arch::Arm => "//",
            Arch::X86 => "#",
        }
    }
}

/// The lane layout of XXH3 for SVE: the lanes de-interleaved.
const SPLIT: &str = "xxh3_split.mlir";
/// The lane layout of XXH3 for fixed-width vectors: the lanes in memory order.
const WHOLE: &str = "xxh3_whole.mlir";

/// A row of [`XXH3`] or [`BLOCK`]: the output folder, the target file, the shared files, a
/// file of the kernel (the lane layout or the loop structure), the architecture and the features.
type Row = (
    &'static str,
    &'static str,
    &'static [&'static str],
    &'static str,
    Arch,
    &'static str,
);

/// The XXH3 targets: the output folder, the target file in `mlir/target/`, the files that the
/// target shares with another target, the lane layout, the architecture and the features. Base
/// SVE uses no SVE2 feature: Graviton 3 has 256-bit SVE but no SVE2, and the `sve2` row builds the
/// NEON target file with SVE2 on. AVX-512 code takes no feature beyond AVX-512F, which is all that
/// `xxh3::tiers` checks, and keeps 512-bit vectors whole.
const XXH3: [Row; 7] = [
    (
        "sve128",
        "sve128",
        &["lohi"],
        SPLIT,
        Arch::Arm,
        "-mattr=+v8.2a,+sve",
    ),
    (
        "sve256",
        "sve256",
        &["lohi"],
        SPLIT,
        Arch::Arm,
        "-mattr=+v8.2a,+sve",
    ),
    ("neon", "neon", &[], WHOLE, Arch::Arm, "-mattr=+v8a,+neon"),
    (
        "sve2",
        "neon",
        &[],
        WHOLE,
        Arch::Arm,
        "-mattr=+v8.2a,+neon,+sve2",
    ),
    ("sse2", "x86", &["lohi"], WHOLE, Arch::X86, "-mattr=+sse2"),
    ("avx2", "x86", &["lohi"], WHOLE, Arch::X86, "-mattr=+avx2"),
    (
        "avx512",
        "x86",
        &["lohi"],
        WHOLE,
        Arch::X86,
        "-mattr=+avx512f,-prefer-256-bit",
    ),
];

/// The structure of the operation loops in batches of 64, for x86-64.
const EXEC64: &str = "exec64.mlir";
/// The structure of the operation loops in batches of 8, for aarch64.
const EXEC8: &str = "exec8.mlir";
/// The file that holds the `@ld` that the statistics and the operation loops share. It follows
/// the kernel file, because the width it loads is the kernel's `!v`, which only the kernel file
/// gives.
const LD: &str = "ld.mlir";

/// The targets of the block kernels, the statistics and the operation loops: the output folder,
/// the target file in `mlir/stats/` and in `mlir/exec/`, the files that the target shares with
/// another target of its architecture (each name is read in the folder of the kernel that uses
/// it), the structure of the operation loops, the architecture and the features, each among those
/// that `block::simd` checks for its tier.
const BLOCK: [Row; 3] = [
    (
        "avx2",
        "x86_256",
        &["x86"],
        EXEC64,
        Arch::X86,
        "-mattr=+avx2,+bmi2,+popcnt",
    ),
    (
        "avx512",
        "x86_512",
        &["x86"],
        EXEC64,
        Arch::X86,
        "-mattr=+avx512f,+avx512bw,+avx512vl,+avx512vbmi,+avx512vbmi2,+bmi2,+popcnt,-prefer-256-bit",
    ),
    ("neon", "neon", &[], EXEC8, Arch::Arm, "-mattr=+v8a,+neon"),
];

/// The targets of the pivco kernels: the output folder, the target file in `mlir/pivco/`, the
/// files that the target shares with another target, the architecture and the features, each among
/// those that `pivco::kernel` checks for its tier.
const PIVCO: [(&str, &str, &[&str], Arch, &str); 3] = [
    (
        "avx2",
        "x86_256",
        &["load_store_n", "spread"],
        Arch::X86,
        "-mattr=+avx2,+bmi2,+popcnt",
    ),
    (
        "avx512",
        "x86_512",
        &["spread", "keep_cols"],
        Arch::X86,
        "-mattr=+avx512f,+avx512bw,+avx512vl,+avx512vbmi,+avx512vbmi2,+avx512vpopcntdq,+bmi2,+popcnt,-prefer-256-bit",
    ),
    (
        "neon",
        "neon",
        &["load_store_n", "keep_cols"],
        Arch::Arm,
        "-mattr=+v8a,+neon",
    ),
];

/// The passes that take the kernels from the dialects they are written in to the LLVM dialect.
const PASSES: [&str; 11] = [
    "--inline",
    "--symbol-dce",
    "--canonicalize",
    "--convert-scf-to-cf",
    "--lower-vector-multi-reduction",
    "--convert-vector-to-llvm",
    "--convert-ub-to-llvm",
    "--convert-arith-to-llvm",
    "--convert-cf-to-llvm",
    "--convert-func-to-llvm",
    "--reconcile-unrealized-casts",
];

/// Returns the workspace root.
fn root() -> &'static Path {
    Path::new(env!("CARGO_MANIFEST_DIR"))
        .parent()
        .expect("xtask/ is in the workspace root")
}

/// Returns the folder of the MLIR kernels.
fn mlir_dir() -> PathBuf {
    root().join("crates/minlz/mlir")
}

/// One kernel lowered for one target.
struct Lowering {
    /// The kernel, which names its functions `minlz_<kernel>_<function>`.
    kernel: &'static str,
    /// The kernel's own file in `mlir/`, which the output names.
    source: &'static str,
    /// The target, which names the output folder.
    target: &'static str,
    /// The output folder.
    out: PathBuf,
    arch: Arch,
    /// The features of the target, as an `-mattr` flag.
    mattr: &'static str,
    /// The functions to write, each to `<out>/<function>.s`.
    functions: &'static [&'static str],
    /// The MLIR to lower: `common.mlir`, the target's files, and the kernel's own file, except for
    /// a shared file whose body names a type the kernel file gives, which follows that file.
    mlir: String,
}

/// Writes the CRC32C target files, then lowers every kernel for every target.
fn mlir() -> Result<(), String> {
    let dir = mlir_dir();
    let src = root().join("crates/minlz/src");
    let read = |name: &str| fs::read_to_string(dir.join(name)).map_err(|e| format!("{name}: {e}"));
    // Reads `<folder>/<name>.mlir` for each name and returns the files one after the other.
    let read_in = |folder: &str, names: &[&str]| -> Result<String, String> {
        names
            .iter()
            .map(|name| read(&format!("{folder}/{name}.mlir")))
            .collect()
    };
    let common = read("common.mlir")?;
    let mut lowerings = Vec::new();

    let xxh3 = read("xxh3.mlir")?;
    for (target, file, shared, layout, arch, mattr) in XXH3 {
        let file = read(&format!("target/{file}.mlir"))?;
        lowerings.push(Lowering {
            kernel: "xxh3",
            source: "xxh3.mlir",
            target,
            out: src.join("xxh3/mlir").join(target),
            arch,
            mattr,
            functions: &["accum", "blocks"],
            mlir: [
                common.as_str(),
                &file,
                &read_in("target", shared)?,
                &read(arch.prefetch())?,
                &read(layout)?,
                &xxh3,
            ]
            .concat(),
        });
    }

    let crc32c = read("crc32c.mlir")?;
    for (name, text) in crc32c::shared_steps() {
        write(&dir.join("crc32c").join(format!("{name}.mlir")), &text)?;
    }
    for t in &crc32c::TARGETS {
        let file = t.generate();
        write(&dir.join("crc32c").join(format!("{}.mlir", t.file)), &file)?;
        // The target file defines the state type that the steps of the halving chain are written
        // in, so it goes in front of them.
        let arch = read(t.arch_file)?;
        let steps: Result<Vec<String>, String> =
            t.step_files().iter().map(|step| read(step)).collect();
        let kernel = read(t.kernel())?;
        lowerings.push(Lowering {
            kernel: "crc32c",
            source: t.kernel(),
            target: t.dir,
            out: src.join("stream/crc/mlir").join(t.dir),
            arch: t.arch,
            mattr: t.mattr,
            functions: &["update"],
            mlir: [
                common.as_str(),
                &file,
                &arch,
                &read(t.arch.prefetch())?,
                &steps?.join(""),
                &crc32c,
                &kernel,
            ]
            .concat(),
        });
    }

    let stats = read("stats.mlir")?;
    let exec = read("exec.mlir")?;
    let ld = read(LD)?;
    for (target, file, shared, structure, arch, mattr) in BLOCK {
        let out = src.join("block/simd/mlir").join(target);
        let stats_shared = read_in("stats", shared)?;
        let exec_shared = read_in("exec", shared)?;
        lowerings.push(Lowering {
            kernel: "stats",
            source: "stats.mlir",
            target,
            out: out.clone(),
            arch,
            mattr,
            functions: &["tok", "ll", "off"],
            mlir: [
                common.as_str(),
                &read(&format!("stats/{file}.mlir"))?,
                &stats_shared,
                &stats,
                &ld,
            ]
            .concat(),
        });
        lowerings.push(Lowering {
            kernel: "exec",
            source: structure,
            target,
            out: out.join("exec"),
            arch,
            mattr,
            functions: &["plain", "delta", "flat", "flat_delta"],
            mlir: [
                common.as_str(),
                &read(&format!("exec/{file}.mlir"))?,
                &exec_shared,
                &exec,
                &read(structure)?,
                &ld,
            ]
            .concat(),
        });
    }

    let pivco = read("pivco.mlir")?;
    for (target, file, shared, arch, mattr) in PIVCO {
        lowerings.push(Lowering {
            kernel: "pivco",
            source: "pivco.mlir",
            target,
            out: src.join("pivco/kernel/mlir").join(target),
            arch,
            mattr,
            functions: &["exec"],
            mlir: [
                common.as_str(),
                &read(&format!("pivco/{file}.mlir"))?,
                &read_in("pivco", shared)?,
                &pivco,
            ]
            .concat(),
        });
    }

    thread::scope(|s| {
        let runs: Vec<_> = lowerings.iter().map(|l| s.spawn(|| l.run())).collect();
        runs.into_iter()
            .try_for_each(|r| r.join().expect("a lowering panicked"))
    })
}

impl Lowering {
    /// Lowers the MLIR and writes the body of each function.
    fn run(&self) -> Result<(), String> {
        // Every tool reads its input from stdin and writes its output to stdout.
        const IO: [&str; 3] = ["-", "-o", "-"];
        let flags: Vec<&str> = self
            .arch
            .flags()
            .iter()
            .copied()
            .chain([self.mattr])
            .collect();
        let llvm = tool(
            "mlir-opt",
            &[&PASSES[..], &IO].concat(),
            self.mlir.as_bytes(),
        )?;
        let ir = tool(
            "mlir-translate",
            &[&["--mlir-to-llvmir"][..], &IO].concat(),
            &llvm,
        )?;
        // A kernel's body must be whole: MLIR's inliner leaves some calls, and the functions it
        // writes have external linkage, so LLVM's inliner needs a high threshold to take them all.
        // Every function keeps its stack frame above the stack pointer (noredzone): the kernels
        // also run on Windows, which does not reserve the area below it.
        let opt = [
            &[
                "-O3",
                "-inline-threshold=100000",
                "-force-attribute=noredzone",
            ][..],
            &flags,
            &IO,
        ]
        .concat();
        let bc = tool("opt", &opt, &ir)?;
        let llc = [
            &["-O3", "-asm-verbose=false", self.arch.no_jump_tables()][..],
            &flags,
            &IO,
        ]
        .concat();
        let asm = tool("llc", &llc, &bc)?;
        let asm = String::from_utf8(asm).map_err(|e| format!("llc wrote no text: {e}"))?;
        fs::create_dir_all(&self.out).map_err(|e| format!("{}: {e}", self.out.display()))?;
        let (source, target, c) = (self.source, self.target, self.arch.comment());
        for f in self.functions {
            let name = format!("minlz_{}_{f}", self.kernel);
            let body = body::extract(&asm, &name)?;
            let text = format!(
                "{c} {name} of crates/minlz/mlir/{source} for {target}, written by\n\
                 {c} cargo xtask mlir. Do not edit.\n{body}"
            );
            write(&self.out.join(format!("{f}.s")), &text)?;
        }
        Ok(())
    }
}

/// Runs the LLVM tool `name` with `args`, feeds it `input` and returns its output.
fn tool(name: &str, args: &[&str], input: &[u8]) -> Result<Vec<u8>, String> {
    let path = match env::var_os("LLVM_BIN") {
        Some(bin) => Path::new(&bin).join(format!("{name}{}", env::consts::EXE_SUFFIX)),
        None => PathBuf::from(name),
    };
    let mut child = Command::new(&path)
        .args(args)
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .spawn()
        .map_err(|e| format!("{}: {e}", path.display()))?;
    let mut stdin = child.stdin.take().expect("stdin is piped");
    let out = thread::scope(|s| {
        // A failed write means the tool stopped early; its exit status says why.
        s.spawn(move || stdin.write_all(input));
        child.wait_with_output()
    })
    .map_err(|e| format!("{name}: {e}"))?;
    if !out.status.success() {
        return Err(format!("{name} failed: {}", out.status));
    }
    Ok(out.stdout)
}

/// Writes text to path unless the file holds it already, so that cargo does not rebuild the crate
/// for an unchanged file.
fn write(path: &Path, text: &str) -> Result<(), String> {
    if fs::read_to_string(path).is_ok_and(|old| old == text) {
        return Ok(());
    }
    fs::write(path, text).map_err(|e| format!("{}: {e}", path.display()))
}

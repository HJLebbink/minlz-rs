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
        _ => Err("usage: cargo xtask mlir".to_string()),
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

/// The XXH3 targets: the output folder, the target file in `mlir/target/`, the lane layout, the
/// architecture and the features. aarch64 code uses base SVE only: Graviton 3 has 256-bit SVE but
/// no SVE2. AVX-512 code takes no feature beyond AVX-512F, which is all that `xxh3::tiers`
/// checks, and keeps 512-bit vectors whole.
const XXH3: [(&str, &str, &str, Arch, &str); 6] = [
    ("sve128", "sve128", SPLIT, Arch::Arm, "-mattr=+v8.2a,+sve"),
    ("sve256", "sve256", SPLIT, Arch::Arm, "-mattr=+v8.2a,+sve"),
    ("neon", "neon", WHOLE, Arch::Arm, "-mattr=+v8a,+neon"),
    ("sse2", "x86", WHOLE, Arch::X86, "-mattr=+sse2"),
    ("avx2", "x86", WHOLE, Arch::X86, "-mattr=+avx2"),
    (
        "avx512",
        "x86",
        WHOLE,
        Arch::X86,
        "-mattr=+avx512f,-prefer-256-bit",
    ),
];

/// The structure of the operation loops in batches of 64, for x86-64.
const EXEC64: &str = "exec64.mlir";
/// The structure of the operation loops in batches of 8, for aarch64.
const EXEC8: &str = "exec8.mlir";

/// The targets of the block kernels, the statistics and the operation loops: the output folder,
/// the target file in `mlir/stats/` and in `mlir/exec/`, the structure of the operation loops, the
/// architecture and the features, each among those that `block::simd` checks for its tier.
const BLOCK: [(&str, &str, &str, Arch, &str); 3] = [
    ("avx2", "x86_256", EXEC64, Arch::X86, "-mattr=+avx2,+bmi2"),
    (
        "avx512",
        "x86_512",
        EXEC64,
        Arch::X86,
        "-mattr=+avx512f,+avx512bw,+avx512vl,+avx512vbmi,+avx512vbmi2,+bmi2,+popcnt,-prefer-256-bit",
    ),
    ("neon", "neon", EXEC8, Arch::Arm, "-mattr=+v8a,+neon"),
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
    /// The MLIR to lower: `common.mlir`, the target's files, and the kernel's own file last.
    mlir: String,
}

/// Writes the CRC32C target files, then lowers every kernel for every target.
fn mlir() -> Result<(), String> {
    let dir = mlir_dir();
    let src = root().join("crates/minlz/src");
    let read = |name: &str| fs::read_to_string(dir.join(name)).map_err(|e| format!("{name}: {e}"));
    let common = read("common.mlir")?;
    let mut lowerings = Vec::new();

    let xxh3 = read("xxh3.mlir")?;
    for (target, file, layout, arch, mattr) in XXH3 {
        let file = read(&format!("target/{file}.mlir"))?;
        lowerings.push(Lowering {
            kernel: "xxh3",
            source: "xxh3.mlir",
            target,
            out: src.join("xxh3/mlir").join(target),
            arch,
            mattr,
            functions: &["accum", "blocks"],
            mlir: [common.as_str(), &file, &read(layout)?, &xxh3].concat(),
        });
    }

    let crc32c = read("crc32c.mlir")?;
    for t in &crc32c::TARGETS {
        let file = t.generate();
        write(&dir.join("crc32c").join(format!("{}.mlir", t.file)), &file)?;
        lowerings.push(Lowering {
            kernel: "crc32c",
            source: t.kernel(),
            target: t.dir,
            out: src.join("stream/crc/mlir").join(t.dir),
            arch: t.arch,
            mattr: t.mattr,
            functions: &["update"],
            mlir: [common.as_str(), &file, &crc32c, &read(t.kernel())?].concat(),
        });
    }

    let stats = read("stats.mlir")?;
    let exec = read("exec.mlir")?;
    for (target, file, structure, arch, mattr) in BLOCK {
        let out = src.join("block/simd/mlir").join(target);
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
                &stats,
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
                &exec,
                &read(structure)?,
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
        let opt = [&["-O3", "-inline-threshold=100000"][..], &flags, &IO].concat();
        let bc = tool("opt", &opt, &ir)?;
        let llc = [&["-O3", "-asm-verbose=false"][..], &flags, &IO].concat();
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

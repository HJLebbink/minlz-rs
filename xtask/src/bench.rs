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

//! `cargo xtask bench <rev> [--target <triple>] [-- <compare options>]` builds `minlz-bench`
//! against the working tree and against commit `rev`, then runs `minlz-bench compare` with the
//! options after `--`. With `--target` it builds for that target and prints the two binaries
//! instead, to copy to a machine of that target.
//!
//! The base build compiles the working tree's `crates/minlz-bench/src/main.rs` against `rev`'s
//! `crates/minlz`, which `git archive` writes to `target/bench-base/<rev>/tree`, with the release
//! profile of the working tree's `Cargo.toml`.
//!
//! `cargo xtask bench-hw <rev> [--host H] [--lock DIR] [--out FILE] [-- <compare options>]`
//! times this tree against `rev` on every machine and every kernel tier each machine has: here,
//! `minlz-bench compare` per tier pinned to one core at high priority, and on the GB10 (skip it
//! with `--host none`), which receives the two trees and the test data over ssh, builds under its
//! build lock and times under its exclusive lock on the big and the little core. It prints one
//! table per machine and core and the geometric mean per tier, and writes them to `--out`. The
//! compare options (default `--only block-decode`) go to every `minlz-bench compare` run. With
//! `--lock DIR` it holds that directory, waiting while it exists, during the local timing only.

use std::fs;
use std::path::{Path, PathBuf};
use std::process::{Command, Stdio};
use std::time::Duration;
use std::{env, thread};

#[cfg(windows)]
use std::os::windows::process::CommandExt;

use crate::root;

/// Runs `bench` with the arguments after its name.
pub fn bench(args: &[&str]) -> Result<(), String> {
    let usage = "usage: cargo xtask bench <rev> [--target <triple>] [-- <compare options>]";
    let (ours, compare) = match args.iter().position(|a| *a == "--") {
        Some(i) => (&args[..i], &args[i + 1..]),
        None => (args, &[][..]),
    };
    let (rev, target) = match ours {
        [rev] => (*rev, None),
        [rev, "--target", t] => (*rev, Some(*t)),
        _ => return Err(usage.to_string()),
    };
    // Own target folders: the cargo that runs this task may hold the workspace's.
    let ours = build(root(), &root().join("target").join("bench"), target)?;
    let base = build_base(rev, target)?;
    match target {
        Some(_) => {
            println!("this build: {}", ours.display());
            println!("base build ({rev}): {}", base.display());
            Ok(())
        }
        None => {
            let base = base.to_str().ok_or("base path is not UTF-8")?;
            run(Command::new(&ours).arg("compare").arg(base).args(compare))
        }
    }
}

/// Builds minlz-bench of the workspace or package at dir into target_dir, and returns the binary.
fn build(dir: &Path, target_dir: &Path, target: Option<&str>) -> Result<PathBuf, String> {
    let mut cargo = Command::new(env!("CARGO"));
    cargo
        .current_dir(dir)
        .args(["build", "--release", "-p", "minlz-bench"]);
    cargo.env("CARGO_TARGET_DIR", target_dir);
    let mut out = target_dir.to_path_buf();
    if let Some(t) = target {
        cargo.args(["--target", t]);
        out.push(t);
    }
    run(&mut cargo)?;
    let exe = if target.is_none_or(|t| t.contains("windows")) {
        std::env::consts::EXE_SUFFIX
    } else {
        ""
    };
    Ok(out.join("release").join(format!("minlz-bench{exe}")))
}

/// Writes rev's tree and a package that builds minlz-bench against it to
/// target/bench-base/<rev>/{tree,bench}, builds it, and returns the binary.
fn build_base(rev: &str, target: Option<&str>) -> Result<PathBuf, String> {
    let dir = base_dir(rev);
    if dir.join("tree").exists() {
        fs::remove_dir_all(dir.join("tree")).map_err(|e| format!("{}: {e}", dir.display()))?;
    }
    write_base(rev, &dir)?;
    build(&dir.join("bench"), &dir.join("target"), target)
}

/// The folder `write_base` lays rev's base build out in.
fn base_dir(rev: &str) -> PathBuf {
    let name: String = rev
        .chars()
        .map(|c| if c.is_ascii_alphanumeric() { c } else { '-' })
        .collect();
    root().join("target").join("bench-base").join(name)
}

/// Writes rev's tree (without testdata) and, beside it, the bench package: the working tree's
/// minlz-bench main.rs and a manifest that builds it against rev's crates/minlz with this
/// workspace's release profile. Both are laid out with relative paths only, so the whole folder
/// can be sent to a remote machine and built there as it is.
fn write_base(rev: &str, dir: &Path) -> Result<(), String> {
    let tree = dir.join("tree");
    fs::create_dir_all(&tree).map_err(|e| format!("{}: {e}", tree.display()))?;
    // tar reads a relative path, which every tar takes: GNU tar reads a colon as a remote host.
    let mut archive = Command::new("git")
        .current_dir(root())
        .args([
            "archive",
            "--format=tar",
            rev,
            "--",
            ".",
            ":(exclude)testdata",
        ])
        .stdout(Stdio::piped())
        .spawn()
        .map_err(|e| format!("git: {e}"))?;
    let tar = run(Command::new("tar")
        .current_dir(&tree)
        .args(["-xf", "-"])
        .stdin(archive.stdout.take().ok_or("git stdout")?));
    let git = archive.wait().map_err(|e| format!("git: {e}"))?;
    if !git.success() {
        return Err(format!("git archive {rev} failed: {git}"));
    }
    tar?;

    let manifest =
        fs::read_to_string(root().join("Cargo.toml")).map_err(|e| format!("Cargo.toml: {e}"))?;
    let profile = release_profile(&manifest).ok_or("Cargo.toml has no [profile.release]")?;
    let main = fs::read_to_string(root().join("crates/minlz-bench/src/main.rs"))
        .map_err(|e| format!("main.rs: {e}"))?;
    let text = format!(
        "# Written by cargo xtask bench: minlz-bench against commit {rev}.\n\
         [package]\nname = \"minlz-bench\"\nversion = \"0.0.0\"\nedition = \"2024\"\npublish = false\n\n\
         [[bin]]\nname = \"minlz-bench\"\npath = \"src/main.rs\"\n\n\
         [dependencies]\nminlz = {{ package = \"minio-minlz\", path = \"../tree/crates/minlz\" }}\n\n\
         [workspace]\n\n{profile}",
    );
    // The package is a sibling of the tree: cargo makes a path dependency below a workspace root
    // a member of that workspace, and rev's crate must take its settings from rev's workspace.
    let pkg = dir.join("bench");
    fs::create_dir_all(pkg.join("src")).map_err(|e| format!("{}: {e}", pkg.display()))?;
    crate::write(&pkg.join("Cargo.toml"), &text)?;
    crate::write(&pkg.join("src").join("main.rs"), &main)
}

/// Returns the `[profile.release]` table of a manifest, up to the next table.
fn release_profile(manifest: &str) -> Option<String> {
    let start = manifest.find("[profile.release]")?;
    let rest = &manifest[start..];
    let end = rest[1..].find("\n[").map_or(rest.len(), |i| i + 2);
    Some(rest[..end].to_string())
}

/// Runs cmd with the output on the terminal, and fails when it fails.
fn run(cmd: &mut Command) -> Result<(), String> {
    let status = cmd
        .status()
        .map_err(|e| format!("{:?}: {e}", cmd.get_program()))?;
    if status.success() {
        Ok(())
    } else {
        Err(format!("{:?} failed: {status}", cmd.get_program()))
    }
}

/// Runs `bench-hw` with the arguments after its name.
pub fn bench_hw(args: &[&str]) -> Result<(), String> {
    let usage = "usage: cargo xtask bench-hw <rev> [--host H] [--lock DIR] [--out FILE] \
                 [-- <compare options>]";
    let (ours, compare) = match args.iter().position(|a| *a == "--") {
        Some(i) => (&args[..i], &args[i + 1..]),
        None => (args, &[][..]),
    };
    // Every run defaults to the block-decode cases, the ones both builds gate identically at any
    // tier. minlz-bench keeps the last --only, so one after the -- wins over this default.
    let mut opts: Vec<&str> = vec!["--only", "block-decode"];
    opts.extend_from_slice(compare);
    let (mut rev, mut host, mut lock, mut out): (Option<&str>, &str, Option<&str>, Option<&str>) =
        (None, "gb10", None, None);
    let mut i = 0;
    while i < ours.len() {
        match ours[i] {
            "--host" if i + 1 < ours.len() => {
                host = ours[i + 1];
                i += 2;
            }
            "--lock" if i + 1 < ours.len() => {
                lock = Some(ours[i + 1]);
                i += 2;
            }
            "--out" if i + 1 < ours.len() => {
                out = Some(ours[i + 1]);
                i += 2;
            }
            a if rev.is_none() && !a.starts_with("--") => {
                rev = Some(a);
                i += 1;
            }
            _ => return Err(usage.to_string()),
        }
    }
    let rev = rev.ok_or(usage)?;
    let data = testdata()?;
    // Build both as bench does, before the lock: only the timing is held.
    let ours_exe = build(root(), &root().join("target").join("bench"), None)?;
    let base_exe = build_base(rev, None)?;
    let mut report = format!(
        "# bench-hw: the working tree over commit {rev}\n\n\
                              One `minlz-bench compare` per kernel tier, options: {}\n\n",
        opts.join(" ")
    );
    // Each phase adds its section and rewrites --out, so an interrupted run leaves what it timed.
    let flush = |report: &str| match out {
        Some(o) => fs::write(o, report).map_err(|e| format!("{o}: {e}")),
        None => Ok(()),
    };

    let timed = with_lock(lock.map(Path::new), || {
        let mut runs: Runs = Vec::new();
        for t in tiers(&ours_exe)? {
            let rows = compare_pinned(&ours_exe, &base_exe, &t, &opts, &data)?;
            runs.push((t, rows));
        }
        Ok(runs)
    })?;
    report += &machine_table("local, core 5", &timed);
    flush(&report)?;

    if host != "none" {
        report += &remote_timings(host, &opts, &base_dir(rev), &data)?;
        flush(&report)?;
    }
    print!("{report}");
    Ok(())
}

/// The folder of the test data: `MINLZ_TESTDATA`, or the workspace's `testdata`.
fn testdata() -> Result<PathBuf, String> {
    let d = match env::var_os("MINLZ_TESTDATA") {
        Some(d) => PathBuf::from(d),
        None => root().join("testdata"),
    };
    if d.is_dir() {
        Ok(d)
    } else {
        Err(format!(
            "{}: no test data (it is not in git; set MINLZ_TESTDATA)",
            d.display()
        ))
    }
}

/// Creates the lock directory, waiting while it exists, runs f, and removes the directory.
fn with_lock<T>(dir: Option<&Path>, f: impl FnOnce() -> Result<T, String>) -> Result<T, String> {
    if let Some(d) = dir {
        while fs::create_dir(d).is_err() {
            if !d.exists() {
                return Err(format!("{}: cannot take the lock", d.display()));
            }
            println!("waiting for the lock {}", d.display());
            thread::sleep(Duration::from_secs(15));
        }
    }
    let result = f();
    if let Some(d) = dir {
        let _ = fs::remove_dir(d);
    }
    result
}

/// Returns the kernel tiers to time on this machine: the lines of `<exe> tiers`.
fn tiers(exe: &Path) -> Result<Vec<String>, String> {
    let out = Command::new(exe)
        .arg("tiers")
        .output()
        .map_err(|e| format!("{}: {e}", exe.display()))?;
    if !out.status.success() {
        return Err(format!("{} tiers: {}", exe.display(), out.status));
    }
    Ok(String::from_utf8_lossy(&out.stdout)
        .lines()
        .map(str::to_string)
        .collect())
}

/// One row of a `minlz-bench compare` table, kept to print with a Tier column added.
struct Row {
    case: String,
    base: f64,
    this: f64,
    ratio: f64,
}

/// The rows a machine timed, per tier.
type Runs = Vec<(String, Vec<Row>)>;

/// Returns the table rows of one `minlz-bench compare` output.
fn parse_compare(text: &str) -> Vec<Row> {
    let mut v = Vec::new();
    for l in text.lines().filter(|l| l.starts_with("| ")) {
        let c: Vec<&str> = l.split('|').map(str::trim).collect();
        // | case | base | this | ratio | range |, the header and separator failing the parses.
        if c.len() < 5 {
            continue;
        }
        if let (Ok(base), Ok(this), Ok(ratio)) = (
            c[2].parse::<f64>(),
            c[3].parse::<f64>(),
            c[4].parse::<f64>(),
        ) {
            v.push(Row {
                case: c[1].to_string(),
                base,
                this,
                ratio,
            });
        }
    }
    v
}

/// The markdown for one machine or core: all its runs in one table, then the geometric mean of
/// the ratios of each tier.
fn machine_table(machine: &str, runs: &Runs) -> String {
    let mut s = format!(
        "## {machine}\n\n| Case | Tier | Base MB/s | This MB/s | Ratio |\n\
                         | --- | --- | ---: | ---: | ---: |\n"
    );
    for (tier, rows) in runs {
        for r in rows {
            s += &format!(
                "| {} | {tier} | {:.0} | {:.0} | {:.3} |\n",
                r.case, r.base, r.this, r.ratio
            );
        }
    }
    for (tier, rows) in runs {
        if !rows.is_empty() {
            let g = (rows.iter().map(|r| r.ratio.ln()).sum::<f64>() / rows.len() as f64).exp();
            s += &format!("\nGeometric mean, {tier}: {g:.3}");
        }
    }
    s + "\n\n"
}

/// Runs `minlz-bench compare` of ours over base at tier, pinned to one core at high priority
/// with the test data of dir, and returns the table rows it printed.
#[cfg(windows)]
fn compare_pinned(
    ours: &Path,
    base: &Path,
    tier: &str,
    opts: &[&str],
    dir: &Path,
) -> Result<Vec<Row>, String> {
    // As x86-pin.ps1: /affinity 20 (0x20) pins to CPU 5, /high runs at high priority, and the
    // redirect to a file is how the run's output is read back through start.
    let tmp = env::temp_dir().join(format!("minlz-bench-hw-{}.txt", std::process::id()));
    let quote = |p: &Path| format!("\"{}\"", p.display());
    let mut cmd = format!(
        "start \"pin\" /b /wait /high /affinity 20 {} compare {} --tier {tier} {}",
        quote(ours),
        quote(base),
        opts.join(" ")
    );
    cmd += &format!(" > {} 2>&1", quote(&tmp));
    // raw_arg: cmd must receive the line exactly as written, for cmd's own quoting rules.
    let status = Command::new("cmd")
        .raw_arg(format!("/c {cmd}"))
        .env("MINLZ_TESTDATA", dir)
        .status()
        .map_err(|e| format!("cmd: {e}"))?;
    let text = fs::read_to_string(&tmp).unwrap_or_default();
    let _ = fs::remove_file(&tmp);
    // start does not pass on the exit code of the program it starts, so a failed run shows up
    // only as a table without rows.
    let rows = parse_compare(&text);
    if !status.success() || rows.is_empty() {
        return Err(format!("compare --tier {tier} failed: {status}\n{text}"));
    }
    Ok(rows)
}

/// Runs `minlz-bench compare` of ours over base at tier, pinned to core 5 of this machine with
/// the test data of dir, and returns the table rows it printed.
#[cfg(not(windows))]
fn compare_pinned(
    ours: &Path,
    base: &Path,
    tier: &str,
    opts: &[&str],
    dir: &Path,
) -> Result<Vec<Row>, String> {
    let out = Command::new("taskset")
        .args(["-c", "5"])
        .arg(ours)
        .args(["compare", base.to_str().ok_or("base path is not UTF-8")?])
        .args(["--tier", tier])
        .args(opts)
        .env("MINLZ_TESTDATA", dir)
        .output()
        .map_err(|e| format!("taskset: {e}"))?;
    if !out.status.success() {
        return Err(format!(
            "compare --tier {tier} failed: {}\n{}{}",
            out.status,
            String::from_utf8_lossy(&out.stdout),
            String::from_utf8_lossy(&out.stderr)
        ));
    }
    Ok(parse_compare(&String::from_utf8_lossy(&out.stdout)))
}

/// Times the working tree over base's tree on a remote aarch64 machine: sends both trees and the
/// test data, builds under the shared build lock, and times every tier on the big and the little
/// core under the exclusive lock, and returns one markdown table per core.
fn remote_timings(host: &str, opts: &[&str], base: &Path, dir: &Path) -> Result<String, String> {
    let name = root()
        .file_name()
        .ok_or("the workspace root has no name")?
        .to_string_lossy()
        .replace(|c: char| !c.is_ascii_alphanumeric(), "-");
    let home = format!("~/minlz-bench-hw/{name}");
    let build_log = |d: &str, tgt: &str| {
        format!(
            "cd {d} && CARGO_TARGET_DIR=~/minlz-bench-hw/targets/{tgt} \
             nice -n 10 ~/.cargo/bin/cargo build -q -j 4 --release -p minlz-bench"
        )
    };
    send_tree(
        host,
        root(),
        &format!("{home}/work"),
        &[
            "--exclude=./target",
            "--exclude=./.git",
            "--exclude=./*/target",
        ],
    )?;
    send_tree(host, base, &format!("{home}/base"), &["--exclude=./target"])?;
    run(Command::new("ssh").arg(host).arg(format!(
        "flock -s /tmp/minlz-gb10.lock bash -c 'set -e\n{}\n{}'",
        build_log(&format!("{home}/work"), &name),
        build_log(&format!("{home}/base/bench"), &format!("{name}-base")),
    )))?;
    send_tree(host, dir, &format!("{home}/testdata"), &[])?;

    let mut script = String::from("flock -x /tmp/minlz-gb10.lock bash -c 'set -e\n");
    let this = format!("~/minlz-bench-hw/targets/{name}/release/minlz-bench");
    let base_exe = format!("~/minlz-bench-hw/targets/{name}-base/release/minlz-bench");
    for core in ["8", "2"] {
        script += &format!(
            "for tier in $({this} tiers); do\n\
             echo \"## core {core} tier $tier\"\n\
             MINLZ_TESTDATA={home}/testdata taskset -c {core} {this} compare {base_exe} \
             --tier $tier {}\n\
             done\n",
            opts.join(" ")
        );
    }
    script += "'";
    let out = Command::new("ssh")
        .arg(host)
        .arg(script)
        .output()
        .map_err(|e| format!("ssh: {e}"))?;
    if !out.status.success() {
        return Err(format!(
            "ssh {host}: {}\n{}",
            out.status,
            String::from_utf8_lossy(&out.stderr)
        ));
    }
    // The output holds one compare table per core and tier, each after its `## core` marker.
    let mut cores: Vec<(String, Runs)> = Vec::new();
    for l in String::from_utf8_lossy(&out.stdout).lines() {
        if let Some(rest) = l.strip_prefix("## core ") {
            let w: Vec<&str> = rest.split_whitespace().collect();
            if w.len() == 3 && w[1] == "tier" {
                match &mut cores.last_mut() {
                    Some((c, runs)) if *c == w[0] => runs.push((w[2].to_string(), Vec::new())),
                    _ => cores.push((w[0].to_string(), vec![(w[2].to_string(), Vec::new())])),
                }
            }
        } else if l.starts_with("| ")
            && let Some((_, runs)) = cores.last_mut()
            && let Some((_, held)) = runs.last_mut()
        {
            held.extend(parse_compare(l));
        }
    }
    let mut report = String::new();
    for (core, runs) in &cores {
        let cpu = match core.as_str() {
            "8" => " (Cortex-X925)",
            "2" => " (Cortex-A725)",
            _ => "",
        };
        report += &machine_table(&format!("{host}, core {core}{cpu}"), runs);
    }
    Ok(report)
}

/// Tars the contents of dir, with the tar options, through ssh into the remote path, replacing
/// that path.
fn send_tree(host: &str, dir: &Path, remote: &str, exclude: &[&str]) -> Result<(), String> {
    let mut tar = Command::new("tar")
        .current_dir(dir)
        .args(["cf", "-"])
        .args(exclude)
        .arg(".")
        .stdout(Stdio::piped())
        .spawn()
        .map_err(|e| format!("tar: {e}"))?;
    let ssh = Command::new("ssh")
        .arg(host)
        .arg(format!(
            "rm -rf {remote} && mkdir -p {remote} && tar xf - -C {remote}"
        ))
        .stdin(tar.stdout.take().ok_or("tar stdout")?)
        .stderr(Stdio::piped())
        .spawn()
        .map_err(|e| format!("ssh: {e}"))?;
    let t = tar.wait().map_err(|e| format!("tar: {e}"))?;
    let s = ssh.wait_with_output().map_err(|e| format!("ssh: {e}"))?;
    if !t.success() {
        return Err(format!("tar of {} failed: {t}", dir.display()));
    }
    if !s.status.success() {
        return Err(format!(
            "ssh {host} to {remote}: {}\n{}",
            s.status,
            String::from_utf8_lossy(&s.stderr)
        ));
    }
    Ok(())
}

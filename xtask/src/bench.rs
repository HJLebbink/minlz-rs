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

use std::fs;
use std::path::{Path, PathBuf};
use std::process::{Command, Stdio};

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
    let name: String = rev
        .chars()
        .map(|c| if c.is_ascii_alphanumeric() { c } else { '-' })
        .collect();
    let dir = root().join("target").join("bench-base").join(name);
    let tree = dir.join("tree");
    if tree.exists() {
        fs::remove_dir_all(&tree).map_err(|e| format!("{}: {e}", tree.display()))?;
    }
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
    let main = root().join("crates/minlz-bench/src/main.rs");
    let text = format!(
        "# Written by cargo xtask bench: minlz-bench against commit {rev}.\n\
         [package]\nname = \"minlz-bench\"\nversion = \"0.0.0\"\nedition = \"2024\"\npublish = false\n\n\
         [[bin]]\nname = \"minlz-bench\"\npath = '{}'\n\n\
         [dependencies]\nminlz = {{ package = \"minio-minlz\", path = \"../tree/crates/minlz\" }}\n\n\
         [workspace]\n\n{profile}",
        main.display()
    );
    // The package is a sibling of the tree: cargo makes a path dependency below a workspace root
    // a member of that workspace, and rev's crate must take its settings from rev's workspace.
    let pkg = dir.join("bench");
    fs::create_dir_all(&pkg).map_err(|e| format!("{}: {e}", pkg.display()))?;
    crate::write(&pkg.join("Cargo.toml"), &text)?;
    build(&pkg, &dir.join("target"), target)
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

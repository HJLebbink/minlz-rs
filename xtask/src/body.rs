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

//! Turns the assembly that `llc -asm-verbose=false` writes into the body of a Rust naked
//! function.
//!
//! Rust may put two copies of a naked function in one assembly unit (two crate versions under
//! LTO), so the body must define no named symbol or label. Each `.LBB` label becomes a numeric
//! local label, and each reference to it becomes `Nf` or `Nb` by where the label lies. The
//! constant pool entries (`.LCPI`) that the body uses follow the body, in the same section, under
//! numeric labels of their own. All numbers end in 2, so the x86 Intel syntax never reads one as
//! binary. CFI directives are dropped.

use std::collections::HashMap;

/// A constant pool entry: the alignment directive in front of it and its data lines.
struct Pool<'a> {
    align: &'a str,
    data: Vec<&'a str>,
}

/// Returns the body of the function `name` in `asm`.
pub fn extract(asm: &str, name: &str) -> Result<String, String> {
    let start = format!("{name}:");
    let mut pools: HashMap<&str, Pool> = HashMap::new();
    let mut align = "";
    let mut pool: Option<&str> = None;
    let mut lines = Vec::new();
    // Each label's number and the index of the line where it lies.
    let mut labels: HashMap<&str, (u32, usize)> = HashMap::new();
    let mut n_labels = 0;
    let mut found = false;
    let mut inside = false;
    for line in asm.lines() {
        let directive = line.trim_start_matches([' ', '\t']);
        if line.starts_with(&start) {
            (inside, found) = (true, true);
        } else if inside {
            if line.starts_with(".Lfunc_end") {
                inside = false;
            } else if !directive.is_empty() && !directive.starts_with(".cfi_") {
                if let Some(label) = definition(line, ".LBB") {
                    n_labels += 1;
                    labels.insert(label, (10 * n_labels - 8, lines.len()));
                }
                lines.push(line);
            }
        } else if let Some(label) = definition(line, ".LCPI") {
            pools.insert(
                label,
                Pool {
                    align,
                    data: Vec::new(),
                },
            );
            pool = Some(label);
        } else if directive.starts_with(".p2align") {
            align = line;
            pool = None;
        } else if let Some(p) = pool.filter(|_| is_data(directive)) {
            pools.get_mut(p).expect("pool is an entry").data.push(line);
        } else if !directive.is_empty() {
            pool = None;
        }
    }
    if !found {
        return Err(format!("no function {name}"));
    }
    // The body is the whole kernel: a call would name a function outside it.
    if let Some(call) = lines.iter().find(|l| {
        let mnemonic = l.split_whitespace().next().unwrap_or("");
        matches!(mnemonic, "call" | "bl" | "blr")
    }) {
        return Err(format!("{name} calls out of its body: {}", call.trim()));
    }

    let mut out = String::new();
    let mut used = Vec::new();
    for (i, line) in lines.iter().enumerate() {
        if let Some(label) = definition(line, ".LBB") {
            out += &format!("{}:\n", labels[label].0);
            continue;
        }
        let mut rest = *line;
        while let Some((at, len)) = reference(rest) {
            let label = &rest[at..at + len];
            if !labels.contains_key(label) {
                if !pools.contains_key(label) {
                    return Err(format!("{name} refers to {label}, defined elsewhere"));
                }
                // A pool entry gets its number at its first use and comes after every line.
                n_labels += 1;
                labels.insert(label, (10 * n_labels - 8, lines.len()));
                used.push(label);
            }
            let (n, def) = labels[label];
            out += &rest[..at];
            out += &format!("{n}{}", if def > i { "f" } else { "b" });
            rest = &rest[at + len..];
        }
        out += rest;
        out.push('\n');
    }
    for label in used {
        let pool = &pools[label];
        if !pool.align.is_empty() {
            out += pool.align;
            out.push('\n');
        }
        out += &format!("{}:\n", labels[label].0);
        for d in &pool.data {
            out += d;
            out.push('\n');
        }
    }
    Ok(out)
}

/// Returns the label that line defines, when it starts with prefix, digits and a colon.
fn definition<'a>(line: &'a str, prefix: &str) -> Option<&'a str> {
    let n = label_len(line, prefix)?;
    line[n..].starts_with(':').then(|| &line[..n])
}

/// Returns the length of the label at the start of s: prefix and then digits or underscores.
fn label_len(s: &str, prefix: &str) -> Option<usize> {
    let digits = s
        .strip_prefix(prefix)?
        .bytes()
        .take_while(|&c| c.is_ascii_digit() || c == b'_');
    match digits.count() {
        0 => None,
        n => Some(prefix.len() + n),
    }
}

/// Returns the offset and length of the first `.LBB` or `.LCPI` label that s refers to.
fn reference(s: &str) -> Option<(usize, usize)> {
    s.match_indices(".L").find_map(|(at, _)| {
        let n = label_len(&s[at..], ".LBB").or_else(|| label_len(&s[at..], ".LCPI"))?;
        Some((at, n))
    })
}

/// Reports whether a line, without its indentation, holds constant pool data.
fn is_data(directive: &str) -> bool {
    [".quad", ".long", ".short", ".byte", ".zero", ".space"]
        .iter()
        .any(|d| {
            directive
                .strip_prefix(d)
                .is_some_and(|rest| rest.starts_with([' ', '\t']))
        })
}

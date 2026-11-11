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
//! functions of the same assembly that the kernel calls follow its body, each under a numeric
//! label that its calls name; a call to anything else is an error. The constant pool entries
//! (`.LCPI`) that the bodies use come last, in the same section, under numeric labels of their own.
//! All numbers end in 2, so the x86 Intel syntax never reads one as binary. CFI directives are
//! dropped.

use std::collections::HashMap;

/// A constant pool entry: the alignment directive in front of it and its data lines.
struct Pool<'a> {
    align: &'a str,
    data: Vec<&'a str>,
}

/// Returns the body of the function `name` in `asm`, followed by the functions it calls.
pub fn extract(asm: &str, name: &str) -> Result<String, String> {
    let mut pools: HashMap<&str, Pool> = HashMap::new();
    let mut align = "";
    let mut pool: Option<&str> = None;
    // The lines of each function, from its label on.
    let mut functions: HashMap<&str, Vec<&str>> = HashMap::new();
    let mut inside: Option<&str> = None;
    for line in asm.lines() {
        let directive = line.trim_start_matches([' ', '\t']);
        if let Some(f) = inside {
            if line.starts_with(".Lfunc_end") {
                inside = None;
            } else if !directive.is_empty() && !directive.starts_with(".cfi_") {
                functions.get_mut(f).expect("f is a function").push(line);
            }
        } else if let Some(f) = function(line) {
            functions.insert(f, vec![line]);
            inside = Some(f);
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
    if !functions.contains_key(name) {
        return Err(format!("no function {name}"));
    }
    // The kernel and the functions it calls, in the order of their first call.
    let mut order = vec![name];
    let mut k = 0;
    while k < order.len() {
        for line in &functions[order[k]] {
            let Some(callee) = callee(line) else {
                continue;
            };
            if !functions.contains_key(callee) {
                return Err(format!(
                    "{} calls out of its body: {}",
                    order[k],
                    line.trim()
                ));
            }
            if !order.contains(&callee) {
                order.push(callee);
            }
        }
        k += 1;
    }
    // The lines of the body, without the kernel's own label, and each label's number and the index
    // of the line where it lies.
    let mut lines = Vec::new();
    let mut labels: HashMap<&str, (u32, usize)> = HashMap::new();
    let mut n_labels = 0;
    for (k, f) in order.iter().enumerate() {
        for (j, line) in functions[f].iter().enumerate() {
            if j == 0 && k == 0 {
                continue;
            }
            if let Some(label) = definition(line, ".LBB").or((j == 0).then_some(*f)) {
                n_labels += 1;
                labels.insert(label, (10 * n_labels - 8, lines.len()));
            }
            lines.push(*line);
        }
    }

    let mut out = String::new();
    let mut used = Vec::new();
    for (i, line) in lines.iter().enumerate() {
        if let Some(label) = definition(line, ".LBB") {
            out += &format!("{}:\n", labels[label].0);
            continue;
        }
        if let Some(f) = function(line) {
            out += &format!("\t.p2align\t4\n{}:\n", labels[f].0);
            continue;
        }
        if let Some(f) = callee(line) {
            let at = line.rfind(f).expect("the line names its callee");
            let (n, def) = labels[f];
            out += &format!("{}{n}{}\n", &line[..at], if def > i { "f" } else { "b" });
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
        // A pool without data has data directives this file does not know; the body would read
        // whatever follows it.
        if pool.data.is_empty() {
            return Err(format!(
                "{name}: constant pool {label} has no data this tool knows"
            ));
        }
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

/// Returns the function that line starts: a name and a colon at the start of the line, which is
/// not a label of llc's own (`.L`).
fn function(line: &str) -> Option<&str> {
    let name = line.strip_suffix(':')?;
    let ok = !name.starts_with(".L")
        && !name.is_empty()
        && name
            .bytes()
            .all(|c| c.is_ascii_alphanumeric() || matches!(c, b'_' | b'.' | b'$'));
    ok.then_some(name)
}

/// Returns the function that line calls or jumps to: the target of a call or branch that is not a
/// label of llc's own (`.L`), without the `@PLT` of a call through the PLT.
fn callee(line: &str) -> Option<&str> {
    let mut words = line.split_whitespace();
    let mnemonic = words.next()?;
    let branch = matches!(mnemonic, "call" | "bl" | "blr" | "b")
        || mnemonic.starts_with('j')
        || mnemonic.starts_with("b.");
    if !branch {
        return None;
    }
    let target = words.last().unwrap_or(mnemonic);
    let target = target.strip_suffix("@PLT").unwrap_or(target);
    (!target.starts_with(".L")).then_some(target)
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

/// Reports whether a line, without its indentation, holds constant pool data: the x86-64 and the
/// AArch64 names of 8, 4, 2 and 1 bytes, and zero fill.
fn is_data(directive: &str) -> bool {
    [
        ".quad", ".xword", ".long", ".word", ".short", ".hword", ".byte", ".zero", ".space",
    ]
    .iter()
    .any(|d| {
        directive
            .strip_prefix(d)
            .is_some_and(|rest| rest.starts_with([' ', '\t']))
    })
}

#[cfg(test)]
mod tests {
    use super::extract;

    /// A kernel that calls a function of the same assembly gets that function's body after its
    /// own, under a numeric label that the call names; a call to anything else is an error.
    #[test]
    fn calls() {
        let asm = "\t.type\tkernel,@function\nkernel:\n\tcall\twork\n\tret\n.Lfunc_end0:\n\
                   \t.type\twork,@function\nwork:\n\tjmp\t.LBB1_1\n.LBB1_1:\n\tret\n.Lfunc_end1:\n";
        let body = extract(asm, "kernel").expect("work is in the assembly");
        assert_eq!(
            body,
            "\tcall\t2f\n\tret\n\t.p2align\t4\n2:\n\tjmp\t12f\n12:\n\tret\n"
        );
        let out = asm.replace("call\twork", "call\tmemcpy@PLT");
        let err = extract(&out, "kernel").expect_err("memcpy is not in the assembly");
        assert!(err.contains("calls out of its body"), "{err}");
    }
}

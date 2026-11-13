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

//! The CRC32C target files, in `crates/minlz/mlir/crc32c/`: per target, how it computes the CRC,
//! the sizes and keys that implies, and the carry-less multiply of its register. The instructions
//! that the targets of an architecture share are in the hand-written `crc32c_x86.mlir` and
//! `crc32c_arm.mlir`. The steps of the halving chain of `crc32c_fold.mlir` are generated too: one
//! file `crc32c/halves_*.mlir` holds each step, shared by every target that uses it, and the
//! steps of one target only are in that target's file. A step is named for the words it halves,
//! and so is the register leaf, which the target file holds.
//!
//! A key multiplies by x^d modulo P, the CRC32C polynomial. For a 64-bit word it is x^(d-1) mod P,
//! reflected into 64 bits (`crc32c_fold.mlir` says why); `crc32c_chains.mlir` uses a 32-bit form.
//! d may be negative, as x has an inverse modulo P. The tests in `crates/minlz/src/stream/crc.rs`
//! check the keys against a table CRC.

use std::fmt::Write;

use crate::Arch;

/// How a target computes the CRC.
#[derive(Clone, Copy)]
pub enum Kind {
    /// `crc32c_fold.mlir`: folding with carry-less multiplies on `lanes` lanes of 128 bits in
    /// vectors of `bits` bits, beside three CRC32 chains of k words per fold, in blocks of
    /// `iters` folds. Inputs below `min_len` bytes take one CRC32 chain. `sve2` is the target's
    /// SVE2 tier: its comment names SVE2, and at `true` its carry-less multiplies are
    /// `pmullb` and `pmullt`.
    Fold {
        bits: u32,
        lanes: u32,
        k: u32,
        iters: u32,
        min_len: u32,
        sve2: bool,
    },
    /// `crc32c_chains.mlir`: three CRC32 chains over neighboring regions of `bytes` bytes.
    Chains { bytes: u32 },
}

/// A CRC32C target.
pub struct Target {
    /// The output folder in `crates/minlz/src/stream/crc/mlir/`.
    pub dir: &'static str,
    /// The target file in `crates/minlz/mlir/crc32c/`, without `.mlir`.
    pub file: &'static str,
    pub arch: Arch,
    pub kind: Kind,
    /// The features of the target, as an `-mattr` flag.
    pub mattr: &'static str,
    /// The hand-written file of `mlir/` that holds the instructions of the architecture: the CRC32
    /// instructions and `@clmul`.
    pub arch_file: &'static str,
}

/// The targets, each with only the features that `stream::crc` checks for it.
///
/// k and I were measured on Sapphire Rapids and on GB10's Cortex-X925 and Cortex-A725 cores: more
/// CRC32 words per fold help cores that multiply on one pipe and slow those that multiply on two;
/// I = 8 keeps blocks short enough to fold inputs of 2 KiB. Below `min_len`, combining the lanes
/// and reducing them costs more than folding saves. With PCLMULQDQ and PMULL it is also a whole
/// block: Neoverse N-class cores multiply on one pipe, so folding alone is no faster there than
/// CRC32, and only the block's CRC32 chains gain.
pub const TARGETS: [Target; 7] = [
    Target {
        dir: "sse42",
        file: "sse42",
        arch: Arch::X86,
        kind: Kind::Chains { bytes: 1024 },
        mattr: "-mattr=+sse4.2,+crc32",
        arch_file: "crc32c_x86.mlir",
    },
    Target {
        dir: "pclmul",
        file: "x86_128",
        arch: Arch::X86,
        kind: Kind::Fold {
            bits: 128,
            lanes: 8,
            k: 4,
            iters: 8,
            min_len: 2048,
            sve2: false,
        },
        mattr: "-mattr=+sse4.2,+crc32,+pclmul",
        arch_file: "crc32c_x86.mlir",
    },
    Target {
        dir: "avx2",
        file: "x86_256",
        arch: Arch::X86,
        kind: Kind::Fold {
            bits: 256,
            lanes: 8,
            k: 4,
            iters: 8,
            min_len: 1024,
            sve2: false,
        },
        mattr: "-mattr=+avx2,+crc32,+pclmul,+vpclmulqdq",
        arch_file: "crc32c_x86.mlir",
    },
    Target {
        dir: "avx512",
        file: "x86_512",
        arch: Arch::X86,
        kind: Kind::Fold {
            bits: 512,
            lanes: 16,
            k: 2,
            iters: 16,
            min_len: 1024,
            sve2: false,
        },
        mattr: "-mattr=+avx512f,+crc32,+pclmul,+vpclmulqdq,-prefer-256-bit",
        arch_file: "crc32c_x86.mlir",
    },
    Target {
        dir: "crc",
        file: "crc",
        arch: Arch::Arm,
        kind: Kind::Chains { bytes: 1024 },
        mattr: "-mattr=+v8a,+crc",
        arch_file: "crc32c_arm.mlir",
    },
    Target {
        dir: "neon",
        file: "neon",
        arch: Arch::Arm,
        kind: Kind::Fold {
            bits: 128,
            lanes: 8,
            k: 4,
            iters: 8,
            min_len: 2048,
            sve2: false,
        },
        mattr: "-mattr=+v8a,+neon,+aes,+crc",
        arch_file: "crc32c_arm.mlir",
    },
    Target {
        dir: "sve2",
        file: "sve2",
        arch: Arch::Arm,
        kind: Kind::Fold {
            bits: 128,
            lanes: 8,
            k: 4,
            iters: 8,
            min_len: 2048,
            sve2: true,
        },
        mattr: "-mattr=+v8a,+neon,+aes,+crc,+sve2,+sve2-aes",
        arch_file: "crc32c_arm.mlir",
    },
];

/// P, the CRC32C polynomial, in normal bit order: bit d is the coefficient of x^d.
const P: u64 = 0x1_1EDC_6F41;
/// x^-1 modulo P: x · X_INV = P - 1.
const X_INV: u64 = (P ^ 1) >> 1;

/// Returns the carry-less product of a and b.
fn clmul(a: u64, b: u64) -> u128 {
    (0..64)
        .filter(|&i| (b >> i) & 1 == 1)
        .fold(0, |r, i| r ^ (u128::from(a) << i))
}

/// Returns a modulo P.
fn pmod(mut a: u128) -> u64 {
    while 128 - a.leading_zeros() > 32 {
        a ^= u128::from(P) << (128 - a.leading_zeros() - 33);
    }
    a as u64
}

/// Returns x^d modulo P.
fn xpow(d: i64) -> u64 {
    let mut base = if d >= 0 { 2 } else { X_INV };
    let (mut r, mut e) = (1, d.unsigned_abs());
    while e != 0 {
        if e & 1 == 1 {
            r = pmod(clmul(r, base));
        }
        base = pmod(clmul(base, base));
        e >>= 1;
    }
    r
}

/// Returns the key for x^d for a 64-bit word, as a signed 64-bit MLIR constant.
fn key(d: i64) -> i64 {
    xpow(d - 1).reverse_bits() as i64
}

/// Returns text as `//` comment lines of at most 100 characters. A no-break space joins two words
/// and is written as a space.
fn comment(text: &str) -> String {
    let mut lines = vec![String::new()];
    for word in text.split(' ') {
        let line = lines.last_mut().expect("lines is never empty");
        if line.is_empty() {
            *line = word.to_string();
        } else if line.chars().count() + 1 + word.chars().count() <= 97 {
            *line += " ";
            *line += word;
        } else {
            lines.push(word.to_string());
        }
    }
    lines
        .iter()
        .map(|line| format!("// {}\n", line.replace('\u{a0}', " ")))
        .collect()
}

/// Returns vals, per_row of them to a line, the lines joined by sep.
fn rows(vals: &[i64], per_row: usize, sep: &str) -> String {
    vals.chunks(per_row)
        .map(|row| {
            row.iter()
                .map(i64::to_string)
                .collect::<Vec<_>>()
                .join(", ")
        })
        .collect::<Vec<_>>()
        .join(sep)
}

/// Returns vals as the elements of an MLIR dense constant.
fn dense(vals: &[i64]) -> String {
    format!("[\n    {}\n  ]", rows(vals, 4, ",\n    "))
}

/// A step of a folding target's halving chain: the words its vector holds, and whether it is the
/// first step, which `crc32c_fold.mlir` calls on the state.
#[derive(Clone, Copy, PartialEq, Eq)]
pub struct Step {
    words: u32,
    first: bool,
}

impl Target {
    /// Returns the kernel file that the target file goes with.
    pub fn kernel(&self) -> &'static str {
        match self.kind {
            Kind::Fold { .. } => "crc32c_fold.mlir",
            Kind::Chains { .. } => "crc32c_chains.mlir",
        }
    }

    /// Returns the steps of the halving chain of `crc32c_fold.mlir` that this target needs,
    /// outermost first. A step halves its words and calls the next, until a half is one register
    /// of the target; the leaf that multiplies a whole register is in the target file.
    fn steps(&self) -> Vec<Step> {
        let Kind::Fold { bits, lanes, .. } = self.kind else {
            return Vec::new();
        };
        let (reg, state) = (bits / 64, 2 * lanes); // the words of one register, of the state
        let mut steps = Vec::new();
        let mut words = state;
        while words > reg {
            steps.push(Step {
                words,
                first: words == state,
            });
            words /= 2;
        }
        steps
    }

    /// Returns the files of the generated steps of this target's halving chain, in `crc32c/` and
    /// outermost first. A step that only this target uses is written into its target file and is
    /// not in the list.
    pub fn step_files(&self) -> Vec<String> {
        self.steps()
            .iter()
            .filter(|s| users(**s) > 1)
            .map(|s| format!("crc32c/{}.mlir", step_name(*s)))
            .collect()
    }

    /// Returns the steps of this target's halving chain that no other target uses, outermost
    /// first, for its own target file.
    fn own_steps(&self) -> String {
        self.steps()
            .iter()
            .filter(|s| users(**s) == 1)
            .map(|s| half(*s))
            .collect()
    }

    /// Returns the target file.
    pub fn generate(&self) -> String {
        match (self.kind, self.arch) {
            (Kind::Fold { bits, .. }, Arch::X86) => {
                let insn = if bits == 128 {
                    "PCLMULQDQ"
                } else {
                    "VPCLMULQDQ"
                };
                let reg = match bits {
                    128 => "xmm",
                    256 => "ymm",
                    _ => "zmm",
                };
                let title = format!("x86-64 with {insn} on {bits}-bit vectors");
                let mut s = self.fold(&title, &format!("{reg} registers"));
                s += &self.own_steps();
                s += &x86_clmul(bits, insn);
                s
            }
            (Kind::Fold { sve2, .. }, Arch::Arm) => {
                let (title, clmul2) = if sve2 {
                    ("SVE2 with PMULLB, PMULLT and EOR3", SVE2_CLMUL2)
                } else {
                    ("NEON with PMULL from the AES extension", NEON_CLMUL2)
                };
                let mut s = self.fold(title, "q registers");
                s += &self.own_steps();
                s += clmul2;
                s
            }
            (Kind::Chains { bytes }, arch) => chains(arch, bytes),
        }
    }

    /// Returns the head of a folding target's file: its comment, its types, its sizes and its
    /// keys.
    fn fold(&self, title: &str, regs: &str) -> String {
        let Kind::Fold {
            lanes,
            k,
            iters,
            min_len,
            ..
        } = self.kind
        else {
            unreachable!("fold is called for folding targets");
        };
        let stride = 16 * lanes;
        let sl = 8 * k * iters; // the bytes of one scalar region
        assert!(
            (3 * sl) % stride == 0,
            "a block must be a whole number of strides"
        );
        let bits = i64::from(128 * lanes);
        let lane0 = bits - 128; // lane 0 weighs x^lane0
        let sl64 = i64::from(sl);
        let fk = [key(bits + 64), key(bits)].repeat(lanes as usize);
        let bk = [key(24 * sl64 + 64), key(24 * sl64)].repeat(lanes as usize);
        let lk: Vec<i64> = (0..bits / 128)
            .flat_map(|j| {
                let d = bits - 128 - 128 * j;
                [key(d + 64), key(d)]
            })
            .collect();
        let ck = [
            key(16 * sl64 - 64 - lane0),
            key(8 * sl64 - 64 - lane0),
            key(-64 - lane0),
        ];
        let (nb, last) = ('\u{a0}', lanes - 1);
        let head = comment(&format!(
            "Target file of crc32c_fold.mlir for {title}: {lanes} lanes of 128 bits in {regs}, \
             {stride} bytes a fold, and k{nb}={nb}{k} words of each CRC32 chain per fold, in \
             blocks of I{nb}={nb}{iters} folds: {} vector bytes and three scalar regions of {sl} \
             bytes. Inputs below {min_len} bytes take one CRC32 chain. The keys multiply by x^d \
             for d{nb}={nb}{bits}{nb}+{nb}64 and {bits} in fold_keys; 8·3·{sl}{nb}+{nb}64 and \
             8·3·{sl} in block_keys; 128·({last}{nb}-{nb}j){nb}+{nb}64 and \
             128·({last}{nb}-{nb}j) for lane j in lane_keys; and 8·2·{sl}{nb}-{nb}64, \
             8·{sl}{nb}-{nb}64 and -64, each minus {lane0} for lane 0, in chain_keys. \
             cargo xtask mlir writes this file.",
            stride * iters
        ));
        let mut s = head;
        write!(
            s,
            r#"
!st = vector<{st}xi64>
!w = vector<{lanes}x2xi64>

func.func private @stride() -> index {{
  %r = arith.constant {stride} : index
  return %r : index
}}

func.func private @words() -> index {{
  %r = arith.constant {k} : index
  return %r : index
}}

func.func private @iters() -> index {{
  %r = arith.constant {iters} : index
  return %r : index
}}

func.func private @min_len() -> index {{
  %r = arith.constant {min_len} : index
  return %r : index
}}

func.func private @fold_keys() -> !st {{
  %r = arith.constant dense<{fk}> : !st
  return %r : !st
}}

func.func private @block_keys() -> !st {{
  %r = arith.constant dense<{bk}> : !st
  return %r : !st
}}

func.func private @lane_keys() -> !st {{
  %r = arith.constant dense<{lk}> : !st
  return %r : !st
}}

func.func private @chain_keys() -> vector<3xi64> {{
  %r = arith.constant dense<{ck}> : vector<3xi64>
  return %r : vector<3xi64>
}}
"#,
            st = 2 * lanes,
            fk = dense(&fk),
            bk = dense(&bk),
            lk = dense(&lk),
            ck = dense(&ck),
        )
        .expect("writing to a String");
        s
    }
}

/// Returns how many targets use one halving chain step.
fn users(step: Step) -> usize {
    TARGETS.iter().filter(|t| t.steps().contains(&step)).count()
}

/// Returns the file name of the generated file of a halving chain step, without its suffix: the
/// words it halves, with `state` for the first step.
fn step_name(step: Step) -> String {
    if step.first {
        format!("halves_state_{}", step.words)
    } else {
        format!("halves_{}", step.words)
    }
}

/// Returns the files `cargo xtask mlir` writes to `crc32c/` for the halving chains: one per step
/// that at least two targets use, as a file name without its folder and suffix and the file's
/// text. The steps of a chain that no other target uses are in that target's own file.
pub fn shared_steps() -> Vec<(String, String)> {
    let mut seen: Vec<Step> = Vec::new();
    let mut files = Vec::new();
    for t in &TARGETS {
        for step in t.steps() {
            if seen.contains(&step) || users(step) < 2 {
                continue;
            }
            seen.push(step);
            files.push((step_name(step), step_file(step)));
        }
    }
    files
}

/// Returns the file of a shared halving chain step: its comment and its body.
fn step_file(step: Step) -> String {
    let who = and_list(
        &TARGETS
            .iter()
            .filter(|t| t.steps().contains(&step))
            .map(|t| t.file)
            .collect::<Vec<_>>(),
    );
    let (words, callee) = (step.words, format!("clmul{}_xor", step.words / 2));
    let head = if step.first {
        comment(&format!(
            "The first step of the halving chain of crc32c_fold.mlir: clmul_state halves the \
             {words} words of the fold's state and calls {callee} on each half. {who} share this \
             file. `cargo xtask mlir` writes it and puts it behind the target file, which defines \
             the state type !st, and in front of crc32c.mlir."
        ))
    } else {
        comment(&format!(
            "A step of the halving chain of crc32c_fold.mlir: {callee} on each half of {words} \
             words. {who} share this file. `cargo xtask mlir` writes it and puts it behind the \
             target file and in front of crc32c.mlir, beside the other steps of the chain."
        ))
    };
    head + &half(step)
}

/// Returns the body of one halving chain step: it takes three vectors of `words` words, splits
/// each in two, calls the next step, or the register leaf of the target, on the halves, and joins
/// the results. The first step is the fold's entry and takes the state type; every other step and
/// the leaf are named for the words they take.
fn half(step: Step) -> String {
    let (h, words) = (step.words / 2, step.words);
    let (name, t) = if step.first {
        ("clmul_state".to_string(), "!st".to_string())
    } else {
        (format!("clmul{words}_xor"), format!("vector<{words}xi64>"))
    };
    let (callee, what) = (
        format!("clmul{h}_xor"),
        if step.first {
            "the whole state".to_string()
        } else {
            format!("{words} words")
        },
    );
    let ht = format!("vector<{h}xi64>");
    let idx = rows(&(0..i64::from(words)).collect::<Vec<_>>(), 16, ",\n      ");
    let split = |o: char, from: &str| -> String {
        [(0, 'a'), (h, 'b')]
            .iter()
            .map(|(off, i)| {
                format!(
                    "  %{o}{i} = vector.extract_strided_slice %{o} {{offsets = [{off}], \
                     sizes = [{h}], strides = [1]}}\n      : {from} to {ht}\n"
                )
            })
            .collect()
    };
    let (xa, ka, da) = (split('x', &t), split('k', &t), split('d', &t));
    format!(
        r#"
// {name} is the fold of crc32c_fold.mlir on {what}, as {callee} on each half.
func.func private @{name}(%x: {t}, %k: {t}, %d: {t})
    -> {t} {{
{xa}{ka}{da}  %ra = func.call @{callee}(%xa, %ka, %da)
      : ({ht}, {ht}, {ht}) -> {ht}
  %rb = func.call @{callee}(%xb, %kb, %db)
      : ({ht}, {ht}, {ht}) -> {ht}
  %r = vector.shuffle %ra, %rb [
      {idx}
    ] : {ht}, {ht}
  return %r : {t}
}}
"#
    )
}

/// Returns the names joined as English: "a", "a and b", "a, b and c".
fn and_list(who: &[&'static str]) -> String {
    match who {
        [] => String::new(),
        [one] => (*one).to_string(),
        [rest @ .., last] => {
            let mut s = rest.join(", ");
            s += " and ";
            s += last;
            s
        }
    }
}

/// Returns the head of a chains target's file: its comment, its region size and its key.
fn chains(arch: Arch, bytes: u32) -> String {
    let title = match arch {
        Arch::X86 => "x86-64 with SSE 4.2's CRC32 alone",
        Arch::Arm => "aarch64 with the CRC extension alone",
    };
    let nb = '\u{a0}';
    let d = 8 * i64::from(bytes) - 33;
    // The key in 32 bits: bit j is the coefficient of x^(31 - j).
    let shift_key = (xpow(d) as u32).reverse_bits();
    let mut s = comment(&format!(
        "Target file of crc32c_chains.mlir for {title}: three CRC32 chains over regions of \
         {bytes} bytes. The key multiplies by x^d for d{nb}={nb}8·{bytes}{nb}-{nb}33. cargo xtask \
         mlir writes this file."
    ));
    write!(
        s,
        r#"
func.func private @chain_bytes() -> index {{
  %r = arith.constant {bytes} : index
  return %r : index
}}

func.func private @shift_key() -> i64 {{
  %r = arith.constant {shift_key} : i64
  return %r : i64
}}
"#
    )
    .expect("writing to a String");
    s
}

/// Returns the leaf of the halving chain for x86-64, the fold on one register of `bits / 64`
/// words: one vector register of the target, named for its words.
fn x86_clmul(bits: u32, insn: &str) -> String {
    let (w, vt) = (bits / 64, format!("vector<{}xi64>", bits / 64));
    let intr = match bits {
        128 => "llvm.x86.pclmulqdq".to_string(),
        _ => format!("llvm.x86.pclmulqdq.{bits}"),
    };
    format!(
        r#"
// clmul{w}_xor is the fold on one register: {insn} multiplies the low words of each 128-bit
// lane (immediate 0x00) or the high words (0x11).
func.func private @clmul{w}_xor(%x: {vt}, %k: {vt}, %d: {vt})
    -> {vt} {{
  %lo = llvm.mlir.constant(0 : i8) : i8
  %hi = llvm.mlir.constant(17 : i8) : i8
  %a = llvm.call_intrinsic "{intr}"(%x, %k, %lo)
      : ({vt}, {vt}, i8) -> {vt}
  %b = llvm.call_intrinsic "{intr}"(%x, %k, %hi)
      : ({vt}, {vt}, i8) -> {vt}
  %ab = arith.xori %a, %b : {vt}
  %r = arith.xori %ab, %d : {vt}
  return %r : {vt}
}}
"#
    )
}

/// The NEON leaf of the halving chain, the fold on one q register.
const NEON_CLMUL2: &str = r#"
// clmul2_xor is the fold on one q register: PMULL multiplies the low words, PMULL2 the high
// words.
func.func private @clmul2_xor(%x: vector<2xi64>, %k: vector<2xi64>, %d: vector<2xi64>)
    -> vector<2xi64> {
  %x0 = vector.extract %x[0] : i64 from vector<2xi64>
  %x1 = vector.extract %x[1] : i64 from vector<2xi64>
  %k0 = vector.extract %k[0] : i64 from vector<2xi64>
  %k1 = vector.extract %k[1] : i64 from vector<2xi64>
  %a = func.call @clmul(%x0, %k0) : (i64, i64) -> vector<2xi64>
  %b = func.call @clmul(%x1, %k1) : (i64, i64) -> vector<2xi64>
  %ab = arith.xori %a, %b : vector<2xi64>
  %r = arith.xori %ab, %d : vector<2xi64>
  return %r : vector<2xi64>
}
"#;

/// The SVE2 leaf of the halving chain, the fold on one register.
const SVE2_CLMUL2: &str = r#"
// clmul2_xor is the fold on one register: pmullb multiplies the low words, pmullt the high
// words, and eor3 adds the two products and d in one instruction. At a 16-byte vector length a
// register is the two words, so pmullb takes element 0 of each operand and pmullt element 1, each
// into the whole register. eor3 also writes its last operand, so that is the product of the low
// words: its register is the one the next fold reads as the state, and with either other operand
// last the loop needs a copy of the state per lane.
func.func private @clmul2_xor(%x: vector<2xi64>, %k: vector<2xi64>, %d: vector<2xi64>)
    -> vector<2xi64> {
  %z = ub.poison : vector<[2]xi64>
  %z8 = ub.poison : vector<[16]xi8>
  %sx = vector.scalable.insert %x, %z[0] : vector<2xi64> into vector<[2]xi64>
  %sk = vector.scalable.insert %k, %z[0] : vector<2xi64> into vector<[2]xi64>
  %a = llvm.call_intrinsic "llvm.aarch64.sve.pmullb.pair"(%sx, %sk)
      : (vector<[2]xi64>, vector<[2]xi64>) -> vector<[2]xi64>
  %b = llvm.call_intrinsic "llvm.aarch64.sve.pmullt.pair"(%sx, %sk)
      : (vector<[2]xi64>, vector<[2]xi64>) -> vector<[2]xi64>
  %sa = vector.bitcast %a : vector<[2]xi64> to vector<[16]xi8>
  %sb = vector.bitcast %b : vector<[2]xi64> to vector<[16]xi8>
  %d8 = vector.bitcast %d : vector<2xi64> to vector<16xi8>
  %sd = vector.scalable.insert %d8, %z8[0] : vector<16xi8> into vector<[16]xi8>
  %r = llvm.call_intrinsic "llvm.aarch64.sve.eor3"(%sb, %sd, %sa)
      : (vector<[16]xi8>, vector<[16]xi8>, vector<[16]xi8>) -> vector<[16]xi8>
  %w = vector.bitcast %r : vector<[16]xi8> to vector<[2]xi64>
  %f = vector.scalable.extract %w[0] : vector<2xi64> from vector<[2]xi64>
  return %f : vector<2xi64>
}
"#;

#[cfg(test)]
mod tests {
    use super::*;

    /// The committed target files and shared halving chain step files are the ones
    /// `cargo xtask mlir` writes.
    #[test]
    fn target_files_are_current() {
        let check = |path: std::path::PathBuf, text: &str| {
            let file = std::fs::read_to_string(&path)
                .expect("generated file")
                .replace("\r\n", "\n");
            assert!(
                file == text,
                "{} is stale: run cargo xtask mlir",
                path.display()
            );
        };
        for t in &TARGETS {
            check(
                crate::mlir_dir().join(format!("crc32c/{}.mlir", t.file)),
                &t.generate(),
            );
        }
        for (name, text) in shared_steps() {
            check(crate::mlir_dir().join(format!("crc32c/{name}.mlir")), &text);
        }
    }

    /// x^-1 is the inverse of x modulo P, so the keys for negative d are right.
    #[test]
    fn x_inv_is_the_inverse_of_x() {
        assert_eq!(pmod(clmul(2, X_INV)), 1);
        assert_eq!(pmod(clmul(xpow(1000), xpow(-1000))), 1);
    }

    /// The reduction in crc32c_fold.mlir multiplies by x^96 and x^64 with the keys of this
    /// generator.
    #[test]
    fn reduction_keys_are_keys() {
        let mlir =
            std::fs::read_to_string(crate::mlir_dir().join("crc32c_fold.mlir")).expect("kernel");
        for (name, d) in [("%k96", 96), ("%k64", 64)] {
            let line = mlir
                .lines()
                .find(|l| {
                    l.trim_start()
                        .starts_with(&format!("{name} = arith.constant "))
                })
                .expect("the constant is in crc32c_fold.mlir");
            assert!(line.contains(&format!(" {} : i64", key(d))), "{line}");
        }
    }
}

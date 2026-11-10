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
//! the sizes and keys that implies, and its instructions.
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
    /// `iters` folds. Inputs below `min_len` bytes take one CRC32 chain.
    Fold {
        bits: u32,
        lanes: u32,
        k: u32,
        iters: u32,
        min_len: u32,
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
}

/// The targets, each with only the features that `stream::crc` checks for it.
///
/// k and I were measured on Sapphire Rapids and on GB10's Cortex-X925 and Cortex-A725 cores: more
/// CRC32 words per fold help cores that multiply on one pipe and slow those that multiply on two;
/// I = 8 keeps blocks short enough to fold inputs of 2 KiB. Below `min_len`, combining the lanes
/// and reducing them costs more than folding saves. With PCLMULQDQ and PMULL it is also a whole
/// block: Neoverse N-class cores multiply on one pipe, so folding alone is no faster there than
/// CRC32, and only the block's CRC32 chains gain.
pub const TARGETS: [Target; 6] = [
    Target {
        dir: "sse42",
        file: "sse42",
        arch: Arch::X86,
        kind: Kind::Chains { bytes: 1024 },
        mattr: "-mattr=+sse4.2,+crc32",
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
        },
        mattr: "-mattr=+sse4.2,+crc32,+pclmul",
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
        },
        mattr: "-mattr=+avx2,+crc32,+pclmul,+vpclmulqdq",
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
        },
        mattr: "-mattr=+avx512f,+crc32,+pclmul,+vpclmulqdq,-prefer-256-bit",
    },
    Target {
        dir: "crc",
        file: "crc",
        arch: Arch::Arm,
        kind: Kind::Chains { bytes: 1024 },
        mattr: "-mattr=+v8a,+crc",
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
        },
        mattr: "-mattr=+v8a,+neon,+aes,+crc",
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

impl Target {
    /// Returns the kernel file that the target file goes with.
    pub fn kernel(&self) -> &'static str {
        match self.kind {
            Kind::Fold { .. } => "crc32c_fold.mlir",
            Kind::Chains { .. } => "crc32c_chains.mlir",
        }
    }

    /// Returns the target file.
    pub fn generate(&self) -> String {
        let mut s = match (self.kind, self.arch) {
            (Kind::Fold { bits, lanes, .. }, Arch::X86) => {
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
                s += &halves(2 * lanes, bits / 64);
                s += &x86_clmul(bits, insn);
                s
            }
            (Kind::Fold { lanes, .. }, Arch::Arm) => {
                let mut s = self.fold("NEON with PMULL from the AES extension", "q registers");
                s += &halves(2 * lanes, 2);
                s += NEON_CLMUL;
                s
            }
            (Kind::Chains { bytes }, arch) => chains(arch, bytes),
        };
        s += match self.arch {
            Arch::X86 => X86_CRC32,
            Arch::Arm => ARM_CRC32,
        };
        s
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

/// Returns clmul2 on `vector<n x i64>` as the same on each half, down to one register of `leaf`
/// words.
fn halves(n: u32, leaf: u32) -> String {
    let mut s = String::new();
    let (mut size, mut name) = (n, "clmul2".to_string());
    while size > leaf {
        let h = size / 2;
        let sub = if h > leaf {
            format!("clmul{h}")
        } else {
            "clmul_reg".to_string()
        };
        let t = if size == n {
            "!st".to_string()
        } else {
            format!("vector<{size}xi64>")
        };
        let ht = format!("vector<{h}xi64>");
        let idx = rows(&(0..i64::from(size)).collect::<Vec<_>>(), 16, ",\n      ");
        write!(
            s,
            r#"
// {name} is clmul2 on {size} words, as {sub} on each half.
func.func private @{name}(%x: {t}, %k: {t}) -> {t} {{
  %xa = vector.extract_strided_slice %x {{offsets = [0], sizes = [{h}], strides = [1]}}
      : {t} to {ht}
  %xb = vector.extract_strided_slice %x {{offsets = [{h}], sizes = [{h}], strides = [1]}}
      : {t} to {ht}
  %ka = vector.extract_strided_slice %k {{offsets = [0], sizes = [{h}], strides = [1]}}
      : {t} to {ht}
  %kb = vector.extract_strided_slice %k {{offsets = [{h}], sizes = [{h}], strides = [1]}}
      : {t} to {ht}
  %ra = func.call @{sub}(%xa, %ka) : ({ht}, {ht}) -> {ht}
  %rb = func.call @{sub}(%xb, %kb) : ({ht}, {ht}) -> {ht}
  %r = vector.shuffle %ra, %rb [
      {idx}
    ] : {ht}, {ht}
  return %r : {t}
}}
"#
        )
        .expect("writing to a String");
        (name, size) = (sub, h);
    }
    s
}

/// Returns the x86-64 carry-less multiplies: clmul2 on one register, and clmul.
fn x86_clmul(bits: u32, insn: &str) -> String {
    let vt = format!("vector<{}xi64>", bits / 64);
    let intr = match bits {
        128 => "llvm.x86.pclmulqdq".to_string(),
        _ => format!("llvm.x86.pclmulqdq.{bits}"),
    };
    format!(
        r#"
// clmul_reg is clmul2 on one register: {insn} multiplies the low words of each 128-bit lane
// (immediate 0x00) or the high words (0x11).
func.func private @clmul_reg(%x: {vt}, %k: {vt}) -> {vt} {{
  %lo = llvm.mlir.constant(0 : i8) : i8
  %hi = llvm.mlir.constant(17 : i8) : i8
  %a = llvm.call_intrinsic "{intr}"(%x, %k, %lo)
      : ({vt}, {vt}, i8) -> {vt}
  %b = llvm.call_intrinsic "{intr}"(%x, %k, %hi)
      : ({vt}, {vt}, i8) -> {vt}
  %r = arith.xori %a, %b : {vt}
  return %r : {vt}
}}

// clmul returns the 128-bit carry-less product of a and b.
func.func private @clmul(%a: i64, %b: i64) -> vector<2xi64> {{
  %z = arith.constant dense<0> : vector<2xi64>
  %va = vector.insert %a, %z [0] : i64 into vector<2xi64>
  %vb = vector.insert %b, %z [0] : i64 into vector<2xi64>
  %lo = llvm.mlir.constant(0 : i8) : i8
  %r = llvm.call_intrinsic "llvm.x86.pclmulqdq"(%va, %vb, %lo)
      : (vector<2xi64>, vector<2xi64>, i8) -> vector<2xi64>
  return %r : vector<2xi64>
}}
"#
    )
}

/// The NEON carry-less multiplies: clmul2 on one register, and clmul.
const NEON_CLMUL: &str = r#"
// clmul_reg is clmul2 on one register: PMULL multiplies the low words, PMULL2 the high words.
func.func private @clmul_reg(%x: vector<2xi64>, %k: vector<2xi64>) -> vector<2xi64> {
  %x0 = vector.extract %x[0] : i64 from vector<2xi64>
  %x1 = vector.extract %x[1] : i64 from vector<2xi64>
  %k0 = vector.extract %k[0] : i64 from vector<2xi64>
  %k1 = vector.extract %k[1] : i64 from vector<2xi64>
  %a = func.call @clmul(%x0, %k0) : (i64, i64) -> vector<2xi64>
  %b = func.call @clmul(%x1, %k1) : (i64, i64) -> vector<2xi64>
  %r = arith.xori %a, %b : vector<2xi64>
  return %r : vector<2xi64>
}

// clmul returns the 128-bit carry-less product of a and b.
func.func private @clmul(%a: i64, %b: i64) -> vector<2xi64> {
  %p = llvm.call_intrinsic "llvm.aarch64.neon.pmull64"(%a, %b) : (i64, i64) -> vector<16xi8>
  %r = vector.bitcast %p : vector<16xi8> to vector<2xi64>
  return %r : vector<2xi64>
}
"#;

/// The x86-64 CRC32 instructions.
const X86_CRC32: &str = r#"
// crc32 returns the CRC state c after the word w: CRC32 with a 64-bit operand.
func.func private @crc32(%c: i64, %w: i64) -> i64 {
  %r = llvm.call_intrinsic "llvm.x86.sse42.crc32.64.64"(%c, %w) : (i64, i64) -> i64
  return %r : i64
}

// crc32w, crc32h and crc32b return the CRC state c, low 32 bits, after v: CRC32 with a 32-bit,
// 16-bit or 8-bit operand.
func.func private @crc32w(%c: i64, %v: i32) -> i64 {
  %c32 = arith.trunci %c : i64 to i32
  %r32 = llvm.call_intrinsic "llvm.x86.sse42.crc32.32.32"(%c32, %v) : (i32, i32) -> i32
  %r = arith.extui %r32 : i32 to i64
  return %r : i64
}

func.func private @crc32h(%c: i64, %v: i16) -> i64 {
  %c32 = arith.trunci %c : i64 to i32
  %r32 = llvm.call_intrinsic "llvm.x86.sse42.crc32.32.16"(%c32, %v) : (i32, i16) -> i32
  %r = arith.extui %r32 : i32 to i64
  return %r : i64
}

func.func private @crc32b(%c: i64, %v: i8) -> i64 {
  %c32 = arith.trunci %c : i64 to i32
  %r32 = llvm.call_intrinsic "llvm.x86.sse42.crc32.32.8"(%c32, %v) : (i32, i8) -> i32
  %r = arith.extui %r32 : i32 to i64
  return %r : i64
}
"#;

/// The aarch64 CRC32 instructions.
const ARM_CRC32: &str = r#"
// crc32 returns the CRC state c, low 32 bits, after the word w: CRC32CX.
func.func private @crc32(%c: i64, %w: i64) -> i64 {
  %c32 = arith.trunci %c : i64 to i32
  %r32 = llvm.call_intrinsic "llvm.aarch64.crc32cx"(%c32, %w) : (i32, i64) -> i32
  %r = arith.extui %r32 : i32 to i64
  return %r : i64
}

// crc32w, crc32h and crc32b return the CRC state c, low 32 bits, after v: CRC32CW, CRC32CH and
// CRC32CB.
func.func private @crc32w(%c: i64, %v: i32) -> i64 {
  %c32 = arith.trunci %c : i64 to i32
  %r32 = llvm.call_intrinsic "llvm.aarch64.crc32cw"(%c32, %v) : (i32, i32) -> i32
  %r = arith.extui %r32 : i32 to i64
  return %r : i64
}

func.func private @crc32h(%c: i64, %v: i16) -> i64 {
  %c32 = arith.trunci %c : i64 to i32
  %v32 = arith.extui %v : i16 to i32
  %r32 = llvm.call_intrinsic "llvm.aarch64.crc32ch"(%c32, %v32) : (i32, i32) -> i32
  %r = arith.extui %r32 : i32 to i64
  return %r : i64
}

func.func private @crc32b(%c: i64, %v: i8) -> i64 {
  %c32 = arith.trunci %c : i64 to i32
  %v32 = arith.extui %v : i8 to i32
  %r32 = llvm.call_intrinsic "llvm.aarch64.crc32cb"(%c32, %v32) : (i32, i32) -> i32
  %r = arith.extui %r32 : i32 to i64
  return %r : i64
}
"#;

#[cfg(test)]
mod tests {
    use super::*;

    /// The committed target files are the ones `cargo xtask mlir` writes.
    #[test]
    fn target_files_are_current() {
        for t in &TARGETS {
            let path = crate::mlir_dir().join(format!("crc32c/{}.mlir", t.file));
            let file = std::fs::read_to_string(&path)
                .expect("target file")
                .replace("\r\n", "\n");
            assert!(
                file == t.generate(),
                "{} is stale: run cargo xtask mlir",
                path.display()
            );
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

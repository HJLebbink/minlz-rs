// The aarch64 CRC32 instructions and the 128-bit carry-less product, in one copy for every CRC32C
// target of the architecture. `cargo xtask mlir` puts common.mlir and the target file
// (crc32c/*.mlir) in front of this file, and crc32c.mlir and the kernel behind it; the target file
// holds what differs between the targets: the sizes, the keys and, for a folding target, the
// register leaf, @clmul2_xor, @clmul4_xor or @clmul8_xor, named for its words. A target that
// multiplies nowhere, as crc does, never calls @clmul, and --symbol-dce drops it.

// clmul returns the 128-bit carry-less product of a and b.
func.func private @clmul(%a: i64, %b: i64) -> vector<2xi64> {
  %p = llvm.call_intrinsic "llvm.aarch64.neon.pmull64"(%a, %b) : (i64, i64) -> vector<16xi8>
  %r = vector.bitcast %p : vector<16xi8> to vector<2xi64>
  return %r : vector<2xi64>
}

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

// The x86-64 CRC32 instructions and the 128-bit carry-less product, in one copy for every CRC32C
// target of the architecture. `cargo xtask mlir` puts common.mlir and the target file
// (crc32c/*.mlir) in front of this file, and crc32c.mlir and the kernel behind it; the target file
// holds what differs between the targets: the sizes, the keys and, for a folding target, the
// register leaf, @clmul2_xor, @clmul4_xor or @clmul8_xor, named for its words. A target that
// multiplies nowhere, as sse42 does, never calls @clmul, and --symbol-dce drops it.

// clmul returns the 128-bit carry-less product of a and b.
func.func private @clmul(%a: i64, %b: i64) -> vector<2xi64> {
  %z = arith.constant dense<0> : vector<2xi64>
  %va = vector.insert %a, %z [0] : i64 into vector<2xi64>
  %vb = vector.insert %b, %z [0] : i64 into vector<2xi64>
  %lo = llvm.mlir.constant(0 : i8) : i8
  %r = llvm.call_intrinsic "llvm.x86.pclmulqdq"(%va, %vb, %lo)
      : (vector<2xi64>, vector<2xi64>, i8) -> vector<2xi64>
  return %r : vector<2xi64>
}

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

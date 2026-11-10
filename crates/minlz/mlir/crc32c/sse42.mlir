// Target file of crc32c_chains.mlir for x86-64 with SSE 4.2's CRC32 alone: three CRC32 chains over
// regions of 1024 bytes. The key multiplies by x^d for d = 8·1024 - 33. cargo xtask mlir writes
// this file.

func.func private @chain_bytes() -> index {
  %r = arith.constant 1024 : index
  return %r : index
}

func.func private @shift_key() -> i64 {
  %r = arith.constant 385906426 : i64
  return %r : i64
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

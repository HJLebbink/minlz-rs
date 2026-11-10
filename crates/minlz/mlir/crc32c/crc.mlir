// Target file of crc32c_chains.mlir for aarch64 with the CRC extension alone: three CRC32 chains
// over regions of 1024 bytes. The key multiplies by x^d for d = 8·1024 - 33. cargo xtask mlir
// writes this file.

func.func private @chain_bytes() -> index {
  %r = arith.constant 1024 : index
  return %r : index
}

func.func private @shift_key() -> i64 {
  %r = arith.constant 385906426 : i64
  return %r : i64
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

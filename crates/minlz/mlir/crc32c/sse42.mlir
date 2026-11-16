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

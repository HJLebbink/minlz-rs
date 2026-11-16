// CRC32C for targets that have the CRC32 instruction but no carry-less multiply. `cargo xtask
// mlir` puts common.mlir, a target file (crc32c/*.mlir), the file of its architecture
// (crc32c_x86.mlir or crc32c_arm.mlir) and crc32c.mlir in front of this file and lowers the result
// once per target. The naked functions in crates/minlz/src/stream/crc/mlir.rs hold the output.
//
// The CRC32 instruction takes 3 cycles and starts one each cycle, so three chains run beside each
// other, over three neighboring regions of S bytes, as in Go's castagnoliSSE42Triple. Joining two
// chains moves the first one's CRC on past the second region: it multiplies it by x^(8·S) modulo
// P, the CRC32C polynomial. In a 32-bit CRC state, bit i is the coefficient of x^(31-i), so the
// 64-bit carry-less product of a state and a 32-bit key, read as a word, is their product times
// x. A CRC32 instruction from state 0 multiplies a word by x^32 and reduces it modulo P. So the
// key that moves a state on past S bytes is x^(8·S-33) mod P, reflected into 32 bits.
//
// The architecture file of the target gives the CRC32 instructions that crc32c.mlir lists. The
// target file gives:
// - @chain_bytes() -> index, S, a multiple of 8;
// - @shift_key() -> i64, the key.

// clmul32 returns the carry-less product of a and b, both below 2^32.
func.func private @clmul32(%a: i64, %b: i64) -> i64 {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c32 = arith.constant 32 : index
  %z = arith.constant 0 : i64
  %one = arith.constant 1 : i64
  %r = scf.for %i = %c0 to %c32 step %c1 iter_args(%x = %z) -> (i64) {
    %s = arith.index_cast %i : index to i64
    %bs = arith.shrui %b, %s : i64
    %bit = arith.andi %bs, %one : i64
    %mask = arith.subi %z, %bit : i64
    %as = arith.shli %a, %s : i64
    %t = arith.andi %as, %mask : i64
    %y = arith.xori %x, %t : i64
    scf.yield %y : i64
  }
  return %r : i64
}

// shift returns the CRC state c moved on past S bytes of zeros.
func.func private @shift(%c: i64) -> i64 {
  %z = arith.constant 0 : i64
  %k = func.call @shift_key() : () -> i64
  %m = func.call @clmul32(%c, %k) : (i64, i64) -> i64
  %r = func.call @crc32(%z, %m) : (i64, i64) -> i64
  return %r : i64
}

// minlz_crc32c_update returns the CRC state after the n bytes at p, starting from state c: three
// chains over each run of 3·S bytes, then one chain over the rest.
func.func @minlz_crc32c_update(%c: i32, %p: !p, %n: i64) -> i32 {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c3 = arith.constant 3 : index
  %c8 = arith.constant 8 : index
  %z = arith.constant 0 : i64
  %s = func.call @chain_bytes() : () -> index
  %s2 = arith.addi %s, %s : index
  %blen = arith.muli %s, %c3 : index
  %ni = arith.index_cast %n : i64 to index
  %nb = arith.divui %ni, %blen : index
  %cw = arith.extui %c : i32 to i64
  %r = scf.for %b = %c0 to %nb step %c1 iter_args(%x = %cw) -> (i64) {
    %o = arith.muli %b, %blen : index
    %t:3 = scf.for %j = %c0 to %s step %c8 iter_args(%u = %x, %v = %z, %w = %z)
        -> (i64, i64, i64) {
      %oa = arith.addi %o, %j : index
      %ob = arith.addi %oa, %s : index
      %oc = arith.addi %oa, %s2 : index
      %da = func.call @word(%p, %oa) : (!p, index) -> i64
      %db = func.call @word(%p, %ob) : (!p, index) -> i64
      %dc = func.call @word(%p, %oc) : (!p, index) -> i64
      %ua = func.call @crc32(%u, %da) : (i64, i64) -> i64
      %vb = func.call @crc32(%v, %db) : (i64, i64) -> i64
      %wc = func.call @crc32(%w, %dc) : (i64, i64) -> i64
      scf.yield %ua, %vb, %wc : i64, i64, i64
    }
    %a = func.call @shift(%t#0) : (i64) -> i64
    %ab = arith.xori %a, %t#1 : i64
    %abs = func.call @shift(%ab) : (i64) -> i64
    %abc = arith.xori %abs, %t#2 : i64
    scf.yield %abc : i64
  }
  %done = arith.muli %nb, %blen : index
  %r32 = arith.trunci %r : i64 to i32
  %crc = func.call @tail(%r32, %p, %done, %ni) : (i32, !p, index, index) -> i32
  return %crc : i32
}

// CRC32C (Castagnoli): the parts that both kernels use. `cargo xtask mlir` puts common.mlir, a
// target file (crc32c/*.mlir) and this file in front of a kernel: crc32c_fold.mlir, which folds
// with carry-less multiplies, or crc32c_chains.mlir, for targets that have the CRC32 instruction
// alone. Both define minlz_crc32c_update, which the naked functions in
// crates/minlz/src/stream/crc/mlir.rs hold.
//
// The CRC is reflected, as the CRC32 instructions compute it. A CRC state is the CRC without its
// final inversion, as the CRC32 instructions keep it. Every target file gives the CRC32
// instruction, which returns a CRC state, low 32 bits, after a value:
// - @crc32(i64, i64) -> i64 for a word;
// - @crc32w(i64, i32) -> i64, @crc32h(i64, i16) -> i64 and @crc32b(i64, i8) -> i64 for 4, 2 and 1
//   bytes.

// chain returns the CRC state after the k words at p + o, starting from state x. With a constant k,
// LLVM unrolls the loop.
func.func private @chain(%x: i64, %p: !p, %o: index, %k: index) -> i64 {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c8 = arith.constant 8 : index
  %r = scf.for %j = %c0 to %k step %c1 iter_args(%y = %x) -> (i64) {
    %oj = arith.muli %j, %c8 : index
    %a = arith.addi %o, %oj : index
    %d = func.call @word(%p, %a) : (!p, index) -> i64
    %z = func.call @crc32(%y, %d) : (i64, i64) -> i64
    scf.yield %z : i64
  }
  return %r : i64
}

// part returns the CRC state and the offset after the m bytes at p + o, starting from state x, if
// len has bit m; m is 32, 16 or 8.
func.func private @part(%x: i64, %p: !p, %o: index, %len: index, %m: index) -> (i64, index) {
  %c0 = arith.constant 0 : index
  %c8 = arith.constant 8 : index
  %b = arith.andi %len, %m : index
  %has = arith.cmpi ne, %b, %c0 : index
  %r:2 = scf.if %has -> (i64, index) {
    %k = arith.divui %m, %c8 : index
    %y = func.call @chain(%x, %p, %o, %k) : (i64, !p, index, index) -> i64
    %o2 = arith.addi %o, %m : index
    scf.yield %y, %o2 : i64, index
  } else {
    scf.yield %x, %o : i64, index
  }
  return %r#0, %r#1 : i64, index
}

// tail returns the CRC state after the bytes o to n of p, starting from state c: one CRC32 chain,
// 64 bytes a loop trip, then 32, 16, 8, 4, 2 and 1 bytes as the length has them. A loop that took
// one word or byte a trip would end with a mispredicted branch on most calls, and keep the next
// call from starting before this one ends.
func.func private @tail(%c: i32, %p: !p, %o: index, %n: index) -> i32 {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c4 = arith.constant 4 : index
  %c8 = arith.constant 8 : index
  %c16 = arith.constant 16 : index
  %c32 = arith.constant 32 : index
  %c64 = arith.constant 64 : index
  %len = arith.subi %n, %o : index
  %runs = arith.divui %len, %c64 : index
  %rlen = arith.muli %runs, %c64 : index
  %re = arith.addi %o, %rlen : index
  %cw = arith.extui %c : i32 to i64
  %x0 = scf.for %i = %o to %re step %c64 iter_args(%x = %cw) -> (i64) {
    %y = func.call @chain(%x, %p, %i, %c8) : (i64, !p, index, index) -> i64
    scf.yield %y : i64
  }
  %x1:2 = func.call @part(%x0, %p, %re, %len, %c32)
      : (i64, !p, index, index, index) -> (i64, index)
  %x2:2 = func.call @part(%x1#0, %p, %x1#1, %len, %c16)
      : (i64, !p, index, index, index) -> (i64, index)
  %x3:2 = func.call @part(%x2#0, %p, %x2#1, %len, %c8)
      : (i64, !p, index, index, index) -> (i64, index)
  %b4 = arith.andi %len, %c4 : index
  %has4 = arith.cmpi ne, %b4, %c0 : index
  %x4:2 = scf.if %has4 -> (i64, index) {
    %q = func.call @at(%p, %x3#1) : (!p, index) -> !p
    %v = ptr.load %q alignment = 1 : !p -> i32
    %y = func.call @crc32w(%x3#0, %v) : (i64, i32) -> i64
    %o2 = arith.addi %x3#1, %c4 : index
    scf.yield %y, %o2 : i64, index
  } else {
    scf.yield %x3#0, %x3#1 : i64, index
  }
  %b2 = arith.andi %len, %c2 : index
  %has2 = arith.cmpi ne, %b2, %c0 : index
  %x5:2 = scf.if %has2 -> (i64, index) {
    %q = func.call @at(%p, %x4#1) : (!p, index) -> !p
    %v = ptr.load %q alignment = 1 : !p -> i16
    %y = func.call @crc32h(%x4#0, %v) : (i64, i16) -> i64
    %o2 = arith.addi %x4#1, %c2 : index
    scf.yield %y, %o2 : i64, index
  } else {
    scf.yield %x4#0, %x4#1 : i64, index
  }
  %b1 = arith.andi %len, %c1 : index
  %has1 = arith.cmpi ne, %b1, %c0 : index
  %x6 = scf.if %has1 -> (i64) {
    %q = func.call @at(%p, %x5#1) : (!p, index) -> !p
    %v = ptr.load %q : !p -> i8
    %y = func.call @crc32b(%x5#0, %v) : (i64, i8) -> i64
    scf.yield %y : i64
  } else {
    scf.yield %x5#0 : i64
  }
  %r = arith.trunci %x6 : i64 to i32
  return %r : i32
}

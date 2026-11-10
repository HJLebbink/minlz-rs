// CRC32C (Castagnoli) by folding with carry-less multiplies, with three CRC32-instruction chains
// beside it: the bulk of crc32c_update for long inputs, for every target. `cargo xtask mlir` puts
// common.mlir and a target file (crc32c/*.mlir) in front of this file and lowers the result once
// per target. The naked functions in crates/minlz/src/stream/crc/mlir.rs hold the output.
//
// The CRC is reflected, as the CRC32 instructions compute it. A 16-byte load, read as a
// little-endian 128-bit number, is a polynomial in which bit j is the coefficient of x^(127-j).
// The state is L such 128-bit lanes, lane j weighing x^(128·(L-1-j)): the input so far, as a
// polynomial congruent to it modulo the CRC polynomial P. Moving a lane d bits on multiplies it by
// x^d modulo P: its low word times x^(d+64), its high word times x^d. In a 64-bit word, bit i is
// the coefficient of x^(63-i), and the carry-less product of two words, read as 128 bits, is their
// product times x. So the key that multiplies by x^d is x^(d-1) mod P, reflected into a 64-bit
// word; d may be negative, as x has an inverse modulo P.
//
// Folding and the CRC32 instruction use different execution units, so a block of the input is a
// vector region of I strides of 16·L bytes, folded, and three scalar regions after it of 8·k·I
// bytes each, one CRC32-instruction chain each. Every loop trip folds one stride and runs k words
// through each chain. At the end of the block the lanes move on past the scalar regions, and each
// chain's CRC joins lane 0 times the power of x that places it.
//
// The target file gives:
// - !st = vector<2L x i64>, lane j being elements 2j (the low word) and 2j+1 (the high word), and
//   !w = vector<L x 2 x i64>, the same words with one lane to a row;
// - @stride() -> index, the 16·L bytes that one fold takes; @words() -> index, k; @iters() ->
//   index, I;
// - @fold_keys() -> !st, the keys that move every lane 128·L bits on;
// - @block_keys() -> !st, the keys that move every lane past the three scalar regions;
// - @lane_keys() -> !st, the keys that move lane j 128·(L-1-j) bits on, so that the lanes add up
//   to one (the last lane's keys multiply by x^0);
// - @chain_keys() -> vector<3xi64>, for each chain the key that places its CRC in lane 0; the
//   third also places the starting CRC there;
// - @clmul2(!st, !st) -> !st, per lane the 128-bit product of the low words xor that of the high
//   words;
// - @clmul(i64, i64) -> vector<2xi64>, the 128-bit carry-less product of two words;
// - @crc32(i64, i64) -> i64, the CRC32 instruction: a CRC state, low 32 bits, after a word.

// word returns the 64-bit word at p + o.
func.func private @word(%p: !p, %o: index) -> i64 {
  %q = func.call @at(%p, %o) : (!p, index) -> !p
  %r = ptr.load %q alignment = 1 : !p -> i64
  return %r : i64
}

// fold returns s moved one stride on, with the stride at p + o added.
func.func private @fold(%s: !st, %k: !st, %p: !p, %o: index) -> !st {
  %q = func.call @at(%p, %o) : (!p, index) -> !p
  %d = ptr.load %q alignment = 1 : !p -> !st
  %f = func.call @clmul2(%s, %k) : (!st, !st) -> !st
  %r = arith.xori %f, %d : !st
  return %r : !st
}

// join returns s with the 128-bit product of c and the key k added to lane 0.
func.func private @join(%s: !st, %c: i64, %k: i64) -> !st {
  %m = func.call @clmul(%c, %k) : (i64, i64) -> vector<2xi64>
  %z = arith.constant dense<0> : !st
  %v = vector.insert_strided_slice %m, %z {offsets = [0], strides = [1]} : vector<2xi64> into !st
  %r = arith.xori %s, %v : !st
  return %r : !st
}

// lanes returns the low and the high word of the 128 bits that the lanes of s add up to.
func.func private @lanes(%s: !st) -> (i64, i64) {
  %z = arith.constant dense<0> : vector<2xi64>
  %kl = func.call @lane_keys() : () -> !st
  %t = func.call @clmul2(%s, %kl) : (!st, !st) -> !st
  %w = vector.shape_cast %t : !st to !w
  %x = vector.multi_reduction <xor>, %w, %z [0] : !w to vector<2xi64>
  %lo = vector.extract %x[0] : i64 from vector<2xi64>
  %hi = vector.extract %x[1] : i64 from vector<2xi64>
  return %lo, %hi : i64, i64
}

// reduce returns the CRC state of 16 bytes, low word lo and high word hi: their polynomial times
// x^32 modulo P. It moves the low word on to 96 bits, the result's 32 high-order bits on to 64
// bits, and takes the remaining 64-bit polynomial modulo P by Barrett reduction, with
// mu = x^64 / P and P itself reflected into 33 bits.
func.func private @reduce(%lo: i64, %hi: i64) -> i32 {
  %k96 = arith.constant 5277230469828575232 : i64
  %k64 = arith.constant -2502406310683738112 : i64
  %mu = arith.constant 3735491569 : i64
  %poly = arith.constant 4394350321 : i64
  %c32 = arith.constant 32 : i64
  %m32 = arith.constant 4294967295 : i64
  %a = func.call @clmul(%lo, %k96) : (i64, i64) -> vector<2xi64>
  %a0 = vector.extract %a[0] : i64 from vector<2xi64>
  %a1 = vector.extract %a[1] : i64 from vector<2xi64>
  %hl = arith.shli %hi, %c32 : i64
  %hh = arith.shrui %hi, %c32 : i64
  %t0 = arith.xori %a0, %hl : i64
  %t1 = arith.xori %a1, %hh : i64
  %b = func.call @clmul(%t0, %k64) : (i64, i64) -> vector<2xi64>
  %b1 = vector.extract %b[1] : i64 from vector<2xi64>
  %u = arith.xori %b1, %t1 : i64
  %ul = arith.andi %u, %m32 : i64
  %q = func.call @clmul(%ul, %mu) : (i64, i64) -> vector<2xi64>
  %q0 = vector.extract %q[0] : i64 from vector<2xi64>
  %ql = arith.andi %q0, %m32 : i64
  %r = func.call @clmul(%ql, %poly) : (i64, i64) -> vector<2xi64>
  %r0 = vector.extract %r[0] : i64 from vector<2xi64>
  %e = arith.xori %u, %r0 : i64
  %f = arith.shrui %e, %c32 : i64
  %crc = arith.trunci %f : i64 to i32
  return %crc : i32
}

// block returns s after the block at p.
func.func private @block(%s: !st, %p: !p) -> !st {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c8 = arith.constant 8 : index
  %z = arith.constant 0 : i64
  %stride = func.call @stride() : () -> index
  %k = func.call @words() : () -> index
  %n = func.call @iters() : () -> index
  %kf = func.call @fold_keys() : () -> !st
  %vlen = arith.muli %stride, %n : index
  %kn = arith.muli %k, %n : index
  %slen = arith.muli %kn, %c8 : index
  %r1 = arith.addi %vlen, %slen : index
  %r2 = arith.addi %r1, %slen : index
  %t:4 = scf.for %i = %c0 to %n step %c1 iter_args(%v = %s, %a = %z, %b = %z, %c = %z)
      -> (!st, i64, i64, i64) {
    %o = arith.muli %i, %stride : index
    %f = func.call @fold(%v, %kf, %p, %o) : (!st, !st, !p, index) -> !st
    %ik = arith.muli %i, %k : index
    %u:3 = scf.for %j = %c0 to %k step %c1 iter_args(%x = %a, %y = %b, %w = %c) -> (i64, i64, i64) {
      %wi = arith.addi %ik, %j : index
      %wo = arith.muli %wi, %c8 : index
      %oa = arith.addi %vlen, %wo : index
      %ob = arith.addi %r1, %wo : index
      %oc = arith.addi %r2, %wo : index
      %da = func.call @word(%p, %oa) : (!p, index) -> i64
      %db = func.call @word(%p, %ob) : (!p, index) -> i64
      %dc = func.call @word(%p, %oc) : (!p, index) -> i64
      %xa = func.call @crc32(%x, %da) : (i64, i64) -> i64
      %xb = func.call @crc32(%y, %db) : (i64, i64) -> i64
      %xc = func.call @crc32(%w, %dc) : (i64, i64) -> i64
      scf.yield %xa, %xb, %xc : i64, i64, i64
    }
    scf.yield %f, %u#0, %u#1, %u#2 : !st, i64, i64, i64
  }
  %kb = func.call @block_keys() : () -> !st
  %kc = func.call @chain_keys() : () -> vector<3xi64>
  %ka = vector.extract %kc[0] : i64 from vector<3xi64>
  %kk = vector.extract %kc[1] : i64 from vector<3xi64>
  %kl = vector.extract %kc[2] : i64 from vector<3xi64>
  %m = func.call @clmul2(%t#0, %kb) : (!st, !st) -> !st
  %j1 = func.call @join(%m, %t#1, %ka) : (!st, i64, i64) -> !st
  %j2 = func.call @join(%j1, %t#2, %kk) : (!st, i64, i64) -> !st
  %j3 = func.call @join(%j2, %t#3, %kl) : (!st, i64, i64) -> !st
  return %j3 : !st
}

// minlz_crc32c_fold returns the CRC state after the n bytes at p, starting from state c. The CRC
// state is the CRC without its final inversion, as the CRC32 instructions keep it. n is a whole
// number of strides.
func.func @minlz_crc32c_fold(%c: i32, %p: !p, %n: i64) -> i32 {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c24 = arith.constant 24 : index
  %stride = func.call @stride() : () -> index
  %k = func.call @words() : () -> index
  %iters = func.call @iters() : () -> index
  %kf = func.call @fold_keys() : () -> !st
  %kc = func.call @chain_keys() : () -> vector<3xi64>
  %ks = vector.extract %kc[2] : i64 from vector<3xi64>
  %z = arith.constant dense<0> : !st
  %cw = arith.extui %c : i32 to i64
  %s0 = func.call @join(%z, %cw, %ks) : (!st, i64, i64) -> !st
  %vlen = arith.muli %stride, %iters : index
  %kn = arith.muli %k, %iters : index
  %slen = arith.muli %kn, %c24 : index
  %blen = arith.addi %vlen, %slen : index
  %ni = arith.index_cast %n : i64 to index
  %nb = arith.divui %ni, %blen : index
  %s1 = scf.for %b = %c0 to %nb step %c1 iter_args(%s = %s0) -> (!st) {
    %o = arith.muli %b, %blen : index
    %pb = func.call @at(%p, %o) : (!p, index) -> !p
    %r = func.call @block(%s, %pb) : (!st, !p) -> !st
    scf.yield %r : !st
  }
  %done = arith.muli %nb, %blen : index
  %s2 = scf.for %o = %done to %ni step %stride iter_args(%s = %s1) -> (!st) {
    %r = func.call @fold(%s, %kf, %p, %o) : (!st, !st, !p, index) -> !st
    scf.yield %r : !st
  }
  %r:2 = func.call @lanes(%s2) : (!st) -> (i64, i64)
  %crc = func.call @reduce(%r#0, %r#1) : (i64, i64) -> i32
  return %crc : i32
}

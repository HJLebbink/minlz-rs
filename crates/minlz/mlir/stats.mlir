// The stream checks of a SIMD block chunk, for every target: sums, counts and range checks of the
// token, literal length and offset symbol streams. `cargo xtask mlir` puts common.mlir and a
// target file (stats/*.mlir) in front of this file and lowers the result once per target. The
// naked functions in crates/minlz/src/block/simd/mlir.rs hold the output; block::simd::decode
// finishes the bytes after the last 64.
//
// Each kernel takes (p, n, r): n bytes at p, a multiple of 64, and r, where it writes its sums.
// It returns 0 if every byte is in range, and 1 if not. The sums are exact for any bytes. Each
// sum adds the bytes of a chunk of 64 to the lanes of an accumulator, as the target adds them
// best, and adds the lanes up once per group of chunks. The range checks keep the largest byte of
// each lane.
//
// The target file gives:
// - !acc, the type of an accumulator, and @acc_zero() -> !acc;
// - @acc_add(!acc, vector<64xi8>) -> !acc, which adds the bytes to the lanes;
// - @acc_total(!acc) -> i64, the sum of the lanes;
// - !cnt, the type of a byte counter, with @cnt_zero() -> !cnt, @cnt_add(!cnt, vector<64xi1>)
//   -> !cnt, which counts the set lanes of a mask, and @cnt_total(!cnt) -> i64, the count so far;
// - @group() -> index, how many chunks a lane takes before it could overflow.

!v = vector<64xi8>

// load returns the 64 bytes at p + o.
func.func private @load(%p: !p, %o: index) -> !v {
  %q = func.call @at(%p, %o) : (!p, index) -> !p
  %r = ptr.load %q alignment = 1 : !p -> !v
  return %r : !v
}

// bad returns 1 if the largest byte of m is above max, and 0 if not.
func.func private @bad(%m: !v, %max: i8) -> i64 {
  %x = vector.reduction <maxui>, %m : !v into i8
  %b = arith.cmpi ugt, %x, %max : i8
  %r = arith.extui %b : i1 to i64
  return %r : i64
}

// store writes x to r + 8·i.
func.func private @store(%r: !p, %i: index, %x: i64) {
  %q = func.call @at8(%r, %i) : (!p, index) -> !p
  ptr.store %x, %q alignment = 8 : i64, !p
  return
}

// group_len returns the bytes of a group of chunks.
func.func private @group_len() -> index {
  %c64 = arith.constant 64 : index
  %g = func.call @group() : () -> index
  %r = arith.muli %g, %c64 : index
  return %r : index
}

// minlz_stats_tok sums the tokens at p: r[0] is the sum of the match length codes t >> 2, r[1]
// the operations with literals (bit 1), r[2] the repeats (bit 0), and r[3] the escaped matches,
// whose match length code is 33 (bits 7 and 2). A token above 135 is out of range.
//
// Every byte t is 4·(t >> 2) + 2·((t >> 1) & 1) + (t & 1), so the loop adds up t, t & 3 and
// t & 1, and the codes come out of those three exact sums once the loops are over.
func.func @minlz_stats_tok(%p: !p, %n: i64, %r: !p) -> i64 {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c3 = arith.constant 3 : index
  %c64 = arith.constant 64 : index
  %four = arith.constant 4 : i64
  %two = arith.constant 2 : i64
  %z = arith.constant 0 : i64
  %zv = arith.constant dense<0> : !v
  %v1 = arith.constant dense<1> : !v
  %v3 = arith.constant dense<3> : !v
  %v5 = arith.constant dense<5> : !v
  %max = arith.constant -121 : i8
  %ni = arith.index_cast %n : i64 to index
  %glen = func.call @group_len() : () -> index
  %res:5 = scf.for %go = %c0 to %ni step %glen
      iter_args(%out = %z, %lit = %z, %rep = %z, %esc = %z, %mx = %zv)
      -> (i64, i64, i64, i64, !v) {
    %ge0 = arith.addi %go, %glen : index
    %ge = arith.minui %ge0, %ni : index
    %a0 = func.call @acc_zero() : () -> !acc
    %k0 = func.call @cnt_zero() : () -> !cnt
    %g:5 = scf.for %o = %go to %ge step %c64
        iter_args(%ao = %a0, %al = %a0, %ar = %k0, %ae = %k0, %m = %mx)
        -> (!acc, !acc, !cnt, !cnt, !v) {
      %t = func.call @load(%p, %o) : (!p, index) -> !v
      %ao2 = func.call @acc_add(%ao, %t) : (!acc, !v) -> !acc
      %t3 = arith.andi %t, %v3 : !v
      %al2 = func.call @acc_add(%al, %t3) : (!acc, !v) -> !acc
      %t1 = arith.andi %t, %v1 : !v
      %mr = arith.cmpi ne, %t1, %zv : !v
      %ar2 = func.call @cnt_add(%ar, %mr) : (!cnt, vector<64xi1>) -> !cnt
      // Bit 2 of t is bit 7 of t << 5, so bit 7 of (t << 5) & t is set exactly where t has both
      // bits 7 and 2, which is where the byte is negative as a signed byte.
      %t5 = arith.shli %t, %v5 : !v
      %e = arith.andi %t5, %t : !v
      %me = arith.cmpi slt, %e, %zv : !v
      %ae2 = func.call @cnt_add(%ae, %me) : (!cnt, vector<64xi1>) -> !cnt
      %m2 = arith.maxui %m, %t : !v
      scf.yield %ao2, %al2, %ar2, %ae2, %m2 : !acc, !acc, !cnt, !cnt, !v
    }
    %so = func.call @acc_total(%g#0) : (!acc) -> i64
    %sl = func.call @acc_total(%g#1) : (!acc) -> i64
    %sr = func.call @cnt_total(%g#2) : (!cnt) -> i64
    %se = func.call @cnt_total(%g#3) : (!cnt) -> i64
    %out2 = arith.addi %out, %so : i64
    %lit2 = arith.addi %lit, %sl : i64
    %rep2 = arith.addi %rep, %sr : i64
    %esc2 = arith.addi %esc, %se : i64
    scf.yield %out2, %lit2, %rep2, %esc2, %g#4 : i64, i64, i64, i64, !v
  }
  %codes = arith.subi %res#0, %res#1 : i64
  %codes2 = arith.divui %codes, %four : i64
  %lits = arith.subi %res#1, %res#2 : i64
  %lits2 = arith.divui %lits, %two : i64
  func.call @store(%r, %c0, %codes2) : (!p, index, i64) -> ()
  func.call @store(%r, %c1, %lits2) : (!p, index, i64) -> ()
  func.call @store(%r, %c2, %res#2) : (!p, index, i64) -> ()
  func.call @store(%r, %c3, %res#3) : (!p, index, i64) -> ()
  %bad = func.call @bad(%res#4, %max) : (!v, i8) -> i64
  return %bad : i64
}

// minlz_stats_ll sums the literal lengths at p: r[0] is their sum, and r[1] how many are 33, the
// escapes. A length outside 1 to 33 is out of range.
func.func @minlz_stats_ll(%p: !p, %n: i64, %r: !p) -> i64 {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c64 = arith.constant 64 : index
  %z = arith.constant 0 : i64
  %zv = arith.constant dense<0> : !v
  %v1 = arith.constant dense<1> : !v
  %v33 = arith.constant dense<33> : !v
  %max = arith.constant 32 : i8
  %ni = arith.index_cast %n : i64 to index
  %glen = func.call @group_len() : () -> index
  %res:3 = scf.for %go = %c0 to %ni step %glen iter_args(%sum = %z, %esc = %z, %mx = %zv)
      -> (i64, i64, !v) {
    %ge0 = arith.addi %go, %glen : index
    %ge = arith.minui %ge0, %ni : index
    %a0 = func.call @acc_zero() : () -> !acc
    %k0 = func.call @cnt_zero() : () -> !cnt
    %g:3 = scf.for %o = %go to %ge step %c64 iter_args(%as = %a0, %ae = %k0, %m = %mx)
        -> (!acc, !cnt, !v) {
      %t = func.call @load(%p, %o) : (!p, index) -> !v
      %as2 = func.call @acc_add(%as, %t) : (!acc, !v) -> !acc
      %eq = arith.cmpi eq, %t, %v33 : !v
      %ae2 = func.call @cnt_add(%ae, %eq) : (!cnt, vector<64xi1>) -> !cnt
      // 0 wraps to 255, so 1 to 33 is at most 32.
      %t1 = arith.subi %t, %v1 : !v
      %m2 = arith.maxui %m, %t1 : !v
      scf.yield %as2, %ae2, %m2 : !acc, !cnt, !v
    }
    %ss = func.call @acc_total(%g#0) : (!acc) -> i64
    %se = func.call @cnt_total(%g#1) : (!cnt) -> i64
    %sum2 = arith.addi %sum, %ss : i64
    %esc2 = arith.addi %esc, %se : i64
    scf.yield %sum2, %esc2, %g#2 : i64, i64, !v
  }
  func.call @store(%r, %c0, %res#0) : (!p, index, i64) -> ()
  func.call @store(%r, %c1, %res#1) : (!p, index, i64) -> ()
  %bad = func.call @bad(%res#2, %max) : (!v, i8) -> i64
  return %bad : i64
}

// minlz_stats_off sums the raw bits of the offset symbols at p into r[0]: max(s >> 3, 1) - 1 for
// symbol s. A symbol outside 1 to 175 is out of range.
func.func @minlz_stats_off(%p: !p, %n: i64, %r: !p) -> i64 {
  %c0 = arith.constant 0 : index
  %c64 = arith.constant 64 : index
  %z = arith.constant 0 : i64
  %zv = arith.constant dense<0> : !v
  %v1 = arith.constant dense<1> : !v
  %v3 = arith.constant dense<3> : !v
  %max = arith.constant -82 : i8
  %ni = arith.index_cast %n : i64 to index
  %glen = func.call @group_len() : () -> index
  %res:2 = scf.for %go = %c0 to %ni step %glen iter_args(%bits = %z, %mx = %zv) -> (i64, !v) {
    %ge0 = arith.addi %go, %glen : index
    %ge = arith.minui %ge0, %ni : index
    %a0 = func.call @acc_zero() : () -> !acc
    %g:2 = scf.for %o = %go to %ge step %c64 iter_args(%ab = %a0, %m = %mx) -> (!acc, !v) {
      %t = func.call @load(%p, %o) : (!p, index) -> !v
      %t3 = arith.shrui %t, %v3 : !v
      %t31 = arith.maxui %t3, %v1 : !v
      %b = arith.subi %t31, %v1 : !v
      %ab2 = func.call @acc_add(%ab, %b) : (!acc, !v) -> !acc
      // 0 wraps to 255, so 1 to 175 is at most 174.
      %t1 = arith.subi %t, %v1 : !v
      %m2 = arith.maxui %m, %t1 : !v
      scf.yield %ab2, %m2 : !acc, !v
    }
    %sb = func.call @acc_total(%g#0) : (!acc) -> i64
    %bits2 = arith.addi %bits, %sb : i64
    scf.yield %bits2, %g#1 : i64, !v
  }
  func.call @store(%r, %c0, %res#0) : (!p, index, i64) -> ()
  %bad = func.call @bad(%res#1, %max) : (!v, i8) -> i64
  return %bad : i64
}

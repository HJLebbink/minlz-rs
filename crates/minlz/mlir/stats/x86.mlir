// The hooks that both x86-64 targets of stats.mlir share: the total of an accumulator and the
// byte counter, which both keep in one general-purpose register. `cargo xtask mlir` puts this
// file after the target file, which gives !acc and !cnt, and in front of stats.mlir.

// acc_total returns the sum of the lanes of a.
func.func private @acc_total(%a: !acc) -> i64 {
  %r = vector.reduction <add>, %a : !acc into i64
  return %r : i64
}

// cnt_zero returns the counter of no bytes yet.
func.func private @cnt_zero() -> !cnt {
  %r = arith.constant 0 : i64
  return %r : i64
}

// cnt_add adds the number of set lanes of m to c: the mask as one 64-bit word and POPCNT.
func.func private @cnt_add(%c: !cnt, %m: vector<64xi1>) -> !cnt {
  %mw = vector.bitcast %m : vector<64xi1> to vector<1xi64>
  %w = vector.extract %mw[0] : i64 from vector<1xi64>
  %n = llvm.intr.ctpop(%w) : (i64) -> i64
  %r = arith.addi %c, %n : i64
  return %r : i64
}

// cnt_total returns the count so far: c, a 64-bit count of bytes.
func.func private @cnt_total(%c: !cnt) -> i64 {
  return %c : i64
}

// group returns the chunks that a lane takes before acc_total: 64-bit lanes do not overflow.
func.func private @group() -> index {
  %r = arith.constant 1099511627776 : index
  return %r : index
}

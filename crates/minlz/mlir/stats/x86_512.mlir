// Target file of stats.mlir for x86-64 with AVX-512BW: the sums of each 8 bytes in the 8 lanes of
// one zmm register.

!acc = vector<8xi64>

func.func private @acc_zero() -> !acc {
  %r = arith.constant dense<0> : !acc
  return %r : !acc
}

// acc_add adds the sums of each 8 bytes of v to the lanes of a: VPSADBW against zero.
func.func private @acc_add(%a: !acc, %v: vector<64xi8>) -> !acc {
  %z = arith.constant dense<0> : vector<64xi8>
  %s = llvm.call_intrinsic "llvm.x86.avx512.psad.bw.512"(%v, %z)
      : (vector<64xi8>, vector<64xi8>) -> !acc
  %r = arith.addi %a, %s : !acc
  return %r : !acc
}

func.func private @acc_total(%a: !acc) -> i64 {
  %r = vector.reduction <add>, %a : !acc into i64
  return %r : i64
}

// group returns the chunks that a lane takes before acc_total: 64-bit lanes do not overflow.
func.func private @group() -> index {
  %r = arith.constant 1099511627776 : index
  return %r : index
}

// Target file of stats.mlir for x86-64 with AVX-512BW: the sums of each 8 bytes in the 8 lanes of
// one zmm register, and a count of bytes in one general-purpose register.

!acc = vector<8xi64>
!cnt = i64

// acc_add adds the sums of each 8 bytes of v to the lanes of a: VPSADBW against zero.
func.func private @acc_add(%a: !acc, %v: vector<64xi8>) -> !acc {
  %z = arith.constant dense<0> : vector<64xi8>
  %s = llvm.call_intrinsic "llvm.x86.avx512.psad.bw.512"(%v, %z)
      : (vector<64xi8>, vector<64xi8>) -> !acc
  %r = arith.addi %a, %s : !acc
  return %r : !acc
}

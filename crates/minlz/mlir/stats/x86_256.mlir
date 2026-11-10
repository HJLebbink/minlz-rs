// Target file of stats.mlir for x86-64 with AVX2: the sums of each 8 bytes in the 8 lanes of two
// ymm registers.

!acc = vector<8xi64>

func.func private @acc_zero() -> !acc {
  %r = arith.constant dense<0> : !acc
  return %r : !acc
}

// acc_add adds the sums of each 8 bytes of v to the lanes of a: VPSADBW against zero on each
// half.
func.func private @acc_add(%a: !acc, %v: vector<64xi8>) -> !acc {
  %z = arith.constant dense<0> : vector<32xi8>
  %lo = vector.extract_strided_slice %v {offsets = [0], sizes = [32], strides = [1]}
      : vector<64xi8> to vector<32xi8>
  %hi = vector.extract_strided_slice %v {offsets = [32], sizes = [32], strides = [1]}
      : vector<64xi8> to vector<32xi8>
  %sl = llvm.call_intrinsic "llvm.x86.avx2.psad.bw"(%lo, %z)
      : (vector<32xi8>, vector<32xi8>) -> vector<4xi64>
  %sh = llvm.call_intrinsic "llvm.x86.avx2.psad.bw"(%hi, %z)
      : (vector<32xi8>, vector<32xi8>) -> vector<4xi64>
  %s = vector.shuffle %sl, %sh [0, 1, 2, 3, 4, 5, 6, 7] : vector<4xi64>, vector<4xi64>
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

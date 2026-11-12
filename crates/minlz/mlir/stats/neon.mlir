// Target file of stats.mlir for NEON: the sums of each 2 bytes in the 32 16-bit lanes of four q
// registers. A count of bytes is an accumulator of the same shape.

!acc = vector<32xi16>
!cnt = vector<32xi16>

func.func private @acc_zero() -> !acc {
  %r = arith.constant dense<0> : !acc
  return %r : !acc
}

// pairs returns the sums of each 2 bytes of q: UADDLP.
func.func private @pairs(%q: vector<16xi8>) -> vector<8xi16> {
  %r = llvm.call_intrinsic "llvm.aarch64.neon.uaddlp"(%q) : (vector<16xi8>) -> vector<8xi16>
  return %r : vector<8xi16>
}

// acc_add adds the sums of each 2 bytes of v to the lanes of a: UADALP, which LLVM makes of UADDLP
// and an add.
func.func private @acc_add(%a: !acc, %v: vector<64xi8>) -> !acc {
  %q0 = vector.extract_strided_slice %v {offsets = [0], sizes = [16], strides = [1]}
      : vector<64xi8> to vector<16xi8>
  %q1 = vector.extract_strided_slice %v {offsets = [16], sizes = [16], strides = [1]}
      : vector<64xi8> to vector<16xi8>
  %q2 = vector.extract_strided_slice %v {offsets = [32], sizes = [16], strides = [1]}
      : vector<64xi8> to vector<16xi8>
  %q3 = vector.extract_strided_slice %v {offsets = [48], sizes = [16], strides = [1]}
      : vector<64xi8> to vector<16xi8>
  %s0 = func.call @pairs(%q0) : (vector<16xi8>) -> vector<8xi16>
  %s1 = func.call @pairs(%q1) : (vector<16xi8>) -> vector<8xi16>
  %s2 = func.call @pairs(%q2) : (vector<16xi8>) -> vector<8xi16>
  %s3 = func.call @pairs(%q3) : (vector<16xi8>) -> vector<8xi16>
  %h0 = vector.shuffle %s0, %s1 [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
      : vector<8xi16>, vector<8xi16>
  %h1 = vector.shuffle %s2, %s3 [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
      : vector<8xi16>, vector<8xi16>
  %s = vector.shuffle %h0, %h1 [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
      16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ] : vector<16xi16>, vector<16xi16>
  %r = arith.addi %a, %s : !acc
  return %r : !acc
}

func.func private @acc_total(%a: !acc) -> i64 {
  %w = arith.extui %a : !acc to vector<32xi32>
  %s = vector.reduction <add>, %w : vector<32xi32> into i32
  %r = arith.extui %s : i32 to i64
  return %r : i64
}

func.func private @cnt_zero() -> !cnt {
  %r = arith.constant dense<0> : !cnt
  return %r : !cnt
}

// cnt_add adds each set lane of m to c as a byte of 255, which the compare mask already is, so
// cnt_total divides the sum by 255.
func.func private @cnt_add(%c: !cnt, %m: vector<64xi1>) -> !cnt {
  %vm1 = arith.constant dense<-1> : vector<64xi8>
  %zv = arith.constant dense<0> : vector<64xi8>
  %b = arith.select %m, %vm1, %zv : vector<64xi1>, vector<64xi8>
  %s = func.call @acc_add(%c, %b) : (!acc, vector<64xi8>) -> !acc
  return %s : !cnt
}

func.func private @cnt_total(%c: !cnt) -> i64 {
  %c255 = arith.constant 255 : i64
  %s = func.call @acc_total(%c) : (!acc) -> i64
  %r = arith.divui %s, %c255 : i64
  return %r : i64
}

// group returns the chunks that a lane takes before acc_total: each chunk adds at most 2·255 to a
// 16-bit lane.
func.func private @group() -> index {
  %r = arith.constant 128 : index
  return %r : index
}

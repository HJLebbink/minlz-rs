// Target file of exec.mlir and exec8.mlir for NEON: TBL permutes and expands bytes.

// tbl8 returns byte idx[i] of v in byte i, or 0 where idx[i] is 0x80: TBL with one register.
func.func private @tbl8(%v: i64, %idx: i64) -> i64 {
  %z = arith.constant 0 : i64
  %vv = vector.from_elements %v, %z : vector<2xi64>
  %iv = vector.from_elements %idx : vector<1xi64>
  %vb = vector.bitcast %vv : vector<2xi64> to vector<16xi8>
  %ib = vector.bitcast %iv : vector<1xi64> to vector<8xi8>
  %rb = llvm.call_intrinsic "llvm.aarch64.neon.tbl1.v8i8"(%vb, %ib)
      : (vector<16xi8>, vector<8xi8>) -> vector<8xi8>
  %rv = vector.bitcast %rb : vector<8xi8> to vector<1xi64>
  %r = vector.extract %rv[0] : i64 from vector<1xi64>
  return %r : i64
}

// permute returns byte idx[i] of t in byte i: TBL with two registers, once for each half.
func.func private @permute(%t: vector<32xi8>, %idx: vector<32xi8>) -> vector<32xi8> {
  %a = vector.extract_strided_slice %t {offsets = [0], sizes = [16], strides = [1]}
      : vector<32xi8> to vector<16xi8>
  %b = vector.extract_strided_slice %t {offsets = [16], sizes = [16], strides = [1]}
      : vector<32xi8> to vector<16xi8>
  %i0 = vector.extract_strided_slice %idx {offsets = [0], sizes = [16], strides = [1]}
      : vector<32xi8> to vector<16xi8>
  %i1 = vector.extract_strided_slice %idx {offsets = [16], sizes = [16], strides = [1]}
      : vector<32xi8> to vector<16xi8>
  %r0 = llvm.call_intrinsic "llvm.aarch64.neon.tbl2.v16i8"(%a, %b, %i0)
      : (vector<16xi8>, vector<16xi8>, vector<16xi8>) -> vector<16xi8>
  %r1 = llvm.call_intrinsic "llvm.aarch64.neon.tbl2.v16i8"(%a, %b, %i1)
      : (vector<16xi8>, vector<16xi8>, vector<16xi8>) -> vector<16xi8>
  %r = vector.shuffle %r0, %r1 [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
      16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ] : vector<16xi8>, vector<16xi8>
  return %r : vector<32xi8>
}

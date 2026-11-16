// The hook that both x86-64 targets of exec.mlir share: the table of 8 bytes. `cargo xtask mlir`
// puts this file after the target file and in front of exec.mlir.

// tbl8 returns byte idx[i] of v in byte i, or 0 where idx[i] is 0x80: PSHUFB.
func.func private @tbl8(%v: i64, %idx: i64) -> i64 {
  %z = arith.constant 0 : i64
  %vv = vector.from_elements %v, %z : vector<2xi64>
  %iv = vector.from_elements %idx, %z : vector<2xi64>
  %vb = vector.bitcast %vv : vector<2xi64> to vector<16xi8>
  %ib = vector.bitcast %iv : vector<2xi64> to vector<16xi8>
  %rb = llvm.call_intrinsic "llvm.x86.ssse3.pshuf.b.128"(%vb, %ib)
      : (vector<16xi8>, vector<16xi8>) -> vector<16xi8>
  %rv = vector.bitcast %rb : vector<16xi8> to vector<2xi64>
  %r = vector.extract %rv[0] : i64 from vector<2xi64>
  return %r : i64
}

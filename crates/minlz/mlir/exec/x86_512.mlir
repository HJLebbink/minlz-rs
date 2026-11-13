// Target file of exec.mlir and exec64.mlir for x86-64 with AVX-512 VBMI and VBMI2: VPEXPANDB
// expands bytes, VPERMB permutes them.

// expand64 returns, in byte i, the next value at p + o if f[i], and 0 if not, and the offset after
// the values it took: VPEXPANDB, which only reads the values it takes.
func.func private @expand64(%p: !p, %o: index, %f: vector<64xi1>, %a: !p)
    -> (vector<64xi8>, index) {
  %z = arith.constant dense<0> : vector<64xi8>
  %q = func.call @at(%p, %o) : (!p, index) -> !p
  %x = llvm.call_intrinsic "llvm.masked.expandload.v64i8"(%q, %f, %z)
      : (!p, vector<64xi1>, vector<64xi8>) -> vector<64xi8>
  %fw = vector.bitcast %f : vector<64xi1> to vector<1xi64>
  %w = vector.extract %fw[0] : i64 from vector<1xi64>
  %n = llvm.intr.ctpop(%w) : (i64) -> i64
  %ni = arith.index_castui %n : i64 to index
  %o2 = arith.addi %o, %ni : index
  return %x, %o2 : vector<64xi8>, index
}

// permute returns byte idx[i] of t in byte i: VPERMB.
func.func private @permute(%t: vector<32xi8>, %idx: vector<32xi8>) -> vector<32xi8> {
  %r = llvm.call_intrinsic "llvm.x86.avx512.permvar.qi.256"(%t, %idx)
      : (vector<32xi8>, vector<32xi8>) -> vector<32xi8>
  return %r : vector<32xi8>
}

// permute64 returns byte idx[i] of t in byte i: VPERMB on 512 bits.
func.func private @permute64(%t: vector<64xi8>, %idx: vector<64xi8>) -> vector<64xi8> {
  %r = llvm.call_intrinsic "llvm.x86.avx512.permvar.qi.512"(%t, %idx)
      : (vector<64xi8>, vector<64xi8>) -> vector<64xi8>
  return %r : vector<64xi8>
}

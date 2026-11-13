// Target file of exec.mlir and exec64.mlir for x86-64 with AVX2: PSHUFB permutes and expands
// bytes.

// expand64 returns, in byte i, the next value at p + o if f[i], and 0 if not, with the offset
// after the values it took: @expand8v for each 8 flags, whose words come straight out of the flag
// bytes and whose results are joined into the answer, so neither crosses memory.
func.func private @expand64(%p: !p, %o: index, %f: vector<64xi1>) -> (vector<64xi8>, index) {
  %ones0 = arith.constant 72340172838076673 : i64
  // Opaque to LLVM, which would otherwise make c - f in expand8 a second multiply.
  %ones = llvm.inline_asm "", "=r,0" %ones0 : (i64) -> i64
  %z = arith.constant dense<0> : vector<64xi8>
  %one = arith.constant dense<1> : vector<64xi8>
  %fb = arith.select %f, %one, %z : vector<64xi1>, vector<64xi8>
  %fw = vector.bitcast %fb : vector<64xi8> to vector<8xi64>
  %f0 = vector.extract %fw[0] : i64 from vector<8xi64>
  %f1 = vector.extract %fw[1] : i64 from vector<8xi64>
  %f2 = vector.extract %fw[2] : i64 from vector<8xi64>
  %f3 = vector.extract %fw[3] : i64 from vector<8xi64>
  %f4 = vector.extract %fw[4] : i64 from vector<8xi64>
  %f5 = vector.extract %fw[5] : i64 from vector<8xi64>
  %f6 = vector.extract %fw[6] : i64 from vector<8xi64>
  %f7 = vector.extract %fw[7] : i64 from vector<8xi64>
  %y0, %o1 = func.call @expand8v(%p, %o, %f0, %ones)
      : (!p, index, i64, i64) -> (vector<8xi8>, index)
  %y1, %o2 = func.call @expand8v(%p, %o1, %f1, %ones)
      : (!p, index, i64, i64) -> (vector<8xi8>, index)
  %y2, %o3 = func.call @expand8v(%p, %o2, %f2, %ones)
      : (!p, index, i64, i64) -> (vector<8xi8>, index)
  %y3, %o4 = func.call @expand8v(%p, %o3, %f3, %ones)
      : (!p, index, i64, i64) -> (vector<8xi8>, index)
  %y4, %o5 = func.call @expand8v(%p, %o4, %f4, %ones)
      : (!p, index, i64, i64) -> (vector<8xi8>, index)
  %y5, %o6 = func.call @expand8v(%p, %o5, %f5, %ones)
      : (!p, index, i64, i64) -> (vector<8xi8>, index)
  %y6, %o7 = func.call @expand8v(%p, %o6, %f6, %ones)
      : (!p, index, i64, i64) -> (vector<8xi8>, index)
  %y7, %o8 = func.call @expand8v(%p, %o7, %f7, %ones)
      : (!p, index, i64, i64) -> (vector<8xi8>, index)
  %a01 = vector.shuffle %y0, %y1 [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
    ] : vector<8xi8>, vector<8xi8>
  %a23 = vector.shuffle %y2, %y3 [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
    ] : vector<8xi8>, vector<8xi8>
  %a45 = vector.shuffle %y4, %y5 [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
    ] : vector<8xi8>, vector<8xi8>
  %a67 = vector.shuffle %y6, %y7 [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
    ] : vector<8xi8>, vector<8xi8>
  %b0123 = vector.shuffle %a01, %a23 [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
      16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ] : vector<16xi8>, vector<16xi8>
  %b4567 = vector.shuffle %a45, %a67 [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
      16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ] : vector<16xi8>, vector<16xi8>
  %r = vector.shuffle %b0123, %b4567 [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
      16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
      32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
      48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63
    ] : vector<32xi8>, vector<32xi8>
  return %r, %o8 : vector<64xi8>, index
}

// expand8v is @expand8 with its answer as a vector of 8 bytes.
func.func private @expand8v(%p: !p, %o: index, %f: i64, %ones: i64) -> (vector<8xi8>, index) {
  %w, %o2 = func.call @expand8(%p, %o, %f, %ones) : (!p, index, i64, i64) -> (i64, index)
  %wv = vector.from_elements %w : vector<1xi64>
  %r = vector.bitcast %wv : vector<1xi64> to vector<8xi8>
  return %r, %o2 : vector<8xi8>, index
}

// permute returns byte idx[i] of t in byte i, for indexes below 32. PSHUFB takes each index from
// both halves of t, each broadcast to both lanes, and a blend keeps the half that bit 4 names.
func.func private @permute(%t: vector<32xi8>, %idx: vector<32xi8>) -> vector<32xi8> {
  %lo = vector.shuffle %t, %t [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
    ] : vector<32xi8>, vector<32xi8>
  %hi = vector.shuffle %t, %t [
      16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
      16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ] : vector<32xi8>, vector<32xi8>
  %a = llvm.call_intrinsic "llvm.x86.avx2.pshuf.b"(%lo, %idx)
      : (vector<32xi8>, vector<32xi8>) -> vector<32xi8>
  %b = llvm.call_intrinsic "llvm.x86.avx2.pshuf.b"(%hi, %idx)
      : (vector<32xi8>, vector<32xi8>) -> vector<32xi8>
  %c16 = arith.constant dense<16> : vector<32xi8>
  %bit = arith.andi %idx, %c16 : vector<32xi8>
  %z = arith.constant dense<0> : vector<32xi8>
  %upper = arith.cmpi ne, %bit, %z : vector<32xi8>
  %r = arith.select %upper, %b, %a : vector<32xi1>, vector<32xi8>
  return %r : vector<32xi8>
}

// quarter returns bytes 16q to 16q + 15 of t in both halves, for a constant q.
func.func private @quarter(%t: vector<64xi8>, %q: index) -> vector<32xi8> {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %is0 = arith.cmpi eq, %q, %c0 : index
  %is1 = arith.cmpi eq, %q, %c1 : index
  %is2 = arith.cmpi eq, %q, %c2 : index
  %q0 = vector.shuffle %t, %t [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
    ] : vector<64xi8>, vector<64xi8>
  %q1 = vector.shuffle %t, %t [
      16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
      16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ] : vector<64xi8>, vector<64xi8>
  %q2 = vector.shuffle %t, %t [
      32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
      32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47
    ] : vector<64xi8>, vector<64xi8>
  %q3 = vector.shuffle %t, %t [
      48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
      48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63
    ] : vector<64xi8>, vector<64xi8>
  %r2 = arith.select %is2, %q2, %q3 : vector<32xi8>
  %r1 = arith.select %is1, %q1, %r2 : vector<32xi8>
  %r0 = arith.select %is0, %q0, %r1 : vector<32xi8>
  return %r0 : vector<32xi8>
}

// permute32of64 returns byte idx[i] of t in byte i, for 32 indexes below 64: PSHUFB from each 16
// bytes of t, and blends that keep the 16 bytes that bits 4 and 5 of the index name.
func.func private @permute32of64(%t: vector<64xi8>, %idx: vector<32xi8>) -> vector<32xi8> {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c3 = arith.constant 3 : index
  %t0 = func.call @quarter(%t, %c0) : (vector<64xi8>, index) -> vector<32xi8>
  %t1 = func.call @quarter(%t, %c1) : (vector<64xi8>, index) -> vector<32xi8>
  %t2 = func.call @quarter(%t, %c2) : (vector<64xi8>, index) -> vector<32xi8>
  %t3 = func.call @quarter(%t, %c3) : (vector<64xi8>, index) -> vector<32xi8>
  %p0 = llvm.call_intrinsic "llvm.x86.avx2.pshuf.b"(%t0, %idx)
      : (vector<32xi8>, vector<32xi8>) -> vector<32xi8>
  %p1 = llvm.call_intrinsic "llvm.x86.avx2.pshuf.b"(%t1, %idx)
      : (vector<32xi8>, vector<32xi8>) -> vector<32xi8>
  %p2 = llvm.call_intrinsic "llvm.x86.avx2.pshuf.b"(%t2, %idx)
      : (vector<32xi8>, vector<32xi8>) -> vector<32xi8>
  %p3 = llvm.call_intrinsic "llvm.x86.avx2.pshuf.b"(%t3, %idx)
      : (vector<32xi8>, vector<32xi8>) -> vector<32xi8>
  %z = arith.constant dense<0> : vector<32xi8>
  %c16 = arith.constant dense<16> : vector<32xi8>
  %c32 = arith.constant dense<32> : vector<32xi8>
  %b4 = arith.andi %idx, %c16 : vector<32xi8>
  %b5 = arith.andi %idx, %c32 : vector<32xi8>
  %odd = arith.cmpi ne, %b4, %z : vector<32xi8>
  %high = arith.cmpi ne, %b5, %z : vector<32xi8>
  %lo = arith.select %odd, %p1, %p0 : vector<32xi1>, vector<32xi8>
  %hi = arith.select %odd, %p3, %p2 : vector<32xi1>, vector<32xi8>
  %r = arith.select %high, %hi, %lo : vector<32xi1>, vector<32xi8>
  return %r : vector<32xi8>
}

// permute64 returns byte idx[i] of t in byte i: permute32of64 for each half of idx.
func.func private @permute64(%t: vector<64xi8>, %idx: vector<64xi8>) -> vector<64xi8> {
  %i0 = vector.extract_strided_slice %idx {offsets = [0], sizes = [32], strides = [1]}
      : vector<64xi8> to vector<32xi8>
  %i1 = vector.extract_strided_slice %idx {offsets = [32], sizes = [32], strides = [1]}
      : vector<64xi8> to vector<32xi8>
  %r0 = func.call @permute32of64(%t, %i0) : (vector<64xi8>, vector<32xi8>) -> vector<32xi8>
  %r1 = func.call @permute32of64(%t, %i1) : (vector<64xi8>, vector<32xi8>) -> vector<32xi8>
  %r = vector.shuffle %r0, %r1 [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
      16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
      32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
      48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63
    ] : vector<32xi8>, vector<32xi8>
  return %r : vector<64xi8>
}

// The operation loops of SIMD block chunks in batches of 64 operations, for targets with wide
// vectors and few general registers, as x86-64 has. See exec.mlir, which comes before this file.
//
// A batch runs in two steps. The first expands the literal lengths and offset symbols of the
// batch and decodes its offsets, 16 operations to a vector, into the buffer, and keeps the stream
// positions in a. The second copies, 4 operations a loop trip. Each step has the registers it
// needs.
//
// The target file also gives:
// - @expand64(p: !p, o: index, f: vector<64xi1>, a: !p) -> (vector<64xi8>, index), whose byte i
//   is the next value at p + o if f[i], and 0 if not, with the offset after the values it took;
//   its reads stay within 8 bytes past the values, as @expand_swar64's do;
// - @permute64(t: vector<64xi8>, idx: vector<64xi8>) -> vector<64xi8>, whose byte i is byte idx[i]
//   of t, for indexes below 64.

!b = vector<64xi8>
!w = vector<16xi32>

// The buffer of a batch of 64: the literal lengths from byte 192 of a, the offsets, 4 bytes each,
// from byte 256, and two windows of 64 bytes, for tokens from byte 512 and raw bits from byte 576.
func.func private @lens(%a: !p) -> !p {
  %o = arith.constant 192 : index
  %r = func.call @at(%a, %o) : (!p, index) -> !p
  return %r : !p
}

func.func private @offs(%a: !p) -> !p {
  %o = arith.constant 256 : index
  %r = func.call @at(%a, %o) : (!p, index) -> !p
  return %r : !p
}

// window returns the 64 bytes of p from byte o, or, when fewer than 64 bytes from o are
// readable, the n - o bytes up to n followed by stale bytes, copied to s.
func.func private @window(%p: !p, %o: index, %n: index, %s: !p) -> !b {
  %c1 = arith.constant 1 : index
  %c64 = arith.constant 64 : index
  %end = arith.addi %o, %c64 : index
  %fits = arith.cmpi ule, %end, %n : index
  %r = scf.if %fits -> !b {
    %q = func.call @at(%p, %o) : (!p, index) -> !p
    %x = ptr.load %q alignment = 1 : !p -> !b
    scf.yield %x : !b
  } else {
    scf.for %i = %o to %n step %c1 {
      %q = func.call @at(%p, %i) : (!p, index) -> !p
      %x = ptr.load %q : !p -> i8
      %j = arith.subi %i, %o : index
      %qs = func.call @at(%s, %j) : (!p, index) -> !p
      ptr.store %x, %qs : i8, !p
    }
    %x = ptr.load %s alignment = 1 : !p -> !b
    scf.yield %x : !b
  }
  return %r : !b
}

// expand_swar64 is @expand64 for targets without a vector expand load: @expand8 for each 8 values.
// Each step reads the 8 bytes at its offset; the flags and the result pass through the token
// window of a.
func.func private @expand_swar64(%p: !p, %o: index, %f: vector<64xi1>, %a: !p)
    -> (!b, index) {
  %c0 = arith.constant 0 : index
  %c8 = arith.constant 8 : index
  %c64 = arith.constant 64 : index
  %c512 = arith.constant 512 : index
  %ones0 = arith.constant 72340172838076673 : i64
  // Opaque to LLVM, which would otherwise make c - f in expand8 a second multiply.
  %ones = llvm.inline_asm "", "=r,0" %ones0 : (i64) -> i64
  %z = arith.constant dense<0> : !b
  %one = arith.constant dense<1> : !b
  %fb = arith.select %f, %one, %z : vector<64xi1>, !b
  %s = func.call @at(%a, %c512) : (!p, index) -> !p
  ptr.store %fb, %s alignment = 8 : !b, !p
  %r = scf.for %j = %c0 to %c64 step %c8 iter_args(%oj = %o) -> (index) {
    %fw = func.call @word(%s, %j) : (!p, index) -> i64
    %y, %o2 = func.call @expand8(%p, %oj, %fw, %ones) : (!p, index, i64, i64) -> (i64, index)
    %q = func.call @at(%s, %j) : (!p, index) -> !p
    ptr.store %y, %q alignment = 8 : i64, !p
    scf.yield %o2 : index
  }
  %v = ptr.load %s alignment = 8 : !p -> !b
  return %v, %r : !b, index
}

// slice16 returns bytes 16g to 16g + 15 of x as 32-bit lanes, for a constant g.
func.func private @slice16(%x: !b, %g: index) -> !w {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %is0 = arith.cmpi eq, %g, %c0 : index
  %is1 = arith.cmpi eq, %g, %c1 : index
  %is2 = arith.cmpi eq, %g, %c2 : index
  %s0 = vector.extract_strided_slice %x {offsets = [0], sizes = [16], strides = [1]}
      : !b to vector<16xi8>
  %s1 = vector.extract_strided_slice %x {offsets = [16], sizes = [16], strides = [1]}
      : !b to vector<16xi8>
  %s2 = vector.extract_strided_slice %x {offsets = [32], sizes = [16], strides = [1]}
      : !b to vector<16xi8>
  %s3 = vector.extract_strided_slice %x {offsets = [48], sizes = [16], strides = [1]}
      : !b to vector<16xi8>
  %t2 = arith.select %is2, %s2, %s3 : vector<16xi8>
  %t1 = arith.select %is1, %s1, %t2 : vector<16xi8>
  %t0 = arith.select %is0, %s0, %t1 : vector<16xi8>
  %r = arith.extui %t0 : vector<16xi8> to !w
  return %r : !w
}

// shift returns x moved up by k lanes, with fill in the lanes below k, for a constant k of 1, 2,
// 4 or 8.
func.func private @shift(%fill: !w, %x: !w, %k: index) -> !w {
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c4 = arith.constant 4 : index
  %h1 = vector.shuffle %fill, %x [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]
      : !w, !w
  %h2 = vector.shuffle %fill, %x [14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29]
      : !w, !w
  %h4 = vector.shuffle %fill, %x [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27]
      : !w, !w
  %h8 = vector.shuffle %fill, %x [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
      : !w, !w
  %is1 = arith.cmpi eq, %k, %c1 : index
  %is2 = arith.cmpi eq, %k, %c2 : index
  %is4 = arith.cmpi eq, %k, %c4 : index
  %r4 = arith.select %is4, %h4, %h8 : !w
  %r2 = arith.select %is2, %h2, %r4 : !w
  %r1 = arith.select %is1, %h1, %r2 : !w
  return %r1 : !w
}

// decode returns the offsets of operations 16g to 16g + 15 of the batch, with tokens tv and offset
// symbols sv, 0 for repeats, after the offset in every lane of lastv, their raw bits from bit pos
// of raw: the offset each match copies from, raised to min(ml, 32) if raise. Also returns pos and
// the offset after them, not raised, in every lane. Lane i of rel0 holds the raw bits of the
// group's operations before operation i. A new offset is the base of its symbol plus its raw
// bits; a repeat takes the offset before it. Symbols above 175, which the decoder rejects before
// it runs a chunk, decode to offsets other than OFF_TAB's, but their reads stay within raw.
func.func private @decode(%a: !p, %raw: !p, %nraw: index, %tv: !b, %sv: !b, %g: index,
    %rel0: !w, %pos: index, %lastv: !w, %raise: i1) -> (!w, index, !w) {
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c3 = arith.constant 3 : index
  %c4 = arith.constant 4 : index
  %c7 = arith.constant 7 : index
  %c8 = arith.constant 8 : index
  %c576 = arith.constant 576 : index
  %v0 = arith.constant dense<0> : !w
  %v1 = arith.constant dense<1> : !w
  %v2 = arith.constant dense<2> : !w
  %v3 = arith.constant dense<3> : !w
  %v7 = arith.constant dense<7> : !w
  %v8 = arith.constant dense<8> : !w
  %v32 = arith.constant dense<32> : !w
  %s = func.call @slice16(%sv, %g) : (!b, index) -> !w
  // Symbol s has nb = max(s >> 3, 1) - 1 raw bits and base (s & 7 | min(s, 8) & 8) << nb.
  %s3 = arith.shrui %s, %v3 : !w
  %s31 = arith.maxui %s3, %v1 : !w
  %nb = arith.subi %s31, %v1 : !w
  %s7 = arith.andi %s, %v7 : !w
  %s8 = arith.minui %s, %v8 : !w
  %s88 = arith.andi %s8, %v8 : !w
  %b0 = arith.ori %s7, %s88 : !w
  %base = arith.shli %b0, %nb : !w
  %one = arith.shli %v1, %nb : !w
  %mask = arith.subi %one, %v1 : !w
  // The bit position of each operation from byte pos >> 3: rel0 plus pos & 7. Lane 15 of
  // rel0 + nb is the group's total of raw bits.
  %incl = arith.addi %rel0, %nb : !w
  %p7 = arith.andi %pos, %c7 : index
  %p7i = arith.index_castui %p7 : index to i32
  %p7v = vector.broadcast %p7i : i32 to !w
  %bp = arith.addi %rel0, %p7v : !w
  // The 4 bytes from the byte of each bit position, which hold its at most 20 bits after a
  // shift of at most 7. The 16 positions span at most 15 · 20 + 7 bits, so the bytes lie within
  // 64 bytes.
  %rel = arith.shrui %bp, %v3 : !w
  %sh = arith.andi %bp, %v7 : !w
  %relb = vector.bitcast %rel : !w to !b
  %dup = vector.shuffle %relb, %relb [
      0, 0, 0, 0, 4, 4, 4, 4, 8, 8, 8, 8, 12, 12, 12, 12,
      16, 16, 16, 16, 20, 20, 20, 20, 24, 24, 24, 24, 28, 28, 28, 28,
      32, 32, 32, 32, 36, 36, 36, 36, 40, 40, 40, 40, 44, 44, 44, 44,
      48, 48, 48, 48, 52, 52, 52, 52, 56, 56, 56, 56, 60, 60, 60, 60
    ] : !b, !b
  %c0123 = arith.constant dense<[
      0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3,
      0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3,
      0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3,
      0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3
    ]> : !b
  %idx = arith.addi %dup, %c0123 : !b
  %wo = arith.shrui %pos, %c3 : index
  %scr = func.call @at(%a, %c576) : (!p, index) -> !p
  %win = func.call @window(%raw, %wo, %nraw, %scr) : (!p, index, index, !p) -> !b
  %gb = func.call @permute64(%win, %idx) : (!b, !b) -> !b
  %gw = vector.bitcast %gb : !b to !w
  %gs = arith.shrui %gw, %sh : !w
  %bits = arith.andi %gs, %mask : !w
  %on = arith.addi %base, %bits : !w
  // Only repeats have offset 0. Each new offset, below 2^25 for symbols up to 175, gets its lane
  // plus 1 in its top 5 bits, so that a running maximum over the lanes, in four steps, carries
  // the last new offset at or before each lane. A lane with none takes the offset before the
  // group; only that step waits for it.
  %lanes = arith.constant dense<[
      134217728, 268435456, 402653184, 536870912, 671088640, 805306368, 939524096, 1073741824,
      1207959552, 1342177280, 1476395008, 1610612736, 1744830464, 1879048192, 2013265920,
      -2147483648
    ]> : !w
  %new = arith.cmpi ne, %on, %v0 : !w
  %keyed = arith.ori %on, %lanes : !w
  %k0 = arith.select %new, %keyed, %v0 : vector<16xi1>, !w
  %m1 = func.call @shift(%v0, %k0, %c1) : (!w, !w, index) -> !w
  %k1 = arith.maxui %k0, %m1 : !w
  %m2 = func.call @shift(%v0, %k1, %c2) : (!w, !w, index) -> !w
  %k2 = arith.maxui %k1, %m2 : !w
  %m4 = func.call @shift(%v0, %k2, %c4) : (!w, !w, index) -> !w
  %k4 = arith.maxui %k2, %m4 : !w
  %m8 = func.call @shift(%v0, %k4, %c8) : (!w, !w, index) -> !w
  %k8 = arith.maxui %k4, %m8 : !w
  %low = arith.constant dense<134217727> : !w
  %ok = arith.andi %k8, %low : !w
  %none = arith.cmpi eq, %k8, %v0 : !w
  %o = arith.select %none, %lastv, %ok : vector<16xi1>, !w
  %lastv2 = vector.shuffle %o, %o [15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15]
      : !w, !w
  // The raise: to min(ml, 32), which the position covers in flat chunks.
  %t = func.call @slice16(%tv, %g) : (!b, index) -> !w
  %ml = arith.shrui %t, %v2 : !w
  %mlc = arith.minui %ml, %v32 : !w
  %raised = arith.maxui %o, %mlc : !w
  %out = arith.select %raise, %raised, %o : !w
  %total = vector.extract %incl[15] : i32 from !w
  %ti = arith.index_castui %total : i32 to index
  %pos2 = arith.addi %pos, %ti : index
  return %out, %pos2, %lastv2 : !w, index, !w
}

// group decodes operations 16g to 16g + 15 of the batch if the batch has more than 16g, writes
// their offsets to the buffer, and returns pos and the last offset, in every lane, after them.
// rel0 is decode's argument of the same name.
func.func private @group(%a: !p, %raw: !p, %nraw: index, %m: index, %tv: !b, %sv: !b,
    %g: index, %rel0: !w, %pos: index, %lastv: !w, %raise: i1) -> (index, !w) {
  %c4 = arith.constant 4 : index
  %c16 = arith.constant 16 : index
  %start = arith.muli %g, %c16 : index
  %any = arith.cmpi ugt, %m, %start : index
  %r:2 = scf.if %any -> (index, !w) {
    %o, %p2, %x2 = func.call @decode(%a, %raw, %nraw, %tv, %sv, %g, %rel0, %pos, %lastv, %raise)
        : (!p, !p, index, !b, !b, index, !w, index, !w, i1) -> (!w, index, !w)
    %offs = func.call @offs(%a) : (!p) -> !p
    %bo = arith.muli %start, %c4 : index
    %q = func.call @at(%offs, %bo) : (!p, index) -> !p
    ptr.store %o, %q alignment = 4 : !w, !p
    scf.yield %p2, %x2 : index, !w
  } else {
    scf.yield %pos, %lastv : index, !w
  }
  return %r#0, %r#1 : index, !w
}

// expand_batch writes the literal lengths and the offsets of the m operations at tok + k to the
// batch buffer, and moves the offsets in ll and offc, the bit position in raw and the last offset
// in a past them. Operations without literals get length 0. With raise, the offsets are raised
// as decode does.
func.func private @expand_batch(%a: !p, %k: index, %m: index, %raise: i1) {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c3 = arith.constant 3 : index
  %c4 = arith.constant 4 : index
  %c5 = arith.constant 5 : index
  %c7 = arith.constant 7 : index
  %c8 = arith.constant 8 : index
  %c9 = arith.constant 9 : index
  %c12 = arith.constant 12 : index
  %c14 = arith.constant 14 : index
  %c16 = arith.constant 16 : index
  %c17 = arith.constant 17 : index
  %c512 = arith.constant 512 : index
  %tok = func.call @argp(%a, %c2) : (!p, index) -> !p
  %ll = func.call @argp(%a, %c3) : (!p, index) -> !p
  %offc = func.call @argp(%a, %c4) : (!p, index) -> !p
  %raw = func.call @argp(%a, %c5) : (!p, index) -> !p
  %n = func.call @arg(%a, %c8) : (!p, index) -> index
  %pos = func.call @arg(%a, %c9) : (!p, index) -> index
  %last = func.call @arg(%a, %c12) : (!p, index) -> index
  %nraw = func.call @arg(%a, %c14) : (!p, index) -> index
  %li = func.call @arg(%a, %c16) : (!p, index) -> index
  %oi = func.call @arg(%a, %c17) : (!p, index) -> index
  // The tokens of the batch; tok is readable 7 bytes past the n tokens.
  %ntok = arith.addi %n, %c7 : index
  %ts = func.call @at(%a, %c512) : (!p, index) -> !p
  %tv = func.call @window(%tok, %k, %ntok, %ts) : (!p, index, index, !p) -> !b
  %iota = arith.constant dense<[
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
      16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
      32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
      48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63
    ]> : !b
  %m8 = arith.index_castui %m : index to i8
  %mv = vector.broadcast %m8 : i8 to !b
  %live = arith.cmpi ult, %iota, %mv : !b
  %z = arith.constant dense<0> : !b
  %b1 = arith.constant dense<1> : !b
  %b2 = arith.constant dense<2> : !b
  %tl = arith.andi %tv, %b2 : !b
  %hasl = arith.cmpi ne, %tl, %z : !b
  %fl = arith.andi %hasl, %live : vector<64xi1>
  %tr = arith.andi %tv, %b1 : !b
  %new = arith.cmpi eq, %tr, %z : !b
  %fo = arith.andi %new, %live : vector<64xi1>
  %lv, %li2 = func.call @expand64(%ll, %li, %fl, %a) : (!p, index, vector<64xi1>, !p) -> (!b, index)
  %lens = func.call @lens(%a) : (!p) -> !p
  ptr.store %lv, %lens alignment = 8 : !b, !p
  %sv, %oi2 = func.call @expand64(%offc, %oi, %fo, %a)
      : (!p, index, vector<64xi1>, !p) -> (!b, index)
  // nb8 is the raw bit count of each symbol, and excl8 the raw bits of the symbols before it in
  // its 8-symbol word: a prefix sum in three shift-and-add steps, each shift within a 64-bit word.
  // A word holds at most 8 · 30 raw bits, so no byte sum carries into the next byte.
  %sb3 = arith.constant dense<3> : !b
  %n3 = arith.shrui %sv, %sb3 : !b
  %n31 = arith.maxui %n3, %b1 : !b
  %nb8 = arith.subi %n31, %b1 : !b
  %q8 = arith.constant dense<8> : vector<8xi64>
  %q16 = arith.constant dense<16> : vector<8xi64>
  %q32 = arith.constant dense<32> : vector<8xi64>
  %q56 = arith.constant dense<56> : vector<8xi64>
  %w0 = vector.bitcast %nb8 : !b to vector<8xi64>
  %x8b = arith.shli %w0, %q8 : vector<8xi64>
  %b8 = vector.bitcast %x8b : vector<8xi64> to !b
  %y1 = arith.addi %nb8, %b8 : !b
  %w1 = vector.bitcast %y1 : !b to vector<8xi64>
  %x16b = arith.shli %w1, %q16 : vector<8xi64>
  %b16 = vector.bitcast %x16b : vector<8xi64> to !b
  %y2 = arith.addi %y1, %b16 : !b
  %w2 = vector.bitcast %y2 : !b to vector<8xi64>
  %x32b = arith.shli %w2, %q32 : vector<8xi64>
  %b32 = vector.bitcast %x32b : vector<8xi64> to !b
  %y3 = arith.addi %y2, %b32 : !b
  %excl8 = arith.subi %y3, %nb8 : !b
  // The raw bits of each word, word w in lane 2w of a vector of 32-bit lanes and 0 in lane 2w + 1.
  %w3 = vector.bitcast %y3 : !b to vector<8xi64>
  %t64 = arith.shrui %w3, %q56 : vector<8xi64>
  %totw = vector.bitcast %t64 : vector<8xi64> to !w
  %v0w = arith.constant dense<0> : !w
  // Group g holds words 2g and 2g + 1, so its rel0 is excl8 plus, in lanes 8 to 15, the total of
  // word 2g.
  %e0 = func.call @slice16(%excl8, %c0) : (!b, index) -> !w
  %e1 = func.call @slice16(%excl8, %c1) : (!b, index) -> !w
  %e2 = func.call @slice16(%excl8, %c2) : (!b, index) -> !w
  %e3 = func.call @slice16(%excl8, %c3) : (!b, index) -> !w
  %g0 = vector.shuffle %totw, %v0w [16, 16, 16, 16, 16, 16, 16, 16, 0, 0, 0, 0, 0, 0, 0, 0]
      : !w, !w
  %g1 = vector.shuffle %totw, %v0w [16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4]
      : !w, !w
  %g2 = vector.shuffle %totw, %v0w [16, 16, 16, 16, 16, 16, 16, 16, 8, 8, 8, 8, 8, 8, 8, 8]
      : !w, !w
  %g3 = vector.shuffle %totw, %v0w [16, 16, 16, 16, 16, 16, 16, 16, 12, 12, 12, 12, 12, 12, 12, 12]
      : !w, !w
  %rel00 = arith.addi %e0, %g0 : !w
  %rel01 = arith.addi %e1, %g1 : !w
  %rel02 = arith.addi %e2, %g2 : !w
  %rel03 = arith.addi %e3, %g3 : !w
  %l32 = arith.index_castui %last : index to i32
  %lastv = vector.broadcast %l32 : i32 to !w
  %p1, %x1 = func.call @group(%a, %raw, %nraw, %m, %tv, %sv, %c0, %rel00, %pos, %lastv, %raise)
      : (!p, !p, index, index, !b, !b, index, !w, index, !w, i1) -> (index, !w)
  %p2, %x2 = func.call @group(%a, %raw, %nraw, %m, %tv, %sv, %c1, %rel01, %p1, %x1, %raise)
      : (!p, !p, index, index, !b, !b, index, !w, index, !w, i1) -> (index, !w)
  %p3, %x3 = func.call @group(%a, %raw, %nraw, %m, %tv, %sv, %c2, %rel02, %p2, %x2, %raise)
      : (!p, !p, index, index, !b, !b, index, !w, index, !w, i1) -> (index, !w)
  %p4, %x4 = func.call @group(%a, %raw, %nraw, %m, %tv, %sv, %c3, %rel03, %p3, %x3, %raise)
      : (!p, !p, index, index, !b, !b, index, !w, index, !w, i1) -> (index, !w)
  %x40 = vector.extract %x4[0] : i32 from !w
  %last2 = arith.index_castui %x40 : i32 to index
  func.call @set(%a, %c9, %p4) : (!p, index, index) -> ()
  func.call @set(%a, %c12, %last2) : (!p, index, index) -> ()
  func.call @set(%a, %c16, %li2) : (!p, index, index) -> ()
  func.call @set(%a, %c17, %oi2) : (!p, index, index) -> ()
  return
}

// copy_one runs operation j of the batch of 64 at tk; see @op.
func.func private @copy_one(%a: !p, %dst: !p, %lits: !p, %tk: !p, %j: index, %delta: i1,
    %flat: i1, %fd: i1, %d: index, %l: index, %x: index) -> (index, index, index) {
  %c4 = arith.constant 4 : index
  %lens = func.call @lens(%a) : (!p) -> !p
  %offs = func.call @offs(%a) : (!p) -> !p
  %t = func.call @byte(%tk, %j) : (!p, index) -> index
  %len = func.call @byte(%lens, %j) : (!p, index) -> index
  %jo = arith.muli %j, %c4 : index
  %oq = func.call @at(%offs, %jo) : (!p, index) -> !p
  %o32 = ptr.load %oq alignment = 4 : !p -> i32
  %o = arith.index_castui %o32 : i32 to index
  %s:2 = func.call @op(%a, %dst, %lits, %t, %len, %o, %delta, %flat, %fd, %d, %l, %x)
      : (!p, !p, !p, index, index, index, i1, i1, i1, index, index, index) -> (index, index)
  return %s#0, %s#1, %o : index, index, index
}

// copy runs the m operations of the batch of 64 at tk, from output position d, literal position l
// and the offset last before them, and returns d, l and last after them, 4 operations a loop trip.
// With delta, the first 32 literals of each operation are added to their references, and the
// batch holds the offsets unraised. With flat, the chunk has the no-overlap flag.
func.func private @copy(%a: !p, %dst: !p, %lits: !p, %tk: !p, %m: index, %delta: i1,
    %flat: i1, %d: index, %l: index, %last: index) -> (index, index, index) {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c3 = arith.constant 3 : index
  %c4 = arith.constant 4 : index
  %fd = arith.andi %flat, %delta : i1
  %m3 = arith.andi %m, %c3 : index
  %m4 = arith.subi %m, %m3 : index
  %r4:3 = scf.for %j = %c0 to %m4 step %c4 iter_args(%d0 = %d, %l0 = %l, %x = %last)
      -> (index, index, index) {
    %j1 = arith.addi %j, %c1 : index
    %j2 = arith.addi %j, %c2 : index
    %j3 = arith.addi %j, %c3 : index
    %s0:3 = func.call @copy_one(%a, %dst, %lits, %tk, %j, %delta, %flat, %fd, %d0, %l0, %x)
        : (!p, !p, !p, !p, index, i1, i1, i1, index, index, index) -> (index, index, index)
    %s1:3 = func.call @copy_one(%a, %dst, %lits, %tk, %j1, %delta, %flat, %fd, %s0#0, %s0#1,
        %s0#2) : (!p, !p, !p, !p, index, i1, i1, i1, index, index, index) -> (index, index, index)
    %s2:3 = func.call @copy_one(%a, %dst, %lits, %tk, %j2, %delta, %flat, %fd, %s1#0, %s1#1,
        %s1#2) : (!p, !p, !p, !p, index, i1, i1, i1, index, index, index) -> (index, index, index)
    %s3:3 = func.call @copy_one(%a, %dst, %lits, %tk, %j3, %delta, %flat, %fd, %s2#0, %s2#1,
        %s2#2) : (!p, !p, !p, !p, index, i1, i1, i1, index, index, index) -> (index, index, index)
    scf.yield %s3#0, %s3#1, %s3#2 : index, index, index
  }
  %r:3 = scf.for %j = %m4 to %m step %c1 iter_args(%d0 = %r4#0, %l0 = %r4#1, %x = %r4#2)
      -> (index, index, index) {
    %s:3 = func.call @copy_one(%a, %dst, %lits, %tk, %j, %delta, %flat, %fd, %d0, %l0, %x)
        : (!p, !p, !p, !p, index, i1, i1, i1, index, index, index) -> (index, index, index)
    scf.yield %s#0, %s#1, %s#2 : index, index, index
  }
  return %r#0, %r#1, %r#2 : index, index, index
}

// run runs the operations of the kernel arguments a in batches of 64.
func.func private @run(%a: !p, %delta: i1, %flat: i1) {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c8 = arith.constant 8 : index
  %c10 = arith.constant 10 : index
  %c11 = arith.constant 11 : index
  %c12 = arith.constant 12 : index
  %c64 = arith.constant 64 : index
  %true = arith.constant true
  %notdelta = arith.xori %delta, %true : i1
  %raise = arith.andi %flat, %notdelta : i1
  %dst = func.call @argp(%a, %c0) : (!p, index) -> !p
  %lits = func.call @argp(%a, %c1) : (!p, index) -> !p
  %tok = func.call @argp(%a, %c2) : (!p, index) -> !p
  %n = func.call @arg(%a, %c8) : (!p, index) -> index
  %d = func.call @arg(%a, %c10) : (!p, index) -> index
  %l = func.call @arg(%a, %c11) : (!p, index) -> index
  %last = func.call @arg(%a, %c12) : (!p, index) -> index
  // k is the index of the next token. The batch keeps the last offset in a; with delta, the copy
  // loop keeps it as well.
  %s:3 = scf.for %k = %c0 to %n step %c64 iter_args(%d0 = %d, %l0 = %l, %x = %last)
      -> (index, index, index) {
    %left = arith.subi %n, %k : index
    %m = arith.minui %left, %c64 : index
    func.call @expand_batch(%a, %k, %m, %raise) : (!p, index, index, i1) -> ()
    %tk = func.call @at(%tok, %k) : (!p, index) -> !p
    %d2, %l2, %x2 = func.call @copy(%a, %dst, %lits, %tk, %m, %delta, %flat, %d0, %l0, %x)
        : (!p, !p, !p, !p, index, i1, i1, index, index, index) -> (index, index, index)
    scf.yield %d2, %l2, %x2 : index, index, index
  }
  func.call @set(%a, %c10, %s#0) : (!p, index, index) -> ()
  func.call @set(%a, %c11, %s#1) : (!p, index, index) -> ()
  return
}

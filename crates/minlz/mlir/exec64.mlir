// The operation loops of SIMD block chunks in batches of 64 operations, for targets with wide
// vectors and few general registers, as x86-64 has. See exec.mlir, which comes before this file.
//
// A batch runs in two steps. The first expands the literal lengths and offset symbols of the
// batch and decodes its offsets, 16 operations to a vector, into the buffer, and keeps the stream
// positions in a. The second copies, one operation a loop trip, reading the tokens, lengths and
// offsets of the batch from the buffer. Each step has the registers it needs.
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
// the offset after them, not raised, in every lane. A new offset is the base of its symbol plus
// its raw bits; a repeat takes the offset before it. Symbols above 175, which the decoder rejects
// before it runs a chunk, decode to offsets other than OFF_TAB's, but their reads stay within raw.
func.func private @decode(%a: !p, %raw: !p, %nraw: index, %tv: !b, %sv: !b, %g: index,
    %pos: index, %lastv: !w, %raise: i1) -> (!w, index, !w) {
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
  // The bit position of each operation from byte pos >> 3: the raw bits before it, summed over
  // the lanes in four steps, plus pos & 7.
  %x1 = func.call @shift(%v0, %nb, %c1) : (!w, !w, index) -> !w
  %y1 = arith.addi %nb, %x1 : !w
  %x2 = func.call @shift(%v0, %y1, %c2) : (!w, !w, index) -> !w
  %y2 = arith.addi %y1, %x2 : !w
  %x4 = func.call @shift(%v0, %y2, %c4) : (!w, !w, index) -> !w
  %y4 = arith.addi %y2, %x4 : !w
  %x8 = func.call @shift(%v0, %y4, %c8) : (!w, !w, index) -> !w
  %incl = arith.addi %y4, %x8 : !w
  %excl = arith.subi %incl, %nb : !w
  %p7 = arith.andi %pos, %c7 : index
  %p7i = arith.index_castui %p7 : index to i32
  %p7v = vector.broadcast %p7i : i32 to !w
  %bp = arith.addi %excl, %p7v : !w
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
func.func private @group(%a: !p, %raw: !p, %nraw: index, %m: index, %tv: !b, %sv: !b,
    %g: index, %pos: index, %lastv: !w, %raise: i1) -> (index, !w) {
  %c4 = arith.constant 4 : index
  %c16 = arith.constant 16 : index
  %start = arith.muli %g, %c16 : index
  %any = arith.cmpi ugt, %m, %start : index
  %r:2 = scf.if %any -> (index, !w) {
    %o, %p2, %x2 = func.call @decode(%a, %raw, %nraw, %tv, %sv, %g, %pos, %lastv, %raise)
        : (!p, !p, index, !b, !b, index, index, !w, i1) -> (!w, index, !w)
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

// expand_batch writes the tokens, the literal lengths and the offsets of the m operations at
// tok + k to the batch buffer, and moves the offsets in ll and offc, the bit position in raw and
// the last offset in a past them. Operations without literals get length 0. With raise, the
// offsets are raised as decode does.
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
  // The copy loop reads the token of operation j at byte 512 + j of a, as it reads its length at
  // byte 192 + j. The store is after both expand calls: @expand_swar64 uses these bytes as scratch.
  ptr.store %tv, %ts alignment = 8 : !b, !p
  %l32 = arith.index_castui %last : index to i32
  %lastv = vector.broadcast %l32 : i32 to !w
  %p1, %x1 = func.call @group(%a, %raw, %nraw, %m, %tv, %sv, %c0, %pos, %lastv, %raise)
      : (!p, !p, index, index, !b, !b, index, index, !w, i1) -> (index, !w)
  %p2, %x2 = func.call @group(%a, %raw, %nraw, %m, %tv, %sv, %c1, %p1, %x1, %raise)
      : (!p, !p, index, index, !b, !b, index, index, !w, i1) -> (index, !w)
  %p3, %x3 = func.call @group(%a, %raw, %nraw, %m, %tv, %sv, %c2, %p2, %x2, %raise)
      : (!p, !p, index, index, !b, !b, index, index, !w, i1) -> (index, !w)
  %p4, %x4 = func.call @group(%a, %raw, %nraw, %m, %tv, %sv, %c3, %p3, %x3, %raise)
      : (!p, !p, index, index, !b, !b, index, index, !w, i1) -> (index, !w)
  %x40 = vector.extract %x4[0] : i32 from !w
  %last2 = arith.index_castui %x40 : i32 to index
  func.call @set(%a, %c9, %p4) : (!p, index, index) -> ()
  func.call @set(%a, %c12, %last2) : (!p, index, index) -> ()
  func.call @set(%a, %c16, %li2) : (!p, index, index) -> ()
  func.call @set(%a, %c17, %oi2) : (!p, index, index) -> ()
  return
}

// copy_one runs operation j of the batch of 64 in the buffer of a; see @op.
func.func private @copy_one(%a: !p, %dst: !p, %j: index, %delta: i1, %flat: i1,
    %fd: i1, %dstP: !p, %litsP: !p, %x: index) -> (!p, !p, index) {
  %c4 = arith.constant 4 : index
  %c512 = arith.constant 512 : index
  %lens = func.call @lens(%a) : (!p) -> !p
  %offs = func.call @offs(%a) : (!p) -> !p
  %tok = func.call @at(%a, %c512) : (!p, index) -> !p
  %t = func.call @byte(%tok, %j) : (!p, index) -> index
  %len = func.call @byte(%lens, %j) : (!p, index) -> index
  %jo = arith.muli %j, %c4 : index
  %oq = func.call @at(%offs, %jo) : (!p, index) -> !p
  %o32 = ptr.load %oq alignment = 4 : !p -> i32
  %o = arith.index_castui %o32 : i32 to index
  %s:2 = func.call @op(%a, %dst, %t, %len, %o, %delta, %flat, %fd, %dstP, %litsP, %x)
      : (!p, !p, index, index, index, i1, i1, i1, !p, !p, index) -> (!p, !p)
  return %s#0, %s#1, %o : !p, !p, index
}

// copy runs the m operations of the batch of 64 in the buffer of a, at the output cursor dstP and
// the literal cursor litsP and after the offset last, and returns the cursors and last after
// them, one operation a loop trip. With delta, the first 32 literals of each operation are added
// to their references, and the batch holds the offsets unraised. With flat, the chunk has the
// no-overlap flag.
func.func private @copy(%a: !p, %dst: !p, %m: index, %delta: i1, %flat: i1,
    %dstP: !p, %litsP: !p, %last: index) -> (!p, !p, index) {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %fd = arith.andi %flat, %delta : i1
  %r:3 = scf.for %j = %c0 to %m step %c1 iter_args(%dP = %dstP, %lP = %litsP, %x = %last)
      -> (!p, !p, index) {
    %s:3 = func.call @copy_one(%a, %dst, %j, %delta, %flat, %fd, %dP, %lP, %x)
        : (!p, !p, index, i1, i1, i1, !p, !p, index) -> (!p, !p, index)
    scf.yield %s#0, %s#1, %s#2 : !p, !p, index
  }
  return %r#0, %r#1, %r#2 : !p, !p, index
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
  %n = func.call @arg(%a, %c8) : (!p, index) -> index
  %d = func.call @arg(%a, %c10) : (!p, index) -> index
  %l = func.call @arg(%a, %c11) : (!p, index) -> index
  %last = func.call @arg(%a, %c12) : (!p, index) -> index
  // k is the index of the next token. The batch keeps the last offset in a; with delta, the copy
  // loop keeps it as well.
  %dstP = func.call @at(%dst, %d) : (!p, index) -> !p
  %litsP = func.call @at(%lits, %l) : (!p, index) -> !p
  %s:3 = scf.for %k = %c0 to %n step %c64 iter_args(%dP = %dstP, %lP = %litsP, %x = %last)
      -> (!p, !p, index) {
    %left = arith.subi %n, %k : index
    %m = arith.minui %left, %c64 : index
    func.call @expand_batch(%a, %k, %m, %raise) : (!p, index, index, i1) -> ()
    %d2, %l2, %x2 = func.call @copy(%a, %dst, %m, %delta, %flat, %dP, %lP, %x)
        : (!p, !p, index, i1, i1, !p, !p, index) -> (!p, !p, index)
    scf.yield %d2, %l2, %x2 : !p, !p, index
  }
  %d3 = func.call @dist(%s#0, %dst) : (!p, !p) -> index
  %l3 = func.call @dist(%s#1, %lits) : (!p, !p) -> index
  func.call @set(%a, %c10, %d3) : (!p, index, index) -> ()
  func.call @set(%a, %c11, %l3) : (!p, index, index) -> ()
  return
}

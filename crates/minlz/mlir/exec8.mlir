// The operation loops of SIMD block chunks in batches of 8 operations, for targets with many
// general registers, as aarch64 has, as Go's arm64 loops run them. See exec.mlir, which comes
// before this file.
//
// The literal lengths and offset symbols of a batch are expanded into a word each, and @op8
// decodes each offset with a table lookup. The 8 operations of a batch are unrolled, and each
// batch expands the next before it runs.
//
// @op8 copies at cursors that @run carries through the batch: the output cursor dstP and the
// literal cursor litsP are pointers moved with ptr.ptr_add, so every copy loads or stores at a
// pointer and needs no add before it. @op of exec.mlir copies at an index instead, for
// exec64.mlir: x86-64 addressing modes take an index register, so cursors gain nothing there.

// back returns p - o.
func.func private @back(%p: !p, %o: index) -> !p {
  %c0 = arith.constant 0 : index
  %n = arith.subi %c0, %o : index
  %i = arith.index_cast %n : index to i64
  %r = ptr.ptr_add %p, %i : !p, i64
  return %r : !p
}

// dist returns the bytes from q up to p.
func.func private @dist(%p: !p, %q: !p) -> index {
  %d = ptr.ptr_diff %p, %q : !p -> i64
  %r = arith.index_cast %d : i64 to index
  return %r : index
}

// expand2 returns the literal lengths and the offset symbols of the 8 operations at tok + k, a byte
// each, and the offsets li and oi in ll and offc after them. Operations without literals get
// length 0, and repeats symbol 0.
func.func private @expand2(%tok: !p, %k: index, %ll: !p, %li: index, %offc: !p, %oi: index,
    %ones: i64) -> (i64, i64, index, index) {
  %k1 = arith.constant 1 : i64
  %tw = func.call @word(%tok, %k) : (!p, index) -> i64
  %t1 = arith.shrui %tw, %k1 : i64
  %fl = arith.andi %t1, %ones : i64
  %nt = arith.xori %tw, %ones : i64
  %fn = arith.andi %nt, %ones : i64
  %lw, %li2 = func.call @expand8(%ll, %li, %fl, %ones) : (!p, index, i64, i64) -> (i64, index)
  %sw, %oi2 = func.call @expand8(%offc, %oi, %fn, %ones) : (!p, index, i64, i64) -> (i64, index)
  return %lw, %sw, %li2, %oi2 : i64, i64, index, index
}

// lane8 returns byte k of w.
func.func private @lane8(%w: i64, %k: i64) -> index {
  %k8 = arith.constant 8 : i64
  %k255 = arith.constant 255 : i64
  %s = arith.muli %k, %k8 : i64
  %x = arith.shrui %w, %s : i64
  %b = arith.andi %x, %k255 : i64
  %r = arith.index_castui %b : i64 to index
  return %r : index
}

// lane8o returns byte k of w held so that the compiler sees the byte rather than the shift and
// mask that made it. Only an offset symbol needs this: it scales a table of eight-byte entries,
// and the scale is then the shift of the load itself, which aarch64 charges nothing for. Left to
// itself the compiler moves the mask across the scale instead, which costs an instruction.
func.func private @lane8o(%w: i64, %k: i64) -> i64 {
  %k8 = arith.constant 8 : i64
  %k255 = arith.constant 255 : i64
  %s = arith.muli %k, %k8 : i64
  %x = arith.shrui %w, %s : i64
  %b = arith.andi %x, %k255 : i64
  %r = llvm.inline_asm "", "=r,0" %b : (i64) -> i64
  return %r : i64
}

// op8 runs operation k of a batch of 8: byte k of the token word tw, the literal length word lw
// and the offset symbol word sw, whose raw bits are at bit p of raw. It copies at the output
// cursor dstP and the literal cursor litsP, and returns the cursors after it, the offset and p.
// See @op.
func.func private @op8(%a: !p, %dst: !p, %raw: !p, %tab: !p, %k: i64, %tw: i64,
    %lw: i64, %sw: i64, %delta: i1, %flat: i1, %dstP: !p, %litsP: !p, %x: index, %p: index)
    -> (!p, !p, index, index) {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c3 = arith.constant 3 : index
  %c7 = arith.constant 7 : index
  %c8 = arith.constant 8 : index
  %c13 = arith.constant 13 : index
  %c32 = arith.constant 32 : index
  %c33 = arith.constant 33 : index
  %k32 = arith.constant 32 : i64
  %k40 = arith.constant 40 : i64
  %k255 = arith.constant 255 : i64
  %true = arith.constant true
  %notflat = arith.xori %flat, %true : i1
  %t = func.call @lane8(%tw, %k) : (i64, i64) -> index
  %len = func.call @lane8(%lw, %k) : (i64, i64) -> index
  %sym8 = func.call @lane8o(%sw, %k) : (i64, i64) -> i64
  %sym = arith.index_castui %sym8 : i64 to index
  // The offset: the base of the symbol plus its raw bits at p; only symbol 0 decodes to 0, which
  // keeps the last offset.
  %eo = arith.muli %sym, %c8 : index
  %eq = func.call @at(%tab, %eo) : (!p, index) -> !p
  %e = ptr.load %eq alignment = 8 : !p -> i64
  %wo = arith.shrui %p, %c3 : index
  %w = func.call @word(%raw, %wo) : (!p, index) -> i64
  %sh = arith.andi %p, %c7 : index
  %sh64 = arith.index_castui %sh : index to i64
  %w2 = arith.shrui %w, %sh64 : i64
  %w32 = arith.trunci %w2 : i64 to i32
  %m32 = arith.trunci %e : i64 to i32
  %bits32 = arith.andi %w32, %m32 : i32
  %bits = arith.index_castui %bits32 : i32 to index
  %nb64 = arith.shrui %e, %k32 : i64
  %nb8 = arith.andi %nb64, %k255 : i64
  %nb = arith.index_castui %nb8 : i64 to index
  %p2 = arith.addi %p, %nb : index
  %base64 = arith.shrui %e, %k40 : i64
  %base = arith.index_castui %base64 : i64 to index
  %on = arith.addi %base, %bits : index
  %new = arith.cmpi ne, %on, %c0 : index
  %o = arith.select %new, %on, %x : index
  // The first 32 literals, loaded at the literal cursor and stored at the output cursor. With
  // delta they are added to their references, whose offset is clamped to the position and raised
  // to 32 for a flat chunk, which starts at 32 or later so its references never repeat.
  %lv = func.call @ld(%litsP, %c0) : (!p, index) -> !v
  %lv2 = scf.if %delta -> !v {
    %raised = arith.maxui %x, %c32 : index
    %dr0 = arith.select %flat, %raised, %x : index
    %d = func.call @dist(%dstP, %dst) : (!p, !p) -> index
    %dr = arith.minui %dr0, %d : index
    %refP = func.call @back(%dstP, %dr) : (!p, index) -> !p
    %near = arith.cmpi ult, %dr, %c32 : index
    %short0 = arith.andi %notflat, %near : i1
    %short = func.call @unlikely(%short0) : (i1) -> i1
    %rv = scf.if %short -> !v {
      %rs = arith.subi %d, %dr : index
      %y = func.call @repeat(%a, %dst, %rs, %dr) : (!p, !p, index, index) -> !v
      scf.yield %y : !v
    } else {
      %y = func.call @ld(%refP, %c0) : (!p, index) -> !v
      scf.yield %y : !v
    }
    %s = arith.addi %lv, %rv : !v
    scf.yield %s : !v
  } else {
    scf.yield %lv : !v
  }
  func.call @st(%dstP, %c0, %lv2) : (!p, index, !v) -> ()
  // Literal lengths from 33 on are 33 plus an escape, copied after the first 32 bytes.
  %llong0 = arith.cmpi uge, %len, %c33 : index
  %llong = func.call @unlikely(%llong0) : (i1) -> i1
  %n = scf.if %llong -> index {
    %ne = func.call @escape(%a) : (!p) -> index
    func.call @long(%dstP, %litsP, %ne) : (!p, !p, index) -> ()
    scf.yield %ne : index
  } else {
    scf.yield %len : index
  }
  // The output cursor after the literals is where the match is stored, and its distance from the
  // start of dst is the position the offset is clamped to.
  %dstP1 = func.call @at(%dstP, %n) : (!p, index) -> !p
  %d1 = func.call @dist(%dstP1, %dst) : (!p, !p) -> index
  // The match copies from the offset clamped to the position. Flat chunks raise it to
  // min(ml, 32) first, which the position covers, so their copies never overlap. Others take a
  // pattern for an offset below ml. Both the clamp and the pattern are rare, so they share a path
  // out of the loop.
  %ml = arith.shrui %t, %c2 : index
  %mlc = arith.minui %ml, %c32 : index
  %rr = arith.maxui %o, %mlc : index
  %r0 = arith.select %flat, %rr, %o : index
  %far = arith.cmpi ugt, %r0, %d1 : index
  %near2 = arith.cmpi ult, %r0, %ml : index
  %pat0 = arith.andi %notflat, %near2 : i1
  %slow0 = arith.ori %far, %pat0 : i1
  %slow = func.call @unlikely(%slow0) : (i1) -> i1
  %r, %srcP, %mv = scf.if %slow -> (index, !p, !v) {
    %rc = arith.minui %r0, %d1 : index
    %sc = arith.subi %d1, %rc : index
    %near3 = arith.cmpi ult, %rc, %ml : index
    %pat = arith.andi %notflat, %near3 : i1
    %y = scf.if %pat -> !v {
      %z = func.call @repeat(%a, %dst, %sc, %rc) : (!p, !p, index, index) -> !v
      scf.yield %z : !v
    } else {
      %z = func.call @ld(%dst, %sc) : (!p, index) -> !v
      scf.yield %z : !v
    }
    %sp = func.call @at(%dst, %sc) : (!p, index) -> !p
    scf.yield %rc, %sp, %y : index, !p, !v
  } else {
    %sp = func.call @back(%dstP1, %r0) : (!p, index) -> !p
    %y = func.call @ld(%sp, %c0) : (!p, index) -> !v
    scf.yield %r0, %sp, %y : index, !p, !v
  }
  func.call @st(%dstP1, %c0, %mv) : (!p, index, !v) -> ()
  // Match length codes from 33 on are 33 plus an escape. Such matches need an offset of at least
  // 32.
  %mlong0 = arith.cmpi uge, %ml, %c33 : index
  %mlong = func.call @unlikely(%mlong0) : (i1) -> i1
  %mn = scf.if %mlong -> index {
    %close = arith.cmpi ult, %r, %c32 : index
    %bad = arith.andi %notflat, %close : i1
    scf.if %bad {
      func.call @set(%a, %c13, %c1) : (!p, index, index) -> ()
    }
    %n2 = func.call @escape(%a) : (!p) -> index
    func.call @long(%dstP1, %srcP, %n2) : (!p, !p, index) -> ()
    scf.yield %n2 : index
  } else {
    scf.yield %ml : index
  }
  %dstP2 = func.call @at(%dstP1, %mn) : (!p, index) -> !p
  %litsP1 = func.call @at(%litsP, %n) : (!p, index) -> !p
  return %dstP2, %litsP1, %o, %p2 : !p, !p, index, index
}

// run runs the operations of the kernel arguments a in batches of 8. Each batch takes the words
// that expand2 made before it, and expands the next batch, if there is one, before it runs. A
// partial last batch takes the words of the 8 operations from its first, whose values past n it
// leaves unused.
func.func private @run(%a: !p, %delta: i1, %flat: i1) {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c3 = arith.constant 3 : index
  %c4 = arith.constant 4 : index
  %c5 = arith.constant 5 : index
  %c7 = arith.constant 7 : index
  %c8 = arith.constant 8 : index
  %c9 = arith.constant 9 : index
  %c10 = arith.constant 10 : index
  %c11 = arith.constant 11 : index
  %c12 = arith.constant 12 : index
  %j0 = arith.constant 0 : i64
  %j1 = arith.constant 1 : i64
  %j2 = arith.constant 2 : i64
  %j3 = arith.constant 3 : i64
  %j4 = arith.constant 4 : i64
  %j5 = arith.constant 5 : i64
  %j6 = arith.constant 6 : i64
  %j7 = arith.constant 7 : i64
  %j8 = arith.constant 8 : i64
  %ones0 = arith.constant 72340172838076673 : i64
  // Opaque to LLVM, which would otherwise make c - f in expand8 a second multiply.
  %ones = llvm.inline_asm "", "=r,0" %ones0 : (i64) -> i64
  %dst = func.call @argp(%a, %c0) : (!p, index) -> !p
  %lits = func.call @argp(%a, %c1) : (!p, index) -> !p
  %tok = func.call @argp(%a, %c2) : (!p, index) -> !p
  %ll = func.call @argp(%a, %c3) : (!p, index) -> !p
  %offc = func.call @argp(%a, %c4) : (!p, index) -> !p
  %raw = func.call @argp(%a, %c5) : (!p, index) -> !p
  %tab = func.call @argp(%a, %c7) : (!p, index) -> !p
  %n = func.call @arg(%a, %c8) : (!p, index) -> index
  %pos = func.call @arg(%a, %c9) : (!p, index) -> index
  %d = func.call @arg(%a, %c10) : (!p, index) -> index
  %l = func.call @arg(%a, %c11) : (!p, index) -> index
  %last = func.call @arg(%a, %c12) : (!p, index) -> index
  %any = arith.cmpi ne, %n, %c0 : index
  scf.if %any {
    // The cursors of the batch: the output and literal positions as pointers.
    %dstP0 = func.call @at(%dst, %d) : (!p, index) -> !p
    %litsP0 = func.call @at(%lits, %l) : (!p, index) -> !p
    %lw0, %sw0, %li0, %oi0 = func.call @expand2(%tok, %c0, %ll, %c0, %offc, %c0, %ones)
        : (!p, index, !p, index, !p, index, i64) -> (i64, i64, index, index)
    // Whole batches. k is the index of the next token, left the operations from it on.
    %b:10 = scf.while (%k = %c0, %left = %n, %lw = %lw0, %sw = %sw0, %li = %li0, %oi = %oi0,
        %x0 = %last, %p0 = %pos, %dstP = %dstP0, %litsP = %litsP0)
        : (index, index, i64, i64, index, index, index, index, !p, !p)
        -> (index, index, i64, i64, index, index, index, index, !p, !p) {
      %more = arith.cmpi uge, %left, %c8 : index
      scf.condition(%more) %k, %left, %lw, %sw, %li, %oi, %x0, %p0, %dstP, %litsP
          : index, index, i64, i64, index, index, index, index, !p, !p
    } do {
    ^bb0(%k: index, %left: index, %lw: i64, %sw: i64, %li: index, %oi: index, %x0: index,
        %p0: index, %dstP: !p, %litsP: !p):
      %tw = func.call @word(%tok, %k) : (!p, index) -> i64
      %k2 = arith.addi %k, %c8 : index
      %left2 = arith.subi %left, %c8 : index
      %next = arith.cmpi ne, %left2, %c0 : index
      %e:4 = scf.if %next -> (i64, i64, index, index) {
        %lwn, %swn, %li2, %oi2 = func.call @expand2(%tok, %k2, %ll, %li, %offc, %oi, %ones)
            : (!p, index, !p, index, !p, index, i64) -> (i64, i64, index, index)
        scf.yield %lwn, %swn, %li2, %oi2 : i64, i64, index, index
      } else {
        scf.yield %lw, %sw, %li, %oi : i64, i64, index, index
      }
      %s0:4 = func.call @op8(%a, %dst, %raw, %tab, %j0, %tw, %lw, %sw, %delta, %flat,
          %dstP, %litsP, %x0, %p0)
          : (!p, !p, !p, !p, i64, i64, i64, i64, i1, i1, !p, !p, index, index)
          -> (!p, !p, index, index)
      %s1:4 = func.call @op8(%a, %dst, %raw, %tab, %j1, %tw, %lw, %sw, %delta, %flat,
          %s0#0, %s0#1, %s0#2, %s0#3)
          : (!p, !p, !p, !p, i64, i64, i64, i64, i1, i1, !p, !p, index, index)
          -> (!p, !p, index, index)
      %s2:4 = func.call @op8(%a, %dst, %raw, %tab, %j2, %tw, %lw, %sw, %delta, %flat,
          %s1#0, %s1#1, %s1#2, %s1#3)
          : (!p, !p, !p, !p, i64, i64, i64, i64, i1, i1, !p, !p, index, index)
          -> (!p, !p, index, index)
      %s3:4 = func.call @op8(%a, %dst, %raw, %tab, %j3, %tw, %lw, %sw, %delta, %flat,
          %s2#0, %s2#1, %s2#2, %s2#3)
          : (!p, !p, !p, !p, i64, i64, i64, i64, i1, i1, !p, !p, index, index)
          -> (!p, !p, index, index)
      %s4:4 = func.call @op8(%a, %dst, %raw, %tab, %j4, %tw, %lw, %sw, %delta, %flat,
          %s3#0, %s3#1, %s3#2, %s3#3)
          : (!p, !p, !p, !p, i64, i64, i64, i64, i1, i1, !p, !p, index, index)
          -> (!p, !p, index, index)
      %s5:4 = func.call @op8(%a, %dst, %raw, %tab, %j5, %tw, %lw, %sw, %delta, %flat,
          %s4#0, %s4#1, %s4#2, %s4#3)
          : (!p, !p, !p, !p, i64, i64, i64, i64, i1, i1, !p, !p, index, index)
          -> (!p, !p, index, index)
      %s6:4 = func.call @op8(%a, %dst, %raw, %tab, %j6, %tw, %lw, %sw, %delta, %flat,
          %s5#0, %s5#1, %s5#2, %s5#3)
          : (!p, !p, !p, !p, i64, i64, i64, i64, i1, i1, !p, !p, index, index)
          -> (!p, !p, index, index)
      %s7:4 = func.call @op8(%a, %dst, %raw, %tab, %j7, %tw, %lw, %sw, %delta, %flat,
          %s6#0, %s6#1, %s6#2, %s6#3)
          : (!p, !p, !p, !p, i64, i64, i64, i64, i1, i1, !p, !p, index, index)
          -> (!p, !p, index, index)
      scf.yield %k2, %left2, %e#0, %e#1, %e#2, %e#3, %s7#2, %s7#3, %s7#0, %s7#1
          : index, index, i64, i64, index, index, index, index, !p, !p
    }
    // The partial last batch takes byte 0 of each word and shifts the words down.
    %rest = arith.cmpi ne, %b#1, %c0 : index
    %f:3 = scf.if %rest -> (index, index, index) {
      %tw0 = func.call @word(%tok, %b#0) : (!p, index) -> i64
      %t:8 = scf.while (%left = %b#1, %tw = %tw0, %lw = %b#2, %sw = %b#3, %x0 = %b#6,
          %p0 = %b#7, %dstP = %b#8, %litsP = %b#9)
          : (index, i64, i64, i64, index, index, !p, !p)
          -> (index, i64, i64, i64, index, index, !p, !p) {
        %more = arith.cmpi ne, %left, %c0 : index
        scf.condition(%more) %left, %tw, %lw, %sw, %x0, %p0, %dstP, %litsP
            : index, i64, i64, i64, index, index, !p, !p
      } do {
      ^bb0(%left: index, %tw: i64, %lw: i64, %sw: i64, %x0: index, %p0: index, %dstP: !p,
          %litsP: !p):
        %s:4 = func.call @op8(%a, %dst, %raw, %tab, %j0, %tw, %lw, %sw, %delta, %flat,
            %dstP, %litsP, %x0, %p0)
            : (!p, !p, !p, !p, i64, i64, i64, i64, i1, i1, !p, !p, index, index)
            -> (!p, !p, index, index)
        %left2 = arith.subi %left, %c1 : index
        %tw2 = arith.shrui %tw, %j8 : i64
        %lw2 = arith.shrui %lw, %j8 : i64
        %sw2 = arith.shrui %sw, %j8 : i64
        scf.yield %left2, %tw2, %lw2, %sw2, %s#2, %s#3, %s#0, %s#1
            : index, i64, i64, i64, index, index, !p, !p
      }
      %d2 = func.call @dist(%t#6, %dst) : (!p, !p) -> index
      %l2 = func.call @dist(%t#7, %lits) : (!p, !p) -> index
      scf.yield %d2, %l2, %t#4 : index, index, index
    } else {
      %d2 = func.call @dist(%b#8, %dst) : (!p, !p) -> index
      %l2 = func.call @dist(%b#9, %lits) : (!p, !p) -> index
      scf.yield %d2, %l2, %b#6 : index, index, index
    }
    func.call @set(%a, %c10, %f#0) : (!p, index, index) -> ()
    func.call @set(%a, %c11, %f#1) : (!p, index, index) -> ()
    func.call @set(%a, %c12, %f#2) : (!p, index, index) -> ()
  }
  return
}

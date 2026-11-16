// The operation loops of SIMD block chunks in batches of 8 operations, for targets with many
// general registers, as aarch64 has, as Go's arm64 loops run them. See exec.mlir, which comes
// before this file.
//
// The literal lengths and offset symbols of a batch are expanded into a word each, and @op8
// decodes each offset with a table lookup. The 8 operations of a batch are unrolled, and each
// batch expands the next before it runs.
//
// The loops carry the escape index in a register: only escapes read it, and the loops read word 15
// of a once, before they start, so the escape branches never touch a for it.

// esc_index returns the escape index the loops carry; see @escape in exec.mlir.
func.func private @esc_index(%a: !p, %g: index) -> index {
  return %g : index
}

// esc_next returns the escape index past the byte it consumed, which the loops carry; see @escape
// in exec.mlir.
func.func private @esc_next(%a: !p, %g2: index) -> index {
  return %g2 : index
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
    %lw: i64, %sw: i64, %delta: i1, %flat: i1, %dstP: !p, %litsP: !p, %x: index, %p: index,
    %g: index) -> (!p, !p, index, index, index) {
  %c0 = arith.constant 0 : index
  %c3 = arith.constant 3 : index
  %c7 = arith.constant 7 : index
  %c8 = arith.constant 8 : index
  %k8 = arith.constant 8 : i32
  %k32 = arith.constant 32 : i64
  %k255 = arith.constant 255 : i64
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
  %e32 = arith.trunci %e : i64 to i32
  %m32 = arith.shrui %e32, %k8 : i32
  %bits32 = arith.andi %w32, %m32 : i32
  %bits = arith.index_castui %bits32 : i32 to index
  %nb8 = arith.andi %e, %k255 : i64
  %nb = arith.index_castui %nb8 : i64 to index
  %p2 = arith.addi %p, %nb : index
  %base64 = arith.shrui %e, %k32 : i64
  %base = arith.index_castui %base64 : i64 to index
  %on = arith.addi %base, %bits : index
  %new = arith.cmpi ne, %on, %c0 : index
  %o = arith.select %new, %on, %x : index
  %s:3 = func.call @op(%a, %dst, %t, %len, %o, %delta, %flat, %flat, %dstP, %litsP, %x, %g)
      : (!p, !p, index, index, index, i1, i1, i1, !p, !p, index, index) -> (!p, !p, index)
  return %s#0, %s#1, %o, %p2, %s#2 : !p, !p, index, index, index
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
  %c15 = arith.constant 15 : index
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
  %dst = func.call @roargp(%a, %c0) : (!p, index) -> !p
  %lits = func.call @roargp(%a, %c1) : (!p, index) -> !p
  %tok = func.call @roargp(%a, %c2) : (!p, index) -> !p
  %ll = func.call @roargp(%a, %c3) : (!p, index) -> !p
  %offc = func.call @roargp(%a, %c4) : (!p, index) -> !p
  %raw = func.call @roargp(%a, %c5) : (!p, index) -> !p
  %tab = func.call @roargp(%a, %c7) : (!p, index) -> !p
  %n = func.call @roarg(%a, %c8) : (!p, index) -> index
  %pos = func.call @arg(%a, %c9) : (!p, index) -> index
  %d = func.call @arg(%a, %c10) : (!p, index) -> index
  %l = func.call @arg(%a, %c11) : (!p, index) -> index
  %last = func.call @arg(%a, %c12) : (!p, index) -> index
  // The escape index the loops carry, read from word 15 of a before they start.
  %g0 = func.call @roarg(%a, %c15) : (!p, index) -> index
  %any = arith.cmpi ne, %n, %c0 : index
  scf.if %any {
    // The cursors of the batch: the output and literal positions as pointers.
    %dstP0 = func.call @at(%dst, %d) : (!p, index) -> !p
    %litsP0 = func.call @at(%lits, %l) : (!p, index) -> !p
    %lw0, %sw0, %li0, %oi0 = func.call @expand2(%tok, %c0, %ll, %c0, %offc, %c0, %ones)
        : (!p, index, !p, index, !p, index, i64) -> (i64, i64, index, index)
    // Whole batches. k is the index of the next token, left the operations from it on.
    %b:11 = scf.while (%k = %c0, %left = %n, %lw = %lw0, %sw = %sw0, %li = %li0, %oi = %oi0,
        %x0 = %last, %p0 = %pos, %dstP = %dstP0, %litsP = %litsP0, %g = %g0)
        : (index, index, i64, i64, index, index, index, index, !p, !p, index)
        -> (index, index, i64, i64, index, index, index, index, !p, !p, index) {
      %more = arith.cmpi uge, %left, %c8 : index
      scf.condition(%more) %k, %left, %lw, %sw, %li, %oi, %x0, %p0, %dstP, %litsP, %g
          : index, index, i64, i64, index, index, index, index, !p, !p, index
    } do {
    ^bb0(%k: index, %left: index, %lw: i64, %sw: i64, %li: index, %oi: index, %x0: index,
        %p0: index, %dstP: !p, %litsP: !p, %g: index):
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
      %s0:5 = func.call @op8(%a, %dst, %raw, %tab, %j0, %tw, %lw, %sw, %delta, %flat,
          %dstP, %litsP, %x0, %p0, %g)
          : (!p, !p, !p, !p, i64, i64, i64, i64, i1, i1, !p, !p, index, index, index)
          -> (!p, !p, index, index, index)
      %s1:5 = func.call @op8(%a, %dst, %raw, %tab, %j1, %tw, %lw, %sw, %delta, %flat,
          %s0#0, %s0#1, %s0#2, %s0#3, %s0#4)
          : (!p, !p, !p, !p, i64, i64, i64, i64, i1, i1, !p, !p, index, index, index)
          -> (!p, !p, index, index, index)
      %s2:5 = func.call @op8(%a, %dst, %raw, %tab, %j2, %tw, %lw, %sw, %delta, %flat,
          %s1#0, %s1#1, %s1#2, %s1#3, %s1#4)
          : (!p, !p, !p, !p, i64, i64, i64, i64, i1, i1, !p, !p, index, index, index)
          -> (!p, !p, index, index, index)
      %s3:5 = func.call @op8(%a, %dst, %raw, %tab, %j3, %tw, %lw, %sw, %delta, %flat,
          %s2#0, %s2#1, %s2#2, %s2#3, %s2#4)
          : (!p, !p, !p, !p, i64, i64, i64, i64, i1, i1, !p, !p, index, index, index)
          -> (!p, !p, index, index, index)
      %s4:5 = func.call @op8(%a, %dst, %raw, %tab, %j4, %tw, %lw, %sw, %delta, %flat,
          %s3#0, %s3#1, %s3#2, %s3#3, %s3#4)
          : (!p, !p, !p, !p, i64, i64, i64, i64, i1, i1, !p, !p, index, index, index)
          -> (!p, !p, index, index, index)
      %s5:5 = func.call @op8(%a, %dst, %raw, %tab, %j5, %tw, %lw, %sw, %delta, %flat,
          %s4#0, %s4#1, %s4#2, %s4#3, %s4#4)
          : (!p, !p, !p, !p, i64, i64, i64, i64, i1, i1, !p, !p, index, index, index)
          -> (!p, !p, index, index, index)
      %s6:5 = func.call @op8(%a, %dst, %raw, %tab, %j6, %tw, %lw, %sw, %delta, %flat,
          %s5#0, %s5#1, %s5#2, %s5#3, %s5#4)
          : (!p, !p, !p, !p, i64, i64, i64, i64, i1, i1, !p, !p, index, index, index)
          -> (!p, !p, index, index, index)
      %s7:5 = func.call @op8(%a, %dst, %raw, %tab, %j7, %tw, %lw, %sw, %delta, %flat,
          %s6#0, %s6#1, %s6#2, %s6#3, %s6#4)
          : (!p, !p, !p, !p, i64, i64, i64, i64, i1, i1, !p, !p, index, index, index)
          -> (!p, !p, index, index, index)
      scf.yield %k2, %left2, %e#0, %e#1, %e#2, %e#3, %s7#2, %s7#3, %s7#0, %s7#1, %s7#4
          : index, index, i64, i64, index, index, index, index, !p, !p, index
    }
    // The partial last batch takes byte 0 of each word and shifts the words down.
    %rest = arith.cmpi ne, %b#1, %c0 : index
    %f:3 = scf.if %rest -> (index, index, index) {
      %tw0 = func.call @word(%tok, %b#0) : (!p, index) -> i64
      %t:9 = scf.while (%left = %b#1, %tw = %tw0, %lw = %b#2, %sw = %b#3, %x0 = %b#6,
          %p0 = %b#7, %dstP = %b#8, %litsP = %b#9, %g = %b#10)
          : (index, i64, i64, i64, index, index, !p, !p, index)
          -> (index, i64, i64, i64, index, index, !p, !p, index) {
        %more = arith.cmpi ne, %left, %c0 : index
        scf.condition(%more) %left, %tw, %lw, %sw, %x0, %p0, %dstP, %litsP, %g
            : index, i64, i64, i64, index, index, !p, !p, index
      } do {
      ^bb0(%left: index, %tw: i64, %lw: i64, %sw: i64, %x0: index, %p0: index, %dstP: !p,
          %litsP: !p, %g: index):
        %s:5 = func.call @op8(%a, %dst, %raw, %tab, %j0, %tw, %lw, %sw, %delta, %flat,
            %dstP, %litsP, %x0, %p0, %g)
            : (!p, !p, !p, !p, i64, i64, i64, i64, i1, i1, !p, !p, index, index, index)
            -> (!p, !p, index, index, index)
        %left2 = arith.subi %left, %c1 : index
        %tw2 = arith.shrui %tw, %j8 : i64
        %lw2 = arith.shrui %lw, %j8 : i64
        %sw2 = arith.shrui %sw, %j8 : i64
        scf.yield %left2, %tw2, %lw2, %sw2, %s#2, %s#3, %s#0, %s#1, %s#4
            : index, i64, i64, i64, index, index, !p, !p, index
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

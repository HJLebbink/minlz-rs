// The operation loops of SIMD block chunks in batches of 8 operations, for targets with many
// general registers, as aarch64 has, as Go's arm64 loops run them. See exec.mlir, which comes
// before this file.
//
// The literal lengths and offset symbols of a batch are expanded into a word each, and @op decodes
// each offset with a table lookup. The 8 operations of a batch are unrolled, and each batch
// expands the next before it runs.

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

// op8 runs operation k of a batch of 8: byte k of the token word tw, the literal length word lw
// and the offset symbol word sw. See @op.
func.func private @op8(%a: !p, %dst: !p, %lits: !p, %raw: !p, %tab: !p, %k: i64, %tw: i64,
    %lw: i64, %sw: i64, %delta: i1, %flat: i1, %d: index, %l: index, %x: index, %p: index)
    -> (index, index, index, index) {
  %true = arith.constant true
  %t = func.call @lane8(%tw, %k) : (i64, i64) -> index
  %len = func.call @lane8(%lw, %k) : (i64, i64) -> index
  %sym = func.call @lane8(%sw, %k) : (i64, i64) -> index
  %s:4 = func.call @op(%a, %dst, %lits, %raw, %tab, %t, %len, %sym, %delta, %flat, %true, %flat,
      %d, %l, %x, %p)
      : (!p, !p, !p, !p, !p, index, index, index, i1, i1, i1, i1, index, index, index, index)
      -> (index, index, index, index)
  return %s#0, %s#1, %s#2, %s#3 : index, index, index, index
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
    %lw0, %sw0, %li0, %oi0 = func.call @expand2(%tok, %c0, %ll, %c0, %offc, %c0, %ones)
        : (!p, index, !p, index, !p, index, i64) -> (i64, i64, index, index)
    // Whole batches. k is the index of the next token, left the operations from it on.
    %b:11 = scf.while (%k = %c0, %left = %n, %lw = %lw0, %sw = %sw0, %li = %li0, %oi = %oi0,
        %d0 = %d, %l0 = %l, %x0 = %last, %p0 = %pos, %u = %c0)
        : (index, index, i64, i64, index, index, index, index, index, index, index)
        -> (index, index, i64, i64, index, index, index, index, index, index, index) {
      %more = arith.cmpi uge, %left, %c8 : index
      scf.condition(%more) %k, %left, %lw, %sw, %li, %oi, %d0, %l0, %x0, %p0, %u
          : index, index, i64, i64, index, index, index, index, index, index, index
    } do {
    ^bb0(%k: index, %left: index, %lw: i64, %sw: i64, %li: index, %oi: index, %d0: index,
        %l0: index, %x0: index, %p0: index, %u: index):
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
      %s0:4 = func.call @op8(%a, %dst, %lits, %raw, %tab, %j0, %tw, %lw, %sw, %delta, %flat,
          %d0, %l0, %x0, %p0)
          : (!p, !p, !p, !p, !p, i64, i64, i64, i64, i1, i1, index, index, index, index)
          -> (index, index, index, index)
      %s1:4 = func.call @op8(%a, %dst, %lits, %raw, %tab, %j1, %tw, %lw, %sw, %delta, %flat,
          %s0#0, %s0#1, %s0#2, %s0#3)
          : (!p, !p, !p, !p, !p, i64, i64, i64, i64, i1, i1, index, index, index, index)
          -> (index, index, index, index)
      %s2:4 = func.call @op8(%a, %dst, %lits, %raw, %tab, %j2, %tw, %lw, %sw, %delta, %flat,
          %s1#0, %s1#1, %s1#2, %s1#3)
          : (!p, !p, !p, !p, !p, i64, i64, i64, i64, i1, i1, index, index, index, index)
          -> (index, index, index, index)
      %s3:4 = func.call @op8(%a, %dst, %lits, %raw, %tab, %j3, %tw, %lw, %sw, %delta, %flat,
          %s2#0, %s2#1, %s2#2, %s2#3)
          : (!p, !p, !p, !p, !p, i64, i64, i64, i64, i1, i1, index, index, index, index)
          -> (index, index, index, index)
      %s4:4 = func.call @op8(%a, %dst, %lits, %raw, %tab, %j4, %tw, %lw, %sw, %delta, %flat,
          %s3#0, %s3#1, %s3#2, %s3#3)
          : (!p, !p, !p, !p, !p, i64, i64, i64, i64, i1, i1, index, index, index, index)
          -> (index, index, index, index)
      %s5:4 = func.call @op8(%a, %dst, %lits, %raw, %tab, %j5, %tw, %lw, %sw, %delta, %flat,
          %s4#0, %s4#1, %s4#2, %s4#3)
          : (!p, !p, !p, !p, !p, i64, i64, i64, i64, i1, i1, index, index, index, index)
          -> (index, index, index, index)
      %s6:4 = func.call @op8(%a, %dst, %lits, %raw, %tab, %j6, %tw, %lw, %sw, %delta, %flat,
          %s5#0, %s5#1, %s5#2, %s5#3)
          : (!p, !p, !p, !p, !p, i64, i64, i64, i64, i1, i1, index, index, index, index)
          -> (index, index, index, index)
      %s7:4 = func.call @op8(%a, %dst, %lits, %raw, %tab, %j7, %tw, %lw, %sw, %delta, %flat,
          %s6#0, %s6#1, %s6#2, %s6#3)
          : (!p, !p, !p, !p, !p, i64, i64, i64, i64, i1, i1, index, index, index, index)
          -> (index, index, index, index)
      scf.yield %k2, %left2, %e#0, %e#1, %e#2, %e#3, %s7#0, %s7#1, %s7#2, %s7#3, %u
          : index, index, i64, i64, index, index, index, index, index, index, index
    }
    // The partial last batch takes byte 0 of each word and shifts the words down.
    %rest = arith.cmpi ne, %b#1, %c0 : index
    %f:3 = scf.if %rest -> (index, index, index) {
      %tw0 = func.call @word(%tok, %b#0) : (!p, index) -> i64
      %t:8 = scf.while (%left = %b#1, %tw = %tw0, %lw = %b#2, %sw = %b#3, %d0 = %b#6,
          %l0 = %b#7, %x0 = %b#8, %p0 = %b#9)
          : (index, i64, i64, i64, index, index, index, index)
          -> (index, i64, i64, i64, index, index, index, index) {
        %more = arith.cmpi ne, %left, %c0 : index
        scf.condition(%more) %left, %tw, %lw, %sw, %d0, %l0, %x0, %p0
            : index, i64, i64, i64, index, index, index, index
      } do {
      ^bb0(%left: index, %tw: i64, %lw: i64, %sw: i64, %d0: index, %l0: index, %x0: index,
          %p0: index):
        %s:4 = func.call @op8(%a, %dst, %lits, %raw, %tab, %j0, %tw, %lw, %sw, %delta, %flat,
            %d0, %l0, %x0, %p0)
            : (!p, !p, !p, !p, !p, i64, i64, i64, i64, i1, i1, index, index, index, index)
            -> (index, index, index, index)
        %left2 = arith.subi %left, %c1 : index
        %tw2 = arith.shrui %tw, %j8 : i64
        %lw2 = arith.shrui %lw, %j8 : i64
        %sw2 = arith.shrui %sw, %j8 : i64
        scf.yield %left2, %tw2, %lw2, %sw2, %s#0, %s#1, %s#2, %s#3
            : index, i64, i64, i64, index, index, index, index
      }
      scf.yield %t#4, %t#5, %t#6 : index, index, index
    } else {
      scf.yield %b#6, %b#7, %b#8 : index, index, index
    }
    func.call @set(%a, %c10, %f#0) : (!p, index, index) -> ()
    func.call @set(%a, %c11, %f#1) : (!p, index, index) -> ()
    func.call @set(%a, %c12, %f#2) : (!p, index, index) -> ()
  }
  return
}

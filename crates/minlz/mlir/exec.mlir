// The operation loops of SIMD block chunks, for every target: the parts that both loop structures
// use. `cargo xtask mlir` puts common.mlir and a target file (exec/*.mlir) in front of this file,
// and a structure file, exec64.mlir or exec8.mlir, after it, and lowers the result once per
// target. The naked functions in crates/minlz/src/block/simd/mlir.rs hold the output.
//
// Each kernel takes a pointer a to its arguments, 24 words and a buffer:
// - words 0 to 9: dst, lits, tok, ll, offc, raw, esc, tab, n and pos;
// - words 10 to 13: the state d, l, last and err;
// - words 14 to 17: the readable bytes of raw, then the escape index and the offsets in ll and
//   offc, which start at 0;
// - from byte 192: a buffer of 448 bytes for the structure file.
// It runs n operations from the streams tok, ll, offc and esc, and from bit pos of raw, at output
// position d, literal position l and repeat offset last, as exec_go and exec_flat_go in
// crates/minlz/src/block/simd/exec.rs run them. It writes the state back, and sets err to 1 for a
// long match at an offset below 32. The memory rules in that file say how far the kernel may read
// and write.
//
// The structure file gives @run(a: !p, delta: i1, flat: i1), which runs the operations in
// batches and copies each with @op.
//
// tab points to two tables. The first has a word per offset symbol, for exec8.mlir: the number
// of its raw bits in bits 0 to 7, their mask in bits 8 to 31 and the base offset in bits 32 to
// 63. Symbol 0 is all zero: the batch gives it to repeats, whose offset is then 0, which keeps the
// last one. The second, from byte 2048, has 64 rows of 32 bytes for repeats: byte i of row r is
// i % r for r from 2 to 31, 0 for rows 0 and 1, and i for rows 32 and up.
//
// Every target file gives:
// - @tbl8(v: i64, idx: i64) -> i64, whose byte i is byte idx[i] of v, or 0 if idx[i] is 0x80;
// - @permute(t: vector<32xi8>, idx: vector<32xi8>) -> vector<32xi8>, whose byte i is byte idx[i]
//   of t, for indexes below 32.

!v = vector<32xi8>

// set writes x to word i of a.
func.func private @set(%a: !p, %i: index, %x: index) {
  %q = func.call @at8(%a, %i) : (!p, index) -> !p
  %w = arith.index_castui %x : index to i64
  ptr.store %w, %q alignment = 8 : i64, !p
  return
}

// ld returns the 32 bytes at p + o.
func.func private @ld(%p: !p, %o: index) -> !v {
  %q = func.call @at(%p, %o) : (!p, index) -> !p
  %r = ptr.load %q alignment = 1 : !p -> !v
  return %r : !v
}

// st writes v to the 32 bytes at p + o.
func.func private @st(%p: !p, %o: index, %v: !v) {
  %q = func.call @at(%p, %o) : (!p, index) -> !p
  ptr.store %v, %q alignment = 1 : !v, !p
  return
}

// unlikely returns c, which LLVM then lays out as rarely true: the paths it guards go after the
// loop, and the common path runs straight through.
func.func private @unlikely(%c: i1) -> i1 {
  %f = llvm.mlir.constant(false) : i1
  %r = llvm.intr.expect %c, %f : i1
  return %r : i1
}

// escape returns the length 33 + e for the escape byte e, and the escape index the loops carry
// after it. Each structure file says where the index lives: @esc_index reads it and @esc_next
// takes the index past the byte it consumed.
func.func private @escape(%a: !p, %g: index) -> (index, index) {
  %c1 = arith.constant 1 : index
  %c6 = arith.constant 6 : index
  %c33 = arith.constant 33 : index
  %esc = func.call @argp(%a, %c6) : (!p, index) -> !p
  %g0 = func.call @esc_index(%a, %g) : (!p, index) -> index
  %e = func.call @byte(%esc, %g0) : (!p, index) -> index
  %g1 = arith.addi %g0, %c1 : index
  %gn = func.call @esc_next(%a, %g1) : (!p, index) -> index
  %n = arith.addi %e, %c33 : index
  return %n, %gn : index, index
}

// long copies the bytes of an escaped length n after the first 32, from s to d, 32 bytes at a
// time. Each step loads after the store before it, as matches with offsets from 32 to 63 need.
func.func private @long(%d: !p, %s: !p, %n: index) {
  %c32 = arith.constant 32 : index
  scf.for %i = %c32 to %n step %c32 {
    %x = func.call @ld(%s, %i) : (!p, index) -> !v
    func.call @st(%d, %i, %x) : (!p, index, !v) -> ()
  }
  return
}

// repeat returns the 32 bytes at dst + s repeated with period r, which is below 64.
func.func private @repeat(%a: !p, %dst: !p, %s: index, %r: index) -> !v {
  %c7 = arith.constant 7 : index
  %c32 = arith.constant 32 : index
  %c2048 = arith.constant 2048 : index
  %tab = func.call @argp(%a, %c7) : (!p, index) -> !p
  %r32 = arith.muli %r, %c32 : index
  %ro = arith.addi %r32, %c2048 : index
  %row = func.call @ld(%tab, %ro) : (!p, index) -> !v
  %x = func.call @ld(%dst, %s) : (!p, index) -> !v
  %y = func.call @permute(%x, %row) : (!v, !v) -> !v
  return %y : !v
}

// expand8 returns, in byte i, the next value at p + o for each byte i of the flags f that is 1, and
// 0 for the others, and the offset after the values it took. It reads the 8 bytes at p + o. ones
// is 0x0101010101010101: c = f · ones counts the values in bytes 0 to i, so c - f indexes each
// value for @tbl8, and bytes without one get 0x80.
func.func private @expand8(%p: !p, %o: index, %f: i64, %ones: i64) -> (i64, index) {
  %k7 = arith.constant 7 : i64
  %k56 = arith.constant 56 : i64
  %c = arith.muli %f, %ones : i64
  %i0 = arith.subi %c, %f : i64
  %nf = arith.xori %f, %ones : i64
  %zf = arith.shli %nf, %k7 : i64
  %idx = arith.ori %i0, %zf : i64
  %x = func.call @word(%p, %o) : (!p, index) -> i64
  %r = func.call @tbl8(%x, %idx) : (i64, i64) -> i64
  %cnt = arith.shrui %c, %k56 : i64
  %ci = arith.index_castui %cnt : i64 to index
  %o2 = arith.addi %o, %ci : index
  return %r, %o2 : i64, index
}

// back returns p - o.
func.func private @back(%p: !p, %o: index) -> !p {
  %c0 = arith.constant 0 : index
  %n = arith.subi %c0, %o : index
  %i = arith.index_cast %n : index to i64
  %r = ptr.ptr_add %p, %i : !p, i64
  return %r : !p
}

// dist returns the bytes from q up to p. User addresses are below 2^63, so the difference never
// overflows.
func.func private @dist(%p: !p, %q: !p) -> index {
  %d = ptr.ptr_diff nsw %p, %q : !p -> i64
  %r = arith.index_cast %d : i64 to index
  return %r : index
}

// op runs an operation with token t, literal length len (0 without literals) and offset o, after
// the offset x. It copies at the output cursor dstP and the literal cursor litsP, pointers into
// dst and lits, and returns them after it; on aarch64 a load or store at a pointer needs no add
// before it. It takes the escape index g and returns the one the loops carry after it. With
// delta, its first 32 literals are added to their references. With flat, the chunk has the
// no-overlap flag, and with fd the offset is raised here.
func.func private @op(%a: !p, %dst: !p, %t: index, %len: index, %o: index, %delta: i1,
    %flat: i1, %fd: i1, %dstP: !p, %litsP: !p, %x: index, %g: index) -> (!p, !p, index) {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c13 = arith.constant 13 : index
  %c32 = arith.constant 32 : index
  %c33 = arith.constant 33 : index
  %true = arith.constant true
  %notflat = arith.xori %flat, %true : i1
  // The first 32 literals, loaded at the literal cursor and stored at the output cursor. With
  // delta they are added to their references, whose offset is clamped to the position and raised
  // to 32 for a flat chunk, which starts at 32 or later so its references never repeat.
  %lv = func.call @ld(%litsP, %c0) : (!p, index) -> !v
  %lv2 = scf.if %delta -> !v {
    %raised = arith.maxui %x, %c32 : index
    %dr0 = arith.select %flat, %raised, %x : index
    // The references copy from dr0 bytes back. Two cases are rare and share a path out of the
    // loop: dr0 reaching before the start of dst, which the first operations of a chunk do, and,
    // for a chunk without the flag, dr0 below 32, where the references repeat and need a pattern.
    %refP0 = func.call @back(%dstP, %dr0) : (!p, index) -> !p
    %rd = func.call @dist(%refP0, %dst) : (!p, !p) -> index
    %under = arith.cmpi slt, %rd, %c0 : index
    %near0 = arith.cmpi ult, %dr0, %c32 : index
    %short0 = arith.andi %notflat, %near0 : i1
    %cold0 = arith.ori %under, %short0 : i1
    %cold = func.call @unlikely(%cold0) : (i1) -> i1
    %rv = scf.if %cold -> !v {
      %d = func.call @dist(%dstP, %dst) : (!p, !p) -> index
      %dr = arith.minui %dr0, %d : index
      %rs = arith.subi %d, %dr : index
      %near = arith.cmpi ult, %dr, %c32 : index
      %short = arith.andi %notflat, %near : i1
      %y = scf.if %short -> !v {
        %z = func.call @repeat(%a, %dst, %rs, %dr) : (!p, !p, index, index) -> !v
        scf.yield %z : !v
      } else {
        %sp = func.call @at(%dst, %rs) : (!p, index) -> !p
        %z = func.call @ld(%sp, %c0) : (!p, index) -> !v
        scf.yield %z : !v
      }
      scf.yield %y : !v
    } else {
      %y = func.call @ld(%refP0, %c0) : (!p, index) -> !v
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
  %n, %g1 = scf.if %llong -> (index, index) {
    %ne, %g0 = func.call @escape(%a, %g) : (!p, index) -> (index, index)
    func.call @long(%dstP, %litsP, %ne) : (!p, !p, index) -> ()
    scf.yield %ne, %g0 : index, index
  } else {
    scf.yield %len, %g : index, index
  }
  %dstP1 = func.call @at(%dstP, %n) : (!p, index) -> !p
  // The match copies from the offset clamped to the position. Flat chunks raise it to
  // min(ml, 32) first, which the position covers, so their copies never overlap. Others take a
  // pattern for an offset below ml. Both the clamp and the pattern are rare, so they share a path
  // out of the loop.
  %ml = arith.shrui %t, %c2 : index
  %mlc = arith.minui %ml, %c32 : index
  %rr = arith.maxui %o, %mlc : index
  %r0 = arith.select %fd, %rr, %o : index
  // The source cursor lies src0 bytes after the start of dst: below 0 when the offset reaches
  // before dst, since the position is below 2^63 and the offset below 2^32.
  %srcP0 = func.call @back(%dstP1, %r0) : (!p, index) -> !p
  %src0 = func.call @dist(%srcP0, %dst) : (!p, !p) -> index
  %far = arith.cmpi slt, %src0, %c0 : index
  %near = arith.cmpi ult, %r0, %ml : index
  %pat0 = arith.andi %notflat, %near : i1
  %slow0 = arith.ori %far, %pat0 : i1
  %slow = func.call @unlikely(%slow0) : (i1) -> i1
  %r, %srcP, %mv = scf.if %slow -> (index, !p, !v) {
    %d1 = func.call @dist(%dstP1, %dst) : (!p, !p) -> index
    %rc = arith.minui %r0, %d1 : index
    %sc = arith.subi %d1, %rc : index
    %near2 = arith.cmpi ult, %rc, %ml : index
    %pat = arith.andi %notflat, %near2 : i1
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
    %y = func.call @ld(%srcP0, %c0) : (!p, index) -> !v
    scf.yield %r0, %srcP0, %y : index, !p, !v
  }
  func.call @st(%dstP1, %c0, %mv) : (!p, index, !v) -> ()
  // Match length codes from 33 on are 33 plus an escape. Such matches need an offset of at least
  // 32.
  %mlong0 = arith.cmpi uge, %ml, %c33 : index
  %mlong = func.call @unlikely(%mlong0) : (i1) -> i1
  %mn, %g2 = scf.if %mlong -> (index, index) {
    %close = arith.cmpi ult, %r, %c32 : index
    %bad = arith.andi %notflat, %close : i1
    scf.if %bad {
      func.call @set(%a, %c13, %c1) : (!p, index, index) -> ()
    }
    %me, %g0 = func.call @escape(%a, %g1) : (!p, index) -> (index, index)
    func.call @long(%dstP1, %srcP, %me) : (!p, !p, index) -> ()
    scf.yield %me, %g0 : index, index
  } else {
    scf.yield %ml, %g1 : index, index
  }
  %dstP2 = func.call @at(%dstP1, %mn) : (!p, index) -> !p
  %litsP1 = func.call @at(%litsP, %n) : (!p, index) -> !p
  return %dstP2, %litsP1, %g2 : !p, !p, index
}

// minlz_exec_plain runs the operations of a chunk.
func.func @minlz_exec_plain(%a: !p) {
  %f = arith.constant false
  func.call @run(%a, %f, %f) : (!p, i1, i1) -> ()
  return
}

// minlz_exec_delta runs the operations of a chunk with delta literals.
func.func @minlz_exec_delta(%a: !p) {
  %t = arith.constant true
  %f = arith.constant false
  func.call @run(%a, %t, %f) : (!p, i1, i1) -> ()
  return
}

// minlz_exec_flat runs the operations of a chunk with the no-overlap flag.
func.func @minlz_exec_flat(%a: !p) {
  %t = arith.constant true
  %f = arith.constant false
  func.call @run(%a, %f, %t) : (!p, i1, i1) -> ()
  return
}

// minlz_exec_flat_delta runs the operations of a chunk with the no-overlap flag and delta
// literals.
func.func @minlz_exec_flat_delta(%a: !p) {
  %t = arith.constant true
  func.call @run(%a, %t, %t) : (!p, i1, i1) -> ()
  return
}

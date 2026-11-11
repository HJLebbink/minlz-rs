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
// tab points to two tables. The first has a word per offset symbol, for @op: the mask of its raw bits in
// bits 0 to 31, their number in bits 32 to 39 and the base offset in bits 40 to 63. Symbol 0 is
// all zero: the batch gives it to repeats, whose offset is then 0, which keeps the last one. The
// second, from byte 2048, has 64 rows of 32 bytes for repeats: byte i of row r is i % r for r from
// 2 to 31, 0 for rows 0 and 1, and i for rows 32 and up.
//
// Every target file gives:
// - @tbl8(v: i64, idx: i64) -> i64, whose byte i is byte idx[i] of v, or 0 if idx[i] is 0x80;
// - @permute(t: vector<32xi8>, idx: vector<32xi8>) -> vector<32xi8>, whose byte i is byte idx[i]
//   of t, for indexes below 32.

!v = vector<32xi8>

// The words of a.
func.func private @arg(%a: !p, %i: index) -> index {
  %c8 = arith.constant 8 : index
  %o = arith.muli %i, %c8 : index
  %q = func.call @at(%a, %o) : (!p, index) -> !p
  %w = ptr.load %q alignment = 8 : !p -> i64
  %r = arith.index_castui %w : i64 to index
  return %r : index
}

func.func private @argp(%a: !p, %i: index) -> !p {
  %c8 = arith.constant 8 : index
  %o = arith.muli %i, %c8 : index
  %q = func.call @at(%a, %o) : (!p, index) -> !p
  %r = ptr.load %q alignment = 8 : !p -> !p
  return %r : !p
}

func.func private @set(%a: !p, %i: index, %x: index) {
  %c8 = arith.constant 8 : index
  %o = arith.muli %i, %c8 : index
  %q = func.call @at(%a, %o) : (!p, index) -> !p
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

// word returns the 64-bit word at p + o.
func.func private @word(%p: !p, %o: index) -> i64 {
  %q = func.call @at(%p, %o) : (!p, index) -> !p
  %r = ptr.load %q alignment = 1 : !p -> i64
  return %r : i64
}

// byte returns the byte at p + o.
func.func private @byte(%p: !p, %o: index) -> index {
  %q = func.call @at(%p, %o) : (!p, index) -> !p
  %b = ptr.load %q : !p -> i8
  %r = arith.index_castui %b : i8 to index
  return %r : index
}

// unlikely returns c, which LLVM then lays out as rarely true: the paths it guards go after the
// loop, and the common path runs straight through.
func.func private @unlikely(%c: i1) -> i1 {
  %f = llvm.mlir.constant(false) : i1
  %r = llvm.intr.expect %c, %f : i1
  return %r : i1
}

// escape returns the length 33 + e for the next escape byte e, and moves the escape index in a
// past it. Only escapes use the index, so it stays in memory.
func.func private @escape(%a: !p) -> index {
  %c1 = arith.constant 1 : index
  %c6 = arith.constant 6 : index
  %c15 = arith.constant 15 : index
  %c33 = arith.constant 33 : index
  %esc = func.call @argp(%a, %c6) : (!p, index) -> !p
  %g = func.call @arg(%a, %c15) : (!p, index) -> index
  %e = func.call @byte(%esc, %g) : (!p, index) -> index
  %g2 = arith.addi %g, %c1 : index
  func.call @set(%a, %c15, %g2) : (!p, index, index) -> ()
  %n = arith.addi %e, %c33 : index
  return %n : index
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

// op runs an operation with token t, literal length len (0 without literals) and offset v, from
// output position d, literal position l, the offset x before it and the bit position p, and
// returns them after it. With delta, its first 32 literals are added to their references. With
// flat, the chunk has the no-overlap flag, and with fd the offset is raised here. With inline, v
// is the offset symbol (0 for a repeat), which op decodes.
func.func private @op(%a: !p, %dst: !p, %lits: !p, %raw: !p, %tab: !p, %t: index, %len: index,
    %v: index, %delta: i1, %flat: i1, %inline: i1, %fd: i1, %d: index, %l: index, %x: index,
    %p: index) -> (index, index, index, index) {
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
  %o, %pn = scf.if %inline -> (index, index) {
    // The offset: the base of the symbol plus its raw bits at p; only symbol 0 decodes to 0,
    // which keeps the last offset.
    %eo = arith.muli %v, %c8 : index
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
    %o1 = arith.select %new, %on, %x : index
    scf.yield %o1, %p2 : index, index
  } else {
    scf.yield %v, %p : index, index
  }

  // The first 32 literals. Delta references use the offset from before the operation, clamped
  // to the position; flat chunks raise it to 32 first, and start at position 32 or later, so
  // their references never repeat.
  %lv = func.call @ld(%lits, %l) : (!p, index) -> !v
  %lv2 = scf.if %delta -> !v {
    %raised = arith.maxui %x, %c32 : index
    %dr0 = arith.select %flat, %raised, %x : index
    %dr = arith.minui %dr0, %d : index
    %rs = arith.subi %d, %dr : index
    %near = arith.cmpi ult, %dr, %c32 : index
    %short0 = arith.andi %notflat, %near : i1
    %short = func.call @unlikely(%short0) : (i1) -> i1
    %rv = scf.if %short -> !v {
      %y = func.call @repeat(%a, %dst, %rs, %dr) : (!p, !p, index, index) -> !v
      scf.yield %y : !v
    } else {
      %y = func.call @ld(%dst, %rs) : (!p, index) -> !v
      scf.yield %y : !v
    }
    %s = arith.addi %lv, %rv : !v
    scf.yield %s : !v
  } else {
    scf.yield %lv : !v
  }
  func.call @st(%dst, %d, %lv2) : (!p, index, !v) -> ()
  // Literal lengths from 33 on are 33 plus an escape.
  %llong0 = arith.cmpi uge, %len, %c33 : index
  %llong = func.call @unlikely(%llong0) : (i1) -> i1
  %n = scf.if %llong -> index {
    %n = func.call @escape(%a) : (!p) -> index
    %dp = func.call @at(%dst, %d) : (!p, index) -> !p
    %lp = func.call @at(%lits, %l) : (!p, index) -> !p
    func.call @long(%dp, %lp, %n) : (!p, !p, index) -> ()
    scf.yield %n : index
  } else {
    scf.yield %len : index
  }
  %d1 = arith.addi %d, %n : index
  %l1 = arith.addi %l, %n : index

  // The match copies from the offset clamped to the position. Flat chunks raise it to
  // min(ml, 32) first, which the position covers, so their copies never overlap. Others take a
  // pattern for an offset below ml. Both the clamp and the pattern are rare, so they share a path
  // out of the loop.
  %ml = arith.shrui %t, %c2 : index
  %mlc = arith.minui %ml, %c32 : index
  %rr = arith.maxui %o, %mlc : index
  %r0 = arith.select %fd, %rr, %o : index
  %src0 = arith.subi %d1, %r0 : index
  %far = arith.cmpi ugt, %r0, %d1 : index
  %near = arith.cmpi ult, %r0, %ml : index
  %pat0 = arith.andi %notflat, %near : i1
  %slow0 = arith.ori %far, %pat0 : i1
  %slow = func.call @unlikely(%slow0) : (i1) -> i1
  %r, %src, %mv = scf.if %slow -> (index, index, !v) {
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
    scf.yield %rc, %sc, %y : index, index, !v
  } else {
    %y = func.call @ld(%dst, %src0) : (!p, index) -> !v
    scf.yield %r0, %src0, %y : index, index, !v
  }
  func.call @st(%dst, %d1, %mv) : (!p, index, !v) -> ()
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
    %dp = func.call @at(%dst, %d1) : (!p, index) -> !p
    %sp = func.call @at(%dst, %src) : (!p, index) -> !p
    func.call @long(%dp, %sp, %n2) : (!p, !p, index) -> ()
    scf.yield %n2 : index
  } else {
    scf.yield %ml : index
  }
  %d2 = arith.addi %d1, %mn : index
  return %d2, %l1, %o, %pn : index, index, index, index
}

// minlz_exec_plain runs the operations of a chunk. Each kernel keeps its stack frame above the
// stack pointer (noredzone): it also runs on Windows, which does not reserve the area below.
func.func @minlz_exec_plain(%a: !p) attributes {llvm.passthrough = ["noredzone"]} {
  %f = arith.constant false
  func.call @run(%a, %f, %f) : (!p, i1, i1) -> ()
  return
}

// minlz_exec_delta runs the operations of a chunk with delta literals.
func.func @minlz_exec_delta(%a: !p) attributes {llvm.passthrough = ["noredzone"]} {
  %t = arith.constant true
  %f = arith.constant false
  func.call @run(%a, %t, %f) : (!p, i1, i1) -> ()
  return
}

// minlz_exec_flat runs the operations of a chunk with the no-overlap flag.
func.func @minlz_exec_flat(%a: !p) attributes {llvm.passthrough = ["noredzone"]} {
  %t = arith.constant true
  %f = arith.constant false
  func.call @run(%a, %f, %t) : (!p, i1, i1) -> ()
  return
}

// minlz_exec_flat_delta runs the operations of a chunk with the no-overlap flag and delta
// literals.
func.func @minlz_exec_flat_delta(%a: !p) attributes {llvm.passthrough = ["noredzone"]} {
  %t = arith.constant true
  func.call @run(%a, %t, %t) : (!p, i1, i1) -> ()
  return
}

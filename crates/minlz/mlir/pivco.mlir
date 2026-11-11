// The pivco decoder kernel of crates/minlz/src/pivco/kernel, for every target. `cargo xtask mlir`
// puts common.mlir and a target file (pivco/*.mlir) in front of this file and lowers the result
// once per target. The naked functions in crates/minlz/src/pivco/kernel/mlir.rs hold the output.
//
// The code works on 64 bytes at a time, and LLVM splits the vectors into the registers of the
// target. Every target file defines the types !b = vector<64xi8>, !m = vector<64xi1>,
// !lut = vector<256xi8> and !cols = vector<8x64xi8> first, as MLIR needs them before their first
// use, and gives:
// - @merge64(l: !p, r: !p, t: i64, c: !b, vv: i1, tab: !p) -> !b: the 64 outputs of a merge
//   whose bitmap bits are t. Byte i is the next value at r if bit i of t is set, else the next
//   value at l (vv) or c (not vv). It may read 64 bytes at l and at r. tab is the merge table of
//   mlir.rs.
// - @lanes() -> index: the row width of the vertical layout's loops, 64, 32 or 16.
// - @clean_codes() -> i1: whether @lut_map needs the bits above d of its codes clear.
// - @keep_cols(d: index) -> i1: whether a vertical block's d columns stay in registers for its 8
//   steps; else each step loads the columns it needs.
// - @lut_map(v: !b, t: !lut, d: index, w: index) -> !b, whose byte i is the symbol of code v[i]
//   in t (d from 2 to 8), for the low w lanes (64, 32 or 16); the others are not used. The bits
//   of v above d are clear, or may hold any value if @clean_codes is false.
// - @nat_codes(p: !p, d: index) -> !b: the 64 codes of depth d (2 to 8) in the natural layout at
//   p, one in each byte, with the bits above d clear. It may read 64 bytes at p.
// - @spread(t: i64) -> !b, whose byte i is 255 if bit i of t is set and 0 if not.
// - @load_n(p: !p, n: index) -> !b: the n bytes at p (n up to 64), zero after them. It reads only
//   those bytes.
// - @store_n(p: !p, n: index, v: !b): writes the first n bytes of v to p (n up to 64), and
//   nothing else.
//
// Each kind of op runs in a function of its own, which the op loop calls: inlined into the loop,
// LLVM would hoist the constants of every kind out of it and spill them. A function that the loop
// calls is internal and not inlined, and `cargo xtask mlir` puts its body after the kernel's.

// ld returns the 64 bytes at p + o.
func.func private @ld(%p: !p, %o: index) -> !b {
  %q = func.call @at(%p, %o) : (!p, index) -> !p
  %r = ptr.load %q alignment = 1 : !p -> !b
  return %r : !b
}

// st writes v to the 64 bytes at p + o.
func.func private @st(%p: !p, %o: index, %v: !b) {
  %q = func.call @at(%p, %o) : (!p, index) -> !p
  ptr.store %v, %q alignment = 1 : !b, !p
  return
}

// ld16 returns the 16 bytes at p + o.
func.func private @ld16(%p: !p, %o: index) -> vector<16xi8> {
  %q = func.call @at(%p, %o) : (!p, index) -> !p
  %r = ptr.load %q alignment = 1 : !p -> vector<16xi8>
  return %r : vector<16xi8>
}

// index16 returns the merge index of the 16 bitmap bits at bit s of m, from the merge table:
// row m0 of its first half plus row m1 of its second, m0 and m1 being the two bytes. Right lanes
// hold their place among the right values, left lanes 255 less their place among the left ones.
func.func private @index16(%m: i64, %s: i64, %tab: !p) -> vector<16xi8> {
  %c4 = arith.constant 4 : index
  %c4096 = arith.constant 4096 : index
  %e8 = arith.constant 8 : i64
  %ff = arith.constant 255 : i64
  %x = arith.shrui %m, %s : i64
  %a = arith.andi %x, %ff : i64
  %xb = arith.shrui %x, %e8 : i64
  %b = arith.andi %xb, %ff : i64
  %ai = arith.index_castui %a : i64 to index
  %bi = arith.index_castui %b : i64 to index
  %ao = arith.shli %ai, %c4 : index
  %bo0 = arith.shli %bi, %c4 : index
  %bo = arith.addi %bo0, %c4096 : index
  %ta = func.call @ld16(%tab, %ao) : (!p, index) -> vector<16xi8>
  %tb = func.call @ld16(%tab, %bo) : (!p, index) -> vector<16xi8>
  %r = arith.addi %ta, %tb : vector<16xi8>
  return %r : vector<16xi8>
}

// u32 returns the 32-bit word at p + o.
func.func private @u32(%p: !p, %o: index) -> index {
  %q = func.call @at(%p, %o) : (!p, index) -> !p
  %w = ptr.load %q alignment = 4 : !p -> i32
  %r = arith.index_castui %w : i32 to index
  return %r : index
}

// low returns the mask of the n low bits, for n from 0 to 64.
func.func private @low(%n: index) -> i64 {
  %c64 = arith.constant 64 : index
  %one = arith.constant 1 : i64
  %all = arith.constant -1 : i64
  %n64 = arith.index_castui %n : index to i64
  %s = arith.shli %one, %n64 : i64
  %m = arith.subi %s, %one : i64
  %full = arith.cmpi uge, %n, %c64 : index
  %r = arith.select %full, %all, %m : i64
  return %r : i64
}

// bits returns t as a mask: lane i is bit i.
func.func private @bits(%t: i64) -> !m {
  %v = vector.from_elements %t : vector<1xi64>
  %r = vector.bitcast %v : vector<1xi64> to !m
  return %r : !m
}

// pop returns the number of set bits of t.
func.func private @pop(%t: i64) -> index {
  %c = llvm.intr.ctpop(%t) : (i64) -> i64
  %r = arith.index_castui %c : i64 to index
  return %r : index
}

// splat returns x in every byte.
func.func private @splat(%x: index) -> !b {
  %b = arith.index_cast %x : index to i8
  %r = vector.broadcast %b : i8 to !b
  return %r : !b
}

// tail returns the n bytes at p (n up to 8) as a little-endian word. It reads only those bytes:
// two loads of 4 (or 2) bytes that overlap in the middle.
func.func private @tail(%p: !p, %n: index) -> i64 {
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c4 = arith.constant 4 : index
  %c8 = arith.constant 8 : index
  %z = arith.constant 0 : i64
  %ge4 = arith.cmpi uge, %n, %c4 : index
  %r = scf.if %ge4 -> i64 {
    %e = arith.subi %n, %c4 : index
    %qe = func.call @at(%p, %e) : (!p, index) -> !p
    %a = ptr.load %p alignment = 1 : !p -> i32
    %b = ptr.load %qe alignment = 1 : !p -> i32
    %a64 = arith.extui %a : i32 to i64
    %b64 = arith.extui %b : i32 to i64
    %eb = arith.muli %e, %c8 : index
    %s = arith.index_castui %eb : index to i64
    %bs = arith.shli %b64, %s : i64
    %x = arith.ori %a64, %bs : i64
    scf.yield %x : i64
  } else {
    %ge2 = arith.cmpi uge, %n, %c2 : index
    %r2 = scf.if %ge2 -> i64 {
      %e = arith.subi %n, %c2 : index
      %qe = func.call @at(%p, %e) : (!p, index) -> !p
      %a = ptr.load %p alignment = 1 : !p -> i16
      %b = ptr.load %qe alignment = 1 : !p -> i16
      %a64 = arith.extui %a : i16 to i64
      %b64 = arith.extui %b : i16 to i64
      %eb = arith.muli %e, %c8 : index
      %s = arith.index_castui %eb : index to i64
      %bs = arith.shli %b64, %s : i64
      %x = arith.ori %a64, %bs : i64
      scf.yield %x : i64
    } else {
      %one = arith.cmpi eq, %n, %c1 : index
      %r1 = scf.if %one -> i64 {
        %a = ptr.load %p : !p -> i8
        %a64 = arith.extui %a : i8 to i64
        scf.yield %a64 : i64
      } else {
        scf.yield %z : i64
      }
      scf.yield %r1 : i64
    }
    scf.yield %r2 : i64
  }
  return %r : i64
}

// load_parts returns the n bytes at p (n up to 64), zero after them, and reads only those bytes.
func.func private @load_parts(%p: !p, %n: index) -> !b {
  %c0 = arith.constant 0 : index
  %c64 = arith.constant 64 : index
  %full = arith.cmpi uge, %n, %c64 : index
  %r = scf.if %full -> !b {
    %x = func.call @ld(%p, %c0) : (!p, index) -> !b
    scf.yield %x : !b
  } else {
    %x = func.call @load_pieces(%p, %n) : (!p, index) -> !b
    scf.yield %x : !b
  }
  return %r : !b
}

// load_pieces is load_parts for n below 64. It loads the last n % 8 bytes with tail, then the
// pieces of 8, 16 and 32 bytes that n holds, from the last one to the first, and moves the bytes
// it has up past each new piece.
func.func private @load_pieces(%p: !p, %n: index) -> !b {
  %c0 = arith.constant 0 : index
  %c7 = arith.constant 7 : index
  %c8 = arith.constant 8 : index
  %c16 = arith.constant 16 : index
  %c32 = arith.constant 32 : index
  %z = arith.constant dense<0> : !b
  %zw = arith.constant dense<0> : vector<8xi64>
  %n7 = arith.andi %n, %c7 : index
  %e0 = arith.subi %n, %n7 : index
  %q0 = func.call @at(%p, %e0) : (!p, index) -> !p
  %w = func.call @tail(%q0, %n7) : (!p, index) -> i64
  %v0w = vector.insert %w, %zw [0] : i64 into vector<8xi64>
  %v0 = vector.bitcast %v0w : vector<8xi64> to !b
  %b8 = arith.andi %n, %c8 : index
  %h8 = arith.cmpi ne, %b8, %c0 : index
  %e1, %v1 = scf.if %h8 -> (index, !b) {
    %e = arith.subi %e0, %c8 : index
    %x = func.call @word(%p, %e) : (!p, index) -> i64
    %s = vector.extract_strided_slice %v0 {offsets = [0], sizes = [56], strides = [1]}
        : !b to vector<56xi8>
    %up = vector.insert_strided_slice %s, %z {offsets = [8], strides = [1]}
        : vector<56xi8> into !b
    %upw = vector.bitcast %up : !b to vector<8xi64>
    %rw = vector.insert %x, %upw [0] : i64 into vector<8xi64>
    %r = vector.bitcast %rw : vector<8xi64> to !b
    scf.yield %e, %r : index, !b
  } else {
    scf.yield %e0, %v0 : index, !b
  }
  %b16 = arith.andi %n, %c16 : index
  %h16 = arith.cmpi ne, %b16, %c0 : index
  %e2, %v2 = scf.if %h16 -> (index, !b) {
    %e = arith.subi %e1, %c16 : index
    %x = func.call @ld16(%p, %e) : (!p, index) -> vector<16xi8>
    %s = vector.extract_strided_slice %v1 {offsets = [0], sizes = [48], strides = [1]}
        : !b to vector<48xi8>
    %up = vector.insert_strided_slice %s, %z {offsets = [16], strides = [1]}
        : vector<48xi8> into !b
    %r = vector.insert_strided_slice %x, %up {offsets = [0], strides = [1]}
        : vector<16xi8> into !b
    scf.yield %e, %r : index, !b
  } else {
    scf.yield %e1, %v1 : index, !b
  }
  %b32 = arith.andi %n, %c32 : index
  %h32 = arith.cmpi ne, %b32, %c0 : index
  %v3 = scf.if %h32 -> !b {
    %q = func.call @at(%p, %c0) : (!p, index) -> !p
    %x = ptr.load %q alignment = 1 : !p -> vector<32xi8>
    %s = vector.extract_strided_slice %v2 {offsets = [0], sizes = [32], strides = [1]}
        : !b to vector<32xi8>
    %up = vector.insert_strided_slice %s, %z {offsets = [32], strides = [1]}
        : vector<32xi8> into !b
    %r = vector.insert_strided_slice %x, %up {offsets = [0], strides = [1]}
        : vector<32xi8> into !b
    scf.yield %r : !b
  } else {
    scf.yield %v2 : !b
  }
  return %v3 : !b
}

// store_parts writes the first n bytes of v to p (n up to 64), and nothing else.
func.func private @store_parts(%p: !p, %n: index, %v: !b) {
  %c0 = arith.constant 0 : index
  %c64 = arith.constant 64 : index
  %full = arith.cmpi uge, %n, %c64 : index
  scf.if %full {
    func.call @st(%p, %c0, %v) : (!p, index, !b) -> ()
  } else {
    func.call @store_pieces(%p, %n, %v) : (!p, index, !b) -> ()
  }
  return
}

// store_pieces is store_parts for n below 64: it writes the pieces of 32, 16, 8, 4, 2 and 1 bytes
// that n holds, each from the bottom of v, which then moves down past it.
func.func private @store_pieces(%p: !p, %n: index, %v: !b) {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c4 = arith.constant 4 : index
  %c8 = arith.constant 8 : index
  %c16 = arith.constant 16 : index
  %c32 = arith.constant 32 : index
  %s16 = arith.constant 16 : i64
  %s32 = arith.constant 32 : i64
  %s8 = arith.constant 8 : i64
  %z = arith.constant dense<0> : !b
  %b32 = arith.andi %n, %c32 : index
  %h32 = arith.cmpi ne, %b32, %c0 : index
  %p1, %v1 = scf.if %h32 -> (!p, !b) {
    %lo = vector.extract_strided_slice %v {offsets = [0], sizes = [32], strides = [1]}
        : !b to vector<32xi8>
    ptr.store %lo, %p alignment = 1 : vector<32xi8>, !p
    %hi = vector.extract_strided_slice %v {offsets = [32], sizes = [32], strides = [1]}
        : !b to vector<32xi8>
    %dn = vector.insert_strided_slice %hi, %z {offsets = [0], strides = [1]}
        : vector<32xi8> into !b
    %q = func.call @at(%p, %c32) : (!p, index) -> !p
    scf.yield %q, %dn : !p, !b
  } else {
    scf.yield %p, %v : !p, !b
  }
  %b16 = arith.andi %n, %c16 : index
  %h16 = arith.cmpi ne, %b16, %c0 : index
  %p2, %v2 = scf.if %h16 -> (!p, !b) {
    %lo = vector.extract_strided_slice %v1 {offsets = [0], sizes = [16], strides = [1]}
        : !b to vector<16xi8>
    ptr.store %lo, %p1 alignment = 1 : vector<16xi8>, !p
    %hi = vector.extract_strided_slice %v1 {offsets = [16], sizes = [48], strides = [1]}
        : !b to vector<48xi8>
    %dn = vector.insert_strided_slice %hi, %z {offsets = [0], strides = [1]}
        : vector<48xi8> into !b
    %q = func.call @at(%p1, %c16) : (!p, index) -> !p
    scf.yield %q, %dn : !p, !b
  } else {
    scf.yield %p1, %v1 : !p, !b
  }
  %vw = vector.bitcast %v2 : !b to vector<8xi64>
  %w0 = vector.extract %vw[0] : i64 from vector<8xi64>
  %w1 = vector.extract %vw[1] : i64 from vector<8xi64>
  %b8 = arith.andi %n, %c8 : index
  %h8 = arith.cmpi ne, %b8, %c0 : index
  %p3, %w = scf.if %h8 -> (!p, i64) {
    ptr.store %w0, %p2 alignment = 1 : i64, !p
    %q = func.call @at(%p2, %c8) : (!p, index) -> !p
    scf.yield %q, %w1 : !p, i64
  } else {
    scf.yield %p2, %w0 : !p, i64
  }
  %b4 = arith.andi %n, %c4 : index
  %h4 = arith.cmpi ne, %b4, %c0 : index
  %p4, %x4 = scf.if %h4 -> (!p, i64) {
    %t = arith.trunci %w : i64 to i32
    ptr.store %t, %p3 alignment = 1 : i32, !p
    %q = func.call @at(%p3, %c4) : (!p, index) -> !p
    %d = arith.shrui %w, %s32 : i64
    scf.yield %q, %d : !p, i64
  } else {
    scf.yield %p3, %w : !p, i64
  }
  %b2 = arith.andi %n, %c2 : index
  %h2 = arith.cmpi ne, %b2, %c0 : index
  %p5, %x2 = scf.if %h2 -> (!p, i64) {
    %t = arith.trunci %x4 : i64 to i16
    ptr.store %t, %p4 alignment = 1 : i16, !p
    %q = func.call @at(%p4, %c2) : (!p, index) -> !p
    %d = arith.shrui %x4, %s16 : i64
    scf.yield %q, %d : !p, i64
  } else {
    scf.yield %p4, %x4 : !p, i64
  }
  %b1 = arith.andi %n, %c1 : index
  %h1 = arith.cmpi ne, %b1, %c0 : index
  scf.if %h1 {
    %t = arith.trunci %x2 : i64 to i8
    ptr.store %t, %p5 : i8, !p
  }
  return
}

// merge writes the k outputs of a VV (vv) or CV op (not vv, constant c) to o, from the bitmap at
// bm and the children at l and r, and returns the number of right values it took. Each step loads
// its values before it stores, and stores only its own outputs. That keeps the in-place layout
// safe: the output position nl + nr never passes the read position in the child it overlaps.
func.func private @merge(%o: !p, %k: index, %bm: !p, %l: !p, %r: !p, %c: index, %vv: i1,
    %tab: !p) -> index {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c3 = arith.constant 3 : index
  %c6 = arith.constant 6 : index
  %c7 = arith.constant 7 : index
  %c63 = arith.constant 63 : index
  %c64 = arith.constant 64 : index
  %cv = func.call @splat(%c) : (index) -> !b
  %steps = arith.shrui %k, %c6 : index
  %nl, %nr = scf.for %i = %c0 to %steps step %c1 iter_args(%sl = %c0, %sr = %c0)
      -> (index, index) {
    %bo = arith.muli %i, %c64 : index
    %to = arith.shrui %bo, %c3 : index
    %t = func.call @word(%bm, %to) : (!p, index) -> i64
    %lp = func.call @at(%l, %sl) : (!p, index) -> !p
    %rp = func.call @at(%r, %sr) : (!p, index) -> !p
    %v = func.call @merge64(%lp, %rp, %t, %cv, %vv, %tab) : (!p, !p, i64, !b, i1, !p) -> !b
    func.call @st(%o, %bo, %v) : (!p, index, !b) -> ()
    %pc = func.call @pop(%t) : (i64) -> index
    %sr2 = arith.addi %sr, %pc : index
    %lc = arith.subi %c64, %pc : index
    %sl2 = arith.addi %sl, %lc : index
    scf.yield %sl2, %sr2 : index, index
  }
  %rem = arith.andi %k, %c63 : index
  %has = arith.cmpi ne, %rem, %c0 : index
  %nr2 = scf.if %has -> index {
    %bo = arith.muli %steps, %c64 : index
    %to = arith.shrui %bo, %c3 : index
    %bq = func.call @at(%bm, %to) : (!p, index) -> !p
    %r7 = arith.addi %rem, %c7 : index
    %nb = arith.shrui %r7, %c3 : index
    %t0 = func.call @tail(%bq, %nb) : (!p, index) -> i64
    %lm = func.call @low(%rem) : (index) -> i64
    %t = arith.andi %t0, %lm : i64
    %lp = func.call @at(%l, %nl) : (!p, index) -> !p
    %rp = func.call @at(%r, %nr) : (!p, index) -> !p
    %v = func.call @merge64(%lp, %rp, %t, %cv, %vv, %tab) : (!p, !p, i64, !b, i1, !p) -> !b
    %oq = func.call @at(%o, %bo) : (!p, index) -> !p
    func.call @store_n(%oq, %rem, %v) : (!p, index, !b) -> ()
    %pc = func.call @pop(%t) : (i64) -> index
    %x = arith.addi %nr, %pc : index
    scf.yield %x : index
  } else {
    scf.yield %nr : index
  }
  return %nr2 : index
}

// merge_vv and merge_cv are merge for VV and CV ops.
func.func private @merge_vv(%o: !p, %k: index, %bm: !p, %l: !p, %r: !p, %tab: !p) -> index
    attributes {llvm.linkage = #llvm.linkage<internal>,
    llvm.passthrough = ["noinline"]} {
  %c0 = arith.constant 0 : index
  %true = arith.constant true
  %nr = func.call @merge(%o, %k, %bm, %l, %r, %c0, %true, %tab)
      : (!p, index, !p, !p, !p, index, i1, !p) -> index
  return %nr : index
}

func.func private @merge_cv(%o: !p, %k: index, %bm: !p, %r: !p, %c: index, %tab: !p) -> index
    attributes {llvm.linkage = #llvm.linkage<internal>,
    llvm.passthrough = ["noinline"]} {
  %false = arith.constant false
  %nr = func.call @merge(%o, %k, %bm, %r, %r, %c, %false, %tab)
      : (!p, index, !p, !p, !p, index, i1, !p) -> index
  return %nr : index
}

// pick returns p ^ diff in the bytes whose bit of t is set, and p in the others. AVX2 has no
// byte mask: an XOR and an AND take one micro-op each, where VPBLENDVB takes three.
func.func private @pick(%t: i64, %p: !b, %diff: !b) -> !b {
  %sel = func.call @spread(%t) : (i64) -> !b
  %x = arith.andi %diff, %sel : !b
  %r = arith.xori %p, %x : !b
  return %r : !b
}

// cc writes byte j = bit j of the bitmap at bm ? q : p for the k outputs at o.
func.func private @cc(%o: !p, %k: index, %bm: !p, %p: index, %q: index)
    attributes {llvm.linkage = #llvm.linkage<internal>,
    llvm.passthrough = ["noinline"]} {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c3 = arith.constant 3 : index
  %c6 = arith.constant 6 : index
  %c7 = arith.constant 7 : index
  %c63 = arith.constant 63 : index
  %c64 = arith.constant 64 : index
  %pv = func.call @splat(%p) : (index) -> !b
  %qv = func.call @splat(%q) : (index) -> !b
  %diff = arith.xori %pv, %qv : !b
  %steps = arith.shrui %k, %c6 : index
  scf.for %i = %c0 to %steps step %c1 {
    %bo = arith.muli %i, %c64 : index
    %to = arith.shrui %bo, %c3 : index
    %t = func.call @word(%bm, %to) : (!p, index) -> i64
    %v = func.call @pick(%t, %pv, %diff) : (i64, !b, !b) -> !b
    func.call @st(%o, %bo, %v) : (!p, index, !b) -> ()
  }
  %rem = arith.andi %k, %c63 : index
  %has = arith.cmpi ne, %rem, %c0 : index
  scf.if %has {
    %bo = arith.muli %steps, %c64 : index
    %to = arith.shrui %bo, %c3 : index
    %bq = func.call @at(%bm, %to) : (!p, index) -> !p
    %r7 = arith.addi %rem, %c7 : index
    %nb = arith.shrui %r7, %c3 : index
    %t = func.call @tail(%bq, %nb) : (!p, index) -> i64
    %v = func.call @pick(%t, %pv, %diff) : (i64, !b, !b) -> !b
    %oq = func.call @at(%o, %bo) : (!p, index) -> !p
    func.call @store_n(%oq, %rem, %v) : (!p, index, !b) -> ()
  }
  return
}

// lut_load returns the 2^d symbols at t (d from 2 to 8) in the low bytes of a table. It reads 64
// bytes for d up to 6, which R2S holds after any first rank, 128 for d = 7 and 256 for d = 8.
func.func private @lut_load(%t: !p, %d: index) -> !lut {
  %c0 = arith.constant 0 : index
  %c7 = arith.constant 7 : index
  %c8 = arith.constant 8 : index
  %c64 = arith.constant 64 : index
  %c128 = arith.constant 128 : index
  %c192 = arith.constant 192 : index
  %z = arith.constant dense<0> : !lut
  %t0 = func.call @ld(%t, %c0) : (!p, index) -> !b
  %r0 = vector.insert_strided_slice %t0, %z {offsets = [0], strides = [1]} : !b into !lut
  %d7 = arith.cmpi uge, %d, %c7 : index
  %r1 = scf.if %d7 -> !lut {
    %t1 = func.call @ld(%t, %c64) : (!p, index) -> !b
    %x = vector.insert_strided_slice %t1, %r0 {offsets = [64], strides = [1]} : !b into !lut
    scf.yield %x : !lut
  } else {
    scf.yield %r0 : !lut
  }
  %d8 = arith.cmpi uge, %d, %c8 : index
  %r2 = scf.if %d8 -> !lut {
    %t2 = func.call @ld(%t, %c128) : (!p, index) -> !b
    %t3 = func.call @ld(%t, %c192) : (!p, index) -> !b
    %x = vector.insert_strided_slice %t2, %r1 {offsets = [128], strides = [1]} : !b into !lut
    %y = vector.insert_strided_slice %t3, %x {offsets = [192], strides = [1]} : !b into !lut
    scf.yield %y : !lut
  } else {
    scf.yield %r1 : !lut
  }
  return %r2 : !lut
}

// vload returns the w bytes at p + o (w is 64, 32 or 16) in the low lanes, zero in the others.
func.func private @vload(%p: !p, %o: index, %w: index) -> !b {
  %c16 = arith.constant 16 : index
  %c32 = arith.constant 32 : index
  %z = arith.constant dense<0> : !b
  %q = func.call @at(%p, %o) : (!p, index) -> !p
  %is16 = arith.cmpi eq, %w, %c16 : index
  %is32 = arith.cmpi eq, %w, %c32 : index
  %r = scf.if %is16 -> !b {
    %x = ptr.load %q alignment = 1 : !p -> vector<16xi8>
    %y = vector.insert_strided_slice %x, %z {offsets = [0], strides = [1]}
        : vector<16xi8> into !b
    scf.yield %y : !b
  } else {
    %r2 = scf.if %is32 -> !b {
      %x = ptr.load %q alignment = 1 : !p -> vector<32xi8>
      %y = vector.insert_strided_slice %x, %z {offsets = [0], strides = [1]}
          : vector<32xi8> into !b
      scf.yield %y : !b
    } else {
      %x = ptr.load %q alignment = 1 : !p -> !b
      scf.yield %x : !b
    }
    scf.yield %r2 : !b
  }
  return %r : !b
}

// vstore writes the low w lanes of v (w is 64, 32 or 16) to p + o.
func.func private @vstore(%p: !p, %o: index, %w: index, %v: !b) {
  %c16 = arith.constant 16 : index
  %c32 = arith.constant 32 : index
  %q = func.call @at(%p, %o) : (!p, index) -> !p
  %is16 = arith.cmpi eq, %w, %c16 : index
  %is32 = arith.cmpi eq, %w, %c32 : index
  scf.if %is16 {
    %x = vector.extract_strided_slice %v {offsets = [0], sizes = [16], strides = [1]}
        : !b to vector<16xi8>
    ptr.store %x, %q alignment = 1 : vector<16xi8>, !p
  } else {
    scf.if %is32 {
      %x = vector.extract_strided_slice %v {offsets = [0], sizes = [32], strides = [1]}
          : !b to vector<32xi8>
      ptr.store %x, %q alignment = 1 : vector<32xi8>, !p
    } else {
      ptr.store %v, %q alignment = 1 : !b, !p
    }
  }
  return
}

// shr16 and shl16 shift the 16-bit lanes of v by s: each byte takes bits from its neighbour. x86
// shifts 16-bit lanes in one instruction, where a byte shift needs a mask too.
func.func private @shr16(%v: !b, %s: index) -> !b {
  %s16 = arith.index_cast %s : index to i16
  %sv = vector.broadcast %s16 : i16 to vector<32xi16>
  %w = vector.bitcast %v : !b to vector<32xi16>
  %x = arith.shrui %w, %sv : vector<32xi16>
  %r = vector.bitcast %x : vector<32xi16> to !b
  return %r : !b
}

func.func private @shl16(%v: !b, %s: index) -> !b {
  %s16 = arith.index_cast %s : index to i16
  %sv = vector.broadcast %s16 : i16 to vector<32xi16>
  %w = vector.bitcast %v : !b to vector<32xi16>
  %x = arith.shli %w, %sv : vector<32xi16>
  %r = vector.bitcast %x : vector<32xi16> to !b
  return %r : !b
}

// cols loads the d columns of w lanes of a vertical block at src, n bytes apart, if the target
// keeps them in registers. Each column has a constant position, which MLIR needs to lower it.
func.func private @cols(%src: !p, %n: index, %w: index, %d: index) -> !cols {
  %z = arith.constant dense<0> : !cols
  %zb = arith.constant dense<0> : !b
  %keep = func.call @keep_cols(%d) : (index) -> i1
  %r = scf.if %keep -> !cols {
    %j0 = arith.constant 0 : index
    %h0 = arith.cmpi ult, %j0, %d : index
    %c0 = scf.if %h0 -> !b {
      %o = arith.muli %j0, %n : index
      %x = func.call @vload(%src, %o, %w) : (!p, index, index) -> !b
      scf.yield %x : !b
    } else {
      scf.yield %zb : !b
    }
    %a0 = vector.insert %c0, %z [0] : !b into !cols
    %j1 = arith.constant 1 : index
    %h1 = arith.cmpi ult, %j1, %d : index
    %c1 = scf.if %h1 -> !b {
      %o = arith.muli %j1, %n : index
      %x = func.call @vload(%src, %o, %w) : (!p, index, index) -> !b
      scf.yield %x : !b
    } else {
      scf.yield %zb : !b
    }
    %a1 = vector.insert %c1, %a0 [1] : !b into !cols
    %j2 = arith.constant 2 : index
    %h2 = arith.cmpi ult, %j2, %d : index
    %c2 = scf.if %h2 -> !b {
      %o = arith.muli %j2, %n : index
      %x = func.call @vload(%src, %o, %w) : (!p, index, index) -> !b
      scf.yield %x : !b
    } else {
      scf.yield %zb : !b
    }
    %a2 = vector.insert %c2, %a1 [2] : !b into !cols
    %j3 = arith.constant 3 : index
    %h3 = arith.cmpi ult, %j3, %d : index
    %c3 = scf.if %h3 -> !b {
      %o = arith.muli %j3, %n : index
      %x = func.call @vload(%src, %o, %w) : (!p, index, index) -> !b
      scf.yield %x : !b
    } else {
      scf.yield %zb : !b
    }
    %a3 = vector.insert %c3, %a2 [3] : !b into !cols
    %j4 = arith.constant 4 : index
    %h4 = arith.cmpi ult, %j4, %d : index
    %c4 = scf.if %h4 -> !b {
      %o = arith.muli %j4, %n : index
      %x = func.call @vload(%src, %o, %w) : (!p, index, index) -> !b
      scf.yield %x : !b
    } else {
      scf.yield %zb : !b
    }
    %a4 = vector.insert %c4, %a3 [4] : !b into !cols
    %j5 = arith.constant 5 : index
    %h5 = arith.cmpi ult, %j5, %d : index
    %c5 = scf.if %h5 -> !b {
      %o = arith.muli %j5, %n : index
      %x = func.call @vload(%src, %o, %w) : (!p, index, index) -> !b
      scf.yield %x : !b
    } else {
      scf.yield %zb : !b
    }
    %a5 = vector.insert %c5, %a4 [5] : !b into !cols
    %j6 = arith.constant 6 : index
    %h6 = arith.cmpi ult, %j6, %d : index
    %c6 = scf.if %h6 -> !b {
      %o = arith.muli %j6, %n : index
      %x = func.call @vload(%src, %o, %w) : (!p, index, index) -> !b
      scf.yield %x : !b
    } else {
      scf.yield %zb : !b
    }
    %a6 = vector.insert %c6, %a5 [6] : !b into !cols
    scf.yield %a6 : !cols
  } else {
    scf.yield %z : !cols
  }
  return %r : !cols
}

// col returns column j of w lanes of a vertical block at src: from cols, or a load if keep is
// false.
func.func private @col(%src: !p, %n: index, %w: index, %j: index, %cols: !cols, %keep: i1)
    -> !b {
  %r = scf.if %keep -> !b {
    %c = vector.extract %cols[%j] : !b from !cols
    scf.yield %c : !b
  } else {
    %jo = arith.muli %j, %n : index
    %c = func.call @vload(%src, %jo, %w) : (!p, index, index) -> !b
    scf.yield %c : !b
  }
  return %r : !b
}

// field returns the codes of step s, for w lanes of a vertical block of depth d at src whose
// column bytes are n bytes apart: the d-bit field at bit s*d of each lane, in the low bits of each
// byte. A field that ends in the next column takes its top bits from there. The bits above d are
// clear if the target's lookups need it (@clean_codes); else the field is cut with 16-bit shifts,
// one instruction each on x86 where a byte shift needs a mask too, and they hold bits of the
// neighbouring byte.
func.func private @field(%src: !p, %n: index, %w: index, %d: index, %s: index, %cols: !cols)
    -> !b {
  %c3 = arith.constant 3 : index
  %c7 = arith.constant 7 : index
  %c8 = arith.constant 8 : index
  %ff = arith.constant 255 : index
  %c1 = arith.constant 1 : index
  %sd = arith.muli %s, %d : index
  %j = arith.shrui %sd, %c3 : index
  %off = arith.andi %sd, %c7 : index
  %jo = arith.muli %j, %n : index
  %keep = func.call @keep_cols(%d) : (index) -> i1
  %c = func.call @col(%src, %n, %w, %j, %cols, %keep) : (!p, index, index, index, !cols, i1) -> !b
  %top = arith.addi %off, %d : index
  %cross = arith.cmpi ugt, %top, %c8 : index
  %up = arith.subi %c8, %off : index
  %clean = func.call @clean_codes() : () -> i1
  %r = scf.if %clean -> !b {
    %offv = func.call @splat(%off) : (index) -> !b
    %x = arith.shrui %c, %offv : !b
    %y = scf.if %cross -> !b {
      %j1 = arith.addi %j, %c1 : index
      %c2 = func.call @col(%src, %n, %w, %j1, %cols, %keep)
          : (!p, index, index, index, !cols, i1) -> !b
      %upv = func.call @splat(%up) : (index) -> !b
      %u = arith.shli %c2, %upv : !b
      %v = arith.ori %x, %u : !b
      scf.yield %v : !b
    } else {
      scf.yield %x : !b
    }
    // A field at the top of its byte has nothing above it.
    %below = arith.cmpi ne, %top, %c8 : index
    %z = scf.if %below -> !b {
      %one = arith.constant 1 : index
      %e = arith.shli %one, %d : index
      %mk = arith.subi %e, %one : index
      %mv = func.call @splat(%mk) : (index) -> !b
      %v = arith.andi %y, %mv : !b
      scf.yield %v : !b
    } else {
      scf.yield %y : !b
    }
    scf.yield %z : !b
  } else {
    %x = func.call @shr16(%c, %off) : (!b, index) -> !b
    // The bits below 8 - off come from the first column, the others from the second.
    %y = scf.if %cross -> !b {
      %j1 = arith.addi %j, %c1 : index
      %c2 = func.call @col(%src, %n, %w, %j1, %cols, %keep)
          : (!p, index, index, index, !cols, i1) -> !b
      %u = func.call @shl16(%c2, %up) : (!b, index) -> !b
      %mk = arith.shrui %ff, %off : index
      %m = func.call @splat(%mk) : (index) -> !b
      %ones = arith.constant dense<-1> : !b
      %nm = arith.xori %m, %ones : !b
      %a = arith.andi %x, %m : !b
      %b = arith.andi %u, %nm : !b
      %v = arith.ori %a, %b : !b
      scf.yield %v : !b
    } else {
      scf.yield %x : !b
    }
    scf.yield %y : !b
  }
  return %r : !b
}

// vstep decodes step s of w lanes of a vertical block of depth d at src, whose columns and rows
// are n bytes apart, to o.
func.func private @vstep(%o: !p, %src: !p, %n: index, %w: index, %d: index, %s: index,
    %t: !lut, %cols: !cols) {
  %v = func.call @field(%src, %n, %w, %d, %s, %cols)
      : (!p, index, index, index, index, !cols) -> !b
  %y = func.call @lut_map(%v, %t, %d, %w) : (!b, !lut, index, index) -> !b
  %so = arith.muli %s, %n : index
  func.call @vstore(%o, %so, %w, %y) : (!p, index, index, !b) -> ()
  return
}

// vert decodes `blocks` vertical blocks of n lanes (64 or 16) and depth d (2 to 7) from src to o,
// and maps the codes through the 2^d symbols at t. Lane l of a block holds its 8 codes in d column
// bytes n bytes apart; step s takes the codes s*n to s*n+n-1 from bits s*d of every lane. A block
// runs in parts of the target's row width, one after the other, so that the registers of one part
// are live at a time.
func.func private @vert(%o: !p, %src: !p, %blocks: index, %t: !p, %d: index, %n: index) {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c3 = arith.constant 3 : index
  %c4 = arith.constant 4 : index
  %c5 = arith.constant 5 : index
  %c6 = arith.constant 6 : index
  %c7 = arith.constant 7 : index
  %c8 = arith.constant 8 : index
  %lut = func.call @lut_load(%t, %d) : (!p, index) -> !lut
  %lanes = func.call @lanes() : () -> index
  %w = arith.minui %n, %lanes : index
  %parts = arith.divui %n, %w : index
  %in = arith.muli %n, %d : index
  %out = arith.muli %n, %c8 : index
  scf.for %b = %c0 to %blocks step %c1 {
    %so = arith.muli %b, %in : index
    %oo = arith.muli %b, %out : index
    scf.for %h = %c0 to %parts step %c1 {
      %ho = arith.muli %h, %w : index
      %so2 = arith.addi %so, %ho : index
      %oo2 = arith.addi %oo, %ho : index
      %sp = func.call @at(%src, %so2) : (!p, index) -> !p
      %op = func.call @at(%o, %oo2) : (!p, index) -> !p
      %cols = func.call @cols(%sp, %n, %w, %d) : (!p, index, index, index) -> !cols
      func.call @vstep(%op, %sp, %n, %w, %d, %c0, %lut, %cols)
          : (!p, !p, index, index, index, index, !lut, !cols) -> ()
      func.call @vstep(%op, %sp, %n, %w, %d, %c1, %lut, %cols)
          : (!p, !p, index, index, index, index, !lut, !cols) -> ()
      func.call @vstep(%op, %sp, %n, %w, %d, %c2, %lut, %cols)
          : (!p, !p, index, index, index, index, !lut, !cols) -> ()
      func.call @vstep(%op, %sp, %n, %w, %d, %c3, %lut, %cols)
          : (!p, !p, index, index, index, index, !lut, !cols) -> ()
      func.call @vstep(%op, %sp, %n, %w, %d, %c4, %lut, %cols)
          : (!p, !p, index, index, index, index, !lut, !cols) -> ()
      func.call @vstep(%op, %sp, %n, %w, %d, %c5, %lut, %cols)
          : (!p, !p, index, index, index, index, !lut, !cols) -> ()
      func.call @vstep(%op, %sp, %n, %w, %d, %c6, %lut, %cols)
          : (!p, !p, index, index, index, index, !lut, !cols) -> ()
      func.call @vstep(%op, %sp, %n, %w, %d, %c7, %lut, %cols)
          : (!p, !p, index, index, index, index, !lut, !cols) -> ()
    }
  }
  return
}

// vert_d runs vert with d and n as constants, which makes the shifts and masks of every step
// constants too.
func.func private @vert_d(%o: !p, %src: !p, %blocks: index, %t: !p, %d: index, %n: index)
    attributes {llvm.linkage = #llvm.linkage<internal>,
    llvm.passthrough = ["noinline"]} {
  %c16 = arith.constant 16 : index
  %narrow = arith.cmpi eq, %n, %c16 : index
  scf.if %narrow {
    func.call @vert_n(%o, %src, %blocks, %t, %d, %c16) : (!p, !p, index, !p, index, index) -> ()
  } else {
    %c64 = arith.constant 64 : index
    func.call @vert_n(%o, %src, %blocks, %t, %d, %c64) : (!p, !p, index, !p, index, index) -> ()
  }
  return
}

func.func private @vert_n(%o: !p, %src: !p, %blocks: index, %t: !p, %d: index, %n: index) {
  scf.index_switch %d
  case 2 {
    %c = arith.constant 2 : index
    func.call @vert(%o, %src, %blocks, %t, %c, %n) : (!p, !p, index, !p, index, index) -> ()
    scf.yield
  }
  case 3 {
    %c = arith.constant 3 : index
    func.call @vert(%o, %src, %blocks, %t, %c, %n) : (!p, !p, index, !p, index, index) -> ()
    scf.yield
  }
  case 4 {
    %c = arith.constant 4 : index
    func.call @vert(%o, %src, %blocks, %t, %c, %n) : (!p, !p, index, !p, index, index) -> ()
    scf.yield
  }
  case 5 {
    %c = arith.constant 5 : index
    func.call @vert(%o, %src, %blocks, %t, %c, %n) : (!p, !p, index, !p, index, index) -> ()
    scf.yield
  }
  case 6 {
    %c = arith.constant 6 : index
    func.call @vert(%o, %src, %blocks, %t, %c, %n) : (!p, !p, index, !p, index, index) -> ()
    scf.yield
  }
  case 7 {
    %c = arith.constant 7 : index
    func.call @vert(%o, %src, %blocks, %t, %c, %n) : (!p, !p, index, !p, index, index) -> ()
    scf.yield
  }
  default {
    scf.yield
  }
  return
}

// nat decodes k codes of depth d (2 to 8) in the natural layout from src to o, and maps them
// through the 2^d symbols at t; the input holds `left` bytes from src on. 64 codes take 8*d bytes.
// A step reads 64 bytes while the input has them; the last steps copy their exact bytes to the
// 64 bytes of scratch first.
func.func private @nat(%o: !p, %src: !p, %k: index, %d: index, %left: index, %t: !p,
    %scratch: !p) {
  %c0 = arith.constant 0 : index
  %c7 = arith.constant 7 : index
  %c3 = arith.constant 3 : index
  %c8 = arith.constant 8 : index
  %c64 = arith.constant 64 : index
  %lut = func.call @lut_load(%t, %d) : (!p, index) -> !lut
  %step = arith.muli %d, %c8 : index
  %o1, %s1, %k1, %l1 = scf.while (%oo = %o, %ss = %src, %kk = %k, %ll = %left)
      : (!p, !p, index, index) -> (!p, !p, index, index) {
    %a = arith.cmpi uge, %kk, %c64 : index
    %b = arith.cmpi uge, %ll, %c64 : index
    %go = arith.andi %a, %b : i1
    scf.condition(%go) %oo, %ss, %kk, %ll : !p, !p, index, index
  } do {
  ^bb0(%oo: !p, %ss: !p, %kk: index, %ll: index):
    %v = func.call @nat_codes(%ss, %d) : (!p, index) -> !b
    %y = func.call @lut_map(%v, %lut, %d, %c64) : (!b, !lut, index, index) -> !b
    func.call @st(%oo, %c0, %y) : (!p, index, !b) -> ()
    %o2 = func.call @at(%oo, %c64) : (!p, index) -> !p
    %s2 = func.call @at(%ss, %step) : (!p, index) -> !p
    %k2 = arith.subi %kk, %c64 : index
    // 64 bytes were left at ss, and a step takes at most 64.
    %l2 = arith.subi %ll, %step : index
    scf.yield %o2, %s2, %k2, %l2 : !p, !p, index, index
  }
  scf.while (%oo = %o1, %ss = %s1, %kk = %k1) : (!p, !p, index) -> (!p, !p, index) {
    %go = arith.cmpi ugt, %kk, %c0 : index
    scf.condition(%go) %oo, %ss, %kk : !p, !p, index
  } do {
  ^bb0(%oo: !p, %ss: !p, %kk: index):
    %c = arith.minui %kk, %c64 : index
    %cd = arith.muli %c, %d : index
    %cd7 = arith.addi %cd, %c7 : index
    %nb = arith.shrui %cd7, %c3 : index
    %w = func.call @load_n(%ss, %nb) : (!p, index) -> !b
    func.call @st(%scratch, %c0, %w) : (!p, index, !b) -> ()
    %v = func.call @nat_codes(%scratch, %d) : (!p, index) -> !b
    %y = func.call @lut_map(%v, %lut, %d, %c64) : (!b, !lut, index, index) -> !b
    func.call @store_n(%oo, %c, %y) : (!p, index, !b) -> ()
    %o2 = func.call @at(%oo, %c64) : (!p, index) -> !p
    %s2 = func.call @at(%ss, %step) : (!p, index) -> !p
    %k2 = arith.subi %kk, %c : index
    scf.yield %o2, %s2, %k2 : !p, !p, index
  }
  return
}

// nat_d runs nat with d as a constant.
func.func private @nat_d(%o: !p, %src: !p, %k: index, %d: index, %left: index, %t: !p,
    %scratch: !p) attributes {llvm.linkage = #llvm.linkage<internal>,
    llvm.passthrough = ["noinline"]} {
  scf.index_switch %d
  case 2 {
    %c = arith.constant 2 : index
    func.call @nat(%o, %src, %k, %c, %left, %t, %scratch)
        : (!p, !p, index, index, index, !p, !p) -> ()
    scf.yield
  }
  case 3 {
    %c = arith.constant 3 : index
    func.call @nat(%o, %src, %k, %c, %left, %t, %scratch)
        : (!p, !p, index, index, index, !p, !p) -> ()
    scf.yield
  }
  case 4 {
    %c = arith.constant 4 : index
    func.call @nat(%o, %src, %k, %c, %left, %t, %scratch)
        : (!p, !p, index, index, index, !p, !p) -> ()
    scf.yield
  }
  case 5 {
    %c = arith.constant 5 : index
    func.call @nat(%o, %src, %k, %c, %left, %t, %scratch)
        : (!p, !p, index, index, index, !p, !p) -> ()
    scf.yield
  }
  case 6 {
    %c = arith.constant 6 : index
    func.call @nat(%o, %src, %k, %c, %left, %t, %scratch)
        : (!p, !p, index, index, index, !p, !p) -> ()
    scf.yield
  }
  case 7 {
    %c = arith.constant 7 : index
    func.call @nat(%o, %src, %k, %c, %left, %t, %scratch)
        : (!p, !p, index, index, index, !p, !p) -> ()
    scf.yield
  }
  case 8 {
    %c = arith.constant 8 : index
    func.call @nat(%o, %src, %k, %c, %left, %t, %scratch)
        : (!p, !p, index, index, index, !p, !p) -> ()
    scf.yield
  }
  default {
    scf.yield
  }
  return
}

// copy copies the k bytes at src to o, which do not overlap.
func.func private @copy(%o: !p, %src: !p, %k: index) attributes {llvm.linkage = #llvm.linkage<internal>,
    llvm.passthrough = ["noinline"]} {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c6 = arith.constant 6 : index
  %c63 = arith.constant 63 : index
  %c64 = arith.constant 64 : index
  %steps = arith.shrui %k, %c6 : index
  scf.for %i = %c0 to %steps step %c1 {
    %j = arith.muli %i, %c64 : index
    %v = func.call @ld(%src, %j) : (!p, index) -> !b
    func.call @st(%o, %j, %v) : (!p, index, !b) -> ()
  }
  %rem = arith.andi %k, %c63 : index
  %has = arith.cmpi ne, %rem, %c0 : index
  scf.if %has {
    %j = arith.muli %steps, %c64 : index
    %sq = func.call @at(%src, %j) : (!p, index) -> !p
    %oq = func.call @at(%o, %j) : (!p, index) -> !p
    %v = func.call @load_n(%sq, %rem) : (!p, index) -> !b
    func.call @store_n(%oq, %rem, %v) : (!p, index, !b) -> ()
  }
  return
}

// op checks the op at op against the buffers, as exec_generic does, and runs it if it passes.
// It reports whether it passed: a VV or CV op passes only if it took kr right values.
func.func private @op(%op: !p, %in: !p, %ilen: index, %arena: !p, %alim: index, %dst: !p,
    %dlen: index, %r2s: !p, %r2s_len: index, %tab: !p, %scratch: !p) -> i1 {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c3 = arith.constant 3 : index
  %c4 = arith.constant 4 : index
  %c7 = arith.constant 7 : index
  %c8 = arith.constant 8 : index
  %c12 = arith.constant 12 : index
  %c16 = arith.constant 16 : index
  %c20 = arith.constant 20 : index
  %c24 = arith.constant 24 : index
  %c28 = arith.constant 28 : index
  %c64 = arith.constant 64 : index
  %c128 = arith.constant 128 : index
  %false = arith.constant false
  %true = arith.constant true
  %kind = func.call @byte(%op, %c0) : (!p, index) -> index
  %flags = func.call @byte(%op, %c1) : (!p, index) -> index
  %d = func.call @byte(%op, %c2) : (!p, index) -> index
  %p = func.call @byte(%op, %c3) : (!p, index) -> index
  %q = func.call @byte(%op, %c4) : (!p, index) -> index
  %k = func.call @u32(%op, %c8) : (!p, index) -> index
  %kr = func.call @u32(%op, %c12) : (!p, index) -> index
  %bm = func.call @u32(%op, %c16) : (!p, index) -> index
  %out = func.call @u32(%op, %c20) : (!p, index) -> index
  %l = func.call @u32(%op, %c24) : (!p, index) -> index
  %r = func.call @u32(%op, %c28) : (!p, index) -> index
  // The output: out+k must fit Dst, or the arena less its slack.
  %fd = arith.andi %flags, %c1 : index
  %todst = arith.cmpi ne, %fd, %c0 : index
  %base = arith.select %todst, %dst, %arena : !p
  %olim = arith.select %todst, %dlen, %alim : index
  %oend = arith.addi %out, %k : index
  %fits = arith.cmpi ule, %oend, %olim : index
  %o = func.call @at(%base, %out) : (!p, index) -> !p
  // The bitmap of a merge: ceil(k/8) bytes at bm in the input. A flat or a copy reads from bm too.
  %k7 = arith.addi %k, %c7 : index
  %nb = arith.shrui %k7, %c3 : index
  %bmend = arith.addi %bm, %nb : index
  %bmok = arith.cmpi ule, %bmend, %ilen : index
  %inp = func.call @at(%in, %bm) : (!p, index) -> !p
  // The children: k bytes at l and r in the arena less its slack.
  %lend = arith.addi %l, %k : index
  %lok = arith.cmpi ule, %lend, %alim : index
  %rend = arith.addi %r, %k : index
  %rok = arith.cmpi ule, %rend, %alim : index
  %lp = func.call @at(%arena, %l) : (!p, index) -> !p
  %rp = func.call @at(%arena, %r) : (!p, index) -> !p
  // A flat's symbols: R2S[p..p+2^d], for d from 2 to 8.
  %dlo = arith.cmpi uge, %d, %c2 : index
  %dc = arith.minui %d, %c8 : index
  %ts = arith.shli %c1, %dc : index
  %tend = arith.addi %p, %ts : index
  %tok0 = arith.cmpi ule, %tend, %r2s_len : index
  %tok = arith.andi %tok0, %dlo : i1
  %tp = func.call @at(%r2s, %p) : (!p, index) -> !p
  %kd = arith.muli %k, %d : index
  %ok = scf.if %fits -> i1 {
    %res = scf.index_switch %kind -> i1
    case 0 {
      %c = arith.andi %bmok, %lok : i1
      %c2b = arith.andi %c, %rok : i1
      %x = scf.if %c2b -> i1 {
        %nr = func.call @merge_vv(%o, %k, %inp, %lp, %rp, %tab) {no_inline}
            : (!p, index, !p, !p, !p, !p) -> index
        %e = arith.cmpi eq, %nr, %kr : index
        scf.yield %e : i1
      } else {
        scf.yield %false : i1
      }
      scf.yield %x : i1
    }
    case 1 {
      %c = arith.andi %bmok, %rok : i1
      %x = scf.if %c -> i1 {
        %nr = func.call @merge_cv(%o, %k, %inp, %rp, %p, %tab) {no_inline}
            : (!p, index, !p, !p, index, !p) -> index
        %e = arith.cmpi eq, %nr, %kr : index
        scf.yield %e : i1
      } else {
        scf.yield %false : i1
      }
      scf.yield %x : i1
    }
    case 2 {
      scf.if %bmok {
        func.call @cc(%o, %k, %inp, %p, %q) {no_inline} : (!p, index, !p, index, index) -> ()
      }
      scf.yield %bmok : i1
    }
    case 3 {
      %x = func.call @vflat(%o, %k, %d, %c64, %kd, %bm, %ilen, %tok, %inp, %tp)
          : (!p, index, index, index, index, index, index, i1, !p, !p) -> i1
      scf.yield %x : i1
    }
    case 4 {
      %x = func.call @vflat(%o, %k, %d, %c16, %kd, %bm, %ilen, %tok, %inp, %tp)
          : (!p, index, index, index, index, index, index, i1, !p, !p) -> i1
      scf.yield %x : i1
    }
    case 5 {
      // A natural flat: d up to 8, ceil(k*d/8) bytes at bm in the input.
      %d8 = arith.cmpi ule, %d, %c8 : index
      %kd7 = arith.addi %kd, %c7 : index
      %need = arith.shrui %kd7, %c3 : index
      %end = arith.addi %bm, %need : index
      %inok = arith.cmpi ule, %end, %ilen : index
      %c = arith.andi %d8, %tok : i1
      %c2b = arith.andi %c, %inok : i1
      scf.if %c2b {
        %left = arith.subi %ilen, %bm : index
        func.call @nat_d(%o, %inp, %k, %d, %left, %tp, %scratch) {no_inline}
            : (!p, !p, index, index, index, !p, !p) -> ()
      }
      scf.yield %c2b : i1
    }
    case 6 {
      // A copy: d = 8, k bytes at bm in the input.
      %d8 = arith.cmpi eq, %d, %c8 : index
      %end = arith.addi %bm, %k : index
      %inok = arith.cmpi ule, %end, %ilen : index
      %c = arith.andi %d8, %inok : i1
      scf.if %c {
        func.call @copy(%o, %inp, %k) {no_inline} : (!p, !p, index) -> ()
      }
      scf.yield %c : i1
    }
    default {
      scf.yield %false : i1
    }
    scf.yield %res : i1
  } else {
    scf.yield %false : i1
  }
  return %ok : i1
}

// vflat checks a flat op in the vertical layout of n lanes (64 or 16) and runs it if it passes:
// d up to 7, k a multiple of 8*n, and k*d/8 bytes at bm in the input. tok says whether R2S holds
// its symbols.
func.func private @vflat(%o: !p, %k: index, %d: index, %n: index, %kd: index, %bm: index,
    %ilen: index, %tok: i1, %src: !p, %tp: !p) -> i1 {
  %c0 = arith.constant 0 : index
  %c3 = arith.constant 3 : index
  %c7 = arith.constant 7 : index
  %c8 = arith.constant 8 : index
  %d7 = arith.cmpi ule, %d, %c7 : index
  %blk = arith.muli %n, %c8 : index
  %km = arith.remui %k, %blk : index
  %whole = arith.cmpi eq, %km, %c0 : index
  %need = arith.shrui %kd, %c3 : index
  %end = arith.addi %bm, %need : index
  %inok = arith.cmpi ule, %end, %ilen : index
  %c1b = arith.andi %d7, %whole : i1
  %c2b = arith.andi %c1b, %inok : i1
  %c3b = arith.andi %c2b, %tok : i1
  scf.if %c3b {
    %blocks = arith.divui %k, %blk : index
    func.call @vert_d(%o, %src, %blocks, %tp, %d, %n) {no_inline}
        : (!p, !p, index, !p, index, index) -> ()
  }
  return %c3b : i1
}

// minlz_pivco_exec runs the ops of a pivco Program (crates/minlz/src/pivco/kernel/mod.rs) in
// order, each after the checks of exec_generic, and returns the index of the first op that fails
// them, or the number of ops. a points to its arguments: the words ops, nops, input, ilen, arena,
// alim (the arena's length less ARENA_SLACK), dst, dlen, r2s, r2s_len (0 without R2S) and tab,
// then 64 bytes of scratch from byte 128.
func.func @minlz_pivco_exec(%a: !p) -> i64 {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c3 = arith.constant 3 : index
  %c4 = arith.constant 4 : index
  %c5 = arith.constant 5 : index
  %c6 = arith.constant 6 : index
  %c7 = arith.constant 7 : index
  %c8 = arith.constant 8 : index
  %c9 = arith.constant 9 : index
  %c10 = arith.constant 10 : index
  %c32 = arith.constant 32 : index
  %c128 = arith.constant 128 : index
  %false = arith.constant false
  %ops = func.call @argp(%a, %c0) : (!p, index) -> !p
  %nops = func.call @arg(%a, %c1) : (!p, index) -> index
  %in = func.call @argp(%a, %c2) : (!p, index) -> !p
  %ilen = func.call @arg(%a, %c3) : (!p, index) -> index
  %arena = func.call @argp(%a, %c4) : (!p, index) -> !p
  %alim = func.call @arg(%a, %c5) : (!p, index) -> index
  %dst = func.call @argp(%a, %c6) : (!p, index) -> !p
  %dlen = func.call @arg(%a, %c7) : (!p, index) -> index
  %r2s = func.call @argp(%a, %c8) : (!p, index) -> !p
  %r2s_len = func.call @arg(%a, %c9) : (!p, index) -> index
  %tab = func.call @argp(%a, %c10) : (!p, index) -> !p
  %scratch = func.call @at(%a, %c128) : (!p, index) -> !p
  %res = scf.while (%i = %c0) : (index) -> index {
    %more = arith.cmpi ult, %i, %nops : index
    %ok = scf.if %more -> i1 {
      %oo = arith.muli %i, %c32 : index
      %op = func.call @at(%ops, %oo) : (!p, index) -> !p
      %x = func.call @op(%op, %in, %ilen, %arena, %alim, %dst, %dlen, %r2s, %r2s_len, %tab,
          %scratch) : (!p, !p, index, !p, index, !p, index, !p, index, !p, !p) -> i1
      scf.yield %x : i1
    } else {
      scf.yield %false : i1
    }
    scf.condition(%ok) %i : index
  } do {
  ^bb0(%i: index):
    %n = arith.addi %i, %c1 : index
    scf.yield %n : index
  }
  %r = arith.index_castui %res : index to i64
  return %r : i64
}

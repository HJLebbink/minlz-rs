// Target file of pivco.mlir for x86-64 with AVX2: PSHUFB merges with the merge table and maps
// codes to symbols in 16-entry quarters of the table, which VPBLENDVB joins.

!b = vector<64xi8>
!m = vector<64xi1>
!lut = vector<256xi8>
!cols = vector<8x64xi8>

!y = vector<32xi8>

// shuf returns byte idx[i] & 15 of the 128-bit lane of t that holds byte i, or 0 where idx[i]
// has bit 7 set: VPSHUFB.
func.func private @shuf(%t: !y, %idx: !y) -> !y {
  %r = llvm.call_intrinsic "llvm.x86.avx2.pshuf.b"(%t, %idx) : (!y, !y) -> !y
  return %r : !y
}

// blendv returns byte i of b where byte i of m has bit 7 set, else byte i of a: VPBLENDVB.
func.func private @blendv(%a: !y, %b: !y, %m: !y) -> !y {
  %r = llvm.call_intrinsic "llvm.x86.avx2.pblendvb"(%a, %b, %m) : (!y, !y, !y) -> !y
  return %r : !y
}

// pair returns the 16 bytes at p in the low lane and the 16 at q in the high lane.
func.func private @pair(%p: !p, %q: !p) -> !y {
  %c0 = arith.constant 0 : index
  %a = func.call @ld16(%p, %c0) : (!p, index) -> vector<16xi8>
  %b = func.call @ld16(%q, %c0) : (!p, index) -> vector<16xi8>
  %r = vector.shuffle %a, %b [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
      16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ] : vector<16xi8>, vector<16xi8>
  return %r : !y
}

// half merges 32 outputs whose bitmap bits are the low 32 of m: the low lane takes its values at
// l and r, the high lane after the 16 outputs of the low one.
func.func private @half(%l: !p, %r: !p, %m: i64, %c: !y, %vv: i1, %tab: !p) -> !y {
  %c16 = arith.constant 16 : index
  %e0 = arith.constant 0 : i64
  %e16 = arith.constant 16 : i64
  %mask16 = arith.constant 65535 : i64
  %i0 = func.call @index16(%m, %e0, %tab) : (i64, i64, !p) -> vector<16xi8>
  %i1 = func.call @index16(%m, %e16, %tab) : (i64, i64, !p) -> vector<16xi8>
  %idx = vector.shuffle %i0, %i1 [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
      16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ] : vector<16xi8>, vector<16xi8>
  %m0 = arith.andi %m, %mask16 : i64
  %lo = func.call @pop(%m0) : (i64) -> index
  %r1 = func.call @at(%r, %lo) : (!p, index) -> !p
  %rv = func.call @pair(%r, %r1) : (!p, !p) -> !y
  %y = func.call @shuf(%rv, %idx) : (!y, !y) -> !y
  %out = scf.if %vv -> !y {
    %ln = arith.subi %c16, %lo : index
    %l1 = func.call @at(%l, %ln) : (!p, index) -> !p
    %lv = func.call @pair(%l, %l1) : (!p, !p) -> !y
    %ones = arith.constant dense<-1> : !y
    %nidx = arith.xori %idx, %ones : !y
    %z = func.call @shuf(%lv, %nidx) : (!y, !y) -> !y
    %o = arith.ori %y, %z : !y
    scf.yield %o : !y
  } else {
    // Left lanes have bit 7 of their index set.
    %o = func.call @blendv(%y, %c, %idx) : (!y, !y, !y) -> !y
    scf.yield %o : !y
  }
  return %out : !y
}

func.func private @merge64(%l: !p, %r: !p, %t: i64, %c: !b, %vv: i1, %tab: !p) -> !b {
  %c32 = arith.constant 32 : index
  %e32 = arith.constant 32 : i64
  %cy = vector.extract_strided_slice %c {offsets = [0], sizes = [32], strides = [1]} : !b to !y
  %h0 = func.call @half(%l, %r, %t, %cy, %vv, %tab) : (!p, !p, i64, !y, i1, !p) -> !y
  %lo32 = arith.constant 4294967295 : i64
  %t0 = arith.andi %t, %lo32 : i64
  %pc = func.call @pop(%t0) : (i64) -> index
  %ln = arith.subi %c32, %pc : index
  %l1 = func.call @at(%l, %ln) : (!p, index) -> !p
  %r1 = func.call @at(%r, %pc) : (!p, index) -> !p
  %t1a = arith.shrui %t, %e32 : i64
  // The second half takes its bits after the first half is merged, which keeps the scalar work of
  // one half live at a time: LLVM would split all eight bytes of t up front and spill.
  %t1 = llvm.inline_asm "", "=r,0,x" %t1a, %h0 : (i64, !y) -> i64
  %h1 = func.call @half(%l1, %r1, %t1, %cy, %vv, %tab) : (!p, !p, i64, !y, i1, !p) -> !y
  %z = arith.constant dense<0> : !b
  %x0 = vector.insert_strided_slice %h0, %z {offsets = [0], strides = [1]} : !y into !b
  %x1 = vector.insert_strided_slice %h1, %x0 {offsets = [32], strides = [1]} : !y into !b
  return %x1 : !b
}

// quarter returns entries 16q to 16q+15 of t in both lanes.
func.func private @quarter(%t: !lut, %q: index) -> !y {
  %t2 = vector.shape_cast %t : !lut to vector<16x16xi8>
  %x = vector.extract %t2[%q] : vector<16xi8> from vector<16x16xi8>
  %r = vector.shuffle %x, %x [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
    ] : vector<16xi8>, vector<16xi8>
  return %r : !y
}

// sign returns v with bit b of each byte in bit 7, as VPBLENDVB reads it: one 16-bit shift, whose
// bits from the byte below land under bit 7.
func.func private @sign(%v: !y, %b: index) -> !y {
  %c7 = arith.constant 7 : index
  %s = arith.subi %c7, %b : index
  %s16 = arith.index_cast %s : index to i16
  %sv = vector.broadcast %s16 : i16 to vector<16xi16>
  %w = vector.bitcast %v : !y to vector<16xi16>
  %x = arith.shli %w, %sv : vector<16xi16>
  %r = vector.bitcast %x : vector<16xi16> to !y
  return %r : !y
}

// tree2 maps v through the 32 entries of quarters q and q+1 (bit 4); tree4 through 64, tree8 through
// 128. v's bit 7 must be clear, as PSHUFB gives 0 otherwise.
func.func private @tree2(%v: !y, %t: !lut, %q: index) -> !y {
  %c1 = arith.constant 1 : index
  %c4 = arith.constant 4 : index
  %q1 = arith.addi %q, %c1 : index
  %ta = func.call @quarter(%t, %q) : (!lut, index) -> !y
  %tb = func.call @quarter(%t, %q1) : (!lut, index) -> !y
  %a = func.call @shuf(%ta, %v) : (!y, !y) -> !y
  %b = func.call @shuf(%tb, %v) : (!y, !y) -> !y
  %s = func.call @sign(%v, %c4) : (!y, index) -> !y
  %r = func.call @blendv(%a, %b, %s) : (!y, !y, !y) -> !y
  return %r : !y
}

func.func private @tree4(%v: !y, %t: !lut, %q: index) -> !y {
  %c2 = arith.constant 2 : index
  %c5 = arith.constant 5 : index
  %q2 = arith.addi %q, %c2 : index
  %a = func.call @tree2(%v, %t, %q) : (!y, !lut, index) -> !y
  %b = func.call @tree2(%v, %t, %q2) : (!y, !lut, index) -> !y
  %s = func.call @sign(%v, %c5) : (!y, index) -> !y
  %r = func.call @blendv(%a, %b, %s) : (!y, !y, !y) -> !y
  return %r : !y
}

func.func private @tree8(%v: !y, %t: !lut, %q: index) -> !y {
  %c4 = arith.constant 4 : index
  %c6 = arith.constant 6 : index
  %q4 = arith.addi %q, %c4 : index
  %a = func.call @tree4(%v, %t, %q) : (!y, !lut, index) -> !y
  %b = func.call @tree4(%v, %t, %q4) : (!y, !lut, index) -> !y
  %s = func.call @sign(%v, %c6) : (!y, index) -> !y
  %r = func.call @blendv(%a, %b, %s) : (!y, !y, !y) -> !y
  return %r : !y
}

// lut32 maps the 32 codes in v through t. For d = 8 the halves of the table are picked by bit 7,
// which the lookups below it must not see.
func.func private @lut32(%v: !y, %t: !lut, %d: index) -> !y {
  %c0 = arith.constant 0 : index
  %c4 = arith.constant 4 : index
  %c5 = arith.constant 5 : index
  %c6 = arith.constant 6 : index
  %c7 = arith.constant 7 : index
  %c8 = arith.constant 8 : index
  %r = scf.index_switch %d -> !y
  case 5 {
    %x = func.call @tree2(%v, %t, %c0) : (!y, !lut, index) -> !y
    scf.yield %x : !y
  }
  case 6 {
    %x = func.call @tree4(%v, %t, %c0) : (!y, !lut, index) -> !y
    scf.yield %x : !y
  }
  case 7 {
    %x = func.call @tree8(%v, %t, %c0) : (!y, !lut, index) -> !y
    scf.yield %x : !y
  }
  case 8 {
    %low7 = arith.constant dense<127> : !y
    %w = arith.andi %v, %low7 : !y
    %a = func.call @tree8(%w, %t, %c0) : (!y, !lut, index) -> !y
    %b = func.call @tree8(%w, %t, %c8) : (!y, !lut, index) -> !y
    %x = func.call @blendv(%a, %b, %v) : (!y, !y, !y) -> !y
    scf.yield %x : !y
  }
  default {
    %q = func.call @quarter(%t, %c0) : (!lut, index) -> !y
    %x = func.call @shuf(%q, %v) : (!y, !y) -> !y
    scf.yield %x : !y
  }
  return %r : !y
}

// keep_cols returns whether d is below 6: from 6 columns on, the columns and up to 8 table
// quarters overflow the 16 ymm registers, and loading them where they are used is cheaper than
// spilling.
func.func private @keep_cols(%d: index) -> i1 {
  %c6 = arith.constant 6 : index
  %r = arith.cmpi ult, %d, %c6 : index
  return %r : i1
}

// clean_codes returns true: PSHUFB reads bit 7 of a code, and the blends bits 4 to 7.
func.func private @clean_codes() -> i1 {
  %r = arith.constant true
  return %r : i1
}

// lanes returns the row width: a ymm register.
func.func private @lanes() -> index {
  %r = arith.constant 32 : index
  return %r : index
}


// lut_map maps the low w lanes of v, a ymm register at a time.
func.func private @lut_map(%v: !b, %t: !lut, %d: index, %w: index) -> !b {
  %c32 = arith.constant 32 : index
  %z = arith.constant dense<0> : !b
  %va = vector.extract_strided_slice %v {offsets = [0], sizes = [32], strides = [1]} : !b to !y
  %a = func.call @lut32(%va, %t, %d) : (!y, !lut, index) -> !y
  %x0 = vector.insert_strided_slice %a, %z {offsets = [0], strides = [1]} : !y into !b
  %one = arith.cmpi ule, %w, %c32 : index
  %r = scf.if %one -> !b {
    scf.yield %x0 : !b
  } else {
    %vb = vector.extract_strided_slice %v {offsets = [32], sizes = [32], strides = [1]}
        : !b to !y
    %b = func.call @lut32(%vb, %t, %d) : (!y, !lut, index) -> !y
    %x1 = vector.insert_strided_slice %b, %x0 {offsets = [32], strides = [1]} : !y into !b
    scf.yield %x1 : !b
  }
  return %r : !b
}
// nat32 returns the 32 codes of depth d (2 to 7) in the natural layout at p: the 16-byte windows
// at p and p + 2*d hold 16 codes each, one window in each lane. PSHUFB puts the two bytes of each
// code in a 16-bit lane, VPMULLW moves the code to the top of the lane and VPSRLW down to the
// bottom, and VPACKUSWB joins the codes. The multipliers are hidden from LLVM, which otherwise
// turns the multiply and the shift into slower variable shifts of 32-bit lanes.
func.func private @nat32(%p: !p, %d: index) -> !y {
  %c2 = arith.constant 2 : index
  %c16 = arith.constant 16 : index
  %g = arith.muli %d, %c2 : index
  %q = func.call @at(%p, %g) : (!p, index) -> !p
  %w = func.call @pair(%p, %q) : (!p, !p) -> !y
  // Byte 2e+h of a lane's pairs of codes 0 to 7 is byte (e*d >> 3) + h of its window, and of codes
  // 8 to 15 byte ((e+8)*d >> 3) + h.
  %io = vector.step : vector<32xindex>
  %iota = arith.index_cast %io : vector<32xindex> to !y
  %d8 = arith.index_cast %d : index to i8
  %dv = vector.broadcast %d8 : i8 to !y
  %one = arith.constant dense<1> : !y
  %three = arith.constant dense<3> : !y
  %eight = arith.constant dense<8> : !y
  %fifteen = arith.constant dense<15> : !y
  %i = arith.andi %iota, %fifteen : !y
  %e = arith.shrui %i, %one : !y
  %h = arith.andi %i, %one : !y
  %e8 = arith.addi %e, %eight : !y
  %ba = arith.muli %e, %dv : !y
  %bb = arith.muli %e8, %dv : !y
  %ia0 = arith.shrui %ba, %three : !y
  %ib0 = arith.shrui %bb, %three : !y
  %ia = arith.addi %ia0, %h : !y
  %ib = arith.addi %ib0, %h : !y
  %pa = func.call @shuf(%w, %ia) : (!y, !y) -> !y
  %pb = func.call @shuf(%w, %ib) : (!y, !y) -> !y
  %ua = vector.bitcast %pa : !y to vector<16xi16>
  %ub = vector.bitcast %pb : !y to vector<16xi16>
  // Lane m of a 128-bit lane holds code m (or m+8), which starts at bit m*d & 7 of its pair: the
  // multiplier 2^(16 - d - (m*d & 7)) moves it to the top.
  %io16 = vector.step : vector<16xindex>
  %m0 = arith.index_cast %io16 : vector<16xindex> to vector<16xi16>
  %d16 = arith.index_cast %d : index to i16
  %dw = vector.broadcast %d16 : i16 to vector<16xi16>
  %sevenw = arith.constant dense<7> : vector<16xi16>
  %eightw = arith.constant dense<8> : vector<16xi16>
  %onew = arith.constant dense<1> : vector<16xi16>
  %sixteenw = arith.constant dense<16> : vector<16xi16>
  %m = arith.andi %m0, %sevenw : vector<16xi16>
  %m8 = arith.addi %m, %eightw : vector<16xi16>
  %oa0 = arith.muli %m, %dw : vector<16xi16>
  %ob0 = arith.muli %m8, %dw : vector<16xi16>
  %oa = arith.andi %oa0, %sevenw : vector<16xi16>
  %ob = arith.andi %ob0, %sevenw : vector<16xi16>
  %top = arith.subi %sixteenw, %dw : vector<16xi16>
  %sa = arith.subi %top, %oa : vector<16xi16>
  %sb = arith.subi %top, %ob : vector<16xi16>
  %mula0 = arith.shli %onew, %sa : vector<16xi16>
  %mulb0 = arith.shli %onew, %sb : vector<16xi16>
  %mula = llvm.inline_asm "", "=x,0" %mula0 : (vector<16xi16>) -> vector<16xi16>
  %mulb = llvm.inline_asm "", "=x,0" %mulb0 : (vector<16xi16>) -> vector<16xi16>
  %xa = arith.muli %ua, %mula : vector<16xi16>
  %xb = arith.muli %ub, %mulb : vector<16xi16>
  %ca = arith.shrui %xa, %top : vector<16xi16>
  %cb = arith.shrui %xb, %top : vector<16xi16>
  %r = llvm.call_intrinsic "llvm.x86.avx2.packuswb"(%ca, %cb)
      : (vector<16xi16>, vector<16xi16>) -> !y
  return %r : !y
}

func.func private @nat_codes(%p: !p, %d: index) -> !b {
  %c0 = arith.constant 0 : index
  %c4 = arith.constant 4 : index
  %c8 = arith.constant 8 : index
  %full = arith.cmpi eq, %d, %c8 : index
  %r = scf.if %full -> !b {
    %x = func.call @ld(%p, %c0) : (!p, index) -> !b
    scf.yield %x : !b
  } else {
    %g = arith.muli %d, %c4 : index
    %q = func.call @at(%p, %g) : (!p, index) -> !p
    %a = func.call @nat32(%p, %d) : (!p, index) -> !y
    %b = func.call @nat32(%q, %d) : (!p, index) -> !y
    %z = arith.constant dense<0> : !b
    %x0 = vector.insert_strided_slice %a, %z {offsets = [0], strides = [1]} : !y into !b
    %x1 = vector.insert_strided_slice %b, %x0 {offsets = [32], strides = [1]} : !y into !b
    scf.yield %x1 : !b
  }
  return %r : !b
}

func.func private @load_n(%p: !p, %n: index) -> !b {
  %r = func.call @load_parts(%p, %n) : (!p, index) -> !b
  return %r : !b
}

func.func private @store_n(%p: !p, %n: index, %v: !b) {
  func.call @store_parts(%p, %n, %v) : (!p, index, !b) -> ()
  return
}

// spread returns 255 in the bytes whose bit of t is set: a mask, which LLVM keeps in a mask
// register where it can.
func.func private @spread(%t: i64) -> !b {
  %m = func.call @bits(%t) : (i64) -> !m
  %r = arith.extsi %m : !m to !b
  return %r : !b
}

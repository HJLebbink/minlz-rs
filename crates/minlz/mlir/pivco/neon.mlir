// Target file of pivco.mlir for NEON: TBL and TBX merge with the merge table and map codes to
// symbols from up to four registers of the table.

!b = vector<64xi8>
!m = vector<64xi1>
!lut = vector<256xi8>
!cols = vector<8x64xi8>

!q = vector<16xi8>

func.func private @tbl1(%t: !q, %idx: !q) -> !q {
  %r = llvm.call_intrinsic "llvm.aarch64.neon.tbl1.v16i8"(%t, %idx) : (!q, !q) -> !q
  return %r : !q
}

func.func private @tbx1(%acc: !q, %t: !q, %idx: !q) -> !q {
  %r = llvm.call_intrinsic "llvm.aarch64.neon.tbx1.v16i8"(%acc, %t, %idx) : (!q, !q, !q) -> !q
  return %r : !q
}

// quarter16 merges the 16 outputs whose bitmap bits are bits s to s+15 of t, from the values at
// l and r. The merge table gives right lanes their place among the right values, and left lanes
// 255 less their place among the left ones: TBX takes the right values, TBL of the complement the
// left ones.
func.func private @quarter16(%l: !p, %r: !p, %t: i64, %s: i64, %c: !q, %vv: i1, %tab: !p) -> !q {
  %c0 = arith.constant 0 : index
  %c4 = arith.constant 4 : index
  %c4096 = arith.constant 4096 : index
  %e8 = arith.constant 8 : i64
  %ff = arith.constant 255 : i64
  %x = arith.shrui %t, %s : i64
  %a = arith.andi %x, %ff : i64
  %xb = arith.shrui %x, %e8 : i64
  %b = arith.andi %xb, %ff : i64
  %ai = arith.index_castui %a : i64 to index
  %bi = arith.index_castui %b : i64 to index
  %ao = arith.shli %ai, %c4 : index
  %bo0 = arith.shli %bi, %c4 : index
  %bo = arith.addi %bo0, %c4096 : index
  %ta = func.call @ld16(%tab, %ao) : (!p, index) -> !q
  %tb = func.call @ld16(%tab, %bo) : (!p, index) -> !q
  %idx = arith.addi %ta, %tb : !q
  %rv = func.call @ld16(%r, %c0) : (!p, index) -> !q
  %base = scf.if %vv -> !q {
    %lv = func.call @ld16(%l, %c0) : (!p, index) -> !q
    %ones = arith.constant dense<-1> : !q
    %nidx = arith.xori %idx, %ones : !q
    %y = func.call @tbl1(%lv, %nidx) : (!q, !q) -> !q
    scf.yield %y : !q
  } else {
    scf.yield %c : !q
  }
  %out = func.call @tbx1(%base, %rv, %idx) : (!q, !q, !q) -> !q
  return %out : !q
}

// merge64 finds where each group of 16 outputs starts in the children from the running sums of
// the bitmap bytes' popcounts: CNT, then a multiply that adds each byte to the ones above it.
func.func private @merge64(%l: !p, %r: !p, %t: i64, %c: !b, %vv: i1, %tab: !p) -> !b {
  %c16 = arith.constant 16 : index
  %c32 = arith.constant 32 : index
  %c48 = arith.constant 48 : index
  %e0 = arith.constant 0 : i64
  %e8 = arith.constant 8 : i64
  %e16 = arith.constant 16 : i64
  %e24 = arith.constant 24 : i64
  %e32 = arith.constant 32 : i64
  %e40 = arith.constant 40 : i64
  %e48 = arith.constant 48 : i64
  %ff = arith.constant 255 : i64
  %ones = arith.constant 72340172838076673 : i64
  %tv = vector.from_elements %t : vector<1xi64>
  %tb = vector.bitcast %tv : vector<1xi64> to vector<8xi8>
  %cnt = llvm.intr.ctpop(%tb) : (vector<8xi8>) -> vector<8xi8>
  %cw = vector.bitcast %cnt : vector<8xi8> to vector<1xi64>
  %cs = vector.extract %cw[0] : i64 from vector<1xi64>
  %run = arith.muli %cs, %ones : i64
  %r1s = arith.shrui %run, %e8 : i64
  %r1w = arith.andi %r1s, %ff : i64
  %r2s = arith.shrui %run, %e24 : i64
  %r2w = arith.andi %r2s, %ff : i64
  %r3s = arith.shrui %run, %e40 : i64
  %r3w = arith.andi %r3s, %ff : i64
  %r1 = arith.index_castui %r1w : i64 to index
  %r2 = arith.index_castui %r2w : i64 to index
  %r3 = arith.index_castui %r3w : i64 to index
  %l1 = arith.subi %c16, %r1 : index
  %l2 = arith.subi %c32, %r2 : index
  %l3 = arith.subi %c48, %r3 : index
  %lp1 = func.call @at(%l, %l1) : (!p, index) -> !p
  %lp2 = func.call @at(%l, %l2) : (!p, index) -> !p
  %lp3 = func.call @at(%l, %l3) : (!p, index) -> !p
  %rp1 = func.call @at(%r, %r1) : (!p, index) -> !p
  %rp2 = func.call @at(%r, %r2) : (!p, index) -> !p
  %rp3 = func.call @at(%r, %r3) : (!p, index) -> !p
  %cq = vector.extract_strided_slice %c {offsets = [0], sizes = [16], strides = [1]} : !b to !q
  %q0 = func.call @quarter16(%l, %r, %t, %e0, %cq, %vv, %tab)
      : (!p, !p, i64, i64, !q, i1, !p) -> !q
  %q1 = func.call @quarter16(%lp1, %rp1, %t, %e16, %cq, %vv, %tab)
      : (!p, !p, i64, i64, !q, i1, !p) -> !q
  %q2 = func.call @quarter16(%lp2, %rp2, %t, %e32, %cq, %vv, %tab)
      : (!p, !p, i64, i64, !q, i1, !p) -> !q
  %q3 = func.call @quarter16(%lp3, %rp3, %t, %e48, %cq, %vv, %tab)
      : (!p, !p, i64, i64, !q, i1, !p) -> !q
  %z = arith.constant dense<0> : !b
  %x0 = vector.insert_strided_slice %q0, %z {offsets = [0], strides = [1]} : !q into !b
  %x1 = vector.insert_strided_slice %q1, %x0 {offsets = [16], strides = [1]} : !q into !b
  %x2 = vector.insert_strided_slice %q2, %x1 {offsets = [32], strides = [1]} : !q into !b
  %x3 = vector.insert_strided_slice %q3, %x2 {offsets = [48], strides = [1]} : !q into !b
  return %x3 : !b
}

// part returns entries 16i to 16i+15 of t.
func.func private @part(%t: !lut, %i: index) -> !q {
  %t2 = vector.shape_cast %t : !lut to vector<16x16xi8>
  %r = vector.extract %t2[%i] : !q from vector<16x16xi8>
  return %r : !q
}

func.func private @tbl4(%t: !lut, %i: index, %v: !q) -> !q {
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c3 = arith.constant 3 : index
  %i1 = arith.addi %i, %c1 : index
  %i2 = arith.addi %i, %c2 : index
  %i3 = arith.addi %i, %c3 : index
  %a = func.call @part(%t, %i) : (!lut, index) -> !q
  %b = func.call @part(%t, %i1) : (!lut, index) -> !q
  %c = func.call @part(%t, %i2) : (!lut, index) -> !q
  %e = func.call @part(%t, %i3) : (!lut, index) -> !q
  %r = llvm.call_intrinsic "llvm.aarch64.neon.tbl4.v16i8"(%a, %b, %c, %e, %v)
      : (!q, !q, !q, !q, !q) -> !q
  return %r : !q
}

func.func private @tbx4(%acc: !q, %t: !lut, %i: index, %v: !q) -> !q {
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c3 = arith.constant 3 : index
  %i1 = arith.addi %i, %c1 : index
  %i2 = arith.addi %i, %c2 : index
  %i3 = arith.addi %i, %c3 : index
  %a = func.call @part(%t, %i) : (!lut, index) -> !q
  %b = func.call @part(%t, %i1) : (!lut, index) -> !q
  %c = func.call @part(%t, %i2) : (!lut, index) -> !q
  %e = func.call @part(%t, %i3) : (!lut, index) -> !q
  %r = llvm.call_intrinsic "llvm.aarch64.neon.tbx4.v16i8"(%acc, %a, %b, %c, %e, %v)
      : (!q, !q, !q, !q, !q, !q) -> !q
  return %r : !q
}

// lut16 maps the 16 codes in v through t: TBL with one, two or four registers; for d = 7 the OR
// of two TBL4, of the codes and of the codes less 64, which do not wait for each other; for d = 8
// a TBL4 and three TBX4.
func.func private @lut16(%v: !q, %t: !lut, %d: index) -> !q {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c4 = arith.constant 4 : index
  %c8 = arith.constant 8 : index
  %c12 = arith.constant 12 : index
  %s64 = arith.constant dense<64> : !q
  %r = scf.index_switch %d -> !q
  case 5 {
    %a = func.call @part(%t, %c0) : (!lut, index) -> !q
    %b = func.call @part(%t, %c1) : (!lut, index) -> !q
    %x = llvm.call_intrinsic "llvm.aarch64.neon.tbl2.v16i8"(%a, %b, %v) : (!q, !q, !q) -> !q
    scf.yield %x : !q
  }
  case 6 {
    %x = func.call @tbl4(%t, %c0, %v) : (!lut, index, !q) -> !q
    scf.yield %x : !q
  }
  case 7 {
    %a = func.call @tbl4(%t, %c0, %v) : (!lut, index, !q) -> !q
    %w = arith.subi %v, %s64 : !q
    %b = func.call @tbl4(%t, %c4, %w) : (!lut, index, !q) -> !q
    %x = arith.ori %a, %b : !q
    scf.yield %x : !q
  }
  case 8 {
    %a = func.call @tbl4(%t, %c0, %v) : (!lut, index, !q) -> !q
    %w1 = arith.subi %v, %s64 : !q
    %b = func.call @tbx4(%a, %t, %c4, %w1) : (!q, !lut, index, !q) -> !q
    %w2 = arith.subi %w1, %s64 : !q
    %c = func.call @tbx4(%b, %t, %c8, %w2) : (!q, !lut, index, !q) -> !q
    %w3 = arith.subi %w2, %s64 : !q
    %x = func.call @tbx4(%c, %t, %c12, %w3) : (!q, !lut, index, !q) -> !q
    scf.yield %x : !q
  }
  default {
    %a = func.call @part(%t, %c0) : (!lut, index) -> !q
    %x = func.call @tbl1(%a, %v) : (!q, !q) -> !q
    scf.yield %x : !q
  }
  return %r : !q
}

// keep_cols returns true: seven columns and the tables fit the 32 q registers.
func.func private @keep_cols(%d: index) -> i1 {
  %r = arith.constant true
  return %r : i1
}

// clean_codes returns true: TBL gives 0 for a code above its table.
func.func private @clean_codes() -> i1 {
  %r = arith.constant true
  return %r : i1
}

// lanes returns the row width: a q register.
func.func private @lanes() -> index {
  %r = arith.constant 16 : index
  return %r : index
}

// lut_map maps the low w lanes of v, a q register at a time.
func.func private @lut_map(%v: !b, %t: !lut, %d: index, %w: index) -> !b {
  %c16 = arith.constant 16 : index
  %c32 = arith.constant 32 : index
  %z = arith.constant dense<0> : !b
  %v0q = vector.extract_strided_slice %v {offsets = [0], sizes = [16], strides = [1]} : !b to !q
  %a = func.call @lut16(%v0q, %t, %d) : (!q, !lut, index) -> !q
  %x0 = vector.insert_strided_slice %a, %z {offsets = [0], strides = [1]} : !q into !b
  %one16 = arith.cmpi ule, %w, %c16 : index
  %r = scf.if %one16 -> !b {
    scf.yield %x0 : !b
  } else {
    %v1 = vector.extract_strided_slice %v {offsets = [16], sizes = [16], strides = [1]}
        : !b to !q
    %b = func.call @lut16(%v1, %t, %d) : (!q, !lut, index) -> !q
    %x1 = vector.insert_strided_slice %b, %x0 {offsets = [16], strides = [1]} : !q into !b
    %two = arith.cmpi ule, %w, %c32 : index
    %r2 = scf.if %two -> !b {
      scf.yield %x1 : !b
    } else {
      %v2 = vector.extract_strided_slice %v {offsets = [32], sizes = [16], strides = [1]}
          : !b to !q
      %v3 = vector.extract_strided_slice %v {offsets = [48], sizes = [16], strides = [1]}
          : !b to !q
      %c = func.call @lut16(%v2, %t, %d) : (!q, !lut, index) -> !q
      %e = func.call @lut16(%v3, %t, %d) : (!q, !lut, index) -> !q
      %x2 = vector.insert_strided_slice %c, %x1 {offsets = [32], strides = [1]} : !q into !b
      %x3 = vector.insert_strided_slice %e, %x2 {offsets = [48], strides = [1]} : !q into !b
      scf.yield %x3 : !b
    }
    scf.yield %r2 : !b
  }
  return %r : !b
}
func.func private @nat_codes(%p: !p, %d: index) -> !b {
  %r = func.call @nat64(%p, %d) : (!p, index) -> !b
  return %r : !b
}

func.func private @tbl16(%v: !q, %idx: !q) -> !q {
  %r = func.call @tbl1(%v, %idx) : (!q, !q) -> !q
  return %r : !q
}

func.func private @load_n(%p: !p, %n: index) -> !b {
  %r = func.call @load_parts(%p, %n) : (!p, index) -> !b
  return %r : !b
}

func.func private @store_n(%p: !p, %n: index, %v: !b) {
  func.call @store_parts(%p, %n, %v) : (!p, index, !b) -> ()
  return
}

// spread returns 255 in the bytes whose bit of t is set: TBL copies byte k of t to bytes 8k to
// 8k+7, and CMTST tests bit i of byte i with the weights 1, 2, 4, ..., 128.
func.func private @spread(%t: i64) -> !b {
  %tv = vector.broadcast %t : i64 to vector<2xi64>
  %tb = vector.bitcast %tv : vector<2xi64> to !q
  %sel = arith.constant dense<[0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1]> : !q
  %w = arith.constant dense<[1, 2, 4, 8, 16, 32, 64, -128, 1, 2, 4, 8, 16, 32, 64, -128]> : !q
  %two = arith.constant dense<2> : !q
  %z = arith.constant dense<0> : !q
  %s1 = arith.addi %sel, %two : !q
  %s2 = arith.addi %s1, %two : !q
  %s3 = arith.addi %s2, %two : !q
  %x0 = func.call @tbl1(%tb, %sel) : (!q, !q) -> !q
  %x1 = func.call @tbl1(%tb, %s1) : (!q, !q) -> !q
  %x2 = func.call @tbl1(%tb, %s2) : (!q, !q) -> !q
  %x3 = func.call @tbl1(%tb, %s3) : (!q, !q) -> !q
  %a0 = arith.andi %x0, %w : !q
  %a1 = arith.andi %x1, %w : !q
  %a2 = arith.andi %x2, %w : !q
  %a3 = arith.andi %x3, %w : !q
  %m0 = arith.cmpi ne, %a0, %z : !q
  %m1 = arith.cmpi ne, %a1, %z : !q
  %m2 = arith.cmpi ne, %a2, %z : !q
  %m3 = arith.cmpi ne, %a3, %z : !q
  %y0 = arith.extsi %m0 : vector<16xi1> to !q
  %y1 = arith.extsi %m1 : vector<16xi1> to !q
  %y2 = arith.extsi %m2 : vector<16xi1> to !q
  %y3 = arith.extsi %m3 : vector<16xi1> to !q
  %zb = arith.constant dense<0> : !b
  %r0 = vector.insert_strided_slice %y0, %zb {offsets = [0], strides = [1]} : !q into !b
  %r1 = vector.insert_strided_slice %y1, %r0 {offsets = [16], strides = [1]} : !q into !b
  %r2 = vector.insert_strided_slice %y2, %r1 {offsets = [32], strides = [1]} : !q into !b
  %r3 = vector.insert_strided_slice %y3, %r2 {offsets = [48], strides = [1]} : !q into !b
  return %r3 : !b
}

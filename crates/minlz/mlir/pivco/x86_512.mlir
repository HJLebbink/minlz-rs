// Target file of pivco.mlir for x86-64 with AVX-512 VBMI and VBMI2: VPEXPANDB merges, VPERMB and
// VPERMI2B map codes to symbols, VPMULTISHIFTQB cuts natural codes, and masked moves load and
// store exactly.

!b = vector<64xi8>
!m = vector<64xi1>
!lut = vector<256xi8>
!cols = vector<8x64xi8>

// reg returns v in a register. LLVM cannot see through the empty assembly, so it neither folds a
// load into the instruction that uses v nor turns a zero v into a zero-masking form. Zen 4 and 5
// give the zero-masking VPEXPANDB a dependency on the old destination, and run its memory form
// slowly.
func.func private @reg(%v: !b) -> !b {
  %r = llvm.inline_asm "", "=v,0" %v : (!b) -> !b
  return %r : !b
}

// expand returns, in lane i, the next byte of x if lane i of m is set, else lane i of pass:
// VPEXPANDB.
func.func private @expand(%x: !b, %pass: !b, %m: !m) -> !b {
  %r = llvm.call_intrinsic "llvm.x86.avx512.mask.expand.v64i8"(%x, %pass, %m)
      : (!b, !b, !m) -> !b
  return %r : !b
}

func.func private @merge64(%l: !p, %r: !p, %t: i64, %c: !b, %vv: i1, %tab: !p) -> !b {
  %c0 = arith.constant 0 : index
  %tm = func.call @bits(%t) : (i64) -> !m
  %rv0 = func.call @ld(%r, %c0) : (!p, index) -> !b
  %rv = func.call @reg(%rv0) : (!b) -> !b
  %pass = scf.if %vv -> !b {
    %all = arith.constant -1 : i64
    %nt = arith.xori %t, %all : i64
    %ntm = func.call @bits(%nt) : (i64) -> !m
    %lv0 = func.call @ld(%l, %c0) : (!p, index) -> !b
    %lv = func.call @reg(%lv0) : (!b) -> !b
    %z0 = arith.constant dense<0> : !b
    %z = func.call @reg(%z0) : (!b) -> !b
    %e = func.call @expand(%lv, %z, %ntm) : (!b, !b, !m) -> !b
    scf.yield %e : !b
  } else {
    scf.yield %c : !b
  }
  %r2 = func.call @expand(%rv, %pass, %tm) : (!b, !b, !m) -> !b
  return %r2 : !b
}

// permb returns byte idx[i] & 63 of t in byte i: VPERMB.
func.func private @permb(%t: !b, %idx: !b) -> !b {
  %r = llvm.call_intrinsic "llvm.x86.avx512.permvar.qi.512"(%t, %idx) : (!b, !b) -> !b
  return %r : !b
}

// permi2b returns byte idx[i] & 127 of the 128 bytes a, b in byte i: VPERMI2B.
func.func private @permi2b(%a: !b, %idx: !b, %b: !b) -> !b {
  %r = llvm.call_intrinsic "llvm.x86.avx512.vpermi2var.qi.512"(%a, %idx, %b)
      : (!b, !b, !b) -> !b
  return %r : !b
}

// keep_cols returns true: seven columns and the tables fit the 32 zmm registers.
func.func private @keep_cols(%d: index) -> i1 {
  %r = arith.constant true
  return %r : i1
}

// clean_codes returns false: VPERMB and VPERMI2B ignore the bits above d of a code
// in the periodic table.
func.func private @clean_codes() -> i1 {
  %r = arith.constant false
  return %r : i1
}

// lanes returns the row width: a zmm register.
func.func private @lanes() -> index {
  %r = arith.constant 64 : index
  return %r : index
}

// periodic returns the first 64 entries of t, repeated every 2^d bytes for d up to 6, so that
// VPERMB maps a code with any bits above d.
func.func private @periodic(%t: !lut, %d: index) -> !b {
  %c6 = arith.constant 6 : index
  %one = arith.constant 1 : index
  %t0 = vector.extract_strided_slice %t {offsets = [0], sizes = [64], strides = [1]}
      : !lut to !b
  %dc = arith.minui %d, %c6 : index
  %e = arith.shli %one, %dc : index
  %mk = arith.subi %e, %one : index
  %m = func.call @splat(%mk) : (index) -> !b
  %io = vector.step : vector<64xindex>
  %iota = arith.index_cast %io : vector<64xindex> to !b
  %idx = arith.andi %iota, %m : !b
  %r = func.call @permb(%t0, %idx) : (!b, !b) -> !b
  return %r : !b
}

// lut_map maps the codes with VPERMB over the periodic table for d up to 6: on an xmm register
// for 16 lanes and up to 16 entries, on a ymm register for up to 32 lanes and 32 entries, which
// keep port 1 free. VPERMI2B ignores bit 7 for d = 7, and bit 7 picks between two of them for
// d = 8. The result of 16 lanes passes through an empty assembly statement with side effects,
// which keeps the 16-byte stores of a block apart: LLVM would merge them into wider stores with
// VINSERTI64X4 and VSHUFI64X2, which take port 5 from the lookups.
func.func private @lut_map(%v: !b, %t: !lut, %d: index, %w: index) -> !b {
  %c4 = arith.constant 4 : index
  %c5 = arith.constant 5 : index
  %c6 = arith.constant 6 : index
  %c7 = arith.constant 7 : index
  %c16 = arith.constant 16 : index
  %c32 = arith.constant 32 : index
  %z = arith.constant dense<0> : !b
  %t0 = vector.extract_strided_slice %t {offsets = [0], sizes = [64], strides = [1]}
      : !lut to !b
  %small = arith.cmpi ule, %d, %c6 : index
  %r = scf.if %small -> !b {
    %tp = func.call @periodic(%t, %d) : (!lut, index) -> !b
    %w16 = arith.cmpi ule, %w, %c16 : index
    %d4 = arith.cmpi ule, %d, %c4 : index
    %x16 = arith.andi %w16, %d4 : i1
    %w32 = arith.cmpi ule, %w, %c32 : index
    %d5 = arith.cmpi ule, %d, %c5 : index
    %x32 = arith.andi %w32, %d5 : i1
    %x = scf.if %x16 -> !b {
      %tq = vector.extract_strided_slice %tp {offsets = [0], sizes = [16], strides = [1]}
          : !b to vector<16xi8>
      %vq = vector.extract_strided_slice %v {offsets = [0], sizes = [16], strides = [1]}
          : !b to vector<16xi8>
      %y = llvm.call_intrinsic "llvm.x86.avx512.permvar.qi.128"(%tq, %vq)
          : (vector<16xi8>, vector<16xi8>) -> vector<16xi8>
      %yw = vector.insert_strided_slice %y, %z {offsets = [0], strides = [1]}
          : vector<16xi8> into !b
      scf.yield %yw : !b
    } else {
      %x2 = scf.if %x32 -> !b {
        %ty = vector.extract_strided_slice %tp {offsets = [0], sizes = [32], strides = [1]}
            : !b to vector<32xi8>
        %vy = vector.extract_strided_slice %v {offsets = [0], sizes = [32], strides = [1]}
            : !b to vector<32xi8>
        %y = llvm.call_intrinsic "llvm.x86.avx512.permvar.qi.256"(%ty, %vy)
            : (vector<32xi8>, vector<32xi8>) -> vector<32xi8>
        %yw = vector.insert_strided_slice %y, %z {offsets = [0], strides = [1]}
            : vector<32xi8> into !b
        scf.yield %yw : !b
      } else {
        %y = func.call @permb(%tp, %v) : (!b, !b) -> !b
        scf.yield %y : !b
      }
      scf.yield %x2 : !b
    }
    scf.yield %x : !b
  } else {
    %t1 = vector.extract_strided_slice %t {offsets = [64], sizes = [64], strides = [1]}
        : !lut to !b
    %lo = func.call @permi2b(%t0, %v, %t1) : (!b, !b, !b) -> !b
    %is7 = arith.cmpi eq, %d, %c7 : index
    %x = scf.if %is7 -> !b {
      scf.yield %lo : !b
    } else {
      %t2 = vector.extract_strided_slice %t {offsets = [128], sizes = [64], strides = [1]}
          : !lut to !b
      %t3 = vector.extract_strided_slice %t {offsets = [192], sizes = [64], strides = [1]}
          : !lut to !b
      %hi = func.call @permi2b(%t2, %v, %t3) : (!b, !b, !b) -> !b
      %top = arith.cmpi slt, %v, %z : !b
      %y = arith.select %top, %hi, %lo : !m, !b
      scf.yield %y : !b
    }
    scf.yield %x : !b
  }
  %w16 = arith.cmpi ule, %w, %c16 : index
  %out = scf.if %w16 -> !b {
    %y = llvm.inline_asm has_side_effects "", "=v,0" %r : (!b) -> !b
    scf.yield %y : !b
  } else {
    scf.yield %r : !b
  }
  return %out : !b
}
// nat_codes gathers bytes d*k to d*k+7 into qword k with VPERMB, and VPMULTISHIFTQB takes byte i
// of each qword from bit d*i. The index and the control are constants for a constant d.
func.func private @nat_codes(%p: !p, %d: index) -> !b {
  %c0 = arith.constant 0 : index
  %c8 = arith.constant 8 : index
  %w = func.call @ld(%p, %c0) : (!p, index) -> !b
  %full = arith.cmpi eq, %d, %c8 : index
  %r = scf.if %full -> !b {
    scf.yield %w : !b
  } else {
    %io = vector.step : vector<64xindex>
    %iota = arith.index_cast %io : vector<64xindex> to !b
    %dv = func.call @splat(%d) : (index) -> !b
    %three = arith.constant dense<3> : !b
    %seven = arith.constant dense<7> : !b
    %k = arith.shrui %iota, %three : !b
    %i = arith.andi %iota, %seven : !b
    %kd = arith.muli %k, %dv : !b
    %idx = arith.addi %kd, %i : !b
    %x = func.call @permb(%w, %idx) : (!b, !b) -> !b
    %ctrl = arith.muli %i, %dv : !b
    %y = llvm.call_intrinsic "llvm.x86.avx512.pmultishift.qb.512"(%ctrl, %x)
        : (!b, !b) -> !b
    %one = arith.constant 1 : index
    %e = arith.shli %one, %d : index
    %mk = arith.subi %e, %one : index
    %mv = func.call @splat(%mk) : (index) -> !b
    %z = arith.andi %y, %mv : !b
    scf.yield %z : !b
  }
  return %r : !b
}

// tbl16 returns byte idx[i] of v in byte i: PSHUFB.
func.func private @tbl16(%v: vector<16xi8>, %idx: vector<16xi8>) -> vector<16xi8> {
  %r = llvm.call_intrinsic "llvm.x86.ssse3.pshuf.b.128"(%v, %idx)
      : (vector<16xi8>, vector<16xi8>) -> vector<16xi8>
  return %r : vector<16xi8>
}

func.func private @load_n(%p: !p, %n: index) -> !b {
  %lm = func.call @low(%n) : (index) -> i64
  %m = func.call @bits(%lm) : (i64) -> !m
  %z = arith.constant dense<0> : !b
  %r = ptr.masked_load %p, %m, %z alignment = 1 : !p -> !b
  return %r : !b
}

func.func private @store_n(%p: !p, %n: index, %v: !b) {
  %lm = func.call @low(%n) : (index) -> i64
  %m = func.call @bits(%lm) : (i64) -> !m
  ptr.masked_store %v, %p, %m alignment = 1 : !b, !p
  return
}

// spread returns 255 in the bytes whose bit of t is set: a mask, which LLVM keeps in a mask
// register where it can.
func.func private @spread(%t: i64) -> !b {
  %m = func.call @bits(%t) : (i64) -> !m
  %r = arith.extsi %m : !m to !b
  return %r : !b
}

// Target file of crc32c.mlir for x86-64 with VPCLMULQDQ on 256-bit vectors: 8 lanes of 128 bits in
// ymm registers, 128 bytes a fold, and k = 4 words of each CRC32 chain per fold, in blocks of I = 8
// folds: 1024 vector bytes and three scalar regions of 256 bytes. The keys multiply by x^d for
// d = 1024 + 64 and 1024 in fold_keys; 8·3·256 + 64 and 8·3·256 in block_keys; 128·(7 - j) + 64 and
// 128·(7 - j) for lane j in lane_keys; and 8·2·256 - 64, 8·256 - 64 and -64, each minus 896 for
// lane 0, in chain_keys. cargo xtask mlir writes this file.

!st = vector<16xi64>
!w = vector<8x2xi64>

func.func private @stride() -> index {
  %r = arith.constant 128 : index
  return %r : index
}

func.func private @words() -> index {
  %r = arith.constant 4 : index
  return %r : index
}

func.func private @iters() -> index {
  %r = arith.constant 8 : index
  return %r : index
}

func.func private @fold_keys() -> !st {
  %r = arith.constant dense<[
    7311508529481777152, 8365178193191108608, 7311508529481777152, 8365178193191108608,
    7311508529481777152, 8365178193191108608, 7311508529481777152, 8365178193191108608,
    7311508529481777152, 8365178193191108608, 7311508529481777152, 8365178193191108608,
    7311508529481777152, 8365178193191108608, 7311508529481777152, 8365178193191108608
  ]> : !st
  return %r : !st
}

func.func private @block_keys() -> !st {
  %r = arith.constant dense<[
    8668591446237904896, -4163748391475478528, 8668591446237904896, -4163748391475478528,
    8668591446237904896, -4163748391475478528, 8668591446237904896, -4163748391475478528,
    8668591446237904896, -4163748391475478528, 8668591446237904896, -4163748391475478528,
    8668591446237904896, -4163748391475478528, 8668591446237904896, -4163748391475478528
  ]> : !st
  return %r : !st
}

func.func private @lane_keys() -> !st {
  %r = arith.constant dense<[
    1627051491397206016, -7620545986368110592, -3949769517311197184, 3703423898453278720,
    2036429962822549504, 7892626757205884928, 2024689343301419008, 8483555033831440384,
    -6598067393069580288, 6940368353756184576, 3732564607311544320, -6767349809599741952,
    3982298886646530048, 3562862082850291712, -2502406310683738112, 426846842152550400
  ]> : !st
  return %r : !st
}

func.func private @chain_keys() -> vector<3xi64> {
  %r = arith.constant dense<[
    4449734295027712000, 7311508529481777152, -1224287136463716352
  ]> : vector<3xi64>
  return %r : vector<3xi64>
}

// clmul2 is clmul2 on 16 words, as clmul8 on each half.
func.func private @clmul2(%x: !st, %k: !st) -> !st {
  %xa = vector.extract_strided_slice %x {offsets = [0], sizes = [8], strides = [1]}
      : !st to vector<8xi64>
  %xb = vector.extract_strided_slice %x {offsets = [8], sizes = [8], strides = [1]}
      : !st to vector<8xi64>
  %ka = vector.extract_strided_slice %k {offsets = [0], sizes = [8], strides = [1]}
      : !st to vector<8xi64>
  %kb = vector.extract_strided_slice %k {offsets = [8], sizes = [8], strides = [1]}
      : !st to vector<8xi64>
  %ra = func.call @clmul8(%xa, %ka) : (vector<8xi64>, vector<8xi64>) -> vector<8xi64>
  %rb = func.call @clmul8(%xb, %kb) : (vector<8xi64>, vector<8xi64>) -> vector<8xi64>
  %r = vector.shuffle %ra, %rb [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
    ] : vector<8xi64>, vector<8xi64>
  return %r : !st
}

// clmul8 is clmul2 on 8 words, as clmul_reg on each half.
func.func private @clmul8(%x: vector<8xi64>, %k: vector<8xi64>) -> vector<8xi64> {
  %xa = vector.extract_strided_slice %x {offsets = [0], sizes = [4], strides = [1]}
      : vector<8xi64> to vector<4xi64>
  %xb = vector.extract_strided_slice %x {offsets = [4], sizes = [4], strides = [1]}
      : vector<8xi64> to vector<4xi64>
  %ka = vector.extract_strided_slice %k {offsets = [0], sizes = [4], strides = [1]}
      : vector<8xi64> to vector<4xi64>
  %kb = vector.extract_strided_slice %k {offsets = [4], sizes = [4], strides = [1]}
      : vector<8xi64> to vector<4xi64>
  %ra = func.call @clmul_reg(%xa, %ka) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
  %rb = func.call @clmul_reg(%xb, %kb) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
  %r = vector.shuffle %ra, %rb [
      0, 1, 2, 3, 4, 5, 6, 7
    ] : vector<4xi64>, vector<4xi64>
  return %r : vector<8xi64>
}

// clmul_reg is clmul2 on one register: VPCLMULQDQ multiplies the low words of each 128-bit lane
// (immediate 0x00) or the high words (0x11).
func.func private @clmul_reg(%x: vector<4xi64>, %k: vector<4xi64>) -> vector<4xi64> {
  %lo = llvm.mlir.constant(0 : i8) : i8
  %hi = llvm.mlir.constant(17 : i8) : i8
  %a = llvm.call_intrinsic "llvm.x86.pclmulqdq.256"(%x, %k, %lo)
      : (vector<4xi64>, vector<4xi64>, i8) -> vector<4xi64>
  %b = llvm.call_intrinsic "llvm.x86.pclmulqdq.256"(%x, %k, %hi)
      : (vector<4xi64>, vector<4xi64>, i8) -> vector<4xi64>
  %r = arith.xori %a, %b : vector<4xi64>
  return %r : vector<4xi64>
}

// clmul returns the 128-bit carry-less product of a and b.
func.func private @clmul(%a: i64, %b: i64) -> vector<2xi64> {
  %z = arith.constant dense<0> : vector<2xi64>
  %va = vector.insert %a, %z [0] : i64 into vector<2xi64>
  %vb = vector.insert %b, %z [0] : i64 into vector<2xi64>
  %lo = llvm.mlir.constant(0 : i8) : i8
  %r = llvm.call_intrinsic "llvm.x86.pclmulqdq"(%va, %vb, %lo)
      : (vector<2xi64>, vector<2xi64>, i8) -> vector<2xi64>
  return %r : vector<2xi64>
}

// crc32 returns the CRC state c after the word w: CRC32 with a 64-bit operand.
func.func private @crc32(%c: i64, %w: i64) -> i64 {
  %r = llvm.call_intrinsic "llvm.x86.sse42.crc32.64.64"(%c, %w) : (i64, i64) -> i64
  return %r : i64
}

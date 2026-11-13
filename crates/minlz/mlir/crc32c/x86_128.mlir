// Target file of crc32c_fold.mlir for x86-64 with PCLMULQDQ on 128-bit vectors: 8 lanes of 128 bits
// in xmm registers, 128 bytes a fold, and k = 4 words of each CRC32 chain per fold, in blocks of
// I = 8 folds: 1024 vector bytes and three scalar regions of 256 bytes. Inputs below 2048 bytes
// take one CRC32 chain. The keys multiply by x^d for d = 1024 + 64 and 1024 in fold_keys;
// 8·3·256 + 64 and 8·3·256 in block_keys; 128·(7 - j) + 64 and 128·(7 - j) for lane j in lane_keys;
// and 8·2·256 - 64, 8·256 - 64 and -64, each minus 896 for lane 0, in chain_keys. cargo xtask mlir
// writes this file.

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

func.func private @min_len() -> index {
  %r = arith.constant 2048 : index
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

// clmul2_xor is clmul2_xor on 16 words, as clmul8_xor on each half.
func.func private @clmul2_xor(%x: !st, %k: !st, %d: !st)
    -> !st {
  %xa = vector.extract_strided_slice %x {offsets = [0], sizes = [8], strides = [1]}
      : !st to vector<8xi64>
  %xb = vector.extract_strided_slice %x {offsets = [8], sizes = [8], strides = [1]}
      : !st to vector<8xi64>
  %ka = vector.extract_strided_slice %k {offsets = [0], sizes = [8], strides = [1]}
      : !st to vector<8xi64>
  %kb = vector.extract_strided_slice %k {offsets = [8], sizes = [8], strides = [1]}
      : !st to vector<8xi64>
  %da = vector.extract_strided_slice %d {offsets = [0], sizes = [8], strides = [1]}
      : !st to vector<8xi64>
  %db = vector.extract_strided_slice %d {offsets = [8], sizes = [8], strides = [1]}
      : !st to vector<8xi64>
  %ra = func.call @clmul8_xor(%xa, %ka, %da)
      : (vector<8xi64>, vector<8xi64>, vector<8xi64>) -> vector<8xi64>
  %rb = func.call @clmul8_xor(%xb, %kb, %db)
      : (vector<8xi64>, vector<8xi64>, vector<8xi64>) -> vector<8xi64>
  %r = vector.shuffle %ra, %rb [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
    ] : vector<8xi64>, vector<8xi64>
  return %r : !st
}

// clmul8_xor is clmul2_xor on 8 words, as clmul4_xor on each half.
func.func private @clmul8_xor(%x: vector<8xi64>, %k: vector<8xi64>, %d: vector<8xi64>)
    -> vector<8xi64> {
  %xa = vector.extract_strided_slice %x {offsets = [0], sizes = [4], strides = [1]}
      : vector<8xi64> to vector<4xi64>
  %xb = vector.extract_strided_slice %x {offsets = [4], sizes = [4], strides = [1]}
      : vector<8xi64> to vector<4xi64>
  %ka = vector.extract_strided_slice %k {offsets = [0], sizes = [4], strides = [1]}
      : vector<8xi64> to vector<4xi64>
  %kb = vector.extract_strided_slice %k {offsets = [4], sizes = [4], strides = [1]}
      : vector<8xi64> to vector<4xi64>
  %da = vector.extract_strided_slice %d {offsets = [0], sizes = [4], strides = [1]}
      : vector<8xi64> to vector<4xi64>
  %db = vector.extract_strided_slice %d {offsets = [4], sizes = [4], strides = [1]}
      : vector<8xi64> to vector<4xi64>
  %ra = func.call @clmul4_xor(%xa, %ka, %da)
      : (vector<4xi64>, vector<4xi64>, vector<4xi64>) -> vector<4xi64>
  %rb = func.call @clmul4_xor(%xb, %kb, %db)
      : (vector<4xi64>, vector<4xi64>, vector<4xi64>) -> vector<4xi64>
  %r = vector.shuffle %ra, %rb [
      0, 1, 2, 3, 4, 5, 6, 7
    ] : vector<4xi64>, vector<4xi64>
  return %r : vector<8xi64>
}

// clmul4_xor is clmul2_xor on 4 words, as clmul_reg_xor on each half.
func.func private @clmul4_xor(%x: vector<4xi64>, %k: vector<4xi64>, %d: vector<4xi64>)
    -> vector<4xi64> {
  %xa = vector.extract_strided_slice %x {offsets = [0], sizes = [2], strides = [1]}
      : vector<4xi64> to vector<2xi64>
  %xb = vector.extract_strided_slice %x {offsets = [2], sizes = [2], strides = [1]}
      : vector<4xi64> to vector<2xi64>
  %ka = vector.extract_strided_slice %k {offsets = [0], sizes = [2], strides = [1]}
      : vector<4xi64> to vector<2xi64>
  %kb = vector.extract_strided_slice %k {offsets = [2], sizes = [2], strides = [1]}
      : vector<4xi64> to vector<2xi64>
  %da = vector.extract_strided_slice %d {offsets = [0], sizes = [2], strides = [1]}
      : vector<4xi64> to vector<2xi64>
  %db = vector.extract_strided_slice %d {offsets = [2], sizes = [2], strides = [1]}
      : vector<4xi64> to vector<2xi64>
  %ra = func.call @clmul_reg_xor(%xa, %ka, %da)
      : (vector<2xi64>, vector<2xi64>, vector<2xi64>) -> vector<2xi64>
  %rb = func.call @clmul_reg_xor(%xb, %kb, %db)
      : (vector<2xi64>, vector<2xi64>, vector<2xi64>) -> vector<2xi64>
  %r = vector.shuffle %ra, %rb [
      0, 1, 2, 3
    ] : vector<2xi64>, vector<2xi64>
  return %r : vector<4xi64>
}

// clmul_reg_xor is clmul2_xor on one register: PCLMULQDQ multiplies the low words of each 128-bit
// lane (immediate 0x00) or the high words (0x11).
func.func private @clmul_reg_xor(%x: vector<2xi64>, %k: vector<2xi64>, %d: vector<2xi64>) -> vector<2xi64> {
  %lo = llvm.mlir.constant(0 : i8) : i8
  %hi = llvm.mlir.constant(17 : i8) : i8
  %a = llvm.call_intrinsic "llvm.x86.pclmulqdq"(%x, %k, %lo)
      : (vector<2xi64>, vector<2xi64>, i8) -> vector<2xi64>
  %b = llvm.call_intrinsic "llvm.x86.pclmulqdq"(%x, %k, %hi)
      : (vector<2xi64>, vector<2xi64>, i8) -> vector<2xi64>
  %ab = arith.xori %a, %b : vector<2xi64>
  %r = arith.xori %ab, %d : vector<2xi64>
  return %r : vector<2xi64>
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

// crc32w, crc32h and crc32b return the CRC state c, low 32 bits, after v: CRC32 with a 32-bit,
// 16-bit or 8-bit operand.
func.func private @crc32w(%c: i64, %v: i32) -> i64 {
  %c32 = arith.trunci %c : i64 to i32
  %r32 = llvm.call_intrinsic "llvm.x86.sse42.crc32.32.32"(%c32, %v) : (i32, i32) -> i32
  %r = arith.extui %r32 : i32 to i64
  return %r : i64
}

func.func private @crc32h(%c: i64, %v: i16) -> i64 {
  %c32 = arith.trunci %c : i64 to i32
  %r32 = llvm.call_intrinsic "llvm.x86.sse42.crc32.32.16"(%c32, %v) : (i32, i16) -> i32
  %r = arith.extui %r32 : i32 to i64
  return %r : i64
}

func.func private @crc32b(%c: i64, %v: i8) -> i64 {
  %c32 = arith.trunci %c : i64 to i32
  %r32 = llvm.call_intrinsic "llvm.x86.sse42.crc32.32.8"(%c32, %v) : (i32, i8) -> i32
  %r = arith.extui %r32 : i32 to i64
  return %r : i64
}

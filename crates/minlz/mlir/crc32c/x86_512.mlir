// Target file of crc32c_fold.mlir for x86-64 with VPCLMULQDQ on 512-bit vectors: 16 lanes of 128
// bits in zmm registers, 256 bytes a fold, and k = 2 words of each CRC32 chain per fold, in blocks
// of I = 16 folds: 4096 vector bytes and three scalar regions of 256 bytes. Inputs below 1024 bytes
// take one CRC32 chain. The keys multiply by x^d for d = 2048 + 64 and 2048 in fold_keys;
// 8·3·256 + 64 and 8·3·256 in block_keys; 128·(15 - j) + 64 and 128·(15 - j) for lane j in
// lane_keys; and 8·2·256 - 64, 8·256 - 64 and -64, each minus 1920 for lane 0, in chain_keys. cargo
// xtask mlir writes this file.

!st = vector<32xi64>
!w = vector<16x2xi64>

func.func private @stride() -> index {
  %r = arith.constant 256 : index
  return %r : index
}

func.func private @words() -> index {
  %r = arith.constant 2 : index
  return %r : index
}

func.func private @iters() -> index {
  %r = arith.constant 16 : index
  return %r : index
}

func.func private @min_len() -> index {
  %r = arith.constant 1024 : index
  return %r : index
}

func.func private @fold_keys() -> !st {
  %r = arith.constant dense<[
    -1610642981159698432, 1452032738021343232, -1610642981159698432, 1452032738021343232,
    -1610642981159698432, 1452032738021343232, -1610642981159698432, 1452032738021343232,
    -1610642981159698432, 1452032738021343232, -1610642981159698432, 1452032738021343232,
    -1610642981159698432, 1452032738021343232, -1610642981159698432, 1452032738021343232,
    -1610642981159698432, 1452032738021343232, -1610642981159698432, 1452032738021343232,
    -1610642981159698432, 1452032738021343232, -1610642981159698432, 1452032738021343232,
    -1610642981159698432, 1452032738021343232, -1610642981159698432, 1452032738021343232,
    -1610642981159698432, 1452032738021343232, -1610642981159698432, 1452032738021343232
  ]> : !st
  return %r : !st
}

func.func private @block_keys() -> !st {
  %r = arith.constant dense<[
    8668591446237904896, -4163748391475478528, 8668591446237904896, -4163748391475478528,
    8668591446237904896, -4163748391475478528, 8668591446237904896, -4163748391475478528,
    8668591446237904896, -4163748391475478528, 8668591446237904896, -4163748391475478528,
    8668591446237904896, -4163748391475478528, 8668591446237904896, -4163748391475478528,
    8668591446237904896, -4163748391475478528, 8668591446237904896, -4163748391475478528,
    8668591446237904896, -4163748391475478528, 8668591446237904896, -4163748391475478528,
    8668591446237904896, -4163748391475478528, 8668591446237904896, -4163748391475478528,
    8668591446237904896, -4163748391475478528, 8668591446237904896, -4163748391475478528
  ]> : !st
  return %r : !st
}

func.func private @lane_keys() -> !st {
  %r = arith.constant dense<[
    -3561372721336025088, 328135827831914496, 964565967243837440, -5966578592056868864,
    -1872356864881065984, 6270699677188882432, 8992487729031806976, 3587475578350993408,
    -5986135871668092928, -4231685123306684416, 3605049029748064256, 4594071318164406272,
    -3520782398465769472, -3507858708728119296, 7311508529481777152, 8365178193191108608,
    1627051491397206016, -7620545986368110592, -3949769517311197184, 3703423898453278720,
    2036429962822549504, 7892626757205884928, 2024689343301419008, 8483555033831440384,
    -6598067393069580288, 6940368353756184576, 3732564607311544320, -6767349809599741952,
    3982298886646530048, 3562862082850291712, -2502406310683738112, 426846842152550400
  ]> : !st
  return %r : !st
}

func.func private @chain_keys() -> vector<3xi64> {
  %r = arith.constant dense<[
    -1610642981159698432, -2502406310683738112, -7027104801687076864
  ]> : vector<3xi64>
  return %r : vector<3xi64>
}

// clmul_state is the fold of crc32c_fold.mlir on the whole state, as clmul16_xor on each half.
func.func private @clmul_state(%x: !st, %k: !st, %d: !st)
    -> !st {
  %xa = vector.extract_strided_slice %x {offsets = [0], sizes = [16], strides = [1]}
      : !st to vector<16xi64>
  %xb = vector.extract_strided_slice %x {offsets = [16], sizes = [16], strides = [1]}
      : !st to vector<16xi64>
  %ka = vector.extract_strided_slice %k {offsets = [0], sizes = [16], strides = [1]}
      : !st to vector<16xi64>
  %kb = vector.extract_strided_slice %k {offsets = [16], sizes = [16], strides = [1]}
      : !st to vector<16xi64>
  %da = vector.extract_strided_slice %d {offsets = [0], sizes = [16], strides = [1]}
      : !st to vector<16xi64>
  %db = vector.extract_strided_slice %d {offsets = [16], sizes = [16], strides = [1]}
      : !st to vector<16xi64>
  %ra = func.call @clmul16_xor(%xa, %ka, %da)
      : (vector<16xi64>, vector<16xi64>, vector<16xi64>) -> vector<16xi64>
  %rb = func.call @clmul16_xor(%xb, %kb, %db)
      : (vector<16xi64>, vector<16xi64>, vector<16xi64>) -> vector<16xi64>
  %r = vector.shuffle %ra, %rb [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
      16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ] : vector<16xi64>, vector<16xi64>
  return %r : !st
}

// clmul16_xor is the fold of crc32c_fold.mlir on 16 words, as clmul8_xor on each half.
func.func private @clmul16_xor(%x: vector<16xi64>, %k: vector<16xi64>, %d: vector<16xi64>)
    -> vector<16xi64> {
  %xa = vector.extract_strided_slice %x {offsets = [0], sizes = [8], strides = [1]}
      : vector<16xi64> to vector<8xi64>
  %xb = vector.extract_strided_slice %x {offsets = [8], sizes = [8], strides = [1]}
      : vector<16xi64> to vector<8xi64>
  %ka = vector.extract_strided_slice %k {offsets = [0], sizes = [8], strides = [1]}
      : vector<16xi64> to vector<8xi64>
  %kb = vector.extract_strided_slice %k {offsets = [8], sizes = [8], strides = [1]}
      : vector<16xi64> to vector<8xi64>
  %da = vector.extract_strided_slice %d {offsets = [0], sizes = [8], strides = [1]}
      : vector<16xi64> to vector<8xi64>
  %db = vector.extract_strided_slice %d {offsets = [8], sizes = [8], strides = [1]}
      : vector<16xi64> to vector<8xi64>
  %ra = func.call @clmul8_xor(%xa, %ka, %da)
      : (vector<8xi64>, vector<8xi64>, vector<8xi64>) -> vector<8xi64>
  %rb = func.call @clmul8_xor(%xb, %kb, %db)
      : (vector<8xi64>, vector<8xi64>, vector<8xi64>) -> vector<8xi64>
  %r = vector.shuffle %ra, %rb [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
    ] : vector<8xi64>, vector<8xi64>
  return %r : vector<16xi64>
}

// clmul8_xor is the fold on one register: VPCLMULQDQ multiplies the low words of each 128-bit
// lane (immediate 0x00) or the high words (0x11).
func.func private @clmul8_xor(%x: vector<8xi64>, %k: vector<8xi64>, %d: vector<8xi64>)
    -> vector<8xi64> {
  %lo = llvm.mlir.constant(0 : i8) : i8
  %hi = llvm.mlir.constant(17 : i8) : i8
  %a = llvm.call_intrinsic "llvm.x86.pclmulqdq.512"(%x, %k, %lo)
      : (vector<8xi64>, vector<8xi64>, i8) -> vector<8xi64>
  %b = llvm.call_intrinsic "llvm.x86.pclmulqdq.512"(%x, %k, %hi)
      : (vector<8xi64>, vector<8xi64>, i8) -> vector<8xi64>
  %ab = arith.xori %a, %b : vector<8xi64>
  %r = arith.xori %ab, %d : vector<8xi64>
  return %r : vector<8xi64>
}

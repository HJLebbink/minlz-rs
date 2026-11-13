// Target file of crc32c_fold.mlir for NEON with PMULL from the AES extension: 8 lanes of 128 bits
// in q registers, 128 bytes a fold, and k = 4 words of each CRC32 chain per fold, in blocks of
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

// clmul2_xor is the fold on one q register: PMULL multiplies the low words, PMULL2 the high
// words.
func.func private @clmul2_xor(%x: vector<2xi64>, %k: vector<2xi64>, %d: vector<2xi64>)
    -> vector<2xi64> {
  %x0 = vector.extract %x[0] : i64 from vector<2xi64>
  %x1 = vector.extract %x[1] : i64 from vector<2xi64>
  %k0 = vector.extract %k[0] : i64 from vector<2xi64>
  %k1 = vector.extract %k[1] : i64 from vector<2xi64>
  %a = func.call @clmul(%x0, %k0) : (i64, i64) -> vector<2xi64>
  %b = func.call @clmul(%x1, %k1) : (i64, i64) -> vector<2xi64>
  %ab = arith.xori %a, %b : vector<2xi64>
  %r = arith.xori %ab, %d : vector<2xi64>
  return %r : vector<2xi64>
}

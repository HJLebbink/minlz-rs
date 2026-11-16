// Target file of crc32c_fold.mlir for SVE2 with PMULLB, PMULLT and EOR3: 8 lanes of 128 bits in q
// registers, 128 bytes a fold, and k = 4 words of each CRC32 chain per fold, in blocks of I = 8
// folds: 1024 vector bytes and three scalar regions of 256 bytes. Inputs below 2048 bytes take one
// CRC32 chain. The keys multiply by x^d for d = 1024 + 64 and 1024 in fold_keys; 8·3·256 + 64 and
// 8·3·256 in block_keys; 128·(7 - j) + 64 and 128·(7 - j) for lane j in lane_keys; and
// 8·2·256 - 64, 8·256 - 64 and -64, each minus 896 for lane 0, in chain_keys. cargo xtask mlir
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

// clmul2_xor is the fold on one register: pmullb multiplies the low words, pmullt the high
// words, and eor3 adds the two products and d in one instruction. At a 16-byte vector length a
// register is the two words, so pmullb takes element 0 of each operand and pmullt element 1, each
// into the whole register. eor3 also writes its last operand, so that is the product of the low
// words: its register is the one the next fold reads as the state, and with either other operand
// last the loop needs a copy of the state per lane.
func.func private @clmul2_xor(%x: vector<2xi64>, %k: vector<2xi64>, %d: vector<2xi64>)
    -> vector<2xi64> {
  %z = ub.poison : vector<[2]xi64>
  %z8 = ub.poison : vector<[16]xi8>
  %sx = vector.scalable.insert %x, %z[0] : vector<2xi64> into vector<[2]xi64>
  %sk = vector.scalable.insert %k, %z[0] : vector<2xi64> into vector<[2]xi64>
  %a = llvm.call_intrinsic "llvm.aarch64.sve.pmullb.pair"(%sx, %sk)
      : (vector<[2]xi64>, vector<[2]xi64>) -> vector<[2]xi64>
  %b = llvm.call_intrinsic "llvm.aarch64.sve.pmullt.pair"(%sx, %sk)
      : (vector<[2]xi64>, vector<[2]xi64>) -> vector<[2]xi64>
  %sa = vector.bitcast %a : vector<[2]xi64> to vector<[16]xi8>
  %sb = vector.bitcast %b : vector<[2]xi64> to vector<[16]xi8>
  %d8 = vector.bitcast %d : vector<2xi64> to vector<16xi8>
  %sd = vector.scalable.insert %d8, %z8[0] : vector<16xi8> into vector<[16]xi8>
  %r = llvm.call_intrinsic "llvm.aarch64.sve.eor3"(%sb, %sd, %sa)
      : (vector<[16]xi8>, vector<[16]xi8>, vector<[16]xi8>) -> vector<[16]xi8>
  %w = vector.bitcast %r : vector<[16]xi8> to vector<[2]xi64>
  %f = vector.scalable.extract %w[0] : vector<2xi64> from vector<[2]xi64>
  return %f : vector<2xi64>
}

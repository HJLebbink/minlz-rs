// A step of the halving chain of crc32c_fold.mlir: clmul2_xor on each half of 4 words. x86_128,
// neon and sve2 share this file. `cargo xtask mlir` writes it and puts it behind the target file
// and in front of crc32c.mlir, beside the other steps of the chain.

// clmul4_xor is the fold of crc32c_fold.mlir on 4 words, as clmul2_xor on each half.
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
  %ra = func.call @clmul2_xor(%xa, %ka, %da)
      : (vector<2xi64>, vector<2xi64>, vector<2xi64>) -> vector<2xi64>
  %rb = func.call @clmul2_xor(%xb, %kb, %db)
      : (vector<2xi64>, vector<2xi64>, vector<2xi64>) -> vector<2xi64>
  %r = vector.shuffle %ra, %rb [
      0, 1, 2, 3
    ] : vector<2xi64>, vector<2xi64>
  return %r : vector<4xi64>
}

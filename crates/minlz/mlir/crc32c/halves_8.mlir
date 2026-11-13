// A step of the halving chain of crc32c_fold.mlir: clmul4_xor on each half of 8 words. x86_128,
// x86_256, neon and sve2 share this file. `cargo xtask mlir` writes it and puts it behind the
// target file and in front of crc32c.mlir, beside the other steps of the chain.

// clmul8_xor is the fold of crc32c_fold.mlir on 8 words, as clmul4_xor on each half.
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

// The first step of the halving chain of crc32c_fold.mlir: clmul_state halves the 16 words of the
// fold's state and calls clmul8_xor on each half. x86_128, x86_256, neon and sve2 share this file.
// `cargo xtask mlir` writes it and puts it behind the target file, which defines the state type
// !st, and in front of crc32c.mlir.

// clmul_state is the fold of crc32c_fold.mlir on the whole state, as clmul8_xor on each half.
func.func private @clmul_state(%x: !st, %k: !st, %d: !st)
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

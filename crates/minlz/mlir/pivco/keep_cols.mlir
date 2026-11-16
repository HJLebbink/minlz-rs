// The @keep_cols of the targets that keep a vertical block's columns in registers: NEON and
// AVX-512. The AVX2 target has one of its own, which lets the columns go from 6 on. `cargo xtask
// mlir` puts this file after the target file.

// keep_cols returns true: seven columns and the tables fit the 32 registers of the target.
func.func private @keep_cols(%d: index) -> i1 {
  %r = arith.constant true
  return %r : i1
}

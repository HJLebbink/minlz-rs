// The @lohi that the SVE and the x86-64 targets of xxh3.mlir share; the NEON target has one of
// its own, which keeps the lanes of a q register apart. `cargo xtask mlir` puts this file after
// the target file, which gives !acc.

// lohi returns the product of the low and the high 32-bit half of each lane of x. On x86 LLVM
// makes it one PMULUDQ (VPMULUDQ with AVX), which multiplies the low halves of its operands, of x
// and of x >> 32.
func.func private @lohi(%x: !acc) -> !acc {
  %lo32 = arith.constant dense<4294967295> : !acc
  %c32 = arith.constant dense<32> : !acc
  %l = arith.andi %x, %lo32 : !acc
  %h = arith.shrui %x, %c32 : !acc
  %r = arith.muli %l, %h : !acc
  return %r : !acc
}

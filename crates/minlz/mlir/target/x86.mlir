// Target file for x86-64 (SSE2, AVX2 and AVX-512): the 8 accumulator lanes are one
// vector<8xi64>, which LLVM spreads over as many registers as the target needs.

!acc = vector<8xi64>

// lohi returns the product of the low and the high 32-bit half of each lane of x. LLVM makes it
// one PMULUDQ (VPMULUDQ with AVX), which multiplies the low halves of its operands, of x and
// x >> 32.
func.func private @lohi(%x: !acc) -> !acc {
  %lo32 = arith.constant dense<4294967295> : !acc
  %c32 = arith.constant dense<32> : !acc
  %l = arith.andi %x, %lo32 : !acc
  %h = arith.shrui %x, %c32 : !acc
  %r = arith.muli %l, %h : !acc
  return %r : !acc
}

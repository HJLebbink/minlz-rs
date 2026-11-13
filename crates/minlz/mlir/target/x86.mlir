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

// prefetch brings the 64 bytes at p into the cache hierarchy, down to the L1 (hint T0). It never
// faults, so the stripe loops may name an address past the end of the input.
func.func private @prefetch(%p: !p) {
  %read = arith.constant 0 : i32
  %locality = arith.constant 3 : i32
  %icc = arith.constant 1 : i32
  llvm.call_intrinsic "llvm.prefetch"(%p, %read, %locality, %icc) : (!p, i32, i32, i32) -> ()
  return
}

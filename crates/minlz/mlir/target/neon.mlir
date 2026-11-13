// Target file for NEON: the 8 accumulator lanes are one vector<8xi64> in four registers.

!acc = vector<8xi64>

// lohi returns the product of the low and the high 32-bit half of each lane of x.
func.func private @lohi(%x: !acc) -> !acc {
  %x32 = vector.bitcast %x : !acc to vector<16xi32>
  %a = vector.extract_strided_slice %x32 {offsets = [0], sizes = [8], strides = [1]}
      : vector<16xi32> to vector<8xi32>
  %b = vector.extract_strided_slice %x32 {offsets = [8], sizes = [8], strides = [1]}
      : vector<16xi32> to vector<8xi32>
  %ma = func.call @lohi4(%a) : (vector<8xi32>) -> vector<4xi64>
  %mb = func.call @lohi4(%b) : (vector<8xi32>) -> vector<4xi64>
  %r = vector.shuffle %ma, %mb [0, 1, 2, 3, 4, 5, 6, 7] : vector<4xi64>, vector<4xi64>
  return %r : !acc
}

// lohi4 returns lohi of the four lanes in v, two registers. UZP1 and UZP2 gather their low and
// high halves into one register each, and UMULL and UMULL2 (UMLAL and UMLAL2 once added) multiply
// them: two instructions per register fewer than XTN and SHRN for each. Left alone, LLVM turns the
// UZPs back into XTN and SHRN; the empty inline assembly, which LLVM cannot see through, stops it.
func.func private @lohi4(%v: vector<8xi32>) -> vector<4xi64> {
  %l, %h = vector.deinterleave %v : vector<8xi32> -> vector<4xi32>
  %lg = llvm.inline_asm "", "=w,0" %l : (vector<4xi32>) -> vector<4xi32>
  %hg = llvm.inline_asm "", "=w,0" %h : (vector<4xi32>) -> vector<4xi32>
  %l64 = arith.extui %lg : vector<4xi32> to vector<4xi64>
  %h64 = arith.extui %hg : vector<4xi32> to vector<4xi64>
  %m = arith.muli %l64, %h64 : vector<4xi64>
  return %m : vector<4xi64>
}

// prefetch does nothing on this target. A prfm four blocks ahead made XXH3 slower on both GB10
// cores, the Cortex-X925 and the Cortex-A725.
func.func private @prefetch(%p: !p) {
  return
}

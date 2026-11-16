// Target file for x86-64 (SSE2, AVX2 and AVX-512): the 8 accumulator lanes are one
// vector<8xi64>, which LLVM spreads over as many registers as the target needs.

!acc = vector<8xi64>

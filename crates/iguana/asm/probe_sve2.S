// AArch64 SVE2 toolchain probe — the ARM counterpart of asm/probe_avx512.asm.
//
// Proves the `.S -> as -> link -> extern "C" -> SVE2 -> Rust dispatch` pipeline
// end-to-end on real SVE2 silicon, and establishes the pattern the real kernels
// (Stages 1-4 of SVE2-PORT-PLAN.md) will follow. Vector-length-agnostic: the
// `whilelt`/`incb` loop runs on any SVE2 VL (128-bit on the GB10, wider on
// server cores).
//
// u64 iguana_sve2_byte_sum(const u8* src /*x0*/, size_t len /*x1*/)
//   returns the sum of all bytes in src[0..len].

.arch armv8-a+sve2+sve2-bitperm+sve2-sha3

.text
.global iguana_sve2_byte_sum
.type iguana_sve2_byte_sum, %function
iguana_sve2_byte_sum:
    mov     x2, #0                  // index into src
    mov     x3, #0                  // running 64-bit total
.Lloop:
    whilelt p0.b, x2, x1            // active lanes while x2 + lane < len (tail-safe)
    b.none  .Ldone                  // no active lanes -> finished
    ld1b    {z0.b}, p0/z, [x0, x2]  // load up to VL bytes (masked tail reads 0)
    uaddv   d0, p0, z0.b            // horizontal unsigned add of active bytes -> u64
    fmov    x4, d0
    add     x3, x3, x4
    incb    x2                      // x2 += bytes-per-vector (VL), length-agnostic
    b       .Lloop
.Ldone:
    mov     x0, x3
    ret
.size iguana_sve2_byte_sum, .-iguana_sve2_byte_sum

// Mark the stack non-executable (ELF hygiene; silences linker warnings).
.section .note.GNU-stack, "", %progbits

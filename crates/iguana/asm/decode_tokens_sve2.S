// AArch64 SVE2 Iguana structural-decode: per-token arithmetic (Stage 4, unit 1).
//
// ===========================================================================
// ⚠ NOT WIRED INTO THE DECODER — CURRENTLY SLOWER THAN SCALAR. Kept on purpose.
//
// Benchmarked on the GB10 (Cortex-X925, VL=128) against its Rust scalar twin
// (`decode_tokens_scalar`), 131 K tokens: scalar 12.3 GiB/s vs this kernel
// 4.55 GiB/s — i.e. **2.7× SLOWER**. The structural decoder is pure byte-ALU
// work, which the Rust scalar already auto-vectorises to NEON (16-wide); at
// VL=128 SVE2 is the *same* 16-byte width, so this hand-written kernel just
// competes with the compiler at equal width and loses on predicate/SEL/CPY
// latency. (Contrast the ans32 entropy kernels, which win at VL=128 because they
// use `LD1W` gather / `FDIV` — capabilities NEON & scalar lack, not extra width.)
//
// It is therefore **validated (differential-tested) but unused**: nothing in the
// decode path calls it; it is reached only by the diff test and the
// `decode_tokens` microbench. KEEP IT — it is a correct, ready starting point for
// the structural port on a WIDER-VL core (Graviton3/4, ≥256-bit), where 32–64-byte
// vectors finally exceed NEON width and the trade-off flips. See SVE2-PORT-PLAN.md
// §"Stage 4 — HALTED at VL=128".
// ===========================================================================
//
// Computes, for each Lizard token byte, the three per-token fields the rest of the
// structural decoder consumes — re-derived cleanly from the scalar decoder's
// semantics (decompress_block) rather than transliterating the x86 vpternlogd
// block (which only exists because AVX-512 lacks a byte shift; SVE2 has LSR.b,
// byte compares and SEL, so this is correct-by-construction):
//
//   token t -> (flags, litlen_base, matchlen_base)
//     short  (t >= 32): litlen_base = t & 7 ; matchlen_base = (t>>3) & 15
//                       flags |= varlitlen(0x02)  if (t&7)  == 7
//                       flags |= varmatchlen(0x04) if (t>>3)&15 == 15
//                       flags |= offset16(0x10)    if (t & 0x80) == 0
//     long   (t < 31) : litlen_base = 0 ; matchlen_base = t + 16 ; flags |= o24(0x08)
//     t == 31         : litlen_base = 0 ; matchlen_base = 47
//                       flags |= varmatchlen(0x04) | offset24(0x08)
//   (offset24 == "not short"; varint values are scattered onto the flagged tokens
//    in a later unit.)
//
// void iguana_sve2_decode_tokens(const u8* tokens /*x0*/, usize n /*x1*/,
//                                u8* flags /*x2*/, u8* litlen /*x3*/, u8* matchlen /*x4*/)
//
// VLA byte loop, leaf function, no stack: caller-saved regs only (x0-x5, z0-z7,
// z16/z17, p0-p8; avoids z8-z15).

.arch armv8-a+sve2

.text
.global iguana_sve2_decode_tokens
.type iguana_sve2_decode_tokens, %function
iguana_sve2_decode_tokens:
    dup     z17.b, #0                    // zero (for SEL fall-through)
    mov     x5, #0                       // li
.Ltok_loop:
    whilelt p0.b, x5, x1
    b.none  .Ltok_done
    ld1b    {z0.b}, p0/z, [x0, x5]       // t

    // class predicates (cmpeq imm is -16..15, so build t==31 from short/long)
    cmphs   p1.b, p0/z, z0.b, #32        // short = t >= 32
    cmplo   p2.b, p0/z, z0.b, #31        // long  = t < 31
    orr     p3.b, p0/z, p1.b, p2.b
    not     p3.b, p0/z, p3.b             // eq31  = active & !short & !long

    // token fields (immediate AND/ADD are destructive -> movprfx the source)
    movprfx z1, z0
    and     z1.b, z1.b, #7               // llf = t & 7
    lsr     z2.b, z0.b, #3
    and     z2.b, z2.b, #0x0f            // mlf = (t>>3) & 15
    movprfx z3, z0
    add     z3.b, z3.b, #16              // t + 16 (long matchlen base)
    movprfx z4, z0
    and     z4.b, z4.b, #0x80            // t & 0x80

    // flag predicates
    cmpeq   p4.b, p1/z, z1.b, #7         // varlitlen  : short & llf==7
    cmpeq   p5.b, p1/z, z2.b, #15        // short & mlf==15
    orr     p5.b, p0/z, p5.b, p3.b       // varmatchlen: that | (t==31)
    not     p6.b, p0/z, p1.b             // offset24   : active & !short
    cmpeq   p8.b, p0/z, z4.b, #0         // (t & 0x80) == 0
    and     p7.b, p0/z, p1.b, p8.b       // offset16   : short & high-bit clear

    // litlen_base = short ? (t&7) : 0
    sel     z5.b, p1, z1.b, z17.b
    // matchlen_base = short ? mlf : (long ? t+16 : 47)
    dup     z6.b, #47
    sel     z6.b, p2, z3.b, z6.b
    sel     z6.b, p1, z2.b, z6.b
    // flags = OR of the four masked bit values
    dup     z7.b, #0
    cpy     z16.b, p4/z, #0x02
    orr     z7.d, z7.d, z16.d
    cpy     z16.b, p5/z, #0x04
    orr     z7.d, z7.d, z16.d
    cpy     z16.b, p6/z, #0x08
    orr     z7.d, z7.d, z16.d
    cpy     z16.b, p7/z, #0x10
    orr     z7.d, z7.d, z16.d

    st1b    {z7.b}, p0, [x2, x5]         // flags
    st1b    {z5.b}, p0, [x3, x5]         // litlen_base
    st1b    {z6.b}, p0, [x4, x5]         // matchlen_base
    incb    x5
    b       .Ltok_loop
.Ltok_done:
    ret

.size iguana_sve2_decode_tokens, .-iguana_sve2_decode_tokens
.section .note.GNU-stack, "", %progbits

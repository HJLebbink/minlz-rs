// AArch64 SVE2 Iguana match finder — port of asm/match_avx512.asm (itself a port of
// Sneller's bestMatchAVX512). This is Stage 3 of SVE2-PORT-PLAN.md ("the warm-up"):
// ~90% scalar GPR work with three SIMD touch-points (the forward compare).
//
// AAPCS64: the sole argument (MatchArgs*) arrives in x0 — there is only one ABI on
// AArch64, so unlike the x86 kernels there is NO Win64/SysV entry shuffle. The body
// touches only caller-saved state (x0-x14, z0/z1, p0-p2), so it is a leaf function
// with no prologue/epilogue to save/restore.
//
// Differential-tested against matcher::best_match_scalar (the oracle), reusing the
// existing 20k-case fuzz + large-offset + edge-case suites.
//
// void iguana_sve2_best_match(MatchArgs* args /*x0*/)
//   struct MatchArgs {              // byte offsets must match matcher.rs #[repr(C)]
//       const u8* src_base;     //  0
//       usize     src_len;      //  8
//       usize     src_cap;      // 16  (unused; layout only)
//       i32       litmin;       // 24  minimum target pos for backward extension
//       i32       pos;          // 28  target position to match
//       const i32* hist;        // 32  -> [4]i32 candidate match positions
//       i32       ret_targetpos;// 40  (out)
//       i32       ret_matchpos; // 44  (out)
//       i32       ret_matchlen; // 48  (out)
//   }
//
// CALLER GUARANTEE: src_len - pos >= 32 and every hist[i] in 0..pos. Unlike the x86
// kernel (which over-reads 32 bytes at pos), the forward loop here is whilelt-bounded
// so every active byte-lane load stays strictly in [pos, src_len) — no over-read.
//
// Register map (all caller-saved): x0=args, x1=src_base, x2=max_ml(=src_len-pos),
//   w3=litmin, x4=hist cursor, x5=pos, w6=targetpos, w7=matchpos, w8=matchlen,
//   w9=candidate countdown, x10=ml, x11=src+pos, x12=src+matchpos, w13/w14=scratch.

.arch armv8-a+sve2

.text
.global iguana_sve2_best_match
.type iguana_sve2_best_match, %function
iguana_sve2_best_match:
    ldr     x1, [x0]                 // src_base
    ldr     x2, [x0, #8]             // src_len
    ldrsw   x5, [x0, #28]            // pos (>=0, so sign/zero extend equivalent)
    ldr     w3, [x0, #24]            // litmin
    ldr     x4, [x0, #32]            // hist ptr
    sub     x2, x2, x5               // max_ml = src_len - pos   (SUBQ BX,DX)
    cmp     x2, #32                  // CMPQ DX,$32
    b.lt    .Ltrap                   // JLT trap — caller guarantee broken
    str     wzr, [x0, #40]           // ret_targetpos = 0   (MOVL R9,ret+40(FP))
    str     wzr, [x0, #44]           // ret_matchpos  = 0
    str     wzr, [x0, #48]           // ret_matchlen  = 0
    add     x11, x1, x5              // x_t = src + pos (loop-invariant across cands)

    mov     w9, #4                   // count = histsize       (MOVL $4, CX)
    ldr     w7, [x4], #4             // matchpos = hist[0]; hist++  (MOVL 0(R8),R10; ADDQ $4,R8)

.Lrestart:                           // 1st iteration unconditional; later ones gated below
    mov     w6, w5                   // targetpos = pos        (MOVL pos,R9)
    mov     w8, #0                   // matchlen  = 0          (XORL R11,R11)
    add     x12, x1, w7, uxtw        // x_m = src + matchpos
    mov     x10, #0                  // ml = 0

    // --- forward: longest common prefix of src[pos..] and src[matchpos..], cap max_ml ---
.Lfwd:
    whilelt p0.b, x10, x2            // active lanes = min(VL, max_ml - ml)
    b.none  .Lfwd_done               // none active => ml == max_ml, fully matched
    ld1b    {z0.b}, p0/z, [x11, x10] // src[pos+ml ..]      (cached Y3 in the x86 kernel)
    ld1b    {z1.b}, p0/z, [x12, x10] // src[matchpos+ml ..]
    cmpne   p1.b, p0/z, z0.b, z1.b   // differing bytes      (VPXORD + VPTESTMB)
    b.any   .Lfwd_mismatch           // any mismatch in this block?  (KTESTD + JNZ)
    incp    x10, p0.b                // ml += active count (whole block matched)
    b       .Lfwd
.Lfwd_mismatch:
    brkb    p2.b, p0/z, p1.b         // lanes before the first mismatch  (= TZCNT index)
    incp    x10, p2.b                // ml += length of the matching prefix
.Lfwd_done:
    mov     w8, w10                  // matchlen = ml (ml < max_ml < 2^31)

    // --- backward extension (skip when matchpos == 0) ---
    cbz     w7, .Ltest_legal         // TESTL R10,R10 / JZ test_legal
.Lback:
    cmp     w6, w3                   // targetpos == litmin?   (CMPL R9,AX)
    b.eq    .Ltest_legal             // JEQ test_legal
    sub     w13, w6, #1
    ldrb    w13, [x1, w13, uxtw]     // src[targetpos-1]       (MOVBLZX -1(SI)(R9),R14)
    sub     w14, w7, #1
    ldrb    w14, [x1, w14, uxtw]     // src[matchpos-1]
    cmp     w13, w14                 // CMPB -1(SI)(R10),R14
    b.ne    .Ltest_legal             // JNE test_legal
    sub     w6, w6, #1               // targetpos--            (DECL R9)
    add     w8, w8, #1               // matchlen++             (INCL R11)
    subs    w7, w7, #1               // matchpos--             (DECL R10)
    b.ne    .Lback                   // JNZ continue_extending_backwards

.Ltest_legal:
    sub     w13, w6, w7              // offset = targetpos - matchpos  (SUBL R10,R14)
    lsr     w13, w13, #16            // SHRL $16,R14
    cbz     w13, .Ltest_better       // offset < 2^16 => legal  (JZ test_better)
    cmp     w8, #15                  // CMPL R11,$15
    b.le    .Lloop_tail              // big offset && len<=15 => illegal (JLE loop_tail)
.Ltest_better:
    ldr     w13, [x0, #48]           // current best matchlen  (CMPL R11,ret2+48(FP))
    cmp     w8, w13
    b.le    .Lloop_tail              // not strictly better => skip
    str     w6, [x0, #40]            // ret_targetpos = targetpos
    str     w7, [x0, #44]            // ret_matchpos  = matchpos
    str     w8, [x0, #48]            // ret_matchlen  = matchlen
.Lloop_tail:
    subs    w9, w9, #1               // DECL CX
    b.eq    .Ldone                   // JZ done
    ldr     w7, [x4], #4             // next matchpos; hist++  (MOVL 0(R8),R10; ADDQ $4,R8)
    cbnz    w7, .Lrestart            // TESTL R10,R10 / JNZ restart (stop at first empty slot)
.Ldone:
    ret

.Ltrap:
    brk     #0                       // BYTE $0xCC — should never run

.size iguana_sve2_best_match, .-iguana_sve2_best_match
.section .note.GNU-stack, "", %progbits

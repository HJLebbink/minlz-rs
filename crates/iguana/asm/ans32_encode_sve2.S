// AArch64 SVE2 Iguana 32-way interleaved rANS *encode* core — Stage 2 of
// SVE2-PORT-PLAN.md. Port of asm/ans32_encode_avx512.asm / the scalar oracle
// `ans32_compress`+`ans32_put` (lib.rs). Byte-identical output, differential-tested.
//
// u32 iguana_sve2_ans32_encode_core(Ans32EncoderC* enc /*x0*/)  -> always 0
//   struct (mirrors Go ANS32Encoder; offsets from lib.rs #[repr(C)]):
//     state[32]u32 @0 ; bufFwd slice @128{data,len,cap} ; bufRev slice @152 ;
//     src slice @176 ; stats *u32 @200 (the 256-entry (start<<12)|freq table)
//   The Rust wrapper pre-sizes bufFwd/bufRev to worst case, so the x86 kernel's
//   buffer-expand protocol can't fire — this kernel omits it (single call) and
//   always returns 0.
//
// DESIGN (mirrors the decode kernel's memory-backed VLA approach):
//   * The 32 states live in a stack array `st[]`; every pass is a `whilelt` loop
//     that runs at any VL.
//   * Per chunk the heavy arithmetic is vectorised: gather the table, compute
//     freq/start, the renorm test (state >= freq<<20), and the rANS state update
//     `((x/freq)<<12)+(x%freq)+start`. The integer divide has no SVE op, so it uses
//     the float trick: UUNPK→UCVTF→FDIV→FCVTZU with FPCR.RMode=RZ (set at entry,
//     restored at exit) so the truncation is an exact floor (see plan §Kernel-2).
//   * The renorm-WORD emission is scalar-walked because its order must match the
//     oracle byte-for-byte: within a chunk lanes 15..0 → bufFwd (big-endian u16),
//     lanes 31..16 → bufRev (little-endian u16); then a flush (fwd states 15..0
//     big-endian; rev states 16..31 little-endian). The wrapper reverses bufFwd.
//
// AAPCS64 base PCS. Saves x19-x28,x29,x30 (uses `bl` to the per-chunk routine) and
// avoids z8-z15 (their low 64 bits are callee-saved); FP scratch is z0-z7,z16-z19,
// z31; predicates p0-p2,p7. 240-byte frame: st@0(128) ew@128(64) rf@192(32)
// fpcr_orig@224.

.arch armv8-a+sve2

.text
.global iguana_sve2_ans32_encode_core
.type iguana_sve2_ans32_encode_core, %function
iguana_sve2_ans32_encode_core:
    stp     x29, x30, [sp, #-16]!
    stp     x27, x28, [sp, #-16]!
    stp     x25, x26, [sp, #-16]!
    stp     x23, x24, [sp, #-16]!
    stp     x21, x22, [sp, #-16]!
    stp     x19, x20, [sp, #-16]!
    sub     sp, sp, #240

    mov     x19, x0                      // enc
    // FPCR -> round-toward-zero (so FDIV+FCVTZU = exact floor); save original
    mrs     x9, fpcr
    str     x9, [sp, #224]
    mov     x10, #0xc00000               // RMode = 0b11 (RZ) at bits [23:22]
    orr     x9, x9, x10
    msr     fpcr, x9

    ldr     x20, [x19, #176]             // src.data
    ldr     x9,  [x19, #184]             // src.len
    ldr     x21, [x19, #200]             // stats (table)
    ldr     x25, [x19, #128]             // bufFwd.data -> fwd cursor
    ldr     x26, [x19, #152]             // bufRev.data -> rev cursor
    mov     x22, sp                      // st_ptr
    add     x23, sp, #128                // ew_ptr  (u16[32])
    add     x24, sp, #192                // rf_ptr  (u8[32])
    mov     x28, #32                     // (whilelt bound for full chunks)

    mov     w11, #0xfff
    dup     z31.s, w11                   // M-1 = 0x0fff
    mov     z7.s, #1                     // renorm-flag value
    ptrue   p7.d                         // all-lanes predicate for the FP divide

    // init st[0..32] <- enc.state[0..32]  (128 bytes)
    mov     x10, #0
    mov     x11, #128
.Linit:
    whilelt p0.b, x10, x11
    b.none  .Linit_done
    ld1b    {z0.b}, p0/z, [x19, x10]
    st1b    {z0.b}, p0, [x22, x10]
    incb    x10
    b       .Linit
.Linit_done:

    // last = src.len % 32 ; k0 = src.len - last
    and     x10, x9, #31                 // last
    sub     x27, x9, x10                 // k = k0 (loop cursor)
    // process the partial (last) chunk first
    add     x0, x20, x27                 // chunk_ptr = src + k0
    mov     x1, x10                      // avail = last
    bl      .Lchunk
    // then full chunks back-to-front
    subs    x27, x27, #32
    b.lt    .Lflush
.Lfull:
    add     x0, x20, x27                 // chunk_ptr = src + k
    mov     x1, x28                      // avail = 32
    bl      .Lchunk
    subs    x27, x27, #32
    b.ge    .Lfull

.Lflush:
    // forward flush: lanes 15..0, state big-endian (4 bytes)
    mov     x10, #15
.Lflush_f:
    ldr     w11, [x22, x10, lsl #2]
    rev     w11, w11
    str     w11, [x25]
    add     x25, x25, #4
    subs    x10, x10, #1
    b.ge    .Lflush_f
    // reverse flush: lanes 16..31 (ascending), state little-endian (4 bytes)
    mov     x10, #16
.Lflush_r:
    ldr     w11, [x22, x10, lsl #2]
    str     w11, [x26]
    add     x26, x26, #4
    add     x10, x10, #1
    cmp     x10, #32
    b.lt    .Lflush_r

    // bufFwd.len = fwd_cursor - bufFwd.data ; bufRev.len likewise
    ldr     x10, [x19, #128]
    sub     x10, x25, x10
    str     x10, [x19, #136]
    ldr     x10, [x19, #152]
    sub     x10, x26, x10
    str     x10, [x19, #160]

    mov     w0, #0                       // return 0 (no buffer expansion)
    ldr     x9, [sp, #224]               // restore FPCR
    msr     fpcr, x9
    add     sp, sp, #240
    ldp     x19, x20, [sp], #16
    ldp     x21, x22, [sp], #16
    ldp     x23, x24, [sp], #16
    ldp     x25, x26, [sp], #16
    ldp     x27, x28, [sp], #16
    ldp     x29, x30, [sp], #16
    ret

// ---------------------------------------------------------------------------
// .Lchunk(x0 = chunk_ptr, x1 = avail) — encode one <=32-symbol chunk.
// Vectorised arithmetic + scalar word emission. Clobbers x10-x12, z0-z5,z16-z19,
// p0-p2; advances x25 (fwd) / x26 (rev); uses x21/x22/x23/x24 + z7/z31/p7.
// ---------------------------------------------------------------------------
.Lchunk:
    stp     xzr, xzr, [x24]              // clear rf[0..32] (inactive lanes => 0)
    stp     xzr, xzr, [x24, #16]
    mov     x10, #0                      // li
.Lchunk_loop:
    whilelt p1.s, x10, x1                // active lanes = li < avail
    b.none  .Lchunk_emit
    ld1w    {z0.s}, p1/z, [x22, x10, lsl #2]    // x = state
    ld1b    {z1.s}, p1/z, [x0, x10]             // sym = chunk[lane]
    ld1w    {z2.s}, p1/z, [x21, z1.s, uxtw #2]  // q = table[sym]
    and     z3.d, z2.d, z31.d                   // freq = q & (M-1)
    lsr     z4.s, z2.s, #12
    and     z4.d, z4.d, z31.d                   // start = (q>>12) & (M-1)
    lsl     z5.s, z3.s, #20                      // thresh = freq << 20
    cmphs   p2.s, p1/z, z0.s, z5.s             // renorm = (x >= thresh)
    st1h    {z0.s}, p2, [x23, x10, lsl #1]     // ew[lane] = x & 0xffff (renorm)
    st1b    {z7.s}, p2, [x24, x10]             // rf[lane] = 1 (renorm)
    lsr     z0.s, p2/m, z0.s, #16              // x >>= 16 on renorm lanes
    // q_div = floor(x / freq) via f64 (FPCR = RZ)
    uunpklo z16.d, z0.s
    uunpkhi z17.d, z0.s
    uunpklo z18.d, z3.s
    uunpkhi z19.d, z3.s
    ucvtf   z16.d, p7/m, z16.d
    ucvtf   z17.d, p7/m, z17.d
    ucvtf   z18.d, p7/m, z18.d
    ucvtf   z19.d, p7/m, z19.d
    fdiv    z16.d, p7/m, z16.d, z18.d
    fdiv    z17.d, p7/m, z17.d, z19.d
    fcvtzu  z16.d, p7/m, z16.d
    fcvtzu  z17.d, p7/m, z17.d
    uzp1    z16.s, z16.s, z17.s                // q_div (svcntw u32)
    mul     z17.s, z16.s, z3.s                  // q*freq
    sub     z17.s, z0.s, z17.s                   // rem = x - q*freq
    lsl     z16.s, z16.s, #12                    // q << 12
    add     z16.s, z16.s, z17.s                  // + rem
    add     z16.s, z16.s, z4.s                   // + start
    st1w    {z16.s}, p1, [x22, x10, lsl #2]     // new state
    incw    x10
    b       .Lchunk_loop

.Lchunk_emit:
    // forward words: lanes 15..0 -> bufFwd, big-endian u16
    mov     x10, #15
.Lemit_f:
    ldrb    w11, [x24, x10]
    cbz     w11, .Lemit_f_n
    ldrh    w12, [x23, x10, lsl #1]
    rev16   w12, w12
    strh    w12, [x25]
    add     x25, x25, #2
.Lemit_f_n:
    subs    x10, x10, #1
    b.ge    .Lemit_f
    // reverse words: lanes 31..16 -> bufRev, little-endian u16
    mov     x10, #31
.Lemit_r:
    cmp     x10, #16
    b.lt    .Lchunk_ret
    ldrb    w11, [x24, x10]
    cbz     w11, .Lemit_r_n
    ldrh    w12, [x23, x10, lsl #1]
    strh    w12, [x26]
    add     x26, x26, #2
.Lemit_r_n:
    sub     x10, x10, #1
    b       .Lemit_r
.Lchunk_ret:
    ret

.size iguana_sve2_ans32_encode_core, .-iguana_sve2_ans32_encode_core
.section .note.GNU-stack, "", %progbits

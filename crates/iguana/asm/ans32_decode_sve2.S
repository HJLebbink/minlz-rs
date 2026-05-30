// AArch64 SVE2 Iguana 32-way interleaved rANS decode — Stage 1 of
// SVE2-PORT-PLAN.md, THE GATE. Port of asm/ans32_decode_avx512.asm / the scalar oracle
// `ans32_decode` (lib.rs). Differential-tested byte-for-byte against it.
//
// void iguana_sve2_ans32_decode(const Ans32Args* args /*x0*/)
//   struct Ans32Args { u8* dst@0; usize dst_len@8; const u8* src@16;
//                      usize src_len@24; const u32* tab@32; }
//
// 32 rANS states: lanes 0-15 "forward" (renorm reads u16 ascending from src+64),
// lanes 16-31 "reverse" (renorm reads u16 descending from src+src_len-64). `tab`
// is the 4096-entry dense table: tab[slot] = (symbol<<24)|(bias<<12)|freq.
//
// DESIGN (see plan §"Kernel 1"):
//   * The 32 states live in a 128-byte stack array `st[]`, so the kernel is fully
//     vector-length-agnostic: every pass is a `whilelt`-driven loop that works at
//     any VL (4 u32-lanes/vector on the GB10's VL=128, more on wider cores).
//   * `vpmovdb`+store of the symbol byte is the fused `ST1B {z.s}` (low byte of
//     each 32-bit lane, contiguous).
//   * The renorm AVOIDS the missing `vpexpandd`: instead of "load 16 contiguous
//     words then expand to the active lanes", each active lane GATHERS its word by
//     its prefix-rank — `LD1H {z.s}, p_act/z, [cursor, z_rank.s, UXTW #1]` — which
//     distributes the contiguous words to the right lanes implicitly. The small
//     prefix-rank (<=16 lanes) is computed in scalar (negligible vs the gather).
//
// AAPCS64 base PCS, leaf (no calls). Saves x19-x24 (callee-saved GPRs it uses);
// touches only z0-z7 + z29/z30 and p0-p3 (all caller-saved under the base PCS —
// deliberately avoids z8-z15 whose low 64 bits are callee-saved). 192-byte frame:
// st[]@sp, idx[]@sp+128.

.arch armv8-a+sve2

.text
.global iguana_sve2_ans32_decode
.type iguana_sve2_ans32_decode, %function
iguana_sve2_ans32_decode:
    stp     x19, x20, [sp, #-16]!
    stp     x21, x22, [sp, #-16]!
    stp     x23, x24, [sp, #-16]!
    sub     sp, sp, #192                 // st[0..32]@sp (128B), idx[0..16]@sp+128 (64B)

    ldr     x1,  [x0, #0]                // dst (advances)
    ldr     x3,  [x0, #8]               // remaining = dst_len
    ldr     x19, [x0, #16]              // src (stream base)
    ldr     x14, [x0, #24]              // src_len
    ldr     x20, [x0, #32]              // tab
    mov     x21, sp                     // st_ptr
    add     x22, sp, #128               // idx_ptr

    // broadcast constants
    mov     w8, #0x10000
    dup     z29.s, w8                    // L = 0x10000
    mov     w9, #0xfff
    dup     z30.s, w9                    // M-1 = 0x0fff

    // cursors and reverse-state source base
    add     x23, x19, #64                // cursor_fwd = src + 64
    add     x24, x19, x14
    sub     x24, x24, #64                // cursor_rev = src + src_len - 64

    // initial states: st[0..16] <- src[0..64], st[16..32] <- src[len-64..len]
    mov     w13, #64                     // whilelt needs a register bound (not imm)
    mov     x10, #0
.Lcpf:
    whilelt p0.b, x10, x13
    b.none  .Lcpf_done
    ld1b    {z0.b}, p0/z, [x19, x10]
    st1b    {z0.b}, p0, [x21, x10]
    incb    x10
    b       .Lcpf
.Lcpf_done:
    add     x16, x21, #64                // &st[16]
    mov     x10, #0                      // (w13 still = 64)
.Lcpr:
    whilelt p0.b, x10, x13
    b.none  .Lcpr_done
    ld1b    {z0.b}, p0/z, [x24, x10]     // src[len-64 .. len]
    st1b    {z0.b}, p0, [x16, x10]
    incb    x10
    b       .Lcpr
.Lcpr_done:

.Lround:
    cmp     x3, #32
    b.lt    .Ltail

    // ---- DECODE 32 symbols (lanes 0..32) ----
    mov     x9, #32
    mov     x10, #0
.Ldecf:
    whilelt p0.s, x10, x9
    b.none  .Ldecf_done
    ld1w    {z0.s}, p0/z, [x21, x10, lsl #2]     // state
    and     z1.d, z0.d, z30.d                    // slot = state & (M-1)
    ld1w    {z2.s}, p0/z, [x20, z1.s, uxtw #2]   // t = tab[slot] (gather)
    lsr     z0.s, z0.s, #12                       // x >> M_BITS
    and     z3.d, z2.d, z30.d                     // freq = t & (M-1)
    mul     z0.s, z0.s, z3.s                      // (x>>12) * freq
    lsr     z3.s, z2.s, #12
    and     z3.d, z3.d, z30.d                     // bias = (t>>12) & (M-1)
    add     z0.s, z0.s, z3.s                      // new state
    st1w    {z0.s}, p0, [x21, x10, lsl #2]
    lsr     z2.s, z2.s, #24                        // symbol (low byte of lane)
    st1b    {z2.s}, p0, [x1, x10]                 // dst[li] = symbol (fused narrow)
    incw    x10
    b       .Ldecf
.Ldecf_done:
    add     x1, x1, #32                  // dst += 32
    subs    x3, x3, #32                  // remaining -= 32
    b.eq    .Ldone                       // produced exactly dst_len: no renorm

    // ---- forward renorm (lanes 0..16): gather-by-rank ----
    // scalar prefix-rank: idx[i] = #active before i; k = #active; cursor_fwd += 2k
    mov     x11, #0                      // k
    mov     x12, #0                      // i
.Lfrank:
    ldr     w13, [x21, x12, lsl #2]      // st[i]
    str     w11, [x22, x12, lsl #2]      // idx[i] = k (exclusive rank)
    cmp     w13, #0x10000                // st[i] < L ?  (L = 16 << 12)
    cinc    x11, x11, lo                 // k += (st[i] < L)
    add     x12, x12, #1
    cmp     x12, #16
    b.lt    .Lfrank
    mov     w13, #16                     // register bound for whilelt
    mov     x10, #0
.Lfmerge:
    whilelt p0.s, x10, x13
    b.none  .Lfmerge_done
    ld1w    {z0.s}, p0/z, [x21, x10, lsl #2]
    cmplo   p1.s, p0/z, z0.s, z29.s              // active = state < L
    ld1w    {z1.s}, p0/z, [x22, x10, lsl #2]     // idx (rank)
    ld1h    {z2.s}, p1/z, [x23, z1.s, uxtw #1]   // word = u16[cursor_fwd + 2*rank]
    lsl     z3.s, z0.s, #16
    orr     z3.d, z3.d, z2.d                      // (state<<16) | word
    mov     z0.s, p1/m, z3.s                      // merge active lanes
    st1w    {z0.s}, p0, [x21, x10, lsl #2]
    incw    x10
    b       .Lfmerge
.Lfmerge_done:
    add     x23, x23, x11, lsl #1        // cursor_fwd += 2k

    // ---- reverse renorm (lanes 16..32): descending gather-by-rank ----
    add     x17, x21, #64                // &st[16]
    mov     x11, #0                      // k
    mov     x12, #0                      // i
.Lrrank:
    ldr     w13, [x17, x12, lsl #2]      // st[16+i]
    neg     w14, w11                     // -k
    str     w14, [x22, x12, lsl #2]      // idx[i] = -rank
    cmp     w13, #0x10000
    cinc    x11, x11, lo
    add     x12, x12, #1
    cmp     x12, #16
    b.lt    .Lrrank
    sub     x15, x24, #2                 // base_rev = cursor_rev - 2
    mov     w13, #16                     // register bound for whilelt
    mov     x10, #0
.Lrmerge:
    whilelt p0.s, x10, x13
    b.none  .Lrmerge_done
    ld1w    {z0.s}, p0/z, [x17, x10, lsl #2]
    cmplo   p1.s, p0/z, z0.s, z29.s
    ld1w    {z1.s}, p0/z, [x22, x10, lsl #2]     // idx (-rank)
    ld1h    {z2.s}, p1/z, [x15, z1.s, sxtw #1]   // word = u16[cursor_rev-2 - 2*rank]
    lsl     z3.s, z0.s, #16
    orr     z3.d, z3.d, z2.d
    mov     z0.s, p1/m, z3.s
    st1w    {z0.s}, p0, [x17, x10, lsl #2]
    incw    x10
    b       .Lrmerge
.Lrmerge_done:
    sub     x24, x24, x11, lsl #1        // cursor_rev -= 2k
    b       .Lround

.Ltail:
    cbz     x3, .Ldone
    // ---- DECODE `remaining` symbols (lanes 0..remaining), no renorm ----
    mov     x9, x3
    mov     x10, #0
.Ldect:
    whilelt p0.s, x10, x9
    b.none  .Ldone
    ld1w    {z0.s}, p0/z, [x21, x10, lsl #2]
    and     z1.d, z0.d, z30.d
    ld1w    {z2.s}, p0/z, [x20, z1.s, uxtw #2]
    lsr     z0.s, z0.s, #12
    and     z3.d, z2.d, z30.d
    mul     z0.s, z0.s, z3.s
    lsr     z3.s, z2.s, #12
    and     z3.d, z3.d, z30.d
    add     z0.s, z0.s, z3.s
    st1w    {z0.s}, p0, [x21, x10, lsl #2]
    lsr     z2.s, z2.s, #24
    st1b    {z2.s}, p0, [x1, x10]
    incw    x10
    b       .Ldect

.Ldone:
    add     sp, sp, #192
    ldp     x23, x24, [sp], #16
    ldp     x21, x22, [sp], #16
    ldp     x19, x20, [sp], #16
    ret

.size iguana_sve2_ans32_decode, .-iguana_sve2_ans32_decode
.section .note.GNU-stack, "", %progbits

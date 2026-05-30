// AArch64 SVE2 Iguana Lizard structural decompressor — Stage 4 of
// SVE2-PORT-PLAN.md. **VLA re-derivation** of the scalar oracle
// `decompress_block` (src/structural.rs), NOT a transliteration of the AVX-512
// kernel: the x86 routine's speed comes from a 512-bit = 16-dword batched
// structure (64-token decode, 16-wide arming, `valignd` queues, `pext`/`pdep`
// wide-varint) that has no analog on SVE's vector-length-agnostic model. Here the
// per-token control flow is scalar integer code (the decode is inherently serial —
// each token's match reads bytes the previous tokens produced), and SVE2 carries
// the two bulk data movements: the literal copy and the overlapped match copy,
// both as `whilelt`-driven VLA loops that widen automatically with VL (4 lanes on
// the GB10's VL=128, 8 on a VL=256 Graviton 3).
//
// This is **Stage A: correctness-first**. It is differential-tested byte-for-byte
// against `decompress_block` (tests/sve2_decompress_diff.rs). At VL=128 it is
// expected to roughly match the auto-NEON scalar (no width edge — see the port
// plan). The wide-VL speed lever (batched token-field pre-decode, reusing the
// validated `iguana_sve2_decode_tokens`) is Stage B, layered on top later.
//
// void iguana_sve2_decompress(IguanaArgs* args /*x0*/)
//   struct IguanaArgs {            // mirrors the AVX-512 kernel's ABI exactly
//       u8*   dst_base;   //  0
//       usize dst_len;    //  8   (start offset; append here)
//       usize dst_cap;    // 16
//       void* streams;    // 24   -> [6]StreamHdr{ data@0; len@8; cap@16; cursor@24 }
//       i64*  last_offs;  // 32   (in/out; init 0)
//       u8*   ret_base;   // 40   (out)
//       usize ret_len;    // 48   (out, total bytes from dst_base)
//       usize ret_cap;    // 56   (out)
//       i32   ret_ec;     // 64   (out; 0 = ok, 1 = corrupt/out-of-input)
//   }
//
// strids: Tokens=0 Off16=1 Off24=2 VarLitLen=3 VarMatchLen=4 Literals=5 (*32).
// All stream reads are predicated/bounds-checked, so unlike the AVX-512 kernel
// this needs NO input tail slack and does NO output over-write.
//
// AAPCS64 base PCS. Saves x19-x28 (callee-saved GPRs it uses); a 64-byte frame
// holds the four "cold" stream cursors (Off16/Off24/VarLitLen/VarMatchLen) as
// {cur,end} pairs. Touches only z0/p0 (caller-saved). Leaf, no calls.

.arch armv8-a+sve2

// --- frame layout (sp-relative, after the 64-byte sub) -------------------
//   [sp+ 0] off16_cur     [sp+ 8] off16_end
//   [sp+16] off24_cur     [sp+24] off24_end
//   [sp+32] varlit_cur    [sp+40] varlit_end
//   [sp+48] varmatch_cur  [sp+56] varmatch_end
.equ SLOT_OFF16,    0
.equ SLOT_OFF24,    16
.equ SLOT_VARLIT,   32
.equ SLOT_VARMATCH, 48

// FETCH_VARUINT slot -> result in x15 (base-254 varint; port of fetchVarUInt).
// Clobbers x9-x14. Branches to .Lerror on overrun.
.macro FETCH_VARUINT slot
    ldp     x9, x10, [sp, #\slot]       // cur, end
    cmp     x9, x10
    b.hs    .Lerror
    ldrb    w11, [x9], #1               // a
    cmp     w11, #0xfe
    b.lo    .Lvu_store\@                // a < 0xfe -> result = a
    b.hi    .Lvu_three\@               // a > 0xfe -> 3-byte form
    // a == 0xfe: two-byte form, value bytes lo,hi -> hi*254 + lo
    add     x12, x9, #2
    cmp     x12, x10
    b.hi    .Lerror
    ldrb    w13, [x9], #1              // lo
    ldrb    w11, [x9], #1              // hi
    mov     w12, #254
    madd    w11, w11, w12, w13         // hi*254 + lo
    b       .Lvu_store\@
.Lvu_three\@:
    add     x12, x9, #3
    cmp     x12, x10
    b.hi    .Lerror
    ldrb    w13, [x9], #1              // a0 (lo)
    ldrb    w12, [x9], #1              // a1 (mid)
    ldrb    w11, [x9], #1             // a2 (hi)
    mov     w14, #254
    madd    w11, w11, w14, w12         // a2*254 + a1
    madd    w11, w11, w14, w13         // *254 + a0
.Lvu_store\@:
    mov     x15, x11
    str     x9, [sp, #\slot]           // commit cursor
.endm

// COPY_LITERALS: copy x1 bytes from x26 (lit_cur) to x21 (dst_cur), advancing
// both. Bounds-checked against x27 (lit_end) and x22 (dst_cap_end). VLA.
// Clobbers x9, z0, p0. Assumes x1 > 0.
.macro COPY_LITERALS
    add     x9, x26, x1
    cmp     x9, x27
    b.hi    .Lerror                    // literals underflow
    add     x9, x21, x1
    cmp     x9, x22
    b.hi    .Lerror                    // dst overflow
    mov     x9, #0
.Lcl\@:
    whilelt p0.b, x9, x1
    b.none  .Lcl_done\@
    ld1b    {z0.b}, p0/z, [x26, x9]
    st1b    {z0.b}, p0, [x21, x9]
    incb    x9
    b       .Lcl\@
.Lcl_done\@:
    add     x26, x26, x1
    add     x21, x21, x1
.endm

.text
.global iguana_sve2_decompress
.type iguana_sve2_decompress, %function
iguana_sve2_decompress:
    stp     x19, x20, [sp, #-16]!
    stp     x21, x22, [sp, #-16]!
    stp     x23, x24, [sp, #-16]!
    stp     x25, x26, [sp, #-16]!
    stp     x27, x28, [sp, #-16]!
    sub     sp, sp, #64

    mov     x19, x0                    // args
    ldr     x20, [x19, #0]             // dst_base
    ldr     x9,  [x19, #8]            // dst_len (start)
    ldr     x10, [x19, #16]           // dst_cap
    add     x21, x20, x9              // dst_cur = dst_base + dst_len
    add     x22, x20, x10             // dst_cap_end
    ldr     x11, [x19, #32]           // last_offs ptr
    ldr     x23, [x11]                // last_offs (init 0)
    ldr     x28, [x19, #24]           // streams base

    ldr     x24, [x28, #0]            // tokens.data  -> tok_cur
    ldr     x9,  [x28, #8]           // tokens.len
    add     x25, x24, x9             // tok_end
    ldr     x26, [x28, #160]         // literals.data -> lit_cur
    ldr     x9,  [x28, #168]         // literals.len
    add     x27, x26, x9            // lit_end

    // cold streams: store {cur, end} for Off16/Off24/VarLitLen/VarMatchLen
    ldr     x9,  [x28, #32];  ldr x10, [x28, #40];  add x10, x9, x10
    stp     x9, x10, [sp, #SLOT_OFF16]
    ldr     x9,  [x28, #64];  ldr x10, [x28, #72];  add x10, x9, x10
    stp     x9, x10, [sp, #SLOT_OFF24]
    ldr     x9,  [x28, #96];  ldr x10, [x28, #104]; add x10, x9, x10
    stp     x9, x10, [sp, #SLOT_VARLIT]
    ldr     x9,  [x28, #128]; ldr x10, [x28, #136]; add x10, x9, x10
    stp     x9, x10, [sp, #SLOT_VARMATCH]

.Lloop:
    cmp     x24, x25
    b.hs    .Ltail                     // tokens exhausted
    ldrb    w0, [x24], #1              // token = fetch8
    cmp     w0, #32
    b.lo    .Llong                     // token < 32 -> long form

    // ---- short token  [X_MMMM_LLL] : literal run + match ----
    and     x1, x0, #7                 // lit_len = token & 7
    cmp     x1, #7
    b.ne    .Lhave_ll
    FETCH_VARUINT SLOT_VARLIT          // -> x15
    add     x1, x15, #7                // lit_len = varuint + 7
.Lhave_ll:
    cbz     x1, .Lno_lits
    COPY_LITERALS
.Lno_lits:
    tbnz    w0, #7, .Lreuse_off        // bit7 set -> reuse last offset
    // new_offs = fetch16(off16); last_offs = -new_offs
    ldp     x9, x10, [sp, #SLOT_OFF16]
    add     x11, x9, #2
    cmp     x11, x10
    b.hi    .Lerror
    ldrb    w12, [x9], #1
    ldrb    w13, [x9], #1
    orr     w12, w12, w13, lsl #8      // u16 little-endian
    neg     x23, x12                   // last_offs = -new_offs
    str     x9, [sp, #SLOT_OFF16]
.Lreuse_off:
    lsr     x3, x0, #3
    and     x3, x3, #15                // ml = (token>>3) & 15
    cmp     x3, #15
    b.ne    .Lhave_ml
    FETCH_VARUINT SLOT_VARMATCH        // -> x15
    add     x3, x15, #15               // ml = varuint + 15
.Lhave_ml:
    mov     x4, x3                     // match_len
    b       .Lcopy_match

.Llong:
    cmp     w0, #31
    b.hs    .Leq31                     // token == 31
    // token < 31: 24-bit offset, match_len = token + 16
    add     x4, x0, #16
    b       .Lfetch24
.Leq31:
    // token == 31: 24-bit offset, extended match_len = varuint + 47
    FETCH_VARUINT SLOT_VARMATCH        // -> x15
    add     x4, x15, #47
.Lfetch24:
    // x = fetch24(off24); last_offs = -x
    ldp     x9, x10, [sp, #SLOT_OFF24]
    add     x11, x9, #3
    cmp     x11, x10
    b.hi    .Lerror
    ldrb    w12, [x9], #1
    ldrb    w13, [x9], #1
    ldrb    w14, [x9], #1
    orr     w12, w12, w13, lsl #8
    orr     w12, w12, w14, lsl #16     // u24 little-endian
    neg     x23, x12                   // last_offs = -x
    str     x9, [sp, #SLOT_OFF24]
    // fall through to .Lcopy_match

.Lcopy_match:
    // wild_copy: src = dst_cur + last_offs (last_offs <= 0); len = x4.
    // Validate src in [dst_base, dst_cur] (i.e. match_pos in [0, dst.len()]).
    add     x5, x21, x23               // src
    cmp     x5, x20
    b.lo    .Lerror
    cmp     x5, x21
    b.hi    .Lerror
    sub     x6, x21, x5                // offset (>= 0)
    cbz     x4, .Lloop                 // zero-length match: src validated, done
.Lwc_outer:
    cmp     x6, x4
    csel    x7, x6, x4, lo             // chunk = min(offset, remaining)
    cbz     x7, .Lerror                // offset 0 with remaining > 0 -> corrupt
    add     x9, x21, x7
    cmp     x9, x22
    b.hi    .Lerror                    // dst overflow
    mov     x9, #0
.Lwc_in:
    whilelt p0.b, x9, x7
    b.none  .Lwc_in_done
    ld1b    {z0.b}, p0/z, [x5, x9]     // read region [src, src+chunk) precedes dst_cur
    st1b    {z0.b}, p0, [x21, x9]
    incb    x9
    b       .Lwc_in
.Lwc_in_done:
    add     x5, x5, x7
    add     x21, x21, x7
    subs    x4, x4, x7
    b.ne    .Lwc_outer
    b       .Lloop

.Ltail:
    // append trailing literals: rem = lit_end - lit_cur
    sub     x1, x27, x26
    cbz     x1, .Lfinish
    COPY_LITERALS
.Lfinish:
    ldr     x11, [x19, #32]
    str     x23, [x11]                 // commit last_offs
    str     x20, [x19, #40]            // ret_base = dst_base
    sub     x9, x21, x20
    str     x9, [x19, #48]             // ret_len = dst_cur - dst_base
    ldr     x9, [x19, #16]
    str     x9, [x19, #56]             // ret_cap = dst_cap
    str     wzr, [x19, #64]            // ret_ec = 0
    b       .Lepilogue
.Lerror:
    mov     w9, #1
    str     w9, [x19, #64]             // ret_ec = 1
.Lepilogue:
    add     sp, sp, #64
    ldp     x27, x28, [sp], #16
    ldp     x25, x26, [sp], #16
    ldp     x23, x24, [sp], #16
    ldp     x21, x22, [sp], #16
    ldp     x19, x20, [sp], #16
    ret

.size iguana_sve2_decompress, .-iguana_sve2_decompress
.section .note.GNU-stack, "", %progbits

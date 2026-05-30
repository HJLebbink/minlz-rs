; AVX-512 (VBMI2) Iguana Lizard structural decompressor, Win64 + SysV/Linux ABI.
;
; Line-by-line port of Sneller's Go Plan9 routine
; `decompressIguanaAVX512VBMI2` in
;   c:\source\sneller\sneller\ion\zion\iguana\decompress_iguana_amd64.s
; Each NASM instruction is annotated with the original Plan9 source on the
; right.  Plan9 -> NASM(Intel) rules applied uniformly:
;   * operand list is REVERSED (Plan9 dst is last; NASM dst is first),
;   * `.Z` + Kn  ->  {kn}{z} attached to the destination,
;   * VPCMP/VPTERNLOG/VALIGN immediates kept verbatim,
;   * Go-ABI FP-relative args/returns -> fields of a C args struct (see below),
;   * Go struct-offset loads -> explicit byte offsets (stream__size=32,
;     SliceHeader.Data=+0, .Len=+8; strids Tokens=0 Off16=1 Off24=2
;     VarLitLen=3 VarMatchLen=4 Literals=5 -> *32),
;   * the `copySingleLongLiteral` helper is inlined into COPY_SINGLE_ITEM via
;     NASM %%-local labels (CALL removed; placement is icache-only).
;
; void iguana_avx512_decompress_vbmi2(Args* args /*rcx*/)
;   struct Args {            // mirrors the Go stack frame so [rbp+N] == [FP+N]
;       u8*   dst_base;   //  0
;       usize dst_len;    //  8
;       usize dst_cap;    // 16
;       void* streams;    // 24  -> [6]stream, stream{ data[]byte; cursor int }
;       i64*  last_offs;  // 32
;       u8*   ret_base;   // 40  (out)
;       usize ret_len;    // 48  (out)
;       usize ret_cap;    // 56  (out)
;       i32   ret_ec;     // 64  (out)
;   }
;
; SAFETY (caller's responsibility): the kernel does unmasked 64-byte loads from
; the head of every stream and a 32-byte over-copy past matches/literals, so
; each input stream needs >=64 bytes of readable tail slack and `dst` needs
; >=32 bytes of writable slack past dst_cap.  The Rust wrapper pads accordingly.
;
; ===========================================================================
; ABI AUDIT SURFACE.  The instruction bodies are a verbatim 1:1 transcription of
; the (flawless) Plan9 source; ONLY the lines tagged `ABI:` below differ from it
; and are the audit surface.  They fall into these classes:
;   (P) Win64 prologue/epilogue: save/restore RBX,RBP,RSI,RDI,R12-R15 and
;       XMM6-XMM15 (the Win64 non-volatile set the body clobbers).  Plan9 had
;       none of this (Go ABI / NOFRAME).
;   (A) `mov rbp, rcx`: stash the args pointer; rbp then stands in for Go's FP.
;   (F) every `[rbp+N]`  == Go `<field>+N(FP)`  (arg/return slot; FP->rbp).
;   (S) every `[rbx+N]`  == Go streamPack field offset (stream__size=32,
;       Data=+0, Len=+8; strid*32): +0/+8 Tokens, +32 Off16, +64 Off24,
;       +96 VarLitLen, +128 VarMatchLen, +160/+168 Literals.
;   (D) `cld` before `rep movsb`: Win64 requires DF=0 (the body never sets it,
;       so this is belt-and-suspenders).
;   (R) `jmp .epilogue` replaces Plan9 `RET` so the epilogue can restore regs.
; Grep `ABI:` to review them all; everything else is the original instruction.
; ===========================================================================

bits 64
default rel

%define VPCMP_IMM_EQ 0
%define VPCMP_IMM_LE 2
%define const_ecOK   0

; ---------------------------------------------------------------------------
; COPY_SINGLE_ITEM(slot_id) — emit one literal-run + match for opcode `slot`.
; Faithful port of the Go COPY_SINGLE_ITEM macro (with the long-literal helper
; inlined).  Uses ymm2 (32-byte copies), rax/rbx/rcx scratch, r9=lastOffs.
; ---------------------------------------------------------------------------
%macro COPY_SINGLE_ITEM 1
    ; cycle 0
    vmovdqu8     ymm2, [rsi]              ; VMOVDQU8 (SI), Y2      ; first 32 literal bytes
    vpextrd      eax, xmm15, %1           ; VPEXTRD $slot, X15, AX ; AX := token.offset
    ; cycle 1
    vmovdqu8     [rdi], ymm2              ; VMOVDQU8 Y2, (DI)      ; store 32 literal bytes
    vpextrd      ebx, xmm16, %1           ; VPEXTRD $slot, X16, BX ; BX := token.litlen
    neg          rax                      ; NEGQ AX               ; AX := -offset
    ; cycle 2
    cmovne       r9, rax                  ; CMOVQNE AX, R9        ; lastOffs := -offset if offset!=0
    add          rdi, rbx                 ; ADDQ BX, DI           ; advance dst (optimistic)
    add          rsi, rbx                 ; ADDQ BX, SI           ; advance literals (optimistic)
    cmp          ebx, 32                  ; CMPL BX, $short_literal_stride
    ja           %%litcpy                 ; JA lbl_litcpy         ; long-literal case
%%litcpy_completed:
    ; cycle 3
    mov          rbx, -32                 ; MOVQ $-32, BX
    vpextrd      ecx, xmm17, %1           ; VPEXTRD $slot, X17, CX ; CX := token.matchlen
    cmp          r9, rbx                  ; CMPQ R9, BX
    cmovg        rbx, r9                  ; CMOVQGT R9, BX        ; BX := max(-32, offs)
    ; cycle 4
%%match_loop:
    vmovdqu8     ymm2, [rdi+r9*1]         ; VMOVDQU8 (DI)(R9*1), Y2 ; 32 bytes of match
    vmovdqu8     [rdi], ymm2              ; VMOVDQU8 Y2, (DI)
    sub          rdi, rbx                 ; SUBQ BX, DI           ; dst += min(offset,32)
    add          rcx, rbx                 ; ADDQ BX, CX           ; matchlen -= min(offset,32)
    jg           %%match_loop             ; JG lbl_match_loop
    add          rdi, rcx                 ; ADDQ CX, DI           ; re-adjust (matchlen negative)
    jmp          %%item_done
%%litcpy:                                 ; inlined copySingleLongLiteral<>
    sub          rsi, rbx                 ; SUBQ BX, SI           ; undo optimistic SI
    sub          rdi, rbx                 ; SUBQ BX, DI           ; undo optimistic DI
    sub          rbx, 32                  ; SUBQ $short_literal_stride, BX
%%litloop:
    vmovdqu8     ymm2, [rsi+32]           ; VMOVDQU8 32(SI), Y2
    add          rsi, 32                  ; ADDQ $long_literal_stride, SI
    vmovdqu8     [rdi+32], ymm2           ; VMOVDQU8 Y2, 32(DI)
    add          rdi, 32                  ; ADDQ $long_literal_stride, DI
    sub          rbx, 32                  ; SUBQ $long_literal_stride, BX
    ja           %%litloop                ; JA loop
    lea          rsi, [rsi+rbx*1+32]      ; LEAQ 32(SI)(BX*1), SI ; correct overshoot
    lea          rdi, [rdi+rbx*1+32]      ; LEAQ 32(DI)(BX*1), DI
    jmp          %%litcpy_completed       ; JMP lbl_litcpy_completed
%%item_done:
%endmacro

section .text
global iguana_avx512_decompress_vbmi2

iguana_avx512_decompress_vbmi2:
%ifdef IGUANA_SYSV
    mov    rcx, rdi                       ; ABI: (A) SysV arg0 -> rcx
%endif
    ; --- ABI: (P) Win64 prologue: preserve non-volatile GPRs + xmm6..xmm15 ---
    push   rbx                           ; ABI: (P)
    push   rbp                           ; ABI: (P)
    push   rsi                           ; ABI: (P)
    push   rdi                           ; ABI: (P)
    push   r12                           ; ABI: (P)
    push   r13                           ; ABI: (P)
    push   r14                           ; ABI: (P)
    push   r15                           ; ABI: (P)
    sub    rsp, 160                      ; ABI: (P) home for xmm6..xmm15
    vmovdqu [rsp+0],   xmm6              ; ABI: (P)
    vmovdqu [rsp+16],  xmm7              ; ABI: (P)
    vmovdqu [rsp+32],  xmm8              ; ABI: (P)
    vmovdqu [rsp+48],  xmm9              ; ABI: (P)
    vmovdqu [rsp+64],  xmm10             ; ABI: (P)
    vmovdqu [rsp+80],  xmm11             ; ABI: (P)
    vmovdqu [rsp+96],  xmm12             ; ABI: (P)
    vmovdqu [rsp+112], xmm13             ; ABI: (P)
    vmovdqu [rsp+128], xmm14             ; ABI: (P)
    vmovdqu [rsp+144], xmm15             ; ABI: (P)
    mov    rbp, rcx                       ; ABI: (A) rbp := args ptr (stands in for Go FP)

    ; --- entry (Go lines 79-107) ---
    mov     rbx, [rbp+24]                 ; MOVQ streams+24(FP), BX   ; ABI: (F)
    vpternlogq zmm1, zmm1, zmm1, 0xff     ; VPTERNLOGQ $0xff, Z1, Z1, Z1   ; Z1 := {-1}
    vpxorq  zmm0, zmm0, zmm0              ; VPXORQ Z0, Z0, Z0              ; Z0 := {0}
    mov     r11, [rbx+0]                  ; MOVQ Tokens.Data(BX), R11      ; ABI: (S) +0
    mov     r10, [rbx+8]                  ; MOVQ Tokens.Len(BX), R10       ; ABI: (S) +8  token_count
    vpabsb  zmm2, zmm1                    ; VPABSB Z1, Z2                 ; Z2 := {0x01}
    mov     r14, [rbx+32]                 ; MOVQ Offsets16.Data(BX), R14   ; ABI: (S) +32
    mov     r15, [rbx+64]                 ; MOVQ Offsets24.Data(BX), R15   ; ABI: (S) +64
    vpslld  zmm29, zmm2, 3                ; VPSLLD $3, Z2, Z29            ; Z29 := {0x08}
    vpaddd  zmm27, zmm2, zmm2            ; VPADDD Z2, Z2, Z27            ; Z27 := {0x02}
    mov     r12, [rbx+96]                 ; MOVQ VarLitLen.Data(BX), R12   ; ABI: (S) +96
    mov     r13, [rbx+128]                ; MOVQ VarMatchLen.Data(BX), R13 ; ABI: (S) +128
    vpsubb  zmm25, zmm1, zmm27           ; VPSUBB Z27, Z1, Z25           ; Z25 := {0xfd}
    vpaddd  zmm30, zmm29, zmm29          ; VPADDD Z29, Z29, Z30          ; Z30 := {0x10}
    vpaddd  zmm28, zmm27, zmm27          ; VPADDD Z27, Z27, Z28          ; Z28 := {0x04}
    mov     rsi, [rbx+160]               ; MOVQ Literals.Data(BX), SI     ; ABI: (S) +160
    mov     r9, [rbp+32]                 ; MOVQ lastOffs+32(FP), R9      ; ABI: (F) &lastOffs
    vmovdqu8 zmm21, [consts_uint24_expander_vbmi2]  ; VMOVDQU8 CONST_GET_PTR(...vbmi2,0), Z21
    vpaddd  zmm31, zmm30, zmm30          ; VPADDD Z30, Z30, Z31          ; Z31 := {0x20}
    vpaddb  zmm24, zmm29, zmm1           ; VPADDB Z1, Z29, Z24           ; Z24 := {0x07}
    mov     rdi, [rbp+0]                 ; MOVQ dst_base+0(FP), DI       ; ABI: (F)
    mov     rdx, [rbp+8]                 ; MOVQ dst_len+8(FP), DX        ; ABI: (F)
    vpaddb  zmm23, zmm30, zmm1           ; VPADDB Z1, Z30, Z23           ; Z23 := {0x0f}
    vpaddb  zmm22, zmm31, zmm1           ; VPADDB Z1, Z31, Z22           ; Z22 := {0x1f}
    mov     rcx, [rbp+16]                ; MOVQ dst_cap+16(FP), CX       ; ABI: (F)
    mov     [rbp+40], rdi                ; MOVQ DI, ret_base+40(FP)      ; ABI: (F)
    add     rdi, rdx                     ; ADDQ DX, DI                   ; append at dst end
    mov     [rbp+56], rcx                ; MOVQ CX, ret_cap+56(FP)       ; ABI: (F)
    mov     r9, [r9]                     ; MOVQ (R9), R9                 ; lastOffs value

.predecoded_tokens_exhausted:
    sub     r10d, 64                     ; SUBL $64, R10                 ; token_count -= 64
    jl      .fetch_last_tokens           ; JLT fetch_last_tokens
    vmovdqu8 zmm2, [r11]                 ; VMOVDQU8 (R11), Z2            ; 64 tokens
    mov     r8d, 0b1_0_0111_1_1_0111_1_1_0111_1_1_0111_1  ; MOVL $0b..., R8  ; sequencer
    add     r11, 64                      ; ADDQ $64, R11

.tokens_fetched:
    ; --- decode 64 tokens into flags(Z18)/litlen-off(Z19)/matchlen-off(Z20) ---
    vpminub zmm3, zmm2, zmm31            ; VPMINUB Z31, Z2, Z3
    vpandd  zmm19, zmm2, zmm24           ; VPANDD Z24, Z2, Z19
    vpsubb  zmm3, zmm3, zmm31            ; VPSUBB Z31, Z3, Z3
    vpsrld  zmm18, zmm2, 3               ; VPSRLD $3, Z2, Z18
    vpmaxsb zmm3, zmm3, zmm1             ; VPMAXSB Z1, Z3, Z3
    vpandd  zmm20, zmm18, zmm23          ; VPANDD Z23, Z18, Z20
    vpminub zmm4, zmm2, zmm22            ; VPMINUB Z22, Z2, Z4
    vpandnd zmm19, zmm3, zmm19           ; VPANDND Z19, Z3, Z19
    vpsubb  zmm4, zmm4, zmm22            ; VPSUBB Z22, Z4, Z4
    vpandnd zmm20, zmm3, zmm20           ; VPANDND Z20, Z3, Z20
    vpmaxsb zmm4, zmm4, zmm1             ; VPMAXSB Z1, Z4, Z4
    vpsubb  zmm5, zmm19, zmm24           ; VPSUBB Z24, Z19, Z5
    vpsubb  zmm6, zmm20, zmm23           ; VPSUBB Z23, Z20, Z6
    vpmaxsb zmm5, zmm5, zmm1             ; VPMAXSB Z1, Z5, Z5
    vpternlogd zmm18, zmm3, zmm30, 0b0000_0010   ; VPTERNLOGD $0b0000_0010, Z30, Z3, Z18
    vpmaxsb zmm6, zmm6, zmm1             ; VPMAXSB Z1, Z6, Z6
    vpternlogd zmm18, zmm3, zmm29, 0b1101_1000   ; VPTERNLOGD $0b1101_1000, Z29, Z3, Z18
    vpaddb  zmm2, zmm2, zmm30            ; VPADDB Z30, Z2, Z2
    vpternlogd zmm18, zmm5, zmm27, 0b0111_0010   ; VPTERNLOGD $0b0111_0010, Z27, Z5, Z18
    vpternlogd zmm5, zmm4, zmm3, 0b0010_0010     ; VPTERNLOGD $0b0010_0010, Z3, Z4, Z5
    vpternlogd zmm18, zmm6, zmm28, 0b0111_0010   ; VPTERNLOGD $0b0111_0010, Z28, Z6, Z18
    vpternlogd zmm20, zmm3, zmm2, 0b1011_1000    ; VPTERNLOGD $0b1011_1000, Z2, Z3, Z20
    vpternlogd zmm18, zmm5, zmm28, 0b1111_1000   ; VPTERNLOGD $0b1111_1000, Z28, Z5, Z18

.predecoded_tokens_available:
    ; --- arm up to 16 tokens with their stream parameters ---
    vptestmb k5, xmm18, xmm29           ; VPTESTMB X29, X18, K5         ; needs Offset24
    vmovdqu8 zmm2, [r12]                ; VMOVDQU8 (R12), Z2            ; VarLitLen bytes
    vptestmb k6, xmm18, xmm30           ; VPTESTMB X30, X18, K6         ; needs Offset16
    vmovdqu8 zmm3, [r13]                ; VMOVDQU8 (R13), Z3            ; VarMatchLen bytes
    vpcmpub k2, zmm2, zmm25, VPCMP_IMM_LE  ; VPCMPUB $LE, Z25, Z2, K2   ; VarLitLen<=0xfd
    vmovdqu16 ymm15, [r14]              ; VMOVDQU16 (R14), Y15          ; Offsets16
    vptestmb k4, xmm18, xmm27           ; VPTESTMB X27, X18, K4         ; needs VarLitLen
    kmovw   eax, k5                      ; KMOVW K5, AX
    vmovdqu8 zmm14, [r15]              ; VMOVDQU8 (R15), Z14           ; Offsets24
    vpmovzxbd zmm4, xmm2                ; VPMOVZXBD X2, Z4              ; VarLitLen[i] u32
    kmovw   ebx, k6                      ; KMOVW K6, BX
    popcnt  eax, eax                     ; POPCNTL AX, AX               ; #Offset24
    vpmovzxbd zmm16, xmm19             ; VPMOVZXBD X19, Z16            ; litlen base
    lea     rax, [rax+rax*2]             ; LEAQ (AX)(AX*2), AX          ; *3
    popcnt  ebx, ebx                     ; POPCNTL BX, BX               ; #Offset16
    vpermb  zmm14, zmm21, zmm14         ; VPERMB Z14, Z21, Z14          ; expand u24<<8
    kortestw k2, k2                      ; KORTESTW K2, K2              ; CF=0 => some >253
    lea     r15, [r15+rax*1]             ; LEAQ (R15)(AX*1), R15        ; skip Offset24 bytes
    vpmovzxwd zmm15, ymm15             ; VPMOVZXWD Y15, Z15            ; Offset16[i] u32
    kmovw   edx, k4                      ; KMOVW K4, DX
    lea     r14, [r14+rbx*2]             ; LEAQ (R14)(BX*2), R14        ; skip Offset16 bytes
    jnc     .decode_wide_varlitlen       ; JCC decode_wide_varlitlen
    popcnt  edx, edx                     ; POPCNTL DX, DX               ; #consumed VarLitLen

.varlitlen_decoded:
    vpexpandd zmm4{k4}{z}, zmm4         ; VPEXPANDD.Z Z4, K4, Z4        ; scatter varlitlen
    add     r12, rdx                     ; ADDQ DX, R12
    vpcmpub k2, zmm3, zmm25, VPCMP_IMM_LE  ; VPCMPUB $LE, Z25, Z3, K2   ; VarMatchLen<=0xfd
    vpsrld  zmm14, zmm14, 8             ; VPSRLD $8, Z14, Z14           ; u24 value
    vptestmb k4, xmm18, xmm28           ; VPTESTMB X28, X18, K4         ; needs VarMatchLen
    vpmovzxbd zmm17, xmm20             ; VPMOVZXBD X20, Z17            ; matchlen base
    vpaddd  zmm16, zmm16, zmm4          ; VPADDD Z4, Z16, Z16           ; litlen[i]
    vpmovzxbd zmm4, xmm3                ; VPMOVZXBD X3, Z4              ; VarMatchLen[i] u32
    kortestw k2, k2                      ; KORTESTW K2, K2
    valignd zmm18, zmm0, zmm18, 4       ; VALIGND $4, Z18, Z0, Z18      ; drop 16 flags
    kmovw   edx, k4                      ; KMOVW K4, DX
    jnc     .decode_wide_varmatchlen     ; JCC decode_wide_varmatchlen
    popcnt  edx, edx                     ; POPCNTL DX, DX               ; #consumed VarMatchLen

.varmatchlen_decoded:
    vpexpandd zmm4{k4}{z}, zmm4         ; VPEXPANDD.Z Z4, K4, Z4        ; scatter varmatchlen
    add     r13, rdx                     ; ADDQ DX, R13
    vpexpandd zmm15{k6}{z}, zmm15       ; VPEXPANDD.Z Z15, K6, Z15      ; scatter Offset16
    vpexpandd zmm14{k5}{z}, zmm14       ; VPEXPANDD.Z Z14, K5, Z14      ; scatter Offset24
    shr     r8d, 1                       ; SHRL $1, R8                   ; sequencer
    valignd zmm19, zmm0, zmm19, 4       ; VALIGND $4, Z19, Z0, Z19      ; drop 16 litlen offs
    vpaddd  zmm17, zmm17, zmm4          ; VPADDD Z4, Z17, Z17           ; matchlen[i]
    valignd zmm20, zmm0, zmm20, 4       ; VALIGND $4, Z20, Z0, Z20      ; drop 16 matchlen offs
    vpord   zmm15, zmm15, zmm14         ; VPORD Z14, Z15, Z15           ; offset = Off16|Off24
    jnc     .check_loop_1x               ; JCC check_loop_1x

.loop_4x:
    COPY_SINGLE_ITEM 0                   ; COPY_SINGLE_ITEM(0, ...)
    COPY_SINGLE_ITEM 1                   ; COPY_SINGLE_ITEM(1, ...)
    COPY_SINGLE_ITEM 2                   ; COPY_SINGLE_ITEM(2, ...)
    COPY_SINGLE_ITEM 3                   ; COPY_SINGLE_ITEM(3, ...)
    valignd zmm15, zmm0, zmm15, 4       ; VALIGND $4, Z15, Z0, Z15      ; rewind queue
    shr     r8d, 1                       ; SHRL $1, R8
    valignd zmm16, zmm0, zmm16, 4       ; VALIGND $4, Z16, Z0, Z16
    valignd zmm17, zmm0, zmm17, 4       ; VALIGND $4, Z17, Z0, Z17
    jc      .loop_4x                     ; JCS loop_4x
    shr     r8d, 1                       ; SHRL $1, R8
    jc      .predecoded_tokens_available ; JCS predecoded_tokens_available
    shr     r8d, 1                       ; SHRL $1, R8
    jc      .predecoded_tokens_exhausted ; JCS predecoded_tokens_exhausted

.check_loop_1x:
    test    r8d, r8d                     ; TESTL R8, R8
    jz      .no_more_tokens              ; JZ no_more_tokens

.loop_1x:
    COPY_SINGLE_ITEM 0                   ; COPY_SINGLE_ITEM(0, ...)
    valignd zmm15, zmm0, zmm15, 1       ; VALIGND $1, Z15, Z0, Z15
    valignd zmm16, zmm0, zmm16, 1       ; VALIGND $1, Z16, Z0, Z16
    valignd zmm17, zmm0, zmm17, 1       ; VALIGND $1, Z17, Z0, Z17
    sub     r8d, 1                       ; SUBL $1, R8
    jnz     .loop_1x                     ; JNZ loop_1x

.no_more_tokens:
    mov     rbx, [rbp+24]                ; MOVQ streams+24(FP), BX      ; ABI: (F)
    mov     rax, [rbp+32]                ; MOVQ lastOffs+32(FP), AX     ; ABI: (F)
    mov     rdx, [rbx+160]               ; MOVQ Literals.Data(BX), DX   ; ABI: (S) +160
    mov     rcx, [rbx+168]               ; MOVQ Literals.Len(BX), CX    ; ABI: (S) +168
    sub     rdx, rsi                     ; SUBQ SI, DX                  ; -consumed
    mov     [rax], r9                    ; MOVQ R9, (AX)                ; store lastOffs
    add     rcx, rdx                     ; ADDQ DX, CX                  ; remaining literals
    lea     rdx, [rdi+rcx*1]             ; LEAQ (DI)(CX*1), DX
    sub     rdx, [rbp+0]                 ; SUBQ dst_base+0(FP), DX      ; ABI: (F) written bytes
    cld                                  ; ABI: (D) Win64 requires DF=0 for MOVSB
    rep movsb                            ; REP; MOVSB                   ; append tail literals
    mov     [rbp+48], rdx                ; MOVQ DX, ret_len+48(FP)      ; ABI: (F)
    mov     dword [rbp+64], const_ecOK   ; MOVL $const_ecOK, ret1+64(FP) ; ABI: (F)
    jmp     .epilogue                    ; RET                          ; ABI: (R) restore regs first

.fetch_last_tokens:
    lea     eax, [r10+64]                ; LEAL 64(R10), AX
    lea     rbx, [consts_composite_remainder]  ; LEAQ CONST_GET_PTR(consts_composite_remainder,0), BX
    mov     rdx, -1                      ; MOVQ $-1, DX
    cmp     r10d, -64                    ; CMPL R10, $-64
    jle     .no_more_tokens              ; JLE no_more_tokens
    mov     r8d, [rbx+rax*4]             ; MOVL (BX)(AX*4), R8          ; sequencer for remainder
    shlx    rdx, rdx, r10                ; SHLXQ R10, DX, DX            ; -1 << (R10 & 0x3f)
    not     rdx                          ; NOTQ DX
    kmovq   k1, rdx                      ; KMOVQ DX, K1
    vmovdqu8 zmm2{k1}{z}, [r11]          ; VMOVDQU8.Z (R11), K1, Z2     ; last tokens
    jmp     .tokens_fetched              ; JMP tokens_fetched

.decode_wide_varlitlen:
    vpcmpub k1, zmm2, zmm1, VPCMP_IMM_EQ ; VPCMPUB $EQ, Z1, Z2, K1      ; ==0xff
    kmovq   rax, k2                      ; KMOVQ K2, AX                 ; <=0xfd
    vpcompressb zmm2{k2}{z}, zmm2        ; VPCOMPRESSB.Z Z2, K2, Z2     ; payload bytes only
    mov     rbx, rax                     ; MOVQ AX, BX
    not     rax                          ; NOTQ AX                      ; >0xfd
    popcnt  ecx, edx                     ; POPCNTL DX, CX               ; #tokens needing VarLitLen
    lea     rdx, [rax+rax*2]             ; LEAQ (AX)(AX*2), DX
    lea     rax, [rdx+rax*4]             ; LEAQ (DX)(AX*4), AX
    kmovq   rdx, k1                      ; KMOVQ K1, DX                 ; ==0xff
    lea     rax, [rax+rdx*8]             ; LEAQ (AX)(DX*8), AX
    xor     rax, rbx                     ; XORQ BX, AX
    pext    rdx, rdx, rax                ; PEXTQ AX, DX, DX
    not     rbx                          ; NOTQ BX                      ; >0xfd
    pext    rbx, rbx, rax                ; PEXTQ AX, BX, BX
    mov     rax, 0x1111_1111_1111_1111   ; MOVQ $0x1111..., AX
    pdep    rdx, rdx, rax                ; PDEPQ AX, DX, DX
    pdep    rbx, rbx, rax                ; PDEPQ AX, BX, BX
    lea     rdx, [rax+rdx*4]             ; LEAQ (AX)(DX*4), DX
    mov     rax, -1                      ; MOVQ $-1, AX
    lea     rdx, [rdx+rbx*2]             ; LEAQ (DX)(BX*2), DX
    shl     rax, cl                      ; SHLQ CX, AX
    kmovq   k1, rdx                      ; KMOVQ DX, K1
    lea     rdx, [rdx+rbx*8]             ; LEAQ (DX)(BX*8), DX
    lea     ecx, [rcx+rcx*2]             ; LEAL (CX)(CX*2), CX          ; *3
    vpexpandb zmm4{k1}{z}, zmm2          ; VPEXPANDB.Z Z2, K1, Z4       ; misencoded varuint_256
    shl     rax, cl                      ; SHLQ CX, AX
    vpsrld  zmm2, zmm4, 8               ; VPSRLD $8, Z4, Z2             ; 256*a2 + a1
    vpsrld  zmm5, zmm4, 16             ; VPSRLD $16, Z4, Z5            ; a2
    andn    rdx, rax, rdx                ; ANDNQ DX, AX, DX             ; trim length vector
    vpaddd  zmm2, zmm2, zmm2           ; VPADDD Z2, Z2, Z2             ; 512*a2 + 2*a1
    vpslld  zmm6, zmm5, 9              ; VPSLLD $9, Z5, Z6             ; 512*a2
    popcnt  rdx, rdx                     ; POPCNTQ DX, DX               ; #consumed VarLitLen
    vpsubd  zmm4, zmm4, zmm2           ; VPSUBD Z2, Z4, Z4
    vpslld  zmm2, zmm5, 2              ; VPSLLD $2, Z5, Z2             ; 4*a2
    vpsubd  zmm4, zmm4, zmm6           ; VPSUBD Z6, Z4, Z4
    vpaddd  zmm4, zmm4, zmm2           ; VPADDD Z2, Z4, Z4             ; corrected varuint_254
    jmp     .varlitlen_decoded           ; JMP varlitlen_decoded

.decode_wide_varmatchlen:
    vpcmpub k1, zmm3, zmm1, VPCMP_IMM_EQ ; VPCMPUB $EQ, Z1, Z3, K1
    kmovq   rax, k2                      ; KMOVQ K2, AX
    vpcompressb zmm2{k2}{z}, zmm3        ; VPCOMPRESSB.Z Z3, K2, Z2
    mov     rbx, rax                     ; MOVQ AX, BX
    not     rax                          ; NOTQ AX
    popcnt  ecx, edx                     ; POPCNTL DX, CX
    lea     rdx, [rax+rax*2]             ; LEAQ (AX)(AX*2), DX
    lea     rax, [rdx+rax*4]             ; LEAQ (DX)(AX*4), AX
    kmovq   rdx, k1                      ; KMOVQ K1, DX
    lea     rax, [rax+rdx*8]             ; LEAQ (AX)(DX*8), AX
    xor     rax, rbx                     ; XORQ BX, AX
    pext    rdx, rdx, rax                ; PEXTQ AX, DX, DX
    not     rbx                          ; NOTQ BX
    pext    rbx, rbx, rax                ; PEXTQ AX, BX, BX
    mov     rax, 0x1111_1111_1111_1111   ; MOVQ $0x1111..., AX
    pdep    rdx, rdx, rax                ; PDEPQ AX, DX, DX
    pdep    rbx, rbx, rax                ; PDEPQ AX, BX, BX
    lea     rdx, [rax+rdx*4]             ; LEAQ (AX)(DX*4), DX
    mov     rax, -1                      ; MOVQ $-1, AX
    lea     rdx, [rdx+rbx*2]             ; LEAQ (DX)(BX*2), DX
    shl     rax, cl                      ; SHLQ CX, AX
    kmovq   k1, rdx                      ; KMOVQ DX, K1
    lea     rdx, [rdx+rbx*8]             ; LEAQ (DX)(BX*8), DX
    lea     ecx, [rcx+rcx*2]             ; LEAL (CX)(CX*2), CX
    vpexpandb zmm4{k1}{z}, zmm2          ; VPEXPANDB.Z Z2, K1, Z4
    shl     rax, cl                      ; SHLQ CX, AX
    vpsrld  zmm2, zmm4, 8               ; VPSRLD $8, Z4, Z2
    vpsrld  zmm5, zmm4, 16             ; VPSRLD $16, Z4, Z5
    andn    rdx, rax, rdx                ; ANDNQ DX, AX, DX
    vpaddd  zmm2, zmm2, zmm2           ; VPADDD Z2, Z2, Z2
    vpslld  zmm6, zmm5, 9              ; VPSLLD $9, Z5, Z6
    popcnt  rdx, rdx                     ; POPCNTQ DX, DX
    vpsubd  zmm4, zmm4, zmm2           ; VPSUBD Z2, Z4, Z4
    vpslld  zmm2, zmm5, 2              ; VPSLLD $2, Z5, Z2
    vpsubd  zmm4, zmm4, zmm6           ; VPSUBD Z6, Z4, Z4
    vpaddd  zmm4, zmm4, zmm2           ; VPADDD Z2, Z4, Z4
    jmp     .varmatchlen_decoded         ; JMP varmatchlen_decoded

.epilogue:                               ; ABI: (P) Win64 epilogue — mirror of prologue
    vmovdqu xmm6,  [rsp+0]               ; ABI: (P)
    vmovdqu xmm7,  [rsp+16]              ; ABI: (P)
    vmovdqu xmm8,  [rsp+32]              ; ABI: (P)
    vmovdqu xmm9,  [rsp+48]              ; ABI: (P)
    vmovdqu xmm10, [rsp+64]              ; ABI: (P)
    vmovdqu xmm11, [rsp+80]              ; ABI: (P)
    vmovdqu xmm12, [rsp+96]              ; ABI: (P)
    vmovdqu xmm13, [rsp+112]             ; ABI: (P)
    vmovdqu xmm14, [rsp+128]             ; ABI: (P)
    vmovdqu xmm15, [rsp+144]             ; ABI: (P)
    add     rsp, 160                     ; ABI: (P)
    pop     r15                          ; ABI: (P)
    pop     r14                          ; ABI: (P)
    pop     r13                          ; ABI: (P)
    pop     r12                          ; ABI: (P)
    pop     rdi                          ; ABI: (P)
    pop     rsi                          ; ABI: (P)
    pop     rbp                          ; ABI: (P)
    pop     rbx                          ; ABI: (P)
    ret                                  ; ABI: (P)

; ---------------------------------------------------------------------------
section .rodata
align 64
; consts_uint24_expander_vbmi2 (Go lines 1229-1245): VPERMB index that spreads
; each packed 3-byte offset to a dword with a 0xff high byte (-> <<8 later).
consts_uint24_expander_vbmi2:
    dd 0x020100ff, 0x050403ff, 0x080706ff, 0x0b0a09ff
    dd 0x0e0d0cff, 0x11100fff, 0x141312ff, 0x171615ff
    dd 0x1a1918ff, 0x1d1c1bff, 0x201f1eff, 0x232221ff
    dd 0x262524ff, 0x292827ff, 0x2c2b2aff, 0x2f2e2dff

align 64
; consts_composite_remainder (Go lines 1265-1329): per-(token_count&0x3f)
; sequencer seed for the final partial batch of tokens.
consts_composite_remainder:
    dd 0b000_0, 0b001_0, 0b010_0, 0b011_0
    dd 0b000_0_0_0_1, 0b001_0_0_0_1, 0b010_0_0_0_1, 0b011_0_0_0_1
    dd 0b000_0_0_01_1, 0b001_0_0_01_1, 0b010_0_0_01_1, 0b011_0_0_01_1
    dd 0b000_0_0_011_1, 0b001_0_0_011_1, 0b010_0_0_011_1, 0b011_0_0_011_1
    dd 0b000_0_1_0111_1, 0b001_0_1_0111_1, 0b010_0_1_0111_1, 0b011_0_1_0111_1
    dd 0b000_0_0_0_1_1_0111_1, 0b001_0_0_0_1_1_0111_1, 0b010_0_0_0_1_1_0111_1, 0b011_0_0_0_1_1_0111_1
    dd 0b000_0_0_01_1_1_0111_1, 0b001_0_0_01_1_1_0111_1, 0b010_0_0_01_1_1_0111_1, 0b011_0_0_01_1_1_0111_1
    dd 0b000_0_0_011_1_1_0111_1, 0b001_0_0_011_1_1_0111_1, 0b010_0_0_011_1_1_0111_1, 0b011_0_0_011_1_1_0111_1
    dd 0b000_0_1_0111_1_1_0111_1, 0b001_0_1_0111_1_1_0111_1, 0b010_0_1_0111_1_1_0111_1, 0b011_0_1_0111_1_1_0111_1
    dd 0b000_0_0_0_1_1_0111_1_1_0111_1, 0b001_0_0_0_1_1_0111_1_1_0111_1, 0b010_0_0_0_1_1_0111_1_1_0111_1, 0b011_0_0_0_1_1_0111_1_1_0111_1
    dd 0b000_0_0_01_1_1_0111_1_1_0111_1, 0b001_0_0_01_1_1_0111_1_1_0111_1, 0b010_0_0_01_1_1_0111_1_1_0111_1, 0b011_0_0_01_1_1_0111_1_1_0111_1
    dd 0b000_0_0_011_1_1_0111_1_1_0111_1, 0b001_0_0_011_1_1_0111_1_1_0111_1, 0b010_0_0_011_1_1_0111_1_1_0111_1, 0b011_0_0_011_1_1_0111_1_1_0111_1
    dd 0b000_0_1_0111_1_1_0111_1_1_0111_1, 0b001_0_1_0111_1_1_0111_1_1_0111_1, 0b010_0_1_0111_1_1_0111_1_1_0111_1, 0b011_0_1_0111_1_1_0111_1_1_0111_1
    dd 0b000_0_0_0_1_1_0111_1_1_0111_1_1_0111_1, 0b001_0_0_0_1_1_0111_1_1_0111_1_1_0111_1, 0b010_0_0_0_1_1_0111_1_1_0111_1_1_0111_1, 0b011_0_0_0_1_1_0111_1_1_0111_1_1_0111_1
    dd 0b000_0_0_01_1_1_0111_1_1_0111_1_1_0111_1, 0b001_0_0_01_1_1_0111_1_1_0111_1_1_0111_1, 0b010_0_0_01_1_1_0111_1_1_0111_1_1_0111_1, 0b011_0_0_01_1_1_0111_1_1_0111_1_1_0111_1
    dd 0b000_0_0_011_1_1_0111_1_1_0111_1_1_0111_1, 0b001_0_0_011_1_1_0111_1_1_0111_1_1_0111_1, 0b010_0_0_011_1_1_0111_1_1_0111_1_1_0111_1, 0b011_0_0_011_1_1_0111_1_1_0111_1_1_0111_1

; AVX-512 Iguana 32-way rANS *encode* core, Win64 + SysV/Linux ABI.
;
; Line-by-line port of Sneller's Go Plan9 routine `ans32CompressCoreAVX512Generic`
;   c:\source\sneller\sneller\ion\zion\iguana\ans32_accelerators_amd64.s
; Each NASM instruction is annotated with the original Plan9 on the right.
;
; u32 iguana_avx512_ans32_encode_core(Ans32Encoder* enc /*rcx*/)
;   Encodes enc.src in 32-byte chunks (back to front), emitting renormalised
;   rANS words into enc.bufFwd (lanes 0-15, big-endian) and enc.bufRev (lanes
;   16-31, little-endian), then flushes the 32 states. Returns 0 on completion or
;   a buffer-expand flag (1=fwd, 2=rev, 3=both) — but the Rust wrapper pre-sizes
;   both buffers to worst case, so the expand paths never fire (single call).
;
; struct layout (mirrors Go ANS32Encoder; offsets resolved from the struct):
;   state  [32]u32   @0     (state[0..15]@0, state[16..31]@64)
;   bufFwd slice      @128   (Data@128, Len@136, Cap@144)
;   bufRev slice      @152   (Data@152, Len@160, Cap@168)
;   src    slice      @176   (Data@176, Len@184, Cap@192)
;   stats  *u32       @200   -> the [256]u32 gather table (cumFreq<<12)|freq
;
; Plan9 -> NASM: reverse operand lists for ALU/vector ops, keep CMP/TEST order,
; `.Z`+Kn -> {k}{z}, masked merge ops -> {k}; VPCMP/VDIV imms/rounding kept.
; ABI-only deviations tagged `ABI:` (grep to audit): (P) Win64 prologue/epilogue
; saving RBX,RSI,RDI,R12-R15 + XMM6-15; (A) r15:=enc ptr (was enc+0(FP)); (S) Go
; struct-field offsets; (V) return value held in a stack slot (Go used ret+8(FP),
; which survives the rax clobber in out_of_buffer_common) then moved to eax; (R)
; `jmp .epilogue` replaces `RET`.

bits 64
default rel

%define ENC_STATE   0
%define ENC_BUFFWD  128
%define ENC_BUFREV  152
%define ENC_SRC     176
%define ENC_STATS   200
%define SH_DATA     0
%define SH_LEN      8
%define SH_CAP      16
%define VPCMP_GE    5
%define FLAG_FWD    1
%define FLAG_REV    2
%define RETSLOT     160          ; stack slot holding the u32 return flag

section .text
global iguana_avx512_ans32_encode_core

iguana_avx512_ans32_encode_core:
%ifdef IGUANA_SYSV
    mov    rcx, rdi                       ; ABI: (A) SysV arg0 -> rcx
%endif
    push   rbx                           ; ABI: (P)
    push   rsi                           ; ABI: (P)
    push   rdi                           ; ABI: (P)
    push   r12                           ; ABI: (P)
    push   r13                           ; ABI: (P)
    push   r14                           ; ABI: (P)
    push   r15                           ; ABI: (P)
    sub    rsp, 176                      ; ABI: (P) xmm6-15 @0..159, ret flag @160
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
    mov    dword [rsp+RETSLOT], 0        ; ABI: (V) default return = 0

    mov     r15, rcx                      ; MOVQ enc+0(FP), R15        ; ABI: (A)
    vbroadcasti32x4 ymm24, [consts_enc_byte_in_word_inverter]  ; VBROADCASTI32X4 ...,Y24
    vpxord  ymm0, ymm0, ymm0             ; VPXORD Y0,Y0,Y0
    vmovdqu32 zmm25, [consts_enc_composite_transformer]        ; VMOVDQU32 ...,Z25
    vpternlogd zmm1, zmm1, zmm1, 0xff    ; VPTERNLOGD $0xff,Z1,Z1,Z1   ; Z1 := {-1}
    mov     r14, [r15+ENC_SRC+SH_LEN]    ; MOVQ src.Len(R15), R14      ; ABI: (S)
    mov     rsi, [r15+ENC_SRC+SH_DATA]   ; MOVQ src.Data(R15), SI      ; ABI: (S)
    vmovdqu32 zmm26, [r15+ENC_STATE+0]   ; VMOVDQU32 state+0(R15), Z26 ; ABI: (S) state[0..15]
    vpsrld  zmm23, zmm1, 20              ; VPSRLD $20, Z1, Z23         ; Z23 := 0x0fff x16
    vmovdqu32 zmm27, [r15+ENC_STATE+64]  ; VMOVDQU32 state+64(R15), Z27; ABI: (S) state[16..31]
    mov     rbx, [r15+ENC_STATS]         ; MOVQ stats(R15), BX         ; ABI: (S) gather table
    mov     r12, [r15+ENC_BUFFWD+SH_DATA] ; MOVQ bufFwd.Data(R15), R12 ; ABI: (S)
    mov     r13, [r15+ENC_BUFREV+SH_DATA] ; MOVQ bufRev.Data(R15), R13 ; ABI: (S)
    mov     rax, [r15+ENC_BUFFWD+SH_LEN] ; MOVQ bufFwd.Len(R15), AX    ; ABI: (S)
    mov     rdx, [r15+ENC_BUFREV+SH_LEN] ; MOVQ bufRev.Len(R15), DX    ; ABI: (S)
    mov     r10, [r15+ENC_BUFFWD+SH_CAP] ; MOVQ bufFwd.Cap(R15), R10   ; ABI: (S)
    mov     r11, [r15+ENC_BUFREV+SH_CAP] ; MOVQ bufRev.Cap(R15), R11   ; ABI: (S)
    add     r12, rax                     ; ADDQ AX, R12                ; fwdCursor = Data+Len
    add     r13, rdx                     ; ADDQ DX, R13                ; revCursor
    sub     r10, rax                     ; SUBQ AX, R10                ; fwd bytes available
    sub     r11, rdx                     ; SUBQ DX, R11                ; rev bytes available
    test    r14b, 31                     ; TESTB $31, R14              ; remainder?
    jnz     .fetch_partial               ; JNZ fetch_partial

.loop:
    sub     r14, 32                      ; SUBQ $32, R14               ; srcCursor -= 32
    jb      .done                        ; JB done                     ; no more input
    vpmovzxbd zmm2, [rsi+r14*1]          ; VPMOVZXBD (SI)(R14*1), Z2   ; chunk[0..15]
    kxnorw  k6, k6, k6                   ; KXNORW K6,K6,K6             ; 0xffff
    vpmovzxbd zmm3, [rsi+r14*1+16]       ; VPMOVZXBD 16(SI)(R14*1), Z3 ; chunk[16..31]
    kxnorw  k7, k7, k7                   ; KXNORW K7,K7,K7

.input_fetched:
    kmovw   k1, k6                       ; KMOVW K6, K1                ; gather mask
    vmovdqa32 zmm4, zmm1                 ; VMOVDQA32 Z1, Z4            ; 0xffffffff x16
    vpgatherdd zmm4{k1}, [rbx+zmm2*4]    ; VPGATHERDD (BX)(Z2*4),K1,Z4 ; (start<<12)|freq [0..15]
    kmovw   k1, k7                       ; KMOVW K7, K1
    vmovdqa32 zmm5, zmm1                 ; VMOVDQA32 Z1, Z5
    vpgatherdd zmm5{k1}, [rbx+zmm3*4]    ; VPGATHERDD (BX)(Z3*4),K1,Z5 ; [16..31]
    vpsrld  zmm6, zmm4, 12               ; VPSRLD $12, Z4, Z6          ; start[0..15]
    vpandd  zmm4, zmm4, zmm23            ; VPANDD Z23, Z4, Z4          ; freq[0..15]
    vpslld  zmm2, zmm4, 20               ; VPSLLD $20, Z4, Z2          ; freq<<20
    vextracti32x8 ymm9, zmm4, 1          ; VEXTRACTI32X8 $1, Z4, Y9    ; freq[8..15]
    vpcmpud k1{k6}, zmm26, zmm2, VPCMP_GE ; VPCMPUD $GE,Z2,Z26,K6,K1   ; state>=freq<<20
    mov     eax, 0xffff0000              ; MOVL $0xffff_0000, AX
    vcvtudq2pd zmm8, ymm4                ; VCVTUDQ2PD Y4, Z8           ; freq[0..7] -> f64
    vcvtudq2pd zmm9, ymm9                ; VCVTUDQ2PD Y9, Z9           ; freq[8..15] -> f64
    kmovw   ecx, k1                      ; KMOVW K1, CX                ; renorm mask [0..15]
    vpcompressd zmm2{k1}{z}, zmm26       ; VPCOMPRESSD.Z Z26, K1, Z2   ; states to store
    vpsrld  zmm7, zmm5, 12               ; VPSRLD $12, Z5, Z7          ; start[16..31]
    vpandd  zmm5, zmm5, zmm23            ; VPANDD Z23, Z5, Z5          ; freq[16..31]
    vpslld  zmm3, zmm5, 20               ; VPSLLD $20, Z5, Z3
    vpcmpud k2{k7}, zmm27, zmm3, VPCMP_GE ; VPCMPUD $GE,Z3,Z27,K7,K2   ; state>=freq<<20 [16..31]
    vextracti32x8 ymm11, zmm5, 1         ; VEXTRACTI32X8 $1, Z5, Y11
    popcnt  ecx, ecx                     ; POPCNTL CX, CX              ; #words to store [0..15]
    vcvtudq2pd zmm10, ymm5               ; VCVTUDQ2PD Y5, Z10
    shrx    edi, eax, ecx                ; SHRXL CX, AX, DI            ; permute mask [0..15]
    add     ecx, ecx                     ; ADDL CX, CX                 ; #bytes to store
    vpcompressd zmm3{k2}{z}, zmm27       ; VPCOMPRESSD.Z Z27, K2, Z3
    kmovw   edx, k2                      ; KMOVW K2, DX
    vcvtudq2pd zmm11, ymm11              ; VCVTUDQ2PD Y11, Z11
    kmovw   k3, edi                      ; KMOVW DI, K3                ; permute mask [0..15]
    movzx   edi, di                      ; MOVWLZX DI, DI
    popcnt  edx, edx                     ; POPCNTL DX, DX              ; #words to store [16..31]
    pext    edi, edi, edi                ; PEXTL DI, DI, DI            ; store mask [0..15]
    shrx    eax, eax, edx                ; SHRXL DX, AX, AX            ; permute mask [16..31]
    add     edx, edx                     ; ADDL DX, DX                 ; #bytes to store
    sub     r10, rcx                     ; SUBQ CX, R10                ; fwd space check
    jb      .out_of_fwd_buffer           ; JB out_of_fwd_buffer
    movzx   eax, ax                      ; MOVWLZX AX, AX
    sub     r11, rdx                     ; SUBQ DX, R11                ; rev space check
    jb      .out_of_rev_buffer           ; JB out_of_rev_buffer
    vpsrld  zmm26{k1}, zmm26, 16         ; VPSRLD $16, Z26, K1, Z26    ; renorm: state>>=16
    kmovw   k4, eax                      ; KMOVW AX, K4                ; permute mask [16..31]
    vcvtudq2pd zmm12, ymm26              ; VCVTUDQ2PD Y26, Z12         ; state[0..7] -> f64
    vpcompressd zmm16{k3}{z}, zmm25      ; VPCOMPRESSD.Z Z25, K3, Z16  ; store permutation [0..15]
    vpsrld  zmm27{k2}, zmm27, 16         ; VPSRLD $16, Z27, K2, Z27    ; renorm [16..31]
    pext    eax, eax, eax                ; PEXTL AX, AX, AX            ; store mask [16..31]
    vcvtudq2pd zmm14, ymm27              ; VCVTUDQ2PD Y27, Z14         ; state[16..23] -> f64
    vextracti32x8 ymm13, zmm26, 1        ; VEXTRACTI32X8 $1, Z26, Y13  ; state[8..15]
    vpaddd  zmm6, zmm26, zmm6            ; VPADDD Z6, Z26, Z6          ; state+start [0..15]
    vpermd  zmm2, zmm16, zmm2            ; VPERMD Z2, Z16, Z2          ; dwords to store [0..15]
    vpaddd  zmm7, zmm27, zmm7            ; VPADDD Z7, Z27, Z7          ; state+start [16..31]
    vextracti32x8 ymm15, zmm27, 1        ; VEXTRACTI32X8 $1, Z27, Y15  ; state[24..31]
    vcvtudq2pd zmm13, ymm13              ; VCVTUDQ2PD Y13, Z13
    vdivpd  zmm12, zmm12, zmm8, {rz-sae} ; VDIVPD.RZ_SAE Z8, Z12, Z12  ; floor(state/freq)[0..7]
    vpmovdw ymm2, zmm2                   ; VPMOVDW Z2, Y2              ; words to store [0..15]
    kmovw   k3, edi                      ; KMOVW DI, K3                ; store mask [0..15]
    vpcompressd zmm16{k4}{z}, zmm25      ; VPCOMPRESSD.Z Z25, K4, Z16  ; store permutation [16..31]
    vcvtudq2pd zmm15, ymm15              ; VCVTUDQ2PD Y15, Z15
    vdivpd  zmm13, zmm13, zmm9, {rz-sae} ; VDIVPD.RZ_SAE Z9, Z13, Z13  ; floor(state/freq)[8..15]
    vpshufb ymm2, ymm2, ymm24            ; VPSHUFB Y24, Y2, Y2         ; big-endian words [0..15]
    vpermd  zmm3, zmm16, zmm3            ; VPERMD Z3, Z16, Z3          ; dwords to store [16..31]
    vmovdqu16 [r12]{k3}, ymm2            ; VMOVDQU16 Y2, K3, (R12)     ; store fwd words
    kmovw   k4, eax                      ; KMOVW AX, K4                ; store mask [16..31]
    add     r12, rcx                     ; ADDQ CX, R12                ; fwdCursor += bytes
    vcvttpd2udq ymm12, zmm12             ; VCVTTPD2UDQ Z12, Y12        ; state/freq [0..7]
    vdivpd  zmm14, zmm14, zmm10, {rz-sae} ; VDIVPD.RZ_SAE Z10, Z14, Z14 ; floor[16..23]
    vcvttpd2udq ymm13, zmm13             ; VCVTTPD2UDQ Z13, Y13        ; state/freq [8..15]
    vpmovdw ymm3, zmm3                   ; VPMOVDW Z3, Y3              ; words to store [16..31]
    vdivpd  zmm15, zmm15, zmm11, {rz-sae} ; VDIVPD.RZ_SAE Z11, Z15, Z15 ; floor[24..31]
    vinserti32x8 zmm12, zmm12, ymm13, 1  ; VINSERTI32X8 $1, Y13, Z12, Z12 ; state/freq [0..15]
    vmovdqu16 [r13]{k4}, ymm3            ; VMOVDQU16 Y3, K4, (R13)     ; store rev words (LE)
    add     r13, rdx                     ; ADDQ DX, R13                ; revCursor += bytes
    vcvttpd2udq ymm14, zmm14             ; VCVTTPD2UDQ Z14, Y14        ; state/freq [16..23]
    vcvttpd2udq ymm15, zmm15             ; VCVTTPD2UDQ Z15, Y15        ; state/freq [24..31]
    vpmulld zmm13, zmm4, zmm12           ; VPMULLD Z12, Z4, Z13        ; (state/freq)*freq [0..15]
    vinserti32x8 zmm14, zmm14, ymm15, 1  ; VINSERTI32X8 $1, Y15, Z14, Z14
    vpslld  zmm12, zmm12, 12             ; VPSLLD $12, Z12, Z12        ; (state/freq)<<12
    vpaddd  zmm12, zmm12, zmm6           ; VPADDD Z6, Z12, Z12         ; +state+start
    vpmulld zmm15, zmm5, zmm14           ; VPMULLD Z14, Z5, Z15        ; [16..31]
    vpslld  zmm14, zmm14, 12             ; VPSLLD $12, Z14, Z14
    vpsubd  zmm26{k6}, zmm12, zmm13      ; VPSUBD Z13, Z12, K6, Z26    ; newstate[0..15]
    vpaddd  zmm14, zmm14, zmm7           ; VPADDD Z7, Z14, Z14
    vpsubd  zmm27{k7}, zmm14, zmm15      ; VPSUBD Z15, Z14, K7, Z27    ; newstate[16..31]
    jmp     .loop                        ; JMP loop

.done:
    vpermd  zmm2, zmm25, zmm26           ; VPERMD Z26, Z25, Z2         ; reverse state[15..0]
    sub     r10, 64                      ; SUBQ $64, R10
    jb      .out_of_fwd_buffer           ; JB out_of_fwd_buffer
    vbroadcasti32x4 zmm3, [consts_enc_byte_in_dword_inverter] ; VBROADCASTI32X4 ...,Z3
    sub     r11, 64                      ; SUBQ $64, R11
    jb      .out_of_rev_buffer           ; JB out_of_rev_buffer
    xor     eax, eax                     ; XORL AX, AX
    vmovdqu32 [r15+ENC_STATE+0], zmm26   ; VMOVDQU32 Z26, state+0(R15) ; ABI: (S)
    vmovdqu32 [r15+ENC_STATE+64], zmm27  ; VMOVDQU32 Z27, state+64(R15); ABI: (S)
    mov     [r15+ENC_SRC+SH_LEN], rax    ; MOVQ AX, src.Len(R15)       ; ABI: (S) src.Len=0
    mov     dword [rsp+RETSLOT], eax     ; MOVL AX, ret+8(FP)          ; ABI: (V) return=0
    vpshufb zmm2, zmm2, zmm3             ; VPSHUFB Z3, Z2, Z2          ; byte-reverse state
    vmovdqu32 [r13], zmm27               ; VMOVDQU32 Z27, (R13)        ; flush state[16..31]
    add     r13, 64                      ; ADDQ $64, R13
    vmovdqu32 [r12], zmm2                ; VMOVDQU32 Z2, (R12)         ; flush byte-rev state[0..15]
    add     r12, 64                      ; ADDQ $64, R12
    sub     r13, [r15+ENC_BUFREV+SH_DATA] ; SUBQ bufRev.Data(R15), R13 ; ABI: (S) new bufRev.Len
    sub     r12, [r15+ENC_BUFFWD+SH_DATA] ; SUBQ bufFwd.Data(R15), R12 ; ABI: (S) new bufFwd.Len
    mov     [r15+ENC_BUFREV+SH_LEN], r13 ; MOVQ R13, bufRev.Len(R15)   ; ABI: (S)
    mov     [r15+ENC_BUFFWD+SH_LEN], r12 ; MOVQ R12, bufFwd.Len(R15)   ; ABI: (S)
    jmp     .epilogue                    ; RET                         ; ABI: (R)

.fetch_partial:
    mov     eax, -1                      ; MOVL $-1, AX
    mov     edx, r14d                    ; MOVL R14, DX
    shlx    eax, eax, r14d               ; SHLXL R14, AX, AX           ; ^fetch_mask
    and     edx, 31                      ; ANDL $31, DX                ; src.Len % 32
    not     eax                          ; NOTL AX                     ; fetch_mask
    sub     r14, rdx                     ; SUBQ DX, R14                ; align down
    kmovw   k6, eax                      ; KMOVW AX, K6
    shr     eax, 16                      ; SHRL $16, AX
    vpmovzxbd zmm2{k6}{z}, [rsi+r14*1]   ; VPMOVZXBD.Z (SI)(R14*1),K6,Z2
    kmovw   k7, eax                      ; KMOVW AX, K7
    vpmovzxbd zmm3{k7}{z}, [rsi+r14*1+16] ; VPMOVZXBD.Z 16(SI)(R14*1),K7,Z3
    jmp     .input_fetched               ; JMP input_fetched
    ud2                                  ; UD2

.out_of_fwd_buffer:
    mov     dword [rsp+RETSLOT], FLAG_FWD ; MOVL $...ExpandForward, ret+8(FP) ; ABI: (V)
    sub     r11, rdx                     ; SUBQ DX, R11
    jae     .out_of_buffer_common        ; JAE out_of_buffer_common
    mov     dword [rsp+RETSLOT], (FLAG_FWD | FLAG_REV) ; MOVL $...Fwd|Rev, ret+8(FP) ; ABI: (V)
    jmp     .out_of_buffer_common        ; JMP out_of_buffer_common

.out_of_rev_buffer:
    mov     dword [rsp+RETSLOT], FLAG_REV ; MOVL $...ExpandReverse, ret+8(FP) ; ABI: (V)

.out_of_buffer_common:
    vmovdqu32 [r15+ENC_STATE+0], zmm26   ; VMOVDQU32 Z26, state+0(R15) ; ABI: (S)
    mov     rax, [r15+ENC_SRC+SH_LEN]    ; MOVQ src.Len(R15), AX       ; ABI: (S)
    vmovdqu32 [r15+ENC_STATE+64], zmm27  ; VMOVDQU32 Z27, state+64(R15); ABI: (S)
    sub     r12, [r15+ENC_BUFFWD+SH_DATA] ; SUBQ bufFwd.Data(R15), R12 ; ABI: (S)
    sub     r13, [r15+ENC_BUFREV+SH_DATA] ; SUBQ bufRev.Data(R15), R13 ; ABI: (S)
    mov     [r15+ENC_BUFFWD+SH_LEN], r12 ; MOVQ R12, bufFwd.Len(R15)   ; ABI: (S)
    sub     rax, r14                     ; SUBQ R14, AX
    lea     rdx, [r14+32]                ; LEAQ 32(R14), DX
    mov     [r15+ENC_BUFREV+SH_LEN], r13 ; MOVQ R13, bufRev.Len(R15)   ; ABI: (S)
    lea     rdi, [r14+rax*1]             ; LEAQ (R14)(AX*1), DI
    cmp     rax, 32                      ; CMPQ AX, $32
    cmovc   rdx, rdi                     ; CMOVQCS DI, DX
    mov     [r15+ENC_SRC+SH_LEN], rdx    ; MOVQ DX, src.Len(R15)       ; ABI: (S)
    jmp     .epilogue                    ; RET                         ; ABI: (R)

.epilogue:                               ; ABI: (P) Win64 epilogue
    mov     eax, [rsp+RETSLOT]           ; ABI: (V) return flag -> eax
    vmovdqu xmm6,  [rsp+0]               ; ABI: (P)
    vmovdqu xmm7,  [rsp+16]              ; ABI: (P)
    vmovdqu xmm8,  [rsp+32]              ; ABI: (P)
    vmovdqu xmm9,  [rsp+48]              ; ABI: (P)
    vmovdqu xmm10, [rsp+64]             ; ABI: (P)
    vmovdqu xmm11, [rsp+80]             ; ABI: (P)
    vmovdqu xmm12, [rsp+96]             ; ABI: (P)
    vmovdqu xmm13, [rsp+112]            ; ABI: (P)
    vmovdqu xmm14, [rsp+128]            ; ABI: (P)
    vmovdqu xmm15, [rsp+144]            ; ABI: (P)
    add     rsp, 176                     ; ABI: (P)
    pop     r15                          ; ABI: (P)
    pop     r14                          ; ABI: (P)
    pop     r13                          ; ABI: (P)
    pop     r12                          ; ABI: (P)
    pop     rdi                          ; ABI: (P)
    pop     rsi                          ; ABI: (P)
    pop     rbx                          ; ABI: (P)
    ret                                  ; ABI: (P)

; ---------------------------------------------------------------------------
section .rodata
align 64
; consts_enc_composite_transformer (Go 872-888): reverse permutation 15..0.
consts_enc_composite_transformer:
    dd 0b1111, 0b1110, 0b1101, 0b1100, 0b1011, 0b1010, 0b1001, 0b1000
    dd 0b0111, 0b0110, 0b0101, 0b0100, 0b0011, 0b0010, 0b0001, 0b0000
align 16
; consts_enc_byte_in_word_inverter (Go 890-894): VPSHUFB index, byte-swap words.
consts_enc_byte_in_word_inverter:
    dd 0x02030001, 0x06070405, 0x0a0b0809, 0x0e0f0c0d
align 16
; consts_enc_byte_in_dword_inverter (Go 896-900): VPSHUFB index, byte-reverse dwords.
consts_enc_byte_in_dword_inverter:
    dd 0x00010203, 0x04050607, 0x08090a0b, 0x0c0d0e0f

; AVX-512 (256-bit) Iguana match finder, Win64 + SysV/Linux ABI.
;
; Line-by-line port of Sneller's Go Plan9 routine `bestMatchAVX512` in
;   c:\source\sneller\sneller\ion\zion\iguana\match_amd64.s
; Each NASM instruction is annotated with the original Plan9 source.
;
; Evaluates up to `histsize`(=4) candidate match positions for the target
; position `pos`, SIMD-extends each forward (32-byte VPXORD/VPTESTMB), extends
; backward bytewise, rejects offset>=2^16 matches shorter than 16, and returns
; the (targetpos, matchpos, matchlen) of the longest legal candidate (or 0,0,0).
;
; void iguana_avx512_best_match(MatchArgs* args /*rcx*/)
;   struct MatchArgs {            // mirrors the Go stack frame ([rbp+N] == [FP+N])
;       const u8* src_base;  //  0
;       usize     src_len;   //  8
;       usize     src_cap;   // 16  (unused; layout only)
;       i32       litmin;    // 24   minimum target pos for backward extension
;       i32       pos;       // 28   target position to match
;       const i32* hist;     // 32   -> [4]i32 candidate match positions
;       i32       ret_targetpos; // 40 (out)
;       i32       ret_matchpos;  // 44 (out)
;       i32       ret_matchlen;  // 48 (out)
;   }
;
; CALLER GUARANTEE: src_len - pos >= 32 (the routine caches/over-reads 32 bytes
; at `pos`); the Rust wrapper only calls it when that holds.
;
; Plan9 -> NASM rules: reverse operand lists for ALU/vector ops (dst last->first)
; but NOT for CMP/TEST (no destination: Plan9 `CMP a,b` == Intel `cmp a,b`).
; ABI-only deviations are tagged `ABI:` (grep them to audit): (P) Win64
; prologue/epilogue saving RBX,RBP,RSI,RDI,R12-R14; (A) rbp:=args ptr; (F) every
; `[rbp+N]` == Go `<field>+N(FP)`; (R) `jmp .epilogue` replaces `RET`.

bits 64
default rel

%define histsize 4

section .text
global iguana_avx512_best_match

iguana_avx512_best_match:
%ifdef IGUANA_SYSV
    mov    rcx, rdi                       ; ABI: (A) SysV arg0 -> rcx
%endif
    push   rbx                           ; ABI: (P)
    push   rbp                           ; ABI: (P)
    push   rsi                           ; ABI: (P)
    push   rdi                           ; ABI: (P)
    push   r12                           ; ABI: (P)
    push   r13                           ; ABI: (P)
    push   r14                           ; ABI: (P)
    mov    rbp, rcx                       ; ABI: (A) rbp := args ptr (stands in for Go FP)

    mov     rsi, [rbp+0]                  ; MOVQ src_base+0(FP), SI      ; ABI: (F)
    mov     rdx, [rbp+8]                  ; MOVQ src_len+8(FP), DX       ; ABI: (F)
    mov     eax, [rbp+24]                 ; MOVL litmin+24(FP), AX       ; ABI: (F) min target pos
    mov     r8, [rbp+32]                  ; MOVQ hist+32(FP), R8         ; ABI: (F) &next candidate
    mov     ebx, [rbp+28]                 ; MOVL pos+28(FP), BX          ; ABI: (F)
    sub     rdx, rbx                      ; SUBQ BX, DX                  ; DX = len-pos = max match len
    cmp     rdx, 32                       ; CMPQ DX, $32
    jl      .trap                         ; JLT trap                     ; should never happen
    vmovdqu32 ymm3, [rsi+rbx*1]           ; VMOVDQU32 0(SI)(BX*1), Y3    ; cache 32 bytes of src@pos

    ; initial results are zero
    xor     r9d, r9d                      ; XORL R9, R9
    mov     [rbp+40], r9d                 ; MOVL R9, ret+40(FP)          ; ABI: (F)
    mov     [rbp+44], r9d                 ; MOVL R9, ret1+44(FP)         ; ABI: (F)
    mov     [rbp+48], r9d                 ; MOVL R9, ret2+48(FP)         ; ABI: (F)

    ; 1st loop iteration: unconditional
    mov     ecx, histsize                 ; MOVL $const_histsize, CX
    mov     r10d, [r8]                    ; MOVL 0(R8), R10              ; R10 = matchpos
    add     r8, 4                          ; ADDQ $4, R8                  ; hist++
.restart:
    mov     rsi, [rbp+0]                  ; MOVQ src_base+0(FP), SI      ; ABI: (F)
    mov     r9d, [rbp+28]                 ; MOVL pos+28(FP), R9          ; ABI: (F) R9 = targetpos
    xor     r11d, r11d                    ; XORL R11, R11                ; matchlen = 0
    vpxord  ymm0, ymm3, [rsi+r10*1]       ; VPXORD 0(SI)(R10*1), Y3, Y0
    vptestmb k1, ymm0, ymm0               ; VPTESTMB Y0, Y0, K1          ; K1 = non-matching bytes
    ktestd  k1, k1                        ; KTESTD K1, K1
    jnz     .matchlen_done                ; JNZ matchlen_done            ; any mismatch in first 32 -> done
    lea     rdi, [rsi+r10*1]              ; LEAQ 0(SI)(R10*1), DI        ; DI = matchpos ptr
    lea     rsi, [rsi+r9*1]               ; LEAQ 0(SI)(R9*1), SI         ; SI = targetpos ptr
    mov     r12, rdx                      ; MOVQ DX, R12                 ; R12 = max_matchlen
.matchlen_loop:
    add     r11, 32                       ; ADDQ $32, R11
    sub     r12, 32                       ; SUBQ $32, R12
    jz      .extend_backwards             ; JZ extend_backwards          ; consumed all -> done
    cmp     r12, 32                       ; CMPQ R12, $32
    jl      .byte_by_byte                 ; JLT byte_by_byte             ; <32 left -> bytewise
    vmovdqu32 ymm0, [rsi+r11*1]           ; VMOVDQU32 0(SI)(R11*1), Y0
    vpxord  ymm0, ymm0, [rdi+r11*1]       ; VPXORD 0(DI)(R11*1), Y0, Y0
    vptestmb k1, ymm0, ymm0               ; VPTESTMB Y0, Y0, K1
    ktestd  k1, k1                        ; KTESTD K1, K1
    jz      .matchlen_loop                ; JZ matchlen_loop
.matchlen_done:
    kmovd   r14d, k1                      ; KMOVD K1, R14
    tzcnt   r14d, r14d                    ; TZCNTL R14, R14
    add     r11d, r14d                    ; ADDL R14, R11               ; matchlen += tzcnt(diff bytes)
.extend_backwards:
    test    r10d, r10d                    ; TESTL R10, R10              ; can't extend back if matchpos==0
    jz      .test_legal                   ; JZ test_legal
    mov     rsi, [rbp+0]                  ; MOVQ src_base+0(FP), SI      ; ABI: (F)
.continue_extending_backwards:
    cmp     r9d, eax                      ; CMPL R9, AX                  ; assert targetpos > litmin
    je      .test_legal                   ; JEQ test_legal
    movzx   r14d, byte [rsi+r9*1-1]       ; MOVBLZX -1(SI)(R9*1), R14    ; src[targetpos-1]
    cmp     byte [rsi+r10*1-1], r14b      ; CMPB -1(SI)(R10*1), R14      ; src[matchpos-1] == ?
    jne     .test_legal                   ; JNE test_legal
    dec     r9d                           ; DECL R9                      ; targetpos--
    inc     r11d                          ; INCL R11                     ; matchlen++
    dec     r10d                          ; DECL R10                     ; matchpos--
    jnz     .continue_extending_backwards ; JNZ continue_extending_backwards
.test_legal:
    mov     r14d, r9d                     ; MOVL R9, R14
    sub     r14d, r10d                    ; SUBL R10, R14               ; R14 = offset = targetpos-matchpos
    shr     r14d, 16                      ; SHRL $16, R14
    jz      .test_better                  ; JZ test_better              ; offset < 2^16 -> legal
    cmp     r11d, 15                      ; CMPL R11, $15
    jle     .loop_tail                    ; JLE loop_tail               ; big offset && len<=15 -> illegal
.test_better:
    cmp     r11d, [rbp+48]                ; CMPL R11, ret2+48(FP)       ; ABI: (F) matchlen vs best
    jle     .loop_tail                    ; JLE loop_tail               ; not better -> skip
    mov     [rbp+40], r9d                 ; MOVL R9, ret+40(FP)         ; ABI: (F) targetpos
    mov     [rbp+44], r10d                ; MOVL R10, ret1+44(FP)       ; ABI: (F) matchpos
    mov     [rbp+48], r11d                ; MOVL R11, ret2+48(FP)       ; ABI: (F) matchlen
.loop_tail:
    dec     ecx                           ; DECL CX
    jz      .done                         ; JZ done                      ; --count == 0
    mov     r10d, [r8]                    ; MOVL 0(R8), R10             ; next matchpos
    add     r8, 4                          ; ADDQ $4, R8                  ; hist++
    test    r10d, r10d                    ; TESTL R10, R10
    jnz     .restart                      ; JNZ restart                  ; continue while matchpos != 0
.done:
    jmp     .epilogue                     ; RET                          ; ABI: (R)
.byte_by_byte:
    movzx   r13d, byte [rsi+r11*1]        ; MOVBLZX 0(SI)(R11*1), R13
    cmp     r13b, byte [rdi+r11*1]        ; CMPB R13, 0(DI)(R11*1)
    jne     .extend_backwards             ; JNE extend_backwards
    inc     r11d                          ; INCL R11
    dec     r12d                          ; DECL R12
    jnz     .byte_by_byte                 ; JNZ byte_by_byte
    jmp     .extend_backwards             ; JMP extend_backwards
.trap:
    int3                                  ; BYTE $0xCC                   ; should never run
.epilogue:                                ; ABI: (P) Win64 epilogue
    pop     r14                           ; ABI: (P)
    pop     r13                           ; ABI: (P)
    pop     r12                           ; ABI: (P)
    pop     rdi                           ; ABI: (P)
    pop     rsi                           ; ABI: (P)
    pop     rbp                           ; ABI: (P)
    pop     rbx                           ; ABI: (P)
    ret                                   ; ABI: (P)

; AVX-512 toolchain probe for the Iguana port (Win64 + SysV/Linux ABI).
;
; Proves the NASM -> nasm-rs -> MSVC-link -> Rust `extern "C"` -> AVX-512
; execution pipeline end-to-end. Differential-tested against a scalar twin in
; Rust. The real ans32 decode kernel will follow this exact pattern.
;
; uint64_t iguana_avx512_byte_sum(const uint8_t* src /*rcx*/, size_t len /*rdx*/)
;   returns the sum of all `len` bytes in `rax`.
;
; Uses only volatile registers (zmm0-2, rax, rcx, rdx, r8) so no Win64
; non-volatile save/restore is needed.

bits 64
default rel

section .text
global iguana_avx512_byte_sum

iguana_avx512_byte_sum:
%ifdef IGUANA_SYSV
    mov           rcx, rdi                 ; ABI: (A) SysV arg0 (src) -> rcx
    mov           rdx, rsi                 ; ABI: (A) SysV arg1 (len) -> rdx
%endif
    vpxorq        zmm0, zmm0, zmm0          ; accumulator: 8 x u64 partial sums
    vpxorq        zmm2, zmm2, zmm2          ; constant zero for vpsadbw

.loop64:
    cmp           rdx, 64
    jb            .reduce
    vmovdqu8      zmm1, [rcx]               ; 64 bytes
    vpsadbw       zmm1, zmm1, zmm2          ; per-qword: sum of its 8 bytes
    vpaddq        zmm0, zmm0, zmm1          ; accumulate
    add           rcx, 64
    sub           rdx, 64
    jmp           .loop64

.reduce:
    ; horizontal sum of the 8 qwords in zmm0 -> rax
    vextracti64x4 ymm1, zmm0, 1
    vpaddq        ymm0, ymm0, ymm1
    vextracti128  xmm1, ymm0, 1
    vpaddq        xmm0, xmm0, xmm1
    vpshufd       xmm1, xmm0, 0x4e          ; swap the two qwords
    vpaddq        xmm0, xmm0, xmm1
    vmovq         rax, xmm0

.tail:                                       ; remaining < 64 bytes, scalar
    test          rdx, rdx
    jz            .done
    movzx         r8d, byte [rcx]
    add           rax, r8
    inc           rcx
    dec           rdx
    jmp           .tail

.done:
    vzeroupper
    ret

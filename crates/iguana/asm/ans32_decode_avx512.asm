; AVX-512 32-way interleaved rANS decode (Iguana ANS32), Win64 + SysV/Linux ABI.
;
; Implements the same algorithm as the scalar reference `ans32_decode`
; (Go `ans32DecompressReference`) and is differential-tested against it.
;
; void iguana_avx512_ans32_decode(const Args* args /*rcx*/)
;   struct Args { u8* dst; usize dst_len; const u8* src; usize src_len; const u32* tab; }
;
; 32 rANS states: lanes 0-15 in zmm0 (forward), lanes 16-31 in zmm1 (reverse).
; Forward renorm reads u16s ascending from src+64; reverse renorm reads u16s
; descending from src+src_len-64. `tab` is the 4096-entry dense table.

bits 64
default rel

section .rodata
align 32
rev16_w: dw 15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0

section .text
global iguana_avx512_ans32_decode

; Decode 16 lanes held in %1 (a zmm): update state in-place, leave the 16
; output symbol bytes in xmm4. Scratch: zmm4, zmm5, k1.
%macro DECODE 1
    vpandd     zmm4, %1, zmm2            ; slot = state & (M-1)
    kxnorw     k1, k1, k1               ; gather mask = all ones
    vpgatherdd zmm5{k1}, [rdx + zmm4*4]  ; t = tab[slot]
    vpsrld     %1, %1, 12               ; state >> M_BITS
    vpandd     zmm4, zmm5, zmm2         ; freq = t & (M-1)
    vpmulld    %1, %1, zmm4             ; (state>>12) * freq
    vpsrld     zmm4, zmm5, 12
    vpandd     zmm4, zmm4, zmm2         ; bias = (t>>12) & (M-1)
    vpaddd     %1, %1, zmm4             ; new state
    vpsrld     zmm4, zmm5, 24           ; symbol (low byte of each u32)
    vpmovdb    xmm4, zmm4               ; 16 symbol bytes
%endmacro

iguana_avx512_ans32_decode:
%ifdef IGUANA_SYSV
    mov        rcx, rdi                 ; ABI: (A) SysV arg0 -> rcx
%endif
    sub        rsp, 48
    vmovdqu    [rsp], xmm6              ; save non-volatile xmm6 (Win64)

    mov        r10, [rcx]              ; dst
    mov        r11, [rcx + 8]          ; remaining (dst_len)
    mov        rax, [rcx + 16]         ; src
    mov        r9,  [rcx + 24]         ; src_len
    mov        rdx, [rcx + 32]         ; tab

    vmovdqu32  zmm0, [rax]             ; state_lo = src[0..64]
    lea        r9, [rax + r9 - 64]     ; reverse states base + reverse cursor
    vmovdqu32  zmm1, [r9]              ; state_hi = src[len-64..len]
    lea        r8, [rax + 64]          ; forward cursor

    mov        ecx, 0xfff
    vpbroadcastd zmm2, ecx             ; M-1
    mov        ecx, 0x10000
    vpbroadcastd zmm3, ecx             ; L
    vmovdqu    ymm6, [rev16_w]         ; reverse-16-words permute index

.full:
    cmp        r11, 32
    jb         .tail

    DECODE     zmm0
    vmovdqu    [r10], xmm4             ; lanes 0-15
    DECODE     zmm1
    vmovdqu    [r10 + 16], xmm4        ; lanes 16-31
    add        r10, 32
    sub        r11, 32
    jz         .done                   ; produced exactly dst_len: no more renorm

    ; forward renorm (lanes 0-15): masked lanes pull the next u16 from r8++
    vpcmpud    k2, zmm0, zmm3, 1       ; state < L
    vpmovzxwd  zmm4, [r8]              ; 16 candidate u16 (ascending)
    vpexpandd  zmm5{k2}{z}, zmm4       ; distribute to masked lanes in order
    vpslld     zmm4, zmm0, 16
    vpord      zmm4, zmm4, zmm5
    vmovdqa32  zmm0{k2}, zmm4          ; update only masked lanes
    kmovw      eax, k2
    popcnt     ecx, eax
    lea        r8, [r8 + rcx*2]        ; cursor_fwd += 2*popcount

    ; reverse renorm (lanes 16-31): masked lanes pull the next u16 from r9--
    vpcmpud    k2, zmm1, zmm3, 1
    vmovdqu    ymm4, [r9 - 32]         ; 16 u16 just below the cursor
    vpermw     ymm4, ymm6, ymm4        ; reverse: element[0] = u16 at r9-2
    vpmovzxwd  zmm4, ymm4
    vpexpandd  zmm5{k2}{z}, zmm4
    vpslld     zmm4, zmm1, 16
    vpord      zmm4, zmm4, zmm5
    vmovdqa32  zmm1{k2}, zmm4
    kmovw      eax, k2
    popcnt     ecx, eax
    lea        rax, [rcx*2]
    sub        r9, rax                 ; cursor_rev -= 2*popcount
    jmp        .full

.tail:                                  ; remaining 1..31: decode, copy that many
    test       r11, r11
    jz         .done
    DECODE     zmm0
    vmovdqu    [rsp + 16], xmm4
    DECODE     zmm1
    vmovdqu    [rsp + 32], xmm4
    xor        eax, eax
.tailcopy:
    cmp        rax, r11
    jae        .done
    mov        cl, [rsp + 16 + rax]
    mov        [r10 + rax], cl
    inc        rax
    jmp        .tailcopy

.done:
    vmovdqu    xmm6, [rsp]
    add        rsp, 48
    vzeroupper
    ret

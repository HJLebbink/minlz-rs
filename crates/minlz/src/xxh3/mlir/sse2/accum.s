# minlz_xxh3_accum of crates/minlz/mlir/xxh3.mlir for sse2, written by
# cargo xtask mlir. Do not edit.
	sub	rsp, 232
	lea	rax, [rdx - 1]
	mov	r8, rax
	shr	r8, 10
	movdqu	xmm1, xmmword ptr [rdi]
	movdqu	xmm4, xmmword ptr [rdi + 16]
	movdqu	xmm5, xmmword ptr [rdi + 32]
	movdqu	xmm6, xmmword ptr [rdi + 48]
	je	22f
	movups	xmm0, xmmword ptr [rcx + 1024]
	movaps	xmmword ptr [rsp + 176], xmm0
	movups	xmm0, xmmword ptr [rcx + 1040]
	movaps	xmmword ptr [rsp + 160], xmm0
	movups	xmm0, xmmword ptr [rcx + 1056]
	movaps	xmmword ptr [rsp + 144], xmm0
	movdqu	xmm0, xmmword ptr [rcx + 1072]
	movdqa	xmmword ptr [rsp + 128], xmm0
	lea	r9, [rsi + 192]
	xor	r10d, r10d
	.p2align	4
2:
	movdqa	xmmword ptr [rsp + 192], xmm6
	movdqa	xmmword ptr [rsp + 208], xmm5
	movdqa	xmmword ptr [rsp + 32], xmm4
	movdqa	xmmword ptr [rsp + 48], xmm1
	mov	r11, r10
	shl	r11, 10
	prefetcht0	byte ptr [rsi + r11 + 4096]
	prefetcht0	byte ptr [rsi + r11 + 4160]
	prefetcht0	byte ptr [rsi + r11 + 4224]
	prefetcht0	byte ptr [rsi + r11 + 4288]
	prefetcht0	byte ptr [rsi + r11 + 4352]
	prefetcht0	byte ptr [rsi + r11 + 4416]
	prefetcht0	byte ptr [rsi + r11 + 4480]
	prefetcht0	byte ptr [rsi + r11 + 4544]
	prefetcht0	byte ptr [rsi + r11 + 4608]
	prefetcht0	byte ptr [rsi + r11 + 4672]
	prefetcht0	byte ptr [rsi + r11 + 4736]
	prefetcht0	byte ptr [rsi + r11 + 4800]
	prefetcht0	byte ptr [rsi + r11 + 4864]
	prefetcht0	byte ptr [rsi + r11 + 4928]
	prefetcht0	byte ptr [rsi + r11 + 4992]
	prefetcht0	byte ptr [rsi + r11 + 5056]
	pxor	xmm10, xmm10
	mov	r11, -256
	pxor	xmm13, xmm13
	pxor	xmm14, xmm14
	pxor	xmm15, xmm15
	pxor	xmm4, xmm4
	pxor	xmm11, xmm11
	pxor	xmm2, xmm2
	pxor	xmm3, xmm3
	.p2align	4
12:
	movdqu	xmm5, xmmword ptr [r9 + r11 + 64]
	movdqa	xmmword ptr [rsp + 64], xmm5
	movdqu	xmm0, xmmword ptr [r9 + r11 + 80]
	movdqa	xmmword ptr [rsp], xmm0
	movdqu	xmm12, xmmword ptr [r9 + r11 + 96]
	movdqa	xmmword ptr [rsp + 16], xmm12
	movdqu	xmm6, xmmword ptr [r9 + r11 + 112]
	movdqu	xmm7, xmmword ptr [rcx + r11 + 256]
	movdqu	xmm8, xmmword ptr [rcx + r11 + 272]
	movdqu	xmm9, xmmword ptr [rcx + r11 + 288]
	movdqa	xmm1, xmm2
	movdqu	xmm2, xmmword ptr [rcx + r11 + 304]
	pxor	xmm2, xmm6
	pxor	xmm9, xmm12
	pxor	xmm8, xmm0
	pxor	xmm7, xmm5
	movdqa	xmm0, xmm11
	movdqa	xmm11, xmm7
	psrlq	xmm11, 32
	movdqa	xmm12, xmm8
	psrlq	xmm12, 32
	movdqa	xmm5, xmm13
	movdqa	xmm13, xmm10
	movdqa	xmm10, xmm2
	psrlq	xmm10, 32
	pmuludq	xmm10, xmm2
	movdqa	xmm2, xmm9
	psrlq	xmm2, 32
	paddq	xmm3, xmm10
	pmuludq	xmm2, xmm9
	paddq	xmm1, xmm2
	movdqa	xmmword ptr [rsp + 80], xmm1
	pmuludq	xmm12, xmm8
	paddq	xmm0, xmm12
	movdqa	xmmword ptr [rsp + 96], xmm0
	pmuludq	xmm11, xmm7
	paddq	xmm13, xmm11
	movdqa	xmmword ptr [rsp + 112], xmm13
	movdqa	xmm13, xmm5
	paddq	xmm4, xmm6
	paddq	xmm15, xmmword ptr [rsp + 16]
	paddq	xmm13, xmmword ptr [rsp + 64]
	paddq	xmm14, xmmword ptr [rsp]
	movdqu	xmm9, xmmword ptr [r9 + r11 + 176]
	movdqu	xmm8, xmmword ptr [r9 + r11 + 160]
	movdqu	xmm0, xmmword ptr [r9 + r11 + 144]
	movdqa	xmmword ptr [rsp], xmm0
	movdqu	xmm11, xmmword ptr [r9 + r11 + 128]
	movdqu	xmm2, xmmword ptr [rcx + r11 + 368]
	movdqu	xmm5, xmmword ptr [rcx + r11 + 352]
	movdqu	xmm6, xmmword ptr [rcx + r11 + 336]
	movdqu	xmm12, xmmword ptr [rcx + r11 + 320]
	pxor	xmm12, xmm11
	pxor	xmm6, xmm0
	pxor	xmm5, xmm8
	pxor	xmm2, xmm9
	movdqa	xmm1, xmm2
	psrlq	xmm1, 32
	movdqa	xmm0, xmm5
	psrlq	xmm0, 32
	movdqa	xmm10, xmm12
	psrlq	xmm10, 32
	pmuludq	xmm10, xmm12
	movdqa	xmm12, xmm6
	psrlq	xmm12, 32
	pmuludq	xmm12, xmm6
	pmuludq	xmm0, xmm5
	pmuludq	xmm1, xmm2
	movdqu	xmm5, xmmword ptr [r9 + r11 + 240]
	movdqa	xmmword ptr [rsp + 16], xmm5
	movdqu	xmm2, xmmword ptr [rcx + r11 + 432]
	pxor	xmm2, xmm5
	movdqa	xmm6, xmm2
	psrlq	xmm6, 32
	pmuludq	xmm6, xmm2
	movdqu	xmm7, xmmword ptr [r9 + r11 + 224]
	paddq	xmm6, xmm1
	movdqu	xmm1, xmmword ptr [rcx + r11 + 416]
	pxor	xmm1, xmm7
	paddq	xmm6, xmm3
	movdqa	xmm3, xmm1
	psrlq	xmm3, 32
	pmuludq	xmm3, xmm1
	movdqu	xmm5, xmmword ptr [r9 + r11 + 208]
	paddq	xmm3, xmm0
	movdqu	xmm0, xmmword ptr [rcx + r11 + 400]
	pxor	xmm0, xmm5
	paddq	xmm3, xmmword ptr [rsp + 80]
	movdqa	xmm2, xmm0
	psrlq	xmm2, 32
	pmuludq	xmm2, xmm0
	movdqu	xmm1, xmmword ptr [r9 + r11 + 192]
	paddq	xmm2, xmm12
	movdqu	xmm12, xmmword ptr [rcx + r11 + 384]
	pxor	xmm12, xmm1
	paddq	xmm2, xmmword ptr [rsp + 96]
	movdqa	xmm0, xmm12
	psrlq	xmm0, 32
	pmuludq	xmm0, xmm12
	paddq	xmm0, xmm10
	paddq	xmm0, xmmword ptr [rsp + 112]
	paddq	xmm9, xmmword ptr [rsp + 16]
	paddq	xmm4, xmm9
	paddq	xmm8, xmm7
	paddq	xmm15, xmm8
	paddq	xmm11, xmm1
	paddq	xmm13, xmm11
	movdqa	xmm1, xmmword ptr [rsp]
	paddq	xmm1, xmm5
	paddq	xmm14, xmm1
	movdqu	xmm5, xmmword ptr [r9 + r11 + 304]
	movdqu	xmm7, xmmword ptr [r9 + r11 + 288]
	movdqu	xmm9, xmmword ptr [r9 + r11 + 272]
	movdqu	xmm8, xmmword ptr [r9 + r11 + 256]
	movdqu	xmm1, xmmword ptr [rcx + r11 + 448]
	pxor	xmm1, xmm8
	movdqa	xmm10, xmm1
	psrlq	xmm10, 32
	pmuludq	xmm10, xmm1
	movdqu	xmm1, xmmword ptr [rcx + r11 + 464]
	pxor	xmm1, xmm9
	paddq	xmm10, xmm0
	movdqa	xmm11, xmm1
	psrlq	xmm11, 32
	pmuludq	xmm11, xmm1
	movdqu	xmm0, xmmword ptr [rcx + r11 + 480]
	pxor	xmm0, xmm7
	paddq	xmm11, xmm2
	movdqa	xmm2, xmm0
	psrlq	xmm2, 32
	pmuludq	xmm2, xmm0
	movdqu	xmm0, xmmword ptr [rcx + r11 + 496]
	pxor	xmm0, xmm5
	paddq	xmm2, xmm3
	movdqa	xmm3, xmm0
	psrlq	xmm3, 32
	pmuludq	xmm3, xmm0
	paddq	xmm3, xmm6
	paddq	xmm14, xmm9
	paddq	xmm13, xmm8
	paddq	xmm15, xmm7
	paddq	xmm4, xmm5
	add	r11, 256
	cmp	r11, 768
	jb	12b
	paddq	xmm3, xmmword ptr [rsp + 192]
	pshufd	xmm0, xmm4, 78
	paddq	xmm3, xmm0
	paddq	xmm2, xmmword ptr [rsp + 208]
	pshufd	xmm0, xmm15, 78
	paddq	xmm2, xmm0
	pshufd	xmm0, xmm14, 78
	pshufd	xmm1, xmm13, 78
	paddq	xmm11, xmmword ptr [rsp + 32]
	paddq	xmm11, xmm0
	paddq	xmm10, xmmword ptr [rsp + 48]
	paddq	xmm10, xmm1
	movdqa	xmm0, xmmword ptr [rsp + 128]
	pxor	xmm0, xmm3
	psrlq	xmm3, 47
	pxor	xmm3, xmm0
	movdqa	xmm0, xmmword ptr [rsp + 144]
	pxor	xmm0, xmm2
	psrlq	xmm2, 47
	pxor	xmm2, xmm0
	movdqa	xmm0, xmmword ptr [rsp + 160]
	pxor	xmm0, xmm11
	psrlq	xmm11, 47
	pxor	xmm11, xmm0
	movdqa	xmm0, xmmword ptr [rsp + 176]
	pxor	xmm0, xmm10
	psrlq	xmm10, 47
	pxor	xmm10, xmm0
	movdqa	xmm0, xmm10
	movdqa	xmm1, xmmword ptr [rip + 92f]
	pmuludq	xmm0, xmm1
	psrlq	xmm10, 32
	pmuludq	xmm10, xmm1
	psllq	xmm10, 32
	paddq	xmm10, xmm0
	movdqa	xmm0, xmm11
	pmuludq	xmm0, xmm1
	psrlq	xmm11, 32
	pmuludq	xmm11, xmm1
	psllq	xmm11, 32
	paddq	xmm11, xmm0
	movdqa	xmm0, xmm2
	pmuludq	xmm0, xmm1
	psrlq	xmm2, 32
	pmuludq	xmm2, xmm1
	psllq	xmm2, 32
	paddq	xmm2, xmm0
	movdqa	xmm0, xmm3
	pmuludq	xmm0, xmm1
	psrlq	xmm3, 32
	pmuludq	xmm3, xmm1
	psllq	xmm3, 32
	paddq	xmm3, xmm0
	inc	r10
	add	r9, 1024
	cmp	r10, r8
	movdqa	xmm1, xmm10
	movdqa	xmm4, xmm11
	movdqa	xmm5, xmm2
	movdqa	xmm6, xmm3
	jne	2b
	jmp	32f
22:
	movdqa	xmm10, xmm1
	movdqa	xmm11, xmm4
	movdqa	xmm2, xmm5
	movdqa	xmm3, xmm6
32:
	movdqa	xmmword ptr [rsp + 80], xmm2
	movdqa	xmmword ptr [rsp + 96], xmm11
	movdqa	xmmword ptr [rsp + 112], xmm10
	mov	r8, rax
	and	r8, -1024
	mov	r9, rax
	and	r9, 768
	je	52f
	lea	r10, [r8 + rsi + 192]
	pxor	xmm13, xmm13
	xor	r11d, r11d
	pxor	xmm14, xmm14
	pxor	xmm0, xmm0
	movdqa	xmmword ptr [rsp], xmm0
	pxor	xmm4, xmm4
	pxor	xmm5, xmm5
	pxor	xmm8, xmm8
	pxor	xmm11, xmm11
	.p2align	4
42:
	movdqu	xmm6, xmmword ptr [r10 + r11 - 192]
	movdqu	xmm15, xmmword ptr [r10 + r11 - 176]
	movdqu	xmm7, xmmword ptr [r10 + r11 - 160]
	movdqu	xmm9, xmmword ptr [r10 + r11 - 144]
	movdqu	xmm1, xmmword ptr [rcx + r11]
	movdqu	xmm10, xmmword ptr [rcx + r11 + 16]
	movdqu	xmm2, xmmword ptr [rcx + r11 + 48]
	pxor	xmm2, xmm9
	movdqa	xmm12, xmm2
	psrlq	xmm12, 32
	pmuludq	xmm12, xmm2
	movdqu	xmm2, xmmword ptr [rcx + r11 + 32]
	pxor	xmm2, xmm7
	pxor	xmm10, xmm15
	pxor	xmm1, xmm6
	paddq	xmm11, xmm12
	movdqa	xmm12, xmm2
	psrlq	xmm12, 32
	pmuludq	xmm12, xmm2
	movdqa	xmm2, xmm1
	psrlq	xmm2, 32
	paddq	xmm8, xmm12
	movdqa	xmm12, xmm10
	psrlq	xmm12, 32
	pmuludq	xmm12, xmm10
	paddq	xmm5, xmm12
	pmuludq	xmm2, xmm1
	paddq	xmm4, xmm2
	paddq	xmm0, xmm9
	movdqa	xmmword ptr [rsp + 16], xmm0
	movdqa	xmm0, xmmword ptr [rsp]
	paddq	xmm0, xmm7
	movdqa	xmmword ptr [rsp], xmm0
	paddq	xmm13, xmm6
	movdqa	xmmword ptr [rsp + 64], xmm13
	paddq	xmm14, xmm15
	movdqa	xmmword ptr [rsp + 48], xmm14
	movdqu	xmm10, xmmword ptr [r10 + r11 - 80]
	movdqu	xmm9, xmmword ptr [r10 + r11 - 96]
	movdqu	xmm7, xmmword ptr [r10 + r11 - 112]
	movdqu	xmm6, xmmword ptr [r10 + r11 - 128]
	movdqu	xmm1, xmmword ptr [rcx + r11 + 96]
	movdqu	xmm0, xmmword ptr [rcx + r11 + 80]
	movdqu	xmm2, xmmword ptr [rcx + r11 + 64]
	pxor	xmm2, xmm6
	pxor	xmm0, xmm7
	pxor	xmm1, xmm9
	movdqa	xmm13, xmm2
	psrlq	xmm13, 32
	pmuludq	xmm13, xmm2
	movdqa	xmm14, xmm0
	psrlq	xmm14, 32
	pmuludq	xmm14, xmm0
	movdqa	xmm0, xmm1
	psrlq	xmm0, 32
	pmuludq	xmm0, xmm1
	movdqu	xmm1, xmmword ptr [rcx + r11 + 112]
	pxor	xmm1, xmm10
	movdqa	xmm2, xmm1
	psrlq	xmm2, 32
	pmuludq	xmm2, xmm1
	movdqu	xmm12, xmmword ptr [r10 + r11 - 16]
	movdqa	xmmword ptr [rsp + 32], xmm12
	movdqu	xmm1, xmmword ptr [rcx + r11 + 176]
	pxor	xmm1, xmm12
	movdqa	xmm12, xmm1
	psrlq	xmm12, 32
	pmuludq	xmm12, xmm1
	paddq	xmm12, xmm2
	paddq	xmm12, xmm11
	movdqu	xmm1, xmmword ptr [r10 + r11 - 32]
	movdqu	xmm2, xmmword ptr [rcx + r11 + 160]
	pxor	xmm2, xmm1
	movdqa	xmm11, xmm2
	psrlq	xmm11, 32
	pmuludq	xmm11, xmm2
	paddq	xmm11, xmm0
	paddq	xmm11, xmm8
	movdqu	xmm15, xmmword ptr [r10 + r11 - 48]
	movdqu	xmm0, xmmword ptr [rcx + r11 + 144]
	pxor	xmm0, xmm15
	movdqa	xmm8, xmm0
	psrlq	xmm8, 32
	pmuludq	xmm8, xmm0
	paddq	xmm8, xmm14
	paddq	xmm8, xmm5
	movdqu	xmm2, xmmword ptr [r10 + r11 - 64]
	movdqu	xmm5, xmmword ptr [rcx + r11 + 128]
	pxor	xmm5, xmm2
	movdqa	xmm0, xmm5
	psrlq	xmm0, 32
	pmuludq	xmm0, xmm5
	paddq	xmm0, xmm13
	paddq	xmm0, xmm4
	paddq	xmm10, xmmword ptr [rsp + 32]
	paddq	xmm10, xmmword ptr [rsp + 16]
	paddq	xmm9, xmm1
	paddq	xmm9, xmmword ptr [rsp]
	paddq	xmm6, xmm2
	paddq	xmm6, xmmword ptr [rsp + 64]
	paddq	xmm7, xmm15
	paddq	xmm7, xmmword ptr [rsp + 48]
	movdqu	xmm2, xmmword ptr [r10 + r11 + 48]
	movdqu	xmm14, xmmword ptr [r10 + r11 + 32]
	movdqu	xmm13, xmmword ptr [r10 + r11 + 16]
	movdqu	xmm15, xmmword ptr [r10 + r11]
	movdqu	xmm1, xmmword ptr [rcx + r11 + 192]
	pxor	xmm1, xmm15
	movdqa	xmm4, xmm1
	psrlq	xmm4, 32
	pmuludq	xmm4, xmm1
	movdqu	xmm1, xmmword ptr [rcx + r11 + 208]
	pxor	xmm1, xmm13
	paddq	xmm4, xmm0
	movdqa	xmm5, xmm1
	psrlq	xmm5, 32
	pmuludq	xmm5, xmm1
	movdqu	xmm0, xmmword ptr [rcx + r11 + 224]
	pxor	xmm0, xmm14
	paddq	xmm5, xmm8
	movdqa	xmm8, xmm0
	psrlq	xmm8, 32
	pmuludq	xmm8, xmm0
	movdqu	xmm0, xmmword ptr [rcx + r11 + 240]
	pxor	xmm0, xmm2
	paddq	xmm8, xmm11
	movdqa	xmm11, xmm0
	psrlq	xmm11, 32
	pmuludq	xmm11, xmm0
	paddq	xmm11, xmm12
	paddq	xmm7, xmm13
	paddq	xmm6, xmm15
	paddq	xmm9, xmm14
	paddq	xmm10, xmm2
	add	r11, 256
	cmp	r11, r9
	movdqa	xmm13, xmm6
	movdqa	xmm14, xmm7
	movdqa	xmmword ptr [rsp], xmm9
	movdqa	xmm0, xmm10
	jb	42b
	and	eax, 960
	cmp	r9d, eax
	jb	62f
	jmp	82f
52:
	pxor	xmm4, xmm4
	pxor	xmm5, xmm5
	pxor	xmm8, xmm8
	pxor	xmm11, xmm11
	pxor	xmm6, xmm6
	pxor	xmm7, xmm7
	pxor	xmm9, xmm9
	pxor	xmm10, xmm10
	and	eax, 960
	cmp	r9d, eax
	jae	82f
62:
	add	r8, rsi
	.p2align	4
72:
	movdqu	xmm0, xmmword ptr [r8 + r9]
	movdqu	xmm14, xmmword ptr [r8 + r9 + 16]
	movdqu	xmm13, xmmword ptr [r8 + r9 + 32]
	movdqu	xmm12, xmmword ptr [r8 + r9 + 48]
	movdqu	xmm1, xmmword ptr [rcx + r9]
	pxor	xmm1, xmm0
	movdqa	xmm2, xmm1
	psrlq	xmm2, 32
	pmuludq	xmm2, xmm1
	movdqu	xmm1, xmmword ptr [rcx + r9 + 16]
	pxor	xmm1, xmm14
	paddq	xmm4, xmm2
	movdqa	xmm2, xmm1
	psrlq	xmm2, 32
	pmuludq	xmm2, xmm1
	movdqu	xmm1, xmmword ptr [rcx + r9 + 32]
	pxor	xmm1, xmm13
	paddq	xmm5, xmm2
	movdqa	xmm2, xmm1
	psrlq	xmm2, 32
	pmuludq	xmm2, xmm1
	movdqu	xmm1, xmmword ptr [rcx + r9 + 48]
	pxor	xmm1, xmm12
	paddq	xmm8, xmm2
	movdqa	xmm2, xmm1
	psrlq	xmm2, 32
	pmuludq	xmm2, xmm1
	paddq	xmm11, xmm2
	paddq	xmm7, xmm14
	paddq	xmm6, xmm0
	paddq	xmm9, xmm13
	paddq	xmm10, xmm12
	add	r9, 64
	cmp	r9, rax
	jb	72b
82:
	movdqu	xmm2, xmmword ptr [rsi + rdx - 64]
	movdqa	xmmword ptr [rsp], xmm2
	movdqu	xmm0, xmmword ptr [rsi + rdx - 48]
	movdqa	xmmword ptr [rsp + 16], xmm0
	movdqu	xmm1, xmmword ptr [rcx + 1088]
	pxor	xmm1, xmm2
	movdqa	xmm13, xmm1
	psrlq	xmm13, 32
	pmuludq	xmm13, xmm1
	movdqu	xmm2, xmmword ptr [rcx + 1104]
	pxor	xmm2, xmm0
	movdqa	xmm12, xmm2
	psrlq	xmm12, 32
	pmuludq	xmm12, xmm2
	movdqu	xmm2, xmmword ptr [rsi + rdx - 32]
	movdqu	xmm14, xmmword ptr [rcx + 1120]
	pxor	xmm14, xmm2
	movdqa	xmm15, xmm14
	psrlq	xmm15, 32
	pmuludq	xmm15, xmm14
	movdqu	xmm14, xmmword ptr [rsi + rdx - 16]
	movdqu	xmm0, xmmword ptr [rcx + 1136]
	pxor	xmm0, xmm14
	movdqa	xmm1, xmm0
	psrlq	xmm1, 32
	pmuludq	xmm1, xmm0
	paddq	xmm6, xmmword ptr [rsp]
	paddq	xmm7, xmmword ptr [rsp + 16]
	paddq	xmm9, xmm2
	paddq	xmm10, xmm14
	pshufd	xmm0, xmm10, 78
	paddq	xmm3, xmm0
	paddq	xmm3, xmm11
	paddq	xmm3, xmm1
	pshufd	xmm0, xmm9, 78
	movdqa	xmm9, xmmword ptr [rsp + 80]
	paddq	xmm9, xmm0
	paddq	xmm9, xmm8
	paddq	xmm9, xmm15
	pshufd	xmm0, xmm7, 78
	movdqa	xmm2, xmmword ptr [rsp + 96]
	paddq	xmm2, xmm0
	paddq	xmm2, xmm5
	paddq	xmm2, xmm12
	pshufd	xmm0, xmm6, 78
	movdqa	xmm1, xmmword ptr [rsp + 112]
	paddq	xmm1, xmm0
	paddq	xmm1, xmm4
	paddq	xmm1, xmm13
	movdqu	xmmword ptr [rdi], xmm1
	movdqu	xmmword ptr [rdi + 16], xmm2
	movdqu	xmmword ptr [rdi + 32], xmm9
	movdqu	xmmword ptr [rdi + 48], xmm3
	add	rsp, 232
	ret
	.p2align	4, 0x0
92:
	.quad	2654435761
	.quad	2654435761

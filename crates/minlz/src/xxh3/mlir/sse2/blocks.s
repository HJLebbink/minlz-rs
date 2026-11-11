# minlz_xxh3_blocks of crates/minlz/mlir/xxh3.mlir for sse2, written by
# cargo xtask mlir. Do not edit.
	movdqu	xmm1, xmmword ptr [rdi]
	movdqu	xmm2, xmmword ptr [rdi + 16]
	movdqu	xmm3, xmmword ptr [rdi + 32]
	movdqu	xmm4, xmmword ptr [rdi + 48]
	test	rdx, rdx
	jle	22f
	sub	rsp, 200
	movups	xmm0, xmmword ptr [rcx + 1024]
	movaps	xmmword ptr [rsp + 96], xmm0
	movups	xmm0, xmmword ptr [rcx + 1040]
	movaps	xmmword ptr [rsp + 80], xmm0
	movups	xmm0, xmmword ptr [rcx + 1056]
	movaps	xmmword ptr [rsp + 64], xmm0
	movdqu	xmm0, xmmword ptr [rcx + 1072]
	movdqa	xmmword ptr [rsp + 48], xmm0
	add	rsi, 192
	xor	eax, eax
	.p2align	4
2:
	movdqa	xmmword ptr [rsp + 112], xmm4
	movdqa	xmmword ptr [rsp + 128], xmm3
	movdqa	xmmword ptr [rsp + 144], xmm2
	movdqa	xmmword ptr [rsp + 160], xmm1
	pxor	xmm5, xmm5
	mov	r8, -256
	pxor	xmm6, xmm6
	pxor	xmm14, xmm14
	pxor	xmm15, xmm15
	pxor	xmm0, xmm0
	pxor	xmm8, xmm8
	pxor	xmm11, xmm11
	pxor	xmm13, xmm13
	.p2align	4
12:
	movdqu	xmm9, xmmword ptr [rsi + r8 + 64]
	movdqa	xmmword ptr [rsp + 16], xmm9
	movdqu	xmm7, xmmword ptr [rsi + r8 + 80]
	movdqa	xmmword ptr [rsp + 32], xmm7
	movdqu	xmm12, xmmword ptr [rsi + r8 + 96]
	movdqa	xmmword ptr [rsp], xmm12
	movdqu	xmm2, xmmword ptr [rsi + r8 + 112]
	movdqu	xmm3, xmmword ptr [rcx + r8 + 256]
	movdqu	xmm4, xmmword ptr [rcx + r8 + 272]
	movdqu	xmm10, xmmword ptr [rcx + r8 + 288]
	movdqu	xmm1, xmmword ptr [rcx + r8 + 304]
	pxor	xmm1, xmm2
	pxor	xmm10, xmm12
	pxor	xmm4, xmm7
	pxor	xmm3, xmm9
	movdqa	xmm7, xmm3
	psrlq	xmm7, 32
	movdqa	xmm9, xmm4
	psrlq	xmm9, 32
	movdqa	xmm12, xmm1
	psrlq	xmm12, 32
	pmuludq	xmm12, xmm1
	movdqa	xmm1, xmm10
	psrlq	xmm1, 32
	paddq	xmm13, xmm12
	pmuludq	xmm1, xmm10
	paddq	xmm11, xmm1
	pmuludq	xmm9, xmm4
	paddq	xmm8, xmm9
	pmuludq	xmm7, xmm3
	paddq	xmm5, xmm7
	paddq	xmm0, xmm2
	paddq	xmm15, xmmword ptr [rsp]
	paddq	xmm6, xmmword ptr [rsp + 16]
	movdqa	xmmword ptr [rsp], xmm6
	paddq	xmm14, xmmword ptr [rsp + 32]
	movdqu	xmm1, xmmword ptr [rsi + r8 + 176]
	movdqu	xmm3, xmmword ptr [rsi + r8 + 160]
	movdqu	xmm7, xmmword ptr [rsi + r8 + 144]
	movdqa	xmmword ptr [rsp + 32], xmm7
	movdqu	xmm9, xmmword ptr [rsi + r8 + 128]
	movdqa	xmmword ptr [rsp + 16], xmm9
	movdqu	xmm2, xmmword ptr [rcx + r8 + 368]
	movdqu	xmm4, xmmword ptr [rcx + r8 + 352]
	movdqu	xmm10, xmmword ptr [rcx + r8 + 336]
	movdqu	xmm6, xmmword ptr [rcx + r8 + 320]
	pxor	xmm6, xmm9
	pxor	xmm10, xmm7
	pxor	xmm4, xmm3
	pxor	xmm2, xmm1
	movdqa	xmm9, xmm2
	psrlq	xmm9, 32
	movdqa	xmm12, xmm4
	psrlq	xmm12, 32
	movdqa	xmm7, xmm6
	psrlq	xmm7, 32
	pmuludq	xmm7, xmm6
	movdqa	xmm6, xmm10
	psrlq	xmm6, 32
	pmuludq	xmm6, xmm10
	pmuludq	xmm12, xmm4
	pmuludq	xmm9, xmm2
	movdqu	xmm2, xmmword ptr [rsi + r8 + 240]
	movdqa	xmmword ptr [rsp + 176], xmm2
	movdqu	xmm4, xmmword ptr [rcx + r8 + 432]
	pxor	xmm4, xmm2
	movdqa	xmm2, xmm4
	psrlq	xmm2, 32
	pmuludq	xmm2, xmm4
	movdqu	xmm4, xmmword ptr [rsi + r8 + 224]
	paddq	xmm2, xmm9
	movdqu	xmm9, xmmword ptr [rcx + r8 + 416]
	pxor	xmm9, xmm4
	paddq	xmm2, xmm13
	movdqa	xmm13, xmm9
	psrlq	xmm13, 32
	pmuludq	xmm13, xmm9
	movdqu	xmm9, xmmword ptr [rsi + r8 + 208]
	paddq	xmm13, xmm12
	movdqu	xmm10, xmmword ptr [rcx + r8 + 400]
	pxor	xmm10, xmm9
	paddq	xmm13, xmm11
	movdqa	xmm11, xmm10
	psrlq	xmm11, 32
	pmuludq	xmm11, xmm10
	movdqu	xmm10, xmmword ptr [rsi + r8 + 192]
	paddq	xmm11, xmm6
	movdqu	xmm6, xmmword ptr [rcx + r8 + 384]
	pxor	xmm6, xmm10
	paddq	xmm11, xmm8
	movdqa	xmm8, xmm6
	psrlq	xmm8, 32
	pmuludq	xmm8, xmm6
	paddq	xmm8, xmm7
	paddq	xmm8, xmm5
	paddq	xmm1, xmmword ptr [rsp + 176]
	paddq	xmm0, xmm1
	paddq	xmm3, xmm4
	paddq	xmm15, xmm3
	movdqa	xmm3, xmmword ptr [rsp + 16]
	paddq	xmm3, xmm10
	movdqa	xmm1, xmmword ptr [rsp]
	paddq	xmm1, xmm3
	movdqa	xmmword ptr [rsp], xmm1
	movdqa	xmm1, xmmword ptr [rsp + 32]
	paddq	xmm1, xmm9
	paddq	xmm14, xmm1
	movdqu	xmm4, xmmword ptr [rsi + r8 + 304]
	movdqu	xmm7, xmmword ptr [rsi + r8 + 288]
	movdqu	xmm1, xmmword ptr [rsi + r8 + 272]
	movdqu	xmm3, xmmword ptr [rsi + r8 + 256]
	movdqu	xmm6, xmmword ptr [rcx + r8 + 448]
	pxor	xmm6, xmm3
	movdqa	xmm5, xmm6
	psrlq	xmm5, 32
	pmuludq	xmm5, xmm6
	movdqu	xmm6, xmmword ptr [rcx + r8 + 464]
	pxor	xmm6, xmm1
	paddq	xmm5, xmm8
	movdqa	xmm8, xmm6
	psrlq	xmm8, 32
	pmuludq	xmm8, xmm6
	movdqu	xmm6, xmmword ptr [rcx + r8 + 480]
	pxor	xmm6, xmm7
	paddq	xmm8, xmm11
	movdqa	xmm11, xmm6
	psrlq	xmm11, 32
	pmuludq	xmm11, xmm6
	movdqu	xmm6, xmmword ptr [rcx + r8 + 496]
	pxor	xmm6, xmm4
	paddq	xmm11, xmm13
	movdqa	xmm13, xmm6
	psrlq	xmm13, 32
	pmuludq	xmm13, xmm6
	movdqa	xmm6, xmmword ptr [rsp]
	paddq	xmm13, xmm2
	paddq	xmm14, xmm1
	paddq	xmm6, xmm3
	paddq	xmm15, xmm7
	paddq	xmm0, xmm4
	add	r8, 256
	cmp	r8, 768
	jb	12b
	paddq	xmm13, xmmword ptr [rsp + 112]
	pshufd	xmm0, xmm0, 78
	paddq	xmm13, xmm0
	paddq	xmm11, xmmword ptr [rsp + 128]
	pshufd	xmm0, xmm15, 78
	paddq	xmm11, xmm0
	pshufd	xmm0, xmm14, 78
	pshufd	xmm1, xmm6, 78
	paddq	xmm8, xmmword ptr [rsp + 144]
	paddq	xmm8, xmm0
	paddq	xmm5, xmmword ptr [rsp + 160]
	paddq	xmm5, xmm1
	movdqa	xmm0, xmmword ptr [rsp + 48]
	pxor	xmm0, xmm13
	psrlq	xmm13, 47
	pxor	xmm13, xmm0
	movdqa	xmm0, xmmword ptr [rsp + 64]
	pxor	xmm0, xmm11
	psrlq	xmm11, 47
	pxor	xmm11, xmm0
	movdqa	xmm0, xmmword ptr [rsp + 80]
	pxor	xmm0, xmm8
	psrlq	xmm8, 47
	pxor	xmm8, xmm0
	movdqa	xmm0, xmmword ptr [rsp + 96]
	pxor	xmm0, xmm5
	psrlq	xmm5, 47
	pxor	xmm5, xmm0
	movdqa	xmm0, xmm5
	movdqa	xmm1, xmmword ptr [rip + 42f]
	pmuludq	xmm0, xmm1
	psrlq	xmm5, 32
	pmuludq	xmm5, xmm1
	psllq	xmm5, 32
	paddq	xmm5, xmm0
	movdqa	xmm0, xmm8
	pmuludq	xmm0, xmm1
	psrlq	xmm8, 32
	pmuludq	xmm8, xmm1
	psllq	xmm8, 32
	paddq	xmm8, xmm0
	movdqa	xmm0, xmm11
	pmuludq	xmm0, xmm1
	psrlq	xmm11, 32
	pmuludq	xmm11, xmm1
	psllq	xmm11, 32
	paddq	xmm11, xmm0
	movdqa	xmm0, xmm13
	pmuludq	xmm0, xmm1
	psrlq	xmm13, 32
	pmuludq	xmm13, xmm1
	psllq	xmm13, 32
	paddq	xmm13, xmm0
	inc	rax
	add	rsi, 1024
	cmp	rax, rdx
	movdqa	xmm1, xmm5
	movdqa	xmm2, xmm8
	movdqa	xmm3, xmm11
	movdqa	xmm4, xmm13
	jne	2b
	add	rsp, 200
	jmp	32f
22:
	movdqa	xmm5, xmm1
	movdqa	xmm8, xmm2
	movdqa	xmm11, xmm3
	movdqa	xmm13, xmm4
32:
	movdqu	xmmword ptr [rdi], xmm5
	movdqu	xmmword ptr [rdi + 16], xmm8
	movdqu	xmmword ptr [rdi + 32], xmm11
	movdqu	xmmword ptr [rdi + 48], xmm13
	ret
	.p2align	4, 0x0
42:
	.quad	2654435761
	.quad	2654435761

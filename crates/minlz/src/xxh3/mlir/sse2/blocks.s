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
	lea	rax, [rsi + 192]
	xor	r8d, r8d
	.p2align	4
2:
	movdqa	xmmword ptr [rsp + 112], xmm4
	movdqa	xmmword ptr [rsp + 128], xmm3
	movdqa	xmmword ptr [rsp + 144], xmm2
	movdqa	xmmword ptr [rsp + 160], xmm1
	mov	r9, r8
	shl	r9, 10
	prefetcht0	byte ptr [rsi + r9 + 4096]
	prefetcht0	byte ptr [rsi + r9 + 4160]
	prefetcht0	byte ptr [rsi + r9 + 4224]
	prefetcht0	byte ptr [rsi + r9 + 4288]
	prefetcht0	byte ptr [rsi + r9 + 4352]
	prefetcht0	byte ptr [rsi + r9 + 4416]
	prefetcht0	byte ptr [rsi + r9 + 4480]
	prefetcht0	byte ptr [rsi + r9 + 4544]
	prefetcht0	byte ptr [rsi + r9 + 4608]
	prefetcht0	byte ptr [rsi + r9 + 4672]
	prefetcht0	byte ptr [rsi + r9 + 4736]
	prefetcht0	byte ptr [rsi + r9 + 4800]
	prefetcht0	byte ptr [rsi + r9 + 4864]
	prefetcht0	byte ptr [rsi + r9 + 4928]
	prefetcht0	byte ptr [rsi + r9 + 4992]
	prefetcht0	byte ptr [rsi + r9 + 5056]
	pxor	xmm6, xmm6
	mov	r9, -256
	pxor	xmm5, xmm5
	pxor	xmm14, xmm14
	pxor	xmm15, xmm15
	pxor	xmm0, xmm0
	pxor	xmm10, xmm10
	pxor	xmm11, xmm11
	pxor	xmm13, xmm13
	.p2align	4
12:
	movdqu	xmm8, xmmword ptr [rax + r9 + 64]
	movdqa	xmmword ptr [rsp + 16], xmm8
	movdqu	xmm7, xmmword ptr [rax + r9 + 80]
	movdqa	xmmword ptr [rsp + 32], xmm7
	movdqu	xmm12, xmmword ptr [rax + r9 + 96]
	movdqa	xmmword ptr [rsp], xmm12
	movdqu	xmm2, xmmword ptr [rax + r9 + 112]
	movdqu	xmm3, xmmword ptr [rcx + r9 + 256]
	movdqu	xmm4, xmmword ptr [rcx + r9 + 272]
	movdqu	xmm9, xmmword ptr [rcx + r9 + 288]
	movdqu	xmm1, xmmword ptr [rcx + r9 + 304]
	pxor	xmm1, xmm2
	pxor	xmm9, xmm12
	pxor	xmm4, xmm7
	pxor	xmm3, xmm8
	movdqa	xmm7, xmm3
	psrlq	xmm7, 32
	movdqa	xmm8, xmm4
	psrlq	xmm8, 32
	movdqa	xmm12, xmm1
	psrlq	xmm12, 32
	pmuludq	xmm12, xmm1
	movdqa	xmm1, xmm9
	psrlq	xmm1, 32
	paddq	xmm13, xmm12
	pmuludq	xmm1, xmm9
	paddq	xmm11, xmm1
	pmuludq	xmm8, xmm4
	paddq	xmm10, xmm8
	pmuludq	xmm7, xmm3
	paddq	xmm6, xmm7
	paddq	xmm0, xmm2
	paddq	xmm15, xmmword ptr [rsp]
	paddq	xmm5, xmmword ptr [rsp + 16]
	movdqa	xmmword ptr [rsp], xmm5
	paddq	xmm14, xmmword ptr [rsp + 32]
	movdqu	xmm1, xmmword ptr [rax + r9 + 176]
	movdqu	xmm3, xmmword ptr [rax + r9 + 160]
	movdqu	xmm7, xmmword ptr [rax + r9 + 144]
	movdqa	xmmword ptr [rsp + 32], xmm7
	movdqu	xmm8, xmmword ptr [rax + r9 + 128]
	movdqa	xmmword ptr [rsp + 16], xmm8
	movdqu	xmm2, xmmword ptr [rcx + r9 + 368]
	movdqu	xmm4, xmmword ptr [rcx + r9 + 352]
	movdqu	xmm9, xmmword ptr [rcx + r9 + 336]
	movdqu	xmm5, xmmword ptr [rcx + r9 + 320]
	pxor	xmm5, xmm8
	pxor	xmm9, xmm7
	pxor	xmm4, xmm3
	pxor	xmm2, xmm1
	movdqa	xmm8, xmm2
	psrlq	xmm8, 32
	movdqa	xmm12, xmm4
	psrlq	xmm12, 32
	movdqa	xmm7, xmm5
	psrlq	xmm7, 32
	pmuludq	xmm7, xmm5
	movdqa	xmm5, xmm9
	psrlq	xmm5, 32
	pmuludq	xmm5, xmm9
	pmuludq	xmm12, xmm4
	pmuludq	xmm8, xmm2
	movdqu	xmm2, xmmword ptr [rax + r9 + 240]
	movdqa	xmmword ptr [rsp + 176], xmm2
	movdqu	xmm4, xmmword ptr [rcx + r9 + 432]
	pxor	xmm4, xmm2
	movdqa	xmm2, xmm4
	psrlq	xmm2, 32
	pmuludq	xmm2, xmm4
	movdqu	xmm4, xmmword ptr [rax + r9 + 224]
	paddq	xmm2, xmm8
	movdqu	xmm8, xmmword ptr [rcx + r9 + 416]
	pxor	xmm8, xmm4
	paddq	xmm2, xmm13
	movdqa	xmm13, xmm8
	psrlq	xmm13, 32
	pmuludq	xmm13, xmm8
	movdqu	xmm8, xmmword ptr [rax + r9 + 208]
	paddq	xmm13, xmm12
	movdqu	xmm9, xmmword ptr [rcx + r9 + 400]
	pxor	xmm9, xmm8
	paddq	xmm13, xmm11
	movdqa	xmm11, xmm9
	psrlq	xmm11, 32
	pmuludq	xmm11, xmm9
	movdqu	xmm12, xmmword ptr [rax + r9 + 192]
	paddq	xmm11, xmm5
	movdqu	xmm5, xmmword ptr [rcx + r9 + 384]
	pxor	xmm5, xmm12
	paddq	xmm11, xmm10
	movdqa	xmm9, xmm5
	psrlq	xmm9, 32
	pmuludq	xmm9, xmm5
	paddq	xmm9, xmm7
	paddq	xmm9, xmm6
	paddq	xmm1, xmmword ptr [rsp + 176]
	paddq	xmm0, xmm1
	paddq	xmm3, xmm4
	paddq	xmm15, xmm3
	movdqa	xmm3, xmmword ptr [rsp + 16]
	paddq	xmm3, xmm12
	movdqa	xmm1, xmmword ptr [rsp]
	paddq	xmm1, xmm3
	movdqa	xmmword ptr [rsp], xmm1
	movdqa	xmm1, xmmword ptr [rsp + 32]
	paddq	xmm1, xmm8
	paddq	xmm14, xmm1
	movdqu	xmm4, xmmword ptr [rax + r9 + 304]
	movdqu	xmm7, xmmword ptr [rax + r9 + 288]
	movdqu	xmm1, xmmword ptr [rax + r9 + 272]
	movdqu	xmm3, xmmword ptr [rax + r9 + 256]
	movdqu	xmm5, xmmword ptr [rcx + r9 + 448]
	pxor	xmm5, xmm3
	movdqa	xmm6, xmm5
	psrlq	xmm6, 32
	pmuludq	xmm6, xmm5
	movdqu	xmm5, xmmword ptr [rcx + r9 + 464]
	pxor	xmm5, xmm1
	paddq	xmm6, xmm9
	movdqa	xmm10, xmm5
	psrlq	xmm10, 32
	pmuludq	xmm10, xmm5
	movdqu	xmm5, xmmword ptr [rcx + r9 + 480]
	pxor	xmm5, xmm7
	paddq	xmm10, xmm11
	movdqa	xmm11, xmm5
	psrlq	xmm11, 32
	pmuludq	xmm11, xmm5
	movdqu	xmm5, xmmword ptr [rcx + r9 + 496]
	pxor	xmm5, xmm4
	paddq	xmm11, xmm13
	movdqa	xmm13, xmm5
	psrlq	xmm13, 32
	pmuludq	xmm13, xmm5
	movdqa	xmm5, xmmword ptr [rsp]
	paddq	xmm13, xmm2
	paddq	xmm14, xmm1
	paddq	xmm5, xmm3
	paddq	xmm15, xmm7
	paddq	xmm0, xmm4
	add	r9, 256
	cmp	r9, 768
	jb	12b
	paddq	xmm13, xmmword ptr [rsp + 112]
	pshufd	xmm0, xmm0, 78
	paddq	xmm13, xmm0
	paddq	xmm11, xmmword ptr [rsp + 128]
	pshufd	xmm0, xmm15, 78
	paddq	xmm11, xmm0
	pshufd	xmm0, xmm14, 78
	pshufd	xmm1, xmm5, 78
	paddq	xmm10, xmmword ptr [rsp + 144]
	paddq	xmm10, xmm0
	paddq	xmm6, xmmword ptr [rsp + 160]
	paddq	xmm6, xmm1
	movdqa	xmm0, xmmword ptr [rsp + 48]
	pxor	xmm0, xmm13
	psrlq	xmm13, 47
	pxor	xmm13, xmm0
	movdqa	xmm0, xmmword ptr [rsp + 64]
	pxor	xmm0, xmm11
	psrlq	xmm11, 47
	pxor	xmm11, xmm0
	movdqa	xmm0, xmmword ptr [rsp + 80]
	pxor	xmm0, xmm10
	psrlq	xmm10, 47
	pxor	xmm10, xmm0
	movdqa	xmm0, xmmword ptr [rsp + 96]
	pxor	xmm0, xmm6
	psrlq	xmm6, 47
	pxor	xmm6, xmm0
	movdqa	xmm0, xmm6
	movdqa	xmm1, xmmword ptr [rip + 42f]
	pmuludq	xmm0, xmm1
	psrlq	xmm6, 32
	pmuludq	xmm6, xmm1
	psllq	xmm6, 32
	paddq	xmm6, xmm0
	movdqa	xmm0, xmm10
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
	movdqa	xmm0, xmm13
	pmuludq	xmm0, xmm1
	psrlq	xmm13, 32
	pmuludq	xmm13, xmm1
	psllq	xmm13, 32
	paddq	xmm13, xmm0
	inc	r8
	add	rax, 1024
	cmp	r8, rdx
	movdqa	xmm1, xmm6
	movdqa	xmm2, xmm10
	movdqa	xmm3, xmm11
	movdqa	xmm4, xmm13
	jne	2b
	add	rsp, 200
	jmp	32f
22:
	movdqa	xmm6, xmm1
	movdqa	xmm10, xmm2
	movdqa	xmm11, xmm3
	movdqa	xmm13, xmm4
32:
	movdqu	xmmword ptr [rdi], xmm6
	movdqu	xmmword ptr [rdi + 16], xmm10
	movdqu	xmmword ptr [rdi + 32], xmm11
	movdqu	xmmword ptr [rdi + 48], xmm13
	ret
	.p2align	4, 0x0
42:
	.quad	2654435761
	.quad	2654435761

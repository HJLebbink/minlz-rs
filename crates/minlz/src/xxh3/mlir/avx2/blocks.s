# minlz_xxh3_blocks of crates/minlz/mlir/xxh3.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	vmovdqu	ymm2, ymmword ptr [rdi]
	vmovdqu	ymm4, ymmword ptr [rdi + 32]
	test	rdx, rdx
	jle	22f
	vmovups	ymm0, ymmword ptr [rcx + 1024]
	vmovups	ymmword ptr [rsp - 72], ymm0
	vmovdqu	ymm0, ymmword ptr [rcx + 1056]
	vmovdqu	ymmword ptr [rsp - 104], ymm0
	add	rsi, 192
	xor	eax, eax
	vpbroadcastq	ymm3, qword ptr [rip + 32f]
	.p2align	4
2:
	vmovdqu	ymmword ptr [rsp - 40], ymm2
	vpxor	xmm6, xmm6, xmm6
	mov	r8, -256
	vpxor	xmm7, xmm7, xmm7
	vpxor	xmm8, xmm8, xmm8
	vpxor	xmm5, xmm5, xmm5
	.p2align	4
12:
	vmovdqu	ymm9, ymmword ptr [rsi + r8 + 64]
	vmovdqu	ymm10, ymmword ptr [rsi + r8 + 96]
	vmovdqu	ymm11, ymmword ptr [rsi + r8 + 128]
	vmovdqu	ymm12, ymmword ptr [rsi + r8 + 160]
	vpxor	ymm13, ymm10, ymmword ptr [rcx + r8 + 288]
	vpxor	ymm14, ymm9, ymmword ptr [rcx + r8 + 256]
	vpsrlq	ymm15, ymm14, 32
	vpsrlq	ymm1, ymm13, 32
	vpmuludq	ymm1, ymm13, ymm1
	vpaddq	ymm1, ymm1, ymm6
	vpmuludq	ymm6, ymm14, ymm15
	vpaddq	ymm5, ymm6, ymm5
	vpaddq	ymm6, ymm9, ymm7
	vpaddq	ymm7, ymm10, ymm8
	vpxor	ymm8, ymm11, ymmword ptr [rcx + r8 + 320]
	vpxor	ymm9, ymm12, ymmword ptr [rcx + r8 + 352]
	vpsrlq	ymm10, ymm9, 32
	vpsrlq	ymm13, ymm8, 32
	vpmuludq	ymm8, ymm8, ymm13
	vpmuludq	ymm9, ymm9, ymm10
	vmovdqu	ymm10, ymmword ptr [rsi + r8 + 192]
	vmovdqu	ymm13, ymmword ptr [rsi + r8 + 224]
	vpxor	ymm14, ymm13, ymmword ptr [rcx + r8 + 416]
	vpxor	ymm15, ymm10, ymmword ptr [rcx + r8 + 384]
	vpsrlq	ymm2, ymm15, 32
	vpsrlq	ymm0, ymm14, 32
	vpmuludq	ymm0, ymm14, ymm0
	vpaddq	ymm0, ymm9, ymm0
	vpaddq	ymm0, ymm1, ymm0
	vpmuludq	ymm1, ymm15, ymm2
	vpaddq	ymm1, ymm8, ymm1
	vpaddq	ymm1, ymm5, ymm1
	vpaddq	ymm2, ymm11, ymm10
	vpaddq	ymm2, ymm6, ymm2
	vpaddq	ymm5, ymm12, ymm13
	vpaddq	ymm7, ymm7, ymm5
	vmovdqu	ymm8, ymmword ptr [rsi + r8 + 288]
	vmovdqu	ymm9, ymmword ptr [rsi + r8 + 256]
	vpxor	ymm5, ymm9, ymmword ptr [rcx + r8 + 448]
	vpxor	ymm6, ymm8, ymmword ptr [rcx + r8 + 480]
	vpsrlq	ymm10, ymm6, 32
	vpsrlq	ymm11, ymm5, 32
	vpmuludq	ymm5, ymm11, ymm5
	vpaddq	ymm5, ymm1, ymm5
	vpmuludq	ymm1, ymm10, ymm6
	vpaddq	ymm6, ymm0, ymm1
	vpaddq	ymm8, ymm8, ymm7
	vpaddq	ymm7, ymm9, ymm2
	add	r8, 256
	cmp	r8, 768
	jb	12b
	vpshufd	ymm0, ymm8, 78
	vpshufd	ymm1, ymm7, 78
	vpaddq	ymm2, ymm6, ymm4
	vpaddq	ymm0, ymm2, ymm0
	vpaddq	ymm2, ymm5, ymmword ptr [rsp - 40]
	vpaddq	ymm1, ymm2, ymm1
	vpsrlq	ymm2, ymm0, 47
	vpsrlq	ymm4, ymm1, 47
	vpxor	ymm0, ymm0, ymmword ptr [rsp - 104]
	vpxor	ymm0, ymm0, ymm2
	vpxor	ymm1, ymm1, ymmword ptr [rsp - 72]
	vpxor	ymm1, ymm1, ymm4
	vpmuludq	ymm2, ymm1, ymm3
	vpsrlq	ymm1, ymm1, 32
	vpmuludq	ymm1, ymm1, ymm3
	vpsllq	ymm1, ymm1, 32
	vpaddq	ymm2, ymm2, ymm1
	vpmuludq	ymm1, ymm0, ymm3
	vpsrlq	ymm0, ymm0, 32
	vpmuludq	ymm0, ymm0, ymm3
	vpsllq	ymm0, ymm0, 32
	vpaddq	ymm4, ymm1, ymm0
	inc	rax
	add	rsi, 1024
	cmp	rax, rdx
	jne	2b
22:
	vmovdqu	ymmword ptr [rdi], ymm2
	vmovdqu	ymmword ptr [rdi + 32], ymm4
	vzeroupper
	ret
	.p2align	3, 0x0
32:
	.quad	2654435761

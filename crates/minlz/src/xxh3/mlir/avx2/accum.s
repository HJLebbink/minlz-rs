# minlz_xxh3_accum of crates/minlz/mlir/xxh3.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	lea	rax, [rdx - 1]
	mov	r8, rax
	shr	r8, 10
	vmovdqu	ymm15, ymmword ptr [rdi]
	vmovdqu	ymm1, ymmword ptr [rdi + 32]
	je	22f
	vmovups	ymm0, ymmword ptr [rcx + 1024]
	vmovups	ymmword ptr [rsp - 72], ymm0
	vmovdqu	ymm0, ymmword ptr [rcx + 1056]
	vmovdqu	ymmword ptr [rsp - 104], ymm0
	lea	r9, [rsi + 192]
	xor	r10d, r10d
	vpbroadcastq	ymm4, qword ptr [rip + 82f]
	.p2align	4
2:
	vmovdqu	ymmword ptr [rsp - 40], ymm15
	vpxor	xmm6, xmm6, xmm6
	mov	r11, -256
	vpxor	xmm7, xmm7, xmm7
	vpxor	xmm8, xmm8, xmm8
	vpxor	xmm5, xmm5, xmm5
	.p2align	4
12:
	vmovdqu	ymm9, ymmword ptr [r9 + r11 + 64]
	vmovdqu	ymm10, ymmword ptr [r9 + r11 + 96]
	vmovdqu	ymm11, ymmword ptr [r9 + r11 + 128]
	vmovdqu	ymm12, ymmword ptr [r9 + r11 + 160]
	vpxor	ymm13, ymm10, ymmword ptr [rcx + r11 + 288]
	vpxor	ymm14, ymm9, ymmword ptr [rcx + r11 + 256]
	vpsrlq	ymm15, ymm14, 32
	vpsrlq	ymm2, ymm13, 32
	vpmuludq	ymm2, ymm13, ymm2
	vpaddq	ymm2, ymm2, ymm6
	vpmuludq	ymm6, ymm14, ymm15
	vpaddq	ymm5, ymm6, ymm5
	vpaddq	ymm6, ymm9, ymm7
	vpaddq	ymm7, ymm10, ymm8
	vpxor	ymm8, ymm11, ymmword ptr [rcx + r11 + 320]
	vpxor	ymm9, ymm12, ymmword ptr [rcx + r11 + 352]
	vpsrlq	ymm10, ymm9, 32
	vpsrlq	ymm13, ymm8, 32
	vpmuludq	ymm8, ymm8, ymm13
	vpmuludq	ymm9, ymm9, ymm10
	vmovdqu	ymm10, ymmword ptr [r9 + r11 + 192]
	vmovdqu	ymm13, ymmword ptr [r9 + r11 + 224]
	vpxor	ymm14, ymm13, ymmword ptr [rcx + r11 + 416]
	vpxor	ymm15, ymm10, ymmword ptr [rcx + r11 + 384]
	vpsrlq	ymm3, ymm15, 32
	vpsrlq	ymm0, ymm14, 32
	vpmuludq	ymm0, ymm14, ymm0
	vpaddq	ymm0, ymm9, ymm0
	vpaddq	ymm0, ymm2, ymm0
	vpmuludq	ymm2, ymm15, ymm3
	vpaddq	ymm2, ymm8, ymm2
	vpaddq	ymm2, ymm5, ymm2
	vpaddq	ymm3, ymm11, ymm10
	vpaddq	ymm3, ymm6, ymm3
	vpaddq	ymm5, ymm12, ymm13
	vpaddq	ymm7, ymm7, ymm5
	vmovdqu	ymm8, ymmword ptr [r9 + r11 + 288]
	vmovdqu	ymm9, ymmword ptr [r9 + r11 + 256]
	vpxor	ymm5, ymm9, ymmword ptr [rcx + r11 + 448]
	vpxor	ymm6, ymm8, ymmword ptr [rcx + r11 + 480]
	vpsrlq	ymm10, ymm6, 32
	vpsrlq	ymm11, ymm5, 32
	vpmuludq	ymm5, ymm11, ymm5
	vpaddq	ymm5, ymm2, ymm5
	vpmuludq	ymm2, ymm10, ymm6
	vpaddq	ymm6, ymm0, ymm2
	vpaddq	ymm8, ymm8, ymm7
	vpaddq	ymm7, ymm9, ymm3
	add	r11, 256
	cmp	r11, 768
	jb	12b
	vpshufd	ymm0, ymm8, 78
	vpshufd	ymm2, ymm7, 78
	vpaddq	ymm1, ymm6, ymm1
	vpaddq	ymm0, ymm1, ymm0
	vpaddq	ymm1, ymm5, ymmword ptr [rsp - 40]
	vpaddq	ymm1, ymm1, ymm2
	vpsrlq	ymm2, ymm0, 47
	vpsrlq	ymm3, ymm1, 47
	vpxor	ymm0, ymm0, ymmword ptr [rsp - 104]
	vpxor	ymm0, ymm0, ymm2
	vpxor	ymm1, ymm1, ymmword ptr [rsp - 72]
	vpxor	ymm1, ymm1, ymm3
	vpmuludq	ymm2, ymm1, ymm4
	vpsrlq	ymm1, ymm1, 32
	vpmuludq	ymm1, ymm1, ymm4
	vpsllq	ymm1, ymm1, 32
	vpaddq	ymm15, ymm2, ymm1
	vpmuludq	ymm1, ymm0, ymm4
	vpsrlq	ymm0, ymm0, 32
	vpmuludq	ymm0, ymm0, ymm4
	vpsllq	ymm0, ymm0, 32
	vpaddq	ymm1, ymm1, ymm0
	inc	r10
	add	r9, 1024
	cmp	r10, r8
	jne	2b
22:
	mov	r8, rax
	and	r8, -1024
	mov	r9, rax
	and	r9, 768
	je	42f
	lea	r10, [r8 + rsi + 192]
	vpxor	xmm4, xmm4, xmm4
	xor	r11d, r11d
	vpxor	xmm5, xmm5, xmm5
	vpxor	xmm2, xmm2, xmm2
	vpxor	xmm3, xmm3, xmm3
	.p2align	4
32:
	vmovdqu	ymm0, ymmword ptr [r10 + r11 - 192]
	vmovdqu	ymm6, ymmword ptr [r10 + r11 - 160]
	vmovdqu	ymm7, ymmword ptr [r10 + r11 - 128]
	vmovdqu	ymm8, ymmword ptr [r10 + r11 - 96]
	vpxor	ymm9, ymm6, ymmword ptr [rcx + r11 + 32]
	vpxor	ymm10, ymm0, ymmword ptr [rcx + r11]
	vpsrlq	ymm11, ymm10, 32
	vpsrlq	ymm12, ymm9, 32
	vpmuludq	ymm9, ymm9, ymm12
	vpaddq	ymm3, ymm9, ymm3
	vpmuludq	ymm9, ymm10, ymm11
	vpaddq	ymm2, ymm9, ymm2
	vpaddq	ymm0, ymm0, ymm4
	vpaddq	ymm4, ymm6, ymm5
	vpxor	ymm5, ymm7, ymmword ptr [rcx + r11 + 64]
	vpxor	ymm6, ymm8, ymmword ptr [rcx + r11 + 96]
	vpsrlq	ymm9, ymm6, 32
	vpsrlq	ymm10, ymm5, 32
	vpmuludq	ymm5, ymm10, ymm5
	vpmuludq	ymm6, ymm9, ymm6
	vmovdqu	ymm9, ymmword ptr [r10 + r11 - 64]
	vmovdqu	ymm10, ymmword ptr [r10 + r11 - 32]
	vpxor	ymm11, ymm10, ymmword ptr [rcx + r11 + 160]
	vpxor	ymm12, ymm9, ymmword ptr [rcx + r11 + 128]
	vpsrlq	ymm13, ymm12, 32
	vpsrlq	ymm14, ymm11, 32
	vpmuludq	ymm11, ymm11, ymm14
	vpaddq	ymm6, ymm11, ymm6
	vpaddq	ymm3, ymm3, ymm6
	vpmuludq	ymm6, ymm12, ymm13
	vpaddq	ymm5, ymm5, ymm6
	vpaddq	ymm2, ymm2, ymm5
	vpaddq	ymm5, ymm9, ymm7
	vpaddq	ymm0, ymm0, ymm5
	vpaddq	ymm5, ymm8, ymm10
	vpaddq	ymm4, ymm4, ymm5
	vmovdqu	ymm5, ymmword ptr [r10 + r11 + 32]
	vmovdqu	ymm6, ymmword ptr [r10 + r11]
	vpxor	ymm7, ymm6, ymmword ptr [rcx + r11 + 192]
	vpxor	ymm8, ymm5, ymmword ptr [rcx + r11 + 224]
	vpsrlq	ymm9, ymm8, 32
	vpsrlq	ymm10, ymm7, 32
	vpmuludq	ymm7, ymm10, ymm7
	vpaddq	ymm2, ymm2, ymm7
	vpmuludq	ymm7, ymm8, ymm9
	vpaddq	ymm3, ymm3, ymm7
	vpaddq	ymm5, ymm4, ymm5
	vpaddq	ymm4, ymm0, ymm6
	add	r11, 256
	cmp	r11, r9
	jb	32b
	and	eax, 960
	cmp	r9d, eax
	jb	52f
	jmp	72f
42:
	vpxor	xmm2, xmm2, xmm2
	vpxor	xmm3, xmm3, xmm3
	vpxor	xmm4, xmm4, xmm4
	vpxor	xmm5, xmm5, xmm5
	and	eax, 960
	cmp	r9d, eax
	jae	72f
52:
	add	r8, rsi
	.p2align	4
62:
	vmovdqu	ymm0, ymmword ptr [r8 + r9]
	vmovdqu	ymm6, ymmword ptr [r8 + r9 + 32]
	vpxor	ymm7, ymm0, ymmword ptr [rcx + r9]
	vpxor	ymm8, ymm6, ymmword ptr [rcx + r9 + 32]
	vpsrlq	ymm9, ymm8, 32
	vpsrlq	ymm10, ymm7, 32
	vpmuludq	ymm7, ymm10, ymm7
	vpaddq	ymm2, ymm7, ymm2
	vpmuludq	ymm7, ymm8, ymm9
	vpaddq	ymm3, ymm7, ymm3
	vpaddq	ymm5, ymm6, ymm5
	vpaddq	ymm4, ymm0, ymm4
	add	r9, 64
	cmp	r9, rax
	jb	62b
72:
	vmovdqu	ymm0, ymmword ptr [rsi + rdx - 64]
	vmovdqu	ymm6, ymmword ptr [rsi + rdx - 32]
	vpxor	ymm7, ymm6, ymmword ptr [rcx + 1120]
	vpxor	ymm8, ymm0, ymmword ptr [rcx + 1088]
	vpsrlq	ymm9, ymm8, 32
	vpsrlq	ymm10, ymm7, 32
	vpmuludq	ymm7, ymm10, ymm7
	vpmuludq	ymm8, ymm8, ymm9
	vpaddq	ymm5, ymm6, ymm5
	vpaddq	ymm0, ymm0, ymm4
	vpshufd	ymm0, ymm0, 78
	vpaddq	ymm0, ymm15, ymm0
	vpaddq	ymm0, ymm8, ymm0
	vpaddq	ymm0, ymm2, ymm0
	vpshufd	ymm2, ymm5, 78
	vpaddq	ymm1, ymm1, ymm2
	vpaddq	ymm1, ymm1, ymm7
	vpaddq	ymm1, ymm3, ymm1
	vmovdqu	ymmword ptr [rdi + 32], ymm1
	vmovdqu	ymmword ptr [rdi], ymm0
	vzeroupper
	ret
	.p2align	3, 0x0
82:
	.quad	2654435761

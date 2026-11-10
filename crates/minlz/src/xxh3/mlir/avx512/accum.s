# minlz_xxh3_accum of crates/minlz/mlir/xxh3.mlir for avx512, written by
# cargo xtask mlir. Do not edit.
	lea	rax, [rdx - 1]
	mov	r8, rax
	shr	r8, 10
	vmovdqu64	zmm0, zmmword ptr [rdi]
	je	12f
	vmovdqu64	zmm1, zmmword ptr [rcx + 1024]
	vmovdqu64	zmm2, zmmword ptr [rcx + 448]
	vmovdqu64	zmm3, zmmword ptr [rcx + 512]
	vmovdqu64	zmm4, zmmword ptr [rcx + 576]
	vmovdqu64	zmm5, zmmword ptr [rcx]
	vmovdqu64	zmm6, zmmword ptr [rcx + 64]
	vmovdqu64	zmm7, zmmword ptr [rcx + 128]
	vmovdqu64	zmm8, zmmword ptr [rcx + 192]
	vmovdqu64	zmm9, zmmword ptr [rcx + 256]
	vmovdqu64	zmm10, zmmword ptr [rcx + 320]
	vmovdqu64	zmm11, zmmword ptr [rcx + 384]
	vmovdqu64	zmm12, zmmword ptr [rcx + 640]
	vmovdqu64	zmm13, zmmword ptr [rcx + 704]
	vmovdqu64	zmm14, zmmword ptr [rcx + 768]
	vmovdqu64	zmm15, zmmword ptr [rcx + 832]
	vmovdqu64	zmm16, zmmword ptr [rcx + 896]
	vmovdqu64	zmm17, zmmword ptr [rcx + 960]
	lea	r9, [rsi + 960]
	vpbroadcastq	zmm18, qword ptr [rip + 72f]
	.p2align	4
2:
	vmovdqu64	zmm19, zmmword ptr [r9 - 960]
	vmovdqu64	zmm20, zmmword ptr [r9 - 896]
	vmovdqu64	zmm21, zmmword ptr [r9 - 832]
	vmovdqu64	zmm22, zmmword ptr [r9 - 768]
	vpxorq	zmm23, zmm5, zmm19
	vpsrlq	zmm24, zmm23, 32
	vpmuludq	zmm23, zmm23, zmm24
	vpxorq	zmm24, zmm6, zmm20
	vpsrlq	zmm25, zmm24, 32
	vpmuludq	zmm24, zmm24, zmm25
	vpaddq	zmm23, zmm23, zmm24
	vpaddq	zmm19, zmm19, zmm20
	vpxorq	zmm20, zmm7, zmm21
	vpsrlq	zmm24, zmm20, 32
	vpmuludq	zmm20, zmm20, zmm24
	vpxorq	zmm24, zmm8, zmm22
	vpsrlq	zmm25, zmm24, 32
	vpmuludq	zmm24, zmm24, zmm25
	vpaddq	zmm20, zmm20, zmm24
	vpaddq	zmm20, zmm23, zmm20
	vpaddq	zmm21, zmm21, zmm22
	vpaddq	zmm19, zmm19, zmm21
	vmovdqu64	zmm21, zmmword ptr [r9 - 704]
	vpxorq	zmm22, zmm9, zmm21
	vpsrlq	zmm23, zmm22, 32
	vpmuludq	zmm22, zmm22, zmm23
	vmovdqu64	zmm23, zmmword ptr [r9 - 640]
	vpxorq	zmm24, zmm10, zmm23
	vpsrlq	zmm25, zmm24, 32
	vpmuludq	zmm24, zmm24, zmm25
	vpaddq	zmm22, zmm22, zmm24
	vpaddq	zmm21, zmm21, zmm23
	vmovdqu64	zmm23, zmmword ptr [r9 - 576]
	vpxorq	zmm24, zmm11, zmm23
	vpsrlq	zmm25, zmm24, 32
	vpmuludq	zmm24, zmm24, zmm25
	vpaddq	zmm22, zmm22, zmm24
	vpaddq	zmm20, zmm22, zmm20
	vpaddq	zmm21, zmm21, zmm23
	vpaddq	zmm19, zmm21, zmm19
	vmovdqu64	zmm21, zmmword ptr [r9 - 512]
	vpxorq	zmm22, zmm2, zmm21
	vpsrlq	zmm23, zmm22, 32
	vpmuludq	zmm22, zmm22, zmm23
	vmovdqu64	zmm23, zmmword ptr [r9 - 448]
	vpxorq	zmm24, zmm3, zmm23
	vpsrlq	zmm25, zmm24, 32
	vpmuludq	zmm24, zmm24, zmm25
	vpaddq	zmm22, zmm24, zmm22
	vpaddq	zmm21, zmm23, zmm21
	vmovdqu64	zmm23, zmmword ptr [r9 - 384]
	vpxorq	zmm24, zmm4, zmm23
	vpsrlq	zmm25, zmm24, 32
	vpmuludq	zmm24, zmm24, zmm25
	vpaddq	zmm22, zmm22, zmm24
	vpaddq	zmm21, zmm21, zmm23
	vmovdqu64	zmm23, zmmword ptr [r9 - 320]
	vpxorq	zmm24, zmm12, zmm23
	vpsrlq	zmm25, zmm24, 32
	vpmuludq	zmm24, zmm24, zmm25
	vpaddq	zmm22, zmm22, zmm24
	vpaddq	zmm20, zmm22, zmm20
	vpaddq	zmm21, zmm21, zmm23
	vpaddq	zmm19, zmm21, zmm19
	vmovdqu64	zmm21, zmmword ptr [r9 - 256]
	vpxorq	zmm22, zmm13, zmm21
	vpsrlq	zmm23, zmm22, 32
	vpmuludq	zmm22, zmm22, zmm23
	vmovdqu64	zmm23, zmmword ptr [r9 - 192]
	vpxorq	zmm24, zmm14, zmm23
	vpsrlq	zmm25, zmm24, 32
	vpmuludq	zmm24, zmm24, zmm25
	vpaddq	zmm22, zmm24, zmm22
	vpaddq	zmm21, zmm23, zmm21
	vmovdqu64	zmm23, zmmword ptr [r9 - 128]
	vpxorq	zmm24, zmm15, zmm23
	vpsrlq	zmm25, zmm24, 32
	vpmuludq	zmm24, zmm24, zmm25
	vpaddq	zmm22, zmm22, zmm24
	vpaddq	zmm21, zmm21, zmm23
	vmovdqu64	zmm23, zmmword ptr [r9 - 64]
	vpxorq	zmm24, zmm16, zmm23
	vpsrlq	zmm25, zmm24, 32
	vpmuludq	zmm24, zmm24, zmm25
	vpaddq	zmm22, zmm22, zmm24
	vpaddq	zmm21, zmm21, zmm23
	vmovdqu64	zmm23, zmmword ptr [r9]
	vpxorq	zmm24, zmm17, zmm23
	vpsrlq	zmm25, zmm24, 32
	vpmuludq	zmm24, zmm24, zmm25
	vpaddq	zmm22, zmm22, zmm24
	vpaddq	zmm20, zmm22, zmm20
	vpaddq	zmm21, zmm21, zmm23
	vpaddq	zmm19, zmm21, zmm19
	vpshufd	zmm19, zmm19, 78
	vpaddq	zmm0, zmm0, zmm19
	vpaddq	zmm0, zmm20, zmm0
	vpsrlq	zmm19, zmm0, 47
	vpternlogq	zmm19, zmm1, zmm0, 150
	vpmuludq	zmm0, zmm19, zmm18
	vpsrlq	zmm19, zmm19, 32
	vpmuludq	zmm19, zmm19, zmm18
	vpsllq	zmm19, zmm19, 32
	vpaddq	zmm0, zmm0, zmm19
	add	r9, 1024
	dec	r8
	jne	2b
12:
	mov	r8, rax
	and	r8, -1024
	mov	r9, rax
	and	r9, 768
	je	32f
	lea	r10, [r8 + rsi + 192]
	vpxor	xmm2, xmm2, xmm2
	xor	r11d, r11d
	vpxor	xmm1, xmm1, xmm1
	.p2align	4
22:
	vmovdqu64	zmm3, zmmword ptr [r10 + r11 - 192]
	vmovdqu64	zmm4, zmmword ptr [r10 + r11 - 128]
	vmovdqu64	zmm5, zmmword ptr [r10 + r11 - 64]
	vmovdqu64	zmm6, zmmword ptr [r10 + r11]
	vpxorq	zmm7, zmm3, zmmword ptr [rcx + r11]
	vpsrlq	zmm8, zmm7, 32
	vpmuludq	zmm7, zmm7, zmm8
	vpaddq	zmm1, zmm7, zmm1
	vpaddq	zmm2, zmm3, zmm2
	vpxorq	zmm3, zmm4, zmmword ptr [rcx + r11 + 64]
	vpsrlq	zmm7, zmm3, 32
	vpmuludq	zmm3, zmm3, zmm7
	vpxorq	zmm7, zmm5, zmmword ptr [rcx + r11 + 128]
	vpsrlq	zmm8, zmm7, 32
	vpmuludq	zmm7, zmm7, zmm8
	vpaddq	zmm3, zmm3, zmm7
	vpaddq	zmm1, zmm1, zmm3
	vpaddq	zmm3, zmm4, zmm5
	vpaddq	zmm2, zmm2, zmm3
	vpxorq	zmm3, zmm6, zmmword ptr [rcx + r11 + 192]
	vpsrlq	zmm4, zmm3, 32
	vpmuludq	zmm3, zmm3, zmm4
	vpaddq	zmm1, zmm1, zmm3
	vpaddq	zmm2, zmm2, zmm6
	add	r11, 256
	cmp	r11, r9
	jb	22b
	and	eax, 960
	cmp	r9d, eax
	jb	42f
	jmp	62f
32:
	vpxor	xmm1, xmm1, xmm1
	vpxor	xmm2, xmm2, xmm2
	and	eax, 960
	cmp	r9d, eax
	jae	62f
42:
	add	r8, rsi
	.p2align	4
52:
	vmovdqu64	zmm3, zmmword ptr [r8 + r9]
	vpxorq	zmm4, zmm3, zmmword ptr [rcx + r9]
	vpsrlq	zmm5, zmm4, 32
	vpmuludq	zmm4, zmm4, zmm5
	vpaddq	zmm1, zmm4, zmm1
	vpaddq	zmm2, zmm3, zmm2
	add	r9, 64
	cmp	r9, rax
	jb	52b
62:
	vmovdqu64	zmm3, zmmword ptr [rsi + rdx - 64]
	vpxorq	zmm4, zmm3, zmmword ptr [rcx + 1088]
	vpsrlq	zmm5, zmm4, 32
	vpmuludq	zmm4, zmm4, zmm5
	vpaddq	zmm2, zmm3, zmm2
	vpshufd	zmm2, zmm2, 78
	vpaddq	zmm0, zmm0, zmm2
	vpaddq	zmm0, zmm0, zmm4
	vpaddq	zmm0, zmm1, zmm0
	vmovdqu64	zmmword ptr [rdi], zmm0
	vzeroupper
	ret
	.p2align	3, 0x0
72:
	.quad	2654435761

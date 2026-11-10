# minlz_stats_tok of crates/minlz/mlir/stats.mlir for avx512, written by
# cargo xtask mlir. Do not edit.
	test	rsi, rsi
	jle	52f
	push	r15
	push	r14
	push	r12
	push	rbx
	vpxor	xmm0, xmm0, xmm0
	xor	ecx, ecx
	movabs	rax, 70368744177664
	vpbroadcastb	zmm2, byte ptr [rip + 72f]
	vpbroadcastb	zmm3, byte ptr [rip + 82f]
	vpxor	xmm1, xmm1, xmm1
	xor	r9d, r9d
	xor	r10d, r10d
	xor	r8d, r8d
	xor	ebx, ebx
	jmp	22f
	.p2align	4
2:
	xor	ebx, ebx
	xor	r14d, r14d
	xor	r15d, r15d
	xor	r12d, r12d
12:
	add	rcx, r12
	add	r9, r15
	add	r10, r14
	add	r8, rbx
	cmp	r11, rsi
	mov	rbx, r11
	jge	42f
22:
	lea	r11, [rbx + rax]
	cmp	r11, rsi
	mov	r14, rsi
	cmovb	r14, r11
	cmp	rbx, r14
	jge	2b
	vpxor	xmm4, xmm4, xmm4
	vpxor	xmm5, xmm5, xmm5
	vpxor	xmm6, xmm6, xmm6
	vpxor	xmm7, xmm7, xmm7
	.p2align	4
32:
	vmovdqu64	zmm8, zmmword ptr [rdi + rbx]
	vpsrlw	zmm9, zmm8, 2
	vpandq	zmm10, zmm9, zmm2
	vpsadbw	zmm10, zmm10, zmm0
	vpaddq	zmm7, zmm10, zmm7
	vpsrlw	zmm10, zmm8, 1
	vpandq	zmm10, zmm10, zmm3
	vpsadbw	zmm10, zmm10, zmm0
	vpaddq	zmm6, zmm10, zmm6
	vpandq	zmm10, zmm8, zmm3
	vpsadbw	zmm10, zmm10, zmm0
	vpaddq	zmm5, zmm10, zmm5
	vpsrlw	zmm10, zmm8, 7
	vpternlogq	zmm10, zmm3, zmm9, 128
	vpsadbw	zmm9, zmm10, zmm0
	vpaddq	zmm4, zmm9, zmm4
	vpmaxub	zmm1, zmm1, zmm8
	add	rbx, 64
	cmp	rbx, r14
	jl	32b
	vextracti64x4	ymm8, zmm7, 1
	vpaddq	zmm7, zmm7, zmm8
	vextracti128	xmm8, ymm7, 1
	vpaddq	xmm7, xmm8, xmm7
	vpshufd	xmm8, xmm7, 238
	vpaddq	xmm7, xmm8, xmm7
	vmovq	rbx, xmm7
	vextracti64x4	ymm7, zmm6, 1
	vpaddq	zmm6, zmm6, zmm7
	vextracti128	xmm7, ymm6, 1
	vpaddq	xmm6, xmm6, xmm7
	vpshufd	xmm7, xmm6, 238
	vpaddq	xmm6, xmm6, xmm7
	vmovq	r14, xmm6
	vextracti64x4	ymm6, zmm5, 1
	vpaddq	zmm5, zmm5, zmm6
	vextracti128	xmm6, ymm5, 1
	vpaddq	xmm5, xmm5, xmm6
	vpshufd	xmm6, xmm5, 238
	vpaddq	xmm5, xmm5, xmm6
	vmovq	r15, xmm5
	vextracti64x4	ymm5, zmm4, 1
	vpaddq	zmm4, zmm4, zmm5
	vextracti128	xmm5, ymm4, 1
	vpaddq	xmm4, xmm4, xmm5
	vpshufd	xmm5, xmm4, 238
	vpaddq	xmm4, xmm4, xmm5
	vmovq	r12, xmm4
	jmp	12b
42:
	vextracti64x4	ymm0, zmm1, 1
	vpmaxub	ymm0, ymm1, ymm0
	vextracti128	xmm1, ymm0, 1
	vpmaxub	xmm0, xmm0, xmm1
	vpternlogq	xmm0, xmm0, xmm0, 15
	vpsrlw	xmm1, xmm0, 8
	vpminub	xmm0, xmm0, xmm1
	vphminposuw	xmm0, xmm0
	vmovd	esi, xmm0
	xor	eax, eax
	cmp	sil, 120
	setb	al
	pop	rbx
	pop	r12
	pop	r14
	pop	r15
	jmp	62f
52:
	xor	r8d, r8d
	xor	r10d, r10d
	xor	r9d, r9d
	xor	ecx, ecx
	xor	eax, eax
62:
	mov	qword ptr [rdx], r8
	mov	qword ptr [rdx + 8], r10
	mov	qword ptr [rdx + 16], r9
	mov	qword ptr [rdx + 24], rcx
	vzeroupper
	ret
	.p2align	6, 0x0
72:
	.byte	63
	.p2align	6, 0x0
82:
	.byte	1

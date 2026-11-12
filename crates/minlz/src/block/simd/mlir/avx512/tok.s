# minlz_stats_tok of crates/minlz/mlir/stats.mlir for avx512, written by
# cargo xtask mlir. Do not edit.
	test	rsi, rsi
	jle	52f
	push	r15
	push	r14
	push	r13
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
	xor	r15d, r15d
	jmp	22f
	.p2align	4
2:
	xor	r15d, r15d
	xor	r12d, r12d
	xor	ebx, ebx
	xor	r14d, r14d
12:
	add	rcx, r14
	add	r9, rbx
	add	r10, r12
	add	r8, r15
	cmp	r11, rsi
	mov	r15, r11
	jge	42f
22:
	lea	r11, [r15 + rax]
	cmp	r11, rsi
	mov	r12, rsi
	cmovb	r12, r11
	cmp	r15, r12
	jge	2b
	vpxor	xmm4, xmm4, xmm4
	xor	r14d, r14d
	xor	ebx, ebx
	vpxor	xmm5, xmm5, xmm5
	.p2align	4
32:
	vmovdqu64	zmm6, zmmword ptr [rdi + r15]
	vpsadbw	zmm7, zmm6, zmm0
	vpaddq	zmm5, zmm7, zmm5
	vpandq	zmm7, zmm6, zmm2
	vpsadbw	zmm7, zmm7, zmm0
	vpaddq	zmm4, zmm7, zmm4
	vpsllw	zmm7, zmm6, 7
	vpmovb2m	k0, zmm7
	kmovq	r13, k0
	popcnt	r13, r13
	add	rbx, r13
	vpsllw	zmm7, zmm6, 5
	vpternlogq	zmm7, zmm6, zmm3, 128
	vpmovb2m	k0, zmm7
	kmovq	r13, k0
	popcnt	r13, r13
	add	r14, r13
	vpmaxub	zmm1, zmm1, zmm6
	add	r15, 64
	cmp	r15, r12
	jl	32b
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
	pop	r13
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
	sub	r8, r10
	shr	r8, 2
	sub	r10, r9
	shr	r10
	mov	qword ptr [rdx], r8
	mov	qword ptr [rdx + 8], r10
	mov	qword ptr [rdx + 16], r9
	mov	qword ptr [rdx + 24], rcx
	vzeroupper
	ret
	.p2align	6, 0x0
72:
	.byte	3
	.p2align	6, 0x0
82:
	.byte	224

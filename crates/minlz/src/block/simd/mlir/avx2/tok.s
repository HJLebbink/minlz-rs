# minlz_stats_tok of crates/minlz/mlir/stats.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	test	rsi, rsi
	jle	52f
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	vpxor	xmm0, xmm0, xmm0
	xor	ecx, ecx
	movabs	rax, 70368744177664
	vpbroadcastb	ymm2, byte ptr [rip + 72f]
	vpxor	xmm1, xmm1, xmm1
	vpxor	xmm3, xmm3, xmm3
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
	vpxor	xmm5, xmm5, xmm5
	xor	r14d, r14d
	xor	ebx, ebx
	vpxor	xmm4, xmm4, xmm4
	vpxor	xmm6, xmm6, xmm6
	vpxor	xmm7, xmm7, xmm7
	.p2align	4
32:
	vmovdqu	ymm8, ymmword ptr [rdi + r15]
	vmovdqu	ymm9, ymmword ptr [rdi + r15 + 32]
	vpsadbw	ymm10, ymm8, ymm0
	vpaddq	ymm7, ymm10, ymm7
	vpsadbw	ymm10, ymm9, ymm0
	vpaddq	ymm5, ymm10, ymm5
	vpand	ymm10, ymm9, ymm2
	vpand	ymm11, ymm8, ymm2
	vpsadbw	ymm11, ymm11, ymm0
	vpaddq	ymm4, ymm11, ymm4
	vpsadbw	ymm10, ymm10, ymm0
	vpaddq	ymm6, ymm10, ymm6
	vpsllw	ymm10, ymm8, 7
	vpmovmskb	r13d, ymm10
	vpsllw	ymm10, ymm9, 7
	vpmovmskb	ebp, ymm10
	shl	rbp, 32
	or	rbp, r13
	popcnt	r13, rbp
	add	rbx, r13
	vpsllw	ymm10, ymm8, 5
	vpsllw	ymm11, ymm9, 5
	vpand	ymm11, ymm11, ymm9
	vpand	ymm10, ymm10, ymm8
	vpmovmskb	r13d, ymm10
	vpmovmskb	ebp, ymm11
	shl	rbp, 32
	or	rbp, r13
	popcnt	r13, rbp
	add	r14, r13
	vpmaxub	ymm3, ymm9, ymm3
	vpmaxub	ymm1, ymm8, ymm1
	add	r15, 64
	cmp	r15, r12
	jl	32b
	vpaddq	ymm5, ymm7, ymm5
	vextracti128	xmm7, ymm5, 1
	vpaddq	xmm5, xmm5, xmm7
	vpshufd	xmm7, xmm5, 238
	vpaddq	xmm5, xmm5, xmm7
	vmovq	r15, xmm5
	vpaddq	ymm4, ymm4, ymm6
	vextracti128	xmm5, ymm4, 1
	vpaddq	xmm4, xmm4, xmm5
	vpshufd	xmm5, xmm4, 238
	vpaddq	xmm4, xmm4, xmm5
	vmovq	r12, xmm4
	jmp	12b
42:
	vpmaxub	ymm0, ymm1, ymm3
	vextracti128	xmm1, ymm0, 1
	vpmaxub	xmm0, xmm0, xmm1
	vpcmpeqd	xmm1, xmm1, xmm1
	vpxor	xmm0, xmm0, xmm1
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
	pop	rbp
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
	.p2align	5, 0x0
72:
	.byte	3

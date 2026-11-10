# minlz_stats_ll of crates/minlz/mlir/stats.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	test	rsi, rsi
	jle	52f
	vpxor	xmm0, xmm0, xmm0
	xor	ecx, ecx
	movabs	rax, 70368744177664
	vpbroadcastb	ymm1, byte ptr [rip + 62f]
	vpbroadcastb	ymm2, byte ptr [rip + 72f]
	vpcmpeqd	ymm4, ymm4, ymm4
	vpxor	xmm3, xmm3, xmm3
	vpxor	xmm5, xmm5, xmm5
	xor	r8d, r8d
	xor	r10d, r10d
	jmp	22f
	.p2align	4
2:
	xor	r10d, r10d
	xor	r11d, r11d
12:
	add	rcx, r11
	add	r8, r10
	cmp	r9, rsi
	mov	r10, r9
	jge	42f
22:
	lea	r9, [r10 + rax]
	cmp	r9, rsi
	mov	r11, rsi
	cmovb	r11, r9
	cmp	r10, r11
	jge	2b
	vpxor	xmm8, xmm8, xmm8
	vpxor	xmm6, xmm6, xmm6
	vpxor	xmm7, xmm7, xmm7
	vpxor	xmm9, xmm9, xmm9
	.p2align	4
32:
	vmovdqu	ymm10, ymmword ptr [rdi + r10]
	vmovdqu	ymm11, ymmword ptr [rdi + r10 + 32]
	vpsadbw	ymm12, ymm10, ymm0
	vpaddq	ymm9, ymm12, ymm9
	vpsadbw	ymm12, ymm11, ymm0
	vpaddq	ymm8, ymm12, ymm8
	vpcmpeqb	ymm12, ymm11, ymm1
	vpand	ymm12, ymm12, ymm2
	vpcmpeqb	ymm13, ymm10, ymm1
	vpand	ymm13, ymm13, ymm2
	vpsadbw	ymm13, ymm13, ymm0
	vpaddq	ymm6, ymm13, ymm6
	vpsadbw	ymm12, ymm12, ymm0
	vpaddq	ymm7, ymm12, ymm7
	vpaddb	ymm10, ymm10, ymm4
	vpmaxub	ymm3, ymm10, ymm3
	vpaddb	ymm10, ymm11, ymm4
	vpmaxub	ymm5, ymm10, ymm5
	add	r10, 64
	cmp	r10, r11
	jl	32b
	vpaddq	ymm8, ymm9, ymm8
	vextracti128	xmm9, ymm8, 1
	vpaddq	xmm8, xmm8, xmm9
	vpshufd	xmm9, xmm8, 238
	vpaddq	xmm8, xmm8, xmm9
	vmovq	r10, xmm8
	vpaddq	ymm6, ymm6, ymm7
	vextracti128	xmm7, ymm6, 1
	vpaddq	xmm6, xmm6, xmm7
	vpshufd	xmm7, xmm6, 238
	vpaddq	xmm6, xmm6, xmm7
	vmovq	r11, xmm6
	jmp	12b
42:
	vpmaxub	ymm0, ymm3, ymm5
	vextracti128	xmm1, ymm0, 1
	vpmaxub	xmm0, xmm0, xmm1
	vpcmpeqd	xmm1, xmm1, xmm1
	vpxor	xmm0, xmm0, xmm1
	vpsrlw	xmm1, xmm0, 8
	vpminub	xmm0, xmm0, xmm1
	vphminposuw	xmm0, xmm0
	vmovd	esi, xmm0
	xor	eax, eax
	cmp	sil, -33
	setb	al
	mov	qword ptr [rdx], r8
	mov	qword ptr [rdx + 8], rcx
	vzeroupper
	ret
52:
	xor	r8d, r8d
	xor	ecx, ecx
	xor	eax, eax
	mov	qword ptr [rdx], r8
	mov	qword ptr [rdx + 8], rcx
	ret
	.p2align	5, 0x0
62:
	.byte	33
	.p2align	5, 0x0
72:
	.byte	1

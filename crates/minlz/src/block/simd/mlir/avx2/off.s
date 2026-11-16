# minlz_stats_off of crates/minlz/mlir/stats.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	test	rsi, rsi
	jle	42f
	vpxor	xmm0, xmm0, xmm0
	xor	ecx, ecx
	movabs	rax, 70368744177664
	vpbroadcastb	ymm1, byte ptr [rip + 52f]
	vpbroadcastb	ymm2, byte ptr [rip + 62f]
	vpcmpeqd	ymm4, ymm4, ymm4
	vpxor	xmm3, xmm3, xmm3
	vpxor	xmm5, xmm5, xmm5
	xor	r9d, r9d
	jmp	12f
	.p2align	4
2:
	xor	r9d, r9d
	add	rcx, r9
	cmp	r8, rsi
	mov	r9, r8
	jge	32f
12:
	lea	r8, [r9 + rax]
	cmp	r8, rsi
	mov	r10, rsi
	cmovb	r10, r8
	cmp	r9, r10
	jge	2b
	vpxor	xmm6, xmm6, xmm6
	vpxor	xmm7, xmm7, xmm7
	.p2align	4
22:
	vmovdqu	ymm8, ymmword ptr [rdi + r9]
	vmovdqu	ymm9, ymmword ptr [rdi + r9 + 32]
	vpsrlw	ymm10, ymm8, 3
	vpand	ymm10, ymm10, ymm1
	vpsrlw	ymm11, ymm9, 3
	vpand	ymm11, ymm11, ymm1
	vpsubusb	ymm11, ymm11, ymm2
	vpsubusb	ymm10, ymm10, ymm2
	vpsadbw	ymm10, ymm10, ymm0
	vpaddq	ymm7, ymm10, ymm7
	vpsadbw	ymm10, ymm11, ymm0
	vpaddq	ymm6, ymm10, ymm6
	vpaddb	ymm8, ymm8, ymm4
	vpmaxub	ymm3, ymm8, ymm3
	vpaddb	ymm8, ymm9, ymm4
	vpmaxub	ymm5, ymm8, ymm5
	add	r9, 64
	cmp	r9, r10
	jl	22b
	vpaddq	ymm6, ymm7, ymm6
	vextracti128	xmm7, ymm6, 1
	vpaddq	xmm6, xmm6, xmm7
	vpshufd	xmm7, xmm6, 238
	vpaddq	xmm6, xmm6, xmm7
	vmovq	r9, xmm6
	add	rcx, r9
	cmp	r8, rsi
	mov	r9, r8
	jl	12b
32:
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
	cmp	sil, 81
	setb	al
	mov	qword ptr [rdx], rcx
	vzeroupper
	ret
42:
	xor	ecx, ecx
	xor	eax, eax
	mov	qword ptr [rdx], rcx
	ret
	.p2align	5, 0x0
52:
	.byte	31
	.p2align	5, 0x0
62:
	.byte	1

# minlz_stats_off of crates/minlz/mlir/stats.mlir for avx512, written by
# cargo xtask mlir. Do not edit.
	test	rsi, rsi
	jle	42f
	vpxor	xmm0, xmm0, xmm0
	xor	ecx, ecx
	movabs	rax, 70368744177664
	vpbroadcastb	zmm2, byte ptr [rip + 52f]
	vpbroadcastb	zmm3, byte ptr [rip + 62f]
	vpternlogd	zmm4, zmm4, zmm4, 255
	vpxor	xmm1, xmm1, xmm1
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
	vpxor	xmm5, xmm5, xmm5
	.p2align	4
22:
	vmovdqu64	zmm6, zmmword ptr [rdi + r9]
	vpsrlw	zmm7, zmm6, 3
	vpandq	zmm7, zmm7, zmm2
	vpsubusb	zmm7, zmm7, zmm3
	vpsadbw	zmm7, zmm7, zmm0
	vpaddq	zmm5, zmm7, zmm5
	vpaddb	zmm6, zmm6, zmm4
	vpmaxub	zmm1, zmm1, zmm6
	add	r9, 64
	cmp	r9, r10
	jl	22b
	vextracti64x4	ymm6, zmm5, 1
	vpaddq	zmm5, zmm5, zmm6
	vextracti128	xmm6, ymm5, 1
	vpaddq	xmm5, xmm5, xmm6
	vpshufd	xmm6, xmm5, 238
	vpaddq	xmm5, xmm5, xmm6
	vmovq	r9, xmm5
	add	rcx, r9
	cmp	r8, rsi
	mov	r9, r8
	jl	12b
32:
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
	.p2align	6, 0x0
52:
	.byte	31
	.p2align	6, 0x0
62:
	.byte	1

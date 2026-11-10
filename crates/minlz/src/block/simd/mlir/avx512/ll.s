# minlz_stats_ll of crates/minlz/mlir/stats.mlir for avx512, written by
# cargo xtask mlir. Do not edit.
	test	rsi, rsi
	jle	52f
	vpxor	xmm0, xmm0, xmm0
	xor	ecx, ecx
	movabs	rax, 70368744177664
	vpbroadcastb	zmm2, byte ptr [rip + 62f]
	vpternlogd	zmm3, zmm3, zmm3, 255
	vpxor	xmm1, xmm1, xmm1
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
	vpxor	xmm4, xmm4, xmm4
	vpxor	xmm5, xmm5, xmm5
	.p2align	4
32:
	vmovdqu64	zmm6, zmmword ptr [rdi + r10]
	vpsadbw	zmm7, zmm6, zmm0
	vpaddq	zmm5, zmm7, zmm5
	vpcmpeqb	k1, zmm6, zmm2
	vmovdqu8	zmm7 {k1} {z}, zmmword ptr [rip + 72f]
	vpsadbw	zmm7, zmm7, zmm0
	vpaddq	zmm4, zmm7, zmm4
	vpaddb	zmm6, zmm6, zmm3
	vpmaxub	zmm1, zmm1, zmm6
	add	r10, 64
	cmp	r10, r11
	jl	32b
	vextracti64x4	ymm6, zmm5, 1
	vpaddq	zmm5, zmm5, zmm6
	vextracti128	xmm6, ymm5, 1
	vpaddq	xmm5, xmm5, xmm6
	vpshufd	xmm6, xmm5, 238
	vpaddq	xmm5, xmm5, xmm6
	vmovq	r10, xmm5
	vextracti64x4	ymm5, zmm4, 1
	vpaddq	zmm4, zmm4, zmm5
	vextracti128	xmm5, ymm4, 1
	vpaddq	xmm4, xmm4, xmm5
	vpshufd	xmm5, xmm4, 238
	vpaddq	xmm4, xmm4, xmm5
	vmovq	r11, xmm4
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
	.p2align	6, 0x0
62:
	.byte	33
	.p2align	6, 0x0
72:
	.zero	64,1

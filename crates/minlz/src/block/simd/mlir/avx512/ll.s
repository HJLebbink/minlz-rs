# minlz_stats_ll of crates/minlz/mlir/stats.mlir for avx512, written by
# cargo xtask mlir. Do not edit.
	test	rsi, rsi
	jle	52f
	push	r14
	push	rbx
	vpxor	xmm0, xmm0, xmm0
	xor	ecx, ecx
	movabs	rax, 70368744177664
	vpbroadcastb	zmm2, byte ptr [rip + 62f]
	vpternlogd	zmm3, zmm3, zmm3, 255
	vpxor	xmm1, xmm1, xmm1
	xor	r8d, r8d
	xor	r11d, r11d
	jmp	22f
	.p2align	4
2:
	xor	r11d, r11d
	xor	r10d, r10d
12:
	add	rcx, r10
	add	r8, r11
	cmp	r9, rsi
	mov	r11, r9
	jge	42f
22:
	lea	r9, [r11 + rax]
	cmp	r9, rsi
	mov	rbx, rsi
	cmovb	rbx, r9
	cmp	r11, rbx
	jge	2b
	vpxor	xmm4, xmm4, xmm4
	xor	r10d, r10d
	.p2align	4
32:
	vmovdqu64	zmm5, zmmword ptr [rdi + r11]
	vpsadbw	zmm6, zmm5, zmm0
	vpaddq	zmm4, zmm6, zmm4
	vpcmpeqb	k0, zmm5, zmm2
	kmovq	r14, k0
	popcnt	r14, r14
	add	r10, r14
	vpaddb	zmm5, zmm5, zmm3
	vpmaxub	zmm1, zmm1, zmm5
	add	r11, 64
	cmp	r11, rbx
	jl	32b
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
	pop	rbx
	pop	r14
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

# minlz_stats_ll of crates/minlz/mlir/stats.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	test	rsi, rsi
	jle	52f
	push	r15
	push	r14
	push	rbx
	vpxor	xmm0, xmm0, xmm0
	xor	ecx, ecx
	movabs	rax, 70368744177664
	vpbroadcastb	ymm1, byte ptr [rip + 62f]
	vpcmpeqd	ymm3, ymm3, ymm3
	vpxor	xmm2, xmm2, xmm2
	vpxor	xmm4, xmm4, xmm4
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
	vpxor	xmm5, xmm5, xmm5
	xor	r10d, r10d
	vpxor	xmm6, xmm6, xmm6
	.p2align	4
32:
	vmovdqu	ymm7, ymmword ptr [rdi + r11]
	vmovdqu	ymm8, ymmword ptr [rdi + r11 + 32]
	vpsadbw	ymm9, ymm7, ymm0
	vpaddq	ymm6, ymm9, ymm6
	vpsadbw	ymm9, ymm8, ymm0
	vpaddq	ymm5, ymm9, ymm5
	vpcmpeqb	ymm9, ymm7, ymm1
	vpmovmskb	r14d, ymm9
	vpcmpeqb	ymm9, ymm8, ymm1
	vpmovmskb	r15d, ymm9
	shl	r15, 32
	or	r15, r14
	popcnt	r14, r15
	add	r10, r14
	vpaddb	ymm7, ymm7, ymm3
	vpmaxub	ymm2, ymm2, ymm7
	vpaddb	ymm7, ymm8, ymm3
	vpmaxub	ymm4, ymm4, ymm7
	add	r11, 64
	cmp	r11, rbx
	jl	32b
	vpaddq	ymm5, ymm6, ymm5
	vextracti128	xmm6, ymm5, 1
	vpaddq	xmm5, xmm5, xmm6
	vpshufd	xmm6, xmm5, 238
	vpaddq	xmm5, xmm5, xmm6
	vmovq	r11, xmm5
	jmp	12b
42:
	vpmaxub	ymm0, ymm2, ymm4
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
	pop	rbx
	pop	r14
	pop	r15
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

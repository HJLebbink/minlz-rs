# minlz_stats_tok of crates/minlz/mlir/stats.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	test	rsi, rsi
	jle	52f
	push	r15
	push	r14
	push	r12
	push	rbx
	xor	ecx, ecx
	movabs	rax, 70368744177664
	vpxor	xmm4, xmm4, xmm4
	vpxor	xmm2, xmm2, xmm2
	xor	r9d, r9d
	xor	r10d, r10d
	xor	r8d, r8d
	xor	ebx, ebx
	vpxor	xmm0, xmm0, xmm0
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
	vpxor	xmm9, xmm9, xmm9
	vxorps	xmm15, xmm15, xmm15
	vpxor	xmm6, xmm6, xmm6
	vpxor	xmm7, xmm7, xmm7
	vpxor	xmm8, xmm8, xmm8
	vpxor	xmm10, xmm10, xmm10
	vpxor	xmm11, xmm11, xmm11
	vpxor	xmm12, xmm12, xmm12
	.p2align	4
32:
	vmovups	ymmword ptr [rsp - 40], ymm15
	vmovdqu	ymm13, ymmword ptr [rdi + rbx]
	vmovdqu	ymm14, ymmword ptr [rdi + rbx + 32]
	vpsrlw	ymm15, ymm14, 2
	vpsrlw	ymm1, ymm13, 2
	vpbroadcastb	ymm5, byte ptr [rip + 72f]
	vpand	ymm3, ymm1, ymm5
	vpsadbw	ymm3, ymm3, ymm0
	vpaddq	ymm12, ymm12, ymm3
	vpand	ymm3, ymm15, ymm5
	vpsadbw	ymm3, ymm3, ymm0
	vpaddq	ymm9, ymm9, ymm3
	vpsrlw	ymm3, ymm13, 1
	vpbroadcastb	ymm5, byte ptr [rip + 82f]
	vpand	ymm3, ymm3, ymm5
	vpsadbw	ymm3, ymm3, ymm0
	vpaddq	ymm10, ymm10, ymm3
	vpsrlw	ymm3, ymm14, 1
	vpand	ymm3, ymm3, ymm5
	vpsadbw	ymm3, ymm3, ymm0
	vpaddq	ymm11, ymm11, ymm3
	vpand	ymm3, ymm13, ymm5
	vpsadbw	ymm3, ymm3, ymm0
	vpaddq	ymm7, ymm3, ymm7
	vpand	ymm3, ymm14, ymm5
	vpsadbw	ymm3, ymm3, ymm0
	vpaddq	ymm8, ymm8, ymm3
	vpsrlw	ymm3, ymm13, 7
	vpand	ymm1, ymm3, ymm1
	vpsrlw	ymm3, ymm14, 7
	vpand	ymm3, ymm15, ymm3
	vmovdqu	ymm15, ymmword ptr [rsp - 40]
	vpand	ymm1, ymm1, ymm5
	vpsadbw	ymm1, ymm1, ymm0
	vpaddq	ymm15, ymm15, ymm1
	vpand	ymm1, ymm3, ymm5
	vpsadbw	ymm1, ymm1, ymm0
	vpaddq	ymm6, ymm1, ymm6
	vpmaxub	ymm2, ymm14, ymm2
	vpmaxub	ymm4, ymm13, ymm4
	add	rbx, 64
	cmp	rbx, r14
	jl	32b
	vpaddq	ymm1, ymm12, ymm9
	vextracti128	xmm3, ymm1, 1
	vpaddq	xmm1, xmm1, xmm3
	vpshufd	xmm3, xmm1, 238
	vpaddq	xmm1, xmm1, xmm3
	vmovq	rbx, xmm1
	vpaddq	ymm1, ymm10, ymm11
	vextracti128	xmm3, ymm1, 1
	vpaddq	xmm1, xmm1, xmm3
	vpshufd	xmm3, xmm1, 238
	vpaddq	xmm1, xmm1, xmm3
	vmovq	r14, xmm1
	vpaddq	ymm1, ymm8, ymm7
	vextracti128	xmm3, ymm1, 1
	vpaddq	xmm1, xmm1, xmm3
	vpshufd	xmm3, xmm1, 238
	vpaddq	xmm1, xmm1, xmm3
	vmovq	r15, xmm1
	vpaddq	ymm1, ymm15, ymm6
	vextracti128	xmm3, ymm1, 1
	vpaddq	xmm1, xmm1, xmm3
	vpshufd	xmm3, xmm1, 238
	vpaddq	xmm1, xmm1, xmm3
	vmovq	r12, xmm1
	jmp	12b
42:
	vpmaxub	ymm0, ymm4, ymm2
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
	.p2align	5, 0x0
72:
	.byte	63
	.p2align	5, 0x0
82:
	.byte	1

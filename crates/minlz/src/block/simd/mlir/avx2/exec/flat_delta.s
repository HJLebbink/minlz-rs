# minlz_exec_flat_delta of crates/minlz/mlir/exec64.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 504
	mov	rcx, qword ptr [rdi]
	mov	rax, qword ptr [rdi + 8]
	mov	r8, qword ptr [rdi + 64]
	mov	rdx, qword ptr [rdi + 80]
	add	rdx, rcx
	mov	rsi, qword ptr [rdi + 88]
	mov	qword ptr [rsp + 200], rax
	add	rsi, rax
	test	r8, r8
	jle	542f
	mov	r11, qword ptr [rdi + 96]
	lea	r13, [rdi + 512]
	mov	eax, 96
	mov	qword ptr [rsp + 40], rax
	mov	r15d, 7
	mov	qword ptr [rsp + 48], 0
	vpxor	xmm7, xmm7, xmm7
	vbroadcastss	ymm0, dword ptr [rip + 552f]
	vmovups	ymmword ptr [rsp + 432], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 562f]
	vmovups	ymmword ptr [rsp + 400], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 572f]
	vmovups	ymmword ptr [rsp + 368], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 582f]
	vmovups	ymmword ptr [rsp + 336], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 592f]
	vmovups	ymmword ptr [rsp + 304], ymm0
	mov	rax, r13
	mov	r9, r8
	xor	ebx, ebx
	mov	qword ptr [rsp + 208], r8
	jmp	12f
	.p2align	4
2:
	mov	r9, qword ptr [rsp + 232]
	add	r9, -64
	inc	qword ptr [rsp + 48]
	add	qword ptr [rsp + 40], 64
	add	r15, -64
	mov	rax, qword ptr [rsp + 56]
	add	rax, -64
	mov	r8, qword ptr [rsp + 208]
	mov	rbx, qword ptr [rsp + 216]
	cmp	rbx, r8
	jge	542f
12:
	mov	qword ptr [rsp + 56], rax
	cmp	r9, 1
	mov	qword ptr [rsp + 232], r9
	adc	r9, 0
	cmp	r9, 64
	mov	eax, 64
	cmovae	r9, rax
	mov	qword ptr [rsp + 224], r9
	sub	r8, rbx
	cmp	r8, 64
	mov	qword ptr [rsp + 272], r8
	cmovb	rax, r8
	mov	qword ptr [rsp + 160], rax
	mov	r14, qword ptr [rdi + 16]
	mov	r12, qword ptr [rdi + 24]
	mov	rax, qword ptr [rdi + 32]
	mov	qword ptr [rsp + 96], rax
	mov	rax, qword ptr [rdi + 40]
	mov	qword ptr [rsp], rax
	mov	r10, qword ptr [rdi + 64]
	mov	rax, qword ptr [rdi + 72]
	mov	qword ptr [rsp + 16], rax
	mov	rax, qword ptr [rdi + 96]
	mov	qword ptr [rsp + 128], rax
	mov	rax, qword ptr [rdi + 112]
	mov	qword ptr [rsp + 8], rax
	mov	rax, qword ptr [rdi + 128]
	mov	qword ptr [rsp + 32], rax
	mov	rax, qword ptr [rdi + 136]
	mov	qword ptr [rsp + 64], rax
	lea	rbp, [r10 + 7]
	lea	rax, [rbx + 64]
	mov	qword ptr [rsp + 216], rax
	cmp	rax, rbp
	mov	qword ptr [rsp + 24], r15
	jbe	52f
	cmp	rbx, rbp
	mov	r8, r13
	jge	62f
	mov	rax, qword ptr [rsp + 48]
	shl	rax, 6
	mov	r9d, 7
	sub	r9, rax
	add	r9, r10
	cmp	r9, 16
	jb	22f
	add	rax, r14
	mov	r8, rdi
	sub	r8, rax
	add	r8, 511
	cmp	r8, 127
	jae	82f
22:
	mov	r9, rbx
32:
	mov	r8, qword ptr [rsp + 56]
	.p2align	4
42:
	movzx	eax, byte ptr [r14 + r9]
	mov	byte ptr [r8 + r9], al
	inc	r9
	cmp	rbp, r9
	jne	42b
	mov	r8, r13
	jmp	62f
	.p2align	4
52:
	add	r14, rbx
	mov	r8, r14
62:
	vmovdqu	ymm0, ymmword ptr [r8]
	vmovdqu	ymm1, ymmword ptr [r8 + 32]
	vmovd	xmm3, dword ptr [rsp + 160]
	vpbroadcastb	ymm4, xmm3
	vpmaxub	ymm3, ymm4, ymmword ptr [rip + 602f]
	vpcmpeqb	ymm3, ymm4, ymm3
	vpmaxub	ymm5, ymm4, ymmword ptr [rip + 612f]
	vpcmpeqb	ymm8, ymm4, ymm5
	vpsllw	ymm4, ymm0, 6
	vpcmpgtb	ymm4, ymm7, ymm4
	vpsllw	ymm5, ymm1, 6
	vpcmpgtb	ymm11, ymm7, ymm5
	vpbroadcastb	ymm2, byte ptr [rip + 622f]
	vpand	ymm5, ymm0, ymm2
	vpand	ymm10, ymm1, ymm2
	vpcmpeqb	ymm12, ymm10, ymm7
	vpcmpeqb	ymm10, ymm5, ymm7
	movabs	r14, 72340172838076673
	mov	r15, r14
	#APP
	#NO_APP
	vpand	ymm4, ymm4, ymm2
	vpand	ymm5, ymm3, ymm4
	vpand	ymm4, ymm11, ymm2
	vpand	ymm4, ymm8, ymm4
	vmovdqu	ymmword ptr [rdi + 544], ymm4
	vmovdqu	ymmword ptr [rdi + 512], ymm5
	vmovq	rax, xmm5
	mov	r9, rax
	imul	r9, r15
	mov	r8, r9
	sub	r8, rax
	xor	rax, r15
	shl	rax, 7
	or	rax, r8
	mov	r8, qword ptr [rsp + 32]
	vmovq	xmm11, qword ptr [r12 + r8]
	vmovq	xmm13, rax
	vpshufb	xmm11, xmm11, xmm13
	shr	r9, 56
	add	r9, r8
	vmovq	qword ptr [rdi + 512], xmm11
	vpextrq	r8, xmm5, 1
	mov	rax, r8
	imul	rax, r15
	mov	r10, rax
	sub	r10, r8
	xor	r8, r15
	shl	r8, 7
	or	r8, r10
	vmovq	xmm11, qword ptr [r12 + r9]
	vmovq	xmm13, r8
	vpshufb	xmm11, xmm11, xmm13
	shr	rax, 56
	add	rax, r9
	vmovq	qword ptr [rdi + 520], xmm11
	vextracti128	xmm5, ymm5, 1
	vmovq	r8, xmm5
	mov	r9, r8
	imul	r9, r15
	mov	r10, r9
	sub	r10, r8
	xor	r8, r15
	shl	r8, 7
	or	r8, r10
	vmovq	xmm11, qword ptr [r12 + rax]
	vmovq	xmm13, r8
	vpshufb	xmm11, xmm11, xmm13
	shr	r9, 56
	add	r9, rax
	vmovq	qword ptr [rdi + 528], xmm11
	vpextrq	r8, xmm5, 1
	mov	rax, r8
	imul	rax, r15
	mov	r10, rax
	sub	r10, r8
	xor	r8, r15
	shl	r8, 7
	or	r8, r10
	vmovq	xmm5, qword ptr [r12 + r9]
	vmovq	xmm11, r8
	vpshufb	xmm5, xmm5, xmm11
	shr	rax, 56
	add	rax, r9
	vmovq	qword ptr [rdi + 536], xmm5
	vmovq	r8, xmm4
	mov	r9, r8
	imul	r9, r15
	mov	r10, r9
	sub	r10, r8
	xor	r8, r15
	shl	r8, 7
	or	r8, r10
	vmovq	xmm5, qword ptr [r12 + rax]
	vmovq	xmm11, r8
	vpshufb	xmm5, xmm5, xmm11
	shr	r9, 56
	add	r9, rax
	vmovq	qword ptr [rdi + 544], xmm5
	vpextrq	r8, xmm4, 1
	mov	rax, r8
	imul	rax, r15
	mov	r10, rax
	sub	r10, r8
	xor	r8, r15
	shl	r8, 7
	or	r8, r10
	vmovq	xmm4, qword ptr [r12 + r9]
	vmovq	xmm5, r8
	vpshufb	xmm4, xmm4, xmm5
	shr	rax, 56
	add	rax, r9
	vmovq	qword ptr [rdi + 552], xmm4
	mov	r8, qword ptr [rdi + 560]
	mov	r9, qword ptr [rdi + 568]
	mov	rbx, r8
	imul	rbx, r15
	mov	r10, rbx
	sub	r10, r8
	xor	r8, r15
	shl	r8, 7
	or	r8, r10
	vmovq	xmm4, qword ptr [r12 + rax]
	vmovq	xmm5, r8
	vpshufb	xmm4, xmm4, xmm5
	shr	rbx, 56
	add	rbx, rax
	vmovq	qword ptr [rdi + 560], xmm4
	mov	rax, r9
	imul	rax, r15
	mov	qword ptr [rsp + 32], rax
	sub	rax, r9
	xor	r15, r9
	shl	r15, 7
	or	r15, rax
	vmovq	xmm4, qword ptr [r12 + rbx]
	vmovq	xmm5, r15
	vpshufb	xmm4, xmm4, xmm5
	vmovq	qword ptr [rdi + 568], xmm4
	vmovups	ymm4, ymmword ptr [rdi + 544]
	vmovups	ymm5, ymmword ptr [rdi + 512]
	vmovups	ymmword ptr [rdi + 192], ymm5
	vmovups	ymmword ptr [rdi + 224], ymm4
	mov	r15, r14
	#APP
	#NO_APP
	vpand	ymm4, ymm12, ymm2
	vpand	ymm4, ymm8, ymm4
	vpand	ymm5, ymm10, ymm2
	vpand	ymm3, ymm3, ymm5
	vmovdqu	ymmword ptr [rdi + 512], ymm3
	vmovdqu	ymmword ptr [rdi + 544], ymm4
	vmovq	rax, xmm3
	mov	r9, r15
	imul	r9, rax
	mov	r8, r9
	sub	r8, rax
	xor	rax, r15
	shl	rax, 7
	or	rax, r8
	mov	r13, qword ptr [rsp + 96]
	mov	r8, qword ptr [rsp + 64]
	vmovq	xmm5, qword ptr [r13 + r8]
	vmovq	xmm8, rax
	vpshufb	xmm5, xmm5, xmm8
	shr	r9, 56
	add	r9, r8
	vmovq	qword ptr [rdi + 512], xmm5
	vpextrq	r8, xmm3, 1
	mov	rax, r15
	imul	rax, r8
	mov	r10, rax
	sub	r10, r8
	xor	r8, r15
	shl	r8, 7
	or	r8, r10
	vmovq	xmm5, qword ptr [r13 + r9]
	vmovq	xmm8, r8
	vpshufb	xmm5, xmm5, xmm8
	shr	rax, 56
	add	rax, r9
	vmovq	qword ptr [rdi + 520], xmm5
	vextracti128	xmm3, ymm3, 1
	vmovq	r8, xmm3
	mov	r9, r15
	imul	r9, r8
	mov	r10, r9
	sub	r10, r8
	xor	r8, r15
	shl	r8, 7
	or	r8, r10
	vmovq	xmm5, qword ptr [r13 + rax]
	vmovq	xmm8, r8
	vpshufb	xmm5, xmm5, xmm8
	shr	r9, 56
	add	r9, rax
	vmovq	qword ptr [rdi + 528], xmm5
	vpextrq	r8, xmm3, 1
	mov	rax, r15
	imul	rax, r8
	mov	r10, rax
	sub	r10, r8
	xor	r8, r15
	shl	r8, 7
	or	r8, r10
	vmovq	xmm3, qword ptr [r13 + r9]
	vmovq	xmm5, r8
	vpshufb	xmm3, xmm3, xmm5
	shr	rax, 56
	add	rax, r9
	vmovq	qword ptr [rdi + 536], xmm3
	vmovq	r8, xmm4
	mov	r9, r15
	imul	r9, r8
	mov	r10, r9
	sub	r10, r8
	xor	r8, r15
	shl	r8, 7
	or	r8, r10
	vmovq	xmm3, qword ptr [r13 + rax]
	vmovq	xmm5, r8
	vpshufb	xmm3, xmm3, xmm5
	shr	r9, 56
	add	r9, rax
	vmovq	qword ptr [rdi + 544], xmm3
	vpextrq	r8, xmm4, 1
	mov	rax, r15
	imul	rax, r8
	mov	r10, rax
	sub	r10, r8
	xor	r8, r15
	shl	r8, 7
	or	r8, r10
	vmovq	xmm3, qword ptr [r13 + r9]
	vmovq	xmm4, r8
	vpshufb	xmm3, xmm3, xmm4
	shr	rax, 56
	add	rax, r9
	vmovq	qword ptr [rdi + 552], xmm3
	mov	r8, qword ptr [rdi + 560]
	mov	r9, qword ptr [rdi + 568]
	mov	r12, r8
	imul	r12, r15
	mov	r10, r12
	sub	r10, r8
	xor	r8, r15
	shl	r8, 7
	or	r8, r10
	vmovq	xmm3, qword ptr [r13 + rax]
	vmovq	xmm4, r8
	vpshufb	xmm3, xmm3, xmm4
	shr	r12, 56
	add	r12, rax
	vmovq	qword ptr [rdi + 560], xmm3
	mov	r14, r9
	imul	r14, r15
	mov	rax, r14
	sub	rax, r9
	xor	r15, r9
	shl	r15, 7
	or	r15, rax
	vmovq	xmm3, qword ptr [r13 + r12]
	vmovq	xmm4, r15
	vpshufb	xmm3, xmm3, xmm4
	vmovq	qword ptr [rdi + 568], xmm3
	vmovups	ymm2, ymmword ptr [rdi + 512]
	vmovups	ymmword ptr [rsp + 240], ymm2
	vmovups	ymm2, ymmword ptr [rdi + 544]
	vmovups	ymmword ptr [rsp + 464], ymm2
	vpmovzxbd	ymm3, qword ptr [rdi + 520]
	vpmovzxbd	ymm8, qword ptr [rdi + 512]
	vmovdqu	ymmword ptr [rdi + 512], ymm0
	vmovdqu	ymmword ptr [rdi + 544], ymm1
	vmovd	xmm0, dword ptr [rsp + 128]
	vpbroadcastd	ymm0, xmm0
	vpsrld	ymm1, ymm8, 3
	vpsrld	ymm4, ymm3, 3
	vmovdqu	ymm2, ymmword ptr [rsp + 432]
	vpmaxud	ymm4, ymm4, ymm2
	vpcmpeqd	ymm6, ymm6, ymm6
	vpaddd	ymm4, ymm4, ymm6
	vpmaxud	ymm1, ymm1, ymm2
	vpaddd	ymm5, ymm1, ymm6
	vmovdqu	ymm2, ymmword ptr [rsp + 400]
	vpand	ymm1, ymm8, ymm2
	vpand	ymm10, ymm3, ymm2
	vmovdqu	ymm9, ymmword ptr [rsp + 368]
	vpminud	ymm3, ymm3, ymm9
	vpminud	ymm8, ymm8, ymm9
	vpand	ymm8, ymm8, ymm9
	vpor	ymm1, ymm8, ymm1
	vpand	ymm3, ymm9, ymm3
	vpor	ymm3, ymm10, ymm3
	vpsllvd	ymm1, ymm1, ymm5
	vmovdqu	ymmword ptr [rsp + 96], ymm1
	vpsllvd	ymm1, ymm3, ymm4
	vmovdqu	ymmword ptr [rsp + 128], ymm1
	vpsllvd	ymm1, ymm6, ymm5
	vmovdqu	ymmword ptr [rsp + 160], ymm1
	vpsllvd	ymm1, ymm6, ymm4
	vmovdqu	ymmword ptr [rsp + 64], ymm1
	vperm2i128	ymm1, ymm5, ymm4, 33
	vpalignr	ymm1, ymm4, ymm1, 12
	vperm2i128	ymm11, ymm5, ymm5, 10
	vpalignr	ymm11, ymm5, ymm11, 12
	vpaddd	ymm11, ymm11, ymm5
	vpaddd	ymm1, ymm1, ymm4
	vpblendd	ymm15, ymm11, ymm7, 192
	vpermq	ymm15, ymm15, 147
	vpaddd	ymm15, ymm15, ymm11
	vpblendd	ymm11, ymm1, ymm11, 192
	vpermq	ymm11, ymm11, 147
	vpaddd	ymm1, ymm11, ymm1
	vperm2i128	ymm11, ymm15, ymm15, 10
	vpaddd	ymm11, ymm11, ymm15
	vperm2i128	ymm15, ymm15, ymm1, 33
	vpaddd	ymm1, ymm15, ymm1
	vpaddd	ymm1, ymm11, ymm1
	vpsubd	ymm4, ymm1, ymm4
	vpsubd	ymm5, ymm11, ymm5
	mov	r9, qword ptr [rsp + 16]
	mov	eax, r9d
	and	eax, 7
	vmovd	xmm11, eax
	vpbroadcastd	ymm11, xmm11
	vpaddd	ymm4, ymm11, ymm4
	vpaddd	ymm5, ymm11, ymm5
	vpsrld	ymm11, ymm4, 3
	vpsrld	ymm9, ymm5, 3
	vpand	ymm15, ymm4, ymm2
	vpand	ymm5, ymm5, ymm2
	vbroadcasti128	ymm2, xmmword ptr [rip + 632f]
	vpshufb	ymm4, ymm11, ymm2
	vpshufb	ymm9, ymm9, ymm2
	vmovdqu	ymm2, ymmword ptr [rsp + 336]
	vpaddb	ymm11, ymm4, ymm2
	vpaddb	ymm4, ymm9, ymm2
	shr	r9, 3
	lea	rax, [r9 + 64]
	mov	r8, qword ptr [rsp + 8]
	cmp	rax, r8
	jbe	72f
	mov	rax, r8
	sub	rax, r9
	lea	rbp, [rdi + 576]
	mov	r8, rbp
	jbe	152f
	cmp	rax, 16
	mov	r10, r9
	jb	132f
	mov	r8, qword ptr [rsp]
	lea	r15, [r9 + r8]
	mov	r8, rdi
	sub	r8, r15
	add	r8, 575
	cmp	r8, 127
	mov	r10, r9
	jb	132f
	cmp	rax, 128
	jae	92f
	xor	r13d, r13d
	jmp	112f
	.p2align	4
72:
	add	r9, qword ptr [rsp]
	mov	r8, r9
	lea	rbp, [rdi + 576]
	jmp	152f
82:
	cmp	r9, 128
	mov	qword ptr [rsp + 240], r9
	jae	172f
	xor	eax, eax
	jmp	192f
92:
	mov	r13, rax
	and	r13, -128
	lea	r10, [r9 + r13]
	mov	r8, qword ptr [rsp]
	lea	r8, [r8 + r9 + 96]
	xor	ebp, ebp
	.p2align	4
102:
	vmovdqu	ymm9, ymmword ptr [r8 + rbp - 96]
	vmovdqu	ymm14, ymmword ptr [r8 + rbp - 64]
	vmovdqu	ymm6, ymmword ptr [r8 + rbp - 32]
	vmovdqu	ymm7, ymmword ptr [r8 + rbp]
	vmovdqu	ymmword ptr [rdi + rbp + 576], ymm9
	vmovdqu	ymmword ptr [rdi + rbp + 608], ymm14
	vmovdqu	ymmword ptr [rdi + rbp + 640], ymm6
	vmovdqu	ymmword ptr [rdi + rbp + 672], ymm7
	sub	rbp, -128
	cmp	r13, rbp
	jne	102b
	cmp	rax, r13
	lea	rbp, [rdi + 576]
	mov	r8, rbp
	je	152f
	test	al, 112
	je	132f
112:
	mov	r8, rax
	and	r8, -16
	lea	r10, [r9 + r8]
	.p2align	4
122:
	vmovdqu	xmm6, xmmword ptr [r15 + r13]
	vmovdqu	xmmword ptr [rbp + r13], xmm6
	add	r13, 16
	cmp	r8, r13
	jne	122b
	cmp	rax, r8
	mov	r8, rbp
	je	152f
	.p2align	4
132:
	mov	rax, rbp
	sub	rax, r9
	mov	r9, qword ptr [rsp]
	mov	r15, qword ptr [rsp + 8]
	.p2align	4
142:
	movzx	r8d, byte ptr [r9 + r10]
	mov	byte ptr [rax + r10], r8b
	inc	r10
	cmp	r15, r10
	jne	142b
	mov	r8, rbp
152:
	vmovdqu	ymm6, ymmword ptr [r8]
	vmovdqu	ymm7, ymmword ptr [r8 + 32]
	vpermq	ymm9, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm14, ymm9, ymm11
	vpshufb	ymm12, ymm6, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 642f]
	vpand	ymm2, ymm11, ymm3
	vpxor	xmm10, xmm10, xmm10
	vpcmpeqb	ymm2, ymm10, ymm2
	vpblendvb	ymm12, ymm12, ymm14, ymm2
	vpermq	ymm14, ymm7, 68
	vpermq	ymm7, ymm7, 238
	vpshufb	ymm13, ymm14, ymm11
	vpshufb	ymm8, ymm7, ymm11
	vpblendvb	ymm2, ymm8, ymm13, ymm2
	vpshufb	ymm8, ymm9, ymm4
	vpshufb	ymm6, ymm6, ymm4
	vpand	ymm9, ymm4, ymm3
	vpcmpeqb	ymm9, ymm9, ymm10
	vpblendvb	ymm6, ymm6, ymm8, ymm9
	vpshufb	ymm8, ymm14, ymm4
	vpshufb	ymm7, ymm7, ymm4
	vpblendvb	ymm7, ymm7, ymm8, ymm9
	vpbroadcastb	ymm3, byte ptr [rip + 652f]
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm4, ymm6, ymm7, ymm4
	vpxor	xmm7, xmm7, xmm7
	vpand	ymm6, ymm11, ymm3
	vpcmpeqb	ymm6, ymm6, ymm3
	vpblendvb	ymm2, ymm12, ymm2, ymm6
	vpsrlvd	ymm4, ymm4, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 160]
	vpandn	ymm3, ymm3, ymm4
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 96]
	vpsrlvd	ymm2, ymm2, ymm15
	vmovdqu	ymm4, ymmword ptr [rsp + 64]
	vpandn	ymm2, ymm4, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 128]
	vpor	ymm4, ymm2, ymmword ptr [rip + 662f]
	vpcmpeqd	ymm2, ymm2, ymm7
	vpandn	ymm2, ymm2, ymm4
	vpor	ymm4, ymm3, ymmword ptr [rip + 672f]
	vpcmpeqd	ymm3, ymm3, ymm7
	vpandn	ymm3, ymm3, ymm4
	vperm2i128	ymm4, ymm3, ymm3, 10
	vpalignr	ymm4, ymm3, ymm4, 12
	vpmaxud	ymm4, ymm3, ymm4
	vperm2i128	ymm3, ymm3, ymm2, 33
	vpalignr	ymm3, ymm2, ymm3, 12
	vpmaxud	ymm2, ymm2, ymm3
	vpblendd	ymm3, ymm2, ymm4, 192
	vpermq	ymm3, ymm3, 147
	vpmaxud	ymm2, ymm2, ymm3
	vpblendd	ymm3, ymm4, ymm7, 192
	vpermq	ymm3, ymm3, 147
	vpmaxud	ymm3, ymm4, ymm3
	vperm2i128	ymm4, ymm3, ymm3, 10
	vpmaxud	ymm4, ymm3, ymm4
	vperm2i128	ymm3, ymm3, ymm2, 33
	vpmaxud	ymm2, ymm2, ymm3
	vpmaxud	ymm2, ymm2, ymm4
	vmovdqu	ymm5, ymmword ptr [rsp + 304]
	vpand	ymm3, ymm2, ymm5
	vpcmpeqd	ymm2, ymm2, ymm7
	vblendvps	ymm2, ymm3, ymm0, ymm2
	vpand	ymm3, ymm4, ymm5
	vpcmpeqd	ymm4, ymm4, ymm7
	vblendvps	ymm0, ymm3, ymm0, ymm4
	vextracti128	xmm1, ymm1, 1
	vpextrd	eax, xmm1, 3
	vmovups	ymmword ptr [rdi + 256], ymm0
	vmovups	ymmword ptr [rdi + 288], ymm2
	vshufps	ymm0, ymm2, ymm2, 255
	vpermpd	ymm0, ymm0, 170
	mov	r9, qword ptr [rsp + 16]
	add	r9, rax
	cmp	qword ptr [rsp + 272], 17
	jb	442f
	vmovdqu	ymm1, ymmword ptr [rsp + 240]
	vextracti128	xmm1, ymm1, 1
	vpshufd	xmm2, xmm1, 238
	vpmovzxbd	ymm2, xmm2
	vpmovzxbd	ymm1, xmm1
	vpsrld	ymm3, ymm1, 3
	vpsrld	ymm4, ymm2, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 432]
	vpmaxud	ymm4, ymm4, ymm5
	vpcmpeqd	ymm8, ymm8, ymm8
	vpaddd	ymm4, ymm8, ymm4
	vpmaxud	ymm3, ymm3, ymm5
	vpaddd	ymm5, ymm8, ymm3
	vmovdqu	ymm9, ymmword ptr [rsp + 400]
	vpand	ymm3, ymm9, ymm1
	vpand	ymm6, ymm9, ymm2
	vmovdqu	ymm10, ymmword ptr [rsp + 368]
	vpminud	ymm2, ymm2, ymm10
	vpminud	ymm1, ymm1, ymm10
	vpand	ymm1, ymm10, ymm1
	vpor	ymm1, ymm1, ymm3
	vpand	ymm2, ymm10, ymm2
	vpor	ymm2, ymm2, ymm6
	vpsllvd	ymm1, ymm1, ymm5
	vmovdqu	ymmword ptr [rsp + 96], ymm1
	vpsllvd	ymm1, ymm2, ymm4
	vmovdqu	ymmword ptr [rsp + 128], ymm1
	vpsllvd	ymm1, ymm8, ymm5
	vmovdqu	ymmword ptr [rsp + 160], ymm1
	vpsllvd	ymm1, ymm8, ymm4
	vmovdqu	ymmword ptr [rsp + 64], ymm1
	vperm2i128	ymm1, ymm5, ymm4, 33
	vpalignr	ymm1, ymm4, ymm1, 12
	vperm2i128	ymm2, ymm5, ymm5, 10
	vpalignr	ymm2, ymm5, ymm2, 12
	vpaddd	ymm2, ymm2, ymm5
	vpaddd	ymm1, ymm1, ymm4
	vpblendd	ymm6, ymm2, ymm7, 192
	vpermq	ymm6, ymm6, 147
	vpaddd	ymm6, ymm6, ymm2
	vpblendd	ymm2, ymm1, ymm2, 192
	vpermq	ymm2, ymm2, 147
	vpaddd	ymm1, ymm2, ymm1
	vperm2i128	ymm2, ymm6, ymm6, 10
	vpaddd	ymm2, ymm2, ymm6
	vperm2i128	ymm6, ymm6, ymm1, 33
	vpaddd	ymm1, ymm6, ymm1
	vpaddd	ymm1, ymm2, ymm1
	vpsubd	ymm4, ymm1, ymm4
	vpsubd	ymm2, ymm2, ymm5
	mov	eax, r9d
	and	eax, 7
	vmovd	xmm5, eax
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm4, ymm5, ymm4
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm6, ymm4, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm13, ymm9, ymm4
	vpand	ymm5, ymm9, ymm2
	vbroadcasti128	ymm4, xmmword ptr [rip + 632f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm4, ymm7, ymm4
	vmovdqu	ymm6, ymmword ptr [rsp + 336]
	vpaddb	ymm11, ymm2, ymm6
	vpaddb	ymm4, ymm4, ymm6
	mov	qword ptr [rsp + 16], r9
	shr	r9, 3
	lea	rax, [r9 + 64]
	mov	r8, qword ptr [rsp + 8]
	cmp	rax, r8
	jbe	162f
	mov	rax, r8
	sub	rax, r9
	mov	r8, rbp
	jbe	272f
	cmp	rax, 16
	mov	r10, r9
	jb	252f
	mov	r8, qword ptr [rsp]
	lea	r15, [r9 + r8]
	mov	r8, rdi
	sub	r8, r15
	add	r8, 575
	cmp	r8, 127
	mov	r10, r9
	jb	252f
	cmp	rax, 128
	jae	212f
	xor	r13d, r13d
	jmp	232f
	.p2align	4
162:
	add	r9, qword ptr [rsp]
	mov	r8, r9
	jmp	272f
172:
	mov	rax, r9
	and	rax, -128
	lea	r9, [rbx + rax]
	mov	r8, qword ptr [rsp + 40]
	lea	r13, [r14 + r8]
	lea	r8, [r10 + r15]
	and	r8, -128
	xor	r15d, r15d
	.p2align	4
182:
	vmovups	ymm0, ymmword ptr [r13 + r15 - 96]
	vmovdqu	ymm1, ymmword ptr [r13 + r15 - 64]
	vmovups	ymm3, ymmword ptr [r13 + r15 - 32]
	vmovups	ymm4, ymmword ptr [r13 + r15]
	vmovups	ymmword ptr [rdi + r15 + 512], ymm0
	vmovdqu	ymmword ptr [rdi + r15 + 544], ymm1
	vmovups	ymmword ptr [rdi + r15 + 576], ymm3
	vmovups	ymmword ptr [rdi + r15 + 608], ymm4
	sub	r15, -128
	cmp	r8, r15
	jne	182b
	cmp	qword ptr [rsp + 240], rax
	lea	r13, [rdi + 512]
	mov	r8, r13
	mov	r15, qword ptr [rsp + 24]
	je	62b
	test	byte ptr [rsp + 240], 112
	je	32b
192:
	mov	r9, qword ptr [rsp + 240]
	and	r9, -16
	lea	r8, [r14 + rbx]
	add	rbx, r9
	add	r10, r15
	and	r10, -16
	.p2align	4
202:
	vmovups	xmm0, xmmword ptr [r8 + rax]
	vmovups	xmmword ptr [r13 + rax], xmm0
	add	rax, 16
	cmp	r10, rax
	jne	202b
	cmp	qword ptr [rsp + 240], r9
	mov	r9, rbx
	mov	r8, r13
	je	62b
	jmp	32b
212:
	mov	r13, rax
	and	r13, -128
	lea	r10, [r9 + r13]
	mov	r8, qword ptr [rsp]
	lea	r8, [r8 + r9 + 96]
	xor	ebp, ebp
	.p2align	4
222:
	vmovdqu	ymm2, ymmword ptr [r8 + rbp - 96]
	vmovdqu	ymm6, ymmword ptr [r8 + rbp - 64]
	vmovdqu	ymm7, ymmword ptr [r8 + rbp - 32]
	vmovdqu	ymm9, ymmword ptr [r8 + rbp]
	vmovdqu	ymmword ptr [rdi + rbp + 576], ymm2
	vmovdqu	ymmword ptr [rdi + rbp + 608], ymm6
	vmovdqu	ymmword ptr [rdi + rbp + 640], ymm7
	vmovdqu	ymmword ptr [rdi + rbp + 672], ymm9
	sub	rbp, -128
	cmp	r13, rbp
	jne	222b
	cmp	rax, r13
	lea	rbp, [rdi + 576]
	mov	r8, rbp
	je	272f
	test	al, 112
	je	252f
232:
	mov	r8, rax
	and	r8, -16
	lea	r10, [r9 + r8]
	.p2align	4
242:
	vmovdqu	xmm2, xmmword ptr [r15 + r13]
	vmovdqu	xmmword ptr [rbp + r13], xmm2
	add	r13, 16
	cmp	r8, r13
	jne	242b
	cmp	rax, r8
	mov	r8, rbp
	je	272f
252:
	mov	rax, rbp
	sub	rax, r9
	mov	r9, qword ptr [rsp]
	mov	r15, qword ptr [rsp + 8]
	.p2align	4
262:
	movzx	r8d, byte ptr [r9 + r10]
	mov	byte ptr [rax + r10], r8b
	inc	r10
	cmp	r15, r10
	jne	262b
	mov	r8, rbp
272:
	vmovdqu	ymm2, ymmword ptr [r8]
	vmovdqu	ymm6, ymmword ptr [r8 + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm9, ymm7, ymm11
	vpshufb	ymm14, ymm2, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 642f]
	vpand	ymm15, ymm11, ymm3
	vpxor	xmm10, xmm10, xmm10
	vpcmpeqb	ymm15, ymm15, ymm10
	vpblendvb	ymm9, ymm14, ymm9, ymm15
	vpermq	ymm14, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm12, ymm14, ymm11
	vpshufb	ymm8, ymm6, ymm11
	vpblendvb	ymm8, ymm8, ymm12, ymm15
	vpshufb	ymm7, ymm7, ymm4
	vpshufb	ymm2, ymm2, ymm4
	vpand	ymm12, ymm4, ymm3
	vpcmpeqb	ymm12, ymm12, ymm10
	vpblendvb	ymm2, ymm2, ymm7, ymm12
	vpshufb	ymm7, ymm14, ymm4
	vpshufb	ymm6, ymm6, ymm4
	vpblendvb	ymm6, ymm6, ymm7, ymm12
	vpxor	xmm7, xmm7, xmm7
	vpbroadcastb	ymm3, byte ptr [rip + 652f]
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm2, ymm2, ymm6, ymm4
	vpand	ymm4, ymm11, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm4, ymm9, ymm8, ymm4
	vpsrlvd	ymm2, ymm2, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 160]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 96]
	vpsrlvd	ymm3, ymm4, ymm13
	vmovdqu	ymm4, ymmword ptr [rsp + 64]
	vpandn	ymm3, ymm4, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 128]
	vpor	ymm4, ymm3, ymmword ptr [rip + 662f]
	vpcmpeqd	ymm3, ymm3, ymm7
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 672f]
	vpcmpeqd	ymm2, ymm2, ymm7
	vpandn	ymm2, ymm2, ymm4
	vperm2i128	ymm4, ymm2, ymm2, 10
	vpalignr	ymm4, ymm2, ymm4, 12
	vpmaxud	ymm4, ymm2, ymm4
	vperm2i128	ymm2, ymm2, ymm3, 33
	vpalignr	ymm2, ymm3, ymm2, 12
	vpmaxud	ymm2, ymm3, ymm2
	vpblendd	ymm3, ymm2, ymm4, 192
	vpermq	ymm3, ymm3, 147
	vpmaxud	ymm2, ymm2, ymm3
	vpblendd	ymm3, ymm4, ymm7, 192
	vpermq	ymm3, ymm3, 147
	vpmaxud	ymm3, ymm4, ymm3
	vperm2i128	ymm4, ymm3, ymm3, 10
	vpmaxud	ymm4, ymm3, ymm4
	vperm2i128	ymm3, ymm3, ymm2, 33
	vpmaxud	ymm2, ymm2, ymm3
	vpmaxud	ymm2, ymm2, ymm4
	vmovdqu	ymm5, ymmword ptr [rsp + 304]
	vpand	ymm3, ymm2, ymm5
	vpcmpeqd	ymm2, ymm2, ymm7
	vblendvps	ymm2, ymm3, ymm0, ymm2
	vpand	ymm3, ymm4, ymm5
	vpcmpeqd	ymm4, ymm4, ymm7
	vblendvps	ymm0, ymm3, ymm0, ymm4
	vextracti128	xmm1, ymm1, 1
	vpextrd	eax, xmm1, 3
	vmovups	ymmword ptr [rdi + 320], ymm0
	vmovups	ymmword ptr [rdi + 352], ymm2
	vshufps	ymm0, ymm2, ymm2, 255
	vpermpd	ymm0, ymm0, 170
	mov	r9, qword ptr [rsp + 16]
	add	r9, rax
	cmp	qword ptr [rsp + 272], 33
	jb	442f
	vmovdqu	ymm2, ymmword ptr [rsp + 464]
	vpshufd	xmm1, xmm2, 238
	vpmovzxbd	ymm1, xmm1
	vpmovzxbd	ymm2, xmm2
	vpsrld	ymm3, ymm2, 3
	vpsrld	ymm4, ymm1, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 432]
	vpmaxud	ymm4, ymm4, ymm5
	vpcmpeqd	ymm8, ymm8, ymm8
	vpaddd	ymm4, ymm8, ymm4
	vpmaxud	ymm3, ymm3, ymm5
	vpaddd	ymm5, ymm8, ymm3
	vmovdqu	ymm9, ymmword ptr [rsp + 400]
	vpand	ymm3, ymm9, ymm2
	vpand	ymm6, ymm9, ymm1
	vmovdqu	ymm10, ymmword ptr [rsp + 368]
	vpminud	ymm1, ymm1, ymm10
	vpminud	ymm2, ymm2, ymm10
	vpand	ymm2, ymm10, ymm2
	vpor	ymm2, ymm2, ymm3
	vpand	ymm1, ymm10, ymm1
	vpor	ymm1, ymm1, ymm6
	vpsllvd	ymm2, ymm2, ymm5
	vmovdqu	ymmword ptr [rsp + 96], ymm2
	vpsllvd	ymm1, ymm1, ymm4
	vmovdqu	ymmword ptr [rsp + 128], ymm1
	vpsllvd	ymm1, ymm8, ymm5
	vmovdqu	ymmword ptr [rsp + 160], ymm1
	vpsllvd	ymm1, ymm8, ymm4
	vmovdqu	ymmword ptr [rsp + 64], ymm1
	vperm2i128	ymm1, ymm5, ymm4, 33
	vpalignr	ymm1, ymm4, ymm1, 12
	vperm2i128	ymm2, ymm5, ymm5, 10
	vpalignr	ymm2, ymm5, ymm2, 12
	vpaddd	ymm2, ymm2, ymm5
	vpaddd	ymm1, ymm1, ymm4
	vpblendd	ymm6, ymm2, ymm7, 192
	vpermq	ymm6, ymm6, 147
	vpaddd	ymm6, ymm6, ymm2
	vpblendd	ymm2, ymm1, ymm2, 192
	vpermq	ymm2, ymm2, 147
	vpaddd	ymm1, ymm2, ymm1
	vperm2i128	ymm2, ymm6, ymm6, 10
	vpaddd	ymm2, ymm2, ymm6
	vperm2i128	ymm6, ymm6, ymm1, 33
	vpaddd	ymm1, ymm6, ymm1
	vpaddd	ymm1, ymm2, ymm1
	vpsubd	ymm4, ymm1, ymm4
	vpsubd	ymm2, ymm2, ymm5
	mov	eax, r9d
	and	eax, 7
	vmovd	xmm5, eax
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm4, ymm5, ymm4
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm6, ymm4, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm13, ymm9, ymm4
	vpand	ymm5, ymm9, ymm2
	vbroadcasti128	ymm4, xmmword ptr [rip + 632f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm4, ymm7, ymm4
	vmovdqu	ymm6, ymmword ptr [rsp + 336]
	vpaddb	ymm11, ymm2, ymm6
	vpaddb	ymm4, ymm4, ymm6
	mov	qword ptr [rsp + 16], r9
	shr	r9, 3
	lea	rax, [r9 + 64]
	mov	r8, qword ptr [rsp + 8]
	cmp	rax, r8
	jbe	282f
	mov	rax, r8
	sub	rax, r9
	mov	r8, rbp
	jbe	352f
	cmp	rax, 16
	mov	r10, r9
	jb	332f
	mov	r8, qword ptr [rsp]
	lea	r15, [r9 + r8]
	mov	r8, rdi
	sub	r8, r15
	add	r8, 575
	cmp	r8, 127
	mov	r10, r9
	jb	332f
	cmp	rax, 128
	jae	292f
	xor	r13d, r13d
	jmp	312f
282:
	add	r9, qword ptr [rsp]
	mov	r8, r9
	jmp	352f
292:
	mov	r13, rax
	and	r13, -128
	lea	r10, [r9 + r13]
	mov	r8, qword ptr [rsp]
	lea	r8, [r8 + r9 + 96]
	xor	ebp, ebp
	.p2align	4
302:
	vmovdqu	ymm2, ymmword ptr [r8 + rbp - 96]
	vmovdqu	ymm6, ymmword ptr [r8 + rbp - 64]
	vmovdqu	ymm7, ymmword ptr [r8 + rbp - 32]
	vmovdqu	ymm9, ymmword ptr [r8 + rbp]
	vmovdqu	ymmword ptr [rdi + rbp + 576], ymm2
	vmovdqu	ymmword ptr [rdi + rbp + 608], ymm6
	vmovdqu	ymmword ptr [rdi + rbp + 640], ymm7
	vmovdqu	ymmword ptr [rdi + rbp + 672], ymm9
	sub	rbp, -128
	cmp	r13, rbp
	jne	302b
	cmp	rax, r13
	lea	rbp, [rdi + 576]
	mov	r8, rbp
	je	352f
	test	al, 112
	je	332f
312:
	mov	r8, rax
	and	r8, -16
	lea	r10, [r9 + r8]
	.p2align	4
322:
	vmovdqu	xmm2, xmmword ptr [r15 + r13]
	vmovdqu	xmmword ptr [rbp + r13], xmm2
	add	r13, 16
	cmp	r8, r13
	jne	322b
	cmp	rax, r8
	mov	r8, rbp
	je	352f
332:
	mov	rax, rbp
	sub	rax, r9
	mov	r9, qword ptr [rsp]
	mov	r15, qword ptr [rsp + 8]
	.p2align	4
342:
	movzx	r8d, byte ptr [r9 + r10]
	mov	byte ptr [rax + r10], r8b
	inc	r10
	cmp	r15, r10
	jne	342b
	mov	r8, rbp
352:
	vmovdqu	ymm2, ymmword ptr [r8]
	vmovdqu	ymm6, ymmword ptr [r8 + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm9, ymm7, ymm11
	vpshufb	ymm14, ymm2, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 642f]
	vpand	ymm15, ymm11, ymm3
	vpxor	xmm10, xmm10, xmm10
	vpcmpeqb	ymm15, ymm15, ymm10
	vpblendvb	ymm9, ymm14, ymm9, ymm15
	vpermq	ymm14, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm12, ymm14, ymm11
	vpshufb	ymm8, ymm6, ymm11
	vpblendvb	ymm8, ymm8, ymm12, ymm15
	vpshufb	ymm7, ymm7, ymm4
	vpshufb	ymm2, ymm2, ymm4
	vpand	ymm12, ymm4, ymm3
	vpcmpeqb	ymm12, ymm12, ymm10
	vpblendvb	ymm2, ymm2, ymm7, ymm12
	vpshufb	ymm7, ymm14, ymm4
	vpshufb	ymm6, ymm6, ymm4
	vpblendvb	ymm6, ymm6, ymm7, ymm12
	vpxor	xmm7, xmm7, xmm7
	vpbroadcastb	ymm3, byte ptr [rip + 652f]
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm2, ymm2, ymm6, ymm4
	vpand	ymm4, ymm11, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm4, ymm9, ymm8, ymm4
	vpsrlvd	ymm2, ymm2, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 160]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 96]
	vpsrlvd	ymm3, ymm4, ymm13
	vmovdqu	ymm4, ymmword ptr [rsp + 64]
	vpandn	ymm3, ymm4, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 128]
	vpor	ymm4, ymm3, ymmword ptr [rip + 662f]
	vpcmpeqd	ymm3, ymm3, ymm7
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 672f]
	vpcmpeqd	ymm2, ymm2, ymm7
	vpandn	ymm2, ymm2, ymm4
	vperm2i128	ymm4, ymm2, ymm2, 10
	vpalignr	ymm4, ymm2, ymm4, 12
	vpmaxud	ymm4, ymm2, ymm4
	vperm2i128	ymm2, ymm2, ymm3, 33
	vpalignr	ymm2, ymm3, ymm2, 12
	vpmaxud	ymm2, ymm3, ymm2
	vpblendd	ymm3, ymm2, ymm4, 192
	vpermq	ymm3, ymm3, 147
	vpmaxud	ymm2, ymm2, ymm3
	vpblendd	ymm3, ymm4, ymm7, 192
	vpermq	ymm3, ymm3, 147
	vpmaxud	ymm3, ymm4, ymm3
	vperm2i128	ymm4, ymm3, ymm3, 10
	vpmaxud	ymm4, ymm3, ymm4
	vperm2i128	ymm3, ymm3, ymm2, 33
	vpmaxud	ymm2, ymm2, ymm3
	vpmaxud	ymm2, ymm2, ymm4
	vmovdqu	ymm5, ymmword ptr [rsp + 304]
	vpand	ymm3, ymm2, ymm5
	vpcmpeqd	ymm2, ymm2, ymm7
	vblendvps	ymm2, ymm3, ymm0, ymm2
	vpand	ymm3, ymm4, ymm5
	vpcmpeqd	ymm4, ymm4, ymm7
	vblendvps	ymm0, ymm3, ymm0, ymm4
	vextracti128	xmm1, ymm1, 1
	vpextrd	eax, xmm1, 3
	vmovups	ymmword ptr [rdi + 384], ymm0
	vmovups	ymmword ptr [rdi + 416], ymm2
	vshufps	ymm0, ymm2, ymm2, 255
	vpermpd	ymm0, ymm0, 170
	mov	r9, qword ptr [rsp + 16]
	add	r9, rax
	cmp	qword ptr [rsp + 272], 49
	jb	442f
	vmovdqu	ymm1, ymmword ptr [rsp + 464]
	vextracti128	xmm1, ymm1, 1
	vpshufd	xmm2, xmm1, 238
	vpmovzxbd	ymm2, xmm2
	vpmovzxbd	ymm1, xmm1
	vpsrld	ymm3, ymm1, 3
	vpsrld	ymm4, ymm2, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 432]
	vpmaxud	ymm4, ymm4, ymm5
	vpcmpeqd	ymm8, ymm8, ymm8
	vpaddd	ymm4, ymm8, ymm4
	vpmaxud	ymm3, ymm3, ymm5
	vpaddd	ymm5, ymm8, ymm3
	vmovdqu	ymm9, ymmword ptr [rsp + 400]
	vpand	ymm3, ymm9, ymm1
	vpand	ymm6, ymm9, ymm2
	vmovdqu	ymm10, ymmword ptr [rsp + 368]
	vpminud	ymm2, ymm2, ymm10
	vpminud	ymm1, ymm1, ymm10
	vpand	ymm1, ymm10, ymm1
	vpor	ymm1, ymm1, ymm3
	vpand	ymm2, ymm10, ymm2
	vpor	ymm2, ymm2, ymm6
	vpsllvd	ymm1, ymm1, ymm5
	vmovdqu	ymmword ptr [rsp + 128], ymm1
	vpsllvd	ymm1, ymm2, ymm4
	vmovdqu	ymmword ptr [rsp + 272], ymm1
	vpsllvd	ymm1, ymm8, ymm5
	vmovdqu	ymmword ptr [rsp + 64], ymm1
	vpsllvd	ymm1, ymm8, ymm4
	vmovdqu	ymmword ptr [rsp + 96], ymm1
	vperm2i128	ymm1, ymm5, ymm4, 33
	vpalignr	ymm1, ymm4, ymm1, 12
	vperm2i128	ymm2, ymm5, ymm5, 10
	vpalignr	ymm2, ymm5, ymm2, 12
	vpaddd	ymm2, ymm2, ymm5
	vpaddd	ymm1, ymm1, ymm4
	vpblendd	ymm6, ymm2, ymm7, 192
	vpermq	ymm6, ymm6, 147
	vpaddd	ymm6, ymm6, ymm2
	vpblendd	ymm2, ymm1, ymm2, 192
	vpermq	ymm2, ymm2, 147
	vpaddd	ymm1, ymm2, ymm1
	vperm2i128	ymm2, ymm6, ymm6, 10
	vpaddd	ymm2, ymm2, ymm6
	vperm2i128	ymm6, ymm6, ymm1, 33
	vpaddd	ymm1, ymm6, ymm1
	vpaddd	ymm1, ymm2, ymm1
	vpsubd	ymm4, ymm1, ymm4
	vpsubd	ymm2, ymm2, ymm5
	mov	eax, r9d
	and	eax, 7
	vmovd	xmm5, eax
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm4, ymm5, ymm4
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm6, ymm4, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm13, ymm9, ymm4
	vpand	ymm5, ymm9, ymm2
	vbroadcasti128	ymm4, xmmword ptr [rip + 632f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm4, ymm7, ymm4
	vmovdqu	ymm6, ymmword ptr [rsp + 336]
	vpaddb	ymm11, ymm2, ymm6
	vpaddb	ymm4, ymm4, ymm6
	mov	qword ptr [rsp + 16], r9
	shr	r9, 3
	lea	rax, [r9 + 64]
	mov	r8, qword ptr [rsp + 8]
	cmp	rax, r8
	jbe	362f
	mov	rax, r8
	sub	rax, r9
	mov	r8, rbp
	jbe	432f
	cmp	rax, 16
	mov	r10, r9
	jb	412f
	mov	r8, qword ptr [rsp]
	lea	r15, [r9 + r8]
	mov	r8, rdi
	sub	r8, r15
	add	r8, 575
	cmp	r8, 127
	mov	r10, r9
	jb	412f
	cmp	rax, 128
	jae	372f
	xor	r13d, r13d
	jmp	392f
362:
	mov	r8, qword ptr [rsp]
	add	r8, r9
	jmp	432f
372:
	mov	r13, rax
	and	r13, -128
	lea	r10, [r9 + r13]
	mov	r8, qword ptr [rsp]
	lea	r8, [r8 + r9 + 96]
	xor	ebp, ebp
	.p2align	4
382:
	vmovdqu	ymm2, ymmword ptr [r8 + rbp - 96]
	vmovdqu	ymm6, ymmword ptr [r8 + rbp - 64]
	vmovdqu	ymm7, ymmword ptr [r8 + rbp - 32]
	vmovdqu	ymm9, ymmword ptr [r8 + rbp]
	vmovdqu	ymmword ptr [rdi + rbp + 576], ymm2
	vmovdqu	ymmword ptr [rdi + rbp + 608], ymm6
	vmovdqu	ymmword ptr [rdi + rbp + 640], ymm7
	vmovdqu	ymmword ptr [rdi + rbp + 672], ymm9
	sub	rbp, -128
	cmp	r13, rbp
	jne	382b
	cmp	rax, r13
	lea	rbp, [rdi + 576]
	mov	r8, rbp
	je	432f
	test	al, 112
	je	412f
392:
	mov	r8, rax
	and	r8, -16
	lea	r10, [r9 + r8]
	.p2align	4
402:
	vmovdqu	xmm2, xmmword ptr [r15 + r13]
	vmovdqu	xmmword ptr [rbp + r13], xmm2
	add	r13, 16
	cmp	r8, r13
	jne	402b
	cmp	rax, r8
	mov	r8, rbp
	je	432f
412:
	mov	rax, rbp
	sub	rax, r9
	mov	r9, qword ptr [rsp]
	mov	r15, qword ptr [rsp + 8]
	.p2align	4
422:
	movzx	r8d, byte ptr [r9 + r10]
	mov	byte ptr [rax + r10], r8b
	inc	r10
	cmp	r15, r10
	jne	422b
	mov	r8, rbp
432:
	vmovdqu	ymm2, ymmword ptr [r8]
	vmovdqu	ymm6, ymmword ptr [r8 + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm9, ymm7, ymm11
	vpshufb	ymm14, ymm2, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 642f]
	vpand	ymm15, ymm11, ymm3
	vpxor	xmm10, xmm10, xmm10
	vpcmpeqb	ymm15, ymm15, ymm10
	vpblendvb	ymm9, ymm14, ymm9, ymm15
	vpermq	ymm14, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm12, ymm14, ymm11
	vpshufb	ymm8, ymm6, ymm11
	vpblendvb	ymm8, ymm8, ymm12, ymm15
	vpshufb	ymm7, ymm7, ymm4
	vpshufb	ymm2, ymm2, ymm4
	vpand	ymm12, ymm4, ymm3
	vpcmpeqb	ymm12, ymm12, ymm10
	vpblendvb	ymm2, ymm2, ymm7, ymm12
	vpshufb	ymm7, ymm14, ymm4
	vpshufb	ymm6, ymm6, ymm4
	vpblendvb	ymm6, ymm6, ymm7, ymm12
	vpxor	xmm7, xmm7, xmm7
	vpbroadcastb	ymm3, byte ptr [rip + 652f]
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm2, ymm2, ymm6, ymm4
	vpand	ymm4, ymm11, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm4, ymm9, ymm8, ymm4
	vpsrlvd	ymm2, ymm2, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 64]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 128]
	vpsrlvd	ymm3, ymm4, ymm13
	vmovdqu	ymm4, ymmword ptr [rsp + 96]
	vpandn	ymm3, ymm4, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 272]
	vpor	ymm4, ymm3, ymmword ptr [rip + 662f]
	vpcmpeqd	ymm3, ymm3, ymm7
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 672f]
	vpcmpeqd	ymm2, ymm2, ymm7
	vpandn	ymm2, ymm2, ymm4
	vperm2i128	ymm4, ymm2, ymm2, 10
	vpalignr	ymm4, ymm2, ymm4, 12
	vpmaxud	ymm4, ymm2, ymm4
	vperm2i128	ymm2, ymm2, ymm3, 33
	vpalignr	ymm2, ymm3, ymm2, 12
	vpmaxud	ymm2, ymm3, ymm2
	vpblendd	ymm3, ymm2, ymm4, 192
	vpermq	ymm3, ymm3, 147
	vpmaxud	ymm2, ymm2, ymm3
	vpblendd	ymm3, ymm4, ymm7, 192
	vpermq	ymm3, ymm3, 147
	vpmaxud	ymm3, ymm4, ymm3
	vperm2i128	ymm4, ymm3, ymm3, 10
	vpmaxud	ymm4, ymm3, ymm4
	vperm2i128	ymm3, ymm3, ymm2, 33
	vpmaxud	ymm2, ymm2, ymm3
	vpmaxud	ymm2, ymm2, ymm4
	vmovdqu	ymm5, ymmword ptr [rsp + 304]
	vpand	ymm3, ymm2, ymm5
	vpcmpeqd	ymm2, ymm2, ymm7
	vblendvps	ymm2, ymm3, ymm0, ymm2
	vpand	ymm3, ymm4, ymm5
	vpcmpeqd	ymm4, ymm4, ymm7
	vblendvps	ymm0, ymm3, ymm0, ymm4
	vextracti128	xmm1, ymm1, 1
	vpextrd	eax, xmm1, 3
	vmovups	ymmword ptr [rdi + 448], ymm0
	vmovups	ymmword ptr [rdi + 480], ymm2
	vshufps	ymm0, ymm2, ymm2, 255
	vpermpd	ymm0, ymm0, 170
	mov	r9, qword ptr [rsp + 16]
	add	r9, rax
	.p2align	4
442:
	lea	r13, [rdi + 512]
	mov	r15, qword ptr [rsp + 24]
	shr	r14, 56
	add	r14, r12
	mov	r8, qword ptr [rsp + 32]
	shr	r8, 56
	add	r8, rbx
	vmovd	eax, xmm0
	mov	qword ptr [rdi + 72], r9
	mov	qword ptr [rdi + 96], rax
	mov	qword ptr [rdi + 128], r8
	mov	qword ptr [rdi + 136], r14
	xor	eax, eax
	mov	r12d, 32
	mov	rbp, qword ptr [rsp + 224]
	.p2align	4
452:
	mov	r8, r11
	movzx	r10d, byte ptr [rdi + rax + 512]
	movzx	r9d, byte ptr [rdi + rax + 192]
	mov	r11d, dword ptr [rdi + 4*rax + 256]
	vmovdqu	ymm0, ymmword ptr [rsi]
	cmp	r8, 33
	cmovb	r8, r12
	mov	rbx, rdx
	sub	rbx, r8
	cmp	rbx, rcx
	jl	482f
	vpaddb	ymm0, ymm0, ymmword ptr [rbx]
	vmovdqu	ymmword ptr [rdx], ymm0
	cmp	r9b, 33
	jae	492f
462:
	add	rdx, r9
	mov	ebx, r10d
	shr	ebx, 2
	cmp	rbx, 32
	mov	r8d, 32
	cmovb	r8, rbx
	cmp	r11, r8
	cmova	r8, r11
	mov	r14, rdx
	sub	r14, r8
	cmp	r14, rcx
	jl	512f
	vmovups	ymm0, ymmword ptr [r14]
	vmovups	ymmword ptr [rdx], ymm0
	cmp	r10b, -124
	jae	522f
472:
	add	rdx, rbx
	add	rsi, r9
	inc	rax
	cmp	rax, rbp
	jne	452b
	jmp	2b
482:
	mov	r14, rdx
	sub	r14, rcx
	sub	r14, r8
	mov	ebx, 0
	cmovae	rbx, r14
	add	rbx, rcx
	vpaddb	ymm0, ymm0, ymmword ptr [rbx]
	vmovdqu	ymmword ptr [rdx], ymm0
	cmp	r9b, 33
	jb	462b
492:
	mov	r8, qword ptr [rdi + 48]
	mov	rbx, qword ptr [rdi + 120]
	movzx	r9d, byte ptr [r8 + rbx]
	inc	rbx
	mov	qword ptr [rdi + 120], rbx
	add	r9, 33
	mov	r8d, 32
	.p2align	4
502:
	vmovdqu	ymm0, ymmword ptr [rsi + r8]
	vmovdqu	ymmword ptr [rdx + r8], ymm0
	add	r8, 32
	cmp	r8, r9
	jb	502b
	jmp	462b
512:
	mov	r15, rdx
	sub	r15, rcx
	sub	r15, r8
	mov	r14d, 0
	cmovae	r14, r15
	mov	r15, qword ptr [rsp + 24]
	add	r14, rcx
	vmovups	ymm0, ymmword ptr [r14]
	vmovups	ymmword ptr [rdx], ymm0
	cmp	r10b, -124
	jb	472b
522:
	mov	r8, qword ptr [rdi + 48]
	mov	r10, qword ptr [rdi + 120]
	movzx	ebx, byte ptr [r8 + r10]
	inc	r10
	mov	qword ptr [rdi + 120], r10
	add	rbx, 33
	mov	r8d, 32
	.p2align	4
532:
	vmovups	ymm0, ymmword ptr [r14 + r8]
	vmovups	ymmword ptr [rdx + r8], ymm0
	add	r8, 32
	cmp	r8, rbx
	jb	532b
	jmp	472b
542:
	sub	rdx, rcx
	sub	rsi, qword ptr [rsp + 200]
	mov	qword ptr [rdi + 80], rdx
	mov	qword ptr [rdi + 88], rsi
	add	rsp, 504
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	vzeroupper
	ret
	.p2align	2, 0x0
552:
	.long	1
	.p2align	2, 0x0
562:
	.long	7
	.p2align	2, 0x0
572:
	.long	8
	.p2align	2, 0x0
582:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	2, 0x0
592:
	.long	134217727
	.p2align	5, 0x0
602:
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	14
	.byte	15
	.byte	16
	.byte	17
	.byte	18
	.byte	19
	.byte	20
	.byte	21
	.byte	22
	.byte	23
	.byte	24
	.byte	25
	.byte	26
	.byte	27
	.byte	28
	.byte	29
	.byte	30
	.byte	31
	.byte	32
	.p2align	5, 0x0
612:
	.byte	33
	.byte	34
	.byte	35
	.byte	36
	.byte	37
	.byte	38
	.byte	39
	.byte	40
	.byte	41
	.byte	42
	.byte	43
	.byte	44
	.byte	45
	.byte	46
	.byte	47
	.byte	48
	.byte	49
	.byte	50
	.byte	51
	.byte	52
	.byte	53
	.byte	54
	.byte	55
	.byte	56
	.byte	57
	.byte	58
	.byte	59
	.byte	60
	.byte	61
	.byte	62
	.byte	63
	.byte	64
	.p2align	2, 0x0
622:
	.byte	1
	.p2align	4, 0x0
632:
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.p2align	2, 0x0
642:
	.byte	16
	.p2align	2, 0x0
652:
	.byte	32
	.p2align	5, 0x0
662:
	.long	1207959552
	.long	1342177280
	.long	1476395008
	.long	1610612736
	.long	1744830464
	.long	1879048192
	.long	2013265920
	.long	2147483648
	.p2align	5, 0x0
672:
	.long	134217728
	.long	268435456
	.long	402653184
	.long	536870912
	.long	671088640
	.long	805306368
	.long	939524096
	.long	1073741824

# minlz_exec_flat of crates/minlz/mlir/exec64.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 568
	mov	rbx, qword ptr [rdi]
	mov	rax, qword ptr [rdi + 8]
	mov	rcx, qword ptr [rdi + 64]
	mov	rdx, qword ptr [rdi + 80]
	add	rdx, rbx
	mov	rsi, qword ptr [rdi + 88]
	mov	qword ptr [rsp + 200], rax
	add	rsi, rax
	test	rcx, rcx
	jle	542f
	lea	r8, [rdi + 512]
	mov	eax, 96
	mov	qword ptr [rsp + 40], rax
	mov	eax, 7
	mov	qword ptr [rsp + 32], rax
	mov	qword ptr [rsp + 48], 0
	vpxor	xmm6, xmm6, xmm6
	vbroadcastss	ymm0, dword ptr [rip + 552f]
	vmovups	ymmword ptr [rsp + 432], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 562f]
	vmovups	ymmword ptr [rsp + 400], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 572f]
	vmovups	ymmword ptr [rsp + 368], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 582f]
	vmovups	ymmword ptr [rsp + 336], ymm0
	vpbroadcastd	ymm0, dword ptr [rip + 592f]
	vmovdqu	ymmword ptr [rsp + 304], ymm0
	mov	rax, r8
	mov	rbp, rcx
	xor	r10d, r10d
	mov	qword ptr [rsp + 216], rbx
	mov	qword ptr [rsp + 208], rcx
	jmp	12f
	.p2align	4
2:
	mov	rbp, qword ptr [rsp + 232]
	add	rbp, -64
	inc	qword ptr [rsp + 48]
	add	qword ptr [rsp + 40], 64
	add	qword ptr [rsp + 32], -64
	mov	rax, qword ptr [rsp + 56]
	add	rax, -64
	mov	rcx, qword ptr [rsp + 208]
	mov	r10, qword ptr [rsp + 224]
	cmp	r10, rcx
	lea	r8, [rdi + 512]
	jge	542f
12:
	mov	qword ptr [rsp + 56], rax
	cmp	rbp, 1
	mov	qword ptr [rsp + 232], rbp
	adc	rbp, 0
	cmp	rbp, 64
	mov	eax, 64
	cmovae	rbp, rax
	sub	rcx, r10
	cmp	rcx, 64
	mov	r11d, 64
	mov	qword ptr [rsp + 272], rcx
	cmovb	r11, rcx
	mov	r12, qword ptr [rdi + 16]
	mov	r14, qword ptr [rdi + 24]
	mov	rax, qword ptr [rdi + 32]
	mov	qword ptr [rsp + 128], rax
	mov	rax, qword ptr [rdi + 40]
	mov	qword ptr [rsp + 8], rax
	mov	rbx, qword ptr [rdi + 64]
	mov	rax, qword ptr [rdi + 72]
	mov	qword ptr [rsp + 16], rax
	mov	rax, qword ptr [rdi + 96]
	mov	qword ptr [rsp + 96], rax
	mov	rax, qword ptr [rdi + 112]
	mov	qword ptr [rsp + 24], rax
	mov	rax, qword ptr [rdi + 128]
	mov	qword ptr [rsp + 160], rax
	mov	rax, qword ptr [rdi + 136]
	mov	qword ptr [rsp + 64], rax
	lea	r13, [rbx + 7]
	lea	rax, [r10 + 64]
	mov	qword ptr [rsp + 224], rax
	cmp	rax, r13
	jbe	52f
	cmp	r10, r13
	mov	rax, r8
	jge	62f
	mov	rax, qword ptr [rsp + 48]
	shl	rax, 6
	mov	r15d, 7
	sub	r15, rax
	add	r15, rbx
	cmp	r15, 16
	jb	22f
	add	rax, r12
	mov	rcx, rdi
	sub	rcx, rax
	add	rcx, 511
	cmp	rcx, 127
	jae	82f
22:
	mov	r15, r10
32:
	mov	rcx, qword ptr [rsp + 56]
	.p2align	4
42:
	movzx	eax, byte ptr [r12 + r15]
	mov	byte ptr [rcx + r15], al
	inc	r15
	cmp	r13, r15
	jne	42b
	mov	rax, r8
	jmp	62f
	.p2align	4
52:
	add	r12, r10
	mov	rax, r12
62:
	vmovdqu	ymm2, ymmword ptr [rax]
	vmovdqu	ymm1, ymmword ptr [rax + 32]
	vmovd	xmm3, r11d
	vpbroadcastb	ymm4, xmm3
	vpmaxub	ymm3, ymm4, ymmword ptr [rip + 602f]
	vpcmpeqb	ymm3, ymm4, ymm3
	vpmaxub	ymm5, ymm4, ymmword ptr [rip + 612f]
	vpcmpeqb	ymm5, ymm4, ymm5
	vpsllw	ymm4, ymm2, 6
	vpcmpgtb	ymm9, ymm6, ymm4
	vpsllw	ymm4, ymm1, 6
	vpcmpgtb	ymm11, ymm6, ymm4
	vpbroadcastb	ymm0, byte ptr [rip + 622f]
	vpand	ymm4, ymm2, ymm0
	vpand	ymm8, ymm1, ymm0
	vpcmpeqb	ymm8, ymm8, ymm6
	vpcmpeqb	ymm4, ymm4, ymm6
	movabs	rbx, 72340172838076673
	mov	r11, rbx
	#APP
	#NO_APP
	vpand	ymm9, ymm9, ymm0
	vpand	ymm10, ymm9, ymm3
	vpand	ymm9, ymm11, ymm0
	vpand	ymm9, ymm9, ymm5
	vmovdqu	ymmword ptr [rdi + 544], ymm9
	vmovdqu	ymmword ptr [rdi + 512], ymm10
	vmovq	rax, xmm10
	mov	r9, rax
	imul	r9, r11
	mov	rcx, r9
	sub	rcx, rax
	xor	rax, r11
	shl	rax, 7
	or	rax, rcx
	mov	rcx, qword ptr [rsp + 160]
	vmovq	xmm11, qword ptr [r14 + rcx]
	vmovq	xmm12, rax
	vpshufb	xmm11, xmm11, xmm12
	shr	r9, 56
	add	r9, rcx
	vmovq	qword ptr [rdi + 512], xmm11
	vpextrq	rcx, xmm10, 1
	mov	rax, rcx
	imul	rax, r11
	mov	r8, rax
	sub	r8, rcx
	xor	rcx, r11
	shl	rcx, 7
	or	rcx, r8
	vmovq	xmm11, qword ptr [r14 + r9]
	vmovq	xmm12, rcx
	vpshufb	xmm11, xmm11, xmm12
	shr	rax, 56
	add	rax, r9
	vmovq	qword ptr [rdi + 520], xmm11
	vextracti128	xmm10, ymm10, 1
	vmovq	rcx, xmm10
	mov	r9, rcx
	imul	r9, r11
	mov	r8, r9
	sub	r8, rcx
	xor	rcx, r11
	shl	rcx, 7
	or	rcx, r8
	vmovq	xmm11, qword ptr [r14 + rax]
	vmovq	xmm12, rcx
	vpshufb	xmm11, xmm11, xmm12
	shr	r9, 56
	add	r9, rax
	vmovq	qword ptr [rdi + 528], xmm11
	vpextrq	rcx, xmm10, 1
	mov	rax, rcx
	imul	rax, r11
	mov	r8, rax
	sub	r8, rcx
	xor	rcx, r11
	shl	rcx, 7
	or	rcx, r8
	vmovq	xmm10, qword ptr [r14 + r9]
	vmovq	xmm11, rcx
	vpshufb	xmm10, xmm10, xmm11
	shr	rax, 56
	add	rax, r9
	vmovq	qword ptr [rdi + 536], xmm10
	vmovq	rcx, xmm9
	mov	r9, rcx
	imul	r9, r11
	mov	r8, r9
	sub	r8, rcx
	xor	rcx, r11
	shl	rcx, 7
	or	rcx, r8
	vmovq	xmm10, qword ptr [r14 + rax]
	vmovq	xmm11, rcx
	vpshufb	xmm10, xmm10, xmm11
	shr	r9, 56
	add	r9, rax
	vmovq	qword ptr [rdi + 544], xmm10
	vpextrq	rcx, xmm9, 1
	mov	rax, rcx
	imul	rax, r11
	mov	r8, rax
	sub	r8, rcx
	xor	rcx, r11
	shl	rcx, 7
	or	rcx, r8
	vmovq	xmm9, qword ptr [r14 + r9]
	vmovq	xmm10, rcx
	vpshufb	xmm9, xmm9, xmm10
	shr	rax, 56
	add	rax, r9
	vmovq	qword ptr [rdi + 552], xmm9
	mov	rcx, qword ptr [rdi + 560]
	mov	r8, qword ptr [rdi + 568]
	mov	r10, rcx
	imul	r10, r11
	mov	r9, r10
	sub	r9, rcx
	xor	rcx, r11
	shl	rcx, 7
	or	rcx, r9
	vmovq	xmm9, qword ptr [r14 + rax]
	vmovq	xmm10, rcx
	vpshufb	xmm9, xmm9, xmm10
	shr	r10, 56
	add	r10, rax
	vmovq	qword ptr [rdi + 560], xmm9
	mov	r15, r8
	imul	r15, r11
	mov	rax, r15
	sub	rax, r8
	xor	r11, r8
	shl	r11, 7
	or	r11, rax
	vmovq	xmm9, qword ptr [r14 + r10]
	vmovq	xmm10, r11
	vpshufb	xmm9, xmm9, xmm10
	vmovq	qword ptr [rdi + 568], xmm9
	vmovups	ymm9, ymmword ptr [rdi + 544]
	vmovups	ymm10, ymmword ptr [rdi + 512]
	vmovups	ymmword ptr [rdi + 192], ymm10
	vmovups	ymmword ptr [rdi + 224], ymm9
	mov	r11, rbx
	#APP
	#NO_APP
	vpand	ymm8, ymm8, ymm0
	vpand	ymm5, ymm8, ymm5
	vpand	ymm4, ymm4, ymm0
	vpand	ymm3, ymm3, ymm4
	vmovdqu	ymmword ptr [rdi + 512], ymm3
	vmovdqu	ymmword ptr [rdi + 544], ymm5
	vmovq	rax, xmm3
	mov	r9, r11
	imul	r9, rax
	mov	rcx, r9
	sub	rcx, rax
	xor	rax, r11
	shl	rax, 7
	or	rax, rcx
	mov	r12, qword ptr [rsp + 128]
	mov	rcx, qword ptr [rsp + 64]
	vmovq	xmm4, qword ptr [r12 + rcx]
	vmovq	xmm8, rax
	vpshufb	xmm4, xmm4, xmm8
	shr	r9, 56
	add	r9, rcx
	vmovq	qword ptr [rdi + 512], xmm4
	vpextrq	rcx, xmm3, 1
	mov	rax, r11
	imul	rax, rcx
	mov	r8, rax
	sub	r8, rcx
	xor	rcx, r11
	shl	rcx, 7
	or	rcx, r8
	vmovq	xmm4, qword ptr [r12 + r9]
	vmovq	xmm8, rcx
	vpshufb	xmm4, xmm4, xmm8
	shr	rax, 56
	add	rax, r9
	vmovq	qword ptr [rdi + 520], xmm4
	vextracti128	xmm3, ymm3, 1
	vmovq	rcx, xmm3
	mov	r9, r11
	imul	r9, rcx
	mov	r8, r9
	sub	r8, rcx
	xor	rcx, r11
	shl	rcx, 7
	or	rcx, r8
	vmovq	xmm4, qword ptr [r12 + rax]
	vmovq	xmm8, rcx
	vpshufb	xmm4, xmm4, xmm8
	shr	r9, 56
	add	r9, rax
	vmovq	qword ptr [rdi + 528], xmm4
	vpextrq	rcx, xmm3, 1
	mov	rax, r11
	imul	rax, rcx
	mov	r8, rax
	sub	r8, rcx
	xor	rcx, r11
	shl	rcx, 7
	or	rcx, r8
	vmovq	xmm3, qword ptr [r12 + r9]
	vmovq	xmm4, rcx
	vpshufb	xmm3, xmm3, xmm4
	shr	rax, 56
	add	rax, r9
	vmovq	qword ptr [rdi + 536], xmm3
	vmovq	rcx, xmm5
	mov	r9, r11
	imul	r9, rcx
	mov	r8, r9
	sub	r8, rcx
	xor	rcx, r11
	shl	rcx, 7
	or	rcx, r8
	vmovq	xmm3, qword ptr [r12 + rax]
	vmovq	xmm4, rcx
	vpshufb	xmm3, xmm3, xmm4
	shr	r9, 56
	add	r9, rax
	vmovq	qword ptr [rdi + 544], xmm3
	vpextrq	rcx, xmm5, 1
	mov	rax, r11
	imul	rax, rcx
	mov	r8, rax
	sub	r8, rcx
	xor	rcx, r11
	shl	rcx, 7
	or	rcx, r8
	vmovq	xmm3, qword ptr [r12 + r9]
	vmovq	xmm4, rcx
	vpshufb	xmm3, xmm3, xmm4
	shr	rax, 56
	add	rax, r9
	vmovq	qword ptr [rdi + 552], xmm3
	mov	rcx, qword ptr [rdi + 560]
	mov	r8, qword ptr [rdi + 568]
	mov	rbx, rcx
	imul	rbx, r11
	mov	r9, rbx
	sub	r9, rcx
	xor	rcx, r11
	shl	rcx, 7
	or	rcx, r9
	vmovq	xmm3, qword ptr [r12 + rax]
	vmovq	xmm4, rcx
	vpshufb	xmm3, xmm3, xmm4
	shr	rbx, 56
	add	rbx, rax
	vmovq	qword ptr [rdi + 560], xmm3
	mov	r14, r8
	imul	r14, r11
	mov	rax, r14
	sub	rax, r8
	xor	r11, r8
	shl	r11, 7
	or	r11, rax
	vmovq	xmm3, qword ptr [r12 + rbx]
	vmovq	xmm4, r11
	vpshufb	xmm3, xmm3, xmm4
	vmovq	qword ptr [rdi + 568], xmm3
	vmovups	ymm0, ymmword ptr [rdi + 512]
	vmovups	ymmword ptr [rsp + 528], ymm0
	vmovups	ymm0, ymmword ptr [rdi + 544]
	vmovups	ymmword ptr [rsp + 464], ymm0
	vpmovzxbd	ymm3, qword ptr [rdi + 520]
	vpmovzxbd	ymm5, qword ptr [rdi + 512]
	vmovdqu	ymmword ptr [rsp + 128], ymm2
	vmovdqu	ymmword ptr [rdi + 512], ymm2
	vmovdqu	ymmword ptr [rsp + 496], ymm1
	vmovdqu	ymmword ptr [rdi + 544], ymm1
	vmovss	xmm4, dword ptr [rsp + 96]
	vbroadcastss	ymm13, xmm4
	vpsrld	ymm8, ymm5, 3
	vpsrld	ymm4, ymm3, 3
	vmovdqu	ymm0, ymmword ptr [rsp + 432]
	vpmaxud	ymm4, ymm4, ymm0
	vpcmpeqd	ymm1, ymm1, ymm1
	vpaddd	ymm4, ymm4, ymm1
	vpmaxud	ymm8, ymm8, ymm0
	vpaddd	ymm9, ymm8, ymm1
	vmovdqu	ymm0, ymmword ptr [rsp + 400]
	vpand	ymm8, ymm5, ymm0
	vpand	ymm10, ymm3, ymm0
	vmovdqu	ymm2, ymmword ptr [rsp + 368]
	vpminud	ymm3, ymm3, ymm2
	vpminud	ymm5, ymm5, ymm2
	vpand	ymm5, ymm5, ymm2
	vpor	ymm5, ymm8, ymm5
	vpand	ymm3, ymm3, ymm2
	vpor	ymm8, ymm10, ymm3
	vpsllvd	ymm2, ymm5, ymm9
	vmovdqu	ymmword ptr [rsp + 64], ymm2
	vpsllvd	ymm2, ymm8, ymm4
	vmovdqu	ymmword ptr [rsp + 96], ymm2
	vpsllvd	ymm2, ymm1, ymm9
	vmovdqu	ymmword ptr [rsp + 240], ymm2
	vpsllvd	ymm1, ymm1, ymm4
	vmovdqu	ymmword ptr [rsp + 160], ymm1
	vperm2i128	ymm8, ymm9, ymm4, 33
	vpalignr	ymm8, ymm4, ymm8, 12
	vperm2i128	ymm11, ymm9, ymm9, 10
	vpalignr	ymm11, ymm9, ymm11, 12
	vpaddd	ymm11, ymm11, ymm9
	vpaddd	ymm8, ymm8, ymm4
	vpblendd	ymm14, ymm11, ymm6, 192
	vpermq	ymm14, ymm14, 147
	vpaddd	ymm14, ymm14, ymm11
	vpblendd	ymm11, ymm8, ymm11, 192
	vpermq	ymm11, ymm11, 147
	vpaddd	ymm8, ymm11, ymm8
	vperm2i128	ymm11, ymm14, ymm14, 10
	vpaddd	ymm11, ymm11, ymm14
	vperm2i128	ymm14, ymm14, ymm8, 33
	vpaddd	ymm8, ymm14, ymm8
	vpaddd	ymm8, ymm11, ymm8
	vpsubd	ymm4, ymm8, ymm4
	vpsubd	ymm9, ymm11, ymm9
	mov	r8, qword ptr [rsp + 16]
	mov	eax, r8d
	and	eax, 7
	vmovd	xmm11, eax
	vpbroadcastd	ymm11, xmm11
	vpaddd	ymm4, ymm11, ymm4
	vpaddd	ymm9, ymm9, ymm11
	vpsrld	ymm11, ymm4, 3
	vpsrld	ymm14, ymm9, 3
	vpand	ymm4, ymm4, ymm0
	vpand	ymm9, ymm9, ymm0
	vbroadcasti128	ymm0, xmmword ptr [rip + 632f]
	vpshufb	ymm11, ymm11, ymm0
	vpshufb	ymm0, ymm14, ymm0
	vmovdqu	ymm1, ymmword ptr [rsp + 336]
	vpaddb	ymm14, ymm11, ymm1
	vpaddb	ymm11, ymm0, ymm1
	shr	r8, 3
	lea	rax, [r8 + 64]
	mov	r9, qword ptr [rsp + 24]
	cmp	rax, r9
	jbe	72f
	sub	r9, r8
	lea	r13, [rdi + 576]
	mov	rcx, r13
	jbe	152f
	cmp	r9, 16
	mov	r11, r8
	jb	132f
	mov	rax, qword ptr [rsp + 8]
	lea	r12, [r8 + rax]
	mov	rax, rdi
	sub	rax, r12
	add	rax, 575
	cmp	rax, 127
	mov	r11, r8
	jb	132f
	cmp	r9, 128
	jae	92f
	xor	eax, eax
	jmp	112f
	.p2align	4
72:
	add	r8, qword ptr [rsp + 8]
	mov	rcx, r8
	lea	r13, [rdi + 576]
	jmp	152f
82:
	cmp	r15, 128
	jae	172f
	xor	r9d, r9d
	mov	rcx, r15
	jmp	192f
92:
	mov	rax, r9
	and	rax, -128
	lea	r11, [r8 + rax]
	mov	rcx, qword ptr [rsp + 8]
	lea	rcx, [rcx + r8 + 96]
	xor	r13d, r13d
	.p2align	4
102:
	vmovdqu	ymm0, ymmword ptr [rcx + r13 - 96]
	vmovdqu	ymm6, ymmword ptr [rcx + r13 - 64]
	vmovdqu	ymm7, ymmword ptr [rcx + r13 - 32]
	vmovdqu	ymm15, ymmword ptr [rcx + r13]
	vmovdqu	ymmword ptr [rdi + r13 + 576], ymm0
	vmovdqu	ymmword ptr [rdi + r13 + 608], ymm6
	vmovdqu	ymmword ptr [rdi + r13 + 640], ymm7
	vmovdqu	ymmword ptr [rdi + r13 + 672], ymm15
	sub	r13, -128
	cmp	rax, r13
	jne	102b
	cmp	r9, rax
	lea	r13, [rdi + 576]
	mov	rcx, r13
	je	152f
	test	r9b, 112
	je	132f
112:
	mov	rcx, r9
	and	rcx, -16
	lea	r11, [r8 + rcx]
	.p2align	4
122:
	vmovdqu	xmm0, xmmword ptr [r12 + rax]
	vmovdqu	xmmword ptr [r13 + rax], xmm0
	add	rax, 16
	cmp	rcx, rax
	jne	122b
	cmp	r9, rcx
	mov	rcx, r13
	je	152f
	.p2align	4
132:
	mov	rax, r13
	sub	rax, r8
	mov	r8, qword ptr [rsp + 8]
	mov	r9, qword ptr [rsp + 24]
	.p2align	4
142:
	movzx	ecx, byte ptr [r8 + r11]
	mov	byte ptr [rax + r11], cl
	inc	r11
	cmp	r9, r11
	jne	142b
	mov	rcx, r13
152:
	vmovdqu	ymm0, ymmword ptr [rcx]
	vmovdqu	ymm6, ymmword ptr [rcx + 32]
	vpermq	ymm7, ymm0, 68
	vpermq	ymm0, ymm0, 238
	vpshufb	ymm15, ymm7, ymm14
	vpshufb	ymm2, ymm0, ymm14
	vpbroadcastb	ymm5, byte ptr [rip + 642f]
	vpand	ymm1, ymm14, ymm5
	vpxor	xmm12, xmm12, xmm12
	vpcmpeqb	ymm1, ymm12, ymm1
	vpblendvb	ymm2, ymm2, ymm15, ymm1
	vpermq	ymm15, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm10, ymm15, ymm14
	vpshufb	ymm3, ymm6, ymm14
	vpblendvb	ymm1, ymm3, ymm10, ymm1
	vpshufb	ymm3, ymm7, ymm11
	vpshufb	ymm0, ymm0, ymm11
	vpand	ymm7, ymm11, ymm5
	vpcmpeqb	ymm7, ymm12, ymm7
	vpblendvb	ymm0, ymm0, ymm3, ymm7
	vpshufb	ymm3, ymm15, ymm11
	vpshufb	ymm6, ymm6, ymm11
	vpblendvb	ymm3, ymm6, ymm3, ymm7
	vpbroadcastb	ymm5, byte ptr [rip + 652f]
	vpand	ymm6, ymm11, ymm5
	vpcmpeqb	ymm6, ymm6, ymm5
	vpblendvb	ymm0, ymm0, ymm3, ymm6
	vpxor	xmm6, xmm6, xmm6
	vpand	ymm3, ymm14, ymm5
	vpcmpeqb	ymm3, ymm3, ymm5
	vpblendvb	ymm1, ymm2, ymm1, ymm3
	vpsrlvd	ymm0, ymm0, ymm9
	vmovdqu	ymm2, ymmword ptr [rsp + 240]
	vpandn	ymm0, ymm2, ymm0
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 64]
	vpsrlvd	ymm1, ymm1, ymm4
	vmovdqu	ymm2, ymmword ptr [rsp + 160]
	vpandn	ymm1, ymm2, ymm1
	vpaddd	ymm1, ymm1, ymmword ptr [rsp + 96]
	vpor	ymm2, ymm1, ymmword ptr [rip + 662f]
	vpcmpeqd	ymm1, ymm1, ymm6
	vpandn	ymm1, ymm1, ymm2
	vpor	ymm2, ymm0, ymmword ptr [rip + 672f]
	vpcmpeqd	ymm0, ymm0, ymm6
	vpandn	ymm0, ymm0, ymm2
	vperm2i128	ymm2, ymm0, ymm0, 10
	vpalignr	ymm2, ymm0, ymm2, 12
	vpmaxud	ymm2, ymm0, ymm2
	vperm2i128	ymm0, ymm0, ymm1, 33
	vpalignr	ymm0, ymm1, ymm0, 12
	vpmaxud	ymm0, ymm1, ymm0
	vpblendd	ymm1, ymm0, ymm2, 192
	vpermq	ymm1, ymm1, 147
	vpmaxud	ymm0, ymm0, ymm1
	vpblendd	ymm1, ymm2, ymm6, 192
	vpermq	ymm1, ymm1, 147
	vpmaxud	ymm1, ymm2, ymm1
	vperm2i128	ymm2, ymm1, ymm1, 10
	vpmaxud	ymm2, ymm1, ymm2
	vperm2i128	ymm1, ymm1, ymm0, 33
	vpmaxud	ymm0, ymm0, ymm1
	vpmaxud	ymm0, ymm0, ymm2
	vmovdqu	ymm3, ymmword ptr [rsp + 304]
	vpand	ymm1, ymm0, ymm3
	vpcmpeqd	ymm0, ymm0, ymm6
	vblendvps	ymm0, ymm1, ymm13, ymm0
	vpand	ymm1, ymm2, ymm3
	vpcmpeqd	ymm2, ymm2, ymm6
	vblendvps	ymm1, ymm1, ymm13, ymm2
	vmovdqu	ymm2, ymmword ptr [rsp + 128]
	vpsrlw	xmm2, xmm2, 2
	vpand	xmm2, xmm2, xmmword ptr [rip + 682f]
	vpminub	xmm2, xmm2, xmm5
	vpmovzxbd	ymm3, xmm2
	vpmaxud	ymm1, ymm1, ymm3
	vextracti128	xmm3, ymm8, 1
	vpextrd	eax, xmm3, 3
	vmovdqu	ymmword ptr [rdi + 256], ymm1
	vpshufd	xmm1, xmm2, 238
	vpmovzxbd	ymm1, xmm1
	vpmaxud	ymm1, ymm0, ymm1
	vmovdqu	ymmword ptr [rdi + 288], ymm1
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm13, ymm0, 170
	mov	rcx, qword ptr [rsp + 16]
	add	rcx, rax
	cmp	qword ptr [rsp + 272], 17
	jb	442f
	vmovdqu	ymm0, ymmword ptr [rsp + 528]
	vextracti128	xmm0, ymm0, 1
	vpshufd	xmm1, xmm0, 238
	vpmovzxbd	ymm1, xmm1
	vpmovzxbd	ymm0, xmm0
	vpsrld	ymm2, ymm0, 3
	vpsrld	ymm3, ymm1, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 432]
	vpmaxud	ymm3, ymm3, ymm5
	vpcmpeqd	ymm7, ymm7, ymm7
	vpaddd	ymm4, ymm3, ymm7
	vpmaxud	ymm2, ymm2, ymm5
	vpaddd	ymm5, ymm2, ymm7
	vmovdqu	ymm8, ymmword ptr [rsp + 400]
	vpand	ymm2, ymm8, ymm0
	vpand	ymm3, ymm8, ymm1
	vmovdqu	ymm9, ymmword ptr [rsp + 368]
	vpminud	ymm1, ymm1, ymm9
	vpminud	ymm0, ymm0, ymm9
	vpand	ymm0, ymm9, ymm0
	vpor	ymm0, ymm0, ymm2
	vpand	ymm1, ymm9, ymm1
	vpor	ymm1, ymm1, ymm3
	vpsllvd	ymm0, ymm0, ymm5
	vmovdqu	ymmword ptr [rsp + 64], ymm0
	vpsllvd	ymm0, ymm1, ymm4
	vmovdqu	ymmword ptr [rsp + 96], ymm0
	vpsllvd	ymm0, ymm7, ymm5
	vmovdqu	ymmword ptr [rsp + 240], ymm0
	vpsllvd	ymm0, ymm7, ymm4
	vmovdqu	ymmword ptr [rsp + 160], ymm0
	vperm2i128	ymm0, ymm5, ymm4, 33
	vpalignr	ymm0, ymm4, ymm0, 12
	vperm2i128	ymm1, ymm5, ymm5, 10
	vpalignr	ymm1, ymm5, ymm1, 12
	vpaddd	ymm1, ymm1, ymm5
	vpaddd	ymm0, ymm0, ymm4
	vpblendd	ymm2, ymm1, ymm6, 192
	vpermq	ymm2, ymm2, 147
	vpaddd	ymm2, ymm2, ymm1
	vpblendd	ymm1, ymm0, ymm1, 192
	vpermq	ymm1, ymm1, 147
	vpaddd	ymm0, ymm1, ymm0
	vperm2i128	ymm1, ymm2, ymm2, 10
	vpaddd	ymm1, ymm1, ymm2
	vperm2i128	ymm2, ymm2, ymm0, 33
	vpaddd	ymm0, ymm2, ymm0
	vpaddd	ymm15, ymm1, ymm0
	vpsubd	ymm0, ymm15, ymm4
	vpsubd	ymm1, ymm1, ymm5
	mov	eax, ecx
	and	eax, 7
	vmovd	xmm2, eax
	vpbroadcastd	ymm2, xmm2
	vpaddd	ymm0, ymm2, ymm0
	vpaddd	ymm1, ymm2, ymm1
	vpsrld	ymm2, ymm0, 3
	vpsrld	ymm6, ymm1, 3
	vpand	ymm5, ymm8, ymm0
	vpand	ymm4, ymm8, ymm1
	vbroadcasti128	ymm1, xmmword ptr [rip + 632f]
	vpshufb	ymm0, ymm2, ymm1
	vpshufb	ymm1, ymm6, ymm1
	vmovdqu	ymm2, ymmword ptr [rsp + 336]
	vpaddb	ymm9, ymm0, ymm2
	vpaddb	ymm14, ymm1, ymm2
	mov	r8, rcx
	shr	r8, 3
	lea	rax, [r8 + 64]
	mov	r9, qword ptr [rsp + 24]
	cmp	rax, r9
	jbe	162f
	sub	r9, r8
	jbe	272f
	cmp	r9, 16
	mov	r11, r8
	jb	252f
	mov	rax, qword ptr [rsp + 8]
	lea	r12, [r8 + rax]
	mov	rax, rdi
	sub	rax, r12
	add	rax, 575
	cmp	rax, 127
	mov	r11, r8
	jb	252f
	cmp	r9, 128
	mov	qword ptr [rsp + 16], rcx
	jae	212f
	xor	eax, eax
	jmp	232f
	.p2align	4
162:
	add	r8, qword ptr [rsp + 8]
	mov	r13, r8
	jmp	272f
172:
	mov	qword ptr [rsp + 240], r15
	mov	r9, r15
	and	r9, -128
	lea	r15, [r10 + r9]
	mov	rax, qword ptr [rsp + 40]
	add	rax, r12
	mov	rcx, qword ptr [rsp + 32]
	add	rcx, rbx
	and	rcx, -128
	xor	r8d, r8d
	.p2align	4
182:
	vmovdqu	ymm0, ymmword ptr [rax + r8 - 96]
	vmovdqu	ymm1, ymmword ptr [rax + r8 - 64]
	vmovdqu	ymm3, ymmword ptr [rax + r8 - 32]
	vmovdqu	ymm4, ymmword ptr [rax + r8]
	vmovdqu	ymmword ptr [rdi + r8 + 512], ymm0
	vmovdqu	ymmword ptr [rdi + r8 + 544], ymm1
	vmovdqu	ymmword ptr [rdi + r8 + 576], ymm3
	vmovdqu	ymmword ptr [rdi + r8 + 608], ymm4
	sub	r8, -128
	cmp	rcx, r8
	jne	182b
	mov	rcx, qword ptr [rsp + 240]
	cmp	rcx, r9
	lea	r8, [rdi + 512]
	mov	rax, r8
	je	62b
	test	cl, 112
	je	32b
192:
	mov	rax, rcx
	and	rax, -16
	mov	r15, rcx
	lea	rcx, [r12 + r10]
	add	r10, rax
	add	rbx, qword ptr [rsp + 32]
	and	rbx, -16
	.p2align	4
202:
	vmovdqu	xmm0, xmmword ptr [rcx + r9]
	vmovdqu	xmmword ptr [r8 + r9], xmm0
	add	r9, 16
	cmp	rbx, r9
	jne	202b
	cmp	r15, rax
	mov	r15, r10
	mov	rax, r8
	je	62b
	jmp	32b
212:
	mov	rax, r9
	and	rax, -128
	lea	r11, [r8 + rax]
	mov	rcx, qword ptr [rsp + 8]
	lea	rcx, [rcx + r8 + 96]
	xor	r13d, r13d
	.p2align	4
222:
	vmovdqu	ymm0, ymmword ptr [rcx + r13 - 96]
	vmovdqu	ymm1, ymmword ptr [rcx + r13 - 64]
	vmovdqu	ymm2, ymmword ptr [rcx + r13 - 32]
	vmovdqu	ymm6, ymmword ptr [rcx + r13]
	vmovdqu	ymmword ptr [rdi + r13 + 576], ymm0
	vmovdqu	ymmword ptr [rdi + r13 + 608], ymm1
	vmovdqu	ymmword ptr [rdi + r13 + 640], ymm2
	vmovdqu	ymmword ptr [rdi + r13 + 672], ymm6
	sub	r13, -128
	cmp	rax, r13
	jne	222b
	cmp	r9, rax
	lea	r13, [rdi + 576]
	mov	rcx, qword ptr [rsp + 16]
	je	272f
	test	r9b, 112
	je	252f
232:
	mov	rcx, r9
	and	rcx, -16
	lea	r11, [r8 + rcx]
	lea	r13, [rdi + 576]
	.p2align	4
242:
	vmovdqu	xmm0, xmmword ptr [r12 + rax]
	vmovdqu	xmmword ptr [r13 + rax], xmm0
	add	rax, 16
	cmp	rcx, rax
	jne	242b
	cmp	r9, rcx
	mov	rcx, qword ptr [rsp + 16]
	je	272f
252:
	mov	r12, rcx
	lea	r9, [rdi + 576]
	mov	rax, r9
	sub	rax, r8
	mov	r8, qword ptr [rsp + 8]
	mov	r13, qword ptr [rsp + 24]
	.p2align	4
262:
	movzx	ecx, byte ptr [r8 + r11]
	mov	byte ptr [rax + r11], cl
	inc	r11
	cmp	r13, r11
	jne	262b
	mov	r13, r9
	mov	rcx, r12
272:
	vmovdqu	ymm0, ymmword ptr [r13]
	vpermq	ymm1, ymm0, 68
	vpermq	ymm0, ymm0, 238
	vpshufb	ymm2, ymm1, ymm9
	vpshufb	ymm6, ymm0, ymm9
	vpbroadcastb	ymm12, byte ptr [rip + 642f]
	vpand	ymm7, ymm9, ymm12
	vpxor	xmm3, xmm3, xmm3
	vpcmpeqb	ymm7, ymm7, ymm3
	vpblendvb	ymm2, ymm6, ymm2, ymm7
	vmovdqu	ymm6, ymmword ptr [r13 + 32]
	vpermq	ymm11, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm8, ymm11, ymm9
	vpshufb	ymm10, ymm6, ymm9
	vpblendvb	ymm7, ymm10, ymm8, ymm7
	vpshufb	ymm1, ymm1, ymm14
	vpshufb	ymm0, ymm0, ymm14
	vpand	ymm8, ymm14, ymm12
	vpcmpeqb	ymm8, ymm8, ymm3
	vpblendvb	ymm0, ymm0, ymm1, ymm8
	vpshufb	ymm1, ymm11, ymm14
	vpshufb	ymm6, ymm6, ymm14
	vpblendvb	ymm1, ymm6, ymm1, ymm8
	vpbroadcastb	ymm3, byte ptr [rip + 652f]
	vpand	ymm6, ymm14, ymm3
	vpcmpeqb	ymm6, ymm6, ymm3
	vpblendvb	ymm0, ymm0, ymm1, ymm6
	vpxor	xmm6, xmm6, xmm6
	vpand	ymm1, ymm9, ymm3
	vpcmpeqb	ymm1, ymm1, ymm3
	vpblendvb	ymm1, ymm2, ymm7, ymm1
	vpsrlvd	ymm0, ymm0, ymm4
	vmovdqu	ymm2, ymmword ptr [rsp + 240]
	vpandn	ymm0, ymm2, ymm0
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 64]
	vpsrlvd	ymm1, ymm1, ymm5
	vmovdqu	ymm2, ymmword ptr [rsp + 160]
	vpandn	ymm1, ymm2, ymm1
	vpaddd	ymm1, ymm1, ymmword ptr [rsp + 96]
	vpor	ymm2, ymm1, ymmword ptr [rip + 662f]
	vpcmpeqd	ymm1, ymm1, ymm6
	vpandn	ymm1, ymm1, ymm2
	vpor	ymm2, ymm0, ymmword ptr [rip + 672f]
	vpcmpeqd	ymm0, ymm0, ymm6
	vpandn	ymm0, ymm0, ymm2
	vperm2i128	ymm2, ymm0, ymm0, 10
	vpalignr	ymm2, ymm0, ymm2, 12
	vpmaxud	ymm2, ymm0, ymm2
	vperm2i128	ymm0, ymm0, ymm1, 33
	vpalignr	ymm0, ymm1, ymm0, 12
	vpmaxud	ymm0, ymm1, ymm0
	vpblendd	ymm1, ymm0, ymm2, 192
	vpermq	ymm1, ymm1, 147
	vpmaxud	ymm0, ymm0, ymm1
	vpblendd	ymm1, ymm2, ymm6, 192
	vpermq	ymm1, ymm1, 147
	vpmaxud	ymm1, ymm2, ymm1
	vperm2i128	ymm2, ymm1, ymm1, 10
	vpmaxud	ymm2, ymm1, ymm2
	vperm2i128	ymm1, ymm1, ymm0, 33
	vpmaxud	ymm0, ymm0, ymm1
	vpmaxud	ymm0, ymm0, ymm2
	vmovdqu	ymm4, ymmword ptr [rsp + 304]
	vpand	ymm1, ymm0, ymm4
	vpcmpeqd	ymm0, ymm0, ymm6
	vblendvps	ymm0, ymm1, ymm13, ymm0
	vpand	ymm1, ymm2, ymm4
	vpcmpeqd	ymm2, ymm2, ymm6
	vblendvps	ymm1, ymm1, ymm13, ymm2
	vmovdqu	ymm2, ymmword ptr [rsp + 128]
	vextracti128	xmm2, ymm2, 1
	vpsrlw	xmm2, xmm2, 2
	vpand	xmm2, xmm2, xmmword ptr [rip + 682f]
	vpminub	xmm2, xmm2, xmm3
	vpmovzxbd	ymm3, xmm2
	vpmaxud	ymm1, ymm1, ymm3
	vextracti128	xmm3, ymm15, 1
	vpextrd	eax, xmm3, 3
	vmovdqu	ymmword ptr [rdi + 320], ymm1
	vpshufd	xmm1, xmm2, 238
	vpmovzxbd	ymm1, xmm1
	vpmaxud	ymm1, ymm0, ymm1
	vmovdqu	ymmword ptr [rdi + 352], ymm1
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm13, ymm0, 170
	add	rcx, rax
	cmp	qword ptr [rsp + 272], 33
	jb	442f
	vmovdqu	ymm1, ymmword ptr [rsp + 464]
	vpshufd	xmm0, xmm1, 238
	vpmovzxbd	ymm0, xmm0
	vpmovzxbd	ymm1, xmm1
	vpsrld	ymm2, ymm1, 3
	vpsrld	ymm3, ymm0, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 432]
	vpmaxud	ymm3, ymm3, ymm5
	vpcmpeqd	ymm7, ymm7, ymm7
	vpaddd	ymm4, ymm3, ymm7
	vpmaxud	ymm2, ymm2, ymm5
	vpaddd	ymm9, ymm2, ymm7
	vmovdqu	ymm8, ymmword ptr [rsp + 400]
	vpand	ymm2, ymm8, ymm1
	vpand	ymm3, ymm8, ymm0
	vmovdqu	ymm5, ymmword ptr [rsp + 368]
	vpminud	ymm0, ymm0, ymm5
	vpminud	ymm1, ymm1, ymm5
	vpand	ymm1, ymm1, ymm5
	vpor	ymm1, ymm1, ymm2
	vpand	ymm0, ymm0, ymm5
	vpor	ymm0, ymm0, ymm3
	vpsllvd	ymm1, ymm1, ymm9
	vmovdqu	ymmword ptr [rsp + 96], ymm1
	vpsllvd	ymm0, ymm0, ymm4
	vmovdqu	ymmword ptr [rsp + 128], ymm0
	vpsllvd	ymm0, ymm7, ymm9
	vmovdqu	ymmword ptr [rsp + 160], ymm0
	vpsllvd	ymm0, ymm7, ymm4
	vmovdqu	ymmword ptr [rsp + 64], ymm0
	vperm2i128	ymm0, ymm9, ymm4, 33
	vpalignr	ymm0, ymm4, ymm0, 12
	vperm2i128	ymm1, ymm9, ymm9, 10
	vpalignr	ymm1, ymm9, ymm1, 12
	vpaddd	ymm1, ymm9, ymm1
	vpaddd	ymm0, ymm0, ymm4
	vpblendd	ymm2, ymm1, ymm6, 192
	vpermq	ymm2, ymm2, 147
	vpaddd	ymm2, ymm2, ymm1
	vpblendd	ymm1, ymm0, ymm1, 192
	vpermq	ymm1, ymm1, 147
	vpaddd	ymm0, ymm1, ymm0
	vperm2i128	ymm1, ymm2, ymm2, 10
	vpaddd	ymm6, ymm1, ymm2
	vperm2i128	ymm1, ymm2, ymm0, 33
	vpaddd	ymm0, ymm1, ymm0
	vpaddd	ymm1, ymm6, ymm0
	vpsubd	ymm0, ymm1, ymm4
	vpsubd	ymm2, ymm6, ymm9
	mov	eax, ecx
	and	eax, 7
	vmovd	xmm4, eax
	vpbroadcastd	ymm4, xmm4
	vpaddd	ymm0, ymm4, ymm0
	vpaddd	ymm2, ymm4, ymm2
	vpsrld	ymm6, ymm0, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm4, ymm8, ymm0
	vpand	ymm9, ymm8, ymm2
	vbroadcasti128	ymm2, xmmword ptr [rip + 632f]
	vpshufb	ymm0, ymm6, ymm2
	vpshufb	ymm2, ymm7, ymm2
	vmovdqu	ymm3, ymmword ptr [rsp + 336]
	vpaddb	ymm12, ymm0, ymm3
	vpaddb	ymm11, ymm2, ymm3
	mov	qword ptr [rsp + 16], rcx
	mov	r8, rcx
	shr	r8, 3
	lea	rax, [r8 + 64]
	mov	r9, qword ptr [rsp + 24]
	cmp	rax, r9
	lea	r13, [rdi + 576]
	jbe	282f
	sub	r9, r8
	mov	rcx, r13
	jbe	352f
	cmp	r9, 16
	mov	r11, r8
	jb	332f
	mov	rax, qword ptr [rsp + 8]
	lea	r12, [r8 + rax]
	mov	rax, rdi
	sub	rax, r12
	add	rax, 575
	cmp	rax, 127
	mov	r11, r8
	jb	332f
	cmp	r9, 128
	jae	292f
	xor	eax, eax
	jmp	312f
282:
	add	r8, qword ptr [rsp + 8]
	mov	rcx, r8
	jmp	352f
292:
	mov	rax, r9
	and	rax, -128
	lea	r11, [r8 + rax]
	mov	rcx, qword ptr [rsp + 8]
	lea	rcx, [rcx + r8 + 96]
	xor	r13d, r13d
	.p2align	4
302:
	vmovdqu	ymm0, ymmword ptr [rcx + r13 - 96]
	vmovdqu	ymm2, ymmword ptr [rcx + r13 - 64]
	vmovdqu	ymm6, ymmword ptr [rcx + r13 - 32]
	vmovdqu	ymm7, ymmword ptr [rcx + r13]
	vmovdqu	ymmword ptr [rdi + r13 + 576], ymm0
	vmovdqu	ymmword ptr [rdi + r13 + 608], ymm2
	vmovdqu	ymmword ptr [rdi + r13 + 640], ymm6
	vmovdqu	ymmword ptr [rdi + r13 + 672], ymm7
	sub	r13, -128
	cmp	rax, r13
	jne	302b
	cmp	r9, rax
	lea	r13, [rdi + 576]
	mov	rcx, r13
	je	352f
	test	r9b, 112
	je	332f
312:
	mov	rcx, r9
	and	rcx, -16
	lea	r11, [r8 + rcx]
	.p2align	4
322:
	vmovdqu	xmm0, xmmword ptr [r12 + rax]
	vmovdqu	xmmword ptr [r13 + rax], xmm0
	add	rax, 16
	cmp	rcx, rax
	jne	322b
	cmp	r9, rcx
	mov	rcx, r13
	je	352f
332:
	mov	rax, r13
	sub	rax, r8
	mov	r8, qword ptr [rsp + 8]
	mov	r9, qword ptr [rsp + 24]
	.p2align	4
342:
	movzx	ecx, byte ptr [r8 + r11]
	mov	byte ptr [rax + r11], cl
	inc	r11
	cmp	r9, r11
	jne	342b
	mov	rcx, r13
352:
	vmovdqu	ymm0, ymmword ptr [rcx]
	vmovdqu	ymm2, ymmword ptr [rcx + 32]
	vpermq	ymm6, ymm0, 68
	vpermq	ymm0, ymm0, 238
	vpshufb	ymm7, ymm6, ymm12
	vpshufb	ymm14, ymm0, ymm12
	vpbroadcastb	ymm5, byte ptr [rip + 642f]
	vpand	ymm15, ymm12, ymm5
	vpxor	xmm10, xmm10, xmm10
	vpcmpeqb	ymm15, ymm15, ymm10
	vpblendvb	ymm7, ymm14, ymm7, ymm15
	vpermq	ymm14, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm8, ymm14, ymm12
	vpshufb	ymm3, ymm2, ymm12
	vpblendvb	ymm3, ymm3, ymm8, ymm15
	vpshufb	ymm6, ymm6, ymm11
	vpshufb	ymm0, ymm0, ymm11
	vpand	ymm8, ymm11, ymm5
	vpcmpeqb	ymm8, ymm8, ymm10
	vpblendvb	ymm0, ymm0, ymm6, ymm8
	vpshufb	ymm6, ymm14, ymm11
	vpshufb	ymm2, ymm2, ymm11
	vpblendvb	ymm2, ymm2, ymm6, ymm8
	vpbroadcastb	ymm5, byte ptr [rip + 652f]
	vpand	ymm6, ymm11, ymm5
	vpcmpeqb	ymm6, ymm6, ymm5
	vpblendvb	ymm0, ymm0, ymm2, ymm6
	vpxor	xmm6, xmm6, xmm6
	vpand	ymm2, ymm12, ymm5
	vpcmpeqb	ymm2, ymm2, ymm5
	vpblendvb	ymm2, ymm7, ymm3, ymm2
	vpsrlvd	ymm0, ymm0, ymm9
	vmovdqu	ymm3, ymmword ptr [rsp + 160]
	vpandn	ymm0, ymm3, ymm0
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 96]
	vpsrlvd	ymm2, ymm2, ymm4
	vmovdqu	ymm3, ymmword ptr [rsp + 64]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 128]
	vpor	ymm3, ymm2, ymmword ptr [rip + 662f]
	vpcmpeqd	ymm2, ymm2, ymm6
	vpandn	ymm2, ymm2, ymm3
	vpor	ymm3, ymm0, ymmword ptr [rip + 672f]
	vpcmpeqd	ymm0, ymm0, ymm6
	vpandn	ymm0, ymm0, ymm3
	vperm2i128	ymm3, ymm0, ymm0, 10
	vpalignr	ymm3, ymm0, ymm3, 12
	vpmaxud	ymm3, ymm0, ymm3
	vperm2i128	ymm0, ymm0, ymm2, 33
	vpalignr	ymm0, ymm2, ymm0, 12
	vpmaxud	ymm0, ymm2, ymm0
	vpblendd	ymm2, ymm0, ymm3, 192
	vpermq	ymm2, ymm2, 147
	vpmaxud	ymm0, ymm0, ymm2
	vpblendd	ymm2, ymm3, ymm6, 192
	vpermq	ymm2, ymm2, 147
	vpmaxud	ymm2, ymm3, ymm2
	vperm2i128	ymm3, ymm2, ymm2, 10
	vpmaxud	ymm3, ymm2, ymm3
	vperm2i128	ymm2, ymm2, ymm0, 33
	vpmaxud	ymm0, ymm0, ymm2
	vpmaxud	ymm0, ymm0, ymm3
	vmovdqu	ymm4, ymmword ptr [rsp + 304]
	vpand	ymm2, ymm0, ymm4
	vpcmpeqd	ymm0, ymm0, ymm6
	vblendvps	ymm0, ymm2, ymm13, ymm0
	vpand	ymm2, ymm3, ymm4
	vpcmpeqd	ymm3, ymm3, ymm6
	vblendvps	ymm2, ymm2, ymm13, ymm3
	vmovdqu	ymm3, ymmword ptr [rsp + 496]
	vpsrlw	xmm3, xmm3, 2
	vpand	xmm3, xmm3, xmmword ptr [rip + 682f]
	vpminub	xmm3, xmm3, xmm5
	vpmovzxbd	ymm4, xmm3
	vpmaxud	ymm2, ymm2, ymm4
	vextracti128	xmm1, ymm1, 1
	vpextrd	eax, xmm1, 3
	vmovdqu	ymmword ptr [rdi + 384], ymm2
	vpshufd	xmm1, xmm3, 238
	vpmovzxbd	ymm1, xmm1
	vpmaxud	ymm1, ymm0, ymm1
	vmovdqu	ymmword ptr [rdi + 416], ymm1
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm13, ymm0, 170
	mov	rcx, qword ptr [rsp + 16]
	add	rcx, rax
	cmp	qword ptr [rsp + 272], 49
	jb	442f
	vmovdqu	ymm0, ymmword ptr [rsp + 464]
	vextracti128	xmm0, ymm0, 1
	vpshufd	xmm1, xmm0, 238
	vpmovzxbd	ymm1, xmm1
	vpmovzxbd	ymm0, xmm0
	vpsrld	ymm2, ymm0, 3
	vpsrld	ymm3, ymm1, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 432]
	vpmaxud	ymm3, ymm3, ymm5
	vpcmpeqd	ymm7, ymm7, ymm7
	vpaddd	ymm4, ymm3, ymm7
	vpmaxud	ymm2, ymm2, ymm5
	vpaddd	ymm5, ymm2, ymm7
	vmovdqu	ymm8, ymmword ptr [rsp + 400]
	vpand	ymm2, ymm8, ymm0
	vpand	ymm3, ymm8, ymm1
	vmovdqu	ymm9, ymmword ptr [rsp + 368]
	vpminud	ymm1, ymm1, ymm9
	vpminud	ymm0, ymm0, ymm9
	vpand	ymm0, ymm9, ymm0
	vpor	ymm0, ymm0, ymm2
	vpand	ymm1, ymm9, ymm1
	vpor	ymm1, ymm1, ymm3
	vpsllvd	ymm0, ymm0, ymm5
	vmovdqu	ymmword ptr [rsp + 128], ymm0
	vpsllvd	ymm0, ymm1, ymm4
	vmovdqu	ymmword ptr [rsp + 272], ymm0
	vpsllvd	ymm0, ymm7, ymm5
	vmovdqu	ymmword ptr [rsp + 64], ymm0
	vpsllvd	ymm0, ymm7, ymm4
	vmovdqu	ymmword ptr [rsp + 96], ymm0
	vperm2i128	ymm0, ymm5, ymm4, 33
	vpalignr	ymm0, ymm4, ymm0, 12
	vperm2i128	ymm1, ymm5, ymm5, 10
	vpalignr	ymm1, ymm5, ymm1, 12
	vpaddd	ymm1, ymm1, ymm5
	vpaddd	ymm0, ymm0, ymm4
	vpblendd	ymm2, ymm1, ymm6, 192
	vpermq	ymm2, ymm2, 147
	vpaddd	ymm2, ymm2, ymm1
	vpblendd	ymm1, ymm0, ymm1, 192
	vpermq	ymm1, ymm1, 147
	vpaddd	ymm0, ymm1, ymm0
	vperm2i128	ymm1, ymm2, ymm2, 10
	vpaddd	ymm6, ymm1, ymm2
	vperm2i128	ymm1, ymm2, ymm0, 33
	vpaddd	ymm0, ymm1, ymm0
	vpaddd	ymm1, ymm6, ymm0
	vpsubd	ymm0, ymm1, ymm4
	vpsubd	ymm2, ymm6, ymm5
	mov	eax, ecx
	and	eax, 7
	vmovd	xmm4, eax
	vpbroadcastd	ymm4, xmm4
	vpaddd	ymm0, ymm4, ymm0
	vpaddd	ymm2, ymm4, ymm2
	vpsrld	ymm6, ymm0, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm5, ymm8, ymm0
	vpand	ymm4, ymm8, ymm2
	vbroadcasti128	ymm2, xmmword ptr [rip + 632f]
	vpshufb	ymm0, ymm6, ymm2
	vpshufb	ymm2, ymm7, ymm2
	vmovdqu	ymm3, ymmword ptr [rsp + 336]
	vpaddb	ymm9, ymm0, ymm3
	vpaddb	ymm14, ymm2, ymm3
	mov	r8, rcx
	shr	r8, 3
	lea	rax, [r8 + 64]
	mov	r9, qword ptr [rsp + 24]
	cmp	rax, r9
	jbe	362f
	sub	r9, r8
	jbe	432f
	cmp	r9, 16
	mov	r11, r8
	jb	412f
	mov	rax, qword ptr [rsp + 8]
	lea	r12, [r8 + rax]
	mov	rax, rdi
	sub	rax, r12
	add	rax, 575
	cmp	rax, 127
	mov	r11, r8
	jb	412f
	cmp	r9, 128
	mov	qword ptr [rsp + 16], rcx
	jae	372f
	xor	eax, eax
	jmp	392f
362:
	mov	r13, qword ptr [rsp + 8]
	add	r13, r8
	jmp	432f
372:
	mov	rax, r9
	and	rax, -128
	lea	r11, [r8 + rax]
	mov	rcx, qword ptr [rsp + 8]
	lea	rcx, [rcx + r8 + 96]
	xor	r13d, r13d
	.p2align	4
382:
	vmovdqu	ymm0, ymmword ptr [rcx + r13 - 96]
	vmovdqu	ymm2, ymmword ptr [rcx + r13 - 64]
	vmovdqu	ymm6, ymmword ptr [rcx + r13 - 32]
	vmovdqu	ymm7, ymmword ptr [rcx + r13]
	vmovdqu	ymmword ptr [rdi + r13 + 576], ymm0
	vmovdqu	ymmword ptr [rdi + r13 + 608], ymm2
	vmovdqu	ymmword ptr [rdi + r13 + 640], ymm6
	vmovdqu	ymmword ptr [rdi + r13 + 672], ymm7
	sub	r13, -128
	cmp	rax, r13
	jne	382b
	cmp	r9, rax
	lea	r13, [rdi + 576]
	mov	rcx, qword ptr [rsp + 16]
	je	432f
	test	r9b, 112
	je	412f
392:
	mov	rcx, r9
	and	rcx, -16
	lea	r11, [r8 + rcx]
	lea	r13, [rdi + 576]
	.p2align	4
402:
	vmovdqu	xmm0, xmmword ptr [r12 + rax]
	vmovdqu	xmmword ptr [r13 + rax], xmm0
	add	rax, 16
	cmp	rcx, rax
	jne	402b
	cmp	r9, rcx
	mov	rcx, qword ptr [rsp + 16]
	je	432f
412:
	mov	r12, rcx
	lea	r9, [rdi + 576]
	mov	rax, r9
	sub	rax, r8
	mov	r8, qword ptr [rsp + 8]
	mov	r13, qword ptr [rsp + 24]
	.p2align	4
422:
	movzx	ecx, byte ptr [r8 + r11]
	mov	byte ptr [rax + r11], cl
	inc	r11
	cmp	r13, r11
	jne	422b
	mov	r13, r9
	mov	rcx, r12
432:
	vmovdqu	ymm0, ymmword ptr [r13]
	vpermq	ymm2, ymm0, 68
	vpermq	ymm0, ymm0, 238
	vpshufb	ymm6, ymm2, ymm9
	vpshufb	ymm7, ymm0, ymm9
	vpbroadcastb	ymm12, byte ptr [rip + 642f]
	vpand	ymm11, ymm9, ymm12
	vpxor	xmm3, xmm3, xmm3
	vpcmpeqb	ymm11, ymm11, ymm3
	vpblendvb	ymm6, ymm7, ymm6, ymm11
	vmovdqu	ymm7, ymmword ptr [r13 + 32]
	vpermq	ymm15, ymm7, 68
	vpermq	ymm7, ymm7, 238
	vpshufb	ymm8, ymm15, ymm9
	vpshufb	ymm10, ymm7, ymm9
	vpblendvb	ymm8, ymm10, ymm8, ymm11
	vpshufb	ymm2, ymm2, ymm14
	vpshufb	ymm0, ymm0, ymm14
	vpand	ymm10, ymm14, ymm12
	vpcmpeqb	ymm10, ymm10, ymm3
	vpblendvb	ymm0, ymm0, ymm2, ymm10
	vpshufb	ymm2, ymm15, ymm14
	vpshufb	ymm7, ymm7, ymm14
	vpblendvb	ymm2, ymm7, ymm2, ymm10
	vpbroadcastb	ymm10, byte ptr [rip + 652f]
	vpand	ymm7, ymm14, ymm10
	vpcmpeqb	ymm7, ymm10, ymm7
	vpblendvb	ymm0, ymm0, ymm2, ymm7
	vpand	ymm2, ymm9, ymm10
	vpcmpeqb	ymm2, ymm10, ymm2
	vpblendvb	ymm2, ymm6, ymm8, ymm2
	vpxor	xmm6, xmm6, xmm6
	vpsrlvd	ymm0, ymm0, ymm4
	vmovdqu	ymm3, ymmword ptr [rsp + 64]
	vpandn	ymm0, ymm3, ymm0
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 128]
	vpsrlvd	ymm2, ymm2, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 96]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 272]
	vpor	ymm3, ymm2, ymmword ptr [rip + 662f]
	vpcmpeqd	ymm2, ymm2, ymm6
	vpandn	ymm2, ymm2, ymm3
	vpor	ymm3, ymm0, ymmword ptr [rip + 672f]
	vpcmpeqd	ymm0, ymm0, ymm6
	vpandn	ymm0, ymm0, ymm3
	vperm2i128	ymm3, ymm0, ymm0, 10
	vpalignr	ymm3, ymm0, ymm3, 12
	vpmaxud	ymm3, ymm0, ymm3
	vperm2i128	ymm0, ymm0, ymm2, 33
	vpalignr	ymm0, ymm2, ymm0, 12
	vpmaxud	ymm0, ymm2, ymm0
	vpblendd	ymm2, ymm0, ymm3, 192
	vpermq	ymm2, ymm2, 147
	vpmaxud	ymm0, ymm0, ymm2
	vpblendd	ymm2, ymm3, ymm6, 192
	vpermq	ymm2, ymm2, 147
	vpmaxud	ymm2, ymm3, ymm2
	vperm2i128	ymm3, ymm2, ymm2, 10
	vpmaxud	ymm3, ymm2, ymm3
	vperm2i128	ymm2, ymm2, ymm0, 33
	vpmaxud	ymm0, ymm0, ymm2
	vpmaxud	ymm0, ymm0, ymm3
	vmovdqu	ymm4, ymmword ptr [rsp + 304]
	vpand	ymm2, ymm0, ymm4
	vpcmpeqd	ymm0, ymm0, ymm6
	vblendvps	ymm0, ymm2, ymm13, ymm0
	vpand	ymm2, ymm3, ymm4
	vpcmpeqd	ymm3, ymm3, ymm6
	vblendvps	ymm2, ymm2, ymm13, ymm3
	vmovdqu	ymm3, ymmword ptr [rsp + 496]
	vextracti128	xmm3, ymm3, 1
	vpsrlw	xmm3, xmm3, 2
	vpand	xmm3, xmm3, xmmword ptr [rip + 682f]
	vpminub	xmm3, xmm10, xmm3
	vpmovzxbd	ymm4, xmm3
	vpmaxud	ymm2, ymm2, ymm4
	vextracti128	xmm1, ymm1, 1
	vpextrd	eax, xmm1, 3
	vmovdqu	ymmword ptr [rdi + 448], ymm2
	vpshufd	xmm1, xmm3, 238
	vpmovzxbd	ymm1, xmm1
	vpmaxud	ymm1, ymm0, ymm1
	vmovdqu	ymmword ptr [rdi + 480], ymm1
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm13, ymm0, 170
	add	rcx, rax
	.p2align	4
442:
	shr	r14, 56
	add	r14, rbx
	shr	r15, 56
	add	r15, r10
	vmovd	eax, xmm13
	mov	qword ptr [rdi + 72], rcx
	mov	qword ptr [rdi + 96], rax
	mov	qword ptr [rdi + 128], r15
	mov	qword ptr [rdi + 136], r14
	xor	eax, eax
	mov	rbx, qword ptr [rsp + 216]
	.p2align	4
452:
	movzx	r9d, byte ptr [rdi + rax + 512]
	movzx	r8d, byte ptr [rdi + rax + 192]
	cmp	r8, 33
	mov	r10d, dword ptr [rdi + 4*rax + 256]
	vmovdqu	ymm0, ymmword ptr [rsi]
	vmovdqu	ymmword ptr [rdx], ymm0
	jae	492f
462:
	add	rdx, r8
	mov	r11, rdx
	sub	r11, r10
	cmp	r11, rbx
	jl	512f
	vmovdqu	ymm0, ymmword ptr [r11]
	vmovdqu	ymmword ptr [rdx], ymm0
	cmp	r9b, -124
	jae	522f
472:
	shr	r9d, 2
482:
	add	rdx, r9
	add	rsi, r8
	inc	rax
	cmp	rax, rbp
	jne	452b
	jmp	2b
492:
	mov	rcx, qword ptr [rdi + 48]
	mov	r11, qword ptr [rdi + 120]
	movzx	r8d, byte ptr [rcx + r11]
	inc	r11
	mov	qword ptr [rdi + 120], r11
	add	r8, 33
	mov	ecx, 32
	.p2align	4
502:
	vmovdqu	ymm0, ymmword ptr [rsi + rcx]
	vmovdqu	ymmword ptr [rdx + rcx], ymm0
	add	rcx, 32
	cmp	rcx, r8
	jb	502b
	jmp	462b
512:
	mov	rcx, rdx
	sub	rcx, rbx
	sub	rcx, r10
	mov	r11d, 0
	cmovae	r11, rcx
	add	r11, rbx
	vmovdqu	ymm0, ymmword ptr [r11]
	vmovdqu	ymmword ptr [rdx], ymm0
	cmp	r9b, -124
	jb	472b
522:
	mov	rcx, qword ptr [rdi + 48]
	mov	r10, qword ptr [rdi + 120]
	movzx	r9d, byte ptr [rcx + r10]
	inc	r10
	mov	qword ptr [rdi + 120], r10
	add	r9, 33
	mov	ecx, 32
	.p2align	4
532:
	vmovdqu	ymm0, ymmword ptr [r11 + rcx]
	vmovdqu	ymmword ptr [rdx + rcx], ymm0
	add	rcx, 32
	cmp	rcx, r9
	jb	532b
	jmp	482b
542:
	sub	rdx, rbx
	sub	rsi, qword ptr [rsp + 200]
	mov	qword ptr [rdi + 80], rdx
	mov	qword ptr [rdi + 88], rsi
	add	rsp, 568
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
	.p2align	4, 0x0
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
	.p2align	4, 0x0
642:
	.byte	16
	.p2align	4, 0x0
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
	.p2align	4, 0x0
682:
	.zero	16,63

# minlz_exec_delta of crates/minlz/mlir/exec64.mlir for avx2, written by
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
	mov	r14, qword ptr [rdi + 64]
	mov	rdx, qword ptr [rdi + 80]
	add	rdx, rcx
	mov	rsi, qword ptr [rdi + 88]
	mov	qword ptr [rsp + 200], rax
	add	rsi, rax
	test	r14, r14
	jle	582f
	mov	r12, qword ptr [rdi + 96]
	lea	r9, [rdi + 512]
	mov	ebp, 96
	mov	eax, 7
	mov	qword ptr [rsp + 40], rax
	xor	r10d, r10d
	vpxor	xmm7, xmm7, xmm7
	vbroadcastss	ymm0, dword ptr [rip + 592f]
	vmovups	ymmword ptr [rsp + 432], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 602f]
	vmovups	ymmword ptr [rsp + 400], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 612f]
	vmovups	ymmword ptr [rsp + 368], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 622f]
	vmovups	ymmword ptr [rsp + 336], ymm0
	vpbroadcastd	ymm0, dword ptr [rip + 632f]
	vmovdqu	ymmword ptr [rsp + 304], ymm0
	mov	r11, r9
	mov	r8, r14
	xor	ebx, ebx
	mov	qword ptr [rsp + 208], r14
	jmp	12f
	.p2align	4
2:
	mov	r8, qword ptr [rsp + 224]
	add	r8, -64
	mov	r10, qword ptr [rsp + 232]
	inc	r10
	add	rbp, 64
	add	qword ptr [rsp + 40], -64
	mov	r11, qword ptr [rsp + 56]
	add	r11, -64
	mov	rbx, qword ptr [rsp + 216]
	mov	r14, qword ptr [rsp + 208]
	cmp	rbx, r14
	mov	r12, rax
	lea	r9, [rdi + 512]
	jge	582f
12:
	mov	qword ptr [rsp + 8], rbp
	cmp	r8, 1
	mov	qword ptr [rsp + 224], r8
	adc	r8, 0
	cmp	r8, 64
	mov	eax, 64
	cmovae	r8, rax
	mov	qword ptr [rsp + 32], r8
	sub	r14, rbx
	cmp	r14, 64
	mov	qword ptr [rsp + 240], r14
	cmovb	rax, r14
	mov	qword ptr [rsp + 160], rax
	mov	r13, qword ptr [rdi + 16]
	mov	r14, qword ptr [rdi + 24]
	mov	rax, qword ptr [rdi + 32]
	mov	qword ptr [rsp + 96], rax
	mov	rax, qword ptr [rdi + 40]
	mov	qword ptr [rsp], rax
	mov	rax, qword ptr [rdi + 64]
	mov	r8, qword ptr [rdi + 72]
	mov	qword ptr [rsp + 24], r8
	mov	r8, qword ptr [rdi + 96]
	mov	qword ptr [rsp + 128], r8
	mov	r8, qword ptr [rdi + 112]
	mov	qword ptr [rsp + 16], r8
	mov	r8, qword ptr [rdi + 128]
	mov	qword ptr [rsp + 48], r8
	mov	r8, qword ptr [rdi + 136]
	mov	qword ptr [rsp + 64], r8
	lea	r8, [rax + 7]
	lea	r15, [rbx + 64]
	mov	qword ptr [rsp + 216], r15
	cmp	r15, r8
	mov	qword ptr [rsp + 232], r10
	mov	qword ptr [rsp + 56], r11
	jbe	22f
	cmp	rbx, r8
	jge	102f
	mov	r9, r10
	shl	r9, 6
	mov	ebp, 7
	sub	rbp, r9
	add	rbp, rax
	cmp	rbp, 16
	jae	32f
	mov	r15, rbx
	jmp	92f
	.p2align	4
22:
	add	r13, rbx
	mov	r9, r13
	jmp	102f
32:
	add	r9, r13
	mov	r10, rdi
	sub	r10, r9
	add	r10, 511
	cmp	r10, 127
	jae	42f
	mov	r15, rbx
	jmp	92f
42:
	cmp	rbp, 128
	mov	qword ptr [rsp + 272], rbp
	jae	52f
	xor	r10d, r10d
	jmp	72f
52:
	mov	r10, rbp
	and	r10, -128
	lea	r15, [rbx + r10]
	mov	r9, qword ptr [rsp + 8]
	lea	r11, [r13 + r9]
	mov	r9, qword ptr [rsp + 40]
	lea	rbp, [rax + r9]
	and	rbp, -128
	xor	r9d, r9d
	.p2align	4
62:
	vmovdqu	ymm0, ymmword ptr [r11 + r9 - 96]
	vmovdqu	ymm1, ymmword ptr [r11 + r9 - 64]
	vmovups	ymm3, ymmword ptr [r11 + r9 - 32]
	vmovups	ymm4, ymmword ptr [r11 + r9]
	vmovdqu	ymmword ptr [rdi + r9 + 512], ymm0
	vmovdqu	ymmword ptr [rdi + r9 + 544], ymm1
	vmovups	ymmword ptr [rdi + r9 + 576], ymm3
	vmovups	ymmword ptr [rdi + r9 + 608], ymm4
	sub	r9, -128
	cmp	rbp, r9
	jne	62b
	mov	rbp, qword ptr [rsp + 272]
	cmp	rbp, r10
	lea	r9, [rdi + 512]
	mov	r11, qword ptr [rsp + 56]
	je	102f
	test	bpl, 112
	je	92f
72:
	and	rbp, -16
	lea	r15, [r13 + rbx]
	add	rbx, rbp
	add	rax, qword ptr [rsp + 40]
	and	rax, -16
	lea	r9, [rdi + 512]
	.p2align	4
82:
	vmovdqu	xmm0, xmmword ptr [r15 + r10]
	vmovdqu	xmmword ptr [r9 + r10], xmm0
	add	r10, 16
	cmp	rax, r10
	jne	82b
	cmp	qword ptr [rsp + 272], rbp
	mov	r15, rbx
	mov	r11, qword ptr [rsp + 56]
	je	102f
	.p2align	4
92:
	movzx	eax, byte ptr [r13 + r15]
	mov	byte ptr [r11 + r15], al
	inc	r15
	cmp	r8, r15
	jne	92b
	lea	r9, [rdi + 512]
102:
	vmovdqu	ymm0, ymmword ptr [r9]
	vmovdqu	ymm1, ymmword ptr [r9 + 32]
	vmovd	xmm3, dword ptr [rsp + 160]
	vpbroadcastb	ymm4, xmm3
	vpmaxub	ymm3, ymm4, ymmword ptr [rip + 642f]
	vpcmpeqb	ymm3, ymm4, ymm3
	vpmaxub	ymm5, ymm4, ymmword ptr [rip + 652f]
	vpcmpeqb	ymm8, ymm4, ymm5
	vpsllw	ymm4, ymm0, 6
	vpcmpgtb	ymm4, ymm7, ymm4
	vpsllw	ymm5, ymm1, 6
	vpcmpgtb	ymm11, ymm7, ymm5
	vpbroadcastb	ymm2, byte ptr [rip + 662f]
	vpand	ymm5, ymm0, ymm2
	vpand	ymm10, ymm1, ymm2
	vpcmpeqb	ymm12, ymm10, ymm7
	vpcmpeqb	ymm10, ymm5, ymm7
	movabs	rbx, 72340172838076673
	mov	r9, rbx
	#APP
	#NO_APP
	vpand	ymm4, ymm4, ymm2
	vpand	ymm5, ymm3, ymm4
	vpand	ymm4, ymm11, ymm2
	vpand	ymm4, ymm8, ymm4
	vmovdqu	ymmword ptr [rdi + 544], ymm4
	vmovdqu	ymmword ptr [rdi + 512], ymm5
	vmovq	rax, xmm5
	mov	r8, rax
	imul	r8, r9
	mov	r10, r8
	sub	r10, rax
	xor	rax, r9
	shl	rax, 7
	or	rax, r10
	mov	r10, qword ptr [rsp + 48]
	vmovq	xmm11, qword ptr [r14 + r10]
	vmovq	xmm13, rax
	vpshufb	xmm11, xmm11, xmm13
	shr	r8, 56
	add	r8, r10
	vmovq	qword ptr [rdi + 512], xmm11
	vpextrq	r10, xmm5, 1
	mov	rax, r10
	imul	rax, r9
	mov	r11, rax
	sub	r11, r10
	xor	r10, r9
	shl	r10, 7
	or	r10, r11
	vmovq	xmm11, qword ptr [r14 + r8]
	vmovq	xmm13, r10
	vpshufb	xmm11, xmm11, xmm13
	shr	rax, 56
	add	rax, r8
	vmovq	qword ptr [rdi + 520], xmm11
	vextracti128	xmm5, ymm5, 1
	vmovq	r10, xmm5
	mov	r8, r10
	imul	r8, r9
	mov	r11, r8
	sub	r11, r10
	xor	r10, r9
	shl	r10, 7
	or	r10, r11
	vmovq	xmm11, qword ptr [r14 + rax]
	vmovq	xmm13, r10
	vpshufb	xmm11, xmm11, xmm13
	shr	r8, 56
	add	r8, rax
	vmovq	qword ptr [rdi + 528], xmm11
	vpextrq	r10, xmm5, 1
	mov	rax, r10
	imul	rax, r9
	mov	r11, rax
	sub	r11, r10
	xor	r10, r9
	shl	r10, 7
	or	r10, r11
	vmovq	xmm5, qword ptr [r14 + r8]
	vmovq	xmm11, r10
	vpshufb	xmm5, xmm5, xmm11
	shr	rax, 56
	add	rax, r8
	vmovq	qword ptr [rdi + 536], xmm5
	vmovq	r10, xmm4
	mov	r8, r10
	imul	r8, r9
	mov	r11, r8
	sub	r11, r10
	xor	r10, r9
	shl	r10, 7
	or	r10, r11
	vmovq	xmm5, qword ptr [r14 + rax]
	vmovq	xmm11, r10
	vpshufb	xmm5, xmm5, xmm11
	shr	r8, 56
	add	r8, rax
	vmovq	qword ptr [rdi + 544], xmm5
	vpextrq	r10, xmm4, 1
	mov	rax, r10
	imul	rax, r9
	mov	r11, rax
	sub	r11, r10
	xor	r10, r9
	shl	r10, 7
	or	r10, r11
	vmovq	xmm4, qword ptr [r14 + r8]
	vmovq	xmm5, r10
	vpshufb	xmm4, xmm4, xmm5
	shr	rax, 56
	add	rax, r8
	vmovq	qword ptr [rdi + 552], xmm4
	mov	r8, qword ptr [rdi + 560]
	mov	r10, qword ptr [rdi + 568]
	mov	r15, r8
	imul	r15, r9
	mov	r11, r15
	sub	r11, r8
	xor	r8, r9
	shl	r8, 7
	or	r8, r11
	vmovq	xmm4, qword ptr [r14 + rax]
	vmovq	xmm5, r8
	vpshufb	xmm4, xmm4, xmm5
	shr	r15, 56
	add	r15, rax
	vmovq	qword ptr [rdi + 560], xmm4
	mov	rax, r10
	imul	rax, r9
	mov	qword ptr [rsp + 48], rax
	sub	rax, r10
	xor	r9, r10
	shl	r9, 7
	or	r9, rax
	vmovq	xmm4, qword ptr [r14 + r15]
	vmovq	xmm5, r9
	vpshufb	xmm4, xmm4, xmm5
	vmovq	qword ptr [rdi + 568], xmm4
	vmovups	ymm4, ymmword ptr [rdi + 544]
	vmovups	ymm5, ymmword ptr [rdi + 512]
	vmovups	ymmword ptr [rdi + 192], ymm5
	vmovups	ymmword ptr [rdi + 224], ymm4
	mov	r9, rbx
	#APP
	#NO_APP
	vpand	ymm4, ymm12, ymm2
	vpand	ymm4, ymm8, ymm4
	vpand	ymm5, ymm10, ymm2
	vpand	ymm3, ymm3, ymm5
	vmovdqu	ymmword ptr [rdi + 512], ymm3
	vmovdqu	ymmword ptr [rdi + 544], ymm4
	vmovq	rax, xmm3
	mov	r8, r9
	imul	r8, rax
	mov	r10, r8
	sub	r10, rax
	xor	rax, r9
	shl	rax, 7
	or	rax, r10
	mov	rbx, qword ptr [rsp + 96]
	mov	r10, qword ptr [rsp + 64]
	vmovq	xmm5, qword ptr [rbx + r10]
	vmovq	xmm8, rax
	vpshufb	xmm5, xmm5, xmm8
	shr	r8, 56
	add	r8, r10
	vmovq	qword ptr [rdi + 512], xmm5
	vpextrq	r10, xmm3, 1
	mov	rax, r9
	imul	rax, r10
	mov	r11, rax
	sub	r11, r10
	xor	r10, r9
	shl	r10, 7
	or	r10, r11
	vmovq	xmm5, qword ptr [rbx + r8]
	vmovq	xmm8, r10
	vpshufb	xmm5, xmm5, xmm8
	shr	rax, 56
	add	rax, r8
	vmovq	qword ptr [rdi + 520], xmm5
	vextracti128	xmm3, ymm3, 1
	vmovq	r10, xmm3
	mov	r8, r9
	imul	r8, r10
	mov	r11, r8
	sub	r11, r10
	xor	r10, r9
	shl	r10, 7
	or	r10, r11
	vmovq	xmm5, qword ptr [rbx + rax]
	vmovq	xmm8, r10
	vpshufb	xmm5, xmm5, xmm8
	shr	r8, 56
	add	r8, rax
	vmovq	qword ptr [rdi + 528], xmm5
	vpextrq	r10, xmm3, 1
	mov	rax, r9
	imul	rax, r10
	mov	r11, rax
	sub	r11, r10
	xor	r10, r9
	shl	r10, 7
	or	r10, r11
	vmovq	xmm3, qword ptr [rbx + r8]
	vmovq	xmm5, r10
	vpshufb	xmm3, xmm3, xmm5
	shr	rax, 56
	add	rax, r8
	vmovq	qword ptr [rdi + 536], xmm3
	vmovq	r10, xmm4
	mov	r8, r9
	imul	r8, r10
	mov	r11, r8
	sub	r11, r10
	xor	r10, r9
	shl	r10, 7
	or	r10, r11
	vmovq	xmm3, qword ptr [rbx + rax]
	vmovq	xmm5, r10
	vpshufb	xmm3, xmm3, xmm5
	shr	r8, 56
	add	r8, rax
	vmovq	qword ptr [rdi + 544], xmm3
	vpextrq	r10, xmm4, 1
	mov	rax, r9
	imul	rax, r10
	mov	r11, rax
	sub	r11, r10
	xor	r10, r9
	shl	r10, 7
	or	r10, r11
	vmovq	xmm3, qword ptr [rbx + r8]
	vmovq	xmm4, r10
	vpshufb	xmm3, xmm3, xmm4
	shr	rax, 56
	add	rax, r8
	vmovq	qword ptr [rdi + 552], xmm3
	mov	r8, qword ptr [rdi + 560]
	mov	r10, qword ptr [rdi + 568]
	mov	r14, r8
	imul	r14, r9
	mov	r11, r14
	sub	r11, r8
	xor	r8, r9
	shl	r8, 7
	or	r8, r11
	vmovq	xmm3, qword ptr [rbx + rax]
	vmovq	xmm4, r8
	vpshufb	xmm3, xmm3, xmm4
	shr	r14, 56
	add	r14, rax
	vmovq	qword ptr [rdi + 560], xmm3
	mov	r8, r10
	imul	r8, r9
	mov	rax, r8
	sub	rax, r10
	xor	r9, r10
	shl	r9, 7
	or	r9, rax
	vmovq	xmm3, qword ptr [rbx + r14]
	vmovq	xmm4, r9
	vpshufb	xmm3, xmm3, xmm4
	vmovq	qword ptr [rdi + 568], xmm3
	vmovups	ymm2, ymmword ptr [rdi + 512]
	vmovups	ymmword ptr [rsp + 272], ymm2
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
	mov	r9, qword ptr [rsp + 24]
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
	vbroadcasti128	ymm2, xmmword ptr [rip + 672f]
	vpshufb	ymm4, ymm11, ymm2
	vpshufb	ymm9, ymm9, ymm2
	vmovdqu	ymm2, ymmword ptr [rsp + 336]
	vpaddb	ymm11, ymm4, ymm2
	vpaddb	ymm4, ymm9, ymm2
	mov	rax, r9
	shr	rax, 3
	lea	r9, [rax + 64]
	mov	r10, qword ptr [rsp + 16]
	cmp	r9, r10
	jbe	112f
	mov	r9, r10
	sub	r9, rax
	lea	rbx, [rdi + 576]
	mov	rbp, qword ptr [rsp + 8]
	jbe	182f
	cmp	r9, 16
	mov	r10, rax
	jb	162f
	mov	r10, qword ptr [rsp]
	lea	r11, [rax + r10]
	mov	r10, rdi
	sub	r10, r11
	add	r10, 575
	cmp	r10, 127
	mov	r10, rax
	jb	162f
	cmp	r9, 128
	jae	122f
	xor	r13d, r13d
	jmp	142f
	.p2align	4
112:
	add	rax, qword ptr [rsp]
	mov	rbx, rax
	mov	rbp, qword ptr [rsp + 8]
	jmp	182f
122:
	mov	r13, r9
	and	r13, -128
	lea	r10, [rax + r13]
	mov	rbx, qword ptr [rsp]
	lea	rbp, [rbx + rax + 96]
	xor	ebx, ebx
	.p2align	4
132:
	vmovdqu	ymm9, ymmword ptr [rbp + rbx - 96]
	vmovdqu	ymm14, ymmword ptr [rbp + rbx - 64]
	vmovdqu	ymm6, ymmword ptr [rbp + rbx - 32]
	vmovdqu	ymm7, ymmword ptr [rbp + rbx]
	vmovdqu	ymmword ptr [rdi + rbx + 576], ymm9
	vmovdqu	ymmword ptr [rdi + rbx + 608], ymm14
	vmovdqu	ymmword ptr [rdi + rbx + 640], ymm6
	vmovdqu	ymmword ptr [rdi + rbx + 672], ymm7
	sub	rbx, -128
	cmp	r13, rbx
	jne	132b
	cmp	r9, r13
	lea	rbx, [rdi + 576]
	mov	rbp, qword ptr [rsp + 8]
	je	182f
	test	r9b, 112
	je	162f
142:
	mov	rbx, r9
	and	rbx, -16
	lea	r10, [rax + rbx]
	lea	rbp, [rdi + 576]
	.p2align	4
152:
	vmovdqu	xmm6, xmmword ptr [r11 + r13]
	vmovdqu	xmmword ptr [rbp + r13], xmm6
	add	r13, 16
	cmp	rbx, r13
	jne	152b
	cmp	r9, rbx
	mov	rbx, rbp
	mov	rbp, qword ptr [rsp + 8]
	je	182f
	.p2align	4
162:
	lea	r11, [rdi + 576]
	mov	r9, r11
	sub	r9, rax
	mov	rbx, qword ptr [rsp]
	mov	r13, qword ptr [rsp + 16]
	.p2align	4
172:
	movzx	eax, byte ptr [rbx + r10]
	mov	byte ptr [r9 + r10], al
	inc	r10
	cmp	r13, r10
	jne	172b
	mov	rbx, r11
182:
	vmovdqu	ymm6, ymmword ptr [rbx]
	vmovdqu	ymm7, ymmword ptr [rbx + 32]
	vpermq	ymm9, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm14, ymm9, ymm11
	vpshufb	ymm12, ymm6, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 682f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 692f]
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
	vpor	ymm4, ymm2, ymmword ptr [rip + 702f]
	vpcmpeqd	ymm2, ymm2, ymm7
	vpandn	ymm2, ymm2, ymm4
	vpor	ymm4, ymm3, ymmword ptr [rip + 712f]
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
	mov	r9, qword ptr [rsp + 24]
	add	r9, rax
	cmp	qword ptr [rsp + 240], 17
	jb	432f
	vmovdqu	ymm1, ymmword ptr [rsp + 272]
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
	vbroadcasti128	ymm4, xmmword ptr [rip + 672f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm4, ymm7, ymm4
	vmovdqu	ymm6, ymmword ptr [rsp + 336]
	vpaddb	ymm11, ymm2, ymm6
	vpaddb	ymm4, ymm4, ymm6
	mov	qword ptr [rsp + 24], r9
	mov	rax, r9
	shr	rax, 3
	lea	r9, [rax + 64]
	mov	r10, qword ptr [rsp + 16]
	cmp	r9, r10
	jbe	192f
	mov	r9, r10
	sub	r9, rax
	lea	rbx, [rdi + 576]
	jbe	262f
	cmp	r9, 16
	mov	r10, rax
	jb	242f
	mov	r10, qword ptr [rsp]
	lea	r11, [rax + r10]
	mov	r10, rdi
	sub	r10, r11
	add	r10, 575
	cmp	r10, 127
	mov	r10, rax
	jb	242f
	cmp	r9, 128
	jae	202f
	xor	r13d, r13d
	jmp	222f
	.p2align	4
192:
	add	rax, qword ptr [rsp]
	mov	rbx, rax
	jmp	262f
202:
	mov	r13, r9
	and	r13, -128
	lea	r10, [rax + r13]
	mov	rbx, qword ptr [rsp]
	lea	rbp, [rbx + rax + 96]
	xor	ebx, ebx
	.p2align	4
212:
	vmovdqu	ymm2, ymmword ptr [rbp + rbx - 96]
	vmovdqu	ymm6, ymmword ptr [rbp + rbx - 64]
	vmovdqu	ymm7, ymmword ptr [rbp + rbx - 32]
	vmovdqu	ymm9, ymmword ptr [rbp + rbx]
	vmovdqu	ymmword ptr [rdi + rbx + 576], ymm2
	vmovdqu	ymmword ptr [rdi + rbx + 608], ymm6
	vmovdqu	ymmword ptr [rdi + rbx + 640], ymm7
	vmovdqu	ymmword ptr [rdi + rbx + 672], ymm9
	sub	rbx, -128
	cmp	r13, rbx
	jne	212b
	cmp	r9, r13
	lea	rbx, [rdi + 576]
	mov	rbp, qword ptr [rsp + 8]
	je	262f
	test	r9b, 112
	je	242f
222:
	mov	rbx, r9
	and	rbx, -16
	lea	r10, [rax + rbx]
	lea	rbp, [rdi + 576]
	.p2align	4
232:
	vmovdqu	xmm2, xmmword ptr [r11 + r13]
	vmovdqu	xmmword ptr [rbp + r13], xmm2
	add	r13, 16
	cmp	rbx, r13
	jne	232b
	cmp	r9, rbx
	mov	rbx, rbp
	mov	rbp, qword ptr [rsp + 8]
	je	262f
242:
	lea	r11, [rdi + 576]
	mov	r9, r11
	sub	r9, rax
	mov	rbx, qword ptr [rsp]
	mov	r13, qword ptr [rsp + 16]
	.p2align	4
252:
	movzx	eax, byte ptr [rbx + r10]
	mov	byte ptr [r9 + r10], al
	inc	r10
	cmp	r13, r10
	jne	252b
	mov	rbx, r11
262:
	vmovdqu	ymm2, ymmword ptr [rbx]
	vmovdqu	ymm6, ymmword ptr [rbx + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm9, ymm7, ymm11
	vpshufb	ymm14, ymm2, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 682f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 692f]
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
	vpor	ymm4, ymm3, ymmword ptr [rip + 702f]
	vpcmpeqd	ymm3, ymm3, ymm7
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 712f]
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
	mov	r9, qword ptr [rsp + 24]
	add	r9, rax
	cmp	qword ptr [rsp + 240], 33
	jb	432f
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
	vbroadcasti128	ymm4, xmmword ptr [rip + 672f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm4, ymm7, ymm4
	vmovdqu	ymm6, ymmword ptr [rsp + 336]
	vpaddb	ymm11, ymm2, ymm6
	vpaddb	ymm4, ymm4, ymm6
	mov	qword ptr [rsp + 24], r9
	mov	rax, r9
	shr	rax, 3
	lea	r9, [rax + 64]
	mov	r10, qword ptr [rsp + 16]
	cmp	r9, r10
	jbe	272f
	mov	r9, r10
	sub	r9, rax
	lea	rbx, [rdi + 576]
	jbe	342f
	cmp	r9, 16
	mov	r10, rax
	jb	322f
	mov	r10, qword ptr [rsp]
	lea	r11, [rax + r10]
	mov	r10, rdi
	sub	r10, r11
	add	r10, 575
	cmp	r10, 127
	mov	r10, rax
	jb	322f
	cmp	r9, 128
	jae	282f
	xor	r13d, r13d
	jmp	302f
272:
	add	rax, qword ptr [rsp]
	mov	rbx, rax
	jmp	342f
282:
	mov	r13, r9
	and	r13, -128
	lea	r10, [rax + r13]
	mov	rbx, qword ptr [rsp]
	lea	rbp, [rbx + rax + 96]
	xor	ebx, ebx
	.p2align	4
292:
	vmovdqu	ymm2, ymmword ptr [rbp + rbx - 96]
	vmovdqu	ymm6, ymmword ptr [rbp + rbx - 64]
	vmovdqu	ymm7, ymmword ptr [rbp + rbx - 32]
	vmovdqu	ymm9, ymmword ptr [rbp + rbx]
	vmovdqu	ymmword ptr [rdi + rbx + 576], ymm2
	vmovdqu	ymmword ptr [rdi + rbx + 608], ymm6
	vmovdqu	ymmword ptr [rdi + rbx + 640], ymm7
	vmovdqu	ymmword ptr [rdi + rbx + 672], ymm9
	sub	rbx, -128
	cmp	r13, rbx
	jne	292b
	cmp	r9, r13
	lea	rbx, [rdi + 576]
	mov	rbp, qword ptr [rsp + 8]
	je	342f
	test	r9b, 112
	je	322f
302:
	mov	rbx, r9
	and	rbx, -16
	lea	r10, [rax + rbx]
	lea	rbp, [rdi + 576]
	.p2align	4
312:
	vmovdqu	xmm2, xmmword ptr [r11 + r13]
	vmovdqu	xmmword ptr [rbp + r13], xmm2
	add	r13, 16
	cmp	rbx, r13
	jne	312b
	cmp	r9, rbx
	mov	rbx, rbp
	mov	rbp, qword ptr [rsp + 8]
	je	342f
322:
	lea	r11, [rdi + 576]
	mov	r9, r11
	sub	r9, rax
	mov	rbx, qword ptr [rsp]
	mov	r13, qword ptr [rsp + 16]
	.p2align	4
332:
	movzx	eax, byte ptr [rbx + r10]
	mov	byte ptr [r9 + r10], al
	inc	r10
	cmp	r13, r10
	jne	332b
	mov	rbx, r11
342:
	vmovdqu	ymm2, ymmword ptr [rbx]
	vmovdqu	ymm6, ymmword ptr [rbx + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm9, ymm7, ymm11
	vpshufb	ymm14, ymm2, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 682f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 692f]
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
	vpor	ymm4, ymm3, ymmword ptr [rip + 702f]
	vpcmpeqd	ymm3, ymm3, ymm7
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 712f]
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
	mov	r9, qword ptr [rsp + 24]
	add	r9, rax
	cmp	qword ptr [rsp + 240], 49
	jb	432f
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
	vmovdqu	ymmword ptr [rsp + 240], ymm1
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
	vbroadcasti128	ymm4, xmmword ptr [rip + 672f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm4, ymm7, ymm4
	vmovdqu	ymm6, ymmword ptr [rsp + 336]
	vpaddb	ymm11, ymm2, ymm6
	vpaddb	ymm4, ymm4, ymm6
	mov	qword ptr [rsp + 24], r9
	mov	rax, r9
	shr	rax, 3
	lea	r9, [rax + 64]
	mov	r10, qword ptr [rsp + 16]
	cmp	r9, r10
	jbe	352f
	mov	r9, r10
	sub	r9, rax
	lea	rbx, [rdi + 576]
	jbe	422f
	cmp	r9, 16
	mov	r10, rax
	jb	402f
	mov	r10, qword ptr [rsp]
	lea	r11, [rax + r10]
	mov	r10, rdi
	sub	r10, r11
	add	r10, 575
	cmp	r10, 127
	mov	r10, rax
	jb	402f
	cmp	r9, 128
	jae	362f
	xor	r13d, r13d
	jmp	382f
352:
	mov	rbx, qword ptr [rsp]
	add	rbx, rax
	jmp	422f
362:
	mov	r13, r9
	and	r13, -128
	lea	r10, [rax + r13]
	mov	rbx, qword ptr [rsp]
	lea	rbp, [rbx + rax + 96]
	xor	ebx, ebx
	.p2align	4
372:
	vmovdqu	ymm2, ymmword ptr [rbp + rbx - 96]
	vmovdqu	ymm6, ymmword ptr [rbp + rbx - 64]
	vmovdqu	ymm7, ymmword ptr [rbp + rbx - 32]
	vmovdqu	ymm9, ymmword ptr [rbp + rbx]
	vmovdqu	ymmword ptr [rdi + rbx + 576], ymm2
	vmovdqu	ymmword ptr [rdi + rbx + 608], ymm6
	vmovdqu	ymmword ptr [rdi + rbx + 640], ymm7
	vmovdqu	ymmword ptr [rdi + rbx + 672], ymm9
	sub	rbx, -128
	cmp	r13, rbx
	jne	372b
	cmp	r9, r13
	lea	rbx, [rdi + 576]
	mov	rbp, qword ptr [rsp + 8]
	je	422f
	test	r9b, 112
	je	402f
382:
	mov	rbx, r9
	and	rbx, -16
	lea	r10, [rax + rbx]
	lea	rbp, [rdi + 576]
	.p2align	4
392:
	vmovdqu	xmm2, xmmword ptr [r11 + r13]
	vmovdqu	xmmword ptr [rbp + r13], xmm2
	add	r13, 16
	cmp	rbx, r13
	jne	392b
	cmp	r9, rbx
	mov	rbx, rbp
	mov	rbp, qword ptr [rsp + 8]
	je	422f
402:
	lea	r11, [rdi + 576]
	mov	r9, r11
	sub	r9, rax
	mov	rbx, qword ptr [rsp]
	mov	r13, qword ptr [rsp + 16]
	.p2align	4
412:
	movzx	eax, byte ptr [rbx + r10]
	mov	byte ptr [r9 + r10], al
	inc	r10
	cmp	r13, r10
	jne	412b
	mov	rbx, r11
422:
	vmovdqu	ymm2, ymmword ptr [rbx]
	vmovdqu	ymm6, ymmword ptr [rbx + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm9, ymm7, ymm11
	vpshufb	ymm14, ymm2, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 682f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 692f]
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
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 240]
	vpor	ymm4, ymm3, ymmword ptr [rip + 702f]
	vpcmpeqd	ymm3, ymm3, ymm7
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 712f]
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
	mov	r9, qword ptr [rsp + 24]
	add	r9, rax
	.p2align	4
432:
	mov	r13, qword ptr [rsp + 32]
	shr	r8, 56
	add	r8, r14
	mov	r10, qword ptr [rsp + 48]
	shr	r10, 56
	add	r10, r15
	vmovd	eax, xmm0
	mov	qword ptr [rdi + 72], r9
	mov	qword ptr [rdi + 96], rax
	mov	qword ptr [rdi + 128], r10
	mov	qword ptr [rdi + 136], r8
	xor	r8d, r8d
	.p2align	4
442:
	movzx	r10d, byte ptr [rdi + r8 + 512]
	movzx	r9d, byte ptr [rdi + r8 + 192]
	mov	eax, dword ptr [rdi + 4*r8 + 256]
	vmovdqu	ymm0, ymmword ptr [rsi]
	cmp	r12, 32
	jb	542f
	mov	r11, rdx
	sub	r11, r12
	cmp	r11, rcx
	jl	542f
	vmovdqu	ymm1, ymmword ptr [r11]
452:
	vpaddb	ymm0, ymm1, ymm0
	vmovdqu	ymmword ptr [rdx], ymm0
	cmp	r9b, 33
	jae	492f
462:
	add	rdx, r9
	mov	r11d, r10d
	shr	r11d, 2
	cmp	rax, r11
	jb	552f
	mov	rbx, rdx
	sub	rbx, rax
	cmp	rbx, rcx
	jl	552f
	vmovdqu	ymm0, ymmword ptr [rbx]
	mov	r14, rax
472:
	vmovdqu	ymmword ptr [rdx], ymm0
	cmp	r10b, -124
	jae	512f
482:
	add	rdx, r11
	add	rsi, r9
	inc	r8
	cmp	r8, r13
	mov	r12, rax
	jne	442b
	jmp	2b
492:
	mov	r9, qword ptr [rdi + 48]
	mov	r11, qword ptr [rdi + 120]
	movzx	r9d, byte ptr [r9 + r11]
	inc	r11
	mov	qword ptr [rdi + 120], r11
	add	r9, 33
	mov	r11d, 32
	.p2align	4
502:
	vmovdqu	ymm0, ymmword ptr [rsi + r11]
	vmovdqu	ymmword ptr [rdx + r11], ymm0
	add	r11, 32
	cmp	r11, r9
	jb	502b
	jmp	462b
512:
	cmp	r14, 31
	ja	522f
	mov	qword ptr [rdi + 104], 1
522:
	mov	r10, qword ptr [rdi + 48]
	mov	r14, qword ptr [rdi + 120]
	movzx	r11d, byte ptr [r10 + r14]
	inc	r14
	mov	qword ptr [rdi + 120], r14
	add	r11, 33
	mov	r10d, 32
	.p2align	4
532:
	vmovdqu	ymm0, ymmword ptr [rbx + r10]
	vmovdqu	ymmword ptr [rdx + r10], ymm0
	add	r10, 32
	cmp	r10, r11
	jb	532b
	jmp	482b
542:
	mov	r11, rdx
	sub	r11, rcx
	cmp	r12, r11
	cmovae	r12, r11
	sub	r11, r12
	cmp	r12, 31
	jbe	562f
	vmovdqu	ymm1, ymmword ptr [rcx + r11]
	jmp	452b
552:
	mov	rbx, rdx
	sub	rbx, rcx
	cmp	rax, rbx
	mov	r14, rbx
	cmovb	r14, rax
	sub	rbx, r14
	cmp	r14, r11
	jae	572f
	mov	r15, qword ptr [rdi + 56]
	mov	r12, r14
	shl	r12, 5
	vmovdqu	ymm0, ymmword ptr [r15 + r12 + 2048]
	vmovdqu	ymm1, ymmword ptr [rcx + rbx]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	add	rbx, rcx
	jmp	472b
562:
	mov	rbx, qword ptr [rdi + 56]
	shl	r12, 5
	vmovdqu	ymm1, ymmword ptr [rbx + r12 + 2048]
	vmovdqu	ymm2, ymmword ptr [rcx + r11]
	vpermq	ymm3, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm3, ymm3, ymm1
	vpshufb	ymm2, ymm2, ymm1
	vpsllw	ymm1, ymm1, 3
	vpblendvb	ymm1, ymm3, ymm2, ymm1
	jmp	452b
572:
	vmovdqu	ymm0, ymmword ptr [rcx + rbx]
	add	rbx, rcx
	jmp	472b
582:
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
592:
	.long	1
	.p2align	2, 0x0
602:
	.long	7
	.p2align	2, 0x0
612:
	.long	8
	.p2align	2, 0x0
622:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	2, 0x0
632:
	.long	134217727
	.p2align	5, 0x0
642:
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
652:
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
662:
	.byte	1
	.p2align	4, 0x0
672:
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
682:
	.byte	16
	.p2align	2, 0x0
692:
	.byte	32
	.p2align	5, 0x0
702:
	.long	1207959552
	.long	1342177280
	.long	1476395008
	.long	1610612736
	.long	1744830464
	.long	1879048192
	.long	2013265920
	.long	2147483648
	.p2align	5, 0x0
712:
	.long	134217728
	.long	268435456
	.long	402653184
	.long	536870912
	.long	671088640
	.long	805306368
	.long	939524096
	.long	1073741824

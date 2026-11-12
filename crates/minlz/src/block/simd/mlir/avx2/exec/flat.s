# minlz_exec_flat of crates/minlz/mlir/exec64.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 600
	mov	rbp, qword ptr [rdi]
	mov	rax, qword ptr [rdi + 8]
	mov	rcx, qword ptr [rdi + 64]
	mov	r11, qword ptr [rdi + 80]
	add	r11, rbp
	mov	r15, qword ptr [rdi + 88]
	mov	qword ptr [rsp + 208], rax
	add	r15, rax
	test	rcx, rcx
	jle	872f
	mov	rax, qword ptr [rdi + 16]
	mov	qword ptr [rsp + 216], rax
	lea	r10, [rdi + 512]
	lea	rax, [rdi + 576]
	mov	qword ptr [rsp + 32], rax
	mov	eax, 96
	mov	qword ptr [rsp + 96], rax
	mov	eax, 7
	mov	qword ptr [rsp + 72], rax
	mov	qword ptr [rsp + 104], 0
	vpxor	xmm7, xmm7, xmm7
	vbroadcastss	ymm0, dword ptr [rip + 882f]
	vmovups	ymmword ptr [rsp + 432], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 892f]
	vmovups	ymmword ptr [rsp + 400], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 902f]
	vmovups	ymmword ptr [rsp + 368], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 912f]
	vmovups	ymmword ptr [rsp + 336], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 922f]
	vmovups	ymmword ptr [rsp + 304], ymm0
	mov	r14, r10
	xor	eax, eax
	mov	qword ptr [rsp + 8], rdi
	mov	qword ptr [rsp + 56], rbp
	mov	qword ptr [rsp + 224], rcx
	mov	qword ptr [rsp + 64], r10
	jmp	12f
	.p2align	4
2:
	inc	qword ptr [rsp + 104]
	add	qword ptr [rsp + 96], 64
	add	qword ptr [rsp + 72], -64
	add	r14, -64
	mov	rcx, qword ptr [rsp + 224]
	mov	rax, qword ptr [rsp + 232]
	cmp	rax, rcx
	jge	872f
12:
	mov	qword ptr [rsp + 48], r15
	mov	qword ptr [rsp + 24], r11
	mov	r11, rax
	sub	rcx, rax
	cmp	rcx, 64
	mov	eax, 64
	mov	qword ptr [rsp + 176], rcx
	cmovb	rax, rcx
	mov	qword ptr [rsp + 88], rax
	mov	r9, qword ptr [rdi + 16]
	mov	rbx, qword ptr [rdi + 24]
	mov	r10, qword ptr [rdi + 32]
	mov	r8, qword ptr [rdi + 40]
	mov	r12, qword ptr [rdi + 64]
	mov	rax, qword ptr [rdi + 72]
	mov	qword ptr [rsp + 40], rax
	mov	r15, qword ptr [rdi + 96]
	mov	rdx, qword ptr [rdi + 112]
	mov	rax, qword ptr [rdi + 128]
	mov	r13, qword ptr [rdi + 136]
	lea	rcx, [r12 + 7]
	lea	rsi, [r11 + 64]
	mov	qword ptr [rsp + 232], rsi
	cmp	rsi, rcx
	mov	qword ptr [rsp + 80], r14
	mov	qword ptr [rsp + 16], r11
	mov	qword ptr [rsp + 144], r15
	mov	qword ptr [rsp + 112], r13
	jbe	22f
	cmp	r11, rcx
	mov	rsi, qword ptr [rsp + 64]
	jge	82f
	mov	rsi, qword ptr [rsp + 104]
	shl	rsi, 6
	mov	r15d, 7
	sub	r15, rsi
	add	r15, r12
	cmp	r15, 16
	mov	rbp, qword ptr [rsp + 16]
	jb	72f
	add	rsi, r9
	mov	r11, rdi
	sub	r11, rsi
	add	r11, 511
	cmp	r11, 127
	mov	rbp, qword ptr [rsp + 16]
	jb	72f
	cmp	r15, 128
	jae	32f
	xor	r13d, r13d
	jmp	52f
	.p2align	4
22:
	add	r9, r11
	mov	rsi, r9
	jmp	82f
32:
	mov	r13, r15
	and	r13, -128
	mov	rsi, qword ptr [rsp + 16]
	lea	rbp, [rsi + r13]
	mov	rsi, qword ptr [rsp + 96]
	add	rsi, r9
	mov	r11, qword ptr [rsp + 72]
	lea	r14, [r12 + r11]
	and	r14, -128
	xor	r11d, r11d
	.p2align	4
42:
	vmovups	ymm0, ymmword ptr [rsi + r11 - 96]
	vmovdqu	ymm1, ymmword ptr [rsi + r11 - 64]
	vmovdqu	ymm3, ymmword ptr [rsi + r11 - 32]
	vmovdqu	ymm4, ymmword ptr [rsi + r11]
	vmovups	ymmword ptr [rdi + r11 + 512], ymm0
	vmovdqu	ymmword ptr [rdi + r11 + 544], ymm1
	vmovdqu	ymmword ptr [rdi + r11 + 576], ymm3
	vmovdqu	ymmword ptr [rdi + r11 + 608], ymm4
	sub	r11, -128
	cmp	r14, r11
	jne	42b
	cmp	r15, r13
	mov	rsi, qword ptr [rsp + 64]
	mov	r14, qword ptr [rsp + 80]
	je	82f
	test	r15b, 112
	je	72f
52:
	mov	rsi, r15
	and	rsi, -16
	mov	r11, qword ptr [rsp + 16]
	lea	rbp, [r11 + rsi]
	add	r11, r9
	add	r12, qword ptr [rsp + 72]
	and	r12, -16
	mov	r14, qword ptr [rsp + 64]
	.p2align	4
62:
	vmovups	xmm0, xmmword ptr [r11 + r13]
	vmovups	xmmword ptr [r14 + r13], xmm0
	add	r13, 16
	cmp	r12, r13
	jne	62b
	cmp	r15, rsi
	mov	rsi, r14
	mov	r14, qword ptr [rsp + 80]
	je	82f
	.p2align	4
72:
	movzx	esi, byte ptr [r9 + rbp]
	mov	byte ptr [r14 + rbp], sil
	inc	rbp
	cmp	rcx, rbp
	jne	72b
	mov	rsi, qword ptr [rsp + 64]
82:
	vmovdqu	ymm2, ymmword ptr [rsi]
	vmovdqu	ymm1, ymmword ptr [rsi + 32]
	vmovd	xmm3, dword ptr [rsp + 88]
	vpbroadcastb	ymm4, xmm3
	vpmaxub	ymm3, ymm4, ymmword ptr [rip + 932f]
	vpcmpeqb	ymm3, ymm4, ymm3
	vpmaxub	ymm5, ymm4, ymmword ptr [rip + 942f]
	vpcmpeqb	ymm4, ymm4, ymm5
	vpsllw	ymm5, ymm2, 6
	vpcmpgtb	ymm9, ymm7, ymm5
	vpsllw	ymm5, ymm1, 6
	vpcmpgtb	ymm11, ymm7, ymm5
	vpbroadcastb	ymm0, byte ptr [rip + 952f]
	vmovdqu	ymmword ptr [rsp + 240], ymm2
	vpand	ymm5, ymm2, ymm0
	vmovdqu	ymmword ptr [rsp + 528], ymm1
	vpand	ymm8, ymm1, ymm0
	vpcmpeqb	ymm8, ymm8, ymm7
	vpcmpeqb	ymm5, ymm5, ymm7
	movabs	r14, 72340172838076673
	mov	r12, r14
	#APP
	#NO_APP
	vpand	ymm9, ymm9, ymm0
	vpand	ymm10, ymm9, ymm3
	vpand	ymm9, ymm11, ymm0
	vpand	ymm9, ymm9, ymm4
	vmovdqu	ymmword ptr [rdi + 544], ymm9
	vmovdqu	ymmword ptr [rdi + 512], ymm10
	vmovq	rsi, xmm10
	mov	rcx, rsi
	imul	rcx, r12
	mov	r9, rcx
	sub	r9, rsi
	xor	rsi, r12
	shl	rsi, 7
	or	rsi, r9
	vmovq	xmm11, qword ptr [rbx + rax]
	vmovq	xmm12, rsi
	vpshufb	xmm11, xmm11, xmm12
	shr	rcx, 56
	add	rcx, rax
	vmovq	qword ptr [rdi + 512], xmm11
	vpextrq	rsi, xmm10, 1
	mov	rax, rsi
	imul	rax, r12
	mov	r9, rax
	sub	r9, rsi
	xor	rsi, r12
	shl	rsi, 7
	or	rsi, r9
	vmovq	xmm11, qword ptr [rbx + rcx]
	vmovq	xmm12, rsi
	vpshufb	xmm11, xmm11, xmm12
	shr	rax, 56
	add	rax, rcx
	vmovq	qword ptr [rdi + 520], xmm11
	vextracti128	xmm10, ymm10, 1
	vmovq	rsi, xmm10
	mov	rcx, rsi
	imul	rcx, r12
	mov	r9, rcx
	sub	r9, rsi
	xor	rsi, r12
	shl	rsi, 7
	or	rsi, r9
	vmovq	xmm11, qword ptr [rbx + rax]
	vmovq	xmm12, rsi
	vpshufb	xmm11, xmm11, xmm12
	shr	rcx, 56
	add	rcx, rax
	vmovq	qword ptr [rdi + 528], xmm11
	vpextrq	rsi, xmm10, 1
	mov	rax, rsi
	imul	rax, r12
	mov	r9, rax
	sub	r9, rsi
	xor	rsi, r12
	shl	rsi, 7
	or	rsi, r9
	vmovq	xmm10, qword ptr [rbx + rcx]
	vmovq	xmm11, rsi
	vpshufb	xmm10, xmm10, xmm11
	shr	rax, 56
	add	rax, rcx
	vmovq	qword ptr [rdi + 536], xmm10
	vmovq	rsi, xmm9
	mov	rcx, rsi
	imul	rcx, r12
	mov	r9, rcx
	sub	r9, rsi
	xor	rsi, r12
	shl	rsi, 7
	or	rsi, r9
	vmovq	xmm10, qword ptr [rbx + rax]
	vmovq	xmm11, rsi
	vpshufb	xmm10, xmm10, xmm11
	shr	rcx, 56
	add	rcx, rax
	vmovq	qword ptr [rdi + 544], xmm10
	vpextrq	rsi, xmm9, 1
	mov	rax, rsi
	imul	rax, r12
	mov	r9, rax
	sub	r9, rsi
	xor	rsi, r12
	shl	rsi, 7
	or	rsi, r9
	vmovq	xmm9, qword ptr [rbx + rcx]
	vmovq	xmm10, rsi
	vpshufb	xmm9, xmm9, xmm10
	shr	rax, 56
	add	rax, rcx
	vmovq	qword ptr [rdi + 552], xmm9
	mov	rcx, qword ptr [rdi + 560]
	mov	rsi, qword ptr [rdi + 568]
	mov	r9, rcx
	imul	r9, r12
	mov	r11, r9
	sub	r11, rcx
	xor	rcx, r12
	shl	rcx, 7
	or	rcx, r11
	vmovq	xmm9, qword ptr [rbx + rax]
	vmovq	xmm10, rcx
	vpshufb	xmm9, xmm9, xmm10
	shr	r9, 56
	add	r9, rax
	vmovq	qword ptr [rdi + 560], xmm9
	mov	r13, rsi
	imul	r13, r12
	mov	rax, r13
	sub	rax, rsi
	xor	r12, rsi
	shl	r12, 7
	or	r12, rax
	vmovq	xmm9, qword ptr [rbx + r9]
	vmovq	xmm10, r12
	vpshufb	xmm9, xmm9, xmm10
	vmovq	qword ptr [rdi + 568], xmm9
	vmovups	ymm9, ymmword ptr [rdi + 544]
	vmovups	ymm10, ymmword ptr [rdi + 512]
	vmovups	ymmword ptr [rdi + 192], ymm10
	vmovups	ymmword ptr [rdi + 224], ymm9
	mov	rax, r14
	#APP
	#NO_APP
	vpand	ymm8, ymm8, ymm0
	vpand	ymm4, ymm8, ymm4
	vpand	ymm5, ymm5, ymm0
	vpand	ymm3, ymm3, ymm5
	vmovdqu	ymmword ptr [rdi + 512], ymm3
	vmovdqu	ymmword ptr [rdi + 544], ymm4
	vmovq	rcx, xmm3
	mov	rsi, rax
	imul	rsi, rcx
	mov	r11, rsi
	sub	r11, rcx
	xor	rcx, rax
	shl	rcx, 7
	or	rcx, r11
	mov	r11, qword ptr [rsp + 112]
	vmovq	xmm5, qword ptr [r10 + r11]
	vmovq	xmm8, rcx
	vpshufb	xmm5, xmm5, xmm8
	shr	rsi, 56
	add	rsi, r11
	vmovq	qword ptr [rdi + 512], xmm5
	vpextrq	r11, xmm3, 1
	mov	rcx, rax
	imul	rcx, r11
	mov	rbx, rcx
	sub	rbx, r11
	xor	r11, rax
	shl	r11, 7
	or	r11, rbx
	vmovq	xmm5, qword ptr [r10 + rsi]
	vmovq	xmm8, r11
	vpshufb	xmm5, xmm5, xmm8
	shr	rcx, 56
	add	rcx, rsi
	vmovq	qword ptr [rdi + 520], xmm5
	vextracti128	xmm3, ymm3, 1
	vmovq	r11, xmm3
	mov	rsi, rax
	imul	rsi, r11
	mov	rbx, rsi
	sub	rbx, r11
	xor	r11, rax
	shl	r11, 7
	or	r11, rbx
	vmovq	xmm5, qword ptr [r10 + rcx]
	vmovq	xmm8, r11
	vpshufb	xmm5, xmm5, xmm8
	shr	rsi, 56
	add	rsi, rcx
	vmovq	qword ptr [rdi + 528], xmm5
	vpextrq	r11, xmm3, 1
	mov	rcx, rax
	imul	rcx, r11
	mov	rbx, rcx
	sub	rbx, r11
	xor	r11, rax
	shl	r11, 7
	or	r11, rbx
	vmovq	xmm3, qword ptr [r10 + rsi]
	vmovq	xmm5, r11
	vpshufb	xmm3, xmm3, xmm5
	shr	rcx, 56
	add	rcx, rsi
	vmovq	qword ptr [rdi + 536], xmm3
	vmovq	r11, xmm4
	mov	rsi, rax
	imul	rsi, r11
	mov	rbx, rsi
	sub	rbx, r11
	xor	r11, rax
	shl	r11, 7
	or	r11, rbx
	vmovq	xmm3, qword ptr [r10 + rcx]
	vmovq	xmm5, r11
	vpshufb	xmm3, xmm3, xmm5
	shr	rsi, 56
	add	rsi, rcx
	vmovq	qword ptr [rdi + 544], xmm3
	vpextrq	r11, xmm4, 1
	mov	rcx, rax
	imul	rcx, r11
	mov	rbx, rcx
	sub	rbx, r11
	xor	r11, rax
	shl	r11, 7
	or	r11, rbx
	vmovq	xmm3, qword ptr [r10 + rsi]
	vmovq	xmm4, r11
	vpshufb	xmm3, xmm3, xmm4
	shr	rcx, 56
	add	rcx, rsi
	vmovq	qword ptr [rdi + 552], xmm3
	mov	rsi, qword ptr [rdi + 560]
	mov	r14, qword ptr [rdi + 568]
	mov	r11, rsi
	imul	r11, rax
	mov	rbx, r11
	sub	rbx, rsi
	xor	rsi, rax
	shl	rsi, 7
	or	rsi, rbx
	vmovq	xmm3, qword ptr [r10 + rcx]
	vmovq	xmm4, rsi
	vpshufb	xmm3, xmm3, xmm4
	shr	r11, 56
	add	r11, rcx
	vmovq	qword ptr [rdi + 560], xmm3
	mov	rbx, r14
	imul	rbx, rax
	mov	rcx, rbx
	sub	rcx, r14
	xor	rax, r14
	shl	rax, 7
	or	rax, rcx
	vmovq	xmm3, qword ptr [r10 + r11]
	vmovq	xmm4, rax
	vpshufb	xmm3, xmm3, xmm4
	vmovq	qword ptr [rdi + 568], xmm3
	vmovdqu	ymm6, ymmword ptr [rdi + 512]
	vmovups	ymm0, ymmword ptr [rdi + 544]
	vmovups	ymmword ptr [rsp + 496], ymm0
	vmovd	xmm3, dword ptr [rsp + 144]
	vpbroadcastd	ymm10, xmm3
	vpmovzxbd	ymm3, qword ptr [rdi + 520]
	vpmovzxbd	ymm4, qword ptr [rdi + 512]
	vpsrld	ymm5, ymm4, 3
	vpsrld	ymm8, ymm3, 3
	vmovdqu	ymm0, ymmword ptr [rsp + 432]
	vpmaxud	ymm8, ymm8, ymm0
	vpcmpeqd	ymm1, ymm1, ymm1
	vpaddd	ymm9, ymm8, ymm1
	vpmaxud	ymm5, ymm5, ymm0
	vpaddd	ymm11, ymm5, ymm1
	vmovdqu	ymm2, ymmword ptr [rsp + 400]
	vpand	ymm5, ymm4, ymm2
	vpand	ymm8, ymm3, ymm2
	vmovdqu	ymm0, ymmword ptr [rsp + 368]
	vpminud	ymm3, ymm3, ymm0
	vpminud	ymm4, ymm4, ymm0
	vpand	ymm4, ymm4, ymm0
	vpor	ymm4, ymm4, ymm5
	vpand	ymm3, ymm3, ymm0
	vpor	ymm5, ymm8, ymm3
	vpsllvd	ymm13, ymm4, ymm11
	vpsllvd	ymm3, ymm5, ymm9
	vpsllvd	ymm5, ymm1, ymm11
	vpsllvd	ymm4, ymm1, ymm9
	vperm2i128	ymm8, ymm11, ymm9, 33
	vpalignr	ymm8, ymm9, ymm8, 12
	vperm2i128	ymm12, ymm11, ymm11, 10
	vpalignr	ymm12, ymm11, ymm12, 12
	vpaddd	ymm12, ymm12, ymm11
	vpaddd	ymm8, ymm8, ymm9
	vpblendd	ymm14, ymm12, ymm7, 192
	vpermq	ymm14, ymm14, 147
	vpaddd	ymm14, ymm14, ymm12
	vpblendd	ymm12, ymm8, ymm12, 192
	vpermq	ymm12, ymm12, 147
	vpaddd	ymm8, ymm12, ymm8
	vperm2i128	ymm12, ymm14, ymm14, 10
	vpaddd	ymm12, ymm12, ymm14
	vperm2i128	ymm14, ymm14, ymm8, 33
	vpaddd	ymm8, ymm14, ymm8
	vpaddd	ymm8, ymm12, ymm8
	vpsubd	ymm9, ymm8, ymm9
	vpsubd	ymm11, ymm12, ymm11
	mov	r15, qword ptr [rsp + 40]
	mov	eax, r15d
	and	eax, 7
	vmovd	xmm12, eax
	vpbroadcastd	ymm12, xmm12
	vpaddd	ymm9, ymm9, ymm12
	vpaddd	ymm11, ymm11, ymm12
	vpsrld	ymm12, ymm9, 3
	vpsrld	ymm0, ymm11, 3
	vpand	ymm14, ymm9, ymm2
	vpand	ymm9, ymm11, ymm2
	vbroadcasti128	ymm1, xmmword ptr [rip + 962f]
	vpshufb	ymm11, ymm12, ymm1
	vpshufb	ymm0, ymm0, ymm1
	vmovdqu	ymm1, ymmword ptr [rsp + 336]
	vpaddb	ymm12, ymm11, ymm1
	vpaddb	ymm11, ymm0, ymm1
	mov	rax, r15
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, rdx
	vmovdqu	ymmword ptr [rsp + 560], ymm6
	vmovdqu	ymmword ptr [rsp + 144], ymm10
	vmovdqu	ymmword ptr [rsp + 112], ymm3
	vmovdqu	ymmword ptr [rsp + 272], ymm4
	vmovdqu	ymmword ptr [rsp + 464], ymm14
	vmovdqa	ymm14, ymm5
	jbe	92f
	mov	rcx, rdx
	sub	rcx, rax
	mov	rdi, qword ptr [rsp + 32]
	mov	r14, rdi
	jbe	162f
	cmp	rcx, 16
	mov	r10, rax
	jb	142f
	lea	r12, [rax + r8]
	mov	rsi, qword ptr [rsp + 8]
	sub	rsi, r12
	add	rsi, 575
	cmp	rsi, 127
	mov	r10, rax
	jb	142f
	cmp	rcx, 128
	jae	102f
	xor	esi, esi
	jmp	122f
	.p2align	4
92:
	add	rax, r8
	mov	r14, rax
	jmp	162f
102:
	mov	rsi, rcx
	and	rsi, -128
	lea	r10, [rax + rsi]
	lea	r14, [r8 + rax + 96]
	xor	r15d, r15d
	mov	rdi, qword ptr [rsp + 8]
	.p2align	4
112:
	vmovdqu	ymm0, ymmword ptr [r14 + r15 - 96]
	vmovdqu	ymm6, ymmword ptr [r14 + r15 - 64]
	vmovdqu	ymm7, ymmword ptr [r14 + r15 - 32]
	vmovdqu	ymm2, ymmword ptr [r14 + r15]
	vmovdqu	ymmword ptr [rdi + r15 + 576], ymm0
	vmovdqu	ymmword ptr [rdi + r15 + 608], ymm6
	vmovdqu	ymmword ptr [rdi + r15 + 640], ymm7
	vmovdqu	ymmword ptr [rdi + r15 + 672], ymm2
	sub	r15, -128
	cmp	rsi, r15
	jne	112b
	cmp	rcx, rsi
	mov	rdi, qword ptr [rsp + 32]
	mov	r14, rdi
	mov	r15, qword ptr [rsp + 40]
	je	162f
	test	cl, 112
	je	142f
122:
	mov	r14, rcx
	and	r14, -16
	lea	r10, [rax + r14]
	.p2align	4
132:
	vmovdqu	xmm0, xmmword ptr [r12 + rsi]
	vmovdqu	xmmword ptr [rdi + rsi], xmm0
	add	rsi, 16
	cmp	r14, rsi
	jne	132b
	cmp	rcx, r14
	mov	r14, rdi
	je	162f
	.p2align	4
142:
	mov	rcx, rdi
	sub	rcx, rax
	.p2align	4
152:
	movzx	eax, byte ptr [r8 + r10]
	mov	byte ptr [rcx + r10], al
	inc	r10
	cmp	rdx, r10
	jne	152b
	mov	r14, rdi
162:
	vmovdqu	ymm0, ymmword ptr [r14]
	vmovdqu	ymm2, ymmword ptr [r14 + 32]
	vpermq	ymm6, ymm0, 68
	vpermq	ymm0, ymm0, 238
	vpshufb	ymm7, ymm6, ymm12
	vpshufb	ymm15, ymm0, ymm12
	vpbroadcastb	ymm4, byte ptr [rip + 972f]
	vpand	ymm1, ymm12, ymm4
	vpxor	xmm5, xmm5, xmm5
	vpcmpeqb	ymm1, ymm1, ymm5
	vpblendvb	ymm7, ymm15, ymm7, ymm1
	vpermq	ymm15, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm10, ymm15, ymm12
	vpshufb	ymm3, ymm2, ymm12
	vpblendvb	ymm1, ymm3, ymm10, ymm1
	vpshufb	ymm3, ymm6, ymm11
	vpshufb	ymm0, ymm0, ymm11
	vpand	ymm6, ymm11, ymm4
	vpcmpeqb	ymm6, ymm6, ymm5
	vpblendvb	ymm0, ymm0, ymm3, ymm6
	vpshufb	ymm3, ymm15, ymm11
	vpshufb	ymm2, ymm2, ymm11
	vpblendvb	ymm2, ymm2, ymm3, ymm6
	vpbroadcastb	ymm4, byte ptr [rip + 982f]
	vpand	ymm3, ymm11, ymm4
	vpcmpeqb	ymm3, ymm3, ymm4
	vpblendvb	ymm0, ymm0, ymm2, ymm3
	vpand	ymm2, ymm12, ymm4
	vpcmpeqb	ymm2, ymm2, ymm4
	vpblendvb	ymm1, ymm7, ymm1, ymm2
	vpxor	xmm7, xmm7, xmm7
	vpsrlvd	ymm0, ymm0, ymm9
	vpandn	ymm0, ymm14, ymm0
	vpaddd	ymm0, ymm13, ymm0
	vpsrlvd	ymm1, ymm1, ymmword ptr [rsp + 464]
	vmovdqu	ymm2, ymmword ptr [rsp + 272]
	vpandn	ymm1, ymm2, ymm1
	vpaddd	ymm1, ymm1, ymmword ptr [rsp + 112]
	vpor	ymm2, ymm1, ymmword ptr [rip + 992f]
	vpcmpeqd	ymm1, ymm1, ymm7
	vpandn	ymm1, ymm1, ymm2
	vpor	ymm2, ymm0, ymmword ptr [rip + 1002f]
	vpcmpeqd	ymm0, ymm0, ymm7
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
	vpblendd	ymm1, ymm2, ymm7, 192
	vpermq	ymm1, ymm1, 147
	vpmaxud	ymm1, ymm2, ymm1
	vperm2i128	ymm2, ymm1, ymm1, 10
	vpmaxud	ymm2, ymm1, ymm2
	vperm2i128	ymm1, ymm1, ymm0, 33
	vpmaxud	ymm0, ymm0, ymm1
	vpmaxud	ymm0, ymm0, ymm2
	vmovdqu	ymm3, ymmword ptr [rsp + 304]
	vpand	ymm1, ymm0, ymm3
	vpcmpeqd	ymm0, ymm0, ymm7
	vmovups	ymm5, ymmword ptr [rsp + 144]
	vblendvps	ymm0, ymm1, ymm5, ymm0
	vpand	ymm1, ymm2, ymm3
	vpcmpeqd	ymm2, ymm2, ymm7
	vblendvps	ymm1, ymm1, ymm5, ymm2
	vmovdqu	ymm2, ymmword ptr [rsp + 240]
	vpsrlw	xmm2, xmm2, 2
	vpand	xmm2, xmm2, xmmword ptr [rip + 1012f]
	vpminub	xmm2, xmm2, xmm4
	vpmovzxbd	ymm3, xmm2
	vpmaxud	ymm1, ymm1, ymm3
	vextracti128	xmm3, ymm8, 1
	vpextrd	eax, xmm3, 3
	mov	rdi, qword ptr [rsp + 8]
	vmovdqu	ymmword ptr [rdi + 256], ymm1
	vpshufd	xmm1, xmm2, 238
	vpmovzxbd	ymm1, xmm1
	vpmaxud	ymm1, ymm0, ymm1
	vmovdqu	ymmword ptr [rdi + 288], ymm1
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm13, ymm0, 170
	add	r15, rax
	cmp	qword ptr [rsp + 176], 17
	jb	172f
	vmovups	ymmword ptr [rsp + 144], ymm13
	vmovdqu	ymm0, ymmword ptr [rsp + 560]
	vextracti128	xmm0, ymm0, 1
	vpshufd	xmm1, xmm0, 238
	vpmovzxbd	ymm1, xmm1
	vpmovzxbd	ymm0, xmm0
	vpsrld	ymm2, ymm0, 3
	vpsrld	ymm3, ymm1, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 432]
	vpmaxud	ymm3, ymm3, ymm5
	vpcmpeqd	ymm6, ymm6, ymm6
	vpaddd	ymm4, ymm3, ymm6
	vpmaxud	ymm2, ymm2, ymm5
	vpaddd	ymm9, ymm2, ymm6
	vmovdqu	ymm8, ymmword ptr [rsp + 400]
	vpand	ymm2, ymm8, ymm0
	vpand	ymm3, ymm8, ymm1
	vmovdqu	ymm5, ymmword ptr [rsp + 368]
	vpminud	ymm1, ymm1, ymm5
	vpminud	ymm0, ymm0, ymm5
	vpand	ymm0, ymm0, ymm5
	vpor	ymm0, ymm0, ymm2
	vpand	ymm1, ymm1, ymm5
	vpor	ymm1, ymm1, ymm3
	vpsllvd	ymm5, ymm0, ymm9
	vpsllvd	ymm3, ymm1, ymm4
	vpsllvd	ymm10, ymm6, ymm9
	vpsllvd	ymm13, ymm6, ymm4
	vperm2i128	ymm0, ymm9, ymm4, 33
	vpalignr	ymm0, ymm4, ymm0, 12
	vperm2i128	ymm1, ymm9, ymm9, 10
	vpalignr	ymm1, ymm9, ymm1, 12
	vpaddd	ymm1, ymm9, ymm1
	vpaddd	ymm0, ymm0, ymm4
	vpblendd	ymm2, ymm1, ymm7, 192
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
	vpsubd	ymm1, ymm1, ymm9
	mov	eax, r15d
	and	eax, 7
	vmovd	xmm2, eax
	vpbroadcastd	ymm2, xmm2
	vpaddd	ymm0, ymm2, ymm0
	vpaddd	ymm1, ymm2, ymm1
	vpsrld	ymm2, ymm0, 3
	vpsrld	ymm6, ymm1, 3
	vpand	ymm4, ymm8, ymm0
	vpand	ymm9, ymm8, ymm1
	vbroadcasti128	ymm1, xmmword ptr [rip + 962f]
	vpshufb	ymm0, ymm2, ymm1
	vpshufb	ymm1, ymm6, ymm1
	vmovdqu	ymm2, ymmword ptr [rsp + 336]
	vpaddb	ymm14, ymm0, ymm2
	vpaddb	ymm12, ymm1, ymm2
	mov	rax, r15
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, rdx
	mov	rbp, qword ptr [rsp + 56]
	vmovdqu	ymmword ptr [rsp + 112], ymm3
	vmovdqu	ymmword ptr [rsp + 272], ymm4
	vmovdqu	ymmword ptr [rsp + 464], ymm13
	vmovdqa	ymm4, ymm10
	vmovdqa	ymm13, ymm5
	jbe	182f
	mov	rcx, rdx
	sub	rcx, rax
	mov	rdi, qword ptr [rsp + 32]
	mov	r14, rdi
	jbe	252f
	cmp	rcx, 16
	mov	r10, rax
	jb	232f
	lea	r12, [rax + r8]
	mov	rsi, qword ptr [rsp + 8]
	sub	rsi, r12
	add	rsi, 575
	cmp	rsi, 127
	mov	r10, rax
	jb	232f
	cmp	rcx, 128
	jae	192f
	xor	esi, esi
	jmp	212f
	.p2align	4
172:
	mov	rbp, qword ptr [rsp + 56]
	jmp	422f
	.p2align	4
182:
	add	rax, r8
	mov	r14, rax
	jmp	252f
192:
	mov	qword ptr [rsp + 40], r15
	mov	rsi, rcx
	and	rsi, -128
	lea	r10, [rax + rsi]
	lea	r14, [r8 + rax + 96]
	xor	r15d, r15d
	mov	rdi, qword ptr [rsp + 8]
	.p2align	4
202:
	vmovdqu	ymm0, ymmword ptr [r14 + r15 - 96]
	vmovdqu	ymm1, ymmword ptr [r14 + r15 - 64]
	vmovdqu	ymm2, ymmword ptr [r14 + r15 - 32]
	vmovdqu	ymm6, ymmword ptr [r14 + r15]
	vmovdqu	ymmword ptr [rdi + r15 + 576], ymm0
	vmovdqu	ymmword ptr [rdi + r15 + 608], ymm1
	vmovdqu	ymmword ptr [rdi + r15 + 640], ymm2
	vmovdqu	ymmword ptr [rdi + r15 + 672], ymm6
	sub	r15, -128
	cmp	rsi, r15
	jne	202b
	cmp	rcx, rsi
	mov	rdi, qword ptr [rsp + 32]
	mov	r14, rdi
	mov	r15, qword ptr [rsp + 40]
	je	252f
	test	cl, 112
	je	232f
212:
	mov	r14, rcx
	and	r14, -16
	lea	r10, [rax + r14]
	.p2align	4
222:
	vmovdqu	xmm0, xmmword ptr [r12 + rsi]
	vmovdqu	xmmword ptr [rdi + rsi], xmm0
	add	rsi, 16
	cmp	r14, rsi
	jne	222b
	cmp	rcx, r14
	mov	r14, rdi
	je	252f
232:
	mov	rcx, rdi
	sub	rcx, rax
	.p2align	4
242:
	movzx	eax, byte ptr [r8 + r10]
	mov	byte ptr [rcx + r10], al
	inc	r10
	cmp	rdx, r10
	jne	242b
	mov	r14, rdi
252:
	vmovdqu	ymm0, ymmword ptr [r14]
	vpermq	ymm1, ymm0, 68
	vpermq	ymm0, ymm0, 238
	vpshufb	ymm2, ymm1, ymm14
	vpshufb	ymm6, ymm0, ymm14
	vpbroadcastb	ymm5, byte ptr [rip + 972f]
	vpand	ymm7, ymm14, ymm5
	vpxor	xmm3, xmm3, xmm3
	vpcmpeqb	ymm7, ymm7, ymm3
	vpblendvb	ymm2, ymm6, ymm2, ymm7
	vmovdqu	ymm6, ymmword ptr [r14 + 32]
	vpermq	ymm11, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm8, ymm11, ymm14
	vpshufb	ymm10, ymm6, ymm14
	vpblendvb	ymm7, ymm10, ymm8, ymm7
	vpshufb	ymm1, ymm1, ymm12
	vpshufb	ymm0, ymm0, ymm12
	vpand	ymm8, ymm12, ymm5
	vpcmpeqb	ymm8, ymm8, ymm3
	vpblendvb	ymm0, ymm0, ymm1, ymm8
	vpshufb	ymm1, ymm11, ymm12
	vpshufb	ymm6, ymm6, ymm12
	vpblendvb	ymm1, ymm6, ymm1, ymm8
	vpbroadcastb	ymm3, byte ptr [rip + 982f]
	vpand	ymm6, ymm12, ymm3
	vpcmpeqb	ymm6, ymm6, ymm3
	vpblendvb	ymm0, ymm0, ymm1, ymm6
	vpand	ymm1, ymm14, ymm3
	vpcmpeqb	ymm1, ymm1, ymm3
	vpblendvb	ymm1, ymm2, ymm7, ymm1
	vpxor	xmm7, xmm7, xmm7
	vpsrlvd	ymm0, ymm0, ymm9
	vpandn	ymm0, ymm4, ymm0
	vpaddd	ymm0, ymm13, ymm0
	vpsrlvd	ymm1, ymm1, ymmword ptr [rsp + 272]
	vmovdqu	ymm2, ymmword ptr [rsp + 464]
	vpandn	ymm1, ymm2, ymm1
	vpaddd	ymm1, ymm1, ymmword ptr [rsp + 112]
	vpor	ymm2, ymm1, ymmword ptr [rip + 992f]
	vpcmpeqd	ymm1, ymm1, ymm7
	vpandn	ymm1, ymm1, ymm2
	vpor	ymm2, ymm0, ymmword ptr [rip + 1002f]
	vpcmpeqd	ymm0, ymm0, ymm7
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
	vpblendd	ymm1, ymm2, ymm7, 192
	vpermq	ymm1, ymm1, 147
	vpmaxud	ymm1, ymm2, ymm1
	vperm2i128	ymm2, ymm1, ymm1, 10
	vpmaxud	ymm2, ymm1, ymm2
	vperm2i128	ymm1, ymm1, ymm0, 33
	vpmaxud	ymm0, ymm0, ymm1
	vpmaxud	ymm0, ymm0, ymm2
	vmovdqu	ymm4, ymmword ptr [rsp + 304]
	vpand	ymm1, ymm0, ymm4
	vpcmpeqd	ymm0, ymm0, ymm7
	vmovups	ymm5, ymmword ptr [rsp + 144]
	vblendvps	ymm0, ymm1, ymm5, ymm0
	vpand	ymm1, ymm2, ymm4
	vpcmpeqd	ymm2, ymm2, ymm7
	vblendvps	ymm1, ymm1, ymm5, ymm2
	vmovdqu	ymm2, ymmword ptr [rsp + 240]
	vextracti128	xmm2, ymm2, 1
	vpsrlw	xmm2, xmm2, 2
	vpand	xmm2, xmm2, xmmword ptr [rip + 1012f]
	vpminub	xmm2, xmm2, xmm3
	vpmovzxbd	ymm3, xmm2
	vpmaxud	ymm1, ymm1, ymm3
	vextracti128	xmm3, ymm15, 1
	vpextrd	eax, xmm3, 3
	mov	rdi, qword ptr [rsp + 8]
	vmovdqu	ymmword ptr [rdi + 320], ymm1
	vpshufd	xmm1, xmm2, 238
	vpmovzxbd	ymm1, xmm1
	vpmaxud	ymm1, ymm0, ymm1
	vmovdqu	ymmword ptr [rdi + 352], ymm1
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm13, ymm0, 170
	add	r15, rax
	cmp	qword ptr [rsp + 176], 33
	jb	422f
	vmovdqu	ymm1, ymmword ptr [rsp + 496]
	vpshufd	xmm0, xmm1, 238
	vpmovzxbd	ymm0, xmm0
	vpmovzxbd	ymm1, xmm1
	vpsrld	ymm2, ymm1, 3
	vpsrld	ymm3, ymm0, 3
	vmovdqu	ymm4, ymmword ptr [rsp + 432]
	vpmaxud	ymm3, ymm3, ymm4
	vpcmpeqd	ymm5, ymm5, ymm5
	vpaddd	ymm9, ymm3, ymm5
	vpmaxud	ymm2, ymm2, ymm4
	vpaddd	ymm10, ymm2, ymm5
	vmovdqu	ymm8, ymmword ptr [rsp + 400]
	vpand	ymm2, ymm8, ymm1
	vpand	ymm3, ymm8, ymm0
	vmovdqu	ymm4, ymmword ptr [rsp + 368]
	vpminud	ymm0, ymm0, ymm4
	vpminud	ymm1, ymm1, ymm4
	vpand	ymm1, ymm1, ymm4
	vpor	ymm1, ymm1, ymm2
	vpand	ymm0, ymm0, ymm4
	vpor	ymm0, ymm0, ymm3
	vpsllvd	ymm1, ymm1, ymm10
	vmovdqu	ymmword ptr [rsp + 144], ymm1
	vpsllvd	ymm0, ymm0, ymm9
	vmovdqu	ymmword ptr [rsp + 240], ymm0
	vpsllvd	ymm0, ymm5, ymm10
	vmovdqu	ymmword ptr [rsp + 272], ymm0
	vpsllvd	ymm0, ymm5, ymm9
	vmovdqu	ymmword ptr [rsp + 112], ymm0
	vperm2i128	ymm0, ymm10, ymm9, 33
	vpalignr	ymm0, ymm9, ymm0, 12
	vperm2i128	ymm1, ymm10, ymm10, 10
	vpalignr	ymm1, ymm10, ymm1, 12
	vpaddd	ymm1, ymm10, ymm1
	vpaddd	ymm0, ymm9, ymm0
	vpblendd	ymm2, ymm1, ymm7, 192
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
	vpsubd	ymm0, ymm1, ymm9
	vpsubd	ymm2, ymm6, ymm10
	mov	eax, r15d
	and	eax, 7
	vmovd	xmm6, eax
	vpbroadcastd	ymm6, xmm6
	vpaddd	ymm0, ymm6, ymm0
	vpaddd	ymm2, ymm6, ymm2
	vpsrld	ymm6, ymm0, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm9, ymm8, ymm0
	vpand	ymm10, ymm8, ymm2
	vbroadcasti128	ymm2, xmmword ptr [rip + 962f]
	vpshufb	ymm0, ymm6, ymm2
	vpshufb	ymm2, ymm7, ymm2
	vmovdqu	ymm3, ymmword ptr [rsp + 336]
	vpaddb	ymm12, ymm0, ymm3
	vpaddb	ymm11, ymm2, ymm3
	mov	rax, r15
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, rdx
	jbe	262f
	mov	rcx, rdx
	sub	rcx, rax
	mov	rdi, qword ptr [rsp + 32]
	mov	r14, rdi
	jbe	332f
	cmp	rcx, 16
	mov	r10, rax
	jb	312f
	lea	r12, [rax + r8]
	mov	rsi, qword ptr [rsp + 8]
	sub	rsi, r12
	add	rsi, 575
	cmp	rsi, 127
	mov	r10, rax
	jb	312f
	cmp	rcx, 128
	jae	272f
	xor	esi, esi
	jmp	292f
262:
	add	rax, r8
	mov	r14, rax
	jmp	332f
272:
	mov	qword ptr [rsp + 40], r15
	mov	rsi, rcx
	and	rsi, -128
	lea	r10, [rax + rsi]
	lea	r14, [r8 + rax + 96]
	xor	r15d, r15d
	mov	rdi, qword ptr [rsp + 8]
	.p2align	4
282:
	vmovdqu	ymm0, ymmword ptr [r14 + r15 - 96]
	vmovdqu	ymm2, ymmword ptr [r14 + r15 - 64]
	vmovdqu	ymm6, ymmword ptr [r14 + r15 - 32]
	vmovdqu	ymm7, ymmword ptr [r14 + r15]
	vmovdqu	ymmword ptr [rdi + r15 + 576], ymm0
	vmovdqu	ymmword ptr [rdi + r15 + 608], ymm2
	vmovdqu	ymmword ptr [rdi + r15 + 640], ymm6
	vmovdqu	ymmword ptr [rdi + r15 + 672], ymm7
	sub	r15, -128
	cmp	rsi, r15
	jne	282b
	cmp	rcx, rsi
	mov	rdi, qword ptr [rsp + 32]
	mov	r14, rdi
	mov	r15, qword ptr [rsp + 40]
	je	332f
	test	cl, 112
	je	312f
292:
	mov	r14, rcx
	and	r14, -16
	lea	r10, [rax + r14]
	.p2align	4
302:
	vmovdqu	xmm0, xmmword ptr [r12 + rsi]
	vmovdqu	xmmword ptr [rdi + rsi], xmm0
	add	rsi, 16
	cmp	r14, rsi
	jne	302b
	cmp	rcx, r14
	mov	r14, rdi
	je	332f
312:
	mov	rcx, rdi
	sub	rcx, rax
	.p2align	4
322:
	movzx	eax, byte ptr [r8 + r10]
	mov	byte ptr [rcx + r10], al
	inc	r10
	cmp	rdx, r10
	jne	322b
	mov	r14, rdi
332:
	vmovdqu	ymm0, ymmword ptr [r14]
	vmovdqu	ymm2, ymmword ptr [r14 + 32]
	vpermq	ymm6, ymm0, 68
	vpermq	ymm0, ymm0, 238
	vpshufb	ymm7, ymm6, ymm12
	vpshufb	ymm14, ymm0, ymm12
	vpbroadcastb	ymm4, byte ptr [rip + 972f]
	vpand	ymm15, ymm12, ymm4
	vpxor	xmm5, xmm5, xmm5
	vpcmpeqb	ymm15, ymm15, ymm5
	vpblendvb	ymm7, ymm14, ymm7, ymm15
	vpermq	ymm14, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm8, ymm14, ymm12
	vpshufb	ymm3, ymm2, ymm12
	vpblendvb	ymm3, ymm3, ymm8, ymm15
	vpshufb	ymm6, ymm6, ymm11
	vpshufb	ymm0, ymm0, ymm11
	vpand	ymm8, ymm11, ymm4
	vpcmpeqb	ymm8, ymm8, ymm5
	vpblendvb	ymm0, ymm0, ymm6, ymm8
	vpshufb	ymm6, ymm14, ymm11
	vpshufb	ymm2, ymm2, ymm11
	vpblendvb	ymm2, ymm2, ymm6, ymm8
	vpbroadcastb	ymm4, byte ptr [rip + 982f]
	vpand	ymm6, ymm11, ymm4
	vpcmpeqb	ymm6, ymm6, ymm4
	vpblendvb	ymm0, ymm0, ymm2, ymm6
	vpand	ymm2, ymm12, ymm4
	vpcmpeqb	ymm2, ymm2, ymm4
	vpblendvb	ymm2, ymm7, ymm3, ymm2
	vpxor	xmm7, xmm7, xmm7
	vpsrlvd	ymm0, ymm0, ymm10
	vmovdqu	ymm3, ymmword ptr [rsp + 272]
	vpandn	ymm0, ymm3, ymm0
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 144]
	vpsrlvd	ymm2, ymm2, ymm9
	vmovdqu	ymm3, ymmword ptr [rsp + 112]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 240]
	vpor	ymm3, ymm2, ymmword ptr [rip + 992f]
	vpcmpeqd	ymm2, ymm2, ymm7
	vpandn	ymm2, ymm2, ymm3
	vpor	ymm3, ymm0, ymmword ptr [rip + 1002f]
	vpcmpeqd	ymm0, ymm0, ymm7
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
	vpblendd	ymm2, ymm3, ymm7, 192
	vpermq	ymm2, ymm2, 147
	vpmaxud	ymm2, ymm3, ymm2
	vperm2i128	ymm3, ymm2, ymm2, 10
	vpmaxud	ymm3, ymm2, ymm3
	vperm2i128	ymm2, ymm2, ymm0, 33
	vpmaxud	ymm0, ymm0, ymm2
	vpmaxud	ymm0, ymm0, ymm3
	vmovdqu	ymm5, ymmword ptr [rsp + 304]
	vpand	ymm2, ymm0, ymm5
	vpcmpeqd	ymm0, ymm0, ymm7
	vblendvps	ymm0, ymm2, ymm13, ymm0
	vpand	ymm2, ymm3, ymm5
	vpcmpeqd	ymm3, ymm3, ymm7
	vblendvps	ymm2, ymm2, ymm13, ymm3
	vmovdqu	ymm3, ymmword ptr [rsp + 528]
	vpsrlw	xmm3, xmm3, 2
	vpand	xmm3, xmm3, xmmword ptr [rip + 1012f]
	vpminub	xmm3, xmm3, xmm4
	vpmovzxbd	ymm4, xmm3
	vpmaxud	ymm2, ymm2, ymm4
	vextracti128	xmm1, ymm1, 1
	vpextrd	eax, xmm1, 3
	mov	rdi, qword ptr [rsp + 8]
	vmovdqu	ymmword ptr [rdi + 384], ymm2
	vpshufd	xmm1, xmm3, 238
	vpmovzxbd	ymm1, xmm1
	vpmaxud	ymm1, ymm0, ymm1
	vmovdqu	ymmword ptr [rdi + 416], ymm1
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm13, ymm0, 170
	add	r15, rax
	cmp	qword ptr [rsp + 176], 49
	jb	422f
	vmovdqu	ymm0, ymmword ptr [rsp + 496]
	vextracti128	xmm0, ymm0, 1
	vpshufd	xmm1, xmm0, 238
	vpmovzxbd	ymm1, xmm1
	vpmovzxbd	ymm0, xmm0
	vpsrld	ymm2, ymm0, 3
	vpsrld	ymm3, ymm1, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 432]
	vpmaxud	ymm3, ymm3, ymm5
	vpcmpeqd	ymm6, ymm6, ymm6
	vpaddd	ymm4, ymm3, ymm6
	vpmaxud	ymm2, ymm2, ymm5
	vpaddd	ymm9, ymm2, ymm6
	vmovdqu	ymm8, ymmword ptr [rsp + 400]
	vpand	ymm2, ymm8, ymm0
	vpand	ymm3, ymm8, ymm1
	vmovdqu	ymm5, ymmword ptr [rsp + 368]
	vpminud	ymm1, ymm1, ymm5
	vpminud	ymm0, ymm0, ymm5
	vpand	ymm0, ymm0, ymm5
	vpor	ymm0, ymm0, ymm2
	vpand	ymm1, ymm1, ymm5
	vpor	ymm1, ymm1, ymm3
	vpsllvd	ymm0, ymm0, ymm9
	vmovdqu	ymmword ptr [rsp + 240], ymm0
	vpsllvd	ymm0, ymm1, ymm4
	vmovdqu	ymmword ptr [rsp + 176], ymm0
	vpsllvd	ymm0, ymm6, ymm9
	vmovdqu	ymmword ptr [rsp + 112], ymm0
	vpsllvd	ymm0, ymm6, ymm4
	vmovdqu	ymmword ptr [rsp + 144], ymm0
	vperm2i128	ymm0, ymm9, ymm4, 33
	vpalignr	ymm0, ymm4, ymm0, 12
	vperm2i128	ymm1, ymm9, ymm9, 10
	vpalignr	ymm1, ymm9, ymm1, 12
	vpaddd	ymm1, ymm9, ymm1
	vpaddd	ymm0, ymm0, ymm4
	vpblendd	ymm2, ymm1, ymm7, 192
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
	mov	eax, r15d
	and	eax, 7
	vmovd	xmm4, eax
	vpbroadcastd	ymm4, xmm4
	vpaddd	ymm0, ymm4, ymm0
	vpaddd	ymm2, ymm4, ymm2
	vpsrld	ymm6, ymm0, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm4, ymm8, ymm0
	vpand	ymm9, ymm8, ymm2
	vbroadcasti128	ymm2, xmmword ptr [rip + 962f]
	vpshufb	ymm0, ymm6, ymm2
	vpshufb	ymm2, ymm7, ymm2
	vmovdqu	ymm3, ymmword ptr [rsp + 336]
	vpaddb	ymm12, ymm0, ymm3
	vpaddb	ymm14, ymm2, ymm3
	mov	rax, r15
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, rdx
	jbe	342f
	mov	rcx, rdx
	sub	rcx, rax
	mov	rdi, qword ptr [rsp + 32]
	mov	r14, rdi
	jbe	412f
	cmp	rcx, 16
	mov	r10, rax
	jb	392f
	lea	r12, [rax + r8]
	mov	rsi, qword ptr [rsp + 8]
	sub	rsi, r12
	add	rsi, 575
	cmp	rsi, 127
	mov	r10, rax
	jb	392f
	cmp	rcx, 128
	jae	352f
	xor	esi, esi
	jmp	372f
342:
	add	r8, rax
	mov	r14, r8
	jmp	412f
352:
	mov	qword ptr [rsp + 40], r15
	mov	rsi, rcx
	and	rsi, -128
	lea	r10, [rax + rsi]
	lea	r14, [r8 + rax + 96]
	xor	r15d, r15d
	mov	rdi, qword ptr [rsp + 8]
	.p2align	4
362:
	vmovdqu	ymm0, ymmword ptr [r14 + r15 - 96]
	vmovdqu	ymm2, ymmword ptr [r14 + r15 - 64]
	vmovdqu	ymm6, ymmword ptr [r14 + r15 - 32]
	vmovdqu	ymm7, ymmword ptr [r14 + r15]
	vmovdqu	ymmword ptr [rdi + r15 + 576], ymm0
	vmovdqu	ymmword ptr [rdi + r15 + 608], ymm2
	vmovdqu	ymmword ptr [rdi + r15 + 640], ymm6
	vmovdqu	ymmword ptr [rdi + r15 + 672], ymm7
	sub	r15, -128
	cmp	rsi, r15
	jne	362b
	cmp	rcx, rsi
	mov	rdi, qword ptr [rsp + 32]
	mov	r14, rdi
	mov	r15, qword ptr [rsp + 40]
	je	412f
	test	cl, 112
	je	392f
372:
	mov	r14, rcx
	and	r14, -16
	lea	r10, [rax + r14]
	.p2align	4
382:
	vmovdqu	xmm0, xmmword ptr [r12 + rsi]
	vmovdqu	xmmword ptr [rdi + rsi], xmm0
	add	rsi, 16
	cmp	r14, rsi
	jne	382b
	cmp	rcx, r14
	mov	r14, rdi
	je	412f
392:
	mov	rcx, rdi
	sub	rcx, rax
	.p2align	4
402:
	movzx	eax, byte ptr [r8 + r10]
	mov	byte ptr [rcx + r10], al
	inc	r10
	cmp	rdx, r10
	jne	402b
	mov	r14, rdi
412:
	vmovdqu	ymm0, ymmword ptr [r14]
	vpermq	ymm2, ymm0, 68
	vpermq	ymm0, ymm0, 238
	vpshufb	ymm6, ymm2, ymm12
	vpshufb	ymm7, ymm0, ymm12
	vpbroadcastb	ymm5, byte ptr [rip + 972f]
	vpand	ymm11, ymm12, ymm5
	vpxor	xmm3, xmm3, xmm3
	vpcmpeqb	ymm11, ymm11, ymm3
	vpblendvb	ymm6, ymm7, ymm6, ymm11
	vmovdqu	ymm7, ymmword ptr [r14 + 32]
	vpermq	ymm15, ymm7, 68
	vpermq	ymm7, ymm7, 238
	vpshufb	ymm8, ymm15, ymm12
	vpshufb	ymm10, ymm7, ymm12
	vpblendvb	ymm8, ymm10, ymm8, ymm11
	vpshufb	ymm2, ymm2, ymm14
	vpshufb	ymm0, ymm0, ymm14
	vpand	ymm10, ymm14, ymm5
	vpcmpeqb	ymm10, ymm10, ymm3
	vpblendvb	ymm0, ymm0, ymm2, ymm10
	vpshufb	ymm2, ymm15, ymm14
	vpshufb	ymm7, ymm7, ymm14
	vpblendvb	ymm2, ymm7, ymm2, ymm10
	vpbroadcastb	ymm5, byte ptr [rip + 982f]
	vpand	ymm7, ymm14, ymm5
	vpcmpeqb	ymm7, ymm7, ymm5
	vpblendvb	ymm0, ymm0, ymm2, ymm7
	vpxor	xmm7, xmm7, xmm7
	vpand	ymm2, ymm12, ymm5
	vpcmpeqb	ymm2, ymm2, ymm5
	vpblendvb	ymm2, ymm6, ymm8, ymm2
	vpsrlvd	ymm0, ymm0, ymm9
	vmovdqu	ymm3, ymmword ptr [rsp + 112]
	vpandn	ymm0, ymm3, ymm0
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 240]
	vpsrlvd	ymm2, ymm2, ymm4
	vmovdqu	ymm3, ymmword ptr [rsp + 144]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 176]
	vpor	ymm3, ymm2, ymmword ptr [rip + 992f]
	vpcmpeqd	ymm2, ymm2, ymm7
	vpandn	ymm2, ymm2, ymm3
	vpor	ymm3, ymm0, ymmword ptr [rip + 1002f]
	vpcmpeqd	ymm0, ymm0, ymm7
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
	vpblendd	ymm2, ymm3, ymm7, 192
	vpermq	ymm2, ymm2, 147
	vpmaxud	ymm2, ymm3, ymm2
	vperm2i128	ymm3, ymm2, ymm2, 10
	vpmaxud	ymm3, ymm2, ymm3
	vperm2i128	ymm2, ymm2, ymm0, 33
	vpmaxud	ymm0, ymm0, ymm2
	vpmaxud	ymm0, ymm0, ymm3
	vmovdqu	ymm4, ymmword ptr [rsp + 304]
	vpand	ymm2, ymm0, ymm4
	vpcmpeqd	ymm0, ymm0, ymm7
	vblendvps	ymm0, ymm2, ymm13, ymm0
	vpand	ymm2, ymm3, ymm4
	vpcmpeqd	ymm3, ymm3, ymm7
	vblendvps	ymm2, ymm2, ymm13, ymm3
	vmovdqu	ymm3, ymmword ptr [rsp + 528]
	vextracti128	xmm3, ymm3, 1
	vpsrlw	xmm3, xmm3, 2
	vpand	xmm3, xmm3, xmmword ptr [rip + 1012f]
	vpminub	xmm3, xmm3, xmm5
	vpmovzxbd	ymm4, xmm3
	vpmaxud	ymm2, ymm2, ymm4
	vextracti128	xmm1, ymm1, 1
	vpextrd	eax, xmm1, 3
	mov	rdi, qword ptr [rsp + 8]
	vmovdqu	ymmword ptr [rdi + 448], ymm2
	vpshufd	xmm1, xmm3, 238
	vpmovzxbd	ymm1, xmm1
	vpmaxud	ymm1, ymm0, ymm1
	vmovdqu	ymmword ptr [rdi + 480], ymm1
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm13, ymm0, 170
	add	r15, rax
	.p2align	4
422:
	mov	r12, qword ptr [rsp + 16]
	shr	rbx, 56
	add	rbx, r11
	shr	r13, 56
	add	r13, r9
	vmovd	eax, xmm13
	mov	qword ptr [rdi + 72], r15
	mov	qword ptr [rdi + 96], rax
	mov	qword ptr [rdi + 128], r13
	mov	qword ptr [rdi + 136], rbx
	add	r12, qword ptr [rsp + 216]
	mov	rdx, qword ptr [rsp + 88]
	and	rdx, 124
	je	762f
	xor	r8d, r8d
	mov	r14, qword ptr [rsp + 24]
	mov	r13, qword ptr [rsp + 48]
	mov	qword ptr [rsp + 16], r12
	.p2align	4
432:
	movzx	r10d, byte ptr [r12 + r8]
	movzx	r11d, byte ptr [rdi + r8 + 192]
	cmp	r11, 33
	mov	eax, dword ptr [rdi + 4*r8 + 256]
	vmovups	ymm0, ymmword ptr [r13]
	vmovups	ymmword ptr [r14], ymm0
	jae	562f
442:
	lea	r9, [r14 + r11]
	mov	rcx, r9
	sub	rcx, rax
	cmp	rcx, rbp
	jl	582f
452:
	vmovups	ymm0, ymmword ptr [rcx]
	vmovups	ymmword ptr [r9], ymm0
	cmp	r10b, -124
	mov	qword ptr [rsp + 24], r14
	jae	592f
	shr	r10d, 2
462:
	lea	rax, [r8 + 1]
	lea	rbx, [r13 + r11]
	movzx	r15d, byte ptr [r12 + rax]
	mov	rcx, r13
	movzx	r13d, byte ptr [rdi + rax + 192]
	cmp	r13, 33
	mov	eax, dword ptr [rdi + 4*rax + 256]
	mov	qword ptr [rsp + 48], rcx
	vmovups	ymm0, ymmword ptr [rcx + r11]
	vmovups	ymmword ptr [r9 + r10], ymm0
	jae	612f
472:
	add	r9, r10
	add	r9, r13
	mov	rcx, r9
	sub	rcx, rax
	cmp	rcx, rbp
	jl	632f
	vmovups	ymm0, ymmword ptr [rcx]
	vmovups	ymmword ptr [r9], ymm0
	cmp	r15b, -124
	jae	642f
482:
	shr	r15d, 2
492:
	lea	rcx, [r8 + 2]
	movzx	eax, byte ptr [r12 + rcx]
	movzx	r12d, byte ptr [rdi + rcx + 192]
	cmp	r12, 33
	mov	ecx, dword ptr [rdi + 4*rcx + 256]
	vmovups	ymm0, ymmword ptr [rbx + r13]
	vmovups	ymmword ptr [r9 + r15], ymm0
	jae	662f
502:
	add	r9, r15
	add	r9, r12
	mov	rsi, r9
	sub	rsi, rcx
	cmp	rsi, rbp
	jl	682f
	vmovups	ymm0, ymmword ptr [rsi]
	vmovups	ymmword ptr [r9], ymm0
	cmp	al, -124
	jae	692f
512:
	shr	eax, 2
522:
	lea	rsi, [r8 + 3]
	add	rbx, r13
	mov	rcx, qword ptr [rsp + 16]
	movzx	ebp, byte ptr [rcx + rsi]
	movzx	ecx, byte ptr [rdi + rsi + 192]
	cmp	rcx, 33
	mov	esi, dword ptr [rdi + 4*rsi + 256]
	vmovups	ymm0, ymmword ptr [rbx + r12]
	vmovups	ymmword ptr [r9 + rax], ymm0
	jae	712f
532:
	add	r9, rax
	add	r9, rcx
	mov	r14, r9
	sub	r14, rsi
	cmp	r14, qword ptr [rsp + 56]
	jl	732f
	vmovups	ymm0, ymmword ptr [r14]
	vmovups	ymmword ptr [r9], ymm0
	cmp	bpl, -124
	jae	742f
542:
	shr	ebp, 2
552:
	add	rbx, r12
	add	r9, rbp
	add	rbx, rcx
	add	r8, 4
	cmp	r8, rdx
	mov	r13, rbx
	mov	r14, r9
	mov	rdi, qword ptr [rsp + 8]
	mov	rbp, qword ptr [rsp + 56]
	mov	r12, qword ptr [rsp + 16]
	jb	432b
	jmp	772f
562:
	mov	rcx, qword ptr [rdi + 48]
	mov	rsi, qword ptr [rdi + 120]
	movzx	r11d, byte ptr [rcx + rsi]
	inc	rsi
	mov	qword ptr [rdi + 120], rsi
	add	r11, 33
	mov	ecx, 32
	.p2align	4
572:
	vmovups	ymm0, ymmword ptr [r13 + rcx]
	vmovups	ymmword ptr [r14 + rcx], ymm0
	add	rcx, 32
	cmp	rcx, r11
	jb	572b
	jmp	442b
582:
	mov	rsi, r9
	sub	rsi, rbp
	sub	rsi, rax
	mov	ecx, 0
	cmovae	rcx, rsi
	add	rcx, rbp
	jmp	452b
592:
	mov	rax, qword ptr [rdi + 48]
	mov	rsi, qword ptr [rdi + 120]
	movzx	r10d, byte ptr [rax + rsi]
	inc	rsi
	mov	qword ptr [rdi + 120], rsi
	add	r10, 33
	mov	eax, 32
	.p2align	4
602:
	vmovups	ymm0, ymmword ptr [rcx + rax]
	vmovups	ymmword ptr [r9 + rax], ymm0
	add	rax, 32
	cmp	rax, r10
	jb	602b
	jmp	462b
612:
	mov	rcx, qword ptr [rdi + 48]
	mov	rsi, qword ptr [rdi + 120]
	movzx	r13d, byte ptr [rcx + rsi]
	inc	rsi
	mov	qword ptr [rdi + 120], rsi
	add	r13, 33
	lea	rcx, [r11 + r10]
	add	rcx, qword ptr [rsp + 24]
	mov	esi, 32
	.p2align	4
622:
	vmovups	ymm0, ymmword ptr [rbx + rsi]
	vmovups	ymmword ptr [rcx + rsi], ymm0
	add	rsi, 32
	cmp	rsi, r13
	jb	622b
	jmp	472b
632:
	mov	rsi, r9
	sub	rsi, rbp
	sub	rsi, rax
	mov	ecx, 0
	cmovae	rcx, rsi
	add	rcx, rbp
	vmovups	ymm0, ymmword ptr [rcx]
	vmovups	ymmword ptr [r9], ymm0
	cmp	r15b, -124
	jb	482b
642:
	mov	rax, qword ptr [rdi + 48]
	mov	rsi, qword ptr [rdi + 120]
	movzx	r15d, byte ptr [rax + rsi]
	inc	rsi
	mov	qword ptr [rdi + 120], rsi
	add	r15, 33
	lea	rax, [r11 + r13]
	mov	rsi, qword ptr [rsp + 24]
	add	rsi, r10
	add	rax, rsi
	mov	esi, 32
	.p2align	4
652:
	vmovups	ymm0, ymmword ptr [rcx + rsi]
	vmovups	ymmword ptr [rax + rsi], ymm0
	add	rsi, 32
	cmp	rsi, r15
	jb	652b
	jmp	492b
662:
	mov	rsi, qword ptr [rdi + 48]
	mov	r14, qword ptr [rdi + 120]
	movzx	r12d, byte ptr [rsi + r14]
	inc	r14
	mov	qword ptr [rdi + 120], r14
	add	r12, 33
	lea	rsi, [r11 + r13]
	lea	r14, [r15 + r10]
	add	r14, rsi
	add	r14, qword ptr [rsp + 24]
	add	rsi, qword ptr [rsp + 48]
	mov	ebp, 32
	.p2align	4
672:
	vmovups	ymm0, ymmword ptr [rsi + rbp]
	vmovups	ymmword ptr [r14 + rbp], ymm0
	add	rbp, 32
	cmp	rbp, r12
	jb	672b
	mov	rdi, qword ptr [rsp + 8]
	mov	rbp, qword ptr [rsp + 56]
	jmp	502b
682:
	mov	r14, r9
	sub	r14, rbp
	sub	r14, rcx
	mov	esi, 0
	cmovae	rsi, r14
	mov	rdi, qword ptr [rsp + 8]
	add	rsi, rbp
	vmovups	ymm0, ymmword ptr [rsi]
	vmovups	ymmword ptr [r9], ymm0
	cmp	al, -124
	jb	512b
692:
	mov	rax, qword ptr [rdi + 48]
	mov	rcx, qword ptr [rdi + 120]
	movzx	eax, byte ptr [rax + rcx]
	inc	rcx
	mov	qword ptr [rdi + 120], rcx
	add	rax, 33
	lea	rcx, [r15 + r13]
	add	rcx, r11
	add	rcx, r12
	mov	rdi, qword ptr [rsp + 24]
	add	rcx, rdi
	add	rcx, r10
	mov	r14d, 32
	.p2align	4
702:
	vmovups	ymm0, ymmword ptr [rsi + r14]
	vmovups	ymmword ptr [rcx + r14], ymm0
	add	r14, 32
	cmp	r14, rax
	jb	702b
	mov	rdi, qword ptr [rsp + 8]
	jmp	522b
712:
	mov	rdi, qword ptr [rsp + 8]
	mov	rcx, qword ptr [rdi + 48]
	mov	r14, qword ptr [rdi + 120]
	movzx	ecx, byte ptr [rcx + r14]
	inc	r14
	mov	qword ptr [rdi + 120], r14
	add	rcx, 33
	lea	r14, [rax + r15]
	add	r14, r11
	add	r14, r12
	lea	rdi, [r13 + r10]
	add	rdi, qword ptr [rsp + 24]
	add	rdi, r14
	mov	qword ptr [rsp + 176], rdi
	mov	rdi, qword ptr [rsp + 48]
	add	rdi, r13
	add	rdi, r11
	add	rdi, r12
	mov	qword ptr [rsp + 48], rdi
	mov	r14d, 32
	.p2align	4
722:
	mov	rdi, qword ptr [rsp + 48]
	vmovups	ymm0, ymmword ptr [rdi + r14]
	mov	rdi, qword ptr [rsp + 176]
	vmovups	ymmword ptr [rdi + r14], ymm0
	add	r14, 32
	cmp	r14, rcx
	jb	722b
	jmp	532b
732:
	mov	r14, r9
	mov	rdi, qword ptr [rsp + 56]
	sub	r14, rdi
	sub	r14, rsi
	mov	rsi, r14
	mov	r14d, 0
	cmovae	r14, rsi
	add	r14, rdi
	vmovups	ymm0, ymmword ptr [r14]
	vmovups	ymmword ptr [r9], ymm0
	cmp	bpl, -124
	jb	542b
742:
	mov	rdi, qword ptr [rsp + 8]
	mov	rbp, qword ptr [rdi + 48]
	mov	rsi, qword ptr [rdi + 120]
	movzx	ebp, byte ptr [rbp + rsi]
	inc	rsi
	mov	qword ptr [rdi + 120], rsi
	add	rbp, 33
	add	r11, rcx
	add	rax, r12
	add	rax, r11
	add	r15, r13
	add	r15, r10
	add	r15, rax
	mov	rsi, qword ptr [rsp + 24]
	add	rsi, r15
	mov	eax, 32
	.p2align	4
752:
	vmovups	ymm0, ymmword ptr [r14 + rax]
	vmovups	ymmword ptr [rsi + rax], ymm0
	add	rax, 32
	cmp	rax, rbp
	jb	752b
	jmp	552b
	.p2align	4
762:
	mov	r9, qword ptr [rsp + 24]
	mov	rbx, qword ptr [rsp + 48]
772:
	mov	rax, qword ptr [rsp + 88]
	cmp	rdx, rax
	mov	r11, r9
	mov	r15, rbx
	mov	rbx, rax
	mov	r14, qword ptr [rsp + 80]
	je	2b
	.p2align	4
782:
	movzx	ecx, byte ptr [r12 + rdx]
	movzx	eax, byte ptr [rdi + rdx + 192]
	cmp	rax, 33
	mov	esi, dword ptr [rdi + 4*rdx + 256]
	vmovups	ymm0, ymmword ptr [r15]
	vmovups	ymmword ptr [r11], ymm0
	jae	822f
792:
	add	r11, rax
	mov	r8, r11
	sub	r8, rsi
	cmp	r8, rbp
	jl	842f
	vmovups	ymm0, ymmword ptr [r8]
	vmovups	ymmword ptr [r11], ymm0
	cmp	cl, -124
	jae	852f
802:
	shr	ecx, 2
812:
	add	r11, rcx
	add	r15, rax
	inc	rdx
	cmp	rdx, rbx
	jb	782b
	jmp	2b
822:
	mov	rax, qword ptr [rdi + 48]
	mov	r8, qword ptr [rdi + 120]
	movzx	eax, byte ptr [rax + r8]
	inc	r8
	mov	qword ptr [rdi + 120], r8
	add	rax, 33
	mov	r8d, 32
	.p2align	4
832:
	vmovups	ymm0, ymmword ptr [r15 + r8]
	vmovups	ymmword ptr [r11 + r8], ymm0
	add	r8, 32
	cmp	r8, rax
	jb	832b
	jmp	792b
842:
	mov	r9, r11
	sub	r9, rbp
	sub	r9, rsi
	mov	r8d, 0
	cmovae	r8, r9
	add	r8, rbp
	vmovups	ymm0, ymmword ptr [r8]
	vmovups	ymmword ptr [r11], ymm0
	cmp	cl, -124
	jb	802b
852:
	mov	rcx, qword ptr [rdi + 48]
	mov	rsi, qword ptr [rdi + 120]
	movzx	ecx, byte ptr [rcx + rsi]
	inc	rsi
	mov	qword ptr [rdi + 120], rsi
	add	rcx, 33
	mov	esi, 32
	.p2align	4
862:
	vmovups	ymm0, ymmword ptr [r8 + rsi]
	vmovups	ymmword ptr [r11 + rsi], ymm0
	add	rsi, 32
	cmp	rsi, rcx
	jb	862b
	jmp	812b
872:
	sub	r11, rbp
	sub	r15, qword ptr [rsp + 208]
	mov	qword ptr [rdi + 80], r11
	mov	qword ptr [rdi + 88], r15
	add	rsp, 600
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	vzeroupper
	ret
	.p2align	2, 0x0
882:
	.long	1
	.p2align	2, 0x0
892:
	.long	7
	.p2align	2, 0x0
902:
	.long	8
	.p2align	2, 0x0
912:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	2, 0x0
922:
	.long	134217727
	.p2align	5, 0x0
932:
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
942:
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
952:
	.byte	1
	.p2align	4, 0x0
962:
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
972:
	.byte	16
	.p2align	4, 0x0
982:
	.byte	32
	.p2align	5, 0x0
992:
	.long	1207959552
	.long	1342177280
	.long	1476395008
	.long	1610612736
	.long	1744830464
	.long	1879048192
	.long	2013265920
	.long	2147483648
	.p2align	5, 0x0
1002:
	.long	134217728
	.long	268435456
	.long	402653184
	.long	536870912
	.long	671088640
	.long	805306368
	.long	939524096
	.long	1073741824
	.p2align	4, 0x0
1012:
	.zero	16,63

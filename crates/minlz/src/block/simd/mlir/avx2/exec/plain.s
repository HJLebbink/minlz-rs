# minlz_exec_plain of crates/minlz/mlir/exec64.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 536
	mov	r9, qword ptr [rdi]
	mov	rax, qword ptr [rdi + 8]
	mov	rcx, qword ptr [rdi + 64]
	mov	r11, qword ptr [rdi + 80]
	add	r11, r9
	mov	qword ptr [rsp + 8], rdi
	mov	r14, qword ptr [rdi + 88]
	mov	qword ptr [rsp + 240], rax
	add	r14, rax
	test	rcx, rcx
	jle	972f
	mov	rdx, qword ptr [rsp + 8]
	mov	rax, qword ptr [rdx + 16]
	mov	qword ptr [rsp + 248], rax
	lea	rbx, [rdx + 512]
	lea	rax, [rdx + 576]
	mov	edx, 96
	mov	qword ptr [rsp + 144], rdx
	mov	edx, 7
	mov	qword ptr [rsp + 72], rdx
	mov	qword ptr [rsp + 160], 0
	vpxor	xmm13, xmm13, xmm13
	vbroadcastss	ymm0, dword ptr [rip + 982f]
	vmovups	ymmword ptr [rsp + 432], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 992f]
	vmovups	ymmword ptr [rsp + 400], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 1002f]
	vmovups	ymmword ptr [rsp + 368], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 1012f]
	vmovups	ymmword ptr [rsp + 336], ymm0
	vpbroadcastd	ymm0, dword ptr [rip + 1022f]
	vmovdqu	ymmword ptr [rsp + 304], ymm0
	mov	rdx, rbx
	xor	esi, esi
	mov	qword ptr [rsp + 152], rbx
	mov	qword ptr [rsp + 40], r9
	mov	qword ptr [rsp + 256], rcx
	mov	qword ptr [rsp + 16], rax
	jmp	12f
	.p2align	4
2:
	inc	qword ptr [rsp + 160]
	add	qword ptr [rsp + 144], 64
	add	qword ptr [rsp + 72], -64
	mov	rdx, qword ptr [rsp + 168]
	add	rdx, -64
	mov	rcx, qword ptr [rsp + 256]
	mov	rsi, qword ptr [rsp + 264]
	cmp	rsi, rcx
	jge	972f
12:
	mov	qword ptr [rsp + 48], r14
	mov	qword ptr [rsp + 168], rdx
	mov	qword ptr [rsp + 32], r11
	mov	rdi, rsi
	sub	rcx, rsi
	cmp	rcx, 64
	mov	eax, 64
	mov	qword ptr [rsp + 112], rcx
	cmovb	rax, rcx
	mov	qword ptr [rsp + 64], rax
	mov	rsi, qword ptr [rsp + 8]
	mov	rcx, qword ptr [rsi + 16]
	mov	r14, qword ptr [rsi + 24]
	mov	r11, qword ptr [rsi + 32]
	mov	r8, qword ptr [rsi + 40]
	mov	r15, qword ptr [rsi + 64]
	mov	rax, qword ptr [rsi + 72]
	mov	qword ptr [rsp + 24], rax
	mov	r10, qword ptr [rsi + 96]
	mov	rdx, qword ptr [rsi + 112]
	mov	rax, qword ptr [rsi + 128]
	mov	r12, qword ptr [rsi + 136]
	lea	r9, [r15 + 7]
	lea	rsi, [rdi + 64]
	mov	qword ptr [rsp + 264], rsi
	cmp	rsi, r9
	mov	qword ptr [rsp + 56], rdi
	mov	qword ptr [rsp + 80], r10
	mov	qword ptr [rsp + 176], r12
	jbe	22f
	cmp	rdi, r9
	mov	rsi, rbx
	jge	92f
	mov	rsi, qword ptr [rsp + 160]
	shl	rsi, 6
	mov	edi, 7
	sub	rdi, rsi
	add	rdi, r15
	cmp	rdi, 16
	mov	r10, qword ptr [rsp + 56]
	jb	72f
	add	rsi, rcx
	mov	r10, qword ptr [rsp + 8]
	sub	r10, rsi
	add	r10, 511
	cmp	r10, 127
	mov	r10, qword ptr [rsp + 56]
	jb	72f
	cmp	rdi, 128
	jae	32f
	xor	r12d, r12d
	jmp	52f
	.p2align	4
22:
	add	rcx, rdi
	mov	rsi, rcx
	jmp	92f
32:
	mov	r12, rdi
	and	r12, -128
	mov	rsi, qword ptr [rsp + 56]
	lea	r10, [rsi + r12]
	mov	rsi, qword ptr [rsp + 144]
	lea	r13, [rcx + rsi]
	mov	rbp, qword ptr [rsp + 8]
	mov	rsi, qword ptr [rsp + 72]
	lea	rbx, [r15 + rsi]
	and	rbx, -128
	xor	esi, esi
	.p2align	4
42:
	vmovdqu	ymm0, ymmword ptr [r13 + rsi - 96]
	vmovdqu	ymm1, ymmword ptr [r13 + rsi - 64]
	vmovups	ymm3, ymmword ptr [r13 + rsi - 32]
	vmovups	ymm4, ymmword ptr [r13 + rsi]
	vmovdqu	ymmword ptr [rbp + rsi + 512], ymm0
	vmovdqu	ymmword ptr [rbp + rsi + 544], ymm1
	vmovups	ymmword ptr [rbp + rsi + 576], ymm3
	vmovups	ymmword ptr [rbp + rsi + 608], ymm4
	sub	rsi, -128
	cmp	rbx, rsi
	jne	42b
	cmp	rdi, r12
	mov	rbx, qword ptr [rsp + 152]
	mov	rsi, rbx
	je	92f
	test	dil, 112
	je	72f
52:
	mov	r13, rdi
	and	r13, -16
	mov	rsi, qword ptr [rsp + 56]
	lea	r10, [rsi + r13]
	add	rsi, rcx
	add	r15, qword ptr [rsp + 72]
	and	r15, -16
	.p2align	4
62:
	vmovdqu	xmm0, xmmword ptr [rsi + r12]
	vmovdqu	xmmword ptr [rbx + r12], xmm0
	add	r12, 16
	cmp	r15, r12
	jne	62b
	cmp	rdi, r13
	mov	rsi, rbx
	je	92f
	.p2align	4
72:
	mov	rdi, qword ptr [rsp + 168]
	.p2align	4
82:
	movzx	esi, byte ptr [rcx + r10]
	mov	byte ptr [rdi + r10], sil
	inc	r10
	cmp	r9, r10
	jne	82b
	mov	rsi, rbx
92:
	vmovdqu	ymm3, ymmword ptr [rsi]
	vmovdqu	ymm4, ymmword ptr [rsi + 32]
	vmovd	xmm0, dword ptr [rsp + 64]
	vpbroadcastb	ymm1, xmm0
	vpmaxub	ymm0, ymm1, ymmword ptr [rip + 1032f]
	vpcmpeqb	ymm0, ymm1, ymm0
	vpmaxub	ymm5, ymm1, ymmword ptr [rip + 1042f]
	vpcmpeqb	ymm1, ymm1, ymm5
	vpsllw	ymm5, ymm3, 6
	vpcmpgtb	ymm8, ymm13, ymm5
	vpsllw	ymm5, ymm4, 6
	vpcmpgtb	ymm9, ymm13, ymm5
	vpbroadcastb	ymm2, byte ptr [rip + 1052f]
	vpand	ymm3, ymm3, ymm2
	vpand	ymm4, ymm4, ymm2
	vpcmpeqb	ymm5, ymm13, ymm4
	vpcmpeqb	ymm3, ymm13, ymm3
	movabs	rbx, 72340172838076673
	mov	rcx, rbx
	#APP
	#NO_APP
	vpand	ymm4, ymm8, ymm2
	vpand	ymm8, ymm0, ymm4
	vpand	ymm4, ymm9, ymm2
	vpand	ymm4, ymm1, ymm4
	mov	r15, qword ptr [rsp + 8]
	vmovdqu	ymmword ptr [r15 + 544], ymm4
	vmovdqu	ymmword ptr [r15 + 512], ymm8
	vmovq	rsi, xmm8
	mov	rdi, rsi
	imul	rdi, rcx
	mov	r9, rdi
	sub	r9, rsi
	xor	rsi, rcx
	shl	rsi, 7
	or	rsi, r9
	vmovq	xmm9, qword ptr [r14 + rax]
	vmovq	xmm10, rsi
	vpshufb	xmm9, xmm9, xmm10
	shr	rdi, 56
	add	rdi, rax
	vmovq	qword ptr [r15 + 512], xmm9
	vpextrq	rsi, xmm8, 1
	mov	rax, rsi
	imul	rax, rcx
	mov	r9, rax
	sub	r9, rsi
	xor	rsi, rcx
	shl	rsi, 7
	or	rsi, r9
	vmovq	xmm9, qword ptr [r14 + rdi]
	vmovq	xmm10, rsi
	vpshufb	xmm9, xmm9, xmm10
	shr	rax, 56
	add	rax, rdi
	vmovq	qword ptr [r15 + 520], xmm9
	vextracti128	xmm8, ymm8, 1
	vmovq	rsi, xmm8
	mov	rdi, rsi
	imul	rdi, rcx
	mov	r9, rdi
	sub	r9, rsi
	xor	rsi, rcx
	shl	rsi, 7
	or	rsi, r9
	vmovq	xmm9, qword ptr [r14 + rax]
	vmovq	xmm10, rsi
	vpshufb	xmm9, xmm9, xmm10
	shr	rdi, 56
	add	rdi, rax
	vmovq	qword ptr [r15 + 528], xmm9
	vpextrq	rsi, xmm8, 1
	mov	rax, rsi
	imul	rax, rcx
	mov	r9, rax
	sub	r9, rsi
	xor	rsi, rcx
	shl	rsi, 7
	or	rsi, r9
	vmovq	xmm8, qword ptr [r14 + rdi]
	vmovq	xmm9, rsi
	vpshufb	xmm8, xmm8, xmm9
	shr	rax, 56
	add	rax, rdi
	vmovq	qword ptr [r15 + 536], xmm8
	vmovq	rsi, xmm4
	mov	rdi, rsi
	imul	rdi, rcx
	mov	r9, rdi
	sub	r9, rsi
	xor	rsi, rcx
	shl	rsi, 7
	or	rsi, r9
	vmovq	xmm8, qword ptr [r14 + rax]
	vmovq	xmm9, rsi
	vpshufb	xmm8, xmm8, xmm9
	shr	rdi, 56
	add	rdi, rax
	vmovq	qword ptr [r15 + 544], xmm8
	vpextrq	rsi, xmm4, 1
	mov	rax, rsi
	imul	rax, rcx
	mov	r9, rax
	sub	r9, rsi
	xor	rsi, rcx
	shl	rsi, 7
	or	rsi, r9
	vmovq	xmm4, qword ptr [r14 + rdi]
	vmovq	xmm8, rsi
	vpshufb	xmm4, xmm4, xmm8
	shr	rax, 56
	add	rax, rdi
	vmovq	qword ptr [r15 + 552], xmm4
	mov	rsi, qword ptr [r15 + 560]
	mov	rdi, qword ptr [r15 + 568]
	mov	r9, rsi
	imul	r9, rcx
	mov	r10, r9
	sub	r10, rsi
	xor	rsi, rcx
	shl	rsi, 7
	or	rsi, r10
	vmovq	xmm4, qword ptr [r14 + rax]
	vmovq	xmm8, rsi
	vpshufb	xmm4, xmm4, xmm8
	shr	r9, 56
	add	r9, rax
	vmovq	qword ptr [r15 + 560], xmm4
	mov	r13, rdi
	imul	r13, rcx
	mov	rax, r13
	sub	rax, rdi
	xor	rcx, rdi
	shl	rcx, 7
	or	rcx, rax
	vmovq	xmm4, qword ptr [r14 + r9]
	vmovq	xmm8, rcx
	vpshufb	xmm4, xmm4, xmm8
	vmovq	qword ptr [r15 + 568], xmm4
	vmovups	ymm4, ymmword ptr [r15 + 544]
	vmovups	ymm8, ymmword ptr [r15 + 512]
	vmovups	ymmword ptr [r15 + 192], ymm8
	vmovups	ymmword ptr [r15 + 224], ymm4
	mov	rax, rbx
	#APP
	#NO_APP
	vpand	ymm4, ymm5, ymm2
	vpand	ymm1, ymm1, ymm4
	vpand	ymm3, ymm3, ymm2
	vpand	ymm0, ymm0, ymm3
	vmovdqu	ymmword ptr [r15 + 512], ymm0
	vmovdqu	ymmword ptr [r15 + 544], ymm1
	vmovq	rcx, xmm0
	mov	rdi, rax
	imul	rdi, rcx
	mov	rsi, rdi
	sub	rsi, rcx
	xor	rcx, rax
	shl	rcx, 7
	or	rcx, rsi
	mov	rsi, qword ptr [rsp + 176]
	vmovq	xmm3, qword ptr [r11 + rsi]
	vmovq	xmm4, rcx
	vpshufb	xmm3, xmm3, xmm4
	shr	rdi, 56
	add	rdi, rsi
	vmovq	qword ptr [r15 + 512], xmm3
	vpextrq	rsi, xmm0, 1
	mov	rcx, rax
	imul	rcx, rsi
	mov	r10, rcx
	sub	r10, rsi
	xor	rsi, rax
	shl	rsi, 7
	or	rsi, r10
	vmovq	xmm3, qword ptr [r11 + rdi]
	vmovq	xmm4, rsi
	vpshufb	xmm3, xmm3, xmm4
	shr	rcx, 56
	add	rcx, rdi
	vmovq	qword ptr [r15 + 520], xmm3
	vextracti128	xmm0, ymm0, 1
	vmovq	rsi, xmm0
	mov	rdi, rax
	imul	rdi, rsi
	mov	r10, rdi
	sub	r10, rsi
	xor	rsi, rax
	shl	rsi, 7
	or	rsi, r10
	vmovq	xmm3, qword ptr [r11 + rcx]
	vmovq	xmm4, rsi
	vpshufb	xmm3, xmm3, xmm4
	shr	rdi, 56
	add	rdi, rcx
	vmovq	qword ptr [r15 + 528], xmm3
	vpextrq	rsi, xmm0, 1
	mov	rcx, rax
	imul	rcx, rsi
	mov	r10, rcx
	sub	r10, rsi
	xor	rsi, rax
	shl	rsi, 7
	or	rsi, r10
	vmovq	xmm0, qword ptr [r11 + rdi]
	vmovq	xmm3, rsi
	vpshufb	xmm0, xmm0, xmm3
	shr	rcx, 56
	add	rcx, rdi
	vmovq	qword ptr [r15 + 536], xmm0
	vmovq	rsi, xmm1
	mov	rdi, rax
	imul	rdi, rsi
	mov	r10, rdi
	sub	r10, rsi
	xor	rsi, rax
	shl	rsi, 7
	or	rsi, r10
	vmovq	xmm0, qword ptr [r11 + rcx]
	vmovq	xmm3, rsi
	vpshufb	xmm0, xmm0, xmm3
	shr	rdi, 56
	add	rdi, rcx
	vmovq	qword ptr [r15 + 544], xmm0
	vpextrq	rsi, xmm1, 1
	mov	rcx, rax
	imul	rcx, rsi
	mov	r10, rcx
	sub	r10, rsi
	xor	rsi, rax
	shl	rsi, 7
	or	rsi, r10
	vmovq	xmm0, qword ptr [r11 + rdi]
	vmovq	xmm1, rsi
	vpshufb	xmm0, xmm0, xmm1
	shr	rcx, 56
	add	rcx, rdi
	vmovq	qword ptr [r15 + 552], xmm0
	mov	rsi, qword ptr [r15 + 560]
	mov	rdi, qword ptr [r15 + 568]
	mov	rbx, rsi
	imul	rbx, rax
	mov	r10, rbx
	sub	r10, rsi
	xor	rsi, rax
	shl	rsi, 7
	or	rsi, r10
	vmovq	xmm0, qword ptr [r11 + rcx]
	vmovq	xmm1, rsi
	vpshufb	xmm0, xmm0, xmm1
	shr	rbx, 56
	add	rbx, rcx
	vmovq	qword ptr [r15 + 560], xmm0
	mov	r14, rdi
	imul	r14, rax
	mov	rcx, r14
	sub	rcx, rdi
	xor	rax, rdi
	shl	rax, 7
	or	rax, rcx
	vmovq	xmm0, qword ptr [r11 + rbx]
	vmovq	xmm1, rax
	vpshufb	xmm0, xmm0, xmm1
	vmovq	qword ptr [r15 + 568], xmm0
	vmovdqu	ymm7, ymmword ptr [r15 + 512]
	vmovups	ymm0, ymmword ptr [r15 + 544]
	vmovups	ymmword ptr [rsp + 464], ymm0
	vmovss	xmm0, dword ptr [rsp + 80]
	vbroadcastss	ymm0, xmm0
	vmovups	ymmword ptr [rsp + 80], ymm0
	vpmovzxbd	ymm3, qword ptr [r15 + 520]
	vpmovzxbd	ymm8, qword ptr [r15 + 512]
	vpsrld	ymm5, ymm8, 3
	vpsrld	ymm4, ymm3, 3
	vmovdqu	ymm1, ymmword ptr [rsp + 432]
	vpmaxud	ymm4, ymm4, ymm1
	vpcmpeqd	ymm2, ymm2, ymm2
	vpaddd	ymm4, ymm4, ymm2
	vpmaxud	ymm5, ymm5, ymm1
	vpaddd	ymm5, ymm5, ymm2
	vmovdqu	ymm1, ymmword ptr [rsp + 400]
	vpand	ymm9, ymm8, ymm1
	vpand	ymm10, ymm3, ymm1
	vmovdqu	ymm6, ymmword ptr [rsp + 368]
	vpminud	ymm3, ymm3, ymm6
	vpminud	ymm8, ymm8, ymm6
	vpand	ymm8, ymm8, ymm6
	vpor	ymm8, ymm8, ymm9
	vpand	ymm3, ymm3, ymm6
	vpor	ymm3, ymm10, ymm3
	vpsllvd	ymm0, ymm8, ymm5
	vpsllvd	ymm3, ymm3, ymm4
	vpsllvd	ymm6, ymm2, ymm5
	vpsllvd	ymm2, ymm2, ymm4
	vperm2i128	ymm9, ymm5, ymm4, 33
	vpalignr	ymm9, ymm4, ymm9, 12
	vperm2i128	ymm11, ymm5, ymm5, 10
	vpalignr	ymm11, ymm5, ymm11, 12
	vpaddd	ymm11, ymm11, ymm5
	vpaddd	ymm9, ymm9, ymm4
	vpblendd	ymm12, ymm11, ymm13, 192
	vpermq	ymm12, ymm12, 147
	vpaddd	ymm12, ymm12, ymm11
	vpblendd	ymm11, ymm9, ymm11, 192
	vpermq	ymm11, ymm11, 147
	vpaddd	ymm9, ymm11, ymm9
	vperm2i128	ymm11, ymm12, ymm12, 10
	vpaddd	ymm11, ymm11, ymm12
	vperm2i128	ymm12, ymm12, ymm9, 33
	vpaddd	ymm9, ymm12, ymm9
	vpaddd	ymm12, ymm11, ymm9
	vpsubd	ymm4, ymm12, ymm4
	vpsubd	ymm5, ymm11, ymm5
	mov	r15, qword ptr [rsp + 24]
	mov	eax, r15d
	and	eax, 7
	vmovd	xmm9, eax
	vpbroadcastd	ymm9, xmm9
	vpaddd	ymm4, ymm9, ymm4
	vpaddd	ymm9, ymm9, ymm5
	vpsrld	ymm14, ymm4, 3
	vpsrld	ymm15, ymm9, 3
	vpand	ymm11, ymm4, ymm1
	vpand	ymm5, ymm9, ymm1
	vbroadcasti128	ymm1, xmmword ptr [rip + 1062f]
	vpshufb	ymm4, ymm14, ymm1
	vpshufb	ymm9, ymm15, ymm1
	vmovdqu	ymm1, ymmword ptr [rsp + 336]
	vpaddb	ymm4, ymm4, ymm1
	vpaddb	ymm9, ymm9, ymm1
	mov	rax, r15
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, rdx
	vmovdqu	ymmword ptr [rsp + 496], ymm7
	vmovdqu	ymmword ptr [rsp + 176], ymm3
	vmovdqu	ymmword ptr [rsp + 208], ymm2
	vmovdqu	ymmword ptr [rsp + 272], ymm11
	vmovdqa	ymm11, ymm6
	jbe	102f
	mov	rcx, rdx
	sub	rcx, rax
	mov	rsi, qword ptr [rsp + 16]
	mov	r12, qword ptr [rsp + 56]
	jbe	172f
	cmp	rcx, 16
	mov	rdi, rax
	jb	152f
	lea	r10, [rax + r8]
	mov	rsi, qword ptr [rsp + 8]
	sub	rsi, r10
	add	rsi, 575
	cmp	rsi, 127
	mov	rdi, rax
	jb	152f
	cmp	rcx, 128
	jae	112f
	xor	r11d, r11d
	jmp	132f
	.p2align	4
102:
	add	rax, r8
	mov	rsi, rax
	mov	r12, qword ptr [rsp + 56]
	jmp	172f
112:
	mov	r11, rcx
	and	r11, -128
	lea	rdi, [rax + r11]
	lea	r15, [r8 + rax + 96]
	xor	esi, esi
	.p2align	4
122:
	vmovdqu	ymm14, ymmword ptr [r15 + rsi - 96]
	vmovdqu	ymm15, ymmword ptr [r15 + rsi - 64]
	vmovdqu	ymm6, ymmword ptr [r15 + rsi - 32]
	vmovdqu	ymm7, ymmword ptr [r15 + rsi]
	mov	rbp, qword ptr [rsp + 8]
	vmovdqu	ymmword ptr [rbp + rsi + 576], ymm14
	vmovdqu	ymmword ptr [rbp + rsi + 608], ymm15
	vmovdqu	ymmword ptr [rbp + rsi + 640], ymm6
	vmovdqu	ymmword ptr [rbp + rsi + 672], ymm7
	sub	rsi, -128
	cmp	r11, rsi
	jne	122b
	cmp	rcx, r11
	mov	rsi, qword ptr [rsp + 16]
	mov	r15, qword ptr [rsp + 24]
	je	172f
	test	cl, 112
	je	152f
132:
	mov	rsi, rcx
	and	rsi, -16
	lea	rdi, [rax + rsi]
	mov	r15, qword ptr [rsp + 16]
	.p2align	4
142:
	vmovdqu	xmm6, xmmword ptr [r10 + r11]
	vmovdqu	xmmword ptr [r15 + r11], xmm6
	add	r11, 16
	cmp	rsi, r11
	jne	142b
	cmp	rcx, rsi
	mov	rsi, r15
	mov	r15, qword ptr [rsp + 24]
	je	172f
	.p2align	4
152:
	mov	rsi, qword ptr [rsp + 16]
	mov	rcx, rsi
	sub	rcx, rax
	.p2align	4
162:
	movzx	eax, byte ptr [r8 + rdi]
	mov	byte ptr [rcx + rdi], al
	inc	rdi
	cmp	rdx, rdi
	jne	162b
172:
	vmovdqu	ymm6, ymmword ptr [rsi]
	vmovdqu	ymm7, ymmword ptr [rsi + 32]
	vpermq	ymm14, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm15, ymm14, ymm4
	vpshufb	ymm2, ymm6, ymm4
	vpbroadcastb	ymm3, byte ptr [rip + 1072f]
	vpand	ymm1, ymm4, ymm3
	vpcmpeqb	ymm1, ymm13, ymm1
	vpblendvb	ymm2, ymm2, ymm15, ymm1
	vpermq	ymm15, ymm7, 68
	vpermq	ymm7, ymm7, 238
	vpxor	xmm10, xmm10, xmm10
	vpshufb	ymm13, ymm15, ymm4
	vpshufb	ymm8, ymm7, ymm4
	vpblendvb	ymm1, ymm8, ymm13, ymm1
	vpshufb	ymm8, ymm14, ymm9
	vpshufb	ymm6, ymm6, ymm9
	vpand	ymm13, ymm9, ymm3
	vpcmpeqb	ymm13, ymm13, ymm10
	vpblendvb	ymm6, ymm6, ymm8, ymm13
	vpshufb	ymm8, ymm15, ymm9
	vpshufb	ymm7, ymm7, ymm9
	vpblendvb	ymm7, ymm7, ymm8, ymm13
	vpxor	xmm13, xmm13, xmm13
	vpbroadcastb	ymm3, byte ptr [rip + 1082f]
	vpand	ymm8, ymm9, ymm3
	vpcmpeqb	ymm8, ymm8, ymm3
	vpblendvb	ymm6, ymm6, ymm7, ymm8
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm1, ymm2, ymm1, ymm4
	vpsrlvd	ymm2, ymm6, ymm5
	vpandn	ymm2, ymm11, ymm2
	vpaddd	ymm2, ymm2, ymm0
	vpsrlvd	ymm1, ymm1, ymmword ptr [rsp + 272]
	vmovdqu	ymm0, ymmword ptr [rsp + 208]
	vpandn	ymm1, ymm0, ymm1
	vpaddd	ymm1, ymm1, ymmword ptr [rsp + 176]
	vpor	ymm3, ymm1, ymmword ptr [rip + 1092f]
	vpcmpeqd	ymm1, ymm13, ymm1
	vpandn	ymm1, ymm1, ymm3
	vpor	ymm3, ymm2, ymmword ptr [rip + 1102f]
	vpcmpeqd	ymm2, ymm13, ymm2
	vpandn	ymm2, ymm2, ymm3
	vperm2i128	ymm3, ymm2, ymm2, 10
	vpalignr	ymm3, ymm2, ymm3, 12
	vpmaxud	ymm3, ymm2, ymm3
	vperm2i128	ymm2, ymm2, ymm1, 33
	vpalignr	ymm2, ymm1, ymm2, 12
	vpmaxud	ymm1, ymm1, ymm2
	vpblendd	ymm2, ymm1, ymm3, 192
	vpermq	ymm2, ymm2, 147
	vpmaxud	ymm1, ymm1, ymm2
	vpblendd	ymm2, ymm3, ymm13, 192
	vpermq	ymm2, ymm2, 147
	vpmaxud	ymm2, ymm3, ymm2
	vperm2i128	ymm3, ymm2, ymm2, 10
	vpmaxud	ymm3, ymm2, ymm3
	vperm2i128	ymm2, ymm2, ymm1, 33
	vpmaxud	ymm1, ymm1, ymm2
	vpmaxud	ymm1, ymm1, ymm3
	vmovdqu	ymm4, ymmword ptr [rsp + 304]
	vpand	ymm2, ymm1, ymm4
	vpcmpeqd	ymm1, ymm13, ymm1
	vmovups	ymm0, ymmword ptr [rsp + 80]
	vblendvps	ymm1, ymm2, ymm0, ymm1
	vpand	ymm2, ymm3, ymm4
	vpcmpeqd	ymm3, ymm13, ymm3
	vblendvps	ymm0, ymm2, ymm0, ymm3
	vextracti128	xmm2, ymm12, 1
	vpextrd	eax, xmm2, 3
	mov	rcx, qword ptr [rsp + 8]
	vmovups	ymmword ptr [rcx + 256], ymm0
	vmovups	ymmword ptr [rcx + 288], ymm1
	vshufps	ymm0, ymm1, ymm1, 255
	vpermpd	ymm0, ymm0, 170
	add	r15, rax
	cmp	qword ptr [rsp + 112], 17
	jb	422f
	vmovups	ymmword ptr [rsp + 80], ymm0
	vmovdqu	ymm1, ymmword ptr [rsp + 496]
	vextracti128	xmm1, ymm1, 1
	vpshufd	xmm2, xmm1, 238
	vpmovzxbd	ymm2, xmm2
	vpmovzxbd	ymm1, xmm1
	vpsrld	ymm3, ymm1, 3
	vpsrld	ymm4, ymm2, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 432]
	vpmaxud	ymm4, ymm4, ymm5
	vpcmpeqd	ymm7, ymm7, ymm7
	vpaddd	ymm4, ymm4, ymm7
	vpmaxud	ymm3, ymm3, ymm5
	vpaddd	ymm5, ymm3, ymm7
	vmovdqu	ymm8, ymmword ptr [rsp + 400]
	vpand	ymm3, ymm8, ymm1
	vpand	ymm6, ymm8, ymm2
	vmovdqu	ymm9, ymmword ptr [rsp + 368]
	vpminud	ymm2, ymm2, ymm9
	vpminud	ymm1, ymm1, ymm9
	vpand	ymm1, ymm9, ymm1
	vpor	ymm1, ymm1, ymm3
	vpand	ymm2, ymm9, ymm2
	vpor	ymm2, ymm2, ymm6
	vpsllvd	ymm11, ymm1, ymm5
	vpsllvd	ymm3, ymm2, ymm4
	vpsllvd	ymm10, ymm7, ymm5
	vpsllvd	ymm0, ymm7, ymm4
	vperm2i128	ymm1, ymm5, ymm4, 33
	vpalignr	ymm1, ymm4, ymm1, 12
	vperm2i128	ymm2, ymm5, ymm5, 10
	vpalignr	ymm2, ymm5, ymm2, 12
	vpaddd	ymm2, ymm2, ymm5
	vpaddd	ymm1, ymm1, ymm4
	vpblendd	ymm6, ymm2, ymm13, 192
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
	mov	eax, r15d
	and	eax, 7
	vmovd	xmm5, eax
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm4, ymm5, ymm4
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm6, ymm4, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm5, ymm8, ymm4
	vpand	ymm8, ymm8, ymm2
	vbroadcasti128	ymm4, xmmword ptr [rip + 1062f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm6, ymm7, ymm4
	vmovdqu	ymm7, ymmword ptr [rsp + 336]
	vpaddb	ymm4, ymm2, ymm7
	vpaddb	ymm9, ymm6, ymm7
	mov	rax, r15
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, rdx
	vmovdqu	ymmword ptr [rsp + 176], ymm3
	vmovdqu	ymmword ptr [rsp + 208], ymm5
	vmovdqu	ymmword ptr [rsp + 272], ymm8
	vmovdqa	ymm5, ymm10
	jbe	182f
	mov	rcx, rdx
	sub	rcx, rax
	mov	rsi, qword ptr [rsp + 16]
	jbe	252f
	cmp	rcx, 16
	mov	rdi, rax
	jb	232f
	lea	r10, [rax + r8]
	mov	rsi, qword ptr [rsp + 8]
	sub	rsi, r10
	add	rsi, 575
	cmp	rsi, 127
	mov	rdi, rax
	jb	232f
	cmp	rcx, 128
	mov	qword ptr [rsp + 24], r15
	jae	192f
	xor	r11d, r11d
	jmp	212f
	.p2align	4
182:
	add	rax, r8
	mov	rsi, rax
	jmp	252f
192:
	mov	r11, rcx
	and	r11, -128
	lea	rdi, [rax + r11]
	lea	r15, [r8 + rax + 96]
	xor	esi, esi
	.p2align	4
202:
	vmovdqu	ymm2, ymmword ptr [r15 + rsi - 96]
	vmovdqu	ymm6, ymmword ptr [r15 + rsi - 64]
	vmovdqu	ymm7, ymmword ptr [r15 + rsi - 32]
	vmovdqu	ymm13, ymmword ptr [r15 + rsi]
	mov	rbp, qword ptr [rsp + 8]
	vmovdqu	ymmword ptr [rbp + rsi + 576], ymm2
	vmovdqu	ymmword ptr [rbp + rsi + 608], ymm6
	vmovdqu	ymmword ptr [rbp + rsi + 640], ymm7
	vmovdqu	ymmword ptr [rbp + rsi + 672], ymm13
	sub	rsi, -128
	cmp	r11, rsi
	jne	202b
	cmp	rcx, r11
	mov	rsi, qword ptr [rsp + 16]
	mov	r15, qword ptr [rsp + 24]
	je	252f
	test	cl, 112
	je	232f
212:
	mov	rsi, rcx
	and	rsi, -16
	lea	rdi, [rax + rsi]
	mov	r15, qword ptr [rsp + 16]
	.p2align	4
222:
	vmovdqu	xmm2, xmmword ptr [r10 + r11]
	vmovdqu	xmmword ptr [r15 + r11], xmm2
	add	r11, 16
	cmp	rsi, r11
	jne	222b
	cmp	rcx, rsi
	mov	rsi, r15
	mov	r15, qword ptr [rsp + 24]
	je	252f
232:
	mov	rsi, qword ptr [rsp + 16]
	mov	rcx, rsi
	sub	rcx, rax
	.p2align	4
242:
	movzx	eax, byte ptr [r8 + rdi]
	mov	byte ptr [rcx + rdi], al
	inc	rdi
	cmp	rdx, rdi
	jne	242b
252:
	vmovdqu	ymm2, ymmword ptr [rsi]
	vmovdqu	ymm6, ymmword ptr [rsi + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm13, ymm7, ymm4
	vpshufb	ymm14, ymm2, ymm4
	vpbroadcastb	ymm3, byte ptr [rip + 1072f]
	vpand	ymm15, ymm4, ymm3
	vpxor	xmm10, xmm10, xmm10
	vpcmpeqb	ymm15, ymm15, ymm10
	vpblendvb	ymm13, ymm14, ymm13, ymm15
	vpermq	ymm14, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm12, ymm14, ymm4
	vpshufb	ymm8, ymm6, ymm4
	vpblendvb	ymm8, ymm8, ymm12, ymm15
	vpshufb	ymm7, ymm7, ymm9
	vpshufb	ymm2, ymm2, ymm9
	vpand	ymm12, ymm9, ymm3
	vpcmpeqb	ymm12, ymm12, ymm10
	vpblendvb	ymm2, ymm2, ymm7, ymm12
	vpshufb	ymm7, ymm14, ymm9
	vpshufb	ymm6, ymm6, ymm9
	vpblendvb	ymm6, ymm6, ymm7, ymm12
	vpbroadcastb	ymm3, byte ptr [rip + 1082f]
	vpand	ymm7, ymm9, ymm3
	vpcmpeqb	ymm7, ymm7, ymm3
	vpblendvb	ymm2, ymm2, ymm6, ymm7
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm4, ymm13, ymm8, ymm4
	vpxor	xmm13, xmm13, xmm13
	vpsrlvd	ymm2, ymm2, ymmword ptr [rsp + 272]
	vpandn	ymm2, ymm5, ymm2
	vpaddd	ymm2, ymm11, ymm2
	vpsrlvd	ymm3, ymm4, ymmword ptr [rsp + 208]
	vpandn	ymm3, ymm0, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 176]
	vpor	ymm4, ymm3, ymmword ptr [rip + 1092f]
	vpcmpeqd	ymm3, ymm13, ymm3
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 1102f]
	vpcmpeqd	ymm2, ymm13, ymm2
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
	vpblendd	ymm3, ymm4, ymm13, 192
	vpermq	ymm3, ymm3, 147
	vpmaxud	ymm3, ymm4, ymm3
	vperm2i128	ymm4, ymm3, ymm3, 10
	vpmaxud	ymm4, ymm3, ymm4
	vperm2i128	ymm3, ymm3, ymm2, 33
	vpmaxud	ymm2, ymm2, ymm3
	vpmaxud	ymm2, ymm2, ymm4
	vmovdqu	ymm5, ymmword ptr [rsp + 304]
	vpand	ymm3, ymm2, ymm5
	vpcmpeqd	ymm2, ymm13, ymm2
	vmovups	ymm0, ymmword ptr [rsp + 80]
	vblendvps	ymm2, ymm3, ymm0, ymm2
	vpand	ymm3, ymm4, ymm5
	vpcmpeqd	ymm4, ymm13, ymm4
	vblendvps	ymm0, ymm3, ymm0, ymm4
	vextracti128	xmm1, ymm1, 1
	vpextrd	eax, xmm1, 3
	mov	rcx, qword ptr [rsp + 8]
	vmovups	ymmword ptr [rcx + 320], ymm0
	vmovups	ymmword ptr [rcx + 352], ymm2
	vshufps	ymm0, ymm2, ymm2, 255
	vpermpd	ymm0, ymm0, 170
	add	r15, rax
	cmp	qword ptr [rsp + 112], 33
	jb	422f
	vmovdqu	ymm2, ymmword ptr [rsp + 464]
	vpshufd	xmm1, xmm2, 238
	vpmovzxbd	ymm1, xmm1
	vpmovzxbd	ymm2, xmm2
	vpsrld	ymm3, ymm2, 3
	vpsrld	ymm4, ymm1, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 432]
	vpmaxud	ymm4, ymm4, ymm5
	vpcmpeqd	ymm7, ymm7, ymm7
	vpaddd	ymm4, ymm4, ymm7
	vpmaxud	ymm3, ymm3, ymm5
	vpaddd	ymm5, ymm3, ymm7
	vmovdqu	ymm8, ymmword ptr [rsp + 400]
	vpand	ymm3, ymm8, ymm2
	vpand	ymm6, ymm8, ymm1
	vmovdqu	ymm9, ymmword ptr [rsp + 368]
	vpminud	ymm1, ymm1, ymm9
	vpminud	ymm2, ymm2, ymm9
	vpand	ymm2, ymm9, ymm2
	vpor	ymm2, ymm2, ymm3
	vpand	ymm1, ymm9, ymm1
	vpor	ymm1, ymm1, ymm6
	vpsllvd	ymm2, ymm2, ymm5
	vmovdqu	ymmword ptr [rsp + 176], ymm2
	vpsllvd	ymm1, ymm1, ymm4
	vmovdqu	ymmword ptr [rsp + 80], ymm1
	vpsllvd	ymm1, ymm7, ymm5
	vmovdqu	ymmword ptr [rsp + 272], ymm1
	vpsllvd	ymm1, ymm7, ymm4
	vmovdqu	ymmword ptr [rsp + 208], ymm1
	vperm2i128	ymm1, ymm5, ymm4, 33
	vpalignr	ymm1, ymm4, ymm1, 12
	vperm2i128	ymm2, ymm5, ymm5, 10
	vpalignr	ymm2, ymm5, ymm2, 12
	vpaddd	ymm2, ymm2, ymm5
	vpaddd	ymm1, ymm1, ymm4
	vpblendd	ymm6, ymm2, ymm13, 192
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
	mov	eax, r15d
	and	eax, 7
	vmovd	xmm5, eax
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm4, ymm5, ymm4
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm6, ymm4, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm5, ymm8, ymm4
	vpand	ymm11, ymm8, ymm2
	vbroadcasti128	ymm4, xmmword ptr [rip + 1062f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm6, ymm7, ymm4
	vmovdqu	ymm7, ymmword ptr [rsp + 336]
	vpaddb	ymm4, ymm2, ymm7
	vpaddb	ymm9, ymm6, ymm7
	mov	rax, r15
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, rdx
	jbe	262f
	mov	rcx, rdx
	sub	rcx, rax
	mov	rsi, qword ptr [rsp + 16]
	jbe	332f
	cmp	rcx, 16
	mov	rdi, rax
	jb	312f
	lea	r10, [rax + r8]
	mov	rsi, qword ptr [rsp + 8]
	sub	rsi, r10
	add	rsi, 575
	cmp	rsi, 127
	mov	rdi, rax
	jb	312f
	cmp	rcx, 128
	mov	qword ptr [rsp + 24], r15
	jae	272f
	xor	r11d, r11d
	jmp	292f
262:
	add	rax, r8
	mov	rsi, rax
	jmp	332f
272:
	mov	r11, rcx
	and	r11, -128
	lea	rdi, [rax + r11]
	lea	r15, [r8 + rax + 96]
	xor	esi, esi
	.p2align	4
282:
	vmovdqu	ymm2, ymmword ptr [r15 + rsi - 96]
	vmovdqu	ymm6, ymmword ptr [r15 + rsi - 64]
	vmovdqu	ymm7, ymmword ptr [r15 + rsi - 32]
	vmovdqu	ymm13, ymmword ptr [r15 + rsi]
	mov	rbp, qword ptr [rsp + 8]
	vmovdqu	ymmword ptr [rbp + rsi + 576], ymm2
	vmovdqu	ymmword ptr [rbp + rsi + 608], ymm6
	vmovdqu	ymmword ptr [rbp + rsi + 640], ymm7
	vmovdqu	ymmword ptr [rbp + rsi + 672], ymm13
	sub	rsi, -128
	cmp	r11, rsi
	jne	282b
	cmp	rcx, r11
	mov	rsi, qword ptr [rsp + 16]
	mov	r15, qword ptr [rsp + 24]
	je	332f
	test	cl, 112
	je	312f
292:
	mov	rsi, rcx
	and	rsi, -16
	lea	rdi, [rax + rsi]
	mov	r15, qword ptr [rsp + 16]
	.p2align	4
302:
	vmovdqu	xmm2, xmmword ptr [r10 + r11]
	vmovdqu	xmmword ptr [r15 + r11], xmm2
	add	r11, 16
	cmp	rsi, r11
	jne	302b
	cmp	rcx, rsi
	mov	rsi, r15
	mov	r15, qword ptr [rsp + 24]
	je	332f
312:
	mov	rsi, qword ptr [rsp + 16]
	mov	rcx, rsi
	sub	rcx, rax
	.p2align	4
322:
	movzx	eax, byte ptr [r8 + rdi]
	mov	byte ptr [rcx + rdi], al
	inc	rdi
	cmp	rdx, rdi
	jne	322b
332:
	vmovdqu	ymm2, ymmword ptr [rsi]
	vmovdqu	ymm6, ymmword ptr [rsi + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm13, ymm7, ymm4
	vpshufb	ymm14, ymm2, ymm4
	vpbroadcastb	ymm3, byte ptr [rip + 1072f]
	vpand	ymm15, ymm4, ymm3
	vpxor	xmm10, xmm10, xmm10
	vpcmpeqb	ymm15, ymm15, ymm10
	vpblendvb	ymm13, ymm14, ymm13, ymm15
	vpermq	ymm14, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm12, ymm14, ymm4
	vpshufb	ymm8, ymm6, ymm4
	vpblendvb	ymm8, ymm8, ymm12, ymm15
	vpshufb	ymm7, ymm7, ymm9
	vpshufb	ymm2, ymm2, ymm9
	vpand	ymm12, ymm9, ymm3
	vpcmpeqb	ymm12, ymm12, ymm10
	vpblendvb	ymm2, ymm2, ymm7, ymm12
	vpshufb	ymm7, ymm14, ymm9
	vpshufb	ymm6, ymm6, ymm9
	vpblendvb	ymm6, ymm6, ymm7, ymm12
	vpbroadcastb	ymm3, byte ptr [rip + 1082f]
	vpand	ymm7, ymm9, ymm3
	vpcmpeqb	ymm7, ymm7, ymm3
	vpblendvb	ymm2, ymm2, ymm6, ymm7
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm4, ymm13, ymm8, ymm4
	vpxor	xmm13, xmm13, xmm13
	vpsrlvd	ymm2, ymm2, ymm11
	vmovdqu	ymm3, ymmword ptr [rsp + 272]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 176]
	vpsrlvd	ymm3, ymm4, ymm5
	vmovdqu	ymm4, ymmword ptr [rsp + 208]
	vpandn	ymm3, ymm4, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 80]
	vpor	ymm4, ymm3, ymmword ptr [rip + 1092f]
	vpcmpeqd	ymm3, ymm13, ymm3
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 1102f]
	vpcmpeqd	ymm2, ymm13, ymm2
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
	vpblendd	ymm3, ymm4, ymm13, 192
	vpermq	ymm3, ymm3, 147
	vpmaxud	ymm3, ymm4, ymm3
	vperm2i128	ymm4, ymm3, ymm3, 10
	vpmaxud	ymm4, ymm3, ymm4
	vperm2i128	ymm3, ymm3, ymm2, 33
	vpmaxud	ymm2, ymm2, ymm3
	vpmaxud	ymm2, ymm2, ymm4
	vmovdqu	ymm5, ymmword ptr [rsp + 304]
	vpand	ymm3, ymm2, ymm5
	vpcmpeqd	ymm2, ymm13, ymm2
	vblendvps	ymm2, ymm3, ymm0, ymm2
	vpand	ymm3, ymm4, ymm5
	vpcmpeqd	ymm4, ymm13, ymm4
	vblendvps	ymm0, ymm3, ymm0, ymm4
	vextracti128	xmm1, ymm1, 1
	vpextrd	eax, xmm1, 3
	mov	rcx, qword ptr [rsp + 8]
	vmovups	ymmword ptr [rcx + 384], ymm0
	vmovups	ymmword ptr [rcx + 416], ymm2
	vshufps	ymm0, ymm2, ymm2, 255
	vpermpd	ymm0, ymm0, 170
	add	r15, rax
	cmp	qword ptr [rsp + 112], 49
	jb	422f
	vmovdqu	ymm1, ymmword ptr [rsp + 464]
	vextracti128	xmm1, ymm1, 1
	vpshufd	xmm2, xmm1, 238
	vpmovzxbd	ymm2, xmm2
	vpmovzxbd	ymm1, xmm1
	vpsrld	ymm3, ymm1, 3
	vpsrld	ymm4, ymm2, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 432]
	vpmaxud	ymm4, ymm4, ymm5
	vpcmpeqd	ymm7, ymm7, ymm7
	vpaddd	ymm4, ymm4, ymm7
	vpmaxud	ymm3, ymm3, ymm5
	vpaddd	ymm5, ymm3, ymm7
	vmovdqu	ymm8, ymmword ptr [rsp + 400]
	vpand	ymm3, ymm8, ymm1
	vpand	ymm6, ymm8, ymm2
	vmovdqu	ymm9, ymmword ptr [rsp + 368]
	vpminud	ymm2, ymm2, ymm9
	vpminud	ymm1, ymm1, ymm9
	vpand	ymm1, ymm9, ymm1
	vpor	ymm1, ymm1, ymm3
	vpand	ymm2, ymm9, ymm2
	vpor	ymm2, ymm2, ymm6
	vpsllvd	ymm1, ymm1, ymm5
	vmovdqu	ymmword ptr [rsp + 80], ymm1
	vpsllvd	ymm1, ymm2, ymm4
	vmovdqu	ymmword ptr [rsp + 112], ymm1
	vpsllvd	ymm1, ymm7, ymm5
	vmovdqu	ymmword ptr [rsp + 208], ymm1
	vpsllvd	ymm1, ymm7, ymm4
	vmovdqu	ymmword ptr [rsp + 176], ymm1
	vperm2i128	ymm1, ymm5, ymm4, 33
	vpalignr	ymm1, ymm4, ymm1, 12
	vperm2i128	ymm2, ymm5, ymm5, 10
	vpalignr	ymm2, ymm5, ymm2, 12
	vpaddd	ymm2, ymm2, ymm5
	vpaddd	ymm1, ymm1, ymm4
	vpblendd	ymm6, ymm2, ymm13, 192
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
	mov	eax, r15d
	and	eax, 7
	vmovd	xmm5, eax
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm4, ymm5, ymm4
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm6, ymm4, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm5, ymm8, ymm4
	vpand	ymm11, ymm8, ymm2
	vbroadcasti128	ymm4, xmmword ptr [rip + 1062f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm6, ymm7, ymm4
	vmovdqu	ymm7, ymmword ptr [rsp + 336]
	vpaddb	ymm4, ymm2, ymm7
	vpaddb	ymm9, ymm6, ymm7
	mov	rax, r15
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, rdx
	jbe	342f
	mov	rcx, rdx
	sub	rcx, rax
	mov	rsi, qword ptr [rsp + 16]
	jbe	412f
	cmp	rcx, 16
	mov	rdi, rax
	jb	392f
	lea	r10, [rax + r8]
	mov	rsi, qword ptr [rsp + 8]
	sub	rsi, r10
	add	rsi, 575
	cmp	rsi, 127
	mov	rdi, rax
	jb	392f
	cmp	rcx, 128
	mov	qword ptr [rsp + 24], r15
	jae	352f
	xor	r11d, r11d
	jmp	372f
342:
	add	r8, rax
	mov	rsi, r8
	jmp	412f
352:
	mov	r11, rcx
	and	r11, -128
	lea	rdi, [rax + r11]
	lea	r15, [r8 + rax + 96]
	xor	esi, esi
	.p2align	4
362:
	vmovdqu	ymm2, ymmword ptr [r15 + rsi - 96]
	vmovdqu	ymm6, ymmword ptr [r15 + rsi - 64]
	vmovdqu	ymm7, ymmword ptr [r15 + rsi - 32]
	vmovdqu	ymm13, ymmword ptr [r15 + rsi]
	mov	rbp, qword ptr [rsp + 8]
	vmovdqu	ymmword ptr [rbp + rsi + 576], ymm2
	vmovdqu	ymmword ptr [rbp + rsi + 608], ymm6
	vmovdqu	ymmword ptr [rbp + rsi + 640], ymm7
	vmovdqu	ymmword ptr [rbp + rsi + 672], ymm13
	sub	rsi, -128
	cmp	r11, rsi
	jne	362b
	cmp	rcx, r11
	mov	rsi, qword ptr [rsp + 16]
	mov	r15, qword ptr [rsp + 24]
	je	412f
	test	cl, 112
	je	392f
372:
	mov	rsi, rcx
	and	rsi, -16
	lea	rdi, [rax + rsi]
	mov	r15, qword ptr [rsp + 16]
	.p2align	4
382:
	vmovdqu	xmm2, xmmword ptr [r10 + r11]
	vmovdqu	xmmword ptr [r15 + r11], xmm2
	add	r11, 16
	cmp	rsi, r11
	jne	382b
	cmp	rcx, rsi
	mov	rsi, r15
	mov	r15, qword ptr [rsp + 24]
	je	412f
392:
	mov	rsi, qword ptr [rsp + 16]
	mov	rcx, rsi
	sub	rcx, rax
	.p2align	4
402:
	movzx	eax, byte ptr [r8 + rdi]
	mov	byte ptr [rcx + rdi], al
	inc	rdi
	cmp	rdx, rdi
	jne	402b
412:
	vmovdqu	ymm2, ymmword ptr [rsi]
	vmovdqu	ymm6, ymmword ptr [rsi + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm13, ymm7, ymm4
	vpshufb	ymm14, ymm2, ymm4
	vpbroadcastb	ymm3, byte ptr [rip + 1072f]
	vpand	ymm15, ymm4, ymm3
	vpxor	xmm10, xmm10, xmm10
	vpcmpeqb	ymm15, ymm15, ymm10
	vpblendvb	ymm13, ymm14, ymm13, ymm15
	vpermq	ymm14, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm12, ymm14, ymm4
	vpshufb	ymm8, ymm6, ymm4
	vpblendvb	ymm8, ymm8, ymm12, ymm15
	vpshufb	ymm7, ymm7, ymm9
	vpshufb	ymm2, ymm2, ymm9
	vpand	ymm12, ymm9, ymm3
	vpcmpeqb	ymm12, ymm12, ymm10
	vpblendvb	ymm2, ymm2, ymm7, ymm12
	vpshufb	ymm7, ymm14, ymm9
	vpshufb	ymm6, ymm6, ymm9
	vpblendvb	ymm6, ymm6, ymm7, ymm12
	vpbroadcastb	ymm3, byte ptr [rip + 1082f]
	vpand	ymm7, ymm9, ymm3
	vpcmpeqb	ymm7, ymm7, ymm3
	vpblendvb	ymm2, ymm2, ymm6, ymm7
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm4, ymm13, ymm8, ymm4
	vpxor	xmm13, xmm13, xmm13
	vpsrlvd	ymm2, ymm2, ymm11
	vmovdqu	ymm3, ymmword ptr [rsp + 208]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 80]
	vpsrlvd	ymm3, ymm4, ymm5
	vmovdqu	ymm4, ymmword ptr [rsp + 176]
	vpandn	ymm3, ymm4, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 112]
	vpor	ymm4, ymm3, ymmword ptr [rip + 1092f]
	vpcmpeqd	ymm3, ymm13, ymm3
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 1102f]
	vpcmpeqd	ymm2, ymm13, ymm2
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
	vpblendd	ymm3, ymm4, ymm13, 192
	vpermq	ymm3, ymm3, 147
	vpmaxud	ymm3, ymm4, ymm3
	vperm2i128	ymm4, ymm3, ymm3, 10
	vpmaxud	ymm4, ymm3, ymm4
	vperm2i128	ymm3, ymm3, ymm2, 33
	vpmaxud	ymm2, ymm2, ymm3
	vpmaxud	ymm2, ymm2, ymm4
	vmovdqu	ymm5, ymmword ptr [rsp + 304]
	vpand	ymm3, ymm2, ymm5
	vpcmpeqd	ymm2, ymm13, ymm2
	vblendvps	ymm2, ymm3, ymm0, ymm2
	vpand	ymm3, ymm4, ymm5
	vpcmpeqd	ymm4, ymm13, ymm4
	vblendvps	ymm0, ymm3, ymm0, ymm4
	vextracti128	xmm1, ymm1, 1
	vpextrd	eax, xmm1, 3
	mov	rcx, qword ptr [rsp + 8]
	vmovups	ymmword ptr [rcx + 448], ymm0
	vmovups	ymmword ptr [rcx + 480], ymm2
	vshufps	ymm0, ymm2, ymm2, 255
	vpermpd	ymm0, ymm0, 170
	add	r15, rax
	.p2align	4
422:
	mov	r10, qword ptr [rsp + 32]
	shr	r14, 56
	add	r14, rbx
	shr	r13, 56
	add	r13, r9
	vmovd	eax, xmm0
	mov	rcx, qword ptr [rsp + 8]
	mov	qword ptr [rcx + 72], r15
	mov	qword ptr [rcx + 96], rax
	mov	qword ptr [rcx + 128], r13
	mov	qword ptr [rcx + 136], r14
	add	r12, qword ptr [rsp + 248]
	mov	rdx, qword ptr [rsp + 64]
	and	rdx, 124
	je	842f
	xor	esi, esi
	mov	r9, qword ptr [rsp + 40]
	mov	r15, qword ptr [rsp + 48]
	mov	qword ptr [rsp + 56], r12
	.p2align	4
432:
	movzx	ecx, byte ptr [r12 + rsi]
	mov	rax, qword ptr [rsp + 8]
	movzx	r13d, byte ptr [rax + rsi + 192]
	cmp	r13, 33
	mov	eax, dword ptr [rax + 4*rsi + 256]
	vmovdqu	ymm0, ymmword ptr [r15]
	vmovdqu	ymmword ptr [r10], ymm0
	jae	562f
442:
	mov	qword ptr [rsp + 32], r10
	lea	r8, [r10 + r13]
	mov	r11d, ecx
	shr	r11d, 2
	cmp	rax, r11
	jb	762f
	mov	rdi, r8
	sub	rdi, rax
	cmp	rdi, r9
	jl	762f
	vmovdqu	ymm0, ymmword ptr [rdi]
452:
	vmovdqu	ymmword ptr [r8], ymm0
	cmp	cl, -124
	jae	582f
462:
	lea	rax, [rsi + 1]
	lea	rbx, [r15 + r13]
	movzx	ecx, byte ptr [r12 + rax]
	mov	rdi, qword ptr [rsp + 8]
	movzx	r14d, byte ptr [rdi + rax + 192]
	cmp	r14, 33
	mov	eax, dword ptr [rdi + 4*rax + 256]
	vmovdqu	ymm0, ymmword ptr [r15 + r13]
	vmovdqu	ymmword ptr [r8 + r11], ymm0
	jae	612f
472:
	mov	qword ptr [rsp + 112], r13
	mov	qword ptr [rsp + 48], r15
	add	r8, r11
	add	r8, r14
	mov	r13d, ecx
	shr	r13d, 2
	cmp	rax, r13
	jb	772f
	mov	rdi, r8
	sub	rdi, rax
	cmp	rdi, r9
	jl	772f
	vmovdqu	ymm0, ymmword ptr [rdi]
482:
	vmovdqu	ymmword ptr [r8], ymm0
	cmp	cl, -124
	jae	632f
492:
	lea	rax, [rsi + 2]
	movzx	r15d, byte ptr [r12 + rax]
	mov	rcx, qword ptr [rsp + 8]
	movzx	r12d, byte ptr [rcx + rax + 192]
	cmp	r12, 33
	mov	ecx, dword ptr [rcx + 4*rax + 256]
	vmovdqu	ymm0, ymmword ptr [rbx + r14]
	vmovdqu	ymmword ptr [r8 + r13], ymm0
	jae	662f
502:
	add	r8, r13
	add	r8, r12
	mov	eax, r15d
	shr	eax, 2
	cmp	rcx, rax
	jb	782f
	mov	rdi, r8
	sub	rdi, rcx
	cmp	rdi, r9
	jl	782f
	vmovdqu	ymm0, ymmword ptr [rdi]
512:
	vmovdqu	ymmword ptr [r8], ymm0
	cmp	r15b, -124
	jae	682f
522:
	lea	rdi, [rsi + 3]
	add	rbx, r14
	mov	rcx, qword ptr [rsp + 56]
	movzx	r10d, byte ptr [rcx + rdi]
	mov	r9, qword ptr [rsp + 8]
	movzx	ecx, byte ptr [r9 + rdi + 192]
	cmp	rcx, 33
	mov	r9d, dword ptr [r9 + 4*rdi + 256]
	vmovdqu	ymm0, ymmword ptr [rbx + r12]
	vmovdqu	ymmword ptr [r8 + rax], ymm0
	jae	712f
532:
	add	r8, rax
	add	r8, rcx
	mov	r15d, r10d
	shr	r15d, 2
	cmp	r9, r15
	jb	792f
	mov	rdi, r8
	sub	rdi, r9
	cmp	rdi, qword ptr [rsp + 40]
	jl	792f
	vmovdqu	ymm0, ymmword ptr [rdi]
542:
	vmovdqu	ymmword ptr [r8], ymm0
	cmp	r10b, -124
	jae	732f
552:
	add	rbx, r12
	add	r8, r15
	add	rbx, rcx
	add	rsi, 4
	cmp	rsi, rdx
	mov	r15, rbx
	mov	r10, r8
	mov	r9, qword ptr [rsp + 40]
	mov	r12, qword ptr [rsp + 56]
	jb	432b
	jmp	852f
562:
	mov	r11, qword ptr [rsp + 8]
	mov	rdi, qword ptr [r11 + 48]
	mov	r8, qword ptr [r11 + 120]
	movzx	r13d, byte ptr [rdi + r8]
	inc	r8
	mov	qword ptr [r11 + 120], r8
	add	r13, 33
	mov	edi, 32
	.p2align	4
572:
	vmovdqu	ymm0, ymmword ptr [r15 + rdi]
	vmovdqu	ymmword ptr [r10 + rdi], ymm0
	add	rdi, 32
	cmp	rdi, r13
	jb	572b
	jmp	442b
582:
	cmp	rax, 31
	ja	592f
	mov	rax, qword ptr [rsp + 8]
	mov	qword ptr [rax + 104], 1
592:
	mov	r10, qword ptr [rsp + 8]
	mov	rax, qword ptr [r10 + 48]
	mov	rcx, qword ptr [r10 + 120]
	movzx	r11d, byte ptr [rax + rcx]
	inc	rcx
	mov	qword ptr [r10 + 120], rcx
	add	r11, 33
	mov	eax, 32
	.p2align	4
602:
	vmovdqu	ymm0, ymmword ptr [rdi + rax]
	vmovdqu	ymmword ptr [r8 + rax], ymm0
	add	rax, 32
	cmp	rax, r11
	jb	602b
	jmp	462b
612:
	mov	rbp, qword ptr [rsp + 8]
	mov	rdi, qword ptr [rbp + 48]
	mov	r10, qword ptr [rbp + 120]
	movzx	r14d, byte ptr [rdi + r10]
	inc	r10
	mov	qword ptr [rbp + 120], r10
	add	r14, 33
	lea	rdi, [r13 + r11]
	add	rdi, qword ptr [rsp + 32]
	mov	r10d, 32
	.p2align	4
622:
	vmovdqu	ymm0, ymmword ptr [rbx + r10]
	vmovdqu	ymmword ptr [rdi + r10], ymm0
	add	r10, 32
	cmp	r10, r14
	jb	622b
	jmp	472b
632:
	cmp	rax, 31
	ja	642f
	mov	rax, qword ptr [rsp + 8]
	mov	qword ptr [rax + 104], 1
642:
	mov	r10, qword ptr [rsp + 8]
	mov	rax, qword ptr [r10 + 48]
	mov	rcx, qword ptr [r10 + 120]
	movzx	r13d, byte ptr [rax + rcx]
	inc	rcx
	mov	qword ptr [r10 + 120], rcx
	add	r13, 33
	mov	rax, qword ptr [rsp + 112]
	add	rax, r14
	mov	rcx, qword ptr [rsp + 32]
	add	rcx, r11
	add	rax, rcx
	mov	ecx, 32
	.p2align	4
652:
	vmovdqu	ymm0, ymmword ptr [rdi + rcx]
	vmovdqu	ymmword ptr [rax + rcx], ymm0
	add	rcx, 32
	cmp	rcx, r13
	jb	652b
	jmp	492b
662:
	mov	r10, qword ptr [rsp + 8]
	mov	rax, qword ptr [r10 + 48]
	mov	rdi, qword ptr [r10 + 120]
	movzx	r12d, byte ptr [rax + rdi]
	inc	rdi
	mov	qword ptr [r10 + 120], rdi
	add	r12, 33
	mov	rax, qword ptr [rsp + 112]
	add	rax, r14
	lea	rdi, [r13 + r11]
	add	rdi, rax
	add	rdi, qword ptr [rsp + 32]
	add	rax, qword ptr [rsp + 48]
	mov	r10d, 32
	.p2align	4
672:
	vmovdqu	ymm0, ymmword ptr [rax + r10]
	vmovdqu	ymmword ptr [rdi + r10], ymm0
	add	r10, 32
	cmp	r10, r12
	jb	672b
	jmp	502b
682:
	cmp	rcx, 31
	ja	692f
	mov	rax, qword ptr [rsp + 8]
	mov	qword ptr [rax + 104], 1
692:
	mov	r9, qword ptr [rsp + 8]
	mov	rax, qword ptr [r9 + 48]
	mov	rcx, qword ptr [r9 + 120]
	movzx	eax, byte ptr [rax + rcx]
	inc	rcx
	mov	qword ptr [r9 + 120], rcx
	add	rax, 33
	mov	rcx, qword ptr [rsp + 112]
	lea	r10, [rcx + r12]
	lea	rcx, [r13 + r14]
	add	rcx, r10
	mov	r9, qword ptr [rsp + 32]
	add	rcx, r9
	add	rcx, r11
	mov	r10d, 32
	.p2align	4
702:
	vmovdqu	ymm0, ymmword ptr [rdi + r10]
	vmovdqu	ymmword ptr [rcx + r10], ymm0
	add	r10, 32
	cmp	r10, rax
	jb	702b
	jmp	522b
712:
	mov	r15, qword ptr [rsp + 8]
	mov	rcx, qword ptr [r15 + 48]
	mov	rdi, qword ptr [r15 + 120]
	movzx	ecx, byte ptr [rcx + rdi]
	inc	rdi
	mov	qword ptr [r15 + 120], rdi
	add	rcx, 33
	mov	rdi, qword ptr [rsp + 112]
	add	rdi, r12
	mov	qword ptr [rsp + 80], rdi
	lea	r15, [rax + r13]
	add	r15, rdi
	lea	rdi, [r14 + r11]
	add	rdi, qword ptr [rsp + 32]
	add	rdi, r15
	mov	qword ptr [rsp + 24], rdi
	mov	rdi, qword ptr [rsp + 48]
	add	rdi, r14
	add	rdi, qword ptr [rsp + 80]
	mov	qword ptr [rsp + 48], rdi
	mov	r15d, 32
	.p2align	4
722:
	mov	rdi, qword ptr [rsp + 48]
	vmovdqu	ymm0, ymmword ptr [rdi + r15]
	mov	rdi, qword ptr [rsp + 24]
	vmovdqu	ymmword ptr [rdi + r15], ymm0
	add	r15, 32
	cmp	r15, rcx
	jb	722b
	jmp	532b
732:
	cmp	r9, 31
	ja	742f
	mov	r9, qword ptr [rsp + 8]
	mov	qword ptr [r9 + 104], 1
742:
	mov	rbp, qword ptr [rsp + 8]
	mov	r9, qword ptr [rbp + 48]
	mov	r10, qword ptr [rbp + 120]
	movzx	r15d, byte ptr [r9 + r10]
	inc	r10
	mov	qword ptr [rbp + 120], r10
	add	r15, 33
	mov	r9, qword ptr [rsp + 112]
	add	r9, rcx
	add	rax, r12
	add	rax, r9
	add	r13, r14
	add	r13, r11
	add	r13, rax
	mov	r9, qword ptr [rsp + 32]
	add	r9, r13
	mov	eax, 32
	.p2align	4
752:
	vmovdqu	ymm0, ymmword ptr [rdi + rax]
	vmovdqu	ymmword ptr [r9 + rax], ymm0
	add	rax, 32
	cmp	rax, r15
	jb	752b
	jmp	552b
762:
	mov	rdi, r8
	sub	rdi, r9
	cmp	rax, rdi
	cmovae	rax, rdi
	sub	rdi, rax
	cmp	rax, r11
	jae	802f
	mov	r10, qword ptr [rsp + 8]
	mov	r10, qword ptr [r10 + 56]
	mov	rbx, rax
	shl	rbx, 5
	vmovdqu	ymm0, ymmword ptr [r10 + rbx + 2048]
	vmovdqu	ymm1, ymmword ptr [r9 + rdi]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	add	rdi, r9
	jmp	452b
772:
	mov	rdi, r8
	sub	rdi, r9
	cmp	rax, rdi
	cmovae	rax, rdi
	sub	rdi, rax
	cmp	rax, r13
	jae	812f
	mov	r10, qword ptr [rsp + 8]
	mov	r10, qword ptr [r10 + 56]
	mov	r15, rax
	shl	r15, 5
	vmovdqu	ymm0, ymmword ptr [r10 + r15 + 2048]
	vmovdqu	ymm1, ymmword ptr [r9 + rdi]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	add	rdi, r9
	jmp	482b
782:
	mov	rdi, r8
	sub	rdi, r9
	cmp	rcx, rdi
	cmovae	rcx, rdi
	sub	rdi, rcx
	cmp	rcx, rax
	jae	822f
	mov	r9, qword ptr [rsp + 8]
	mov	r10, qword ptr [r9 + 56]
	mov	rbp, rcx
	shl	rbp, 5
	vmovdqu	ymm0, ymmword ptr [r10 + rbp + 2048]
	mov	r9, qword ptr [rsp + 40]
	vmovdqu	ymm1, ymmword ptr [r9 + rdi]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	add	rdi, r9
	jmp	512b
792:
	mov	rdi, r8
	sub	rdi, qword ptr [rsp + 40]
	cmp	r9, rdi
	cmovae	r9, rdi
	sub	rdi, r9
	cmp	r9, r15
	jae	832f
	mov	qword ptr [rsp + 24], r14
	mov	r14, qword ptr [rsp + 8]
	mov	r14, qword ptr [r14 + 56]
	mov	qword ptr [rsp + 48], r14
	mov	rbp, r9
	shl	rbp, 5
	mov	r14, qword ptr [rsp + 48]
	vmovdqu	ymm0, ymmword ptr [r14 + rbp + 2048]
	mov	r14, qword ptr [rsp + 24]
	mov	rbp, qword ptr [rsp + 40]
	vmovdqu	ymm1, ymmword ptr [rbp + rdi]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	add	rdi, qword ptr [rsp + 40]
	jmp	542b
802:
	vmovdqu	ymm0, ymmword ptr [r9 + rdi]
	add	rdi, r9
	jmp	452b
812:
	vmovdqu	ymm0, ymmword ptr [r9 + rdi]
	add	rdi, r9
	jmp	482b
822:
	vmovdqu	ymm0, ymmword ptr [r9 + rdi]
	add	rdi, r9
	jmp	512b
832:
	mov	rbp, qword ptr [rsp + 40]
	vmovdqu	ymm0, ymmword ptr [rbp + rdi]
	add	rdi, qword ptr [rsp + 40]
	jmp	542b
	.p2align	4
842:
	mov	r8, r10
	mov	rbx, qword ptr [rsp + 48]
	mov	r9, qword ptr [rsp + 40]
852:
	mov	r10, qword ptr [rsp + 64]
	cmp	rdx, r10
	mov	r11, r8
	mov	r14, rbx
	mov	rbx, qword ptr [rsp + 152]
	je	2b
	.p2align	4
862:
	movzx	esi, byte ptr [r12 + rdx]
	mov	rcx, qword ptr [rsp + 8]
	movzx	eax, byte ptr [rcx + rdx + 192]
	cmp	rax, 33
	mov	ecx, dword ptr [rcx + 4*rdx + 256]
	vmovdqu	ymm0, ymmword ptr [r14]
	vmovdqu	ymmword ptr [r11], ymm0
	jae	902f
872:
	add	r11, rax
	mov	edi, esi
	shr	edi, 2
	cmp	rcx, rdi
	jb	952f
	mov	r8, r11
	sub	r8, rcx
	cmp	r8, r9
	jl	952f
	vmovdqu	ymm0, ymmword ptr [r8]
882:
	vmovdqu	ymmword ptr [r11], ymm0
	cmp	sil, -124
	jae	922f
892:
	add	r11, rdi
	add	r14, rax
	inc	rdx
	cmp	rdx, r10
	jb	862b
	jmp	2b
902:
	mov	r8, qword ptr [rsp + 8]
	mov	rax, qword ptr [r8 + 48]
	mov	rdi, qword ptr [r8 + 120]
	movzx	eax, byte ptr [rax + rdi]
	inc	rdi
	mov	qword ptr [r8 + 120], rdi
	add	rax, 33
	mov	edi, 32
	.p2align	4
912:
	vmovdqu	ymm0, ymmword ptr [r14 + rdi]
	vmovdqu	ymmword ptr [r11 + rdi], ymm0
	add	rdi, 32
	cmp	rdi, rax
	jb	912b
	jmp	872b
922:
	cmp	rcx, 31
	ja	932f
	mov	rcx, qword ptr [rsp + 8]
	mov	qword ptr [rcx + 104], 1
932:
	mov	r15, qword ptr [rsp + 8]
	mov	rcx, qword ptr [r15 + 48]
	mov	rsi, qword ptr [r15 + 120]
	movzx	edi, byte ptr [rcx + rsi]
	inc	rsi
	mov	qword ptr [r15 + 120], rsi
	add	rdi, 33
	mov	ecx, 32
	.p2align	4
942:
	vmovdqu	ymm0, ymmword ptr [r8 + rcx]
	vmovdqu	ymmword ptr [r11 + rcx], ymm0
	add	rcx, 32
	cmp	rcx, rdi
	jb	942b
	jmp	892b
952:
	mov	r8, r11
	sub	r8, r9
	cmp	rcx, r8
	cmovae	rcx, r8
	sub	r8, rcx
	cmp	rcx, rdi
	jae	962f
	mov	r9, qword ptr [rsp + 8]
	mov	r9, qword ptr [r9 + 56]
	mov	r10, rcx
	shl	r10, 5
	vmovdqu	ymm0, ymmword ptr [r9 + r10 + 2048]
	mov	r10, qword ptr [rsp + 64]
	mov	r9, qword ptr [rsp + 40]
	vmovdqu	ymm1, ymmword ptr [r9 + r8]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	add	r8, r9
	jmp	882b
962:
	vmovdqu	ymm0, ymmword ptr [r9 + r8]
	add	r8, r9
	jmp	882b
972:
	sub	r11, r9
	sub	r14, qword ptr [rsp + 240]
	mov	rax, qword ptr [rsp + 8]
	mov	qword ptr [rax + 80], r11
	mov	qword ptr [rax + 88], r14
	add	rsp, 536
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	vzeroupper
	ret
	.p2align	2, 0x0
982:
	.long	1
	.p2align	2, 0x0
992:
	.long	7
	.p2align	2, 0x0
1002:
	.long	8
	.p2align	2, 0x0
1012:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	2, 0x0
1022:
	.long	134217727
	.p2align	5, 0x0
1032:
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
1042:
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
1052:
	.byte	1
	.p2align	4, 0x0
1062:
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
1072:
	.byte	16
	.p2align	2, 0x0
1082:
	.byte	32
	.p2align	5, 0x0
1092:
	.long	1207959552
	.long	1342177280
	.long	1476395008
	.long	1610612736
	.long	1744830464
	.long	1879048192
	.long	2013265920
	.long	2147483648
	.p2align	5, 0x0
1102:
	.long	134217728
	.long	268435456
	.long	402653184
	.long	536870912
	.long	671088640
	.long	805306368
	.long	939524096
	.long	1073741824

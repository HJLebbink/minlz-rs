# minlz_exec_flat_delta of crates/minlz/mlir/exec64.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 536
	mov	r12, rdi
	mov	rbp, qword ptr [rdi]
	mov	rax, qword ptr [rdi + 8]
	mov	rcx, qword ptr [rdi + 64]
	mov	r10, qword ptr [rdi + 80]
	add	r10, rbp
	mov	r15, qword ptr [rdi + 88]
	mov	qword ptr [rsp + 240], rax
	add	r15, rax
	test	rcx, rcx
	jle	822f
	mov	rax, qword ptr [r12 + 16]
	mov	qword ptr [rsp + 248], rax
	mov	rdi, qword ptr [r12 + 96]
	lea	rbx, [r12 + 512]
	lea	rax, [r12 + 576]
	mov	qword ptr [rsp], rax
	mov	eax, 96
	mov	qword ptr [rsp + 88], rax
	mov	eax, 7
	mov	qword ptr [rsp + 80], rax
	mov	qword ptr [rsp + 96], 0
	vpxor	xmm13, xmm13, xmm13
	vbroadcastss	ymm0, dword ptr [rip + 832f]
	vmovups	ymmword ptr [rsp + 432], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 842f]
	vmovups	ymmword ptr [rsp + 400], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 852f]
	vmovups	ymmword ptr [rsp + 368], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 862f]
	vmovups	ymmword ptr [rsp + 336], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 872f]
	vmovups	ymmword ptr [rsp + 304], ymm0
	mov	r11, rbx
	xor	eax, eax
	mov	qword ptr [rsp + 16], rbp
	mov	qword ptr [rsp + 56], rbx
	mov	qword ptr [rsp + 32], r12
	mov	qword ptr [rsp + 256], rcx
	jmp	12f
	.p2align	4
2:
	inc	qword ptr [rsp + 96]
	add	qword ptr [rsp + 88], 64
	add	qword ptr [rsp + 80], -64
	add	r11, -64
	mov	rcx, qword ptr [rsp + 256]
	mov	rax, qword ptr [rsp + 264]
	cmp	rax, rcx
	jge	822f
12:
	mov	qword ptr [rsp + 64], rdi
	mov	qword ptr [rsp + 48], r15
	mov	qword ptr [rsp + 104], r11
	mov	qword ptr [rsp + 24], r10
	mov	r14, rax
	sub	rcx, rax
	cmp	rcx, 64
	mov	eax, 64
	mov	qword ptr [rsp + 208], rcx
	cmovb	rax, rcx
	mov	qword ptr [rsp + 72], rax
	mov	rcx, qword ptr [r12 + 16]
	mov	r13, qword ptr [r12 + 24]
	mov	rdx, qword ptr [r12 + 32]
	mov	r9, qword ptr [r12 + 40]
	mov	r11, qword ptr [r12 + 64]
	mov	rax, qword ptr [r12 + 72]
	mov	qword ptr [rsp + 8], rax
	mov	r8, qword ptr [r12 + 96]
	mov	rax, qword ptr [r12 + 112]
	mov	rsi, qword ptr [r12 + 128]
	mov	r15, qword ptr [r12 + 136]
	lea	r10, [r11 + 7]
	lea	rdi, [r14 + 64]
	mov	qword ptr [rsp + 264], rdi
	cmp	rdi, r10
	mov	qword ptr [rsp + 40], r14
	mov	qword ptr [rsp + 144], r8
	mov	qword ptr [rsp + 112], r15
	jbe	22f
	cmp	r14, r10
	mov	rdi, rbx
	jge	92f
	mov	rdi, qword ptr [rsp + 96]
	shl	rdi, 6
	mov	ebx, 7
	sub	rbx, rdi
	add	rbx, r11
	cmp	rbx, 16
	mov	r15, r14
	jb	72f
	add	rdi, rcx
	mov	r8, qword ptr [rsp + 32]
	sub	r8, rdi
	add	r8, 511
	cmp	r8, 127
	mov	r15, r14
	jb	72f
	cmp	rbx, 128
	jae	32f
	xor	r12d, r12d
	jmp	52f
	.p2align	4
22:
	add	rcx, r14
	mov	rdi, rcx
	jmp	92f
32:
	mov	r12, rbx
	and	r12, -128
	lea	r15, [r14 + r12]
	mov	rdi, qword ptr [rsp + 88]
	lea	r8, [rcx + rdi]
	mov	rdi, qword ptr [rsp + 80]
	lea	rbp, [r11 + rdi]
	and	rbp, -128
	xor	r14d, r14d
	mov	rdi, qword ptr [rsp + 32]
	.p2align	4
42:
	vmovups	ymm0, ymmword ptr [r8 + r14 - 96]
	vmovdqu	ymm1, ymmword ptr [r8 + r14 - 64]
	vmovups	ymm3, ymmword ptr [r8 + r14 - 32]
	vmovups	ymm4, ymmword ptr [r8 + r14]
	vmovups	ymmword ptr [rdi + r14 + 512], ymm0
	vmovdqu	ymmword ptr [rdi + r14 + 544], ymm1
	vmovups	ymmword ptr [rdi + r14 + 576], ymm3
	vmovups	ymmword ptr [rdi + r14 + 608], ymm4
	sub	r14, -128
	cmp	rbp, r14
	jne	42b
	cmp	rbx, r12
	mov	rdi, qword ptr [rsp + 56]
	mov	rbp, qword ptr [rsp + 16]
	mov	r14, qword ptr [rsp + 40]
	je	92f
	test	bl, 112
	je	72f
52:
	mov	r8, rbx
	and	r8, -16
	lea	r15, [r14 + r8]
	add	r14, rcx
	add	r11, qword ptr [rsp + 80]
	and	r11, -16
	mov	rdi, qword ptr [rsp + 56]
	.p2align	4
62:
	vmovups	xmm0, xmmword ptr [r14 + r12]
	vmovups	xmmword ptr [rdi + r12], xmm0
	add	r12, 16
	cmp	r11, r12
	jne	62b
	cmp	rbx, r8
	je	92f
	.p2align	4
72:
	mov	r8, qword ptr [rsp + 104]
	.p2align	4
82:
	movzx	edi, byte ptr [rcx + r15]
	mov	byte ptr [r8 + r15], dil
	inc	r15
	cmp	r10, r15
	jne	82b
	mov	rdi, qword ptr [rsp + 56]
92:
	vmovdqu	ymm3, ymmword ptr [rdi]
	vmovdqu	ymm4, ymmword ptr [rdi + 32]
	vmovd	xmm0, dword ptr [rsp + 72]
	vpbroadcastb	ymm1, xmm0
	vpmaxub	ymm0, ymm1, ymmword ptr [rip + 882f]
	vpcmpeqb	ymm0, ymm1, ymm0
	vpmaxub	ymm5, ymm1, ymmword ptr [rip + 892f]
	vpcmpeqb	ymm1, ymm1, ymm5
	vpsllw	ymm5, ymm3, 6
	vpcmpgtb	ymm8, ymm13, ymm5
	vpsllw	ymm5, ymm4, 6
	vpcmpgtb	ymm9, ymm13, ymm5
	vpbroadcastb	ymm2, byte ptr [rip + 902f]
	vpand	ymm3, ymm3, ymm2
	vpand	ymm4, ymm4, ymm2
	vpcmpeqb	ymm5, ymm13, ymm4
	vpcmpeqb	ymm3, ymm13, ymm3
	movabs	r14, 72340172838076673
	mov	rbx, r14
	#APP
	#NO_APP
	vpand	ymm4, ymm8, ymm2
	vpand	ymm8, ymm0, ymm4
	vpand	ymm4, ymm9, ymm2
	vpand	ymm4, ymm1, ymm4
	mov	r12, qword ptr [rsp + 32]
	vmovdqu	ymmword ptr [r12 + 544], ymm4
	vmovdqu	ymmword ptr [r12 + 512], ymm8
	vmovq	rcx, xmm8
	mov	r8, rcx
	imul	r8, rbx
	mov	rdi, r8
	sub	rdi, rcx
	xor	rcx, rbx
	shl	rcx, 7
	or	rcx, rdi
	vmovq	xmm9, qword ptr [r13 + rsi]
	vmovq	xmm10, rcx
	vpshufb	xmm9, xmm9, xmm10
	shr	r8, 56
	add	r8, rsi
	vmovq	qword ptr [r12 + 512], xmm9
	vpextrq	rsi, xmm8, 1
	mov	rcx, rsi
	imul	rcx, rbx
	mov	rdi, rcx
	sub	rdi, rsi
	xor	rsi, rbx
	shl	rsi, 7
	or	rsi, rdi
	vmovq	xmm9, qword ptr [r13 + r8]
	vmovq	xmm10, rsi
	vpshufb	xmm9, xmm9, xmm10
	shr	rcx, 56
	add	rcx, r8
	vmovq	qword ptr [r12 + 520], xmm9
	vextracti128	xmm8, ymm8, 1
	vmovq	rdi, xmm8
	mov	rsi, rdi
	imul	rsi, rbx
	mov	r8, rsi
	sub	r8, rdi
	xor	rdi, rbx
	shl	rdi, 7
	or	rdi, r8
	vmovq	xmm9, qword ptr [r13 + rcx]
	vmovq	xmm10, rdi
	vpshufb	xmm9, xmm9, xmm10
	shr	rsi, 56
	add	rsi, rcx
	vmovq	qword ptr [r12 + 528], xmm9
	vpextrq	rdi, xmm8, 1
	mov	rcx, rdi
	imul	rcx, rbx
	mov	r8, rcx
	sub	r8, rdi
	xor	rdi, rbx
	shl	rdi, 7
	or	rdi, r8
	vmovq	xmm8, qword ptr [r13 + rsi]
	vmovq	xmm9, rdi
	vpshufb	xmm8, xmm8, xmm9
	shr	rcx, 56
	add	rcx, rsi
	vmovq	qword ptr [r12 + 536], xmm8
	vmovq	rdi, xmm4
	mov	rsi, rdi
	imul	rsi, rbx
	mov	r8, rsi
	sub	r8, rdi
	xor	rdi, rbx
	shl	rdi, 7
	or	rdi, r8
	vmovq	xmm8, qword ptr [r13 + rcx]
	vmovq	xmm9, rdi
	vpshufb	xmm8, xmm8, xmm9
	shr	rsi, 56
	add	rsi, rcx
	vmovq	qword ptr [r12 + 544], xmm8
	vpextrq	rdi, xmm4, 1
	mov	rcx, rdi
	imul	rcx, rbx
	mov	r8, rcx
	sub	r8, rdi
	xor	rdi, rbx
	shl	rdi, 7
	or	rdi, r8
	vmovq	xmm4, qword ptr [r13 + rsi]
	vmovq	xmm8, rdi
	vpshufb	xmm4, xmm4, xmm8
	shr	rcx, 56
	add	rcx, rsi
	vmovq	qword ptr [r12 + 552], xmm4
	mov	rsi, qword ptr [r12 + 560]
	mov	rdi, qword ptr [r12 + 568]
	mov	r10, rsi
	imul	r10, rbx
	mov	r8, r10
	sub	r8, rsi
	xor	rsi, rbx
	shl	rsi, 7
	or	rsi, r8
	vmovq	xmm4, qword ptr [r13 + rcx]
	vmovq	xmm8, rsi
	vpshufb	xmm4, xmm4, xmm8
	shr	r10, 56
	add	r10, rcx
	vmovq	qword ptr [r12 + 560], xmm4
	mov	r11, rdi
	imul	r11, rbx
	mov	rcx, r11
	sub	rcx, rdi
	xor	rbx, rdi
	shl	rbx, 7
	or	rbx, rcx
	vmovq	xmm4, qword ptr [r13 + r10]
	vmovq	xmm8, rbx
	vpshufb	xmm4, xmm4, xmm8
	vmovq	qword ptr [r12 + 568], xmm4
	vmovups	ymm4, ymmword ptr [r12 + 544]
	vmovups	ymm8, ymmword ptr [r12 + 512]
	vmovups	ymmword ptr [r12 + 192], ymm8
	vmovups	ymmword ptr [r12 + 224], ymm4
	mov	rsi, r14
	#APP
	#NO_APP
	vpand	ymm4, ymm5, ymm2
	vpand	ymm1, ymm1, ymm4
	vpand	ymm3, ymm3, ymm2
	vpand	ymm0, ymm0, ymm3
	vmovdqu	ymmword ptr [r12 + 512], ymm0
	vmovdqu	ymmword ptr [r12 + 544], ymm1
	vmovq	rcx, xmm0
	mov	r8, rsi
	imul	r8, rcx
	mov	rdi, r8
	sub	rdi, rcx
	xor	rcx, rsi
	shl	rcx, 7
	or	rcx, rdi
	mov	rdi, qword ptr [rsp + 112]
	vmovq	xmm3, qword ptr [rdx + rdi]
	vmovq	xmm4, rcx
	vpshufb	xmm3, xmm3, xmm4
	shr	r8, 56
	add	r8, rdi
	vmovq	qword ptr [r12 + 512], xmm3
	vpextrq	rdi, xmm0, 1
	mov	rcx, rsi
	imul	rcx, rdi
	mov	rbx, rcx
	sub	rbx, rdi
	xor	rdi, rsi
	shl	rdi, 7
	or	rdi, rbx
	vmovq	xmm3, qword ptr [rdx + r8]
	vmovq	xmm4, rdi
	vpshufb	xmm3, xmm3, xmm4
	shr	rcx, 56
	add	rcx, r8
	vmovq	qword ptr [r12 + 520], xmm3
	vextracti128	xmm0, ymm0, 1
	vmovq	rdi, xmm0
	mov	r8, rsi
	imul	r8, rdi
	mov	rbx, r8
	sub	rbx, rdi
	xor	rdi, rsi
	shl	rdi, 7
	or	rdi, rbx
	vmovq	xmm3, qword ptr [rdx + rcx]
	vmovq	xmm4, rdi
	vpshufb	xmm3, xmm3, xmm4
	shr	r8, 56
	add	r8, rcx
	vmovq	qword ptr [r12 + 528], xmm3
	vpextrq	rdi, xmm0, 1
	mov	rcx, rsi
	imul	rcx, rdi
	mov	rbx, rcx
	sub	rbx, rdi
	xor	rdi, rsi
	shl	rdi, 7
	or	rdi, rbx
	vmovq	xmm0, qword ptr [rdx + r8]
	vmovq	xmm3, rdi
	vpshufb	xmm0, xmm0, xmm3
	shr	rcx, 56
	add	rcx, r8
	vmovq	qword ptr [r12 + 536], xmm0
	vmovq	rdi, xmm1
	mov	r8, rsi
	imul	r8, rdi
	mov	rbx, r8
	sub	rbx, rdi
	xor	rdi, rsi
	shl	rdi, 7
	or	rdi, rbx
	vmovq	xmm0, qword ptr [rdx + rcx]
	vmovq	xmm3, rdi
	vpshufb	xmm0, xmm0, xmm3
	shr	r8, 56
	add	r8, rcx
	vmovq	qword ptr [r12 + 544], xmm0
	vpextrq	rdi, xmm1, 1
	mov	rcx, rsi
	imul	rcx, rdi
	mov	rbx, rcx
	sub	rbx, rdi
	xor	rdi, rsi
	shl	rdi, 7
	or	rdi, rbx
	vmovq	xmm0, qword ptr [rdx + r8]
	vmovq	xmm1, rdi
	vpshufb	xmm0, xmm0, xmm1
	shr	rcx, 56
	add	rcx, r8
	vmovq	qword ptr [r12 + 552], xmm0
	mov	rdi, qword ptr [r12 + 560]
	mov	r8, qword ptr [r12 + 568]
	mov	r14, rdi
	imul	r14, rsi
	mov	rbx, r14
	sub	rbx, rdi
	xor	rdi, rsi
	shl	rdi, 7
	or	rdi, rbx
	vmovq	xmm0, qword ptr [rdx + rcx]
	vmovq	xmm1, rdi
	vpshufb	xmm0, xmm0, xmm1
	shr	r14, 56
	add	r14, rcx
	vmovq	qword ptr [r12 + 560], xmm0
	mov	r13, r8
	imul	r13, rsi
	mov	rcx, r13
	sub	rcx, r8
	xor	rsi, r8
	shl	rsi, 7
	or	rsi, rcx
	vmovq	xmm0, qword ptr [rdx + r14]
	vmovq	xmm1, rsi
	vpshufb	xmm0, xmm0, xmm1
	vmovq	qword ptr [r12 + 568], xmm0
	vmovdqu	ymm7, ymmword ptr [r12 + 512]
	vmovups	ymm0, ymmword ptr [r12 + 544]
	vmovups	ymmword ptr [rsp + 464], ymm0
	vmovss	xmm0, dword ptr [rsp + 144]
	vbroadcastss	ymm0, xmm0
	vmovups	ymmword ptr [rsp + 144], ymm0
	vpmovzxbd	ymm3, qword ptr [r12 + 520]
	vpmovzxbd	ymm8, qword ptr [r12 + 512]
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
	mov	r15, qword ptr [rsp + 8]
	mov	ecx, r15d
	and	ecx, 7
	vmovd	xmm9, ecx
	vpbroadcastd	ymm9, xmm9
	vpaddd	ymm4, ymm9, ymm4
	vpaddd	ymm9, ymm9, ymm5
	vpsrld	ymm14, ymm4, 3
	vpsrld	ymm15, ymm9, 3
	vpand	ymm11, ymm4, ymm1
	vpand	ymm5, ymm9, ymm1
	vbroadcasti128	ymm1, xmmword ptr [rip + 912f]
	vpshufb	ymm4, ymm14, ymm1
	vpshufb	ymm9, ymm15, ymm1
	vmovdqu	ymm1, ymmword ptr [rsp + 336]
	vpaddb	ymm4, ymm4, ymm1
	vpaddb	ymm9, ymm9, ymm1
	mov	rcx, r15
	shr	rcx, 3
	lea	rdx, [rcx + 64]
	cmp	rdx, rax
	vmovdqu	ymmword ptr [rsp + 496], ymm7
	vmovdqu	ymmword ptr [rsp + 112], ymm3
	vmovdqu	ymmword ptr [rsp + 176], ymm2
	vmovdqu	ymmword ptr [rsp + 272], ymm11
	vmovdqa	ymm11, ymm6
	jbe	102f
	mov	rdx, rax
	sub	rdx, rcx
	mov	rdi, qword ptr [rsp]
	jbe	172f
	cmp	rdx, 16
	mov	rsi, rcx
	jb	152f
	lea	rbx, [rcx + r9]
	mov	rsi, r12
	sub	rsi, rbx
	add	rsi, 575
	cmp	rsi, 127
	mov	rsi, rcx
	jb	152f
	cmp	rdx, 128
	jae	112f
	xor	r8d, r8d
	jmp	132f
	.p2align	4
102:
	add	rcx, r9
	mov	rdi, rcx
	jmp	172f
112:
	mov	r8, rdx
	and	r8, -128
	lea	rsi, [rcx + r8]
	lea	r15, [r9 + rcx + 96]
	mov	rbp, r12
	xor	r12d, r12d
	.p2align	4
122:
	vmovdqu	ymm14, ymmword ptr [r15 + r12 - 96]
	vmovdqu	ymm15, ymmword ptr [r15 + r12 - 64]
	vmovdqu	ymm6, ymmword ptr [r15 + r12 - 32]
	vmovdqu	ymm7, ymmword ptr [r15 + r12]
	vmovdqu	ymmword ptr [rbp + r12 + 576], ymm14
	vmovdqu	ymmword ptr [rbp + r12 + 608], ymm15
	vmovdqu	ymmword ptr [rbp + r12 + 640], ymm6
	vmovdqu	ymmword ptr [rbp + r12 + 672], ymm7
	sub	r12, -128
	cmp	r8, r12
	jne	122b
	cmp	rdx, r8
	mov	rdi, qword ptr [rsp]
	mov	r12, rbp
	mov	rbp, qword ptr [rsp + 16]
	mov	r15, qword ptr [rsp + 8]
	je	172f
	test	dl, 112
	je	152f
132:
	mov	r15, rdx
	and	r15, -16
	lea	rsi, [rcx + r15]
	mov	rdi, qword ptr [rsp]
	.p2align	4
142:
	vmovdqu	xmm6, xmmword ptr [rbx + r8]
	vmovdqu	xmmword ptr [rdi + r8], xmm6
	add	r8, 16
	cmp	r15, r8
	jne	142b
	cmp	rdx, r15
	mov	r15, qword ptr [rsp + 8]
	je	172f
	.p2align	4
152:
	mov	rdi, qword ptr [rsp]
	mov	rdx, rdi
	sub	rdx, rcx
	.p2align	4
162:
	movzx	ecx, byte ptr [r9 + rsi]
	mov	byte ptr [rdx + rsi], cl
	inc	rsi
	cmp	rax, rsi
	jne	162b
172:
	vmovdqu	ymm6, ymmword ptr [rdi]
	vmovdqu	ymm7, ymmword ptr [rdi + 32]
	vpermq	ymm14, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm15, ymm14, ymm4
	vpshufb	ymm2, ymm6, ymm4
	vpbroadcastb	ymm3, byte ptr [rip + 922f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 932f]
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
	vmovdqu	ymm0, ymmword ptr [rsp + 176]
	vpandn	ymm1, ymm0, ymm1
	vpaddd	ymm1, ymm1, ymmword ptr [rsp + 112]
	vpor	ymm3, ymm1, ymmword ptr [rip + 942f]
	vpcmpeqd	ymm1, ymm13, ymm1
	vpandn	ymm1, ymm1, ymm3
	vpor	ymm3, ymm2, ymmword ptr [rip + 952f]
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
	vmovups	ymm0, ymmword ptr [rsp + 144]
	vblendvps	ymm1, ymm2, ymm0, ymm1
	vpand	ymm2, ymm3, ymm4
	vpcmpeqd	ymm3, ymm13, ymm3
	vblendvps	ymm0, ymm2, ymm0, ymm3
	vextracti128	xmm2, ymm12, 1
	vpextrd	ecx, xmm2, 3
	vmovups	ymmword ptr [r12 + 256], ymm0
	vmovups	ymmword ptr [r12 + 288], ymm1
	vshufps	ymm0, ymm1, ymm1, 255
	vpermpd	ymm0, ymm0, 170
	add	r15, rcx
	cmp	qword ptr [rsp + 208], 17
	jb	422f
	vmovups	ymmword ptr [rsp + 144], ymm0
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
	mov	ecx, r15d
	and	ecx, 7
	vmovd	xmm5, ecx
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm4, ymm5, ymm4
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm6, ymm4, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm5, ymm8, ymm4
	vpand	ymm8, ymm8, ymm2
	vbroadcasti128	ymm4, xmmword ptr [rip + 912f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm6, ymm7, ymm4
	vmovdqu	ymm7, ymmword ptr [rsp + 336]
	vpaddb	ymm4, ymm2, ymm7
	vpaddb	ymm9, ymm6, ymm7
	mov	rcx, r15
	shr	rcx, 3
	lea	rdx, [rcx + 64]
	cmp	rdx, rax
	vmovdqu	ymmword ptr [rsp + 112], ymm3
	vmovdqu	ymmword ptr [rsp + 176], ymm5
	vmovdqu	ymmword ptr [rsp + 272], ymm8
	vmovdqa	ymm5, ymm10
	jbe	182f
	mov	rdx, rax
	sub	rdx, rcx
	mov	rdi, qword ptr [rsp]
	jbe	252f
	cmp	rdx, 16
	mov	rsi, rcx
	jb	232f
	lea	rbx, [rcx + r9]
	mov	rsi, r12
	sub	rsi, rbx
	add	rsi, 575
	cmp	rsi, 127
	mov	rsi, rcx
	jb	232f
	cmp	rdx, 128
	mov	qword ptr [rsp + 8], r15
	jae	192f
	xor	r8d, r8d
	jmp	212f
	.p2align	4
182:
	add	rcx, r9
	mov	rdi, rcx
	jmp	252f
192:
	mov	r8, rdx
	and	r8, -128
	lea	rsi, [rcx + r8]
	lea	r15, [r9 + rcx + 96]
	mov	rbp, r12
	xor	r12d, r12d
	.p2align	4
202:
	vmovdqu	ymm2, ymmword ptr [r15 + r12 - 96]
	vmovdqu	ymm6, ymmword ptr [r15 + r12 - 64]
	vmovdqu	ymm7, ymmword ptr [r15 + r12 - 32]
	vmovdqu	ymm13, ymmword ptr [r15 + r12]
	vmovdqu	ymmword ptr [rbp + r12 + 576], ymm2
	vmovdqu	ymmword ptr [rbp + r12 + 608], ymm6
	vmovdqu	ymmword ptr [rbp + r12 + 640], ymm7
	vmovdqu	ymmword ptr [rbp + r12 + 672], ymm13
	sub	r12, -128
	cmp	r8, r12
	jne	202b
	cmp	rdx, r8
	mov	rdi, qword ptr [rsp]
	mov	r12, rbp
	mov	rbp, qword ptr [rsp + 16]
	mov	r15, qword ptr [rsp + 8]
	je	252f
	test	dl, 112
	je	232f
212:
	mov	r15, rdx
	and	r15, -16
	lea	rsi, [rcx + r15]
	mov	rdi, qword ptr [rsp]
	.p2align	4
222:
	vmovdqu	xmm2, xmmword ptr [rbx + r8]
	vmovdqu	xmmword ptr [rdi + r8], xmm2
	add	r8, 16
	cmp	r15, r8
	jne	222b
	cmp	rdx, r15
	mov	r15, qword ptr [rsp + 8]
	je	252f
232:
	mov	rdi, qword ptr [rsp]
	mov	rdx, rdi
	sub	rdx, rcx
	.p2align	4
242:
	movzx	ecx, byte ptr [r9 + rsi]
	mov	byte ptr [rdx + rsi], cl
	inc	rsi
	cmp	rax, rsi
	jne	242b
252:
	vmovdqu	ymm2, ymmword ptr [rdi]
	vmovdqu	ymm6, ymmword ptr [rdi + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm13, ymm7, ymm4
	vpshufb	ymm14, ymm2, ymm4
	vpbroadcastb	ymm3, byte ptr [rip + 922f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 932f]
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
	vpsrlvd	ymm3, ymm4, ymmword ptr [rsp + 176]
	vpandn	ymm3, ymm0, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 112]
	vpor	ymm4, ymm3, ymmword ptr [rip + 942f]
	vpcmpeqd	ymm3, ymm13, ymm3
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 952f]
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
	vmovups	ymm0, ymmword ptr [rsp + 144]
	vblendvps	ymm2, ymm3, ymm0, ymm2
	vpand	ymm3, ymm4, ymm5
	vpcmpeqd	ymm4, ymm13, ymm4
	vblendvps	ymm0, ymm3, ymm0, ymm4
	vextracti128	xmm1, ymm1, 1
	vpextrd	ecx, xmm1, 3
	vmovups	ymmword ptr [r12 + 320], ymm0
	vmovups	ymmword ptr [r12 + 352], ymm2
	vshufps	ymm0, ymm2, ymm2, 255
	vpermpd	ymm0, ymm0, 170
	add	r15, rcx
	cmp	qword ptr [rsp + 208], 33
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
	vmovdqu	ymmword ptr [rsp + 112], ymm2
	vpsllvd	ymm1, ymm1, ymm4
	vmovdqu	ymmword ptr [rsp + 144], ymm1
	vpsllvd	ymm1, ymm7, ymm5
	vmovdqu	ymmword ptr [rsp + 272], ymm1
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
	mov	ecx, r15d
	and	ecx, 7
	vmovd	xmm5, ecx
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm4, ymm5, ymm4
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm6, ymm4, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm5, ymm8, ymm4
	vpand	ymm11, ymm8, ymm2
	vbroadcasti128	ymm4, xmmword ptr [rip + 912f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm6, ymm7, ymm4
	vmovdqu	ymm7, ymmword ptr [rsp + 336]
	vpaddb	ymm4, ymm2, ymm7
	vpaddb	ymm9, ymm6, ymm7
	mov	rcx, r15
	shr	rcx, 3
	lea	rdx, [rcx + 64]
	cmp	rdx, rax
	jbe	262f
	mov	rdx, rax
	sub	rdx, rcx
	mov	rdi, qword ptr [rsp]
	jbe	332f
	cmp	rdx, 16
	mov	rsi, rcx
	jb	312f
	lea	rbx, [rcx + r9]
	mov	rsi, r12
	sub	rsi, rbx
	add	rsi, 575
	cmp	rsi, 127
	mov	rsi, rcx
	jb	312f
	cmp	rdx, 128
	mov	qword ptr [rsp + 8], r15
	jae	272f
	xor	r8d, r8d
	jmp	292f
262:
	add	rcx, r9
	mov	rdi, rcx
	jmp	332f
272:
	mov	r8, rdx
	and	r8, -128
	lea	rsi, [rcx + r8]
	lea	r15, [r9 + rcx + 96]
	mov	rbp, r12
	xor	r12d, r12d
	.p2align	4
282:
	vmovdqu	ymm2, ymmword ptr [r15 + r12 - 96]
	vmovdqu	ymm6, ymmword ptr [r15 + r12 - 64]
	vmovdqu	ymm7, ymmword ptr [r15 + r12 - 32]
	vmovdqu	ymm13, ymmword ptr [r15 + r12]
	vmovdqu	ymmword ptr [rbp + r12 + 576], ymm2
	vmovdqu	ymmword ptr [rbp + r12 + 608], ymm6
	vmovdqu	ymmword ptr [rbp + r12 + 640], ymm7
	vmovdqu	ymmword ptr [rbp + r12 + 672], ymm13
	sub	r12, -128
	cmp	r8, r12
	jne	282b
	cmp	rdx, r8
	mov	rdi, qword ptr [rsp]
	mov	r12, rbp
	mov	rbp, qword ptr [rsp + 16]
	mov	r15, qword ptr [rsp + 8]
	je	332f
	test	dl, 112
	je	312f
292:
	mov	r15, rdx
	and	r15, -16
	lea	rsi, [rcx + r15]
	mov	rdi, qword ptr [rsp]
	.p2align	4
302:
	vmovdqu	xmm2, xmmword ptr [rbx + r8]
	vmovdqu	xmmword ptr [rdi + r8], xmm2
	add	r8, 16
	cmp	r15, r8
	jne	302b
	cmp	rdx, r15
	mov	r15, qword ptr [rsp + 8]
	je	332f
312:
	mov	rdi, qword ptr [rsp]
	mov	rdx, rdi
	sub	rdx, rcx
	.p2align	4
322:
	movzx	ecx, byte ptr [r9 + rsi]
	mov	byte ptr [rdx + rsi], cl
	inc	rsi
	cmp	rax, rsi
	jne	322b
332:
	vmovdqu	ymm2, ymmword ptr [rdi]
	vmovdqu	ymm6, ymmword ptr [rdi + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm13, ymm7, ymm4
	vpshufb	ymm14, ymm2, ymm4
	vpbroadcastb	ymm3, byte ptr [rip + 922f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 932f]
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
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 112]
	vpsrlvd	ymm3, ymm4, ymm5
	vmovdqu	ymm4, ymmword ptr [rsp + 176]
	vpandn	ymm3, ymm4, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 144]
	vpor	ymm4, ymm3, ymmword ptr [rip + 942f]
	vpcmpeqd	ymm3, ymm13, ymm3
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 952f]
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
	vpextrd	ecx, xmm1, 3
	vmovups	ymmword ptr [r12 + 384], ymm0
	vmovups	ymmword ptr [r12 + 416], ymm2
	vshufps	ymm0, ymm2, ymm2, 255
	vpermpd	ymm0, ymm0, 170
	add	r15, rcx
	cmp	qword ptr [rsp + 208], 49
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
	vmovdqu	ymmword ptr [rsp + 144], ymm1
	vpsllvd	ymm1, ymm2, ymm4
	vmovdqu	ymmword ptr [rsp + 208], ymm1
	vpsllvd	ymm1, ymm7, ymm5
	vmovdqu	ymmword ptr [rsp + 176], ymm1
	vpsllvd	ymm1, ymm7, ymm4
	vmovdqu	ymmword ptr [rsp + 112], ymm1
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
	mov	ecx, r15d
	and	ecx, 7
	vmovd	xmm5, ecx
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm4, ymm5, ymm4
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm6, ymm4, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm5, ymm8, ymm4
	vpand	ymm11, ymm8, ymm2
	vbroadcasti128	ymm4, xmmword ptr [rip + 912f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm6, ymm7, ymm4
	vmovdqu	ymm7, ymmword ptr [rsp + 336]
	vpaddb	ymm4, ymm2, ymm7
	vpaddb	ymm9, ymm6, ymm7
	mov	rcx, r15
	shr	rcx, 3
	lea	rdx, [rcx + 64]
	cmp	rdx, rax
	jbe	342f
	mov	rdx, rax
	sub	rdx, rcx
	mov	rdi, qword ptr [rsp]
	jbe	412f
	cmp	rdx, 16
	mov	rsi, rcx
	jb	392f
	lea	rbx, [rcx + r9]
	mov	rsi, r12
	sub	rsi, rbx
	add	rsi, 575
	cmp	rsi, 127
	mov	rsi, rcx
	jb	392f
	cmp	rdx, 128
	mov	qword ptr [rsp + 8], r15
	jae	352f
	xor	r8d, r8d
	jmp	372f
342:
	add	r9, rcx
	mov	rdi, r9
	jmp	412f
352:
	mov	r8, rdx
	and	r8, -128
	lea	rsi, [rcx + r8]
	lea	r15, [r9 + rcx + 96]
	mov	rbp, r12
	xor	r12d, r12d
	.p2align	4
362:
	vmovdqu	ymm2, ymmword ptr [r15 + r12 - 96]
	vmovdqu	ymm6, ymmword ptr [r15 + r12 - 64]
	vmovdqu	ymm7, ymmword ptr [r15 + r12 - 32]
	vmovdqu	ymm13, ymmword ptr [r15 + r12]
	vmovdqu	ymmword ptr [rbp + r12 + 576], ymm2
	vmovdqu	ymmword ptr [rbp + r12 + 608], ymm6
	vmovdqu	ymmword ptr [rbp + r12 + 640], ymm7
	vmovdqu	ymmword ptr [rbp + r12 + 672], ymm13
	sub	r12, -128
	cmp	r8, r12
	jne	362b
	cmp	rdx, r8
	mov	rdi, qword ptr [rsp]
	mov	r12, rbp
	mov	rbp, qword ptr [rsp + 16]
	mov	r15, qword ptr [rsp + 8]
	je	412f
	test	dl, 112
	je	392f
372:
	mov	r15, rdx
	and	r15, -16
	lea	rsi, [rcx + r15]
	mov	rdi, qword ptr [rsp]
	.p2align	4
382:
	vmovdqu	xmm2, xmmword ptr [rbx + r8]
	vmovdqu	xmmword ptr [rdi + r8], xmm2
	add	r8, 16
	cmp	r15, r8
	jne	382b
	cmp	rdx, r15
	mov	r15, qword ptr [rsp + 8]
	je	412f
392:
	mov	rdi, qword ptr [rsp]
	mov	rdx, rdi
	sub	rdx, rcx
	.p2align	4
402:
	movzx	ecx, byte ptr [r9 + rsi]
	mov	byte ptr [rdx + rsi], cl
	inc	rsi
	cmp	rax, rsi
	jne	402b
412:
	vmovdqu	ymm2, ymmword ptr [rdi]
	vmovdqu	ymm6, ymmword ptr [rdi + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm13, ymm7, ymm4
	vpshufb	ymm14, ymm2, ymm4
	vpbroadcastb	ymm3, byte ptr [rip + 922f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 932f]
	vpand	ymm7, ymm9, ymm3
	vpcmpeqb	ymm7, ymm7, ymm3
	vpblendvb	ymm2, ymm2, ymm6, ymm7
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm4, ymm13, ymm8, ymm4
	vpxor	xmm13, xmm13, xmm13
	vpsrlvd	ymm2, ymm2, ymm11
	vmovdqu	ymm3, ymmword ptr [rsp + 176]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 144]
	vpsrlvd	ymm3, ymm4, ymm5
	vmovdqu	ymm4, ymmword ptr [rsp + 112]
	vpandn	ymm3, ymm4, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 208]
	vpor	ymm4, ymm3, ymmword ptr [rip + 942f]
	vpcmpeqd	ymm3, ymm13, ymm3
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 952f]
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
	vmovups	ymmword ptr [r12 + 448], ymm0
	vmovups	ymmword ptr [r12 + 480], ymm2
	vshufps	ymm0, ymm2, ymm2, 255
	vpermpd	ymm0, ymm0, 170
	add	r15, rax
	.p2align	4
422:
	mov	rdi, qword ptr [rsp + 64]
	shr	r13, 56
	add	r13, r14
	shr	r11, 56
	add	r11, r10
	vmovd	eax, xmm0
	mov	qword ptr [r12 + 72], r15
	mov	qword ptr [r12 + 96], rax
	mov	qword ptr [r12 + 128], r11
	mov	qword ptr [r12 + 136], r13
	mov	r14, qword ptr [rsp + 40]
	add	r14, qword ptr [rsp + 248]
	mov	r13, qword ptr [rsp + 72]
	and	r13, 124
	je	722f
	xor	edx, edx
	mov	r9, qword ptr [rsp + 24]
	mov	r15, qword ptr [rsp + 48]
	mov	qword ptr [rsp + 40], r14
	mov	qword ptr [rsp + 208], r13
	.p2align	4
432:
	movzx	r11d, byte ptr [r14 + rdx]
	movzx	eax, byte ptr [r12 + rdx + 192]
	cmp	rdi, 33
	mov	ecx, 32
	cmovb	rdi, rcx
	mov	rsi, r9
	sub	rsi, rbp
	cmp	rdi, rsi
	cmovb	rsi, rdi
	neg	rsi
	cmp	rax, 33
	mov	ecx, dword ptr [r12 + 4*rdx + 256]
	vmovdqu	ymm0, ymmword ptr [r9 + rsi]
	vpaddb	ymm0, ymm0, ymmword ptr [r15]
	vmovdqu	ymmword ptr [r9], ymm0
	jae	522f
442:
	lea	rsi, [r9 + rax]
	mov	r10d, r11d
	shr	r10d, 2
	cmp	r10, 32
	mov	ebx, 32
	cmovb	rbx, r10
	cmp	rcx, rbx
	cmova	rbx, rcx
	mov	r8, rsi
	sub	r8, rbx
	cmp	r8, rbp
	jl	542f
	vmovups	ymm0, ymmword ptr [r8]
	vmovups	ymmword ptr [rsi], ymm0
	cmp	r11b, -124
	jae	552f
452:
	lea	rdi, [rdx + 1]
	lea	r8, [rsi + r10]
	cmp	rcx, 33
	mov	r11d, 32
	cmovb	rcx, r11
	mov	r11, r8
	sub	r11, rbp
	cmp	rcx, r11
	cmovb	r11, rcx
	mov	rbx, r8
	sub	rbx, r11
	movzx	ecx, byte ptr [r14 + rdi]
	vmovdqu	ymm0, ymmword ptr [rbx]
	movzx	r14d, byte ptr [r12 + rdi + 192]
	mov	ebx, dword ptr [r12 + 4*rdi + 256]
	vpaddb	ymm0, ymm0, ymmword ptr [r15 + rax]
	vmovdqu	ymmword ptr [rsi + r10], ymm0
	lea	r11, [r15 + rax]
	cmp	r14, 33
	jae	572f
462:
	mov	qword ptr [rsp + 48], r15
	mov	qword ptr [rsp + 24], r9
	add	r8, r14
	mov	r13d, ecx
	shr	r13d, 2
	cmp	r13, 32
	mov	r15d, 32
	cmovb	r15, r13
	cmp	rbx, r15
	cmova	r15, rbx
	mov	rsi, r8
	sub	rsi, r15
	cmp	rsi, rbp
	jl	592f
	vmovups	ymm0, ymmword ptr [rsi]
	vmovups	ymmword ptr [r8], ymm0
	cmp	cl, -124
	jae	602f
472:
	lea	rdi, [rdx + 2]
	lea	rcx, [r8 + r13]
	mov	rsi, qword ptr [rsp + 40]
	movzx	ebp, byte ptr [rsi + rdi]
	movzx	esi, byte ptr [r12 + rdi + 192]
	cmp	rbx, 33
	mov	r9d, 32
	cmovb	rbx, r9
	mov	r15, rcx
	mov	r9, qword ptr [rsp + 16]
	sub	r15, r9
	cmp	rbx, r15
	cmovb	r15, rbx
	mov	rbx, rcx
	sub	rbx, r15
	cmp	rsi, 33
	mov	r15d, dword ptr [r12 + 4*rdi + 256]
	vmovdqu	ymm0, ymmword ptr [rbx]
	vpaddb	ymm0, ymm0, ymmword ptr [r11 + r14]
	vmovdqu	ymmword ptr [r8 + r13], ymm0
	jae	622f
482:
	add	rcx, rsi
	mov	r12d, ebp
	shr	r12d, 2
	cmp	r12, 32
	mov	ebx, 32
	cmovb	rbx, r12
	cmp	r15, rbx
	cmova	rbx, r15
	mov	r8, rcx
	sub	r8, rbx
	cmp	r8, r9
	jl	642f
	vmovups	ymm0, ymmword ptr [r8]
	vmovups	ymmword ptr [rcx], ymm0
	cmp	bpl, -124
	jae	652f
492:
	mov	qword ptr [rsp + 8], rax
	add	r11, r14
	lea	rdi, [rdx + 3]
	lea	rbx, [rcx + r12]
	cmp	r15, 33
	mov	r8d, 32
	cmovb	r15, r8
	mov	r8, rbx
	mov	r9, qword ptr [rsp + 16]
	sub	r8, r9
	cmp	r15, r8
	cmovb	r8, r15
	mov	r15, rbx
	sub	r15, r8
	mov	r8, qword ptr [rsp + 40]
	movzx	ebp, byte ptr [r8 + rdi]
	vmovdqu	ymm0, ymmword ptr [r15]
	mov	r8, qword ptr [rsp + 32]
	movzx	r15d, byte ptr [r8 + rdi + 192]
	mov	r8d, dword ptr [r8 + 4*rdi + 256]
	vpaddb	ymm0, ymm0, ymmword ptr [r11 + rsi]
	vmovdqu	ymmword ptr [rcx + r12], ymm0
	cmp	r15, 33
	jae	672f
502:
	add	rbx, r15
	mov	ecx, ebp
	shr	ecx, 2
	cmp	rcx, 32
	mov	edi, 32
	cmovb	rdi, rcx
	cmp	r8, rdi
	mov	rax, r8
	cmova	rdi, r8
	mov	r8, rbx
	sub	r8, rdi
	cmp	r8, r9
	jl	692f
	vmovups	ymm0, ymmword ptr [r8]
	vmovups	ymmword ptr [rbx], ymm0
	cmp	bpl, -124
	jae	702f
512:
	add	r11, rsi
	add	rbx, rcx
	add	r11, r15
	add	rdx, 4
	mov	r13, qword ptr [rsp + 208]
	cmp	rdx, r13
	mov	r15, r11
	mov	r9, rbx
	mov	r12, qword ptr [rsp + 32]
	mov	rbp, qword ptr [rsp + 16]
	mov	r14, qword ptr [rsp + 40]
	mov	rdi, rax
	jb	432b
	jmp	732f
522:
	mov	rsi, qword ptr [r12 + 48]
	mov	rdi, qword ptr [r12 + 120]
	movzx	eax, byte ptr [rsi + rdi]
	inc	rdi
	mov	qword ptr [r12 + 120], rdi
	add	rax, 33
	mov	esi, 32
	.p2align	4
532:
	vmovdqu	ymm0, ymmword ptr [r15 + rsi]
	vmovdqu	ymmword ptr [r9 + rsi], ymm0
	add	rsi, 32
	cmp	rsi, rax
	jb	532b
	jmp	442b
542:
	mov	rdi, rsi
	sub	rdi, rbp
	sub	rdi, rbx
	mov	r8d, 0
	cmovae	r8, rdi
	add	r8, rbp
	vmovups	ymm0, ymmword ptr [r8]
	vmovups	ymmword ptr [rsi], ymm0
	cmp	r11b, -124
	jb	452b
552:
	mov	rdi, qword ptr [r12 + 48]
	mov	r11, qword ptr [r12 + 120]
	movzx	r10d, byte ptr [rdi + r11]
	inc	r11
	mov	qword ptr [r12 + 120], r11
	add	r10, 33
	mov	edi, 32
	.p2align	4
562:
	vmovups	ymm0, ymmword ptr [r8 + rdi]
	vmovups	ymmword ptr [rsi + rdi], ymm0
	add	rdi, 32
	cmp	rdi, r10
	jb	562b
	jmp	452b
572:
	mov	rsi, qword ptr [r12 + 48]
	mov	rdi, qword ptr [r12 + 120]
	movzx	r14d, byte ptr [rsi + rdi]
	inc	rdi
	mov	qword ptr [r12 + 120], rdi
	add	r14, 33
	lea	rsi, [rax + r10]
	add	rsi, r9
	mov	edi, 32
	.p2align	4
582:
	vmovdqu	ymm0, ymmword ptr [r11 + rdi]
	vmovdqu	ymmword ptr [rsi + rdi], ymm0
	add	rdi, 32
	cmp	rdi, r14
	jb	582b
	jmp	462b
592:
	mov	rdi, r8
	sub	rdi, rbp
	sub	rdi, r15
	mov	esi, 0
	cmovae	rsi, rdi
	add	rsi, rbp
	vmovups	ymm0, ymmword ptr [rsi]
	vmovups	ymmword ptr [r8], ymm0
	cmp	cl, -124
	jb	472b
602:
	mov	rcx, qword ptr [r12 + 48]
	mov	rdi, qword ptr [r12 + 120]
	movzx	r13d, byte ptr [rcx + rdi]
	inc	rdi
	mov	qword ptr [r12 + 120], rdi
	add	r13, 33
	lea	rcx, [rax + r14]
	mov	rdi, qword ptr [rsp + 24]
	add	rdi, r10
	add	rcx, rdi
	mov	edi, 32
	.p2align	4
612:
	vmovups	ymm0, ymmword ptr [rsi + rdi]
	vmovups	ymmword ptr [rcx + rdi], ymm0
	add	rdi, 32
	cmp	rdi, r13
	jb	612b
	jmp	472b
622:
	mov	rsi, qword ptr [r12 + 48]
	mov	rdi, qword ptr [r12 + 120]
	movzx	esi, byte ptr [rsi + rdi]
	inc	rdi
	mov	qword ptr [r12 + 120], rdi
	add	rsi, 33
	lea	r8, [rax + r14]
	lea	rbx, [r13 + r10]
	add	rbx, r8
	add	rbx, qword ptr [rsp + 24]
	add	r8, qword ptr [rsp + 48]
	mov	edi, 32
	.p2align	4
632:
	vmovdqu	ymm0, ymmword ptr [r8 + rdi]
	vmovdqu	ymmword ptr [rbx + rdi], ymm0
	add	rdi, 32
	cmp	rdi, rsi
	jb	632b
	mov	r9, qword ptr [rsp + 16]
	jmp	482b
642:
	mov	rdi, rcx
	mov	r9, qword ptr [rsp + 16]
	sub	rdi, r9
	sub	rdi, rbx
	mov	r8d, 0
	cmovae	r8, rdi
	add	r8, r9
	vmovups	ymm0, ymmword ptr [r8]
	vmovups	ymmword ptr [rcx], ymm0
	cmp	bpl, -124
	jb	492b
652:
	mov	rbp, qword ptr [rsp + 32]
	mov	rdi, qword ptr [rbp + 48]
	mov	rbx, qword ptr [rbp + 120]
	movzx	r12d, byte ptr [rdi + rbx]
	inc	rbx
	mov	qword ptr [rbp + 120], rbx
	add	r12, 33
	lea	rbx, [r13 + r14]
	add	rbx, rax
	add	rbx, rsi
	mov	rdi, qword ptr [rsp + 24]
	add	rdi, r10
	add	rbx, rdi
	mov	edi, 32
	.p2align	4
662:
	vmovups	ymm0, ymmword ptr [r8 + rdi]
	vmovups	ymmword ptr [rbx + rdi], ymm0
	add	rdi, 32
	cmp	rdi, r12
	jb	662b
	jmp	492b
672:
	mov	rax, r8
	mov	r8, qword ptr [rsp + 32]
	mov	rcx, qword ptr [r8 + 48]
	mov	rdi, qword ptr [r8 + 120]
	movzx	r15d, byte ptr [rcx + rdi]
	inc	rdi
	mov	qword ptr [r8 + 120], rdi
	add	r15, 33
	mov	rcx, qword ptr [rsp + 8]
	lea	rdi, [rcx + rsi]
	lea	r8, [r12 + r13]
	add	r8, rdi
	lea	rcx, [r14 + r10]
	add	rcx, qword ptr [rsp + 24]
	add	rcx, r8
	mov	r8, qword ptr [rsp + 48]
	add	r8, r14
	add	r8, rdi
	mov	edi, 32
	.p2align	4
682:
	vmovdqu	ymm0, ymmword ptr [r8 + rdi]
	vmovdqu	ymmword ptr [rcx + rdi], ymm0
	add	rdi, 32
	cmp	rdi, r15
	jb	682b
	mov	r9, qword ptr [rsp + 16]
	mov	r8, rax
	jmp	502b
692:
	mov	r8, rbx
	mov	r9, qword ptr [rsp + 16]
	sub	r8, r9
	sub	r8, rdi
	mov	rdi, r8
	mov	r8d, 0
	cmovae	r8, rdi
	add	r8, r9
	vmovups	ymm0, ymmword ptr [r8]
	vmovups	ymmword ptr [rbx], ymm0
	cmp	bpl, -124
	jb	512b
702:
	mov	rbp, qword ptr [rsp + 32]
	mov	rcx, qword ptr [rbp + 48]
	mov	rdi, qword ptr [rbp + 120]
	movzx	ecx, byte ptr [rcx + rdi]
	inc	rdi
	mov	qword ptr [rbp + 120], rdi
	add	rcx, 33
	mov	rdi, qword ptr [rsp + 8]
	add	rdi, r15
	add	r12, rsi
	add	r12, rdi
	add	r13, r14
	add	r13, r10
	add	r13, r12
	mov	r9, qword ptr [rsp + 24]
	add	r9, r13
	mov	edi, 32
	.p2align	4
712:
	vmovups	ymm0, ymmword ptr [r8 + rdi]
	vmovups	ymmword ptr [r9 + rdi], ymm0
	add	rdi, 32
	cmp	rdi, rcx
	jb	712b
	jmp	512b
	.p2align	4
722:
	mov	rbx, qword ptr [rsp + 24]
	mov	r11, qword ptr [rsp + 48]
732:
	mov	r9, qword ptr [rsp + 72]
	cmp	r13, r9
	mov	r10, rbx
	mov	r15, r11
	mov	rbx, qword ptr [rsp + 56]
	mov	r11, qword ptr [rsp + 104]
	je	2b
	.p2align	4
742:
	movzx	edx, byte ptr [r14 + r13]
	movzx	ecx, byte ptr [r12 + r13 + 192]
	cmp	rdi, 33
	mov	esi, 32
	cmovb	rdi, rsi
	mov	rsi, r10
	sub	rsi, rbp
	cmp	rdi, rsi
	cmovb	rsi, rdi
	neg	rsi
	cmp	rcx, 33
	mov	r8d, dword ptr [r12 + 4*r13 + 256]
	vmovdqu	ymm0, ymmword ptr [r10 + rsi]
	vpaddb	ymm0, ymm0, ymmword ptr [r15]
	vmovdqu	ymmword ptr [r10], ymm0
	jae	772f
752:
	add	r10, rcx
	mov	esi, edx
	shr	esi, 2
	cmp	rsi, 32
	mov	edi, 32
	cmovb	rdi, rsi
	cmp	r8, rdi
	mov	rax, r8
	cmova	rdi, r8
	mov	r8, r10
	sub	r8, rdi
	cmp	r8, rbp
	jl	792f
	vmovups	ymm0, ymmword ptr [r8]
	vmovups	ymmword ptr [r10], ymm0
	cmp	dl, -124
	jae	802f
762:
	add	r10, rsi
	add	r15, rcx
	inc	r13
	cmp	r13, r9
	mov	rdi, rax
	jb	742b
	jmp	2b
772:
	mov	rcx, qword ptr [r12 + 48]
	mov	rsi, qword ptr [r12 + 120]
	movzx	ecx, byte ptr [rcx + rsi]
	inc	rsi
	mov	qword ptr [r12 + 120], rsi
	add	rcx, 33
	mov	esi, 32
	.p2align	4
782:
	vmovdqu	ymm0, ymmword ptr [r15 + rsi]
	vmovdqu	ymmword ptr [r10 + rsi], ymm0
	add	rsi, 32
	cmp	rsi, rcx
	jb	782b
	jmp	752b
792:
	mov	r9, r10
	sub	r9, rbp
	sub	r9, rdi
	mov	r8d, 0
	cmovae	r8, r9
	mov	r9, qword ptr [rsp + 72]
	add	r8, rbp
	vmovups	ymm0, ymmword ptr [r8]
	vmovups	ymmword ptr [r10], ymm0
	cmp	dl, -124
	jb	762b
802:
	mov	rdx, qword ptr [r12 + 48]
	mov	rdi, qword ptr [r12 + 120]
	movzx	esi, byte ptr [rdx + rdi]
	inc	rdi
	mov	qword ptr [r12 + 120], rdi
	add	rsi, 33
	mov	edx, 32
	.p2align	4
812:
	vmovups	ymm0, ymmword ptr [r8 + rdx]
	vmovups	ymmword ptr [r10 + rdx], ymm0
	add	rdx, 32
	cmp	rdx, rsi
	jb	812b
	jmp	762b
822:
	sub	r10, rbp
	sub	r15, qword ptr [rsp + 240]
	mov	qword ptr [r12 + 80], r10
	mov	qword ptr [r12 + 88], r15
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
832:
	.long	1
	.p2align	2, 0x0
842:
	.long	7
	.p2align	2, 0x0
852:
	.long	8
	.p2align	2, 0x0
862:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	2, 0x0
872:
	.long	134217727
	.p2align	5, 0x0
882:
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
892:
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
902:
	.byte	1
	.p2align	4, 0x0
912:
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
922:
	.byte	16
	.p2align	2, 0x0
932:
	.byte	32
	.p2align	5, 0x0
942:
	.long	1207959552
	.long	1342177280
	.long	1476395008
	.long	1610612736
	.long	1744830464
	.long	1879048192
	.long	2013265920
	.long	2147483648
	.p2align	5, 0x0
952:
	.long	134217728
	.long	268435456
	.long	402653184
	.long	536870912
	.long	671088640
	.long	805306368
	.long	939524096
	.long	1073741824

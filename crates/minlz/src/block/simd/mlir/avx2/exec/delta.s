# minlz_exec_delta of crates/minlz/mlir/exec64.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 552
	mov	r10, rdi
	mov	r15, qword ptr [rdi]
	mov	rax, qword ptr [rdi + 8]
	mov	rcx, qword ptr [rdi + 64]
	mov	rbp, qword ptr [rdi + 80]
	add	rbp, r15
	mov	r12, qword ptr [rdi + 88]
	mov	qword ptr [rsp + 256], rax
	add	r12, rax
	test	rcx, rcx
	jle	1062f
	mov	rax, qword ptr [r10 + 16]
	mov	qword ptr [rsp + 264], rax
	mov	rsi, qword ptr [r10 + 96]
	lea	rax, [r10 + 512]
	lea	r11, [r10 + 576]
	mov	edx, 96
	mov	qword ptr [rsp + 136], rdx
	mov	edx, 7
	mov	qword ptr [rsp + 80], rdx
	mov	qword ptr [rsp + 152], 0
	vpxor	xmm13, xmm13, xmm13
	vbroadcastss	ymm0, dword ptr [rip + 1072f]
	vmovups	ymmword ptr [rsp + 448], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 1082f]
	vmovups	ymmword ptr [rsp + 416], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 1092f]
	vmovups	ymmword ptr [rsp + 384], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 1102f]
	vmovups	ymmword ptr [rsp + 352], ymm0
	vpbroadcastd	ymm0, dword ptr [rip + 1112f]
	vmovdqu	ymmword ptr [rsp + 320], ymm0
	mov	qword ptr [rsp + 144], rax
	xor	edx, edx
	mov	qword ptr [rsp + 24], r10
	mov	qword ptr [rsp + 72], rax
	mov	qword ptr [rsp + 32], r15
	mov	qword ptr [rsp + 272], rcx
	mov	qword ptr [rsp + 8], r11
	jmp	12f
	.p2align	4
2:
	inc	qword ptr [rsp + 152]
	add	qword ptr [rsp + 136], 64
	add	qword ptr [rsp + 80], -64
	add	qword ptr [rsp + 144], -64
	mov	rcx, qword ptr [rsp + 272]
	mov	rdx, qword ptr [rsp + 280]
	cmp	rdx, rcx
	mov	rax, qword ptr [rsp + 72]
	jge	1062f
12:
	mov	qword ptr [rsp + 56], rsi
	mov	qword ptr [rsp + 64], r12
	mov	r8, rdx
	mov	rdx, rcx
	sub	rdx, r8
	cmp	rdx, 64
	mov	ecx, 64
	mov	qword ptr [rsp + 96], rdx
	cmovb	rcx, rdx
	mov	qword ptr [rsp + 88], rcx
	mov	rsi, qword ptr [r10 + 16]
	mov	r14, qword ptr [r10 + 24]
	mov	r11, qword ptr [r10 + 32]
	mov	rdx, qword ptr [r10 + 40]
	mov	r15, qword ptr [r10 + 64]
	mov	rcx, qword ptr [r10 + 72]
	mov	qword ptr [rsp + 16], rcx
	mov	r12, qword ptr [r10 + 96]
	mov	r9, qword ptr [r10 + 112]
	mov	rcx, qword ptr [r10 + 128]
	mov	r13, qword ptr [r10 + 136]
	lea	rbx, [r15 + 7]
	lea	rdi, [r8 + 64]
	mov	qword ptr [rsp + 280], rdi
	cmp	rdi, rbx
	mov	qword ptr [rsp + 48], r8
	mov	qword ptr [rsp + 192], r12
	mov	qword ptr [rsp + 160], r13
	jbe	22f
	cmp	r8, rbx
	jge	92f
	mov	rax, qword ptr [rsp + 152]
	shl	rax, 6
	mov	edi, 7
	sub	rdi, rax
	add	rdi, r15
	cmp	rdi, 16
	mov	r12, qword ptr [rsp + 48]
	jb	72f
	add	rax, rsi
	mov	r8, r10
	sub	r8, rax
	add	r8, 511
	cmp	r8, 127
	mov	r12, qword ptr [rsp + 48]
	jb	72f
	cmp	rdi, 128
	mov	qword ptr [rsp + 40], rbp
	jae	32f
	xor	r13d, r13d
	jmp	52f
	.p2align	4
22:
	add	rsi, r8
	mov	rax, rsi
	jmp	92f
32:
	mov	r13, rdi
	and	r13, -128
	mov	rax, qword ptr [rsp + 48]
	lea	r12, [rax + r13]
	mov	rax, qword ptr [rsp + 136]
	lea	rbp, [rsi + rax]
	mov	rax, qword ptr [rsp + 80]
	lea	r8, [r15 + rax]
	and	r8, -128
	xor	eax, eax
	.p2align	4
42:
	vmovdqu	ymm0, ymmword ptr [rbp + rax - 96]
	vmovdqu	ymm1, ymmword ptr [rbp + rax - 64]
	vmovdqu	ymm3, ymmword ptr [rbp + rax - 32]
	vmovups	ymm4, ymmword ptr [rbp + rax]
	vmovdqu	ymmword ptr [r10 + rax + 512], ymm0
	vmovdqu	ymmword ptr [r10 + rax + 544], ymm1
	vmovdqu	ymmword ptr [r10 + rax + 576], ymm3
	vmovups	ymmword ptr [r10 + rax + 608], ymm4
	sub	rax, -128
	cmp	r8, rax
	jne	42b
	cmp	rdi, r13
	mov	rax, qword ptr [rsp + 72]
	mov	rbp, qword ptr [rsp + 40]
	je	92f
	test	dil, 112
	je	72f
52:
	mov	r8, rdi
	and	r8, -16
	mov	rax, qword ptr [rsp + 48]
	lea	r12, [rax + r8]
	add	rax, rsi
	add	r15, qword ptr [rsp + 80]
	and	r15, -16
	mov	rbp, qword ptr [rsp + 72]
	.p2align	4
62:
	vmovdqu	xmm0, xmmword ptr [rax + r13]
	vmovdqu	xmmword ptr [rbp + r13], xmm0
	add	r13, 16
	cmp	r15, r13
	jne	62b
	cmp	rdi, r8
	mov	rax, rbp
	mov	rbp, qword ptr [rsp + 40]
	je	92f
	.p2align	4
72:
	mov	rdi, qword ptr [rsp + 144]
	.p2align	4
82:
	movzx	eax, byte ptr [rsi + r12]
	mov	byte ptr [rdi + r12], al
	inc	r12
	cmp	rbx, r12
	jne	82b
	mov	rax, qword ptr [rsp + 72]
92:
	vmovdqu	ymm3, ymmword ptr [rax]
	vmovdqu	ymm4, ymmword ptr [rax + 32]
	vmovd	xmm0, dword ptr [rsp + 88]
	vpbroadcastb	ymm1, xmm0
	vpmaxub	ymm0, ymm1, ymmword ptr [rip + 1122f]
	vpcmpeqb	ymm0, ymm1, ymm0
	vpmaxub	ymm5, ymm1, ymmword ptr [rip + 1132f]
	vpcmpeqb	ymm1, ymm1, ymm5
	vpsllw	ymm5, ymm3, 6
	vpcmpgtb	ymm8, ymm13, ymm5
	vpsllw	ymm5, ymm4, 6
	vpcmpgtb	ymm9, ymm13, ymm5
	vpbroadcastb	ymm2, byte ptr [rip + 1142f]
	vpand	ymm3, ymm3, ymm2
	vpand	ymm4, ymm4, ymm2
	vpcmpeqb	ymm5, ymm13, ymm4
	vpcmpeqb	ymm3, ymm13, ymm3
	movabs	r8, 72340172838076673
	mov	r15, r8
	#APP
	#NO_APP
	vpand	ymm4, ymm8, ymm2
	vpand	ymm8, ymm0, ymm4
	vpand	ymm4, ymm9, ymm2
	vpand	ymm4, ymm1, ymm4
	vmovdqu	ymmword ptr [r10 + 544], ymm4
	vmovdqu	ymmword ptr [r10 + 512], ymm8
	vmovq	rax, xmm8
	mov	rsi, rax
	imul	rsi, r15
	mov	rdi, rsi
	sub	rdi, rax
	xor	rax, r15
	shl	rax, 7
	or	rax, rdi
	vmovq	xmm9, qword ptr [r14 + rcx]
	vmovq	xmm10, rax
	vpshufb	xmm9, xmm9, xmm10
	shr	rsi, 56
	add	rsi, rcx
	vmovq	qword ptr [r10 + 512], xmm9
	vpextrq	rax, xmm8, 1
	mov	rcx, rax
	imul	rcx, r15
	mov	rdi, rcx
	sub	rdi, rax
	xor	rax, r15
	shl	rax, 7
	or	rax, rdi
	vmovq	xmm9, qword ptr [r14 + rsi]
	vmovq	xmm10, rax
	vpshufb	xmm9, xmm9, xmm10
	shr	rcx, 56
	add	rcx, rsi
	vmovq	qword ptr [r10 + 520], xmm9
	vextracti128	xmm8, ymm8, 1
	vmovq	rax, xmm8
	mov	rsi, rax
	imul	rsi, r15
	mov	rdi, rsi
	sub	rdi, rax
	xor	rax, r15
	shl	rax, 7
	or	rax, rdi
	vmovq	xmm9, qword ptr [r14 + rcx]
	vmovq	xmm10, rax
	vpshufb	xmm9, xmm9, xmm10
	shr	rsi, 56
	add	rsi, rcx
	vmovq	qword ptr [r10 + 528], xmm9
	vpextrq	rax, xmm8, 1
	mov	rcx, rax
	imul	rcx, r15
	mov	rdi, rcx
	sub	rdi, rax
	xor	rax, r15
	shl	rax, 7
	or	rax, rdi
	vmovq	xmm8, qword ptr [r14 + rsi]
	vmovq	xmm9, rax
	vpshufb	xmm8, xmm8, xmm9
	shr	rcx, 56
	add	rcx, rsi
	vmovq	qword ptr [r10 + 536], xmm8
	vmovq	rax, xmm4
	mov	rsi, rax
	imul	rsi, r15
	mov	rdi, rsi
	sub	rdi, rax
	xor	rax, r15
	shl	rax, 7
	or	rax, rdi
	vmovq	xmm8, qword ptr [r14 + rcx]
	vmovq	xmm9, rax
	vpshufb	xmm8, xmm8, xmm9
	shr	rsi, 56
	add	rsi, rcx
	vmovq	qword ptr [r10 + 544], xmm8
	vpextrq	rax, xmm4, 1
	mov	rcx, rax
	imul	rcx, r15
	mov	rdi, rcx
	sub	rdi, rax
	xor	rax, r15
	shl	rax, 7
	or	rax, rdi
	vmovq	xmm4, qword ptr [r14 + rsi]
	vmovq	xmm8, rax
	vpshufb	xmm4, xmm4, xmm8
	shr	rcx, 56
	add	rcx, rsi
	vmovq	qword ptr [r10 + 552], xmm4
	mov	rax, qword ptr [r10 + 560]
	mov	rdi, qword ptr [r10 + 568]
	mov	r13, rax
	imul	r13, r15
	mov	rsi, r13
	sub	rsi, rax
	xor	rax, r15
	shl	rax, 7
	or	rax, rsi
	vmovq	xmm4, qword ptr [r14 + rcx]
	vmovq	xmm8, rax
	vpshufb	xmm4, xmm4, xmm8
	shr	r13, 56
	add	r13, rcx
	vmovq	qword ptr [r10 + 560], xmm4
	mov	rsi, rdi
	imul	rsi, r15
	mov	rax, rsi
	sub	rax, rdi
	xor	r15, rdi
	shl	r15, 7
	or	r15, rax
	vmovq	xmm4, qword ptr [r14 + r13]
	vmovq	xmm8, r15
	vpshufb	xmm4, xmm4, xmm8
	vmovq	qword ptr [r10 + 568], xmm4
	vmovups	ymm4, ymmword ptr [r10 + 544]
	vmovups	ymm8, ymmword ptr [r10 + 512]
	vmovups	ymmword ptr [r10 + 192], ymm8
	vmovups	ymmword ptr [r10 + 224], ymm4
	mov	rcx, r8
	#APP
	#NO_APP
	vpand	ymm4, ymm5, ymm2
	vpand	ymm1, ymm1, ymm4
	vpand	ymm3, ymm3, ymm2
	vpand	ymm0, ymm0, ymm3
	vmovdqu	ymmword ptr [r10 + 512], ymm0
	vmovdqu	ymmword ptr [r10 + 544], ymm1
	vmovq	rax, xmm0
	mov	rdi, rcx
	imul	rdi, rax
	mov	r8, rdi
	sub	r8, rax
	xor	rax, rcx
	shl	rax, 7
	or	rax, r8
	mov	r8, qword ptr [rsp + 160]
	vmovq	xmm3, qword ptr [r11 + r8]
	vmovq	xmm4, rax
	vpshufb	xmm3, xmm3, xmm4
	shr	rdi, 56
	add	rdi, r8
	vmovq	qword ptr [r10 + 512], xmm3
	vpextrq	r8, xmm0, 1
	mov	rax, rcx
	imul	rax, r8
	mov	rbx, rax
	sub	rbx, r8
	xor	r8, rcx
	shl	r8, 7
	or	r8, rbx
	vmovq	xmm3, qword ptr [r11 + rdi]
	vmovq	xmm4, r8
	vpshufb	xmm3, xmm3, xmm4
	shr	rax, 56
	add	rax, rdi
	vmovq	qword ptr [r10 + 520], xmm3
	vextracti128	xmm0, ymm0, 1
	vmovq	r8, xmm0
	mov	rdi, rcx
	imul	rdi, r8
	mov	rbx, rdi
	sub	rbx, r8
	xor	r8, rcx
	shl	r8, 7
	or	r8, rbx
	vmovq	xmm3, qword ptr [r11 + rax]
	vmovq	xmm4, r8
	vpshufb	xmm3, xmm3, xmm4
	shr	rdi, 56
	add	rdi, rax
	vmovq	qword ptr [r10 + 528], xmm3
	vpextrq	r8, xmm0, 1
	mov	rax, rcx
	imul	rax, r8
	mov	rbx, rax
	sub	rbx, r8
	xor	r8, rcx
	shl	r8, 7
	or	r8, rbx
	vmovq	xmm0, qword ptr [r11 + rdi]
	vmovq	xmm3, r8
	vpshufb	xmm0, xmm0, xmm3
	shr	rax, 56
	add	rax, rdi
	vmovq	qword ptr [r10 + 536], xmm0
	vmovq	r8, xmm1
	mov	rdi, rcx
	imul	rdi, r8
	mov	rbx, rdi
	sub	rbx, r8
	xor	r8, rcx
	shl	r8, 7
	or	r8, rbx
	vmovq	xmm0, qword ptr [r11 + rax]
	vmovq	xmm3, r8
	vpshufb	xmm0, xmm0, xmm3
	shr	rdi, 56
	add	rdi, rax
	vmovq	qword ptr [r10 + 544], xmm0
	vpextrq	r8, xmm1, 1
	mov	rax, rcx
	imul	rax, r8
	mov	rbx, rax
	sub	rbx, r8
	xor	r8, rcx
	shl	r8, 7
	or	r8, rbx
	vmovq	xmm0, qword ptr [r11 + rdi]
	vmovq	xmm1, r8
	vpshufb	xmm0, xmm0, xmm1
	shr	rax, 56
	add	rax, rdi
	vmovq	qword ptr [r10 + 552], xmm0
	mov	rdi, qword ptr [r10 + 560]
	mov	r8, qword ptr [r10 + 568]
	mov	r14, rdi
	imul	r14, rcx
	mov	rbx, r14
	sub	rbx, rdi
	xor	rdi, rcx
	shl	rdi, 7
	or	rdi, rbx
	vmovq	xmm0, qword ptr [r11 + rax]
	vmovq	xmm1, rdi
	vpshufb	xmm0, xmm0, xmm1
	shr	r14, 56
	add	r14, rax
	vmovq	qword ptr [r10 + 560], xmm0
	mov	r12, r8
	imul	r12, rcx
	mov	rax, r12
	sub	rax, r8
	xor	rcx, r8
	shl	rcx, 7
	or	rcx, rax
	vmovq	xmm0, qword ptr [r11 + r14]
	vmovq	xmm1, rcx
	vpshufb	xmm0, xmm0, xmm1
	vmovq	qword ptr [r10 + 568], xmm0
	vmovdqu	ymm7, ymmword ptr [r10 + 512]
	vmovups	ymm0, ymmword ptr [r10 + 544]
	vmovups	ymmword ptr [rsp + 480], ymm0
	vmovss	xmm0, dword ptr [rsp + 192]
	vbroadcastss	ymm0, xmm0
	vmovups	ymmword ptr [rsp + 192], ymm0
	vpmovzxbd	ymm3, qword ptr [r10 + 520]
	vpmovzxbd	ymm8, qword ptr [r10 + 512]
	vpsrld	ymm5, ymm8, 3
	vpsrld	ymm4, ymm3, 3
	vmovdqu	ymm1, ymmword ptr [rsp + 448]
	vpmaxud	ymm4, ymm4, ymm1
	vpcmpeqd	ymm2, ymm2, ymm2
	vpaddd	ymm4, ymm4, ymm2
	vpmaxud	ymm5, ymm5, ymm1
	vpaddd	ymm5, ymm5, ymm2
	vmovdqu	ymm1, ymmword ptr [rsp + 416]
	vpand	ymm9, ymm8, ymm1
	vpand	ymm10, ymm3, ymm1
	vmovdqu	ymm6, ymmword ptr [rsp + 384]
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
	mov	rcx, qword ptr [rsp + 16]
	mov	eax, ecx
	and	eax, 7
	vmovd	xmm9, eax
	vpbroadcastd	ymm9, xmm9
	vpaddd	ymm4, ymm9, ymm4
	vpaddd	ymm9, ymm9, ymm5
	vpsrld	ymm14, ymm4, 3
	vpsrld	ymm15, ymm9, 3
	vpand	ymm11, ymm4, ymm1
	vpand	ymm5, ymm9, ymm1
	vbroadcasti128	ymm1, xmmword ptr [rip + 1152f]
	vpshufb	ymm4, ymm14, ymm1
	vpshufb	ymm9, ymm15, ymm1
	vmovdqu	ymm1, ymmword ptr [rsp + 352]
	vpaddb	ymm4, ymm4, ymm1
	vpaddb	ymm9, ymm9, ymm1
	mov	rax, rcx
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, r9
	vmovdqu	ymmword ptr [rsp + 512], ymm7
	vmovdqu	ymmword ptr [rsp + 160], ymm3
	vmovdqu	ymmword ptr [rsp + 224], ymm2
	vmovdqu	ymmword ptr [rsp + 288], ymm11
	vmovdqa	ymm11, ymm6
	jbe	102f
	mov	rcx, r9
	sub	rcx, rax
	mov	r8, qword ptr [rsp + 8]
	mov	r15, qword ptr [rsp + 32]
	jbe	172f
	cmp	rcx, 16
	mov	rdi, rax
	jb	152f
	lea	r11, [rax + rdx]
	mov	rdi, r10
	sub	rdi, r11
	add	rdi, 575
	cmp	rdi, 127
	mov	rdi, rax
	jb	152f
	cmp	rcx, 128
	jae	112f
	xor	ebx, ebx
	jmp	132f
	.p2align	4
102:
	add	rax, rdx
	mov	r8, rax
	mov	r15, qword ptr [rsp + 32]
	jmp	172f
112:
	mov	rbx, rcx
	and	rbx, -128
	lea	rdi, [rax + rbx]
	lea	r8, [rdx + rax + 96]
	xor	r15d, r15d
	.p2align	4
122:
	vmovdqu	ymm14, ymmword ptr [r8 + r15 - 96]
	vmovdqu	ymm15, ymmword ptr [r8 + r15 - 64]
	vmovdqu	ymm6, ymmword ptr [r8 + r15 - 32]
	vmovdqu	ymm7, ymmword ptr [r8 + r15]
	vmovdqu	ymmword ptr [r10 + r15 + 576], ymm14
	vmovdqu	ymmword ptr [r10 + r15 + 608], ymm15
	vmovdqu	ymmword ptr [r10 + r15 + 640], ymm6
	vmovdqu	ymmword ptr [r10 + r15 + 672], ymm7
	sub	r15, -128
	cmp	rbx, r15
	jne	122b
	cmp	rcx, rbx
	mov	r8, qword ptr [rsp + 8]
	mov	r15, qword ptr [rsp + 32]
	je	172f
	test	cl, 112
	je	152f
132:
	mov	qword ptr [rsp + 40], rbp
	mov	r8, rcx
	and	r8, -16
	lea	rdi, [rax + r8]
	mov	rbp, qword ptr [rsp + 8]
	.p2align	4
142:
	vmovdqu	xmm6, xmmword ptr [r11 + rbx]
	vmovdqu	xmmword ptr [rbp + rbx], xmm6
	add	rbx, 16
	cmp	r8, rbx
	jne	142b
	cmp	rcx, r8
	mov	r8, rbp
	mov	rbp, qword ptr [rsp + 40]
	je	172f
	.p2align	4
152:
	mov	rcx, qword ptr [rsp + 8]
	sub	rcx, rax
	.p2align	4
162:
	movzx	eax, byte ptr [rdx + rdi]
	mov	byte ptr [rcx + rdi], al
	inc	rdi
	cmp	r9, rdi
	jne	162b
	mov	r8, qword ptr [rsp + 8]
172:
	vmovdqu	ymm6, ymmword ptr [r8]
	vmovdqu	ymm7, ymmword ptr [r8 + 32]
	vpermq	ymm14, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm15, ymm14, ymm4
	vpshufb	ymm2, ymm6, ymm4
	vpbroadcastb	ymm3, byte ptr [rip + 1162f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 1172f]
	vpand	ymm8, ymm9, ymm3
	vpcmpeqb	ymm8, ymm8, ymm3
	vpblendvb	ymm6, ymm6, ymm7, ymm8
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm1, ymm2, ymm1, ymm4
	vpsrlvd	ymm2, ymm6, ymm5
	vpandn	ymm2, ymm11, ymm2
	vpaddd	ymm2, ymm2, ymm0
	vpsrlvd	ymm1, ymm1, ymmword ptr [rsp + 288]
	vmovdqu	ymm0, ymmword ptr [rsp + 224]
	vpandn	ymm1, ymm0, ymm1
	vpaddd	ymm1, ymm1, ymmword ptr [rsp + 160]
	vpor	ymm3, ymm1, ymmword ptr [rip + 1182f]
	vpcmpeqd	ymm1, ymm13, ymm1
	vpandn	ymm1, ymm1, ymm3
	vpor	ymm3, ymm2, ymmword ptr [rip + 1192f]
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
	vmovdqu	ymm4, ymmword ptr [rsp + 320]
	vpand	ymm2, ymm1, ymm4
	vpcmpeqd	ymm1, ymm13, ymm1
	vmovups	ymm0, ymmword ptr [rsp + 192]
	vblendvps	ymm1, ymm2, ymm0, ymm1
	vpand	ymm2, ymm3, ymm4
	vpcmpeqd	ymm3, ymm13, ymm3
	vblendvps	ymm0, ymm2, ymm0, ymm3
	vextracti128	xmm2, ymm12, 1
	vpextrd	eax, xmm2, 3
	vmovups	ymmword ptr [r10 + 256], ymm0
	vmovups	ymmword ptr [r10 + 288], ymm1
	vshufps	ymm0, ymm1, ymm1, 255
	vpermpd	ymm0, ymm0, 170
	mov	rcx, qword ptr [rsp + 16]
	add	rcx, rax
	cmp	qword ptr [rsp + 96], 17
	jb	422f
	vmovups	ymmword ptr [rsp + 192], ymm0
	vmovdqu	ymm1, ymmword ptr [rsp + 512]
	vextracti128	xmm1, ymm1, 1
	vpshufd	xmm2, xmm1, 238
	vpmovzxbd	ymm2, xmm2
	vpmovzxbd	ymm1, xmm1
	vpsrld	ymm3, ymm1, 3
	vpsrld	ymm4, ymm2, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 448]
	vpmaxud	ymm4, ymm4, ymm5
	vpcmpeqd	ymm7, ymm7, ymm7
	vpaddd	ymm4, ymm4, ymm7
	vpmaxud	ymm3, ymm3, ymm5
	vpaddd	ymm5, ymm3, ymm7
	vmovdqu	ymm8, ymmword ptr [rsp + 416]
	vpand	ymm3, ymm8, ymm1
	vpand	ymm6, ymm8, ymm2
	vmovdqu	ymm9, ymmword ptr [rsp + 384]
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
	mov	eax, ecx
	and	eax, 7
	vmovd	xmm5, eax
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm4, ymm5, ymm4
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm6, ymm4, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm5, ymm8, ymm4
	vpand	ymm8, ymm8, ymm2
	vbroadcasti128	ymm4, xmmword ptr [rip + 1152f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm6, ymm7, ymm4
	vmovdqu	ymm7, ymmword ptr [rsp + 352]
	vpaddb	ymm4, ymm2, ymm7
	vpaddb	ymm9, ymm6, ymm7
	mov	qword ptr [rsp + 16], rcx
	mov	rax, rcx
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, r9
	vmovdqu	ymmword ptr [rsp + 160], ymm3
	vmovdqu	ymmword ptr [rsp + 224], ymm5
	vmovdqu	ymmword ptr [rsp + 288], ymm8
	vmovdqa	ymm5, ymm10
	jbe	182f
	mov	rcx, r9
	sub	rcx, rax
	mov	r8, qword ptr [rsp + 8]
	jbe	252f
	cmp	rcx, 16
	mov	rdi, rax
	jb	232f
	lea	r11, [rax + rdx]
	mov	rdi, r10
	sub	rdi, r11
	add	rdi, 575
	cmp	rdi, 127
	mov	rdi, rax
	jb	232f
	cmp	rcx, 128
	jae	192f
	xor	ebx, ebx
	jmp	212f
	.p2align	4
182:
	add	rax, rdx
	mov	r8, rax
	jmp	252f
192:
	mov	rbx, rcx
	and	rbx, -128
	lea	rdi, [rax + rbx]
	lea	r8, [rdx + rax + 96]
	xor	r15d, r15d
	.p2align	4
202:
	vmovdqu	ymm2, ymmword ptr [r8 + r15 - 96]
	vmovdqu	ymm6, ymmword ptr [r8 + r15 - 64]
	vmovdqu	ymm7, ymmword ptr [r8 + r15 - 32]
	vmovdqu	ymm13, ymmword ptr [r8 + r15]
	vmovdqu	ymmword ptr [r10 + r15 + 576], ymm2
	vmovdqu	ymmword ptr [r10 + r15 + 608], ymm6
	vmovdqu	ymmword ptr [r10 + r15 + 640], ymm7
	vmovdqu	ymmword ptr [r10 + r15 + 672], ymm13
	sub	r15, -128
	cmp	rbx, r15
	jne	202b
	cmp	rcx, rbx
	mov	r8, qword ptr [rsp + 8]
	mov	r15, qword ptr [rsp + 32]
	je	252f
	test	cl, 112
	je	232f
212:
	mov	qword ptr [rsp + 40], rbp
	mov	r8, rcx
	and	r8, -16
	lea	rdi, [rax + r8]
	mov	rbp, qword ptr [rsp + 8]
	.p2align	4
222:
	vmovdqu	xmm2, xmmword ptr [r11 + rbx]
	vmovdqu	xmmword ptr [rbp + rbx], xmm2
	add	rbx, 16
	cmp	r8, rbx
	jne	222b
	cmp	rcx, r8
	mov	r8, rbp
	mov	rbp, qword ptr [rsp + 40]
	je	252f
232:
	mov	rcx, qword ptr [rsp + 8]
	sub	rcx, rax
	.p2align	4
242:
	movzx	eax, byte ptr [rdx + rdi]
	mov	byte ptr [rcx + rdi], al
	inc	rdi
	cmp	r9, rdi
	jne	242b
	mov	r8, qword ptr [rsp + 8]
252:
	vmovdqu	ymm2, ymmword ptr [r8]
	vmovdqu	ymm6, ymmword ptr [r8 + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm13, ymm7, ymm4
	vpshufb	ymm14, ymm2, ymm4
	vpbroadcastb	ymm3, byte ptr [rip + 1162f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 1172f]
	vpand	ymm7, ymm9, ymm3
	vpcmpeqb	ymm7, ymm7, ymm3
	vpblendvb	ymm2, ymm2, ymm6, ymm7
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm4, ymm13, ymm8, ymm4
	vpxor	xmm13, xmm13, xmm13
	vpsrlvd	ymm2, ymm2, ymmword ptr [rsp + 288]
	vpandn	ymm2, ymm5, ymm2
	vpaddd	ymm2, ymm11, ymm2
	vpsrlvd	ymm3, ymm4, ymmword ptr [rsp + 224]
	vpandn	ymm3, ymm0, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 160]
	vpor	ymm4, ymm3, ymmword ptr [rip + 1182f]
	vpcmpeqd	ymm3, ymm13, ymm3
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 1192f]
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
	vmovdqu	ymm5, ymmword ptr [rsp + 320]
	vpand	ymm3, ymm2, ymm5
	vpcmpeqd	ymm2, ymm13, ymm2
	vmovups	ymm0, ymmword ptr [rsp + 192]
	vblendvps	ymm2, ymm3, ymm0, ymm2
	vpand	ymm3, ymm4, ymm5
	vpcmpeqd	ymm4, ymm13, ymm4
	vblendvps	ymm0, ymm3, ymm0, ymm4
	vextracti128	xmm1, ymm1, 1
	vpextrd	eax, xmm1, 3
	vmovups	ymmword ptr [r10 + 320], ymm0
	vmovups	ymmword ptr [r10 + 352], ymm2
	vshufps	ymm0, ymm2, ymm2, 255
	vpermpd	ymm0, ymm0, 170
	mov	rcx, qword ptr [rsp + 16]
	add	rcx, rax
	cmp	qword ptr [rsp + 96], 33
	jb	422f
	vmovdqu	ymm2, ymmword ptr [rsp + 480]
	vpshufd	xmm1, xmm2, 238
	vpmovzxbd	ymm1, xmm1
	vpmovzxbd	ymm2, xmm2
	vpsrld	ymm3, ymm2, 3
	vpsrld	ymm4, ymm1, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 448]
	vpmaxud	ymm4, ymm4, ymm5
	vpcmpeqd	ymm7, ymm7, ymm7
	vpaddd	ymm4, ymm4, ymm7
	vpmaxud	ymm3, ymm3, ymm5
	vpaddd	ymm5, ymm3, ymm7
	vmovdqu	ymm8, ymmword ptr [rsp + 416]
	vpand	ymm3, ymm8, ymm2
	vpand	ymm6, ymm8, ymm1
	vmovdqu	ymm9, ymmword ptr [rsp + 384]
	vpminud	ymm1, ymm1, ymm9
	vpminud	ymm2, ymm2, ymm9
	vpand	ymm2, ymm9, ymm2
	vpor	ymm2, ymm2, ymm3
	vpand	ymm1, ymm9, ymm1
	vpor	ymm1, ymm1, ymm6
	vpsllvd	ymm2, ymm2, ymm5
	vmovdqu	ymmword ptr [rsp + 160], ymm2
	vpsllvd	ymm1, ymm1, ymm4
	vmovdqu	ymmword ptr [rsp + 192], ymm1
	vpsllvd	ymm1, ymm7, ymm5
	vmovdqu	ymmword ptr [rsp + 288], ymm1
	vpsllvd	ymm1, ymm7, ymm4
	vmovdqu	ymmword ptr [rsp + 224], ymm1
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
	mov	eax, ecx
	and	eax, 7
	vmovd	xmm5, eax
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm4, ymm5, ymm4
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm6, ymm4, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm5, ymm8, ymm4
	vpand	ymm11, ymm8, ymm2
	vbroadcasti128	ymm4, xmmword ptr [rip + 1152f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm6, ymm7, ymm4
	vmovdqu	ymm7, ymmword ptr [rsp + 352]
	vpaddb	ymm4, ymm2, ymm7
	vpaddb	ymm9, ymm6, ymm7
	mov	qword ptr [rsp + 16], rcx
	mov	rax, rcx
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, r9
	jbe	262f
	mov	rcx, r9
	sub	rcx, rax
	mov	r8, qword ptr [rsp + 8]
	jbe	332f
	cmp	rcx, 16
	mov	rdi, rax
	jb	312f
	lea	r11, [rax + rdx]
	mov	rdi, r10
	sub	rdi, r11
	add	rdi, 575
	cmp	rdi, 127
	mov	rdi, rax
	jb	312f
	cmp	rcx, 128
	jae	272f
	xor	ebx, ebx
	jmp	292f
262:
	add	rax, rdx
	mov	r8, rax
	jmp	332f
272:
	mov	rbx, rcx
	and	rbx, -128
	lea	rdi, [rax + rbx]
	lea	r8, [rdx + rax + 96]
	xor	r15d, r15d
	.p2align	4
282:
	vmovdqu	ymm2, ymmword ptr [r8 + r15 - 96]
	vmovdqu	ymm6, ymmword ptr [r8 + r15 - 64]
	vmovdqu	ymm7, ymmword ptr [r8 + r15 - 32]
	vmovdqu	ymm13, ymmword ptr [r8 + r15]
	vmovdqu	ymmword ptr [r10 + r15 + 576], ymm2
	vmovdqu	ymmword ptr [r10 + r15 + 608], ymm6
	vmovdqu	ymmword ptr [r10 + r15 + 640], ymm7
	vmovdqu	ymmword ptr [r10 + r15 + 672], ymm13
	sub	r15, -128
	cmp	rbx, r15
	jne	282b
	cmp	rcx, rbx
	mov	r8, qword ptr [rsp + 8]
	mov	r15, qword ptr [rsp + 32]
	je	332f
	test	cl, 112
	je	312f
292:
	mov	qword ptr [rsp + 40], rbp
	mov	r8, rcx
	and	r8, -16
	lea	rdi, [rax + r8]
	mov	rbp, qword ptr [rsp + 8]
	.p2align	4
302:
	vmovdqu	xmm2, xmmword ptr [r11 + rbx]
	vmovdqu	xmmword ptr [rbp + rbx], xmm2
	add	rbx, 16
	cmp	r8, rbx
	jne	302b
	cmp	rcx, r8
	mov	r8, rbp
	mov	rbp, qword ptr [rsp + 40]
	je	332f
312:
	mov	rcx, qword ptr [rsp + 8]
	sub	rcx, rax
	.p2align	4
322:
	movzx	eax, byte ptr [rdx + rdi]
	mov	byte ptr [rcx + rdi], al
	inc	rdi
	cmp	r9, rdi
	jne	322b
	mov	r8, qword ptr [rsp + 8]
332:
	vmovdqu	ymm2, ymmword ptr [r8]
	vmovdqu	ymm6, ymmword ptr [r8 + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm13, ymm7, ymm4
	vpshufb	ymm14, ymm2, ymm4
	vpbroadcastb	ymm3, byte ptr [rip + 1162f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 1172f]
	vpand	ymm7, ymm9, ymm3
	vpcmpeqb	ymm7, ymm7, ymm3
	vpblendvb	ymm2, ymm2, ymm6, ymm7
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm4, ymm13, ymm8, ymm4
	vpxor	xmm13, xmm13, xmm13
	vpsrlvd	ymm2, ymm2, ymm11
	vmovdqu	ymm3, ymmword ptr [rsp + 288]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 160]
	vpsrlvd	ymm3, ymm4, ymm5
	vmovdqu	ymm4, ymmword ptr [rsp + 224]
	vpandn	ymm3, ymm4, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 192]
	vpor	ymm4, ymm3, ymmword ptr [rip + 1182f]
	vpcmpeqd	ymm3, ymm13, ymm3
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 1192f]
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
	vmovdqu	ymm5, ymmword ptr [rsp + 320]
	vpand	ymm3, ymm2, ymm5
	vpcmpeqd	ymm2, ymm13, ymm2
	vblendvps	ymm2, ymm3, ymm0, ymm2
	vpand	ymm3, ymm4, ymm5
	vpcmpeqd	ymm4, ymm13, ymm4
	vblendvps	ymm0, ymm3, ymm0, ymm4
	vextracti128	xmm1, ymm1, 1
	vpextrd	eax, xmm1, 3
	vmovups	ymmword ptr [r10 + 384], ymm0
	vmovups	ymmword ptr [r10 + 416], ymm2
	vshufps	ymm0, ymm2, ymm2, 255
	vpermpd	ymm0, ymm0, 170
	mov	rcx, qword ptr [rsp + 16]
	add	rcx, rax
	cmp	qword ptr [rsp + 96], 49
	jb	422f
	vmovdqu	ymm1, ymmword ptr [rsp + 480]
	vextracti128	xmm1, ymm1, 1
	vpshufd	xmm2, xmm1, 238
	vpmovzxbd	ymm2, xmm2
	vpmovzxbd	ymm1, xmm1
	vpsrld	ymm3, ymm1, 3
	vpsrld	ymm4, ymm2, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 448]
	vpmaxud	ymm4, ymm4, ymm5
	vpcmpeqd	ymm7, ymm7, ymm7
	vpaddd	ymm4, ymm4, ymm7
	vpmaxud	ymm3, ymm3, ymm5
	vpaddd	ymm5, ymm3, ymm7
	vmovdqu	ymm8, ymmword ptr [rsp + 416]
	vpand	ymm3, ymm8, ymm1
	vpand	ymm6, ymm8, ymm2
	vmovdqu	ymm9, ymmword ptr [rsp + 384]
	vpminud	ymm2, ymm2, ymm9
	vpminud	ymm1, ymm1, ymm9
	vpand	ymm1, ymm9, ymm1
	vpor	ymm1, ymm1, ymm3
	vpand	ymm2, ymm9, ymm2
	vpor	ymm2, ymm2, ymm6
	vpsllvd	ymm1, ymm1, ymm5
	vmovdqu	ymmword ptr [rsp + 192], ymm1
	vpsllvd	ymm1, ymm2, ymm4
	vmovdqu	ymmword ptr [rsp + 96], ymm1
	vpsllvd	ymm1, ymm7, ymm5
	vmovdqu	ymmword ptr [rsp + 224], ymm1
	vpsllvd	ymm1, ymm7, ymm4
	vmovdqu	ymmword ptr [rsp + 160], ymm1
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
	mov	eax, ecx
	and	eax, 7
	vmovd	xmm5, eax
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm4, ymm5, ymm4
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm6, ymm4, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm5, ymm8, ymm4
	vpand	ymm11, ymm8, ymm2
	vbroadcasti128	ymm4, xmmword ptr [rip + 1152f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm6, ymm7, ymm4
	vmovdqu	ymm7, ymmword ptr [rsp + 352]
	vpaddb	ymm4, ymm2, ymm7
	vpaddb	ymm9, ymm6, ymm7
	mov	qword ptr [rsp + 16], rcx
	mov	rax, rcx
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, r9
	jbe	342f
	mov	rcx, r9
	sub	rcx, rax
	mov	r8, qword ptr [rsp + 8]
	jbe	412f
	cmp	rcx, 16
	mov	rdi, rax
	jb	392f
	lea	r11, [rax + rdx]
	mov	rdi, r10
	sub	rdi, r11
	add	rdi, 575
	cmp	rdi, 127
	mov	rdi, rax
	jb	392f
	cmp	rcx, 128
	jae	352f
	xor	ebx, ebx
	jmp	372f
342:
	add	rdx, rax
	mov	r8, rdx
	jmp	412f
352:
	mov	rbx, rcx
	and	rbx, -128
	lea	rdi, [rax + rbx]
	lea	r8, [rdx + rax + 96]
	xor	r15d, r15d
	.p2align	4
362:
	vmovdqu	ymm2, ymmword ptr [r8 + r15 - 96]
	vmovdqu	ymm6, ymmword ptr [r8 + r15 - 64]
	vmovdqu	ymm7, ymmword ptr [r8 + r15 - 32]
	vmovdqu	ymm13, ymmword ptr [r8 + r15]
	vmovdqu	ymmword ptr [r10 + r15 + 576], ymm2
	vmovdqu	ymmword ptr [r10 + r15 + 608], ymm6
	vmovdqu	ymmword ptr [r10 + r15 + 640], ymm7
	vmovdqu	ymmword ptr [r10 + r15 + 672], ymm13
	sub	r15, -128
	cmp	rbx, r15
	jne	362b
	cmp	rcx, rbx
	mov	r8, qword ptr [rsp + 8]
	mov	r15, qword ptr [rsp + 32]
	je	412f
	test	cl, 112
	je	392f
372:
	mov	qword ptr [rsp + 40], rbp
	mov	r8, rcx
	and	r8, -16
	lea	rdi, [rax + r8]
	mov	rbp, qword ptr [rsp + 8]
	.p2align	4
382:
	vmovdqu	xmm2, xmmword ptr [r11 + rbx]
	vmovdqu	xmmword ptr [rbp + rbx], xmm2
	add	rbx, 16
	cmp	r8, rbx
	jne	382b
	cmp	rcx, r8
	mov	r8, rbp
	mov	rbp, qword ptr [rsp + 40]
	je	412f
392:
	mov	rcx, qword ptr [rsp + 8]
	sub	rcx, rax
	.p2align	4
402:
	movzx	eax, byte ptr [rdx + rdi]
	mov	byte ptr [rcx + rdi], al
	inc	rdi
	cmp	r9, rdi
	jne	402b
	mov	r8, qword ptr [rsp + 8]
412:
	vmovdqu	ymm2, ymmword ptr [r8]
	vmovdqu	ymm6, ymmword ptr [r8 + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm13, ymm7, ymm4
	vpshufb	ymm14, ymm2, ymm4
	vpbroadcastb	ymm3, byte ptr [rip + 1162f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 1172f]
	vpand	ymm7, ymm9, ymm3
	vpcmpeqb	ymm7, ymm7, ymm3
	vpblendvb	ymm2, ymm2, ymm6, ymm7
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm4, ymm13, ymm8, ymm4
	vpxor	xmm13, xmm13, xmm13
	vpsrlvd	ymm2, ymm2, ymm11
	vmovdqu	ymm3, ymmword ptr [rsp + 224]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 192]
	vpsrlvd	ymm3, ymm4, ymm5
	vmovdqu	ymm4, ymmword ptr [rsp + 160]
	vpandn	ymm3, ymm4, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 96]
	vpor	ymm4, ymm3, ymmword ptr [rip + 1182f]
	vpcmpeqd	ymm3, ymm13, ymm3
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 1192f]
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
	vmovdqu	ymm5, ymmword ptr [rsp + 320]
	vpand	ymm3, ymm2, ymm5
	vpcmpeqd	ymm2, ymm13, ymm2
	vblendvps	ymm2, ymm3, ymm0, ymm2
	vpand	ymm3, ymm4, ymm5
	vpcmpeqd	ymm4, ymm13, ymm4
	vblendvps	ymm0, ymm3, ymm0, ymm4
	vextracti128	xmm1, ymm1, 1
	vpextrd	eax, xmm1, 3
	vmovups	ymmword ptr [r10 + 448], ymm0
	vmovups	ymmword ptr [r10 + 480], ymm2
	vshufps	ymm0, ymm2, ymm2, 255
	vpermpd	ymm0, ymm0, 170
	mov	rcx, qword ptr [rsp + 16]
	add	rcx, rax
	.p2align	4
422:
	mov	rbx, qword ptr [rsp + 48]
	shr	r12, 56
	add	r12, r14
	shr	rsi, 56
	add	rsi, r13
	vmovd	eax, xmm0
	mov	qword ptr [r10 + 72], rcx
	mov	qword ptr [r10 + 96], rax
	mov	qword ptr [r10 + 128], rsi
	mov	qword ptr [r10 + 136], r12
	add	rbx, qword ptr [rsp + 264]
	mov	rdx, qword ptr [rsp + 88]
	and	rdx, 124
	je	912f
	xor	r8d, r8d
	mov	r13, qword ptr [rsp + 64]
	mov	rsi, qword ptr [rsp + 56]
	mov	qword ptr [rsp + 48], rbx
	.p2align	4
432:
	mov	rax, rbp
	sub	rax, r15
	cmp	rsi, rax
	cmovae	rsi, rax
	cmp	rsi, 31
	jbe	592f
	mov	rax, rbp
	sub	rax, rsi
	vmovdqu	ymm0, ymmword ptr [rax]
442:
	movzx	ecx, byte ptr [rbx + r8]
	movzx	r11d, byte ptr [r10 + r8 + 192]
	mov	eax, dword ptr [r10 + 4*r8 + 256]
	vpaddb	ymm0, ymm0, ymmword ptr [r13]
	vmovdqu	ymmword ptr [rbp], ymm0
	cmp	r11b, 33
	jae	602f
452:
	lea	r9, [rbp + r11]
	mov	r12d, ecx
	shr	r12d, 2
	cmp	rax, r12
	jb	832f
	mov	rsi, r9
	sub	rsi, rax
	cmp	rsi, r15
	jl	832f
	vmovdqu	ymm0, ymmword ptr [rsi]
	mov	rdi, rax
462:
	vmovdqu	ymmword ptr [r9], ymm0
	cmp	cl, -124
	jae	622f
472:
	lea	rsi, [r8 + 1]
	mov	qword ptr [rsp + 96], r12
	add	r9, r12
	movzx	ecx, byte ptr [rbx + rsi]
	movzx	edi, byte ptr [r10 + rsi + 192]
	mov	qword ptr [rsp + 16], rdi
	mov	esi, dword ptr [r10 + 4*rsi + 256]
	vmovdqu	ymm0, ymmword ptr [r13 + r11]
	mov	rdi, r9
	sub	rdi, r15
	cmp	rax, rdi
	cmovae	rax, rdi
	cmp	rax, 31
	jbe	652f
	mov	rdi, r9
	sub	rdi, rax
	vmovdqu	ymm1, ymmword ptr [rdi]
482:
	vpaddb	ymm0, ymm1, ymm0
	lea	r14, [r13 + r11]
	vmovdqu	ymmword ptr [r9], ymm0
	cmp	byte ptr [rsp + 16], 33
	jae	662f
492:
	mov	qword ptr [rsp + 64], r13
	add	r9, qword ptr [rsp + 16]
	mov	r13d, ecx
	shr	r13d, 2
	cmp	rsi, r13
	mov	qword ptr [rsp + 56], r11
	jb	842f
	mov	rax, r9
	sub	rax, rsi
	cmp	rax, r15
	jl	842f
	vmovdqu	ymm0, ymmword ptr [rax]
	mov	rdi, rsi
502:
	vmovdqu	ymmword ptr [r9], ymm0
	cmp	cl, -124
	jae	682f
512:
	lea	rcx, [r8 + 2]
	add	r9, r13
	movzx	ebx, byte ptr [rbx + rcx]
	movzx	eax, byte ptr [r10 + rcx + 192]
	mov	ecx, dword ptr [r10 + 4*rcx + 256]
	mov	rdi, qword ptr [rsp + 16]
	vmovdqu	ymm0, ymmword ptr [r14 + rdi]
	mov	rdi, r9
	sub	rdi, r15
	cmp	rsi, rdi
	cmovae	rsi, rdi
	cmp	rsi, 31
	jbe	712f
	mov	rdi, r9
	sub	rdi, rsi
	vmovdqu	ymm1, ymmword ptr [rdi]
	vpaddb	ymm0, ymm1, ymm0
	vmovdqu	ymmword ptr [r9], ymm0
	cmp	al, 33
	jae	722f
522:
	mov	qword ptr [rsp + 40], rbp
	add	r9, rax
	mov	ebp, ebx
	shr	ebp, 2
	cmp	rcx, rbp
	jb	852f
	mov	rsi, r9
	sub	rsi, rcx
	cmp	rsi, r15
	jl	852f
	vmovdqu	ymm0, ymmword ptr [rsi]
	mov	rdi, rcx
532:
	vmovdqu	ymmword ptr [r9], ymm0
	cmp	bl, -124
	jae	742f
542:
	lea	rsi, [r8 + 3]
	add	r14, qword ptr [rsp + 16]
	add	r9, rbp
	mov	rdi, qword ptr [rsp + 48]
	movzx	ebx, byte ptr [rdi + rsi]
	movzx	r15d, byte ptr [r10 + rsi + 192]
	mov	r11d, dword ptr [r10 + 4*rsi + 256]
	vmovdqu	ymm0, ymmword ptr [r14 + rax]
	mov	rsi, r9
	sub	rsi, qword ptr [rsp + 32]
	cmp	rcx, rsi
	cmovae	rcx, rsi
	cmp	rcx, 31
	jbe	772f
	mov	rsi, r9
	sub	rsi, rcx
	vmovdqu	ymm1, ymmword ptr [rsi]
552:
	vpaddb	ymm0, ymm1, ymm0
	vmovdqu	ymmword ptr [r9], ymm0
	cmp	r15b, 33
	mov	rsi, r11
	jae	782f
562:
	add	r9, r15
	mov	ecx, ebx
	shr	ecx, 2
	cmp	rsi, rcx
	jb	862f
	mov	rdi, r9
	sub	rdi, rsi
	cmp	rdi, qword ptr [rsp + 32]
	jl	862f
	vmovdqu	ymm0, ymmword ptr [rdi]
	mov	r10, rsi
572:
	vmovdqu	ymmword ptr [r9], ymm0
	cmp	bl, -124
	mov	rbx, qword ptr [rsp + 48]
	jae	802f
582:
	add	r14, rax
	add	r9, rcx
	add	r14, r15
	add	r8, 4
	cmp	r8, rdx
	mov	r13, r14
	mov	rbp, r9
	mov	r10, qword ptr [rsp + 24]
	mov	r15, qword ptr [rsp + 32]
	jb	432b
	jmp	922f
592:
	sub	rax, rsi
	mov	rcx, qword ptr [r10 + 56]
	shl	rsi, 5
	vmovdqu	ymm0, ymmword ptr [rcx + rsi + 2048]
	vmovdqu	ymm1, ymmword ptr [r15 + rax]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	jmp	442b
602:
	mov	rsi, qword ptr [r10 + 48]
	mov	rdi, qword ptr [r10 + 120]
	movzx	r11d, byte ptr [rsi + rdi]
	inc	rdi
	mov	qword ptr [r10 + 120], rdi
	add	r11, 33
	mov	esi, 32
	.p2align	4
612:
	vmovdqu	ymm0, ymmword ptr [r13 + rsi]
	vmovdqu	ymmword ptr [rbp + rsi], ymm0
	add	rsi, 32
	cmp	rsi, r11
	jb	612b
	jmp	452b
622:
	cmp	rdi, 31
	ja	632f
	mov	qword ptr [r10 + 104], 1
632:
	mov	rcx, qword ptr [r10 + 48]
	mov	rdi, qword ptr [r10 + 120]
	movzx	r12d, byte ptr [rcx + rdi]
	inc	rdi
	mov	qword ptr [r10 + 120], rdi
	add	r12, 33
	mov	ecx, 32
	.p2align	4
642:
	vmovdqu	ymm0, ymmword ptr [rsi + rcx]
	vmovdqu	ymmword ptr [r9 + rcx], ymm0
	add	rcx, 32
	cmp	rcx, r12
	jb	642b
	jmp	472b
652:
	sub	rdi, rax
	mov	r10, qword ptr [rsp + 24]
	mov	r10, qword ptr [r10 + 56]
	shl	rax, 5
	vmovdqu	ymm1, ymmword ptr [r10 + rax + 2048]
	mov	r10, qword ptr [rsp + 24]
	vmovdqu	ymm2, ymmword ptr [r15 + rdi]
	vpermq	ymm3, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm3, ymm3, ymm1
	vpshufb	ymm2, ymm2, ymm1
	vpsllw	ymm1, ymm1, 3
	vpblendvb	ymm1, ymm3, ymm2, ymm1
	jmp	482b
662:
	mov	rax, qword ptr [r10 + 48]
	mov	rdi, qword ptr [r10 + 120]
	movzx	eax, byte ptr [rax + rdi]
	inc	rdi
	mov	qword ptr [r10 + 120], rdi
	add	rax, 33
	mov	qword ptr [rsp + 16], rax
	mov	rax, qword ptr [rsp + 96]
	add	rax, r11
	add	rax, rbp
	mov	edi, 32
	.p2align	4
672:
	vmovdqu	ymm0, ymmword ptr [r14 + rdi]
	vmovdqu	ymmword ptr [rax + rdi], ymm0
	add	rdi, 32
	cmp	rdi, qword ptr [rsp + 16]
	jb	672b
	jmp	492b
682:
	cmp	rdi, 31
	ja	692f
	mov	qword ptr [r10 + 104], 1
692:
	mov	rcx, qword ptr [r10 + 48]
	mov	rdi, qword ptr [r10 + 120]
	movzx	r13d, byte ptr [rcx + rdi]
	inc	rdi
	mov	qword ptr [r10 + 120], rdi
	add	r13, 33
	mov	rcx, qword ptr [rsp + 16]
	add	rcx, r11
	mov	rdi, qword ptr [rsp + 96]
	add	rdi, rbp
	add	rcx, rdi
	mov	edi, 32
	.p2align	4
702:
	vmovdqu	ymm0, ymmword ptr [rax + rdi]
	vmovdqu	ymmword ptr [rcx + rdi], ymm0
	add	rdi, 32
	cmp	rdi, r13
	jb	702b
	jmp	512b
712:
	sub	rdi, rsi
	mov	r10, qword ptr [rsp + 24]
	mov	r10, qword ptr [r10 + 56]
	shl	rsi, 5
	vmovdqu	ymm1, ymmword ptr [r10 + rsi + 2048]
	mov	r10, qword ptr [rsp + 24]
	vmovdqu	ymm2, ymmword ptr [r15 + rdi]
	vpermq	ymm3, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm3, ymm3, ymm1
	vpshufb	ymm2, ymm2, ymm1
	vpsllw	ymm1, ymm1, 3
	vpblendvb	ymm1, ymm3, ymm2, ymm1
	vpaddb	ymm0, ymm1, ymm0
	vmovdqu	ymmword ptr [r9], ymm0
	cmp	al, 33
	jb	522b
722:
	mov	rax, qword ptr [r10 + 48]
	mov	rsi, qword ptr [r10 + 120]
	movzx	eax, byte ptr [rax + rsi]
	inc	rsi
	mov	qword ptr [r10 + 120], rsi
	add	rax, 33
	mov	rsi, qword ptr [rsp + 16]
	add	rsi, r11
	mov	rdi, qword ptr [rsp + 96]
	add	rdi, r13
	add	rdi, rsi
	add	rdi, rbp
	add	rsi, qword ptr [rsp + 64]
	mov	r10d, 32
	.p2align	4
732:
	vmovdqu	ymm0, ymmword ptr [rsi + r10]
	vmovdqu	ymmword ptr [rdi + r10], ymm0
	add	r10, 32
	cmp	r10, rax
	jb	732b
	mov	r10, qword ptr [rsp + 24]
	jmp	522b
742:
	cmp	rdi, 31
	ja	752f
	mov	qword ptr [r10 + 104], 1
752:
	mov	rdi, qword ptr [r10 + 48]
	mov	rbx, r10
	mov	r10, qword ptr [r10 + 120]
	movzx	ebp, byte ptr [rdi + r10]
	inc	r10
	mov	qword ptr [rbx + 120], r10
	add	rbp, 33
	mov	rdi, qword ptr [rsp + 56]
	lea	r10, [rdi + rax]
	mov	rdi, qword ptr [rsp + 16]
	add	rdi, r13
	add	rdi, r10
	mov	r10, qword ptr [rsp + 40]
	mov	r11, qword ptr [rsp + 96]
	add	r10, r11
	add	rdi, r10
	mov	r10d, 32
	.p2align	4
762:
	vmovdqu	ymm0, ymmword ptr [rsi + r10]
	vmovdqu	ymmword ptr [rdi + r10], ymm0
	add	r10, 32
	cmp	r10, rbp
	jb	762b
	mov	r10, qword ptr [rsp + 24]
	jmp	542b
772:
	sub	rsi, rcx
	mov	rdi, qword ptr [r10 + 56]
	shl	rcx, 5
	vmovdqu	ymm1, ymmword ptr [rdi + rcx + 2048]
	mov	rcx, qword ptr [rsp + 32]
	vmovdqu	ymm2, ymmword ptr [rcx + rsi]
	vpermq	ymm3, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm3, ymm3, ymm1
	vpshufb	ymm2, ymm2, ymm1
	vpsllw	ymm1, ymm1, 3
	vpblendvb	ymm1, ymm3, ymm2, ymm1
	jmp	552b
782:
	mov	rcx, qword ptr [r10 + 48]
	mov	rsi, qword ptr [r10 + 120]
	movzx	r15d, byte ptr [rcx + rsi]
	inc	rsi
	mov	qword ptr [r10 + 120], rsi
	add	r15, 33
	mov	rcx, qword ptr [rsp + 56]
	lea	rsi, [rcx + rax]
	lea	rdi, [rbp + r13]
	add	rdi, rsi
	mov	rcx, qword ptr [rsp + 96]
	mov	r10, qword ptr [rsp + 16]
	add	rcx, r10
	add	rcx, qword ptr [rsp + 40]
	add	rcx, rdi
	mov	rdi, qword ptr [rsp + 64]
	add	rdi, r10
	add	rdi, rsi
	mov	esi, 32
	.p2align	4
792:
	vmovdqu	ymm0, ymmword ptr [rdi + rsi]
	vmovdqu	ymmword ptr [rcx + rsi], ymm0
	add	rsi, 32
	cmp	rsi, r15
	jb	792b
	mov	rsi, r11
	jmp	562b
802:
	cmp	r10, 31
	mov	r10, qword ptr [rsp + 24]
	ja	812f
	mov	qword ptr [r10 + 104], 1
812:
	mov	rcx, qword ptr [r10 + 48]
	mov	rsi, qword ptr [r10 + 120]
	movzx	ecx, byte ptr [rcx + rsi]
	inc	rsi
	mov	qword ptr [r10 + 120], rsi
	add	rcx, 33
	mov	rsi, qword ptr [rsp + 56]
	add	rsi, r15
	add	rbp, rax
	add	rbp, rsi
	add	r13, qword ptr [rsp + 16]
	add	r13, qword ptr [rsp + 96]
	add	r13, rbp
	mov	r10, qword ptr [rsp + 40]
	add	r10, r13
	mov	esi, 32
	.p2align	4
822:
	vmovdqu	ymm0, ymmword ptr [rdi + rsi]
	vmovdqu	ymmword ptr [r10 + rsi], ymm0
	add	rsi, 32
	cmp	rsi, rcx
	jb	822b
	mov	rsi, r11
	jmp	582b
832:
	mov	rsi, r9
	sub	rsi, r15
	cmp	rax, rsi
	mov	rdi, rsi
	cmovb	rdi, rax
	sub	rsi, rdi
	cmp	rdi, r12
	jae	872f
	mov	r10, qword ptr [rsp + 24]
	mov	r10, qword ptr [r10 + 56]
	mov	r14, r11
	mov	r11, rbx
	mov	rbx, rdi
	shl	rbx, 5
	vmovdqu	ymm0, ymmword ptr [r10 + rbx + 2048]
	mov	rbx, r11
	mov	r11, r14
	mov	r10, qword ptr [rsp + 24]
	vmovdqu	ymm1, ymmword ptr [r15 + rsi]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	add	rsi, r15
	jmp	462b
842:
	mov	rax, r9
	sub	rax, r15
	cmp	rsi, rax
	mov	rdi, rax
	cmovb	rdi, rsi
	sub	rax, rdi
	cmp	rdi, r13
	jae	882f
	mov	r10, qword ptr [rsp + 24]
	mov	r10, qword ptr [r10 + 56]
	mov	r11, rbx
	mov	rbx, rdi
	shl	rbx, 5
	vmovdqu	ymm0, ymmword ptr [r10 + rbx + 2048]
	mov	rbx, r11
	mov	r11, qword ptr [rsp + 56]
	mov	r10, qword ptr [rsp + 24]
	vmovdqu	ymm1, ymmword ptr [r15 + rax]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	add	rax, r15
	jmp	502b
852:
	mov	rsi, r9
	sub	rsi, r15
	cmp	rcx, rsi
	mov	rdi, rsi
	cmovb	rdi, rcx
	sub	rsi, rdi
	cmp	rdi, rbp
	jae	892f
	mov	r10, qword ptr [rsp + 24]
	mov	r10, qword ptr [r10 + 56]
	mov	r15, rdi
	shl	r15, 5
	vmovdqu	ymm0, ymmword ptr [r10 + r15 + 2048]
	mov	r15, qword ptr [rsp + 32]
	mov	r10, qword ptr [rsp + 24]
	vmovdqu	ymm1, ymmword ptr [r15 + rsi]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	add	rsi, r15
	jmp	532b
862:
	mov	rdi, r9
	sub	rdi, qword ptr [rsp + 32]
	cmp	rsi, rdi
	mov	r10, rdi
	cmovb	r10, rsi
	sub	rdi, r10
	cmp	r10, rcx
	jae	902f
	mov	rsi, qword ptr [rsp + 24]
	mov	rsi, qword ptr [rsi + 56]
	mov	qword ptr [rsp + 64], rsi
	mov	rsi, r10
	shl	rsi, 5
	mov	r12, qword ptr [rsp + 64]
	vmovdqu	ymm0, ymmword ptr [r12 + rsi + 2048]
	mov	rsi, r11
	mov	r12, qword ptr [rsp + 32]
	vmovdqu	ymm1, ymmword ptr [r12 + rdi]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	add	rdi, qword ptr [rsp + 32]
	jmp	572b
872:
	vmovdqu	ymm0, ymmword ptr [r15 + rsi]
	add	rsi, r15
	jmp	462b
882:
	vmovdqu	ymm0, ymmword ptr [r15 + rax]
	add	rax, r15
	jmp	502b
892:
	vmovdqu	ymm0, ymmword ptr [r15 + rsi]
	add	rsi, r15
	jmp	532b
902:
	mov	r12, qword ptr [rsp + 32]
	vmovdqu	ymm0, ymmword ptr [r12 + rdi]
	add	rdi, r12
	jmp	572b
	.p2align	4
912:
	mov	r9, rbp
	mov	r14, qword ptr [rsp + 64]
	mov	rsi, qword ptr [rsp + 56]
922:
	mov	rax, qword ptr [rsp + 88]
	cmp	rdx, rax
	mov	rbp, r9
	mov	r12, r14
	mov	r14, rax
	je	2b
	.p2align	4
932:
	mov	rax, rbp
	sub	rax, r15
	cmp	rsi, rax
	cmovae	rsi, rax
	cmp	rsi, 31
	jbe	982f
	mov	rax, rbp
	sub	rax, rsi
	vmovdqu	ymm0, ymmword ptr [rax]
942:
	movzx	ecx, byte ptr [rbx + rdx]
	movzx	eax, byte ptr [r10 + rdx + 192]
	mov	esi, dword ptr [r10 + 4*rdx + 256]
	vpaddb	ymm0, ymm0, ymmword ptr [r12]
	vmovdqu	ymmword ptr [rbp], ymm0
	cmp	al, 33
	mov	r13, rsi
	jae	992f
952:
	add	rbp, rax
	mov	edi, ecx
	shr	edi, 2
	cmp	rsi, rdi
	jb	1042f
	mov	r8, rbp
	sub	r8, rsi
	cmp	r8, r15
	jl	1042f
	vmovdqu	ymm0, ymmword ptr [r8]
962:
	vmovdqu	ymmword ptr [rbp], ymm0
	cmp	cl, -124
	jae	1012f
972:
	add	rbp, rdi
	add	r12, rax
	inc	rdx
	cmp	rdx, r14
	mov	rsi, r13
	jb	932b
	jmp	2b
982:
	sub	rax, rsi
	mov	rcx, qword ptr [r10 + 56]
	shl	rsi, 5
	vmovdqu	ymm0, ymmword ptr [rcx + rsi + 2048]
	vmovdqu	ymm1, ymmword ptr [r15 + rax]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	jmp	942b
992:
	mov	rax, qword ptr [r10 + 48]
	mov	rsi, qword ptr [r10 + 120]
	movzx	eax, byte ptr [rax + rsi]
	inc	rsi
	mov	qword ptr [r10 + 120], rsi
	add	rax, 33
	mov	esi, 32
	.p2align	4
1002:
	vmovdqu	ymm0, ymmword ptr [r12 + rsi]
	vmovdqu	ymmword ptr [rbp + rsi], ymm0
	add	rsi, 32
	cmp	rsi, rax
	jb	1002b
	mov	rsi, r13
	jmp	952b
1012:
	cmp	rsi, 31
	ja	1022f
	mov	qword ptr [r10 + 104], 1
1022:
	mov	rcx, qword ptr [r10 + 48]
	mov	rsi, qword ptr [r10 + 120]
	movzx	edi, byte ptr [rcx + rsi]
	inc	rsi
	mov	qword ptr [r10 + 120], rsi
	add	rdi, 33
	mov	ecx, 32
	.p2align	4
1032:
	vmovdqu	ymm0, ymmword ptr [r8 + rcx]
	vmovdqu	ymmword ptr [rbp + rcx], ymm0
	add	rcx, 32
	cmp	rcx, rdi
	jb	1032b
	jmp	972b
1042:
	mov	r8, rbp
	sub	r8, r15
	cmp	rsi, r8
	mov	r9, rsi
	mov	rsi, r8
	cmovb	rsi, r9
	sub	r8, rsi
	cmp	rsi, rdi
	jae	1052f
	mov	r9, qword ptr [r10 + 56]
	mov	r10, rsi
	shl	r10, 5
	vmovdqu	ymm0, ymmword ptr [r9 + r10 + 2048]
	mov	r10, qword ptr [rsp + 24]
	vmovdqu	ymm1, ymmword ptr [r15 + r8]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	add	r8, r15
	jmp	962b
1052:
	vmovdqu	ymm0, ymmword ptr [r15 + r8]
	add	r8, r15
	jmp	962b
1062:
	sub	rbp, r15
	sub	r12, qword ptr [rsp + 256]
	mov	qword ptr [r10 + 80], rbp
	mov	qword ptr [r10 + 88], r12
	add	rsp, 552
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	vzeroupper
	ret
	.p2align	2, 0x0
1072:
	.long	1
	.p2align	2, 0x0
1082:
	.long	7
	.p2align	2, 0x0
1092:
	.long	8
	.p2align	2, 0x0
1102:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	2, 0x0
1112:
	.long	134217727
	.p2align	5, 0x0
1122:
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
1132:
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
1142:
	.byte	1
	.p2align	4, 0x0
1152:
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
1162:
	.byte	16
	.p2align	2, 0x0
1172:
	.byte	32
	.p2align	5, 0x0
1182:
	.long	1207959552
	.long	1342177280
	.long	1476395008
	.long	1610612736
	.long	1744830464
	.long	1879048192
	.long	2013265920
	.long	2147483648
	.p2align	5, 0x0
1192:
	.long	134217728
	.long	268435456
	.long	402653184
	.long	536870912
	.long	671088640
	.long	805306368
	.long	939524096
	.long	1073741824

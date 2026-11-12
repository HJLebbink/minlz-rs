# minlz_exec_delta of crates/minlz/mlir/exec64.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 552
	mov	r13, rdi
	mov	rax, qword ptr [rdi + 64]
	mov	r11, qword ptr [rdi + 80]
	mov	rbx, qword ptr [rdi + 88]
	test	rax, rax
	jle	1042f
	mov	r8, qword ptr [r13]
	mov	rbp, qword ptr [r13 + 8]
	mov	rcx, qword ptr [r13 + 16]
	mov	qword ptr [rsp + 264], rcx
	mov	r15, qword ptr [r13 + 96]
	lea	rdx, [r13 + 512]
	lea	r10, [r13 + 576]
	mov	ecx, 96
	mov	qword ptr [rsp + 136], rcx
	mov	ecx, 7
	mov	qword ptr [rsp + 88], rcx
	mov	qword ptr [rsp + 152], 0
	vpxor	xmm13, xmm13, xmm13
	vbroadcastss	ymm0, dword ptr [rip + 1052f]
	vmovups	ymmword ptr [rsp + 448], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 1062f]
	vmovups	ymmword ptr [rsp + 416], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 1072f]
	vmovups	ymmword ptr [rsp + 384], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 1082f]
	vmovups	ymmword ptr [rsp + 352], ymm0
	vpbroadcastd	ymm0, dword ptr [rip + 1092f]
	vmovdqu	ymmword ptr [rsp + 320], ymm0
	mov	qword ptr [rsp + 144], rdx
	xor	ecx, ecx
	mov	qword ptr [rsp + 72], r13
	mov	qword ptr [rsp + 80], rbp
	mov	qword ptr [rsp + 56], rdx
	mov	qword ptr [rsp + 272], rax
	mov	qword ptr [rsp + 16], r8
	mov	qword ptr [rsp + 8], r10
	jmp	12f
	.p2align	4
2:
	inc	qword ptr [rsp + 152]
	add	qword ptr [rsp + 136], 64
	add	qword ptr [rsp + 88], -64
	add	qword ptr [rsp + 144], -64
	mov	rax, qword ptr [rsp + 272]
	mov	rcx, qword ptr [rsp + 280]
	cmp	rcx, rax
	mov	rdx, qword ptr [rsp + 56]
	jge	1042f
12:
	mov	qword ptr [rsp + 48], rbx
	mov	qword ptr [rsp + 32], r11
	mov	r9, rcx
	mov	rcx, rax
	sub	rcx, r9
	cmp	rcx, 64
	mov	eax, 64
	mov	qword ptr [rsp + 96], rcx
	cmovb	rax, rcx
	mov	qword ptr [rsp + 64], rax
	mov	rdi, qword ptr [r13 + 16]
	mov	rbx, qword ptr [r13 + 24]
	mov	rax, qword ptr [r13 + 32]
	mov	rcx, qword ptr [r13 + 40]
	mov	qword ptr [rsp], rcx
	mov	r11, qword ptr [r13 + 64]
	mov	r14, qword ptr [r13 + 72]
	mov	r12, qword ptr [r13 + 96]
	mov	r8, qword ptr [r13 + 112]
	mov	rsi, qword ptr [r13 + 128]
	mov	rcx, qword ptr [r13 + 136]
	mov	qword ptr [rsp + 192], rcx
	lea	r10, [r11 + 7]
	lea	rcx, [r9 + 64]
	mov	qword ptr [rsp + 280], rcx
	cmp	rcx, r10
	mov	qword ptr [rsp + 40], r9
	mov	qword ptr [rsp + 24], r14
	mov	qword ptr [rsp + 224], r12
	jbe	22f
	cmp	r9, r10
	jge	92f
	mov	rdx, qword ptr [rsp + 152]
	shl	rdx, 6
	mov	ecx, 7
	sub	rcx, rdx
	add	rcx, r11
	cmp	rcx, 16
	mov	r14, qword ptr [rsp + 40]
	jb	72f
	add	rdx, rdi
	mov	r9, r13
	sub	r9, rdx
	add	r9, 511
	cmp	r9, 127
	mov	r14, qword ptr [rsp + 40]
	jb	72f
	cmp	rcx, 128
	jae	32f
	xor	r12d, r12d
	jmp	52f
	.p2align	4
22:
	add	rdi, r9
	mov	rdx, rdi
	jmp	92f
32:
	mov	r12, rcx
	and	r12, -128
	mov	rdx, qword ptr [rsp + 40]
	lea	r14, [rdx + r12]
	mov	rdx, qword ptr [rsp + 136]
	lea	rbp, [rdi + rdx]
	mov	rdx, qword ptr [rsp + 88]
	add	rdx, r11
	and	rdx, -128
	xor	r9d, r9d
	.p2align	4
42:
	vmovdqu	ymm0, ymmword ptr [rbp + r9 - 96]
	vmovdqu	ymm1, ymmword ptr [rbp + r9 - 64]
	vmovdqu	ymm3, ymmword ptr [rbp + r9 - 32]
	vmovups	ymm4, ymmword ptr [rbp + r9]
	vmovdqu	ymmword ptr [r13 + r9 + 512], ymm0
	vmovdqu	ymmword ptr [r13 + r9 + 544], ymm1
	vmovdqu	ymmword ptr [r13 + r9 + 576], ymm3
	vmovups	ymmword ptr [r13 + r9 + 608], ymm4
	sub	r9, -128
	cmp	rdx, r9
	jne	42b
	cmp	rcx, r12
	mov	rdx, qword ptr [rsp + 56]
	mov	rbp, qword ptr [rsp + 80]
	je	92f
	test	cl, 112
	je	72f
52:
	mov	r9, rcx
	and	r9, -16
	mov	rdx, qword ptr [rsp + 40]
	mov	qword ptr [rsp + 160], r9
	lea	r14, [rdx + r9]
	lea	r9, [rdi + rdx]
	add	r11, qword ptr [rsp + 88]
	and	r11, -16
	mov	rdx, qword ptr [rsp + 56]
	.p2align	4
62:
	vmovdqu	xmm0, xmmword ptr [r9 + r12]
	vmovdqu	xmmword ptr [rdx + r12], xmm0
	add	r12, 16
	cmp	r11, r12
	jne	62b
	cmp	rcx, qword ptr [rsp + 160]
	je	92f
	.p2align	4
72:
	mov	rdx, qword ptr [rsp + 144]
	.p2align	4
82:
	movzx	ecx, byte ptr [rdi + r14]
	mov	byte ptr [rdx + r14], cl
	inc	r14
	cmp	r10, r14
	jne	82b
	mov	rdx, qword ptr [rsp + 56]
92:
	vmovdqu	ymm3, ymmword ptr [rdx]
	vmovdqu	ymm4, ymmword ptr [rdx + 32]
	vmovd	xmm0, dword ptr [rsp + 64]
	vpbroadcastb	ymm1, xmm0
	vpmaxub	ymm0, ymm1, ymmword ptr [rip + 1102f]
	vpcmpeqb	ymm0, ymm1, ymm0
	vpmaxub	ymm5, ymm1, ymmword ptr [rip + 1112f]
	vpcmpeqb	ymm1, ymm1, ymm5
	vpsllw	ymm5, ymm3, 6
	vpcmpgtb	ymm8, ymm13, ymm5
	vpsllw	ymm5, ymm4, 6
	vpcmpgtb	ymm9, ymm13, ymm5
	vpbroadcastb	ymm2, byte ptr [rip + 1122f]
	vpand	ymm3, ymm3, ymm2
	vpand	ymm4, ymm4, ymm2
	vpcmpeqb	ymm5, ymm13, ymm4
	vpcmpeqb	ymm3, ymm13, ymm3
	movabs	r14, 72340172838076673
	mov	rdi, r14
	#APP
	#NO_APP
	vpand	ymm4, ymm8, ymm2
	vpand	ymm8, ymm0, ymm4
	vpand	ymm4, ymm9, ymm2
	vpand	ymm4, ymm1, ymm4
	vmovdqu	ymmword ptr [r13 + 544], ymm4
	vmovdqu	ymmword ptr [r13 + 512], ymm8
	vmovq	rcx, xmm8
	mov	r10, rcx
	imul	r10, rdi
	mov	rdx, r10
	sub	rdx, rcx
	xor	rcx, rdi
	shl	rcx, 7
	or	rcx, rdx
	vmovq	xmm9, qword ptr [rbx + rsi]
	vmovq	xmm10, rcx
	vpshufb	xmm9, xmm9, xmm10
	shr	r10, 56
	add	r10, rsi
	vmovq	qword ptr [r13 + 512], xmm9
	vpextrq	rdx, xmm8, 1
	mov	rcx, rdx
	imul	rcx, rdi
	mov	rsi, rcx
	sub	rsi, rdx
	xor	rdx, rdi
	shl	rdx, 7
	or	rdx, rsi
	vmovq	xmm9, qword ptr [rbx + r10]
	vmovq	xmm10, rdx
	vpshufb	xmm9, xmm9, xmm10
	shr	rcx, 56
	add	rcx, r10
	vmovq	qword ptr [r13 + 520], xmm9
	vextracti128	xmm8, ymm8, 1
	vmovq	rdx, xmm8
	mov	rsi, rdx
	imul	rsi, rdi
	mov	r9, rsi
	sub	r9, rdx
	xor	rdx, rdi
	shl	rdx, 7
	or	rdx, r9
	vmovq	xmm9, qword ptr [rbx + rcx]
	vmovq	xmm10, rdx
	vpshufb	xmm9, xmm9, xmm10
	shr	rsi, 56
	add	rsi, rcx
	vmovq	qword ptr [r13 + 528], xmm9
	vpextrq	rdx, xmm8, 1
	mov	rcx, rdx
	imul	rcx, rdi
	mov	r9, rcx
	sub	r9, rdx
	xor	rdx, rdi
	shl	rdx, 7
	or	rdx, r9
	vmovq	xmm8, qword ptr [rbx + rsi]
	vmovq	xmm9, rdx
	vpshufb	xmm8, xmm8, xmm9
	shr	rcx, 56
	add	rcx, rsi
	vmovq	qword ptr [r13 + 536], xmm8
	vmovq	rdx, xmm4
	mov	rsi, rdx
	imul	rsi, rdi
	mov	r9, rsi
	sub	r9, rdx
	xor	rdx, rdi
	shl	rdx, 7
	or	rdx, r9
	vmovq	xmm8, qword ptr [rbx + rcx]
	vmovq	xmm9, rdx
	vpshufb	xmm8, xmm8, xmm9
	shr	rsi, 56
	add	rsi, rcx
	vmovq	qword ptr [r13 + 544], xmm8
	vpextrq	rdx, xmm4, 1
	mov	rcx, rdx
	imul	rcx, rdi
	mov	r9, rcx
	sub	r9, rdx
	xor	rdx, rdi
	shl	rdx, 7
	or	rdx, r9
	vmovq	xmm4, qword ptr [rbx + rsi]
	vmovq	xmm8, rdx
	vpshufb	xmm4, xmm4, xmm8
	shr	rcx, 56
	add	rcx, rsi
	vmovq	qword ptr [r13 + 552], xmm4
	mov	rdx, qword ptr [r13 + 560]
	mov	rsi, qword ptr [r13 + 568]
	mov	r10, rdx
	imul	r10, rdi
	mov	r9, r10
	sub	r9, rdx
	xor	rdx, rdi
	shl	rdx, 7
	or	rdx, r9
	vmovq	xmm4, qword ptr [rbx + rcx]
	vmovq	xmm8, rdx
	vpshufb	xmm4, xmm4, xmm8
	shr	r10, 56
	add	r10, rcx
	vmovq	qword ptr [r13 + 560], xmm4
	mov	r11, rsi
	imul	r11, rdi
	mov	rcx, r11
	sub	rcx, rsi
	xor	rdi, rsi
	shl	rdi, 7
	or	rdi, rcx
	vmovq	xmm4, qword ptr [rbx + r10]
	vmovq	xmm8, rdi
	vpshufb	xmm4, xmm4, xmm8
	vmovq	qword ptr [r13 + 568], xmm4
	vmovups	ymm4, ymmword ptr [r13 + 544]
	vmovups	ymm8, ymmword ptr [r13 + 512]
	vmovups	ymmword ptr [r13 + 192], ymm8
	vmovups	ymmword ptr [r13 + 224], ymm4
	mov	rsi, r14
	#APP
	#NO_APP
	vpand	ymm4, ymm5, ymm2
	vpand	ymm1, ymm1, ymm4
	vpand	ymm3, ymm3, ymm2
	vpand	ymm0, ymm0, ymm3
	vmovdqu	ymmword ptr [r13 + 512], ymm0
	vmovdqu	ymmword ptr [r13 + 544], ymm1
	vmovq	rcx, xmm0
	mov	rdi, rsi
	imul	rdi, rcx
	mov	rdx, rdi
	sub	rdx, rcx
	xor	rcx, rsi
	shl	rcx, 7
	or	rcx, rdx
	mov	rdx, qword ptr [rsp + 192]
	vmovq	xmm3, qword ptr [rax + rdx]
	vmovq	xmm4, rcx
	vpshufb	xmm3, xmm3, xmm4
	shr	rdi, 56
	add	rdi, rdx
	vmovq	qword ptr [r13 + 512], xmm3
	vpextrq	rdx, xmm0, 1
	mov	rcx, rsi
	imul	rcx, rdx
	mov	r9, rcx
	sub	r9, rdx
	xor	rdx, rsi
	shl	rdx, 7
	or	rdx, r9
	vmovq	xmm3, qword ptr [rax + rdi]
	vmovq	xmm4, rdx
	vpshufb	xmm3, xmm3, xmm4
	shr	rcx, 56
	add	rcx, rdi
	vmovq	qword ptr [r13 + 520], xmm3
	vextracti128	xmm0, ymm0, 1
	vmovq	rdi, xmm0
	mov	rdx, rsi
	imul	rdx, rdi
	mov	r9, rdx
	sub	r9, rdi
	xor	rdi, rsi
	shl	rdi, 7
	or	rdi, r9
	vmovq	xmm3, qword ptr [rax + rcx]
	vmovq	xmm4, rdi
	vpshufb	xmm3, xmm3, xmm4
	shr	rdx, 56
	add	rdx, rcx
	vmovq	qword ptr [r13 + 528], xmm3
	vpextrq	rdi, xmm0, 1
	mov	rcx, rsi
	imul	rcx, rdi
	mov	r9, rcx
	sub	r9, rdi
	xor	rdi, rsi
	shl	rdi, 7
	or	rdi, r9
	vmovq	xmm0, qword ptr [rax + rdx]
	vmovq	xmm3, rdi
	vpshufb	xmm0, xmm0, xmm3
	shr	rcx, 56
	add	rcx, rdx
	vmovq	qword ptr [r13 + 536], xmm0
	vmovq	rdi, xmm1
	mov	rdx, rsi
	imul	rdx, rdi
	mov	r9, rdx
	sub	r9, rdi
	xor	rdi, rsi
	shl	rdi, 7
	or	rdi, r9
	vmovq	xmm0, qword ptr [rax + rcx]
	vmovq	xmm3, rdi
	vpshufb	xmm0, xmm0, xmm3
	shr	rdx, 56
	add	rdx, rcx
	vmovq	qword ptr [r13 + 544], xmm0
	vpextrq	rdi, xmm1, 1
	mov	rcx, rsi
	imul	rcx, rdi
	mov	r9, rcx
	sub	r9, rdi
	xor	rdi, rsi
	shl	rdi, 7
	or	rdi, r9
	vmovq	xmm0, qword ptr [rax + rdx]
	vmovq	xmm1, rdi
	vpshufb	xmm0, xmm0, xmm1
	shr	rcx, 56
	add	rcx, rdx
	vmovq	qword ptr [r13 + 552], xmm0
	mov	rdx, qword ptr [r13 + 560]
	mov	rdi, qword ptr [r13 + 568]
	mov	r12, rdx
	imul	r12, rsi
	mov	r9, r12
	sub	r9, rdx
	xor	rdx, rsi
	shl	rdx, 7
	or	rdx, r9
	vmovq	xmm0, qword ptr [rax + rcx]
	vmovq	xmm1, rdx
	vpshufb	xmm0, xmm0, xmm1
	shr	r12, 56
	add	r12, rcx
	vmovq	qword ptr [r13 + 560], xmm0
	mov	rbx, rdi
	imul	rbx, rsi
	mov	rcx, rbx
	sub	rcx, rdi
	xor	rsi, rdi
	shl	rsi, 7
	or	rsi, rcx
	vmovq	xmm0, qword ptr [rax + r12]
	vmovq	xmm1, rsi
	vpshufb	xmm0, xmm0, xmm1
	vmovq	qword ptr [r13 + 568], xmm0
	vmovdqu	ymm7, ymmword ptr [r13 + 512]
	vmovups	ymm0, ymmword ptr [r13 + 544]
	vmovups	ymmword ptr [rsp + 480], ymm0
	vmovss	xmm0, dword ptr [rsp + 224]
	vbroadcastss	ymm0, xmm0
	vmovups	ymmword ptr [rsp + 224], ymm0
	vpmovzxbd	ymm3, qword ptr [r13 + 520]
	vpmovzxbd	ymm8, qword ptr [r13 + 512]
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
	mov	r14, qword ptr [rsp + 24]
	mov	eax, r14d
	and	eax, 7
	vmovd	xmm9, eax
	vpbroadcastd	ymm9, xmm9
	vpaddd	ymm4, ymm9, ymm4
	vpaddd	ymm9, ymm9, ymm5
	vpsrld	ymm14, ymm4, 3
	vpsrld	ymm15, ymm9, 3
	vpand	ymm11, ymm4, ymm1
	vpand	ymm5, ymm9, ymm1
	vbroadcasti128	ymm1, xmmword ptr [rip + 1132f]
	vpshufb	ymm4, ymm14, ymm1
	vpshufb	ymm9, ymm15, ymm1
	vmovdqu	ymm1, ymmword ptr [rsp + 352]
	vpaddb	ymm4, ymm4, ymm1
	vpaddb	ymm9, ymm9, ymm1
	mov	rax, r14
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, r8
	vmovdqu	ymmword ptr [rsp + 512], ymm7
	vmovdqu	ymmword ptr [rsp + 192], ymm3
	vmovdqu	ymmword ptr [rsp + 160], ymm2
	vmovdqu	ymmword ptr [rsp + 288], ymm11
	vmovdqa	ymm11, ymm6
	jbe	102f
	mov	rcx, r8
	sub	rcx, rax
	mov	r9, qword ptr [rsp + 8]
	jbe	172f
	cmp	rcx, 16
	mov	rdx, rax
	jb	152f
	mov	rdx, qword ptr [rsp]
	lea	rsi, [rax + rdx]
	mov	rdx, r13
	sub	rdx, rsi
	add	rdx, 575
	cmp	rdx, 127
	mov	rdx, rax
	jb	152f
	cmp	rcx, 128
	jae	112f
	xor	edi, edi
	jmp	132f
	.p2align	4
102:
	add	rax, qword ptr [rsp]
	mov	r9, rax
	jmp	172f
112:
	mov	rdi, rcx
	and	rdi, -128
	lea	rdx, [rax + rdi]
	mov	r9, qword ptr [rsp]
	lea	r14, [r9 + rax + 96]
	xor	r9d, r9d
	.p2align	4
122:
	vmovdqu	ymm14, ymmword ptr [r14 + r9 - 96]
	vmovdqu	ymm15, ymmword ptr [r14 + r9 - 64]
	vmovdqu	ymm6, ymmword ptr [r14 + r9 - 32]
	vmovdqu	ymm7, ymmword ptr [r14 + r9]
	vmovdqu	ymmword ptr [r13 + r9 + 576], ymm14
	vmovdqu	ymmword ptr [r13 + r9 + 608], ymm15
	vmovdqu	ymmword ptr [r13 + r9 + 640], ymm6
	vmovdqu	ymmword ptr [r13 + r9 + 672], ymm7
	sub	r9, -128
	cmp	rdi, r9
	jne	122b
	cmp	rcx, rdi
	mov	r9, qword ptr [rsp + 8]
	mov	r14, qword ptr [rsp + 24]
	je	172f
	test	cl, 112
	je	152f
132:
	mov	r9, rcx
	and	r9, -16
	lea	rdx, [rax + r9]
	mov	r14, qword ptr [rsp + 8]
	.p2align	4
142:
	vmovdqu	xmm6, xmmword ptr [rsi + rdi]
	vmovdqu	xmmword ptr [r14 + rdi], xmm6
	add	rdi, 16
	cmp	r9, rdi
	jne	142b
	cmp	rcx, r9
	mov	r9, r14
	mov	r14, qword ptr [rsp + 24]
	je	172f
	.p2align	4
152:
	mov	rcx, qword ptr [rsp + 8]
	sub	rcx, rax
	mov	rsi, qword ptr [rsp]
	.p2align	4
162:
	movzx	eax, byte ptr [rsi + rdx]
	mov	byte ptr [rcx + rdx], al
	inc	rdx
	cmp	r8, rdx
	jne	162b
	mov	r9, qword ptr [rsp + 8]
172:
	vmovdqu	ymm6, ymmword ptr [r9]
	vmovdqu	ymm7, ymmword ptr [r9 + 32]
	vpermq	ymm14, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm15, ymm14, ymm4
	vpshufb	ymm2, ymm6, ymm4
	vpbroadcastb	ymm3, byte ptr [rip + 1142f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 1152f]
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
	vmovdqu	ymm0, ymmword ptr [rsp + 160]
	vpandn	ymm1, ymm0, ymm1
	vpaddd	ymm1, ymm1, ymmword ptr [rsp + 192]
	vpor	ymm3, ymm1, ymmword ptr [rip + 1162f]
	vpcmpeqd	ymm1, ymm13, ymm1
	vpandn	ymm1, ymm1, ymm3
	vpor	ymm3, ymm2, ymmword ptr [rip + 1172f]
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
	vmovups	ymm0, ymmword ptr [rsp + 224]
	vblendvps	ymm1, ymm2, ymm0, ymm1
	vpand	ymm2, ymm3, ymm4
	vpcmpeqd	ymm3, ymm13, ymm3
	vblendvps	ymm0, ymm2, ymm0, ymm3
	vextracti128	xmm2, ymm12, 1
	vpextrd	eax, xmm2, 3
	vmovups	ymmword ptr [r13 + 256], ymm0
	vmovups	ymmword ptr [r13 + 288], ymm1
	vshufps	ymm0, ymm1, ymm1, 255
	vpermpd	ymm0, ymm0, 170
	add	r14, rax
	cmp	qword ptr [rsp + 96], 17
	jb	422f
	vmovups	ymmword ptr [rsp + 224], ymm0
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
	mov	eax, r14d
	and	eax, 7
	vmovd	xmm5, eax
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm4, ymm5, ymm4
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm6, ymm4, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm5, ymm8, ymm4
	vpand	ymm8, ymm8, ymm2
	vbroadcasti128	ymm4, xmmword ptr [rip + 1132f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm6, ymm7, ymm4
	vmovdqu	ymm7, ymmword ptr [rsp + 352]
	vpaddb	ymm4, ymm2, ymm7
	vpaddb	ymm9, ymm6, ymm7
	mov	rax, r14
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, r8
	vmovdqu	ymmword ptr [rsp + 192], ymm3
	vmovdqu	ymmword ptr [rsp + 160], ymm5
	vmovdqu	ymmword ptr [rsp + 288], ymm8
	vmovdqa	ymm5, ymm10
	jbe	182f
	mov	rcx, r8
	sub	rcx, rax
	mov	r9, qword ptr [rsp + 8]
	jbe	252f
	cmp	rcx, 16
	mov	rdx, rax
	jb	232f
	mov	rdx, qword ptr [rsp]
	lea	rsi, [rax + rdx]
	mov	rdx, r13
	sub	rdx, rsi
	add	rdx, 575
	cmp	rdx, 127
	mov	rdx, rax
	jb	232f
	cmp	rcx, 128
	mov	qword ptr [rsp + 24], r14
	jae	192f
	xor	edi, edi
	jmp	212f
	.p2align	4
182:
	add	rax, qword ptr [rsp]
	mov	r9, rax
	jmp	252f
192:
	mov	rdi, rcx
	and	rdi, -128
	lea	rdx, [rax + rdi]
	mov	r9, qword ptr [rsp]
	lea	r14, [r9 + rax + 96]
	xor	r9d, r9d
	.p2align	4
202:
	vmovdqu	ymm2, ymmword ptr [r14 + r9 - 96]
	vmovdqu	ymm6, ymmword ptr [r14 + r9 - 64]
	vmovdqu	ymm7, ymmword ptr [r14 + r9 - 32]
	vmovdqu	ymm13, ymmword ptr [r14 + r9]
	vmovdqu	ymmword ptr [r13 + r9 + 576], ymm2
	vmovdqu	ymmword ptr [r13 + r9 + 608], ymm6
	vmovdqu	ymmword ptr [r13 + r9 + 640], ymm7
	vmovdqu	ymmword ptr [r13 + r9 + 672], ymm13
	sub	r9, -128
	cmp	rdi, r9
	jne	202b
	cmp	rcx, rdi
	mov	r9, qword ptr [rsp + 8]
	mov	r14, qword ptr [rsp + 24]
	je	252f
	test	cl, 112
	je	232f
212:
	mov	r9, rcx
	and	r9, -16
	lea	rdx, [rax + r9]
	mov	r14, qword ptr [rsp + 8]
	.p2align	4
222:
	vmovdqu	xmm2, xmmword ptr [rsi + rdi]
	vmovdqu	xmmword ptr [r14 + rdi], xmm2
	add	rdi, 16
	cmp	r9, rdi
	jne	222b
	cmp	rcx, r9
	mov	r9, r14
	mov	r14, qword ptr [rsp + 24]
	je	252f
232:
	mov	rcx, qword ptr [rsp + 8]
	sub	rcx, rax
	mov	rsi, qword ptr [rsp]
	.p2align	4
242:
	movzx	eax, byte ptr [rsi + rdx]
	mov	byte ptr [rcx + rdx], al
	inc	rdx
	cmp	r8, rdx
	jne	242b
	mov	r9, qword ptr [rsp + 8]
252:
	vmovdqu	ymm2, ymmword ptr [r9]
	vmovdqu	ymm6, ymmword ptr [r9 + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm13, ymm7, ymm4
	vpshufb	ymm14, ymm2, ymm4
	vpbroadcastb	ymm3, byte ptr [rip + 1142f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 1152f]
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
	vpsrlvd	ymm3, ymm4, ymmword ptr [rsp + 160]
	vpandn	ymm3, ymm0, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 192]
	vpor	ymm4, ymm3, ymmword ptr [rip + 1162f]
	vpcmpeqd	ymm3, ymm13, ymm3
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 1172f]
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
	vmovups	ymm0, ymmword ptr [rsp + 224]
	vblendvps	ymm2, ymm3, ymm0, ymm2
	vpand	ymm3, ymm4, ymm5
	vpcmpeqd	ymm4, ymm13, ymm4
	vblendvps	ymm0, ymm3, ymm0, ymm4
	vextracti128	xmm1, ymm1, 1
	vpextrd	eax, xmm1, 3
	vmovups	ymmword ptr [r13 + 320], ymm0
	vmovups	ymmword ptr [r13 + 352], ymm2
	vshufps	ymm0, ymm2, ymm2, 255
	vpermpd	ymm0, ymm0, 170
	add	r14, rax
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
	vmovdqu	ymmword ptr [rsp + 192], ymm2
	vpsllvd	ymm1, ymm1, ymm4
	vmovdqu	ymmword ptr [rsp + 224], ymm1
	vpsllvd	ymm1, ymm7, ymm5
	vmovdqu	ymmword ptr [rsp + 288], ymm1
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
	mov	eax, r14d
	and	eax, 7
	vmovd	xmm5, eax
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm4, ymm5, ymm4
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm6, ymm4, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm5, ymm8, ymm4
	vpand	ymm11, ymm8, ymm2
	vbroadcasti128	ymm4, xmmword ptr [rip + 1132f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm6, ymm7, ymm4
	vmovdqu	ymm7, ymmword ptr [rsp + 352]
	vpaddb	ymm4, ymm2, ymm7
	vpaddb	ymm9, ymm6, ymm7
	mov	rax, r14
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, r8
	jbe	262f
	mov	rcx, r8
	sub	rcx, rax
	mov	r9, qword ptr [rsp + 8]
	jbe	332f
	cmp	rcx, 16
	mov	rdx, rax
	jb	312f
	mov	rdx, qword ptr [rsp]
	lea	rsi, [rax + rdx]
	mov	rdx, r13
	sub	rdx, rsi
	add	rdx, 575
	cmp	rdx, 127
	mov	rdx, rax
	jb	312f
	cmp	rcx, 128
	mov	qword ptr [rsp + 24], r14
	jae	272f
	xor	edi, edi
	jmp	292f
262:
	add	rax, qword ptr [rsp]
	mov	r9, rax
	jmp	332f
272:
	mov	rdi, rcx
	and	rdi, -128
	lea	rdx, [rax + rdi]
	mov	r9, qword ptr [rsp]
	lea	r14, [r9 + rax + 96]
	xor	r9d, r9d
	.p2align	4
282:
	vmovdqu	ymm2, ymmword ptr [r14 + r9 - 96]
	vmovdqu	ymm6, ymmword ptr [r14 + r9 - 64]
	vmovdqu	ymm7, ymmword ptr [r14 + r9 - 32]
	vmovdqu	ymm13, ymmword ptr [r14 + r9]
	vmovdqu	ymmword ptr [r13 + r9 + 576], ymm2
	vmovdqu	ymmword ptr [r13 + r9 + 608], ymm6
	vmovdqu	ymmword ptr [r13 + r9 + 640], ymm7
	vmovdqu	ymmword ptr [r13 + r9 + 672], ymm13
	sub	r9, -128
	cmp	rdi, r9
	jne	282b
	cmp	rcx, rdi
	mov	r9, qword ptr [rsp + 8]
	mov	r14, qword ptr [rsp + 24]
	je	332f
	test	cl, 112
	je	312f
292:
	mov	r9, rcx
	and	r9, -16
	lea	rdx, [rax + r9]
	mov	r14, qword ptr [rsp + 8]
	.p2align	4
302:
	vmovdqu	xmm2, xmmword ptr [rsi + rdi]
	vmovdqu	xmmword ptr [r14 + rdi], xmm2
	add	rdi, 16
	cmp	r9, rdi
	jne	302b
	cmp	rcx, r9
	mov	r9, r14
	mov	r14, qword ptr [rsp + 24]
	je	332f
312:
	mov	rcx, qword ptr [rsp + 8]
	sub	rcx, rax
	mov	rsi, qword ptr [rsp]
	.p2align	4
322:
	movzx	eax, byte ptr [rsi + rdx]
	mov	byte ptr [rcx + rdx], al
	inc	rdx
	cmp	r8, rdx
	jne	322b
	mov	r9, qword ptr [rsp + 8]
332:
	vmovdqu	ymm2, ymmword ptr [r9]
	vmovdqu	ymm6, ymmword ptr [r9 + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm13, ymm7, ymm4
	vpshufb	ymm14, ymm2, ymm4
	vpbroadcastb	ymm3, byte ptr [rip + 1142f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 1152f]
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
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 192]
	vpsrlvd	ymm3, ymm4, ymm5
	vmovdqu	ymm4, ymmword ptr [rsp + 160]
	vpandn	ymm3, ymm4, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 224]
	vpor	ymm4, ymm3, ymmword ptr [rip + 1162f]
	vpcmpeqd	ymm3, ymm13, ymm3
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 1172f]
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
	vmovups	ymmword ptr [r13 + 384], ymm0
	vmovups	ymmword ptr [r13 + 416], ymm2
	vshufps	ymm0, ymm2, ymm2, 255
	vpermpd	ymm0, ymm0, 170
	add	r14, rax
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
	vmovdqu	ymmword ptr [rsp + 224], ymm1
	vpsllvd	ymm1, ymm2, ymm4
	vmovdqu	ymmword ptr [rsp + 96], ymm1
	vpsllvd	ymm1, ymm7, ymm5
	vmovdqu	ymmword ptr [rsp + 160], ymm1
	vpsllvd	ymm1, ymm7, ymm4
	vmovdqu	ymmword ptr [rsp + 192], ymm1
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
	mov	eax, r14d
	and	eax, 7
	vmovd	xmm5, eax
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm4, ymm5, ymm4
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm6, ymm4, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm5, ymm8, ymm4
	vpand	ymm11, ymm8, ymm2
	vbroadcasti128	ymm4, xmmword ptr [rip + 1132f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm6, ymm7, ymm4
	vmovdqu	ymm7, ymmword ptr [rsp + 352]
	vpaddb	ymm4, ymm2, ymm7
	vpaddb	ymm9, ymm6, ymm7
	mov	rax, r14
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, r8
	jbe	342f
	mov	rcx, r8
	sub	rcx, rax
	mov	r9, qword ptr [rsp + 8]
	jbe	412f
	cmp	rcx, 16
	mov	rdx, rax
	jb	392f
	mov	rdx, qword ptr [rsp]
	lea	rsi, [rax + rdx]
	mov	rdx, r13
	sub	rdx, rsi
	add	rdx, 575
	cmp	rdx, 127
	mov	rdx, rax
	jb	392f
	cmp	rcx, 128
	mov	qword ptr [rsp + 24], r14
	jae	352f
	xor	edi, edi
	jmp	372f
342:
	mov	r9, qword ptr [rsp]
	add	r9, rax
	jmp	412f
352:
	mov	rdi, rcx
	and	rdi, -128
	lea	rdx, [rax + rdi]
	mov	r9, qword ptr [rsp]
	lea	r14, [r9 + rax + 96]
	xor	r9d, r9d
	.p2align	4
362:
	vmovdqu	ymm2, ymmword ptr [r14 + r9 - 96]
	vmovdqu	ymm6, ymmword ptr [r14 + r9 - 64]
	vmovdqu	ymm7, ymmword ptr [r14 + r9 - 32]
	vmovdqu	ymm13, ymmword ptr [r14 + r9]
	vmovdqu	ymmword ptr [r13 + r9 + 576], ymm2
	vmovdqu	ymmword ptr [r13 + r9 + 608], ymm6
	vmovdqu	ymmword ptr [r13 + r9 + 640], ymm7
	vmovdqu	ymmword ptr [r13 + r9 + 672], ymm13
	sub	r9, -128
	cmp	rdi, r9
	jne	362b
	cmp	rcx, rdi
	mov	r9, qword ptr [rsp + 8]
	mov	r14, qword ptr [rsp + 24]
	je	412f
	test	cl, 112
	je	392f
372:
	mov	r9, rcx
	and	r9, -16
	lea	rdx, [rax + r9]
	mov	r14, qword ptr [rsp + 8]
	.p2align	4
382:
	vmovdqu	xmm2, xmmword ptr [rsi + rdi]
	vmovdqu	xmmword ptr [r14 + rdi], xmm2
	add	rdi, 16
	cmp	r9, rdi
	jne	382b
	cmp	rcx, r9
	mov	r9, r14
	mov	r14, qword ptr [rsp + 24]
	je	412f
392:
	mov	rcx, qword ptr [rsp + 8]
	sub	rcx, rax
	mov	rsi, qword ptr [rsp]
	.p2align	4
402:
	movzx	eax, byte ptr [rsi + rdx]
	mov	byte ptr [rcx + rdx], al
	inc	rdx
	cmp	r8, rdx
	jne	402b
	mov	r9, qword ptr [rsp + 8]
412:
	vmovdqu	ymm2, ymmword ptr [r9]
	vmovdqu	ymm6, ymmword ptr [r9 + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm13, ymm7, ymm4
	vpshufb	ymm14, ymm2, ymm4
	vpbroadcastb	ymm3, byte ptr [rip + 1142f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 1152f]
	vpand	ymm7, ymm9, ymm3
	vpcmpeqb	ymm7, ymm7, ymm3
	vpblendvb	ymm2, ymm2, ymm6, ymm7
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm4, ymm13, ymm8, ymm4
	vpxor	xmm13, xmm13, xmm13
	vpsrlvd	ymm2, ymm2, ymm11
	vmovdqu	ymm3, ymmword ptr [rsp + 160]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 224]
	vpsrlvd	ymm3, ymm4, ymm5
	vmovdqu	ymm4, ymmword ptr [rsp + 192]
	vpandn	ymm3, ymm4, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 96]
	vpor	ymm4, ymm3, ymmword ptr [rip + 1162f]
	vpcmpeqd	ymm3, ymm13, ymm3
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 1172f]
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
	vmovups	ymmword ptr [r13 + 448], ymm0
	vmovups	ymmword ptr [r13 + 480], ymm2
	vshufps	ymm0, ymm2, ymm2, 255
	vpermpd	ymm0, ymm0, 170
	add	r14, rax
	.p2align	4
422:
	shr	rbx, 56
	add	rbx, r12
	shr	r11, 56
	add	r11, r10
	vmovd	eax, xmm0
	mov	qword ptr [r13 + 72], r14
	mov	qword ptr [r13 + 96], rax
	mov	qword ptr [r13 + 128], r11
	mov	qword ptr [r13 + 136], rbx
	mov	rax, qword ptr [rsp + 40]
	add	rax, qword ptr [rsp + 264]
	mov	qword ptr [rsp + 40], rax
	mov	rax, qword ptr [rsp + 64]
	and	rax, 124
	mov	r8, qword ptr [rsp + 16]
	je	892f
	xor	r9d, r9d
	mov	r11, qword ptr [rsp + 32]
	mov	r14, qword ptr [rsp + 48]
	.p2align	4
432:
	cmp	r15, r11
	cmovae	r15, r11
	mov	rcx, r11
	sub	rcx, r15
	cmp	r15, 31
	jbe	572f
	vmovdqu	ymm0, ymmword ptr [r8 + rcx]
442:
	mov	r15, qword ptr [rsp + 40]
	movzx	esi, byte ptr [r15 + r9]
	movzx	r12d, byte ptr [r13 + r9 + 192]
	mov	edx, dword ptr [r13 + 4*r9 + 256]
	vpaddb	ymm0, ymm0, ymmword ptr [rbp + r14]
	vmovdqu	ymmword ptr [r8 + r11], ymm0
	cmp	r12b, 33
	jae	582f
452:
	mov	qword ptr [rsp + 32], r11
	add	r11, r12
	mov	ebx, esi
	shr	ebx, 2
	cmp	edx, ebx
	jb	812f
	mov	rcx, r11
	sub	rcx, rdx
	jb	812f
	vmovdqu	ymm0, ymmword ptr [r8 + rcx]
	mov	rdi, rdx
462:
	vmovdqu	ymmword ptr [r8 + r11], ymm0
	cmp	sil, -124
	jae	602f
472:
	lea	rcx, [r9 + 1]
	mov	qword ptr [rsp + 48], r14
	mov	qword ptr [rsp + 96], r12
	add	r12, r14
	add	r11, rbx
	movzx	edi, byte ptr [r15 + rcx]
	movzx	r10d, byte ptr [r13 + rcx + 192]
	mov	esi, dword ptr [r13 + 4*rcx + 256]
	vmovdqu	ymm0, ymmword ptr [rbp + r12]
	cmp	rdx, r11
	cmovae	rdx, r11
	mov	rcx, r11
	sub	rcx, rdx
	cmp	rdx, 31
	jbe	632f
	vmovdqu	ymm1, ymmword ptr [r8 + rcx]
	vpaddb	ymm0, ymm1, ymm0
	vmovdqu	ymmword ptr [r8 + r11], ymm0
	cmp	r10b, 33
	jae	642f
482:
	add	r11, r10
	mov	r14d, edi
	shr	r14d, 2
	cmp	esi, r14d
	mov	qword ptr [rsp], r10
	jb	822f
	mov	rcx, r11
	sub	rcx, rsi
	jb	822f
	vmovdqu	ymm0, ymmword ptr [r8 + rcx]
	mov	rdx, rsi
492:
	vmovdqu	ymmword ptr [r8 + r11], ymm0
	cmp	dil, -124
	jae	662f
502:
	lea	rcx, [r9 + 2]
	add	r12, r10
	add	r11, r14
	movzx	edi, byte ptr [r15 + rcx]
	movzx	edx, byte ptr [r13 + rcx + 192]
	mov	r10d, dword ptr [r13 + 4*rcx + 256]
	vmovdqu	ymm0, ymmword ptr [rbp + r12]
	cmp	rsi, r11
	cmovae	rsi, r11
	mov	rcx, r11
	sub	rcx, rsi
	cmp	rsi, 31
	jbe	692f
	vmovdqu	ymm1, ymmword ptr [r8 + rcx]
	vpaddb	ymm0, ymm1, ymm0
	vmovdqu	ymmword ptr [r8 + r11], ymm0
	cmp	dl, 33
	jae	702f
512:
	add	r11, rdx
	mov	ebp, edi
	shr	ebp, 2
	cmp	r10d, ebp
	jb	832f
	mov	rcx, r11
	sub	rcx, r10
	jb	832f
	vmovdqu	ymm0, ymmword ptr [r8 + rcx]
	mov	rsi, r10
522:
	vmovdqu	ymmword ptr [r8 + r11], ymm0
	cmp	dil, -124
	jae	722f
532:
	lea	rcx, [r9 + 3]
	add	r12, rdx
	add	r11, rbp
	movzx	edi, byte ptr [r15 + rcx]
	movzx	esi, byte ptr [r13 + rcx + 192]
	mov	r15d, dword ptr [r13 + 4*rcx + 256]
	mov	rcx, qword ptr [rsp + 80]
	vmovdqu	ymm0, ymmword ptr [rcx + r12]
	cmp	r10, r11
	cmovae	r10, r11
	mov	rcx, r11
	sub	rcx, r10
	cmp	r10, 31
	jbe	752f
	vmovdqu	ymm1, ymmword ptr [r8 + rcx]
	vpaddb	ymm0, ymm1, ymm0
	vmovdqu	ymmword ptr [r8 + r11], ymm0
	cmp	sil, 33
	jae	762f
542:
	add	r11, rsi
	mov	r10d, edi
	shr	r10d, 2
	cmp	r15d, r10d
	jb	842f
	mov	rcx, r11
	sub	rcx, r15
	jb	842f
	vmovdqu	ymm0, ymmword ptr [r8 + rcx]
	mov	r13, r15
552:
	vmovdqu	ymmword ptr [r8 + r11], ymm0
	cmp	dil, -124
	jae	782f
562:
	add	rsi, r12
	add	r10, r11
	add	r9, 4
	cmp	r9, rax
	mov	r14, rsi
	mov	r11, r10
	mov	r13, qword ptr [rsp + 72]
	mov	rbp, qword ptr [rsp + 80]
	jb	432b
	jmp	902f
572:
	mov	rdx, qword ptr [r13 + 56]
	shl	r15, 5
	vmovdqu	ymm0, ymmword ptr [rdx + r15 + 2048]
	vmovdqu	ymm1, ymmword ptr [r8 + rcx]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	jmp	442b
582:
	lea	rcx, [rbp + r14]
	lea	rdi, [r8 + r11]
	mov	r8, qword ptr [r13 + 48]
	mov	r10, qword ptr [r13 + 120]
	movzx	r12d, byte ptr [r8 + r10]
	inc	r10
	mov	qword ptr [r13 + 120], r10
	add	r12, 33
	mov	r8d, 32
	.p2align	4
592:
	vmovdqu	ymm0, ymmword ptr [rcx + r8]
	vmovdqu	ymmword ptr [rdi + r8], ymm0
	add	r8, 32
	cmp	r8, r12
	jb	592b
	mov	r8, qword ptr [rsp + 16]
	jmp	452b
602:
	cmp	rdi, 31
	ja	612f
	mov	qword ptr [r13 + 104], 1
612:
	lea	rsi, [r8 + r11]
	mov	rdi, qword ptr [r13 + 48]
	mov	r8, qword ptr [r13 + 120]
	movzx	ebx, byte ptr [rdi + r8]
	inc	r8
	mov	qword ptr [r13 + 120], r8
	mov	r8, qword ptr [rsp + 16]
	add	rbx, 33
	add	rcx, r8
	mov	edi, 32
	.p2align	4
622:
	vmovdqu	ymm0, ymmword ptr [rcx + rdi]
	vmovdqu	ymmword ptr [rsi + rdi], ymm0
	add	rdi, 32
	cmp	rdi, rbx
	jb	622b
	jmp	472b
632:
	mov	r8, qword ptr [r13 + 56]
	shl	rdx, 5
	vmovdqu	ymm1, ymmword ptr [r8 + rdx + 2048]
	mov	r8, qword ptr [rsp + 16]
	vmovdqu	ymm2, ymmword ptr [r8 + rcx]
	vpermq	ymm3, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm3, ymm3, ymm1
	vpshufb	ymm2, ymm2, ymm1
	vpsllw	ymm1, ymm1, 3
	vpblendvb	ymm1, ymm3, ymm2, ymm1
	vpaddb	ymm0, ymm1, ymm0
	vmovdqu	ymmword ptr [r8 + r11], ymm0
	cmp	r10b, 33
	jb	482b
642:
	lea	rcx, [rbp + r12]
	mov	rdx, qword ptr [r13 + 48]
	mov	r10, r8
	mov	r8, qword ptr [r13 + 120]
	movzx	r14d, byte ptr [rdx + r8]
	inc	r8
	mov	qword ptr [r13 + 120], r8
	add	r14, 33
	lea	rdx, [r10 + r11]
	mov	r10, r14
	mov	r8d, 32
	.p2align	4
652:
	vmovdqu	ymm0, ymmword ptr [rcx + r8]
	vmovdqu	ymmword ptr [rdx + r8], ymm0
	add	r8, 32
	cmp	r8, r10
	jb	652b
	mov	r8, qword ptr [rsp + 16]
	jmp	482b
662:
	cmp	rdx, 31
	ja	672f
	mov	qword ptr [r13 + 104], 1
672:
	mov	rdx, qword ptr [r13 + 48]
	mov	rdi, qword ptr [r13 + 120]
	movzx	r14d, byte ptr [rdx + rdi]
	inc	rdi
	mov	qword ptr [r13 + 120], rdi
	add	r14, 33
	add	rcx, r8
	mov	rdx, qword ptr [rsp + 96]
	lea	rdi, [rbx + rdx]
	mov	rdx, qword ptr [rsp + 32]
	add	rdx, r10
	add	rdx, rdi
	add	rdx, r8
	mov	edi, 32
	.p2align	4
682:
	vmovdqu	ymm0, ymmword ptr [rcx + rdi]
	vmovdqu	ymmword ptr [rdx + rdi], ymm0
	add	rdi, 32
	cmp	rdi, r14
	jb	682b
	jmp	502b
692:
	mov	r8, qword ptr [r13 + 56]
	shl	rsi, 5
	vmovdqu	ymm1, ymmword ptr [r8 + rsi + 2048]
	mov	r8, qword ptr [rsp + 16]
	vmovdqu	ymm2, ymmword ptr [r8 + rcx]
	vpermq	ymm3, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm3, ymm3, ymm1
	vpshufb	ymm2, ymm2, ymm1
	vpsllw	ymm1, ymm1, 3
	vpblendvb	ymm1, ymm3, ymm2, ymm1
	vpaddb	ymm0, ymm1, ymm0
	vmovdqu	ymmword ptr [r8 + r11], ymm0
	cmp	dl, 33
	jb	512b
702:
	mov	rcx, qword ptr [r13 + 48]
	mov	rsi, qword ptr [r13 + 120]
	movzx	edx, byte ptr [rcx + rsi]
	inc	rsi
	mov	qword ptr [r13 + 120], rsi
	add	rdx, 33
	mov	rcx, qword ptr [rsp + 96]
	lea	rsi, [rbx + rcx]
	mov	rcx, qword ptr [rsp]
	add	rcx, r14
	add	rcx, rsi
	add	rcx, qword ptr [rsp + 32]
	add	rcx, r8
	lea	rsi, [rbp + r12]
	mov	r8d, 32
	.p2align	4
712:
	vmovdqu	ymm0, ymmword ptr [rsi + r8]
	vmovdqu	ymmword ptr [rcx + r8], ymm0
	add	r8, 32
	cmp	r8, rdx
	jb	712b
	mov	r8, qword ptr [rsp + 16]
	jmp	512b
722:
	cmp	rsi, 31
	ja	732f
	mov	qword ptr [r13 + 104], 1
732:
	mov	rsi, qword ptr [r13 + 48]
	mov	rdi, qword ptr [r13 + 120]
	movzx	ebp, byte ptr [rsi + rdi]
	inc	rdi
	mov	qword ptr [r13 + 120], rdi
	add	rbp, 33
	add	rcx, r8
	mov	rsi, qword ptr [rsp + 96]
	lea	rdi, [rbx + rsi]
	lea	rsi, [rdx + r14]
	add	rsi, rdi
	mov	qword ptr [rsp + 24], rsi
	mov	rdi, qword ptr [rsp + 32]
	mov	rsi, qword ptr [rsp]
	add	rdi, rsi
	mov	rsi, qword ptr [rsp + 24]
	add	rsi, rdi
	add	rsi, r8
	mov	edi, 32
	.p2align	4
742:
	vmovdqu	ymm0, ymmword ptr [rcx + rdi]
	vmovdqu	ymmword ptr [rsi + rdi], ymm0
	add	rdi, 32
	cmp	rdi, rbp
	jb	742b
	jmp	532b
752:
	mov	r8, qword ptr [r13 + 56]
	shl	r10, 5
	vmovdqu	ymm1, ymmword ptr [r8 + r10 + 2048]
	mov	r8, qword ptr [rsp + 16]
	vmovdqu	ymm2, ymmword ptr [r8 + rcx]
	vpermq	ymm3, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm3, ymm3, ymm1
	vpshufb	ymm2, ymm2, ymm1
	vpsllw	ymm1, ymm1, 3
	vpblendvb	ymm1, ymm3, ymm2, ymm1
	vpaddb	ymm0, ymm1, ymm0
	vmovdqu	ymmword ptr [r8 + r11], ymm0
	cmp	sil, 33
	jb	542b
762:
	mov	rcx, qword ptr [r13 + 48]
	mov	r8, qword ptr [r13 + 120]
	movzx	esi, byte ptr [rcx + r8]
	inc	r8
	mov	qword ptr [r13 + 120], r8
	add	rsi, 33
	mov	r13, qword ptr [rsp + 96]
	lea	r8, [rbp + rdx]
	add	r8, rbx
	add	r8, r13
	mov	r10, qword ptr [rsp]
	lea	rcx, [r14 + r10]
	add	rcx, qword ptr [rsp + 32]
	add	rcx, r8
	add	rcx, qword ptr [rsp + 16]
	lea	r8, [r10 + r13]
	mov	r10, qword ptr [rsp + 48]
	add	r10, rdx
	add	r10, r8
	add	r10, qword ptr [rsp + 80]
	mov	r8d, 32
	.p2align	4
772:
	vmovdqu	ymm0, ymmword ptr [r10 + r8]
	vmovdqu	ymmword ptr [rcx + r8], ymm0
	add	r8, 32
	cmp	r8, rsi
	jb	772b
	mov	r8, qword ptr [rsp + 16]
	jmp	542b
782:
	cmp	r13, 31
	mov	r13, qword ptr [rsp + 72]
	ja	792f
	mov	qword ptr [r13 + 104], 1
792:
	mov	rdi, qword ptr [r13 + 48]
	mov	r8, qword ptr [r13 + 120]
	movzx	r10d, byte ptr [rdi + r8]
	inc	r8
	mov	qword ptr [r13 + 120], r8
	add	r10, 33
	mov	r8, qword ptr [rsp + 16]
	add	rcx, r8
	add	rbx, qword ptr [rsp + 96]
	add	rbp, rsi
	add	rbp, rbx
	add	rdx, r14
	add	rdx, qword ptr [rsp]
	add	rdx, rbp
	add	rdx, qword ptr [rsp + 32]
	add	rdx, r8
	mov	edi, 32
	.p2align	4
802:
	vmovdqu	ymm0, ymmword ptr [rcx + rdi]
	vmovdqu	ymmword ptr [rdx + rdi], ymm0
	add	rdi, 32
	cmp	rdi, r10
	jb	802b
	jmp	562b
812:
	cmp	rdx, r11
	mov	rdi, r11
	cmovb	rdi, rdx
	mov	rcx, r11
	sub	rcx, rdi
	cmp	rdi, rbx
	jae	852f
	mov	r8, qword ptr [r13 + 56]
	mov	r10, rdi
	shl	r10, 5
	vmovdqu	ymm0, ymmword ptr [r8 + r10 + 2048]
	mov	r8, qword ptr [rsp + 16]
	vmovdqu	ymm1, ymmword ptr [r8 + rcx]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	jmp	462b
822:
	cmp	rsi, r11
	mov	rdx, r11
	cmovb	rdx, rsi
	mov	rcx, r11
	sub	rcx, rdx
	cmp	rdx, r14
	jae	862f
	mov	r8, qword ptr [r13 + 56]
	mov	qword ptr [rsp + 24], r8
	mov	r10, rdx
	shl	r10, 5
	mov	r8, qword ptr [rsp + 24]
	vmovdqu	ymm0, ymmword ptr [r8 + r10 + 2048]
	mov	r10, qword ptr [rsp]
	mov	r8, qword ptr [rsp + 16]
	vmovdqu	ymm1, ymmword ptr [r8 + rcx]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	jmp	492b
832:
	cmp	r10, r11
	mov	rsi, r11
	cmovb	rsi, r10
	mov	rcx, r11
	sub	rcx, rsi
	cmp	rsi, rbp
	jae	872f
	mov	r8, qword ptr [r13 + 56]
	mov	r13, rsi
	shl	r13, 5
	vmovdqu	ymm0, ymmword ptr [r8 + r13 + 2048]
	mov	r8, qword ptr [rsp + 16]
	mov	r13, qword ptr [rsp + 72]
	vmovdqu	ymm1, ymmword ptr [r8 + rcx]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	jmp	522b
842:
	cmp	r15, r11
	mov	r13, r11
	cmovb	r13, r15
	mov	rcx, r11
	sub	rcx, r13
	cmp	r13, r10
	jae	882f
	mov	r8, qword ptr [rsp + 72]
	mov	r8, qword ptr [r8 + 56]
	mov	qword ptr [rsp + 48], r8
	mov	r8, r13
	shl	r8, 5
	mov	qword ptr [rsp + 24], r15
	mov	r15, qword ptr [rsp + 48]
	vmovdqu	ymm0, ymmword ptr [r15 + r8 + 2048]
	mov	r15, qword ptr [rsp + 24]
	mov	r8, qword ptr [rsp + 16]
	vmovdqu	ymm1, ymmword ptr [r8 + rcx]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	jmp	552b
852:
	vmovdqu	ymm0, ymmword ptr [r8 + rcx]
	jmp	462b
862:
	vmovdqu	ymm0, ymmword ptr [r8 + rcx]
	jmp	492b
872:
	vmovdqu	ymm0, ymmword ptr [r8 + rcx]
	jmp	522b
882:
	vmovdqu	ymm0, ymmword ptr [r8 + rcx]
	jmp	552b
	.p2align	4
892:
	mov	r10, qword ptr [rsp + 32]
	mov	rsi, qword ptr [rsp + 48]
902:
	cmp	rax, qword ptr [rsp + 64]
	mov	r11, r10
	mov	rbx, rsi
	je	2b
	.p2align	4
912:
	cmp	r15, r11
	cmovae	r15, r11
	mov	rcx, r11
	sub	rcx, r15
	cmp	r15, 31
	jbe	962f
	vmovdqu	ymm0, ymmword ptr [r8 + rcx]
922:
	mov	rcx, qword ptr [rsp + 40]
	movzx	esi, byte ptr [rcx + rax]
	movzx	edx, byte ptr [r13 + rax + 192]
	mov	r15d, dword ptr [r13 + 4*rax + 256]
	vpaddb	ymm0, ymm0, ymmword ptr [rbp + rbx]
	vmovdqu	ymmword ptr [r8 + r11], ymm0
	cmp	dl, 33
	jae	972f
932:
	add	r11, rdx
	mov	ecx, esi
	shr	ecx, 2
	cmp	r15d, ecx
	jb	1022f
	mov	rdi, r11
	sub	rdi, r15
	jb	1022f
	vmovdqu	ymm0, ymmword ptr [r8 + rdi]
	mov	r9, r8
	mov	r8, r15
942:
	vmovdqu	ymmword ptr [r9 + r11], ymm0
	cmp	sil, -124
	jae	992f
952:
	add	rbx, rdx
	add	r11, rcx
	inc	rax
	cmp	rax, qword ptr [rsp + 64]
	mov	r8, qword ptr [rsp + 16]
	jb	912b
	jmp	2b
962:
	mov	rdx, qword ptr [r13 + 56]
	shl	r15, 5
	vmovdqu	ymm0, ymmword ptr [rdx + r15 + 2048]
	vmovdqu	ymm1, ymmword ptr [r8 + rcx]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	jmp	922b
972:
	lea	rcx, [rbp + rbx]
	lea	rdi, [r8 + r11]
	mov	rdx, qword ptr [r13 + 48]
	mov	r8, qword ptr [r13 + 120]
	movzx	edx, byte ptr [rdx + r8]
	inc	r8
	mov	qword ptr [r13 + 120], r8
	add	rdx, 33
	mov	r8d, 32
	.p2align	4
982:
	vmovdqu	ymm0, ymmword ptr [rcx + r8]
	vmovdqu	ymmword ptr [rdi + r8], ymm0
	add	r8, 32
	cmp	r8, rdx
	jb	982b
	mov	r8, qword ptr [rsp + 16]
	jmp	932b
992:
	cmp	r8, 31
	ja	1002f
	mov	qword ptr [r13 + 104], 1
1002:
	mov	r9, qword ptr [rsp + 16]
	lea	rsi, [r9 + r11]
	mov	rcx, qword ptr [r13 + 48]
	mov	r8, qword ptr [r13 + 120]
	movzx	ecx, byte ptr [rcx + r8]
	inc	r8
	mov	qword ptr [r13 + 120], r8
	add	rcx, 33
	add	rdi, r9
	mov	r8d, 32
	.p2align	4
1012:
	vmovdqu	ymm0, ymmword ptr [rdi + r8]
	vmovdqu	ymmword ptr [rsi + r8], ymm0
	add	r8, 32
	cmp	r8, rcx
	jb	1012b
	jmp	952b
1022:
	cmp	r15, r11
	mov	r8, r11
	cmovb	r8, r15
	mov	rdi, r11
	sub	rdi, r8
	cmp	r8, rcx
	jae	1032f
	mov	r9, qword ptr [r13 + 56]
	mov	r10, r8
	shl	r10, 5
	vmovdqu	ymm0, ymmword ptr [r9 + r10 + 2048]
	mov	r9, qword ptr [rsp + 16]
	vmovdqu	ymm1, ymmword ptr [r9 + rdi]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	jmp	942b
1032:
	mov	r9, qword ptr [rsp + 16]
	vmovdqu	ymm0, ymmword ptr [r9 + rdi]
	jmp	942b
1042:
	mov	qword ptr [r13 + 80], r11
	mov	qword ptr [r13 + 88], rbx
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
1052:
	.long	1
	.p2align	2, 0x0
1062:
	.long	7
	.p2align	2, 0x0
1072:
	.long	8
	.p2align	2, 0x0
1082:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	2, 0x0
1092:
	.long	134217727
	.p2align	5, 0x0
1102:
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
1112:
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
1122:
	.byte	1
	.p2align	4, 0x0
1132:
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
1142:
	.byte	16
	.p2align	2, 0x0
1152:
	.byte	32
	.p2align	5, 0x0
1162:
	.long	1207959552
	.long	1342177280
	.long	1476395008
	.long	1610612736
	.long	1744830464
	.long	1879048192
	.long	2013265920
	.long	2147483648
	.p2align	5, 0x0
1172:
	.long	134217728
	.long	268435456
	.long	402653184
	.long	536870912
	.long	671088640
	.long	805306368
	.long	939524096
	.long	1073741824

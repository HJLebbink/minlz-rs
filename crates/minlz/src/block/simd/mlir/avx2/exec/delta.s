# minlz_exec_delta of crates/minlz/mlir/exec64.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 648
	mov	r13, rdi
	mov	rax, qword ptr [rdi + 64]
	mov	r12, qword ptr [rdi + 80]
	mov	rdi, qword ptr [rdi + 88]
	test	rax, rax
	jle	1042f
	mov	r11, qword ptr [r13]
	mov	rbp, qword ptr [r13 + 8]
	mov	rcx, qword ptr [r13 + 16]
	mov	qword ptr [rsp + 264], rcx
	mov	r15, qword ptr [r13 + 96]
	lea	rsi, [r13 + 512]
	lea	r10, [r13 + 576]
	mov	ecx, 96
	mov	qword ptr [rsp + 168], rcx
	mov	ecx, 7
	mov	qword ptr [rsp + 112], rcx
	mov	qword ptr [rsp + 176], 0
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
	mov	rcx, rsi
	xor	edx, edx
	mov	qword ptr [rsp + 64], r13
	mov	qword ptr [rsp + 72], rbp
	mov	qword ptr [rsp + 56], rsi
	mov	qword ptr [rsp + 272], rax
	mov	qword ptr [rsp + 8], r11
	mov	qword ptr [rsp + 40], r10
	jmp	12f
	.p2align	4
2:
	inc	qword ptr [rsp + 176]
	add	qword ptr [rsp + 168], 64
	add	qword ptr [rsp + 112], -64
	mov	rcx, qword ptr [rsp + 184]
	add	rcx, -64
	mov	rax, qword ptr [rsp + 272]
	mov	rdx, qword ptr [rsp + 280]
	cmp	rdx, rax
	jge	1042f
12:
	mov	qword ptr [rsp + 16], rdi
	mov	qword ptr [rsp + 184], rcx
	mov	qword ptr [rsp + 24], r12
	mov	rcx, rax
	sub	rcx, rdx
	cmp	rcx, 64
	mov	eax, 64
	mov	qword ptr [rsp + 80], rcx
	cmovb	rax, rcx
	mov	qword ptr [rsp + 120], rax
	mov	r10, qword ptr [r13 + 16]
	mov	rsi, qword ptr [r13 + 24]
	mov	rax, qword ptr [r13 + 32]
	mov	rcx, qword ptr [r13 + 40]
	mov	qword ptr [rsp], rcx
	mov	rbx, qword ptr [r13 + 64]
	mov	r9, qword ptr [r13 + 72]
	mov	r14, qword ptr [r13 + 96]
	mov	r8, qword ptr [r13 + 112]
	mov	rdi, qword ptr [r13 + 128]
	mov	rcx, qword ptr [r13 + 136]
	mov	qword ptr [rsp + 192], rcx
	lea	r11, [rbx + 7]
	lea	rcx, [rdx + 64]
	mov	qword ptr [rsp + 280], rcx
	cmp	rcx, r11
	mov	qword ptr [rsp + 32], rdx
	mov	qword ptr [rsp + 128], r9
	mov	qword ptr [rsp + 224], r14
	jbe	22f
	cmp	rdx, r11
	mov	r9, qword ptr [rsp + 56]
	jge	92f
	mov	rdx, qword ptr [rsp + 176]
	shl	rdx, 6
	mov	ecx, 7
	sub	rcx, rdx
	add	rcx, rbx
	cmp	rcx, 16
	mov	r14, qword ptr [rsp + 32]
	jb	72f
	add	rdx, r10
	mov	r9, r13
	sub	r9, rdx
	add	r9, 511
	cmp	r9, 127
	mov	r14, qword ptr [rsp + 32]
	jb	72f
	cmp	rcx, 128
	jae	32f
	xor	r12d, r12d
	jmp	52f
	.p2align	4
22:
	add	r10, rdx
	mov	r9, r10
	jmp	92f
32:
	mov	r12, rcx
	and	r12, -128
	mov	rdx, qword ptr [rsp + 32]
	lea	r14, [rdx + r12]
	mov	rdx, qword ptr [rsp + 168]
	lea	rbp, [r10 + rdx]
	mov	rdx, qword ptr [rsp + 112]
	add	rdx, rbx
	and	rdx, -128
	xor	r9d, r9d
	.p2align	4
42:
	vmovdqu	ymm0, ymmword ptr [rbp + r9 - 96]
	vmovdqu	ymm1, ymmword ptr [rbp + r9 - 64]
	vmovdqu	ymm3, ymmword ptr [rbp + r9 - 32]
	vmovdqu	ymm4, ymmword ptr [rbp + r9]
	vmovdqu	ymmword ptr [r13 + r9 + 512], ymm0
	vmovdqu	ymmword ptr [r13 + r9 + 544], ymm1
	vmovdqu	ymmword ptr [r13 + r9 + 576], ymm3
	vmovdqu	ymmword ptr [r13 + r9 + 608], ymm4
	sub	r9, -128
	cmp	rdx, r9
	jne	42b
	cmp	rcx, r12
	mov	r9, qword ptr [rsp + 56]
	mov	rbp, qword ptr [rsp + 72]
	je	92f
	test	cl, 112
	je	72f
52:
	mov	r9, rcx
	and	r9, -16
	mov	rdx, qword ptr [rsp + 32]
	mov	qword ptr [rsp + 48], r9
	lea	r14, [rdx + r9]
	mov	r9, qword ptr [rsp + 56]
	add	rdx, r10
	add	rbx, qword ptr [rsp + 112]
	and	rbx, -16
	.p2align	4
62:
	vmovdqu	xmm0, xmmword ptr [rdx + r12]
	vmovdqu	xmmword ptr [r9 + r12], xmm0
	add	r12, 16
	cmp	rbx, r12
	jne	62b
	cmp	rcx, qword ptr [rsp + 48]
	je	92f
	.p2align	4
72:
	mov	rdx, qword ptr [rsp + 184]
	.p2align	4
82:
	movzx	ecx, byte ptr [r10 + r14]
	mov	byte ptr [rdx + r14], cl
	inc	r14
	cmp	r11, r14
	jne	82b
	mov	r9, qword ptr [rsp + 56]
92:
	vmovdqu	ymm3, ymmword ptr [r9]
	vmovdqu	ymm4, ymmword ptr [r9 + 32]
	vmovd	xmm0, dword ptr [rsp + 120]
	vpbroadcastb	ymm1, xmm0
	vpmaxub	ymm0, ymm1, ymmword ptr [rip + 1102f]
	vpcmpeqb	ymm0, ymm1, ymm0
	vpmaxub	ymm5, ymm1, ymmword ptr [rip + 1112f]
	vpcmpeqb	ymm1, ymm1, ymm5
	vpsllw	ymm5, ymm3, 6
	vpxor	xmm2, xmm2, xmm2
	vpcmpgtb	ymm5, ymm2, ymm5
	vpsllw	ymm6, ymm4, 6
	vpcmpgtb	ymm9, ymm2, ymm6
	vpbroadcastb	ymm7, byte ptr [rip + 1122f]
	vpand	ymm3, ymm3, ymm7
	vpand	ymm4, ymm4, ymm7
	vpcmpeqb	ymm4, ymm4, ymm2
	vpcmpeqb	ymm3, ymm3, ymm2
	movabs	r14, 72340172838076673
	mov	r11, r14
	#APP
	#NO_APP
	vpand	ymm5, ymm5, ymm7
	vpand	ymm6, ymm0, ymm5
	vpand	ymm5, ymm9, ymm7
	vpand	ymm5, ymm1, ymm5
	vmovdqu	ymmword ptr [r13 + 544], ymm5
	vmovdqu	ymmword ptr [r13 + 512], ymm6
	vmovq	rcx, xmm6
	mov	r10, rcx
	imul	r10, r11
	mov	rdx, r10
	sub	rdx, rcx
	xor	rcx, r11
	shl	rcx, 7
	or	rcx, rdx
	vmovq	xmm9, qword ptr [rsi + rdi]
	vmovq	xmm10, rcx
	vpshufb	xmm9, xmm9, xmm10
	shr	r10, 56
	add	r10, rdi
	vmovq	qword ptr [r13 + 512], xmm9
	vpextrq	rdx, xmm6, 1
	mov	rcx, rdx
	imul	rcx, r11
	mov	rdi, rcx
	sub	rdi, rdx
	xor	rdx, r11
	shl	rdx, 7
	or	rdx, rdi
	vmovq	xmm9, qword ptr [rsi + r10]
	vmovq	xmm10, rdx
	vpshufb	xmm9, xmm9, xmm10
	shr	rcx, 56
	add	rcx, r10
	vmovq	qword ptr [r13 + 520], xmm9
	vextracti128	xmm6, ymm6, 1
	vmovq	rdx, xmm6
	mov	rdi, rdx
	imul	rdi, r11
	mov	r9, rdi
	sub	r9, rdx
	xor	rdx, r11
	shl	rdx, 7
	or	rdx, r9
	vmovq	xmm9, qword ptr [rsi + rcx]
	vmovq	xmm10, rdx
	vpshufb	xmm9, xmm9, xmm10
	shr	rdi, 56
	add	rdi, rcx
	vmovq	qword ptr [r13 + 528], xmm9
	vpextrq	rdx, xmm6, 1
	mov	rcx, rdx
	imul	rcx, r11
	mov	r9, rcx
	sub	r9, rdx
	xor	rdx, r11
	shl	rdx, 7
	or	rdx, r9
	vmovq	xmm6, qword ptr [rsi + rdi]
	vmovq	xmm9, rdx
	vpshufb	xmm6, xmm6, xmm9
	shr	rcx, 56
	add	rcx, rdi
	vmovq	qword ptr [r13 + 536], xmm6
	vmovq	rdx, xmm5
	mov	rdi, rdx
	imul	rdi, r11
	mov	r9, rdi
	sub	r9, rdx
	xor	rdx, r11
	shl	rdx, 7
	or	rdx, r9
	vmovq	xmm6, qword ptr [rsi + rcx]
	vmovq	xmm9, rdx
	vpshufb	xmm6, xmm6, xmm9
	shr	rdi, 56
	add	rdi, rcx
	vmovq	qword ptr [r13 + 544], xmm6
	vpextrq	rdx, xmm5, 1
	mov	rcx, rdx
	imul	rcx, r11
	mov	r9, rcx
	sub	r9, rdx
	xor	rdx, r11
	shl	rdx, 7
	or	rdx, r9
	vmovq	xmm5, qword ptr [rsi + rdi]
	vmovq	xmm6, rdx
	vpshufb	xmm5, xmm5, xmm6
	shr	rcx, 56
	add	rcx, rdi
	vmovq	qword ptr [r13 + 552], xmm5
	mov	rdx, qword ptr [r13 + 560]
	mov	rdi, qword ptr [r13 + 568]
	mov	r10, rdx
	imul	r10, r11
	mov	r9, r10
	sub	r9, rdx
	xor	rdx, r11
	shl	rdx, 7
	or	rdx, r9
	vmovq	xmm5, qword ptr [rsi + rcx]
	vmovq	xmm6, rdx
	vpshufb	xmm5, xmm5, xmm6
	shr	r10, 56
	add	r10, rcx
	vmovq	qword ptr [r13 + 560], xmm5
	mov	rcx, rdi
	imul	rcx, r11
	mov	qword ptr [rsp + 48], rcx
	sub	rcx, rdi
	xor	r11, rdi
	shl	r11, 7
	or	r11, rcx
	vmovq	xmm5, qword ptr [rsi + r10]
	vmovq	xmm6, r11
	vpshufb	xmm5, xmm5, xmm6
	vmovq	qword ptr [r13 + 568], xmm5
	vmovups	ymm5, ymmword ptr [r13 + 544]
	vmovups	ymm6, ymmword ptr [r13 + 512]
	vmovups	ymmword ptr [r13 + 192], ymm6
	vmovups	ymmword ptr [r13 + 224], ymm5
	mov	rsi, r14
	#APP
	#NO_APP
	vpand	ymm4, ymm4, ymm7
	vpand	ymm1, ymm1, ymm4
	vpand	ymm3, ymm3, ymm7
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
	mov	r11, rdi
	imul	r11, rsi
	mov	rcx, r11
	sub	rcx, rdi
	xor	rsi, rdi
	shl	rsi, 7
	or	rsi, rcx
	vmovq	xmm0, qword ptr [rax + r12]
	vmovq	xmm1, rsi
	vpshufb	xmm0, xmm0, xmm1
	vmovq	qword ptr [r13 + 568], xmm0
	vmovdqu	ymm8, ymmword ptr [r13 + 512]
	vmovdqu	ymm0, ymmword ptr [r13 + 512]
	vmovups	ymm1, ymmword ptr [r13 + 544]
	vmovups	ymmword ptr [rsp + 544], ymm1
	vpsrlw	ymm0, ymm0, 3
	vpand	ymm0, ymm0, ymmword ptr [rip + 1132f]
	vpsubusb	ymm0, ymm0, ymm7
	vpsllq	ymm1, ymm0, 8
	vpaddb	ymm1, ymm0, ymm1
	vpsllq	ymm3, ymm1, 16
	vpaddb	ymm1, ymm1, ymm3
	vpsllq	ymm3, ymm1, 32
	vpaddb	ymm1, ymm1, ymm3
	vpsubb	ymm14, ymm1, ymm0
	vpsrlq	ymm13, ymm1, 56
	vmovss	xmm0, dword ptr [rsp + 224]
	vbroadcastss	ymm0, xmm0
	vmovups	ymmword ptr [rsp + 288], ymm0
	vpbroadcastd	ymm0, xmm13
	vpmovzxbd	ymm5, xmm14
	vpshufd	xmm3, xmm14, 238
	vpmovzxbd	ymm3, xmm3
	vpaddd	ymm0, ymm0, ymm3
	vpmovzxbd	ymm3, qword ptr [r13 + 520]
	vpmovzxbd	ymm6, qword ptr [r13 + 512]
	vpsrld	ymm9, ymm6, 3
	vpsrld	ymm10, ymm3, 3
	vmovdqu	ymm2, ymmword ptr [rsp + 448]
	vpmaxud	ymm10, ymm10, ymm2
	vpcmpeqd	ymm4, ymm4, ymm4
	vpaddd	ymm10, ymm10, ymm4
	vpmaxud	ymm9, ymm9, ymm2
	vpaddd	ymm9, ymm9, ymm4
	vmovdqu	ymm2, ymmword ptr [rsp + 416]
	vpand	ymm11, ymm6, ymm2
	vpand	ymm12, ymm3, ymm2
	vmovdqu	ymm7, ymmword ptr [rsp + 384]
	vpminud	ymm3, ymm3, ymm7
	vpminud	ymm6, ymm6, ymm7
	vpand	ymm6, ymm6, ymm7
	vpor	ymm6, ymm11, ymm6
	vpand	ymm3, ymm3, ymm7
	vpor	ymm11, ymm12, ymm3
	vpsllvd	ymm12, ymm6, ymm9
	vpsllvd	ymm6, ymm11, ymm10
	vpsllvd	ymm1, ymm4, ymm9
	vpsllvd	ymm4, ymm4, ymm10
	vpaddd	ymm3, ymm10, ymm0
	mov	rcx, qword ptr [rsp + 128]
	mov	eax, ecx
	and	eax, 7
	vmovd	xmm10, eax
	vpbroadcastd	ymm10, xmm10
	vpaddd	ymm0, ymm10, ymm0
	vpaddd	ymm10, ymm10, ymm5
	vpsrld	ymm15, ymm0, 3
	vpsrld	ymm7, ymm10, 3
	vpand	ymm5, ymm0, ymm2
	vpand	ymm10, ymm10, ymm2
	vbroadcasti128	ymm2, xmmword ptr [rip + 1142f]
	vpshufb	ymm0, ymm15, ymm2
	vpshufb	ymm7, ymm7, ymm2
	vmovdqu	ymm2, ymmword ptr [rsp + 352]
	vpaddb	ymm15, ymm0, ymm2
	vpaddb	ymm0, ymm7, ymm2
	mov	rbx, rcx
	mov	rax, rcx
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, r8
	vmovdqu	ymmword ptr [rsp + 608], ymm8
	vmovdqu	ymmword ptr [rsp + 576], ymm13
	vmovdqu	ymmword ptr [rsp + 224], ymm3
	vmovdqu	ymmword ptr [rsp + 192], ymm6
	vmovdqu	ymmword ptr [rsp + 512], ymm4
	vmovdqu	ymmword ptr [rsp + 480], ymm5
	vmovdqa	ymm5, ymm12
	jbe	102f
	mov	rcx, r8
	sub	rcx, rax
	mov	r14, qword ptr [rsp + 40]
	mov	r9, r14
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
	mov	r14, qword ptr [rsp + 40]
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
	vmovdqu	ymm7, ymmword ptr [r14 + r9 - 96]
	vmovdqu	ymm8, ymmword ptr [r14 + r9 - 64]
	vmovdqu	ymm2, ymmword ptr [r14 + r9 - 32]
	vmovdqu	ymm4, ymmword ptr [r14 + r9]
	vmovdqu	ymmword ptr [r13 + r9 + 576], ymm7
	vmovdqu	ymmword ptr [r13 + r9 + 608], ymm8
	vmovdqu	ymmword ptr [r13 + r9 + 640], ymm2
	vmovdqu	ymmword ptr [r13 + r9 + 672], ymm4
	sub	r9, -128
	cmp	rdi, r9
	jne	122b
	cmp	rcx, rdi
	mov	r14, qword ptr [rsp + 40]
	mov	r9, r14
	je	172f
	test	cl, 112
	je	152f
132:
	mov	r9, rcx
	and	r9, -16
	lea	rdx, [rax + r9]
	.p2align	4
142:
	vmovdqu	xmm2, xmmword ptr [rsi + rdi]
	vmovdqu	xmmword ptr [r14 + rdi], xmm2
	add	rdi, 16
	cmp	r9, rdi
	jne	142b
	cmp	rcx, r9
	mov	r9, r14
	je	172f
	.p2align	4
152:
	mov	rcx, r14
	sub	rcx, rax
	mov	rsi, qword ptr [rsp]
	.p2align	4
162:
	movzx	eax, byte ptr [rsi + rdx]
	mov	byte ptr [rcx + rdx], al
	inc	rdx
	cmp	r8, rdx
	jne	162b
	mov	r9, r14
172:
	vmovdqu	ymm2, ymmword ptr [r9]
	vmovdqu	ymm4, ymmword ptr [r9 + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm8, ymm7, ymm15
	vpshufb	ymm9, ymm2, ymm15
	vpbroadcastb	ymm12, byte ptr [rip + 1152f]
	vpand	ymm13, ymm15, ymm12
	vpxor	xmm6, xmm6, xmm6
	vpcmpeqb	ymm13, ymm13, ymm6
	vpblendvb	ymm8, ymm9, ymm8, ymm13
	vpermq	ymm9, ymm4, 68
	vpermq	ymm4, ymm4, 238
	vpshufb	ymm11, ymm9, ymm15
	vpshufb	ymm3, ymm4, ymm15
	vpblendvb	ymm3, ymm3, ymm11, ymm13
	vpshufb	ymm7, ymm7, ymm0
	vpshufb	ymm2, ymm2, ymm0
	vpand	ymm11, ymm12, ymm0
	vpcmpeqb	ymm11, ymm11, ymm6
	vpblendvb	ymm2, ymm2, ymm7, ymm11
	vpshufb	ymm7, ymm9, ymm0
	vpshufb	ymm4, ymm4, ymm0
	vpblendvb	ymm4, ymm4, ymm7, ymm11
	vpbroadcastb	ymm7, byte ptr [rip + 1162f]
	vpand	ymm0, ymm0, ymm7
	vpcmpeqb	ymm0, ymm0, ymm7
	vpblendvb	ymm0, ymm2, ymm4, ymm0
	vpand	ymm2, ymm15, ymm7
	vpcmpeqb	ymm2, ymm2, ymm7
	vpblendvb	ymm2, ymm8, ymm3, ymm2
	vpsrlvd	ymm0, ymm0, ymm10
	vpandn	ymm0, ymm1, ymm0
	vpaddd	ymm0, ymm0, ymm5
	vpsrlvd	ymm2, ymm2, ymmword ptr [rsp + 480]
	vmovdqu	ymm1, ymmword ptr [rsp + 512]
	vpandn	ymm2, ymm1, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 192]
	vpor	ymm3, ymm2, ymmword ptr [rip + 1172f]
	vpcmpeqd	ymm2, ymm2, ymm6
	vpandn	ymm2, ymm2, ymm3
	vpor	ymm3, ymm0, ymmword ptr [rip + 1182f]
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
	vmovdqu	ymm4, ymmword ptr [rsp + 320]
	vpand	ymm2, ymm0, ymm4
	vpcmpeqd	ymm0, ymm0, ymm6
	vmovups	ymm1, ymmword ptr [rsp + 288]
	vblendvps	ymm0, ymm2, ymm1, ymm0
	vpand	ymm2, ymm3, ymm4
	vpcmpeqd	ymm3, ymm3, ymm6
	vblendvps	ymm1, ymm2, ymm1, ymm3
	vmovdqu	ymm2, ymmword ptr [rsp + 224]
	vextracti128	xmm2, ymm2, 1
	vpextrd	eax, xmm2, 3
	vmovups	ymmword ptr [r13 + 256], ymm1
	vmovups	ymmword ptr [r13 + 288], ymm0
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm1, ymm0, 170
	mov	rcx, rbx
	add	rcx, rax
	cmp	qword ptr [rsp + 80], 17
	jb	422f
	vmovups	ymmword ptr [rsp + 288], ymm1
	vextracti128	xmm0, ymm14, 1
	vpshufd	xmm2, xmm0, 238
	vmovdqu	ymm3, ymmword ptr [rsp + 576]
	vextracti128	xmm3, ymm3, 1
	vpmovzxbd	ymm2, xmm2
	vpbroadcastd	ymm3, xmm3
	vpaddd	ymm2, ymm3, ymm2
	vpmovzxbd	ymm0, xmm0
	vmovdqu	ymm3, ymmword ptr [rsp + 608]
	vextracti128	xmm3, ymm3, 1
	vpshufd	xmm4, xmm3, 238
	vpmovzxbd	ymm4, xmm4
	vpmovzxbd	ymm3, xmm3
	vpsrld	ymm5, ymm3, 3
	vpsrld	ymm6, ymm4, 3
	vmovdqu	ymm8, ymmword ptr [rsp + 448]
	vpmaxud	ymm6, ymm6, ymm8
	vpcmpeqd	ymm9, ymm9, ymm9
	vpaddd	ymm7, ymm9, ymm6
	vpmaxud	ymm5, ymm5, ymm8
	vpaddd	ymm5, ymm9, ymm5
	vmovdqu	ymm10, ymmword ptr [rsp + 416]
	vpand	ymm6, ymm10, ymm3
	vpand	ymm8, ymm10, ymm4
	vmovdqu	ymm11, ymmword ptr [rsp + 384]
	vpminud	ymm4, ymm4, ymm11
	vpminud	ymm3, ymm3, ymm11
	vpand	ymm3, ymm11, ymm3
	vpor	ymm3, ymm3, ymm6
	vpand	ymm4, ymm11, ymm4
	vpor	ymm4, ymm8, ymm4
	vpsllvd	ymm6, ymm3, ymm5
	vpsllvd	ymm11, ymm4, ymm7
	vpsllvd	ymm13, ymm9, ymm5
	vpsllvd	ymm9, ymm9, ymm7
	vpaddd	ymm3, ymm2, ymm7
	mov	eax, ecx
	and	eax, 7
	vmovd	xmm5, eax
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm0, ymm5, ymm0
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm7, ymm2, 3
	vpsrld	ymm8, ymm0, 3
	vpand	ymm5, ymm10, ymm2
	vpand	ymm1, ymm10, ymm0
	vbroadcasti128	ymm2, xmmword ptr [rip + 1142f]
	vpshufb	ymm0, ymm8, ymm2
	vpshufb	ymm2, ymm7, ymm2
	vmovdqu	ymm4, ymmword ptr [rsp + 352]
	vpaddb	ymm12, ymm2, ymm4
	vpaddb	ymm0, ymm0, ymm4
	mov	rbx, rcx
	mov	rax, rcx
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, r8
	vmovdqu	ymmword ptr [rsp + 128], ymm3
	vmovdqu	ymmword ptr [rsp + 224], ymm9
	vmovdqu	ymmword ptr [rsp + 192], ymm5
	vmovdqa	ymm10, ymm13
	vmovdqa	ymm5, ymm6
	jbe	182f
	mov	rcx, r8
	sub	rcx, rax
	mov	r9, r14
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
	vmovdqu	ymm7, ymmword ptr [r14 + r9 - 64]
	vmovdqu	ymm8, ymmword ptr [r14 + r9 - 32]
	vmovdqu	ymm13, ymmword ptr [r14 + r9]
	vmovdqu	ymmword ptr [r13 + r9 + 576], ymm2
	vmovdqu	ymmword ptr [r13 + r9 + 608], ymm7
	vmovdqu	ymmword ptr [r13 + r9 + 640], ymm8
	vmovdqu	ymmword ptr [r13 + r9 + 672], ymm13
	sub	r9, -128
	cmp	rdi, r9
	jne	202b
	cmp	rcx, rdi
	mov	r14, qword ptr [rsp + 40]
	mov	r9, r14
	je	252f
	test	cl, 112
	je	232f
212:
	mov	r9, rcx
	and	r9, -16
	lea	rdx, [rax + r9]
	.p2align	4
222:
	vmovdqu	xmm2, xmmword ptr [rsi + rdi]
	vmovdqu	xmmword ptr [r14 + rdi], xmm2
	add	rdi, 16
	cmp	r9, rdi
	jne	222b
	cmp	rcx, r9
	mov	r9, r14
	je	252f
232:
	mov	rcx, r14
	sub	rcx, rax
	mov	rsi, qword ptr [rsp]
	.p2align	4
242:
	movzx	eax, byte ptr [rsi + rdx]
	mov	byte ptr [rcx + rdx], al
	inc	rdx
	cmp	r8, rdx
	jne	242b
	mov	r9, r14
252:
	vmovdqu	ymm2, ymmword ptr [r9]
	vmovdqu	ymm7, ymmword ptr [r9 + 32]
	vpermq	ymm8, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm13, ymm8, ymm12
	vpshufb	ymm14, ymm2, ymm12
	vpbroadcastb	ymm3, byte ptr [rip + 1152f]
	vpand	ymm15, ymm12, ymm3
	vpxor	xmm6, xmm6, xmm6
	vpcmpeqb	ymm15, ymm15, ymm6
	vpblendvb	ymm13, ymm14, ymm13, ymm15
	vpermq	ymm14, ymm7, 68
	vpermq	ymm7, ymm7, 238
	vpshufb	ymm4, ymm14, ymm12
	vpshufb	ymm9, ymm7, ymm12
	vpblendvb	ymm4, ymm9, ymm4, ymm15
	vpshufb	ymm8, ymm8, ymm0
	vpshufb	ymm2, ymm2, ymm0
	vpand	ymm9, ymm0, ymm3
	vpcmpeqb	ymm9, ymm9, ymm6
	vpblendvb	ymm2, ymm2, ymm8, ymm9
	vpshufb	ymm8, ymm14, ymm0
	vpshufb	ymm7, ymm7, ymm0
	vpblendvb	ymm7, ymm7, ymm8, ymm9
	vpbroadcastb	ymm3, byte ptr [rip + 1162f]
	vpand	ymm0, ymm0, ymm3
	vpcmpeqb	ymm0, ymm0, ymm3
	vpblendvb	ymm0, ymm2, ymm7, ymm0
	vpand	ymm2, ymm12, ymm3
	vpcmpeqb	ymm2, ymm2, ymm3
	vpblendvb	ymm2, ymm13, ymm4, ymm2
	vpsrlvd	ymm0, ymm0, ymm1
	vpandn	ymm0, ymm10, ymm0
	vpaddd	ymm0, ymm0, ymm5
	vpsrlvd	ymm2, ymm2, ymmword ptr [rsp + 192]
	vmovdqu	ymm3, ymmword ptr [rsp + 224]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm11, ymm2
	vpor	ymm3, ymm2, ymmword ptr [rip + 1172f]
	vpcmpeqd	ymm2, ymm2, ymm6
	vpandn	ymm2, ymm2, ymm3
	vpor	ymm3, ymm0, ymmword ptr [rip + 1182f]
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
	vmovdqu	ymm4, ymmword ptr [rsp + 320]
	vpand	ymm2, ymm0, ymm4
	vpcmpeqd	ymm0, ymm0, ymm6
	vmovups	ymm1, ymmword ptr [rsp + 288]
	vblendvps	ymm0, ymm2, ymm1, ymm0
	vpand	ymm2, ymm3, ymm4
	vpcmpeqd	ymm3, ymm3, ymm6
	vblendvps	ymm1, ymm2, ymm1, ymm3
	vmovdqu	ymm2, ymmword ptr [rsp + 128]
	vextracti128	xmm2, ymm2, 1
	vpextrd	eax, xmm2, 3
	vmovups	ymmword ptr [r13 + 320], ymm1
	vmovups	ymmword ptr [r13 + 352], ymm0
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm1, ymm0, 170
	mov	rcx, rbx
	add	rcx, rax
	cmp	qword ptr [rsp + 80], 33
	jb	422f
	vmovdqu	ymm4, ymmword ptr [rsp + 544]
	vpsrlw	ymm0, ymm4, 3
	vpand	ymm0, ymm0, ymmword ptr [rip + 1132f]
	vpsubusb	ymm0, ymm0, ymmword ptr [rip + 1192f]
	vpsllq	ymm2, ymm0, 8
	vpaddb	ymm2, ymm0, ymm2
	vpsllq	ymm3, ymm2, 16
	vpaddb	ymm2, ymm2, ymm3
	vpsllq	ymm3, ymm2, 32
	vpaddb	ymm2, ymm2, ymm3
	vpsubb	ymm13, ymm2, ymm0
	vpsrlq	ymm2, ymm2, 56
	vpshufd	xmm0, xmm13, 238
	vpmovzxbd	ymm0, xmm0
	vmovdqu	ymmword ptr [rsp + 480], ymm2
	vpbroadcastd	ymm2, xmm2
	vpaddd	ymm0, ymm2, ymm0
	vpmovzxbd	ymm2, xmm13
	vpshufd	xmm3, xmm4, 238
	vpmovzxbd	ymm3, xmm3
	vpmovzxbd	ymm5, xmm4
	vpsrld	ymm6, ymm5, 3
	vpsrld	ymm7, ymm3, 3
	vmovdqu	ymm4, ymmword ptr [rsp + 448]
	vpmaxud	ymm7, ymm7, ymm4
	vpcmpeqd	ymm10, ymm10, ymm10
	vpaddd	ymm7, ymm10, ymm7
	vpmaxud	ymm6, ymm6, ymm4
	vpaddd	ymm6, ymm10, ymm6
	vmovdqu	ymm4, ymmword ptr [rsp + 416]
	vpand	ymm8, ymm5, ymm4
	vpand	ymm9, ymm3, ymm4
	vmovdqu	ymm11, ymmword ptr [rsp + 384]
	vpminud	ymm3, ymm3, ymm11
	vpminud	ymm5, ymm5, ymm11
	vpand	ymm5, ymm11, ymm5
	vpor	ymm5, ymm8, ymm5
	vpand	ymm3, ymm11, ymm3
	vpor	ymm8, ymm9, ymm3
	vpsllvd	ymm3, ymm5, ymm6
	vmovdqu	ymmword ptr [rsp + 192], ymm3
	vpsllvd	ymm3, ymm8, ymm7
	vmovdqu	ymmword ptr [rsp + 224], ymm3
	vpsllvd	ymm3, ymm10, ymm6
	vmovdqu	ymmword ptr [rsp + 512], ymm3
	vpsllvd	ymm3, ymm10, ymm7
	vmovdqu	ymmword ptr [rsp + 288], ymm3
	vpaddd	ymm3, ymm0, ymm7
	vmovdqu	ymmword ptr [rsp + 128], ymm3
	mov	eax, ecx
	and	eax, 7
	vmovd	xmm5, eax
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm2, ymm5, ymm2
	vpaddd	ymm0, ymm5, ymm0
	vpsrld	ymm7, ymm0, 3
	vpsrld	ymm8, ymm2, 3
	vpand	ymm5, ymm0, ymm4
	vpand	ymm10, ymm2, ymm4
	vbroadcasti128	ymm2, xmmword ptr [rip + 1142f]
	vpshufb	ymm0, ymm8, ymm2
	vpshufb	ymm2, ymm7, ymm2
	vmovdqu	ymm3, ymmword ptr [rsp + 352]
	vpaddb	ymm14, ymm2, ymm3
	vpaddb	ymm0, ymm0, ymm3
	mov	rbx, rcx
	mov	rax, rcx
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, r8
	jbe	262f
	mov	rcx, r8
	sub	rcx, rax
	mov	r9, r14
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
	vmovdqu	ymm7, ymmword ptr [r14 + r9 - 64]
	vmovdqu	ymm8, ymmword ptr [r14 + r9 - 32]
	vmovdqu	ymm15, ymmword ptr [r14 + r9]
	vmovdqu	ymmword ptr [r13 + r9 + 576], ymm2
	vmovdqu	ymmword ptr [r13 + r9 + 608], ymm7
	vmovdqu	ymmword ptr [r13 + r9 + 640], ymm8
	vmovdqu	ymmword ptr [r13 + r9 + 672], ymm15
	sub	r9, -128
	cmp	rdi, r9
	jne	282b
	cmp	rcx, rdi
	mov	r14, qword ptr [rsp + 40]
	mov	r9, r14
	je	332f
	test	cl, 112
	je	312f
292:
	mov	r9, rcx
	and	r9, -16
	lea	rdx, [rax + r9]
	.p2align	4
302:
	vmovdqu	xmm2, xmmword ptr [rsi + rdi]
	vmovdqu	xmmword ptr [r14 + rdi], xmm2
	add	rdi, 16
	cmp	r9, rdi
	jne	302b
	cmp	rcx, r9
	mov	r9, r14
	je	332f
312:
	mov	rcx, r14
	sub	rcx, rax
	mov	rsi, qword ptr [rsp]
	.p2align	4
322:
	movzx	eax, byte ptr [rsi + rdx]
	mov	byte ptr [rcx + rdx], al
	inc	rdx
	cmp	r8, rdx
	jne	322b
	mov	r9, r14
332:
	vmovdqu	ymm2, ymmword ptr [r9]
	vmovdqu	ymm7, ymmword ptr [r9 + 32]
	vpermq	ymm8, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm15, ymm8, ymm14
	vpshufb	ymm9, ymm2, ymm14
	vpbroadcastb	ymm12, byte ptr [rip + 1152f]
	vpand	ymm4, ymm14, ymm12
	vpxor	xmm6, xmm6, xmm6
	vpcmpeqb	ymm4, ymm4, ymm6
	vpblendvb	ymm9, ymm9, ymm15, ymm4
	vpermq	ymm15, ymm7, 68
	vpermq	ymm7, ymm7, 238
	vpshufb	ymm11, ymm15, ymm14
	vpshufb	ymm3, ymm7, ymm14
	vpblendvb	ymm3, ymm3, ymm11, ymm4
	vpshufb	ymm4, ymm8, ymm0
	vpshufb	ymm2, ymm2, ymm0
	vpand	ymm8, ymm12, ymm0
	vpcmpeqb	ymm8, ymm8, ymm6
	vpblendvb	ymm2, ymm2, ymm4, ymm8
	vpshufb	ymm4, ymm15, ymm0
	vpshufb	ymm7, ymm7, ymm0
	vpblendvb	ymm4, ymm7, ymm4, ymm8
	vpbroadcastb	ymm7, byte ptr [rip + 1162f]
	vpand	ymm0, ymm0, ymm7
	vpcmpeqb	ymm0, ymm0, ymm7
	vpblendvb	ymm0, ymm2, ymm4, ymm0
	vpand	ymm2, ymm14, ymm7
	vpcmpeqb	ymm2, ymm2, ymm7
	vpblendvb	ymm2, ymm9, ymm3, ymm2
	vpsrlvd	ymm0, ymm0, ymm10
	vmovdqu	ymm3, ymmword ptr [rsp + 512]
	vpandn	ymm0, ymm3, ymm0
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 192]
	vpsrlvd	ymm2, ymm2, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 288]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 224]
	vpor	ymm3, ymm2, ymmword ptr [rip + 1172f]
	vpcmpeqd	ymm2, ymm2, ymm6
	vpandn	ymm2, ymm2, ymm3
	vpor	ymm3, ymm0, ymmword ptr [rip + 1182f]
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
	vmovdqu	ymm4, ymmword ptr [rsp + 320]
	vpand	ymm2, ymm0, ymm4
	vpcmpeqd	ymm0, ymm0, ymm6
	vblendvps	ymm0, ymm2, ymm1, ymm0
	vpand	ymm2, ymm3, ymm4
	vpcmpeqd	ymm3, ymm3, ymm6
	vblendvps	ymm1, ymm2, ymm1, ymm3
	vmovdqu	ymm2, ymmword ptr [rsp + 128]
	vextracti128	xmm2, ymm2, 1
	vpextrd	eax, xmm2, 3
	vmovups	ymmword ptr [r13 + 384], ymm1
	vmovups	ymmword ptr [r13 + 416], ymm0
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm1, ymm0, 170
	mov	rcx, rbx
	add	rcx, rax
	cmp	qword ptr [rsp + 80], 49
	jb	422f
	vextracti128	xmm0, ymm13, 1
	vpshufd	xmm2, xmm0, 238
	vmovdqu	ymm3, ymmword ptr [rsp + 480]
	vextracti128	xmm3, ymm3, 1
	vpmovzxbd	ymm2, xmm2
	vpbroadcastd	ymm3, xmm3
	vpaddd	ymm2, ymm3, ymm2
	vpmovzxbd	ymm5, xmm0
	vmovdqu	ymm0, ymmword ptr [rsp + 544]
	vextracti128	xmm0, ymm0, 1
	vpshufd	xmm3, xmm0, 238
	vpmovzxbd	ymm3, xmm3
	vpmovzxbd	ymm0, xmm0
	vpsrld	ymm4, ymm0, 3
	vpsrld	ymm6, ymm3, 3
	vmovdqu	ymm8, ymmword ptr [rsp + 448]
	vpmaxud	ymm6, ymm6, ymm8
	vpcmpeqd	ymm10, ymm10, ymm10
	vpaddd	ymm7, ymm10, ymm6
	vpmaxud	ymm4, ymm4, ymm8
	vpaddd	ymm6, ymm10, ymm4
	vmovdqu	ymm12, ymmword ptr [rsp + 416]
	vpand	ymm4, ymm12, ymm0
	vpand	ymm8, ymm12, ymm3
	vmovdqu	ymm9, ymmword ptr [rsp + 384]
	vpminud	ymm3, ymm3, ymm9
	vpminud	ymm0, ymm0, ymm9
	vpand	ymm0, ymm9, ymm0
	vpor	ymm0, ymm0, ymm4
	vpand	ymm3, ymm9, ymm3
	vpor	ymm4, ymm8, ymm3
	vpsllvd	ymm0, ymm0, ymm6
	vmovdqu	ymmword ptr [rsp + 224], ymm0
	vpsllvd	ymm0, ymm4, ymm7
	vmovdqu	ymmword ptr [rsp + 128], ymm0
	vpsllvd	ymm9, ymm10, ymm6
	vpsllvd	ymm0, ymm10, ymm7
	vmovdqu	ymmword ptr [rsp + 192], ymm0
	vpaddd	ymm0, ymm2, ymm7
	vmovdqu	ymmword ptr [rsp + 80], ymm0
	mov	eax, ecx
	and	eax, 7
	vmovd	xmm7, eax
	vpbroadcastd	ymm7, xmm7
	vpaddd	ymm8, ymm7, ymm5
	vpaddd	ymm2, ymm7, ymm2
	vpsrld	ymm7, ymm2, 3
	vpsrld	ymm11, ymm8, 3
	vpand	ymm5, ymm12, ymm2
	vpand	ymm10, ymm8, ymm12
	vbroadcasti128	ymm0, xmmword ptr [rip + 1142f]
	vpshufb	ymm2, ymm11, ymm0
	vpshufb	ymm7, ymm7, ymm0
	vmovdqu	ymm0, ymmword ptr [rsp + 352]
	vpaddb	ymm11, ymm7, ymm0
	vpaddb	ymm12, ymm2, ymm0
	mov	rbx, rcx
	mov	rax, rcx
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, r8
	jbe	342f
	mov	rcx, r8
	sub	rcx, rax
	mov	r9, r14
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
	vmovdqu	ymm7, ymmword ptr [r14 + r9 - 64]
	vmovdqu	ymm8, ymmword ptr [r14 + r9 - 32]
	vmovdqu	ymm13, ymmword ptr [r14 + r9]
	vmovdqu	ymmword ptr [r13 + r9 + 576], ymm2
	vmovdqu	ymmword ptr [r13 + r9 + 608], ymm7
	vmovdqu	ymmword ptr [r13 + r9 + 640], ymm8
	vmovdqu	ymmword ptr [r13 + r9 + 672], ymm13
	sub	r9, -128
	cmp	rdi, r9
	jne	362b
	cmp	rcx, rdi
	mov	r14, qword ptr [rsp + 40]
	mov	r9, r14
	je	412f
	test	cl, 112
	je	392f
372:
	mov	r9, rcx
	and	r9, -16
	lea	rdx, [rax + r9]
	.p2align	4
382:
	vmovdqu	xmm2, xmmword ptr [rsi + rdi]
	vmovdqu	xmmword ptr [r14 + rdi], xmm2
	add	rdi, 16
	cmp	r9, rdi
	jne	382b
	cmp	rcx, r9
	mov	r9, r14
	je	412f
392:
	mov	rcx, r14
	sub	rcx, rax
	mov	rsi, qword ptr [rsp]
	.p2align	4
402:
	movzx	eax, byte ptr [rsi + rdx]
	mov	byte ptr [rcx + rdx], al
	inc	rdx
	cmp	r8, rdx
	jne	402b
	mov	r9, r14
412:
	vmovdqu	ymm2, ymmword ptr [r9]
	vmovdqu	ymm7, ymmword ptr [r9 + 32]
	vpermq	ymm8, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm13, ymm8, ymm11
	vpshufb	ymm14, ymm2, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 1152f]
	vpand	ymm15, ymm11, ymm3
	vpxor	xmm6, xmm6, xmm6
	vpcmpeqb	ymm15, ymm15, ymm6
	vpblendvb	ymm13, ymm14, ymm13, ymm15
	vpermq	ymm14, ymm7, 68
	vpermq	ymm7, ymm7, 238
	vpshufb	ymm0, ymm14, ymm11
	vpshufb	ymm4, ymm7, ymm11
	vpblendvb	ymm0, ymm4, ymm0, ymm15
	vpshufb	ymm4, ymm8, ymm12
	vpshufb	ymm2, ymm2, ymm12
	vpand	ymm8, ymm12, ymm3
	vpcmpeqb	ymm8, ymm8, ymm6
	vpblendvb	ymm2, ymm2, ymm4, ymm8
	vpshufb	ymm4, ymm14, ymm12
	vpshufb	ymm7, ymm7, ymm12
	vpblendvb	ymm4, ymm7, ymm4, ymm8
	vpbroadcastb	ymm3, byte ptr [rip + 1162f]
	vpand	ymm7, ymm12, ymm3
	vpcmpeqb	ymm7, ymm7, ymm3
	vpblendvb	ymm2, ymm2, ymm4, ymm7
	vpand	ymm4, ymm11, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm0, ymm13, ymm0, ymm4
	vpsrlvd	ymm2, ymm2, ymm10
	vpandn	ymm2, ymm9, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 224]
	vpsrlvd	ymm0, ymm0, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 192]
	vpandn	ymm0, ymm3, ymm0
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 128]
	vpor	ymm3, ymm0, ymmword ptr [rip + 1172f]
	vpcmpeqd	ymm0, ymm0, ymm6
	vpandn	ymm0, ymm0, ymm3
	vpor	ymm3, ymm2, ymmword ptr [rip + 1182f]
	vpcmpeqd	ymm2, ymm2, ymm6
	vpandn	ymm2, ymm2, ymm3
	vperm2i128	ymm3, ymm2, ymm2, 10
	vpalignr	ymm3, ymm2, ymm3, 12
	vpmaxud	ymm3, ymm2, ymm3
	vperm2i128	ymm2, ymm2, ymm0, 33
	vpalignr	ymm2, ymm0, ymm2, 12
	vpmaxud	ymm0, ymm0, ymm2
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
	vmovdqu	ymm4, ymmword ptr [rsp + 320]
	vpand	ymm2, ymm0, ymm4
	vpcmpeqd	ymm0, ymm0, ymm6
	vblendvps	ymm0, ymm2, ymm1, ymm0
	vpand	ymm2, ymm3, ymm4
	vpcmpeqd	ymm3, ymm3, ymm6
	vblendvps	ymm1, ymm2, ymm1, ymm3
	vmovdqu	ymm2, ymmword ptr [rsp + 80]
	vextracti128	xmm2, ymm2, 1
	vpextrd	eax, xmm2, 3
	vmovups	ymmword ptr [r13 + 448], ymm1
	vmovups	ymmword ptr [r13 + 480], ymm0
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm1, ymm0, 170
	mov	rcx, rbx
	add	rcx, rax
	.p2align	4
422:
	mov	rdx, qword ptr [rsp + 48]
	shr	r11, 56
	add	r11, r12
	shr	rdx, 56
	add	rdx, r10
	vmovd	eax, xmm1
	mov	qword ptr [r13 + 72], rcx
	mov	qword ptr [r13 + 96], rax
	mov	qword ptr [r13 + 128], rdx
	mov	qword ptr [r13 + 136], r11
	mov	rax, qword ptr [rsp + 32]
	add	rax, qword ptr [rsp + 264]
	mov	qword ptr [rsp + 32], rax
	mov	rax, qword ptr [rsp + 120]
	and	rax, 124
	mov	r8, qword ptr [rsp + 16]
	je	892f
	xor	r9d, r9d
	mov	r12, qword ptr [rsp + 24]
	.p2align	4
432:
	cmp	r15, r12
	cmovae	r15, r12
	mov	rcx, r12
	sub	rcx, r15
	cmp	r15, 31
	jbe	572f
	mov	r14, qword ptr [rsp + 8]
	vmovdqu	ymm0, ymmword ptr [r14 + rcx]
442:
	mov	r15, qword ptr [rsp + 32]
	movzx	esi, byte ptr [r15 + r9]
	movzx	r10d, byte ptr [r13 + r9 + 192]
	mov	edx, dword ptr [r13 + 4*r9 + 256]
	vpaddb	ymm0, ymm0, ymmword ptr [rbp + r8]
	vmovdqu	ymmword ptr [r14 + r12], ymm0
	cmp	r10b, 33
	mov	qword ptr [rsp + 16], r8
	jae	582f
452:
	lea	r11, [r10 + r12]
	mov	ebx, esi
	shr	ebx, 2
	cmp	edx, ebx
	mov	qword ptr [rsp], r10
	jb	812f
	mov	rcx, r11
	sub	rcx, rdx
	jb	812f
	vmovdqu	ymm0, ymmword ptr [r14 + rcx]
	mov	rdi, rdx
462:
	vmovdqu	ymmword ptr [r14 + r11], ymm0
	cmp	sil, -124
	jae	602f
472:
	mov	qword ptr [rsp + 24], r12
	lea	rcx, [r9 + 1]
	lea	r12, [r10 + r8]
	add	r11, rbx
	movzx	edi, byte ptr [r15 + rcx]
	movzx	esi, byte ptr [r13 + rcx + 192]
	mov	r8d, dword ptr [r13 + 4*rcx + 256]
	vmovdqu	ymm0, ymmword ptr [rbp + r12]
	cmp	rdx, r11
	cmovae	rdx, r11
	mov	rcx, r11
	sub	rcx, rdx
	cmp	rdx, 31
	jbe	632f
	vmovdqu	ymm1, ymmword ptr [r14 + rcx]
	vpaddb	ymm0, ymm1, ymm0
	vmovdqu	ymmword ptr [r14 + r11], ymm0
	cmp	sil, 33
	jae	642f
482:
	mov	qword ptr [rsp + 80], rsi
	add	r11, rsi
	mov	esi, edi
	shr	esi, 2
	cmp	r8d, esi
	jb	822f
	mov	rcx, r11
	sub	rcx, r8
	jb	822f
	vmovdqu	ymm0, ymmword ptr [r14 + rcx]
	mov	rdx, r8
492:
	vmovdqu	ymmword ptr [r14 + r11], ymm0
	cmp	dil, -124
	jae	662f
502:
	lea	rcx, [r9 + 2]
	add	r12, qword ptr [rsp + 80]
	add	r11, rsi
	movzx	edi, byte ptr [r15 + rcx]
	movzx	edx, byte ptr [r13 + rcx + 192]
	mov	r10d, dword ptr [r13 + 4*rcx + 256]
	vmovdqu	ymm0, ymmword ptr [rbp + r12]
	cmp	r8, r11
	cmovae	r8, r11
	mov	rcx, r11
	sub	rcx, r8
	cmp	r8, 31
	jbe	692f
	vmovdqu	ymm1, ymmword ptr [r14 + rcx]
	vpaddb	ymm0, ymm1, ymm0
	vmovdqu	ymmword ptr [r14 + r11], ymm0
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
	vmovdqu	ymm0, ymmword ptr [r14 + rcx]
	mov	r8, r10
522:
	vmovdqu	ymmword ptr [r14 + r11], ymm0
	cmp	dil, -124
	jae	722f
532:
	lea	rcx, [r9 + 3]
	add	r12, rdx
	add	r11, rbp
	movzx	edi, byte ptr [r15 + rcx]
	movzx	r14d, byte ptr [r13 + rcx + 192]
	mov	r15d, dword ptr [r13 + 4*rcx + 256]
	mov	rcx, qword ptr [rsp + 72]
	vmovdqu	ymm0, ymmword ptr [rcx + r12]
	cmp	r10, r11
	cmovae	r10, r11
	mov	rcx, r11
	sub	rcx, r10
	cmp	r10, 31
	jbe	752f
	mov	r8, qword ptr [rsp + 8]
	vmovdqu	ymm1, ymmword ptr [r8 + rcx]
	vpaddb	ymm0, ymm1, ymm0
	vmovdqu	ymmword ptr [r8 + r11], ymm0
	cmp	r14b, 33
	jae	762f
542:
	add	r11, r14
	mov	r10d, edi
	shr	r10d, 2
	cmp	r15d, r10d
	jb	842f
	mov	rcx, r11
	sub	rcx, r15
	jb	842f
	mov	r8, qword ptr [rsp + 8]
	vmovdqu	ymm0, ymmword ptr [r8 + rcx]
	mov	r13, r15
552:
	vmovdqu	ymmword ptr [r8 + r11], ymm0
	cmp	dil, -124
	jae	782f
562:
	add	r14, r12
	add	r10, r11
	add	r9, 4
	cmp	r9, rax
	mov	r8, r14
	mov	r12, r10
	mov	r13, qword ptr [rsp + 64]
	mov	rbp, qword ptr [rsp + 72]
	jb	432b
	jmp	902f
572:
	mov	rdx, qword ptr [r13 + 56]
	shl	r15, 5
	vmovdqu	ymm0, ymmword ptr [rdx + r15 + 2048]
	mov	r14, qword ptr [rsp + 8]
	vmovdqu	ymm1, ymmword ptr [r14 + rcx]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	jmp	442b
582:
	lea	rcx, [rbp + r8]
	lea	rdi, [r14 + r12]
	mov	r8, qword ptr [r13 + 48]
	mov	r10, qword ptr [r13 + 120]
	movzx	r8d, byte ptr [r8 + r10]
	inc	r10
	mov	qword ptr [r13 + 120], r10
	mov	r10, r8
	add	r10, 33
	mov	r8d, 32
	.p2align	4
592:
	vmovdqu	ymm0, ymmword ptr [rcx + r8]
	vmovdqu	ymmword ptr [rdi + r8], ymm0
	add	r8, 32
	cmp	r8, r10
	jb	592b
	mov	r8, qword ptr [rsp + 16]
	jmp	452b
602:
	cmp	rdi, 31
	ja	612f
	mov	qword ptr [r13 + 104], 1
612:
	lea	rsi, [r14 + r11]
	mov	rdi, qword ptr [r13 + 48]
	mov	r8, qword ptr [r13 + 120]
	movzx	ebx, byte ptr [rdi + r8]
	inc	r8
	mov	qword ptr [r13 + 120], r8
	add	rbx, 33
	add	rcx, r14
	mov	edi, 32
	.p2align	4
622:
	vmovdqu	ymm0, ymmword ptr [rcx + rdi]
	vmovdqu	ymmword ptr [rsi + rdi], ymm0
	add	rdi, 32
	cmp	rdi, rbx
	jb	622b
	mov	r8, qword ptr [rsp + 16]
	jmp	472b
632:
	mov	qword ptr [rsp + 80], rsi
	mov	rsi, qword ptr [r13 + 56]
	shl	rdx, 5
	vmovdqu	ymm1, ymmword ptr [rsi + rdx + 2048]
	mov	rsi, qword ptr [rsp + 80]
	vmovdqu	ymm2, ymmword ptr [r14 + rcx]
	vpermq	ymm3, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm3, ymm3, ymm1
	vpshufb	ymm2, ymm2, ymm1
	vpsllw	ymm1, ymm1, 3
	vpblendvb	ymm1, ymm3, ymm2, ymm1
	vpaddb	ymm0, ymm1, ymm0
	vmovdqu	ymmword ptr [r14 + r11], ymm0
	cmp	sil, 33
	jb	482b
642:
	mov	rdx, qword ptr [r13 + 48]
	mov	rsi, qword ptr [r13 + 120]
	movzx	ecx, byte ptr [rdx + rsi]
	inc	rsi
	mov	qword ptr [r13 + 120], rsi
	add	rcx, 33
	mov	esi, 32
	.p2align	4
652:
	lea	rdx, [rbp + r12]
	vmovdqu	ymm0, ymmword ptr [rdx + rsi]
	lea	rdx, [r14 + r11]
	vmovdqu	ymmword ptr [rdx + rsi], ymm0
	add	rsi, 32
	cmp	rsi, rcx
	jb	652b
	mov	rsi, rcx
	jmp	482b
662:
	cmp	rdx, 31
	ja	672f
	mov	qword ptr [r13 + 104], 1
672:
	mov	rdx, qword ptr [r13 + 48]
	mov	rdi, qword ptr [r13 + 120]
	movzx	esi, byte ptr [rdx + rdi]
	inc	rdi
	mov	qword ptr [r13 + 120], rdi
	add	rsi, 33
	add	rcx, r14
	lea	rdi, [rbx + r10]
	mov	rdx, qword ptr [rsp + 24]
	mov	r10, qword ptr [rsp + 80]
	add	rdx, r10
	add	rdx, rdi
	add	rdx, r14
	mov	edi, 32
	.p2align	4
682:
	vmovdqu	ymm0, ymmword ptr [rcx + rdi]
	vmovdqu	ymmword ptr [rdx + rdi], ymm0
	add	rdi, 32
	cmp	rdi, rsi
	jb	682b
	jmp	502b
692:
	mov	r14, qword ptr [r13 + 56]
	shl	r8, 5
	vmovdqu	ymm1, ymmword ptr [r14 + r8 + 2048]
	mov	r14, qword ptr [rsp + 8]
	vmovdqu	ymm2, ymmword ptr [r14 + rcx]
	vpermq	ymm3, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm3, ymm3, ymm1
	vpshufb	ymm2, ymm2, ymm1
	vpsllw	ymm1, ymm1, 3
	vpblendvb	ymm1, ymm3, ymm2, ymm1
	vpaddb	ymm0, ymm1, ymm0
	vmovdqu	ymmword ptr [r14 + r11], ymm0
	cmp	dl, 33
	jb	512b
702:
	mov	rcx, qword ptr [r13 + 48]
	mov	r8, qword ptr [r13 + 120]
	movzx	edx, byte ptr [rcx + r8]
	inc	r8
	mov	qword ptr [r13 + 120], r8
	add	rdx, 33
	mov	rcx, qword ptr [rsp]
	lea	r8, [rbx + rcx]
	mov	rcx, qword ptr [rsp + 80]
	add	rcx, rsi
	add	rcx, r8
	add	rcx, qword ptr [rsp + 24]
	add	rcx, r14
	lea	r8, [rbp + r12]
	mov	r14d, 32
	.p2align	4
712:
	vmovdqu	ymm0, ymmword ptr [r8 + r14]
	vmovdqu	ymmword ptr [rcx + r14], ymm0
	add	r14, 32
	cmp	r14, rdx
	jb	712b
	mov	r14, qword ptr [rsp + 8]
	jmp	512b
722:
	cmp	r8, 31
	ja	732f
	mov	qword ptr [r13 + 104], 1
732:
	mov	rdi, qword ptr [r13 + 48]
	mov	r8, qword ptr [r13 + 120]
	movzx	ebp, byte ptr [rdi + r8]
	inc	r8
	mov	qword ptr [r13 + 120], r8
	add	rbp, 33
	add	rcx, r14
	mov	rdi, qword ptr [rsp]
	lea	r8, [rbx + rdi]
	lea	rdi, [rdx + rsi]
	add	rdi, r8
	mov	qword ptr [rsp + 128], rdi
	mov	r8, qword ptr [rsp + 24]
	mov	rdi, qword ptr [rsp + 80]
	add	r8, rdi
	mov	rdi, qword ptr [rsp + 128]
	add	rdi, r8
	add	rdi, r14
	mov	r8d, 32
	.p2align	4
742:
	vmovdqu	ymm0, ymmword ptr [rcx + r8]
	vmovdqu	ymmword ptr [rdi + r8], ymm0
	add	r8, 32
	cmp	r8, rbp
	jb	742b
	jmp	532b
752:
	mov	r8, qword ptr [r13 + 56]
	shl	r10, 5
	vmovdqu	ymm1, ymmword ptr [r8 + r10 + 2048]
	mov	r8, qword ptr [rsp + 8]
	vmovdqu	ymm2, ymmword ptr [r8 + rcx]
	vpermq	ymm3, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm3, ymm3, ymm1
	vpshufb	ymm2, ymm2, ymm1
	vpsllw	ymm1, ymm1, 3
	vpblendvb	ymm1, ymm3, ymm2, ymm1
	vpaddb	ymm0, ymm1, ymm0
	vmovdqu	ymmword ptr [r8 + r11], ymm0
	cmp	r14b, 33
	jb	542b
762:
	mov	rcx, qword ptr [r13 + 48]
	mov	r8, qword ptr [r13 + 120]
	movzx	r14d, byte ptr [rcx + r8]
	inc	r8
	mov	qword ptr [r13 + 120], r8
	add	r14, 33
	mov	r10, qword ptr [rsp]
	lea	r8, [rbp + rdx]
	add	r8, rbx
	add	r8, r10
	mov	r13, qword ptr [rsp + 80]
	lea	rcx, [rsi + r13]
	add	rcx, qword ptr [rsp + 24]
	add	rcx, r8
	add	rcx, qword ptr [rsp + 8]
	lea	r8, [r13 + r10]
	mov	r10, qword ptr [rsp + 16]
	add	r10, rdx
	add	r10, r8
	add	r10, qword ptr [rsp + 72]
	mov	r8d, 32
	.p2align	4
772:
	vmovdqu	ymm0, ymmword ptr [r10 + r8]
	vmovdqu	ymmword ptr [rcx + r8], ymm0
	add	r8, 32
	cmp	r8, r14
	jb	772b
	jmp	542b
782:
	cmp	r13, 31
	mov	r13, qword ptr [rsp + 64]
	ja	792f
	mov	qword ptr [r13 + 104], 1
792:
	mov	rdi, qword ptr [r13 + 48]
	mov	r8, qword ptr [r13 + 120]
	movzx	r10d, byte ptr [rdi + r8]
	inc	r8
	mov	qword ptr [r13 + 120], r8
	add	r10, 33
	mov	rdi, qword ptr [rsp + 8]
	add	rcx, rdi
	add	rbx, qword ptr [rsp]
	add	rbp, r14
	add	rbp, rbx
	add	rdx, rsi
	add	rdx, qword ptr [rsp + 80]
	add	rdx, rbp
	add	rdx, qword ptr [rsp + 24]
	add	rdx, rdi
	mov	esi, 32
	.p2align	4
802:
	vmovdqu	ymm0, ymmword ptr [rcx + rsi]
	vmovdqu	ymmword ptr [rdx + rsi], ymm0
	add	rsi, 32
	cmp	rsi, r10
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
	mov	r10, qword ptr [rsp]
	mov	r8, qword ptr [rsp + 16]
	vmovdqu	ymm1, ymmword ptr [r14 + rcx]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	jmp	462b
822:
	cmp	r8, r11
	mov	rdx, r11
	cmovb	rdx, r8
	mov	rcx, r11
	sub	rcx, rdx
	cmp	rdx, rsi
	jae	862f
	mov	r10, qword ptr [r13 + 56]
	mov	r14, rdx
	shl	r14, 5
	vmovdqu	ymm0, ymmword ptr [r10 + r14 + 2048]
	mov	r10, qword ptr [rsp]
	mov	r14, qword ptr [rsp + 8]
	vmovdqu	ymm1, ymmword ptr [r14 + rcx]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	jmp	492b
832:
	cmp	r10, r11
	mov	r8, r11
	cmovb	r8, r10
	mov	rcx, r11
	sub	rcx, r8
	cmp	r8, rbp
	jae	872f
	mov	r14, qword ptr [r13 + 56]
	mov	r13, r8
	shl	r13, 5
	vmovdqu	ymm0, ymmword ptr [r14 + r13 + 2048]
	mov	r14, qword ptr [rsp + 8]
	mov	r13, qword ptr [rsp + 64]
	vmovdqu	ymm1, ymmword ptr [r14 + rcx]
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
	mov	r8, qword ptr [rsp + 64]
	mov	r8, qword ptr [r8 + 56]
	mov	qword ptr [rsp + 16], r8
	mov	r8, r13
	shl	r8, 5
	mov	qword ptr [rsp + 128], r15
	mov	r15, qword ptr [rsp + 16]
	vmovdqu	ymm0, ymmword ptr [r15 + r8 + 2048]
	mov	r15, qword ptr [rsp + 128]
	mov	r8, qword ptr [rsp + 8]
	vmovdqu	ymm1, ymmword ptr [r8 + rcx]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	jmp	552b
852:
	vmovdqu	ymm0, ymmword ptr [r14 + rcx]
	jmp	462b
862:
	vmovdqu	ymm0, ymmword ptr [r14 + rcx]
	jmp	492b
872:
	vmovdqu	ymm0, ymmword ptr [r14 + rcx]
	jmp	522b
882:
	mov	r8, qword ptr [rsp + 8]
	vmovdqu	ymm0, ymmword ptr [r8 + rcx]
	jmp	552b
	.p2align	4
892:
	mov	r10, qword ptr [rsp + 24]
	mov	r14, r8
902:
	mov	rcx, qword ptr [rsp + 120]
	cmp	rax, rcx
	mov	r12, r10
	mov	rdi, r14
	mov	r14, rcx
	mov	r11, qword ptr [rsp + 8]
	je	2b
	.p2align	4
912:
	cmp	r15, r12
	cmovae	r15, r12
	mov	rcx, r12
	sub	rcx, r15
	cmp	r15, 31
	jbe	962f
	vmovdqu	ymm0, ymmword ptr [r11 + rcx]
922:
	mov	rcx, qword ptr [rsp + 32]
	movzx	esi, byte ptr [rcx + rax]
	movzx	edx, byte ptr [r13 + rax + 192]
	mov	r15d, dword ptr [r13 + 4*rax + 256]
	vpaddb	ymm0, ymm0, ymmword ptr [rbp + rdi]
	vmovdqu	ymmword ptr [r11 + r12], ymm0
	cmp	dl, 33
	mov	r9, rdi
	jae	972f
932:
	add	r12, rdx
	mov	ecx, esi
	shr	ecx, 2
	cmp	r15d, ecx
	jb	1022f
	mov	rdi, r12
	sub	rdi, r15
	jb	1022f
	vmovdqu	ymm0, ymmword ptr [r11 + rdi]
	mov	r8, r15
942:
	vmovdqu	ymmword ptr [r11 + r12], ymm0
	cmp	sil, -124
	jae	992f
952:
	mov	rdi, r9
	add	rdi, rdx
	add	r12, rcx
	inc	rax
	cmp	rax, r14
	jb	912b
	jmp	2b
962:
	mov	rdx, qword ptr [r13 + 56]
	shl	r15, 5
	vmovdqu	ymm0, ymmword ptr [rdx + r15 + 2048]
	vmovdqu	ymm1, ymmword ptr [r11 + rcx]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	jmp	922b
972:
	lea	rcx, [rbp + rdi]
	lea	rdi, [r11 + r12]
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
	jmp	932b
992:
	cmp	r8, 31
	ja	1002f
	mov	qword ptr [r13 + 104], 1
1002:
	lea	rsi, [r11 + r12]
	mov	rcx, qword ptr [r13 + 48]
	mov	r8, qword ptr [r13 + 120]
	movzx	ecx, byte ptr [rcx + r8]
	inc	r8
	mov	qword ptr [r13 + 120], r8
	add	rcx, 33
	add	rdi, r11
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
	cmp	r15, r12
	mov	r8, r12
	cmovb	r8, r15
	mov	rdi, r12
	sub	rdi, r8
	cmp	r8, rcx
	jae	1032f
	mov	r10, qword ptr [r13 + 56]
	mov	qword ptr [rsp + 80], r10
	mov	r10, r8
	shl	r10, 5
	mov	rbx, qword ptr [rsp + 80]
	vmovdqu	ymm0, ymmword ptr [rbx + r10 + 2048]
	vmovdqu	ymm1, ymmword ptr [r11 + rdi]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	jmp	942b
1032:
	vmovdqu	ymm0, ymmword ptr [r11 + rdi]
	jmp	942b
1042:
	mov	qword ptr [r13 + 80], r12
	mov	qword ptr [r13 + 88], rdi
	add	rsp, 648
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
	.p2align	5, 0x0
1132:
	.zero	32,31
	.p2align	4, 0x0
1142:
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
1152:
	.byte	16
	.p2align	2, 0x0
1162:
	.byte	32
	.p2align	5, 0x0
1172:
	.long	1207959552
	.long	1342177280
	.long	1476395008
	.long	1610612736
	.long	1744830464
	.long	1879048192
	.long	2013265920
	.long	2147483648
	.p2align	5, 0x0
1182:
	.long	134217728
	.long	268435456
	.long	402653184
	.long	536870912
	.long	671088640
	.long	805306368
	.long	939524096
	.long	1073741824
	.p2align	5, 0x0
1192:
	.zero	32,1

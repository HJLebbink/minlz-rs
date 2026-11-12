# minlz_exec_plain of crates/minlz/mlir/exec64.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 616
	mov	r10, rdi
	mov	rax, qword ptr [rdi + 64]
	mov	r15, qword ptr [rdi + 80]
	mov	r13, qword ptr [rdi + 88]
	test	rax, rax
	jle	932f
	mov	r11, qword ptr [r10]
	mov	rbp, qword ptr [r10 + 8]
	mov	rcx, qword ptr [r10 + 16]
	mov	qword ptr [rsp + 264], rcx
	lea	r8, [r10 + 512]
	lea	r9, [r10 + 576]
	mov	ecx, 96
	mov	qword ptr [rsp + 136], rcx
	mov	ecx, 7
	mov	qword ptr [rsp + 88], rcx
	mov	qword ptr [rsp + 152], 0
	vbroadcastss	ymm0, dword ptr [rip + 942f]
	vmovups	ymmword ptr [rsp + 448], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 952f]
	vmovups	ymmword ptr [rsp + 416], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 962f]
	vmovups	ymmword ptr [rsp + 384], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 972f]
	vmovups	ymmword ptr [rsp + 352], ymm0
	vpbroadcastd	ymm0, dword ptr [rip + 982f]
	vmovdqu	ymmword ptr [rsp + 320], ymm0
	mov	qword ptr [rsp + 144], r8
	xor	ecx, ecx
	mov	qword ptr [rsp + 72], rbp
	mov	qword ptr [rsp + 56], r8
	mov	qword ptr [rsp + 16], r10
	mov	qword ptr [rsp + 272], rax
	mov	qword ptr [rsp + 40], r11
	mov	qword ptr [rsp + 48], r9
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
	mov	r8, qword ptr [rsp + 56]
	jge	932f
12:
	mov	qword ptr [rsp + 80], r13
	mov	qword ptr [rsp + 32], r15
	mov	r14, rcx
	mov	rcx, rax
	sub	rcx, r14
	cmp	rcx, 64
	mov	eax, 64
	mov	qword ptr [rsp + 160], rcx
	cmovb	rax, rcx
	mov	qword ptr [rsp + 64], rax
	mov	rsi, qword ptr [r10 + 16]
	mov	rbx, qword ptr [r10 + 24]
	mov	r12, qword ptr [r10 + 32]
	mov	rax, qword ptr [r10 + 40]
	mov	rdi, qword ptr [r10 + 64]
	mov	rcx, qword ptr [r10 + 72]
	mov	qword ptr [rsp + 8], rcx
	mov	r15, qword ptr [r10 + 96]
	mov	r9, qword ptr [r10 + 112]
	mov	rdx, qword ptr [r10 + 128]
	mov	r13, qword ptr [r10 + 136]
	lea	r11, [rdi + 7]
	lea	rcx, [r14 + 64]
	mov	qword ptr [rsp + 280], rcx
	cmp	rcx, r11
	mov	qword ptr [rsp + 24], r14
	mov	qword ptr [rsp + 96], r15
	mov	qword ptr [rsp + 192], r13
	jbe	22f
	cmp	r14, r11
	jge	92f
	mov	r8, qword ptr [rsp + 152]
	shl	r8, 6
	mov	ecx, 7
	sub	rcx, r8
	add	rcx, rdi
	cmp	rcx, 16
	mov	r14, qword ptr [rsp + 24]
	jb	72f
	add	r8, rsi
	mov	r14, r10
	sub	r14, r8
	add	r14, 511
	cmp	r14, 127
	mov	r14, qword ptr [rsp + 24]
	jb	72f
	cmp	rcx, 128
	jae	32f
	xor	r15d, r15d
	jmp	52f
	.p2align	4
22:
	add	rsi, r14
	mov	r8, rsi
	jmp	92f
32:
	mov	r15, rcx
	and	r15, -128
	mov	r8, qword ptr [rsp + 24]
	lea	r14, [r8 + r15]
	mov	r8, qword ptr [rsp + 136]
	lea	r13, [rsi + r8]
	mov	rbp, r10
	mov	r8, qword ptr [rsp + 88]
	lea	r10, [rdi + r8]
	and	r10, -128
	xor	r8d, r8d
	.p2align	4
42:
	vmovdqu	ymm0, ymmword ptr [r13 + r8 - 96]
	vmovdqu	ymm1, ymmword ptr [r13 + r8 - 64]
	vmovups	ymm3, ymmword ptr [r13 + r8 - 32]
	vmovdqu	ymm4, ymmword ptr [r13 + r8]
	vmovdqu	ymmword ptr [rbp + r8 + 512], ymm0
	vmovdqu	ymmword ptr [rbp + r8 + 544], ymm1
	vmovups	ymmword ptr [rbp + r8 + 576], ymm3
	vmovdqu	ymmword ptr [rbp + r8 + 608], ymm4
	sub	r8, -128
	cmp	r10, r8
	jne	42b
	cmp	rcx, r15
	mov	r8, qword ptr [rsp + 56]
	mov	r10, rbp
	mov	rbp, qword ptr [rsp + 72]
	je	92f
	test	cl, 112
	je	72f
52:
	mov	r13, rcx
	and	r13, -16
	mov	r8, qword ptr [rsp + 24]
	lea	r14, [r8 + r13]
	add	r8, rsi
	add	rdi, qword ptr [rsp + 88]
	and	rdi, -16
	mov	r10, qword ptr [rsp + 56]
	.p2align	4
62:
	vmovdqu	xmm0, xmmword ptr [r8 + r15]
	vmovdqu	xmmword ptr [r10 + r15], xmm0
	add	r15, 16
	cmp	rdi, r15
	jne	62b
	cmp	rcx, r13
	mov	r8, r10
	mov	r10, qword ptr [rsp + 16]
	je	92f
	.p2align	4
72:
	mov	rdi, qword ptr [rsp + 144]
	.p2align	4
82:
	movzx	ecx, byte ptr [rsi + r14]
	mov	byte ptr [rdi + r14], cl
	inc	r14
	cmp	r11, r14
	jne	82b
	mov	r8, qword ptr [rsp + 56]
92:
	vmovdqu	ymm3, ymmword ptr [r8]
	vmovdqu	ymm4, ymmword ptr [r8 + 32]
	vmovd	xmm0, dword ptr [rsp + 64]
	vpbroadcastb	ymm1, xmm0
	vpmaxub	ymm0, ymm1, ymmword ptr [rip + 992f]
	vpcmpeqb	ymm0, ymm1, ymm0
	vpmaxub	ymm5, ymm1, ymmword ptr [rip + 1002f]
	vpcmpeqb	ymm1, ymm1, ymm5
	vpsllw	ymm5, ymm3, 6
	vpxor	xmm2, xmm2, xmm2
	vpcmpgtb	ymm5, ymm2, ymm5
	vpsllw	ymm6, ymm4, 6
	vpcmpgtb	ymm9, ymm2, ymm6
	vpbroadcastb	ymm7, byte ptr [rip + 1012f]
	vpand	ymm3, ymm3, ymm7
	vpand	ymm4, ymm4, ymm7
	vpcmpeqb	ymm4, ymm4, ymm2
	vpcmpeqb	ymm3, ymm3, ymm2
	movabs	r14, 72340172838076673
	mov	rsi, r14
	#APP
	#NO_APP
	vpand	ymm5, ymm5, ymm7
	vpand	ymm6, ymm0, ymm5
	vpand	ymm5, ymm9, ymm7
	vpand	ymm5, ymm1, ymm5
	vmovdqu	ymmword ptr [r10 + 544], ymm5
	vmovdqu	ymmword ptr [r10 + 512], ymm6
	vmovq	rcx, xmm6
	mov	rdi, rcx
	imul	rdi, rsi
	mov	r8, rdi
	sub	r8, rcx
	xor	rcx, rsi
	shl	rcx, 7
	or	rcx, r8
	vmovq	xmm9, qword ptr [rbx + rdx]
	vmovq	xmm10, rcx
	vpshufb	xmm9, xmm9, xmm10
	shr	rdi, 56
	add	rdi, rdx
	vmovq	qword ptr [r10 + 512], xmm9
	vpextrq	rdx, xmm6, 1
	mov	rcx, rdx
	imul	rcx, rsi
	mov	r8, rcx
	sub	r8, rdx
	xor	rdx, rsi
	shl	rdx, 7
	or	rdx, r8
	vmovq	xmm9, qword ptr [rbx + rdi]
	vmovq	xmm10, rdx
	vpshufb	xmm9, xmm9, xmm10
	shr	rcx, 56
	add	rcx, rdi
	vmovq	qword ptr [r10 + 520], xmm9
	vextracti128	xmm6, ymm6, 1
	vmovq	rdi, xmm6
	mov	rdx, rdi
	imul	rdx, rsi
	mov	r8, rdx
	sub	r8, rdi
	xor	rdi, rsi
	shl	rdi, 7
	or	rdi, r8
	vmovq	xmm9, qword ptr [rbx + rcx]
	vmovq	xmm10, rdi
	vpshufb	xmm9, xmm9, xmm10
	shr	rdx, 56
	add	rdx, rcx
	vmovq	qword ptr [r10 + 528], xmm9
	vpextrq	rdi, xmm6, 1
	mov	rcx, rdi
	imul	rcx, rsi
	mov	r8, rcx
	sub	r8, rdi
	xor	rdi, rsi
	shl	rdi, 7
	or	rdi, r8
	vmovq	xmm6, qword ptr [rbx + rdx]
	vmovq	xmm9, rdi
	vpshufb	xmm6, xmm6, xmm9
	shr	rcx, 56
	add	rcx, rdx
	vmovq	qword ptr [r10 + 536], xmm6
	vmovq	rdi, xmm5
	mov	rdx, rdi
	imul	rdx, rsi
	mov	r8, rdx
	sub	r8, rdi
	xor	rdi, rsi
	shl	rdi, 7
	or	rdi, r8
	vmovq	xmm6, qword ptr [rbx + rcx]
	vmovq	xmm9, rdi
	vpshufb	xmm6, xmm6, xmm9
	shr	rdx, 56
	add	rdx, rcx
	vmovq	qword ptr [r10 + 544], xmm6
	vpextrq	rdi, xmm5, 1
	mov	rcx, rdi
	imul	rcx, rsi
	mov	r8, rcx
	sub	r8, rdi
	xor	rdi, rsi
	shl	rdi, 7
	or	rdi, r8
	vmovq	xmm5, qword ptr [rbx + rdx]
	vmovq	xmm6, rdi
	vpshufb	xmm5, xmm5, xmm6
	shr	rcx, 56
	add	rcx, rdx
	vmovq	qword ptr [r10 + 552], xmm5
	mov	rdx, qword ptr [r10 + 560]
	mov	rdi, qword ptr [r10 + 568]
	mov	r13, rdx
	imul	r13, rsi
	mov	r8, r13
	sub	r8, rdx
	xor	rdx, rsi
	shl	rdx, 7
	or	rdx, r8
	vmovq	xmm5, qword ptr [rbx + rcx]
	vmovq	xmm6, rdx
	vpshufb	xmm5, xmm5, xmm6
	shr	r13, 56
	add	r13, rcx
	vmovq	qword ptr [r10 + 560], xmm5
	mov	r11, rdi
	imul	r11, rsi
	mov	rcx, r11
	sub	rcx, rdi
	xor	rsi, rdi
	shl	rsi, 7
	or	rsi, rcx
	vmovq	xmm5, qword ptr [rbx + r13]
	vmovq	xmm6, rsi
	vpshufb	xmm5, xmm5, xmm6
	vmovq	qword ptr [r10 + 568], xmm5
	vmovups	ymm5, ymmword ptr [r10 + 544]
	vmovups	ymm6, ymmword ptr [r10 + 512]
	vmovups	ymmword ptr [r10 + 192], ymm6
	vmovups	ymmword ptr [r10 + 224], ymm5
	mov	rdx, r14
	#APP
	#NO_APP
	vpand	ymm4, ymm4, ymm7
	vpand	ymm1, ymm1, ymm4
	vpand	ymm3, ymm3, ymm7
	vpand	ymm0, ymm0, ymm3
	vmovdqu	ymmword ptr [r10 + 512], ymm0
	vmovdqu	ymmword ptr [r10 + 544], ymm1
	vmovq	rcx, xmm0
	mov	rsi, rdx
	imul	rsi, rcx
	mov	rdi, rsi
	sub	rdi, rcx
	xor	rcx, rdx
	shl	rcx, 7
	or	rcx, rdi
	mov	rdi, qword ptr [rsp + 192]
	vmovq	xmm3, qword ptr [r12 + rdi]
	vmovq	xmm4, rcx
	vpshufb	xmm3, xmm3, xmm4
	shr	rsi, 56
	add	rsi, rdi
	vmovq	qword ptr [r10 + 512], xmm3
	vpextrq	rdi, xmm0, 1
	mov	rcx, rdx
	imul	rcx, rdi
	mov	r8, rcx
	sub	r8, rdi
	xor	rdi, rdx
	shl	rdi, 7
	or	rdi, r8
	vmovq	xmm3, qword ptr [r12 + rsi]
	vmovq	xmm4, rdi
	vpshufb	xmm3, xmm3, xmm4
	shr	rcx, 56
	add	rcx, rsi
	vmovq	qword ptr [r10 + 520], xmm3
	vextracti128	xmm0, ymm0, 1
	vmovq	rdi, xmm0
	mov	rsi, rdx
	imul	rsi, rdi
	mov	r8, rsi
	sub	r8, rdi
	xor	rdi, rdx
	shl	rdi, 7
	or	rdi, r8
	vmovq	xmm3, qword ptr [r12 + rcx]
	vmovq	xmm4, rdi
	vpshufb	xmm3, xmm3, xmm4
	shr	rsi, 56
	add	rsi, rcx
	vmovq	qword ptr [r10 + 528], xmm3
	vpextrq	rdi, xmm0, 1
	mov	rcx, rdx
	imul	rcx, rdi
	mov	r8, rcx
	sub	r8, rdi
	xor	rdi, rdx
	shl	rdi, 7
	or	rdi, r8
	vmovq	xmm0, qword ptr [r12 + rsi]
	vmovq	xmm3, rdi
	vpshufb	xmm0, xmm0, xmm3
	shr	rcx, 56
	add	rcx, rsi
	vmovq	qword ptr [r10 + 536], xmm0
	vmovq	rdi, xmm1
	mov	rsi, rdx
	imul	rsi, rdi
	mov	r8, rsi
	sub	r8, rdi
	xor	rdi, rdx
	shl	rdi, 7
	or	rdi, r8
	vmovq	xmm0, qword ptr [r12 + rcx]
	vmovq	xmm3, rdi
	vpshufb	xmm0, xmm0, xmm3
	shr	rsi, 56
	add	rsi, rcx
	vmovq	qword ptr [r10 + 544], xmm0
	vpextrq	rdi, xmm1, 1
	mov	rcx, rdx
	imul	rcx, rdi
	mov	r8, rcx
	sub	r8, rdi
	xor	rdi, rdx
	shl	rdi, 7
	or	rdi, r8
	vmovq	xmm0, qword ptr [r12 + rsi]
	vmovq	xmm1, rdi
	vpshufb	xmm0, xmm0, xmm1
	shr	rcx, 56
	add	rcx, rsi
	vmovq	qword ptr [r10 + 552], xmm0
	mov	rsi, qword ptr [r10 + 560]
	mov	rdi, qword ptr [r10 + 568]
	mov	rbx, rsi
	imul	rbx, rdx
	mov	r8, rbx
	sub	r8, rsi
	xor	rsi, rdx
	shl	rsi, 7
	or	rsi, r8
	vmovq	xmm0, qword ptr [r12 + rcx]
	vmovq	xmm1, rsi
	vpshufb	xmm0, xmm0, xmm1
	shr	rbx, 56
	add	rbx, rcx
	vmovq	qword ptr [r10 + 560], xmm0
	mov	rsi, r10
	mov	r10, rdi
	imul	r10, rdx
	mov	rcx, r10
	sub	rcx, rdi
	xor	rdx, rdi
	shl	rdx, 7
	or	rdx, rcx
	vmovq	xmm0, qword ptr [r12 + rbx]
	vmovq	xmm1, rdx
	vpshufb	xmm0, xmm0, xmm1
	vmovq	qword ptr [rsi + 568], xmm0
	vmovdqu	ymm8, ymmword ptr [rsi + 512]
	vmovdqu	ymm0, ymmword ptr [rsi + 512]
	vmovups	ymm1, ymmword ptr [rsi + 544]
	vmovups	ymmword ptr [rsp + 544], ymm1
	vpsrlw	ymm0, ymm0, 3
	vpand	ymm0, ymm0, ymmword ptr [rip + 1022f]
	vpsubusb	ymm0, ymm0, ymm7
	vpsllq	ymm1, ymm0, 8
	vpaddb	ymm1, ymm0, ymm1
	vpsllq	ymm3, ymm1, 16
	vpaddb	ymm1, ymm1, ymm3
	vpsllq	ymm3, ymm1, 32
	vpaddb	ymm1, ymm1, ymm3
	vpsubb	ymm14, ymm1, ymm0
	vpsrlq	ymm13, ymm1, 56
	vmovss	xmm0, dword ptr [rsp + 96]
	vbroadcastss	ymm0, xmm0
	vmovups	ymmword ptr [rsp + 224], ymm0
	vpbroadcastd	ymm0, xmm13
	vpmovzxbd	ymm5, xmm14
	vpshufd	xmm3, xmm14, 238
	vpmovzxbd	ymm3, xmm3
	vpaddd	ymm0, ymm0, ymm3
	vpmovzxbd	ymm3, qword ptr [rsi + 520]
	vpmovzxbd	ymm6, qword ptr [rsi + 512]
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
	mov	rdx, qword ptr [rsp + 8]
	mov	ecx, edx
	and	ecx, 7
	vmovd	xmm10, ecx
	vpbroadcastd	ymm10, xmm10
	vpaddd	ymm0, ymm10, ymm0
	vpaddd	ymm10, ymm10, ymm5
	vpsrld	ymm15, ymm0, 3
	vpsrld	ymm7, ymm10, 3
	vpand	ymm5, ymm0, ymm2
	vpand	ymm10, ymm10, ymm2
	vbroadcasti128	ymm2, xmmword ptr [rip + 1032f]
	vpshufb	ymm0, ymm15, ymm2
	vpshufb	ymm7, ymm7, ymm2
	vmovdqu	ymm2, ymmword ptr [rsp + 352]
	vpaddb	ymm15, ymm0, ymm2
	vpaddb	ymm0, ymm7, ymm2
	shr	rdx, 3
	lea	rcx, [rdx + 64]
	cmp	rcx, r9
	vmovdqu	ymmword ptr [rsp + 480], ymm8
	vmovdqu	ymmword ptr [rsp + 576], ymm13
	vmovdqu	ymmword ptr [rsp + 96], ymm3
	vmovdqu	ymmword ptr [rsp + 192], ymm6
	vmovdqu	ymmword ptr [rsp + 288], ymm4
	vmovdqu	ymmword ptr [rsp + 512], ymm5
	vmovdqa	ymm5, ymm12
	jbe	102f
	mov	rcx, r9
	sub	rcx, rdx
	mov	r15, qword ptr [rsp + 48]
	mov	r8, r15
	jbe	172f
	cmp	rcx, 16
	mov	rsi, rdx
	jb	152f
	lea	rdi, [rdx + rax]
	mov	rsi, qword ptr [rsp + 16]
	sub	rsi, rdi
	add	rsi, 575
	cmp	rsi, 127
	mov	rsi, rdx
	jb	152f
	cmp	rcx, 128
	jae	112f
	xor	r14d, r14d
	jmp	132f
	.p2align	4
102:
	add	rdx, rax
	mov	r8, rdx
	mov	r15, qword ptr [rsp + 48]
	jmp	172f
112:
	mov	r14, rcx
	and	r14, -128
	lea	rsi, [rdx + r14]
	lea	r15, [rax + rdx + 96]
	xor	r8d, r8d
	mov	r12, qword ptr [rsp + 16]
	.p2align	4
122:
	vmovdqu	ymm7, ymmword ptr [r15 + r8 - 96]
	vmovdqu	ymm8, ymmword ptr [r15 + r8 - 64]
	vmovdqu	ymm2, ymmword ptr [r15 + r8 - 32]
	vmovdqu	ymm4, ymmword ptr [r15 + r8]
	vmovdqu	ymmword ptr [r12 + r8 + 576], ymm7
	vmovdqu	ymmword ptr [r12 + r8 + 608], ymm8
	vmovdqu	ymmword ptr [r12 + r8 + 640], ymm2
	vmovdqu	ymmword ptr [r12 + r8 + 672], ymm4
	sub	r8, -128
	cmp	r14, r8
	jne	122b
	cmp	rcx, r14
	mov	r15, qword ptr [rsp + 48]
	mov	r8, r15
	je	172f
	test	cl, 112
	je	152f
132:
	mov	r8, rcx
	and	r8, -16
	lea	rsi, [rdx + r8]
	.p2align	4
142:
	vmovdqu	xmm2, xmmword ptr [rdi + r14]
	vmovdqu	xmmword ptr [r15 + r14], xmm2
	add	r14, 16
	cmp	r8, r14
	jne	142b
	cmp	rcx, r8
	mov	r8, r15
	je	172f
	.p2align	4
152:
	mov	rcx, r15
	sub	rcx, rdx
	.p2align	4
162:
	movzx	edx, byte ptr [rax + rsi]
	mov	byte ptr [rcx + rsi], dl
	inc	rsi
	cmp	r9, rsi
	jne	162b
	mov	r8, r15
172:
	vmovdqu	ymm2, ymmword ptr [r8]
	vmovdqu	ymm4, ymmword ptr [r8 + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm8, ymm7, ymm15
	vpshufb	ymm9, ymm2, ymm15
	vpbroadcastb	ymm12, byte ptr [rip + 1042f]
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
	vpbroadcastb	ymm7, byte ptr [rip + 1052f]
	vpand	ymm0, ymm0, ymm7
	vpcmpeqb	ymm0, ymm0, ymm7
	vpblendvb	ymm0, ymm2, ymm4, ymm0
	vpand	ymm2, ymm15, ymm7
	vpcmpeqb	ymm2, ymm2, ymm7
	vpblendvb	ymm2, ymm8, ymm3, ymm2
	vpsrlvd	ymm0, ymm0, ymm10
	vpandn	ymm0, ymm1, ymm0
	vpaddd	ymm0, ymm0, ymm5
	vpsrlvd	ymm2, ymm2, ymmword ptr [rsp + 512]
	vmovdqu	ymm1, ymmword ptr [rsp + 288]
	vpandn	ymm2, ymm1, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 192]
	vpor	ymm3, ymm2, ymmword ptr [rip + 1062f]
	vpcmpeqd	ymm2, ymm2, ymm6
	vpandn	ymm2, ymm2, ymm3
	vpor	ymm3, ymm0, ymmword ptr [rip + 1072f]
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
	vmovups	ymm1, ymmword ptr [rsp + 224]
	vblendvps	ymm0, ymm2, ymm1, ymm0
	vpand	ymm2, ymm3, ymm4
	vpcmpeqd	ymm3, ymm3, ymm6
	vblendvps	ymm1, ymm2, ymm1, ymm3
	vmovdqu	ymm2, ymmword ptr [rsp + 96]
	vextracti128	xmm2, ymm2, 1
	vpextrd	ecx, xmm2, 3
	mov	rdx, qword ptr [rsp + 16]
	vmovups	ymmword ptr [rdx + 256], ymm1
	vmovups	ymmword ptr [rdx + 288], ymm0
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm1, ymm0, 170
	mov	rdx, qword ptr [rsp + 8]
	add	rdx, rcx
	cmp	qword ptr [rsp + 160], 17
	jb	342f
	vmovups	ymmword ptr [rsp + 288], ymm1
	vextracti128	xmm0, ymm14, 1
	vpshufd	xmm2, xmm0, 238
	vmovdqu	ymm3, ymmword ptr [rsp + 576]
	vextracti128	xmm3, ymm3, 1
	vpmovzxbd	ymm2, xmm2
	vpbroadcastd	ymm3, xmm3
	vpaddd	ymm2, ymm3, ymm2
	vpmovzxbd	ymm0, xmm0
	vmovdqu	ymm3, ymmword ptr [rsp + 480]
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
	mov	ecx, edx
	and	ecx, 7
	vmovd	xmm5, ecx
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm0, ymm5, ymm0
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm7, ymm2, 3
	vpsrld	ymm8, ymm0, 3
	vpand	ymm5, ymm10, ymm2
	vpand	ymm1, ymm10, ymm0
	vbroadcasti128	ymm2, xmmword ptr [rip + 1032f]
	vpshufb	ymm0, ymm8, ymm2
	vpshufb	ymm2, ymm7, ymm2
	vmovdqu	ymm4, ymmword ptr [rsp + 352]
	vpaddb	ymm12, ymm2, ymm4
	vpaddb	ymm0, ymm0, ymm4
	mov	qword ptr [rsp + 8], rdx
	shr	rdx, 3
	lea	rcx, [rdx + 64]
	cmp	rcx, r9
	vmovdqu	ymmword ptr [rsp + 96], ymm3
	vmovdqu	ymmword ptr [rsp + 192], ymm9
	vmovdqu	ymmword ptr [rsp + 224], ymm5
	vmovdqa	ymm10, ymm13
	vmovdqa	ymm5, ymm6
	jbe	182f
	mov	rcx, r9
	sub	rcx, rdx
	mov	r8, r15
	jbe	252f
	cmp	rcx, 16
	mov	rsi, rdx
	jb	232f
	lea	rdi, [rdx + rax]
	mov	rsi, qword ptr [rsp + 16]
	sub	rsi, rdi
	add	rsi, 575
	cmp	rsi, 127
	mov	rsi, rdx
	jb	232f
	cmp	rcx, 128
	jae	192f
	xor	r14d, r14d
	jmp	212f
	.p2align	4
182:
	add	rdx, rax
	mov	r8, rdx
	jmp	252f
192:
	mov	r14, rcx
	and	r14, -128
	lea	rsi, [rdx + r14]
	lea	r15, [rax + rdx + 96]
	xor	r8d, r8d
	mov	r12, qword ptr [rsp + 16]
	.p2align	4
202:
	vmovdqu	ymm2, ymmword ptr [r15 + r8 - 96]
	vmovdqu	ymm7, ymmword ptr [r15 + r8 - 64]
	vmovdqu	ymm8, ymmword ptr [r15 + r8 - 32]
	vmovdqu	ymm13, ymmword ptr [r15 + r8]
	vmovdqu	ymmword ptr [r12 + r8 + 576], ymm2
	vmovdqu	ymmword ptr [r12 + r8 + 608], ymm7
	vmovdqu	ymmword ptr [r12 + r8 + 640], ymm8
	vmovdqu	ymmword ptr [r12 + r8 + 672], ymm13
	sub	r8, -128
	cmp	r14, r8
	jne	202b
	cmp	rcx, r14
	mov	r15, qword ptr [rsp + 48]
	mov	r8, r15
	je	252f
	test	cl, 112
	je	232f
212:
	mov	r8, rcx
	and	r8, -16
	lea	rsi, [rdx + r8]
	.p2align	4
222:
	vmovdqu	xmm2, xmmword ptr [rdi + r14]
	vmovdqu	xmmword ptr [r15 + r14], xmm2
	add	r14, 16
	cmp	r8, r14
	jne	222b
	cmp	rcx, r8
	mov	r8, r15
	je	252f
232:
	mov	rcx, r15
	sub	rcx, rdx
	.p2align	4
242:
	movzx	edx, byte ptr [rax + rsi]
	mov	byte ptr [rcx + rsi], dl
	inc	rsi
	cmp	r9, rsi
	jne	242b
	mov	r8, r15
252:
	vmovdqu	ymm2, ymmword ptr [r8]
	vmovdqu	ymm7, ymmword ptr [r8 + 32]
	vpermq	ymm8, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm13, ymm8, ymm12
	vpshufb	ymm14, ymm2, ymm12
	vpbroadcastb	ymm3, byte ptr [rip + 1042f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 1052f]
	vpand	ymm0, ymm0, ymm3
	vpcmpeqb	ymm0, ymm0, ymm3
	vpblendvb	ymm0, ymm2, ymm7, ymm0
	vpand	ymm2, ymm12, ymm3
	vpcmpeqb	ymm2, ymm2, ymm3
	vpblendvb	ymm2, ymm13, ymm4, ymm2
	vpsrlvd	ymm0, ymm0, ymm1
	vpandn	ymm0, ymm10, ymm0
	vpaddd	ymm0, ymm0, ymm5
	vpsrlvd	ymm2, ymm2, ymmword ptr [rsp + 224]
	vmovdqu	ymm3, ymmword ptr [rsp + 192]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm11, ymm2
	vpor	ymm3, ymm2, ymmword ptr [rip + 1062f]
	vpcmpeqd	ymm2, ymm2, ymm6
	vpandn	ymm2, ymm2, ymm3
	vpor	ymm3, ymm0, ymmword ptr [rip + 1072f]
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
	vmovdqu	ymm2, ymmword ptr [rsp + 96]
	vextracti128	xmm2, ymm2, 1
	vpextrd	ecx, xmm2, 3
	mov	rdx, qword ptr [rsp + 16]
	vmovups	ymmword ptr [rdx + 320], ymm1
	vmovups	ymmword ptr [rdx + 352], ymm0
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm1, ymm0, 170
	mov	rdx, qword ptr [rsp + 8]
	add	rdx, rcx
	cmp	qword ptr [rsp + 160], 33
	jb	342f
	vmovdqu	ymm4, ymmword ptr [rsp + 544]
	vpsrlw	ymm0, ymm4, 3
	vpand	ymm0, ymm0, ymmword ptr [rip + 1022f]
	vpsubusb	ymm0, ymm0, ymmword ptr [rip + 1082f]
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
	vmovdqu	ymmword ptr [rsp + 224], ymm3
	vpsllvd	ymm3, ymm8, ymm7
	vmovdqu	ymmword ptr [rsp + 192], ymm3
	vpsllvd	ymm3, ymm10, ymm6
	vmovdqu	ymmword ptr [rsp + 512], ymm3
	vpsllvd	ymm3, ymm10, ymm7
	vmovdqu	ymmword ptr [rsp + 288], ymm3
	vpaddd	ymm3, ymm0, ymm7
	vmovdqu	ymmword ptr [rsp + 96], ymm3
	mov	ecx, edx
	and	ecx, 7
	vmovd	xmm5, ecx
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm2, ymm5, ymm2
	vpaddd	ymm0, ymm5, ymm0
	vpsrld	ymm7, ymm0, 3
	vpsrld	ymm8, ymm2, 3
	vpand	ymm5, ymm0, ymm4
	vpand	ymm10, ymm2, ymm4
	vbroadcasti128	ymm2, xmmword ptr [rip + 1032f]
	vpshufb	ymm0, ymm8, ymm2
	vpshufb	ymm2, ymm7, ymm2
	vmovdqu	ymm3, ymmword ptr [rsp + 352]
	vpaddb	ymm14, ymm2, ymm3
	vpaddb	ymm0, ymm0, ymm3
	mov	qword ptr [rsp + 8], rdx
	shr	rdx, 3
	lea	rcx, [rdx + 64]
	cmp	rcx, r9
	jbe	262f
	mov	rcx, r9
	sub	rcx, rdx
	mov	r8, r15
	jbe	332f
	cmp	rcx, 16
	mov	rsi, rdx
	jb	312f
	lea	rdi, [rdx + rax]
	mov	rsi, qword ptr [rsp + 16]
	sub	rsi, rdi
	add	rsi, 575
	cmp	rsi, 127
	mov	rsi, rdx
	jb	312f
	cmp	rcx, 128
	jae	272f
	xor	r14d, r14d
	jmp	292f
262:
	add	rdx, rax
	mov	r8, rdx
	jmp	332f
272:
	mov	r14, rcx
	and	r14, -128
	lea	rsi, [rdx + r14]
	lea	r15, [rax + rdx + 96]
	xor	r8d, r8d
	mov	r12, qword ptr [rsp + 16]
	.p2align	4
282:
	vmovdqu	ymm2, ymmword ptr [r15 + r8 - 96]
	vmovdqu	ymm7, ymmword ptr [r15 + r8 - 64]
	vmovdqu	ymm8, ymmword ptr [r15 + r8 - 32]
	vmovdqu	ymm15, ymmword ptr [r15 + r8]
	vmovdqu	ymmword ptr [r12 + r8 + 576], ymm2
	vmovdqu	ymmword ptr [r12 + r8 + 608], ymm7
	vmovdqu	ymmword ptr [r12 + r8 + 640], ymm8
	vmovdqu	ymmword ptr [r12 + r8 + 672], ymm15
	sub	r8, -128
	cmp	r14, r8
	jne	282b
	cmp	rcx, r14
	mov	r15, qword ptr [rsp + 48]
	mov	r8, r15
	je	332f
	test	cl, 112
	je	312f
292:
	mov	r8, rcx
	and	r8, -16
	lea	rsi, [rdx + r8]
	.p2align	4
302:
	vmovdqu	xmm2, xmmword ptr [rdi + r14]
	vmovdqu	xmmword ptr [r15 + r14], xmm2
	add	r14, 16
	cmp	r8, r14
	jne	302b
	cmp	rcx, r8
	mov	r8, r15
	je	332f
312:
	mov	rcx, r15
	sub	rcx, rdx
	.p2align	4
322:
	movzx	edx, byte ptr [rax + rsi]
	mov	byte ptr [rcx + rsi], dl
	inc	rsi
	cmp	r9, rsi
	jne	322b
	mov	r8, r15
332:
	vmovdqu	ymm2, ymmword ptr [r8]
	vmovdqu	ymm7, ymmword ptr [r8 + 32]
	vpermq	ymm8, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm15, ymm8, ymm14
	vpshufb	ymm9, ymm2, ymm14
	vpbroadcastb	ymm12, byte ptr [rip + 1042f]
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
	vpbroadcastb	ymm7, byte ptr [rip + 1052f]
	vpand	ymm0, ymm0, ymm7
	vpcmpeqb	ymm0, ymm0, ymm7
	vpblendvb	ymm0, ymm2, ymm4, ymm0
	vpand	ymm2, ymm14, ymm7
	vpcmpeqb	ymm2, ymm2, ymm7
	vpblendvb	ymm2, ymm9, ymm3, ymm2
	vpsrlvd	ymm0, ymm0, ymm10
	vmovdqu	ymm3, ymmword ptr [rsp + 512]
	vpandn	ymm0, ymm3, ymm0
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 224]
	vpsrlvd	ymm2, ymm2, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 288]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 192]
	vpor	ymm3, ymm2, ymmword ptr [rip + 1062f]
	vpcmpeqd	ymm2, ymm2, ymm6
	vpandn	ymm2, ymm2, ymm3
	vpor	ymm3, ymm0, ymmword ptr [rip + 1072f]
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
	vmovdqu	ymm2, ymmword ptr [rsp + 96]
	vextracti128	xmm2, ymm2, 1
	vpextrd	ecx, xmm2, 3
	mov	rdx, qword ptr [rsp + 16]
	vmovups	ymmword ptr [rdx + 384], ymm1
	vmovups	ymmword ptr [rdx + 416], ymm0
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm1, ymm0, 170
	mov	rdx, qword ptr [rsp + 8]
	add	rdx, rcx
	cmp	qword ptr [rsp + 160], 49
	jb	342f
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
	vmovdqu	ymmword ptr [rsp + 192], ymm0
	vpsllvd	ymm0, ymm4, ymm7
	vmovdqu	ymmword ptr [rsp + 96], ymm0
	vpsllvd	ymm9, ymm10, ymm6
	vpsllvd	ymm0, ymm10, ymm7
	vmovdqu	ymmword ptr [rsp + 224], ymm0
	vpaddd	ymm0, ymm2, ymm7
	vmovdqu	ymmword ptr [rsp + 160], ymm0
	mov	ecx, edx
	and	ecx, 7
	vmovd	xmm7, ecx
	vpbroadcastd	ymm7, xmm7
	vpaddd	ymm8, ymm7, ymm5
	vpaddd	ymm2, ymm7, ymm2
	vpsrld	ymm7, ymm2, 3
	vpsrld	ymm11, ymm8, 3
	vpand	ymm5, ymm12, ymm2
	vpand	ymm10, ymm8, ymm12
	vbroadcasti128	ymm0, xmmword ptr [rip + 1032f]
	vpshufb	ymm2, ymm11, ymm0
	vpshufb	ymm7, ymm7, ymm0
	vmovdqu	ymm0, ymmword ptr [rsp + 352]
	vpaddb	ymm11, ymm7, ymm0
	vpaddb	ymm12, ymm2, ymm0
	mov	qword ptr [rsp + 8], rdx
	shr	rdx, 3
	lea	rcx, [rdx + 64]
	cmp	rcx, r9
	jbe	852f
	mov	rcx, r9
	sub	rcx, rdx
	mov	r8, r15
	jbe	922f
	cmp	rcx, 16
	mov	rsi, rdx
	jb	902f
	lea	rdi, [rdx + rax]
	mov	rsi, qword ptr [rsp + 16]
	sub	rsi, rdi
	add	rsi, 575
	cmp	rsi, 127
	mov	rsi, rdx
	jb	902f
	cmp	rcx, 128
	jae	862f
	xor	r14d, r14d
	jmp	882f
	.p2align	4
342:
	mov	r12, rbp
352:
	mov	rbp, qword ptr [rsp + 32]
	mov	r14, qword ptr [rsp + 24]
	shr	r10, 56
	add	r10, rbx
	shr	r11, 56
	add	r11, r13
	vmovd	eax, xmm1
	mov	rcx, qword ptr [rsp + 16]
	mov	qword ptr [rcx + 72], rdx
	mov	qword ptr [rcx + 96], rax
	mov	qword ptr [rcx + 128], r11
	mov	qword ptr [rcx + 136], r10
	mov	r10, rcx
	add	r14, qword ptr [rsp + 264]
	mov	rax, qword ptr [rsp + 64]
	and	rax, 124
	je	732f
	xor	r8d, r8d
	mov	r13, qword ptr [rsp + 80]
	mov	qword ptr [rsp + 24], r14
	.p2align	4
362:
	movzx	esi, byte ptr [r14 + r8]
	movzx	r11d, byte ptr [r10 + r8 + 192]
	cmp	r11, 33
	mov	edx, dword ptr [r10 + 4*r8 + 256]
	vmovdqu	ymm0, ymmword ptr [r12 + r13]
	mov	r15, qword ptr [rsp + 40]
	vmovdqu	ymmword ptr [r15 + rbp], ymm0
	jae	492f
372:
	lea	r9, [r11 + rbp]
	mov	edi, esi
	shr	edi, 2
	cmp	edx, edi
	jb	572f
	mov	rcx, r9
	sub	rcx, rdx
	jb	572f
382:
	vmovdqu	ymm0, ymmword ptr [r15 + rcx]
	vmovdqu	ymmword ptr [r15 + r9], ymm0
	cmp	sil, -124
	jae	582f
392:
	lea	rcx, [r8 + 1]
	lea	rbx, [r11 + r13]
	add	r9, rdi
	movzx	esi, byte ptr [r14 + rcx]
	movzx	r14d, byte ptr [r10 + rcx + 192]
	cmp	r14, 33
	mov	edx, dword ptr [r10 + 4*rcx + 256]
	vmovdqu	ymm0, ymmword ptr [r12 + rbx]
	vmovdqu	ymmword ptr [r15 + r9], ymm0
	mov	qword ptr [rsp + 32], rbp
	mov	qword ptr [rsp + 8], rdi
	jae	512f
402:
	mov	qword ptr [rsp + 80], r13
	add	r9, r14
	mov	r13d, esi
	shr	r13d, 2
	cmp	edx, r13d
	jb	612f
	mov	rcx, r9
	sub	rcx, rdx
	jb	612f
412:
	vmovdqu	ymm0, ymmword ptr [r15 + rcx]
	vmovdqu	ymmword ptr [r15 + r9], ymm0
	cmp	sil, -124
	jae	622f
422:
	lea	rcx, [r8 + 2]
	mov	qword ptr [rsp + 160], r14
	add	rbx, r14
	add	r9, r13
	mov	rdx, qword ptr [rsp + 24]
	movzx	edi, byte ptr [rdx + rcx]
	movzx	r14d, byte ptr [r10 + rcx + 192]
	cmp	r14, 33
	mov	esi, dword ptr [r10 + 4*rcx + 256]
	vmovdqu	ymm0, ymmword ptr [r12 + rbx]
	vmovdqu	ymmword ptr [r15 + r9], ymm0
	jae	532f
432:
	add	r9, r14
	mov	edx, edi
	shr	edx, 2
	cmp	esi, edx
	mov	qword ptr [rsp + 96], r11
	jb	652f
	mov	rcx, r9
	sub	rcx, rsi
	jb	652f
442:
	vmovdqu	ymm0, ymmword ptr [r15 + rcx]
	vmovdqu	ymmword ptr [r15 + r9], ymm0
	cmp	dil, -124
	jae	662f
452:
	lea	rcx, [r8 + 3]
	add	rbx, r14
	add	r9, rdx
	mov	rsi, qword ptr [rsp + 24]
	movzx	edi, byte ptr [rsi + rcx]
	movzx	esi, byte ptr [r10 + rcx + 192]
	cmp	rsi, 33
	mov	r11, r10
	mov	r10d, dword ptr [r10 + 4*rcx + 256]
	vmovdqu	ymm0, ymmword ptr [r12 + rbx]
	vmovdqu	ymmword ptr [r15 + r9], ymm0
	jae	552f
462:
	add	r9, rsi
	mov	r15d, edi
	shr	r15d, 2
	cmp	r10d, r15d
	jb	692f
	mov	rcx, r9
	sub	rcx, r10
	jb	692f
472:
	mov	rbp, qword ptr [rsp + 40]
	vmovdqu	ymm0, ymmword ptr [rbp + rcx]
	vmovdqu	ymmword ptr [rbp + r9], ymm0
	cmp	dil, -124
	mov	r12, qword ptr [rsp + 72]
	jae	702f
482:
	add	rsi, rbx
	add	r15, r9
	add	r8, 4
	cmp	r8, rax
	mov	r13, rsi
	mov	rbp, r15
	mov	r10, r11
	mov	r14, qword ptr [rsp + 24]
	jb	362b
	jmp	742f
492:
	lea	rcx, [r12 + r13]
	lea	rdi, [r15 + rbp]
	mov	r9, qword ptr [r10 + 48]
	mov	r11, qword ptr [r10 + 120]
	movzx	r9d, byte ptr [r9 + r11]
	inc	r11
	mov	qword ptr [r10 + 120], r11
	mov	r11, r9
	add	r11, 33
	mov	r9d, 32
	.p2align	4
502:
	vmovdqu	ymm0, ymmword ptr [rcx + r9]
	vmovdqu	ymmword ptr [rdi + r9], ymm0
	add	r9, 32
	cmp	r9, r11
	jb	502b
	jmp	372b
512:
	lea	rcx, [r12 + rbx]
	mov	rdi, qword ptr [r10 + 48]
	mov	rbp, qword ptr [r10 + 120]
	movzx	r14d, byte ptr [rdi + rbp]
	inc	rbp
	mov	qword ptr [r10 + 120], rbp
	add	r14, 33
	lea	rdi, [r15 + r9]
	mov	ebp, 32
	.p2align	4
522:
	vmovdqu	ymm0, ymmword ptr [rcx + rbp]
	vmovdqu	ymmword ptr [rdi + rbp], ymm0
	add	rbp, 32
	cmp	rbp, r14
	jb	522b
	mov	rdi, qword ptr [rsp + 8]
	jmp	402b
532:
	mov	rcx, qword ptr [r10 + 48]
	mov	rdx, qword ptr [r10 + 120]
	movzx	r14d, byte ptr [rcx + rdx]
	inc	rdx
	mov	qword ptr [r10 + 120], rdx
	add	r14, 33
	mov	rcx, qword ptr [rsp + 8]
	lea	rdx, [rcx + r11]
	mov	rcx, qword ptr [rsp + 160]
	add	rcx, r13
	add	rcx, rdx
	add	rcx, qword ptr [rsp + 32]
	add	rcx, r15
	lea	rdx, [r12 + rbx]
	mov	r15d, 32
	.p2align	4
542:
	vmovdqu	ymm0, ymmword ptr [rdx + r15]
	vmovdqu	ymmword ptr [rcx + r15], ymm0
	add	r15, 32
	cmp	r15, r14
	jb	542b
	mov	r15, qword ptr [rsp + 40]
	jmp	432b
552:
	mov	rsi, qword ptr [r11 + 48]
	mov	r15, qword ptr [r11 + 120]
	movzx	esi, byte ptr [rsi + r15]
	inc	r15
	mov	qword ptr [r11 + 120], r15
	add	rsi, 33
	mov	rcx, qword ptr [rsp + 96]
	mov	r15, qword ptr [rsp + 8]
	lea	rbp, [r15 + rcx]
	lea	r15, [rdx + r14]
	add	r15, rbp
	mov	rbp, qword ptr [rsp + 160]
	lea	r12, [r13 + rbp]
	add	r12, qword ptr [rsp + 32]
	add	r12, r15
	add	r12, qword ptr [rsp + 40]
	lea	r15, [rbp + rcx]
	mov	rcx, qword ptr [rsp + 80]
	add	rcx, r14
	add	rcx, r15
	add	rcx, qword ptr [rsp + 72]
	mov	r15d, 32
	.p2align	4
562:
	vmovdqu	ymm0, ymmword ptr [rcx + r15]
	vmovdqu	ymmword ptr [r12 + r15], ymm0
	add	r15, 32
	cmp	r15, rsi
	jb	562b
	jmp	462b
572:
	cmp	rdx, r9
	cmovae	rdx, r9
	mov	rcx, r9
	sub	rcx, rdx
	cmp	rdx, rdi
	jae	382b
	mov	qword ptr [rsp + 8], rdi
	mov	rdi, qword ptr [r10 + 56]
	mov	rbx, rdx
	shl	rbx, 5
	vmovdqu	ymm0, ymmword ptr [rdi + rbx + 2048]
	mov	rdi, qword ptr [rsp + 8]
	vmovdqu	ymm1, ymmword ptr [r15 + rcx]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	vmovdqu	ymmword ptr [r15 + r9], ymm0
	cmp	sil, -124
	jb	392b
582:
	cmp	rdx, 31
	ja	592f
	mov	qword ptr [r10 + 104], 1
592:
	lea	rdx, [r15 + r9]
	mov	rsi, qword ptr [r10 + 48]
	mov	rdi, qword ptr [r10 + 120]
	movzx	esi, byte ptr [rsi + rdi]
	inc	rdi
	mov	qword ptr [r10 + 120], rdi
	mov	rdi, rsi
	add	rdi, 33
	add	rcx, r15
	mov	esi, 32
	.p2align	4
602:
	vmovdqu	ymm0, ymmword ptr [rcx + rsi]
	vmovdqu	ymmword ptr [rdx + rsi], ymm0
	add	rsi, 32
	cmp	rsi, rdi
	jb	602b
	jmp	392b
612:
	cmp	rdx, r9
	cmovae	rdx, r9
	mov	rcx, r9
	sub	rcx, rdx
	cmp	rdx, r13
	jae	412b
	mov	rdi, qword ptr [r10 + 56]
	mov	rbp, r14
	mov	r14, rdx
	shl	r14, 5
	vmovdqu	ymm0, ymmword ptr [rdi + r14 + 2048]
	mov	r14, rbp
	mov	rdi, qword ptr [rsp + 8]
	vmovdqu	ymm1, ymmword ptr [r15 + rcx]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	vmovdqu	ymmword ptr [r15 + r9], ymm0
	cmp	sil, -124
	jb	422b
622:
	cmp	rdx, 31
	ja	632f
	mov	qword ptr [r10 + 104], 1
632:
	mov	rdx, qword ptr [r10 + 48]
	mov	rsi, qword ptr [r10 + 120]
	movzx	r13d, byte ptr [rdx + rsi]
	inc	rsi
	mov	qword ptr [r10 + 120], rsi
	add	r13, 33
	add	rcx, r15
	mov	rdx, qword ptr [rsp + 32]
	lea	rdx, [r14 + rdx]
	add	rdx, rdi
	add	rdx, r11
	add	rdx, r15
	mov	esi, 32
	.p2align	4
642:
	vmovdqu	ymm0, ymmword ptr [rcx + rsi]
	vmovdqu	ymmword ptr [rdx + rsi], ymm0
	add	rsi, 32
	cmp	rsi, r13
	jb	642b
	jmp	422b
652:
	cmp	rsi, r9
	cmovae	rsi, r9
	mov	rcx, r9
	sub	rcx, rsi
	cmp	rsi, rdx
	jae	442b
	mov	r15, qword ptr [r10 + 56]
	mov	rbp, rsi
	shl	rbp, 5
	vmovdqu	ymm0, ymmword ptr [r15 + rbp + 2048]
	mov	r12, qword ptr [rsp + 72]
	mov	r15, qword ptr [rsp + 40]
	vmovdqu	ymm1, ymmword ptr [r15 + rcx]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	vmovdqu	ymmword ptr [r15 + r9], ymm0
	cmp	dil, -124
	jb	452b
662:
	cmp	rsi, 31
	ja	672f
	mov	qword ptr [r10 + 104], 1
672:
	mov	rdx, qword ptr [r10 + 48]
	mov	rsi, qword ptr [r10 + 120]
	movzx	edx, byte ptr [rdx + rsi]
	inc	rsi
	mov	qword ptr [r10 + 120], rsi
	add	rdx, 33
	add	rcx, r15
	mov	rsi, qword ptr [rsp + 96]
	mov	rdi, qword ptr [rsp + 8]
	add	rdi, rsi
	lea	rsi, [r14 + r13]
	add	rsi, rdi
	mov	rdi, qword ptr [rsp + 32]
	mov	r11, qword ptr [rsp + 160]
	add	rdi, r11
	add	rsi, rdi
	add	rsi, r15
	mov	edi, 32
	.p2align	4
682:
	vmovdqu	ymm0, ymmword ptr [rcx + rdi]
	vmovdqu	ymmword ptr [rsi + rdi], ymm0
	add	rdi, 32
	cmp	rdi, rdx
	jb	682b
	jmp	452b
692:
	cmp	r10, r9
	cmovae	r10, r9
	mov	rcx, r9
	sub	rcx, r10
	cmp	r10, r15
	jae	472b
	mov	r11, qword ptr [r11 + 56]
	mov	rbp, r10
	shl	rbp, 5
	vmovdqu	ymm0, ymmword ptr [r11 + rbp + 2048]
	mov	r11, qword ptr [rsp + 16]
	mov	rbp, qword ptr [rsp + 40]
	vmovdqu	ymm1, ymmword ptr [rbp + rcx]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	vmovdqu	ymmword ptr [rbp + r9], ymm0
	cmp	dil, -124
	mov	r12, qword ptr [rsp + 72]
	jb	482b
702:
	cmp	r10, 31
	mov	rdi, r11
	ja	712f
	mov	qword ptr [rdi + 104], 1
712:
	mov	r15, qword ptr [rdi + 48]
	mov	r10, qword ptr [rdi + 120]
	movzx	r15d, byte ptr [r15 + r10]
	inc	r10
	mov	qword ptr [rdi + 120], r10
	add	r15, 33
	mov	rdi, qword ptr [rsp + 40]
	add	rcx, rdi
	mov	r10, qword ptr [rsp + 8]
	add	r10, qword ptr [rsp + 96]
	add	rdx, rsi
	add	rdx, r10
	add	r14, r13
	add	r14, qword ptr [rsp + 160]
	add	r14, rdx
	add	r14, qword ptr [rsp + 32]
	add	r14, rdi
	mov	edx, 32
	.p2align	4
722:
	vmovdqu	ymm0, ymmword ptr [rcx + rdx]
	vmovdqu	ymmword ptr [r14 + rdx], ymm0
	add	rdx, 32
	cmp	rdx, r15
	jb	722b
	jmp	482b
	.p2align	4
732:
	mov	r15, rbp
	mov	rsi, qword ptr [rsp + 80]
742:
	mov	rbx, r14
	mov	r14, qword ptr [rsp + 64]
	cmp	rax, r14
	mov	r13, rsi
	mov	r11, qword ptr [rsp + 40]
	mov	r9, qword ptr [rsp + 48]
	mov	rbp, r12
	je	2b
	.p2align	4
752:
	movzx	edi, byte ptr [rbx + rax]
	movzx	edx, byte ptr [r10 + rax + 192]
	cmp	rdx, 33
	mov	esi, dword ptr [r10 + 4*rax + 256]
	vmovdqu	ymm0, ymmword ptr [rbp + r13]
	vmovdqu	ymmword ptr [r11 + r15], ymm0
	jae	792f
762:
	add	r15, rdx
	mov	ecx, edi
	shr	ecx, 2
	cmp	esi, ecx
	jb	812f
	mov	r8, r15
	sub	r8, rsi
	jb	812f
772:
	vmovdqu	ymm0, ymmword ptr [r11 + r8]
	vmovdqu	ymmword ptr [r11 + r15], ymm0
	cmp	dil, -124
	jae	822f
782:
	add	r13, rdx
	add	r15, rcx
	inc	rax
	cmp	rax, r14
	jb	752b
	jmp	2b
792:
	mov	r12, r9
	lea	rcx, [rbp + r13]
	lea	r8, [r11 + r15]
	mov	rdx, qword ptr [r10 + 48]
	mov	r9, qword ptr [r10 + 120]
	movzx	edx, byte ptr [rdx + r9]
	inc	r9
	mov	qword ptr [r10 + 120], r9
	add	rdx, 33
	mov	r9d, 32
	.p2align	4
802:
	vmovdqu	ymm0, ymmword ptr [rcx + r9]
	vmovdqu	ymmword ptr [r8 + r9], ymm0
	add	r9, 32
	cmp	r9, rdx
	jb	802b
	mov	r9, r12
	jmp	762b
812:
	cmp	rsi, r15
	cmovae	rsi, r15
	mov	r8, r15
	sub	r8, rsi
	cmp	rsi, rcx
	jae	772b
	mov	r12, r9
	mov	r9, qword ptr [r10 + 56]
	mov	r14, r10
	mov	r10, rsi
	shl	r10, 5
	vmovdqu	ymm0, ymmword ptr [r9 + r10 + 2048]
	mov	r9, r12
	mov	r10, r14
	mov	r14, qword ptr [rsp + 64]
	vmovdqu	ymm1, ymmword ptr [r11 + r8]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	vmovdqu	ymmword ptr [r11 + r15], ymm0
	cmp	dil, -124
	jb	782b
822:
	cmp	rsi, 31
	ja	832f
	mov	qword ptr [r10 + 104], 1
832:
	lea	rsi, [r11 + r15]
	mov	rcx, qword ptr [r10 + 48]
	mov	rdi, qword ptr [r10 + 120]
	movzx	ecx, byte ptr [rcx + rdi]
	inc	rdi
	mov	qword ptr [r10 + 120], rdi
	add	rcx, 33
	add	r8, r11
	mov	edi, 32
	.p2align	4
842:
	vmovdqu	ymm0, ymmword ptr [r8 + rdi]
	vmovdqu	ymmword ptr [rsi + rdi], ymm0
	add	rdi, 32
	cmp	rdi, rcx
	jb	842b
	jmp	782b
852:
	add	rax, rdx
	mov	r8, rax
	jmp	922f
862:
	mov	r14, rcx
	and	r14, -128
	lea	rsi, [rdx + r14]
	lea	r15, [rax + rdx + 96]
	xor	r8d, r8d
	mov	r12, qword ptr [rsp + 16]
	.p2align	4
872:
	vmovdqu	ymm2, ymmword ptr [r15 + r8 - 96]
	vmovdqu	ymm7, ymmword ptr [r15 + r8 - 64]
	vmovdqu	ymm8, ymmword ptr [r15 + r8 - 32]
	vmovdqu	ymm13, ymmword ptr [r15 + r8]
	vmovdqu	ymmword ptr [r12 + r8 + 576], ymm2
	vmovdqu	ymmword ptr [r12 + r8 + 608], ymm7
	vmovdqu	ymmword ptr [r12 + r8 + 640], ymm8
	vmovdqu	ymmword ptr [r12 + r8 + 672], ymm13
	sub	r8, -128
	cmp	r14, r8
	jne	872b
	cmp	rcx, r14
	mov	r15, qword ptr [rsp + 48]
	mov	r8, r15
	je	922f
	test	cl, 112
	je	902f
882:
	mov	r8, rcx
	and	r8, -16
	lea	rsi, [rdx + r8]
	.p2align	4
892:
	vmovdqu	xmm2, xmmword ptr [rdi + r14]
	vmovdqu	xmmword ptr [r15 + r14], xmm2
	add	r14, 16
	cmp	r8, r14
	jne	892b
	cmp	rcx, r8
	mov	r8, r15
	je	922f
902:
	mov	rcx, r15
	sub	rcx, rdx
	.p2align	4
912:
	movzx	edx, byte ptr [rax + rsi]
	mov	byte ptr [rcx + rsi], dl
	inc	rsi
	cmp	r9, rsi
	jne	912b
	mov	r8, r15
922:
	mov	r12, rbp
	vmovdqu	ymm2, ymmword ptr [r8]
	vmovdqu	ymm7, ymmword ptr [r8 + 32]
	vpermq	ymm8, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm13, ymm8, ymm11
	vpshufb	ymm14, ymm2, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 1042f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 1052f]
	vpand	ymm7, ymm12, ymm3
	vpcmpeqb	ymm7, ymm7, ymm3
	vpblendvb	ymm2, ymm2, ymm4, ymm7
	vpand	ymm4, ymm11, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm0, ymm13, ymm0, ymm4
	vpsrlvd	ymm2, ymm2, ymm10
	vpandn	ymm2, ymm9, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 192]
	vpsrlvd	ymm0, ymm0, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 224]
	vpandn	ymm0, ymm3, ymm0
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 96]
	vpor	ymm3, ymm0, ymmword ptr [rip + 1062f]
	vpcmpeqd	ymm0, ymm0, ymm6
	vpandn	ymm0, ymm0, ymm3
	vpor	ymm3, ymm2, ymmword ptr [rip + 1072f]
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
	vmovdqu	ymm2, ymmword ptr [rsp + 160]
	vextracti128	xmm2, ymm2, 1
	vpextrd	eax, xmm2, 3
	mov	rcx, qword ptr [rsp + 16]
	vmovups	ymmword ptr [rcx + 448], ymm1
	vmovups	ymmword ptr [rcx + 480], ymm0
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm1, ymm0, 170
	mov	rdx, qword ptr [rsp + 8]
	add	rdx, rax
	jmp	352b
932:
	mov	qword ptr [r10 + 80], r15
	mov	qword ptr [r10 + 88], r13
	add	rsp, 616
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	vzeroupper
	ret
	.p2align	2, 0x0
942:
	.long	1
	.p2align	2, 0x0
952:
	.long	7
	.p2align	2, 0x0
962:
	.long	8
	.p2align	2, 0x0
972:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	2, 0x0
982:
	.long	134217727
	.p2align	5, 0x0
992:
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
1002:
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
1012:
	.byte	1
	.p2align	5, 0x0
1022:
	.zero	32,31
	.p2align	4, 0x0
1032:
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
1042:
	.byte	16
	.p2align	2, 0x0
1052:
	.byte	32
	.p2align	5, 0x0
1062:
	.long	1207959552
	.long	1342177280
	.long	1476395008
	.long	1610612736
	.long	1744830464
	.long	1879048192
	.long	2013265920
	.long	2147483648
	.p2align	5, 0x0
1072:
	.long	134217728
	.long	268435456
	.long	402653184
	.long	536870912
	.long	671088640
	.long	805306368
	.long	939524096
	.long	1073741824
	.p2align	5, 0x0
1082:
	.zero	32,1

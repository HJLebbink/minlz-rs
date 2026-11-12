# minlz_exec_flat of crates/minlz/mlir/exec64.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 680
	mov	rax, qword ptr [rdi + 64]
	mov	r12, qword ptr [rdi + 80]
	mov	r14, qword ptr [rdi + 88]
	test	rax, rax
	jle	792f
	mov	r10, qword ptr [rdi]
	mov	rcx, qword ptr [rdi + 8]
	mov	qword ptr [rsp + 40], rcx
	mov	rcx, qword ptr [rdi + 16]
	mov	qword ptr [rsp + 256], rcx
	lea	r8, [rdi + 512]
	lea	rdx, [rdi + 576]
	mov	qword ptr [rsp + 128], rdx
	mov	edx, 96
	mov	qword ptr [rsp + 136], rdx
	mov	r11d, 7
	vbroadcastss	ymm0, dword ptr [rip + 802f]
	vmovups	ymmword ptr [rsp + 480], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 812f]
	vmovups	ymmword ptr [rsp + 448], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 822f]
	vmovups	ymmword ptr [rsp + 416], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 832f]
	vmovups	ymmword ptr [rsp + 384], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 842f]
	vmovups	ymmword ptr [rsp + 352], ymm0
	mov	qword ptr [rsp + 248], r8
	xor	ecx, ecx
	xor	edx, edx
	mov	qword ptr [rsp + 8], rdi
	mov	qword ptr [rsp + 264], rax
	mov	qword ptr [rsp + 56], r10
	jmp	12f
	.p2align	4
2:
	mov	rcx, qword ptr [rsp + 280]
	inc	rcx
	add	qword ptr [rsp + 136], 64
	add	r11, -64
	mov	r8, qword ptr [rsp + 64]
	add	r8, -64
	mov	rax, qword ptr [rsp + 264]
	mov	rdx, qword ptr [rsp + 272]
	cmp	rdx, rax
	jge	792f
12:
	mov	qword ptr [rsp + 72], r14
	mov	qword ptr [rsp + 32], r12
	mov	r12, rdx
	mov	rdx, rax
	sub	rdx, r12
	cmp	rdx, 64
	mov	eax, 64
	mov	qword ptr [rsp + 96], rdx
	cmovb	rax, rdx
	mov	qword ptr [rsp + 88], rax
	mov	rsi, qword ptr [rdi + 16]
	mov	rbx, qword ptr [rdi + 24]
	mov	r15, qword ptr [rdi + 32]
	mov	rax, qword ptr [rdi + 40]
	mov	qword ptr [rsp + 16], rax
	mov	r14, qword ptr [rdi + 64]
	mov	rax, qword ptr [rdi + 72]
	mov	qword ptr [rsp + 48], rax
	mov	r13, qword ptr [rdi + 96]
	mov	r9, qword ptr [rdi + 112]
	mov	rdx, qword ptr [rdi + 128]
	mov	rax, qword ptr [rdi + 136]
	mov	qword ptr [rsp + 176], rax
	lea	r10, [r14 + 7]
	lea	rax, [r12 + 64]
	mov	qword ptr [rsp + 272], rax
	cmp	rax, r10
	mov	qword ptr [rsp + 80], r11
	mov	qword ptr [rsp + 64], r8
	mov	qword ptr [rsp + 24], r12
	mov	qword ptr [rsp + 280], rcx
	mov	qword ptr [rsp + 208], r13
	jbe	22f
	cmp	r12, r10
	mov	rdi, qword ptr [rsp + 248]
	mov	rax, rdi
	jge	82f
	mov	rax, rcx
	shl	rax, 6
	mov	r12d, 7
	sub	r12, rax
	add	r12, r14
	cmp	r12, 16
	mov	r13, qword ptr [rsp + 24]
	jb	72f
	add	rax, rsi
	mov	r8, qword ptr [rsp + 8]
	sub	r8, rax
	add	r8, 511
	cmp	r8, 127
	mov	r8, qword ptr [rsp + 64]
	mov	r13, qword ptr [rsp + 24]
	jb	72f
	cmp	r12, 128
	jae	32f
	xor	ebp, ebp
	jmp	52f
	.p2align	4
22:
	add	rsi, r12
	mov	rax, rsi
	jmp	82f
32:
	mov	rbp, r12
	and	rbp, -128
	mov	rax, qword ptr [rsp + 24]
	lea	r13, [rax + rbp]
	mov	rax, qword ptr [rsp + 136]
	lea	r8, [rsi + rax]
	add	r11, r14
	and	r11, -128
	xor	eax, eax
	mov	rcx, qword ptr [rsp + 8]
	.p2align	4
42:
	vmovups	ymm0, ymmword ptr [r8 + rax - 96]
	vmovdqu	ymm1, ymmword ptr [r8 + rax - 64]
	vmovdqu	ymm3, ymmword ptr [r8 + rax - 32]
	vmovups	ymm4, ymmword ptr [r8 + rax]
	vmovups	ymmword ptr [rcx + rax + 512], ymm0
	vmovdqu	ymmword ptr [rcx + rax + 544], ymm1
	vmovdqu	ymmword ptr [rcx + rax + 576], ymm3
	vmovups	ymmword ptr [rcx + rax + 608], ymm4
	sub	rax, -128
	cmp	r11, rax
	jne	42b
	cmp	r12, rbp
	mov	rax, rdi
	mov	r11, qword ptr [rsp + 80]
	mov	r8, qword ptr [rsp + 64]
	je	82f
	test	r12b, 112
	je	72f
52:
	mov	r8, r12
	and	r8, -16
	mov	rax, qword ptr [rsp + 24]
	lea	r13, [rax + r8]
	add	rax, rsi
	add	r14, r11
	and	r14, -16
	.p2align	4
62:
	vmovups	xmm0, xmmword ptr [rax + rbp]
	vmovups	xmmword ptr [rdi + rbp], xmm0
	add	rbp, 16
	cmp	r14, rbp
	jne	62b
	cmp	r12, r8
	mov	rax, rdi
	mov	r8, qword ptr [rsp + 64]
	je	82f
	.p2align	4
72:
	movzx	eax, byte ptr [rsi + r13]
	mov	byte ptr [r8 + r13], al
	inc	r13
	cmp	r10, r13
	jne	72b
	mov	rax, rdi
82:
	vmovdqu	ymm7, ymmword ptr [rax]
	vmovdqu	ymm6, ymmword ptr [rax + 32]
	vmovd	xmm0, dword ptr [rsp + 88]
	vpbroadcastb	ymm1, xmm0
	vpmaxub	ymm0, ymm1, ymmword ptr [rip + 852f]
	vpcmpeqb	ymm0, ymm1, ymm0
	vpmaxub	ymm3, ymm1, ymmword ptr [rip + 862f]
	vpcmpeqb	ymm3, ymm1, ymm3
	vpsllw	ymm1, ymm7, 6
	vpxor	xmm2, xmm2, xmm2
	vpcmpgtb	ymm1, ymm2, ymm1
	vpsllw	ymm5, ymm6, 6
	vpcmpgtb	ymm9, ymm2, ymm5
	vpbroadcastb	ymm4, byte ptr [rip + 872f]
	vmovdqu	ymmword ptr [rsp + 144], ymm7
	vpand	ymm5, ymm7, ymm4
	vmovdqu	ymmword ptr [rsp + 576], ymm6
	vpand	ymm6, ymm6, ymm4
	vpcmpeqb	ymm6, ymm6, ymm2
	vpcmpeqb	ymm5, ymm5, ymm2
	movabs	rdi, 72340172838076673
	mov	rsi, rdi
	#APP
	#NO_APP
	vpand	ymm1, ymm1, ymm4
	vpand	ymm7, ymm0, ymm1
	vpand	ymm1, ymm9, ymm4
	vpand	ymm1, ymm3, ymm1
	mov	rcx, qword ptr [rsp + 8]
	vmovdqu	ymmword ptr [rcx + 544], ymm1
	vmovdqu	ymmword ptr [rcx + 512], ymm7
	vmovq	rax, xmm7
	mov	r10, rax
	imul	r10, rsi
	mov	r8, r10
	sub	r8, rax
	xor	rax, rsi
	shl	rax, 7
	or	rax, r8
	vmovq	xmm9, qword ptr [rbx + rdx]
	vmovq	xmm10, rax
	vpshufb	xmm9, xmm9, xmm10
	shr	r10, 56
	add	r10, rdx
	vmovq	qword ptr [rcx + 512], xmm9
	vpextrq	rax, xmm7, 1
	mov	rdx, rax
	imul	rdx, rsi
	mov	r8, rdx
	sub	r8, rax
	xor	rax, rsi
	shl	rax, 7
	or	rax, r8
	vmovq	xmm9, qword ptr [rbx + r10]
	vmovq	xmm10, rax
	vpshufb	xmm9, xmm9, xmm10
	shr	rdx, 56
	add	rdx, r10
	vmovq	qword ptr [rcx + 520], xmm9
	vextracti128	xmm7, ymm7, 1
	vmovq	rax, xmm7
	mov	r10, rax
	imul	r10, rsi
	mov	r8, r10
	sub	r8, rax
	xor	rax, rsi
	shl	rax, 7
	or	rax, r8
	vmovq	xmm9, qword ptr [rbx + rdx]
	vmovq	xmm10, rax
	vpshufb	xmm9, xmm9, xmm10
	shr	r10, 56
	add	r10, rdx
	vmovq	qword ptr [rcx + 528], xmm9
	vpextrq	rax, xmm7, 1
	mov	rdx, rax
	imul	rdx, rsi
	mov	r8, rdx
	sub	r8, rax
	xor	rax, rsi
	shl	rax, 7
	or	rax, r8
	vmovq	xmm7, qword ptr [rbx + r10]
	vmovq	xmm9, rax
	vpshufb	xmm7, xmm7, xmm9
	shr	rdx, 56
	add	rdx, r10
	vmovq	qword ptr [rcx + 536], xmm7
	vmovq	rax, xmm1
	mov	r10, rax
	imul	r10, rsi
	mov	r8, r10
	sub	r8, rax
	xor	rax, rsi
	shl	rax, 7
	or	rax, r8
	vmovq	xmm7, qword ptr [rbx + rdx]
	vmovq	xmm9, rax
	vpshufb	xmm7, xmm7, xmm9
	shr	r10, 56
	add	r10, rdx
	vmovq	qword ptr [rcx + 544], xmm7
	vpextrq	rax, xmm1, 1
	mov	rdx, rax
	imul	rdx, rsi
	mov	r8, rdx
	sub	r8, rax
	xor	rax, rsi
	shl	rax, 7
	or	rax, r8
	vmovq	xmm1, qword ptr [rbx + r10]
	vmovq	xmm7, rax
	vpshufb	xmm1, xmm1, xmm7
	shr	rdx, 56
	add	rdx, r10
	vmovq	qword ptr [rcx + 552], xmm1
	mov	rax, qword ptr [rcx + 560]
	mov	r8, qword ptr [rcx + 568]
	mov	r13, rax
	imul	r13, rsi
	mov	r10, r13
	sub	r10, rax
	xor	rax, rsi
	shl	rax, 7
	or	rax, r10
	vmovq	xmm1, qword ptr [rbx + rdx]
	vmovq	xmm7, rax
	vpshufb	xmm1, xmm1, xmm7
	shr	r13, 56
	add	r13, rdx
	vmovq	qword ptr [rcx + 560], xmm1
	mov	r10, r8
	imul	r10, rsi
	mov	rax, r10
	sub	rax, r8
	xor	rsi, r8
	shl	rsi, 7
	or	rsi, rax
	vmovq	xmm1, qword ptr [rbx + r13]
	vmovq	xmm7, rsi
	vpshufb	xmm1, xmm1, xmm7
	vmovq	qword ptr [rcx + 568], xmm1
	vmovups	ymm1, ymmword ptr [rcx + 544]
	vmovups	ymm7, ymmword ptr [rcx + 512]
	vmovups	ymmword ptr [rcx + 192], ymm7
	vmovups	ymmword ptr [rcx + 224], ymm1
	mov	rdx, rdi
	#APP
	#NO_APP
	vpand	ymm1, ymm6, ymm4
	vpand	ymm1, ymm3, ymm1
	vpand	ymm3, ymm5, ymm4
	vpand	ymm0, ymm0, ymm3
	vmovdqu	ymmword ptr [rcx + 512], ymm0
	vmovdqu	ymmword ptr [rcx + 544], ymm1
	vmovq	rax, xmm0
	mov	rbx, rdx
	imul	rbx, rax
	mov	rsi, rbx
	sub	rsi, rax
	xor	rax, rdx
	shl	rax, 7
	or	rax, rsi
	mov	rsi, qword ptr [rsp + 176]
	vmovq	xmm3, qword ptr [r15 + rsi]
	vmovq	xmm5, rax
	vpshufb	xmm3, xmm3, xmm5
	shr	rbx, 56
	add	rbx, rsi
	vmovq	qword ptr [rcx + 512], xmm3
	vpextrq	rax, xmm0, 1
	mov	rsi, rdx
	imul	rsi, rax
	mov	r8, rsi
	sub	r8, rax
	xor	rax, rdx
	shl	rax, 7
	or	rax, r8
	vmovq	xmm3, qword ptr [r15 + rbx]
	vmovq	xmm5, rax
	vpshufb	xmm3, xmm3, xmm5
	shr	rsi, 56
	add	rsi, rbx
	vmovq	qword ptr [rcx + 520], xmm3
	vextracti128	xmm0, ymm0, 1
	vmovq	rax, xmm0
	mov	r11, rdx
	imul	r11, rax
	mov	r8, r11
	sub	r8, rax
	xor	rax, rdx
	shl	rax, 7
	or	rax, r8
	vmovq	xmm3, qword ptr [r15 + rsi]
	vmovq	xmm5, rax
	vpshufb	xmm3, xmm3, xmm5
	shr	r11, 56
	add	r11, rsi
	vmovq	qword ptr [rcx + 528], xmm3
	vpextrq	rax, xmm0, 1
	mov	rsi, rdx
	imul	rsi, rax
	mov	r8, rsi
	sub	r8, rax
	xor	rax, rdx
	shl	rax, 7
	or	rax, r8
	vmovq	xmm0, qword ptr [r15 + r11]
	vmovq	xmm3, rax
	vpshufb	xmm0, xmm0, xmm3
	shr	rsi, 56
	add	rsi, r11
	vmovq	qword ptr [rcx + 536], xmm0
	vmovq	rax, xmm1
	mov	r11, rdx
	imul	r11, rax
	mov	r8, r11
	sub	r8, rax
	xor	rax, rdx
	shl	rax, 7
	or	rax, r8
	vmovq	xmm0, qword ptr [r15 + rsi]
	vmovq	xmm3, rax
	vpshufb	xmm0, xmm0, xmm3
	shr	r11, 56
	add	r11, rsi
	vmovq	qword ptr [rcx + 544], xmm0
	vpextrq	rax, xmm1, 1
	mov	rsi, rdx
	imul	rsi, rax
	mov	r8, rsi
	sub	r8, rax
	xor	rax, rdx
	shl	rax, 7
	or	rax, r8
	vmovq	xmm0, qword ptr [r15 + r11]
	vmovq	xmm1, rax
	vpshufb	xmm0, xmm0, xmm1
	shr	rsi, 56
	add	rsi, r11
	vmovq	qword ptr [rcx + 552], xmm0
	mov	rax, qword ptr [rcx + 560]
	mov	r8, qword ptr [rcx + 568]
	mov	rbx, rax
	imul	rbx, rdx
	mov	r11, rbx
	sub	r11, rax
	xor	rax, rdx
	shl	rax, 7
	or	rax, r11
	vmovq	xmm0, qword ptr [r15 + rsi]
	vmovq	xmm1, rax
	vpshufb	xmm0, xmm0, xmm1
	shr	rbx, 56
	add	rbx, rsi
	vmovq	qword ptr [rcx + 560], xmm0
	mov	r11, r8
	imul	r11, rdx
	mov	rax, r11
	sub	rax, r8
	xor	rdx, r8
	shl	rdx, 7
	or	rdx, rax
	vmovq	xmm0, qword ptr [r15 + rbx]
	vmovq	xmm1, rdx
	vpshufb	xmm0, xmm0, xmm1
	vmovq	qword ptr [rcx + 568], xmm0
	vmovdqu	ymm9, ymmword ptr [rcx + 512]
	vmovdqu	ymm1, ymmword ptr [rcx + 512]
	vmovups	ymm0, ymmword ptr [rcx + 544]
	vmovups	ymmword ptr [rsp + 544], ymm0
	vpsrlw	ymm1, ymm1, 3
	vpand	ymm1, ymm1, ymmword ptr [rip + 882f]
	vpsubusb	ymm1, ymm1, ymm4
	vpsllq	ymm3, ymm1, 8
	vpaddb	ymm3, ymm1, ymm3
	vpsllq	ymm5, ymm3, 16
	vpaddb	ymm3, ymm3, ymm5
	vpsllq	ymm5, ymm3, 32
	vpaddb	ymm3, ymm3, ymm5
	vpsubb	ymm11, ymm3, ymm1
	vpsrlq	ymm15, ymm3, 56
	vmovss	xmm1, dword ptr [rsp + 208]
	vbroadcastss	ymm0, xmm1
	vmovups	ymmword ptr [rsp + 320], ymm0
	vpbroadcastd	ymm1, xmm15
	vpmovzxbd	ymm7, xmm11
	vpshufd	xmm3, xmm11, 238
	vpmovzxbd	ymm3, xmm3
	vpaddd	ymm1, ymm1, ymm3
	vpmovzxbd	ymm3, qword ptr [rcx + 520]
	vpmovzxbd	ymm5, qword ptr [rcx + 512]
	vpsrld	ymm6, ymm5, 3
	vpsrld	ymm10, ymm3, 3
	vmovdqu	ymm0, ymmword ptr [rsp + 480]
	vpmaxud	ymm10, ymm10, ymm0
	vpcmpeqd	ymm2, ymm2, ymm2
	vpaddd	ymm12, ymm10, ymm2
	vpmaxud	ymm6, ymm6, ymm0
	vpaddd	ymm10, ymm6, ymm2
	vmovdqu	ymm0, ymmword ptr [rsp + 448]
	vpand	ymm6, ymm5, ymm0
	vpand	ymm13, ymm3, ymm0
	vmovdqu	ymm4, ymmword ptr [rsp + 416]
	vpminud	ymm3, ymm3, ymm4
	vpminud	ymm5, ymm5, ymm4
	vpand	ymm5, ymm5, ymm4
	vpor	ymm5, ymm5, ymm6
	vpand	ymm3, ymm3, ymm4
	vpor	ymm3, ymm13, ymm3
	vpsllvd	ymm13, ymm5, ymm10
	vpsllvd	ymm4, ymm3, ymm12
	vpsllvd	ymm14, ymm2, ymm10
	vpsllvd	ymm5, ymm2, ymm12
	vpaddd	ymm3, ymm12, ymm1
	mov	r8, qword ptr [rsp + 48]
	mov	eax, r8d
	and	eax, 7
	vmovd	xmm12, eax
	vpbroadcastd	ymm12, xmm12
	vpaddd	ymm1, ymm12, ymm1
	vpaddd	ymm7, ymm12, ymm7
	vpsrld	ymm8, ymm1, 3
	vpsrld	ymm2, ymm7, 3
	vpand	ymm12, ymm1, ymm0
	vpand	ymm6, ymm7, ymm0
	vbroadcasti128	ymm0, xmmword ptr [rip + 892f]
	vpshufb	ymm1, ymm8, ymm0
	vpshufb	ymm2, ymm2, ymm0
	vmovdqu	ymm0, ymmword ptr [rsp + 384]
	vpaddb	ymm1, ymm1, ymm0
	vpaddb	ymm7, ymm2, ymm0
	mov	rdx, r8
	shr	rdx, 3
	lea	rax, [rdx + 64]
	cmp	rax, r9
	vmovdqu	ymmword ptr [rsp + 640], ymm9
	vmovdqu	ymmword ptr [rsp + 608], ymm15
	vmovdqu	ymmword ptr [rsp + 208], ymm3
	vmovdqu	ymmword ptr [rsp + 176], ymm4
	vmovdqu	ymmword ptr [rsp + 288], ymm5
	vmovdqu	ymmword ptr [rsp + 512], ymm6
	jbe	92f
	mov	rsi, r9
	sub	rsi, rdx
	mov	rdi, qword ptr [rsp + 128]
	mov	rax, rdi
	mov	rbp, qword ptr [rsp + 24]
	jbe	162f
	cmp	rsi, 16
	mov	r14, rdx
	jb	142f
	mov	rax, qword ptr [rsp + 16]
	lea	r15, [rdx + rax]
	mov	rax, qword ptr [rsp + 8]
	sub	rax, r15
	add	rax, 575
	cmp	rax, 127
	mov	r14, rdx
	jb	142f
	cmp	rsi, 128
	jae	102f
	xor	r12d, r12d
	jmp	122f
	.p2align	4
92:
	add	rdx, qword ptr [rsp + 16]
	mov	rax, rdx
	mov	rdi, qword ptr [rsp + 128]
	mov	rbp, qword ptr [rsp + 24]
	jmp	162f
102:
	mov	r12, rsi
	and	r12, -128
	lea	r14, [rdx + r12]
	mov	rax, qword ptr [rsp + 16]
	lea	r8, [rax + rdx + 96]
	xor	eax, eax
	mov	rcx, qword ptr [rsp + 8]
	.p2align	4
112:
	vmovdqu	ymm2, ymmword ptr [r8 + rax - 96]
	vmovdqu	ymm8, ymmword ptr [r8 + rax - 64]
	vmovdqu	ymm0, ymmword ptr [r8 + rax - 32]
	vmovdqu	ymm4, ymmword ptr [r8 + rax]
	vmovdqu	ymmword ptr [rcx + rax + 576], ymm2
	vmovdqu	ymmword ptr [rcx + rax + 608], ymm8
	vmovdqu	ymmword ptr [rcx + rax + 640], ymm0
	vmovdqu	ymmword ptr [rcx + rax + 672], ymm4
	sub	rax, -128
	cmp	r12, rax
	jne	112b
	cmp	rsi, r12
	mov	rax, rdi
	mov	r8, qword ptr [rsp + 48]
	je	162f
	test	sil, 112
	je	142f
122:
	mov	rax, rsi
	and	rax, -16
	lea	r14, [rdx + rax]
	.p2align	4
132:
	vmovdqu	xmm0, xmmword ptr [r15 + r12]
	vmovdqu	xmmword ptr [rdi + r12], xmm0
	add	r12, 16
	cmp	rax, r12
	jne	132b
	cmp	rsi, rax
	mov	rax, rdi
	je	162f
	.p2align	4
142:
	mov	rax, rdi
	sub	rax, rdx
	mov	rcx, qword ptr [rsp + 16]
	.p2align	4
152:
	movzx	edx, byte ptr [rcx + r14]
	mov	byte ptr [rax + r14], dl
	inc	r14
	cmp	r9, r14
	jne	152b
	mov	rax, rdi
162:
	vmovdqu	ymm0, ymmword ptr [rax]
	vmovdqu	ymm2, ymmword ptr [rax + 32]
	vpermq	ymm4, ymm0, 68
	vpermq	ymm0, ymm0, 238
	vpshufb	ymm8, ymm4, ymm1
	vpshufb	ymm3, ymm0, ymm1
	vpbroadcastb	ymm15, byte ptr [rip + 902f]
	vpand	ymm9, ymm15, ymm1
	vpxor	xmm10, xmm10, xmm10
	vpcmpeqb	ymm9, ymm9, ymm10
	vpblendvb	ymm3, ymm3, ymm8, ymm9
	vpermq	ymm8, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm6, ymm8, ymm1
	vpshufb	ymm5, ymm2, ymm1
	vpblendvb	ymm5, ymm5, ymm6, ymm9
	vpshufb	ymm4, ymm4, ymm7
	vpshufb	ymm0, ymm0, ymm7
	vpand	ymm6, ymm15, ymm7
	vpcmpeqb	ymm6, ymm10, ymm6
	vpblendvb	ymm0, ymm0, ymm4, ymm6
	vpshufb	ymm4, ymm8, ymm7
	vpshufb	ymm2, ymm2, ymm7
	vpblendvb	ymm2, ymm2, ymm4, ymm6
	vpbroadcastb	ymm6, byte ptr [rip + 912f]
	vpand	ymm4, ymm7, ymm6
	vpcmpeqb	ymm4, ymm4, ymm6
	vpblendvb	ymm0, ymm0, ymm2, ymm4
	vpand	ymm1, ymm1, ymm6
	vpcmpeqb	ymm1, ymm1, ymm6
	vpblendvb	ymm1, ymm3, ymm5, ymm1
	vpsrlvd	ymm0, ymm0, ymmword ptr [rsp + 512]
	vpandn	ymm0, ymm14, ymm0
	vpaddd	ymm0, ymm13, ymm0
	vpsrlvd	ymm1, ymm1, ymm12
	vmovdqu	ymm2, ymmword ptr [rsp + 288]
	vpandn	ymm1, ymm2, ymm1
	vpaddd	ymm1, ymm1, ymmword ptr [rsp + 176]
	vpor	ymm2, ymm1, ymmword ptr [rip + 922f]
	vpcmpeqd	ymm1, ymm10, ymm1
	vpandn	ymm1, ymm1, ymm2
	vpor	ymm2, ymm0, ymmword ptr [rip + 932f]
	vpcmpeqd	ymm0, ymm10, ymm0
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
	vpblendd	ymm1, ymm2, ymm10, 192
	vpermq	ymm1, ymm1, 147
	vpmaxud	ymm1, ymm2, ymm1
	vperm2i128	ymm2, ymm1, ymm1, 10
	vpmaxud	ymm2, ymm1, ymm2
	vperm2i128	ymm1, ymm1, ymm0, 33
	vpmaxud	ymm0, ymm0, ymm1
	vpmaxud	ymm0, ymm0, ymm2
	vmovdqu	ymm3, ymmword ptr [rsp + 352]
	vpand	ymm1, ymm0, ymm3
	vpcmpeqd	ymm0, ymm10, ymm0
	vmovups	ymm4, ymmword ptr [rsp + 320]
	vblendvps	ymm0, ymm1, ymm4, ymm0
	vpand	ymm1, ymm2, ymm3
	vpcmpeqd	ymm2, ymm10, ymm2
	vblendvps	ymm1, ymm1, ymm4, ymm2
	vmovdqu	ymm2, ymmword ptr [rsp + 144]
	vpsrlw	xmm2, xmm2, 2
	vpand	xmm2, xmm2, xmmword ptr [rip + 942f]
	vpminub	xmm2, xmm2, xmm6
	vpmovzxbd	ymm3, xmm2
	vpmaxud	ymm1, ymm1, ymm3
	vmovdqu	ymm3, ymmword ptr [rsp + 208]
	vextracti128	xmm3, ymm3, 1
	vpextrd	eax, xmm3, 3
	mov	rcx, qword ptr [rsp + 8]
	vmovdqu	ymmword ptr [rcx + 256], ymm1
	vpshufd	xmm1, xmm2, 238
	vpmovzxbd	ymm1, xmm1
	vpmaxud	ymm1, ymm0, ymm1
	vmovdqu	ymmword ptr [rcx + 288], ymm1
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm14, ymm0, 170
	add	r8, rax
	cmp	qword ptr [rsp + 96], 17
	jb	342f
	vextracti128	xmm0, ymm11, 1
	vpshufd	xmm1, xmm0, 238
	vmovdqu	ymm2, ymmword ptr [rsp + 608]
	vextracti128	xmm2, ymm2, 1
	vpmovzxbd	ymm1, xmm1
	vpbroadcastd	ymm2, xmm2
	vpaddd	ymm1, ymm2, ymm1
	vpmovzxbd	ymm2, xmm0
	vmovdqu	ymm0, ymmword ptr [rsp + 640]
	vextracti128	xmm0, ymm0, 1
	vpshufd	xmm3, xmm0, 238
	vpmovzxbd	ymm3, xmm3
	vpmovzxbd	ymm0, xmm0
	vpsrld	ymm4, ymm0, 3
	vpsrld	ymm5, ymm3, 3
	vmovdqu	ymm6, ymmword ptr [rsp + 480]
	vpmaxud	ymm5, ymm5, ymm6
	vpcmpeqd	ymm8, ymm8, ymm8
	vpaddd	ymm7, ymm8, ymm5
	vpmaxud	ymm4, ymm4, ymm6
	vpaddd	ymm4, ymm8, ymm4
	vmovdqu	ymm11, ymmword ptr [rsp + 448]
	vpand	ymm5, ymm11, ymm0
	vpand	ymm6, ymm11, ymm3
	vmovdqu	ymm9, ymmword ptr [rsp + 416]
	vpminud	ymm3, ymm3, ymm9
	vpminud	ymm0, ymm0, ymm9
	vpand	ymm0, ymm9, ymm0
	vpor	ymm0, ymm0, ymm5
	vpand	ymm3, ymm9, ymm3
	vpor	ymm3, ymm3, ymm6
	vpsllvd	ymm10, ymm0, ymm4
	vpsllvd	ymm9, ymm3, ymm7
	vpsllvd	ymm6, ymm8, ymm4
	vpsllvd	ymm5, ymm8, ymm7
	vpaddd	ymm3, ymm1, ymm7
	mov	eax, r8d
	and	eax, 7
	vmovd	xmm4, eax
	vpbroadcastd	ymm4, xmm4
	vpaddd	ymm2, ymm4, ymm2
	vpaddd	ymm1, ymm4, ymm1
	vpsrld	ymm4, ymm1, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm8, ymm11, ymm1
	vpand	ymm11, ymm11, ymm2
	vbroadcasti128	ymm0, xmmword ptr [rip + 892f]
	vpshufb	ymm1, ymm7, ymm0
	vpshufb	ymm2, ymm4, ymm0
	vmovdqu	ymm0, ymmword ptr [rsp + 384]
	vpaddb	ymm12, ymm2, ymm0
	vpaddb	ymm1, ymm1, ymm0
	mov	rdx, r8
	shr	rdx, 3
	lea	rax, [rdx + 64]
	cmp	rax, r9
	vmovdqu	ymmword ptr [rsp + 208], ymm3
	vmovdqu	ymmword ptr [rsp + 176], ymm5
	vmovdqu	ymmword ptr [rsp + 320], ymm8
	vmovdqu	ymmword ptr [rsp + 288], ymm6
	jbe	172f
	mov	rsi, r9
	sub	rsi, rdx
	mov	rbp, rdi
	jbe	242f
	cmp	rsi, 16
	mov	r14, rdx
	jb	222f
	mov	rax, qword ptr [rsp + 16]
	lea	r15, [rdx + rax]
	mov	rax, qword ptr [rsp + 8]
	sub	rax, r15
	add	rax, 575
	cmp	rax, 127
	mov	r14, rdx
	jb	222f
	cmp	rsi, 128
	jae	182f
	xor	r12d, r12d
	jmp	202f
	.p2align	4
172:
	add	rdx, qword ptr [rsp + 16]
	mov	rbp, rdx
	jmp	242f
182:
	mov	qword ptr [rsp + 48], r8
	mov	r12, rsi
	and	r12, -128
	lea	r14, [rdx + r12]
	mov	rax, qword ptr [rsp + 16]
	lea	r8, [rax + rdx + 96]
	xor	eax, eax
	mov	rcx, qword ptr [rsp + 8]
	.p2align	4
192:
	vmovdqu	ymm2, ymmword ptr [r8 + rax - 96]
	vmovdqu	ymm4, ymmword ptr [r8 + rax - 64]
	vmovdqu	ymm7, ymmword ptr [r8 + rax - 32]
	vmovdqu	ymm8, ymmword ptr [r8 + rax]
	vmovdqu	ymmword ptr [rcx + rax + 576], ymm2
	vmovdqu	ymmword ptr [rcx + rax + 608], ymm4
	vmovdqu	ymmword ptr [rcx + rax + 640], ymm7
	vmovdqu	ymmword ptr [rcx + rax + 672], ymm8
	sub	rax, -128
	cmp	r12, rax
	jne	192b
	cmp	rsi, r12
	mov	rbp, rdi
	mov	r8, qword ptr [rsp + 48]
	je	242f
	test	sil, 112
	je	222f
202:
	mov	rax, rsi
	and	rax, -16
	lea	r14, [rdx + rax]
	.p2align	4
212:
	vmovdqu	xmm2, xmmword ptr [r15 + r12]
	vmovdqu	xmmword ptr [rdi + r12], xmm2
	add	r12, 16
	cmp	rax, r12
	jne	212b
	cmp	rsi, rax
	mov	rbp, rdi
	je	242f
222:
	mov	rax, rdi
	sub	rax, rdx
	mov	rcx, qword ptr [rsp + 16]
	.p2align	4
232:
	movzx	edx, byte ptr [rcx + r14]
	mov	byte ptr [rax + r14], dl
	inc	r14
	cmp	r9, r14
	jne	232b
	mov	rbp, rdi
242:
	vmovdqu	ymm2, ymmword ptr [rbp]
	vpermq	ymm4, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm7, ymm4, ymm12
	vpshufb	ymm8, ymm2, ymm12
	vpbroadcastb	ymm5, byte ptr [rip + 902f]
	vpand	ymm13, ymm12, ymm5
	vpxor	xmm6, xmm6, xmm6
	vpcmpeqb	ymm13, ymm13, ymm6
	vpblendvb	ymm7, ymm8, ymm7, ymm13
	vmovdqu	ymm8, ymmword ptr [rbp + 32]
	vpermq	ymm15, ymm8, 68
	vpermq	ymm8, ymm8, 238
	vpshufb	ymm0, ymm15, ymm12
	vpshufb	ymm3, ymm8, ymm12
	vpblendvb	ymm0, ymm3, ymm0, ymm13
	vpshufb	ymm3, ymm4, ymm1
	vpshufb	ymm2, ymm2, ymm1
	vpand	ymm4, ymm1, ymm5
	vpcmpeqb	ymm4, ymm4, ymm6
	vpblendvb	ymm2, ymm2, ymm3, ymm4
	vpshufb	ymm3, ymm15, ymm1
	vpshufb	ymm8, ymm8, ymm1
	vpblendvb	ymm3, ymm8, ymm3, ymm4
	vpbroadcastb	ymm4, byte ptr [rip + 912f]
	vpand	ymm1, ymm1, ymm4
	vpcmpeqb	ymm1, ymm1, ymm4
	vpblendvb	ymm1, ymm2, ymm3, ymm1
	vpand	ymm2, ymm12, ymm4
	vpcmpeqb	ymm2, ymm2, ymm4
	vpblendvb	ymm0, ymm7, ymm0, ymm2
	vpsrlvd	ymm1, ymm1, ymm11
	vmovdqu	ymm2, ymmword ptr [rsp + 288]
	vpandn	ymm1, ymm2, ymm1
	vpaddd	ymm1, ymm10, ymm1
	vpsrlvd	ymm0, ymm0, ymmword ptr [rsp + 320]
	vmovdqu	ymm2, ymmword ptr [rsp + 176]
	vpandn	ymm0, ymm2, ymm0
	vpaddd	ymm0, ymm9, ymm0
	vpor	ymm2, ymm0, ymmword ptr [rip + 922f]
	vpcmpeqd	ymm0, ymm0, ymm6
	vpandn	ymm0, ymm0, ymm2
	vpor	ymm2, ymm1, ymmword ptr [rip + 932f]
	vpcmpeqd	ymm1, ymm1, ymm6
	vpandn	ymm1, ymm1, ymm2
	vperm2i128	ymm2, ymm1, ymm1, 10
	vpalignr	ymm2, ymm1, ymm2, 12
	vpmaxud	ymm2, ymm1, ymm2
	vperm2i128	ymm1, ymm1, ymm0, 33
	vpalignr	ymm1, ymm0, ymm1, 12
	vpmaxud	ymm0, ymm0, ymm1
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
	vmovdqu	ymm3, ymmword ptr [rsp + 352]
	vpand	ymm1, ymm0, ymm3
	vpcmpeqd	ymm0, ymm0, ymm6
	vblendvps	ymm0, ymm1, ymm14, ymm0
	vpand	ymm1, ymm2, ymm3
	vpcmpeqd	ymm2, ymm2, ymm6
	vblendvps	ymm1, ymm1, ymm14, ymm2
	vmovdqu	ymm2, ymmword ptr [rsp + 144]
	vextracti128	xmm2, ymm2, 1
	vpsrlw	xmm2, xmm2, 2
	vpand	xmm2, xmm2, xmmword ptr [rip + 942f]
	vpminub	xmm2, xmm2, xmm4
	vpmovzxbd	ymm3, xmm2
	vpmaxud	ymm1, ymm1, ymm3
	vmovdqu	ymm3, ymmword ptr [rsp + 208]
	vextracti128	xmm3, ymm3, 1
	vpextrd	eax, xmm3, 3
	mov	rcx, qword ptr [rsp + 8]
	vmovdqu	ymmword ptr [rcx + 320], ymm1
	vpshufd	xmm1, xmm2, 238
	vpmovzxbd	ymm1, xmm1
	vpmaxud	ymm1, ymm0, ymm1
	vmovdqu	ymmword ptr [rcx + 352], ymm1
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm14, ymm0, 170
	add	r8, rax
	cmp	qword ptr [rsp + 96], 33
	jb	252f
	vmovdqu	ymm5, ymmword ptr [rsp + 544]
	vpsrlw	ymm0, ymm5, 3
	vpand	ymm0, ymm0, ymmword ptr [rip + 882f]
	vpsubusb	ymm0, ymm0, ymmword ptr [rip + 952f]
	vpsllq	ymm1, ymm0, 8
	vpaddb	ymm1, ymm0, ymm1
	vpsllq	ymm2, ymm1, 16
	vpaddb	ymm1, ymm1, ymm2
	vpsllq	ymm2, ymm1, 32
	vpaddb	ymm1, ymm1, ymm2
	vpsubb	ymm4, ymm1, ymm0
	vpsrlq	ymm0, ymm1, 56
	vpshufd	xmm1, xmm4, 238
	vpmovzxbd	ymm1, xmm1
	vmovdqu	ymmword ptr [rsp + 512], ymm0
	vpbroadcastd	ymm2, xmm0
	vpaddd	ymm1, ymm2, ymm1
	vpmovzxbd	ymm2, xmm4
	vpshufd	xmm3, xmm5, 238
	vpmovzxbd	ymm3, xmm3
	vpmovzxbd	ymm5, xmm5
	vpsrld	ymm6, ymm5, 3
	vpsrld	ymm7, ymm3, 3
	vmovdqu	ymm0, ymmword ptr [rsp + 480]
	vpmaxud	ymm7, ymm7, ymm0
	vpcmpeqd	ymm11, ymm11, ymm11
	vpaddd	ymm7, ymm11, ymm7
	vpmaxud	ymm6, ymm6, ymm0
	vpaddd	ymm8, ymm11, ymm6
	vmovdqu	ymm0, ymmword ptr [rsp + 448]
	vpand	ymm6, ymm5, ymm0
	vpand	ymm9, ymm3, ymm0
	vmovdqu	ymm10, ymmword ptr [rsp + 416]
	vpminud	ymm3, ymm3, ymm10
	vpminud	ymm5, ymm5, ymm10
	vpand	ymm5, ymm10, ymm5
	vpor	ymm5, ymm5, ymm6
	vpand	ymm3, ymm10, ymm3
	vpor	ymm3, ymm9, ymm3
	vpsllvd	ymm5, ymm5, ymm8
	vmovdqu	ymmword ptr [rsp + 176], ymm5
	vpsllvd	ymm3, ymm3, ymm7
	vmovdqu	ymmword ptr [rsp + 208], ymm3
	vpsllvd	ymm3, ymm11, ymm8
	vmovdqu	ymmword ptr [rsp + 288], ymm3
	vpsllvd	ymm3, ymm11, ymm7
	vmovdqu	ymmword ptr [rsp + 320], ymm3
	vpaddd	ymm3, ymm1, ymm7
	vmovdqu	ymmword ptr [rsp + 144], ymm3
	mov	eax, r8d
	and	eax, 7
	vmovd	xmm7, eax
	vpbroadcastd	ymm7, xmm7
	vpaddd	ymm2, ymm7, ymm2
	vpaddd	ymm1, ymm7, ymm1
	vpsrld	ymm7, ymm1, 3
	vpsrld	ymm8, ymm2, 3
	vpand	ymm11, ymm1, ymm0
	vpand	ymm12, ymm2, ymm0
	vbroadcasti128	ymm0, xmmword ptr [rip + 892f]
	vpshufb	ymm2, ymm8, ymm0
	vpshufb	ymm1, ymm7, ymm0
	vmovdqu	ymm0, ymmword ptr [rsp + 384]
	vpaddb	ymm1, ymm1, ymm0
	vpaddb	ymm7, ymm2, ymm0
	mov	rdx, r8
	shr	rdx, 3
	lea	rax, [rdx + 64]
	cmp	rax, r9
	mov	rbp, qword ptr [rsp + 24]
	jbe	262f
	mov	rsi, r9
	sub	rsi, rdx
	mov	rax, rdi
	jbe	332f
	cmp	rsi, 16
	mov	r14, rdx
	jb	312f
	mov	rax, qword ptr [rsp + 16]
	lea	r15, [rdx + rax]
	mov	rax, qword ptr [rsp + 8]
	sub	rax, r15
	add	rax, 575
	cmp	rax, 127
	mov	r14, rdx
	jb	312f
	cmp	rsi, 128
	jae	272f
	xor	r12d, r12d
	jmp	292f
	.p2align	4
252:
	mov	rdi, qword ptr [rsp + 8]
	mov	rcx, qword ptr [rsp + 40]
	jmp	432f
262:
	add	rdx, qword ptr [rsp + 16]
	mov	rax, rdx
	jmp	332f
272:
	mov	qword ptr [rsp + 48], r8
	mov	r12, rsi
	and	r12, -128
	lea	r14, [rdx + r12]
	mov	rax, qword ptr [rsp + 16]
	lea	r8, [rax + rdx + 96]
	xor	eax, eax
	mov	rcx, qword ptr [rsp + 8]
	.p2align	4
282:
	vmovdqu	ymm2, ymmword ptr [r8 + rax - 96]
	vmovdqu	ymm8, ymmword ptr [r8 + rax - 64]
	vmovdqu	ymm13, ymmword ptr [r8 + rax - 32]
	vmovdqu	ymm15, ymmword ptr [r8 + rax]
	vmovdqu	ymmword ptr [rcx + rax + 576], ymm2
	vmovdqu	ymmword ptr [rcx + rax + 608], ymm8
	vmovdqu	ymmword ptr [rcx + rax + 640], ymm13
	vmovdqu	ymmword ptr [rcx + rax + 672], ymm15
	sub	rax, -128
	cmp	r12, rax
	jne	282b
	cmp	rsi, r12
	mov	rax, rdi
	mov	r8, qword ptr [rsp + 48]
	je	332f
	test	sil, 112
	je	312f
292:
	mov	rax, rsi
	and	rax, -16
	lea	r14, [rdx + rax]
	.p2align	4
302:
	vmovdqu	xmm2, xmmword ptr [r15 + r12]
	vmovdqu	xmmword ptr [rdi + r12], xmm2
	add	r12, 16
	cmp	rax, r12
	jne	302b
	cmp	rsi, rax
	mov	rax, rdi
	je	332f
312:
	mov	rax, rdi
	sub	rax, rdx
	mov	rcx, qword ptr [rsp + 16]
	.p2align	4
322:
	movzx	edx, byte ptr [rcx + r14]
	mov	byte ptr [rax + r14], dl
	inc	r14
	cmp	r9, r14
	jne	322b
	mov	rax, rdi
332:
	vmovdqu	ymm2, ymmword ptr [rax]
	vmovdqu	ymm8, ymmword ptr [rax + 32]
	vpermq	ymm13, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm15, ymm13, ymm1
	vpshufb	ymm3, ymm2, ymm1
	vpbroadcastb	ymm10, byte ptr [rip + 902f]
	vpand	ymm0, ymm10, ymm1
	vpxor	xmm9, xmm9, xmm9
	vpcmpeqb	ymm0, ymm9, ymm0
	vpblendvb	ymm3, ymm3, ymm15, ymm0
	vpermq	ymm15, ymm8, 68
	vpermq	ymm8, ymm8, 238
	vpshufb	ymm6, ymm15, ymm1
	vpshufb	ymm5, ymm8, ymm1
	vpblendvb	ymm0, ymm5, ymm6, ymm0
	vpshufb	ymm5, ymm13, ymm7
	vpshufb	ymm2, ymm2, ymm7
	vpand	ymm6, ymm10, ymm7
	vpcmpeqb	ymm6, ymm9, ymm6
	vpblendvb	ymm2, ymm2, ymm5, ymm6
	vpshufb	ymm5, ymm15, ymm7
	vpshufb	ymm8, ymm8, ymm7
	vpblendvb	ymm5, ymm8, ymm5, ymm6
	vpbroadcastb	ymm8, byte ptr [rip + 912f]
	vpand	ymm6, ymm8, ymm7
	vpcmpeqb	ymm6, ymm8, ymm6
	vpblendvb	ymm2, ymm2, ymm5, ymm6
	vpand	ymm1, ymm8, ymm1
	vpcmpeqb	ymm1, ymm8, ymm1
	vpblendvb	ymm0, ymm3, ymm0, ymm1
	vpsrlvd	ymm1, ymm2, ymm12
	vmovdqu	ymm2, ymmword ptr [rsp + 288]
	vpandn	ymm1, ymm2, ymm1
	vpaddd	ymm1, ymm1, ymmword ptr [rsp + 176]
	vpsrlvd	ymm0, ymm0, ymm11
	vmovdqu	ymm2, ymmword ptr [rsp + 320]
	vpandn	ymm0, ymm2, ymm0
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 208]
	vpor	ymm2, ymm0, ymmword ptr [rip + 922f]
	vpcmpeqd	ymm0, ymm9, ymm0
	vpandn	ymm0, ymm0, ymm2
	vpor	ymm2, ymm1, ymmword ptr [rip + 932f]
	vpcmpeqd	ymm1, ymm9, ymm1
	vpandn	ymm1, ymm1, ymm2
	vperm2i128	ymm2, ymm1, ymm1, 10
	vpalignr	ymm2, ymm1, ymm2, 12
	vpmaxud	ymm2, ymm1, ymm2
	vperm2i128	ymm1, ymm1, ymm0, 33
	vpalignr	ymm1, ymm0, ymm1, 12
	vpmaxud	ymm0, ymm0, ymm1
	vpblendd	ymm1, ymm0, ymm2, 192
	vpermq	ymm1, ymm1, 147
	vpmaxud	ymm0, ymm0, ymm1
	vpblendd	ymm1, ymm2, ymm9, 192
	vpermq	ymm1, ymm1, 147
	vpmaxud	ymm1, ymm2, ymm1
	vperm2i128	ymm2, ymm1, ymm1, 10
	vpmaxud	ymm2, ymm1, ymm2
	vperm2i128	ymm1, ymm1, ymm0, 33
	vpmaxud	ymm0, ymm0, ymm1
	vpmaxud	ymm0, ymm0, ymm2
	vmovdqu	ymm3, ymmword ptr [rsp + 352]
	vpand	ymm1, ymm0, ymm3
	vpcmpeqd	ymm0, ymm9, ymm0
	vblendvps	ymm0, ymm1, ymm14, ymm0
	vpand	ymm1, ymm2, ymm3
	vpcmpeqd	ymm2, ymm9, ymm2
	vblendvps	ymm1, ymm1, ymm14, ymm2
	vmovdqu	ymm2, ymmword ptr [rsp + 576]
	vpsrlw	xmm2, xmm2, 2
	vpand	xmm2, xmm2, xmmword ptr [rip + 942f]
	vpminub	xmm2, xmm8, xmm2
	vpmovzxbd	ymm3, xmm2
	vpmaxud	ymm1, ymm1, ymm3
	vmovdqu	ymm3, ymmword ptr [rsp + 144]
	vextracti128	xmm3, ymm3, 1
	vpextrd	eax, xmm3, 3
	mov	rcx, qword ptr [rsp + 8]
	vmovdqu	ymmword ptr [rcx + 384], ymm1
	vpshufd	xmm1, xmm2, 238
	vpmovzxbd	ymm1, xmm1
	vpmaxud	ymm1, ymm0, ymm1
	vmovdqu	ymmword ptr [rcx + 416], ymm1
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm14, ymm0, 170
	add	r8, rax
	cmp	qword ptr [rsp + 96], 49
	jb	342f
	vextracti128	xmm0, ymm4, 1
	vpshufd	xmm1, xmm0, 238
	vmovdqu	ymm2, ymmword ptr [rsp + 512]
	vextracti128	xmm2, ymm2, 1
	vpmovzxbd	ymm1, xmm1
	vpbroadcastd	ymm2, xmm2
	vpaddd	ymm1, ymm2, ymm1
	vpmovzxbd	ymm2, xmm0
	vmovdqu	ymm0, ymmword ptr [rsp + 544]
	vextracti128	xmm0, ymm0, 1
	vpshufd	xmm3, xmm0, 238
	vpmovzxbd	ymm3, xmm3
	vpmovzxbd	ymm0, xmm0
	vpsrld	ymm4, ymm0, 3
	vpsrld	ymm5, ymm3, 3
	vmovdqu	ymm6, ymmword ptr [rsp + 480]
	vpmaxud	ymm5, ymm5, ymm6
	vpcmpeqd	ymm8, ymm8, ymm8
	vpaddd	ymm7, ymm8, ymm5
	vpmaxud	ymm4, ymm4, ymm6
	vpaddd	ymm5, ymm8, ymm4
	vmovdqu	ymm10, ymmword ptr [rsp + 448]
	vpand	ymm4, ymm10, ymm0
	vpand	ymm6, ymm10, ymm3
	vmovdqu	ymm9, ymmword ptr [rsp + 416]
	vpminud	ymm3, ymm3, ymm9
	vpminud	ymm0, ymm0, ymm9
	vpand	ymm0, ymm9, ymm0
	vpor	ymm0, ymm0, ymm4
	vpand	ymm3, ymm9, ymm3
	vpor	ymm3, ymm3, ymm6
	vpsllvd	ymm0, ymm0, ymm5
	vmovdqu	ymmword ptr [rsp + 208], ymm0
	vpsllvd	ymm0, ymm3, ymm7
	vmovdqu	ymmword ptr [rsp + 144], ymm0
	vpsllvd	ymm6, ymm8, ymm5
	vpsllvd	ymm0, ymm8, ymm7
	vmovdqu	ymmword ptr [rsp + 176], ymm0
	vpaddd	ymm0, ymm1, ymm7
	vmovdqu	ymmword ptr [rsp + 96], ymm0
	mov	eax, r8d
	and	eax, 7
	vmovd	xmm7, eax
	vpbroadcastd	ymm7, xmm7
	vpaddd	ymm2, ymm7, ymm2
	vpaddd	ymm1, ymm7, ymm1
	vpsrld	ymm7, ymm1, 3
	vpsrld	ymm8, ymm2, 3
	vpand	ymm9, ymm10, ymm1
	vpand	ymm10, ymm10, ymm2
	vbroadcasti128	ymm0, xmmword ptr [rip + 892f]
	vpshufb	ymm1, ymm8, ymm0
	vpshufb	ymm2, ymm7, ymm0
	vmovdqu	ymm0, ymmword ptr [rsp + 384]
	vpaddb	ymm11, ymm2, ymm0
	vpaddb	ymm1, ymm1, ymm0
	mov	rdx, r8
	shr	rdx, 3
	lea	rax, [rdx + 64]
	cmp	rax, r9
	mov	rcx, qword ptr [rsp + 40]
	jbe	352f
	mov	rsi, r9
	sub	rsi, rdx
	mov	rbp, rdi
	jbe	422f
	cmp	rsi, 16
	mov	r14, rdx
	jb	402f
	mov	rax, qword ptr [rsp + 16]
	lea	r15, [rdx + rax]
	mov	rax, qword ptr [rsp + 8]
	sub	rax, r15
	add	rax, 575
	cmp	rax, 127
	mov	r14, rdx
	jb	402f
	cmp	rsi, 128
	jae	362f
	xor	r12d, r12d
	jmp	382f
	.p2align	4
342:
	mov	rdi, qword ptr [rsp + 8]
	mov	rcx, qword ptr [rsp + 40]
	mov	r15, qword ptr [rsp + 32]
	jmp	442f
352:
	mov	rbp, qword ptr [rsp + 16]
	add	rbp, rdx
	jmp	422f
362:
	mov	qword ptr [rsp + 48], r8
	mov	r12, rsi
	and	r12, -128
	lea	r14, [rdx + r12]
	mov	rax, qword ptr [rsp + 16]
	lea	r8, [rax + rdx + 96]
	xor	eax, eax
	mov	rcx, qword ptr [rsp + 8]
	.p2align	4
372:
	vmovdqu	ymm2, ymmword ptr [r8 + rax - 96]
	vmovdqu	ymm7, ymmword ptr [r8 + rax - 64]
	vmovdqu	ymm8, ymmword ptr [r8 + rax - 32]
	vmovdqu	ymm12, ymmword ptr [r8 + rax]
	vmovdqu	ymmword ptr [rcx + rax + 576], ymm2
	vmovdqu	ymmword ptr [rcx + rax + 608], ymm7
	vmovdqu	ymmword ptr [rcx + rax + 640], ymm8
	vmovdqu	ymmword ptr [rcx + rax + 672], ymm12
	sub	rax, -128
	cmp	r12, rax
	jne	372b
	cmp	rsi, r12
	mov	rbp, rdi
	mov	rcx, qword ptr [rsp + 40]
	mov	r8, qword ptr [rsp + 48]
	je	422f
	test	sil, 112
	je	402f
382:
	mov	rax, rsi
	and	rax, -16
	lea	r14, [rdx + rax]
	.p2align	4
392:
	vmovdqu	xmm2, xmmword ptr [r15 + r12]
	vmovdqu	xmmword ptr [rdi + r12], xmm2
	add	r12, 16
	cmp	rax, r12
	jne	392b
	cmp	rsi, rax
	mov	rbp, rdi
	je	422f
402:
	mov	rax, rdi
	sub	rax, rdx
	mov	rsi, qword ptr [rsp + 16]
	.p2align	4
412:
	movzx	edx, byte ptr [rsi + r14]
	mov	byte ptr [rax + r14], dl
	inc	r14
	cmp	r9, r14
	jne	412b
	mov	rbp, rdi
422:
	vmovdqu	ymm2, ymmword ptr [rbp]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm8, ymm7, ymm11
	vpshufb	ymm12, ymm2, ymm11
	vpbroadcastb	ymm5, byte ptr [rip + 902f]
	vpand	ymm13, ymm11, ymm5
	vpxor	xmm4, xmm4, xmm4
	vpcmpeqb	ymm13, ymm13, ymm4
	vpblendvb	ymm8, ymm12, ymm8, ymm13
	vmovdqu	ymm12, ymmword ptr [rbp + 32]
	vpermq	ymm15, ymm12, 68
	vpermq	ymm12, ymm12, 238
	vpshufb	ymm0, ymm15, ymm11
	vpshufb	ymm3, ymm12, ymm11
	vpblendvb	ymm0, ymm3, ymm0, ymm13
	vpshufb	ymm3, ymm7, ymm1
	vpshufb	ymm2, ymm2, ymm1
	vpand	ymm7, ymm1, ymm5
	vpcmpeqb	ymm7, ymm7, ymm4
	vpblendvb	ymm2, ymm2, ymm3, ymm7
	vpshufb	ymm3, ymm15, ymm1
	vpshufb	ymm12, ymm12, ymm1
	vpblendvb	ymm3, ymm12, ymm3, ymm7
	vpbroadcastb	ymm5, byte ptr [rip + 912f]
	vpand	ymm1, ymm1, ymm5
	vpcmpeqb	ymm1, ymm1, ymm5
	vpblendvb	ymm1, ymm2, ymm3, ymm1
	vpand	ymm2, ymm11, ymm5
	vpcmpeqb	ymm2, ymm2, ymm5
	vpblendvb	ymm0, ymm8, ymm0, ymm2
	vpsrlvd	ymm1, ymm1, ymm10
	vpandn	ymm1, ymm6, ymm1
	vpaddd	ymm1, ymm1, ymmword ptr [rsp + 208]
	vpsrlvd	ymm0, ymm0, ymm9
	vmovdqu	ymm2, ymmword ptr [rsp + 176]
	vpandn	ymm0, ymm2, ymm0
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 144]
	vpor	ymm2, ymm0, ymmword ptr [rip + 922f]
	vpcmpeqd	ymm0, ymm0, ymm4
	vpandn	ymm0, ymm0, ymm2
	vpor	ymm2, ymm1, ymmword ptr [rip + 932f]
	vpcmpeqd	ymm1, ymm1, ymm4
	vpandn	ymm1, ymm1, ymm2
	vperm2i128	ymm2, ymm1, ymm1, 10
	vpalignr	ymm2, ymm1, ymm2, 12
	vpmaxud	ymm2, ymm1, ymm2
	vperm2i128	ymm1, ymm1, ymm0, 33
	vpalignr	ymm1, ymm0, ymm1, 12
	vpmaxud	ymm0, ymm0, ymm1
	vpblendd	ymm1, ymm0, ymm2, 192
	vpermq	ymm1, ymm1, 147
	vpmaxud	ymm0, ymm0, ymm1
	vpblendd	ymm1, ymm2, ymm4, 192
	vpermq	ymm1, ymm1, 147
	vpmaxud	ymm1, ymm2, ymm1
	vperm2i128	ymm2, ymm1, ymm1, 10
	vpmaxud	ymm2, ymm1, ymm2
	vperm2i128	ymm1, ymm1, ymm0, 33
	vpmaxud	ymm0, ymm0, ymm1
	vpmaxud	ymm0, ymm0, ymm2
	vmovdqu	ymm3, ymmword ptr [rsp + 352]
	vpand	ymm1, ymm0, ymm3
	vpcmpeqd	ymm0, ymm0, ymm4
	vblendvps	ymm0, ymm1, ymm14, ymm0
	vpand	ymm1, ymm2, ymm3
	vpcmpeqd	ymm2, ymm2, ymm4
	vblendvps	ymm1, ymm1, ymm14, ymm2
	vmovdqu	ymm2, ymmword ptr [rsp + 576]
	vextracti128	xmm2, ymm2, 1
	vpsrlw	xmm2, xmm2, 2
	vpand	xmm2, xmm2, xmmword ptr [rip + 942f]
	vpminub	xmm2, xmm2, xmm5
	vpmovzxbd	ymm3, xmm2
	vpmaxud	ymm1, ymm1, ymm3
	vmovdqu	ymm3, ymmword ptr [rsp + 96]
	vextracti128	xmm3, ymm3, 1
	vpextrd	eax, xmm3, 3
	mov	rdi, qword ptr [rsp + 8]
	vmovdqu	ymmword ptr [rdi + 448], ymm1
	vpshufd	xmm1, xmm2, 238
	vpmovzxbd	ymm1, xmm1
	vpmaxud	ymm1, ymm0, ymm1
	vmovdqu	ymmword ptr [rdi + 480], ymm1
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm14, ymm0, 170
	add	r8, rax
432:
	mov	r15, qword ptr [rsp + 32]
	mov	rbp, qword ptr [rsp + 24]
442:
	shr	r11, 56
	add	r11, rbx
	shr	r10, 56
	add	r10, r13
	vmovd	eax, xmm14
	mov	qword ptr [rdi + 72], r8
	mov	qword ptr [rdi + 96], rax
	mov	qword ptr [rdi + 128], r10
	mov	qword ptr [rdi + 136], r11
	add	rbp, qword ptr [rsp + 256]
	mov	rax, qword ptr [rsp + 88]
	and	rax, 124
	mov	r10, qword ptr [rsp + 56]
	je	702f
	xor	r8d, r8d
	mov	r13, qword ptr [rsp + 72]
	mov	qword ptr [rsp + 24], rbp
	.p2align	4
452:
	movzx	r9d, byte ptr [rbp + r8]
	movzx	r14d, byte ptr [rdi + r8 + 192]
	cmp	r14, 33
	mov	edx, dword ptr [rdi + 4*r8 + 256]
	vmovups	ymm0, ymmword ptr [rcx + r13]
	vmovups	ymmword ptr [r10 + r15], ymm0
	jae	542f
462:
	lea	r11, [r14 + r15]
	mov	rsi, r11
	sub	rsi, rdx
	mov	ebx, 0
	cmovae	rbx, rsi
	vmovups	ymm0, ymmword ptr [r10 + rbx]
	vmovups	ymmword ptr [r10 + r11], ymm0
	cmp	r9b, -124
	mov	qword ptr [rsp + 32], r15
	jae	562f
	shr	r9d, 2
472:
	lea	rdx, [r8 + 1]
	mov	qword ptr [rsp + 72], r13
	mov	qword ptr [rsp + 96], r14
	lea	rbx, [r14 + r13]
	add	r11, r9
	movzx	r13d, byte ptr [rbp + rdx]
	movzx	r15d, byte ptr [rdi + rdx + 192]
	cmp	r15, 33
	mov	edx, dword ptr [rdi + 4*rdx + 256]
	vmovups	ymm0, ymmword ptr [rcx + rbx]
	vmovups	ymmword ptr [r10 + r11], ymm0
	jae	582f
482:
	add	r11, r15
	mov	rsi, r11
	sub	rsi, rdx
	mov	r14d, 0
	cmovae	r14, rsi
	vmovups	ymm0, ymmword ptr [r10 + r14]
	vmovups	ymmword ptr [r10 + r11], ymm0
	cmp	r13b, -124
	jae	602f
	shr	r13d, 2
492:
	lea	r14, [r8 + 2]
	add	rbx, r15
	add	r11, r13
	movzx	edx, byte ptr [rbp + r14]
	movzx	esi, byte ptr [rdi + r14 + 192]
	cmp	rsi, 33
	mov	r14d, dword ptr [rdi + 4*r14 + 256]
	vmovups	ymm0, ymmword ptr [rcx + rbx]
	vmovups	ymmword ptr [r10 + r11], ymm0
	jae	622f
502:
	add	r11, rsi
	mov	r12, r11
	sub	r12, r14
	mov	ebp, 0
	cmovae	rbp, r12
	vmovups	ymm0, ymmword ptr [r10 + rbp]
	vmovups	ymmword ptr [r10 + r11], ymm0
	cmp	dl, -124
	jae	642f
	shr	edx, 2
512:
	mov	qword ptr [rsp + 16], r9
	lea	rbp, [r8 + 3]
	add	rbx, rsi
	add	r11, rdx
	mov	r14, qword ptr [rsp + 24]
	movzx	r12d, byte ptr [r14 + rbp]
	movzx	r14d, byte ptr [rdi + rbp + 192]
	cmp	r14, 33
	mov	ebp, dword ptr [rdi + 4*rbp + 256]
	vmovups	ymm0, ymmword ptr [rcx + rbx]
	vmovups	ymmword ptr [r10 + r11], ymm0
	jae	662f
522:
	add	r11, r14
	mov	r9, r11
	sub	r9, rbp
	mov	ecx, 0
	cmovae	rcx, r9
	mov	r10, qword ptr [rsp + 56]
	vmovups	ymm0, ymmword ptr [r10 + rcx]
	vmovups	ymmword ptr [r10 + r11], ymm0
	cmp	r12b, -124
	jae	682f
	shr	r12d, 2
	mov	rdi, qword ptr [rsp + 8]
532:
	mov	rcx, qword ptr [rsp + 40]
	mov	rbp, qword ptr [rsp + 24]
	add	r14, rbx
	add	r12, r11
	add	r8, 4
	cmp	r8, rax
	mov	r13, r14
	mov	r15, r12
	jb	452b
	jmp	712f
542:
	mov	r12, r9
	lea	rsi, [rcx + r13]
	lea	r9, [r10 + r15]
	mov	r11, qword ptr [rdi + 48]
	mov	rbx, qword ptr [rdi + 120]
	movzx	r14d, byte ptr [r11 + rbx]
	inc	rbx
	mov	qword ptr [rdi + 120], rbx
	add	r14, 33
	mov	ebx, 32
	.p2align	4
552:
	vmovups	ymm0, ymmword ptr [rsi + rbx]
	vmovups	ymmword ptr [r9 + rbx], ymm0
	add	rbx, 32
	cmp	rbx, r14
	jb	552b
	mov	rdi, qword ptr [rsp + 8]
	mov	r10, qword ptr [rsp + 56]
	mov	r9, r12
	jmp	462b
562:
	lea	rsi, [r10 + r11]
	mov	r9, qword ptr [rdi + 48]
	mov	rbx, qword ptr [rdi + 120]
	movzx	r9d, byte ptr [r9 + rbx]
	inc	rbx
	mov	qword ptr [rdi + 120], rbx
	add	r9, 33
	cmp	r11, rdx
	cmovb	rdx, r11
	mov	rbx, rsi
	sub	rbx, rdx
	mov	edx, 32
	.p2align	4
572:
	vmovups	ymm0, ymmword ptr [rbx + rdx]
	vmovups	ymmword ptr [rsi + rdx], ymm0
	add	rdx, 32
	cmp	rdx, r9
	jb	572b
	jmp	472b
582:
	lea	rsi, [rcx + rbx]
	mov	r14, qword ptr [rdi + 48]
	mov	r12, qword ptr [rdi + 120]
	movzx	r15d, byte ptr [r14 + r12]
	inc	r12
	mov	qword ptr [rdi + 120], r12
	add	r15, 33
	lea	r14, [r10 + r11]
	mov	r12d, 32
	.p2align	4
592:
	vmovups	ymm0, ymmword ptr [rsi + r12]
	vmovups	ymmword ptr [r14 + r12], ymm0
	add	r12, 32
	cmp	r12, r15
	jb	592b
	jmp	482b
602:
	lea	rsi, [r10 + r11]
	mov	r14, qword ptr [rdi + 48]
	mov	r12, qword ptr [rdi + 120]
	movzx	r13d, byte ptr [r14 + r12]
	inc	r12
	mov	qword ptr [rdi + 120], r12
	add	r13, 33
	mov	r14, qword ptr [rsp + 96]
	lea	r12, [r9 + r14]
	mov	r14, qword ptr [rsp + 32]
	add	r14, r15
	add	r14, r12
	cmp	r11, rdx
	cmovb	rdx, r11
	sub	r14, rdx
	add	r14, r10
	mov	edx, 32
	.p2align	4
612:
	vmovups	ymm0, ymmword ptr [r14 + rdx]
	vmovups	ymmword ptr [rsi + rdx], ymm0
	add	rdx, 32
	cmp	rdx, r13
	jb	612b
	jmp	492b
622:
	mov	rsi, qword ptr [rdi + 48]
	mov	r12, qword ptr [rdi + 120]
	movzx	esi, byte ptr [rsi + r12]
	inc	r12
	mov	qword ptr [rdi + 120], r12
	add	rsi, 33
	mov	r12, qword ptr [rsp + 96]
	lea	rbp, [r9 + r12]
	lea	r12, [r13 + r15]
	add	r12, rbp
	add	r12, qword ptr [rsp + 32]
	add	r12, r10
	mov	qword ptr [rsp + 16], r12
	mov	ebp, 32
	.p2align	4
632:
	lea	r12, [rcx + rbx]
	vmovups	ymm0, ymmword ptr [r12 + rbp]
	mov	r12, qword ptr [rsp + 16]
	vmovups	ymmword ptr [r12 + rbp], ymm0
	add	rbp, 32
	cmp	rbp, rsi
	jb	632b
	jmp	502b
642:
	mov	rdx, qword ptr [rdi + 48]
	mov	rbp, qword ptr [rdi + 120]
	movzx	edx, byte ptr [rdx + rbp]
	inc	rbp
	mov	qword ptr [rdi + 120], rbp
	add	rdx, 33
	mov	r12, qword ptr [rsp + 96]
	add	r12, r9
	lea	rbp, [rsi + r13]
	add	rbp, r12
	mov	r12, qword ptr [rsp + 32]
	add	r12, r15
	add	rbp, r12
	lea	r12, [r10 + r11]
	cmp	r11, r14
	cmovb	r14, r11
	sub	rbp, r14
	add	rbp, r10
	mov	r14d, 32
	.p2align	4
652:
	vmovups	ymm0, ymmword ptr [rbp + r14]
	vmovups	ymmword ptr [r12 + r14], ymm0
	add	r14, 32
	cmp	r14, rdx
	jb	652b
	jmp	512b
662:
	mov	r14, qword ptr [rdi + 48]
	mov	r9, qword ptr [rdi + 120]
	movzx	r14d, byte ptr [r14 + r9]
	inc	r9
	mov	qword ptr [rdi + 120], r9
	add	r14, 33
	mov	rdi, qword ptr [rsp + 96]
	mov	r9, qword ptr [rsp + 16]
	add	r9, rdi
	mov	qword ptr [rsp + 144], r9
	lea	r9, [rdx + rsi]
	add	r9, qword ptr [rsp + 144]
	mov	qword ptr [rsp + 144], r9
	lea	r9, [r13 + r15]
	add	r9, qword ptr [rsp + 32]
	add	r9, qword ptr [rsp + 144]
	add	r9, r10
	lea	r10, [r15 + rdi]
	mov	rdi, qword ptr [rsp + 72]
	add	rdi, rsi
	add	rdi, r10
	add	rdi, rcx
	mov	ecx, 32
	.p2align	4
672:
	vmovups	ymm0, ymmword ptr [rdi + rcx]
	vmovups	ymmword ptr [r9 + rcx], ymm0
	add	rcx, 32
	cmp	rcx, r14
	jb	672b
	jmp	522b
682:
	add	r10, r11
	mov	rdi, qword ptr [rsp + 8]
	mov	rcx, qword ptr [rdi + 48]
	mov	r9, qword ptr [rdi + 120]
	movzx	r12d, byte ptr [rcx + r9]
	mov	rcx, r10
	inc	r9
	mov	qword ptr [rdi + 120], r9
	mov	r10, qword ptr [rsp + 56]
	add	r12, 33
	mov	r9, qword ptr [rsp + 16]
	add	r9, qword ptr [rsp + 96]
	add	rdx, r14
	add	rdx, r9
	add	rsi, r13
	add	rsi, r15
	add	rsi, rdx
	add	rsi, qword ptr [rsp + 32]
	cmp	r11, rbp
	cmovb	rbp, r11
	sub	rsi, rbp
	add	rsi, r10
	mov	edx, 32
	.p2align	4
692:
	vmovups	ymm0, ymmword ptr [rsi + rdx]
	vmovups	ymmword ptr [rcx + rdx], ymm0
	add	rdx, 32
	cmp	rdx, r12
	jb	692b
	jmp	532b
	.p2align	4
702:
	mov	r12, r15
	mov	r14, qword ptr [rsp + 72]
712:
	mov	rbx, qword ptr [rsp + 88]
	cmp	rax, rbx
	mov	r11, qword ptr [rsp + 80]
	je	2b
	.p2align	4
722:
	movzx	edx, byte ptr [rbp + rax]
	movzx	esi, byte ptr [rdi + rax + 192]
	cmp	rsi, 33
	mov	r8d, dword ptr [rdi + 4*rax + 256]
	vmovups	ymm0, ymmword ptr [rcx + r14]
	vmovups	ymmword ptr [r10 + r12], ymm0
	jae	752f
732:
	add	r12, rsi
	mov	rcx, r12
	sub	rcx, r8
	mov	r9d, 0
	cmovae	r9, rcx
	vmovups	ymm0, ymmword ptr [r10 + r9]
	vmovups	ymmword ptr [r10 + r12], ymm0
	cmp	dl, -124
	jae	772f
	shr	edx, 2
742:
	mov	rcx, qword ptr [rsp + 40]
	add	r14, rsi
	add	r12, rdx
	inc	rax
	cmp	rax, rbx
	jb	722b
	jmp	2b
752:
	mov	r11, rdi
	lea	r9, [rcx + r14]
	add	r10, r12
	mov	rcx, qword ptr [rdi + 48]
	mov	rdi, qword ptr [rdi + 120]
	movzx	esi, byte ptr [rcx + rdi]
	inc	rdi
	mov	qword ptr [r11 + 120], rdi
	add	rsi, 33
	mov	r11d, 32
	.p2align	4
762:
	vmovups	ymm0, ymmword ptr [r9 + r11]
	vmovups	ymmword ptr [r10 + r11], ymm0
	add	r11, 32
	cmp	r11, rsi
	jb	762b
	mov	rdi, qword ptr [rsp + 8]
	mov	r10, qword ptr [rsp + 56]
	mov	r11, qword ptr [rsp + 80]
	jmp	732b
772:
	mov	r15, rdi
	lea	r9, [r10 + r12]
	mov	rcx, qword ptr [rdi + 48]
	mov	rdi, qword ptr [rdi + 120]
	movzx	edx, byte ptr [rcx + rdi]
	inc	rdi
	mov	qword ptr [r15 + 120], rdi
	add	rdx, 33
	cmp	r12, r8
	cmovb	r8, r12
	mov	r10, r9
	sub	r10, r8
	mov	r8d, 32
	.p2align	4
782:
	vmovups	ymm0, ymmword ptr [r10 + r8]
	vmovups	ymmword ptr [r9 + r8], ymm0
	add	r8, 32
	cmp	r8, rdx
	jb	782b
	mov	rdi, qword ptr [rsp + 8]
	mov	r10, qword ptr [rsp + 56]
	jmp	742b
792:
	mov	qword ptr [rdi + 80], r12
	mov	qword ptr [rdi + 88], r14
	add	rsp, 680
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	vzeroupper
	ret
	.p2align	2, 0x0
802:
	.long	1
	.p2align	2, 0x0
812:
	.long	7
	.p2align	2, 0x0
822:
	.long	8
	.p2align	2, 0x0
832:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	2, 0x0
842:
	.long	134217727
	.p2align	5, 0x0
852:
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
862:
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
872:
	.byte	1
	.p2align	5, 0x0
882:
	.zero	32,31
	.p2align	4, 0x0
892:
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
902:
	.byte	16
	.p2align	4, 0x0
912:
	.byte	32
	.p2align	5, 0x0
922:
	.long	1207959552
	.long	1342177280
	.long	1476395008
	.long	1610612736
	.long	1744830464
	.long	1879048192
	.long	2013265920
	.long	2147483648
	.p2align	5, 0x0
932:
	.long	134217728
	.long	268435456
	.long	402653184
	.long	536870912
	.long	671088640
	.long	805306368
	.long	939524096
	.long	1073741824
	.p2align	4, 0x0
942:
	.zero	16,63
	.p2align	5, 0x0
952:
	.zero	32,1

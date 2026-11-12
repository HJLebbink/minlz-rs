# minlz_exec_flat_delta of crates/minlz/mlir/exec64.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 584
	mov	r11, rdi
	mov	rax, qword ptr [rdi + 64]
	mov	r13, qword ptr [rdi + 80]
	mov	r14, qword ptr [rdi + 88]
	test	rax, rax
	jle	762f
	mov	rcx, qword ptr [r11]
	mov	rdx, qword ptr [r11 + 8]
	mov	qword ptr [rsp + 32], rdx
	mov	rdx, qword ptr [r11 + 16]
	mov	qword ptr [rsp + 264], rdx
	mov	r15, qword ptr [r11 + 96]
	lea	r9, [r11 + 512]
	lea	rdx, [r11 + 576]
	mov	qword ptr [rsp + 56], rdx
	mov	edx, 96
	mov	qword ptr [rsp + 104], rdx
	mov	edx, 7
	mov	qword ptr [rsp + 88], rdx
	mov	qword ptr [rsp + 120], 0
	vpxor	xmm13, xmm13, xmm13
	vbroadcastss	ymm0, dword ptr [rip + 772f]
	vmovups	ymmword ptr [rsp + 448], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 782f]
	vmovups	ymmword ptr [rsp + 416], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 792f]
	vmovups	ymmword ptr [rsp + 384], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 802f]
	vmovups	ymmword ptr [rsp + 352], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 812f]
	vmovups	ymmword ptr [rsp + 320], ymm0
	mov	rdi, r9
	xor	edx, edx
	mov	qword ptr [rsp + 48], rcx
	mov	qword ptr [rsp + 112], r9
	mov	qword ptr [rsp], r11
	mov	qword ptr [rsp + 272], rax
	jmp	12f
	.p2align	4
2:
	inc	qword ptr [rsp + 120]
	add	qword ptr [rsp + 104], 64
	add	qword ptr [rsp + 88], -64
	mov	rdi, qword ptr [rsp + 72]
	add	rdi, -64
	mov	rax, qword ptr [rsp + 272]
	mov	rdx, qword ptr [rsp + 280]
	cmp	rdx, rax
	mov	r9, qword ptr [rsp + 112]
	jge	762f
12:
	mov	qword ptr [rsp + 40], r15
	mov	qword ptr [rsp + 80], r14
	mov	qword ptr [rsp + 16], r13
	mov	rsi, rdx
	mov	rdx, rax
	sub	rdx, rsi
	cmp	rdx, 64
	mov	eax, 64
	mov	qword ptr [rsp + 224], rdx
	cmovb	rax, rdx
	mov	qword ptr [rsp + 96], rax
	mov	r8, qword ptr [r11 + 16]
	mov	r14, qword ptr [r11 + 24]
	mov	rbx, qword ptr [r11 + 32]
	mov	rax, qword ptr [r11 + 40]
	mov	qword ptr [rsp + 8], rax
	mov	r15, qword ptr [r11 + 64]
	mov	rax, qword ptr [r11 + 72]
	mov	qword ptr [rsp + 192], rax
	mov	r12, qword ptr [r11 + 96]
	mov	r10, qword ptr [r11 + 112]
	mov	rdx, qword ptr [r11 + 128]
	mov	rax, qword ptr [r11 + 136]
	mov	qword ptr [rsp + 128], rax
	lea	r11, [r15 + 7]
	lea	rax, [rsi + 64]
	mov	qword ptr [rsp + 280], rax
	cmp	rax, r11
	mov	qword ptr [rsp + 72], rdi
	mov	qword ptr [rsp + 24], rsi
	mov	qword ptr [rsp + 160], r12
	jbe	22f
	cmp	rsi, r11
	mov	rsi, r9
	jge	82f
	mov	rsi, qword ptr [rsp + 120]
	shl	rsi, 6
	mov	r12d, 7
	sub	r12, rsi
	add	r12, r15
	cmp	r12, 16
	mov	r13, qword ptr [rsp + 24]
	jb	72f
	add	rsi, r8
	mov	rdi, qword ptr [rsp]
	sub	rdi, rsi
	add	rdi, 511
	cmp	rdi, 127
	mov	rdi, qword ptr [rsp + 72]
	mov	r13, qword ptr [rsp + 24]
	jb	72f
	cmp	r12, 128
	jae	32f
	xor	ebp, ebp
	jmp	52f
	.p2align	4
22:
	add	r8, rsi
	mov	rsi, r8
	jmp	82f
32:
	mov	rbp, r12
	and	rbp, -128
	mov	rax, qword ptr [rsp + 24]
	lea	r13, [rax + rbp]
	mov	rax, qword ptr [rsp + 104]
	lea	rdi, [r8 + rax]
	mov	rax, qword ptr [rsp + 88]
	lea	r9, [r15 + rax]
	and	r9, -128
	xor	esi, esi
	mov	rax, qword ptr [rsp]
	.p2align	4
42:
	vmovups	ymm0, ymmword ptr [rdi + rsi - 96]
	vmovdqu	ymm1, ymmword ptr [rdi + rsi - 64]
	vmovups	ymm3, ymmword ptr [rdi + rsi - 32]
	vmovups	ymm4, ymmword ptr [rdi + rsi]
	vmovups	ymmword ptr [rax + rsi + 512], ymm0
	vmovdqu	ymmword ptr [rax + rsi + 544], ymm1
	vmovups	ymmword ptr [rax + rsi + 576], ymm3
	vmovups	ymmword ptr [rax + rsi + 608], ymm4
	sub	rsi, -128
	cmp	r9, rsi
	jne	42b
	cmp	r12, rbp
	mov	r9, qword ptr [rsp + 112]
	mov	rsi, r9
	mov	rdi, qword ptr [rsp + 72]
	je	82f
	test	r12b, 112
	je	72f
52:
	mov	rdi, r12
	and	rdi, -16
	mov	rax, qword ptr [rsp + 24]
	lea	r13, [rax + rdi]
	lea	rsi, [r8 + rax]
	add	r15, qword ptr [rsp + 88]
	and	r15, -16
	.p2align	4
62:
	vmovups	xmm0, xmmword ptr [rsi + rbp]
	vmovups	xmmword ptr [r9 + rbp], xmm0
	add	rbp, 16
	cmp	r15, rbp
	jne	62b
	cmp	r12, rdi
	mov	rsi, r9
	mov	rdi, qword ptr [rsp + 72]
	je	82f
	.p2align	4
72:
	movzx	esi, byte ptr [r8 + r13]
	mov	byte ptr [rdi + r13], sil
	inc	r13
	cmp	r11, r13
	jne	72b
	mov	rsi, r9
82:
	vmovdqu	ymm3, ymmword ptr [rsi]
	vmovdqu	ymm4, ymmword ptr [rsi + 32]
	vmovd	xmm0, dword ptr [rsp + 96]
	vpbroadcastb	ymm1, xmm0
	vpmaxub	ymm0, ymm1, ymmword ptr [rip + 822f]
	vpcmpeqb	ymm0, ymm1, ymm0
	vpmaxub	ymm5, ymm1, ymmword ptr [rip + 832f]
	vpcmpeqb	ymm1, ymm1, ymm5
	vpsllw	ymm5, ymm3, 6
	vpcmpgtb	ymm8, ymm13, ymm5
	vpsllw	ymm5, ymm4, 6
	vpcmpgtb	ymm9, ymm13, ymm5
	vpbroadcastb	ymm2, byte ptr [rip + 842f]
	vpand	ymm3, ymm3, ymm2
	vpand	ymm4, ymm4, ymm2
	vpcmpeqb	ymm5, ymm13, ymm4
	vpcmpeqb	ymm3, ymm13, ymm3
	movabs	r9, 72340172838076673
	mov	r15, r9
	#APP
	#NO_APP
	vpand	ymm4, ymm8, ymm2
	vpand	ymm8, ymm0, ymm4
	vpand	ymm4, ymm9, ymm2
	vpand	ymm4, ymm1, ymm4
	mov	rax, qword ptr [rsp]
	vmovdqu	ymmword ptr [rax + 544], ymm4
	vmovdqu	ymmword ptr [rax + 512], ymm8
	vmovq	rsi, xmm8
	mov	rdi, rsi
	imul	rdi, r15
	mov	r8, rdi
	sub	r8, rsi
	xor	rsi, r15
	shl	rsi, 7
	or	rsi, r8
	vmovq	xmm9, qword ptr [r14 + rdx]
	vmovq	xmm10, rsi
	vpshufb	xmm9, xmm9, xmm10
	shr	rdi, 56
	add	rdi, rdx
	vmovq	qword ptr [rax + 512], xmm9
	vpextrq	rsi, xmm8, 1
	mov	rdx, rsi
	imul	rdx, r15
	mov	r8, rdx
	sub	r8, rsi
	xor	rsi, r15
	shl	rsi, 7
	or	rsi, r8
	vmovq	xmm9, qword ptr [r14 + rdi]
	vmovq	xmm10, rsi
	vpshufb	xmm9, xmm9, xmm10
	shr	rdx, 56
	add	rdx, rdi
	vmovq	qword ptr [rax + 520], xmm9
	vextracti128	xmm8, ymm8, 1
	vmovq	rsi, xmm8
	mov	rdi, rsi
	imul	rdi, r15
	mov	r8, rdi
	sub	r8, rsi
	xor	rsi, r15
	shl	rsi, 7
	or	rsi, r8
	vmovq	xmm9, qword ptr [r14 + rdx]
	vmovq	xmm10, rsi
	vpshufb	xmm9, xmm9, xmm10
	shr	rdi, 56
	add	rdi, rdx
	vmovq	qword ptr [rax + 528], xmm9
	vpextrq	rsi, xmm8, 1
	mov	rdx, rsi
	imul	rdx, r15
	mov	r8, rdx
	sub	r8, rsi
	xor	rsi, r15
	shl	rsi, 7
	or	rsi, r8
	vmovq	xmm8, qword ptr [r14 + rdi]
	vmovq	xmm9, rsi
	vpshufb	xmm8, xmm8, xmm9
	shr	rdx, 56
	add	rdx, rdi
	vmovq	qword ptr [rax + 536], xmm8
	vmovq	rsi, xmm4
	mov	rdi, rsi
	imul	rdi, r15
	mov	r8, rdi
	sub	r8, rsi
	xor	rsi, r15
	shl	rsi, 7
	or	rsi, r8
	vmovq	xmm8, qword ptr [r14 + rdx]
	vmovq	xmm9, rsi
	vpshufb	xmm8, xmm8, xmm9
	shr	rdi, 56
	add	rdi, rdx
	vmovq	qword ptr [rax + 544], xmm8
	vpextrq	rsi, xmm4, 1
	mov	rdx, rsi
	imul	rdx, r15
	mov	r8, rdx
	sub	r8, rsi
	xor	rsi, r15
	shl	rsi, 7
	or	rsi, r8
	vmovq	xmm4, qword ptr [r14 + rdi]
	vmovq	xmm8, rsi
	vpshufb	xmm4, xmm4, xmm8
	shr	rdx, 56
	add	rdx, rdi
	vmovq	qword ptr [rax + 552], xmm4
	mov	rsi, qword ptr [rax + 560]
	mov	rdi, qword ptr [rax + 568]
	mov	r11, rsi
	imul	r11, r15
	mov	r8, r11
	sub	r8, rsi
	xor	rsi, r15
	shl	rsi, 7
	or	rsi, r8
	vmovq	xmm4, qword ptr [r14 + rdx]
	vmovq	xmm8, rsi
	vpshufb	xmm4, xmm4, xmm8
	shr	r11, 56
	add	r11, rdx
	vmovq	qword ptr [rax + 560], xmm4
	mov	rdx, rdi
	imul	rdx, r15
	mov	qword ptr [rsp + 64], rdx
	sub	rdx, rdi
	xor	r15, rdi
	shl	r15, 7
	or	r15, rdx
	vmovq	xmm4, qword ptr [r14 + r11]
	vmovq	xmm8, r15
	vpshufb	xmm4, xmm4, xmm8
	vmovq	qword ptr [rax + 568], xmm4
	vmovups	ymm4, ymmword ptr [rax + 544]
	vmovups	ymm8, ymmword ptr [rax + 512]
	vmovups	ymmword ptr [rax + 192], ymm8
	vmovups	ymmword ptr [rax + 224], ymm4
	mov	rdx, r9
	#APP
	#NO_APP
	vpand	ymm4, ymm5, ymm2
	vpand	ymm1, ymm1, ymm4
	vpand	ymm3, ymm3, ymm2
	vpand	ymm0, ymm0, ymm3
	vmovdqu	ymmword ptr [rax + 512], ymm0
	vmovdqu	ymmword ptr [rax + 544], ymm1
	vmovq	rsi, xmm0
	mov	r8, rdx
	imul	r8, rsi
	mov	rdi, r8
	sub	rdi, rsi
	xor	rsi, rdx
	shl	rsi, 7
	or	rsi, rdi
	mov	rdi, qword ptr [rsp + 128]
	vmovq	xmm3, qword ptr [rbx + rdi]
	vmovq	xmm4, rsi
	vpshufb	xmm3, xmm3, xmm4
	shr	r8, 56
	add	r8, rdi
	vmovq	qword ptr [rax + 512], xmm3
	vpextrq	rsi, xmm0, 1
	mov	rdi, rdx
	imul	rdi, rsi
	mov	r9, rdi
	sub	r9, rsi
	xor	rsi, rdx
	shl	rsi, 7
	or	rsi, r9
	vmovq	xmm3, qword ptr [rbx + r8]
	vmovq	xmm4, rsi
	vpshufb	xmm3, xmm3, xmm4
	shr	rdi, 56
	add	rdi, r8
	vmovq	qword ptr [rax + 520], xmm3
	vextracti128	xmm0, ymm0, 1
	vmovq	rsi, xmm0
	mov	r8, rdx
	imul	r8, rsi
	mov	r9, r8
	sub	r9, rsi
	xor	rsi, rdx
	shl	rsi, 7
	or	rsi, r9
	vmovq	xmm3, qword ptr [rbx + rdi]
	vmovq	xmm4, rsi
	vpshufb	xmm3, xmm3, xmm4
	shr	r8, 56
	add	r8, rdi
	vmovq	qword ptr [rax + 528], xmm3
	vpextrq	rsi, xmm0, 1
	mov	rdi, rdx
	imul	rdi, rsi
	mov	r9, rdi
	sub	r9, rsi
	xor	rsi, rdx
	shl	rsi, 7
	or	rsi, r9
	vmovq	xmm0, qword ptr [rbx + r8]
	vmovq	xmm3, rsi
	vpshufb	xmm0, xmm0, xmm3
	shr	rdi, 56
	add	rdi, r8
	vmovq	qword ptr [rax + 536], xmm0
	vmovq	rsi, xmm1
	mov	r8, rdx
	imul	r8, rsi
	mov	r9, r8
	sub	r9, rsi
	xor	rsi, rdx
	shl	rsi, 7
	or	rsi, r9
	vmovq	xmm0, qword ptr [rbx + rdi]
	vmovq	xmm3, rsi
	vpshufb	xmm0, xmm0, xmm3
	shr	r8, 56
	add	r8, rdi
	vmovq	qword ptr [rax + 544], xmm0
	vpextrq	rsi, xmm1, 1
	mov	rdi, rdx
	imul	rdi, rsi
	mov	r9, rdi
	sub	r9, rsi
	xor	rsi, rdx
	shl	rsi, 7
	or	rsi, r9
	vmovq	xmm0, qword ptr [rbx + r8]
	vmovq	xmm1, rsi
	vpshufb	xmm0, xmm0, xmm1
	shr	rdi, 56
	add	rdi, r8
	vmovq	qword ptr [rax + 552], xmm0
	mov	rsi, qword ptr [rax + 560]
	mov	r8, qword ptr [rax + 568]
	mov	r12, rsi
	imul	r12, rdx
	mov	r9, r12
	sub	r9, rsi
	xor	rsi, rdx
	shl	rsi, 7
	or	rsi, r9
	vmovq	xmm0, qword ptr [rbx + rdi]
	vmovq	xmm1, rsi
	vpshufb	xmm0, xmm0, xmm1
	shr	r12, 56
	add	r12, rdi
	vmovq	qword ptr [rax + 560], xmm0
	mov	r9, r8
	imul	r9, rdx
	mov	rsi, r9
	sub	rsi, r8
	xor	rdx, r8
	shl	rdx, 7
	or	rdx, rsi
	vmovq	xmm0, qword ptr [rbx + r12]
	vmovq	xmm1, rdx
	vpshufb	xmm0, xmm0, xmm1
	vmovq	qword ptr [rax + 568], xmm0
	vmovdqu	ymm7, ymmword ptr [rax + 512]
	vmovups	ymm0, ymmword ptr [rax + 544]
	vmovups	ymmword ptr [rsp + 480], ymm0
	vmovss	xmm0, dword ptr [rsp + 160]
	vbroadcastss	ymm0, xmm0
	vmovups	ymmword ptr [rsp + 160], ymm0
	vpmovzxbd	ymm3, qword ptr [rax + 520]
	vpmovzxbd	ymm8, qword ptr [rax + 512]
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
	mov	r13, qword ptr [rsp + 192]
	mov	edx, r13d
	and	edx, 7
	vmovd	xmm9, edx
	vpbroadcastd	ymm9, xmm9
	vpaddd	ymm4, ymm9, ymm4
	vpaddd	ymm9, ymm9, ymm5
	vpsrld	ymm14, ymm4, 3
	vpsrld	ymm15, ymm9, 3
	vpand	ymm11, ymm4, ymm1
	vpand	ymm5, ymm9, ymm1
	vbroadcasti128	ymm1, xmmword ptr [rip + 852f]
	vpshufb	ymm4, ymm14, ymm1
	vpshufb	ymm9, ymm15, ymm1
	vmovdqu	ymm1, ymmword ptr [rsp + 352]
	vpaddb	ymm4, ymm4, ymm1
	vpaddb	ymm9, ymm9, ymm1
	mov	rdx, r13
	shr	rdx, 3
	lea	rsi, [rdx + 64]
	cmp	rsi, r10
	vmovdqu	ymmword ptr [rsp + 512], ymm7
	vmovdqu	ymmword ptr [rsp + 128], ymm3
	vmovdqu	ymmword ptr [rsp + 288], ymm2
	vmovdqu	ymmword ptr [rsp + 544], ymm11
	vmovdqa	ymm11, ymm6
	jbe	92f
	mov	r8, r10
	sub	r8, rdx
	mov	rax, qword ptr [rsp + 56]
	mov	rsi, rax
	mov	rbp, qword ptr [rsp + 24]
	mov	rdi, qword ptr [rsp + 8]
	jbe	162f
	cmp	r8, 16
	mov	rbx, rdx
	jb	142f
	lea	r14, [rdx + rdi]
	mov	rsi, qword ptr [rsp]
	sub	rsi, r14
	add	rsi, 575
	cmp	rsi, 127
	mov	rbx, rdx
	jb	142f
	cmp	r8, 128
	jae	102f
	xor	r15d, r15d
	jmp	122f
	.p2align	4
92:
	mov	rdi, qword ptr [rsp + 8]
	add	rdx, rdi
	mov	rsi, rdx
	mov	rbp, qword ptr [rsp + 24]
	jmp	162f
102:
	mov	r15, r8
	and	r15, -128
	lea	rbx, [rdx + r15]
	lea	rdi, [rdi + rdx + 96]
	xor	esi, esi
	mov	rax, qword ptr [rsp]
	.p2align	4
112:
	vmovdqu	ymm14, ymmword ptr [rdi + rsi - 96]
	vmovdqu	ymm15, ymmword ptr [rdi + rsi - 64]
	vmovdqu	ymm6, ymmword ptr [rdi + rsi - 32]
	vmovdqu	ymm7, ymmword ptr [rdi + rsi]
	vmovdqu	ymmword ptr [rax + rsi + 576], ymm14
	vmovdqu	ymmword ptr [rax + rsi + 608], ymm15
	vmovdqu	ymmword ptr [rax + rsi + 640], ymm6
	vmovdqu	ymmword ptr [rax + rsi + 672], ymm7
	sub	rsi, -128
	cmp	r15, rsi
	jne	112b
	cmp	r8, r15
	mov	rax, qword ptr [rsp + 56]
	mov	rsi, rax
	mov	rdi, qword ptr [rsp + 8]
	je	162f
	test	r8b, 112
	je	142f
122:
	mov	rsi, r8
	and	rsi, -16
	lea	rbx, [rdx + rsi]
	.p2align	4
132:
	vmovdqu	xmm6, xmmword ptr [r14 + r15]
	vmovdqu	xmmword ptr [rax + r15], xmm6
	add	r15, 16
	cmp	rsi, r15
	jne	132b
	cmp	r8, rsi
	mov	rsi, rax
	je	162f
	.p2align	4
142:
	mov	rsi, rax
	sub	rsi, rdx
	.p2align	4
152:
	movzx	edx, byte ptr [rdi + rbx]
	mov	byte ptr [rsi + rbx], dl
	inc	rbx
	cmp	r10, rbx
	jne	152b
	mov	rsi, rax
162:
	vmovdqu	ymm6, ymmword ptr [rsi]
	vmovdqu	ymm7, ymmword ptr [rsi + 32]
	vpermq	ymm14, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm15, ymm14, ymm4
	vpshufb	ymm2, ymm6, ymm4
	vpbroadcastb	ymm3, byte ptr [rip + 862f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 872f]
	vpand	ymm8, ymm9, ymm3
	vpcmpeqb	ymm8, ymm8, ymm3
	vpblendvb	ymm6, ymm6, ymm7, ymm8
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm1, ymm2, ymm1, ymm4
	vpsrlvd	ymm2, ymm6, ymm5
	vpandn	ymm2, ymm11, ymm2
	vpaddd	ymm2, ymm2, ymm0
	vpsrlvd	ymm1, ymm1, ymmword ptr [rsp + 544]
	vmovdqu	ymm0, ymmword ptr [rsp + 288]
	vpandn	ymm1, ymm0, ymm1
	vpaddd	ymm1, ymm1, ymmword ptr [rsp + 128]
	vpor	ymm3, ymm1, ymmword ptr [rip + 882f]
	vpcmpeqd	ymm1, ymm13, ymm1
	vpandn	ymm1, ymm1, ymm3
	vpor	ymm3, ymm2, ymmword ptr [rip + 892f]
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
	vmovups	ymm0, ymmword ptr [rsp + 160]
	vblendvps	ymm1, ymm2, ymm0, ymm1
	vpand	ymm2, ymm3, ymm4
	vpcmpeqd	ymm3, ymm13, ymm3
	vblendvps	ymm0, ymm2, ymm0, ymm3
	vextracti128	xmm2, ymm12, 1
	vpextrd	edx, xmm2, 3
	mov	rax, qword ptr [rsp]
	vmovups	ymmword ptr [rax + 256], ymm0
	vmovups	ymmword ptr [rax + 288], ymm1
	vshufps	ymm0, ymm1, ymm1, 255
	vpermpd	ymm0, ymm0, 170
	add	r13, rdx
	cmp	qword ptr [rsp + 224], 17
	jb	412f
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
	mov	edx, r13d
	and	edx, 7
	vmovd	xmm5, edx
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm4, ymm5, ymm4
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm6, ymm4, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm5, ymm8, ymm4
	vpand	ymm8, ymm8, ymm2
	vbroadcasti128	ymm4, xmmword ptr [rip + 852f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm6, ymm7, ymm4
	vmovdqu	ymm7, ymmword ptr [rsp + 352]
	vpaddb	ymm4, ymm2, ymm7
	vpaddb	ymm9, ymm6, ymm7
	mov	rdx, r13
	shr	rdx, 3
	lea	rsi, [rdx + 64]
	cmp	rsi, r10
	vmovdqu	ymmword ptr [rsp + 160], ymm3
	vmovdqu	ymmword ptr [rsp + 128], ymm5
	vmovdqu	ymmword ptr [rsp + 288], ymm8
	vmovdqa	ymm5, ymm10
	jbe	172f
	mov	r8, r10
	sub	r8, rdx
	mov	rax, qword ptr [rsp + 56]
	mov	rsi, rax
	jbe	242f
	cmp	r8, 16
	mov	rbx, rdx
	jb	222f
	lea	r14, [rdx + rdi]
	mov	rsi, qword ptr [rsp]
	sub	rsi, r14
	add	rsi, 575
	cmp	rsi, 127
	mov	rbx, rdx
	jb	222f
	cmp	r8, 128
	jae	182f
	xor	r15d, r15d
	jmp	202f
	.p2align	4
172:
	add	rdx, rdi
	mov	rsi, rdx
	jmp	242f
182:
	mov	r15, r8
	and	r15, -128
	lea	rbx, [rdx + r15]
	lea	rdi, [rdi + rdx + 96]
	xor	esi, esi
	mov	rax, qword ptr [rsp]
	.p2align	4
192:
	vmovdqu	ymm2, ymmword ptr [rdi + rsi - 96]
	vmovdqu	ymm6, ymmword ptr [rdi + rsi - 64]
	vmovdqu	ymm7, ymmword ptr [rdi + rsi - 32]
	vmovdqu	ymm13, ymmword ptr [rdi + rsi]
	vmovdqu	ymmword ptr [rax + rsi + 576], ymm2
	vmovdqu	ymmword ptr [rax + rsi + 608], ymm6
	vmovdqu	ymmword ptr [rax + rsi + 640], ymm7
	vmovdqu	ymmword ptr [rax + rsi + 672], ymm13
	sub	rsi, -128
	cmp	r15, rsi
	jne	192b
	cmp	r8, r15
	mov	rax, qword ptr [rsp + 56]
	mov	rsi, rax
	mov	rdi, qword ptr [rsp + 8]
	je	242f
	test	r8b, 112
	je	222f
202:
	mov	rsi, r8
	and	rsi, -16
	lea	rbx, [rdx + rsi]
	.p2align	4
212:
	vmovdqu	xmm2, xmmword ptr [r14 + r15]
	vmovdqu	xmmword ptr [rax + r15], xmm2
	add	r15, 16
	cmp	rsi, r15
	jne	212b
	cmp	r8, rsi
	mov	rsi, rax
	je	242f
222:
	mov	rsi, rax
	sub	rsi, rdx
	.p2align	4
232:
	movzx	edx, byte ptr [rdi + rbx]
	mov	byte ptr [rsi + rbx], dl
	inc	rbx
	cmp	r10, rbx
	jne	232b
	mov	rsi, rax
242:
	vmovdqu	ymm2, ymmword ptr [rsi]
	vmovdqu	ymm6, ymmword ptr [rsi + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm13, ymm7, ymm4
	vpshufb	ymm14, ymm2, ymm4
	vpbroadcastb	ymm3, byte ptr [rip + 862f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 872f]
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
	vpsrlvd	ymm3, ymm4, ymmword ptr [rsp + 128]
	vpandn	ymm3, ymm0, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 160]
	vpor	ymm4, ymm3, ymmword ptr [rip + 882f]
	vpcmpeqd	ymm3, ymm13, ymm3
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 892f]
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
	vpextrd	edx, xmm1, 3
	mov	rax, qword ptr [rsp]
	vmovups	ymmword ptr [rax + 320], ymm0
	vmovups	ymmword ptr [rax + 352], ymm2
	vshufps	ymm0, ymm2, ymm2, 255
	vpermpd	ymm0, ymm0, 170
	add	r13, rdx
	cmp	qword ptr [rsp + 224], 33
	jb	412f
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
	vmovdqu	ymmword ptr [rsp + 128], ymm1
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
	mov	edx, r13d
	and	edx, 7
	vmovd	xmm5, edx
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm4, ymm5, ymm4
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm6, ymm4, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm5, ymm8, ymm4
	vpand	ymm11, ymm8, ymm2
	vbroadcasti128	ymm4, xmmword ptr [rip + 852f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm6, ymm7, ymm4
	vmovdqu	ymm7, ymmword ptr [rsp + 352]
	vpaddb	ymm4, ymm2, ymm7
	vpaddb	ymm9, ymm6, ymm7
	mov	rdx, r13
	shr	rdx, 3
	lea	rsi, [rdx + 64]
	cmp	rsi, r10
	jbe	252f
	mov	r8, r10
	sub	r8, rdx
	mov	rax, qword ptr [rsp + 56]
	mov	rsi, rax
	jbe	322f
	cmp	r8, 16
	mov	rbx, rdx
	jb	302f
	lea	r14, [rdx + rdi]
	mov	rsi, qword ptr [rsp]
	sub	rsi, r14
	add	rsi, 575
	cmp	rsi, 127
	mov	rbx, rdx
	jb	302f
	cmp	r8, 128
	jae	262f
	xor	r15d, r15d
	jmp	282f
252:
	add	rdx, rdi
	mov	rsi, rdx
	jmp	322f
262:
	mov	r15, r8
	and	r15, -128
	lea	rbx, [rdx + r15]
	lea	rdi, [rdi + rdx + 96]
	xor	esi, esi
	mov	rax, qword ptr [rsp]
	.p2align	4
272:
	vmovdqu	ymm2, ymmword ptr [rdi + rsi - 96]
	vmovdqu	ymm6, ymmword ptr [rdi + rsi - 64]
	vmovdqu	ymm7, ymmword ptr [rdi + rsi - 32]
	vmovdqu	ymm13, ymmword ptr [rdi + rsi]
	vmovdqu	ymmword ptr [rax + rsi + 576], ymm2
	vmovdqu	ymmword ptr [rax + rsi + 608], ymm6
	vmovdqu	ymmword ptr [rax + rsi + 640], ymm7
	vmovdqu	ymmword ptr [rax + rsi + 672], ymm13
	sub	rsi, -128
	cmp	r15, rsi
	jne	272b
	cmp	r8, r15
	mov	rax, qword ptr [rsp + 56]
	mov	rsi, rax
	mov	rdi, qword ptr [rsp + 8]
	je	322f
	test	r8b, 112
	je	302f
282:
	mov	rsi, r8
	and	rsi, -16
	lea	rbx, [rdx + rsi]
	.p2align	4
292:
	vmovdqu	xmm2, xmmword ptr [r14 + r15]
	vmovdqu	xmmword ptr [rax + r15], xmm2
	add	r15, 16
	cmp	rsi, r15
	jne	292b
	cmp	r8, rsi
	mov	rsi, rax
	je	322f
302:
	mov	rsi, rax
	sub	rsi, rdx
	.p2align	4
312:
	movzx	edx, byte ptr [rdi + rbx]
	mov	byte ptr [rsi + rbx], dl
	inc	rbx
	cmp	r10, rbx
	jne	312b
	mov	rsi, rax
322:
	vmovdqu	ymm2, ymmword ptr [rsi]
	vmovdqu	ymm6, ymmword ptr [rsi + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm13, ymm7, ymm4
	vpshufb	ymm14, ymm2, ymm4
	vpbroadcastb	ymm3, byte ptr [rip + 862f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 872f]
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
	vmovdqu	ymm4, ymmword ptr [rsp + 128]
	vpandn	ymm3, ymm4, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 192]
	vpor	ymm4, ymm3, ymmword ptr [rip + 882f]
	vpcmpeqd	ymm3, ymm13, ymm3
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 892f]
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
	vpextrd	edx, xmm1, 3
	mov	rax, qword ptr [rsp]
	vmovups	ymmword ptr [rax + 384], ymm0
	vmovups	ymmword ptr [rax + 416], ymm2
	vshufps	ymm0, ymm2, ymm2, 255
	vpermpd	ymm0, ymm0, 170
	add	r13, rdx
	cmp	qword ptr [rsp + 224], 49
	jb	412f
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
	vmovdqu	ymmword ptr [rsp + 224], ymm1
	vpsllvd	ymm1, ymm7, ymm5
	vmovdqu	ymmword ptr [rsp + 128], ymm1
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
	mov	edx, r13d
	and	edx, 7
	vmovd	xmm5, edx
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm4, ymm5, ymm4
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm6, ymm4, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm5, ymm8, ymm4
	vpand	ymm11, ymm8, ymm2
	vbroadcasti128	ymm4, xmmword ptr [rip + 852f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm6, ymm7, ymm4
	vmovdqu	ymm7, ymmword ptr [rsp + 352]
	vpaddb	ymm4, ymm2, ymm7
	vpaddb	ymm9, ymm6, ymm7
	mov	rdx, r13
	shr	rdx, 3
	lea	rsi, [rdx + 64]
	cmp	rsi, r10
	jbe	332f
	mov	r8, r10
	sub	r8, rdx
	mov	rax, qword ptr [rsp + 56]
	mov	rsi, rax
	jbe	402f
	cmp	r8, 16
	mov	rbx, rdx
	jb	382f
	lea	r14, [rdx + rdi]
	mov	rsi, qword ptr [rsp]
	sub	rsi, r14
	add	rsi, 575
	cmp	rsi, 127
	mov	rbx, rdx
	jb	382f
	cmp	r8, 128
	jae	342f
	xor	r15d, r15d
	jmp	362f
332:
	add	rdi, rdx
	mov	rsi, rdi
	jmp	402f
342:
	mov	r15, r8
	and	r15, -128
	lea	rbx, [rdx + r15]
	lea	rdi, [rdi + rdx + 96]
	xor	esi, esi
	mov	rax, qword ptr [rsp]
	.p2align	4
352:
	vmovdqu	ymm2, ymmword ptr [rdi + rsi - 96]
	vmovdqu	ymm6, ymmword ptr [rdi + rsi - 64]
	vmovdqu	ymm7, ymmword ptr [rdi + rsi - 32]
	vmovdqu	ymm13, ymmword ptr [rdi + rsi]
	vmovdqu	ymmword ptr [rax + rsi + 576], ymm2
	vmovdqu	ymmword ptr [rax + rsi + 608], ymm6
	vmovdqu	ymmword ptr [rax + rsi + 640], ymm7
	vmovdqu	ymmword ptr [rax + rsi + 672], ymm13
	sub	rsi, -128
	cmp	r15, rsi
	jne	352b
	cmp	r8, r15
	mov	rax, qword ptr [rsp + 56]
	mov	rsi, rax
	mov	rdi, qword ptr [rsp + 8]
	je	402f
	test	r8b, 112
	je	382f
362:
	mov	rsi, r8
	and	rsi, -16
	lea	rbx, [rdx + rsi]
	.p2align	4
372:
	vmovdqu	xmm2, xmmword ptr [r14 + r15]
	vmovdqu	xmmword ptr [rax + r15], xmm2
	add	r15, 16
	cmp	rsi, r15
	jne	372b
	cmp	r8, rsi
	mov	rsi, rax
	je	402f
382:
	mov	rsi, rax
	sub	rsi, rdx
	.p2align	4
392:
	movzx	edx, byte ptr [rdi + rbx]
	mov	byte ptr [rsi + rbx], dl
	inc	rbx
	cmp	r10, rbx
	jne	392b
	mov	rsi, rax
402:
	vmovdqu	ymm2, ymmword ptr [rsi]
	vmovdqu	ymm6, ymmword ptr [rsi + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm13, ymm7, ymm4
	vpshufb	ymm14, ymm2, ymm4
	vpbroadcastb	ymm3, byte ptr [rip + 862f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 872f]
	vpand	ymm7, ymm9, ymm3
	vpcmpeqb	ymm7, ymm7, ymm3
	vpblendvb	ymm2, ymm2, ymm6, ymm7
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm4, ymm13, ymm8, ymm4
	vpxor	xmm13, xmm13, xmm13
	vpsrlvd	ymm2, ymm2, ymm11
	vmovdqu	ymm3, ymmword ptr [rsp + 128]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 192]
	vpsrlvd	ymm3, ymm4, ymm5
	vmovdqu	ymm4, ymmword ptr [rsp + 160]
	vpandn	ymm3, ymm4, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 224]
	vpor	ymm4, ymm3, ymmword ptr [rip + 882f]
	vpcmpeqd	ymm3, ymm13, ymm3
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 892f]
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
	vpextrd	edx, xmm1, 3
	mov	rax, qword ptr [rsp]
	vmovups	ymmword ptr [rax + 448], ymm0
	vmovups	ymmword ptr [rax + 480], ymm2
	vshufps	ymm0, ymm2, ymm2, 255
	vpermpd	ymm0, ymm0, 170
	add	r13, rdx
	.p2align	4
412:
	mov	r14, qword ptr [rsp + 16]
	mov	r15, qword ptr [rsp + 40]
	mov	rax, qword ptr [rsp + 64]
	shr	r9, 56
	add	r9, r12
	shr	rax, 56
	add	rax, r11
	vmovd	edx, xmm0
	mov	r11, qword ptr [rsp]
	mov	qword ptr [r11 + 72], r13
	mov	qword ptr [r11 + 96], rdx
	mov	qword ptr [r11 + 128], rax
	mov	qword ptr [r11 + 136], r9
	add	rbp, qword ptr [rsp + 264]
	mov	r10, qword ptr [rsp + 96]
	and	r10, 124
	je	672f
	xor	r9d, r9d
	mov	r12, qword ptr [rsp + 80]
	mov	qword ptr [rsp + 24], rbp
	mov	qword ptr [rsp + 224], r10
	.p2align	4
422:
	movzx	r10d, byte ptr [rbp + r9]
	movzx	esi, byte ptr [r11 + r9 + 192]
	cmp	r15, 33
	mov	eax, 32
	cmovb	r15, rax
	mov	rdx, r14
	sub	rdx, r15
	mov	edi, 0
	cmovae	rdi, rdx
	cmp	rsi, 33
	mov	edx, dword ptr [r11 + 4*r9 + 256]
	vmovdqu	ymm0, ymmword ptr [rcx + rdi]
	mov	rax, qword ptr [rsp + 32]
	vpaddb	ymm0, ymm0, ymmword ptr [rax + r12]
	vmovdqu	ymmword ptr [rcx + r14], ymm0
	jae	512f
432:
	mov	r8d, r10d
	mov	qword ptr [rsp + 16], r14
	lea	rbx, [rsi + r14]
	shr	r10d, 2
	cmp	r10, 32
	mov	edi, 32
	cmovb	rdi, r10
	cmp	rdx, rdi
	cmova	rdi, rdx
	mov	r14, rbx
	sub	r14, rdi
	mov	r15d, 0
	cmovae	r15, r14
	vmovups	ymm0, ymmword ptr [rcx + r15]
	vmovups	ymmword ptr [rcx + rbx], ymm0
	cmp	r8b, -124
	jae	532f
442:
	lea	rdi, [r9 + 1]
	mov	qword ptr [rsp + 80], r12
	add	r12, rsi
	add	rbx, r10
	cmp	rdx, 33
	mov	eax, 32
	cmovb	rdx, rax
	mov	r8, rbx
	sub	r8, rdx
	mov	edx, 0
	cmovae	rdx, r8
	movzx	r14d, byte ptr [rbp + rdi]
	vmovdqu	ymm0, ymmword ptr [rcx + rdx]
	movzx	r15d, byte ptr [r11 + rdi + 192]
	cmp	r15, 33
	mov	edi, dword ptr [r11 + 4*rdi + 256]
	mov	rax, qword ptr [rsp + 32]
	vpaddb	ymm0, ymm0, ymmword ptr [rax + r12]
	vmovdqu	ymmword ptr [rcx + rbx], ymm0
	jae	552f
452:
	mov	r8d, r14d
	add	rbx, r15
	shr	r14d, 2
	cmp	r14, 32
	mov	edx, 32
	cmovb	rdx, r14
	cmp	rdi, rdx
	cmova	rdx, rdi
	mov	r13, rbx
	sub	r13, rdx
	mov	ebp, 0
	cmovae	rbp, r13
	vmovups	ymm0, ymmword ptr [rcx + rbp]
	vmovups	ymmword ptr [rcx + rbx], ymm0
	cmp	r8b, -124
	jae	572f
462:
	lea	r8, [r9 + 2]
	add	r12, r15
	add	rbx, r14
	mov	rax, qword ptr [rsp + 24]
	movzx	ebp, byte ptr [rax + r8]
	movzx	edx, byte ptr [r11 + r8 + 192]
	cmp	rdi, 33
	mov	eax, 32
	cmovb	rdi, rax
	mov	r13, rbx
	sub	r13, rdi
	mov	eax, 0
	cmovae	rax, r13
	cmp	rdx, 33
	mov	edi, dword ptr [r11 + 4*r8 + 256]
	vmovdqu	ymm0, ymmword ptr [rcx + rax]
	mov	rax, qword ptr [rsp + 32]
	vpaddb	ymm0, ymm0, ymmword ptr [rax + r12]
	vmovdqu	ymmword ptr [rcx + rbx], ymm0
	jae	592f
472:
	mov	qword ptr [rsp + 8], r15
	mov	eax, ebp
	add	rbx, rdx
	shr	ebp, 2
	cmp	rbp, 32
	mov	r8d, 32
	cmovb	r8, rbp
	cmp	rdi, r8
	cmova	r8, rdi
	mov	r13, rbx
	sub	r13, r8
	mov	ecx, 0
	cmovae	rcx, r13
	mov	r15, qword ptr [rsp + 48]
	vmovups	ymm0, ymmword ptr [r15 + rcx]
	mov	r15, qword ptr [rsp + 48]
	vmovups	ymmword ptr [r15 + rbx], ymm0
	cmp	al, -124
	jae	612f
482:
	mov	qword ptr [rsp + 40], rsi
	lea	rax, [r9 + 3]
	add	r12, rdx
	add	rbx, rbp
	mov	rcx, qword ptr [rsp + 24]
	movzx	r13d, byte ptr [rcx + rax]
	movzx	r8d, byte ptr [r11 + rax + 192]
	cmp	rdi, 33
	mov	ecx, 32
	cmovb	rdi, rcx
	mov	rcx, rbx
	sub	rcx, rdi
	mov	edi, 0
	cmovae	rdi, rcx
	cmp	r8, 33
	mov	ecx, dword ptr [r11 + 4*rax + 256]
	vmovdqu	ymm0, ymmword ptr [r15 + rdi]
	mov	rax, qword ptr [rsp + 32]
	vpaddb	ymm0, ymm0, ymmword ptr [rax + r12]
	vmovdqu	ymmword ptr [r15 + rbx], ymm0
	jae	632f
492:
	mov	eax, r13d
	add	rbx, r8
	shr	r13d, 2
	cmp	r13, 32
	mov	edi, 32
	cmovb	rdi, r13
	cmp	rcx, rdi
	mov	rsi, rcx
	cmova	rdi, rcx
	mov	rcx, rbx
	sub	rcx, rdi
	mov	r11d, 0
	cmovae	r11, rcx
	vmovups	ymm0, ymmword ptr [r15 + r11]
	mov	r11, qword ptr [rsp]
	vmovups	ymmword ptr [r15 + rbx], ymm0
	cmp	al, -124
	mov	rcx, r15
	jae	652f
502:
	add	r8, r12
	add	r13, rbx
	add	r9, 4
	mov	r10, qword ptr [rsp + 224]
	cmp	r9, r10
	mov	r12, r8
	mov	r14, r13
	mov	rbp, qword ptr [rsp + 24]
	mov	r15, rsi
	jb	422b
	jmp	682f
512:
	mov	rax, qword ptr [rsp + 32]
	lea	rdi, [rax + r12]
	lea	r8, [rcx + r14]
	mov	rax, qword ptr [rsp]
	mov	r11, qword ptr [rax + 48]
	mov	rax, qword ptr [rsp]
	mov	rbx, qword ptr [rax + 120]
	movzx	esi, byte ptr [r11 + rbx]
	mov	r11, qword ptr [rsp]
	inc	rbx
	mov	qword ptr [r11 + 120], rbx
	add	rsi, 33
	mov	ebx, 32
	.p2align	4
522:
	vmovdqu	ymm0, ymmword ptr [rdi + rbx]
	vmovdqu	ymmword ptr [r8 + rbx], ymm0
	add	rbx, 32
	cmp	rbx, rsi
	jb	522b
	jmp	432b
532:
	lea	r8, [rcx + rbx]
	mov	r10, qword ptr [r11 + 48]
	mov	r14, qword ptr [r11 + 120]
	movzx	r10d, byte ptr [r10 + r14]
	inc	r14
	mov	qword ptr [r11 + 120], r14
	add	r10, 33
	cmp	rdi, rbx
	cmovae	rdi, rbx
	mov	r14, r8
	sub	r14, rdi
	mov	edi, 32
	.p2align	4
542:
	vmovups	ymm0, ymmword ptr [r14 + rdi]
	vmovups	ymmword ptr [r8 + rdi], ymm0
	add	rdi, 32
	cmp	rdi, r10
	jb	542b
	jmp	442b
552:
	mov	rax, qword ptr [rsp + 32]
	lea	rdx, [rax + r12]
	mov	r8, qword ptr [r11 + 48]
	mov	r13, qword ptr [r11 + 120]
	movzx	r15d, byte ptr [r8 + r13]
	inc	r13
	mov	qword ptr [r11 + 120], r13
	add	r15, 33
	lea	r8, [rcx + rbx]
	mov	r13d, 32
	.p2align	4
562:
	vmovdqu	ymm0, ymmword ptr [rdx + r13]
	vmovdqu	ymmword ptr [r8 + r13], ymm0
	add	r13, 32
	cmp	r13, r15
	jb	562b
	jmp	452b
572:
	lea	r8, [rcx + rbx]
	mov	r14, qword ptr [r11 + 48]
	mov	r13, qword ptr [r11 + 120]
	movzx	r14d, byte ptr [r14 + r13]
	inc	r13
	mov	qword ptr [r11 + 120], r13
	add	r14, 33
	mov	rax, qword ptr [rsp + 16]
	lea	r13, [r15 + rax]
	add	r13, r10
	add	r13, rsi
	cmp	rdx, rbx
	cmovae	rdx, rbx
	sub	r13, rdx
	add	r13, rcx
	mov	edx, 32
	.p2align	4
582:
	vmovups	ymm0, ymmword ptr [r13 + rdx]
	vmovups	ymmword ptr [r8 + rdx], ymm0
	add	rdx, 32
	cmp	rdx, r14
	jb	582b
	jmp	462b
592:
	mov	rax, qword ptr [r11 + 48]
	mov	r8, qword ptr [r11 + 120]
	movzx	edx, byte ptr [rax + r8]
	inc	r8
	mov	qword ptr [r11 + 120], r8
	add	rdx, 33
	lea	r8, [r14 + r15]
	add	r8, r10
	add	r8, rsi
	add	r8, qword ptr [rsp + 16]
	add	r8, rcx
	mov	rax, qword ptr [rsp + 32]
	add	rax, r12
	mov	r13d, 32
	.p2align	4
602:
	vmovdqu	ymm0, ymmword ptr [rax + r13]
	vmovdqu	ymmword ptr [r8 + r13], ymm0
	add	r13, 32
	cmp	r13, rdx
	jb	602b
	jmp	472b
612:
	lea	rax, [r15 + rbx]
	mov	qword ptr [rsp + 40], rax
	mov	rax, qword ptr [r11 + 48]
	mov	rcx, qword ptr [r11 + 120]
	movzx	ebp, byte ptr [rax + rcx]
	inc	rcx
	mov	qword ptr [r11 + 120], rcx
	mov	r15, qword ptr [rsp + 48]
	add	rbp, 33
	lea	r13, [rdx + r14]
	add	r13, r10
	add	r13, rsi
	mov	rax, qword ptr [rsp + 16]
	mov	rcx, qword ptr [rsp + 8]
	add	rax, rcx
	add	r13, rax
	mov	rax, qword ptr [rsp + 40]
	cmp	r8, rbx
	cmovae	r8, rbx
	sub	r13, r8
	add	r13, r15
	mov	r8d, 32
	.p2align	4
622:
	vmovups	ymm0, ymmword ptr [r13 + r8]
	vmovups	ymmword ptr [rax + r8], ymm0
	add	r8, 32
	cmp	r8, rbp
	jb	622b
	jmp	482b
632:
	mov	rsi, rcx
	mov	rax, qword ptr [r11 + 48]
	mov	rcx, qword ptr [r11 + 120]
	movzx	r8d, byte ptr [rax + rcx]
	inc	rcx
	mov	qword ptr [r11 + 120], rcx
	add	r8, 33
	mov	rdi, qword ptr [rsp + 40]
	lea	rcx, [rbp + rdx]
	add	rcx, r10
	add	rcx, rdi
	mov	rax, qword ptr [rsp + 8]
	lea	r11, [r14 + rax]
	add	r11, qword ptr [rsp + 16]
	add	r11, rcx
	add	r11, r15
	add	rax, rdi
	mov	rcx, qword ptr [rsp + 80]
	add	rcx, rdx
	add	rcx, rax
	add	rcx, qword ptr [rsp + 32]
	mov	edi, 32
	.p2align	4
642:
	vmovdqu	ymm0, ymmword ptr [rcx + rdi]
	vmovdqu	ymmword ptr [r11 + rdi], ymm0
	add	rdi, 32
	cmp	rdi, r8
	jb	642b
	mov	r15, qword ptr [rsp + 48]
	mov	rcx, rsi
	jmp	492b
652:
	lea	r15, [rcx + rbx]
	mov	rax, qword ptr [r11 + 48]
	mov	rcx, qword ptr [r11 + 120]
	movzx	r13d, byte ptr [rax + rcx]
	inc	rcx
	mov	qword ptr [r11 + 120], rcx
	mov	rcx, qword ptr [rsp + 48]
	add	r13, 33
	add	r10, qword ptr [rsp + 40]
	add	rbp, r8
	add	rbp, r10
	add	rdx, r14
	add	rdx, qword ptr [rsp + 8]
	add	rdx, rbp
	add	rdx, qword ptr [rsp + 16]
	cmp	rdi, rbx
	cmovae	rdi, rbx
	sub	rdx, rdi
	add	rdx, rcx
	mov	eax, 32
	.p2align	4
662:
	vmovups	ymm0, ymmword ptr [rdx + rax]
	vmovups	ymmword ptr [r15 + rax], ymm0
	add	rax, 32
	cmp	rax, r13
	jb	662b
	jmp	502b
	.p2align	4
672:
	mov	r13, r14
	mov	r8, qword ptr [rsp + 80]
682:
	mov	rbx, qword ptr [rsp + 96]
	cmp	r10, rbx
	mov	r14, r8
	je	2b
	.p2align	4
692:
	movzx	edx, byte ptr [rbp + r10]
	movzx	r8d, byte ptr [r11 + r10 + 192]
	cmp	r15, 33
	mov	eax, 32
	cmovb	r15, rax
	mov	rax, r13
	sub	rax, r15
	mov	ecx, 0
	cmovae	rcx, rax
	cmp	r8, 33
	mov	r15d, dword ptr [r11 + 4*r10 + 256]
	mov	rax, qword ptr [rsp + 48]
	vmovdqu	ymm0, ymmword ptr [rax + rcx]
	mov	rax, qword ptr [rsp + 48]
	mov	rcx, qword ptr [rsp + 32]
	vpaddb	ymm0, ymm0, ymmword ptr [rcx + r14]
	vmovdqu	ymmword ptr [rax + r13], ymm0
	jae	722f
702:
	mov	eax, edx
	add	r13, r8
	shr	edx, 2
	cmp	rdx, 32
	mov	edi, 32
	cmovb	rdi, rdx
	cmp	r15, rdi
	cmova	rdi, r15
	mov	rcx, r13
	sub	rcx, rdi
	mov	r9d, 0
	cmovae	r9, rcx
	mov	rcx, qword ptr [rsp + 48]
	vmovups	ymm0, ymmword ptr [rcx + r9]
	vmovups	ymmword ptr [rcx + r13], ymm0
	cmp	al, -124
	jae	742f
712:
	add	r14, r8
	add	r13, rdx
	inc	r10
	cmp	r10, rbx
	jb	692b
	jmp	2b
722:
	mov	rsi, r10
	mov	rcx, qword ptr [rsp + 32]
	lea	rdi, [rcx + r14]
	lea	r9, [rax + r13]
	mov	rax, qword ptr [r11 + 48]
	mov	rcx, qword ptr [r11 + 120]
	movzx	r8d, byte ptr [rax + rcx]
	inc	rcx
	mov	qword ptr [r11 + 120], rcx
	add	r8, 33
	mov	r10d, 32
	.p2align	4
732:
	vmovdqu	ymm0, ymmword ptr [rdi + r10]
	vmovdqu	ymmword ptr [r9 + r10], ymm0
	add	r10, 32
	cmp	r10, r8
	jb	732b
	mov	r10, rsi
	jmp	702b
742:
	mov	rsi, r10
	lea	r9, [rcx + r13]
	mov	rax, qword ptr [r11 + 48]
	mov	rcx, qword ptr [r11 + 120]
	movzx	edx, byte ptr [rax + rcx]
	inc	rcx
	mov	qword ptr [r11 + 120], rcx
	add	rdx, 33
	cmp	rdi, r13
	cmovae	rdi, r13
	mov	r10, r9
	sub	r10, rdi
	mov	edi, 32
	.p2align	4
752:
	vmovups	ymm0, ymmword ptr [r10 + rdi]
	vmovups	ymmword ptr [r9 + rdi], ymm0
	add	rdi, 32
	cmp	rdi, rdx
	jb	752b
	mov	rcx, qword ptr [rsp + 48]
	mov	r10, rsi
	jmp	712b
762:
	mov	qword ptr [r11 + 80], r13
	mov	qword ptr [r11 + 88], r14
	add	rsp, 584
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	vzeroupper
	ret
	.p2align	2, 0x0
772:
	.long	1
	.p2align	2, 0x0
782:
	.long	7
	.p2align	2, 0x0
792:
	.long	8
	.p2align	2, 0x0
802:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	2, 0x0
812:
	.long	134217727
	.p2align	5, 0x0
822:
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
832:
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
842:
	.byte	1
	.p2align	4, 0x0
852:
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
862:
	.byte	16
	.p2align	2, 0x0
872:
	.byte	32
	.p2align	5, 0x0
882:
	.long	1207959552
	.long	1342177280
	.long	1476395008
	.long	1610612736
	.long	1744830464
	.long	1879048192
	.long	2013265920
	.long	2147483648
	.p2align	5, 0x0
892:
	.long	134217728
	.long	268435456
	.long	402653184
	.long	536870912
	.long	671088640
	.long	805306368
	.long	939524096
	.long	1073741824

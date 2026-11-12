# minlz_exec_plain of crates/minlz/mlir/exec64.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 488
	mov	r15, qword ptr [rdi]
	mov	rax, qword ptr [rdi + 8]
	mov	rcx, qword ptr [rdi + 64]
	mov	rdx, qword ptr [rdi + 80]
	add	rdx, r15
	mov	rsi, qword ptr [rdi + 88]
	mov	qword ptr [rsp + 176], rax
	add	rsi, rax
	test	rcx, rcx
	jle	562f
	lea	rax, [rdi + 512]
	mov	r8d, 96
	mov	qword ptr [rsp + 32], r8
	mov	r8d, 7
	mov	qword ptr [rsp + 24], r8
	xor	r8d, r8d
	vpxor	xmm7, xmm7, xmm7
	vbroadcastss	ymm0, dword ptr [rip + 572f]
	vmovups	ymmword ptr [rsp + 384], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 582f]
	vmovups	ymmword ptr [rsp + 352], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 592f]
	vmovups	ymmword ptr [rsp + 320], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 602f]
	vmovups	ymmword ptr [rsp + 288], ymm0
	vpbroadcastd	ymm0, dword ptr [rip + 612f]
	vmovdqu	ymmword ptr [rsp + 256], ymm0
	mov	rbp, rcx
	xor	r10d, r10d
	mov	qword ptr [rsp + 192], r15
	mov	qword ptr [rsp + 184], rcx
	jmp	12f
	.p2align	4
2:
	mov	rbp, qword ptr [rsp + 208]
	add	rbp, -64
	mov	r8, qword ptr [rsp + 216]
	inc	r8
	add	qword ptr [rsp + 32], 64
	add	qword ptr [rsp + 24], -64
	mov	rax, qword ptr [rsp + 40]
	add	rax, -64
	mov	rcx, qword ptr [rsp + 184]
	mov	r10, qword ptr [rsp + 200]
	cmp	r10, rcx
	jge	562f
12:
	mov	qword ptr [rsp + 40], rax
	cmp	rbp, 1
	mov	qword ptr [rsp + 208], rbp
	adc	rbp, 0
	cmp	rbp, 64
	mov	eax, 64
	cmovae	rbp, rax
	sub	rcx, r10
	cmp	rcx, 64
	mov	r11d, 64
	mov	qword ptr [rsp + 224], rcx
	cmovb	r11, rcx
	mov	r12, qword ptr [rdi + 16]
	mov	r14, qword ptr [rdi + 24]
	mov	rax, qword ptr [rdi + 32]
	mov	qword ptr [rsp + 80], rax
	mov	rax, qword ptr [rdi + 40]
	mov	qword ptr [rsp], rax
	mov	rbx, qword ptr [rdi + 64]
	mov	rax, qword ptr [rdi + 72]
	mov	qword ptr [rsp + 16], rax
	mov	rax, qword ptr [rdi + 96]
	mov	qword ptr [rsp + 112], rax
	mov	rax, qword ptr [rdi + 112]
	mov	qword ptr [rsp + 8], rax
	mov	rax, qword ptr [rdi + 128]
	mov	qword ptr [rsp + 144], rax
	mov	rax, qword ptr [rdi + 136]
	mov	qword ptr [rsp + 48], rax
	lea	r13, [rbx + 7]
	lea	rax, [r10 + 64]
	mov	qword ptr [rsp + 200], rax
	cmp	rax, r13
	mov	qword ptr [rsp + 216], r8
	jbe	52f
	cmp	r10, r13
	lea	rax, [rdi + 512]
	jge	62f
	mov	rax, r8
	shl	rax, 6
	mov	r8d, 7
	sub	r8, rax
	add	r8, rbx
	cmp	r8, 16
	jb	22f
	add	rax, r12
	mov	rcx, rdi
	sub	rcx, rax
	add	rcx, 511
	cmp	rcx, 127
	jae	82f
22:
	mov	r15, r10
32:
	mov	rcx, qword ptr [rsp + 40]
	.p2align	4
42:
	movzx	eax, byte ptr [r12 + r15]
	mov	byte ptr [rcx + r15], al
	inc	r15
	cmp	r13, r15
	jne	42b
	lea	rax, [rdi + 512]
	jmp	62f
	.p2align	4
52:
	add	r12, r10
	mov	rax, r12
62:
	vmovdqu	ymm0, ymmword ptr [rax]
	vmovdqu	ymm1, ymmword ptr [rax + 32]
	vmovd	xmm3, r11d
	vpbroadcastb	ymm4, xmm3
	vpmaxub	ymm3, ymm4, ymmword ptr [rip + 622f]
	vpcmpeqb	ymm3, ymm4, ymm3
	vpmaxub	ymm5, ymm4, ymmword ptr [rip + 632f]
	vpcmpeqb	ymm8, ymm4, ymm5
	vpsllw	ymm4, ymm0, 6
	vpcmpgtb	ymm4, ymm7, ymm4
	vpsllw	ymm5, ymm1, 6
	vpcmpgtb	ymm11, ymm7, ymm5
	vpbroadcastb	ymm2, byte ptr [rip + 642f]
	vpand	ymm5, ymm0, ymm2
	vpand	ymm10, ymm1, ymm2
	vpcmpeqb	ymm12, ymm10, ymm7
	vpcmpeqb	ymm10, ymm5, ymm7
	movabs	rbx, 72340172838076673
	mov	r15, rbx
	#APP
	#NO_APP
	vpand	ymm4, ymm4, ymm2
	vpand	ymm5, ymm3, ymm4
	vpand	ymm4, ymm11, ymm2
	vpand	ymm4, ymm8, ymm4
	vmovdqu	ymmword ptr [rdi + 544], ymm4
	vmovdqu	ymmword ptr [rdi + 512], ymm5
	vmovq	rax, xmm5
	mov	r9, rax
	imul	r9, r15
	mov	rcx, r9
	sub	rcx, rax
	xor	rax, r15
	shl	rax, 7
	or	rax, rcx
	mov	rcx, qword ptr [rsp + 144]
	vmovq	xmm11, qword ptr [r14 + rcx]
	vmovq	xmm13, rax
	vpshufb	xmm11, xmm11, xmm13
	shr	r9, 56
	add	r9, rcx
	vmovq	qword ptr [rdi + 512], xmm11
	vpextrq	rcx, xmm5, 1
	mov	rax, rcx
	imul	rax, r15
	mov	r8, rax
	sub	r8, rcx
	xor	rcx, r15
	shl	rcx, 7
	or	rcx, r8
	vmovq	xmm11, qword ptr [r14 + r9]
	vmovq	xmm13, rcx
	vpshufb	xmm11, xmm11, xmm13
	shr	rax, 56
	add	rax, r9
	vmovq	qword ptr [rdi + 520], xmm11
	vextracti128	xmm5, ymm5, 1
	vmovq	rcx, xmm5
	mov	r9, rcx
	imul	r9, r15
	mov	r8, r9
	sub	r8, rcx
	xor	rcx, r15
	shl	rcx, 7
	or	rcx, r8
	vmovq	xmm11, qword ptr [r14 + rax]
	vmovq	xmm13, rcx
	vpshufb	xmm11, xmm11, xmm13
	shr	r9, 56
	add	r9, rax
	vmovq	qword ptr [rdi + 528], xmm11
	vpextrq	rcx, xmm5, 1
	mov	rax, rcx
	imul	rax, r15
	mov	r8, rax
	sub	r8, rcx
	xor	rcx, r15
	shl	rcx, 7
	or	rcx, r8
	vmovq	xmm5, qword ptr [r14 + r9]
	vmovq	xmm11, rcx
	vpshufb	xmm5, xmm5, xmm11
	shr	rax, 56
	add	rax, r9
	vmovq	qword ptr [rdi + 536], xmm5
	vmovq	rcx, xmm4
	mov	r9, rcx
	imul	r9, r15
	mov	r8, r9
	sub	r8, rcx
	xor	rcx, r15
	shl	rcx, 7
	or	rcx, r8
	vmovq	xmm5, qword ptr [r14 + rax]
	vmovq	xmm11, rcx
	vpshufb	xmm5, xmm5, xmm11
	shr	r9, 56
	add	r9, rax
	vmovq	qword ptr [rdi + 544], xmm5
	vpextrq	rcx, xmm4, 1
	mov	rax, rcx
	imul	rax, r15
	mov	r8, rax
	sub	r8, rcx
	xor	rcx, r15
	shl	rcx, 7
	or	rcx, r8
	vmovq	xmm4, qword ptr [r14 + r9]
	vmovq	xmm5, rcx
	vpshufb	xmm4, xmm4, xmm5
	shr	rax, 56
	add	rax, r9
	vmovq	qword ptr [rdi + 552], xmm4
	mov	rcx, qword ptr [rdi + 560]
	mov	r8, qword ptr [rdi + 568]
	mov	r10, rcx
	imul	r10, r15
	mov	r9, r10
	sub	r9, rcx
	xor	rcx, r15
	shl	rcx, 7
	or	rcx, r9
	vmovq	xmm4, qword ptr [r14 + rax]
	vmovq	xmm5, rcx
	vpshufb	xmm4, xmm4, xmm5
	shr	r10, 56
	add	r10, rax
	vmovq	qword ptr [rdi + 560], xmm4
	mov	r11, r8
	imul	r11, r15
	mov	rax, r11
	sub	rax, r8
	xor	r15, r8
	shl	r15, 7
	or	r15, rax
	vmovq	xmm4, qword ptr [r14 + r10]
	vmovq	xmm5, r15
	vpshufb	xmm4, xmm4, xmm5
	vmovq	qword ptr [rdi + 568], xmm4
	vmovups	ymm4, ymmword ptr [rdi + 544]
	vmovups	ymm5, ymmword ptr [rdi + 512]
	vmovups	ymmword ptr [rdi + 192], ymm5
	vmovups	ymmword ptr [rdi + 224], ymm4
	mov	r15, rbx
	#APP
	#NO_APP
	vpand	ymm4, ymm12, ymm2
	vpand	ymm4, ymm8, ymm4
	vpand	ymm5, ymm10, ymm2
	vpand	ymm3, ymm3, ymm5
	vmovdqu	ymmword ptr [rdi + 512], ymm3
	vmovdqu	ymmword ptr [rdi + 544], ymm4
	vmovq	rax, xmm3
	mov	r9, r15
	imul	r9, rax
	mov	rcx, r9
	sub	rcx, rax
	xor	rax, r15
	shl	rax, 7
	or	rax, rcx
	mov	r12, qword ptr [rsp + 80]
	mov	rcx, qword ptr [rsp + 48]
	vmovq	xmm5, qword ptr [r12 + rcx]
	vmovq	xmm8, rax
	vpshufb	xmm5, xmm5, xmm8
	shr	r9, 56
	add	r9, rcx
	vmovq	qword ptr [rdi + 512], xmm5
	vpextrq	rcx, xmm3, 1
	mov	rax, r15
	imul	rax, rcx
	mov	r8, rax
	sub	r8, rcx
	xor	rcx, r15
	shl	rcx, 7
	or	rcx, r8
	vmovq	xmm5, qword ptr [r12 + r9]
	vmovq	xmm8, rcx
	vpshufb	xmm5, xmm5, xmm8
	shr	rax, 56
	add	rax, r9
	vmovq	qword ptr [rdi + 520], xmm5
	vextracti128	xmm3, ymm3, 1
	vmovq	rcx, xmm3
	mov	r9, r15
	imul	r9, rcx
	mov	r8, r9
	sub	r8, rcx
	xor	rcx, r15
	shl	rcx, 7
	or	rcx, r8
	vmovq	xmm5, qword ptr [r12 + rax]
	vmovq	xmm8, rcx
	vpshufb	xmm5, xmm5, xmm8
	shr	r9, 56
	add	r9, rax
	vmovq	qword ptr [rdi + 528], xmm5
	vpextrq	rcx, xmm3, 1
	mov	rax, r15
	imul	rax, rcx
	mov	r8, rax
	sub	r8, rcx
	xor	rcx, r15
	shl	rcx, 7
	or	rcx, r8
	vmovq	xmm3, qword ptr [r12 + r9]
	vmovq	xmm5, rcx
	vpshufb	xmm3, xmm3, xmm5
	shr	rax, 56
	add	rax, r9
	vmovq	qword ptr [rdi + 536], xmm3
	vmovq	rcx, xmm4
	mov	r9, r15
	imul	r9, rcx
	mov	r8, r9
	sub	r8, rcx
	xor	rcx, r15
	shl	rcx, 7
	or	rcx, r8
	vmovq	xmm3, qword ptr [r12 + rax]
	vmovq	xmm5, rcx
	vpshufb	xmm3, xmm3, xmm5
	shr	r9, 56
	add	r9, rax
	vmovq	qword ptr [rdi + 544], xmm3
	vpextrq	rcx, xmm4, 1
	mov	rax, r15
	imul	rax, rcx
	mov	r8, rax
	sub	r8, rcx
	xor	rcx, r15
	shl	rcx, 7
	or	rcx, r8
	vmovq	xmm3, qword ptr [r12 + r9]
	vmovq	xmm4, rcx
	vpshufb	xmm3, xmm3, xmm4
	shr	rax, 56
	add	rax, r9
	vmovq	qword ptr [rdi + 552], xmm3
	mov	rcx, qword ptr [rdi + 560]
	mov	r8, qword ptr [rdi + 568]
	mov	rbx, rcx
	imul	rbx, r15
	mov	r9, rbx
	sub	r9, rcx
	xor	rcx, r15
	shl	rcx, 7
	or	rcx, r9
	vmovq	xmm3, qword ptr [r12 + rax]
	vmovq	xmm4, rcx
	vpshufb	xmm3, xmm3, xmm4
	shr	rbx, 56
	add	rbx, rax
	vmovq	qword ptr [rdi + 560], xmm3
	mov	r14, r8
	imul	r14, r15
	mov	rax, r14
	sub	rax, r8
	xor	r15, r8
	shl	r15, 7
	or	r15, rax
	vmovq	xmm3, qword ptr [r12 + rbx]
	vmovq	xmm4, r15
	vpshufb	xmm3, xmm3, xmm4
	vmovq	qword ptr [rdi + 568], xmm3
	vmovups	ymm2, ymmword ptr [rdi + 512]
	vmovups	ymmword ptr [rsp + 416], ymm2
	vmovups	ymm2, ymmword ptr [rdi + 544]
	vmovups	ymmword ptr [rsp + 448], ymm2
	vpmovzxbd	ymm3, qword ptr [rdi + 520]
	vpmovzxbd	ymm8, qword ptr [rdi + 512]
	vmovdqu	ymmword ptr [rdi + 512], ymm0
	vmovdqu	ymmword ptr [rdi + 544], ymm1
	vmovd	xmm0, dword ptr [rsp + 112]
	vpbroadcastd	ymm0, xmm0
	vpsrld	ymm1, ymm8, 3
	vpsrld	ymm4, ymm3, 3
	vmovdqu	ymm2, ymmword ptr [rsp + 384]
	vpmaxud	ymm4, ymm4, ymm2
	vpcmpeqd	ymm6, ymm6, ymm6
	vpaddd	ymm4, ymm4, ymm6
	vpmaxud	ymm1, ymm1, ymm2
	vpaddd	ymm5, ymm1, ymm6
	vmovdqu	ymm2, ymmword ptr [rsp + 352]
	vpand	ymm1, ymm8, ymm2
	vpand	ymm10, ymm3, ymm2
	vmovdqu	ymm9, ymmword ptr [rsp + 320]
	vpminud	ymm3, ymm3, ymm9
	vpminud	ymm8, ymm8, ymm9
	vpand	ymm8, ymm8, ymm9
	vpor	ymm1, ymm8, ymm1
	vpand	ymm3, ymm9, ymm3
	vpor	ymm3, ymm10, ymm3
	vpsllvd	ymm1, ymm1, ymm5
	vmovdqu	ymmword ptr [rsp + 80], ymm1
	vpsllvd	ymm1, ymm3, ymm4
	vmovdqu	ymmword ptr [rsp + 112], ymm1
	vpsllvd	ymm1, ymm6, ymm5
	vmovdqu	ymmword ptr [rsp + 144], ymm1
	vpsllvd	ymm1, ymm6, ymm4
	vmovdqu	ymmword ptr [rsp + 48], ymm1
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
	mov	r8, qword ptr [rsp + 16]
	mov	eax, r8d
	and	eax, 7
	vmovd	xmm11, eax
	vpbroadcastd	ymm11, xmm11
	vpaddd	ymm4, ymm11, ymm4
	vpaddd	ymm5, ymm11, ymm5
	vpsrld	ymm11, ymm4, 3
	vpsrld	ymm9, ymm5, 3
	vpand	ymm15, ymm4, ymm2
	vpand	ymm5, ymm5, ymm2
	vbroadcasti128	ymm2, xmmword ptr [rip + 652f]
	vpshufb	ymm4, ymm11, ymm2
	vpshufb	ymm9, ymm9, ymm2
	vmovdqu	ymm2, ymmword ptr [rsp + 288]
	vpaddb	ymm11, ymm4, ymm2
	vpaddb	ymm4, ymm9, ymm2
	shr	r8, 3
	lea	rax, [r8 + 64]
	mov	r9, qword ptr [rsp + 8]
	cmp	rax, r9
	jbe	72f
	sub	r9, r8
	lea	r13, [rdi + 576]
	mov	rcx, r13
	jbe	152f
	cmp	r9, 16
	mov	r15, r8
	jb	132f
	mov	rax, qword ptr [rsp]
	lea	r12, [r8 + rax]
	mov	rax, rdi
	sub	rax, r12
	add	rax, 575
	cmp	rax, 127
	mov	r15, r8
	jb	132f
	cmp	r9, 128
	jae	92f
	xor	eax, eax
	jmp	112f
	.p2align	4
72:
	add	r8, qword ptr [rsp]
	mov	rcx, r8
	lea	r13, [rdi + 576]
	jmp	152f
82:
	cmp	r8, 128
	jae	172f
	xor	r9d, r9d
	jmp	192f
92:
	mov	rax, r9
	and	rax, -128
	lea	r15, [r8 + rax]
	mov	rcx, qword ptr [rsp]
	lea	rcx, [rcx + r8 + 96]
	xor	r13d, r13d
	.p2align	4
102:
	vmovdqu	ymm9, ymmword ptr [rcx + r13 - 96]
	vmovdqu	ymm14, ymmword ptr [rcx + r13 - 64]
	vmovdqu	ymm6, ymmword ptr [rcx + r13 - 32]
	vmovdqu	ymm7, ymmword ptr [rcx + r13]
	vmovdqu	ymmword ptr [rdi + r13 + 576], ymm9
	vmovdqu	ymmword ptr [rdi + r13 + 608], ymm14
	vmovdqu	ymmword ptr [rdi + r13 + 640], ymm6
	vmovdqu	ymmword ptr [rdi + r13 + 672], ymm7
	sub	r13, -128
	cmp	rax, r13
	jne	102b
	cmp	r9, rax
	lea	r13, [rdi + 576]
	mov	rcx, r13
	je	152f
	test	r9b, 112
	je	132f
112:
	mov	rcx, r9
	and	rcx, -16
	lea	r15, [r8 + rcx]
	.p2align	4
122:
	vmovdqu	xmm6, xmmword ptr [r12 + rax]
	vmovdqu	xmmword ptr [r13 + rax], xmm6
	add	rax, 16
	cmp	rcx, rax
	jne	122b
	cmp	r9, rcx
	mov	rcx, r13
	je	152f
	.p2align	4
132:
	mov	rax, r13
	sub	rax, r8
	mov	r8, qword ptr [rsp]
	mov	r9, qword ptr [rsp + 8]
	.p2align	4
142:
	movzx	ecx, byte ptr [r8 + r15]
	mov	byte ptr [rax + r15], cl
	inc	r15
	cmp	r9, r15
	jne	142b
	mov	rcx, r13
152:
	vmovdqu	ymm6, ymmword ptr [rcx]
	vmovdqu	ymm7, ymmword ptr [rcx + 32]
	vpermq	ymm9, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm14, ymm9, ymm11
	vpshufb	ymm12, ymm6, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 662f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 672f]
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm4, ymm6, ymm7, ymm4
	vpxor	xmm7, xmm7, xmm7
	vpand	ymm6, ymm11, ymm3
	vpcmpeqb	ymm6, ymm6, ymm3
	vpblendvb	ymm2, ymm12, ymm2, ymm6
	vpsrlvd	ymm4, ymm4, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 144]
	vpandn	ymm3, ymm3, ymm4
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 80]
	vpsrlvd	ymm2, ymm2, ymm15
	vmovdqu	ymm4, ymmword ptr [rsp + 48]
	vpandn	ymm2, ymm4, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 112]
	vpor	ymm4, ymm2, ymmword ptr [rip + 682f]
	vpcmpeqd	ymm2, ymm2, ymm7
	vpandn	ymm2, ymm2, ymm4
	vpor	ymm4, ymm3, ymmword ptr [rip + 692f]
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
	vmovdqu	ymm5, ymmword ptr [rsp + 256]
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
	mov	r8, qword ptr [rsp + 16]
	add	r8, rax
	cmp	qword ptr [rsp + 224], 17
	jb	442f
	vmovdqu	ymm1, ymmword ptr [rsp + 416]
	vextracti128	xmm1, ymm1, 1
	vpshufd	xmm2, xmm1, 238
	vpmovzxbd	ymm2, xmm2
	vpmovzxbd	ymm1, xmm1
	vpsrld	ymm3, ymm1, 3
	vpsrld	ymm4, ymm2, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 384]
	vpmaxud	ymm4, ymm4, ymm5
	vpcmpeqd	ymm8, ymm8, ymm8
	vpaddd	ymm4, ymm8, ymm4
	vpmaxud	ymm3, ymm3, ymm5
	vpaddd	ymm5, ymm8, ymm3
	vmovdqu	ymm9, ymmword ptr [rsp + 352]
	vpand	ymm3, ymm9, ymm1
	vpand	ymm6, ymm9, ymm2
	vmovdqu	ymm10, ymmword ptr [rsp + 320]
	vpminud	ymm2, ymm2, ymm10
	vpminud	ymm1, ymm1, ymm10
	vpand	ymm1, ymm10, ymm1
	vpor	ymm1, ymm1, ymm3
	vpand	ymm2, ymm10, ymm2
	vpor	ymm2, ymm2, ymm6
	vpsllvd	ymm1, ymm1, ymm5
	vmovdqu	ymmword ptr [rsp + 80], ymm1
	vpsllvd	ymm1, ymm2, ymm4
	vmovdqu	ymmword ptr [rsp + 112], ymm1
	vpsllvd	ymm1, ymm8, ymm5
	vmovdqu	ymmword ptr [rsp + 144], ymm1
	vpsllvd	ymm1, ymm8, ymm4
	vmovdqu	ymmword ptr [rsp + 48], ymm1
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
	mov	eax, r8d
	and	eax, 7
	vmovd	xmm5, eax
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm4, ymm5, ymm4
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm6, ymm4, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm13, ymm9, ymm4
	vpand	ymm5, ymm9, ymm2
	vbroadcasti128	ymm4, xmmword ptr [rip + 652f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm4, ymm7, ymm4
	vmovdqu	ymm6, ymmword ptr [rsp + 288]
	vpaddb	ymm11, ymm2, ymm6
	vpaddb	ymm4, ymm4, ymm6
	mov	qword ptr [rsp + 16], r8
	shr	r8, 3
	lea	rax, [r8 + 64]
	mov	r9, qword ptr [rsp + 8]
	cmp	rax, r9
	jbe	162f
	sub	r9, r8
	mov	rcx, r13
	jbe	272f
	cmp	r9, 16
	mov	r15, r8
	jb	252f
	mov	rax, qword ptr [rsp]
	lea	r12, [r8 + rax]
	mov	rax, rdi
	sub	rax, r12
	add	rax, 575
	cmp	rax, 127
	mov	r15, r8
	jb	252f
	cmp	r9, 128
	jae	212f
	xor	eax, eax
	jmp	232f
	.p2align	4
162:
	add	r8, qword ptr [rsp]
	mov	rcx, r8
	jmp	272f
172:
	mov	qword ptr [rsp + 416], r8
	mov	r9, r8
	and	r9, -128
	lea	r15, [r10 + r9]
	mov	rax, qword ptr [rsp + 32]
	add	rax, r12
	mov	rcx, qword ptr [rsp + 24]
	add	rcx, rbx
	and	rcx, -128
	xor	r8d, r8d
	.p2align	4
182:
	vmovdqu	ymm0, ymmword ptr [rax + r8 - 96]
	vmovdqu	ymm1, ymmword ptr [rax + r8 - 64]
	vmovups	ymm3, ymmword ptr [rax + r8 - 32]
	vmovups	ymm4, ymmword ptr [rax + r8]
	vmovdqu	ymmword ptr [rdi + r8 + 512], ymm0
	vmovdqu	ymmword ptr [rdi + r8 + 544], ymm1
	vmovups	ymmword ptr [rdi + r8 + 576], ymm3
	vmovups	ymmword ptr [rdi + r8 + 608], ymm4
	sub	r8, -128
	cmp	rcx, r8
	jne	182b
	mov	r8, qword ptr [rsp + 416]
	cmp	r8, r9
	lea	rax, [rdi + 512]
	je	62b
	test	r8b, 112
	je	32b
192:
	mov	r15, r8
	mov	rax, r8
	and	rax, -16
	lea	rcx, [r12 + r10]
	add	r10, rax
	add	rbx, qword ptr [rsp + 24]
	and	rbx, -16
	lea	r8, [rdi + 512]
	.p2align	4
202:
	vmovdqu	xmm0, xmmword ptr [rcx + r9]
	vmovdqu	xmmword ptr [r8 + r9], xmm0
	add	r9, 16
	cmp	rbx, r9
	jne	202b
	cmp	r15, rax
	mov	rax, r8
	mov	r15, r10
	je	62b
	jmp	32b
212:
	mov	rax, r9
	and	rax, -128
	lea	r15, [r8 + rax]
	mov	rcx, qword ptr [rsp]
	lea	rcx, [rcx + r8 + 96]
	xor	r13d, r13d
	.p2align	4
222:
	vmovdqu	ymm2, ymmword ptr [rcx + r13 - 96]
	vmovdqu	ymm6, ymmword ptr [rcx + r13 - 64]
	vmovdqu	ymm7, ymmword ptr [rcx + r13 - 32]
	vmovdqu	ymm9, ymmword ptr [rcx + r13]
	vmovdqu	ymmword ptr [rdi + r13 + 576], ymm2
	vmovdqu	ymmword ptr [rdi + r13 + 608], ymm6
	vmovdqu	ymmword ptr [rdi + r13 + 640], ymm7
	vmovdqu	ymmword ptr [rdi + r13 + 672], ymm9
	sub	r13, -128
	cmp	rax, r13
	jne	222b
	cmp	r9, rax
	lea	r13, [rdi + 576]
	mov	rcx, r13
	je	272f
	test	r9b, 112
	je	252f
232:
	mov	rcx, r9
	and	rcx, -16
	lea	r15, [r8 + rcx]
	.p2align	4
242:
	vmovdqu	xmm2, xmmword ptr [r12 + rax]
	vmovdqu	xmmword ptr [r13 + rax], xmm2
	add	rax, 16
	cmp	rcx, rax
	jne	242b
	cmp	r9, rcx
	mov	rcx, r13
	je	272f
252:
	mov	rax, r13
	sub	rax, r8
	mov	r8, qword ptr [rsp]
	mov	r9, qword ptr [rsp + 8]
	.p2align	4
262:
	movzx	ecx, byte ptr [r8 + r15]
	mov	byte ptr [rax + r15], cl
	inc	r15
	cmp	r9, r15
	jne	262b
	mov	rcx, r13
272:
	vmovdqu	ymm2, ymmword ptr [rcx]
	vmovdqu	ymm6, ymmword ptr [rcx + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm9, ymm7, ymm11
	vpshufb	ymm14, ymm2, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 662f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 672f]
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm2, ymm2, ymm6, ymm4
	vpand	ymm4, ymm11, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm4, ymm9, ymm8, ymm4
	vpsrlvd	ymm2, ymm2, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 144]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 80]
	vpsrlvd	ymm3, ymm4, ymm13
	vmovdqu	ymm4, ymmword ptr [rsp + 48]
	vpandn	ymm3, ymm4, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 112]
	vpor	ymm4, ymm3, ymmword ptr [rip + 682f]
	vpcmpeqd	ymm3, ymm3, ymm7
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 692f]
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
	vmovdqu	ymm5, ymmword ptr [rsp + 256]
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
	mov	r8, qword ptr [rsp + 16]
	add	r8, rax
	cmp	qword ptr [rsp + 224], 33
	jb	442f
	vmovdqu	ymm2, ymmword ptr [rsp + 448]
	vpshufd	xmm1, xmm2, 238
	vpmovzxbd	ymm1, xmm1
	vpmovzxbd	ymm2, xmm2
	vpsrld	ymm3, ymm2, 3
	vpsrld	ymm4, ymm1, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 384]
	vpmaxud	ymm4, ymm4, ymm5
	vpcmpeqd	ymm8, ymm8, ymm8
	vpaddd	ymm4, ymm8, ymm4
	vpmaxud	ymm3, ymm3, ymm5
	vpaddd	ymm5, ymm8, ymm3
	vmovdqu	ymm9, ymmword ptr [rsp + 352]
	vpand	ymm3, ymm9, ymm2
	vpand	ymm6, ymm9, ymm1
	vmovdqu	ymm10, ymmword ptr [rsp + 320]
	vpminud	ymm1, ymm1, ymm10
	vpminud	ymm2, ymm2, ymm10
	vpand	ymm2, ymm10, ymm2
	vpor	ymm2, ymm2, ymm3
	vpand	ymm1, ymm10, ymm1
	vpor	ymm1, ymm1, ymm6
	vpsllvd	ymm2, ymm2, ymm5
	vmovdqu	ymmword ptr [rsp + 80], ymm2
	vpsllvd	ymm1, ymm1, ymm4
	vmovdqu	ymmword ptr [rsp + 112], ymm1
	vpsllvd	ymm1, ymm8, ymm5
	vmovdqu	ymmword ptr [rsp + 144], ymm1
	vpsllvd	ymm1, ymm8, ymm4
	vmovdqu	ymmword ptr [rsp + 48], ymm1
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
	mov	eax, r8d
	and	eax, 7
	vmovd	xmm5, eax
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm4, ymm5, ymm4
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm6, ymm4, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm13, ymm9, ymm4
	vpand	ymm5, ymm9, ymm2
	vbroadcasti128	ymm4, xmmword ptr [rip + 652f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm4, ymm7, ymm4
	vmovdqu	ymm6, ymmword ptr [rsp + 288]
	vpaddb	ymm11, ymm2, ymm6
	vpaddb	ymm4, ymm4, ymm6
	mov	qword ptr [rsp + 16], r8
	shr	r8, 3
	lea	rax, [r8 + 64]
	mov	r9, qword ptr [rsp + 8]
	cmp	rax, r9
	jbe	282f
	sub	r9, r8
	mov	rcx, r13
	jbe	352f
	cmp	r9, 16
	mov	r15, r8
	jb	332f
	mov	rax, qword ptr [rsp]
	lea	r12, [r8 + rax]
	mov	rax, rdi
	sub	rax, r12
	add	rax, 575
	cmp	rax, 127
	mov	r15, r8
	jb	332f
	cmp	r9, 128
	jae	292f
	xor	eax, eax
	jmp	312f
282:
	add	r8, qword ptr [rsp]
	mov	rcx, r8
	jmp	352f
292:
	mov	rax, r9
	and	rax, -128
	lea	r15, [r8 + rax]
	mov	rcx, qword ptr [rsp]
	lea	rcx, [rcx + r8 + 96]
	xor	r13d, r13d
	.p2align	4
302:
	vmovdqu	ymm2, ymmword ptr [rcx + r13 - 96]
	vmovdqu	ymm6, ymmword ptr [rcx + r13 - 64]
	vmovdqu	ymm7, ymmword ptr [rcx + r13 - 32]
	vmovdqu	ymm9, ymmword ptr [rcx + r13]
	vmovdqu	ymmword ptr [rdi + r13 + 576], ymm2
	vmovdqu	ymmword ptr [rdi + r13 + 608], ymm6
	vmovdqu	ymmword ptr [rdi + r13 + 640], ymm7
	vmovdqu	ymmword ptr [rdi + r13 + 672], ymm9
	sub	r13, -128
	cmp	rax, r13
	jne	302b
	cmp	r9, rax
	lea	r13, [rdi + 576]
	mov	rcx, r13
	je	352f
	test	r9b, 112
	je	332f
312:
	mov	rcx, r9
	and	rcx, -16
	lea	r15, [r8 + rcx]
	.p2align	4
322:
	vmovdqu	xmm2, xmmword ptr [r12 + rax]
	vmovdqu	xmmword ptr [r13 + rax], xmm2
	add	rax, 16
	cmp	rcx, rax
	jne	322b
	cmp	r9, rcx
	mov	rcx, r13
	je	352f
332:
	mov	rax, r13
	sub	rax, r8
	mov	r8, qword ptr [rsp]
	mov	r9, qword ptr [rsp + 8]
	.p2align	4
342:
	movzx	ecx, byte ptr [r8 + r15]
	mov	byte ptr [rax + r15], cl
	inc	r15
	cmp	r9, r15
	jne	342b
	mov	rcx, r13
352:
	vmovdqu	ymm2, ymmword ptr [rcx]
	vmovdqu	ymm6, ymmword ptr [rcx + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm9, ymm7, ymm11
	vpshufb	ymm14, ymm2, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 662f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 672f]
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm2, ymm2, ymm6, ymm4
	vpand	ymm4, ymm11, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm4, ymm9, ymm8, ymm4
	vpsrlvd	ymm2, ymm2, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 144]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 80]
	vpsrlvd	ymm3, ymm4, ymm13
	vmovdqu	ymm4, ymmword ptr [rsp + 48]
	vpandn	ymm3, ymm4, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 112]
	vpor	ymm4, ymm3, ymmword ptr [rip + 682f]
	vpcmpeqd	ymm3, ymm3, ymm7
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 692f]
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
	vmovdqu	ymm5, ymmword ptr [rsp + 256]
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
	mov	r8, qword ptr [rsp + 16]
	add	r8, rax
	cmp	qword ptr [rsp + 224], 49
	jb	442f
	vmovdqu	ymm1, ymmword ptr [rsp + 448]
	vextracti128	xmm1, ymm1, 1
	vpshufd	xmm2, xmm1, 238
	vpmovzxbd	ymm2, xmm2
	vpmovzxbd	ymm1, xmm1
	vpsrld	ymm3, ymm1, 3
	vpsrld	ymm4, ymm2, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 384]
	vpmaxud	ymm4, ymm4, ymm5
	vpcmpeqd	ymm8, ymm8, ymm8
	vpaddd	ymm4, ymm8, ymm4
	vpmaxud	ymm3, ymm3, ymm5
	vpaddd	ymm5, ymm8, ymm3
	vmovdqu	ymm9, ymmword ptr [rsp + 352]
	vpand	ymm3, ymm9, ymm1
	vpand	ymm6, ymm9, ymm2
	vmovdqu	ymm10, ymmword ptr [rsp + 320]
	vpminud	ymm2, ymm2, ymm10
	vpminud	ymm1, ymm1, ymm10
	vpand	ymm1, ymm10, ymm1
	vpor	ymm1, ymm1, ymm3
	vpand	ymm2, ymm10, ymm2
	vpor	ymm2, ymm2, ymm6
	vpsllvd	ymm1, ymm1, ymm5
	vmovdqu	ymmword ptr [rsp + 112], ymm1
	vpsllvd	ymm1, ymm2, ymm4
	vmovdqu	ymmword ptr [rsp + 224], ymm1
	vpsllvd	ymm1, ymm8, ymm5
	vmovdqu	ymmword ptr [rsp + 48], ymm1
	vpsllvd	ymm1, ymm8, ymm4
	vmovdqu	ymmword ptr [rsp + 80], ymm1
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
	mov	eax, r8d
	and	eax, 7
	vmovd	xmm5, eax
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm4, ymm5, ymm4
	vpaddd	ymm2, ymm5, ymm2
	vpsrld	ymm6, ymm4, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm13, ymm9, ymm4
	vpand	ymm5, ymm9, ymm2
	vbroadcasti128	ymm4, xmmword ptr [rip + 652f]
	vpshufb	ymm2, ymm6, ymm4
	vpshufb	ymm4, ymm7, ymm4
	vmovdqu	ymm6, ymmword ptr [rsp + 288]
	vpaddb	ymm11, ymm2, ymm6
	vpaddb	ymm4, ymm4, ymm6
	mov	qword ptr [rsp + 16], r8
	shr	r8, 3
	lea	rax, [r8 + 64]
	mov	r9, qword ptr [rsp + 8]
	cmp	rax, r9
	jbe	362f
	sub	r9, r8
	mov	rcx, r13
	jbe	432f
	cmp	r9, 16
	mov	r15, r8
	jb	412f
	mov	rax, qword ptr [rsp]
	lea	r12, [r8 + rax]
	mov	rax, rdi
	sub	rax, r12
	add	rax, 575
	cmp	rax, 127
	mov	r15, r8
	jb	412f
	cmp	r9, 128
	jae	372f
	xor	eax, eax
	jmp	392f
362:
	mov	rcx, qword ptr [rsp]
	add	rcx, r8
	jmp	432f
372:
	mov	rax, r9
	and	rax, -128
	lea	r15, [r8 + rax]
	mov	rcx, qword ptr [rsp]
	lea	rcx, [rcx + r8 + 96]
	xor	r13d, r13d
	.p2align	4
382:
	vmovdqu	ymm2, ymmword ptr [rcx + r13 - 96]
	vmovdqu	ymm6, ymmword ptr [rcx + r13 - 64]
	vmovdqu	ymm7, ymmword ptr [rcx + r13 - 32]
	vmovdqu	ymm9, ymmword ptr [rcx + r13]
	vmovdqu	ymmword ptr [rdi + r13 + 576], ymm2
	vmovdqu	ymmword ptr [rdi + r13 + 608], ymm6
	vmovdqu	ymmword ptr [rdi + r13 + 640], ymm7
	vmovdqu	ymmword ptr [rdi + r13 + 672], ymm9
	sub	r13, -128
	cmp	rax, r13
	jne	382b
	cmp	r9, rax
	lea	r13, [rdi + 576]
	mov	rcx, r13
	je	432f
	test	r9b, 112
	je	412f
392:
	mov	rcx, r9
	and	rcx, -16
	lea	r15, [r8 + rcx]
	.p2align	4
402:
	vmovdqu	xmm2, xmmword ptr [r12 + rax]
	vmovdqu	xmmword ptr [r13 + rax], xmm2
	add	rax, 16
	cmp	rcx, rax
	jne	402b
	cmp	r9, rcx
	mov	rcx, r13
	je	432f
412:
	mov	rax, r13
	sub	rax, r8
	mov	r8, qword ptr [rsp]
	mov	r9, qword ptr [rsp + 8]
	.p2align	4
422:
	movzx	ecx, byte ptr [r8 + r15]
	mov	byte ptr [rax + r15], cl
	inc	r15
	cmp	r9, r15
	jne	422b
	mov	rcx, r13
432:
	vmovdqu	ymm2, ymmword ptr [rcx]
	vmovdqu	ymm6, ymmword ptr [rcx + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm9, ymm7, ymm11
	vpshufb	ymm14, ymm2, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 662f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 672f]
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm2, ymm2, ymm6, ymm4
	vpand	ymm4, ymm11, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm4, ymm9, ymm8, ymm4
	vpsrlvd	ymm2, ymm2, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 48]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 112]
	vpsrlvd	ymm3, ymm4, ymm13
	vmovdqu	ymm4, ymmword ptr [rsp + 80]
	vpandn	ymm3, ymm4, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 224]
	vpor	ymm4, ymm3, ymmword ptr [rip + 682f]
	vpcmpeqd	ymm3, ymm3, ymm7
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 692f]
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
	vmovdqu	ymm5, ymmword ptr [rsp + 256]
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
	mov	r8, qword ptr [rsp + 16]
	add	r8, rax
	.p2align	4
442:
	shr	r14, 56
	add	r14, rbx
	shr	r11, 56
	add	r11, r10
	vmovd	eax, xmm0
	mov	qword ptr [rdi + 72], r8
	mov	qword ptr [rdi + 96], rax
	mov	qword ptr [rdi + 128], r11
	mov	qword ptr [rdi + 136], r14
	xor	eax, eax
	mov	r15, qword ptr [rsp + 192]
	.p2align	4
452:
	movzx	r10d, byte ptr [rdi + rax + 512]
	movzx	r8d, byte ptr [rdi + rax + 192]
	cmp	r8, 33
	mov	r9d, dword ptr [rdi + 4*rax + 256]
	vmovdqu	ymm0, ymmword ptr [rsi]
	vmovdqu	ymmword ptr [rdx], ymm0
	jae	492f
462:
	add	rdx, r8
	mov	r11d, r10d
	shr	r11d, 2
	cmp	r9, r11
	jb	542f
	mov	rbx, rdx
	sub	rbx, r9
	cmp	rbx, r15
	jl	542f
	vmovdqu	ymm0, ymmword ptr [rbx]
472:
	vmovdqu	ymmword ptr [rdx], ymm0
	cmp	r10b, -124
	jae	512f
482:
	add	rdx, r11
	add	rsi, r8
	inc	rax
	cmp	rax, rbp
	jne	452b
	jmp	2b
492:
	mov	rcx, qword ptr [rdi + 48]
	mov	r11, qword ptr [rdi + 120]
	movzx	r8d, byte ptr [rcx + r11]
	inc	r11
	mov	qword ptr [rdi + 120], r11
	add	r8, 33
	mov	ecx, 32
	.p2align	4
502:
	vmovdqu	ymm0, ymmword ptr [rsi + rcx]
	vmovdqu	ymmword ptr [rdx + rcx], ymm0
	add	rcx, 32
	cmp	rcx, r8
	jb	502b
	jmp	462b
512:
	cmp	r9, 31
	ja	522f
	mov	qword ptr [rdi + 104], 1
522:
	mov	rcx, qword ptr [rdi + 48]
	mov	r9, qword ptr [rdi + 120]
	movzx	r11d, byte ptr [rcx + r9]
	inc	r9
	mov	qword ptr [rdi + 120], r9
	add	r11, 33
	mov	ecx, 32
	.p2align	4
532:
	vmovdqu	ymm0, ymmword ptr [rbx + rcx]
	vmovdqu	ymmword ptr [rdx + rcx], ymm0
	add	rcx, 32
	cmp	rcx, r11
	jb	532b
	jmp	482b
542:
	mov	rbx, rdx
	sub	rbx, r15
	cmp	r9, rbx
	cmovae	r9, rbx
	sub	rbx, r9
	cmp	r9, r11
	jae	552f
	mov	rcx, qword ptr [rdi + 56]
	mov	r14, r9
	shl	r14, 5
	vmovdqu	ymm0, ymmword ptr [rcx + r14 + 2048]
	vmovdqu	ymm1, ymmword ptr [r15 + rbx]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	add	rbx, r15
	jmp	472b
552:
	vmovdqu	ymm0, ymmword ptr [r15 + rbx]
	add	rbx, r15
	jmp	472b
562:
	sub	rdx, r15
	sub	rsi, qword ptr [rsp + 176]
	mov	qword ptr [rdi + 80], rdx
	mov	qword ptr [rdi + 88], rsi
	add	rsp, 488
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	vzeroupper
	ret
	.p2align	2, 0x0
572:
	.long	1
	.p2align	2, 0x0
582:
	.long	7
	.p2align	2, 0x0
592:
	.long	8
	.p2align	2, 0x0
602:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	2, 0x0
612:
	.long	134217727
	.p2align	5, 0x0
622:
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
632:
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
642:
	.byte	1
	.p2align	4, 0x0
652:
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
662:
	.byte	16
	.p2align	2, 0x0
672:
	.byte	32
	.p2align	5, 0x0
682:
	.long	1207959552
	.long	1342177280
	.long	1476395008
	.long	1610612736
	.long	1744830464
	.long	1879048192
	.long	2013265920
	.long	2147483648
	.p2align	5, 0x0
692:
	.long	134217728
	.long	268435456
	.long	402653184
	.long	536870912
	.long	671088640
	.long	805306368
	.long	939524096
	.long	1073741824

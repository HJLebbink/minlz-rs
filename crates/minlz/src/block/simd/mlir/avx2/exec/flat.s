# minlz_exec_flat of crates/minlz/mlir/exec64.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 728
	mov	rbx, qword ptr [rdi]
	mov	rax, qword ptr [rdi + 8]
	mov	rcx, qword ptr [rdi + 64]
	mov	rdx, qword ptr [rdi + 80]
	add	rdx, rbx
	mov	rsi, qword ptr [rdi + 88]
	mov	qword ptr [rsp + 168], rax
	add	rsi, rax
	test	rcx, rcx
	jle	552f
	lea	r8, [rdi + 512]
	mov	eax, 96
	mov	qword ptr [rsp + 40], rax
	mov	r9d, 7
	xor	eax, eax
	vpxor	xmm13, xmm13, xmm13
	vbroadcastss	ymm0, dword ptr [rip + 562f]
	vmovups	ymmword ptr [rsp + 496], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 572f]
	vmovups	ymmword ptr [rsp + 464], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 582f]
	vmovups	ymmword ptr [rsp + 432], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 592f]
	vmovups	ymmword ptr [rsp + 400], ymm0
	vpbroadcastd	ymm0, dword ptr [rip + 602f]
	vmovdqu	ymmword ptr [rsp + 368], ymm0
	mov	r11, rcx
	xor	r10d, r10d
	mov	qword ptr [rsp + 184], rbx
	mov	qword ptr [rsp + 176], rcx
	jmp	12f
	.p2align	4
2:
	mov	r11, qword ptr [rsp + 288]
	add	r11, -64
	mov	rax, qword ptr [rsp + 296]
	inc	rax
	add	qword ptr [rsp + 40], 64
	mov	r9, qword ptr [rsp + 48]
	add	r9, -64
	mov	r8, qword ptr [rsp + 56]
	add	r8, -64
	mov	rcx, qword ptr [rsp + 176]
	mov	r10, qword ptr [rsp + 280]
	cmp	r10, rcx
	jge	552f
12:
	mov	qword ptr [rsp + 56], r8
	cmp	r11, 1
	mov	qword ptr [rsp + 288], r11
	adc	r11, 0
	cmp	r11, 64
	mov	r8d, 64
	cmovae	r11, r8
	mov	qword ptr [rsp + 16], r11
	sub	rcx, r10
	cmp	rcx, 64
	mov	ebx, 64
	mov	qword ptr [rsp + 336], rcx
	cmovb	rbx, rcx
	mov	r15, qword ptr [rdi + 16]
	mov	r11, qword ptr [rdi + 24]
	mov	rcx, qword ptr [rdi + 32]
	mov	qword ptr [rsp + 64], rcx
	mov	rcx, qword ptr [rdi + 40]
	mov	qword ptr [rsp], rcx
	mov	r13, qword ptr [rdi + 64]
	mov	rcx, qword ptr [rdi + 72]
	mov	qword ptr [rsp + 96], rcx
	mov	rcx, qword ptr [rdi + 96]
	mov	qword ptr [rsp + 128], rcx
	mov	rcx, qword ptr [rdi + 112]
	mov	qword ptr [rsp + 8], rcx
	mov	rbp, qword ptr [rdi + 128]
	mov	rcx, qword ptr [rdi + 136]
	mov	qword ptr [rsp + 24], rcx
	lea	r12, [r13 + 7]
	lea	rcx, [r10 + 64]
	mov	qword ptr [rsp + 280], rcx
	cmp	rcx, r12
	mov	qword ptr [rsp + 48], r9
	mov	qword ptr [rsp + 296], rax
	jbe	52f
	cmp	r10, r12
	lea	rcx, [rdi + 512]
	jge	62f
	shl	rax, 6
	mov	r8d, 7
	sub	r8, rax
	add	r8, r13
	cmp	r8, 16
	jb	22f
	add	rax, r15
	mov	rcx, rdi
	sub	rcx, rax
	add	rcx, 511
	cmp	rcx, 127
	jae	82f
22:
	mov	r14, r10
32:
	mov	rcx, qword ptr [rsp + 56]
	.p2align	4
42:
	movzx	eax, byte ptr [r15 + r14]
	mov	byte ptr [rcx + r14], al
	inc	r14
	cmp	r12, r14
	jne	42b
	lea	rcx, [rdi + 512]
	jmp	62f
	.p2align	4
52:
	add	r15, r10
	mov	rcx, r15
62:
	vmovdqu	ymm12, ymmword ptr [rcx]
	vmovdqu	ymm7, ymmword ptr [rcx + 32]
	vmovd	xmm0, ebx
	vpbroadcastb	ymm0, xmm0
	vpmaxub	ymm1, ymm0, ymmword ptr [rip + 612f]
	vpcmpeqb	ymm8, ymm0, ymm1
	vpmaxub	ymm1, ymm0, ymmword ptr [rip + 622f]
	vpcmpeqb	ymm1, ymm0, ymm1
	vpsllw	ymm0, ymm7, 6
	vpcmpgtb	ymm0, ymm13, ymm0
	vpsllw	ymm3, ymm12, 6
	vpcmpgtb	ymm4, ymm13, ymm3
	vpbroadcastb	ymm2, byte ptr [rip + 632f]
	vpand	ymm3, ymm12, ymm2
	vpcmpeqb	ymm3, ymm13, ymm3
	movabs	rbx, 72340172838076673
	#APP
	#NO_APP
	vpand	ymm0, ymm0, ymm2
	vpand	ymm0, ymm8, ymm0
	vpand	ymm4, ymm4, ymm2
	vpand	ymm4, ymm1, ymm4
	vmovq	r10, xmm4
	vpextrq	r8, xmm4, 1
	vextracti128	xmm4, ymm4, 1
	vmovq	rax, xmm4
	vpextrq	r9, xmm4, 1
	vmovq	r13, xmm0
	vpextrq	r12, xmm0, 1
	vextracti128	xmm0, ymm0, 1
	vmovq	r14, xmm0
	mov	rcx, r10
	imul	rcx, rbx
	mov	r15, rcx
	sub	r15, r10
	xor	r10, rbx
	shl	r10, 7
	or	r10, r15
	vpextrq	r15, xmm0, 1
	vmovq	xmm0, qword ptr [r11 + rbp]
	vmovq	xmm4, r10
	vpshufb	xmm0, xmm0, xmm4
	shr	rcx, 56
	add	rcx, rbp
	mov	r10, r8
	imul	r10, rbx
	mov	rbp, r10
	sub	rbp, r8
	xor	r8, rbx
	shl	r8, 7
	or	r8, rbp
	vmovq	xmm4, qword ptr [r11 + rcx]
	vmovq	xmm5, r8
	vpshufb	xmm4, xmm4, xmm5
	vpunpcklqdq	xmm0, xmm0, xmm4
	shr	r10, 56
	add	r10, rcx
	mov	rcx, rax
	imul	rcx, rbx
	mov	r8, rcx
	sub	r8, rax
	xor	rax, rbx
	shl	rax, 7
	or	rax, r8
	vmovq	xmm4, qword ptr [r11 + r10]
	vmovq	xmm5, rax
	vpshufb	xmm4, xmm4, xmm5
	shr	rcx, 56
	add	rcx, r10
	mov	rax, r9
	imul	rax, rbx
	mov	r8, rax
	sub	r8, r9
	xor	r9, rbx
	shl	r9, 7
	or	r9, r8
	vmovq	xmm5, qword ptr [r11 + rcx]
	vmovq	xmm9, r9
	vpshufb	xmm5, xmm5, xmm9
	vpunpcklqdq	xmm4, xmm4, xmm5
	shr	rax, 56
	add	rax, rcx
	mov	rcx, r13
	imul	rcx, rbx
	mov	r8, rcx
	sub	r8, r13
	xor	r13, rbx
	shl	r13, 7
	or	r13, r8
	vmovq	xmm5, qword ptr [r11 + rax]
	vmovq	xmm9, r13
	vpshufb	xmm5, xmm5, xmm9
	shr	rcx, 56
	add	rcx, rax
	mov	rax, r12
	imul	rax, rbx
	mov	r8, rax
	sub	r8, r12
	xor	r12, rbx
	shl	r12, 7
	or	r12, r8
	vmovq	xmm9, qword ptr [r11 + rcx]
	vmovq	xmm10, r12
	vpshufb	xmm9, xmm9, xmm10
	vpunpcklqdq	xmm5, xmm5, xmm9
	shr	rax, 56
	add	rax, rcx
	mov	r8, r14
	imul	r8, rbx
	mov	rcx, r8
	sub	rcx, r14
	xor	r14, rbx
	shl	r14, 7
	or	r14, rcx
	vmovq	xmm9, qword ptr [r11 + rax]
	vmovq	xmm10, r14
	vpshufb	xmm9, xmm9, xmm10
	shr	r8, 56
	add	r8, rax
	mov	rax, r15
	imul	rax, rbx
	mov	qword ptr [rsp + 272], rax
	sub	rax, r15
	xor	rbx, r15
	shl	rbx, 7
	or	rbx, rax
	mov	qword ptr [rsp + 32], r8
	vmovq	xmm10, qword ptr [r11 + r8]
	vmovq	xmm11, rbx
	vpshufb	xmm10, xmm10, xmm11
	vpunpcklqdq	xmm9, xmm9, xmm10
	vmovdqu	xmmword ptr [rdi + 224], xmm5
	vmovdqu	xmmword ptr [rdi + 192], xmm0
	vmovdqu	xmmword ptr [rdi + 208], xmm4
	vmovdqu	xmmword ptr [rdi + 240], xmm9
	movabs	r15, 72340172838076673
	#APP
	#NO_APP
	vpand	ymm0, ymm3, ymm2
	vpand	ymm0, ymm1, ymm0
	vmovq	r9, xmm0
	vpextrq	r13, xmm0, 1
	vextracti128	xmm0, ymm0, 1
	vmovq	rax, xmm0
	mov	r10, r15
	imul	r10, r9
	mov	rbx, r10
	shr	rbx, 56
	mov	r12, qword ptr [rsp + 24]
	add	rbx, r12
	mov	r14, r15
	imul	r14, r13
	mov	rcx, r14
	shr	rcx, 56
	add	rcx, rbx
	mov	r8, r15
	mov	qword ptr [rsp + 240], rax
	imul	r8, rax
	mov	rax, qword ptr [rsp + 64]
	vmovsd	xmm1, qword ptr [rax + rcx]
	vmovaps	xmmword ptr [rsp + 592], xmm1
	mov	qword ptr [rsp + 248], r8
	shr	r8, 56
	add	r8, rcx
	vpextrq	r11, xmm0, 1
	mov	rcx, r15
	imul	rcx, r11
	vmovsd	xmm0, qword ptr [rax + r8]
	vmovaps	xmmword ptr [rsp + 608], xmm0
	mov	qword ptr [rsp + 256], rcx
	shr	rcx, 56
	add	rcx, r8
	vpand	ymm0, ymm7, ymm2
	vpcmpeqb	ymm0, ymm13, ymm0
	vpand	ymm0, ymm0, ymm2
	vpand	ymm0, ymm8, ymm0
	vmovq	r8, xmm0
	mov	rbp, r15
	mov	qword ptr [rsp + 224], r8
	imul	rbp, r8
	vmovsd	xmm1, qword ptr [rax + rcx]
	vmovaps	xmmword ptr [rsp + 560], xmm1
	mov	qword ptr [rsp + 208], rbp
	mov	r8, rbp
	shr	r8, 56
	add	r8, rcx
	vpextrq	rcx, xmm0, 1
	mov	rbp, r15
	mov	qword ptr [rsp + 232], rcx
	imul	rbp, rcx
	vmovsd	xmm1, qword ptr [rax + r8]
	vmovaps	xmmword ptr [rsp + 576], xmm1
	mov	qword ptr [rsp + 216], rbp
	mov	rcx, rbp
	shr	rcx, 56
	add	rcx, r8
	vextracti128	xmm0, ymm0, 1
	vmovq	r8, xmm0
	mov	rbp, r15
	mov	qword ptr [rsp + 200], r8
	imul	rbp, r8
	vmovsd	xmm1, qword ptr [rax + rcx]
	vmovaps	xmmword ptr [rsp + 544], xmm1
	mov	qword ptr [rsp + 192], rbp
	shr	rbp, 56
	add	rbp, rcx
	vmovq	xmm3, qword ptr [rax + r12]
	vmovq	xmm4, qword ptr [rax + rbx]
	sub	r10, r9
	xor	r9, r15
	shl	r9, 7
	or	r9, r10
	vmovq	xmm5, r9
	sub	r14, r13
	xor	r13, r15
	shl	r13, 7
	or	r13, r14
	vmovq	xmm8, r13
	mov	r8, qword ptr [rsp + 96]
	mov	ecx, r8d
	and	ecx, 7
	vmovd	xmm11, ecx
	vpshufb	xmm3, xmm3, xmm5
	vpshufb	xmm4, xmm4, xmm8
	vpmovzxbd	ymm3, xmm3
	vpmovzxbd	ymm5, xmm4
	vpsrld	ymm8, ymm5, 3
	vpsrld	ymm4, ymm3, 3
	vmovdqu	ymm1, ymmword ptr [rsp + 496]
	vpmaxud	ymm4, ymm4, ymm1
	vpcmpeqd	ymm2, ymm2, ymm2
	vpaddd	ymm4, ymm4, ymm2
	vpmaxud	ymm8, ymm8, ymm1
	vpaddd	ymm9, ymm8, ymm2
	vmovdqu	ymm6, ymmword ptr [rsp + 464]
	vpand	ymm8, ymm5, ymm6
	vpand	ymm10, ymm3, ymm6
	vmovdqu	ymm1, ymmword ptr [rsp + 432]
	vpminud	ymm3, ymm3, ymm1
	vpminud	ymm5, ymm5, ymm1
	vpand	ymm5, ymm5, ymm1
	vpor	ymm5, ymm8, ymm5
	vpand	ymm3, ymm3, ymm1
	vpor	ymm10, ymm10, ymm3
	vperm2i128	ymm3, ymm4, ymm9, 33
	vpalignr	ymm3, ymm9, ymm3, 12
	vperm2i128	ymm8, ymm4, ymm4, 10
	vpalignr	ymm8, ymm4, ymm8, 12
	vpaddd	ymm8, ymm8, ymm4
	vpaddd	ymm3, ymm9, ymm3
	vpblendd	ymm14, ymm3, ymm8, 192
	vpermq	ymm14, ymm14, 147
	vpaddd	ymm3, ymm14, ymm3
	vpblendd	ymm14, ymm8, ymm13, 192
	vpermq	ymm14, ymm14, 147
	vpaddd	ymm8, ymm14, ymm8
	vperm2i128	ymm14, ymm8, ymm3, 33
	vpaddd	ymm3, ymm14, ymm3
	vperm2i128	ymm14, ymm8, ymm8, 10
	vpaddd	ymm8, ymm14, ymm8
	vpaddd	ymm15, ymm8, ymm3
	vpsubd	ymm3, ymm15, ymm9
	vpsubd	ymm8, ymm8, ymm4
	vpbroadcastd	ymm11, xmm11
	vpaddd	ymm14, ymm11, ymm3
	vpaddd	ymm11, ymm8, ymm11
	mov	qword ptr [rsp + 264], rbp
	vmovsd	xmm1, qword ptr [rax + rbp]
	vmovaps	xmmword ptr [rsp + 528], xmm1
	vpextrq	qword ptr [rsp + 24], xmm0, 1
	vmovss	xmm0, dword ptr [rsp + 128]
	shr	r8, 3
	lea	rcx, [r8 + 64]
	mov	r9, qword ptr [rsp + 8]
	cmp	rcx, r9
	vmovdqu	ymmword ptr [rsp + 64], ymm12
	vmovdqu	ymmword ptr [rdi + 512], ymm12
	vmovdqu	ymmword ptr [rsp + 624], ymm7
	vmovdqu	ymmword ptr [rdi + 544], ymm7
	vbroadcastss	ymm3, xmm0
	vpsllvd	ymm0, ymm5, ymm9
	vmovdqu	ymmword ptr [rsp + 128], ymm0
	vpsllvd	ymm0, ymm10, ymm4
	vmovdqu	ymmword ptr [rsp + 688], ymm0
	vpsllvd	ymm0, ymm2, ymm9
	vmovdqu	ymmword ptr [rsp + 304], ymm0
	vpsllvd	ymm0, ymm2, ymm4
	vmovdqu	ymmword ptr [rsp + 656], ymm0
	vpsrld	ymm0, ymm14, 3
	vpand	ymm9, ymm14, ymm6
	vpsrld	ymm1, ymm11, 3
	vpand	ymm14, ymm11, ymm6
	vbroadcasti128	ymm2, xmmword ptr [rip + 642f]
	vpshufb	ymm0, ymm0, ymm2
	vpshufb	ymm1, ymm1, ymm2
	vmovdqu	ymm2, ymmword ptr [rsp + 400]
	vpaddb	ymm11, ymm0, ymm2
	vpaddb	ymm0, ymm1, ymm2
	jbe	72f
	sub	r9, r8
	lea	r13, [rdi + 576]
	mov	rcx, r13
	jbe	152f
	cmp	r9, 16
	mov	rbx, r8
	jb	132f
	mov	rcx, qword ptr [rsp]
	lea	r14, [r8 + rcx]
	mov	rcx, rdi
	sub	rcx, r14
	add	rcx, 575
	cmp	rcx, 127
	mov	rbx, r8
	jb	132f
	cmp	r9, 128
	jae	92f
	xor	r10d, r10d
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
	xor	eax, eax
	jmp	192f
92:
	mov	r10, r9
	and	r10, -128
	lea	rbx, [r8 + r10]
	mov	rcx, qword ptr [rsp]
	lea	rcx, [rcx + r8 + 96]
	xor	r13d, r13d
	.p2align	4
102:
	vmovdqu	ymm1, ymmword ptr [rcx + r13 - 96]
	vmovdqu	ymm13, ymmword ptr [rcx + r13 - 64]
	vmovdqu	ymm6, ymmword ptr [rcx + r13 - 32]
	vmovdqu	ymm7, ymmword ptr [rcx + r13]
	vmovdqu	ymmword ptr [rdi + r13 + 576], ymm1
	vmovdqu	ymmword ptr [rdi + r13 + 608], ymm13
	vmovdqu	ymmword ptr [rdi + r13 + 640], ymm6
	vmovdqu	ymmword ptr [rdi + r13 + 672], ymm7
	sub	r13, -128
	cmp	r10, r13
	jne	102b
	cmp	r9, r10
	lea	r13, [rdi + 576]
	mov	rcx, r13
	je	152f
	test	r9b, 112
	je	132f
112:
	mov	rcx, r9
	and	rcx, -16
	lea	rbx, [r8 + rcx]
	.p2align	4
122:
	vmovdqu	xmm1, xmmword ptr [r14 + r10]
	vmovdqu	xmmword ptr [r13 + r10], xmm1
	add	r10, 16
	cmp	rcx, r10
	jne	122b
	cmp	r9, rcx
	mov	rcx, r13
	je	152f
	.p2align	4
132:
	mov	rcx, r13
	sub	rcx, r8
	mov	r9, qword ptr [rsp]
	mov	r10, qword ptr [rsp + 8]
	.p2align	4
142:
	movzx	r8d, byte ptr [r9 + rbx]
	mov	byte ptr [rcx + rbx], r8b
	inc	rbx
	cmp	r10, rbx
	jne	142b
	mov	rcx, r13
152:
	vmovdqu	ymm1, ymmword ptr [rcx]
	vmovdqu	ymm6, ymmword ptr [rcx + 32]
	vpermq	ymm7, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm13, ymm7, ymm11
	vpshufb	ymm2, ymm1, ymm11
	vpbroadcastb	ymm4, byte ptr [rip + 652f]
	vpand	ymm12, ymm11, ymm4
	vpxor	xmm5, xmm5, xmm5
	vpcmpeqb	ymm12, ymm12, ymm5
	vpblendvb	ymm2, ymm2, ymm13, ymm12
	vpermq	ymm13, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm8, ymm13, ymm11
	vpshufb	ymm10, ymm6, ymm11
	vpblendvb	ymm8, ymm10, ymm8, ymm12
	vpshufb	ymm7, ymm7, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpand	ymm10, ymm0, ymm4
	vpcmpeqb	ymm10, ymm10, ymm5
	vpblendvb	ymm1, ymm1, ymm7, ymm10
	vpshufb	ymm7, ymm13, ymm0
	vpxor	xmm13, xmm13, xmm13
	vpshufb	ymm6, ymm6, ymm0
	vpblendvb	ymm6, ymm6, ymm7, ymm10
	vpbroadcastb	ymm4, byte ptr [rip + 662f]
	vpand	ymm0, ymm0, ymm4
	vpcmpeqb	ymm0, ymm0, ymm4
	vpblendvb	ymm0, ymm1, ymm6, ymm0
	vpand	ymm1, ymm11, ymm4
	vpcmpeqb	ymm1, ymm1, ymm4
	vpblendvb	ymm1, ymm2, ymm8, ymm1
	vpsrlvd	ymm0, ymm0, ymm14
	vmovdqu	ymm2, ymmword ptr [rsp + 656]
	vpandn	ymm0, ymm2, ymm0
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 688]
	vpsrlvd	ymm1, ymm1, ymm9
	vmovdqu	ymm2, ymmword ptr [rsp + 304]
	vpandn	ymm1, ymm2, ymm1
	vpaddd	ymm1, ymm1, ymmword ptr [rsp + 128]
	vpor	ymm2, ymm1, ymmword ptr [rip + 672f]
	vpcmpeqd	ymm1, ymm13, ymm1
	vpandn	ymm1, ymm1, ymm2
	vpor	ymm2, ymm0, ymmword ptr [rip + 682f]
	vpcmpeqd	ymm0, ymm13, ymm0
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
	vpblendd	ymm1, ymm2, ymm13, 192
	vpermq	ymm1, ymm1, 147
	vpmaxud	ymm1, ymm2, ymm1
	vperm2i128	ymm2, ymm1, ymm1, 10
	vpmaxud	ymm2, ymm1, ymm2
	vperm2i128	ymm1, ymm1, ymm0, 33
	vpmaxud	ymm0, ymm0, ymm1
	vpmaxud	ymm0, ymm0, ymm2
	vmovdqu	ymm5, ymmword ptr [rsp + 368]
	vpand	ymm1, ymm0, ymm5
	vpcmpeqd	ymm0, ymm13, ymm0
	vblendvps	ymm0, ymm1, ymm3, ymm0
	vpand	ymm1, ymm2, ymm5
	vpcmpeqd	ymm2, ymm13, ymm2
	vblendvps	ymm1, ymm1, ymm3, ymm2
	vmovdqu	ymm2, ymmword ptr [rsp + 64]
	vpsrlw	xmm2, xmm2, 2
	vpand	xmm2, xmm2, xmmword ptr [rip + 692f]
	vpminub	xmm2, xmm2, xmm4
	vpmovzxbd	ymm3, xmm2
	vpmaxud	ymm1, ymm1, ymm3
	vextracti128	xmm3, ymm15, 1
	vpextrd	ecx, xmm3, 3
	vmovdqu	ymmword ptr [rdi + 256], ymm1
	vpshufd	xmm1, xmm2, 238
	vpmovzxbd	ymm1, xmm1
	vpmaxud	ymm1, ymm0, ymm1
	vmovdqu	ymmword ptr [rdi + 288], ymm1
	mov	r8, r15
	imul	r8, qword ptr [rsp + 24]
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm15, ymm0, 170
	mov	r14, qword ptr [rsp + 96]
	add	r14, rcx
	cmp	qword ptr [rsp + 336], 17
	jb	362f
	mov	rax, qword ptr [rsp + 248]
	mov	rcx, qword ptr [rsp + 240]
	sub	rax, rcx
	xor	rcx, r15
	shl	rcx, 7
	or	rcx, rax
	vmovq	xmm0, rcx
	vmovdqa	xmm1, xmmword ptr [rsp + 592]
	vpshufb	xmm0, xmm1, xmm0
	mov	rax, qword ptr [rsp + 256]
	sub	rax, r11
	xor	r11, r15
	shl	r11, 7
	or	r11, rax
	vmovq	xmm1, r11
	vmovdqa	xmm2, xmmword ptr [rsp + 608]
	vpshufb	xmm1, xmm2, xmm1
	vpunpcklqdq	xmm0, xmm0, xmm1
	vpshufd	xmm1, xmm0, 238
	vpmovzxbd	ymm1, xmm1
	vpmovzxbd	ymm2, xmm0
	vpsrld	ymm3, ymm2, 3
	vpsrld	ymm0, ymm1, 3
	vmovdqu	ymm4, ymmword ptr [rsp + 496]
	vpmaxud	ymm0, ymm0, ymm4
	vpcmpeqd	ymm6, ymm6, ymm6
	vpaddd	ymm0, ymm0, ymm6
	vpmaxud	ymm3, ymm3, ymm4
	vpaddd	ymm4, ymm3, ymm6
	vmovdqu	ymm9, ymmword ptr [rsp + 464]
	vpand	ymm3, ymm9, ymm2
	vpand	ymm5, ymm9, ymm1
	vmovdqu	ymm7, ymmword ptr [rsp + 432]
	vpminud	ymm1, ymm1, ymm7
	vpminud	ymm2, ymm2, ymm7
	vpand	ymm2, ymm2, ymm7
	vpor	ymm2, ymm2, ymm3
	vpand	ymm1, ymm1, ymm7
	vpor	ymm1, ymm1, ymm5
	vpsllvd	ymm2, ymm2, ymm4
	vmovdqu	ymmword ptr [rsp + 128], ymm2
	vpsllvd	ymm1, ymm1, ymm0
	vmovdqu	ymmword ptr [rsp + 96], ymm1
	vpsllvd	ymm10, ymm6, ymm4
	vpsllvd	ymm1, ymm6, ymm0
	vmovdqu	ymmword ptr [rsp + 304], ymm1
	vperm2i128	ymm1, ymm4, ymm0, 33
	vpalignr	ymm1, ymm0, ymm1, 12
	vperm2i128	ymm2, ymm4, ymm4, 10
	vpalignr	ymm2, ymm4, ymm2, 12
	vpaddd	ymm2, ymm2, ymm4
	vpaddd	ymm1, ymm1, ymm0
	vpblendd	ymm5, ymm2, ymm13, 192
	vpermq	ymm5, ymm5, 147
	vpaddd	ymm5, ymm5, ymm2
	vpblendd	ymm2, ymm1, ymm2, 192
	vpermq	ymm2, ymm2, 147
	vpaddd	ymm1, ymm2, ymm1
	vperm2i128	ymm2, ymm5, ymm5, 10
	vpaddd	ymm2, ymm2, ymm5
	vperm2i128	ymm5, ymm5, ymm1, 33
	vpaddd	ymm1, ymm5, ymm1
	vpaddd	ymm1, ymm2, ymm1
	vpsubd	ymm0, ymm1, ymm0
	vpsubd	ymm2, ymm2, ymm4
	mov	eax, r14d
	and	eax, 7
	vmovd	xmm4, eax
	vpbroadcastd	ymm4, xmm4
	vpaddd	ymm0, ymm4, ymm0
	vpaddd	ymm2, ymm4, ymm2
	vpsrld	ymm6, ymm0, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm5, ymm9, ymm0
	vpand	ymm4, ymm9, ymm2
	vbroadcasti128	ymm2, xmmword ptr [rip + 642f]
	vpshufb	ymm0, ymm6, ymm2
	vpshufb	ymm2, ymm7, ymm2
	vmovdqu	ymm3, ymmword ptr [rsp + 400]
	vpaddb	ymm9, ymm0, ymm3
	vpaddb	ymm11, ymm2, ymm3
	mov	r11, r14
	shr	r11, 3
	lea	rax, [r11 + 64]
	mov	r9, qword ptr [rsp + 8]
	cmp	rax, r9
	jbe	162f
	sub	r9, r11
	mov	rcx, r13
	jbe	272f
	cmp	r9, 16
	mov	rax, r11
	jb	252f
	mov	rax, qword ptr [rsp]
	lea	rbx, [r11 + rax]
	mov	rax, rdi
	sub	rax, rbx
	add	rax, 575
	cmp	rax, 127
	mov	rax, r11
	jb	252f
	cmp	r9, 128
	jae	212f
	xor	r10d, r10d
	jmp	232f
	.p2align	4
162:
	add	r11, qword ptr [rsp]
	mov	rcx, r11
	jmp	272f
172:
	mov	qword ptr [rsp + 32], r8
	mov	rax, r8
	and	rax, -128
	lea	r14, [r10 + rax]
	mov	rcx, qword ptr [rsp + 40]
	add	rcx, r15
	lea	r8, [r13 + r9]
	and	r8, -128
	xor	r9d, r9d
	.p2align	4
182:
	vmovdqu	ymm0, ymmword ptr [rcx + r9 - 96]
	vmovdqu	ymm1, ymmword ptr [rcx + r9 - 64]
	vmovdqu	ymm3, ymmword ptr [rcx + r9 - 32]
	vmovdqu	ymm4, ymmword ptr [rcx + r9]
	vmovdqu	ymmword ptr [rdi + r9 + 512], ymm0
	vmovdqu	ymmword ptr [rdi + r9 + 544], ymm1
	vmovdqu	ymmword ptr [rdi + r9 + 576], ymm3
	vmovdqu	ymmword ptr [rdi + r9 + 608], ymm4
	sub	r9, -128
	cmp	r8, r9
	jne	182b
	mov	r8, qword ptr [rsp + 32]
	cmp	r8, rax
	lea	rcx, [rdi + 512]
	mov	r9, qword ptr [rsp + 48]
	je	62b
	test	r8b, 112
	je	32b
192:
	mov	r14, r8
	mov	rcx, r8
	and	rcx, -16
	lea	r8, [r15 + r10]
	add	r10, rcx
	add	r13, r9
	and	r13, -16
	.p2align	4
202:
	vmovdqu	xmm0, xmmword ptr [r8 + rax]
	lea	r9, [rdi + 512]
	vmovdqu	xmmword ptr [r9 + rax], xmm0
	add	rax, 16
	cmp	r13, rax
	jne	202b
	cmp	r14, rcx
	mov	r14, r10
	lea	rcx, [rdi + 512]
	je	62b
	jmp	32b
212:
	mov	r12, r14
	mov	r10, r9
	and	r10, -128
	lea	rax, [r11 + r10]
	mov	rcx, qword ptr [rsp]
	lea	rcx, [rcx + r11 + 96]
	xor	r14d, r14d
	.p2align	4
222:
	vmovdqu	ymm0, ymmword ptr [rcx + r14 - 96]
	vmovdqu	ymm2, ymmword ptr [rcx + r14 - 64]
	vmovdqu	ymm6, ymmword ptr [rcx + r14 - 32]
	vmovdqu	ymm7, ymmword ptr [rcx + r14]
	vmovdqu	ymmword ptr [rdi + r14 + 576], ymm0
	vmovdqu	ymmword ptr [rdi + r14 + 608], ymm2
	vmovdqu	ymmword ptr [rdi + r14 + 640], ymm6
	vmovdqu	ymmword ptr [rdi + r14 + 672], ymm7
	sub	r14, -128
	cmp	r10, r14
	jne	222b
	cmp	r9, r10
	mov	rcx, r13
	mov	r14, r12
	je	272f
	test	r9b, 112
	je	252f
232:
	mov	rcx, r9
	and	rcx, -16
	lea	rax, [r11 + rcx]
	.p2align	4
242:
	vmovdqu	xmm0, xmmword ptr [rbx + r10]
	vmovdqu	xmmword ptr [r13 + r10], xmm0
	add	r10, 16
	cmp	rcx, r10
	jne	242b
	cmp	r9, rcx
	mov	rcx, r13
	je	272f
252:
	mov	rcx, r13
	sub	rcx, r11
	mov	r10, qword ptr [rsp]
	mov	r11, qword ptr [rsp + 8]
	.p2align	4
262:
	movzx	r9d, byte ptr [r10 + rax]
	mov	byte ptr [rcx + rax], r9b
	inc	rax
	cmp	r11, rax
	jne	262b
	mov	rcx, r13
272:
	vmovdqu	ymm0, ymmword ptr [rcx]
	vpermq	ymm2, ymm0, 68
	vpermq	ymm0, ymm0, 238
	vpshufb	ymm6, ymm2, ymm9
	vpshufb	ymm7, ymm0, ymm9
	vpbroadcastb	ymm8, byte ptr [rip + 652f]
	vpand	ymm12, ymm9, ymm8
	vpcmpeqb	ymm12, ymm12, ymm13
	vpblendvb	ymm6, ymm7, ymm6, ymm12
	vmovdqu	ymm7, ymmword ptr [rcx + 32]
	vpermq	ymm14, ymm7, 68
	vpermq	ymm7, ymm7, 238
	vpshufb	ymm3, ymm14, ymm9
	vpshufb	ymm13, ymm7, ymm9
	vpblendvb	ymm3, ymm13, ymm3, ymm12
	vpxor	xmm13, xmm13, xmm13
	vpshufb	ymm2, ymm2, ymm11
	vpshufb	ymm0, ymm0, ymm11
	vpand	ymm12, ymm11, ymm8
	vpcmpeqb	ymm12, ymm12, ymm13
	vpblendvb	ymm0, ymm0, ymm2, ymm12
	vpshufb	ymm2, ymm14, ymm11
	vpshufb	ymm7, ymm7, ymm11
	vpblendvb	ymm2, ymm7, ymm2, ymm12
	vpbroadcastb	ymm8, byte ptr [rip + 662f]
	vpand	ymm7, ymm11, ymm8
	vpcmpeqb	ymm7, ymm8, ymm7
	vpblendvb	ymm0, ymm0, ymm2, ymm7
	vpand	ymm2, ymm9, ymm8
	vpcmpeqb	ymm2, ymm8, ymm2
	vpblendvb	ymm2, ymm6, ymm3, ymm2
	vpsrlvd	ymm0, ymm0, ymm4
	vpandn	ymm0, ymm10, ymm0
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 128]
	vpsrlvd	ymm2, ymm2, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 304]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 96]
	vpor	ymm3, ymm2, ymmword ptr [rip + 672f]
	vpcmpeqd	ymm2, ymm13, ymm2
	vpandn	ymm2, ymm2, ymm3
	vpor	ymm3, ymm0, ymmword ptr [rip + 682f]
	vpcmpeqd	ymm0, ymm13, ymm0
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
	vpblendd	ymm2, ymm3, ymm13, 192
	vpermq	ymm2, ymm2, 147
	vpmaxud	ymm2, ymm3, ymm2
	vperm2i128	ymm3, ymm2, ymm2, 10
	vpmaxud	ymm3, ymm2, ymm3
	vperm2i128	ymm2, ymm2, ymm0, 33
	vpmaxud	ymm0, ymm0, ymm2
	vpmaxud	ymm0, ymm0, ymm3
	vmovdqu	ymm4, ymmword ptr [rsp + 368]
	vpand	ymm2, ymm0, ymm4
	vpcmpeqd	ymm0, ymm13, ymm0
	vblendvps	ymm0, ymm2, ymm15, ymm0
	vpand	ymm2, ymm3, ymm4
	vpcmpeqd	ymm3, ymm13, ymm3
	vblendvps	ymm2, ymm2, ymm15, ymm3
	vmovdqu	ymm3, ymmword ptr [rsp + 64]
	vextracti128	xmm3, ymm3, 1
	vpsrlw	xmm3, xmm3, 2
	vpand	xmm3, xmm3, xmmword ptr [rip + 692f]
	vpminub	xmm3, xmm8, xmm3
	vpmovzxbd	ymm4, xmm3
	vpmaxud	ymm2, ymm2, ymm4
	vextracti128	xmm1, ymm1, 1
	vpextrd	eax, xmm1, 3
	vmovdqu	ymmword ptr [rdi + 320], ymm2
	vpshufd	xmm1, xmm3, 238
	vpmovzxbd	ymm1, xmm1
	vpmaxud	ymm1, ymm0, ymm1
	vmovdqu	ymmword ptr [rdi + 352], ymm1
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm15, ymm0, 170
	add	r14, rax
	cmp	qword ptr [rsp + 336], 33
	jb	362f
	mov	rax, qword ptr [rsp + 224]
	mov	rcx, qword ptr [rsp + 208]
	sub	rcx, rax
	xor	rax, r15
	shl	rax, 7
	or	rax, rcx
	vmovq	xmm0, rax
	vmovdqa	xmm1, xmmword ptr [rsp + 560]
	vpshufb	xmm0, xmm1, xmm0
	mov	rax, qword ptr [rsp + 232]
	mov	rcx, qword ptr [rsp + 216]
	sub	rcx, rax
	xor	rax, r15
	shl	rax, 7
	or	rax, rcx
	vmovq	xmm1, rax
	vmovdqa	xmm2, xmmword ptr [rsp + 576]
	vpshufb	xmm1, xmm2, xmm1
	vpunpcklqdq	xmm0, xmm0, xmm1
	vpshufd	xmm1, xmm0, 238
	vpmovzxbd	ymm1, xmm1
	vpmovzxbd	ymm2, xmm0
	vpsrld	ymm3, ymm2, 3
	vpsrld	ymm0, ymm1, 3
	vmovdqu	ymm4, ymmword ptr [rsp + 496]
	vpmaxud	ymm0, ymm0, ymm4
	vpcmpeqd	ymm6, ymm6, ymm6
	vpaddd	ymm0, ymm0, ymm6
	vpmaxud	ymm3, ymm3, ymm4
	vpaddd	ymm4, ymm3, ymm6
	vmovdqu	ymm8, ymmword ptr [rsp + 464]
	vpand	ymm3, ymm8, ymm2
	vpand	ymm5, ymm8, ymm1
	vmovdqu	ymm7, ymmword ptr [rsp + 432]
	vpminud	ymm1, ymm1, ymm7
	vpminud	ymm2, ymm2, ymm7
	vpand	ymm2, ymm2, ymm7
	vpor	ymm2, ymm2, ymm3
	vpand	ymm1, ymm1, ymm7
	vpor	ymm1, ymm1, ymm5
	vpsllvd	ymm2, ymm2, ymm4
	vmovdqu	ymmword ptr [rsp + 64], ymm2
	vpsllvd	ymm1, ymm1, ymm0
	vmovdqu	ymmword ptr [rsp + 96], ymm1
	vpsllvd	ymm1, ymm6, ymm4
	vmovdqu	ymmword ptr [rsp + 304], ymm1
	vpsllvd	ymm1, ymm6, ymm0
	vmovdqu	ymmword ptr [rsp + 128], ymm1
	vperm2i128	ymm1, ymm4, ymm0, 33
	vpalignr	ymm1, ymm0, ymm1, 12
	vperm2i128	ymm2, ymm4, ymm4, 10
	vpalignr	ymm2, ymm4, ymm2, 12
	vpaddd	ymm2, ymm2, ymm4
	vpaddd	ymm1, ymm1, ymm0
	vpblendd	ymm5, ymm2, ymm13, 192
	vpermq	ymm5, ymm5, 147
	vpaddd	ymm5, ymm5, ymm2
	vpblendd	ymm2, ymm1, ymm2, 192
	vpermq	ymm2, ymm2, 147
	vpaddd	ymm1, ymm2, ymm1
	vperm2i128	ymm2, ymm5, ymm5, 10
	vpaddd	ymm2, ymm2, ymm5
	vperm2i128	ymm5, ymm5, ymm1, 33
	vpaddd	ymm1, ymm5, ymm1
	vpaddd	ymm1, ymm2, ymm1
	vpsubd	ymm0, ymm1, ymm0
	vpsubd	ymm2, ymm2, ymm4
	mov	eax, r14d
	and	eax, 7
	vmovd	xmm4, eax
	vpbroadcastd	ymm4, xmm4
	vpaddd	ymm0, ymm4, ymm0
	vpaddd	ymm2, ymm4, ymm2
	vpsrld	ymm6, ymm0, 3
	vpsrld	ymm7, ymm2, 3
	vpand	ymm5, ymm8, ymm0
	vpand	ymm4, ymm8, ymm2
	vbroadcasti128	ymm2, xmmword ptr [rip + 642f]
	vpshufb	ymm0, ymm6, ymm2
	vpshufb	ymm2, ymm7, ymm2
	vmovdqu	ymm3, ymmword ptr [rsp + 400]
	vpaddb	ymm9, ymm0, ymm3
	vpaddb	ymm11, ymm2, ymm3
	mov	r11, r14
	shr	r11, 3
	lea	rax, [r11 + 64]
	mov	r9, qword ptr [rsp + 8]
	cmp	rax, r9
	jbe	282f
	sub	r9, r11
	mov	rcx, r13
	jbe	352f
	cmp	r9, 16
	mov	rax, r11
	jb	332f
	mov	rax, qword ptr [rsp]
	lea	rbx, [r11 + rax]
	mov	rax, rdi
	sub	rax, rbx
	add	rax, 575
	cmp	rax, 127
	mov	rax, r11
	jb	332f
	cmp	r9, 128
	jae	292f
	xor	r10d, r10d
	jmp	312f
282:
	add	r11, qword ptr [rsp]
	mov	rcx, r11
	jmp	352f
292:
	mov	r12, r14
	mov	r10, r9
	and	r10, -128
	lea	rax, [r11 + r10]
	mov	rcx, qword ptr [rsp]
	lea	rcx, [rcx + r11 + 96]
	xor	r14d, r14d
	.p2align	4
302:
	vmovdqu	ymm0, ymmword ptr [rcx + r14 - 96]
	vmovdqu	ymm2, ymmword ptr [rcx + r14 - 64]
	vmovdqu	ymm6, ymmword ptr [rcx + r14 - 32]
	vmovdqu	ymm7, ymmword ptr [rcx + r14]
	vmovdqu	ymmword ptr [rdi + r14 + 576], ymm0
	vmovdqu	ymmword ptr [rdi + r14 + 608], ymm2
	vmovdqu	ymmword ptr [rdi + r14 + 640], ymm6
	vmovdqu	ymmword ptr [rdi + r14 + 672], ymm7
	sub	r14, -128
	cmp	r10, r14
	jne	302b
	cmp	r9, r10
	mov	rcx, r13
	mov	r14, r12
	je	352f
	test	r9b, 112
	je	332f
312:
	mov	rcx, r9
	and	rcx, -16
	lea	rax, [r11 + rcx]
	.p2align	4
322:
	vmovdqu	xmm0, xmmword ptr [rbx + r10]
	vmovdqu	xmmword ptr [r13 + r10], xmm0
	add	r10, 16
	cmp	rcx, r10
	jne	322b
	cmp	r9, rcx
	mov	rcx, r13
	je	352f
332:
	mov	rcx, r13
	sub	rcx, r11
	mov	r10, qword ptr [rsp]
	mov	r11, qword ptr [rsp + 8]
	.p2align	4
342:
	movzx	r9d, byte ptr [r10 + rax]
	mov	byte ptr [rcx + rax], r9b
	inc	rax
	cmp	r11, rax
	jne	342b
	mov	rcx, r13
352:
	vmovdqu	ymm0, ymmword ptr [rcx]
	vmovdqu	ymm2, ymmword ptr [rcx + 32]
	vpermq	ymm6, ymm0, 68
	vpermq	ymm0, ymm0, 238
	vpshufb	ymm7, ymm6, ymm9
	vpshufb	ymm13, ymm0, ymm9
	vpbroadcastb	ymm12, byte ptr [rip + 652f]
	vpand	ymm14, ymm9, ymm12
	vpxor	xmm10, xmm10, xmm10
	vpcmpeqb	ymm14, ymm14, ymm10
	vpblendvb	ymm7, ymm13, ymm7, ymm14
	vpermq	ymm13, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm3, ymm13, ymm9
	vpshufb	ymm8, ymm2, ymm9
	vpblendvb	ymm3, ymm8, ymm3, ymm14
	vpshufb	ymm6, ymm6, ymm11
	vpshufb	ymm0, ymm0, ymm11
	vpand	ymm8, ymm11, ymm12
	vpcmpeqb	ymm8, ymm8, ymm10
	vpblendvb	ymm0, ymm0, ymm6, ymm8
	vpshufb	ymm6, ymm13, ymm11
	vpxor	xmm13, xmm13, xmm13
	vpshufb	ymm2, ymm2, ymm11
	vpblendvb	ymm2, ymm2, ymm6, ymm8
	vpbroadcastb	ymm8, byte ptr [rip + 662f]
	vpand	ymm6, ymm11, ymm8
	vpcmpeqb	ymm6, ymm8, ymm6
	vpblendvb	ymm0, ymm0, ymm2, ymm6
	vpand	ymm2, ymm9, ymm8
	vpcmpeqb	ymm2, ymm8, ymm2
	vpblendvb	ymm2, ymm7, ymm3, ymm2
	vpsrlvd	ymm0, ymm0, ymm4
	vmovdqu	ymm3, ymmword ptr [rsp + 304]
	vpandn	ymm0, ymm3, ymm0
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 64]
	vpsrlvd	ymm2, ymm2, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 128]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 96]
	vpor	ymm3, ymm2, ymmword ptr [rip + 672f]
	vpcmpeqd	ymm2, ymm13, ymm2
	vpandn	ymm2, ymm2, ymm3
	vpor	ymm3, ymm0, ymmword ptr [rip + 682f]
	vpcmpeqd	ymm0, ymm13, ymm0
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
	vpblendd	ymm2, ymm3, ymm13, 192
	vpermq	ymm2, ymm2, 147
	vpmaxud	ymm2, ymm3, ymm2
	vperm2i128	ymm3, ymm2, ymm2, 10
	vpmaxud	ymm3, ymm2, ymm3
	vperm2i128	ymm2, ymm2, ymm0, 33
	vpmaxud	ymm0, ymm0, ymm2
	vpmaxud	ymm0, ymm0, ymm3
	vmovdqu	ymm4, ymmword ptr [rsp + 368]
	vpand	ymm2, ymm0, ymm4
	vpcmpeqd	ymm0, ymm13, ymm0
	vblendvps	ymm0, ymm2, ymm15, ymm0
	vpand	ymm2, ymm3, ymm4
	vpcmpeqd	ymm3, ymm13, ymm3
	vblendvps	ymm2, ymm2, ymm15, ymm3
	vmovdqu	ymm3, ymmword ptr [rsp + 624]
	vpsrlw	xmm3, xmm3, 2
	vpand	xmm3, xmm3, xmmword ptr [rip + 692f]
	vpminub	xmm3, xmm8, xmm3
	vpmovzxbd	ymm4, xmm3
	vpmaxud	ymm2, ymm2, ymm4
	vextracti128	xmm1, ymm1, 1
	vpextrd	eax, xmm1, 3
	vmovdqu	ymmword ptr [rdi + 384], ymm2
	vpshufd	xmm1, xmm3, 238
	vpmovzxbd	ymm1, xmm1
	vpmaxud	ymm1, ymm0, ymm1
	vmovdqu	ymmword ptr [rdi + 416], ymm1
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm15, ymm0, 170
	add	r14, rax
	cmp	qword ptr [rsp + 336], 49
	jb	362f
	mov	rax, qword ptr [rsp + 200]
	mov	rcx, qword ptr [rsp + 192]
	sub	rcx, rax
	xor	rax, r15
	shl	rax, 7
	or	rax, rcx
	vmovq	xmm0, rax
	vmovdqa	xmm1, xmmword ptr [rsp + 544]
	vpshufb	xmm0, xmm1, xmm0
	mov	rax, r8
	mov	rcx, qword ptr [rsp + 24]
	sub	rax, rcx
	xor	r15, rcx
	shl	r15, 7
	or	r15, rax
	vmovq	xmm1, r15
	vmovdqa	xmm2, xmmword ptr [rsp + 528]
	vpshufb	xmm1, xmm2, xmm1
	vpmovzxbd	ymm2, xmm0
	vpmovzxbd	ymm1, xmm1
	vpsrld	ymm3, ymm1, 3
	vpsrld	ymm0, ymm2, 3
	vmovdqu	ymm4, ymmword ptr [rsp + 496]
	vpmaxud	ymm0, ymm0, ymm4
	vpcmpeqd	ymm6, ymm6, ymm6
	vpaddd	ymm0, ymm0, ymm6
	vpmaxud	ymm3, ymm3, ymm4
	vpaddd	ymm4, ymm3, ymm6
	vmovdqu	ymm7, ymmword ptr [rsp + 464]
	vpand	ymm3, ymm1, ymm7
	vpand	ymm5, ymm2, ymm7
	vmovdqu	ymm8, ymmword ptr [rsp + 432]
	vpminud	ymm2, ymm2, ymm8
	vpminud	ymm1, ymm1, ymm8
	vpand	ymm1, ymm8, ymm1
	vpor	ymm1, ymm1, ymm3
	vpand	ymm2, ymm8, ymm2
	vpor	ymm2, ymm2, ymm5
	vpsllvd	ymm1, ymm1, ymm4
	vmovdqu	ymmword ptr [rsp + 96], ymm1
	vpsllvd	ymm1, ymm2, ymm0
	vmovdqu	ymmword ptr [rsp + 64], ymm1
	vpsllvd	ymm1, ymm6, ymm4
	vmovdqu	ymmword ptr [rsp + 336], ymm1
	vpsllvd	ymm12, ymm6, ymm0
	vperm2i128	ymm1, ymm0, ymm4, 33
	vpalignr	ymm1, ymm4, ymm1, 12
	vperm2i128	ymm2, ymm0, ymm0, 10
	vpalignr	ymm2, ymm0, ymm2, 12
	vpaddd	ymm2, ymm2, ymm0
	vpaddd	ymm1, ymm1, ymm4
	vpblendd	ymm5, ymm1, ymm2, 192
	vpermq	ymm5, ymm5, 147
	vpaddd	ymm1, ymm5, ymm1
	vpblendd	ymm5, ymm2, ymm13, 192
	vpermq	ymm5, ymm5, 147
	vpaddd	ymm2, ymm5, ymm2
	vperm2i128	ymm5, ymm2, ymm1, 33
	vpaddd	ymm1, ymm5, ymm1
	vperm2i128	ymm5, ymm2, ymm2, 10
	vpaddd	ymm2, ymm5, ymm2
	vpaddd	ymm1, ymm2, ymm1
	vpsubd	ymm4, ymm1, ymm4
	vpsubd	ymm0, ymm2, ymm0
	mov	eax, r14d
	and	eax, 7
	vmovd	xmm2, eax
	vpbroadcastd	ymm2, xmm2
	vpaddd	ymm4, ymm2, ymm4
	vpaddd	ymm0, ymm2, ymm0
	vpsrld	ymm2, ymm4, 3
	vpsrld	ymm6, ymm0, 3
	vpand	ymm5, ymm4, ymm7
	vpand	ymm4, ymm0, ymm7
	vbroadcasti128	ymm3, xmmword ptr [rip + 642f]
	vpshufb	ymm0, ymm2, ymm3
	vpshufb	ymm2, ymm6, ymm3
	vmovdqu	ymm3, ymmword ptr [rsp + 400]
	vpaddb	ymm9, ymm0, ymm3
	vpaddb	ymm11, ymm2, ymm3
	mov	r11, r14
	shr	r11, 3
	lea	rax, [r11 + 64]
	mov	r9, qword ptr [rsp + 8]
	cmp	rax, r9
	jbe	472f
	sub	r9, r11
	mov	rcx, r13
	mov	r15, qword ptr [rsp + 16]
	jbe	542f
	cmp	r9, 16
	mov	rax, r11
	jb	522f
	mov	rax, qword ptr [rsp]
	lea	r10, [r11 + rax]
	mov	rax, rdi
	sub	rax, r10
	add	rax, 575
	cmp	rax, 127
	mov	rax, r11
	jb	522f
	cmp	r9, 128
	jae	482f
	xor	ebx, ebx
	jmp	502f
	.p2align	4
362:
	mov	r15, qword ptr [rsp + 16]
372:
	shr	r8, 56
	mov	r9, qword ptr [rsp + 264]
	add	r9, r8
	mov	rax, qword ptr [rsp + 272]
	shr	rax, 56
	mov	rcx, qword ptr [rsp + 32]
	add	rcx, rax
	vmovd	eax, xmm15
	mov	qword ptr [rdi + 72], r14
	mov	qword ptr [rdi + 96], rax
	mov	qword ptr [rdi + 128], rcx
	mov	qword ptr [rdi + 136], r9
	xor	eax, eax
	mov	rbx, qword ptr [rsp + 184]
	.p2align	4
382:
	movzx	r9d, byte ptr [rdi + rax + 512]
	movzx	r8d, byte ptr [rdi + rax + 192]
	cmp	r8, 33
	mov	r10d, dword ptr [rdi + 4*rax + 256]
	vmovdqu	ymm0, ymmword ptr [rsi]
	vmovdqu	ymmword ptr [rdx], ymm0
	jae	422f
392:
	add	rdx, r8
	mov	r11, rdx
	sub	r11, r10
	cmp	r11, rbx
	jl	442f
	vmovdqu	ymm0, ymmword ptr [r11]
	vmovdqu	ymmword ptr [rdx], ymm0
	cmp	r9b, -124
	jae	452f
402:
	shr	r9d, 2
412:
	add	rdx, r9
	add	rsi, r8
	inc	rax
	cmp	rax, r15
	jne	382b
	jmp	2b
422:
	mov	rcx, qword ptr [rdi + 48]
	mov	r11, qword ptr [rdi + 120]
	movzx	r8d, byte ptr [rcx + r11]
	inc	r11
	mov	qword ptr [rdi + 120], r11
	add	r8, 33
	mov	ecx, 32
	.p2align	4
432:
	vmovdqu	ymm0, ymmword ptr [rsi + rcx]
	vmovdqu	ymmword ptr [rdx + rcx], ymm0
	add	rcx, 32
	cmp	rcx, r8
	jb	432b
	jmp	392b
442:
	mov	rcx, rdx
	sub	rcx, rbx
	sub	rcx, r10
	mov	r11d, 0
	cmovae	r11, rcx
	add	r11, rbx
	vmovdqu	ymm0, ymmword ptr [r11]
	vmovdqu	ymmword ptr [rdx], ymm0
	cmp	r9b, -124
	jb	402b
452:
	mov	rcx, qword ptr [rdi + 48]
	mov	r10, qword ptr [rdi + 120]
	movzx	r9d, byte ptr [rcx + r10]
	inc	r10
	mov	qword ptr [rdi + 120], r10
	add	r9, 33
	mov	ecx, 32
	.p2align	4
462:
	vmovdqu	ymm0, ymmword ptr [r11 + rcx]
	vmovdqu	ymmword ptr [rdx + rcx], ymm0
	add	rcx, 32
	cmp	rcx, r9
	jb	462b
	jmp	412b
472:
	mov	rcx, qword ptr [rsp]
	add	rcx, r11
	mov	r15, qword ptr [rsp + 16]
	jmp	542f
482:
	mov	r12, r14
	mov	rbx, r9
	and	rbx, -128
	lea	rax, [r11 + rbx]
	mov	rcx, qword ptr [rsp]
	lea	rcx, [rcx + r11 + 96]
	xor	r14d, r14d
	.p2align	4
492:
	vmovdqu	ymm0, ymmword ptr [rcx + r14 - 96]
	vmovdqu	ymm2, ymmword ptr [rcx + r14 - 64]
	vmovdqu	ymm6, ymmword ptr [rcx + r14 - 32]
	vmovdqu	ymm7, ymmword ptr [rcx + r14]
	vmovdqu	ymmword ptr [rdi + r14 + 576], ymm0
	vmovdqu	ymmword ptr [rdi + r14 + 608], ymm2
	vmovdqu	ymmword ptr [rdi + r14 + 640], ymm6
	vmovdqu	ymmword ptr [rdi + r14 + 672], ymm7
	sub	r14, -128
	cmp	rbx, r14
	jne	492b
	cmp	r9, rbx
	mov	rcx, r13
	mov	r14, r12
	je	542f
	test	r9b, 112
	je	522f
502:
	mov	rcx, r9
	and	rcx, -16
	lea	rax, [r11 + rcx]
	.p2align	4
512:
	vmovdqu	xmm0, xmmword ptr [r10 + rbx]
	vmovdqu	xmmword ptr [r13 + rbx], xmm0
	add	rbx, 16
	cmp	rcx, rbx
	jne	512b
	cmp	r9, rcx
	mov	rcx, r13
	je	542f
522:
	mov	rcx, r13
	sub	rcx, r11
	mov	r10, qword ptr [rsp]
	mov	r11, qword ptr [rsp + 8]
	.p2align	4
532:
	movzx	r9d, byte ptr [r10 + rax]
	mov	byte ptr [rcx + rax], r9b
	inc	rax
	cmp	r11, rax
	jne	532b
	mov	rcx, r13
542:
	vmovdqu	ymm0, ymmword ptr [rcx]
	vpermq	ymm2, ymm0, 68
	vpermq	ymm0, ymm0, 238
	vpshufb	ymm6, ymm2, ymm9
	vpshufb	ymm7, ymm0, ymm9
	vpbroadcastb	ymm10, byte ptr [rip + 652f]
	vpand	ymm13, ymm9, ymm10
	vpxor	xmm3, xmm3, xmm3
	vpcmpeqb	ymm13, ymm13, ymm3
	vpblendvb	ymm6, ymm7, ymm6, ymm13
	vmovdqu	ymm7, ymmword ptr [rcx + 32]
	vpermq	ymm14, ymm7, 68
	vpermq	ymm7, ymm7, 238
	vpshufb	ymm3, ymm14, ymm9
	vpshufb	ymm8, ymm7, ymm9
	vpblendvb	ymm3, ymm8, ymm3, ymm13
	vpxor	xmm13, xmm13, xmm13
	vpshufb	ymm2, ymm2, ymm11
	vpshufb	ymm0, ymm0, ymm11
	vpand	ymm8, ymm11, ymm10
	vpcmpeqb	ymm8, ymm8, ymm13
	vpblendvb	ymm0, ymm0, ymm2, ymm8
	vpshufb	ymm2, ymm14, ymm11
	vpshufb	ymm7, ymm7, ymm11
	vpblendvb	ymm2, ymm7, ymm2, ymm8
	vpbroadcastb	ymm8, byte ptr [rip + 662f]
	vpand	ymm7, ymm11, ymm8
	vpcmpeqb	ymm7, ymm8, ymm7
	vpblendvb	ymm0, ymm0, ymm2, ymm7
	vpand	ymm2, ymm9, ymm8
	vpcmpeqb	ymm2, ymm8, ymm2
	vpblendvb	ymm2, ymm6, ymm3, ymm2
	vpsrlvd	ymm0, ymm0, ymm4
	vpandn	ymm0, ymm12, ymm0
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 64]
	vpsrlvd	ymm2, ymm2, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 336]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 96]
	vpor	ymm3, ymm2, ymmword ptr [rip + 672f]
	vpcmpeqd	ymm2, ymm13, ymm2
	vpandn	ymm2, ymm2, ymm3
	vpor	ymm3, ymm0, ymmword ptr [rip + 682f]
	vpcmpeqd	ymm0, ymm13, ymm0
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
	vpblendd	ymm2, ymm3, ymm13, 192
	vpermq	ymm2, ymm2, 147
	vpmaxud	ymm2, ymm3, ymm2
	vperm2i128	ymm3, ymm2, ymm2, 10
	vpmaxud	ymm3, ymm2, ymm3
	vperm2i128	ymm2, ymm2, ymm0, 33
	vpmaxud	ymm0, ymm0, ymm2
	vpmaxud	ymm0, ymm0, ymm3
	vmovdqu	ymm4, ymmword ptr [rsp + 368]
	vpand	ymm2, ymm0, ymm4
	vpcmpeqd	ymm0, ymm13, ymm0
	vblendvps	ymm0, ymm2, ymm15, ymm0
	vpand	ymm2, ymm3, ymm4
	vpcmpeqd	ymm3, ymm13, ymm3
	vblendvps	ymm2, ymm2, ymm15, ymm3
	vmovdqu	ymm3, ymmword ptr [rsp + 624]
	vextracti128	xmm3, ymm3, 1
	vpsrlw	xmm3, xmm3, 2
	vpand	xmm3, xmm3, xmmword ptr [rip + 692f]
	vpminub	xmm3, xmm8, xmm3
	vpmovzxbd	ymm4, xmm3
	vpmaxud	ymm2, ymm2, ymm4
	vextracti128	xmm1, ymm1, 1
	vpextrd	eax, xmm1, 3
	vmovdqu	ymmword ptr [rdi + 448], ymm2
	vpshufd	xmm1, xmm3, 238
	vpmovzxbd	ymm1, xmm1
	vpmaxud	ymm1, ymm0, ymm1
	vmovdqu	ymmword ptr [rdi + 480], ymm1
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm15, ymm0, 170
	add	r14, rax
	jmp	372b
552:
	sub	rdx, rbx
	sub	rsi, qword ptr [rsp + 168]
	mov	qword ptr [rdi + 80], rdx
	mov	qword ptr [rdi + 88], rsi
	add	rsp, 728
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	vzeroupper
	ret
	.p2align	2, 0x0
562:
	.long	1
	.p2align	2, 0x0
572:
	.long	7
	.p2align	2, 0x0
582:
	.long	8
	.p2align	2, 0x0
592:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	2, 0x0
602:
	.long	134217727
	.p2align	5, 0x0
612:
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
	.p2align	4, 0x0
632:
	.byte	1
	.p2align	4, 0x0
642:
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
652:
	.byte	16
	.p2align	4, 0x0
662:
	.byte	32
	.p2align	5, 0x0
672:
	.long	1207959552
	.long	1342177280
	.long	1476395008
	.long	1610612736
	.long	1744830464
	.long	1879048192
	.long	2013265920
	.long	2147483648
	.p2align	5, 0x0
682:
	.long	134217728
	.long	268435456
	.long	402653184
	.long	536870912
	.long	671088640
	.long	805306368
	.long	939524096
	.long	1073741824
	.p2align	4, 0x0
692:
	.zero	16,63

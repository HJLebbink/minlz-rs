# minlz_exec_flat_delta of crates/minlz/mlir/exec64.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 696
	mov	r12, qword ptr [rdi]
	mov	rax, qword ptr [rdi + 8]
	mov	rcx, qword ptr [rdi + 64]
	mov	rdx, qword ptr [rdi + 80]
	add	rdx, r12
	mov	rsi, qword ptr [rdi + 88]
	mov	qword ptr [rsp + 216], rax
	add	rsi, rax
	test	rcx, rcx
	jle	572f
	mov	r11, qword ptr [rdi + 96]
	lea	rax, [rdi + 512]
	mov	r8d, 96
	mov	qword ptr [rsp + 96], r8
	mov	ebp, 7
	xor	r9d, r9d
	vpxor	xmm7, xmm7, xmm7
	vbroadcastss	ymm0, dword ptr [rip + 582f]
	vmovups	ymmword ptr [rsp + 560], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 592f]
	vmovups	ymmword ptr [rsp + 528], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 602f]
	vmovups	ymmword ptr [rsp + 496], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 612f]
	vmovups	ymmword ptr [rsp + 464], ymm0
	vpbroadcastd	ymm0, dword ptr [rip + 622f]
	vmovdqu	ymmword ptr [rsp + 432], ymm0
	mov	r8, rcx
	xor	ebx, ebx
	mov	qword ptr [rsp + 16], r12
	mov	qword ptr [rsp + 224], rcx
	jmp	12f
	.p2align	4
2:
	mov	r8, qword ptr [rsp + 320]
	add	r8, -64
	mov	r9, qword ptr [rsp + 328]
	inc	r9
	add	qword ptr [rsp + 96], 64
	add	rbp, -64
	mov	rax, qword ptr [rsp + 104]
	add	rax, -64
	mov	rcx, qword ptr [rsp + 224]
	mov	rbx, qword ptr [rsp + 312]
	cmp	rbx, rcx
	jge	572f
12:
	mov	qword ptr [rsp + 104], rax
	cmp	r8, 1
	mov	qword ptr [rsp + 320], r8
	adc	r8, 0
	cmp	r8, 64
	mov	eax, 64
	cmovae	r8, rax
	mov	qword ptr [rsp + 24], r8
	sub	rcx, rbx
	cmp	rcx, 64
	mov	r14d, 64
	mov	qword ptr [rsp + 400], rcx
	cmovb	r14, rcx
	mov	r12, qword ptr [rdi + 16]
	mov	rax, qword ptr [rdi + 24]
	mov	qword ptr [rsp + 144], rax
	mov	rax, qword ptr [rdi + 32]
	mov	qword ptr [rsp + 336], rax
	mov	rax, qword ptr [rdi + 40]
	mov	qword ptr [rsp], rax
	mov	r10, qword ptr [rdi + 64]
	mov	rax, qword ptr [rdi + 72]
	mov	qword ptr [rsp + 64], rax
	mov	rax, qword ptr [rdi + 96]
	mov	qword ptr [rsp + 176], rax
	mov	rax, qword ptr [rdi + 112]
	mov	qword ptr [rsp + 8], rax
	mov	rax, qword ptr [rdi + 128]
	mov	qword ptr [rsp + 48], rax
	mov	rax, qword ptr [rdi + 136]
	mov	qword ptr [rsp + 32], rax
	lea	r13, [r10 + 7]
	lea	rax, [rbx + 64]
	mov	qword ptr [rsp + 312], rax
	cmp	rax, r13
	mov	qword ptr [rsp + 56], rbp
	mov	qword ptr [rsp + 328], r9
	jbe	52f
	cmp	rbx, r13
	lea	rcx, [rdi + 512]
	mov	r8, rcx
	jge	62f
	mov	rax, r9
	shl	rax, 6
	mov	r9d, 7
	sub	r9, rax
	add	r9, r10
	cmp	r9, 16
	jb	22f
	add	rax, r12
	mov	r8, rdi
	sub	r8, rax
	add	r8, 511
	cmp	r8, 127
	jae	82f
22:
	mov	r15, rbx
32:
	mov	r8, qword ptr [rsp + 104]
	.p2align	4
42:
	movzx	eax, byte ptr [r12 + r15]
	mov	byte ptr [r8 + r15], al
	inc	r15
	cmp	r13, r15
	jne	42b
	mov	r8, rcx
	jmp	62f
	.p2align	4
52:
	add	r12, rbx
	mov	r8, r12
62:
	vmovdqu	ymm1, ymmword ptr [r8]
	vmovdqu	ymm15, ymmword ptr [r8 + 32]
	vmovd	xmm0, r14d
	vpbroadcastb	ymm3, xmm0
	vpmaxub	ymm0, ymm3, ymmword ptr [rip + 632f]
	vpcmpeqb	ymm0, ymm3, ymm0
	vpmaxub	ymm4, ymm3, ymmword ptr [rip + 642f]
	vpcmpeqb	ymm3, ymm3, ymm4
	vpsllw	ymm4, ymm15, 6
	vpcmpgtb	ymm4, ymm7, ymm4
	vpsllw	ymm5, ymm1, 6
	vpcmpgtb	ymm8, ymm7, ymm5
	vpbroadcastb	ymm2, byte ptr [rip + 652f]
	vpand	ymm5, ymm1, ymm2
	vpcmpeqb	ymm5, ymm5, ymm7
	movabs	r14, 72340172838076673
	#APP
	#NO_APP
	vpand	ymm4, ymm4, ymm2
	vpand	ymm4, ymm0, ymm4
	vpand	ymm8, ymm8, ymm2
	vpand	ymm8, ymm8, ymm3
	vmovq	r8, xmm8
	vpextrq	r9, xmm8, 1
	vextracti128	xmm8, ymm8, 1
	vmovq	rbx, xmm8
	vpextrq	rax, xmm8, 1
	vmovq	r10, xmm4
	vpextrq	r13, xmm4, 1
	vextracti128	xmm4, ymm4, 1
	vmovq	r15, xmm4
	mov	rbp, r8
	imul	rbp, r14
	mov	r12, rbp
	sub	r12, r8
	xor	r8, r14
	shl	r8, 7
	or	r8, r12
	vpextrq	qword ptr [rsp + 112], xmm4, 1
	mov	r12, qword ptr [rsp + 144]
	mov	rcx, qword ptr [rsp + 48]
	vmovq	xmm4, qword ptr [r12 + rcx]
	vmovq	xmm8, r8
	vpshufb	xmm4, xmm4, xmm8
	shr	rbp, 56
	add	rbp, rcx
	mov	r8, r9
	imul	r8, r14
	mov	rcx, r8
	sub	rcx, r9
	xor	r9, r14
	shl	r9, 7
	or	r9, rcx
	vmovq	xmm8, qword ptr [r12 + rbp]
	vmovq	xmm9, r9
	vpshufb	xmm8, xmm8, xmm9
	vpunpcklqdq	xmm4, xmm4, xmm8
	shr	r8, 56
	add	r8, rbp
	mov	r9, rbx
	imul	r9, r14
	mov	rcx, r9
	sub	rcx, rbx
	xor	rbx, r14
	shl	rbx, 7
	or	rbx, rcx
	vmovq	xmm8, qword ptr [r12 + r8]
	vmovq	xmm9, rbx
	vpshufb	xmm8, xmm8, xmm9
	shr	r9, 56
	add	r9, r8
	mov	r8, rax
	imul	r8, r14
	mov	rcx, r8
	sub	rcx, rax
	xor	rax, r14
	shl	rax, 7
	or	rax, rcx
	vmovq	xmm9, qword ptr [r12 + r9]
	vmovq	xmm10, rax
	vpshufb	xmm9, xmm9, xmm10
	vpunpcklqdq	xmm8, xmm8, xmm9
	shr	r8, 56
	add	r8, r9
	mov	rax, r10
	imul	rax, r14
	mov	rcx, rax
	sub	rcx, r10
	xor	r10, r14
	shl	r10, 7
	or	r10, rcx
	vmovq	xmm9, qword ptr [r12 + r8]
	vmovq	xmm10, r10
	vpshufb	xmm9, xmm9, xmm10
	shr	rax, 56
	add	rax, r8
	mov	r8, r13
	imul	r8, r14
	mov	rcx, r8
	sub	rcx, r13
	xor	r13, r14
	shl	r13, 7
	or	r13, rcx
	vmovq	xmm10, qword ptr [r12 + rax]
	vmovq	xmm11, r13
	vpshufb	xmm10, xmm10, xmm11
	vpunpcklqdq	xmm9, xmm9, xmm10
	shr	r8, 56
	add	r8, rax
	mov	rcx, r15
	imul	rcx, r14
	mov	rax, rcx
	sub	rax, r15
	xor	r15, r14
	shl	r15, 7
	or	r15, rax
	vmovq	xmm10, qword ptr [r12 + r8]
	vmovq	xmm11, r15
	vpshufb	xmm10, xmm10, xmm11
	shr	rcx, 56
	add	rcx, r8
	mov	r8, qword ptr [rsp + 112]
	mov	rax, r8
	imul	rax, r14
	mov	qword ptr [rsp + 40], rax
	sub	rax, r8
	xor	r14, r8
	shl	r14, 7
	or	r14, rax
	mov	qword ptr [rsp + 48], rcx
	vmovq	xmm11, qword ptr [r12 + rcx]
	vmovq	xmm12, r14
	vpshufb	xmm11, xmm11, xmm12
	vpunpcklqdq	xmm10, xmm10, xmm11
	vmovdqu	xmmword ptr [rdi + 224], xmm9
	vmovdqu	xmmword ptr [rdi + 192], xmm4
	vmovdqu	xmmword ptr [rdi + 208], xmm8
	vmovdqu	xmmword ptr [rdi + 240], xmm10
	movabs	r13, 72340172838076673
	#APP
	#NO_APP
	vpand	ymm4, ymm5, ymm2
	vpand	ymm3, ymm3, ymm4
	vmovq	rbx, xmm3
	vpextrq	r10, xmm3, 1
	vextracti128	xmm3, ymm3, 1
	vmovq	r9, xmm3
	mov	r12, r13
	imul	r12, rbx
	mov	r15, r12
	shr	r15, 56
	mov	r14, qword ptr [rsp + 32]
	add	r15, r14
	mov	rax, r13
	imul	rax, r10
	mov	rcx, rax
	shr	rcx, 56
	add	rcx, r15
	mov	r8, r13
	mov	qword ptr [rsp + 288], r9
	imul	r8, r9
	mov	r9, qword ptr [rsp + 336]
	vmovsd	xmm4, qword ptr [r9 + rcx]
	vmovaps	xmmword ptr [rsp + 656], xmm4
	mov	qword ptr [rsp + 296], r8
	shr	r8, 56
	add	r8, rcx
	vpextrq	rbp, xmm3, 1
	mov	rcx, r13
	mov	qword ptr [rsp + 280], rbp
	imul	rcx, rbp
	vmovsd	xmm3, qword ptr [r9 + r8]
	vmovaps	xmmword ptr [rsp + 672], xmm3
	mov	qword ptr [rsp + 304], rcx
	shr	rcx, 56
	add	rcx, r8
	vpand	ymm3, ymm15, ymm2
	vpcmpeqb	ymm3, ymm3, ymm7
	vpand	ymm3, ymm3, ymm2
	vpand	ymm0, ymm0, ymm3
	vmovq	r8, xmm0
	mov	rbp, r13
	mov	qword ptr [rsp + 264], r8
	imul	rbp, r8
	vmovsd	xmm2, qword ptr [r9 + rcx]
	vmovaps	xmmword ptr [rsp + 624], xmm2
	mov	qword ptr [rsp + 248], rbp
	mov	r8, rbp
	shr	r8, 56
	add	r8, rcx
	vpextrq	rcx, xmm0, 1
	mov	rbp, r13
	mov	qword ptr [rsp + 272], rcx
	imul	rbp, rcx
	vmovsd	xmm2, qword ptr [r9 + r8]
	vmovaps	xmmword ptr [rsp + 640], xmm2
	mov	qword ptr [rsp + 256], rbp
	mov	rcx, rbp
	shr	rcx, 56
	add	rcx, r8
	vextracti128	xmm4, ymm0, 1
	vmovq	r8, xmm4
	mov	rbp, r13
	mov	qword ptr [rsp + 240], r8
	imul	rbp, r8
	vmovsd	xmm0, qword ptr [r9 + rcx]
	vmovaps	xmmword ptr [rsp + 592], xmm0
	mov	qword ptr [rsp + 232], rbp
	mov	r8, rbp
	shr	r8, 56
	add	r8, rcx
	vmovq	xmm0, qword ptr [r9 + r14]
	vmovq	xmm3, qword ptr [r9 + r15]
	mov	qword ptr [rsp + 32], r8
	vmovsd	xmm2, qword ptr [r9 + r8]
	vmovaps	xmmword ptr [rsp + 608], xmm2
	vmovss	xmm5, dword ptr [rsp + 176]
	sub	r12, rbx
	xor	rbx, r13
	shl	rbx, 7
	or	rbx, r12
	vmovq	xmm9, rbx
	sub	rax, r10
	xor	r10, r13
	shl	r10, 7
	or	r10, rax
	vmovq	xmm11, r10
	mov	rcx, qword ptr [rsp + 64]
	mov	eax, ecx
	and	eax, 7
	vmovd	xmm14, eax
	mov	rbp, rcx
	shr	rbp, 3
	lea	rax, [rbp + 64]
	mov	r8, qword ptr [rsp + 8]
	cmp	rax, r8
	vmovdqu	ymmword ptr [rdi + 512], ymm1
	vmovdqu	ymmword ptr [rdi + 544], ymm15
	vbroadcastss	ymm1, xmm5
	vpshufb	xmm0, xmm0, xmm9
	vpshufb	xmm3, xmm3, xmm11
	vpmovzxbd	ymm0, xmm0
	vpmovzxbd	ymm3, xmm3
	vpsrld	ymm5, ymm3, 3
	vpsrld	ymm9, ymm0, 3
	vmovdqu	ymm2, ymmword ptr [rsp + 560]
	vpmaxud	ymm9, ymm9, ymm2
	vpcmpeqd	ymm6, ymm6, ymm6
	vpaddd	ymm9, ymm9, ymm6
	vpmaxud	ymm5, ymm5, ymm2
	vpaddd	ymm5, ymm5, ymm6
	vmovdqu	ymm2, ymmword ptr [rsp + 528]
	vpand	ymm11, ymm3, ymm2
	vpand	ymm12, ymm0, ymm2
	vmovdqu	ymm8, ymmword ptr [rsp + 496]
	vpminud	ymm0, ymm0, ymm8
	vpminud	ymm3, ymm3, ymm8
	vpand	ymm3, ymm8, ymm3
	vpor	ymm3, ymm11, ymm3
	vpand	ymm0, ymm8, ymm0
	vpor	ymm11, ymm12, ymm0
	vpsllvd	ymm0, ymm3, ymm5
	vmovdqu	ymmword ptr [rsp + 176], ymm0
	vpsllvd	ymm0, ymm11, ymm9
	vmovdqu	ymmword ptr [rsp + 144], ymm0
	vperm2i128	ymm11, ymm9, ymm5, 33
	vpalignr	ymm11, ymm5, ymm11, 12
	vperm2i128	ymm12, ymm9, ymm9, 10
	vpalignr	ymm12, ymm9, ymm12, 12
	vpaddd	ymm12, ymm12, ymm9
	vpaddd	ymm11, ymm11, ymm5
	vpblendd	ymm13, ymm11, ymm12, 192
	vpermq	ymm13, ymm13, 147
	vpaddd	ymm11, ymm13, ymm11
	vpblendd	ymm13, ymm12, ymm7, 192
	vpermq	ymm13, ymm13, 147
	vpaddd	ymm12, ymm13, ymm12
	vperm2i128	ymm13, ymm12, ymm11, 33
	vpaddd	ymm11, ymm13, ymm11
	vperm2i128	ymm13, ymm12, ymm12, 10
	vpaddd	ymm13, ymm13, ymm12
	vpsllvd	ymm0, ymm6, ymm5
	vmovdqu	ymmword ptr [rsp + 112], ymm0
	vpaddd	ymm15, ymm13, ymm11
	vpsubd	ymm11, ymm13, ymm9
	vpsllvd	ymm0, ymm6, ymm9
	vmovdqu	ymmword ptr [rsp + 368], ymm0
	vpsubd	ymm5, ymm15, ymm5
	vpbroadcastd	ymm9, xmm14
	vpaddd	ymm5, ymm9, ymm5
	vpaddd	ymm9, ymm11, ymm9
	vpsrld	ymm14, ymm5, 3
	vpextrq	qword ptr [rsp + 336], xmm4, 1
	vpsrld	ymm4, ymm9, 3
	vpand	ymm5, ymm5, ymm2
	vpand	ymm11, ymm9, ymm2
	vbroadcasti128	ymm0, xmmword ptr [rip + 662f]
	vpshufb	ymm9, ymm14, ymm0
	vpshufb	ymm14, ymm4, ymm0
	vmovdqu	ymm0, ymmword ptr [rsp + 464]
	vpaddb	ymm4, ymm9, ymm0
	vpaddb	ymm9, ymm14, ymm0
	jbe	72f
	mov	rax, r8
	sub	rax, rbp
	lea	r12, [rdi + 576]
	mov	r8, r12
	jbe	152f
	cmp	rax, 16
	mov	r10, rbp
	jb	132f
	mov	rcx, qword ptr [rsp]
	lea	rbx, [rbp + rcx]
	mov	rcx, rdi
	sub	rcx, rbx
	add	rcx, 575
	cmp	rcx, 127
	mov	rcx, qword ptr [rsp + 64]
	mov	r10, rbp
	jb	132f
	cmp	rax, 128
	jae	92f
	xor	r15d, r15d
	jmp	112f
	.p2align	4
72:
	add	rbp, qword ptr [rsp]
	mov	r8, rbp
	lea	r12, [rdi + 576]
	jmp	152f
82:
	cmp	r9, 128
	jae	182f
	xor	eax, eax
	jmp	202f
92:
	mov	r15, rax
	and	r15, -128
	lea	r10, [rbp + r15]
	mov	r8, qword ptr [rsp]
	lea	r8, [r8 + rbp + 96]
	xor	r12d, r12d
	.p2align	4
102:
	vmovdqu	ymm14, ymmword ptr [r8 + r12 - 96]
	vmovdqu	ymm8, ymmword ptr [r8 + r12 - 64]
	vmovdqu	ymm10, ymmword ptr [r8 + r12 - 32]
	vmovdqu	ymm6, ymmword ptr [r8 + r12]
	vmovdqu	ymmword ptr [rdi + r12 + 576], ymm14
	vmovdqu	ymmword ptr [rdi + r12 + 608], ymm8
	vmovdqu	ymmword ptr [rdi + r12 + 640], ymm10
	vmovdqu	ymmword ptr [rdi + r12 + 672], ymm6
	sub	r12, -128
	cmp	r15, r12
	jne	102b
	cmp	rax, r15
	lea	r12, [rdi + 576]
	mov	r8, r12
	je	152f
	test	al, 112
	je	132f
112:
	mov	r8, rax
	and	r8, -16
	lea	r10, [rbp + r8]
	.p2align	4
122:
	vmovdqu	xmm6, xmmword ptr [rbx + r15]
	vmovdqu	xmmword ptr [r12 + r15], xmm6
	add	r15, 16
	cmp	r8, r15
	jne	122b
	cmp	rax, r8
	mov	r8, r12
	je	152f
	.p2align	4
132:
	mov	rax, r12
	sub	rax, rbp
	mov	r8, qword ptr [rsp]
	mov	rbx, qword ptr [rsp + 8]
	.p2align	4
142:
	movzx	ecx, byte ptr [r8 + r10]
	mov	byte ptr [rax + r10], cl
	inc	r10
	cmp	rbx, r10
	jne	142b
	mov	r8, r12
	mov	rcx, qword ptr [rsp + 64]
152:
	vmovdqu	ymm6, ymmword ptr [r8]
	vmovdqu	ymm8, ymmword ptr [r8 + 32]
	vpermq	ymm10, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm14, ymm10, ymm4
	vpshufb	ymm7, ymm6, ymm4
	vpbroadcastb	ymm13, byte ptr [rip + 672f]
	vpand	ymm2, ymm13, ymm4
	vpxor	xmm12, xmm12, xmm12
	vpcmpeqb	ymm2, ymm12, ymm2
	vpblendvb	ymm7, ymm7, ymm14, ymm2
	vpermq	ymm14, ymm8, 68
	vpermq	ymm8, ymm8, 238
	vpshufb	ymm0, ymm14, ymm4
	vpshufb	ymm3, ymm8, ymm4
	vpblendvb	ymm0, ymm3, ymm0, ymm2
	vpshufb	ymm2, ymm10, ymm9
	vpshufb	ymm3, ymm6, ymm9
	vpand	ymm6, ymm9, ymm13
	vpcmpeqb	ymm6, ymm12, ymm6
	vpblendvb	ymm2, ymm3, ymm2, ymm6
	vpshufb	ymm3, ymm14, ymm9
	vpshufb	ymm8, ymm8, ymm9
	vpblendvb	ymm3, ymm8, ymm3, ymm6
	vpbroadcastb	ymm8, byte ptr [rip + 682f]
	vpand	ymm6, ymm9, ymm8
	vpcmpeqb	ymm6, ymm8, ymm6
	vpblendvb	ymm2, ymm2, ymm3, ymm6
	vpand	ymm3, ymm8, ymm4
	vpcmpeqb	ymm3, ymm8, ymm3
	vpblendvb	ymm0, ymm7, ymm0, ymm3
	vpxor	xmm7, xmm7, xmm7
	vpsrlvd	ymm2, ymm2, ymm11
	vmovdqu	ymm3, ymmword ptr [rsp + 368]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 144]
	vpsrlvd	ymm0, ymm0, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 112]
	vpandn	ymm0, ymm3, ymm0
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 176]
	vpor	ymm3, ymm0, ymmword ptr [rip + 692f]
	vpcmpeqd	ymm0, ymm0, ymm7
	vpandn	ymm0, ymm0, ymm3
	vpor	ymm3, ymm2, ymmword ptr [rip + 702f]
	vpcmpeqd	ymm2, ymm2, ymm7
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
	vpblendd	ymm2, ymm3, ymm7, 192
	vpermq	ymm2, ymm2, 147
	vpmaxud	ymm2, ymm3, ymm2
	vperm2i128	ymm3, ymm2, ymm2, 10
	vpmaxud	ymm3, ymm2, ymm3
	vperm2i128	ymm2, ymm2, ymm0, 33
	vpmaxud	ymm0, ymm0, ymm2
	vpmaxud	ymm0, ymm0, ymm3
	vmovdqu	ymm4, ymmword ptr [rsp + 432]
	vpand	ymm2, ymm0, ymm4
	vpcmpeqd	ymm0, ymm0, ymm7
	vblendvps	ymm0, ymm2, ymm1, ymm0
	vpand	ymm2, ymm3, ymm4
	vpcmpeqd	ymm3, ymm3, ymm7
	vblendvps	ymm1, ymm2, ymm1, ymm3
	vextracti128	xmm2, ymm15, 1
	vpextrd	eax, xmm2, 3
	vmovups	ymmword ptr [rdi + 256], ymm1
	mov	r8, r13
	imul	r8, qword ptr [rsp + 336]
	vmovups	ymmword ptr [rdi + 288], ymm0
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm1, ymm0, 170
	add	rcx, rax
	cmp	qword ptr [rsp + 400], 17
	jb	162f
	mov	qword ptr [rsp + 176], r8
	mov	rax, qword ptr [rsp + 296]
	mov	r8, qword ptr [rsp + 288]
	sub	rax, r8
	xor	r8, r13
	shl	r8, 7
	or	r8, rax
	vmovq	xmm0, r8
	vmovdqa	xmm2, xmmword ptr [rsp + 656]
	vpshufb	xmm0, xmm2, xmm0
	mov	rax, qword ptr [rsp + 304]
	mov	r8, qword ptr [rsp + 280]
	sub	rax, r8
	xor	r8, r13
	shl	r8, 7
	or	r8, rax
	vmovq	xmm2, r8
	vmovdqa	xmm3, xmmword ptr [rsp + 672]
	vpshufb	xmm2, xmm3, xmm2
	vpunpcklqdq	xmm0, xmm0, xmm2
	vpshufd	xmm2, xmm0, 238
	vpmovzxbd	ymm2, xmm2
	vpmovzxbd	ymm0, xmm0
	vpsrld	ymm3, ymm0, 3
	vpsrld	ymm4, ymm2, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 560]
	vpmaxud	ymm4, ymm4, ymm5
	vpcmpeqd	ymm7, ymm7, ymm7
	vpaddd	ymm4, ymm4, ymm7
	vpmaxud	ymm3, ymm3, ymm5
	vpaddd	ymm5, ymm3, ymm7
	vmovdqu	ymm9, ymmword ptr [rsp + 528]
	vpand	ymm3, ymm9, ymm0
	vpand	ymm6, ymm9, ymm2
	vmovdqu	ymm8, ymmword ptr [rsp + 496]
	vpminud	ymm2, ymm2, ymm8
	vpminud	ymm0, ymm0, ymm8
	vpand	ymm0, ymm8, ymm0
	vpor	ymm0, ymm0, ymm3
	vpand	ymm2, ymm8, ymm2
	vpor	ymm2, ymm2, ymm6
	vpsllvd	ymm0, ymm0, ymm5
	vmovdqu	ymmword ptr [rsp + 144], ymm0
	vpsllvd	ymm0, ymm2, ymm4
	vmovdqu	ymmword ptr [rsp + 64], ymm0
	vpsllvd	ymm0, ymm7, ymm5
	vmovdqu	ymmword ptr [rsp + 368], ymm0
	vpsllvd	ymm0, ymm7, ymm4
	vmovdqu	ymmword ptr [rsp + 112], ymm0
	vperm2i128	ymm2, ymm5, ymm4, 33
	vpalignr	ymm2, ymm4, ymm2, 12
	vperm2i128	ymm6, ymm5, ymm5, 10
	vpalignr	ymm6, ymm5, ymm6, 12
	vpaddd	ymm6, ymm6, ymm5
	vpaddd	ymm2, ymm2, ymm4
	vpxor	xmm7, xmm7, xmm7
	vpblendd	ymm7, ymm6, ymm7, 192
	vpermq	ymm7, ymm7, 147
	vpaddd	ymm7, ymm7, ymm6
	vpblendd	ymm6, ymm2, ymm6, 192
	vpermq	ymm6, ymm6, 147
	vpaddd	ymm2, ymm6, ymm2
	vperm2i128	ymm6, ymm7, ymm7, 10
	vpaddd	ymm6, ymm6, ymm7
	vperm2i128	ymm7, ymm7, ymm2, 33
	vpaddd	ymm2, ymm7, ymm2
	vpaddd	ymm8, ymm6, ymm2
	vpsubd	ymm2, ymm8, ymm4
	vpsubd	ymm4, ymm6, ymm5
	mov	eax, ecx
	and	eax, 7
	vmovd	xmm5, eax
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm2, ymm5, ymm2
	vpaddd	ymm4, ymm5, ymm4
	vpsrld	ymm6, ymm2, 3
	vpsrld	ymm7, ymm4, 3
	vpand	ymm12, ymm9, ymm2
	vpand	ymm5, ymm9, ymm4
	vbroadcasti128	ymm0, xmmword ptr [rip + 662f]
	vpshufb	ymm2, ymm6, ymm0
	vpshufb	ymm4, ymm7, ymm0
	vmovdqu	ymm0, ymmword ptr [rsp + 464]
	vpaddb	ymm11, ymm2, ymm0
	vpaddb	ymm4, ymm4, ymm0
	mov	r9, rcx
	shr	r9, 3
	lea	rax, [r9 + 64]
	mov	r8, qword ptr [rsp + 8]
	cmp	rax, r8
	mov	rbp, qword ptr [rsp + 56]
	mov	r15, qword ptr [rsp + 24]
	jbe	172f
	mov	rax, r8
	sub	rax, r9
	mov	r8, r12
	jbe	282f
	cmp	rax, 16
	mov	r10, r9
	jb	262f
	mov	r8, qword ptr [rsp]
	lea	rbx, [r9 + r8]
	mov	r8, rcx
	mov	rcx, rdi
	sub	rcx, rbx
	add	rcx, 575
	cmp	rcx, 127
	mov	rcx, r8
	mov	r10, r9
	jb	262f
	cmp	rax, 128
	jae	222f
	xor	r14d, r14d
	jmp	242f
	.p2align	4
162:
	mov	r12, qword ptr [rsp + 16]
	mov	rbp, qword ptr [rsp + 56]
	mov	r13d, 32
	mov	r15, qword ptr [rsp + 24]
	jmp	472f
	.p2align	4
172:
	add	r9, qword ptr [rsp]
	mov	r8, r9
	jmp	282f
182:
	mov	qword ptr [rsp + 40], r9
	mov	rax, r9
	and	rax, -128
	lea	r15, [rbx + rax]
	mov	r8, qword ptr [rsp + 96]
	add	r8, r12
	lea	r9, [r10 + rbp]
	and	r9, -128
	xor	ebp, ebp
	.p2align	4
192:
	vmovdqu	ymm0, ymmword ptr [r8 + rbp - 96]
	vmovups	ymm1, ymmword ptr [r8 + rbp - 64]
	vmovups	ymm3, ymmword ptr [r8 + rbp - 32]
	vmovdqu	ymm4, ymmword ptr [r8 + rbp]
	vmovdqu	ymmword ptr [rdi + rbp + 512], ymm0
	vmovups	ymmword ptr [rdi + rbp + 544], ymm1
	vmovups	ymmword ptr [rdi + rbp + 576], ymm3
	vmovdqu	ymmword ptr [rdi + rbp + 608], ymm4
	sub	rbp, -128
	cmp	r9, rbp
	jne	192b
	mov	r9, qword ptr [rsp + 40]
	cmp	r9, rax
	mov	r8, rcx
	mov	rbp, qword ptr [rsp + 56]
	je	62b
	test	r9b, 112
	je	32b
202:
	mov	r15, r9
	mov	r8, r9
	and	r8, -16
	lea	r9, [r12 + rbx]
	add	rbx, r8
	add	r10, rbp
	and	r10, -16
	.p2align	4
212:
	vmovdqu	xmm0, xmmword ptr [r9 + rax]
	vmovdqu	xmmword ptr [rcx + rax], xmm0
	add	rax, 16
	cmp	r10, rax
	jne	212b
	cmp	r15, r8
	mov	r15, rbx
	mov	r8, rcx
	je	62b
	jmp	32b
222:
	mov	r14, rax
	and	r14, -128
	lea	r10, [r9 + r14]
	mov	r8, qword ptr [rsp]
	lea	r8, [r8 + r9 + 96]
	xor	r15d, r15d
	.p2align	4
232:
	vmovdqu	ymm2, ymmword ptr [r8 + r15 - 96]
	vmovdqu	ymm6, ymmword ptr [r8 + r15 - 64]
	vmovdqu	ymm7, ymmword ptr [r8 + r15 - 32]
	vmovdqu	ymm9, ymmword ptr [r8 + r15]
	vmovdqu	ymmword ptr [rdi + r15 + 576], ymm2
	vmovdqu	ymmword ptr [rdi + r15 + 608], ymm6
	vmovdqu	ymmword ptr [rdi + r15 + 640], ymm7
	vmovdqu	ymmword ptr [rdi + r15 + 672], ymm9
	sub	r15, -128
	cmp	r14, r15
	jne	232b
	cmp	rax, r14
	mov	r8, r12
	mov	r15, qword ptr [rsp + 24]
	je	282f
	test	al, 112
	je	262f
242:
	mov	r8, rax
	and	r8, -16
	lea	r10, [r9 + r8]
	.p2align	4
252:
	vmovdqu	xmm2, xmmword ptr [rbx + r14]
	vmovdqu	xmmword ptr [r12 + r14], xmm2
	add	r14, 16
	cmp	r8, r14
	jne	252b
	cmp	rax, r8
	mov	r8, r12
	je	282f
262:
	mov	rbx, rcx
	mov	rax, r12
	sub	rax, r9
	mov	r8, qword ptr [rsp]
	mov	r9, qword ptr [rsp + 8]
	.p2align	4
272:
	movzx	ecx, byte ptr [r8 + r10]
	mov	byte ptr [rax + r10], cl
	inc	r10
	cmp	r9, r10
	jne	272b
	mov	r8, r12
	mov	rcx, rbx
282:
	vmovdqu	ymm2, ymmword ptr [r8]
	vmovdqu	ymm6, ymmword ptr [r8 + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm9, ymm7, ymm11
	vpshufb	ymm13, ymm2, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 672f]
	vpand	ymm14, ymm11, ymm3
	vpxor	xmm0, xmm0, xmm0
	vpcmpeqb	ymm14, ymm14, ymm0
	vpblendvb	ymm9, ymm13, ymm9, ymm14
	vpermq	ymm13, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm10, ymm13, ymm11
	vpshufb	ymm15, ymm6, ymm11
	vpblendvb	ymm10, ymm15, ymm10, ymm14
	vpshufb	ymm7, ymm7, ymm4
	vpshufb	ymm2, ymm2, ymm4
	vpand	ymm14, ymm4, ymm3
	vpcmpeqb	ymm14, ymm14, ymm0
	vpblendvb	ymm2, ymm2, ymm7, ymm14
	vpshufb	ymm7, ymm13, ymm4
	vpshufb	ymm6, ymm6, ymm4
	vpblendvb	ymm6, ymm6, ymm7, ymm14
	vpxor	xmm7, xmm7, xmm7
	vpbroadcastb	ymm0, byte ptr [rip + 682f]
	vpand	ymm4, ymm4, ymm0
	vpcmpeqb	ymm4, ymm4, ymm0
	vpblendvb	ymm2, ymm2, ymm6, ymm4
	vpand	ymm4, ymm11, ymm0
	vpcmpeqb	ymm4, ymm4, ymm0
	vpblendvb	ymm4, ymm9, ymm10, ymm4
	vpsrlvd	ymm2, ymm2, ymm5
	vmovdqu	ymm0, ymmword ptr [rsp + 368]
	vpandn	ymm2, ymm0, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 144]
	vpsrlvd	ymm3, ymm4, ymm12
	vmovdqu	ymm0, ymmword ptr [rsp + 112]
	vpandn	ymm0, ymm0, ymm3
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 64]
	vpor	ymm3, ymm0, ymmword ptr [rip + 692f]
	vpcmpeqd	ymm0, ymm0, ymm7
	vpandn	ymm0, ymm0, ymm3
	vpor	ymm3, ymm2, ymmword ptr [rip + 702f]
	vpcmpeqd	ymm2, ymm2, ymm7
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
	vpblendd	ymm2, ymm3, ymm7, 192
	vpermq	ymm2, ymm2, 147
	vpmaxud	ymm2, ymm3, ymm2
	vperm2i128	ymm3, ymm2, ymm2, 10
	vpmaxud	ymm3, ymm2, ymm3
	vperm2i128	ymm2, ymm2, ymm0, 33
	vpmaxud	ymm0, ymm0, ymm2
	vpmaxud	ymm0, ymm0, ymm3
	vmovdqu	ymm4, ymmword ptr [rsp + 432]
	vpand	ymm2, ymm0, ymm4
	vpcmpeqd	ymm0, ymm0, ymm7
	vblendvps	ymm0, ymm2, ymm1, ymm0
	vpand	ymm2, ymm3, ymm4
	vpcmpeqd	ymm3, ymm3, ymm7
	vblendvps	ymm1, ymm2, ymm1, ymm3
	vextracti128	xmm2, ymm8, 1
	vpextrd	eax, xmm2, 3
	vmovups	ymmword ptr [rdi + 320], ymm1
	vmovups	ymmword ptr [rdi + 352], ymm0
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm1, ymm0, 170
	add	rcx, rax
	cmp	qword ptr [rsp + 400], 33
	jb	372f
	mov	rax, qword ptr [rsp + 264]
	mov	r8, qword ptr [rsp + 248]
	sub	r8, rax
	xor	rax, r13
	shl	rax, 7
	or	rax, r8
	vmovq	xmm0, rax
	vmovdqa	xmm2, xmmword ptr [rsp + 624]
	vpshufb	xmm0, xmm2, xmm0
	mov	rax, qword ptr [rsp + 272]
	mov	r8, qword ptr [rsp + 256]
	sub	r8, rax
	xor	rax, r13
	shl	rax, 7
	or	rax, r8
	vmovq	xmm2, rax
	vmovdqa	xmm3, xmmword ptr [rsp + 640]
	vpshufb	xmm2, xmm3, xmm2
	vpunpcklqdq	xmm0, xmm0, xmm2
	vpshufd	xmm2, xmm0, 238
	vpmovzxbd	ymm2, xmm2
	vpmovzxbd	ymm0, xmm0
	vpsrld	ymm3, ymm0, 3
	vpsrld	ymm4, ymm2, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 560]
	vpmaxud	ymm4, ymm4, ymm5
	vpcmpeqd	ymm7, ymm7, ymm7
	vpaddd	ymm4, ymm4, ymm7
	vpmaxud	ymm3, ymm3, ymm5
	vpaddd	ymm5, ymm3, ymm7
	vmovdqu	ymm9, ymmword ptr [rsp + 528]
	vpand	ymm3, ymm9, ymm0
	vpand	ymm6, ymm9, ymm2
	vmovdqu	ymm8, ymmword ptr [rsp + 496]
	vpminud	ymm2, ymm2, ymm8
	vpminud	ymm0, ymm0, ymm8
	vpand	ymm0, ymm8, ymm0
	vpor	ymm0, ymm0, ymm3
	vpand	ymm2, ymm8, ymm2
	vpor	ymm2, ymm2, ymm6
	vpsllvd	ymm0, ymm0, ymm5
	vmovdqu	ymmword ptr [rsp + 144], ymm0
	vpsllvd	ymm0, ymm2, ymm4
	vmovdqu	ymmword ptr [rsp + 64], ymm0
	vpsllvd	ymm0, ymm7, ymm5
	vmovdqu	ymmword ptr [rsp + 368], ymm0
	vpsllvd	ymm0, ymm7, ymm4
	vmovdqu	ymmword ptr [rsp + 112], ymm0
	vperm2i128	ymm2, ymm5, ymm4, 33
	vpalignr	ymm2, ymm4, ymm2, 12
	vperm2i128	ymm6, ymm5, ymm5, 10
	vpalignr	ymm6, ymm5, ymm6, 12
	vpaddd	ymm6, ymm6, ymm5
	vpaddd	ymm2, ymm2, ymm4
	vpxor	xmm7, xmm7, xmm7
	vpblendd	ymm7, ymm6, ymm7, 192
	vpermq	ymm7, ymm7, 147
	vpaddd	ymm7, ymm7, ymm6
	vpblendd	ymm6, ymm2, ymm6, 192
	vpermq	ymm6, ymm6, 147
	vpaddd	ymm2, ymm6, ymm2
	vperm2i128	ymm6, ymm7, ymm7, 10
	vpaddd	ymm6, ymm6, ymm7
	vperm2i128	ymm7, ymm7, ymm2, 33
	vpaddd	ymm2, ymm7, ymm2
	vpaddd	ymm8, ymm6, ymm2
	vpsubd	ymm2, ymm8, ymm4
	vpsubd	ymm4, ymm6, ymm5
	mov	eax, ecx
	and	eax, 7
	vmovd	xmm5, eax
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm2, ymm5, ymm2
	vpaddd	ymm4, ymm5, ymm4
	vpsrld	ymm6, ymm2, 3
	vpsrld	ymm7, ymm4, 3
	vpand	ymm13, ymm9, ymm2
	vpand	ymm5, ymm9, ymm4
	vbroadcasti128	ymm0, xmmword ptr [rip + 662f]
	vpshufb	ymm2, ymm6, ymm0
	vpshufb	ymm4, ymm7, ymm0
	vmovdqu	ymm0, ymmword ptr [rsp + 464]
	vpaddb	ymm11, ymm2, ymm0
	vpaddb	ymm4, ymm4, ymm0
	mov	r9, rcx
	shr	r9, 3
	lea	rax, [r9 + 64]
	mov	r8, qword ptr [rsp + 8]
	cmp	rax, r8
	jbe	292f
	mov	rax, r8
	sub	rax, r9
	mov	r8, r12
	jbe	362f
	cmp	rax, 16
	mov	r10, r9
	jb	342f
	mov	r8, qword ptr [rsp]
	lea	rbx, [r9 + r8]
	mov	r8, rcx
	mov	rcx, rdi
	sub	rcx, rbx
	add	rcx, 575
	cmp	rcx, 127
	mov	rcx, r8
	mov	r10, r9
	jb	342f
	cmp	rax, 128
	jae	302f
	xor	r14d, r14d
	jmp	322f
292:
	add	r9, qword ptr [rsp]
	mov	r8, r9
	jmp	362f
302:
	mov	r14, rax
	and	r14, -128
	lea	r10, [r9 + r14]
	mov	r8, qword ptr [rsp]
	lea	r8, [r8 + r9 + 96]
	xor	r15d, r15d
	.p2align	4
312:
	vmovdqu	ymm2, ymmword ptr [r8 + r15 - 96]
	vmovdqu	ymm6, ymmword ptr [r8 + r15 - 64]
	vmovdqu	ymm7, ymmword ptr [r8 + r15 - 32]
	vmovdqu	ymm9, ymmword ptr [r8 + r15]
	vmovdqu	ymmword ptr [rdi + r15 + 576], ymm2
	vmovdqu	ymmword ptr [rdi + r15 + 608], ymm6
	vmovdqu	ymmword ptr [rdi + r15 + 640], ymm7
	vmovdqu	ymmword ptr [rdi + r15 + 672], ymm9
	sub	r15, -128
	cmp	r14, r15
	jne	312b
	cmp	rax, r14
	mov	r8, r12
	mov	r15, qword ptr [rsp + 24]
	je	362f
	test	al, 112
	je	342f
322:
	mov	r8, rax
	and	r8, -16
	lea	r10, [r9 + r8]
	.p2align	4
332:
	vmovdqu	xmm2, xmmword ptr [rbx + r14]
	vmovdqu	xmmword ptr [r12 + r14], xmm2
	add	r14, 16
	cmp	r8, r14
	jne	332b
	cmp	rax, r8
	mov	r8, r12
	je	362f
342:
	mov	rbx, rcx
	mov	rax, r12
	sub	rax, r9
	mov	r8, qword ptr [rsp]
	mov	r9, qword ptr [rsp + 8]
	.p2align	4
352:
	movzx	ecx, byte ptr [r8 + r10]
	mov	byte ptr [rax + r10], cl
	inc	r10
	cmp	r9, r10
	jne	352b
	mov	r8, r12
	mov	rcx, rbx
362:
	vmovdqu	ymm2, ymmword ptr [r8]
	vmovdqu	ymm6, ymmword ptr [r8 + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm9, ymm7, ymm11
	vpshufb	ymm14, ymm2, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 672f]
	vpand	ymm15, ymm11, ymm3
	vpxor	xmm0, xmm0, xmm0
	vpcmpeqb	ymm15, ymm15, ymm0
	vpblendvb	ymm9, ymm14, ymm9, ymm15
	vpermq	ymm14, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm10, ymm14, ymm11
	vpshufb	ymm12, ymm6, ymm11
	vpblendvb	ymm10, ymm12, ymm10, ymm15
	vpshufb	ymm7, ymm7, ymm4
	vpshufb	ymm2, ymm2, ymm4
	vpand	ymm12, ymm4, ymm3
	vpcmpeqb	ymm12, ymm12, ymm0
	vpblendvb	ymm2, ymm2, ymm7, ymm12
	vpshufb	ymm7, ymm14, ymm4
	vpshufb	ymm6, ymm6, ymm4
	vpblendvb	ymm6, ymm6, ymm7, ymm12
	vpxor	xmm7, xmm7, xmm7
	vpbroadcastb	ymm0, byte ptr [rip + 682f]
	vpand	ymm4, ymm4, ymm0
	vpcmpeqb	ymm4, ymm4, ymm0
	vpblendvb	ymm2, ymm2, ymm6, ymm4
	vpand	ymm4, ymm11, ymm0
	vpcmpeqb	ymm4, ymm4, ymm0
	vpblendvb	ymm4, ymm9, ymm10, ymm4
	vpsrlvd	ymm2, ymm2, ymm5
	vmovdqu	ymm0, ymmword ptr [rsp + 368]
	vpandn	ymm2, ymm0, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 144]
	vpsrlvd	ymm3, ymm4, ymm13
	vmovdqu	ymm0, ymmword ptr [rsp + 112]
	vpandn	ymm0, ymm0, ymm3
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 64]
	vpor	ymm3, ymm0, ymmword ptr [rip + 692f]
	vpcmpeqd	ymm0, ymm0, ymm7
	vpandn	ymm0, ymm0, ymm3
	vpor	ymm3, ymm2, ymmword ptr [rip + 702f]
	vpcmpeqd	ymm2, ymm2, ymm7
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
	vpblendd	ymm2, ymm3, ymm7, 192
	vpermq	ymm2, ymm2, 147
	vpmaxud	ymm2, ymm3, ymm2
	vperm2i128	ymm3, ymm2, ymm2, 10
	vpmaxud	ymm3, ymm2, ymm3
	vperm2i128	ymm2, ymm2, ymm0, 33
	vpmaxud	ymm0, ymm0, ymm2
	vpmaxud	ymm0, ymm0, ymm3
	vmovdqu	ymm4, ymmword ptr [rsp + 432]
	vpand	ymm2, ymm0, ymm4
	vpcmpeqd	ymm0, ymm0, ymm7
	vblendvps	ymm0, ymm2, ymm1, ymm0
	vpand	ymm2, ymm3, ymm4
	vpcmpeqd	ymm3, ymm3, ymm7
	vblendvps	ymm1, ymm2, ymm1, ymm3
	vextracti128	xmm2, ymm8, 1
	vpextrd	eax, xmm2, 3
	vmovups	ymmword ptr [rdi + 384], ymm1
	vmovups	ymmword ptr [rdi + 416], ymm0
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm1, ymm0, 170
	add	rcx, rax
	cmp	qword ptr [rsp + 400], 49
	jb	372f
	mov	rax, qword ptr [rsp + 240]
	mov	r8, qword ptr [rsp + 232]
	sub	r8, rax
	xor	rax, r13
	shl	rax, 7
	or	rax, r8
	vmovq	xmm0, rax
	vmovdqa	xmm2, xmmword ptr [rsp + 592]
	vpshufb	xmm0, xmm2, xmm0
	mov	rax, qword ptr [rsp + 176]
	mov	r8, qword ptr [rsp + 336]
	sub	rax, r8
	xor	r13, r8
	shl	r13, 7
	or	r13, rax
	vmovq	xmm2, r13
	vmovdqa	xmm3, xmmword ptr [rsp + 608]
	vpshufb	xmm2, xmm3, xmm2
	vpmovzxbd	ymm0, xmm0
	vpmovzxbd	ymm2, xmm2
	vpsrld	ymm3, ymm2, 3
	vpsrld	ymm4, ymm0, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 560]
	vpmaxud	ymm4, ymm4, ymm5
	vpcmpeqd	ymm8, ymm8, ymm8
	vpaddd	ymm4, ymm8, ymm4
	vpmaxud	ymm3, ymm3, ymm5
	vpaddd	ymm5, ymm8, ymm3
	vmovdqu	ymm9, ymmword ptr [rsp + 528]
	vpand	ymm3, ymm9, ymm2
	vpand	ymm6, ymm9, ymm0
	vmovdqu	ymm10, ymmword ptr [rsp + 496]
	vpminud	ymm0, ymm0, ymm10
	vpminud	ymm2, ymm2, ymm10
	vpand	ymm2, ymm10, ymm2
	vpor	ymm2, ymm2, ymm3
	vpand	ymm0, ymm10, ymm0
	vpor	ymm0, ymm0, ymm6
	vpsllvd	ymm2, ymm2, ymm5
	vmovdqu	ymmword ptr [rsp + 400], ymm2
	vpsllvd	ymm0, ymm0, ymm4
	vmovdqu	ymmword ptr [rsp + 144], ymm0
	vpsllvd	ymm0, ymm8, ymm5
	vmovdqu	ymmword ptr [rsp + 336], ymm0
	vpsllvd	ymm0, ymm8, ymm4
	vmovdqu	ymmword ptr [rsp + 112], ymm0
	vperm2i128	ymm0, ymm4, ymm5, 33
	vpalignr	ymm0, ymm5, ymm0, 12
	vperm2i128	ymm2, ymm4, ymm4, 10
	vpalignr	ymm2, ymm4, ymm2, 12
	vpaddd	ymm2, ymm2, ymm4
	vpaddd	ymm0, ymm0, ymm5
	vpblendd	ymm6, ymm0, ymm2, 192
	vpermq	ymm6, ymm6, 147
	vpaddd	ymm0, ymm6, ymm0
	vpblendd	ymm6, ymm2, ymm7, 192
	vpermq	ymm6, ymm6, 147
	vpaddd	ymm2, ymm6, ymm2
	vperm2i128	ymm6, ymm2, ymm0, 33
	vpaddd	ymm0, ymm6, ymm0
	vperm2i128	ymm6, ymm2, ymm2, 10
	vpaddd	ymm2, ymm6, ymm2
	vpaddd	ymm0, ymm2, ymm0
	vpsubd	ymm5, ymm0, ymm5
	vpsubd	ymm2, ymm2, ymm4
	mov	eax, ecx
	and	eax, 7
	vmovd	xmm4, eax
	vpbroadcastd	ymm4, xmm4
	vpaddd	ymm5, ymm4, ymm5
	vpaddd	ymm2, ymm4, ymm2
	vpsrld	ymm4, ymm5, 3
	vpsrld	ymm6, ymm2, 3
	vpand	ymm13, ymm9, ymm5
	vpand	ymm5, ymm9, ymm2
	vbroadcasti128	ymm7, xmmword ptr [rip + 662f]
	vpshufb	ymm2, ymm4, ymm7
	vpshufb	ymm4, ymm6, ymm7
	vmovdqu	ymm6, ymmword ptr [rsp + 464]
	vpaddb	ymm11, ymm2, ymm6
	vpaddb	ymm4, ymm4, ymm6
	mov	r9, rcx
	shr	r9, 3
	lea	rax, [r9 + 64]
	mov	r8, qword ptr [rsp + 8]
	cmp	rax, r8
	jbe	382f
	mov	rax, r8
	sub	rax, r9
	mov	r8, r12
	mov	r12, qword ptr [rsp + 16]
	mov	r13d, 32
	jbe	452f
	cmp	rax, 16
	mov	r10, r9
	mov	qword ptr [rsp + 64], rcx
	jb	432f
	mov	rcx, qword ptr [rsp]
	lea	rbx, [r9 + rcx]
	mov	rcx, rdi
	sub	rcx, rbx
	add	rcx, 575
	cmp	rcx, 127
	mov	rcx, qword ptr [rsp + 64]
	mov	r10, r9
	jb	432f
	cmp	rax, 128
	jae	392f
	xor	r14d, r14d
	jmp	412f
	.p2align	4
372:
	mov	r12, qword ptr [rsp + 16]
	mov	r13d, 32
	jmp	462f
382:
	mov	r8, qword ptr [rsp]
	add	r8, r9
	mov	r12, qword ptr [rsp + 16]
	mov	r13d, 32
	jmp	452f
392:
	mov	r14, rax
	and	r14, -128
	lea	r10, [r9 + r14]
	mov	r8, qword ptr [rsp]
	lea	r8, [r8 + r9 + 96]
	xor	r15d, r15d
	.p2align	4
402:
	vmovdqu	ymm2, ymmword ptr [r8 + r15 - 96]
	vmovdqu	ymm6, ymmword ptr [r8 + r15 - 64]
	vmovdqu	ymm7, ymmword ptr [r8 + r15 - 32]
	vmovdqu	ymm9, ymmword ptr [r8 + r15]
	vmovdqu	ymmword ptr [rdi + r15 + 576], ymm2
	vmovdqu	ymmword ptr [rdi + r15 + 608], ymm6
	vmovdqu	ymmword ptr [rdi + r15 + 640], ymm7
	vmovdqu	ymmword ptr [rdi + r15 + 672], ymm9
	sub	r15, -128
	cmp	r14, r15
	jne	402b
	cmp	rax, r14
	lea	r8, [rdi + 576]
	mov	r15, qword ptr [rsp + 24]
	je	452f
	test	al, 112
	je	432f
412:
	mov	r8, rax
	and	r8, -16
	lea	r10, [r9 + r8]
	lea	rcx, [rdi + 576]
	.p2align	4
422:
	vmovdqu	xmm2, xmmword ptr [rbx + r14]
	vmovdqu	xmmword ptr [rcx + r14], xmm2
	add	r14, 16
	cmp	r8, r14
	jne	422b
	cmp	rax, r8
	mov	r8, rcx
	mov	rcx, qword ptr [rsp + 64]
	je	452f
432:
	lea	rax, [rdi + 576]
	sub	rax, r9
	mov	r8, qword ptr [rsp]
	mov	r9, qword ptr [rsp + 8]
	.p2align	4
442:
	movzx	ecx, byte ptr [r8 + r10]
	mov	byte ptr [rax + r10], cl
	inc	r10
	cmp	r9, r10
	jne	442b
	lea	r8, [rdi + 576]
	mov	rcx, qword ptr [rsp + 64]
452:
	vmovdqu	ymm2, ymmword ptr [r8]
	vmovdqu	ymm6, ymmword ptr [r8 + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm9, ymm7, ymm11
	vpshufb	ymm14, ymm2, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 672f]
	vpand	ymm15, ymm11, ymm3
	vpxor	xmm12, xmm12, xmm12
	vpcmpeqb	ymm15, ymm15, ymm12
	vpblendvb	ymm9, ymm14, ymm9, ymm15
	vpermq	ymm14, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm8, ymm14, ymm11
	vpshufb	ymm10, ymm6, ymm11
	vpblendvb	ymm8, ymm10, ymm8, ymm15
	vpshufb	ymm7, ymm7, ymm4
	vpshufb	ymm2, ymm2, ymm4
	vpand	ymm10, ymm4, ymm3
	vpcmpeqb	ymm10, ymm10, ymm12
	vpblendvb	ymm2, ymm2, ymm7, ymm10
	vpshufb	ymm7, ymm14, ymm4
	vpshufb	ymm6, ymm6, ymm4
	vpblendvb	ymm6, ymm6, ymm7, ymm10
	vpxor	xmm7, xmm7, xmm7
	vpbroadcastb	ymm3, byte ptr [rip + 682f]
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm2, ymm2, ymm6, ymm4
	vpand	ymm4, ymm11, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm4, ymm9, ymm8, ymm4
	vpsrlvd	ymm2, ymm2, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 112]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 144]
	vpsrlvd	ymm3, ymm4, ymm13
	vmovdqu	ymm4, ymmword ptr [rsp + 336]
	vpandn	ymm3, ymm4, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 400]
	vpor	ymm4, ymm3, ymmword ptr [rip + 692f]
	vpcmpeqd	ymm3, ymm3, ymm7
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 702f]
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
	vmovdqu	ymm5, ymmword ptr [rsp + 432]
	vpand	ymm3, ymm2, ymm5
	vpcmpeqd	ymm2, ymm2, ymm7
	vblendvps	ymm2, ymm3, ymm1, ymm2
	vpand	ymm3, ymm4, ymm5
	vpcmpeqd	ymm4, ymm4, ymm7
	vblendvps	ymm1, ymm3, ymm1, ymm4
	vextracti128	xmm0, ymm0, 1
	vpextrd	eax, xmm0, 3
	vmovups	ymmword ptr [rdi + 448], ymm1
	vmovups	ymmword ptr [rdi + 480], ymm2
	vshufps	ymm0, ymm2, ymm2, 255
	vpermpd	ymm1, ymm0, 170
	add	rcx, rax
462:
	mov	r8, qword ptr [rsp + 176]
472:
	shr	r8, 56
	mov	r9, qword ptr [rsp + 32]
	add	r9, r8
	mov	rax, qword ptr [rsp + 40]
	shr	rax, 56
	mov	r8, qword ptr [rsp + 48]
	add	r8, rax
	vmovd	eax, xmm1
	mov	qword ptr [rdi + 72], rcx
	mov	qword ptr [rdi + 96], rax
	mov	qword ptr [rdi + 128], r8
	mov	qword ptr [rdi + 136], r9
	xor	eax, eax
	.p2align	4
482:
	mov	r8, r11
	movzx	r10d, byte ptr [rdi + rax + 512]
	movzx	r9d, byte ptr [rdi + rax + 192]
	mov	r11d, dword ptr [rdi + 4*rax + 256]
	vmovdqu	ymm0, ymmword ptr [rsi]
	cmp	r8, 33
	cmovb	r8, r13
	mov	rbx, rdx
	sub	rbx, r8
	cmp	rbx, r12
	jl	512f
	vpaddb	ymm0, ymm0, ymmword ptr [rbx]
	vmovdqu	ymmword ptr [rdx], ymm0
	cmp	r9b, 33
	jae	522f
492:
	add	rdx, r9
	mov	ebx, r10d
	shr	ebx, 2
	cmp	rbx, 32
	mov	r8d, 32
	cmovb	r8, rbx
	cmp	r11, r8
	cmova	r8, r11
	mov	r14, rdx
	sub	r14, r8
	cmp	r14, r12
	jl	542f
	vmovdqu	ymm0, ymmword ptr [r14]
	vmovdqu	ymmword ptr [rdx], ymm0
	cmp	r10b, -124
	jae	552f
502:
	add	rdx, rbx
	add	rsi, r9
	inc	rax
	cmp	rax, r15
	jne	482b
	jmp	2b
512:
	mov	rcx, rdx
	sub	rcx, r12
	sub	rcx, r8
	mov	ebx, 0
	cmovae	rbx, rcx
	add	rbx, r12
	vpaddb	ymm0, ymm0, ymmword ptr [rbx]
	vmovdqu	ymmword ptr [rdx], ymm0
	cmp	r9b, 33
	jb	492b
522:
	mov	rcx, qword ptr [rdi + 48]
	mov	r8, qword ptr [rdi + 120]
	movzx	r9d, byte ptr [rcx + r8]
	inc	r8
	mov	qword ptr [rdi + 120], r8
	add	r9, 33
	mov	r8d, 32
	.p2align	4
532:
	vmovdqu	ymm0, ymmword ptr [rsi + r8]
	vmovdqu	ymmword ptr [rdx + r8], ymm0
	add	r8, 32
	cmp	r8, r9
	jb	532b
	jmp	492b
542:
	mov	rcx, rdx
	sub	rcx, r12
	sub	rcx, r8
	mov	r14d, 0
	cmovae	r14, rcx
	add	r14, r12
	vmovdqu	ymm0, ymmword ptr [r14]
	vmovdqu	ymmword ptr [rdx], ymm0
	cmp	r10b, -124
	jb	502b
552:
	mov	rcx, qword ptr [rdi + 48]
	mov	r8, qword ptr [rdi + 120]
	movzx	ebx, byte ptr [rcx + r8]
	inc	r8
	mov	qword ptr [rdi + 120], r8
	add	rbx, 33
	mov	r8d, 32
	.p2align	4
562:
	vmovdqu	ymm0, ymmword ptr [r14 + r8]
	vmovdqu	ymmword ptr [rdx + r8], ymm0
	add	r8, 32
	cmp	r8, rbx
	jb	562b
	jmp	502b
572:
	sub	rdx, r12
	sub	rsi, qword ptr [rsp + 216]
	mov	qword ptr [rdi + 80], rdx
	mov	qword ptr [rdi + 88], rsi
	add	rsp, 696
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	vzeroupper
	ret
	.p2align	2, 0x0
582:
	.long	1
	.p2align	2, 0x0
592:
	.long	7
	.p2align	2, 0x0
602:
	.long	8
	.p2align	2, 0x0
612:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	2, 0x0
622:
	.long	134217727
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
	.p2align	5, 0x0
642:
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
	.p2align	2, 0x0
652:
	.byte	1
	.p2align	4, 0x0
662:
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
672:
	.byte	16
	.p2align	2, 0x0
682:
	.byte	32
	.p2align	5, 0x0
692:
	.long	1207959552
	.long	1342177280
	.long	1476395008
	.long	1610612736
	.long	1744830464
	.long	1879048192
	.long	2013265920
	.long	2147483648
	.p2align	5, 0x0
702:
	.long	134217728
	.long	268435456
	.long	402653184
	.long	536870912
	.long	671088640
	.long	805306368
	.long	939524096
	.long	1073741824

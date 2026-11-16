# minlz_exec_plain of crates/minlz/mlir/exec64.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 696
	mov	r15, qword ptr [rdi]
	mov	rax, qword ptr [rdi + 8]
	mov	rcx, qword ptr [rdi + 64]
	mov	rdx, qword ptr [rdi + 80]
	add	rdx, r15
	mov	rsi, qword ptr [rdi + 88]
	mov	qword ptr [rsp + 152], rax
	add	rsi, rax
	test	rcx, rcx
	jle	582f
	lea	r9, [rdi + 512]
	mov	eax, 96
	mov	qword ptr [rsp + 72], rax
	mov	r13d, 7
	xor	ebp, ebp
	vpxor	xmm7, xmm7, xmm7
	vbroadcastss	ymm0, dword ptr [rip + 592f]
	vmovups	ymmword ptr [rsp + 560], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 602f]
	vmovups	ymmword ptr [rsp + 528], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 612f]
	vmovups	ymmword ptr [rsp + 496], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 622f]
	vmovups	ymmword ptr [rsp + 464], ymm0
	vpbroadcastd	ymm0, dword ptr [rip + 632f]
	vmovdqu	ymmword ptr [rsp + 432], ymm0
	mov	qword ptr [rsp + 24], r9
	mov	rax, rcx
	xor	r10d, r10d
	mov	qword ptr [rsp + 64], r15
	mov	qword ptr [rsp + 160], rcx
	jmp	12f
	.p2align	4
2:
	mov	rax, qword ptr [rsp + 256]
	add	rax, -64
	inc	rbp
	add	qword ptr [rsp + 72], 64
	add	r13, -64
	add	rcx, -64
	mov	qword ptr [rsp + 24], rcx
	mov	rcx, qword ptr [rsp + 160]
	mov	r10, qword ptr [rsp + 248]
	cmp	r10, rcx
	lea	r9, [rdi + 512]
	jge	582f
12:
	cmp	rax, 1
	mov	qword ptr [rsp + 256], rax
	mov	r8, rax
	adc	r8, 0
	cmp	r8, 64
	mov	eax, 64
	cmovae	r8, rax
	mov	qword ptr [rsp + 56], r8
	sub	rcx, r10
	cmp	rcx, 64
	mov	r11d, 64
	mov	qword ptr [rsp + 400], rcx
	cmovb	r11, rcx
	mov	r15, qword ptr [rdi + 16]
	mov	r8, qword ptr [rdi + 24]
	mov	rax, qword ptr [rdi + 32]
	mov	qword ptr [rsp + 272], rax
	mov	rax, qword ptr [rdi + 40]
	mov	qword ptr [rsp + 8], rax
	mov	rbx, qword ptr [rdi + 64]
	mov	rax, qword ptr [rdi + 72]
	mov	qword ptr [rsp + 112], rax
	mov	rax, qword ptr [rdi + 96]
	mov	qword ptr [rsp + 80], rax
	mov	rax, qword ptr [rdi + 112]
	mov	qword ptr [rsp + 32], rax
	mov	rax, qword ptr [rdi + 128]
	mov	qword ptr [rsp + 48], rax
	mov	rax, qword ptr [rdi + 136]
	mov	qword ptr [rsp + 40], rax
	lea	r12, [rbx + 7]
	lea	rax, [r10 + 64]
	mov	qword ptr [rsp + 248], rax
	cmp	rax, r12
	mov	qword ptr [rsp + 264], rbp
	jbe	52f
	cmp	r10, r12
	mov	rcx, r9
	jge	62f
	mov	rax, rbp
	shl	rax, 6
	mov	r14d, 7
	sub	r14, rax
	add	r14, rbx
	cmp	r14, 16
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
	mov	rcx, qword ptr [rsp + 24]
	.p2align	4
42:
	movzx	eax, byte ptr [r15 + r14]
	mov	byte ptr [rcx + r14], al
	inc	r14
	cmp	r12, r14
	jne	42b
	mov	rcx, r9
	jmp	62f
	.p2align	4
52:
	add	r15, r10
	mov	rcx, r15
62:
	mov	qword ptr [rsp + 16], r13
	vmovdqu	ymm1, ymmword ptr [rcx]
	vmovdqu	ymm15, ymmword ptr [rcx + 32]
	vmovd	xmm0, r11d
	vpbroadcastb	ymm3, xmm0
	vpmaxub	ymm0, ymm3, ymmword ptr [rip + 642f]
	vpcmpeqb	ymm0, ymm3, ymm0
	vpmaxub	ymm4, ymm3, ymmword ptr [rip + 652f]
	vpcmpeqb	ymm3, ymm3, ymm4
	vpsllw	ymm4, ymm15, 6
	vpcmpgtb	ymm4, ymm7, ymm4
	vpsllw	ymm5, ymm1, 6
	vpcmpgtb	ymm8, ymm7, ymm5
	vpbroadcastb	ymm2, byte ptr [rip + 662f]
	vpand	ymm5, ymm1, ymm2
	vpcmpeqb	ymm5, ymm5, ymm7
	movabs	r11, 72340172838076673
	#APP
	#NO_APP
	vpand	ymm4, ymm4, ymm2
	vpand	ymm4, ymm0, ymm4
	vpand	ymm8, ymm8, ymm2
	vpand	ymm8, ymm8, ymm3
	vmovq	r10, xmm8
	vpextrq	rbp, xmm8, 1
	vextracti128	xmm8, ymm8, 1
	vmovq	r9, xmm8
	vpextrq	rax, xmm8, 1
	vmovq	rbx, xmm4
	vpextrq	r12, xmm4, 1
	vextracti128	xmm4, ymm4, 1
	vmovq	r14, xmm4
	mov	rcx, r10
	imul	rcx, r11
	mov	r15, rcx
	sub	r15, r10
	xor	r10, r11
	shl	r10, 7
	or	r10, r15
	vpextrq	r15, xmm4, 1
	mov	r13, qword ptr [rsp + 48]
	vmovq	xmm4, qword ptr [r8 + r13]
	vmovq	xmm8, r10
	vpshufb	xmm4, xmm4, xmm8
	shr	rcx, 56
	add	rcx, r13
	mov	r10, rbp
	imul	r10, r11
	mov	r13, r10
	sub	r13, rbp
	xor	rbp, r11
	shl	rbp, 7
	or	rbp, r13
	vmovq	xmm8, qword ptr [r8 + rcx]
	vmovq	xmm9, rbp
	vpshufb	xmm8, xmm8, xmm9
	vpunpcklqdq	xmm4, xmm4, xmm8
	shr	r10, 56
	add	r10, rcx
	mov	rcx, r9
	imul	rcx, r11
	mov	r13, rcx
	sub	r13, r9
	xor	r9, r11
	shl	r9, 7
	or	r9, r13
	vmovq	xmm8, qword ptr [r8 + r10]
	vmovq	xmm9, r9
	vpshufb	xmm8, xmm8, xmm9
	shr	rcx, 56
	add	rcx, r10
	mov	r9, rax
	imul	r9, r11
	mov	r10, r9
	sub	r10, rax
	xor	rax, r11
	shl	rax, 7
	or	rax, r10
	vmovq	xmm9, qword ptr [r8 + rcx]
	vmovq	xmm10, rax
	vpshufb	xmm9, xmm9, xmm10
	vpunpcklqdq	xmm8, xmm8, xmm9
	shr	r9, 56
	add	r9, rcx
	mov	rax, rbx
	imul	rax, r11
	mov	rcx, rax
	sub	rcx, rbx
	xor	rbx, r11
	shl	rbx, 7
	or	rbx, rcx
	vmovq	xmm9, qword ptr [r8 + r9]
	vmovq	xmm10, rbx
	vpshufb	xmm9, xmm9, xmm10
	shr	rax, 56
	add	rax, r9
	mov	rcx, r12
	imul	rcx, r11
	mov	r9, rcx
	sub	r9, r12
	xor	r12, r11
	shl	r12, 7
	or	r12, r9
	vmovq	xmm10, qword ptr [r8 + rax]
	vmovq	xmm11, r12
	vpshufb	xmm10, xmm10, xmm11
	vpunpcklqdq	xmm9, xmm9, xmm10
	shr	rcx, 56
	add	rcx, rax
	mov	r9, r14
	imul	r9, r11
	mov	rax, r9
	sub	rax, r14
	xor	r14, r11
	shl	r14, 7
	or	r14, rax
	vmovq	xmm10, qword ptr [r8 + rcx]
	vmovq	xmm11, r14
	vpshufb	xmm10, xmm10, xmm11
	shr	r9, 56
	add	r9, rcx
	mov	rax, r15
	imul	rax, r11
	mov	qword ptr [rsp + 240], rax
	sub	rax, r15
	xor	r11, r15
	shl	r11, 7
	or	r11, rax
	mov	qword ptr [rsp + 48], r9
	vmovq	xmm11, qword ptr [r8 + r9]
	vmovq	xmm12, r11
	vpshufb	xmm11, xmm11, xmm12
	vpunpcklqdq	xmm10, xmm10, xmm11
	vmovdqu	xmmword ptr [rdi + 224], xmm9
	vmovdqu	xmmword ptr [rdi + 192], xmm4
	vmovdqu	xmmword ptr [rdi + 208], xmm8
	vmovdqu	xmmword ptr [rdi + 240], xmm10
	movabs	r11, 72340172838076673
	#APP
	#NO_APP
	vpand	ymm4, ymm5, ymm2
	vpand	ymm3, ymm3, ymm4
	vmovq	r10, xmm3
	vpextrq	rbx, xmm3, 1
	vextracti128	xmm3, ymm3, 1
	vmovq	rax, xmm3
	mov	r15, r11
	imul	r15, r10
	mov	r14, r15
	shr	r14, 56
	mov	r12, qword ptr [rsp + 40]
	add	r14, r12
	mov	r9, r11
	imul	r9, rbx
	mov	rcx, r9
	shr	rcx, 56
	add	rcx, r14
	mov	r13, r11
	mov	qword ptr [rsp + 216], rax
	imul	r13, rax
	mov	rax, qword ptr [rsp + 272]
	vmovsd	xmm4, qword ptr [rax + rcx]
	vmovaps	xmmword ptr [rsp + 656], xmm4
	mov	qword ptr [rsp + 224], r13
	shr	r13, 56
	add	r13, rcx
	vpextrq	r8, xmm3, 1
	mov	rcx, r11
	imul	rcx, r8
	vmovsd	xmm3, qword ptr [rax + r13]
	vmovaps	xmmword ptr [rsp + 672], xmm3
	mov	qword ptr [rsp + 232], rcx
	shr	rcx, 56
	add	rcx, r13
	vpand	ymm3, ymm15, ymm2
	vpcmpeqb	ymm3, ymm3, ymm7
	vpand	ymm3, ymm3, ymm2
	vpand	ymm0, ymm0, ymm3
	vmovq	r13, xmm0
	mov	rbp, r11
	mov	qword ptr [rsp + 200], r13
	imul	rbp, r13
	vmovsd	xmm2, qword ptr [rax + rcx]
	vmovaps	xmmword ptr [rsp + 624], xmm2
	mov	qword ptr [rsp + 184], rbp
	mov	r13, rbp
	shr	r13, 56
	add	r13, rcx
	vpextrq	rcx, xmm0, 1
	mov	rbp, r11
	mov	qword ptr [rsp + 208], rcx
	imul	rbp, rcx
	vmovsd	xmm2, qword ptr [rax + r13]
	vmovaps	xmmword ptr [rsp + 640], xmm2
	mov	qword ptr [rsp + 192], rbp
	mov	rcx, rbp
	shr	rcx, 56
	add	rcx, r13
	vextracti128	xmm4, ymm0, 1
	vmovq	r13, xmm4
	mov	rbp, r11
	mov	qword ptr [rsp + 176], r13
	imul	rbp, r13
	vmovsd	xmm0, qword ptr [rax + rcx]
	vmovaps	xmmword ptr [rsp + 592], xmm0
	mov	qword ptr [rsp + 168], rbp
	mov	r13, rbp
	shr	r13, 56
	add	r13, rcx
	vmovq	xmm0, qword ptr [rax + r12]
	vmovq	xmm3, qword ptr [rax + r14]
	mov	qword ptr [rsp + 40], r13
	vmovsd	xmm2, qword ptr [rax + r13]
	vmovaps	xmmword ptr [rsp + 608], xmm2
	vmovss	xmm5, dword ptr [rsp + 80]
	sub	r15, r10
	xor	r10, r11
	shl	r10, 7
	or	r10, r15
	vmovq	xmm9, r10
	sub	r9, rbx
	xor	rbx, r11
	shl	rbx, 7
	or	rbx, r9
	vmovq	xmm11, rbx
	mov	rbx, qword ptr [rsp + 112]
	mov	ecx, ebx
	and	ecx, 7
	vmovd	xmm14, ecx
	shr	rbx, 3
	lea	rcx, [rbx + 64]
	mov	r9, qword ptr [rsp + 32]
	cmp	rcx, r9
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
	vmovdqu	ymmword ptr [rsp + 80], ymm0
	vpsllvd	ymm0, ymm11, ymm9
	vmovdqu	ymmword ptr [rsp + 368], ymm0
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
	vmovdqu	ymmword ptr [rsp + 336], ymm0
	vpaddd	ymm15, ymm13, ymm11
	vpsubd	ymm11, ymm13, ymm9
	vpsllvd	ymm0, ymm6, ymm9
	vmovdqu	ymmword ptr [rsp + 304], ymm0
	vpsubd	ymm5, ymm15, ymm5
	vpbroadcastd	ymm9, xmm14
	vpaddd	ymm5, ymm9, ymm5
	vpaddd	ymm9, ymm11, ymm9
	vpsrld	ymm14, ymm5, 3
	vpextrq	qword ptr [rsp + 272], xmm4, 1
	vpsrld	ymm4, ymm9, 3
	vpand	ymm5, ymm5, ymm2
	vpand	ymm11, ymm9, ymm2
	vbroadcasti128	ymm0, xmmword ptr [rip + 672f]
	vpshufb	ymm9, ymm14, ymm0
	vpshufb	ymm14, ymm4, ymm0
	vmovdqu	ymm0, ymmword ptr [rsp + 464]
	vpaddb	ymm4, ymm9, ymm0
	vpaddb	ymm9, ymm14, ymm0
	jbe	72f
	sub	r9, rbx
	lea	rbp, [rdi + 576]
	mov	rcx, rbp
	mov	r13, qword ptr [rsp + 16]
	jbe	152f
	cmp	r9, 16
	mov	r10, rbx
	jb	132f
	mov	rcx, qword ptr [rsp + 8]
	lea	r14, [rbx + rcx]
	mov	rcx, rdi
	sub	rcx, r14
	add	rcx, 575
	cmp	rcx, 127
	mov	r10, rbx
	jb	132f
	cmp	r9, 128
	jae	92f
	xor	r15d, r15d
	jmp	112f
	.p2align	4
72:
	add	rbx, qword ptr [rsp + 8]
	mov	rcx, rbx
	lea	rbp, [rdi + 576]
	mov	r13, qword ptr [rsp + 16]
	jmp	152f
82:
	cmp	r14, 128
	mov	qword ptr [rsp + 16], r14
	jae	182f
	xor	eax, eax
	jmp	202f
92:
	mov	r15, r9
	and	r15, -128
	lea	r10, [rbx + r15]
	mov	rcx, qword ptr [rsp + 8]
	lea	rcx, [rcx + rbx + 96]
	xor	r13d, r13d
	.p2align	4
102:
	vmovdqu	ymm14, ymmword ptr [rcx + r13 - 96]
	vmovdqu	ymm8, ymmword ptr [rcx + r13 - 64]
	vmovdqu	ymm10, ymmword ptr [rcx + r13 - 32]
	vmovdqu	ymm6, ymmword ptr [rcx + r13]
	vmovdqu	ymmword ptr [rdi + r13 + 576], ymm14
	vmovdqu	ymmword ptr [rdi + r13 + 608], ymm8
	vmovdqu	ymmword ptr [rdi + r13 + 640], ymm10
	vmovdqu	ymmword ptr [rdi + r13 + 672], ymm6
	sub	r13, -128
	cmp	r15, r13
	jne	102b
	cmp	r9, r15
	mov	rcx, rbp
	mov	r13, qword ptr [rsp + 16]
	je	152f
	test	r9b, 112
	je	132f
112:
	mov	rcx, r9
	and	rcx, -16
	lea	r10, [rbx + rcx]
	.p2align	4
122:
	vmovdqu	xmm6, xmmword ptr [r14 + r15]
	vmovdqu	xmmword ptr [rbp + r15], xmm6
	add	r15, 16
	cmp	rcx, r15
	jne	122b
	cmp	r9, rcx
	mov	rcx, rbp
	je	152f
	.p2align	4
132:
	mov	rcx, rbp
	sub	rcx, rbx
	mov	rbx, qword ptr [rsp + 8]
	mov	r14, qword ptr [rsp + 32]
	.p2align	4
142:
	movzx	r9d, byte ptr [rbx + r10]
	mov	byte ptr [rcx + r10], r9b
	inc	r10
	cmp	r14, r10
	jne	142b
	mov	rcx, rbp
152:
	vmovdqu	ymm6, ymmword ptr [rcx]
	vmovdqu	ymm8, ymmword ptr [rcx + 32]
	vpermq	ymm10, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm14, ymm10, ymm4
	vpshufb	ymm7, ymm6, ymm4
	vpbroadcastb	ymm13, byte ptr [rip + 682f]
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
	vpbroadcastb	ymm8, byte ptr [rip + 692f]
	vpand	ymm6, ymm9, ymm8
	vpcmpeqb	ymm6, ymm8, ymm6
	vpblendvb	ymm2, ymm2, ymm3, ymm6
	vpand	ymm3, ymm8, ymm4
	vpcmpeqb	ymm3, ymm8, ymm3
	vpblendvb	ymm0, ymm7, ymm0, ymm3
	vpxor	xmm7, xmm7, xmm7
	vpsrlvd	ymm2, ymm2, ymm11
	vmovdqu	ymm3, ymmword ptr [rsp + 304]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 368]
	vpsrlvd	ymm0, ymm0, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 336]
	vpandn	ymm0, ymm3, ymm0
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 80]
	vpor	ymm3, ymm0, ymmword ptr [rip + 702f]
	vpcmpeqd	ymm0, ymm0, ymm7
	vpandn	ymm0, ymm0, ymm3
	vpor	ymm3, ymm2, ymmword ptr [rip + 712f]
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
	vpextrd	ecx, xmm2, 3
	vmovups	ymmword ptr [rdi + 256], ymm1
	mov	r10, r11
	imul	r10, qword ptr [rsp + 272]
	vmovups	ymmword ptr [rdi + 288], ymm0
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm1, ymm0, 170
	mov	r14, qword ptr [rsp + 112]
	add	r14, rcx
	cmp	qword ptr [rsp + 400], 17
	jb	162f
	mov	qword ptr [rsp + 16], r10
	mov	rax, qword ptr [rsp + 224]
	mov	rcx, qword ptr [rsp + 216]
	sub	rax, rcx
	xor	rcx, r11
	shl	rcx, 7
	or	rcx, rax
	vmovq	xmm0, rcx
	vmovdqa	xmm2, xmmword ptr [rsp + 656]
	vpshufb	xmm0, xmm2, xmm0
	mov	rax, qword ptr [rsp + 232]
	sub	rax, r8
	xor	r8, r11
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
	vmovdqu	ymmword ptr [rsp + 368], ymm0
	vpsllvd	ymm0, ymm2, ymm4
	vmovdqu	ymmword ptr [rsp + 80], ymm0
	vpsllvd	ymm0, ymm7, ymm5
	vmovdqu	ymmword ptr [rsp + 304], ymm0
	vpsllvd	ymm0, ymm7, ymm4
	vmovdqu	ymmword ptr [rsp + 336], ymm0
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
	mov	eax, r14d
	and	eax, 7
	vmovd	xmm5, eax
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm2, ymm5, ymm2
	vpaddd	ymm4, ymm5, ymm4
	vpsrld	ymm6, ymm2, 3
	vpsrld	ymm7, ymm4, 3
	vpand	ymm12, ymm9, ymm2
	vpand	ymm5, ymm9, ymm4
	vbroadcasti128	ymm0, xmmword ptr [rip + 672f]
	vpshufb	ymm2, ymm6, ymm0
	vpshufb	ymm4, ymm7, ymm0
	vmovdqu	ymm0, ymmword ptr [rsp + 464]
	vpaddb	ymm11, ymm2, ymm0
	vpaddb	ymm4, ymm4, ymm0
	mov	r8, r14
	shr	r8, 3
	lea	rax, [r8 + 64]
	mov	r9, qword ptr [rsp + 32]
	cmp	rax, r9
	mov	r15, qword ptr [rsp + 64]
	jbe	172f
	sub	r9, r8
	mov	rcx, rbp
	mov	r12, qword ptr [rsp + 56]
	jbe	282f
	cmp	r9, 16
	mov	rax, r8
	jb	262f
	mov	rax, qword ptr [rsp + 8]
	lea	r10, [r8 + rax]
	mov	rax, rdi
	sub	rax, r10
	add	rax, 575
	cmp	rax, 127
	mov	rax, r8
	jb	262f
	cmp	r9, 128
	jae	222f
	xor	ebx, ebx
	jmp	242f
	.p2align	4
162:
	mov	r15, qword ptr [rsp + 64]
	mov	rcx, qword ptr [rsp + 24]
	mov	r12, qword ptr [rsp + 56]
	jmp	462f
	.p2align	4
172:
	add	r8, qword ptr [rsp + 8]
	mov	rcx, r8
	mov	r12, qword ptr [rsp + 56]
	jmp	282f
182:
	mov	rax, r14
	and	rax, -128
	lea	r14, [r10 + rax]
	mov	rcx, qword ptr [rsp + 72]
	add	rcx, r15
	lea	rbp, [rbx + r13]
	and	rbp, -128
	xor	r9d, r9d
	.p2align	4
192:
	vmovdqu	ymm0, ymmword ptr [rcx + r9 - 96]
	vmovups	ymm1, ymmword ptr [rcx + r9 - 64]
	vmovups	ymm3, ymmword ptr [rcx + r9 - 32]
	vmovdqu	ymm4, ymmword ptr [rcx + r9]
	vmovdqu	ymmword ptr [rdi + r9 + 512], ymm0
	vmovups	ymmword ptr [rdi + r9 + 544], ymm1
	vmovups	ymmword ptr [rdi + r9 + 576], ymm3
	vmovdqu	ymmword ptr [rdi + r9 + 608], ymm4
	sub	r9, -128
	cmp	rbp, r9
	jne	192b
	cmp	qword ptr [rsp + 16], rax
	lea	r9, [rdi + 512]
	mov	rcx, r9
	je	62b
	test	byte ptr [rsp + 16], 112
	je	32b
202:
	mov	rcx, qword ptr [rsp + 16]
	and	rcx, -16
	lea	r14, [r15 + r10]
	add	r10, rcx
	add	rbx, r13
	and	rbx, -16
	.p2align	4
212:
	vmovdqu	xmm0, xmmword ptr [r14 + rax]
	vmovdqu	xmmword ptr [r9 + rax], xmm0
	add	rax, 16
	cmp	rbx, rax
	jne	212b
	cmp	qword ptr [rsp + 16], rcx
	mov	r14, r10
	mov	rcx, r9
	je	62b
	jmp	32b
222:
	mov	qword ptr [rsp + 112], r14
	mov	rbx, r9
	and	rbx, -128
	lea	rax, [r8 + rbx]
	mov	rcx, qword ptr [rsp + 8]
	lea	rcx, [rcx + r8 + 96]
	xor	r14d, r14d
	.p2align	4
232:
	vmovdqu	ymm2, ymmword ptr [rcx + r14 - 96]
	vmovdqu	ymm6, ymmword ptr [rcx + r14 - 64]
	vmovdqu	ymm7, ymmword ptr [rcx + r14 - 32]
	vmovdqu	ymm9, ymmword ptr [rcx + r14]
	vmovdqu	ymmword ptr [rdi + r14 + 576], ymm2
	vmovdqu	ymmword ptr [rdi + r14 + 608], ymm6
	vmovdqu	ymmword ptr [rdi + r14 + 640], ymm7
	vmovdqu	ymmword ptr [rdi + r14 + 672], ymm9
	sub	r14, -128
	cmp	rbx, r14
	jne	232b
	cmp	r9, rbx
	mov	rcx, rbp
	mov	r14, qword ptr [rsp + 112]
	je	282f
	test	r9b, 112
	je	262f
242:
	mov	rcx, r9
	and	rcx, -16
	lea	rax, [r8 + rcx]
	.p2align	4
252:
	vmovdqu	xmm2, xmmword ptr [r10 + rbx]
	vmovdqu	xmmword ptr [rbp + rbx], xmm2
	add	rbx, 16
	cmp	rcx, rbx
	jne	252b
	cmp	r9, rcx
	mov	rcx, rbp
	je	282f
262:
	mov	rcx, rbp
	sub	rcx, r8
	mov	r9, qword ptr [rsp + 8]
	mov	r10, qword ptr [rsp + 32]
	.p2align	4
272:
	movzx	r8d, byte ptr [r9 + rax]
	mov	byte ptr [rcx + rax], r8b
	inc	rax
	cmp	r10, rax
	jne	272b
	mov	rcx, rbp
282:
	vmovdqu	ymm2, ymmword ptr [rcx]
	vmovdqu	ymm6, ymmword ptr [rcx + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm9, ymm7, ymm11
	vpshufb	ymm13, ymm2, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 682f]
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
	vpbroadcastb	ymm0, byte ptr [rip + 692f]
	vpand	ymm4, ymm4, ymm0
	vpcmpeqb	ymm4, ymm4, ymm0
	vpblendvb	ymm2, ymm2, ymm6, ymm4
	vpand	ymm4, ymm11, ymm0
	vpcmpeqb	ymm4, ymm4, ymm0
	vpblendvb	ymm4, ymm9, ymm10, ymm4
	vpsrlvd	ymm2, ymm2, ymm5
	vmovdqu	ymm0, ymmword ptr [rsp + 304]
	vpandn	ymm2, ymm0, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 368]
	vpsrlvd	ymm3, ymm4, ymm12
	vmovdqu	ymm0, ymmword ptr [rsp + 336]
	vpandn	ymm0, ymm0, ymm3
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 80]
	vpor	ymm3, ymm0, ymmword ptr [rip + 702f]
	vpcmpeqd	ymm0, ymm0, ymm7
	vpandn	ymm0, ymm0, ymm3
	vpor	ymm3, ymm2, ymmword ptr [rip + 712f]
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
	add	r14, rax
	cmp	qword ptr [rsp + 400], 33
	jb	452f
	mov	rax, qword ptr [rsp + 200]
	mov	rcx, qword ptr [rsp + 184]
	sub	rcx, rax
	xor	rax, r11
	shl	rax, 7
	or	rax, rcx
	vmovq	xmm0, rax
	vmovdqa	xmm2, xmmword ptr [rsp + 624]
	vpshufb	xmm0, xmm2, xmm0
	mov	rax, qword ptr [rsp + 208]
	mov	rcx, qword ptr [rsp + 192]
	sub	rcx, rax
	xor	rax, r11
	shl	rax, 7
	or	rax, rcx
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
	vmovdqu	ymmword ptr [rsp + 368], ymm0
	vpsllvd	ymm0, ymm2, ymm4
	vmovdqu	ymmword ptr [rsp + 80], ymm0
	vpsllvd	ymm0, ymm7, ymm5
	vmovdqu	ymmword ptr [rsp + 304], ymm0
	vpsllvd	ymm0, ymm7, ymm4
	vmovdqu	ymmword ptr [rsp + 336], ymm0
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
	mov	eax, r14d
	and	eax, 7
	vmovd	xmm5, eax
	vpbroadcastd	ymm5, xmm5
	vpaddd	ymm2, ymm5, ymm2
	vpaddd	ymm4, ymm5, ymm4
	vpsrld	ymm6, ymm2, 3
	vpsrld	ymm7, ymm4, 3
	vpand	ymm13, ymm9, ymm2
	vpand	ymm5, ymm9, ymm4
	vbroadcasti128	ymm0, xmmword ptr [rip + 672f]
	vpshufb	ymm2, ymm6, ymm0
	vpshufb	ymm4, ymm7, ymm0
	vmovdqu	ymm0, ymmword ptr [rsp + 464]
	vpaddb	ymm11, ymm2, ymm0
	vpaddb	ymm4, ymm4, ymm0
	mov	r8, r14
	shr	r8, 3
	lea	rax, [r8 + 64]
	mov	r9, qword ptr [rsp + 32]
	cmp	rax, r9
	jbe	292f
	sub	r9, r8
	mov	rcx, rbp
	jbe	362f
	cmp	r9, 16
	mov	rax, r8
	jb	342f
	mov	rax, qword ptr [rsp + 8]
	lea	r10, [r8 + rax]
	mov	rax, rdi
	sub	rax, r10
	add	rax, 575
	cmp	rax, 127
	mov	rax, r8
	jb	342f
	cmp	r9, 128
	jae	302f
	xor	ebx, ebx
	jmp	322f
292:
	add	r8, qword ptr [rsp + 8]
	mov	rcx, r8
	jmp	362f
302:
	mov	qword ptr [rsp + 112], r14
	mov	rbx, r9
	and	rbx, -128
	lea	rax, [r8 + rbx]
	mov	rcx, qword ptr [rsp + 8]
	lea	rcx, [rcx + r8 + 96]
	xor	r14d, r14d
	.p2align	4
312:
	vmovdqu	ymm2, ymmword ptr [rcx + r14 - 96]
	vmovdqu	ymm6, ymmword ptr [rcx + r14 - 64]
	vmovdqu	ymm7, ymmword ptr [rcx + r14 - 32]
	vmovdqu	ymm9, ymmword ptr [rcx + r14]
	vmovdqu	ymmword ptr [rdi + r14 + 576], ymm2
	vmovdqu	ymmword ptr [rdi + r14 + 608], ymm6
	vmovdqu	ymmword ptr [rdi + r14 + 640], ymm7
	vmovdqu	ymmword ptr [rdi + r14 + 672], ymm9
	sub	r14, -128
	cmp	rbx, r14
	jne	312b
	cmp	r9, rbx
	mov	rcx, rbp
	mov	r14, qword ptr [rsp + 112]
	je	362f
	test	r9b, 112
	je	342f
322:
	mov	rcx, r9
	and	rcx, -16
	lea	rax, [r8 + rcx]
	.p2align	4
332:
	vmovdqu	xmm2, xmmword ptr [r10 + rbx]
	vmovdqu	xmmword ptr [rbp + rbx], xmm2
	add	rbx, 16
	cmp	rcx, rbx
	jne	332b
	cmp	r9, rcx
	mov	rcx, rbp
	je	362f
342:
	mov	rcx, rbp
	sub	rcx, r8
	mov	r9, qword ptr [rsp + 8]
	mov	r10, qword ptr [rsp + 32]
	.p2align	4
352:
	movzx	r8d, byte ptr [r9 + rax]
	mov	byte ptr [rcx + rax], r8b
	inc	rax
	cmp	r10, rax
	jne	352b
	mov	rcx, rbp
362:
	vmovdqu	ymm2, ymmword ptr [rcx]
	vmovdqu	ymm6, ymmword ptr [rcx + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm9, ymm7, ymm11
	vpshufb	ymm14, ymm2, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 682f]
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
	vpbroadcastb	ymm0, byte ptr [rip + 692f]
	vpand	ymm4, ymm4, ymm0
	vpcmpeqb	ymm4, ymm4, ymm0
	vpblendvb	ymm2, ymm2, ymm6, ymm4
	vpand	ymm4, ymm11, ymm0
	vpcmpeqb	ymm4, ymm4, ymm0
	vpblendvb	ymm4, ymm9, ymm10, ymm4
	vpsrlvd	ymm2, ymm2, ymm5
	vmovdqu	ymm0, ymmword ptr [rsp + 304]
	vpandn	ymm2, ymm0, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 368]
	vpsrlvd	ymm3, ymm4, ymm13
	vmovdqu	ymm0, ymmword ptr [rsp + 336]
	vpandn	ymm0, ymm0, ymm3
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 80]
	vpor	ymm3, ymm0, ymmword ptr [rip + 702f]
	vpcmpeqd	ymm0, ymm0, ymm7
	vpandn	ymm0, ymm0, ymm3
	vpor	ymm3, ymm2, ymmword ptr [rip + 712f]
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
	add	r14, rax
	cmp	qword ptr [rsp + 400], 49
	jb	452f
	mov	rax, qword ptr [rsp + 176]
	mov	rcx, qword ptr [rsp + 168]
	sub	rcx, rax
	xor	rax, r11
	shl	rax, 7
	or	rax, rcx
	vmovq	xmm0, rax
	vmovdqa	xmm2, xmmword ptr [rsp + 592]
	vpshufb	xmm0, xmm2, xmm0
	mov	rax, qword ptr [rsp + 16]
	mov	rcx, qword ptr [rsp + 272]
	sub	rax, rcx
	xor	r11, rcx
	shl	r11, 7
	or	r11, rax
	vmovq	xmm2, r11
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
	vmovdqu	ymmword ptr [rsp + 112], ymm2
	vpsllvd	ymm0, ymm0, ymm4
	vmovdqu	ymmword ptr [rsp + 272], ymm0
	vpsllvd	ymm0, ymm8, ymm5
	vmovdqu	ymmword ptr [rsp + 400], ymm0
	vpsllvd	ymm0, ymm8, ymm4
	vmovdqu	ymmword ptr [rsp + 80], ymm0
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
	mov	eax, r14d
	and	eax, 7
	vmovd	xmm4, eax
	vpbroadcastd	ymm4, xmm4
	vpaddd	ymm5, ymm4, ymm5
	vpaddd	ymm2, ymm4, ymm2
	vpsrld	ymm4, ymm5, 3
	vpsrld	ymm6, ymm2, 3
	vpand	ymm13, ymm9, ymm5
	vpand	ymm5, ymm9, ymm2
	vbroadcasti128	ymm7, xmmword ptr [rip + 672f]
	vpshufb	ymm2, ymm4, ymm7
	vpshufb	ymm4, ymm6, ymm7
	vmovdqu	ymm6, ymmword ptr [rsp + 464]
	vpaddb	ymm11, ymm2, ymm6
	vpaddb	ymm4, ymm4, ymm6
	mov	r8, r14
	shr	r8, 3
	lea	rax, [r8 + 64]
	mov	r9, qword ptr [rsp + 32]
	cmp	rax, r9
	jbe	372f
	sub	r9, r8
	mov	rcx, rbp
	mov	rbx, qword ptr [rsp + 8]
	jbe	442f
	cmp	r9, 16
	mov	rax, r8
	jb	422f
	lea	r10, [r8 + rbx]
	mov	rax, rdi
	sub	rax, r10
	add	rax, 575
	cmp	rax, 127
	mov	rax, r8
	jb	422f
	cmp	r9, 128
	jae	382f
	xor	r11d, r11d
	jmp	402f
372:
	mov	rcx, qword ptr [rsp + 8]
	add	rcx, r8
	jmp	442f
382:
	mov	r11, r9
	and	r11, -128
	lea	rax, [r8 + r11]
	lea	rcx, [rbx + r8 + 96]
	xor	ebx, ebx
	.p2align	4
392:
	vmovdqu	ymm2, ymmword ptr [rcx + rbx - 96]
	vmovdqu	ymm6, ymmword ptr [rcx + rbx - 64]
	vmovdqu	ymm7, ymmword ptr [rcx + rbx - 32]
	vmovdqu	ymm9, ymmword ptr [rcx + rbx]
	vmovdqu	ymmword ptr [rdi + rbx + 576], ymm2
	vmovdqu	ymmword ptr [rdi + rbx + 608], ymm6
	vmovdqu	ymmword ptr [rdi + rbx + 640], ymm7
	vmovdqu	ymmword ptr [rdi + rbx + 672], ymm9
	sub	rbx, -128
	cmp	r11, rbx
	jne	392b
	cmp	r9, r11
	mov	rcx, rbp
	mov	rbx, qword ptr [rsp + 8]
	je	442f
	test	r9b, 112
	je	422f
402:
	mov	rcx, r9
	and	rcx, -16
	lea	rax, [r8 + rcx]
	.p2align	4
412:
	vmovdqu	xmm2, xmmword ptr [r10 + r11]
	vmovdqu	xmmword ptr [rbp + r11], xmm2
	add	r11, 16
	cmp	rcx, r11
	jne	412b
	cmp	r9, rcx
	mov	rcx, rbp
	je	442f
422:
	mov	rcx, rbp
	sub	rcx, r8
	mov	r9, qword ptr [rsp + 32]
	.p2align	4
432:
	movzx	r8d, byte ptr [rbx + rax]
	mov	byte ptr [rcx + rax], r8b
	inc	rax
	cmp	r9, rax
	jne	432b
	mov	rcx, rbp
442:
	vmovdqu	ymm2, ymmword ptr [rcx]
	vmovdqu	ymm6, ymmword ptr [rcx + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm9, ymm7, ymm11
	vpshufb	ymm14, ymm2, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 682f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 692f]
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm2, ymm2, ymm6, ymm4
	vpand	ymm4, ymm11, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm4, ymm9, ymm8, ymm4
	vpsrlvd	ymm2, ymm2, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 80]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 272]
	vpsrlvd	ymm3, ymm4, ymm13
	vmovdqu	ymm4, ymmword ptr [rsp + 400]
	vpandn	ymm3, ymm4, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 112]
	vpor	ymm4, ymm3, ymmword ptr [rip + 702f]
	vpcmpeqd	ymm3, ymm3, ymm7
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 712f]
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
	add	r14, rax
452:
	mov	rcx, qword ptr [rsp + 24]
	mov	r10, qword ptr [rsp + 16]
462:
	shr	r10, 56
	mov	r9, qword ptr [rsp + 40]
	add	r9, r10
	mov	rax, qword ptr [rsp + 240]
	shr	rax, 56
	mov	r8, qword ptr [rsp + 48]
	add	r8, rax
	vmovd	eax, xmm1
	mov	qword ptr [rdi + 72], r14
	mov	qword ptr [rdi + 96], rax
	mov	qword ptr [rdi + 128], r8
	mov	qword ptr [rdi + 136], r9
	xor	eax, eax
	mov	rbp, qword ptr [rsp + 264]
	.p2align	4
472:
	movzx	r10d, byte ptr [rdi + rax + 512]
	movzx	r8d, byte ptr [rdi + rax + 192]
	cmp	r8, 33
	mov	r9d, dword ptr [rdi + 4*rax + 256]
	vmovdqu	ymm0, ymmword ptr [rsi]
	vmovdqu	ymmword ptr [rdx], ymm0
	jae	512f
482:
	add	rdx, r8
	mov	r11d, r10d
	shr	r11d, 2
	cmp	r9, r11
	jb	562f
	mov	rbx, rdx
	sub	rbx, r9
	cmp	rbx, r15
	jl	562f
	vmovdqu	ymm0, ymmword ptr [rbx]
492:
	vmovdqu	ymmword ptr [rdx], ymm0
	cmp	r10b, -124
	jae	532f
502:
	add	rdx, r11
	add	rsi, r8
	inc	rax
	cmp	rax, r12
	jne	472b
	jmp	2b
512:
	mov	rcx, qword ptr [rdi + 48]
	mov	r11, qword ptr [rdi + 120]
	movzx	r8d, byte ptr [rcx + r11]
	inc	r11
	mov	qword ptr [rdi + 120], r11
	add	r8, 33
	mov	ecx, 32
	.p2align	4
522:
	vmovdqu	ymm0, ymmword ptr [rsi + rcx]
	vmovdqu	ymmword ptr [rdx + rcx], ymm0
	add	rcx, 32
	cmp	rcx, r8
	jb	522b
	mov	rcx, qword ptr [rsp + 24]
	jmp	482b
532:
	cmp	r9, 31
	ja	542f
	mov	qword ptr [rdi + 104], 1
542:
	mov	rcx, qword ptr [rdi + 48]
	mov	r9, qword ptr [rdi + 120]
	movzx	r11d, byte ptr [rcx + r9]
	inc	r9
	mov	qword ptr [rdi + 120], r9
	add	r11, 33
	mov	ecx, 32
	.p2align	4
552:
	vmovdqu	ymm0, ymmword ptr [rbx + rcx]
	vmovdqu	ymmword ptr [rdx + rcx], ymm0
	add	rcx, 32
	cmp	rcx, r11
	jb	552b
	mov	rcx, qword ptr [rsp + 24]
	jmp	502b
562:
	mov	rbx, rdx
	sub	rbx, r15
	cmp	r9, rbx
	cmovae	r9, rbx
	sub	rbx, r9
	cmp	r9, r11
	jae	572f
	mov	rcx, qword ptr [rdi + 56]
	mov	r14, r9
	shl	r14, 5
	vmovdqu	ymm0, ymmword ptr [rcx + r14 + 2048]
	mov	rcx, qword ptr [rsp + 24]
	vmovdqu	ymm1, ymmword ptr [r15 + rbx]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	add	rbx, r15
	jmp	492b
572:
	vmovdqu	ymm0, ymmword ptr [r15 + rbx]
	add	rbx, r15
	jmp	492b
582:
	sub	rdx, r15
	sub	rsi, qword ptr [rsp + 152]
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
592:
	.long	1
	.p2align	2, 0x0
602:
	.long	7
	.p2align	2, 0x0
612:
	.long	8
	.p2align	2, 0x0
622:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	2, 0x0
632:
	.long	134217727
	.p2align	5, 0x0
642:
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
652:
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
662:
	.byte	1
	.p2align	4, 0x0
672:
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
682:
	.byte	16
	.p2align	2, 0x0
692:
	.byte	32
	.p2align	5, 0x0
702:
	.long	1207959552
	.long	1342177280
	.long	1476395008
	.long	1610612736
	.long	1744830464
	.long	1879048192
	.long	2013265920
	.long	2147483648
	.p2align	5, 0x0
712:
	.long	134217728
	.long	268435456
	.long	402653184
	.long	536870912
	.long	671088640
	.long	805306368
	.long	939524096
	.long	1073741824

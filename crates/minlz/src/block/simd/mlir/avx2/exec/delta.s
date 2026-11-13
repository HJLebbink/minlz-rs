# minlz_exec_delta of crates/minlz/mlir/exec64.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 664
	mov	r13, qword ptr [rdi]
	mov	rax, qword ptr [rdi + 8]
	mov	rcx, qword ptr [rdi + 64]
	mov	rdx, qword ptr [rdi + 80]
	add	rdx, r13
	mov	rsi, qword ptr [rdi + 88]
	mov	qword ptr [rsp + 192], rax
	add	rsi, rax
	test	rcx, rcx
	jle	612f
	mov	r12, qword ptr [rdi + 96]
	lea	rax, [rdi + 512]
	mov	r8d, 96
	mov	qword ptr [rsp + 64], r8
	mov	ebp, 7
	mov	qword ptr [rsp + 72], 0
	vpxor	xmm7, xmm7, xmm7
	vbroadcastss	ymm0, dword ptr [rip + 622f]
	vmovups	ymmword ptr [rsp + 528], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 632f]
	vmovups	ymmword ptr [rsp + 496], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 642f]
	vmovups	ymmword ptr [rsp + 464], ymm0
	vbroadcastss	ymm0, dword ptr [rip + 652f]
	vmovups	ymmword ptr [rsp + 432], ymm0
	vpbroadcastd	ymm0, dword ptr [rip + 662f]
	vmovdqu	ymmword ptr [rsp + 400], ymm0
	mov	r8, rax
	mov	r10, rcx
	xor	r9d, r9d
	mov	qword ptr [rsp + 40], r13
	mov	qword ptr [rsp + 200], rcx
	jmp	12f
	.p2align	4
2:
	mov	r10, qword ptr [rsp + 296]
	add	r10, -64
	inc	qword ptr [rsp + 72]
	add	qword ptr [rsp + 64], 64
	add	rbp, -64
	mov	r8, qword ptr [rsp + 88]
	add	r8, -64
	mov	rcx, qword ptr [rsp + 200]
	mov	r9, qword ptr [rsp + 288]
	cmp	r9, rcx
	mov	r12, rax
	jge	612f
12:
	mov	qword ptr [rsp + 88], r8
	cmp	r10, 1
	mov	qword ptr [rsp + 296], r10
	adc	r10, 0
	cmp	r10, 64
	mov	eax, 64
	cmovae	r10, rax
	mov	qword ptr [rsp + 32], r10
	sub	rcx, r9
	cmp	rcx, 64
	mov	r11d, 64
	mov	qword ptr [rsp + 368], rcx
	cmovb	r11, rcx
	mov	r15, qword ptr [rdi + 16]
	mov	rax, qword ptr [rdi + 24]
	mov	qword ptr [rsp + 96], rax
	mov	rax, qword ptr [rdi + 32]
	mov	qword ptr [rsp + 304], rax
	mov	r14, qword ptr [rdi + 40]
	mov	rax, qword ptr [rdi + 64]
	mov	rcx, qword ptr [rdi + 72]
	mov	qword ptr [rsp + 8], rcx
	mov	rcx, qword ptr [rdi + 96]
	mov	qword ptr [rsp + 128], rcx
	mov	rcx, qword ptr [rdi + 112]
	mov	qword ptr [rsp + 16], rcx
	mov	rcx, qword ptr [rdi + 128]
	mov	qword ptr [rsp + 56], rcx
	mov	rcx, qword ptr [rdi + 136]
	mov	qword ptr [rsp + 48], rcx
	lea	r13, [rax + 7]
	lea	rcx, [r9 + 64]
	mov	qword ptr [rsp + 288], rcx
	cmp	rcx, r13
	mov	qword ptr [rsp + 80], rbp
	mov	qword ptr [rsp], r14
	jbe	52f
	cmp	r9, r13
	lea	rcx, [rdi + 512]
	mov	r8, rcx
	jge	62f
	mov	r8, qword ptr [rsp + 72]
	shl	r8, 6
	mov	ebx, 7
	sub	rbx, r8
	add	rbx, rax
	cmp	rbx, 16
	jb	22f
	add	r8, r15
	mov	r10, rdi
	sub	r10, r8
	add	r10, 511
	cmp	r10, 127
	jae	82f
22:
	mov	rbx, r9
32:
	mov	r8, qword ptr [rsp + 88]
	.p2align	4
42:
	movzx	eax, byte ptr [r15 + rbx]
	mov	byte ptr [r8 + rbx], al
	inc	rbx
	cmp	r13, rbx
	jne	42b
	mov	r8, rcx
	jmp	62f
	.p2align	4
52:
	add	r15, r9
	mov	r8, r15
62:
	vmovdqu	ymm1, ymmword ptr [r8]
	vmovdqu	ymm15, ymmword ptr [r8 + 32]
	vmovd	xmm0, r11d
	vpbroadcastb	ymm3, xmm0
	vpmaxub	ymm0, ymm3, ymmword ptr [rip + 672f]
	vpcmpeqb	ymm0, ymm3, ymm0
	vpmaxub	ymm4, ymm3, ymmword ptr [rip + 682f]
	vpcmpeqb	ymm3, ymm3, ymm4
	vpsllw	ymm4, ymm15, 6
	vpcmpgtb	ymm4, ymm7, ymm4
	vpsllw	ymm5, ymm1, 6
	vpcmpgtb	ymm8, ymm7, ymm5
	vpbroadcastb	ymm2, byte ptr [rip + 692f]
	vpand	ymm5, ymm1, ymm2
	vpcmpeqb	ymm5, ymm5, ymm7
	movabs	r11, 72340172838076673
	#APP
	#NO_APP
	vpand	ymm4, ymm4, ymm2
	vpand	ymm4, ymm0, ymm4
	vpand	ymm8, ymm8, ymm2
	vpand	ymm8, ymm8, ymm3
	vmovq	rbp, xmm8
	vpextrq	r8, xmm8, 1
	vextracti128	xmm8, ymm8, 1
	vmovq	r9, xmm8
	vpextrq	r10, xmm8, 1
	vmovq	rax, xmm4
	vpextrq	r15, xmm4, 1
	vextracti128	xmm4, ymm4, 1
	vmovq	rbx, xmm4
	mov	r14, rbp
	imul	r14, r11
	mov	r13, r14
	sub	r13, rbp
	xor	rbp, r11
	shl	rbp, 7
	or	rbp, r13
	vpextrq	qword ptr [rsp + 160], xmm4, 1
	mov	r13, qword ptr [rsp + 96]
	mov	rcx, qword ptr [rsp + 56]
	vmovq	xmm4, qword ptr [r13 + rcx]
	vmovq	xmm8, rbp
	vpshufb	xmm4, xmm4, xmm8
	shr	r14, 56
	add	r14, rcx
	mov	rbp, r8
	imul	rbp, r11
	mov	rcx, rbp
	sub	rcx, r8
	xor	r8, r11
	shl	r8, 7
	or	r8, rcx
	vmovq	xmm8, qword ptr [r13 + r14]
	vmovq	xmm9, r8
	vpshufb	xmm8, xmm8, xmm9
	vpunpcklqdq	xmm4, xmm4, xmm8
	shr	rbp, 56
	add	rbp, r14
	mov	r8, r9
	imul	r8, r11
	mov	rcx, r8
	sub	rcx, r9
	xor	r9, r11
	shl	r9, 7
	or	r9, rcx
	vmovq	xmm8, qword ptr [r13 + rbp]
	vmovq	xmm9, r9
	vpshufb	xmm8, xmm8, xmm9
	shr	r8, 56
	add	r8, rbp
	mov	r9, r10
	imul	r9, r11
	mov	rcx, r9
	sub	rcx, r10
	xor	r10, r11
	shl	r10, 7
	or	r10, rcx
	vmovq	xmm9, qword ptr [r13 + r8]
	vmovq	xmm10, r10
	vpshufb	xmm9, xmm9, xmm10
	vpunpcklqdq	xmm8, xmm8, xmm9
	shr	r9, 56
	add	r9, r8
	mov	r8, rax
	imul	r8, r11
	mov	rcx, r8
	sub	rcx, rax
	xor	rax, r11
	shl	rax, 7
	or	rax, rcx
	vmovq	xmm9, qword ptr [r13 + r9]
	vmovq	xmm10, rax
	vpshufb	xmm9, xmm9, xmm10
	shr	r8, 56
	add	r8, r9
	mov	rax, r15
	imul	rax, r11
	mov	rcx, rax
	sub	rcx, r15
	xor	r15, r11
	shl	r15, 7
	or	r15, rcx
	vmovq	xmm10, qword ptr [r13 + r8]
	vmovq	xmm11, r15
	vpshufb	xmm10, xmm10, xmm11
	vpunpcklqdq	xmm9, xmm9, xmm10
	shr	rax, 56
	add	rax, r8
	mov	r8, rbx
	imul	r8, r11
	mov	rcx, r8
	sub	rcx, rbx
	xor	rbx, r11
	shl	rbx, 7
	or	rbx, rcx
	vmovq	xmm10, qword ptr [r13 + rax]
	vmovq	xmm11, rbx
	vpshufb	xmm10, xmm10, xmm11
	shr	r8, 56
	add	r8, rax
	mov	rcx, qword ptr [rsp + 160]
	mov	rax, rcx
	imul	rax, r11
	mov	qword ptr [rsp + 24], rax
	sub	rax, rcx
	xor	r11, rcx
	shl	r11, 7
	or	r11, rax
	mov	qword ptr [rsp + 56], r8
	vmovq	xmm11, qword ptr [r13 + r8]
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
	vmovq	r15, xmm3
	vpextrq	rax, xmm3, 1
	vextracti128	xmm3, ymm3, 1
	vmovq	rbx, xmm3
	mov	r9, r11
	imul	r9, r15
	mov	r8, r9
	shr	r8, 56
	mov	r13, qword ptr [rsp + 48]
	add	r8, r13
	mov	r10, r11
	imul	r10, rax
	mov	rcx, r10
	shr	rcx, 56
	add	rcx, r8
	mov	r14, r11
	mov	qword ptr [rsp + 264], rbx
	imul	r14, rbx
	mov	rbx, qword ptr [rsp + 304]
	vmovsd	xmm4, qword ptr [rbx + rcx]
	vmovaps	xmmword ptr [rsp + 624], xmm4
	mov	qword ptr [rsp + 272], r14
	shr	r14, 56
	add	r14, rcx
	vpextrq	rbp, xmm3, 1
	mov	rcx, r11
	mov	qword ptr [rsp + 256], rbp
	imul	rcx, rbp
	vmovsd	xmm3, qword ptr [rbx + r14]
	vmovaps	xmmword ptr [rsp + 640], xmm3
	mov	qword ptr [rsp + 280], rcx
	shr	rcx, 56
	add	rcx, r14
	vpand	ymm3, ymm15, ymm2
	vpcmpeqb	ymm3, ymm3, ymm7
	vpand	ymm3, ymm3, ymm2
	vpand	ymm0, ymm0, ymm3
	vmovq	r14, xmm0
	mov	rbp, r11
	mov	qword ptr [rsp + 240], r14
	imul	rbp, r14
	vmovsd	xmm2, qword ptr [rbx + rcx]
	vmovaps	xmmword ptr [rsp + 592], xmm2
	mov	qword ptr [rsp + 224], rbp
	mov	r14, rbp
	shr	r14, 56
	add	r14, rcx
	vpextrq	rcx, xmm0, 1
	mov	rbp, r11
	mov	qword ptr [rsp + 248], rcx
	imul	rbp, rcx
	vmovsd	xmm2, qword ptr [rbx + r14]
	vmovaps	xmmword ptr [rsp + 608], xmm2
	mov	qword ptr [rsp + 232], rbp
	mov	rcx, rbp
	shr	rcx, 56
	add	rcx, r14
	vextracti128	xmm4, ymm0, 1
	vmovq	r14, xmm4
	mov	rbp, r11
	mov	qword ptr [rsp + 216], r14
	imul	rbp, r14
	vmovsd	xmm0, qword ptr [rbx + rcx]
	vmovaps	xmmword ptr [rsp + 560], xmm0
	mov	qword ptr [rsp + 208], rbp
	mov	r14, rbp
	shr	r14, 56
	add	r14, rcx
	vmovq	xmm0, qword ptr [rbx + r13]
	vmovq	xmm3, qword ptr [rbx + r8]
	mov	qword ptr [rsp + 48], r14
	vmovsd	xmm2, qword ptr [rbx + r14]
	vmovaps	xmmword ptr [rsp + 576], xmm2
	vmovss	xmm5, dword ptr [rsp + 128]
	sub	r9, r15
	xor	r15, r11
	shl	r15, 7
	or	r15, r9
	vmovq	xmm9, r15
	sub	r10, rax
	xor	rax, r11
	shl	rax, 7
	or	rax, r10
	vmovq	xmm11, rax
	mov	rcx, qword ptr [rsp + 8]
	mov	eax, ecx
	and	eax, 7
	vmovd	xmm14, eax
	mov	r14, rcx
	shr	r14, 3
	lea	rax, [r14 + 64]
	mov	r8, qword ptr [rsp + 16]
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
	vmovdqu	ymm2, ymmword ptr [rsp + 528]
	vpmaxud	ymm9, ymm9, ymm2
	vpcmpeqd	ymm6, ymm6, ymm6
	vpaddd	ymm9, ymm9, ymm6
	vpmaxud	ymm5, ymm5, ymm2
	vpaddd	ymm5, ymm5, ymm6
	vmovdqu	ymm2, ymmword ptr [rsp + 496]
	vpand	ymm11, ymm3, ymm2
	vpand	ymm12, ymm0, ymm2
	vmovdqu	ymm8, ymmword ptr [rsp + 464]
	vpminud	ymm0, ymm0, ymm8
	vpminud	ymm3, ymm3, ymm8
	vpand	ymm3, ymm8, ymm3
	vpor	ymm3, ymm11, ymm3
	vpand	ymm0, ymm8, ymm0
	vpor	ymm11, ymm12, ymm0
	vpsllvd	ymm0, ymm3, ymm5
	vmovdqu	ymmword ptr [rsp + 128], ymm0
	vpsllvd	ymm0, ymm11, ymm9
	vmovdqu	ymmword ptr [rsp + 96], ymm0
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
	vmovdqu	ymmword ptr [rsp + 160], ymm0
	vpaddd	ymm15, ymm13, ymm11
	vpsubd	ymm11, ymm13, ymm9
	vpsllvd	ymm0, ymm6, ymm9
	vmovdqu	ymmword ptr [rsp + 336], ymm0
	vpsubd	ymm5, ymm15, ymm5
	vpbroadcastd	ymm9, xmm14
	vpaddd	ymm5, ymm9, ymm5
	vpaddd	ymm9, ymm11, ymm9
	vpsrld	ymm14, ymm5, 3
	vpextrq	qword ptr [rsp + 304], xmm4, 1
	vpsrld	ymm4, ymm9, 3
	vpand	ymm5, ymm5, ymm2
	vpand	ymm11, ymm9, ymm2
	vbroadcasti128	ymm0, xmmword ptr [rip + 702f]
	vpshufb	ymm9, ymm14, ymm0
	vpshufb	ymm14, ymm4, ymm0
	vmovdqu	ymm0, ymmword ptr [rsp + 432]
	vpaddb	ymm4, ymm9, ymm0
	vpaddb	ymm9, ymm14, ymm0
	jbe	72f
	mov	rax, r8
	sub	rax, r14
	lea	rbp, [rdi + 576]
	mov	r15, rbp
	jbe	152f
	cmp	rax, 16
	mov	r8, r14
	jb	132f
	mov	rcx, qword ptr [rsp]
	lea	r10, [r14 + rcx]
	mov	rcx, rdi
	sub	rcx, r10
	add	rcx, 575
	cmp	rcx, 127
	mov	rcx, qword ptr [rsp + 8]
	mov	r8, r14
	jb	132f
	cmp	rax, 128
	jae	92f
	xor	r9d, r9d
	jmp	112f
	.p2align	4
72:
	add	r14, qword ptr [rsp]
	mov	r15, r14
	lea	rbp, [rdi + 576]
	jmp	152f
82:
	cmp	rbx, 128
	mov	qword ptr [rsp + 24], rbx
	jae	182f
	xor	r10d, r10d
	jmp	202f
92:
	mov	r9, rax
	and	r9, -128
	lea	r8, [r14 + r9]
	mov	r15, qword ptr [rsp]
	lea	r15, [r15 + r14 + 96]
	xor	ebp, ebp
	.p2align	4
102:
	vmovdqu	ymm14, ymmword ptr [r15 + rbp - 96]
	vmovdqu	ymm8, ymmword ptr [r15 + rbp - 64]
	vmovdqu	ymm10, ymmword ptr [r15 + rbp - 32]
	vmovdqu	ymm6, ymmword ptr [r15 + rbp]
	vmovdqu	ymmword ptr [rdi + rbp + 576], ymm14
	vmovdqu	ymmword ptr [rdi + rbp + 608], ymm8
	vmovdqu	ymmword ptr [rdi + rbp + 640], ymm10
	vmovdqu	ymmword ptr [rdi + rbp + 672], ymm6
	sub	rbp, -128
	cmp	r9, rbp
	jne	102b
	cmp	rax, r9
	lea	rbp, [rdi + 576]
	mov	r15, rbp
	je	152f
	test	al, 112
	je	132f
112:
	mov	r15, rax
	and	r15, -16
	lea	r8, [r14 + r15]
	.p2align	4
122:
	vmovdqu	xmm6, xmmword ptr [r10 + r9]
	vmovdqu	xmmword ptr [rbp + r9], xmm6
	add	r9, 16
	cmp	r15, r9
	jne	122b
	cmp	rax, r15
	mov	r15, rbp
	je	152f
	.p2align	4
132:
	mov	rax, rbp
	sub	rax, r14
	mov	r9, qword ptr [rsp]
	mov	r10, qword ptr [rsp + 16]
	.p2align	4
142:
	movzx	ecx, byte ptr [r9 + r8]
	mov	byte ptr [rax + r8], cl
	inc	r8
	cmp	r10, r8
	jne	142b
	mov	r15, rbp
	mov	rcx, qword ptr [rsp + 8]
152:
	vmovdqu	ymm6, ymmword ptr [r15]
	vmovdqu	ymm8, ymmword ptr [r15 + 32]
	vpermq	ymm10, ymm6, 68
	vpermq	ymm6, ymm6, 238
	vpshufb	ymm14, ymm10, ymm4
	vpshufb	ymm7, ymm6, ymm4
	vpbroadcastb	ymm13, byte ptr [rip + 712f]
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
	vpbroadcastb	ymm8, byte ptr [rip + 722f]
	vpand	ymm6, ymm9, ymm8
	vpcmpeqb	ymm6, ymm8, ymm6
	vpblendvb	ymm2, ymm2, ymm3, ymm6
	vpand	ymm3, ymm8, ymm4
	vpcmpeqb	ymm3, ymm8, ymm3
	vpblendvb	ymm0, ymm7, ymm0, ymm3
	vpxor	xmm7, xmm7, xmm7
	vpsrlvd	ymm2, ymm2, ymm11
	vmovdqu	ymm3, ymmword ptr [rsp + 336]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 96]
	vpsrlvd	ymm0, ymm0, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 160]
	vpandn	ymm0, ymm3, ymm0
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 128]
	vpor	ymm3, ymm0, ymmword ptr [rip + 732f]
	vpcmpeqd	ymm0, ymm0, ymm7
	vpandn	ymm0, ymm0, ymm3
	vpor	ymm3, ymm2, ymmword ptr [rip + 742f]
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
	vmovdqu	ymm4, ymmword ptr [rsp + 400]
	vpand	ymm2, ymm0, ymm4
	vpcmpeqd	ymm0, ymm0, ymm7
	vblendvps	ymm0, ymm2, ymm1, ymm0
	vpand	ymm2, ymm3, ymm4
	vpcmpeqd	ymm3, ymm3, ymm7
	vblendvps	ymm1, ymm2, ymm1, ymm3
	vextracti128	xmm2, ymm15, 1
	vpextrd	eax, xmm2, 3
	vmovups	ymmword ptr [rdi + 256], ymm1
	mov	r8, r11
	imul	r8, qword ptr [rsp + 304]
	vmovups	ymmword ptr [rdi + 288], ymm0
	vshufps	ymm0, ymm0, ymm0, 255
	vpermpd	ymm1, ymm0, 170
	add	rcx, rax
	cmp	qword ptr [rsp + 368], 17
	jb	162f
	mov	qword ptr [rsp + 8], r8
	mov	rax, qword ptr [rsp + 272]
	mov	r8, qword ptr [rsp + 264]
	sub	rax, r8
	xor	r8, r11
	shl	r8, 7
	or	r8, rax
	vmovq	xmm0, r8
	vmovdqa	xmm2, xmmword ptr [rsp + 624]
	vpshufb	xmm0, xmm2, xmm0
	mov	rax, qword ptr [rsp + 280]
	mov	r8, qword ptr [rsp + 256]
	sub	rax, r8
	xor	r8, r11
	shl	r8, 7
	or	r8, rax
	vmovq	xmm2, r8
	vmovdqa	xmm3, xmmword ptr [rsp + 640]
	vpshufb	xmm2, xmm3, xmm2
	vpunpcklqdq	xmm0, xmm0, xmm2
	vpshufd	xmm2, xmm0, 238
	vpmovzxbd	ymm2, xmm2
	vpmovzxbd	ymm0, xmm0
	vpsrld	ymm3, ymm0, 3
	vpsrld	ymm4, ymm2, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 528]
	vpmaxud	ymm4, ymm4, ymm5
	vpcmpeqd	ymm7, ymm7, ymm7
	vpaddd	ymm4, ymm4, ymm7
	vpmaxud	ymm3, ymm3, ymm5
	vpaddd	ymm5, ymm3, ymm7
	vmovdqu	ymm9, ymmword ptr [rsp + 496]
	vpand	ymm3, ymm9, ymm0
	vpand	ymm6, ymm9, ymm2
	vmovdqu	ymm8, ymmword ptr [rsp + 464]
	vpminud	ymm2, ymm2, ymm8
	vpminud	ymm0, ymm0, ymm8
	vpand	ymm0, ymm8, ymm0
	vpor	ymm0, ymm0, ymm3
	vpand	ymm2, ymm8, ymm2
	vpor	ymm2, ymm2, ymm6
	vpsllvd	ymm0, ymm0, ymm5
	vmovdqu	ymmword ptr [rsp + 96], ymm0
	vpsllvd	ymm0, ymm2, ymm4
	vmovdqu	ymmword ptr [rsp + 128], ymm0
	vpsllvd	ymm0, ymm7, ymm5
	vmovdqu	ymmword ptr [rsp + 336], ymm0
	vpsllvd	ymm0, ymm7, ymm4
	vmovdqu	ymmword ptr [rsp + 160], ymm0
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
	vbroadcasti128	ymm0, xmmword ptr [rip + 702f]
	vpshufb	ymm2, ymm6, ymm0
	vpshufb	ymm4, ymm7, ymm0
	vmovdqu	ymm0, ymmword ptr [rsp + 432]
	vpaddb	ymm11, ymm2, ymm0
	vpaddb	ymm4, ymm4, ymm0
	mov	rbx, rcx
	mov	rax, rcx
	shr	rax, 3
	lea	rcx, [rax + 64]
	mov	r8, qword ptr [rsp + 16]
	cmp	rcx, r8
	mov	r15, qword ptr [rsp + 32]
	jbe	172f
	sub	r8, rax
	mov	r14, rbp
	mov	r13, qword ptr [rsp + 40]
	mov	rcx, rbx
	jbe	282f
	cmp	r8, 16
	mov	r10, rax
	jb	262f
	mov	rcx, qword ptr [rsp]
	lea	r9, [rax + rcx]
	mov	rcx, rdi
	sub	rcx, r9
	add	rcx, 575
	cmp	rcx, 127
	mov	rcx, rbx
	mov	r10, rax
	jb	262f
	cmp	r8, 128
	jae	222f
	xor	ebx, ebx
	jmp	242f
	.p2align	4
162:
	mov	r13, qword ptr [rsp + 40]
	mov	r15, qword ptr [rsp + 32]
	jmp	462f
	.p2align	4
172:
	add	rax, qword ptr [rsp]
	mov	r14, rax
	mov	r13, qword ptr [rsp + 40]
	mov	rcx, rbx
	jmp	282f
182:
	mov	r10, rbx
	and	r10, -128
	lea	rbx, [r9 + r10]
	mov	r8, qword ptr [rsp + 64]
	add	r8, r15
	lea	r14, [rax + rbp]
	and	r14, -128
	xor	ebp, ebp
	.p2align	4
192:
	vmovdqu	ymm0, ymmword ptr [r8 + rbp - 96]
	vmovdqu	ymm1, ymmword ptr [r8 + rbp - 64]
	vmovups	ymm3, ymmword ptr [r8 + rbp - 32]
	vmovdqu	ymm4, ymmword ptr [r8 + rbp]
	vmovdqu	ymmword ptr [rdi + rbp + 512], ymm0
	vmovdqu	ymmword ptr [rdi + rbp + 544], ymm1
	vmovups	ymmword ptr [rdi + rbp + 576], ymm3
	vmovdqu	ymmword ptr [rdi + rbp + 608], ymm4
	sub	rbp, -128
	cmp	r14, rbp
	jne	192b
	cmp	qword ptr [rsp + 24], r10
	mov	r8, rcx
	mov	rbp, qword ptr [rsp + 80]
	je	62b
	test	byte ptr [rsp + 24], 112
	je	32b
202:
	mov	r8, qword ptr [rsp + 24]
	and	r8, -16
	lea	rbx, [r15 + r9]
	add	r9, r8
	add	rax, rbp
	and	rax, -16
	.p2align	4
212:
	vmovdqu	xmm0, xmmword ptr [rbx + r10]
	vmovdqu	xmmword ptr [rcx + r10], xmm0
	add	r10, 16
	cmp	rax, r10
	jne	212b
	cmp	qword ptr [rsp + 24], r8
	mov	rbx, r9
	mov	r8, rcx
	je	62b
	jmp	32b
222:
	mov	rbx, r8
	and	rbx, -128
	lea	r10, [rax + rbx]
	mov	r14, qword ptr [rsp]
	lea	r14, [r14 + rax + 96]
	xor	r15d, r15d
	.p2align	4
232:
	vmovdqu	ymm2, ymmword ptr [r14 + r15 - 96]
	vmovdqu	ymm6, ymmword ptr [r14 + r15 - 64]
	vmovdqu	ymm7, ymmword ptr [r14 + r15 - 32]
	vmovdqu	ymm9, ymmword ptr [r14 + r15]
	vmovdqu	ymmword ptr [rdi + r15 + 576], ymm2
	vmovdqu	ymmword ptr [rdi + r15 + 608], ymm6
	vmovdqu	ymmword ptr [rdi + r15 + 640], ymm7
	vmovdqu	ymmword ptr [rdi + r15 + 672], ymm9
	sub	r15, -128
	cmp	rbx, r15
	jne	232b
	cmp	r8, rbx
	mov	r14, rbp
	mov	r15, qword ptr [rsp + 32]
	je	282f
	test	r8b, 112
	je	262f
242:
	mov	r14, r8
	and	r14, -16
	lea	r10, [rax + r14]
	.p2align	4
252:
	vmovdqu	xmm2, xmmword ptr [r9 + rbx]
	vmovdqu	xmmword ptr [rbp + rbx], xmm2
	add	rbx, 16
	cmp	r14, rbx
	jne	252b
	cmp	r8, r14
	mov	r14, rbp
	je	282f
262:
	mov	r8, rbp
	sub	r8, rax
	mov	r9, qword ptr [rsp]
	mov	rbx, qword ptr [rsp + 16]
	.p2align	4
272:
	movzx	eax, byte ptr [r9 + r10]
	mov	byte ptr [r8 + r10], al
	inc	r10
	cmp	rbx, r10
	jne	272b
	mov	r14, rbp
282:
	vmovdqu	ymm2, ymmword ptr [r14]
	vmovdqu	ymm6, ymmword ptr [r14 + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm9, ymm7, ymm11
	vpshufb	ymm13, ymm2, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 712f]
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
	vpbroadcastb	ymm0, byte ptr [rip + 722f]
	vpand	ymm4, ymm4, ymm0
	vpcmpeqb	ymm4, ymm4, ymm0
	vpblendvb	ymm2, ymm2, ymm6, ymm4
	vpand	ymm4, ymm11, ymm0
	vpcmpeqb	ymm4, ymm4, ymm0
	vpblendvb	ymm4, ymm9, ymm10, ymm4
	vpsrlvd	ymm2, ymm2, ymm5
	vmovdqu	ymm0, ymmword ptr [rsp + 336]
	vpandn	ymm2, ymm0, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 96]
	vpsrlvd	ymm3, ymm4, ymm12
	vmovdqu	ymm0, ymmword ptr [rsp + 160]
	vpandn	ymm0, ymm0, ymm3
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 128]
	vpor	ymm3, ymm0, ymmword ptr [rip + 732f]
	vpcmpeqd	ymm0, ymm0, ymm7
	vpandn	ymm0, ymm0, ymm3
	vpor	ymm3, ymm2, ymmword ptr [rip + 742f]
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
	vmovdqu	ymm4, ymmword ptr [rsp + 400]
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
	cmp	qword ptr [rsp + 368], 33
	jb	452f
	mov	rax, qword ptr [rsp + 240]
	mov	r8, qword ptr [rsp + 224]
	sub	r8, rax
	xor	rax, r11
	shl	rax, 7
	or	rax, r8
	vmovq	xmm0, rax
	vmovdqa	xmm2, xmmword ptr [rsp + 592]
	vpshufb	xmm0, xmm2, xmm0
	mov	rax, qword ptr [rsp + 248]
	mov	r8, qword ptr [rsp + 232]
	sub	r8, rax
	xor	rax, r11
	shl	rax, 7
	or	rax, r8
	vmovq	xmm2, rax
	vmovdqa	xmm3, xmmword ptr [rsp + 608]
	vpshufb	xmm2, xmm3, xmm2
	vpunpcklqdq	xmm0, xmm0, xmm2
	vpshufd	xmm2, xmm0, 238
	vpmovzxbd	ymm2, xmm2
	vpmovzxbd	ymm0, xmm0
	vpsrld	ymm3, ymm0, 3
	vpsrld	ymm4, ymm2, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 528]
	vpmaxud	ymm4, ymm4, ymm5
	vpcmpeqd	ymm7, ymm7, ymm7
	vpaddd	ymm4, ymm4, ymm7
	vpmaxud	ymm3, ymm3, ymm5
	vpaddd	ymm5, ymm3, ymm7
	vmovdqu	ymm9, ymmword ptr [rsp + 496]
	vpand	ymm3, ymm9, ymm0
	vpand	ymm6, ymm9, ymm2
	vmovdqu	ymm8, ymmword ptr [rsp + 464]
	vpminud	ymm2, ymm2, ymm8
	vpminud	ymm0, ymm0, ymm8
	vpand	ymm0, ymm8, ymm0
	vpor	ymm0, ymm0, ymm3
	vpand	ymm2, ymm8, ymm2
	vpor	ymm2, ymm2, ymm6
	vpsllvd	ymm0, ymm0, ymm5
	vmovdqu	ymmword ptr [rsp + 96], ymm0
	vpsllvd	ymm0, ymm2, ymm4
	vmovdqu	ymmword ptr [rsp + 128], ymm0
	vpsllvd	ymm0, ymm7, ymm5
	vmovdqu	ymmword ptr [rsp + 336], ymm0
	vpsllvd	ymm0, ymm7, ymm4
	vmovdqu	ymmword ptr [rsp + 160], ymm0
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
	vbroadcasti128	ymm0, xmmword ptr [rip + 702f]
	vpshufb	ymm2, ymm6, ymm0
	vpshufb	ymm4, ymm7, ymm0
	vmovdqu	ymm0, ymmword ptr [rsp + 432]
	vpaddb	ymm11, ymm2, ymm0
	vpaddb	ymm4, ymm4, ymm0
	mov	rbx, rcx
	mov	rax, rcx
	shr	rax, 3
	lea	rcx, [rax + 64]
	mov	r8, qword ptr [rsp + 16]
	cmp	rcx, r8
	jbe	292f
	sub	r8, rax
	mov	r14, rbp
	mov	rcx, rbx
	jbe	362f
	cmp	r8, 16
	mov	r10, rax
	jb	342f
	mov	rcx, qword ptr [rsp]
	lea	r9, [rax + rcx]
	mov	rcx, rdi
	sub	rcx, r9
	add	rcx, 575
	cmp	rcx, 127
	mov	rcx, rbx
	mov	r10, rax
	jb	342f
	cmp	r8, 128
	jae	302f
	xor	ebx, ebx
	jmp	322f
292:
	add	rax, qword ptr [rsp]
	mov	r14, rax
	mov	rcx, rbx
	jmp	362f
302:
	mov	rbx, r8
	and	rbx, -128
	lea	r10, [rax + rbx]
	mov	r14, qword ptr [rsp]
	lea	r14, [r14 + rax + 96]
	xor	r15d, r15d
	.p2align	4
312:
	vmovdqu	ymm2, ymmword ptr [r14 + r15 - 96]
	vmovdqu	ymm6, ymmword ptr [r14 + r15 - 64]
	vmovdqu	ymm7, ymmword ptr [r14 + r15 - 32]
	vmovdqu	ymm9, ymmword ptr [r14 + r15]
	vmovdqu	ymmword ptr [rdi + r15 + 576], ymm2
	vmovdqu	ymmword ptr [rdi + r15 + 608], ymm6
	vmovdqu	ymmword ptr [rdi + r15 + 640], ymm7
	vmovdqu	ymmword ptr [rdi + r15 + 672], ymm9
	sub	r15, -128
	cmp	rbx, r15
	jne	312b
	cmp	r8, rbx
	mov	r14, rbp
	mov	r15, qword ptr [rsp + 32]
	je	362f
	test	r8b, 112
	je	342f
322:
	mov	r14, r8
	and	r14, -16
	lea	r10, [rax + r14]
	.p2align	4
332:
	vmovdqu	xmm2, xmmword ptr [r9 + rbx]
	vmovdqu	xmmword ptr [rbp + rbx], xmm2
	add	rbx, 16
	cmp	r14, rbx
	jne	332b
	cmp	r8, r14
	mov	r14, rbp
	je	362f
342:
	mov	r8, rbp
	sub	r8, rax
	mov	r9, qword ptr [rsp]
	mov	rbx, qword ptr [rsp + 16]
	.p2align	4
352:
	movzx	eax, byte ptr [r9 + r10]
	mov	byte ptr [r8 + r10], al
	inc	r10
	cmp	rbx, r10
	jne	352b
	mov	r14, rbp
362:
	vmovdqu	ymm2, ymmword ptr [r14]
	vmovdqu	ymm6, ymmword ptr [r14 + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm9, ymm7, ymm11
	vpshufb	ymm14, ymm2, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 712f]
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
	vpbroadcastb	ymm0, byte ptr [rip + 722f]
	vpand	ymm4, ymm4, ymm0
	vpcmpeqb	ymm4, ymm4, ymm0
	vpblendvb	ymm2, ymm2, ymm6, ymm4
	vpand	ymm4, ymm11, ymm0
	vpcmpeqb	ymm4, ymm4, ymm0
	vpblendvb	ymm4, ymm9, ymm10, ymm4
	vpsrlvd	ymm2, ymm2, ymm5
	vmovdqu	ymm0, ymmword ptr [rsp + 336]
	vpandn	ymm2, ymm0, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 96]
	vpsrlvd	ymm3, ymm4, ymm13
	vmovdqu	ymm0, ymmword ptr [rsp + 160]
	vpandn	ymm0, ymm0, ymm3
	vpaddd	ymm0, ymm0, ymmword ptr [rsp + 128]
	vpor	ymm3, ymm0, ymmword ptr [rip + 732f]
	vpcmpeqd	ymm0, ymm0, ymm7
	vpandn	ymm0, ymm0, ymm3
	vpor	ymm3, ymm2, ymmword ptr [rip + 742f]
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
	vmovdqu	ymm4, ymmword ptr [rsp + 400]
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
	cmp	qword ptr [rsp + 368], 49
	jb	452f
	mov	rax, qword ptr [rsp + 216]
	mov	r8, qword ptr [rsp + 208]
	sub	r8, rax
	xor	rax, r11
	shl	rax, 7
	or	rax, r8
	vmovq	xmm0, rax
	vmovdqa	xmm2, xmmword ptr [rsp + 560]
	vpshufb	xmm0, xmm2, xmm0
	mov	rax, qword ptr [rsp + 8]
	mov	r8, qword ptr [rsp + 304]
	sub	rax, r8
	xor	r11, r8
	shl	r11, 7
	or	r11, rax
	vmovq	xmm2, r11
	vmovdqa	xmm3, xmmword ptr [rsp + 576]
	vpshufb	xmm2, xmm3, xmm2
	vpmovzxbd	ymm0, xmm0
	vpmovzxbd	ymm2, xmm2
	vpsrld	ymm3, ymm2, 3
	vpsrld	ymm4, ymm0, 3
	vmovdqu	ymm5, ymmword ptr [rsp + 528]
	vpmaxud	ymm4, ymm4, ymm5
	vpcmpeqd	ymm8, ymm8, ymm8
	vpaddd	ymm4, ymm8, ymm4
	vpmaxud	ymm3, ymm3, ymm5
	vpaddd	ymm5, ymm8, ymm3
	vmovdqu	ymm9, ymmword ptr [rsp + 496]
	vpand	ymm3, ymm9, ymm2
	vpand	ymm6, ymm9, ymm0
	vmovdqu	ymm10, ymmword ptr [rsp + 464]
	vpminud	ymm0, ymm0, ymm10
	vpminud	ymm2, ymm2, ymm10
	vpand	ymm2, ymm10, ymm2
	vpor	ymm2, ymm2, ymm3
	vpand	ymm0, ymm10, ymm0
	vpor	ymm0, ymm0, ymm6
	vpsllvd	ymm2, ymm2, ymm5
	vmovdqu	ymmword ptr [rsp + 368], ymm2
	vpsllvd	ymm0, ymm0, ymm4
	vmovdqu	ymmword ptr [rsp + 128], ymm0
	vpsllvd	ymm0, ymm8, ymm5
	vmovdqu	ymmword ptr [rsp + 304], ymm0
	vpsllvd	ymm0, ymm8, ymm4
	vmovdqu	ymmword ptr [rsp + 96], ymm0
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
	vbroadcasti128	ymm7, xmmword ptr [rip + 702f]
	vpshufb	ymm2, ymm4, ymm7
	vpshufb	ymm4, ymm6, ymm7
	vmovdqu	ymm6, ymmword ptr [rsp + 432]
	vpaddb	ymm11, ymm2, ymm6
	vpaddb	ymm4, ymm4, ymm6
	mov	r11, rcx
	mov	rax, rcx
	shr	rax, 3
	lea	rcx, [rax + 64]
	mov	r8, qword ptr [rsp + 16]
	cmp	rcx, r8
	jbe	372f
	sub	r8, rax
	mov	rbx, rbp
	mov	rcx, r11
	mov	r14, qword ptr [rsp]
	jbe	442f
	cmp	r8, 16
	mov	r9, rax
	jb	422f
	lea	r10, [rax + r14]
	mov	rcx, rdi
	sub	rcx, r10
	add	rcx, 575
	cmp	rcx, 127
	mov	rcx, r11
	mov	r9, rax
	jb	422f
	cmp	r8, 128
	jae	382f
	xor	r11d, r11d
	jmp	402f
372:
	mov	rbx, qword ptr [rsp]
	add	rbx, rax
	mov	rcx, r11
	jmp	442f
382:
	mov	r11, r8
	and	r11, -128
	lea	r9, [rax + r11]
	lea	rbx, [r14 + rax + 96]
	xor	r14d, r14d
	.p2align	4
392:
	vmovdqu	ymm2, ymmword ptr [rbx + r14 - 96]
	vmovdqu	ymm6, ymmword ptr [rbx + r14 - 64]
	vmovdqu	ymm7, ymmword ptr [rbx + r14 - 32]
	vmovdqu	ymm9, ymmword ptr [rbx + r14]
	vmovdqu	ymmword ptr [rdi + r14 + 576], ymm2
	vmovdqu	ymmword ptr [rdi + r14 + 608], ymm6
	vmovdqu	ymmword ptr [rdi + r14 + 640], ymm7
	vmovdqu	ymmword ptr [rdi + r14 + 672], ymm9
	sub	r14, -128
	cmp	r11, r14
	jne	392b
	cmp	r8, r11
	mov	rbx, rbp
	mov	r14, qword ptr [rsp]
	je	442f
	test	r8b, 112
	je	422f
402:
	mov	rbx, r8
	and	rbx, -16
	lea	r9, [rax + rbx]
	.p2align	4
412:
	vmovdqu	xmm2, xmmword ptr [r10 + r11]
	vmovdqu	xmmword ptr [rbp + r11], xmm2
	add	r11, 16
	cmp	rbx, r11
	jne	412b
	cmp	r8, rbx
	mov	rbx, rbp
	je	442f
422:
	mov	r8, rbp
	sub	r8, rax
	mov	r10, qword ptr [rsp + 16]
	.p2align	4
432:
	movzx	eax, byte ptr [r14 + r9]
	mov	byte ptr [r8 + r9], al
	inc	r9
	cmp	r10, r9
	jne	432b
	mov	rbx, rbp
442:
	vmovdqu	ymm2, ymmword ptr [rbx]
	vmovdqu	ymm6, ymmword ptr [rbx + 32]
	vpermq	ymm7, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm9, ymm7, ymm11
	vpshufb	ymm14, ymm2, ymm11
	vpbroadcastb	ymm3, byte ptr [rip + 712f]
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
	vpbroadcastb	ymm3, byte ptr [rip + 722f]
	vpand	ymm4, ymm4, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm2, ymm2, ymm6, ymm4
	vpand	ymm4, ymm11, ymm3
	vpcmpeqb	ymm4, ymm4, ymm3
	vpblendvb	ymm4, ymm9, ymm8, ymm4
	vpsrlvd	ymm2, ymm2, ymm5
	vmovdqu	ymm3, ymmword ptr [rsp + 96]
	vpandn	ymm2, ymm3, ymm2
	vpaddd	ymm2, ymm2, ymmword ptr [rsp + 128]
	vpsrlvd	ymm3, ymm4, ymm13
	vmovdqu	ymm4, ymmword ptr [rsp + 304]
	vpandn	ymm3, ymm4, ymm3
	vpaddd	ymm3, ymm3, ymmword ptr [rsp + 368]
	vpor	ymm4, ymm3, ymmword ptr [rip + 732f]
	vpcmpeqd	ymm3, ymm3, ymm7
	vpandn	ymm3, ymm3, ymm4
	vpor	ymm4, ymm2, ymmword ptr [rip + 742f]
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
	vmovdqu	ymm5, ymmword ptr [rsp + 400]
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
452:
	mov	r8, qword ptr [rsp + 8]
462:
	shr	r8, 56
	mov	r9, qword ptr [rsp + 48]
	add	r9, r8
	mov	rax, qword ptr [rsp + 24]
	shr	rax, 56
	mov	r8, qword ptr [rsp + 56]
	add	r8, rax
	vmovd	eax, xmm1
	mov	qword ptr [rdi + 72], rcx
	mov	qword ptr [rdi + 96], rax
	mov	qword ptr [rdi + 128], r8
	mov	qword ptr [rdi + 136], r9
	xor	r8d, r8d
	mov	rbp, qword ptr [rsp + 80]
	.p2align	4
472:
	movzx	r10d, byte ptr [rdi + r8 + 512]
	movzx	r9d, byte ptr [rdi + r8 + 192]
	mov	eax, dword ptr [rdi + 4*r8 + 256]
	vmovdqu	ymm0, ymmword ptr [rsi]
	cmp	r12, 32
	jb	572f
	mov	r11, rdx
	sub	r11, r12
	cmp	r11, r13
	jl	572f
	vmovdqu	ymm1, ymmword ptr [r11]
482:
	vpaddb	ymm0, ymm1, ymm0
	vmovdqu	ymmword ptr [rdx], ymm0
	cmp	r9b, 33
	jae	522f
492:
	add	rdx, r9
	mov	r11d, r10d
	shr	r11d, 2
	cmp	rax, r11
	jb	582f
	mov	rbx, rdx
	sub	rbx, rax
	cmp	rbx, r13
	jl	582f
	vmovdqu	ymm0, ymmword ptr [rbx]
	mov	r14, rax
502:
	vmovdqu	ymmword ptr [rdx], ymm0
	cmp	r10b, -124
	jae	542f
512:
	add	rdx, r11
	add	rsi, r9
	inc	r8
	cmp	r8, r15
	mov	r12, rax
	jne	472b
	jmp	2b
522:
	mov	rcx, qword ptr [rdi + 48]
	mov	r11, qword ptr [rdi + 120]
	movzx	r9d, byte ptr [rcx + r11]
	inc	r11
	mov	qword ptr [rdi + 120], r11
	add	r9, 33
	mov	r11d, 32
	.p2align	4
532:
	vmovdqu	ymm0, ymmword ptr [rsi + r11]
	vmovdqu	ymmword ptr [rdx + r11], ymm0
	add	r11, 32
	cmp	r11, r9
	jb	532b
	jmp	492b
542:
	cmp	r14, 31
	ja	552f
	mov	qword ptr [rdi + 104], 1
552:
	mov	rcx, qword ptr [rdi + 48]
	mov	r10, qword ptr [rdi + 120]
	movzx	r11d, byte ptr [rcx + r10]
	inc	r10
	mov	qword ptr [rdi + 120], r10
	add	r11, 33
	mov	r10d, 32
	.p2align	4
562:
	vmovdqu	ymm0, ymmword ptr [rbx + r10]
	vmovdqu	ymmword ptr [rdx + r10], ymm0
	add	r10, 32
	cmp	r10, r11
	jb	562b
	jmp	512b
572:
	mov	r11, rdx
	sub	r11, r13
	cmp	r12, r11
	cmovae	r12, r11
	sub	r11, r12
	cmp	r12, 31
	jbe	592f
	vmovdqu	ymm1, ymmword ptr [r13 + r11]
	jmp	482b
582:
	mov	rbx, rdx
	sub	rbx, r13
	cmp	rax, rbx
	mov	r14, rbx
	cmovb	r14, rax
	sub	rbx, r14
	cmp	r14, r11
	jae	602f
	mov	rcx, qword ptr [rdi + 56]
	mov	r15, r14
	shl	r15, 5
	vmovdqu	ymm0, ymmword ptr [rcx + r15 + 2048]
	mov	r15, qword ptr [rsp + 32]
	vmovdqu	ymm1, ymmword ptr [r13 + rbx]
	vpermq	ymm2, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpshufb	ymm2, ymm2, ymm0
	vpshufb	ymm1, ymm1, ymm0
	vpsllw	ymm0, ymm0, 3
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	add	rbx, r13
	jmp	502b
592:
	mov	rcx, qword ptr [rdi + 56]
	shl	r12, 5
	vmovdqu	ymm1, ymmword ptr [rcx + r12 + 2048]
	vmovdqu	ymm2, ymmword ptr [r13 + r11]
	vpermq	ymm3, ymm2, 68
	vpermq	ymm2, ymm2, 238
	vpshufb	ymm3, ymm3, ymm1
	vpshufb	ymm2, ymm2, ymm1
	vpsllw	ymm1, ymm1, 3
	vpblendvb	ymm1, ymm3, ymm2, ymm1
	jmp	482b
602:
	vmovdqu	ymm0, ymmword ptr [r13 + rbx]
	add	rbx, r13
	jmp	502b
612:
	sub	rdx, r13
	sub	rsi, qword ptr [rsp + 192]
	mov	qword ptr [rdi + 80], rdx
	mov	qword ptr [rdi + 88], rsi
	add	rsp, 664
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	vzeroupper
	ret
	.p2align	2, 0x0
622:
	.long	1
	.p2align	2, 0x0
632:
	.long	7
	.p2align	2, 0x0
642:
	.long	8
	.p2align	2, 0x0
652:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	2, 0x0
662:
	.long	134217727
	.p2align	5, 0x0
672:
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
682:
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
692:
	.byte	1
	.p2align	4, 0x0
702:
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
712:
	.byte	16
	.p2align	2, 0x0
722:
	.byte	32
	.p2align	5, 0x0
732:
	.long	1207959552
	.long	1342177280
	.long	1476395008
	.long	1610612736
	.long	1744830464
	.long	1879048192
	.long	2013265920
	.long	2147483648
	.p2align	5, 0x0
742:
	.long	134217728
	.long	268435456
	.long	402653184
	.long	536870912
	.long	671088640
	.long	805306368
	.long	939524096
	.long	1073741824

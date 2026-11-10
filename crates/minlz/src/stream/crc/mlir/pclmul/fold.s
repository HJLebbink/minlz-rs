# minlz_crc32c_fold of crates/minlz/mlir/crc32c.mlir for pclmul, written by
# cargo xtask mlir. Do not edit.
	push	r15
	push	r14
	push	rbx
	mov	rcx, rdx
	movd	xmm6, edi
	movabs	rax, -1224287136463716352
	movq	xmm8, rax
	pclmulqdq	xmm6, xmm8, 0
	pxor	xmm4, xmm4
	mov	rax, rdx
	shr	rax, 8
	movabs	rdx, 2635249153387078803
	mul	rdx
	cmp	rcx, 1792
	movabs	rax, 7311508529481777152
	jae	2f
	pxor	xmm7, xmm7
	pxor	xmm3, xmm3
	pxor	xmm5, xmm5
	pxor	xmm1, xmm1
	pxor	xmm2, xmm2
	pxor	xmm0, xmm0
	jmp	32f
2:
	xor	edi, edi
	movdqa	xmm9, xmmword ptr [rip + 62f]
	movabs	r8, 8668591446237904896
	movdqa	xmm10, xmmword ptr [rip + 72f]
	movabs	r9, 4449734295027712000
	mov	r10, rsi
	pxor	xmm7, xmm7
	pxor	xmm3, xmm3
	pxor	xmm5, xmm5
	pxor	xmm1, xmm1
	pxor	xmm2, xmm2
	pxor	xmm0, xmm0
	.p2align	4
12:
	mov	r15, -256
	xor	r11d, r11d
	xor	ebx, ebx
	xor	r14d, r14d
	.p2align	4
22:
	movdqu	xmm12, xmmword ptr [r10 + 4*r15 + 1024]
	movq	xmm11, rax
	movdqa	xmm13, xmm6
	pclmulqdq	xmm13, xmm11, 0
	pxor	xmm13, xmm12
	movdqu	xmm12, xmmword ptr [r10 + 4*r15 + 1040]
	pclmulqdq	xmm6, xmm9, 17
	pxor	xmm6, xmm13
	movdqa	xmm13, xmm4
	pclmulqdq	xmm13, xmm11, 0
	pxor	xmm13, xmm12
	movdqu	xmm12, xmmword ptr [r10 + 4*r15 + 1056]
	pclmulqdq	xmm4, xmm9, 17
	pxor	xmm4, xmm13
	movdqa	xmm13, xmm7
	pclmulqdq	xmm13, xmm11, 0
	pxor	xmm13, xmm12
	movdqu	xmm12, xmmword ptr [r10 + 4*r15 + 1072]
	pclmulqdq	xmm7, xmm9, 17
	pxor	xmm7, xmm13
	movdqa	xmm13, xmm3
	pclmulqdq	xmm13, xmm11, 0
	pxor	xmm13, xmm12
	movdqu	xmm12, xmmword ptr [r10 + 4*r15 + 1088]
	pclmulqdq	xmm3, xmm9, 17
	pxor	xmm3, xmm13
	movdqa	xmm13, xmm5
	pclmulqdq	xmm13, xmm11, 0
	pxor	xmm13, xmm12
	movdqu	xmm12, xmmword ptr [r10 + 4*r15 + 1104]
	pclmulqdq	xmm5, xmm9, 17
	pxor	xmm5, xmm13
	movdqa	xmm13, xmm1
	pclmulqdq	xmm13, xmm11, 0
	pxor	xmm13, xmm12
	movdqu	xmm12, xmmword ptr [r10 + 4*r15 + 1120]
	pclmulqdq	xmm1, xmm9, 17
	pxor	xmm1, xmm13
	movdqa	xmm13, xmm2
	pclmulqdq	xmm13, xmm11, 0
	pxor	xmm13, xmm12
	movdqu	xmm12, xmmword ptr [r10 + 4*r15 + 1136]
	pclmulqdq	xmm2, xmm9, 17
	pxor	xmm2, xmm13
	movdqa	xmm13, xmm0
	pclmulqdq	xmm13, xmm11, 0
	pxor	xmm13, xmm12
	pclmulqdq	xmm0, xmm9, 17
	pxor	xmm0, xmm13
	crc32	r14, qword ptr [r10 + r15 + 1280]
	crc32	rbx, qword ptr [r10 + r15 + 1536]
	crc32	r11, qword ptr [r10 + r15 + 1792]
	crc32	r14, qword ptr [r10 + r15 + 1288]
	crc32	rbx, qword ptr [r10 + r15 + 1544]
	crc32	r11, qword ptr [r10 + r15 + 1800]
	crc32	r14, qword ptr [r10 + r15 + 1296]
	crc32	rbx, qword ptr [r10 + r15 + 1552]
	crc32	r11, qword ptr [r10 + r15 + 1808]
	crc32	r14, qword ptr [r10 + r15 + 1304]
	crc32	rbx, qword ptr [r10 + r15 + 1560]
	crc32	r11, qword ptr [r10 + r15 + 1816]
	add	r15, 32
	jne	22b
	movq	xmm12, r8
	movdqa	xmm13, xmm6
	pclmulqdq	xmm13, xmm12, 0
	pclmulqdq	xmm6, xmm10, 17
	pxor	xmm6, xmm13
	movdqa	xmm13, xmm4
	pclmulqdq	xmm13, xmm12, 0
	pclmulqdq	xmm4, xmm10, 17
	pxor	xmm4, xmm13
	movdqa	xmm13, xmm7
	pclmulqdq	xmm13, xmm12, 0
	pclmulqdq	xmm7, xmm10, 17
	pxor	xmm7, xmm13
	movdqa	xmm13, xmm3
	pclmulqdq	xmm13, xmm12, 0
	pclmulqdq	xmm3, xmm10, 17
	pxor	xmm3, xmm13
	movdqa	xmm13, xmm5
	pclmulqdq	xmm13, xmm12, 0
	pclmulqdq	xmm5, xmm10, 17
	pxor	xmm5, xmm13
	movdqa	xmm13, xmm1
	pclmulqdq	xmm13, xmm12, 0
	pclmulqdq	xmm1, xmm10, 17
	pxor	xmm1, xmm13
	movdqa	xmm13, xmm2
	pclmulqdq	xmm13, xmm12, 0
	pclmulqdq	xmm2, xmm10, 17
	pxor	xmm2, xmm13
	pclmulqdq	xmm12, xmm0, 0
	pclmulqdq	xmm0, xmm10, 17
	pxor	xmm0, xmm12
	movq	xmm12, r14
	movq	xmm13, r9
	pclmulqdq	xmm13, xmm12, 0
	pxor	xmm13, xmm6
	movq	xmm12, rbx
	pclmulqdq	xmm12, xmm11, 0
	movq	xmm6, r11
	pclmulqdq	xmm6, xmm8, 0
	pxor	xmm6, xmm12
	pxor	xmm6, xmm13
	inc	rdi
	add	r10, 1792
	cmp	rdi, rdx
	jne	12b
32:
	imul	rdx, rdx, 1792
	cmp	rdx, rcx
	jge	52f
	movq	xmm8, rax
	movdqa	xmm9, xmmword ptr [rip + 62f]
	.p2align	4
42:
	movdqu	xmm10, xmmword ptr [rsi + rdx]
	movdqa	xmm11, xmm6
	pclmulqdq	xmm11, xmm8, 0
	pxor	xmm11, xmm10
	movdqu	xmm10, xmmword ptr [rsi + rdx + 16]
	pclmulqdq	xmm6, xmm9, 17
	pxor	xmm6, xmm11
	movdqa	xmm11, xmm4
	pclmulqdq	xmm11, xmm8, 0
	pxor	xmm11, xmm10
	movdqu	xmm10, xmmword ptr [rsi + rdx + 32]
	pclmulqdq	xmm4, xmm9, 17
	pxor	xmm4, xmm11
	movdqa	xmm11, xmm7
	pclmulqdq	xmm11, xmm8, 0
	pxor	xmm11, xmm10
	movdqu	xmm10, xmmword ptr [rsi + rdx + 48]
	pclmulqdq	xmm7, xmm9, 17
	pxor	xmm7, xmm11
	movdqa	xmm11, xmm3
	pclmulqdq	xmm11, xmm8, 0
	pxor	xmm11, xmm10
	movdqu	xmm10, xmmword ptr [rsi + rdx + 64]
	pclmulqdq	xmm3, xmm9, 17
	pxor	xmm3, xmm11
	movdqa	xmm11, xmm5
	pclmulqdq	xmm11, xmm8, 0
	pxor	xmm11, xmm10
	movdqu	xmm10, xmmword ptr [rsi + rdx + 80]
	pclmulqdq	xmm5, xmm9, 17
	pxor	xmm5, xmm11
	movdqa	xmm11, xmm1
	pclmulqdq	xmm11, xmm8, 0
	pxor	xmm11, xmm10
	movdqu	xmm10, xmmword ptr [rsi + rdx + 96]
	pclmulqdq	xmm1, xmm9, 17
	pxor	xmm1, xmm11
	movdqa	xmm11, xmm2
	pclmulqdq	xmm11, xmm8, 0
	pxor	xmm11, xmm10
	movdqu	xmm10, xmmword ptr [rsi + rdx + 112]
	pclmulqdq	xmm2, xmm9, 17
	pxor	xmm2, xmm11
	movdqa	xmm11, xmm0
	pclmulqdq	xmm11, xmm8, 0
	pxor	xmm11, xmm10
	pclmulqdq	xmm0, xmm9, 17
	pxor	xmm0, xmm11
	sub	rdx, -128
	cmp	rdx, rcx
	jl	42b
52:
	movabs	rax, 1627051491397206016
	movq	xmm8, rax
	pclmulqdq	xmm8, xmm6, 0
	pclmulqdq	xmm6, xmmword ptr [rip + 82f], 17
	movabs	rax, -3949769517311197184
	movq	xmm9, rax
	pclmulqdq	xmm9, xmm4, 0
	pxor	xmm9, xmm8
	pxor	xmm9, xmm6
	pclmulqdq	xmm4, xmmword ptr [rip + 92f], 17
	movabs	rax, 2036429962822549504
	movq	xmm6, rax
	pclmulqdq	xmm6, xmm7, 0
	pxor	xmm6, xmm4
	pxor	xmm6, xmm9
	pclmulqdq	xmm7, xmmword ptr [rip + 102f], 17
	movabs	rax, 2024689343301419008
	movq	xmm4, rax
	pclmulqdq	xmm4, xmm3, 0
	pxor	xmm4, xmm7
	pclmulqdq	xmm3, xmmword ptr [rip + 112f], 17
	pxor	xmm3, xmm4
	pxor	xmm3, xmm6
	movabs	rax, -6598067393069580288
	movq	xmm4, rax
	pclmulqdq	xmm4, xmm5, 0
	pclmulqdq	xmm5, xmmword ptr [rip + 122f], 17
	pxor	xmm5, xmm4
	movabs	rax, 3732564607311544320
	movq	xmm4, rax
	pclmulqdq	xmm4, xmm1, 0
	pxor	xmm4, xmm5
	pclmulqdq	xmm1, xmmword ptr [rip + 132f], 17
	pxor	xmm1, xmm4
	pxor	xmm1, xmm3
	movabs	rax, 3982298886646530048
	movq	xmm3, rax
	pclmulqdq	xmm3, xmm2, 0
	pclmulqdq	xmm2, xmmword ptr [rip + 142f], 17
	pxor	xmm2, xmm3
	movabs	rax, -2502406310683738112
	movq	xmm3, rax
	movdqa	xmm4, xmm0
	pclmulqdq	xmm4, xmm3, 0
	pclmulqdq	xmm0, xmmword ptr [rip + 152f], 17
	pxor	xmm0, xmm4
	pxor	xmm0, xmm2
	pxor	xmm0, xmm1
	pextrq	rax, xmm0, 1
	movabs	rcx, 5277230469828575232
	movq	xmm1, rcx
	pclmulqdq	xmm1, xmm0, 0
	movq	rcx, xmm1
	mov	rdx, rax
	shl	rdx, 32
	xor	rdx, rcx
	shr	rax, 32
	movq	xmm0, rdx
	pclmulqdq	xmm0, xmm3, 0
	pxor	xmm0, xmm1
	pextrq	rcx, xmm0, 1
	xor	eax, ecx
	movd	xmm0, eax
	mov	eax, 3735491569
	movq	xmm1, rax
	pclmulqdq	xmm1, xmm0, 0
	pmovzxdq	xmm0, xmm1
	movabs	rax, 4394350321
	movq	xmm1, rax
	pclmulqdq	xmm1, xmm0, 0
	movq	rax, xmm1
	xor	rax, rcx
	shr	rax, 32
	pop	rbx
	pop	r14
	pop	r15
	ret
	.p2align	4, 0x0
62:
	.zero	8
	.quad	8365178193191108608
	.p2align	4, 0x0
72:
	.zero	8
	.quad	-4163748391475478528
	.p2align	4, 0x0
82:
	.zero	8
	.quad	-7620545986368110592
	.p2align	4, 0x0
92:
	.zero	8
	.quad	3703423898453278720
	.p2align	4, 0x0
102:
	.zero	8
	.quad	7892626757205884928
	.p2align	4, 0x0
112:
	.zero	8
	.quad	8483555033831440384
	.p2align	4, 0x0
122:
	.zero	8
	.quad	6940368353756184576
	.p2align	4, 0x0
132:
	.zero	8
	.quad	-6767349809599741952
	.p2align	4, 0x0
142:
	.zero	8
	.quad	3562862082850291712
	.p2align	4, 0x0
152:
	.zero	8
	.quad	426846842152550400

# minlz_crc32c_update of crates/minlz/mlir/crc32c_fold.mlir for pclmul, written by
# cargo xtask mlir. Do not edit.
	mov	rcx, rdx
	cmp	rdx, 2048
	jb	42f
	push	r15
	push	r14
	push	r12
	push	rbx
	mov	r8, rcx
	and	r8, -128
	mov	rax, rcx
	shr	rax, 8
	movabs	rdx, 2635249153387078803
	mul	rdx
	movd	xmm7, edi
	movabs	rax, -1224287136463716352
	movq	xmm10, rax
	pclmulqdq	xmm7, xmm10, 0
	pxor	xmm5, xmm5
	xor	eax, eax
	movabs	rdi, 7311508529481777152
	movdqa	xmm8, xmmword ptr [rip + 192f]
	movabs	r9, 8668591446237904896
	movdqa	xmm11, xmmword ptr [rip + 202f]
	movabs	r10, 4449734295027712000
	mov	r11, rsi
	pxor	xmm6, xmm6
	pxor	xmm3, xmm3
	pxor	xmm4, xmm4
	pxor	xmm1, xmm1
	pxor	xmm2, xmm2
	pxor	xmm0, xmm0
	.p2align	4
2:
	mov	r12, -256
	xor	ebx, ebx
	xor	r14d, r14d
	xor	r15d, r15d
	.p2align	4
12:
	movdqu	xmm12, xmmword ptr [r11 + 4*r12 + 1024]
	movq	xmm9, rdi
	movdqa	xmm13, xmm7
	pclmulqdq	xmm13, xmm9, 0
	pxor	xmm13, xmm12
	movdqu	xmm12, xmmword ptr [r11 + 4*r12 + 1040]
	pclmulqdq	xmm7, xmm8, 17
	pxor	xmm7, xmm13
	movdqa	xmm13, xmm5
	pclmulqdq	xmm13, xmm9, 0
	pxor	xmm13, xmm12
	movdqu	xmm12, xmmword ptr [r11 + 4*r12 + 1056]
	pclmulqdq	xmm5, xmm8, 17
	pxor	xmm5, xmm13
	movdqa	xmm13, xmm6
	pclmulqdq	xmm13, xmm9, 0
	pxor	xmm13, xmm12
	movdqu	xmm12, xmmword ptr [r11 + 4*r12 + 1072]
	pclmulqdq	xmm6, xmm8, 17
	pxor	xmm6, xmm13
	movdqa	xmm13, xmm3
	pclmulqdq	xmm13, xmm9, 0
	pxor	xmm13, xmm12
	movdqu	xmm12, xmmword ptr [r11 + 4*r12 + 1088]
	pclmulqdq	xmm3, xmm8, 17
	pxor	xmm3, xmm13
	movdqa	xmm13, xmm4
	pclmulqdq	xmm13, xmm9, 0
	pxor	xmm13, xmm12
	movdqu	xmm12, xmmword ptr [r11 + 4*r12 + 1104]
	pclmulqdq	xmm4, xmm8, 17
	pxor	xmm4, xmm13
	movdqa	xmm13, xmm1
	pclmulqdq	xmm13, xmm9, 0
	pxor	xmm13, xmm12
	movdqu	xmm12, xmmword ptr [r11 + 4*r12 + 1120]
	pclmulqdq	xmm1, xmm8, 17
	pxor	xmm1, xmm13
	movdqa	xmm13, xmm2
	pclmulqdq	xmm13, xmm9, 0
	pxor	xmm13, xmm12
	movdqu	xmm12, xmmword ptr [r11 + 4*r12 + 1136]
	pclmulqdq	xmm2, xmm8, 17
	pxor	xmm2, xmm13
	movdqa	xmm13, xmm0
	pclmulqdq	xmm13, xmm9, 0
	pxor	xmm13, xmm12
	pclmulqdq	xmm0, xmm8, 17
	pxor	xmm0, xmm13
	prefetcht0	byte ptr [r11 + 4*r12 + 6912]
	prefetcht0	byte ptr [r11 + 4*r12 + 6976]
	prefetcht0	byte ptr [r11 + r12 + 7168]
	prefetcht0	byte ptr [r11 + r12 + 7424]
	prefetcht0	byte ptr [r11 + r12 + 7680]
	crc32	r15, qword ptr [r11 + r12 + 1280]
	crc32	r14, qword ptr [r11 + r12 + 1536]
	crc32	rbx, qword ptr [r11 + r12 + 1792]
	crc32	r15, qword ptr [r11 + r12 + 1288]
	crc32	r14, qword ptr [r11 + r12 + 1544]
	crc32	rbx, qword ptr [r11 + r12 + 1800]
	crc32	r15, qword ptr [r11 + r12 + 1296]
	crc32	r14, qword ptr [r11 + r12 + 1552]
	crc32	rbx, qword ptr [r11 + r12 + 1808]
	crc32	r15, qword ptr [r11 + r12 + 1304]
	crc32	r14, qword ptr [r11 + r12 + 1560]
	crc32	rbx, qword ptr [r11 + r12 + 1816]
	add	r12, 32
	jne	12b
	movq	xmm12, r9
	movdqa	xmm13, xmm7
	pclmulqdq	xmm13, xmm12, 0
	pclmulqdq	xmm7, xmm11, 17
	pxor	xmm7, xmm13
	movdqa	xmm13, xmm5
	pclmulqdq	xmm13, xmm12, 0
	pclmulqdq	xmm5, xmm11, 17
	pxor	xmm5, xmm13
	movdqa	xmm13, xmm6
	pclmulqdq	xmm13, xmm12, 0
	pclmulqdq	xmm6, xmm11, 17
	pxor	xmm6, xmm13
	movdqa	xmm13, xmm3
	pclmulqdq	xmm13, xmm12, 0
	pclmulqdq	xmm3, xmm11, 17
	pxor	xmm3, xmm13
	movdqa	xmm13, xmm4
	pclmulqdq	xmm13, xmm12, 0
	pclmulqdq	xmm4, xmm11, 17
	pxor	xmm4, xmm13
	movdqa	xmm13, xmm1
	pclmulqdq	xmm13, xmm12, 0
	pclmulqdq	xmm1, xmm11, 17
	pxor	xmm1, xmm13
	movdqa	xmm13, xmm2
	pclmulqdq	xmm13, xmm12, 0
	pclmulqdq	xmm2, xmm11, 17
	pxor	xmm2, xmm13
	pclmulqdq	xmm12, xmm0, 0
	pclmulqdq	xmm0, xmm11, 17
	pxor	xmm0, xmm12
	movq	xmm12, r15
	movq	xmm13, r10
	pclmulqdq	xmm13, xmm12, 0
	pxor	xmm13, xmm7
	movq	xmm12, r14
	pclmulqdq	xmm12, xmm9, 0
	movq	xmm7, rbx
	pclmulqdq	xmm7, xmm10, 0
	pxor	xmm7, xmm12
	pxor	xmm7, xmm13
	inc	rax
	add	r11, 1792
	cmp	rax, rdx
	jne	2b
	imul	rax, rdx, 1792
	cmp	rax, r8
	pop	rbx
	pop	r12
	pop	r14
	pop	r15
	jge	32f
	.p2align	4
22:
	movdqa	xmm10, xmm7
	pclmulqdq	xmm10, xmm9, 0
	pclmulqdq	xmm7, xmm8, 17
	movdqu	xmm11, xmmword ptr [rsi + rax]
	pxor	xmm11, xmm10
	pxor	xmm7, xmm11
	movdqu	xmm10, xmmword ptr [rsi + rax + 16]
	movdqu	xmm11, xmmword ptr [rsi + rax + 32]
	movdqu	xmm12, xmmword ptr [rsi + rax + 48]
	movdqa	xmm13, xmm5
	pclmulqdq	xmm13, xmm9, 0
	pxor	xmm13, xmm10
	pclmulqdq	xmm5, xmm8, 17
	pxor	xmm5, xmm13
	movdqa	xmm10, xmm6
	pclmulqdq	xmm10, xmm9, 0
	pxor	xmm10, xmm11
	pclmulqdq	xmm6, xmm8, 17
	pxor	xmm6, xmm10
	movdqa	xmm10, xmm3
	pclmulqdq	xmm10, xmm9, 0
	pxor	xmm10, xmm12
	pclmulqdq	xmm3, xmm8, 17
	pxor	xmm3, xmm10
	movdqu	xmm10, xmmword ptr [rsi + rax + 64]
	movdqu	xmm11, xmmword ptr [rsi + rax + 80]
	movdqa	xmm12, xmm4
	pclmulqdq	xmm12, xmm9, 0
	pxor	xmm12, xmm10
	pclmulqdq	xmm4, xmm8, 17
	pxor	xmm4, xmm12
	movdqa	xmm10, xmm1
	pclmulqdq	xmm10, xmm9, 0
	pxor	xmm10, xmm11
	pclmulqdq	xmm1, xmm8, 17
	pxor	xmm1, xmm10
	movdqu	xmm10, xmmword ptr [rsi + rax + 96]
	movdqu	xmm11, xmmword ptr [rsi + rax + 112]
	movdqa	xmm12, xmm2
	pclmulqdq	xmm12, xmm9, 0
	pxor	xmm12, xmm10
	pclmulqdq	xmm2, xmm8, 17
	pxor	xmm2, xmm12
	movdqa	xmm10, xmm0
	pclmulqdq	xmm10, xmm9, 0
	pxor	xmm10, xmm11
	pclmulqdq	xmm0, xmm8, 17
	pxor	xmm0, xmm10
	sub	rax, -128
	cmp	rax, r8
	jl	22b
32:
	movabs	rax, 1627051491397206016
	movq	xmm8, rax
	pclmulqdq	xmm8, xmm7, 0
	pclmulqdq	xmm7, xmmword ptr [rip + 212f], 17
	movabs	rax, -3949769517311197184
	movq	xmm9, rax
	pclmulqdq	xmm9, xmm5, 0
	pxor	xmm9, xmm8
	pxor	xmm9, xmm7
	pclmulqdq	xmm5, xmmword ptr [rip + 222f], 17
	movabs	rax, 2036429962822549504
	movq	xmm7, rax
	pclmulqdq	xmm7, xmm6, 0
	pxor	xmm7, xmm5
	pxor	xmm7, xmm9
	pclmulqdq	xmm6, xmmword ptr [rip + 232f], 17
	movabs	rax, 2024689343301419008
	movq	xmm5, rax
	pclmulqdq	xmm5, xmm3, 0
	pxor	xmm5, xmm6
	pclmulqdq	xmm3, xmmword ptr [rip + 242f], 17
	pxor	xmm3, xmm5
	pxor	xmm3, xmm7
	movabs	rax, -6598067393069580288
	movq	xmm5, rax
	pclmulqdq	xmm5, xmm4, 0
	pclmulqdq	xmm4, xmmword ptr [rip + 252f], 17
	pxor	xmm4, xmm5
	movabs	rax, 3732564607311544320
	movq	xmm5, rax
	pclmulqdq	xmm5, xmm1, 0
	pxor	xmm5, xmm4
	pclmulqdq	xmm1, xmmword ptr [rip + 262f], 17
	pxor	xmm1, xmm5
	pxor	xmm1, xmm3
	movabs	rax, 3982298886646530048
	movq	xmm3, rax
	pclmulqdq	xmm3, xmm2, 0
	pclmulqdq	xmm2, xmmword ptr [rip + 272f], 17
	pxor	xmm2, xmm3
	movabs	rax, -2502406310683738112
	movq	xmm3, rax
	movdqa	xmm4, xmm0
	pclmulqdq	xmm4, xmm3, 0
	pclmulqdq	xmm0, xmmword ptr [rip + 282f], 17
	pxor	xmm0, xmm4
	pxor	xmm0, xmm2
	pxor	xmm0, xmm1
	pextrq	rax, xmm0, 1
	movabs	rdx, 5277230469828575232
	movq	xmm1, rdx
	pclmulqdq	xmm1, xmm0, 0
	movq	rdx, xmm1
	mov	rdi, rax
	shl	rdi, 32
	xor	rdi, rdx
	shr	rax, 32
	movq	xmm0, rdi
	pclmulqdq	xmm0, xmm3, 0
	pxor	xmm0, xmm1
	pextrq	rdx, xmm0, 1
	xor	eax, edx
	movd	xmm0, eax
	mov	eax, 3735491569
	movq	xmm1, rax
	pclmulqdq	xmm1, xmm0, 0
	pmovzxdq	xmm0, xmm1
	movabs	rax, 4394350321
	movq	xmm1, rax
	pclmulqdq	xmm1, xmm0, 0
	movq	rdi, xmm1
	xor	rdi, rdx
	shr	rdi, 32
	jmp	52f
42:
	xor	r8d, r8d
52:
	mov	rdx, rcx
	sub	rdx, r8
	and	rdx, -64
	add	rdx, r8
	mov	eax, edi
	cmp	r8, rdx
	jge	72f
	.p2align	4
62:
	crc32	rax, qword ptr [rsi + r8]
	crc32	rax, qword ptr [rsi + r8 + 8]
	crc32	rax, qword ptr [rsi + r8 + 16]
	crc32	rax, qword ptr [rsi + r8 + 24]
	crc32	rax, qword ptr [rsi + r8 + 32]
	crc32	rax, qword ptr [rsi + r8 + 40]
	crc32	rax, qword ptr [rsi + r8 + 48]
	crc32	rax, qword ptr [rsi + r8 + 56]
	add	r8, 64
	cmp	r8, rdx
	jl	62b
72:
	test	cl, 32
	jne	132f
	test	cl, 16
	jne	142f
82:
	test	cl, 8
	jne	152f
92:
	test	cl, 4
	jne	162f
102:
	test	cl, 2
	jne	172f
112:
	test	cl, 1
	jne	182f
122:
	ret
132:
	crc32	rax, qword ptr [rsi + rdx]
	crc32	rax, qword ptr [rsi + rdx + 8]
	crc32	rax, qword ptr [rsi + rdx + 16]
	crc32	rax, qword ptr [rsi + rdx + 24]
	or	rdx, 32
	test	cl, 16
	je	82b
142:
	crc32	rax, qword ptr [rsi + rdx]
	crc32	rax, qword ptr [rsi + rdx + 8]
	add	rdx, 16
	test	cl, 8
	je	92b
152:
	crc32	rax, qword ptr [rsi + rdx]
	add	rdx, 8
	test	cl, 4
	je	102b
162:
	crc32	eax, dword ptr [rsi + rdx]
	add	rdx, 4
	test	cl, 2
	je	112b
172:
	crc32	eax, word ptr [rsi + rdx]
	add	rdx, 2
	test	cl, 1
	je	122b
182:
	crc32	eax, byte ptr [rsi + rdx]
	ret
	.p2align	4, 0x0
192:
	.zero	8
	.quad	8365178193191108608
	.p2align	4, 0x0
202:
	.zero	8
	.quad	-4163748391475478528
	.p2align	4, 0x0
212:
	.zero	8
	.quad	-7620545986368110592
	.p2align	4, 0x0
222:
	.zero	8
	.quad	3703423898453278720
	.p2align	4, 0x0
232:
	.zero	8
	.quad	7892626757205884928
	.p2align	4, 0x0
242:
	.zero	8
	.quad	8483555033831440384
	.p2align	4, 0x0
252:
	.zero	8
	.quad	6940368353756184576
	.p2align	4, 0x0
262:
	.zero	8
	.quad	-6767349809599741952
	.p2align	4, 0x0
272:
	.zero	8
	.quad	3562862082850291712
	.p2align	4, 0x0
282:
	.zero	8
	.quad	426846842152550400

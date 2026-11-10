# minlz_crc32c_fold of crates/minlz/mlir/crc32c.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	push	r14
	push	rbx
	mov	rcx, rdx
	vmovd	xmm0, edi
	movabs	rax, -1224287136463716352
	vmovq	xmm4, rax
	vpclmulqdq	xmm3, xmm0, xmm4, 0
	vpxor	xmm0, xmm0, xmm0
	mov	rax, rdx
	shr	rax, 8
	movabs	rdx, 2635249153387078803
	mul	rdx
	cmp	rcx, 1792
	jae	2f
	vpxor	xmm2, xmm2, xmm2
	vpxor	xmm1, xmm1, xmm1
	jmp	32f
2:
	xor	eax, eax
	vpbroadcastq	ymm5, qword ptr [rip + 62f]
	vpbroadcastq	ymm6, qword ptr [rip + 72f]
	vpbroadcastq	ymm7, qword ptr [rip + 82f]
	vpbroadcastq	ymm8, qword ptr [rip + 92f]
	movabs	rdi, 4449734295027712000
	movabs	r8, 7311508529481777152
	mov	r9, rsi
	vpxor	xmm2, xmm2, xmm2
	vpxor	xmm1, xmm1, xmm1
	.p2align	4
12:
	mov	r14, -256
	xor	r10d, r10d
	xor	r11d, r11d
	xor	ebx, ebx
	.p2align	4
22:
	crc32	rbx, qword ptr [r9 + r14 + 1280]
	crc32	r11, qword ptr [r9 + r14 + 1536]
	crc32	r10, qword ptr [r9 + r14 + 1792]
	crc32	rbx, qword ptr [r9 + r14 + 1288]
	crc32	r11, qword ptr [r9 + r14 + 1544]
	crc32	r10, qword ptr [r9 + r14 + 1800]
	crc32	rbx, qword ptr [r9 + r14 + 1296]
	crc32	r11, qword ptr [r9 + r14 + 1552]
	crc32	r10, qword ptr [r9 + r14 + 1808]
	crc32	rbx, qword ptr [r9 + r14 + 1304]
	crc32	r11, qword ptr [r9 + r14 + 1560]
	crc32	r10, qword ptr [r9 + r14 + 1816]
	vpclmulqdq	ymm9, ymm3, ymm5, 0
	vpclmulqdq	ymm3, ymm3, ymm6, 17
	vpxor	ymm3, ymm9, ymm3
	vpclmulqdq	ymm9, ymm0, ymm5, 0
	vpclmulqdq	ymm0, ymm0, ymm6, 17
	vpxor	ymm0, ymm9, ymm0
	vpclmulqdq	ymm9, ymm2, ymm5, 0
	vpclmulqdq	ymm2, ymm2, ymm6, 17
	vpxor	ymm2, ymm9, ymm2
	vpclmulqdq	ymm9, ymm1, ymm5, 0
	vpclmulqdq	ymm1, ymm1, ymm6, 17
	vpxor	ymm1, ymm9, ymm1
	vpxor	ymm3, ymm3, ymmword ptr [r9 + 4*r14 + 1024]
	vpxor	ymm0, ymm0, ymmword ptr [r9 + 4*r14 + 1056]
	vpxor	ymm2, ymm2, ymmword ptr [r9 + 4*r14 + 1088]
	vpxor	ymm1, ymm1, ymmword ptr [r9 + 4*r14 + 1120]
	add	r14, 32
	jne	22b
	vpclmulqdq	ymm9, ymm3, ymm7, 0
	vpclmulqdq	ymm3, ymm3, ymm8, 17
	vpxor	ymm3, ymm9, ymm3
	vpclmulqdq	ymm9, ymm0, ymm7, 0
	vpclmulqdq	ymm0, ymm0, ymm8, 17
	vpxor	ymm0, ymm9, ymm0
	vpclmulqdq	ymm9, ymm2, ymm7, 0
	vpclmulqdq	ymm2, ymm2, ymm8, 17
	vpxor	ymm2, ymm9, ymm2
	vpclmulqdq	ymm9, ymm1, ymm7, 0
	vpclmulqdq	ymm1, ymm1, ymm8, 17
	vpxor	ymm1, ymm9, ymm1
	vmovq	xmm9, rbx
	vmovq	xmm10, rdi
	vpclmulqdq	xmm9, xmm9, xmm10, 0
	vpxor	ymm3, ymm9, ymm3
	vmovq	xmm9, r11
	vmovq	xmm10, r8
	vpclmulqdq	xmm9, xmm9, xmm10, 0
	vmovq	xmm10, r10
	vpclmulqdq	xmm10, xmm10, xmm4, 0
	vpxor	ymm9, ymm9, ymm10
	vpxor	ymm3, ymm9, ymm3
	inc	rax
	add	r9, 1792
	cmp	rax, rdx
	jne	12b
32:
	imul	rax, rdx, 1792
	cmp	rax, rcx
	jge	52f
	vpbroadcastq	ymm4, qword ptr [rip + 62f]
	vpbroadcastq	ymm5, qword ptr [rip + 72f]
	.p2align	4
42:
	vpclmulqdq	ymm6, ymm3, ymm4, 0
	vpclmulqdq	ymm3, ymm3, ymm5, 17
	vpxor	ymm3, ymm3, ymm6
	vpclmulqdq	ymm6, ymm0, ymm4, 0
	vpclmulqdq	ymm0, ymm0, ymm5, 17
	vpxor	ymm0, ymm0, ymm6
	vpclmulqdq	ymm6, ymm2, ymm4, 0
	vpclmulqdq	ymm2, ymm2, ymm5, 17
	vpxor	ymm2, ymm2, ymm6
	vpclmulqdq	ymm6, ymm1, ymm4, 0
	vpclmulqdq	ymm1, ymm1, ymm5, 17
	vpxor	ymm1, ymm1, ymm6
	vpxor	ymm3, ymm3, ymmword ptr [rsi + rax]
	vpxor	ymm0, ymm0, ymmword ptr [rsi + rax + 32]
	vpxor	ymm2, ymm2, ymmword ptr [rsi + rax + 64]
	vpxor	ymm1, ymm1, ymmword ptr [rsi + rax + 96]
	sub	rax, -128
	cmp	rax, rcx
	jl	42b
52:
	vpclmulqdq	ymm4, ymm3, ymmword ptr [rip + 102f], 0
	vpclmulqdq	ymm3, ymm3, ymmword ptr [rip + 112f], 17
	vpxor	ymm3, ymm3, ymm4
	vpclmulqdq	ymm4, ymm0, ymmword ptr [rip + 122f], 0
	vpclmulqdq	ymm0, ymm0, ymmword ptr [rip + 132f], 17
	vpxor	ymm0, ymm0, ymm4
	vpclmulqdq	ymm4, ymm2, ymmword ptr [rip + 142f], 0
	vpclmulqdq	ymm2, ymm2, ymmword ptr [rip + 152f], 17
	vpxor	ymm2, ymm2, ymm4
	vpclmulqdq	ymm4, ymm1, ymmword ptr [rip + 162f], 0
	vpclmulqdq	ymm1, ymm1, ymmword ptr [rip + 172f], 17
	vpxor	ymm1, ymm1, ymm4
	vextracti128	xmm4, ymm3, 1
	vextracti128	xmm5, ymm0, 1
	vextracti128	xmm6, ymm2, 1
	vextracti128	xmm7, ymm1, 1
	vpxor	xmm0, xmm3, xmm0
	vpxor	xmm0, xmm4, xmm0
	vpxor	xmm2, xmm5, xmm2
	vpxor	xmm0, xmm0, xmm2
	vpxor	xmm1, xmm6, xmm1
	vpxor	xmm1, xmm1, xmm7
	vpxor	xmm0, xmm0, xmm1
	vpextrq	rax, xmm0, 1
	movabs	rcx, 5277230469828575232
	vmovq	xmm1, rcx
	vpclmulqdq	xmm0, xmm0, xmm1, 0
	vmovq	rcx, xmm0
	mov	rdx, rax
	shl	rdx, 32
	xor	rdx, rcx
	shr	rax, 32
	vmovq	xmm1, rdx
	movabs	rcx, -2502406310683738112
	vmovq	xmm2, rcx
	vpclmulqdq	xmm1, xmm1, xmm2, 0
	vpxor	xmm0, xmm1, xmm0
	vpextrq	rcx, xmm0, 1
	xor	eax, ecx
	vmovd	xmm0, eax
	mov	eax, 3735491569
	vmovq	xmm1, rax
	vpclmulqdq	xmm0, xmm0, xmm1, 0
	vpmovzxdq	xmm0, xmm0
	movabs	rax, 4394350321
	vmovq	xmm1, rax
	vpclmulqdq	xmm0, xmm0, xmm1, 0
	vmovq	rax, xmm0
	xor	rax, rcx
	shr	rax, 32
	pop	rbx
	pop	r14
	vzeroupper
	ret
	.p2align	3, 0x0
62:
	.quad	7311508529481777152
	.p2align	3, 0x0
72:
	.quad	8365178193191108608
	.p2align	3, 0x0
82:
	.quad	8668591446237904896
	.p2align	3, 0x0
92:
	.quad	-4163748391475478528
	.p2align	5, 0x0
102:
	.quad	1627051491397206016
	.zero	8
	.quad	-3949769517311197184
	.zero	8
	.p2align	5, 0x0
112:
	.zero	8
	.quad	-7620545986368110592
	.zero	8
	.quad	3703423898453278720
	.p2align	5, 0x0
122:
	.quad	2036429962822549504
	.zero	8
	.quad	2024689343301419008
	.zero	8
	.p2align	5, 0x0
132:
	.zero	8
	.quad	7892626757205884928
	.zero	8
	.quad	8483555033831440384
	.p2align	5, 0x0
142:
	.quad	-6598067393069580288
	.zero	8
	.quad	3732564607311544320
	.zero	8
	.p2align	5, 0x0
152:
	.zero	8
	.quad	6940368353756184576
	.zero	8
	.quad	-6767349809599741952
	.p2align	5, 0x0
162:
	.quad	3982298886646530048
	.zero	8
	.quad	-2502406310683738112
	.zero	8
	.p2align	5, 0x0
172:
	.zero	8
	.quad	3562862082850291712
	.zero	8
	.quad	426846842152550400

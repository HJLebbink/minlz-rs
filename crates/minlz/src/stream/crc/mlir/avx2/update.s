# minlz_crc32c_update of crates/minlz/mlir/crc32c_fold.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	mov	rcx, rdx
	cmp	rdx, 1024
	jb	2f
	mov	r8, rcx
	and	r8, -128
	vmovd	xmm0, edi
	movabs	rax, -1224287136463716352
	vmovq	xmm4, rax
	vpclmulqdq	xmm2, xmm0, xmm4, 0
	vpxor	xmm0, xmm0, xmm0
	mov	rax, rcx
	shr	rax, 8
	movabs	rdx, 2635249153387078803
	mul	rdx
	cmp	rcx, 1792
	jae	12f
	vpxor	xmm3, xmm3, xmm3
	vpxor	xmm1, xmm1, xmm1
	imul	rax, rdx, 1792
	cmp	rax, r8
	jl	42f
	jmp	62f
2:
	xor	r8d, r8d
	jmp	72f
12:
	push	r15
	push	r14
	push	rbx
	xor	eax, eax
	vpbroadcastq	ymm5, qword ptr [rip + 212f]
	vpbroadcastq	ymm6, qword ptr [rip + 222f]
	vpbroadcastq	ymm7, qword ptr [rip + 232f]
	vpbroadcastq	ymm8, qword ptr [rip + 242f]
	movabs	rdi, 4449734295027712000
	movabs	r9, 7311508529481777152
	mov	r10, rsi
	vpxor	xmm3, xmm3, xmm3
	vpxor	xmm1, xmm1, xmm1
	.p2align	4
22:
	mov	r15, -256
	xor	r11d, r11d
	xor	ebx, ebx
	xor	r14d, r14d
	.p2align	4
32:
	prefetcht0	byte ptr [r10 + 4*r15 + 6912]
	vpclmulqdq	ymm9, ymm2, ymm5, 0
	vpxor	ymm9, ymm9, ymmword ptr [r10 + 4*r15 + 1024]
	vpclmulqdq	ymm10, ymm0, ymm5, 0
	vpxor	ymm10, ymm10, ymmword ptr [r10 + 4*r15 + 1056]
	vpclmulqdq	ymm11, ymm3, ymm5, 0
	vpxor	ymm11, ymm11, ymmword ptr [r10 + 4*r15 + 1088]
	vpclmulqdq	ymm12, ymm1, ymm5, 0
	vpxor	ymm12, ymm12, ymmword ptr [r10 + 4*r15 + 1120]
	prefetcht0	byte ptr [r10 + 4*r15 + 6976]
	prefetcht0	byte ptr [r10 + r15 + 7168]
	prefetcht0	byte ptr [r10 + r15 + 7424]
	prefetcht0	byte ptr [r10 + r15 + 7680]
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
	vpclmulqdq	ymm2, ymm2, ymm6, 17
	vpxor	ymm2, ymm9, ymm2
	vpclmulqdq	ymm0, ymm0, ymm6, 17
	vpxor	ymm0, ymm10, ymm0
	vpclmulqdq	ymm3, ymm3, ymm6, 17
	vpxor	ymm3, ymm11, ymm3
	vpclmulqdq	ymm1, ymm1, ymm6, 17
	vpxor	ymm1, ymm12, ymm1
	add	r15, 32
	jne	32b
	vpclmulqdq	ymm9, ymm2, ymm7, 0
	vpclmulqdq	ymm2, ymm2, ymm8, 17
	vpxor	ymm2, ymm9, ymm2
	vpclmulqdq	ymm9, ymm0, ymm7, 0
	vpclmulqdq	ymm0, ymm0, ymm8, 17
	vpxor	ymm0, ymm9, ymm0
	vpclmulqdq	ymm9, ymm3, ymm7, 0
	vpclmulqdq	ymm3, ymm3, ymm8, 17
	vpxor	ymm3, ymm9, ymm3
	vpclmulqdq	ymm9, ymm1, ymm7, 0
	vpclmulqdq	ymm1, ymm1, ymm8, 17
	vpxor	ymm1, ymm9, ymm1
	vmovq	xmm9, r14
	vmovq	xmm10, rdi
	vpclmulqdq	xmm9, xmm9, xmm10, 0
	vpxor	ymm2, ymm9, ymm2
	vmovq	xmm9, rbx
	vmovq	xmm10, r9
	vpclmulqdq	xmm9, xmm9, xmm10, 0
	vmovq	xmm10, r11
	vpclmulqdq	xmm10, xmm10, xmm4, 0
	vpxor	ymm9, ymm9, ymm10
	vpxor	ymm2, ymm9, ymm2
	inc	rax
	add	r10, 1792
	cmp	rax, rdx
	jne	22b
	pop	rbx
	pop	r14
	pop	r15
	imul	rax, rdx, 1792
	cmp	rax, r8
	jge	62f
42:
	vpbroadcastq	ymm4, qword ptr [rip + 212f]
	vpbroadcastq	ymm5, qword ptr [rip + 222f]
	.p2align	4
52:
	vpclmulqdq	ymm6, ymm2, ymm4, 0
	vpclmulqdq	ymm2, ymm2, ymm5, 17
	vpxor	ymm6, ymm6, ymmword ptr [rsi + rax]
	vpxor	ymm2, ymm6, ymm2
	vpclmulqdq	ymm6, ymm0, ymm4, 0
	vpclmulqdq	ymm0, ymm0, ymm5, 17
	vpxor	ymm6, ymm6, ymmword ptr [rsi + rax + 32]
	vpxor	ymm0, ymm6, ymm0
	vpclmulqdq	ymm6, ymm3, ymm4, 0
	vpclmulqdq	ymm3, ymm3, ymm5, 17
	vpxor	ymm6, ymm6, ymmword ptr [rsi + rax + 64]
	vpxor	ymm3, ymm6, ymm3
	vpclmulqdq	ymm6, ymm1, ymm4, 0
	vpclmulqdq	ymm1, ymm1, ymm5, 17
	vpxor	ymm6, ymm6, ymmword ptr [rsi + rax + 96]
	vpxor	ymm1, ymm6, ymm1
	sub	rax, -128
	cmp	rax, r8
	jl	52b
62:
	vpclmulqdq	ymm4, ymm2, ymmword ptr [rip + 252f], 0
	vpclmulqdq	ymm2, ymm2, ymmword ptr [rip + 262f], 17
	vpxor	ymm2, ymm2, ymm4
	vpclmulqdq	ymm4, ymm0, ymmword ptr [rip + 272f], 0
	vpclmulqdq	ymm0, ymm0, ymmword ptr [rip + 282f], 17
	vpxor	ymm0, ymm0, ymm4
	vpclmulqdq	ymm4, ymm3, ymmword ptr [rip + 292f], 0
	vpclmulqdq	ymm3, ymm3, ymmword ptr [rip + 302f], 17
	vpxor	ymm3, ymm3, ymm4
	vpclmulqdq	ymm4, ymm1, ymmword ptr [rip + 312f], 0
	vpclmulqdq	ymm1, ymm1, ymmword ptr [rip + 322f], 17
	vpxor	ymm1, ymm1, ymm4
	vextracti128	xmm4, ymm2, 1
	vextracti128	xmm5, ymm0, 1
	vextracti128	xmm6, ymm3, 1
	vextracti128	xmm7, ymm1, 1
	vpxor	xmm0, xmm2, xmm0
	vpxor	xmm0, xmm4, xmm0
	vpxor	xmm2, xmm5, xmm3
	vpxor	xmm0, xmm0, xmm2
	vpxor	xmm1, xmm6, xmm1
	vpxor	xmm1, xmm1, xmm7
	vpxor	xmm0, xmm0, xmm1
	vpextrq	rax, xmm0, 1
	movabs	rdx, 5277230469828575232
	vmovq	xmm1, rdx
	vpclmulqdq	xmm0, xmm0, xmm1, 0
	vmovq	rdx, xmm0
	mov	rdi, rax
	shl	rdi, 32
	xor	rdi, rdx
	shr	rax, 32
	vmovq	xmm1, rdi
	movabs	rdx, -2502406310683738112
	vmovq	xmm2, rdx
	vpclmulqdq	xmm1, xmm1, xmm2, 0
	vpxor	xmm0, xmm1, xmm0
	vpextrq	rdx, xmm0, 1
	xor	eax, edx
	vmovd	xmm0, eax
	mov	eax, 3735491569
	vmovq	xmm1, rax
	vpclmulqdq	xmm0, xmm0, xmm1, 0
	vpmovzxdq	xmm0, xmm0
	movabs	rax, 4394350321
	vmovq	xmm1, rax
	vpclmulqdq	xmm0, xmm0, xmm1, 0
	vmovq	rdi, xmm0
	xor	rdi, rdx
	shr	rdi, 32
72:
	mov	rdx, rcx
	sub	rdx, r8
	and	rdx, -64
	add	rdx, r8
	mov	eax, edi
	cmp	r8, rdx
	jge	92f
	.p2align	4
82:
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
	jl	82b
92:
	test	cl, 32
	jne	152f
	test	cl, 16
	jne	162f
102:
	test	cl, 8
	jne	172f
112:
	test	cl, 4
	jne	182f
122:
	test	cl, 2
	jne	192f
132:
	test	cl, 1
	jne	202f
142:
	vzeroupper
	ret
152:
	crc32	rax, qword ptr [rsi + rdx]
	crc32	rax, qword ptr [rsi + rdx + 8]
	crc32	rax, qword ptr [rsi + rdx + 16]
	crc32	rax, qword ptr [rsi + rdx + 24]
	or	rdx, 32
	test	cl, 16
	je	102b
162:
	crc32	rax, qword ptr [rsi + rdx]
	crc32	rax, qword ptr [rsi + rdx + 8]
	add	rdx, 16
	test	cl, 8
	je	112b
172:
	crc32	rax, qword ptr [rsi + rdx]
	add	rdx, 8
	test	cl, 4
	je	122b
182:
	crc32	eax, dword ptr [rsi + rdx]
	add	rdx, 4
	test	cl, 2
	je	132b
192:
	crc32	eax, word ptr [rsi + rdx]
	add	rdx, 2
	test	cl, 1
	je	142b
202:
	crc32	eax, byte ptr [rsi + rdx]
	vzeroupper
	ret
	.p2align	3, 0x0
212:
	.quad	7311508529481777152
	.p2align	3, 0x0
222:
	.quad	8365178193191108608
	.p2align	3, 0x0
232:
	.quad	8668591446237904896
	.p2align	3, 0x0
242:
	.quad	-4163748391475478528
	.p2align	5, 0x0
252:
	.quad	1627051491397206016
	.zero	8
	.quad	-3949769517311197184
	.zero	8
	.p2align	5, 0x0
262:
	.zero	8
	.quad	-7620545986368110592
	.zero	8
	.quad	3703423898453278720
	.p2align	5, 0x0
272:
	.quad	2036429962822549504
	.zero	8
	.quad	2024689343301419008
	.zero	8
	.p2align	5, 0x0
282:
	.zero	8
	.quad	7892626757205884928
	.zero	8
	.quad	8483555033831440384
	.p2align	5, 0x0
292:
	.quad	-6598067393069580288
	.zero	8
	.quad	3732564607311544320
	.zero	8
	.p2align	5, 0x0
302:
	.zero	8
	.quad	6940368353756184576
	.zero	8
	.quad	-6767349809599741952
	.p2align	5, 0x0
312:
	.quad	3982298886646530048
	.zero	8
	.quad	-2502406310683738112
	.zero	8
	.p2align	5, 0x0
322:
	.zero	8
	.quad	3562862082850291712
	.zero	8
	.quad	426846842152550400

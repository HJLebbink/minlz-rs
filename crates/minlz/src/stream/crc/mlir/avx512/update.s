# minlz_crc32c_update of crates/minlz/mlir/crc32c_fold.mlir for avx512, written by
# cargo xtask mlir. Do not edit.
	mov	rcx, rdx
	cmp	rdx, 1024
	jb	2f
	mov	r8, rcx
	and	r8, -256
	vmovd	xmm0, edi
	movabs	rax, -7027104801687076864
	vmovq	xmm4, rax
	vpclmulqdq	xmm1, xmm0, xmm4, 0
	vpxor	xmm0, xmm0, xmm0
	movabs	rdx, -2912643801112034465
	mov	rax, rcx
	mul	rdx
	shr	rdx, 12
	cmp	rcx, 4864
	movabs	rax, -2502406310683738112
	jae	12f
	vpxor	xmm3, xmm3, xmm3
	vpxor	xmm2, xmm2, xmm2
	imul	rdx, rdx, 4864
	cmp	rdx, r8
	jl	42f
	jmp	62f
2:
	xor	r8d, r8d
	jmp	72f
12:
	push	r15
	push	r14
	push	r12
	push	rbx
	lea	rdi, [rsi + 4616]
	xor	r9d, r9d
	vpbroadcastq	zmm5, qword ptr [rip + 212f]
	vpbroadcastq	zmm6, qword ptr [rip + 222f]
	vpbroadcastq	zmm7, qword ptr [rip + 232f]
	vpbroadcastq	zmm8, qword ptr [rip + 242f]
	movabs	r10, -1610642981159698432
	vmovq	xmm9, r10
	vmovq	xmm10, rax
	mov	r10, rsi
	vpxor	xmm3, xmm3, xmm3
	vpxor	xmm2, xmm2, xmm2
	.p2align	4
22:
	mov	r15, -256
	mov	r12, r10
	xor	r11d, r11d
	xor	ebx, ebx
	xor	r14d, r14d
	.p2align	4
32:
	crc32	r14, qword ptr [rdi + r15 - 264]
	crc32	rbx, qword ptr [rdi + r15 - 8]
	crc32	r11, qword ptr [rdi + r15 + 248]
	crc32	r14, qword ptr [rdi + r15 - 256]
	crc32	rbx, qword ptr [rdi + r15]
	crc32	r11, qword ptr [rdi + r15 + 256]
	vpclmulqdq	zmm11, zmm1, zmm5, 0
	vpclmulqdq	zmm1, zmm1, zmm6, 17
	vpclmulqdq	zmm12, zmm0, zmm5, 0
	vpclmulqdq	zmm0, zmm0, zmm6, 17
	vpclmulqdq	zmm13, zmm3, zmm5, 0
	vpclmulqdq	zmm3, zmm3, zmm6, 17
	vpclmulqdq	zmm14, zmm2, zmm5, 0
	vpclmulqdq	zmm2, zmm2, zmm6, 17
	vpternlogq	zmm1, zmm11, zmmword ptr [r12], 150
	vpternlogq	zmm0, zmm12, zmmword ptr [r12 + 64], 150
	vpternlogq	zmm3, zmm13, zmmword ptr [r12 + 128], 150
	vpternlogq	zmm2, zmm14, zmmword ptr [r12 + 192], 150
	add	r12, 256
	add	r15, 16
	jne	32b
	vpclmulqdq	zmm11, zmm1, zmm7, 0
	vpclmulqdq	zmm1, zmm1, zmm8, 17
	vpclmulqdq	zmm12, zmm0, zmm7, 0
	vpclmulqdq	zmm0, zmm0, zmm8, 17
	vpxorq	zmm0, zmm0, zmm12
	vpclmulqdq	zmm12, zmm3, zmm7, 0
	vpclmulqdq	zmm3, zmm3, zmm8, 17
	vpxorq	zmm3, zmm3, zmm12
	vpclmulqdq	zmm12, zmm2, zmm7, 0
	vpclmulqdq	zmm2, zmm2, zmm8, 17
	vpxorq	zmm2, zmm2, zmm12
	vmovq	xmm12, r14
	vpclmulqdq	xmm12, xmm12, xmm9, 0
	vpternlogq	zmm12, zmm1, zmm11, 150
	vmovq	xmm1, rbx
	vpclmulqdq	xmm11, xmm1, xmm10, 0
	vmovq	xmm1, r11
	vpclmulqdq	xmm1, xmm1, xmm4, 0
	vpternlogq	zmm1, zmm12, zmm11, 150
	inc	r9
	add	r10, 4864
	add	rdi, 4864
	cmp	r9, rdx
	jne	22b
	pop	rbx
	pop	r12
	pop	r14
	pop	r15
	imul	rdx, rdx, 4864
	cmp	rdx, r8
	jge	62f
42:
	vpbroadcastq	zmm4, qword ptr [rip + 212f]
	vpbroadcastq	zmm5, qword ptr [rip + 222f]
	.p2align	4
52:
	vpclmulqdq	zmm6, zmm1, zmm4, 0
	vpclmulqdq	zmm1, zmm1, zmm5, 17
	vpclmulqdq	zmm7, zmm0, zmm4, 0
	vpclmulqdq	zmm0, zmm0, zmm5, 17
	vpclmulqdq	zmm8, zmm3, zmm4, 0
	vpclmulqdq	zmm3, zmm3, zmm5, 17
	vpclmulqdq	zmm9, zmm2, zmm4, 0
	vpclmulqdq	zmm2, zmm2, zmm5, 17
	vpternlogq	zmm1, zmm6, zmmword ptr [rsi + rdx], 150
	vpternlogq	zmm0, zmm7, zmmword ptr [rsi + rdx + 64], 150
	vpternlogq	zmm3, zmm8, zmmword ptr [rsi + rdx + 128], 150
	vpternlogq	zmm2, zmm9, zmmword ptr [rsi + rdx + 192], 150
	add	rdx, 256
	cmp	rdx, r8
	jl	52b
62:
	vpclmulqdq	zmm4, zmm1, zmmword ptr [rip + 252f], 0
	vpclmulqdq	zmm1, zmm1, zmmword ptr [rip + 262f], 17
	vpxorq	zmm1, zmm1, zmm4
	vpclmulqdq	zmm4, zmm0, zmmword ptr [rip + 272f], 0
	vpclmulqdq	zmm0, zmm0, zmmword ptr [rip + 282f], 17
	vpxorq	zmm0, zmm0, zmm4
	vpclmulqdq	zmm4, zmm3, zmmword ptr [rip + 292f], 0
	vpclmulqdq	zmm3, zmm3, zmmword ptr [rip + 302f], 17
	vpxorq	zmm3, zmm3, zmm4
	vpclmulqdq	zmm4, zmm2, zmmword ptr [rip + 312f], 0
	vpclmulqdq	zmm2, zmm2, zmmword ptr [rip + 322f], 17
	vpxorq	zmm2, zmm2, zmm4
	vextracti128	xmm4, ymm1, 1
	vextracti32x4	xmm5, zmm1, 2
	vextracti32x4	xmm6, zmm1, 3
	vpxor	xmm5, xmm5, xmm6
	vextracti128	xmm6, ymm0, 1
	vextracti32x4	xmm7, zmm0, 2
	vextracti32x4	xmm8, zmm0, 3
	vextracti128	xmm9, ymm3, 1
	vextracti32x4	xmm10, zmm3, 2
	vextracti32x4	xmm11, zmm3, 3
	vextracti128	xmm12, ymm2, 1
	vextracti32x4	xmm13, zmm2, 2
	vextracti32x4	xmm14, zmm2, 3
	vpxor	xmm1, xmm4, xmm1
	vpxor	xmm1, xmm1, xmm5
	vpxor	xmm0, xmm0, xmm6
	vpxor	xmm0, xmm0, xmm7
	vpxor	xmm0, xmm1, xmm0
	vpxor	xmm1, xmm8, xmm3
	vpxor	xmm1, xmm9, xmm1
	vpxor	xmm1, xmm10, xmm1
	vpxor	xmm0, xmm0, xmm1
	vpxor	xmm1, xmm11, xmm2
	vpxor	xmm1, xmm12, xmm1
	vpxor	xmm1, xmm13, xmm1
	vpxor	xmm1, xmm14, xmm1
	vpxor	xmm0, xmm0, xmm1
	vpextrq	rdx, xmm0, 1
	movabs	rdi, 5277230469828575232
	vmovq	xmm1, rdi
	vpclmulqdq	xmm0, xmm0, xmm1, 0
	vmovq	rdi, xmm0
	mov	r9, rdx
	shl	r9, 32
	xor	r9, rdi
	shr	rdx, 32
	vmovq	xmm1, r9
	vmovq	xmm2, rax
	vpclmulqdq	xmm1, xmm1, xmm2, 0
	vpxor	xmm0, xmm1, xmm0
	vpextrq	rax, xmm0, 1
	xor	edx, eax
	vmovd	xmm0, edx
	mov	edx, 3735491569
	vmovq	xmm1, rdx
	vpclmulqdq	xmm0, xmm0, xmm1, 0
	vpmovzxdq	xmm0, xmm0
	movabs	rdx, 4394350321
	vmovq	xmm1, rdx
	vpclmulqdq	xmm0, xmm0, xmm1, 0
	vmovq	rdi, xmm0
	xor	rdi, rax
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
	.quad	-1610642981159698432
	.p2align	3, 0x0
222:
	.quad	1452032738021343232
	.p2align	3, 0x0
232:
	.quad	8668591446237904896
	.p2align	3, 0x0
242:
	.quad	-4163748391475478528
	.p2align	6, 0x0
252:
	.quad	-3561372721336025088
	.zero	8
	.quad	964565967243837440
	.zero	8
	.quad	-1872356864881065984
	.zero	8
	.quad	8992487729031806976
	.zero	8
	.p2align	6, 0x0
262:
	.zero	8
	.quad	328135827831914496
	.zero	8
	.quad	-5966578592056868864
	.zero	8
	.quad	6270699677188882432
	.zero	8
	.quad	3587475578350993408
	.p2align	6, 0x0
272:
	.quad	-5986135871668092928
	.zero	8
	.quad	3605049029748064256
	.zero	8
	.quad	-3520782398465769472
	.zero	8
	.quad	7311508529481777152
	.zero	8
	.p2align	6, 0x0
282:
	.zero	8
	.quad	-4231685123306684416
	.zero	8
	.quad	4594071318164406272
	.zero	8
	.quad	-3507858708728119296
	.zero	8
	.quad	8365178193191108608
	.p2align	6, 0x0
292:
	.quad	1627051491397206016
	.zero	8
	.quad	-3949769517311197184
	.zero	8
	.quad	2036429962822549504
	.zero	8
	.quad	2024689343301419008
	.zero	8
	.p2align	6, 0x0
302:
	.zero	8
	.quad	-7620545986368110592
	.zero	8
	.quad	3703423898453278720
	.zero	8
	.quad	7892626757205884928
	.zero	8
	.quad	8483555033831440384
	.p2align	6, 0x0
312:
	.quad	-6598067393069580288
	.zero	8
	.quad	3732564607311544320
	.zero	8
	.quad	3982298886646530048
	.zero	8
	.quad	-2502406310683738112
	.zero	8
	.p2align	6, 0x0
322:
	.zero	8
	.quad	6940368353756184576
	.zero	8
	.quad	-6767349809599741952
	.zero	8
	.quad	3562862082850291712
	.zero	8
	.quad	426846842152550400

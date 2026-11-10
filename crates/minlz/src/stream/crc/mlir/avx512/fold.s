# minlz_crc32c_fold of crates/minlz/mlir/crc32c.mlir for avx512, written by
# cargo xtask mlir. Do not edit.
	push	r15
	push	r14
	push	rbx
	mov	rcx, rdx
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
	jae	2f
	vpxor	xmm3, xmm3, xmm3
	vpxor	xmm2, xmm2, xmm2
	jmp	32f
2:
	lea	rdi, [rsi + 4616]
	xor	r8d, r8d
	vpbroadcastq	zmm5, qword ptr [rip + 62f]
	vpbroadcastq	zmm6, qword ptr [rip + 72f]
	vpbroadcastq	zmm7, qword ptr [rip + 82f]
	vpbroadcastq	zmm8, qword ptr [rip + 92f]
	movabs	r9, -1610642981159698432
	vmovq	xmm9, r9
	vmovq	xmm10, rax
	mov	r9, rsi
	vpxor	xmm3, xmm3, xmm3
	vpxor	xmm2, xmm2, xmm2
	.p2align	4
12:
	mov	r14, -256
	mov	r15, r9
	xor	r10d, r10d
	xor	r11d, r11d
	xor	ebx, ebx
	.p2align	4
22:
	crc32	rbx, qword ptr [rdi + r14 - 264]
	crc32	r11, qword ptr [rdi + r14 - 8]
	crc32	r10, qword ptr [rdi + r14 + 248]
	crc32	rbx, qword ptr [rdi + r14 - 256]
	crc32	r11, qword ptr [rdi + r14]
	crc32	r10, qword ptr [rdi + r14 + 256]
	vpclmulqdq	zmm11, zmm1, zmm5, 0
	vpclmulqdq	zmm1, zmm1, zmm6, 17
	vpclmulqdq	zmm12, zmm0, zmm5, 0
	vpclmulqdq	zmm0, zmm0, zmm6, 17
	vpclmulqdq	zmm13, zmm3, zmm5, 0
	vpclmulqdq	zmm3, zmm3, zmm6, 17
	vpclmulqdq	zmm14, zmm2, zmm5, 0
	vpclmulqdq	zmm2, zmm2, zmm6, 17
	vpternlogq	zmm1, zmm11, zmmword ptr [r15], 150
	vpternlogq	zmm0, zmm12, zmmword ptr [r15 + 64], 150
	vpternlogq	zmm3, zmm13, zmmword ptr [r15 + 128], 150
	vpternlogq	zmm2, zmm14, zmmword ptr [r15 + 192], 150
	add	r15, 256
	add	r14, 16
	jne	22b
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
	vmovq	xmm12, rbx
	vpclmulqdq	xmm12, xmm12, xmm9, 0
	vpternlogq	zmm12, zmm1, zmm11, 150
	vmovq	xmm1, r11
	vpclmulqdq	xmm11, xmm1, xmm10, 0
	vmovq	xmm1, r10
	vpclmulqdq	xmm1, xmm1, xmm4, 0
	vpternlogq	zmm1, zmm12, zmm11, 150
	inc	r8
	add	r9, 4864
	add	rdi, 4864
	cmp	r8, rdx
	jne	12b
32:
	imul	rdx, rdx, 4864
	cmp	rdx, rcx
	jge	52f
	vpbroadcastq	zmm4, qword ptr [rip + 62f]
	vpbroadcastq	zmm5, qword ptr [rip + 72f]
	.p2align	4
42:
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
	cmp	rdx, rcx
	jl	42b
52:
	vpclmulqdq	zmm4, zmm1, zmmword ptr [rip + 102f], 0
	vpclmulqdq	zmm1, zmm1, zmmword ptr [rip + 112f], 17
	vpxorq	zmm1, zmm1, zmm4
	vpclmulqdq	zmm4, zmm0, zmmword ptr [rip + 122f], 0
	vpclmulqdq	zmm0, zmm0, zmmword ptr [rip + 132f], 17
	vpxorq	zmm0, zmm0, zmm4
	vpclmulqdq	zmm4, zmm3, zmmword ptr [rip + 142f], 0
	vpclmulqdq	zmm3, zmm3, zmmword ptr [rip + 152f], 17
	vpxorq	zmm3, zmm3, zmm4
	vpclmulqdq	zmm4, zmm2, zmmword ptr [rip + 162f], 0
	vpclmulqdq	zmm2, zmm2, zmmword ptr [rip + 172f], 17
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
	vpextrq	rcx, xmm0, 1
	movabs	rdx, 5277230469828575232
	vmovq	xmm1, rdx
	vpclmulqdq	xmm0, xmm0, xmm1, 0
	vmovq	rdx, xmm0
	mov	rsi, rcx
	shl	rsi, 32
	xor	rsi, rdx
	shr	rcx, 32
	vmovq	xmm1, rsi
	vmovq	xmm2, rax
	vpclmulqdq	xmm1, xmm1, xmm2, 0
	vpxor	xmm0, xmm1, xmm0
	vpextrq	rdx, xmm0, 1
	xor	ecx, edx
	vmovd	xmm0, ecx
	mov	eax, 3735491569
	vmovq	xmm1, rax
	vpclmulqdq	xmm0, xmm0, xmm1, 0
	vpmovzxdq	xmm0, xmm0
	movabs	rax, 4394350321
	vmovq	xmm1, rax
	vpclmulqdq	xmm0, xmm0, xmm1, 0
	vmovq	rax, xmm0
	xor	rax, rdx
	shr	rax, 32
	pop	rbx
	pop	r14
	pop	r15
	vzeroupper
	ret
	.p2align	3, 0x0
62:
	.quad	-1610642981159698432
	.p2align	3, 0x0
72:
	.quad	1452032738021343232
	.p2align	3, 0x0
82:
	.quad	8668591446237904896
	.p2align	3, 0x0
92:
	.quad	-4163748391475478528
	.p2align	6, 0x0
102:
	.quad	-3561372721336025088
	.zero	8
	.quad	964565967243837440
	.zero	8
	.quad	-1872356864881065984
	.zero	8
	.quad	8992487729031806976
	.zero	8
	.p2align	6, 0x0
112:
	.zero	8
	.quad	328135827831914496
	.zero	8
	.quad	-5966578592056868864
	.zero	8
	.quad	6270699677188882432
	.zero	8
	.quad	3587475578350993408
	.p2align	6, 0x0
122:
	.quad	-5986135871668092928
	.zero	8
	.quad	3605049029748064256
	.zero	8
	.quad	-3520782398465769472
	.zero	8
	.quad	7311508529481777152
	.zero	8
	.p2align	6, 0x0
132:
	.zero	8
	.quad	-4231685123306684416
	.zero	8
	.quad	4594071318164406272
	.zero	8
	.quad	-3507858708728119296
	.zero	8
	.quad	8365178193191108608
	.p2align	6, 0x0
142:
	.quad	1627051491397206016
	.zero	8
	.quad	-3949769517311197184
	.zero	8
	.quad	2036429962822549504
	.zero	8
	.quad	2024689343301419008
	.zero	8
	.p2align	6, 0x0
152:
	.zero	8
	.quad	-7620545986368110592
	.zero	8
	.quad	3703423898453278720
	.zero	8
	.quad	7892626757205884928
	.zero	8
	.quad	8483555033831440384
	.p2align	6, 0x0
162:
	.quad	-6598067393069580288
	.zero	8
	.quad	3732564607311544320
	.zero	8
	.quad	3982298886646530048
	.zero	8
	.quad	-2502406310683738112
	.zero	8
	.p2align	6, 0x0
172:
	.zero	8
	.quad	6940368353756184576
	.zero	8
	.quad	-6767349809599741952
	.zero	8
	.quad	3562862082850291712
	.zero	8
	.quad	426846842152550400

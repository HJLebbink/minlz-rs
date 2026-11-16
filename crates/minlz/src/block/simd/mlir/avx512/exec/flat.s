# minlz_exec_flat of crates/minlz/mlir/exec64.mlir for avx512, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 144
	mov	rcx, qword ptr [rdi]
	mov	rax, qword ptr [rdi + 8]
	mov	r8, qword ptr [rdi + 64]
	mov	rdx, qword ptr [rdi + 80]
	add	rdx, rcx
	mov	rsi, qword ptr [rdi + 88]
	mov	qword ptr [rsp + 80], rax
	add	rsi, rax
	test	r8, r8
	jle	532f
	lea	rbx, [rdi + 512]
	mov	eax, 192
	mov	qword ptr [rsp + 48], rax
	mov	eax, 7
	mov	qword ptr [rsp + 32], rax
	xor	r9d, r9d
	vmovdqa64	zmm22, zmmword ptr [rip + 542f]
	vpbroadcastb	zmm1, byte ptr [rip + 552f]
	vpbroadcastb	zmm2, byte ptr [rip + 562f]
	vpbroadcastd	zmm3, dword ptr [rip + 572f]
	vpternlogd	zmm4, zmm4, zmm4, 255
	vpbroadcastd	zmm5, dword ptr [rip + 582f]
	vpbroadcastd	zmm6, dword ptr [rip + 592f]
	vpxor	xmm7, xmm7, xmm7
	vbroadcasti32x4	zmm8, xmmword ptr [rip + 602f]
	vpbroadcastd	zmm9, dword ptr [rip + 612f]
	vmovdqa64	zmm10, zmmword ptr [rip + 622f]
	vpbroadcastd	zmm11, dword ptr [rip + 632f]
	vpbroadcastb	xmm12, byte ptr [rip + 642f]
	vpbroadcastb	xmm13, byte ptr [rip + 652f]
	mov	r10, rbx
	mov	rbp, r8
	xor	r12d, r12d
	mov	qword ptr [rsp + 88], r8
	jmp	12f
	.p2align	4
2:
	mov	rbp, qword ptr [rsp + 128]
	add	rbp, -64
	mov	r9, qword ptr [rsp + 136]
	inc	r9
	add	qword ptr [rsp + 48], 64
	add	qword ptr [rsp + 32], -64
	mov	r10, qword ptr [rsp + 56]
	add	r10, -64
	mov	r8, qword ptr [rsp + 88]
	mov	r12, qword ptr [rsp + 120]
	cmp	r12, r8
	jge	532f
12:
	cmp	rbp, 1
	mov	qword ptr [rsp + 128], rbp
	adc	rbp, 0
	cmp	rbp, 64
	mov	eax, 64
	cmovae	rbp, rax
	sub	r8, r12
	cmp	r8, 64
	mov	r14d, 64
	mov	qword ptr [rsp + 40], r8
	cmovb	r14, r8
	mov	r13, qword ptr [rdi + 16]
	mov	rax, qword ptr [rdi + 24]
	mov	qword ptr [rsp + 96], rax
	mov	rax, qword ptr [rdi + 32]
	mov	qword ptr [rsp + 104], rax
	mov	rax, qword ptr [rdi + 40]
	mov	qword ptr [rsp], rax
	mov	rax, qword ptr [rdi + 64]
	mov	r8, qword ptr [rdi + 72]
	mov	qword ptr [rsp + 64], r8
	mov	r8, qword ptr [rdi + 96]
	mov	qword ptr [rsp + 112], r8
	mov	r8, qword ptr [rdi + 112]
	mov	qword ptr [rsp + 8], r8
	mov	r8, qword ptr [rdi + 128]
	mov	qword ptr [rsp + 16], r8
	mov	r8, qword ptr [rdi + 136]
	mov	qword ptr [rsp + 72], r8
	lea	r15, [rax + 7]
	lea	r8, [r12 + 64]
	mov	qword ptr [rsp + 120], r8
	cmp	r8, r15
	mov	qword ptr [rsp + 136], r9
	mov	qword ptr [rsp + 56], r10
	jbe	22f
	cmp	r12, r15
	mov	r8, rbx
	jge	102f
	mov	r8, r9
	shl	r8, 6
	mov	r11d, 7
	sub	r11, r8
	add	r11, rax
	cmp	r11, 16
	jae	32f
	mov	r9, r12
	jmp	92f
	.p2align	4
22:
	add	r13, r12
	mov	r8, r13
	jmp	102f
32:
	add	r8, r13
	mov	r9, rdi
	sub	r9, r8
	add	r9, 511
	cmp	r9, 255
	jae	42f
	mov	r9, r12
	jmp	92f
42:
	cmp	r11, 256
	mov	qword ptr [rsp + 24], r11
	jae	52f
	xor	r11d, r11d
	jmp	72f
52:
	and	r11, -256
	lea	r9, [r12 + r11]
	mov	r8, qword ptr [rsp + 48]
	lea	rbx, [r13 + r8]
	mov	r8, qword ptr [rsp + 32]
	add	r8, rax
	and	r8, -256
	xor	r10d, r10d
	.p2align	4
62:
	vmovdqu64	zmm14, zmmword ptr [rbx + r10 - 192]
	vmovdqu64	zmm15, zmmword ptr [rbx + r10 - 128]
	vmovdqu64	zmm16, zmmword ptr [rbx + r10 - 64]
	vmovdqu64	zmm17, zmmword ptr [rbx + r10]
	vmovdqu64	zmmword ptr [rdi + r10 + 512], zmm14
	vmovdqu64	zmmword ptr [rdi + r10 + 576], zmm15
	vmovdqu64	zmmword ptr [rdi + r10 + 640], zmm16
	vmovdqu64	zmmword ptr [rdi + r10 + 704], zmm17
	add	r10, 256
	cmp	r8, r10
	jne	62b
	cmp	qword ptr [rsp + 24], r11
	lea	rbx, [rdi + 512]
	mov	r8, rbx
	mov	r10, qword ptr [rsp + 56]
	je	102f
	test	byte ptr [rsp + 24], -16
	je	92f
72:
	mov	r9, qword ptr [rsp + 24]
	and	r9, -16
	lea	r8, [r13 + r12]
	add	r12, r9
	add	rax, qword ptr [rsp + 32]
	and	rax, -16
	.p2align	4
82:
	vmovdqu	xmm14, xmmword ptr [r8 + r11]
	vmovdqu	xmmword ptr [rbx + r11], xmm14
	add	r11, 16
	cmp	rax, r11
	jne	82b
	cmp	qword ptr [rsp + 24], r9
	mov	r9, r12
	mov	r8, rbx
	je	102f
	.p2align	4
92:
	movzx	eax, byte ptr [r13 + r9]
	mov	byte ptr [r10 + r9], al
	inc	r9
	cmp	r15, r9
	jne	92b
	mov	r8, rbx
102:
	vmovdqu64	zmm14, zmmword ptr [r8]
	vpbroadcastb	zmm15, r14d
	vpcmpnleub	k2, zmm15, zmm22
	vptestmb	k1 {k2}, zmm14, zmm1
	vptestnmb	k2 {k2}, zmm14, zmm2
	mov	r10, qword ptr [rsp + 16]
	mov	rax, qword ptr [rsp + 96]
	vpexpandb	zmm15 {k1} {z}, zmmword ptr [rax + r10]
	vmovdqu64	zmmword ptr [rdi + 192], zmm15
	mov	rax, qword ptr [rsp + 72]
	mov	r8, qword ptr [rsp + 104]
	vpexpandb	zmm15 {k2} {z}, zmmword ptr [r8 + rax]
	vmovdqu64	zmmword ptr [rdi + 512], zmm14
	mov	rax, qword ptr [rsp + 64]
	shr	rax, 3
	lea	r8, [rax + 64]
	mov	r9, qword ptr [rsp + 8]
	cmp	r8, r9
	jbe	112f
	sub	r9, rax
	lea	r13, [rdi + 576]
	mov	r15, r13
	mov	r12, qword ptr [rsp]
	jbe	182f
	cmp	r9, 16
	mov	r11, rax
	jb	162f
	lea	rbx, [rax + r12]
	mov	r8, rdi
	sub	r8, rbx
	add	r8, 575
	cmp	r8, 255
	mov	r11, rax
	jb	162f
	cmp	r9, 256
	jae	122f
	xor	r14d, r14d
	jmp	142f
	.p2align	4
112:
	mov	r12, qword ptr [rsp]
	add	rax, r12
	mov	r15, rax
	lea	r13, [rdi + 576]
	jmp	182f
122:
	mov	r14, r9
	and	r14, -256
	lea	r11, [rax + r14]
	lea	r8, [r12 + rax + 192]
	xor	r10d, r10d
	.p2align	4
132:
	vmovdqu64	zmm16, zmmword ptr [r8 + r10 - 192]
	vmovdqu64	zmm17, zmmword ptr [r8 + r10 - 128]
	vmovdqu64	zmm18, zmmword ptr [r8 + r10 - 64]
	vmovdqu64	zmm19, zmmword ptr [r8 + r10]
	vmovdqu64	zmmword ptr [rdi + r10 + 576], zmm16
	vmovdqu64	zmmword ptr [rdi + r10 + 640], zmm17
	vmovdqu64	zmmword ptr [rdi + r10 + 704], zmm18
	vmovdqu64	zmmword ptr [rdi + r10 + 768], zmm19
	add	r10, 256
	cmp	r14, r10
	jne	132b
	cmp	r9, r14
	mov	r15, r13
	mov	r10, qword ptr [rsp + 16]
	je	182f
	test	r9b, -16
	je	162f
142:
	mov	r8, r9
	and	r8, -16
	lea	r11, [rax + r8]
	.p2align	4
152:
	vmovdqu64	xmm16, xmmword ptr [rbx + r14]
	vmovdqu64	xmmword ptr [r13 + r14], xmm16
	add	r14, 16
	cmp	r8, r14
	jne	152b
	cmp	r9, r8
	mov	r15, r13
	je	182f
	.p2align	4
162:
	mov	r8, r13
	sub	r8, rax
	mov	r9, qword ptr [rsp + 8]
	.p2align	4
172:
	movzx	eax, byte ptr [r12 + r11]
	mov	byte ptr [r8 + r11], al
	inc	r11
	cmp	r9, r11
	jne	172b
	mov	r15, r13
182:
	mov	rax, qword ptr [rsp + 112]
	vpbroadcastd	zmm17, eax
	vpmovzxbd	zmm16, xmm15
	vpsrld	zmm18, zmm16, 3
	vpmaxud	zmm18, zmm18, zmm3
	vpaddd	zmm18, zmm18, zmm4
	vpminud	zmm19, zmm16, zmm6
	vpandd	zmm19, zmm19, zmm6
	vpternlogd	zmm19, zmm16, zmm5, 248
	vpsllvd	zmm16, zmm19, zmm18
	vpsllvd	zmm19, zmm4, zmm18
	valignd	zmm20, zmm18, zmm7, 15
	vpaddd	zmm20, zmm20, zmm18
	valignq	zmm21, zmm20, zmm7, 7
	vpaddd	zmm20, zmm21, zmm20
	valignq	zmm21, zmm20, zmm7, 6
	vpaddd	zmm20, zmm21, zmm20
	valignq	zmm21, zmm20, zmm7, 4
	vpaddd	zmm20, zmm21, zmm20
	vpsubd	zmm18, zmm20, zmm18
	mov	r8, qword ptr [rsp + 64]
	mov	eax, r8d
	and	eax, 7
	vpbroadcastd	zmm21, eax
	vpaddd	zmm18, zmm18, zmm21
	vpsrld	zmm21, zmm18, 3
	vpandd	zmm18, zmm18, zmm5
	vpshufb	zmm21, zmm21, zmm8
	vpaddb	zmm21, zmm21, zmm9
	vpermb	zmm21, zmm21, zmmword ptr [r15]
	vpsrlvd	zmm18, zmm21, zmm18
	vpandnd	zmm18, zmm19, zmm18
	vpaddd	zmm16, zmm18, zmm16
	vptestmd	k3, zmm16, zmm16
	vpord	zmm16 {k3} {z}, zmm16, zmm10
	valignd	zmm18, zmm16, zmm7, 15
	vpmaxud	zmm16, zmm16, zmm18
	valignq	zmm18, zmm16, zmm7, 7
	vpmaxud	zmm16, zmm16, zmm18
	valignq	zmm18, zmm16, zmm7, 6
	vpmaxud	zmm16, zmm16, zmm18
	valignq	zmm18, zmm16, zmm7, 4
	vpmaxud	zmm16, zmm16, zmm18
	vptestmd	k3, zmm16, zmm16
	vpandd	zmm17 {k3}, zmm16, zmm11
	vpshufd	zmm16, zmm17, 255
	vshufi64x2	zmm16, zmm16, zmm16, 255
	vpsrlw	xmm18, xmm14, 2
	vpandq	xmm18, xmm18, xmm12
	vpminub	xmm18, xmm18, xmm13
	vpmovzxbd	zmm18, xmm18
	vpmaxud	zmm17, zmm17, zmm18
	vextracti32x4	xmm0, zmm20, 3
	vpextrd	r9d, xmm0, 3
	add	r9, r8
	vmovdqu64	zmmword ptr [rdi + 256], zmm17
	cmp	qword ptr [rsp + 40], 17
	jb	432f
	mov	rax, r9
	shr	rax, 3
	lea	r8, [rax + 64]
	mov	r11, qword ptr [rsp + 8]
	cmp	r8, r11
	jbe	192f
	sub	r11, rax
	mov	r12, r13
	jbe	262f
	cmp	r11, 16
	mov	rbx, rax
	jb	242f
	mov	r8, qword ptr [rsp]
	lea	r14, [rax + r8]
	mov	r8, rdi
	sub	r8, r14
	add	r8, 575
	cmp	r8, 255
	mov	rbx, rax
	jb	242f
	cmp	r11, 256
	jae	202f
	xor	r15d, r15d
	jmp	222f
	.p2align	4
192:
	add	rax, r12
	mov	r12, rax
	jmp	262f
202:
	mov	r15, r11
	and	r15, -256
	lea	rbx, [rax + r15]
	mov	r8, qword ptr [rsp]
	lea	r8, [r8 + rax + 192]
	xor	r10d, r10d
	.p2align	4
212:
	vmovdqu64	zmm0, zmmword ptr [r8 + r10 - 192]
	vmovdqu64	zmm17, zmmword ptr [r8 + r10 - 128]
	vmovdqu64	zmm18, zmmword ptr [r8 + r10 - 64]
	vmovdqu64	zmm19, zmmword ptr [r8 + r10]
	vmovdqu64	zmmword ptr [rdi + r10 + 576], zmm0
	vmovdqu64	zmmword ptr [rdi + r10 + 640], zmm17
	vmovdqu64	zmmword ptr [rdi + r10 + 704], zmm18
	vmovdqu64	zmmword ptr [rdi + r10 + 768], zmm19
	add	r10, 256
	cmp	r15, r10
	jne	212b
	cmp	r11, r15
	mov	r12, r13
	mov	r10, qword ptr [rsp + 16]
	je	262f
	test	r11b, -16
	je	242f
222:
	mov	r8, r11
	and	r8, -16
	lea	rbx, [rax + r8]
	.p2align	4
232:
	vmovdqu	xmm0, xmmword ptr [r14 + r15]
	vmovdqu	xmmword ptr [r13 + r15], xmm0
	add	r15, 16
	cmp	r8, r15
	jne	232b
	cmp	r11, r8
	mov	r12, r13
	je	262f
242:
	mov	r8, r13
	sub	r8, rax
	mov	r11, qword ptr [rsp]
	mov	r14, qword ptr [rsp + 8]
	.p2align	4
252:
	movzx	eax, byte ptr [r11 + rbx]
	mov	byte ptr [r8 + rbx], al
	inc	rbx
	cmp	r14, rbx
	jne	252b
	mov	r12, r13
262:
	vextracti128	xmm0, ymm15, 1
	vpmovzxbd	zmm0, xmm0
	vpsrld	zmm17, zmm0, 3
	vpmaxud	zmm17, zmm17, zmm3
	vpaddd	zmm17, zmm17, zmm4
	vpminud	zmm18, zmm0, zmm6
	vpandd	zmm18, zmm18, zmm6
	vpternlogd	zmm18, zmm0, zmm5, 248
	vpsllvd	zmm0, zmm18, zmm17
	vpsllvd	zmm18, zmm4, zmm17
	valignd	zmm19, zmm17, zmm7, 15
	vpaddd	zmm19, zmm19, zmm17
	valignq	zmm20, zmm19, zmm7, 7
	vpaddd	zmm19, zmm20, zmm19
	valignq	zmm20, zmm19, zmm7, 6
	vpaddd	zmm19, zmm20, zmm19
	valignq	zmm20, zmm19, zmm7, 4
	vpaddd	zmm19, zmm20, zmm19
	vpsubd	zmm17, zmm19, zmm17
	mov	eax, r9d
	and	eax, 7
	vpbroadcastd	zmm20, eax
	vpaddd	zmm17, zmm20, zmm17
	vpsrld	zmm20, zmm17, 3
	vpandd	zmm17, zmm17, zmm5
	vpshufb	zmm20, zmm20, zmm8
	vpaddb	zmm20, zmm20, zmm9
	vpermb	zmm20, zmm20, zmmword ptr [r12]
	vpsrlvd	zmm17, zmm20, zmm17
	vpandnd	zmm17, zmm18, zmm17
	vpaddd	zmm0, zmm17, zmm0
	vptestmd	k3, zmm0, zmm0
	vpord	zmm0 {k3} {z}, zmm0, zmm10
	valignd	zmm17, zmm0, zmm7, 15
	vpmaxud	zmm0, zmm0, zmm17
	valignq	zmm17, zmm0, zmm7, 7
	vpmaxud	zmm0, zmm0, zmm17
	valignq	zmm17, zmm0, zmm7, 6
	vpmaxud	zmm0, zmm0, zmm17
	valignq	zmm17, zmm0, zmm7, 4
	vpmaxud	zmm0, zmm0, zmm17
	vptestmd	k3, zmm0, zmm0
	vpandd	zmm16 {k3}, zmm0, zmm11
	vpshufd	zmm0, zmm16, 255
	vextracti32x4	xmm17, ymm14, 1
	vpsrlw	xmm17, xmm17, 2
	vpandq	xmm17, xmm17, xmm12
	vpminub	xmm17, xmm17, xmm13
	vpmovzxbd	zmm17, xmm17
	vpmaxud	zmm17, zmm16, zmm17
	vshufi64x2	zmm16, zmm0, zmm0, 255
	vextracti32x4	xmm0, zmm19, 3
	vpextrd	eax, xmm0, 3
	add	r9, rax
	vmovdqu64	zmmword ptr [rdi + 320], zmm17
	cmp	qword ptr [rsp + 40], 33
	jb	432f
	mov	rax, r9
	shr	rax, 3
	lea	r8, [rax + 64]
	mov	r11, qword ptr [rsp + 8]
	cmp	r8, r11
	jbe	272f
	sub	r11, rax
	mov	r12, r13
	jbe	342f
	cmp	r11, 16
	mov	rbx, rax
	jb	322f
	mov	r8, qword ptr [rsp]
	lea	r14, [rax + r8]
	mov	r8, rdi
	sub	r8, r14
	add	r8, 575
	cmp	r8, 255
	mov	rbx, rax
	jb	322f
	cmp	r11, 256
	jae	282f
	xor	r15d, r15d
	jmp	302f
272:
	add	rax, qword ptr [rsp]
	mov	r12, rax
	jmp	342f
282:
	mov	r15, r11
	and	r15, -256
	lea	rbx, [rax + r15]
	mov	r8, qword ptr [rsp]
	lea	r8, [r8 + rax + 192]
	xor	r10d, r10d
	.p2align	4
292:
	vmovdqu64	zmm0, zmmword ptr [r8 + r10 - 192]
	vmovdqu64	zmm17, zmmword ptr [r8 + r10 - 128]
	vmovdqu64	zmm18, zmmword ptr [r8 + r10 - 64]
	vmovdqu64	zmm19, zmmword ptr [r8 + r10]
	vmovdqu64	zmmword ptr [rdi + r10 + 576], zmm0
	vmovdqu64	zmmword ptr [rdi + r10 + 640], zmm17
	vmovdqu64	zmmword ptr [rdi + r10 + 704], zmm18
	vmovdqu64	zmmword ptr [rdi + r10 + 768], zmm19
	add	r10, 256
	cmp	r15, r10
	jne	292b
	cmp	r11, r15
	mov	r12, r13
	mov	r10, qword ptr [rsp + 16]
	je	342f
	test	r11b, -16
	je	322f
302:
	mov	r8, r11
	and	r8, -16
	lea	rbx, [rax + r8]
	.p2align	4
312:
	vmovdqu	xmm0, xmmword ptr [r14 + r15]
	vmovdqu	xmmword ptr [r13 + r15], xmm0
	add	r15, 16
	cmp	r8, r15
	jne	312b
	cmp	r11, r8
	mov	r12, r13
	je	342f
322:
	mov	r8, r13
	sub	r8, rax
	mov	r11, qword ptr [rsp]
	mov	r14, qword ptr [rsp + 8]
	.p2align	4
332:
	movzx	eax, byte ptr [r11 + rbx]
	mov	byte ptr [r8 + rbx], al
	inc	rbx
	cmp	r14, rbx
	jne	332b
	mov	r12, r13
342:
	vextracti32x4	xmm0, zmm15, 2
	vpmovzxbd	zmm0, xmm0
	vpsrld	zmm17, zmm0, 3
	vpmaxud	zmm17, zmm17, zmm3
	vpaddd	zmm17, zmm17, zmm4
	vpminud	zmm18, zmm0, zmm6
	vpandd	zmm18, zmm18, zmm6
	vpternlogd	zmm18, zmm0, zmm5, 248
	vpsllvd	zmm0, zmm18, zmm17
	vpsllvd	zmm18, zmm4, zmm17
	valignd	zmm19, zmm17, zmm7, 15
	vpaddd	zmm19, zmm19, zmm17
	valignq	zmm20, zmm19, zmm7, 7
	vpaddd	zmm19, zmm20, zmm19
	valignq	zmm20, zmm19, zmm7, 6
	vpaddd	zmm19, zmm20, zmm19
	valignq	zmm20, zmm19, zmm7, 4
	vpaddd	zmm19, zmm20, zmm19
	vpsubd	zmm17, zmm19, zmm17
	mov	eax, r9d
	and	eax, 7
	vpbroadcastd	zmm20, eax
	vpaddd	zmm17, zmm20, zmm17
	vpsrld	zmm20, zmm17, 3
	vpandd	zmm17, zmm17, zmm5
	vpshufb	zmm20, zmm20, zmm8
	vpaddb	zmm20, zmm20, zmm9
	vpermb	zmm20, zmm20, zmmword ptr [r12]
	vpsrlvd	zmm17, zmm20, zmm17
	vpandnd	zmm17, zmm18, zmm17
	vpaddd	zmm0, zmm17, zmm0
	vptestmd	k3, zmm0, zmm0
	vpord	zmm0 {k3} {z}, zmm0, zmm10
	valignd	zmm17, zmm0, zmm7, 15
	vpmaxud	zmm0, zmm0, zmm17
	valignq	zmm17, zmm0, zmm7, 7
	vpmaxud	zmm0, zmm0, zmm17
	valignq	zmm17, zmm0, zmm7, 6
	vpmaxud	zmm0, zmm0, zmm17
	valignq	zmm17, zmm0, zmm7, 4
	vpmaxud	zmm0, zmm0, zmm17
	vptestmd	k3, zmm0, zmm0
	vpandd	zmm16 {k3}, zmm0, zmm11
	vpshufd	zmm0, zmm16, 255
	vextracti32x4	xmm17, zmm14, 2
	vpsrlw	xmm17, xmm17, 2
	vpandq	xmm17, xmm17, xmm12
	vpminub	xmm17, xmm17, xmm13
	vpmovzxbd	zmm17, xmm17
	vpmaxud	zmm17, zmm16, zmm17
	vshufi64x2	zmm16, zmm0, zmm0, 255
	vextracti32x4	xmm0, zmm19, 3
	vpextrd	eax, xmm0, 3
	add	r9, rax
	vmovdqu64	zmmword ptr [rdi + 384], zmm17
	cmp	qword ptr [rsp + 40], 49
	jb	432f
	mov	rax, r9
	shr	rax, 3
	lea	r8, [rax + 64]
	mov	r11, qword ptr [rsp + 8]
	cmp	r8, r11
	jbe	352f
	sub	r11, rax
	mov	r12, r13
	jbe	422f
	cmp	r11, 16
	mov	rbx, rax
	jb	402f
	mov	r8, qword ptr [rsp]
	lea	r14, [rax + r8]
	mov	r8, rdi
	sub	r8, r14
	add	r8, 575
	cmp	r8, 255
	mov	rbx, rax
	jb	402f
	cmp	r11, 256
	jae	362f
	xor	r15d, r15d
	jmp	382f
352:
	mov	r12, qword ptr [rsp]
	add	r12, rax
	jmp	422f
362:
	mov	r15, r11
	and	r15, -256
	lea	rbx, [rax + r15]
	mov	r8, qword ptr [rsp]
	lea	r8, [r8 + rax + 192]
	xor	r10d, r10d
	.p2align	4
372:
	vmovdqu64	zmm0, zmmword ptr [r8 + r10 - 192]
	vmovdqu64	zmm17, zmmword ptr [r8 + r10 - 128]
	vmovdqu64	zmm18, zmmword ptr [r8 + r10 - 64]
	vmovdqu64	zmm19, zmmword ptr [r8 + r10]
	vmovdqu64	zmmword ptr [rdi + r10 + 576], zmm0
	vmovdqu64	zmmword ptr [rdi + r10 + 640], zmm17
	vmovdqu64	zmmword ptr [rdi + r10 + 704], zmm18
	vmovdqu64	zmmword ptr [rdi + r10 + 768], zmm19
	add	r10, 256
	cmp	r15, r10
	jne	372b
	cmp	r11, r15
	mov	r12, r13
	mov	r10, qword ptr [rsp + 16]
	je	422f
	test	r11b, -16
	je	402f
382:
	mov	r8, r11
	and	r8, -16
	lea	rbx, [rax + r8]
	.p2align	4
392:
	vmovdqu	xmm0, xmmword ptr [r14 + r15]
	vmovdqu	xmmword ptr [r13 + r15], xmm0
	add	r15, 16
	cmp	r8, r15
	jne	392b
	cmp	r11, r8
	mov	r12, r13
	je	422f
402:
	mov	r8, r13
	sub	r8, rax
	mov	r11, qword ptr [rsp]
	mov	r14, qword ptr [rsp + 8]
	.p2align	4
412:
	movzx	eax, byte ptr [r11 + rbx]
	mov	byte ptr [r8 + rbx], al
	inc	rbx
	cmp	r14, rbx
	jne	412b
	mov	r12, r13
422:
	vextracti32x4	xmm0, zmm15, 3
	vpmovzxbd	zmm0, xmm0
	vpsrld	zmm15, zmm0, 3
	vpmaxud	zmm15, zmm15, zmm3
	vpaddd	zmm15, zmm15, zmm4
	vpminud	zmm17, zmm0, zmm6
	vpandd	zmm17, zmm17, zmm6
	vpternlogd	zmm17, zmm0, zmm5, 248
	vpsllvd	zmm0, zmm17, zmm15
	vpsllvd	zmm17, zmm4, zmm15
	valignd	zmm18, zmm15, zmm7, 15
	vpaddd	zmm18, zmm18, zmm15
	valignq	zmm19, zmm18, zmm7, 7
	vpaddd	zmm18, zmm19, zmm18
	valignq	zmm19, zmm18, zmm7, 6
	vpaddd	zmm18, zmm19, zmm18
	valignq	zmm19, zmm18, zmm7, 4
	vpaddd	zmm18, zmm19, zmm18
	vpsubd	zmm15, zmm18, zmm15
	mov	eax, r9d
	and	eax, 7
	vpbroadcastd	zmm19, eax
	vpaddd	zmm15, zmm19, zmm15
	vpsrld	zmm19, zmm15, 3
	vpandd	zmm15, zmm15, zmm5
	vpshufb	zmm19, zmm19, zmm8
	vpaddb	zmm19, zmm19, zmm9
	vpermb	zmm19, zmm19, zmmword ptr [r12]
	vpsrlvd	zmm15, zmm19, zmm15
	vpandnd	zmm15, zmm17, zmm15
	vpaddd	zmm0, zmm15, zmm0
	vptestmd	k3, zmm0, zmm0
	vpord	zmm0 {k3} {z}, zmm0, zmm10
	valignd	zmm15, zmm0, zmm7, 15
	vpmaxud	zmm0, zmm0, zmm15
	valignq	zmm15, zmm0, zmm7, 7
	vpmaxud	zmm0, zmm0, zmm15
	valignq	zmm15, zmm0, zmm7, 6
	vpmaxud	zmm0, zmm0, zmm15
	valignq	zmm15, zmm0, zmm7, 4
	vpmaxud	zmm0, zmm0, zmm15
	vptestmd	k3, zmm0, zmm0
	vpandd	zmm16 {k3}, zmm0, zmm11
	vpshufd	zmm0, zmm16, 255
	vextracti32x4	xmm14, zmm14, 3
	vpsrlw	xmm14, xmm14, 2
	vpand	xmm14, xmm14, xmm12
	vpminub	xmm14, xmm14, xmm13
	vpmovzxbd	zmm14, xmm14
	vpmaxud	zmm14, zmm16, zmm14
	vshufi64x2	zmm16, zmm0, zmm0, 255
	vextracti32x4	xmm0, zmm18, 3
	vpextrd	eax, xmm0, 3
	add	r9, rax
	vmovdqu64	zmmword ptr [rdi + 448], zmm14
	.p2align	4
432:
	kmovq	rax, k2
	popcnt	rax, rax
	add	rax, qword ptr [rsp + 72]
	kmovq	r8, k1
	popcnt	r8, r8
	add	r8, r10
	vmovd	r10d, xmm16
	mov	qword ptr [rdi + 72], r9
	mov	qword ptr [rdi + 96], r10
	mov	qword ptr [rdi + 128], r8
	mov	qword ptr [rdi + 136], rax
	xor	eax, eax
	lea	rbx, [rdi + 512]
	.p2align	4
442:
	movzx	r9d, byte ptr [rdi + rax + 512]
	movzx	r8d, byte ptr [rdi + rax + 192]
	cmp	r8, 33
	mov	r10d, dword ptr [rdi + 4*rax + 256]
	vmovdqu	ymm0, ymmword ptr [rsi]
	vmovdqu	ymmword ptr [rdx], ymm0
	jae	482f
452:
	add	rdx, r8
	mov	r11, rdx
	sub	r11, r10
	cmp	r11, rcx
	jl	502f
	vmovdqu	ymm0, ymmword ptr [r11]
	vmovdqu	ymmword ptr [rdx], ymm0
	cmp	r9b, -124
	jae	512f
462:
	shr	r9d, 2
472:
	add	rdx, r9
	add	rsi, r8
	inc	rax
	cmp	rax, rbp
	jne	442b
	jmp	2b
482:
	mov	r8, qword ptr [rdi + 48]
	mov	r11, qword ptr [rdi + 120]
	movzx	r8d, byte ptr [r8 + r11]
	inc	r11
	mov	qword ptr [rdi + 120], r11
	add	r8, 33
	mov	r11d, 32
	.p2align	4
492:
	vmovdqu	ymm0, ymmword ptr [rsi + r11]
	vmovdqu	ymmword ptr [rdx + r11], ymm0
	add	r11, 32
	cmp	r11, r8
	jb	492b
	jmp	452b
502:
	mov	rbx, rdx
	sub	rbx, rcx
	sub	rbx, r10
	mov	r11d, 0
	cmovae	r11, rbx
	lea	rbx, [rdi + 512]
	add	r11, rcx
	vmovdqu	ymm0, ymmword ptr [r11]
	vmovdqu	ymmword ptr [rdx], ymm0
	cmp	r9b, -124
	jb	462b
512:
	mov	r9, qword ptr [rdi + 48]
	mov	r10, qword ptr [rdi + 120]
	movzx	r9d, byte ptr [r9 + r10]
	inc	r10
	mov	qword ptr [rdi + 120], r10
	add	r9, 33
	mov	r10d, 32
	.p2align	4
522:
	vmovdqu	ymm0, ymmword ptr [r11 + r10]
	vmovdqu	ymmword ptr [rdx + r10], ymm0
	add	r10, 32
	cmp	r10, r9
	jb	522b
	jmp	472b
532:
	sub	rdx, rcx
	sub	rsi, qword ptr [rsp + 80]
	mov	qword ptr [rdi + 80], rdx
	mov	qword ptr [rdi + 88], rsi
	add	rsp, 144
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	vzeroupper
	ret
	.p2align	6, 0x0
542:
	.byte	0
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
	.p2align	6, 0x0
552:
	.byte	2
	.p2align	6, 0x0
562:
	.byte	1
	.p2align	2, 0x0
572:
	.long	1
	.p2align	2, 0x0
582:
	.long	7
	.p2align	2, 0x0
592:
	.long	8
	.p2align	4, 0x0
602:
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
612:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	6, 0x0
622:
	.long	134217728
	.long	268435456
	.long	402653184
	.long	536870912
	.long	671088640
	.long	805306368
	.long	939524096
	.long	1073741824
	.long	1207959552
	.long	1342177280
	.long	1476395008
	.long	1610612736
	.long	1744830464
	.long	1879048192
	.long	2013265920
	.long	2147483648
	.p2align	2, 0x0
632:
	.long	134217727
	.p2align	6, 0x0
642:
	.byte	63
	.p2align	6, 0x0
652:
	.byte	32

# minlz_pivco_exec of crates/minlz/mlir/pivco.mlir for avx2, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 88
	mov	r15, qword ptr [rdi + 8]
	test	r15, r15
	je	102f
	mov	r14, rdi
	mov	r13, qword ptr [rdi]
	mov	rbp, qword ptr [rdi + 16]
	mov	rax, qword ptr [rdi + 24]
	mov	qword ptr [rsp + 16], rax
	mov	rax, qword ptr [rdi + 32]
	mov	qword ptr [rsp + 24], rax
	mov	r12, qword ptr [rdi + 40]
	mov	rax, qword ptr [rdi + 48]
	mov	qword ptr [rsp + 80], rax
	mov	rax, qword ptr [rdi + 56]
	mov	qword ptr [rsp + 72], rax
	mov	rax, qword ptr [rdi + 64]
	mov	qword ptr [rsp + 56], rax
	mov	rax, qword ptr [rdi + 72]
	mov	qword ptr [rsp + 64], rax
	mov	rax, qword ptr [rdi + 80]
	mov	qword ptr [rsp + 32], rax
	sub	r14, -128
	xor	ebx, ebx
	mov	qword ptr [rsp + 48], r15
	mov	qword ptr [rsp + 40], rbp
	mov	qword ptr [rsp + 8], r12
	jmp	32f
2:
	cmp	r8b, 9
	setb	r9b
	add	r11, 7
	shr	r11, 3
	add	r11, rsi
	mov	r12, qword ptr [rsp + 16]
	cmp	r11, r12
	setbe	r11b
	and	r11b, r9b
	and	cl, r11b
	cmp	cl, 1
	jne	122f
	mov	r9, r12
	sub	r9, rsi
	mov	qword ptr [rsp], r14
	mov	rsi, rax
	mov	rcx, r8
	mov	r8, r9
	mov	r9, r10
	call	132f
12:
	mov	r12, qword ptr [rsp + 8]
22:
	inc	rbx
	add	r13, 32
	cmp	r15, rbx
	je	112f
32:
	movzx	r8d, byte ptr [r13 + 2]
	cmp	r8, 2
	setae	cl
	movzx	r10d, byte ptr [r13 + 3]
	mov	edx, dword ptr [r13 + 8]
	mov	eax, dword ptr [r13 + 20]
	test	byte ptr [r13 + 1], 1
	mov	rdi, qword ptr [rsp + 80]
	cmove	rdi, qword ptr [rsp + 24]
	mov	rsi, qword ptr [rsp + 72]
	cmove	rsi, r12
	cmp	r8, 8
	mov	r9d, 8
	cmovb	r9, r8
	mov	r11d, 1
	shlx	r9, r11, r9
	add	r9, r10
	cmp	r9, qword ptr [rsp + 64]
	lea	r9, [rax + rdx]
	setbe	r11b
	cmp	r9, rsi
	ja	122f
	mov	esi, dword ptr [r13 + 16]
	add	rdi, rax
	lea	rax, [rbp + rsi]
	movzx	r9d, byte ptr [r13]
	cmp	r9d, 2
	jle	42f
	and	cl, r11b
	add	r10, qword ptr [rsp + 56]
	mov	r11, rdx
	imul	r11, r8
	cmp	r9d, 4
	jg	52f
	cmp	r9d, 3
	je	62f
	cmp	r9d, 4
	jne	122f
	mov	r9d, 16
	mov	r12d, 128
	jmp	72f
	.p2align	4
42:
	mov	r12d, dword ptr [r13 + 12]
	mov	r11d, dword ptr [r13 + 28]
	lea	rcx, [rdx + 7]
	shr	rcx, 3
	add	rcx, rsi
	mov	rsi, qword ptr [rsp + 24]
	lea	r8, [rsi + r11]
	add	r11, rdx
	test	r9d, r9d
	je	92f
	cmp	r9d, 1
	je	82f
	cmp	r9d, 2
	jne	122f
	cmp	rcx, qword ptr [rsp + 16]
	ja	122f
	movzx	r8d, byte ptr [r13 + 4]
	mov	rsi, rdx
	mov	rdx, rax
	mov	rcx, r10
	call	1782f
	jmp	12b
	.p2align	4
52:
	cmp	r9d, 5
	je	2b
	cmp	r9d, 6
	jne	122f
	cmp	r8d, 8
	jne	122f
	add	rsi, rdx
	cmp	rsi, qword ptr [rsp + 16]
	ja	122f
	mov	rsi, rax
	call	1942f
	jmp	22b
62:
	mov	r9d, 64
	mov	r12d, 512
72:
	cmp	r8b, 8
	setb	r15b
	lea	ebp, [r12 - 1]
	test	ebp, edx
	sete	bpl
	shr	r11, 3
	add	r11, rsi
	cmp	r11, qword ptr [rsp + 16]
	setbe	sil
	and	bpl, r15b
	and	bpl, sil
	and	cl, bpl
	cmp	cl, 1
	jne	122f
	rep		bsf	rcx, r12
	shrx	rdx, rdx, rcx
	mov	rsi, rax
	mov	rcx, r10
	call	2162f
	mov	r15, qword ptr [rsp + 48]
	mov	rbp, qword ptr [rsp + 40]
	jmp	12b
82:
	cmp	rcx, qword ptr [rsp + 16]
	ja	122f
	cmp	r11, qword ptr [rsp + 8]
	ja	122f
	mov	rsi, rdx
	mov	rdx, rax
	mov	rcx, r8
	mov	r8, r10
	mov	r9, qword ptr [rsp + 32]
	call	2422f
	cmp	rax, r12
	mov	r12, qword ptr [rsp + 8]
	je	22b
	jmp	122f
92:
	cmp	rcx, qword ptr [rsp + 16]
	ja	122f
	mov	ecx, dword ptr [r13 + 24]
	lea	rsi, [rcx + rdx]
	mov	r9, qword ptr [rsp + 8]
	cmp	rsi, r9
	ja	122f
	cmp	r11, r9
	ja	122f
	add	rcx, qword ptr [rsp + 24]
	mov	rsi, rdx
	mov	rdx, rax
	mov	r9, qword ptr [rsp + 32]
	call	2602f
	cmp	rax, r12
	mov	r12, qword ptr [rsp + 8]
	je	22b
	jmp	122f
102:
	xor	ebx, ebx
	jmp	122f
112:
	mov	rbx, r15
122:
	mov	rax, rbx
	add	rsp, 88
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
	.p2align	4
132:
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 544
	mov	rax, qword ptr [rsp + 592]
	vmovdqu	ymm10, ymmword ptr [r9]
	cmp	rcx, 4
	jle	372f
	vmovdqu	ymm7, ymmword ptr [r9 + 32]
	cmp	rcx, 6
	jg	582f
	cmp	rcx, 5
	jne	1272f
	cmp	rdx, 64
	setb	cl
	cmp	r8, 64
	setb	r9b
	or	r9b, cl
	jne	152f
	vbroadcasti128	ymm1, xmmword ptr [rip + 2782f]
	vbroadcasti128	ymm2, xmmword ptr [rip + 2792f]
	vbroadcasti128	ymm3, xmmword ptr [rip + 2802f]
	vpermq	ymm4, ymm10, 68
	vpermq	ymm5, ymm10, 238
	add	r8, -40
	.p2align	4
142:
	vmovdqu	xmm6, xmmword ptr [rsi]
	vmovdqu	xmm7, xmmword ptr [rsi + 20]
	vinserti128	ymm6, ymm6, xmmword ptr [rsi + 10], 1
	vpshufb	ymm8, ymm6, ymm1
	vpshufb	ymm6, ymm6, ymm2
	vmovdqa	ymm9, ymm3
	#APP
	#NO_APP
	vpmullw	ymm8, ymm9, ymm8
	vmovdqa	ymm9, ymm3
	#APP
	#NO_APP
	vpmullw	ymm6, ymm9, ymm6
	vpsrlw	ymm8, ymm8, 11
	vpsrlw	ymm6, ymm6, 11
	vpackuswb	ymm6, ymm8, ymm6
	vinserti128	ymm7, ymm7, xmmword ptr [rsi + 30], 1
	vpshufb	ymm8, ymm7, ymm1
	vpshufb	ymm7, ymm7, ymm2
	vmovdqa	ymm9, ymm3
	#APP
	#NO_APP
	vpmullw	ymm8, ymm9, ymm8
	vmovdqa	ymm9, ymm3
	#APP
	#NO_APP
	vpmullw	ymm7, ymm9, ymm7
	vpsrlw	ymm8, ymm8, 11
	vpsrlw	ymm7, ymm7, 11
	vpackuswb	ymm7, ymm8, ymm7
	vpshufb	ymm8, ymm4, ymm6
	vpshufb	ymm9, ymm5, ymm6
	vpsllw	ymm6, ymm6, 3
	vpblendvb	ymm6, ymm8, ymm9, ymm6
	vpshufb	ymm8, ymm4, ymm7
	vpshufb	ymm9, ymm5, ymm7
	vpsllw	ymm7, ymm7, 3
	vpblendvb	ymm7, ymm8, ymm9, ymm7
	vmovdqu	ymmword ptr [rdi + 32], ymm7
	vmovdqu	ymmword ptr [rdi], ymm6
	add	rdi, 64
	add	rsi, 40
	add	rdx, -64
	cmp	rdx, 64
	jb	152f
	cmp	r8, 63
	lea	r8, [r8 - 40]
	ja	142b
152:
	test	rdx, rdx
	je	1772f
	vbroadcasti128	ymm1, xmmword ptr [rip + 2782f]
	vbroadcasti128	ymm2, xmmword ptr [rip + 2792f]
	vbroadcasti128	ymm3, xmmword ptr [rip + 2802f]
	vpermq	ymm4, ymm10, 68
	vpermq	ymm0, ymm10, 238
	lea	rcx, [rdi + 32]
	jmp	182f
	.p2align	4
162:
	vmovdqu	ymmword ptr [rcx - 32], ymm5
	vmovdqu	ymmword ptr [rcx], ymm6
172:
	add	rdi, 64
	add	rsi, 40
	add	rcx, 64
	sub	rdx, r8
	je	1772f
182:
	cmp	rdx, 64
	mov	r8d, 64
	cmovb	r8, rdx
	lea	r9, [r8 + 4*r8 + 7]
	mov	r10d, r9d
	shr	r10d, 3
	mov	r11d, r10d
	and	r11d, 7
	and	r10d, 248
	cmp	r11, 4
	jb	192f
	lea	ebx, [8*r11]
	add	r11, r10
	mov	r14d, dword ptr [rsi + r10]
	mov	r11d, dword ptr [rsi + r11 - 4]
	add	bl, -32
	jmp	202f
	.p2align	4
192:
	cmp	r11d, 2
	jb	312f
	lea	ebx, [8*r11]
	add	r11, r10
	movzx	r14d, word ptr [rsi + r10]
	movzx	r11d, word ptr [rsi + r11 - 2]
	add	bl, -16
202:
	shlx	r11, r11, rbx
	or	r11, r14
212:
	vmovq	xmm5, r11
	vpxor	xmm6, xmm6, xmm6
	test	r9b, 64
	jne	292f
	test	r9b, r9b
	js	302f
222:
	test	r9d, 256
	je	242f
232:
	vmovdqa	ymm6, ymm5
	vmovdqu	ymm5, ymmword ptr [rsi]
242:
	vmovdqu	ymmword ptr [rax], ymm5
	vmovdqu	ymmword ptr [rax + 32], ymm6
	vextracti128	xmm6, ymm5, 1
	vpalignr	xmm6, xmm6, xmm5, 10
	vinserti128	ymm5, ymm5, xmm6, 1
	vpshufb	ymm6, ymm5, ymm1
	vpshufb	ymm5, ymm5, ymm2
	vmovdqa	ymm7, ymm3
	#APP
	#NO_APP
	vpmullw	ymm6, ymm7, ymm6
	vmovdqa	ymm7, ymm3
	#APP
	#NO_APP
	vpmullw	ymm5, ymm7, ymm5
	vpsrlw	ymm6, ymm6, 11
	vpsrlw	ymm5, ymm5, 11
	vpackuswb	ymm5, ymm6, ymm5
	vmovdqu	xmm6, xmmword ptr [rax + 20]
	vinserti128	ymm6, ymm6, xmmword ptr [rax + 30], 1
	vpshufb	ymm7, ymm6, ymm1
	vpshufb	ymm6, ymm6, ymm2
	vmovdqa	ymm8, ymm3
	#APP
	#NO_APP
	vpmullw	ymm7, ymm8, ymm7
	vmovdqa	ymm8, ymm3
	#APP
	#NO_APP
	vpmullw	ymm6, ymm8, ymm6
	vpsrlw	ymm7, ymm7, 11
	vpsrlw	ymm6, ymm6, 11
	vpackuswb	ymm6, ymm7, ymm6
	vpshufb	ymm7, ymm4, ymm5
	vpshufb	ymm8, ymm0, ymm5
	vpsllw	ymm5, ymm5, 3
	vpblendvb	ymm5, ymm7, ymm8, ymm5
	vpshufb	ymm7, ymm4, ymm6
	vpshufb	ymm8, ymm0, ymm6
	vpsllw	ymm6, ymm6, 3
	vpblendvb	ymm6, ymm7, ymm8, ymm6
	cmp	rdx, 64
	jae	162b
	cmp	rdx, 32
	mov	r9, rdi
	jb	252f
	vmovdqu	ymmword ptr [rcx - 32], ymm5
	mov	r9, rcx
	vmovdqa	ymm5, ymm6
	vpxor	xmm6, xmm6, xmm6
252:
	test	r8b, 16
	je	262f
	vmovdqu	xmmword ptr [r9], xmm5
	vperm2i128	ymm5, ymm5, ymm6, 33
	add	r9, 16
262:
	vmovq	r11, xmm5
	vpextrq	r10, xmm5, 1
	test	r8b, 8
	cmove	r10, r11
	jne	322f
	test	r8b, 4
	jne	332f
272:
	test	r8b, 2
	jne	342f
282:
	test	r8b, 1
	je	172b
	jmp	352f
	.p2align	4
292:
	vpermq	ymm6, ymm5, 255
	vmovq	xmm6, xmm6
	vpermq	ymm5, ymm5, 144
	vmovq	xmm7, qword ptr [rsi + r10 - 8]
	add	r10, -8
	vpblendd	ymm5, ymm5, ymm7, 3
	test	r9b, r9b
	jns	222b
302:
	vmovdqu	xmm7, xmmword ptr [r10 + rsi - 16]
	vperm2i128	ymm6, ymm5, ymm6, 33
	vinserti128	ymm5, ymm7, xmm5, 1
	test	r9d, 256
	jne	232b
	jmp	242b
	.p2align	4
312:
	cmp	r11d, 1
	jne	362f
	movzx	r11d, byte ptr [rsi + r10]
	jmp	212b
	.p2align	4
322:
	mov	qword ptr [r9], r11
	add	r9, 8
	test	r8b, 4
	je	272b
332:
	mov	dword ptr [r9], r10d
	add	r9, 4
	shr	r10, 32
	test	r8b, 2
	je	282b
342:
	mov	word ptr [r9], r10w
	add	r9, 2
	shr	r10, 16
	test	r8b, 1
	je	172b
352:
	mov	byte ptr [r9], r10b
	jmp	172b
362:
	xor	r11d, r11d
	jmp	212b
372:
	cmp	rcx, 2
	je	822f
	cmp	rcx, 3
	jne	1032f
	cmp	rdx, 64
	setb	cl
	cmp	r8, 64
	setb	r9b
	or	r9b, cl
	jne	392f
	vbroadcasti128	ymm1, xmmword ptr [rip + 2812f]
	vbroadcasti128	ymm2, xmmword ptr [rip + 2822f]
	vbroadcasti128	ymm3, xmmword ptr [rip + 2832f]
	vpermq	ymm4, ymm10, 68
	add	r8, -24
	.p2align	4
382:
	vmovdqu	xmm5, xmmword ptr [rsi]
	vmovdqu	xmm6, xmmword ptr [rsi + 12]
	vinserti128	ymm5, ymm5, xmmword ptr [rsi + 6], 1
	vpshufb	ymm7, ymm5, ymm1
	vpshufb	ymm5, ymm5, ymm2
	vmovdqa	ymm8, ymm3
	#APP
	#NO_APP
	vpmullw	ymm7, ymm8, ymm7
	vmovdqa	ymm8, ymm3
	#APP
	#NO_APP
	vpmullw	ymm5, ymm8, ymm5
	vpsrlw	ymm7, ymm7, 13
	vpsrlw	ymm5, ymm5, 13
	vpackuswb	ymm5, ymm7, ymm5
	vinserti128	ymm6, ymm6, xmmword ptr [rsi + 18], 1
	vpshufb	ymm7, ymm6, ymm1
	vpshufb	ymm6, ymm6, ymm2
	vmovdqa	ymm8, ymm3
	#APP
	#NO_APP
	vpmullw	ymm7, ymm8, ymm7
	vmovdqa	ymm8, ymm3
	#APP
	#NO_APP
	vpmullw	ymm6, ymm8, ymm6
	vpsrlw	ymm7, ymm7, 13
	vpsrlw	ymm6, ymm6, 13
	vpackuswb	ymm6, ymm7, ymm6
	vpshufb	ymm5, ymm4, ymm5
	vpshufb	ymm6, ymm4, ymm6
	vmovdqu	ymmword ptr [rdi + 32], ymm6
	vmovdqu	ymmword ptr [rdi], ymm5
	add	rdi, 64
	add	rsi, 24
	add	rdx, -64
	cmp	rdx, 64
	jb	392f
	cmp	r8, 63
	lea	r8, [r8 - 24]
	ja	382b
392:
	test	rdx, rdx
	je	1772f
	vbroadcasti128	ymm1, xmmword ptr [rip + 2812f]
	vbroadcasti128	ymm2, xmmword ptr [rip + 2822f]
	vbroadcasti128	ymm3, xmmword ptr [rip + 2832f]
	vpermq	ymm0, ymm10, 68
	lea	rcx, [rdi + 32]
	jmp	422f
	.p2align	4
402:
	vmovdqu	ymmword ptr [rcx - 32], ymm4
	vmovdqu	ymmword ptr [rcx], ymm5
412:
	add	rdi, 64
	add	rsi, 24
	add	rcx, 64
	sub	rdx, r8
	je	1772f
422:
	cmp	rdx, 64
	mov	r8d, 64
	cmovb	r8, rdx
	lea	r10, [r8 + 2*r8 + 7]
	mov	r9d, r10d
	shr	r9d, 3
	mov	r11d, r9d
	and	r11d, 7
	and	r9d, 120
	cmp	r11, 4
	jb	432f
	lea	ebx, [8*r11]
	add	r11, r9
	mov	r14d, dword ptr [rsi + r9]
	mov	r11d, dword ptr [rsi + r11 - 4]
	add	bl, -32
	jmp	442f
	.p2align	4
432:
	cmp	r11d, 2
	jb	522f
	lea	ebx, [8*r11]
	add	r11, r9
	movzx	r14d, word ptr [rsi + r9]
	movzx	r11d, word ptr [rsi + r11 - 2]
	add	bl, -16
442:
	shlx	r11, r11, rbx
	or	r11, r14
452:
	vmovq	xmm4, r11
	vpxor	xmm5, xmm5, xmm5
	test	r10b, 64
	je	462f
	vpermq	ymm5, ymm4, 255
	vmovq	xmm5, xmm5
	vpermq	ymm4, ymm4, 144
	vmovq	xmm6, qword ptr [rsi + r9 - 8]
	add	r9, -8
	vpblendd	ymm4, ymm4, ymm6, 3
462:
	test	r10b, r10b
	jns	472f
	vmovdqu	xmm6, xmmword ptr [r9 + rsi - 16]
	vperm2i128	ymm5, ymm4, ymm5, 33
	vinserti128	ymm4, ymm6, xmm4, 1
472:
	vmovdqu	ymmword ptr [rax], ymm4
	vmovdqu	ymmword ptr [rax + 32], ymm5
	vextracti128	xmm5, ymm4, 1
	vpalignr	xmm5, xmm5, xmm4, 6
	vinserti128	ymm4, ymm4, xmm5, 1
	vpshufb	ymm5, ymm4, ymm1
	vpshufb	ymm4, ymm4, ymm2
	vmovdqa	ymm6, ymm3
	#APP
	#NO_APP
	vpmullw	ymm5, ymm6, ymm5
	vmovdqa	ymm6, ymm3
	#APP
	#NO_APP
	vpmullw	ymm4, ymm6, ymm4
	vpsrlw	ymm5, ymm5, 13
	vpsrlw	ymm4, ymm4, 13
	vpackuswb	ymm4, ymm5, ymm4
	vmovdqu	xmm5, xmmword ptr [rax + 12]
	vinserti128	ymm5, ymm5, xmmword ptr [rax + 18], 1
	vpshufb	ymm6, ymm5, ymm1
	vpshufb	ymm5, ymm5, ymm2
	vmovdqa	ymm7, ymm3
	#APP
	#NO_APP
	vpmullw	ymm6, ymm7, ymm6
	vmovdqa	ymm7, ymm3
	#APP
	#NO_APP
	vpmullw	ymm5, ymm7, ymm5
	vpsrlw	ymm6, ymm6, 13
	vpsrlw	ymm5, ymm5, 13
	vpackuswb	ymm5, ymm6, ymm5
	vpshufb	ymm4, ymm0, ymm4
	vpshufb	ymm5, ymm0, ymm5
	cmp	rdx, 64
	jae	402b
	cmp	rdx, 32
	mov	r9, rdi
	jb	482f
	vmovdqu	ymmword ptr [rcx - 32], ymm4
	mov	r9, rcx
	vmovdqa	ymm4, ymm5
	vpxor	xmm5, xmm5, xmm5
482:
	test	r8b, 16
	je	492f
	vmovdqu	xmmword ptr [r9], xmm4
	vperm2i128	ymm4, ymm4, ymm5, 33
	add	r9, 16
492:
	vmovq	r11, xmm4
	vpextrq	r10, xmm4, 1
	test	r8b, 8
	cmove	r10, r11
	jne	532f
	test	r8b, 4
	jne	542f
502:
	test	r8b, 2
	jne	552f
512:
	test	r8b, 1
	je	412b
	jmp	562f
	.p2align	4
522:
	cmp	r11d, 1
	jne	572f
	movzx	r11d, byte ptr [rsi + r9]
	jmp	452b
	.p2align	4
532:
	mov	qword ptr [r9], r11
	add	r9, 8
	test	r8b, 4
	je	502b
542:
	mov	dword ptr [r9], r10d
	add	r9, 4
	shr	r10, 32
	test	r8b, 2
	je	512b
552:
	mov	word ptr [r9], r10w
	add	r9, 2
	shr	r10, 16
	test	r8b, 1
	je	412b
562:
	mov	byte ptr [r9], r10b
	jmp	412b
572:
	xor	r11d, r11d
	jmp	452b
582:
	cmp	rcx, 7
	jne	1292f
	vmovdqu	ymm2, ymmword ptr [r9 + 64]
	vmovdqu	ymm4, ymmword ptr [r9 + 96]
	cmp	rdx, 64
	setb	cl
	cmp	r8, 64
	setb	r9b
	or	r9b, cl
	vpermq	ymm0, ymm2, 68
	vmovdqu	ymmword ptr [rsp + 96], ymm0
	vpermq	ymm0, ymm2, 238
	vmovdqu	ymmword ptr [rsp + 64], ymm0
	vpermq	ymm0, ymm4, 68
	vmovdqu	ymmword ptr [rsp + 32], ymm0
	vpermq	ymm0, ymm4, 238
	vmovdqu	ymmword ptr [rsp], ymm0
	vmovdqu	ymmword ptr [rsp + 160], ymm10
	vmovdqu	ymmword ptr [rsp + 128], ymm7
	jne	602f
	vpermq	ymm8, ymm10, 68
	vpermq	ymm9, ymm10, 238
	vpermq	ymm11, ymm7, 68
	vpermq	ymm12, ymm7, 238
	add	r8, -56
	vmovdqu	ymm3, ymmword ptr [rsp + 64]
	vmovdqu	ymm4, ymmword ptr [rsp + 32]
	.p2align	4
592:
	vmovdqu	xmm13, xmmword ptr [rsi]
	vmovdqu	xmm14, xmmword ptr [rsi + 28]
	vinserti128	ymm13, ymm13, xmmword ptr [rsi + 14], 1
	vbroadcasti128	ymm0, xmmword ptr [rip + 2842f]
	vpshufb	ymm15, ymm13, ymm0
	vbroadcasti128	ymm1, xmmword ptr [rip + 2852f]
	vpshufb	ymm13, ymm13, ymm1
	vbroadcastf128	ymm2, xmmword ptr [rip + 2862f]
	vmovaps	ymm7, ymm2
	#APP
	#NO_APP
	vpmullw	ymm7, ymm15, ymm7
	vmovaps	ymm15, ymm2
	#APP
	#NO_APP
	vpmullw	ymm13, ymm15, ymm13
	vpsrlw	ymm7, ymm7, 9
	vpsrlw	ymm13, ymm13, 9
	vpackuswb	ymm7, ymm7, ymm13
	vinserti128	ymm13, ymm14, xmmword ptr [rsi + 42], 1
	vpshufb	ymm14, ymm13, ymm0
	vpshufb	ymm13, ymm13, ymm1
	vmovaps	ymm15, ymm2
	#APP
	#NO_APP
	vpmullw	ymm14, ymm15, ymm14
	vmovaps	ymm15, ymm2
	#APP
	#NO_APP
	vpmullw	ymm13, ymm15, ymm13
	vpsrlw	ymm14, ymm14, 9
	vpsrlw	ymm13, ymm13, 9
	vpackuswb	ymm13, ymm14, ymm13
	vpshufb	ymm14, ymm8, ymm7
	vpshufb	ymm15, ymm9, ymm7
	vpsllw	ymm10, ymm7, 3
	vpblendvb	ymm14, ymm14, ymm15, ymm10
	vpshufb	ymm15, ymm11, ymm7
	vpshufb	ymm5, ymm12, ymm7
	vpblendvb	ymm5, ymm15, ymm5, ymm10
	vpsllw	ymm15, ymm7, 2
	vpblendvb	ymm5, ymm14, ymm5, ymm15
	vmovdqu	ymm2, ymmword ptr [rsp + 96]
	vpshufb	ymm14, ymm2, ymm7
	vpshufb	ymm6, ymm3, ymm7
	vpblendvb	ymm6, ymm14, ymm6, ymm10
	vpshufb	ymm14, ymm4, ymm7
	vmovdqu	ymm0, ymmword ptr [rsp]
	vpshufb	ymm1, ymm0, ymm7
	vpblendvb	ymm1, ymm14, ymm1, ymm10
	vpblendvb	ymm1, ymm6, ymm1, ymm15
	vpaddw	ymm6, ymm7, ymm7
	vpblendvb	ymm1, ymm5, ymm1, ymm6
	vpshufb	ymm5, ymm8, ymm13
	vpshufb	ymm6, ymm9, ymm13
	vpsllw	ymm7, ymm13, 3
	vpblendvb	ymm5, ymm5, ymm6, ymm7
	vpshufb	ymm6, ymm11, ymm13
	vpshufb	ymm10, ymm12, ymm13
	vpblendvb	ymm6, ymm6, ymm10, ymm7
	vpshufb	ymm10, ymm2, ymm13
	vpshufb	ymm14, ymm3, ymm13
	vpblendvb	ymm10, ymm10, ymm14, ymm7
	vpshufb	ymm14, ymm4, ymm13
	vpshufb	ymm15, ymm0, ymm13
	vpblendvb	ymm7, ymm14, ymm15, ymm7
	vpsllw	ymm14, ymm13, 2
	vpblendvb	ymm5, ymm5, ymm6, ymm14
	vpblendvb	ymm6, ymm10, ymm7, ymm14
	vpaddw	ymm7, ymm13, ymm13
	vpblendvb	ymm5, ymm5, ymm6, ymm7
	vmovdqu	ymmword ptr [rdi + 32], ymm5
	vmovdqu	ymmword ptr [rdi], ymm1
	add	rdi, 64
	add	rsi, 56
	add	rdx, -64
	cmp	rdx, 64
	jb	602f
	cmp	r8, 63
	lea	r8, [r8 - 56]
	ja	592b
602:
	test	rdx, rdx
	vmovdqu	ymm0, ymmword ptr [rsp + 160]
	je	1772f
	vpermq	ymm8, ymm0, 68
	vpermq	ymm0, ymm0, 238
	vmovdqu	ymm1, ymmword ptr [rsp + 128]
	vpermq	ymm9, ymm1, 68
	vpermq	ymm10, ymm1, 238
	lea	rcx, [rdi + 32]
	vmovdqu	ymm7, ymmword ptr [rsp]
	jmp	632f
	.p2align	4
612:
	vmovdqu	ymmword ptr [rcx - 32], ymm11
	vmovdqu	ymmword ptr [rcx], ymm12
622:
	add	rdi, 64
	add	rsi, 56
	add	rcx, 64
	sub	rdx, r8
	je	1772f
632:
	cmp	rdx, 64
	mov	r8d, 64
	cmovb	r8, rdx
	mov	r9d, r8d
	shl	r9, 3
	sub	r9, r8
	add	r9, 7
	mov	r10d, r9d
	shr	r10d, 3
	mov	r11d, r10d
	and	r11d, 7
	and	r10d, 248
	cmp	r11, 4
	jb	642f
	lea	ebx, [8*r11]
	add	r11, r10
	mov	r14d, dword ptr [rsi + r10]
	mov	r11d, dword ptr [rsi + r11 - 4]
	add	bl, -32
	jmp	652f
	.p2align	4
642:
	cmp	r11d, 2
	jb	762f
	lea	ebx, [8*r11]
	add	r11, r10
	movzx	r14d, word ptr [rsi + r10]
	movzx	r11d, word ptr [rsi + r11 - 2]
	add	bl, -16
652:
	shlx	r11, r11, rbx
	or	r11, r14
662:
	vmovq	xmm11, r11
	vpxor	xmm12, xmm12, xmm12
	test	r9b, 64
	jne	742f
	test	r9b, r9b
	js	752f
672:
	test	r9d, 256
	je	692f
682:
	vmovdqa	ymm12, ymm11
	vmovdqu	ymm11, ymmword ptr [rsi]
692:
	vmovdqu	ymmword ptr [rax], ymm11
	vmovdqu	ymmword ptr [rax + 32], ymm12
	vextracti128	xmm1, ymm11, 1
	vpalignr	xmm1, xmm1, xmm11, 14
	vinserti128	ymm1, ymm11, xmm1, 1
	vbroadcasti128	ymm2, xmmword ptr [rip + 2842f]
	vpshufb	ymm11, ymm1, ymm2
	vbroadcasti128	ymm3, xmmword ptr [rip + 2852f]
	vpshufb	ymm1, ymm1, ymm3
	vbroadcastf128	ymm4, xmmword ptr [rip + 2862f]
	vmovaps	ymm12, ymm4
	#APP
	#NO_APP
	vpmullw	ymm11, ymm12, ymm11
	vmovaps	ymm12, ymm4
	#APP
	#NO_APP
	vpmullw	ymm1, ymm12, ymm1
	vpsrlw	ymm11, ymm11, 9
	vpsrlw	ymm1, ymm1, 9
	vpackuswb	ymm1, ymm11, ymm1
	vmovdqu	xmm11, xmmword ptr [rax + 28]
	vinserti128	ymm11, ymm11, xmmword ptr [rax + 42], 1
	vpshufb	ymm12, ymm11, ymm2
	vpshufb	ymm11, ymm11, ymm3
	vmovaps	ymm13, ymm4
	#APP
	#NO_APP
	vpmullw	ymm12, ymm13, ymm12
	vmovaps	ymm13, ymm4
	#APP
	#NO_APP
	vpmullw	ymm11, ymm13, ymm11
	vpsrlw	ymm12, ymm12, 9
	vpsrlw	ymm11, ymm11, 9
	vpackuswb	ymm12, ymm12, ymm11
	vpshufb	ymm11, ymm8, ymm1
	vpshufb	ymm13, ymm0, ymm1
	vpsllw	ymm14, ymm1, 3
	vpblendvb	ymm11, ymm11, ymm13, ymm14
	vpshufb	ymm13, ymm9, ymm1
	vpshufb	ymm15, ymm10, ymm1
	vpblendvb	ymm13, ymm13, ymm15, ymm14
	vpsllw	ymm15, ymm1, 2
	vpblendvb	ymm11, ymm11, ymm13, ymm15
	vmovdqu	ymm2, ymmword ptr [rsp + 96]
	vpshufb	ymm13, ymm2, ymm1
	vmovdqu	ymm3, ymmword ptr [rsp + 64]
	vpshufb	ymm5, ymm3, ymm1
	vpblendvb	ymm5, ymm13, ymm5, ymm14
	vmovdqu	ymm4, ymmword ptr [rsp + 32]
	vpshufb	ymm13, ymm4, ymm1
	vpshufb	ymm6, ymm7, ymm1
	vpblendvb	ymm6, ymm13, ymm6, ymm14
	vpblendvb	ymm5, ymm5, ymm6, ymm15
	vpaddw	ymm1, ymm1, ymm1
	vpblendvb	ymm11, ymm11, ymm5, ymm1
	vpshufb	ymm1, ymm8, ymm12
	vpshufb	ymm5, ymm0, ymm12
	vpsllw	ymm6, ymm12, 3
	vpblendvb	ymm1, ymm1, ymm5, ymm6
	vpshufb	ymm5, ymm9, ymm12
	vpshufb	ymm13, ymm10, ymm12
	vpblendvb	ymm5, ymm5, ymm13, ymm6
	vpshufb	ymm13, ymm2, ymm12
	vpshufb	ymm14, ymm3, ymm12
	vpblendvb	ymm13, ymm13, ymm14, ymm6
	vpshufb	ymm14, ymm4, ymm12
	vpshufb	ymm15, ymm7, ymm12
	vpblendvb	ymm6, ymm14, ymm15, ymm6
	vpsllw	ymm14, ymm12, 2
	vpblendvb	ymm1, ymm1, ymm5, ymm14
	vpblendvb	ymm5, ymm13, ymm6, ymm14
	vpaddw	ymm6, ymm12, ymm12
	vpblendvb	ymm12, ymm1, ymm5, ymm6
	cmp	rdx, 64
	jae	612b
	cmp	rdx, 32
	mov	r9, rdi
	jb	702f
	vmovdqu	ymmword ptr [rcx - 32], ymm11
	mov	r9, rcx
	vmovdqa	ymm11, ymm12
	vpxor	xmm12, xmm12, xmm12
702:
	test	r8b, 16
	je	712f
	vmovdqu	xmmword ptr [r9], xmm11
	vperm2i128	ymm11, ymm11, ymm12, 33
	add	r9, 16
712:
	vmovq	r11, xmm11
	vpextrq	r10, xmm11, 1
	test	r8b, 8
	cmove	r10, r11
	jne	772f
	test	r8b, 4
	jne	782f
722:
	test	r8b, 2
	jne	792f
732:
	test	r8b, 1
	je	622b
	jmp	802f
	.p2align	4
742:
	vpermq	ymm1, ymm11, 255
	vmovq	xmm12, xmm1
	vpermq	ymm1, ymm11, 144
	vmovq	xmm11, qword ptr [rsi + r10 - 8]
	add	r10, -8
	vpblendd	ymm11, ymm1, ymm11, 3
	test	r9b, r9b
	jns	672b
752:
	vmovdqu	xmm1, xmmword ptr [r10 + rsi - 16]
	vperm2i128	ymm12, ymm11, ymm12, 33
	vinserti128	ymm11, ymm1, xmm11, 1
	test	r9d, 256
	jne	682b
	jmp	692b
	.p2align	4
762:
	cmp	r11d, 1
	jne	812f
	movzx	r11d, byte ptr [rsi + r10]
	jmp	662b
	.p2align	4
772:
	mov	qword ptr [r9], r11
	add	r9, 8
	test	r8b, 4
	je	722b
782:
	mov	dword ptr [r9], r10d
	add	r9, 4
	shr	r10, 32
	test	r8b, 2
	je	732b
792:
	mov	word ptr [r9], r10w
	add	r9, 2
	shr	r10, 16
	test	r8b, 1
	je	622b
802:
	mov	byte ptr [r9], r10b
	jmp	622b
812:
	xor	r11d, r11d
	jmp	662b
822:
	cmp	rdx, 64
	setb	cl
	cmp	r8, 64
	setb	r9b
	or	r9b, cl
	jne	842f
	vbroadcasti128	ymm1, xmmword ptr [rip + 2872f]
	vbroadcasti128	ymm2, xmmword ptr [rip + 2882f]
	vpbroadcastq	ymm3, qword ptr [rip + 2892f]
	vpermq	ymm4, ymm10, 68
	add	r8, -16
	.p2align	4
832:
	vmovdqu	xmm5, xmmword ptr [rsi]
	vmovdqu	xmm6, xmmword ptr [rsi + 8]
	vinserti128	ymm5, ymm5, xmmword ptr [rsi + 4], 1
	vpshufb	ymm7, ymm5, ymm1
	vpshufb	ymm5, ymm5, ymm2
	vmovdqa	ymm8, ymm3
	#APP
	#NO_APP
	vpmullw	ymm7, ymm8, ymm7
	vmovdqa	ymm8, ymm3
	#APP
	#NO_APP
	vpmullw	ymm5, ymm8, ymm5
	vpsrlw	ymm7, ymm7, 14
	vpsrlw	ymm5, ymm5, 14
	vpackuswb	ymm5, ymm7, ymm5
	vinserti128	ymm6, ymm6, xmmword ptr [rsi + 12], 1
	vpshufb	ymm7, ymm6, ymm1
	vpshufb	ymm6, ymm6, ymm2
	vmovdqa	ymm8, ymm3
	#APP
	#NO_APP
	vpmullw	ymm7, ymm8, ymm7
	vmovdqa	ymm8, ymm3
	#APP
	#NO_APP
	vpmullw	ymm6, ymm8, ymm6
	vpsrlw	ymm7, ymm7, 14
	vpsrlw	ymm6, ymm6, 14
	vpackuswb	ymm6, ymm7, ymm6
	vpshufb	ymm5, ymm4, ymm5
	vpshufb	ymm6, ymm4, ymm6
	vmovdqu	ymmword ptr [rdi + 32], ymm6
	vmovdqu	ymmword ptr [rdi], ymm5
	add	rdi, 64
	add	rsi, 16
	add	rdx, -64
	cmp	rdx, 64
	jb	842f
	cmp	r8, 63
	lea	r8, [r8 - 16]
	ja	832b
842:
	test	rdx, rdx
	je	1772f
	vbroadcasti128	ymm1, xmmword ptr [rip + 2872f]
	vbroadcasti128	ymm2, xmmword ptr [rip + 2882f]
	vpbroadcastq	ymm3, qword ptr [rip + 2892f]
	vpermq	ymm0, ymm10, 68
	mov	ecx, 32
	xor	r8d, r8d
	vpmovsxbd	xmm4, dword ptr [rip + 2902f]
	mov	r9, rdi
	jmp	872f
	.p2align	4
852:
	vmovdqu	ymmword ptr [rdi + 4*r8], ymm5
	vmovdqu	ymmword ptr [rdi + 4*r8 + 32], ymm6
862:
	add	r9, 64
	add	r8, 16
	add	rcx, 64
	sub	rdx, r10
	je	1772f
872:
	cmp	rdx, 64
	mov	r10d, 64
	cmovb	r10, rdx
	mov	r11d, r10d
	lea	rbx, [r11 + r11 + 6]
	mov	r11d, ebx
	shr	r11d, 3
	mov	r15d, r11d
	and	r15d, 7
	and	r11d, 56
	lea	r14, [rsi + r11]
	cmp	r15, 4
	jb	882f
	lea	r12d, [8*r15]
	add	r15, r11
	add	r15, rsi
	mov	r13d, dword ptr [r14 + r8]
	mov	r15d, dword ptr [r8 + r15 - 4]
	add	r12b, -32
	jmp	892f
	.p2align	4
882:
	cmp	r15d, 2
	jb	972f
	lea	r12d, [8*r15]
	add	r15, r11
	add	r15, rsi
	movzx	r13d, word ptr [r14 + r8]
	movzx	r15d, word ptr [r8 + r15 - 2]
	add	r12b, -16
892:
	shlx	r15, r15, r12
	or	r15, r13
902:
	vmovq	xmm5, r15
	vpxor	xmm6, xmm6, xmm6
	test	bl, 64
	je	912f
	add	r11, -8
	vpermq	ymm6, ymm5, 255
	vmovq	xmm6, xmm6
	vpermq	ymm5, ymm5, 144
	vmovq	xmm7, qword ptr [r8 + r14 - 8]
	vpblendd	ymm5, ymm5, ymm7, 3
912:
	test	bl, bl
	jns	922f
	add	r11, rsi
	vmovdqu	xmm7, xmmword ptr [r8 + r11 - 16]
	vperm2i128	ymm6, ymm5, ymm6, 33
	vinserti128	ymm5, ymm7, xmm5, 1
922:
	vmovdqu	ymmword ptr [rax], ymm5
	vmovdqu	ymmword ptr [rax + 32], ymm6
	vpermd	ymm6, ymm4, ymm5
	vpshufd	xmm7, xmm5, 185
	vpunpcklqdq	xmm6, xmm7, xmm6
	vinserti128	ymm5, ymm5, xmm6, 1
	vpshufb	ymm6, ymm5, ymm1
	vpshufb	ymm5, ymm5, ymm2
	vmovdqa	ymm7, ymm3
	#APP
	#NO_APP
	vpmullw	ymm6, ymm7, ymm6
	vmovdqa	ymm7, ymm3
	#APP
	#NO_APP
	vpmullw	ymm5, ymm7, ymm5
	vpsrlw	ymm6, ymm6, 14
	vpsrlw	ymm5, ymm5, 14
	vpackuswb	ymm5, ymm6, ymm5
	vmovdqu	xmm6, xmmword ptr [rax + 8]
	vinserti128	ymm6, ymm6, xmmword ptr [rax + 12], 1
	vpshufb	ymm7, ymm6, ymm1
	vpshufb	ymm6, ymm6, ymm2
	vmovdqa	ymm8, ymm3
	#APP
	#NO_APP
	vpmullw	ymm7, ymm8, ymm7
	vmovdqa	ymm8, ymm3
	#APP
	#NO_APP
	vpmullw	ymm6, ymm8, ymm6
	vpsrlw	ymm7, ymm7, 14
	vpsrlw	ymm6, ymm6, 14
	vpackuswb	ymm6, ymm7, ymm6
	vpshufb	ymm5, ymm0, ymm5
	vpshufb	ymm6, ymm0, ymm6
	cmp	rdx, 64
	jae	852b
	cmp	rdx, 32
	mov	r11, r9
	jb	932f
	vmovdqu	ymmword ptr [rdi + 4*r8], ymm5
	lea	r11, [rdi + rcx]
	vmovdqa	ymm5, ymm6
	vpxor	xmm6, xmm6, xmm6
932:
	test	r10b, 16
	je	942f
	vmovdqu	xmmword ptr [r11], xmm5
	vperm2i128	ymm5, ymm5, ymm6, 33
	add	r11, 16
942:
	vmovq	r14, xmm5
	vpextrq	rbx, xmm5, 1
	test	r10b, 8
	cmove	rbx, r14
	jne	982f
	test	r10b, 4
	jne	992f
952:
	test	r10b, 2
	jne	1002f
962:
	test	r10b, 1
	je	862b
	jmp	1012f
	.p2align	4
972:
	cmp	r15d, 1
	jne	1022f
	movzx	r15d, byte ptr [r14 + r8]
	jmp	902b
	.p2align	4
982:
	mov	qword ptr [r11], r14
	add	r11, 8
	test	r10b, 4
	je	952b
992:
	mov	dword ptr [r11], ebx
	add	r11, 4
	shr	rbx, 32
	test	r10b, 2
	je	962b
1002:
	mov	word ptr [r11], bx
	add	r11, 2
	shr	rbx, 16
	test	r10b, 1
	je	862b
1012:
	mov	byte ptr [r11], bl
	jmp	862b
1022:
	xor	r15d, r15d
	jmp	902b
1032:
	cmp	rdx, 64
	setb	cl
	cmp	r8, 64
	setb	r9b
	or	r9b, cl
	jne	1052f
	vbroadcasti128	ymm1, xmmword ptr [rip + 2912f]
	vbroadcasti128	ymm2, xmmword ptr [rip + 2922f]
	vpbroadcastd	ymm3, dword ptr [rip + 2932f]
	vpermq	ymm4, ymm10, 68
	add	r8, -32
	.p2align	4
1042:
	vmovdqu	xmm5, xmmword ptr [rsi]
	vmovdqu	xmm6, xmmword ptr [rsi + 16]
	vinserti128	ymm5, ymm5, xmmword ptr [rsi + 8], 1
	vpshufb	ymm7, ymm5, ymm1
	vpshufb	ymm5, ymm5, ymm2
	vmovdqa	ymm8, ymm3
	#APP
	#NO_APP
	vpmullw	ymm7, ymm8, ymm7
	vmovdqa	ymm8, ymm3
	#APP
	#NO_APP
	vpmullw	ymm5, ymm8, ymm5
	vpsrlw	ymm7, ymm7, 12
	vpsrlw	ymm5, ymm5, 12
	vpackuswb	ymm5, ymm7, ymm5
	vinserti128	ymm6, ymm6, xmmword ptr [rsi + 24], 1
	vpshufb	ymm7, ymm6, ymm1
	vpshufb	ymm6, ymm6, ymm2
	vmovdqa	ymm8, ymm3
	#APP
	#NO_APP
	vpmullw	ymm7, ymm8, ymm7
	vmovdqa	ymm8, ymm3
	#APP
	#NO_APP
	vpmullw	ymm6, ymm8, ymm6
	vpsrlw	ymm7, ymm7, 12
	vpsrlw	ymm6, ymm6, 12
	vpackuswb	ymm6, ymm7, ymm6
	vpshufb	ymm5, ymm4, ymm5
	vpshufb	ymm6, ymm4, ymm6
	vmovdqu	ymmword ptr [rdi + 32], ymm6
	vmovdqu	ymmword ptr [rdi], ymm5
	add	rdi, 64
	add	rsi, 32
	add	rdx, -64
	cmp	rdx, 64
	jb	1052f
	cmp	r8, 63
	lea	r8, [r8 - 32]
	ja	1042b
1052:
	test	rdx, rdx
	je	1772f
	vbroadcasti128	ymm1, xmmword ptr [rip + 2912f]
	vbroadcasti128	ymm2, xmmword ptr [rip + 2922f]
	vpbroadcastd	ymm3, dword ptr [rip + 2932f]
	vpermq	ymm0, ymm10, 68
	mov	ecx, 32
	xor	r8d, r8d
	mov	r9, rdi
	jmp	1082f
	.p2align	4
1062:
	vmovdqu	ymmword ptr [rdi + 2*r8], ymm4
	vmovdqu	ymmword ptr [rdi + 2*r8 + 32], ymm5
1072:
	add	r9, 64
	add	r8, 32
	add	rcx, 64
	sub	rdx, r10
	je	1772f
1082:
	cmp	rdx, 64
	mov	r10d, 64
	cmovb	r10, rdx
	mov	r11d, r10d
	lea	r11, [4*r11 + 4]
	mov	ebx, r11d
	shr	ebx, 3
	mov	r15d, ebx
	and	r15d, 7
	and	ebx, 120
	lea	r14, [rsi + rbx]
	cmp	r15, 4
	jb	1092f
	lea	r12d, [8*r15]
	add	r15, rbx
	add	r15, rsi
	mov	r13d, dword ptr [r14 + r8]
	mov	r15d, dword ptr [r8 + r15 - 4]
	add	r12b, -32
	jmp	1102f
	.p2align	4
1092:
	cmp	r15d, 2
	jb	1212f
	lea	r12d, [8*r15]
	add	r15, rbx
	add	r15, rsi
	movzx	r13d, word ptr [r14 + r8]
	movzx	r15d, word ptr [r8 + r15 - 2]
	add	r12b, -16
1102:
	shlx	r15, r15, r12
	or	r15, r13
1112:
	vmovq	xmm4, r15
	vpxor	xmm5, xmm5, xmm5
	test	r11b, 64
	jne	1192f
	test	r11b, r11b
	js	1202f
1122:
	test	r11d, 256
	je	1142f
1132:
	vmovdqa	ymm5, ymm4
	vmovdqu	ymm4, ymmword ptr [rsi + r8]
1142:
	vmovdqu	ymmword ptr [rax], ymm4
	vmovdqu	ymmword ptr [rax + 32], ymm5
	vpermq	ymm5, ymm4, 233
	vinserti128	ymm4, ymm4, xmm5, 1
	vpshufb	ymm5, ymm4, ymm1
	vpshufb	ymm4, ymm4, ymm2
	vmovdqa	ymm6, ymm3
	#APP
	#NO_APP
	vpmullw	ymm5, ymm6, ymm5
	vmovdqa	ymm6, ymm3
	#APP
	#NO_APP
	vpmullw	ymm4, ymm6, ymm4
	vpsrlw	ymm5, ymm5, 12
	vpsrlw	ymm4, ymm4, 12
	vpackuswb	ymm4, ymm5, ymm4
	vmovdqu	xmm5, xmmword ptr [rax + 16]
	vinserti128	ymm5, ymm5, xmmword ptr [rax + 24], 1
	vpshufb	ymm6, ymm5, ymm1
	vpshufb	ymm5, ymm5, ymm2
	vmovdqa	ymm7, ymm3
	#APP
	#NO_APP
	vpmullw	ymm6, ymm7, ymm6
	vmovdqa	ymm7, ymm3
	#APP
	#NO_APP
	vpmullw	ymm5, ymm7, ymm5
	vpsrlw	ymm6, ymm6, 12
	vpsrlw	ymm5, ymm5, 12
	vpackuswb	ymm5, ymm6, ymm5
	vpshufb	ymm4, ymm0, ymm4
	vpshufb	ymm5, ymm0, ymm5
	cmp	rdx, 64
	jae	1062b
	cmp	rdx, 32
	mov	r11, r9
	jb	1152f
	vmovdqu	ymmword ptr [rdi + 2*r8], ymm4
	lea	r11, [rdi + rcx]
	vmovdqa	ymm4, ymm5
	vpxor	xmm5, xmm5, xmm5
1152:
	test	r10b, 16
	je	1162f
	vmovdqu	xmmword ptr [r11], xmm4
	vperm2i128	ymm4, ymm4, ymm5, 33
	add	r11, 16
1162:
	vmovq	r14, xmm4
	vpextrq	rbx, xmm4, 1
	test	r10b, 8
	cmove	rbx, r14
	jne	1222f
	test	r10b, 4
	jne	1232f
1172:
	test	r10b, 2
	jne	1242f
1182:
	test	r10b, 1
	je	1072b
	jmp	1252f
	.p2align	4
1192:
	add	rbx, -8
	vpermq	ymm5, ymm4, 255
	vmovq	xmm5, xmm5
	vpermq	ymm4, ymm4, 144
	vmovq	xmm6, qword ptr [r8 + r14 - 8]
	vpblendd	ymm4, ymm4, ymm6, 3
	test	r11b, r11b
	jns	1122b
1202:
	add	rbx, rsi
	vmovdqu	xmm6, xmmword ptr [r8 + rbx - 16]
	vperm2i128	ymm5, ymm4, ymm5, 33
	vinserti128	ymm4, ymm6, xmm4, 1
	test	r11d, 256
	jne	1132b
	jmp	1142b
	.p2align	4
1212:
	cmp	r15d, 1
	jne	1262f
	movzx	r15d, byte ptr [r14 + r8]
	jmp	1112b
	.p2align	4
1222:
	mov	qword ptr [r11], r14
	add	r11, 8
	test	r10b, 4
	je	1172b
1232:
	mov	dword ptr [r11], ebx
	add	r11, 4
	shr	rbx, 32
	test	r10b, 2
	je	1182b
1242:
	mov	word ptr [r11], bx
	add	r11, 2
	shr	rbx, 16
	test	r10b, 1
	je	1072b
1252:
	mov	byte ptr [r11], bl
	jmp	1072b
1262:
	xor	r15d, r15d
	jmp	1112b
1272:
	cmp	rdx, 64
	setb	cl
	cmp	r8, 64
	setb	r9b
	or	r9b, cl
	jne	1542f
	vbroadcasti128	ymm1, xmmword ptr [rip + 2942f]
	vbroadcasti128	ymm2, xmmword ptr [rip + 2952f]
	vpbroadcastq	ymm3, qword ptr [rip + 2962f]
	vpermq	ymm4, ymm10, 68
	vpermq	ymm5, ymm10, 238
	vpermq	ymm6, ymm7, 68
	vmovdqa	ymm15, ymm7
	vpermq	ymm7, ymm7, 238
	add	r8, -48
	.p2align	4
1282:
	vmovdqu	xmm8, xmmword ptr [rsi]
	vmovdqu	xmm9, xmmword ptr [rsi + 24]
	vinserti128	ymm8, ymm8, xmmword ptr [rsi + 12], 1
	vpshufb	ymm11, ymm8, ymm1
	vpshufb	ymm8, ymm8, ymm2
	vmovdqa	ymm12, ymm3
	#APP
	#NO_APP
	vpmullw	ymm11, ymm12, ymm11
	vmovdqa	ymm12, ymm3
	#APP
	#NO_APP
	vpmullw	ymm8, ymm12, ymm8
	vpsrlw	ymm11, ymm11, 10
	vpsrlw	ymm8, ymm8, 10
	vpackuswb	ymm8, ymm11, ymm8
	vinserti128	ymm9, ymm9, xmmword ptr [rsi + 36], 1
	vpshufb	ymm11, ymm9, ymm1
	vpshufb	ymm9, ymm9, ymm2
	vmovdqa	ymm12, ymm3
	#APP
	#NO_APP
	vpmullw	ymm11, ymm12, ymm11
	vmovdqa	ymm12, ymm3
	#APP
	#NO_APP
	vpmullw	ymm9, ymm12, ymm9
	vpsrlw	ymm11, ymm11, 10
	vpsrlw	ymm9, ymm9, 10
	vpackuswb	ymm9, ymm11, ymm9
	vpshufb	ymm11, ymm4, ymm8
	vpshufb	ymm12, ymm5, ymm8
	vpsllw	ymm13, ymm8, 3
	vpblendvb	ymm11, ymm11, ymm12, ymm13
	vpshufb	ymm12, ymm6, ymm8
	vpshufb	ymm14, ymm7, ymm8
	vpblendvb	ymm12, ymm12, ymm14, ymm13
	vpsllw	ymm8, ymm8, 2
	vpblendvb	ymm8, ymm11, ymm12, ymm8
	vpshufb	ymm11, ymm4, ymm9
	vpshufb	ymm12, ymm5, ymm9
	vpsllw	ymm13, ymm9, 3
	vpblendvb	ymm11, ymm11, ymm12, ymm13
	vpshufb	ymm12, ymm6, ymm9
	vpshufb	ymm14, ymm7, ymm9
	vpblendvb	ymm12, ymm12, ymm14, ymm13
	vpsllw	ymm9, ymm9, 2
	vpblendvb	ymm9, ymm11, ymm12, ymm9
	vmovdqu	ymmword ptr [rdi + 32], ymm9
	vmovdqu	ymmword ptr [rdi], ymm8
	add	rdi, 64
	add	rsi, 48
	add	rdx, -64
	cmp	rdx, 64
	jb	1552f
	cmp	r8, 63
	lea	r8, [r8 - 48]
	ja	1282b
	jmp	1552f
1292:
	vmovdqu	ymm0, ymmword ptr [r9 + 64]
	vmovdqu	ymm1, ymmword ptr [r9 + 96]
	vmovdqu	ymm2, ymmword ptr [r9 + 128]
	vmovdqu	ymm3, ymmword ptr [r9 + 160]
	vmovdqu	ymm15, ymmword ptr [r9 + 224]
	vmovdqu	ymm13, ymmword ptr [r9 + 192]
	cmp	rdx, 64
	setb	cl
	cmp	r8, 64
	setb	r9b
	or	r9b, cl
	vpermq	ymm4, ymm10, 68
	vmovdqu	ymmword ptr [rsp + 512], ymm4
	vpermq	ymm4, ymm10, 238
	vmovdqu	ymmword ptr [rsp + 480], ymm4
	vpermq	ymm4, ymm7, 68
	vmovdqu	ymmword ptr [rsp + 448], ymm4
	vpermq	ymm4, ymm7, 238
	vmovdqu	ymmword ptr [rsp + 416], ymm4
	vpermq	ymm4, ymm0, 68
	vmovdqu	ymmword ptr [rsp + 352], ymm4
	vpermq	ymm0, ymm0, 238
	vmovdqu	ymmword ptr [rsp + 384], ymm0
	vpermq	ymm0, ymm1, 68
	vmovdqu	ymmword ptr [rsp + 96], ymm0
	vpermq	ymm0, ymm1, 238
	vmovdqu	ymmword ptr [rsp + 64], ymm0
	vpermq	ymm0, ymm2, 68
	vmovdqu	ymmword ptr [rsp + 320], ymm0
	vpermq	ymm0, ymm2, 238
	vmovdqu	ymmword ptr [rsp + 32], ymm0
	vpermq	ymm0, ymm3, 68
	vmovdqu	ymmword ptr [rsp], ymm0
	vpermq	ymm0, ymm3, 238
	vmovdqu	ymmword ptr [rsp + 160], ymm0
	vpermq	ymm0, ymm13, 68
	vmovdqu	ymmword ptr [rsp + 128], ymm0
	vpermq	ymm0, ymm13, 238
	vmovdqu	ymmword ptr [rsp + 256], ymm0
	vpermq	ymm0, ymm15, 68
	vmovdqu	ymmword ptr [rsp + 224], ymm0
	vpermq	ymm0, ymm15, 238
	vmovdqu	ymmword ptr [rsp + 192], ymm0
	jne	1312f
	add	r8, -64
	vmovdqu	ymm13, ymmword ptr [rsp + 416]
	vmovdqu	ymm14, ymmword ptr [rsp + 352]
	vmovdqu	ymm15, ymmword ptr [rsp + 384]
	.p2align	4
1302:
	vmovdqu	ymm2, ymmword ptr [rsi]
	vmovdqu	ymm1, ymmword ptr [rsi + 32]
	vpbroadcastb	ymm0, byte ptr [rip + 2972f]
	vpand	ymm3, ymm2, ymm0
	vmovdqu	ymm10, ymmword ptr [rsp + 512]
	vpshufb	ymm0, ymm10, ymm3
	vmovdqu	ymm11, ymmword ptr [rsp + 480]
	vpshufb	ymm4, ymm11, ymm3
	vpsllw	ymm5, ymm2, 3
	vpblendvb	ymm0, ymm0, ymm4, ymm5
	vmovdqu	ymm12, ymmword ptr [rsp + 448]
	vpshufb	ymm4, ymm12, ymm3
	vpshufb	ymm6, ymm13, ymm3
	vpblendvb	ymm4, ymm4, ymm6, ymm5
	vpsllw	ymm6, ymm2, 2
	vpblendvb	ymm0, ymm0, ymm4, ymm6
	vpshufb	ymm4, ymm14, ymm3
	vpshufb	ymm7, ymm15, ymm3
	vpblendvb	ymm4, ymm4, ymm7, ymm5
	vmovdqu	ymm7, ymmword ptr [rsp + 96]
	vpshufb	ymm7, ymm7, ymm3
	vmovdqu	ymm8, ymmword ptr [rsp + 64]
	vpshufb	ymm8, ymm8, ymm3
	vpblendvb	ymm7, ymm7, ymm8, ymm5
	vpblendvb	ymm4, ymm4, ymm7, ymm6
	vpaddw	ymm7, ymm2, ymm2
	vpblendvb	ymm0, ymm0, ymm4, ymm7
	vmovdqu	ymmword ptr [rsp + 288], ymm0
	vmovdqu	ymm0, ymmword ptr [rsp + 320]
	vpshufb	ymm4, ymm0, ymm3
	vmovdqu	ymm0, ymmword ptr [rsp + 32]
	vpshufb	ymm8, ymm0, ymm3
	vpblendvb	ymm4, ymm4, ymm8, ymm5
	vmovdqu	ymm0, ymmword ptr [rsp]
	vpshufb	ymm8, ymm0, ymm3
	vmovdqu	ymm0, ymmword ptr [rsp + 160]
	vpshufb	ymm9, ymm0, ymm3
	vpblendvb	ymm8, ymm8, ymm9, ymm5
	vpblendvb	ymm4, ymm4, ymm8, ymm6
	vmovdqu	ymm0, ymmword ptr [rsp + 128]
	vpshufb	ymm8, ymm0, ymm3
	vmovdqu	ymm0, ymmword ptr [rsp + 256]
	vpshufb	ymm9, ymm0, ymm3
	vpblendvb	ymm8, ymm8, ymm9, ymm5
	vmovdqu	ymm0, ymmword ptr [rsp + 224]
	vpshufb	ymm9, ymm0, ymm3
	vmovdqu	ymm0, ymmword ptr [rsp + 192]
	vpshufb	ymm3, ymm0, ymm3
	vpblendvb	ymm3, ymm9, ymm3, ymm5
	vpblendvb	ymm3, ymm8, ymm3, ymm6
	vpblendvb	ymm3, ymm4, ymm3, ymm7
	vmovdqu	ymm0, ymmword ptr [rsp + 288]
	vpblendvb	ymm2, ymm0, ymm3, ymm2
	vpand	ymm0, ymm1, ymmword ptr [rip + 2982f]
	vpshufb	ymm3, ymm10, ymm0
	vpshufb	ymm4, ymm11, ymm0
	vpsllw	ymm5, ymm1, 3
	vpblendvb	ymm3, ymm3, ymm4, ymm5
	vpshufb	ymm4, ymm12, ymm0
	vpshufb	ymm6, ymm13, ymm0
	vpblendvb	ymm4, ymm4, ymm6, ymm5
	vpshufb	ymm6, ymm14, ymm0
	vpshufb	ymm7, ymm15, ymm0
	vpblendvb	ymm6, ymm6, ymm7, ymm5
	vmovdqu	ymm7, ymmword ptr [rsp + 96]
	vpshufb	ymm7, ymm7, ymm0
	vmovdqu	ymm8, ymmword ptr [rsp + 64]
	vpshufb	ymm8, ymm8, ymm0
	vpblendvb	ymm7, ymm7, ymm8, ymm5
	vmovdqu	ymm8, ymmword ptr [rsp + 320]
	vpshufb	ymm8, ymm8, ymm0
	vmovdqu	ymm9, ymmword ptr [rsp + 32]
	vpshufb	ymm9, ymm9, ymm0
	vpblendvb	ymm8, ymm8, ymm9, ymm5
	vmovdqu	ymm9, ymmword ptr [rsp]
	vpshufb	ymm9, ymm9, ymm0
	vmovdqu	ymm10, ymmword ptr [rsp + 160]
	vpshufb	ymm10, ymm10, ymm0
	vpblendvb	ymm9, ymm9, ymm10, ymm5
	vmovdqu	ymm10, ymmword ptr [rsp + 128]
	vpshufb	ymm10, ymm10, ymm0
	vmovdqu	ymm11, ymmword ptr [rsp + 256]
	vpshufb	ymm11, ymm11, ymm0
	vpblendvb	ymm10, ymm10, ymm11, ymm5
	vmovdqu	ymm11, ymmword ptr [rsp + 224]
	vpshufb	ymm11, ymm11, ymm0
	vmovdqu	ymm12, ymmword ptr [rsp + 192]
	vpshufb	ymm0, ymm12, ymm0
	vpblendvb	ymm0, ymm11, ymm0, ymm5
	vpsllw	ymm5, ymm1, 2
	vpblendvb	ymm3, ymm3, ymm4, ymm5
	vpblendvb	ymm4, ymm6, ymm7, ymm5
	vpblendvb	ymm6, ymm8, ymm9, ymm5
	vpblendvb	ymm0, ymm10, ymm0, ymm5
	vpaddw	ymm5, ymm1, ymm1
	vpblendvb	ymm3, ymm3, ymm4, ymm5
	vpblendvb	ymm0, ymm6, ymm0, ymm5
	vpblendvb	ymm0, ymm3, ymm0, ymm1
	vmovdqu	ymmword ptr [rdi + 32], ymm0
	vmovdqu	ymmword ptr [rdi], ymm2
	add	rdi, 64
	add	rsi, 64
	add	rdx, -64
	cmp	rdx, 64
	jb	1312f
	cmp	r8, 63
	lea	r8, [r8 - 64]
	ja	1302b
1312:
	test	rdx, rdx
	je	1772f
	xor	ecx, ecx
	mov	r8, rdi
	vmovdqu	ymm15, ymmword ptr [rsp + 384]
	jmp	1342f
	.p2align	4
1322:
	vmovdqu	ymmword ptr [rdi + rcx], ymm2
	vmovdqu	ymmword ptr [rdi + rcx + 32], ymm1
1332:
	add	r8, 64
	add	rcx, 64
	sub	rdx, r9
	je	1772f
1342:
	cmp	rdx, 64
	mov	r9d, 64
	cmovb	r9, rdx
	jb	1352f
	vmovdqu	ymm1, ymmword ptr [rsi + rcx]
	vmovdqu	ymm14, ymmword ptr [rsi + rcx + 32]
	jmp	1412f
	.p2align	4
1352:
	mov	ebx, r9d
	and	ebx, 7
	mov	r10d, r9d
	and	r10d, 56
	lea	r11, [rsi + r10]
	cmp	rbx, 4
	jb	1362f
	lea	r14d, [8*rbx]
	add	rbx, r10
	add	rbx, rsi
	mov	r15d, dword ptr [r11 + rcx]
	mov	ebx, dword ptr [rcx + rbx - 4]
	add	r14b, -32
	jmp	1372f
	.p2align	4
1362:
	cmp	ebx, 2
	jb	1522f
	lea	r14d, [8*rbx]
	add	rbx, r10
	add	rbx, rsi
	movzx	r15d, word ptr [r11 + rcx]
	movzx	ebx, word ptr [rcx + rbx - 2]
	add	r14b, -16
1372:
	shlx	rbx, rbx, r14
	or	rbx, r15
1382:
	vmovq	xmm1, rbx
	vpxor	xmm14, xmm14, xmm14
	test	r9b, 8
	jne	1462f
	test	r9b, 16
	jne	1472f
1392:
	cmp	rdx, 32
	jb	1412f
1402:
	vmovdqa	ymm14, ymm1
	vmovdqu	ymm1, ymmword ptr [rsi + rcx]
1412:
	vpbroadcastb	ymm0, byte ptr [rip + 2972f]
	vpand	ymm3, ymm1, ymm0
	vmovdqu	ymm10, ymmword ptr [rsp + 512]
	vpshufb	ymm2, ymm10, ymm3
	vmovdqu	ymm11, ymmword ptr [rsp + 480]
	vpshufb	ymm4, ymm11, ymm3
	vpsllw	ymm5, ymm1, 3
	vpblendvb	ymm2, ymm2, ymm4, ymm5
	vmovdqu	ymm12, ymmword ptr [rsp + 448]
	vpshufb	ymm4, ymm12, ymm3
	vmovdqu	ymm13, ymmword ptr [rsp + 416]
	vpshufb	ymm6, ymm13, ymm3
	vpblendvb	ymm4, ymm4, ymm6, ymm5
	vpsllw	ymm6, ymm1, 2
	vpblendvb	ymm2, ymm2, ymm4, ymm6
	vmovdqu	ymm0, ymmword ptr [rsp + 352]
	vpshufb	ymm4, ymm0, ymm3
	vpshufb	ymm7, ymm15, ymm3
	vpblendvb	ymm4, ymm4, ymm7, ymm5
	vmovdqu	ymm0, ymmword ptr [rsp + 96]
	vpshufb	ymm7, ymm0, ymm3
	vmovdqu	ymm0, ymmword ptr [rsp + 64]
	vpshufb	ymm8, ymm0, ymm3
	vpblendvb	ymm7, ymm7, ymm8, ymm5
	vpblendvb	ymm4, ymm4, ymm7, ymm6
	vpaddw	ymm7, ymm1, ymm1
	vpblendvb	ymm2, ymm2, ymm4, ymm7
	vmovdqu	ymmword ptr [rsp + 288], ymm2
	vmovdqu	ymm2, ymmword ptr [rsp + 320]
	vpshufb	ymm4, ymm2, ymm3
	vmovdqu	ymm0, ymmword ptr [rsp + 32]
	vpshufb	ymm8, ymm0, ymm3
	vpblendvb	ymm4, ymm4, ymm8, ymm5
	vmovdqu	ymm0, ymmword ptr [rsp]
	vpshufb	ymm8, ymm0, ymm3
	vmovdqu	ymm0, ymmword ptr [rsp + 160]
	vpshufb	ymm9, ymm0, ymm3
	vpblendvb	ymm8, ymm8, ymm9, ymm5
	vpblendvb	ymm4, ymm4, ymm8, ymm6
	vmovdqu	ymm0, ymmword ptr [rsp + 128]
	vpshufb	ymm8, ymm0, ymm3
	vmovdqu	ymm0, ymmword ptr [rsp + 256]
	vpshufb	ymm9, ymm0, ymm3
	vpblendvb	ymm8, ymm8, ymm9, ymm5
	vmovdqu	ymm0, ymmword ptr [rsp + 224]
	vpshufb	ymm9, ymm0, ymm3
	vmovdqu	ymm0, ymmword ptr [rsp + 192]
	vpshufb	ymm3, ymm0, ymm3
	vpblendvb	ymm3, ymm9, ymm3, ymm5
	vpblendvb	ymm3, ymm8, ymm3, ymm6
	vpblendvb	ymm3, ymm4, ymm3, ymm7
	vpand	ymm4, ymm14, ymmword ptr [rip + 2982f]
	vpshufb	ymm5, ymm10, ymm4
	vpshufb	ymm6, ymm11, ymm4
	vpsllw	ymm7, ymm14, 3
	vpblendvb	ymm5, ymm5, ymm6, ymm7
	vpshufb	ymm6, ymm12, ymm4
	vpshufb	ymm8, ymm13, ymm4
	vpblendvb	ymm6, ymm6, ymm8, ymm7
	vmovdqu	ymm0, ymmword ptr [rsp + 352]
	vpshufb	ymm8, ymm0, ymm4
	vpshufb	ymm9, ymm15, ymm4
	vpblendvb	ymm8, ymm8, ymm9, ymm7
	vmovdqu	ymm0, ymmword ptr [rsp + 96]
	vpshufb	ymm9, ymm0, ymm4
	vmovdqu	ymm0, ymmword ptr [rsp + 64]
	vpshufb	ymm10, ymm0, ymm4
	vpblendvb	ymm9, ymm9, ymm10, ymm7
	vpshufb	ymm10, ymm2, ymm4
	vmovdqu	ymm0, ymmword ptr [rsp + 32]
	vpshufb	ymm11, ymm0, ymm4
	vpblendvb	ymm10, ymm10, ymm11, ymm7
	vmovdqu	ymm0, ymmword ptr [rsp]
	vpshufb	ymm11, ymm0, ymm4
	vmovdqu	ymm0, ymmword ptr [rsp + 160]
	vpshufb	ymm12, ymm0, ymm4
	vpblendvb	ymm11, ymm11, ymm12, ymm7
	vmovdqu	ymm0, ymmword ptr [rsp + 128]
	vpshufb	ymm12, ymm0, ymm4
	vmovdqu	ymm0, ymmword ptr [rsp + 256]
	vpshufb	ymm13, ymm0, ymm4
	vpblendvb	ymm12, ymm12, ymm13, ymm7
	vmovdqu	ymm0, ymmword ptr [rsp + 224]
	vpshufb	ymm13, ymm0, ymm4
	vmovdqu	ymm0, ymmword ptr [rsp + 192]
	vpshufb	ymm4, ymm0, ymm4
	vpblendvb	ymm4, ymm13, ymm4, ymm7
	vpsllw	ymm7, ymm14, 2
	vpblendvb	ymm5, ymm5, ymm6, ymm7
	vpblendvb	ymm6, ymm8, ymm9, ymm7
	vpblendvb	ymm8, ymm10, ymm11, ymm7
	vpblendvb	ymm4, ymm12, ymm4, ymm7
	vpaddw	ymm7, ymm14, ymm14
	vpblendvb	ymm5, ymm5, ymm6, ymm7
	vpblendvb	ymm4, ymm8, ymm4, ymm7
	vmovdqu	ymm0, ymmword ptr [rsp + 288]
	vpblendvb	ymm2, ymm0, ymm3, ymm1
	vmovdqu	ymmword ptr [rax], ymm1
	vpblendvb	ymm1, ymm5, ymm4, ymm14
	vmovdqu	ymmword ptr [rax + 32], ymm14
	cmp	rdx, 64
	jae	1322b
	cmp	rdx, 32
	mov	r10, r8
	jb	1422f
	vmovdqu	ymmword ptr [rdi + rcx], ymm2
	lea	r10, [rdi + rcx + 32]
	vmovdqa	ymm2, ymm1
	vpxor	xmm1, xmm1, xmm1
1422:
	test	r9b, 16
	je	1432f
	vmovdqu	xmmword ptr [r10], xmm2
	vperm2i128	ymm2, ymm2, ymm1, 33
	add	r10, 16
1432:
	vmovq	rbx, xmm2
	vpextrq	r11, xmm2, 1
	test	r9b, 8
	cmove	r11, rbx
	jne	1482f
	test	r9b, 4
	jne	1492f
1442:
	test	r9b, 2
	jne	1502f
1452:
	test	r9b, 1
	je	1332b
	jmp	1512f
	.p2align	4
1462:
	add	r10, -8
	vpermq	ymm0, ymm1, 255
	vmovq	xmm14, xmm0
	vpermq	ymm1, ymm1, 144
	vmovq	xmm2, qword ptr [rcx + r11 - 8]
	vpblendd	ymm1, ymm1, ymm2, 3
	test	r9b, 16
	je	1392b
1472:
	add	r10, rsi
	vmovdqu	xmm2, xmmword ptr [rcx + r10 - 16]
	vperm2i128	ymm14, ymm1, ymm14, 33
	vinserti128	ymm1, ymm2, xmm1, 1
	cmp	rdx, 32
	jae	1402b
	jmp	1412b
	.p2align	4
1482:
	mov	qword ptr [r10], rbx
	add	r10, 8
	test	r9b, 4
	je	1442b
1492:
	mov	dword ptr [r10], r11d
	add	r10, 4
	shr	r11, 32
	test	r9b, 2
	je	1452b
1502:
	mov	word ptr [r10], r11w
	add	r10, 2
	shr	r11, 16
	test	r9b, 1
	je	1332b
1512:
	mov	byte ptr [r10], r11b
	jmp	1332b
1522:
	cmp	ebx, 1
	jne	1532f
	movzx	ebx, byte ptr [r11 + rcx]
	jmp	1382b
1532:
	xor	ebx, ebx
	jmp	1382b
1542:
	vmovdqa	ymm15, ymm7
1552:
	test	rdx, rdx
	je	1772f
	vbroadcasti128	ymm1, xmmword ptr [rip + 2942f]
	vbroadcasti128	ymm2, xmmword ptr [rip + 2952f]
	vpbroadcastq	ymm3, qword ptr [rip + 2962f]
	vpermq	ymm4, ymm10, 68
	vpermq	ymm0, ymm10, 238
	vpermq	ymm5, ymm15, 68
	vpermq	ymm6, ymm15, 238
	lea	rcx, [rdi + 32]
	vpmovsxbd	xmm7, dword ptr [rip + 2902f]
	jmp	1582f
	.p2align	4
1562:
	vmovdqu	ymmword ptr [rcx - 32], ymm8
	vmovdqu	ymmword ptr [rcx], ymm9
1572:
	add	rdi, 64
	add	rsi, 48
	add	rcx, 64
	sub	rdx, r8
	je	1772f
1582:
	cmp	rdx, 64
	mov	r8d, 64
	cmovb	r8, rdx
	lea	r9, [r8 + 2*r8]
	mov	r9d, r9d
	lea	r9, [r9 + r9 + 6]
	mov	r10d, r9d
	shr	r10d, 3
	mov	r11d, r10d
	and	r11d, 7
	and	r10d, 248
	cmp	r11, 4
	jb	1592f
	lea	ebx, [8*r11]
	add	r11, r10
	mov	r14d, dword ptr [rsi + r10]
	mov	r11d, dword ptr [rsi + r11 - 4]
	add	bl, -32
	jmp	1602f
	.p2align	4
1592:
	cmp	r11d, 2
	jb	1712f
	lea	ebx, [8*r11]
	add	r11, r10
	movzx	r14d, word ptr [rsi + r10]
	movzx	r11d, word ptr [rsi + r11 - 2]
	add	bl, -16
1602:
	shlx	r11, r11, rbx
	or	r11, r14
1612:
	vmovq	xmm8, r11
	vpxor	xmm9, xmm9, xmm9
	test	r9b, 64
	jne	1692f
	test	r9b, r9b
	js	1702f
1622:
	test	r9d, 256
	je	1642f
1632:
	vmovdqa	ymm9, ymm8
	vmovdqu	ymm8, ymmword ptr [rsi]
1642:
	vmovdqu	ymmword ptr [rax], ymm8
	vmovdqu	ymmword ptr [rax + 32], ymm9
	vpermd	ymm9, ymm7, ymm8
	vextracti128	xmm10, ymm8, 1
	vpshufd	xmm10, xmm10, 185
	vpunpcklqdq	xmm9, xmm9, xmm10
	vinserti128	ymm8, ymm8, xmm9, 1
	vpshufb	ymm9, ymm8, ymm1
	vpshufb	ymm8, ymm8, ymm2
	vmovdqa	ymm10, ymm3
	#APP
	#NO_APP
	vpmullw	ymm9, ymm10, ymm9
	vmovdqa	ymm10, ymm3
	#APP
	#NO_APP
	vpmullw	ymm8, ymm10, ymm8
	vpsrlw	ymm9, ymm9, 10
	vpsrlw	ymm8, ymm8, 10
	vpackuswb	ymm8, ymm9, ymm8
	vmovdqu	xmm9, xmmword ptr [rax + 24]
	vinserti128	ymm9, ymm9, xmmword ptr [rax + 36], 1
	vpshufb	ymm10, ymm9, ymm1
	vpshufb	ymm9, ymm9, ymm2
	vmovdqa	ymm11, ymm3
	#APP
	#NO_APP
	vpmullw	ymm10, ymm11, ymm10
	vmovdqa	ymm11, ymm3
	#APP
	#NO_APP
	vpmullw	ymm9, ymm11, ymm9
	vpsrlw	ymm10, ymm10, 10
	vpsrlw	ymm9, ymm9, 10
	vpackuswb	ymm9, ymm10, ymm9
	vpshufb	ymm10, ymm4, ymm8
	vpshufb	ymm11, ymm0, ymm8
	vpsllw	ymm12, ymm8, 3
	vpblendvb	ymm10, ymm10, ymm11, ymm12
	vpshufb	ymm11, ymm5, ymm8
	vpshufb	ymm13, ymm6, ymm8
	vpblendvb	ymm11, ymm11, ymm13, ymm12
	vpsllw	ymm8, ymm8, 2
	vpblendvb	ymm8, ymm10, ymm11, ymm8
	vpshufb	ymm10, ymm4, ymm9
	vpshufb	ymm11, ymm0, ymm9
	vpsllw	ymm12, ymm9, 3
	vpblendvb	ymm10, ymm10, ymm11, ymm12
	vpshufb	ymm11, ymm5, ymm9
	vpshufb	ymm13, ymm6, ymm9
	vpblendvb	ymm11, ymm11, ymm13, ymm12
	vpsllw	ymm9, ymm9, 2
	vpblendvb	ymm9, ymm10, ymm11, ymm9
	cmp	rdx, 64
	jae	1562b
	cmp	rdx, 32
	mov	r9, rdi
	jb	1652f
	vmovdqu	ymmword ptr [rcx - 32], ymm8
	mov	r9, rcx
	vmovdqa	ymm8, ymm9
	vpxor	xmm9, xmm9, xmm9
1652:
	test	r8b, 16
	je	1662f
	vmovdqu	xmmword ptr [r9], xmm8
	vperm2i128	ymm8, ymm8, ymm9, 33
	add	r9, 16
1662:
	vmovq	r11, xmm8
	vpextrq	r10, xmm8, 1
	test	r8b, 8
	cmove	r10, r11
	jne	1722f
	test	r8b, 4
	jne	1732f
1672:
	test	r8b, 2
	jne	1742f
1682:
	test	r8b, 1
	je	1572b
	jmp	1752f
	.p2align	4
1692:
	vpermq	ymm9, ymm8, 255
	vmovq	xmm9, xmm9
	vpermq	ymm8, ymm8, 144
	vmovq	xmm10, qword ptr [rsi + r10 - 8]
	add	r10, -8
	vpblendd	ymm8, ymm8, ymm10, 3
	test	r9b, r9b
	jns	1622b
1702:
	vmovdqu	xmm10, xmmword ptr [r10 + rsi - 16]
	vperm2i128	ymm9, ymm8, ymm9, 33
	vinserti128	ymm8, ymm10, xmm8, 1
	test	r9d, 256
	jne	1632b
	jmp	1642b
	.p2align	4
1712:
	cmp	r11d, 1
	jne	1762f
	movzx	r11d, byte ptr [rsi + r10]
	jmp	1612b
	.p2align	4
1722:
	mov	qword ptr [r9], r11
	add	r9, 8
	test	r8b, 4
	je	1672b
1732:
	mov	dword ptr [r9], r10d
	add	r9, 4
	shr	r10, 32
	test	r8b, 2
	je	1682b
1742:
	mov	word ptr [r9], r10w
	add	r9, 2
	shr	r10, 16
	test	r8b, 1
	je	1572b
1752:
	mov	byte ptr [r9], r10b
	jmp	1572b
1762:
	xor	r11d, r11d
	jmp	1612b
1772:
	add	rsp, 544
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	vzeroupper
	ret
	.p2align	4
1782:
	vmovd	xmm0, ecx
	vpbroadcastb	ymm0, xmm0
	xor	r8d, ecx
	vmovd	xmm1, r8d
	vpbroadcastb	ymm1, xmm1
	mov	rax, rsi
	shr	rax, 6
	je	1802f
	shl	rax, 3
	xor	ecx, ecx
	vmovdqa	ymm2, ymmword ptr [rip + 2992f]
	vpbroadcastq	ymm3, qword ptr [rip + 3002f]
	vmovdqa	ymm4, ymmword ptr [rip + 3012f]
	.p2align	4
1792:
	vpbroadcastq	ymm5, qword ptr [rdx + rcx]
	vpshufb	ymm6, ymm5, ymm2
	vpand	ymm6, ymm6, ymm3
	vpcmpeqb	ymm6, ymm6, ymm3
	vpand	ymm6, ymm6, ymm1
	vpshufb	ymm5, ymm5, ymm4
	vpand	ymm5, ymm5, ymm3
	vpcmpeqb	ymm5, ymm5, ymm3
	vpand	ymm5, ymm5, ymm1
	vpxor	ymm5, ymm5, ymm0
	vpxor	ymm6, ymm6, ymm0
	vmovdqu	ymmword ptr [rdi + 8*rcx + 32], ymm6
	vmovdqu	ymmword ptr [rdi + 8*rcx], ymm5
	add	rcx, 8
	cmp	rax, rcx
	jne	1792b
1802:
	mov	r8, rsi
	and	r8, 63
	je	1902f
	mov	eax, esi
	and	eax, -64
	mov	ecx, eax
	shr	ecx, 3
	add	rdx, rcx
	lea	ecx, [r8 + 7]
	shr	ecx, 3
	cmp	r8, 25
	jb	1812f
	mov	r8d, dword ptr [rdx]
	mov	edx, dword ptr [rdx + rcx - 4]
	add	rcx, -4
	jmp	1822f
1812:
	cmp	r8d, 9
	jb	1832f
	movzx	r8d, word ptr [rdx]
	movzx	edx, word ptr [rdx + rcx - 2]
	add	rcx, -2
1822:
	shl	ecx, 3
	shlx	rcx, rdx, rcx
	or	rcx, r8
	jmp	1842f
1832:
	movzx	ecx, byte ptr [rdx]
1842:
	add	rdi, rax
	vmovq	xmm2, rcx
	vpbroadcastq	ymm2, xmm2
	vpshufb	ymm3, ymm2, ymmword ptr [rip + 3012f]
	vpbroadcastq	ymm4, qword ptr [rip + 3002f]
	vpand	ymm3, ymm3, ymm4
	vpcmpeqb	ymm3, ymm3, ymm4
	vpand	ymm3, ymm3, ymm1
	vpshufb	ymm2, ymm2, ymmword ptr [rip + 2992f]
	vpand	ymm2, ymm2, ymm4
	vpcmpeqb	ymm2, ymm2, ymm4
	vpand	ymm1, ymm2, ymm1
	vpxor	ymm1, ymm1, ymm0
	vpxor	ymm0, ymm3, ymm0
	test	sil, 32
	je	1852f
	vmovdqu	ymmword ptr [rdi], ymm0
	add	rdi, 32
	vmovdqa	ymm0, ymm1
	vpxor	xmm1, xmm1, xmm1
1852:
	test	sil, 16
	je	1862f
	vmovdqu	xmmword ptr [rdi], xmm0
	vperm2i128	ymm0, ymm0, ymm1, 33
	add	rdi, 16
1862:
	vmovq	rcx, xmm0
	vpextrq	rax, xmm0, 1
	test	sil, 8
	cmove	rax, rcx
	jne	1912f
	test	sil, 4
	jne	1922f
1872:
	test	sil, 2
	jne	1932f
1882:
	test	sil, 1
	je	1902f
1892:
	mov	byte ptr [rdi], al
1902:
	vzeroupper
	ret
1912:
	mov	qword ptr [rdi], rcx
	add	rdi, 8
	test	sil, 4
	je	1872b
1922:
	mov	dword ptr [rdi], eax
	add	rdi, 4
	shr	rax, 32
	test	sil, 2
	je	1882b
1932:
	mov	word ptr [rdi], ax
	add	rdi, 2
	shr	rax, 16
	test	sil, 1
	jne	1892b
	jmp	1902b
	.p2align	4
1942:
	mov	rax, rdx
	shr	rax, 6
	je	1962f
	shl	rax, 6
	xor	ecx, ecx
	.p2align	4
1952:
	vmovdqu	ymm0, ymmword ptr [rsi + rcx]
	vmovdqu	ymm1, ymmword ptr [rsi + rcx + 32]
	vmovdqu	ymmword ptr [rdi + rcx + 32], ymm1
	vmovdqu	ymmword ptr [rdi + rcx], ymm0
	add	rcx, 64
	cmp	rax, rcx
	jne	1952b
1962:
	test	dl, 63
	je	2072f
	mov	eax, edx
	and	eax, -64
	add	rsi, rax
	mov	r8d, edx
	and	r8d, 7
	mov	ecx, edx
	and	ecx, 56
	lea	r9, [rsi + rcx]
	cmp	r8, 4
	jb	1972f
	mov	r10d, dword ptr [r9]
	mov	r9d, dword ptr [r9 + r8 - 4]
	add	r8, -4
	jmp	1982f
1972:
	cmp	r8d, 2
	jb	2142f
	movzx	r10d, word ptr [r9]
	movzx	r9d, word ptr [r9 + r8 - 2]
	add	r8, -2
1982:
	shl	r8d, 3
	shlx	r8, r9, r8
	or	r8, r10
1992:
	vmovq	xmm0, r8
	vpxor	xmm1, xmm1, xmm1
	test	dl, 8
	jne	2082f
	test	dl, 16
	jne	2092f
2002:
	add	rdi, rax
	test	dl, 32
	jne	2102f
2012:
	test	dl, 16
	je	2032f
2022:
	vmovdqu	xmmword ptr [rdi], xmm0
	vperm2i128	ymm0, ymm0, ymm1, 33
	add	rdi, 16
2032:
	test	dl, 8
	vmovq	rcx, xmm0
	vpextrq	rax, xmm0, 1
	cmove	rax, rcx
	jne	2112f
	test	dl, 4
	jne	2122f
2042:
	test	dl, 2
	jne	2132f
2052:
	test	dl, 1
	je	2072f
2062:
	mov	byte ptr [rdi], al
2072:
	vzeroupper
	ret
2082:
	vpermq	ymm1, ymm0, 255
	vmovq	xmm1, xmm1
	vpermq	ymm0, ymm0, 144
	vmovq	xmm2, qword ptr [rsi + rcx - 8]
	add	rcx, -8
	vpblendd	ymm0, ymm0, ymm2, 3
	test	dl, 16
	je	2002b
2092:
	vmovdqu	xmm2, xmmword ptr [rsi + rcx - 16]
	vperm2i128	ymm1, ymm0, ymm1, 33
	vinserti128	ymm0, ymm2, xmm0, 1
	add	rdi, rax
	test	dl, 32
	je	2012b
2102:
	vmovdqu	ymm1, ymmword ptr [rsi]
	vmovdqu	ymmword ptr [rdi], ymm1
	vpxor	xmm1, xmm1, xmm1
	add	rdi, 32
	test	dl, 16
	jne	2022b
	jmp	2032b
2112:
	mov	qword ptr [rdi], rcx
	add	rdi, 8
	test	dl, 4
	je	2042b
2122:
	mov	dword ptr [rdi], eax
	add	rdi, 4
	shr	rax, 32
	test	dl, 2
	je	2052b
2132:
	mov	word ptr [rdi], ax
	add	rdi, 2
	shr	rax, 16
	test	dl, 1
	jne	2062b
	jmp	2072b
2142:
	cmp	r8d, 1
	jne	2152f
	movzx	r8d, byte ptr [r9]
	jmp	1992b
2152:
	xor	r8d, r8d
	jmp	1992b
	.p2align	4
2162:
	sub	rsp, 40
	cmp	r9, 16
	jne	2182f
	cmp	r8, 4
	jg	2202f
	cmp	r8, 2
	je	2252f
	cmp	r8, 3
	je	2332f
	cmp	r8, 4
	jne	2412f
	test	rdx, rdx
	je	2412f
	vbroadcasti128	ymm1, xmmword ptr [rcx]
	shl	rdx, 6
	xor	eax, eax
	vpbroadcastb	ymm0, byte ptr [rip + 3022f]
	vinserti128	ymm1, ymm1, xmm1, 1
	.p2align	4
2172:
	vmovdqu	xmm2, xmmword ptr [rsi + rax]
	vmovdqu	xmm3, xmmword ptr [rsi + rax + 16]
	vmovdqu	xmm4, xmmword ptr [rsi + rax + 32]
	vmovdqu	xmm5, xmmword ptr [rsi + rax + 48]
	vpsrlw	xmm6, xmm2, 4
	vinserti128	ymm2, ymm2, xmm6, 1
	vpand	ymm2, ymm2, ymm0
	vpshufb	ymm2, ymm1, ymm2
	vmovdqu	ymmword ptr [rdi + 2*rax], ymm2
	vpsrlw	xmm2, xmm3, 4
	vinserti128	ymm2, ymm3, xmm2, 1
	vpand	ymm2, ymm2, ymm0
	vpshufb	ymm2, ymm1, ymm2
	vmovdqu	ymmword ptr [rdi + 2*rax + 32], ymm2
	vpsrlw	xmm2, xmm4, 4
	vinserti128	ymm2, ymm4, xmm2, 1
	vpand	ymm2, ymm2, ymm0
	vpshufb	ymm2, ymm1, ymm2
	vmovdqu	ymmword ptr [rdi + 2*rax + 64], ymm2
	vpsrlw	xmm2, xmm5, 4
	vinserti128	ymm2, ymm5, xmm2, 1
	vpand	ymm2, ymm2, ymm0
	vpshufb	ymm2, ymm1, ymm2
	vmovdqu	ymmword ptr [rdi + 2*rax + 96], ymm2
	add	rax, 64
	cmp	rdx, rax
	jne	2172b
	jmp	2412f
2182:
	cmp	r8, 4
	jg	2222f
	cmp	r8, 2
	je	2272f
	cmp	r8, 3
	je	2352f
	cmp	r8, 4
	jne	2412f
	test	rdx, rdx
	je	2412f
	vbroadcasti128	ymm0, xmmword ptr [rcx]
	shl	rdx, 8
	xor	eax, eax
	vpbroadcastb	ymm1, byte ptr [rip + 3022f]
	.p2align	4
2192:
	vmovdqu	ymm2, ymmword ptr [rsi + rax]
	vmovdqu	ymm3, ymmword ptr [rsi + rax + 64]
	vmovdqu	ymm4, ymmword ptr [rsi + rax + 128]
	vmovdqu	ymm5, ymmword ptr [rsi + rax + 192]
	vpand	ymm6, ymm2, ymm1
	vpshufb	ymm6, ymm0, ymm6
	vmovdqu	ymmword ptr [rdi + 2*rax], ymm6
	vpsrlw	ymm2, ymm2, 4
	vpand	ymm2, ymm2, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 2*rax + 64], ymm2
	vpand	ymm2, ymm3, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 2*rax + 128], ymm2
	vpsrlw	ymm2, ymm3, 4
	vpand	ymm2, ymm2, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 2*rax + 192], ymm2
	vpand	ymm2, ymm4, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 2*rax + 256], ymm2
	vpsrlw	ymm2, ymm4, 4
	vpand	ymm2, ymm2, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 2*rax + 320], ymm2
	vpand	ymm2, ymm5, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 2*rax + 384], ymm2
	vpsrlw	ymm2, ymm5, 4
	vpand	ymm2, ymm2, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 2*rax + 448], ymm2
	vmovdqu	ymm2, ymmword ptr [rsi + rax + 32]
	vmovdqu	ymm3, ymmword ptr [rsi + rax + 96]
	vmovdqu	ymm4, ymmword ptr [rsi + rax + 160]
	vmovdqu	ymm5, ymmword ptr [rsi + rax + 224]
	vpand	ymm6, ymm2, ymm1
	vpshufb	ymm6, ymm0, ymm6
	vmovdqu	ymmword ptr [rdi + 2*rax + 32], ymm6
	vpsrlw	ymm2, ymm2, 4
	vpand	ymm2, ymm2, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 2*rax + 96], ymm2
	vpand	ymm2, ymm3, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 2*rax + 160], ymm2
	vpsrlw	ymm2, ymm3, 4
	vpand	ymm2, ymm2, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 2*rax + 224], ymm2
	vpand	ymm2, ymm4, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 2*rax + 288], ymm2
	vpsrlw	ymm2, ymm4, 4
	vpand	ymm2, ymm2, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 2*rax + 352], ymm2
	vpand	ymm2, ymm5, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 2*rax + 416], ymm2
	vpsrlw	ymm2, ymm5, 4
	vpand	ymm2, ymm2, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 2*rax + 480], ymm2
	add	rax, 256
	cmp	rdx, rax
	jne	2192b
	jmp	2412f
2202:
	cmp	r8, 5
	je	2292f
	cmp	r8, 6
	je	2372f
	cmp	r8, 7
	jne	2412f
	test	rdx, rdx
	je	2412f
	vmovdqu	ymm1, ymmword ptr [rcx]
	vmovdqu	ymm3, ymmword ptr [rcx + 32]
	vmovdqu	ymm5, ymmword ptr [rcx + 64]
	vmovdqu	ymm7, ymmword ptr [rcx + 96]
	vpermq	ymm0, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpermq	ymm2, ymm3, 68
	vpermq	ymm3, ymm3, 238
	vpermq	ymm4, ymm5, 68
	vpermq	ymm5, ymm5, 238
	vpermq	ymm6, ymm7, 68
	vpermq	ymm7, ymm7, 238
	add	rsi, 96
	add	rdi, 112
	.p2align	4
2212:
	vmovdqu	xmm12, xmmword ptr [rsi - 96]
	vpbroadcastb	ymm8, byte ptr [rip + 3032f]
	vpand	xmm13, xmm12, xmm8
	vpshufb	xmm14, xmm0, xmm13
	vpshufb	xmm15, xmm1, xmm13
	vpsllw	xmm9, xmm12, 3
	vpblendvb	xmm14, xmm14, xmm15, xmm9
	vpshufb	xmm15, xmm2, xmm13
	vpshufb	xmm10, xmm3, xmm13
	vpblendvb	xmm10, xmm15, xmm10, xmm9
	vpsllw	xmm15, xmm12, 2
	vpblendvb	xmm10, xmm14, xmm10, xmm15
	vpshufb	xmm14, xmm4, xmm13
	vpshufb	xmm11, xmm5, xmm13
	vpblendvb	xmm11, xmm14, xmm11, xmm9
	vpshufb	xmm14, xmm6, xmm13
	vpshufb	xmm13, xmm7, xmm13
	vpblendvb	xmm9, xmm14, xmm13, xmm9
	vpblendvb	xmm9, xmm11, xmm9, xmm15
	vpaddw	xmm11, xmm12, xmm12
	vpblendvb	xmm9, xmm10, xmm9, xmm11
	vmovdqu	xmmword ptr [rdi - 112], xmm9
	vmovdqu	xmm9, xmmword ptr [rsi - 96]
	vmovdqu	xmm10, xmmword ptr [rsi - 80]
	vpsrlw	xmm9, xmm9, 7
	vpand	xmm9, xmm9, xmmword ptr [rip + 3042f]
	vpaddb	xmm10, xmm10, xmm10
	vpor	xmm9, xmm10, xmm9
	vpand	xmm11, xmm9, xmm8
	vpshufb	xmm12, xmm0, xmm11
	vpshufb	xmm13, xmm1, xmm11
	vpsllw	xmm14, xmm10, 3
	vpblendvb	xmm12, xmm12, xmm13, xmm14
	vpshufb	xmm13, xmm2, xmm11
	vpshufb	xmm15, xmm3, xmm11
	vpblendvb	xmm13, xmm13, xmm15, xmm14
	vpsllw	xmm10, xmm10, 2
	vpblendvb	xmm12, xmm12, xmm13, xmm10
	vpshufb	xmm13, xmm4, xmm11
	vpshufb	xmm15, xmm5, xmm11
	vpblendvb	xmm13, xmm13, xmm15, xmm14
	vpshufb	xmm15, xmm6, xmm11
	vpshufb	xmm11, xmm7, xmm11
	vpblendvb	xmm11, xmm15, xmm11, xmm14
	vpblendvb	xmm10, xmm13, xmm11, xmm10
	vpaddw	xmm9, xmm9, xmm9
	vpblendvb	xmm9, xmm12, xmm10, xmm9
	vmovdqu	xmmword ptr [rdi - 96], xmm9
	vmovdqu	xmm9, xmmword ptr [rsi - 80]
	vmovdqu	xmm10, xmmword ptr [rsi - 64]
	vmovdqa	xmm10, xmm10
	vpsrlw	xmm9, xmm9, 6
	vpand	ymm9, ymm9, ymmword ptr [rip + 3052f]
	vpaddb	ymm10, ymm10, ymm10
	vpaddb	ymm10, ymm10, ymm10
	vpor	ymm9, ymm10, ymm9
	vpand	xmm11, xmm9, xmm8
	vpshufb	xmm12, xmm0, xmm11
	vpshufb	xmm13, xmm1, xmm11
	vpsllw	xmm14, xmm10, 3
	vpblendvb	xmm12, xmm12, xmm13, xmm14
	vpshufb	xmm13, xmm2, xmm11
	vpshufb	xmm15, xmm3, xmm11
	vpblendvb	xmm13, xmm13, xmm15, xmm14
	vpsllw	xmm10, xmm10, 2
	vpblendvb	xmm12, xmm12, xmm13, xmm10
	vpshufb	xmm13, xmm4, xmm11
	vpshufb	xmm15, xmm5, xmm11
	vpblendvb	xmm13, xmm13, xmm15, xmm14
	vpshufb	xmm15, xmm6, xmm11
	vpshufb	xmm11, xmm7, xmm11
	vpblendvb	xmm11, xmm15, xmm11, xmm14
	vpblendvb	xmm10, xmm13, xmm11, xmm10
	vpaddw	xmm9, xmm9, xmm9
	vpblendvb	xmm9, xmm12, xmm10, xmm9
	vmovdqu	xmmword ptr [rdi - 80], xmm9
	vmovdqu	xmm9, xmmword ptr [rsi - 64]
	vmovdqu	xmm10, xmmword ptr [rsi - 48]
	vpsrlw	xmm9, xmm9, 5
	vpand	ymm9, ymm9, ymmword ptr [rip + 3062f]
	vpsllw	ymm11, ymm10, 3
	vpand	ymm12, ymm11, ymmword ptr [rip + 3072f]
	vpor	ymm9, ymm12, ymm9
	vpand	xmm12, xmm9, xmm8
	vpshufb	xmm13, xmm0, xmm12
	vpshufb	xmm14, xmm1, xmm12
	vpsllw	xmm10, xmm10, 6
	vpblendvb	xmm13, xmm13, xmm14, xmm10
	vpshufb	xmm14, xmm2, xmm12
	vpshufb	xmm15, xmm3, xmm12
	vpblendvb	xmm14, xmm14, xmm15, xmm10
	vpsllw	xmm11, xmm11, 2
	vpblendvb	xmm13, xmm13, xmm14, xmm11
	vpshufb	xmm14, xmm4, xmm12
	vpshufb	xmm15, xmm5, xmm12
	vpblendvb	xmm14, xmm14, xmm15, xmm10
	vpshufb	xmm15, xmm6, xmm12
	vpshufb	xmm12, xmm7, xmm12
	vpblendvb	xmm10, xmm15, xmm12, xmm10
	vpblendvb	xmm10, xmm14, xmm10, xmm11
	vpaddw	xmm9, xmm9, xmm9
	vpblendvb	xmm9, xmm13, xmm10, xmm9
	vmovdqu	xmmword ptr [rdi - 64], xmm9
	vmovdqu	xmm9, xmmword ptr [rsi - 48]
	vmovdqu	xmm10, xmmword ptr [rsi - 32]
	vpsrlw	xmm9, xmm9, 4
	vpand	ymm9, ymm9, ymmword ptr [rip + 3082f]
	vpsllw	ymm11, ymm10, 4
	vpand	ymm12, ymm11, ymmword ptr [rip + 3092f]
	vpor	ymm9, ymm12, ymm9
	vpand	xmm12, xmm9, xmm8
	vpshufb	xmm13, xmm0, xmm12
	vpshufb	xmm14, xmm1, xmm12
	vpsllw	xmm10, xmm10, 7
	vpblendvb	xmm13, xmm13, xmm14, xmm10
	vpshufb	xmm14, xmm2, xmm12
	vpshufb	xmm15, xmm3, xmm12
	vpblendvb	xmm14, xmm14, xmm15, xmm10
	vpsllw	xmm11, xmm11, 2
	vpblendvb	xmm13, xmm13, xmm14, xmm11
	vpshufb	xmm14, xmm4, xmm12
	vpshufb	xmm15, xmm5, xmm12
	vpblendvb	xmm14, xmm14, xmm15, xmm10
	vpshufb	xmm15, xmm6, xmm12
	vpshufb	xmm12, xmm7, xmm12
	vpblendvb	xmm10, xmm15, xmm12, xmm10
	vpblendvb	xmm10, xmm14, xmm10, xmm11
	vpaddw	xmm9, xmm9, xmm9
	vpblendvb	xmm9, xmm13, xmm10, xmm9
	vmovdqu	xmmword ptr [rdi - 48], xmm9
	vmovdqu	xmm9, xmmword ptr [rsi - 32]
	vmovdqu	xmm10, xmmword ptr [rsi - 16]
	vpsrlw	xmm11, xmm9, 3
	vpand	ymm11, ymm11, ymmword ptr [rip + 3102f]
	vpsllw	ymm10, ymm10, 5
	vpand	ymm12, ymm10, ymmword ptr [rip + 3112f]
	vpor	ymm11, ymm12, ymm11
	vpand	xmm12, xmm11, xmm8
	vpshufb	xmm13, xmm0, xmm12
	vpshufb	xmm14, xmm1, xmm12
	vpblendvb	xmm13, xmm13, xmm14, xmm9
	vpshufb	xmm14, xmm2, xmm12
	vpshufb	xmm15, xmm3, xmm12
	vpblendvb	xmm14, xmm14, xmm15, xmm9
	vpsllw	xmm10, xmm10, 2
	vpblendvb	xmm13, xmm13, xmm14, xmm10
	vpshufb	xmm14, xmm4, xmm12
	vpshufb	xmm15, xmm5, xmm12
	vpblendvb	xmm14, xmm14, xmm15, xmm9
	vpshufb	xmm15, xmm6, xmm12
	vpshufb	xmm12, xmm7, xmm12
	vpblendvb	xmm9, xmm15, xmm12, xmm9
	vpblendvb	xmm9, xmm14, xmm9, xmm10
	vpaddw	xmm10, xmm11, xmm11
	vpblendvb	xmm9, xmm13, xmm9, xmm10
	vmovdqu	xmmword ptr [rdi - 32], xmm9
	vmovdqu	xmm9, xmmword ptr [rsi - 16]
	vmovdqu	xmm10, xmmword ptr [rsi]
	vpsllw	xmm10, xmm10, 6
	vpand	ymm10, ymm10, ymmword ptr [rip + 3122f]
	vpsrlw	ymm11, ymm9, 2
	vpand	ymm12, ymm11, ymmword ptr [rip + 3132f]
	vpor	ymm10, ymm10, ymm12
	vpand	xmm12, xmm10, xmm8
	vpshufb	xmm13, xmm0, xmm12
	vpshufb	xmm14, xmm1, xmm12
	vpaddw	xmm9, xmm9, xmm9
	vpblendvb	xmm13, xmm13, xmm14, xmm9
	vpshufb	xmm14, xmm2, xmm12
	vpshufb	xmm15, xmm3, xmm12
	vpblendvb	xmm14, xmm14, xmm15, xmm9
	vpsllw	xmm11, xmm11, 2
	vpblendvb	xmm13, xmm13, xmm14, xmm11
	vpshufb	xmm14, xmm4, xmm12
	vpshufb	xmm15, xmm5, xmm12
	vpblendvb	xmm14, xmm14, xmm15, xmm9
	vpshufb	xmm15, xmm6, xmm12
	vpshufb	xmm12, xmm7, xmm12
	vpblendvb	xmm9, xmm15, xmm12, xmm9
	vpblendvb	xmm9, xmm14, xmm9, xmm11
	vpaddw	xmm10, xmm10, xmm10
	vpblendvb	xmm9, xmm13, xmm9, xmm10
	vmovdqu	xmmword ptr [rdi - 16], xmm9
	vmovdqu	xmm9, xmmword ptr [rsi]
	vpsrlw	xmm10, xmm9, 1
	vpand	xmm11, xmm10, xmm8
	vpshufb	xmm12, xmm0, xmm11
	vpshufb	xmm13, xmm1, xmm11
	vpsllw	xmm14, xmm9, 2
	vpblendvb	xmm12, xmm12, xmm13, xmm14
	vpshufb	xmm13, xmm2, xmm11
	vpshufb	xmm15, xmm3, xmm11
	vpblendvb	xmm13, xmm13, xmm15, xmm14
	vpshufb	xmm15, xmm4, xmm11
	vpshufb	xmm8, xmm5, xmm11
	vpblendvb	xmm8, xmm15, xmm8, xmm14
	vpshufb	xmm15, xmm6, xmm11
	vpshufb	xmm11, xmm7, xmm11
	vpblendvb	xmm11, xmm15, xmm11, xmm14
	vpaddw	xmm9, xmm9, xmm9
	vpblendvb	xmm12, xmm12, xmm13, xmm9
	vpblendvb	xmm8, xmm8, xmm11, xmm9
	vpaddw	xmm9, xmm10, xmm10
	vpblendvb	xmm8, xmm12, xmm8, xmm9
	vmovdqu	xmmword ptr [rdi], xmm8
	add	rsi, 112
	sub	rdi, -128
	dec	rdx
	jne	2212b
	jmp	2412f
2222:
	cmp	r8, 5
	je	2312f
	cmp	r8, 6
	je	2392f
	cmp	r8, 7
	jne	2412f
	test	rdx, rdx
	je	2412f
	vmovdqu	ymm1, ymmword ptr [rcx]
	vmovdqu	ymm3, ymmword ptr [rcx + 32]
	vmovdqu	ymm5, ymmword ptr [rcx + 64]
	vmovdqu	ymm7, ymmword ptr [rcx + 96]
	vpermq	ymm0, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpermq	ymm2, ymm3, 68
	vpermq	ymm3, ymm3, 238
	vpermq	ymm4, ymm5, 68
	vpermq	ymm5, ymm5, 238
	vpermq	ymm6, ymm7, 68
	vpermq	ymm7, ymm7, 238
	xor	eax, eax
	vpbroadcastb	ymm8, byte ptr [rip + 3032f]
	vmovdqu	ymmword ptr [rsp], ymm4
	.p2align	4
2232:
	imul	rcx, rax, 448
	mov	r8, rax
	shl	r8, 9
	add	rcx, rsi
	add	r8, rdi
	mov	r9b, 1
	xor	r10d, r10d
	.p2align	4
2242:
	vmovdqu	ymm12, ymmword ptr [rcx + r10]
	vpand	ymm13, ymm12, ymm8
	vpshufb	ymm14, ymm0, ymm13
	vpshufb	ymm15, ymm1, ymm13
	vpsllw	ymm9, ymm12, 3
	vpblendvb	ymm14, ymm14, ymm15, ymm9
	vpshufb	ymm15, ymm2, ymm13
	vpshufb	ymm10, ymm3, ymm13
	vpblendvb	ymm10, ymm15, ymm10, ymm9
	vpsllw	ymm15, ymm12, 2
	vpblendvb	ymm10, ymm14, ymm10, ymm15
	vpshufb	ymm14, ymm4, ymm13
	vpshufb	ymm11, ymm5, ymm13
	vpblendvb	ymm11, ymm14, ymm11, ymm9
	vpshufb	ymm14, ymm6, ymm13
	vpshufb	ymm13, ymm7, ymm13
	vpblendvb	ymm9, ymm14, ymm13, ymm9
	vpblendvb	ymm9, ymm11, ymm9, ymm15
	vpaddw	ymm11, ymm12, ymm12
	vpblendvb	ymm9, ymm10, ymm9, ymm11
	vmovdqu	ymmword ptr [r8 + r10], ymm9
	vmovdqu	ymm9, ymmword ptr [rcx + r10]
	vmovdqu	ymm10, ymmword ptr [rcx + r10 + 64]
	vpsrlw	ymm9, ymm9, 7
	vpand	ymm9, ymm9, ymmword ptr [rip + 3042f]
	vpaddb	ymm10, ymm10, ymm10
	vpor	ymm9, ymm10, ymm9
	vpand	ymm11, ymm9, ymm8
	vpshufb	ymm12, ymm0, ymm11
	vpshufb	ymm13, ymm1, ymm11
	vpsllw	ymm14, ymm10, 3
	vpblendvb	ymm12, ymm12, ymm13, ymm14
	vpshufb	ymm13, ymm2, ymm11
	vpshufb	ymm15, ymm3, ymm11
	vpblendvb	ymm13, ymm13, ymm15, ymm14
	vpsllw	ymm10, ymm10, 2
	vpblendvb	ymm12, ymm12, ymm13, ymm10
	vpshufb	ymm13, ymm4, ymm11
	vpshufb	ymm15, ymm5, ymm11
	vpblendvb	ymm13, ymm13, ymm15, ymm14
	vpshufb	ymm15, ymm6, ymm11
	vpshufb	ymm11, ymm7, ymm11
	vpblendvb	ymm11, ymm15, ymm11, ymm14
	vpblendvb	ymm10, ymm13, ymm11, ymm10
	vpaddw	ymm9, ymm9, ymm9
	vpblendvb	ymm9, ymm12, ymm10, ymm9
	vmovdqu	ymmword ptr [r8 + r10 + 64], ymm9
	vmovdqu	ymm9, ymmword ptr [rcx + r10 + 64]
	vmovdqu	ymm10, ymmword ptr [rcx + r10 + 128]
	vpsrlw	ymm9, ymm9, 6
	vpand	ymm9, ymm9, ymmword ptr [rip + 3052f]
	vpaddb	ymm10, ymm10, ymm10
	vpaddb	ymm10, ymm10, ymm10
	vpor	ymm9, ymm10, ymm9
	vpand	ymm11, ymm9, ymm8
	vpshufb	ymm12, ymm0, ymm11
	vpshufb	ymm13, ymm1, ymm11
	vpsllw	ymm14, ymm10, 3
	vpblendvb	ymm12, ymm12, ymm13, ymm14
	vpshufb	ymm13, ymm2, ymm11
	vpshufb	ymm15, ymm3, ymm11
	vpblendvb	ymm13, ymm13, ymm15, ymm14
	vpsllw	ymm10, ymm10, 2
	vpblendvb	ymm12, ymm12, ymm13, ymm10
	vpshufb	ymm13, ymm4, ymm11
	vpshufb	ymm15, ymm5, ymm11
	vpblendvb	ymm13, ymm13, ymm15, ymm14
	vpshufb	ymm15, ymm6, ymm11
	vpshufb	ymm11, ymm7, ymm11
	vpblendvb	ymm11, ymm15, ymm11, ymm14
	vpblendvb	ymm10, ymm13, ymm11, ymm10
	vpaddw	ymm9, ymm9, ymm9
	vpblendvb	ymm9, ymm12, ymm10, ymm9
	vmovdqu	ymmword ptr [r8 + r10 + 128], ymm9
	vmovdqu	ymm9, ymmword ptr [rcx + r10 + 128]
	vmovdqu	ymm10, ymmword ptr [rcx + r10 + 192]
	vpsrlw	ymm9, ymm9, 5
	vpand	ymm9, ymm9, ymmword ptr [rip + 3062f]
	vpsllw	ymm11, ymm10, 3
	vpand	ymm11, ymm11, ymmword ptr [rip + 3072f]
	vpor	ymm9, ymm11, ymm9
	vpand	ymm12, ymm9, ymm8
	vpshufb	ymm13, ymm0, ymm12
	vpshufb	ymm14, ymm1, ymm12
	vpsllw	ymm10, ymm10, 6
	vpblendvb	ymm13, ymm13, ymm14, ymm10
	vpshufb	ymm14, ymm2, ymm12
	vpshufb	ymm15, ymm3, ymm12
	vpblendvb	ymm14, ymm14, ymm15, ymm10
	vpsllw	ymm11, ymm11, 2
	vpblendvb	ymm13, ymm13, ymm14, ymm11
	vpshufb	ymm14, ymm4, ymm12
	vpshufb	ymm15, ymm5, ymm12
	vpblendvb	ymm14, ymm14, ymm15, ymm10
	vpshufb	ymm15, ymm6, ymm12
	vpshufb	ymm12, ymm7, ymm12
	vpblendvb	ymm10, ymm15, ymm12, ymm10
	vpblendvb	ymm10, ymm14, ymm10, ymm11
	vpaddw	ymm9, ymm9, ymm9
	vpblendvb	ymm9, ymm13, ymm10, ymm9
	vmovdqu	ymmword ptr [r8 + r10 + 192], ymm9
	vmovdqu	ymm9, ymmword ptr [rcx + r10 + 192]
	vmovdqu	ymm10, ymmword ptr [rcx + r10 + 256]
	vpsrlw	ymm9, ymm9, 4
	vpand	ymm9, ymm9, ymmword ptr [rip + 3082f]
	vpsllw	ymm11, ymm10, 4
	vpand	ymm11, ymm11, ymmword ptr [rip + 3092f]
	vpor	ymm9, ymm11, ymm9
	vpand	ymm12, ymm9, ymm8
	vpshufb	ymm13, ymm0, ymm12
	vpshufb	ymm14, ymm1, ymm12
	vpsllw	ymm10, ymm10, 7
	vpblendvb	ymm13, ymm13, ymm14, ymm10
	vpshufb	ymm14, ymm2, ymm12
	vpshufb	ymm15, ymm3, ymm12
	vpblendvb	ymm14, ymm14, ymm15, ymm10
	vpsllw	ymm11, ymm11, 2
	vpblendvb	ymm13, ymm13, ymm14, ymm11
	vpshufb	ymm14, ymm4, ymm12
	vpshufb	ymm15, ymm5, ymm12
	vpblendvb	ymm14, ymm14, ymm15, ymm10
	vpshufb	ymm15, ymm6, ymm12
	vpshufb	ymm12, ymm7, ymm12
	vpblendvb	ymm10, ymm15, ymm12, ymm10
	vpblendvb	ymm10, ymm14, ymm10, ymm11
	vpaddw	ymm9, ymm9, ymm9
	vpblendvb	ymm9, ymm13, ymm10, ymm9
	vmovdqu	ymmword ptr [r8 + r10 + 256], ymm9
	vmovdqu	ymm9, ymmword ptr [rcx + r10 + 256]
	vmovdqu	ymm10, ymmword ptr [rcx + r10 + 320]
	vpsrlw	ymm11, ymm9, 3
	vpand	ymm11, ymm11, ymmword ptr [rip + 3102f]
	vpsllw	ymm10, ymm10, 5
	vpand	ymm10, ymm10, ymmword ptr [rip + 3112f]
	vpor	ymm11, ymm10, ymm11
	vpand	ymm12, ymm11, ymm8
	vpshufb	ymm13, ymm0, ymm12
	vpshufb	ymm14, ymm1, ymm12
	vpblendvb	ymm13, ymm13, ymm14, ymm9
	vpshufb	ymm14, ymm2, ymm12
	vpshufb	ymm15, ymm3, ymm12
	vpblendvb	ymm14, ymm14, ymm15, ymm9
	vpsllw	ymm10, ymm10, 2
	vpblendvb	ymm13, ymm13, ymm14, ymm10
	vpshufb	ymm14, ymm4, ymm12
	vpshufb	ymm15, ymm5, ymm12
	vpblendvb	ymm14, ymm14, ymm15, ymm9
	vpshufb	ymm15, ymm6, ymm12
	vpshufb	ymm12, ymm7, ymm12
	vpblendvb	ymm9, ymm15, ymm12, ymm9
	vpblendvb	ymm9, ymm14, ymm9, ymm10
	vpaddw	ymm10, ymm11, ymm11
	vpblendvb	ymm9, ymm13, ymm9, ymm10
	vmovdqu	ymmword ptr [r8 + r10 + 320], ymm9
	vmovdqu	ymm9, ymmword ptr [rcx + r10 + 320]
	vmovdqu	ymm10, ymmword ptr [rcx + r10 + 384]
	vpsrlw	ymm11, ymm9, 2
	vpand	ymm11, ymm11, ymmword ptr [rip + 3132f]
	vpsllw	ymm10, ymm10, 6
	vpand	ymm10, ymm10, ymmword ptr [rip + 3122f]
	vpor	ymm10, ymm10, ymm11
	vpand	ymm12, ymm10, ymm8
	vpshufb	ymm13, ymm0, ymm12
	vpshufb	ymm14, ymm1, ymm12
	vpaddw	ymm9, ymm9, ymm9
	vpblendvb	ymm13, ymm13, ymm14, ymm9
	vpshufb	ymm14, ymm2, ymm12
	vpshufb	ymm15, ymm3, ymm12
	vpblendvb	ymm14, ymm14, ymm15, ymm9
	vpsllw	ymm11, ymm11, 2
	vpblendvb	ymm13, ymm13, ymm14, ymm11
	vpshufb	ymm14, ymm4, ymm12
	vpshufb	ymm15, ymm5, ymm12
	vpblendvb	ymm14, ymm14, ymm15, ymm9
	vpshufb	ymm15, ymm6, ymm12
	vpshufb	ymm12, ymm7, ymm12
	vpblendvb	ymm9, ymm15, ymm12, ymm9
	vpblendvb	ymm9, ymm14, ymm9, ymm11
	vpaddw	ymm10, ymm10, ymm10
	vpblendvb	ymm9, ymm13, ymm9, ymm10
	vmovdqu	ymmword ptr [r8 + r10 + 384], ymm9
	vmovdqu	ymm9, ymmword ptr [rcx + r10 + 384]
	vpsrlw	ymm10, ymm9, 1
	vpand	ymm11, ymm10, ymm8
	vpshufb	ymm12, ymm0, ymm11
	vpshufb	ymm13, ymm1, ymm11
	vpsllw	ymm14, ymm9, 2
	vpblendvb	ymm12, ymm12, ymm13, ymm14
	vpshufb	ymm13, ymm2, ymm11
	vpshufb	ymm15, ymm3, ymm11
	vpblendvb	ymm13, ymm13, ymm15, ymm14
	vpshufb	ymm15, ymm4, ymm11
	vmovdqa	ymm4, ymm3
	vmovdqa	ymm3, ymm2
	vmovdqa	ymm2, ymm1
	vmovdqa	ymm1, ymm0
	vmovdqa	ymm0, ymm8
	vpshufb	ymm8, ymm5, ymm11
	vpblendvb	ymm8, ymm15, ymm8, ymm14
	vpshufb	ymm15, ymm6, ymm11
	vpshufb	ymm11, ymm7, ymm11
	vpblendvb	ymm11, ymm15, ymm11, ymm14
	vpaddw	ymm9, ymm9, ymm9
	vpblendvb	ymm12, ymm12, ymm13, ymm9
	vpblendvb	ymm8, ymm8, ymm11, ymm9
	vpaddw	ymm9, ymm10, ymm10
	vpblendvb	ymm8, ymm12, ymm8, ymm9
	vmovdqu	ymmword ptr [r8 + r10 + 448], ymm8
	vmovdqa	ymm8, ymm0
	vmovdqa	ymm0, ymm1
	vmovdqa	ymm1, ymm2
	vmovdqa	ymm2, ymm3
	vmovdqa	ymm3, ymm4
	vmovdqu	ymm4, ymmword ptr [rsp]
	mov	r11d, r9d
	mov	r10d, 32
	xor	r9d, r9d
	test	r11b, 1
	jne	2242b
	inc	rax
	cmp	rax, rdx
	jne	2232b
	jmp	2412f
2252:
	test	rdx, rdx
	je	2412f
	vbroadcasti128	ymm1, xmmword ptr [rcx]
	shl	rdx, 5
	xor	eax, eax
	vpbroadcastb	ymm0, byte ptr [rip + 3142f]
	vinserti128	ymm1, ymm1, xmm1, 1
	.p2align	4
2262:
	vmovdqu	xmm2, xmmword ptr [rsi + rax]
	vmovdqu	xmm3, xmmword ptr [rsi + rax + 16]
	vpsrlw	xmm4, xmm2, 2
	vinserti128	ymm4, ymm2, xmm4, 1
	vpand	ymm4, ymm4, ymm0
	vpshufb	ymm4, ymm1, ymm4
	vmovdqu	ymmword ptr [rdi + 4*rax], ymm4
	vpsrlw	xmm4, xmm2, 4
	vpsrlw	xmm2, xmm2, 6
	vinserti128	ymm2, ymm4, xmm2, 1
	vpand	ymm2, ymm2, ymm0
	vpshufb	ymm2, ymm1, ymm2
	vmovdqu	ymmword ptr [rdi + 4*rax + 32], ymm2
	vpsrlw	xmm2, xmm3, 2
	vinserti128	ymm2, ymm3, xmm2, 1
	vpand	ymm2, ymm2, ymm0
	vpshufb	ymm2, ymm1, ymm2
	vmovdqu	ymmword ptr [rdi + 4*rax + 64], ymm2
	vpsrlw	xmm2, xmm3, 4
	vpsrlw	xmm3, xmm3, 6
	vinserti128	ymm2, ymm2, xmm3, 1
	vpand	ymm2, ymm2, ymm0
	vpshufb	ymm2, ymm1, ymm2
	vmovdqu	ymmword ptr [rdi + 4*rax + 96], ymm2
	add	rax, 32
	cmp	rdx, rax
	jne	2262b
	jmp	2412f
2272:
	test	rdx, rdx
	je	2412f
	vbroadcasti128	ymm0, xmmword ptr [rcx]
	shl	rdx, 7
	xor	eax, eax
	vpbroadcastb	ymm1, byte ptr [rip + 3142f]
	.p2align	4
2282:
	vmovdqu	ymm2, ymmword ptr [rsi + rax]
	vmovdqu	ymm3, ymmword ptr [rsi + rax + 64]
	vpand	ymm4, ymm2, ymm1
	vpshufb	ymm4, ymm0, ymm4
	vmovdqu	ymmword ptr [rdi + 4*rax], ymm4
	vpsrlw	ymm4, ymm2, 2
	vpand	ymm4, ymm4, ymm1
	vpshufb	ymm4, ymm0, ymm4
	vmovdqu	ymmword ptr [rdi + 4*rax + 64], ymm4
	vpsrlw	ymm4, ymm2, 4
	vpand	ymm4, ymm4, ymm1
	vpshufb	ymm4, ymm0, ymm4
	vmovdqu	ymmword ptr [rdi + 4*rax + 128], ymm4
	vpsrlw	ymm2, ymm2, 6
	vpand	ymm2, ymm2, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 4*rax + 192], ymm2
	vpand	ymm2, ymm3, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 4*rax + 256], ymm2
	vpsrlw	ymm2, ymm3, 2
	vpand	ymm2, ymm2, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 4*rax + 320], ymm2
	vpsrlw	ymm2, ymm3, 4
	vpand	ymm2, ymm2, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 4*rax + 384], ymm2
	vpsrlw	ymm2, ymm3, 6
	vpand	ymm2, ymm2, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 4*rax + 448], ymm2
	vmovdqu	ymm2, ymmword ptr [rsi + rax + 32]
	vmovdqu	ymm3, ymmword ptr [rsi + rax + 96]
	vpand	ymm4, ymm2, ymm1
	vpshufb	ymm4, ymm0, ymm4
	vmovdqu	ymmword ptr [rdi + 4*rax + 32], ymm4
	vpsrlw	ymm4, ymm2, 2
	vpand	ymm4, ymm4, ymm1
	vpshufb	ymm4, ymm0, ymm4
	vmovdqu	ymmword ptr [rdi + 4*rax + 96], ymm4
	vpsrlw	ymm4, ymm2, 4
	vpand	ymm4, ymm4, ymm1
	vpshufb	ymm4, ymm0, ymm4
	vmovdqu	ymmword ptr [rdi + 4*rax + 160], ymm4
	vpsrlw	ymm2, ymm2, 6
	vpand	ymm2, ymm2, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 4*rax + 224], ymm2
	vpand	ymm2, ymm3, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 4*rax + 288], ymm2
	vpsrlw	ymm2, ymm3, 2
	vpand	ymm2, ymm2, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 4*rax + 352], ymm2
	vpsrlw	ymm2, ymm3, 4
	vpand	ymm2, ymm2, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 4*rax + 416], ymm2
	vpsrlw	ymm2, ymm3, 6
	vpand	ymm2, ymm2, ymm1
	vpshufb	ymm2, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 4*rax + 480], ymm2
	sub	rax, -128
	cmp	rdx, rax
	jne	2282b
	jmp	2412f
2292:
	test	rdx, rdx
	je	2412f
	vmovdqu	ymm1, ymmword ptr [rcx]
	vpermq	ymm0, ymm1, 68
	vpermq	ymm1, ymm1, 238
	add	rsi, 64
	add	rdi, 112
	vpbroadcastb	ymm2, byte ptr [rip + 3152f]
	vpbroadcastb	ymm6, byte ptr [rip + 3162f]
	vpbroadcastb	ymm7, byte ptr [rip + 3022f]
	vpbroadcastb	ymm8, byte ptr [rip + 3142f]
	.p2align	4
2302:
	vmovdqu	xmm12, xmmword ptr [rsi - 64]
	vmovdqu	xmm14, xmmword ptr [rsi - 48]
	vmovdqu	xmm9, xmmword ptr [rsi - 32]
	vmovdqu	xmm11, xmmword ptr [rsi - 16]
	vmovdqa	xmm15, xmm9
	vmovdqu	xmm10, xmmword ptr [rsi]
	vpand	ymm9, ymm12, ymm2
	vpshufb	xmm13, xmm0, xmm9
	vpshufb	xmm3, xmm1, xmm9
	vpsllw	xmm9, xmm9, 3
	vpblendvb	xmm9, xmm13, xmm3, xmm9
	vpsrlw	ymm3, ymm12, 5
	vpand	ymm3, ymm3, ymmword ptr [rip + 3062f]
	vpsllw	ymm12, ymm14, 3
	vpand	ymm12, ymm12, ymmword ptr [rip + 3072f]
	vpor	ymm3, ymm12, ymm3
	vpand	ymm3, ymm3, ymm2
	vpshufb	xmm12, xmm0, xmm3
	vpshufb	xmm13, xmm1, xmm3
	vpsllw	xmm3, xmm3, 3
	vpblendvb	xmm12, xmm12, xmm13, xmm3
	vpsrlw	xmm3, xmm14, 2
	vpand	ymm3, ymm3, ymm2
	vpshufb	xmm13, xmm0, xmm3
	vpshufb	xmm4, xmm1, xmm3
	vpsllw	xmm3, xmm3, 3
	vpblendvb	xmm13, xmm13, xmm4, xmm3
	vpsrlw	ymm3, ymm14, 7
	vpand	ymm3, ymm3, ymmword ptr [rip + 3042f]
	vpaddb	ymm4, ymm15, ymm15
	vpor	ymm3, ymm4, ymm3
	vpand	ymm3, ymm3, ymm2
	vpshufb	xmm4, xmm0, xmm3
	vpshufb	xmm14, xmm1, xmm3
	vpsllw	xmm3, xmm3, 3
	vpblendvb	xmm14, xmm4, xmm14, xmm3
	vpsllw	ymm3, ymm11, 4
	vpand	ymm3, ymm3, ymm6
	vpsrlw	ymm4, ymm15, 4
	vpand	ymm4, ymm4, ymm7
	vpor	ymm3, ymm3, ymm4
	vpand	ymm3, ymm3, ymm2
	vpshufb	xmm4, xmm0, xmm3
	vpshufb	xmm15, xmm1, xmm3
	vpsllw	xmm3, xmm3, 3
	vpblendvb	xmm15, xmm4, xmm15, xmm3
	vpsrlw	xmm3, xmm11, 1
	vpand	ymm3, ymm3, ymm2
	vpshufb	xmm4, xmm0, xmm3
	vpshufb	xmm5, xmm1, xmm3
	vpsllw	xmm3, xmm3, 3
	vpblendvb	xmm3, xmm4, xmm5, xmm3
	vpsrlw	ymm4, ymm11, 6
	vpand	ymm4, ymm8, ymm4
	vmovdqa	xmm5, xmm10
	vpaddb	ymm5, ymm5, ymm5
	vpaddb	ymm5, ymm5, ymm5
	vpor	ymm4, ymm5, ymm4
	vpand	ymm4, ymm4, ymm2
	vpshufb	xmm5, xmm0, xmm4
	vpshufb	xmm11, xmm1, xmm4
	vpsllw	xmm4, xmm4, 3
	vpblendvb	xmm4, xmm5, xmm11, xmm4
	vpsrlw	xmm5, xmm10, 3
	vpand	ymm5, ymm5, ymm2
	vpshufb	xmm10, xmm0, xmm5
	vpshufb	xmm11, xmm1, xmm5
	vpsllw	xmm5, xmm5, 3
	vpblendvb	xmm5, xmm10, xmm11, xmm5
	vmovdqu	xmmword ptr [rdi - 112], xmm9
	vmovdqu	xmmword ptr [rdi - 96], xmm12
	vmovdqu	xmmword ptr [rdi - 80], xmm13
	vmovdqu	xmmword ptr [rdi - 64], xmm14
	vmovdqu	xmmword ptr [rdi - 32], xmm3
	vmovdqu	xmmword ptr [rdi - 48], xmm15
	vmovdqu	xmmword ptr [rdi], xmm5
	vmovdqu	xmmword ptr [rdi - 16], xmm4
	add	rsi, 80
	sub	rdi, -128
	dec	rdx
	jne	2302b
	jmp	2412f
2312:
	test	rdx, rdx
	je	2412f
	vmovdqu	ymm1, ymmword ptr [rcx]
	vpermq	ymm0, ymm1, 68
	vpermq	ymm1, ymm1, 238
	add	rsi, 288
	add	rdi, 480
	vpbroadcastb	ymm2, byte ptr [rip + 3152f]
	vpbroadcastb	ymm3, byte ptr [rip + 3172f]
	vpbroadcastb	ymm4, byte ptr [rip + 3182f]
	vpbroadcastb	ymm5, byte ptr [rip + 3162f]
	vpbroadcastb	ymm6, byte ptr [rip + 3142f]
	.p2align	4
2322:
	vmovdqu	ymm10, ymmword ptr [rsi - 288]
	vmovdqu	ymm11, ymmword ptr [rsi - 224]
	vmovdqu	ymm9, ymmword ptr [rsi - 160]
	vmovdqu	ymm8, ymmword ptr [rsi - 96]
	vmovdqu	ymm7, ymmword ptr [rsi - 32]
	vpand	ymm12, ymm10, ymm2
	vpshufb	ymm13, ymm0, ymm12
	vpshufb	ymm12, ymm1, ymm12
	vpsllw	ymm14, ymm10, 3
	vpblendvb	ymm12, ymm13, ymm12, ymm14
	vmovdqu	ymmword ptr [rdi - 480], ymm12
	vpsrlw	ymm10, ymm10, 5
	vpandn	ymm10, ymm3, ymm10
	vpsllw	ymm12, ymm11, 3
	vpand	ymm12, ymm12, ymm3
	vpor	ymm10, ymm12, ymm10
	vpand	ymm12, ymm10, ymm2
	vpshufb	ymm13, ymm0, ymm12
	vpshufb	ymm12, ymm1, ymm12
	vpsllw	ymm10, ymm10, 3
	vpblendvb	ymm10, ymm13, ymm12, ymm10
	vmovdqu	ymmword ptr [rdi - 416], ymm10
	vpsrlw	ymm10, ymm11, 2
	vpand	ymm12, ymm10, ymm2
	vpshufb	ymm13, ymm0, ymm12
	vpshufb	ymm12, ymm1, ymm12
	vpsllw	ymm10, ymm10, 3
	vpblendvb	ymm10, ymm13, ymm12, ymm10
	vmovdqu	ymmword ptr [rdi - 352], ymm10
	vpsrlw	ymm10, ymm11, 7
	vpand	ymm10, ymm10, ymm4
	vpaddb	ymm11, ymm9, ymm9
	vpor	ymm10, ymm11, ymm10
	vpand	ymm11, ymm10, ymm2
	vpshufb	ymm12, ymm0, ymm11
	vpshufb	ymm11, ymm1, ymm11
	vpsllw	ymm10, ymm10, 3
	vpblendvb	ymm10, ymm12, ymm11, ymm10
	vmovdqu	ymmword ptr [rdi - 288], ymm10
	vpsllw	ymm10, ymm8, 4
	vpand	ymm10, ymm10, ymm5
	vpsrlw	ymm9, ymm9, 4
	vpandn	ymm9, ymm5, ymm9
	vpor	ymm9, ymm10, ymm9
	vpand	ymm10, ymm9, ymm2
	vpshufb	ymm11, ymm0, ymm10
	vpshufb	ymm10, ymm1, ymm10
	vpsllw	ymm9, ymm9, 3
	vpblendvb	ymm9, ymm11, ymm10, ymm9
	vmovdqu	ymmword ptr [rdi - 224], ymm9
	vpsrlw	ymm9, ymm8, 1
	vpand	ymm10, ymm9, ymm2
	vpshufb	ymm11, ymm0, ymm10
	vpshufb	ymm10, ymm1, ymm10
	vpsllw	ymm9, ymm9, 3
	vpblendvb	ymm9, ymm11, ymm10, ymm9
	vmovdqu	ymmword ptr [rdi - 160], ymm9
	vpsrlw	ymm8, ymm8, 6
	vpand	ymm8, ymm8, ymm6
	vpaddb	ymm9, ymm7, ymm7
	vpaddb	ymm9, ymm9, ymm9
	vpor	ymm8, ymm9, ymm8
	vpand	ymm9, ymm8, ymm2
	vpshufb	ymm10, ymm0, ymm9
	vpshufb	ymm9, ymm1, ymm9
	vpsllw	ymm8, ymm8, 3
	vpblendvb	ymm8, ymm10, ymm9, ymm8
	vmovdqu	ymmword ptr [rdi - 96], ymm8
	vpsrlw	ymm7, ymm7, 3
	vpand	ymm8, ymm7, ymm2
	vpshufb	ymm9, ymm0, ymm8
	vpshufb	ymm8, ymm1, ymm8
	vpsllw	ymm7, ymm7, 3
	vpblendvb	ymm7, ymm9, ymm8, ymm7
	vmovdqu	ymmword ptr [rdi - 32], ymm7
	vmovdqu	ymm10, ymmword ptr [rsi - 256]
	vmovdqu	ymm11, ymmword ptr [rsi - 192]
	vmovdqu	ymm9, ymmword ptr [rsi - 128]
	vmovdqu	ymm8, ymmword ptr [rsi - 64]
	vmovdqu	ymm7, ymmword ptr [rsi]
	vpand	ymm12, ymm10, ymm2
	vpshufb	ymm13, ymm0, ymm12
	vpshufb	ymm12, ymm1, ymm12
	vpsllw	ymm14, ymm10, 3
	vpblendvb	ymm12, ymm13, ymm12, ymm14
	vmovdqu	ymmword ptr [rdi - 448], ymm12
	vpsrlw	ymm10, ymm10, 5
	vpandn	ymm10, ymm3, ymm10
	vpsllw	ymm12, ymm11, 3
	vpand	ymm12, ymm12, ymm3
	vpor	ymm10, ymm12, ymm10
	vpand	ymm12, ymm10, ymm2
	vpshufb	ymm13, ymm0, ymm12
	vpshufb	ymm12, ymm1, ymm12
	vpsllw	ymm10, ymm10, 3
	vpblendvb	ymm10, ymm13, ymm12, ymm10
	vmovdqu	ymmword ptr [rdi - 384], ymm10
	vpsrlw	ymm10, ymm11, 2
	vpand	ymm12, ymm10, ymm2
	vpshufb	ymm13, ymm0, ymm12
	vpshufb	ymm12, ymm1, ymm12
	vpsllw	ymm10, ymm10, 3
	vpblendvb	ymm10, ymm13, ymm12, ymm10
	vmovdqu	ymmword ptr [rdi - 320], ymm10
	vpsrlw	ymm10, ymm11, 7
	vpand	ymm10, ymm10, ymm4
	vpaddb	ymm11, ymm9, ymm9
	vpor	ymm10, ymm11, ymm10
	vpand	ymm11, ymm10, ymm2
	vpshufb	ymm12, ymm0, ymm11
	vpshufb	ymm11, ymm1, ymm11
	vpsllw	ymm10, ymm10, 3
	vpblendvb	ymm10, ymm12, ymm11, ymm10
	vmovdqu	ymmword ptr [rdi - 256], ymm10
	vpsllw	ymm10, ymm8, 4
	vpand	ymm10, ymm10, ymm5
	vpsrlw	ymm9, ymm9, 4
	vpandn	ymm9, ymm5, ymm9
	vpor	ymm9, ymm10, ymm9
	vpand	ymm10, ymm9, ymm2
	vpshufb	ymm11, ymm0, ymm10
	vpshufb	ymm10, ymm1, ymm10
	vpsllw	ymm9, ymm9, 3
	vpblendvb	ymm9, ymm11, ymm10, ymm9
	vmovdqu	ymmword ptr [rdi - 192], ymm9
	vpsrlw	ymm9, ymm8, 1
	vpand	ymm10, ymm9, ymm2
	vpshufb	ymm11, ymm0, ymm10
	vpshufb	ymm10, ymm1, ymm10
	vpsllw	ymm9, ymm9, 3
	vpblendvb	ymm9, ymm11, ymm10, ymm9
	vmovdqu	ymmword ptr [rdi - 128], ymm9
	vpsrlw	ymm8, ymm8, 6
	vpand	ymm8, ymm8, ymm6
	vpaddb	ymm9, ymm7, ymm7
	vpaddb	ymm9, ymm9, ymm9
	vpor	ymm8, ymm9, ymm8
	vpand	ymm9, ymm8, ymm2
	vpshufb	ymm10, ymm0, ymm9
	vpshufb	ymm9, ymm1, ymm9
	vpsllw	ymm8, ymm8, 3
	vpblendvb	ymm8, ymm10, ymm9, ymm8
	vmovdqu	ymmword ptr [rdi - 64], ymm8
	vpsrlw	ymm7, ymm7, 3
	vpand	ymm8, ymm7, ymm2
	vpshufb	ymm9, ymm0, ymm8
	vpshufb	ymm8, ymm1, ymm8
	vpsllw	ymm7, ymm7, 3
	vpblendvb	ymm7, ymm9, ymm8, ymm7
	vmovdqu	ymmword ptr [rdi], ymm7
	add	rsi, 320
	add	rdi, 512
	dec	rdx
	jne	2322b
	jmp	2412f
2332:
	test	rdx, rdx
	je	2412f
	vbroadcasti128	ymm1, xmmword ptr [rcx]
	add	rsi, 32
	add	rdi, 112
	vpbroadcastb	ymm0, byte ptr [rip + 3192f]
	vinserti128	ymm1, ymm1, xmm1, 1
	vpbroadcastb	xmm2, byte ptr [rip + 3142f]
	vpbroadcastb	xmm3, byte ptr [rip + 3182f]
	.p2align	4
2342:
	vmovdqu	xmm4, xmmword ptr [rsi - 32]
	vmovdqu	xmm5, xmmword ptr [rsi - 16]
	vmovdqu	xmm6, xmmword ptr [rsi]
	vpsrlw	xmm7, xmm4, 3
	vinserti128	ymm7, ymm4, xmm7, 1
	vpand	ymm7, ymm7, ymm0
	vpshufb	ymm7, ymm1, ymm7
	vmovdqu	ymmword ptr [rdi - 112], ymm7
	vpsrlw	xmm4, xmm4, 6
	vpand	xmm4, xmm4, xmm2
	vpaddb	xmm7, xmm5, xmm5
	vpaddb	xmm7, xmm7, xmm7
	vpor	xmm4, xmm7, xmm4
	vpsrlw	xmm7, xmm5, 1
	vinserti128	ymm4, ymm4, xmm7, 1
	vpand	ymm4, ymm4, ymm0
	vpshufb	ymm4, ymm1, ymm4
	vmovdqu	ymmword ptr [rdi - 80], ymm4
	vpsrlw	xmm4, xmm5, 4
	vpsrlw	xmm5, xmm5, 7
	vpand	xmm5, xmm5, xmm3
	vpaddb	xmm7, xmm6, xmm6
	vpor	xmm5, xmm7, xmm5
	vinserti128	ymm4, ymm4, xmm5, 1
	vpand	ymm4, ymm4, ymm0
	vpshufb	ymm4, ymm1, ymm4
	vmovdqu	ymmword ptr [rdi - 48], ymm4
	vpsrlw	xmm4, xmm6, 2
	vpsrlw	xmm5, xmm6, 5
	vinserti128	ymm4, ymm4, xmm5, 1
	vpand	ymm4, ymm4, ymm0
	vpshufb	ymm4, ymm1, ymm4
	vmovdqu	ymmword ptr [rdi - 16], ymm4
	add	rsi, 48
	sub	rdi, -128
	dec	rdx
	jne	2342b
	jmp	2412f
2352:
	test	rdx, rdx
	je	2412f
	vbroadcasti128	ymm0, xmmword ptr [rcx]
	add	rsi, 160
	add	rdi, 480
	vpbroadcastb	ymm1, byte ptr [rip + 3192f]
	vpbroadcastb	ymm2, byte ptr [rip + 3142f]
	vpbroadcastb	ymm3, byte ptr [rip + 3182f]
	.p2align	4
2362:
	vmovdqu	ymm5, ymmword ptr [rsi - 160]
	vmovdqu	ymm6, ymmword ptr [rsi - 96]
	vmovdqu	ymm4, ymmword ptr [rsi - 32]
	vpand	ymm7, ymm5, ymm1
	vpshufb	ymm7, ymm0, ymm7
	vmovdqu	ymmword ptr [rdi - 480], ymm7
	vpsrlw	ymm7, ymm5, 3
	vpand	ymm7, ymm7, ymm1
	vpshufb	ymm7, ymm0, ymm7
	vmovdqu	ymmword ptr [rdi - 416], ymm7
	vpsrlw	ymm5, ymm5, 6
	vpand	ymm5, ymm5, ymm2
	vpaddb	ymm7, ymm6, ymm6
	vpaddb	ymm7, ymm7, ymm7
	vpor	ymm5, ymm7, ymm5
	vpand	ymm5, ymm5, ymm1
	vpshufb	ymm5, ymm0, ymm5
	vmovdqu	ymmword ptr [rdi - 352], ymm5
	vpsrlw	ymm5, ymm6, 1
	vpand	ymm5, ymm5, ymm1
	vpshufb	ymm5, ymm0, ymm5
	vmovdqu	ymmword ptr [rdi - 288], ymm5
	vpsrlw	ymm5, ymm6, 4
	vpand	ymm5, ymm5, ymm1
	vpshufb	ymm5, ymm0, ymm5
	vmovdqu	ymmword ptr [rdi - 224], ymm5
	vpsrlw	ymm5, ymm6, 7
	vpand	ymm5, ymm5, ymm3
	vpaddb	ymm6, ymm4, ymm4
	vpor	ymm5, ymm6, ymm5
	vpand	ymm5, ymm5, ymm1
	vpshufb	ymm5, ymm0, ymm5
	vmovdqu	ymmword ptr [rdi - 160], ymm5
	vpsrlw	ymm5, ymm4, 2
	vpand	ymm5, ymm5, ymm1
	vpshufb	ymm5, ymm0, ymm5
	vmovdqu	ymmword ptr [rdi - 96], ymm5
	vpsrlw	ymm4, ymm4, 5
	vpand	ymm4, ymm4, ymm1
	vpshufb	ymm4, ymm0, ymm4
	vmovdqu	ymmword ptr [rdi - 32], ymm4
	vmovdqu	ymm5, ymmword ptr [rsi - 128]
	vmovdqu	ymm6, ymmword ptr [rsi - 64]
	vmovdqu	ymm4, ymmword ptr [rsi]
	vpand	ymm7, ymm5, ymm1
	vpshufb	ymm7, ymm0, ymm7
	vmovdqu	ymmword ptr [rdi - 448], ymm7
	vpsrlw	ymm7, ymm5, 3
	vpand	ymm7, ymm7, ymm1
	vpshufb	ymm7, ymm0, ymm7
	vmovdqu	ymmword ptr [rdi - 384], ymm7
	vpsrlw	ymm5, ymm5, 6
	vpand	ymm5, ymm5, ymm2
	vpaddb	ymm7, ymm6, ymm6
	vpaddb	ymm7, ymm7, ymm7
	vpor	ymm5, ymm7, ymm5
	vpand	ymm5, ymm5, ymm1
	vpshufb	ymm5, ymm0, ymm5
	vmovdqu	ymmword ptr [rdi - 320], ymm5
	vpsrlw	ymm5, ymm6, 1
	vpand	ymm5, ymm5, ymm1
	vpshufb	ymm5, ymm0, ymm5
	vmovdqu	ymmword ptr [rdi - 256], ymm5
	vpsrlw	ymm5, ymm6, 4
	vpand	ymm5, ymm5, ymm1
	vpshufb	ymm5, ymm0, ymm5
	vmovdqu	ymmword ptr [rdi - 192], ymm5
	vpsrlw	ymm5, ymm6, 7
	vpand	ymm5, ymm5, ymm3
	vpaddb	ymm6, ymm4, ymm4
	vpor	ymm5, ymm6, ymm5
	vpand	ymm5, ymm5, ymm1
	vpshufb	ymm5, ymm0, ymm5
	vmovdqu	ymmword ptr [rdi - 128], ymm5
	vpsrlw	ymm5, ymm4, 2
	vpand	ymm5, ymm5, ymm1
	vpshufb	ymm5, ymm0, ymm5
	vmovdqu	ymmword ptr [rdi - 64], ymm5
	vpsrlw	ymm4, ymm4, 5
	vpand	ymm4, ymm4, ymm1
	vpshufb	ymm4, ymm0, ymm4
	vmovdqu	ymmword ptr [rdi], ymm4
	add	rsi, 192
	add	rdi, 512
	dec	rdx
	jne	2362b
	jmp	2412f
2372:
	test	rdx, rdx
	je	2412f
	vmovdqu	ymm1, ymmword ptr [rcx]
	vmovdqu	ymm3, ymmword ptr [rcx + 32]
	vpermq	ymm0, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpermq	ymm2, ymm3, 68
	vpermq	ymm3, ymm3, 238
	add	rsi, 80
	add	rdi, 112
	vpbroadcastb	ymm4, byte ptr [rip + 3202f]
	vpbroadcastb	ymm5, byte ptr [rip + 3142f]
	vpbroadcastb	ymm6, byte ptr [rip + 3162f]
	.p2align	4
2382:
	vmovdqu	xmm7, xmmword ptr [rsi - 80]
	vpand	xmm8, xmm7, xmm4
	vpshufb	xmm9, xmm0, xmm8
	vpshufb	xmm10, xmm1, xmm8
	vpsllw	xmm11, xmm7, 3
	vpblendvb	xmm9, xmm9, xmm10, xmm11
	vpshufb	xmm10, xmm2, xmm8
	vpshufb	xmm8, xmm3, xmm8
	vpblendvb	xmm8, xmm10, xmm8, xmm11
	vpsllw	xmm7, xmm7, 2
	vpblendvb	xmm7, xmm9, xmm8, xmm7
	vmovdqu	xmmword ptr [rdi - 112], xmm7
	vmovdqu	xmm7, xmmword ptr [rsi - 80]
	vmovdqu	xmm8, xmmword ptr [rsi - 64]
	vmovdqa	xmm8, xmm8
	vpsrlw	xmm7, xmm7, 6
	vpand	ymm7, ymm7, ymm5
	vpaddb	ymm8, ymm8, ymm8
	vpaddb	ymm8, ymm8, ymm8
	vpor	ymm7, ymm8, ymm7
	vpand	xmm9, xmm7, xmm4
	vpshufb	xmm10, xmm0, xmm9
	vpshufb	xmm11, xmm1, xmm9
	vpsllw	xmm8, xmm8, 3
	vpblendvb	xmm10, xmm10, xmm11, xmm8
	vpshufb	xmm11, xmm2, xmm9
	vpshufb	xmm9, xmm3, xmm9
	vpblendvb	xmm8, xmm11, xmm9, xmm8
	vpsllw	xmm7, xmm7, 2
	vpblendvb	xmm7, xmm10, xmm8, xmm7
	vmovdqu	xmmword ptr [rdi - 96], xmm7
	vmovdqu	xmm7, xmmword ptr [rsi - 64]
	vmovdqu	xmm8, xmmword ptr [rsi - 48]
	vpsrlw	xmm7, xmm7, 4
	vpandn	ymm7, ymm6, ymm7
	vpsllw	ymm8, ymm8, 4
	vpand	ymm9, ymm8, ymm6
	vpor	ymm7, ymm9, ymm7
	vpand	xmm9, xmm7, xmm4
	vpshufb	xmm10, xmm0, xmm9
	vpshufb	xmm11, xmm1, xmm9
	vpsllw	xmm8, xmm8, 3
	vpblendvb	xmm10, xmm10, xmm11, xmm8
	vpshufb	xmm11, xmm2, xmm9
	vpshufb	xmm9, xmm3, xmm9
	vpblendvb	xmm8, xmm11, xmm9, xmm8
	vpsllw	xmm7, xmm7, 2
	vpblendvb	xmm7, xmm10, xmm8, xmm7
	vmovdqu	xmmword ptr [rdi - 80], xmm7
	vmovdqu	xmm7, xmmword ptr [rsi - 48]
	vpsrlw	xmm8, xmm7, 2
	vpand	xmm9, xmm8, xmm4
	vpshufb	xmm10, xmm0, xmm9
	vpshufb	xmm11, xmm1, xmm9
	vpaddw	xmm7, xmm7, xmm7
	vpblendvb	xmm10, xmm10, xmm11, xmm7
	vpshufb	xmm11, xmm2, xmm9
	vpshufb	xmm9, xmm3, xmm9
	vpblendvb	xmm7, xmm11, xmm9, xmm7
	vpsllw	xmm8, xmm8, 2
	vpblendvb	xmm7, xmm10, xmm7, xmm8
	vmovdqu	xmmword ptr [rdi - 64], xmm7
	vmovdqu	xmm7, xmmword ptr [rsi - 32]
	vpand	xmm8, xmm7, xmm4
	vpshufb	xmm9, xmm0, xmm8
	vpshufb	xmm10, xmm1, xmm8
	vpsllw	xmm11, xmm7, 3
	vpblendvb	xmm9, xmm9, xmm10, xmm11
	vpshufb	xmm10, xmm2, xmm8
	vpshufb	xmm8, xmm3, xmm8
	vpblendvb	xmm8, xmm10, xmm8, xmm11
	vpsllw	xmm7, xmm7, 2
	vpblendvb	xmm7, xmm9, xmm8, xmm7
	vmovdqu	xmmword ptr [rdi - 48], xmm7
	vmovdqu	xmm7, xmmword ptr [rsi - 32]
	vmovdqu	xmm8, xmmword ptr [rsi - 16]
	vmovdqa	xmm8, xmm8
	vpsrlw	xmm7, xmm7, 6
	vpand	ymm7, ymm7, ymm5
	vpaddb	ymm8, ymm8, ymm8
	vpaddb	ymm8, ymm8, ymm8
	vpor	ymm7, ymm8, ymm7
	vpand	xmm9, xmm7, xmm4
	vpshufb	xmm10, xmm0, xmm9
	vpshufb	xmm11, xmm1, xmm9
	vpsllw	xmm8, xmm8, 3
	vpblendvb	xmm10, xmm10, xmm11, xmm8
	vpshufb	xmm11, xmm2, xmm9
	vpshufb	xmm9, xmm3, xmm9
	vpblendvb	xmm8, xmm11, xmm9, xmm8
	vpsllw	xmm7, xmm7, 2
	vpblendvb	xmm7, xmm10, xmm8, xmm7
	vmovdqu	xmmword ptr [rdi - 32], xmm7
	vmovdqu	xmm7, xmmword ptr [rsi - 16]
	vmovdqu	xmm8, xmmword ptr [rsi]
	vpsrlw	xmm7, xmm7, 4
	vpandn	ymm7, ymm6, ymm7
	vpsllw	ymm8, ymm8, 4
	vpand	ymm9, ymm8, ymm6
	vpor	ymm7, ymm9, ymm7
	vpand	xmm9, xmm7, xmm4
	vpshufb	xmm10, xmm0, xmm9
	vpshufb	xmm11, xmm1, xmm9
	vpsllw	xmm8, xmm8, 3
	vpblendvb	xmm10, xmm10, xmm11, xmm8
	vpshufb	xmm11, xmm2, xmm9
	vpshufb	xmm9, xmm3, xmm9
	vpblendvb	xmm8, xmm11, xmm9, xmm8
	vpsllw	xmm7, xmm7, 2
	vpblendvb	xmm7, xmm10, xmm8, xmm7
	vmovdqu	xmmword ptr [rdi - 16], xmm7
	vmovdqu	xmm7, xmmword ptr [rsi]
	vpsrlw	xmm8, xmm7, 2
	vpand	xmm9, xmm8, xmm4
	vpshufb	xmm10, xmm0, xmm9
	vpshufb	xmm11, xmm1, xmm9
	vpaddw	xmm7, xmm7, xmm7
	vpblendvb	xmm10, xmm10, xmm11, xmm7
	vpshufb	xmm11, xmm2, xmm9
	vpshufb	xmm9, xmm3, xmm9
	vpblendvb	xmm7, xmm11, xmm9, xmm7
	vpsllw	xmm8, xmm8, 2
	vpblendvb	xmm7, xmm10, xmm7, xmm8
	vmovdqu	xmmword ptr [rdi], xmm7
	add	rsi, 96
	sub	rdi, -128
	dec	rdx
	jne	2382b
	jmp	2412f
2392:
	test	rdx, rdx
	je	2412f
	vmovdqu	ymm1, ymmword ptr [rcx]
	vmovdqu	ymm3, ymmword ptr [rcx + 32]
	vpermq	ymm0, ymm1, 68
	vpermq	ymm1, ymm1, 238
	vpermq	ymm2, ymm3, 68
	vpermq	ymm3, ymm3, 238
	add	rsi, 352
	add	rdi, 480
	vpbroadcastb	ymm4, byte ptr [rip + 3202f]
	vpbroadcastb	ymm5, byte ptr [rip + 3142f]
	vpbroadcastb	ymm6, byte ptr [rip + 3162f]
	.p2align	4
2402:
	vmovdqu	ymm7, ymmword ptr [rsi - 352]
	vpand	ymm8, ymm7, ymm4
	vpshufb	ymm9, ymm0, ymm8
	vpshufb	ymm10, ymm1, ymm8
	vpsllw	ymm11, ymm7, 3
	vpblendvb	ymm9, ymm9, ymm10, ymm11
	vpshufb	ymm10, ymm2, ymm8
	vpshufb	ymm8, ymm3, ymm8
	vpblendvb	ymm8, ymm10, ymm8, ymm11
	vpsllw	ymm7, ymm7, 2
	vpblendvb	ymm7, ymm9, ymm8, ymm7
	vmovdqu	ymmword ptr [rdi - 480], ymm7
	vmovdqu	ymm7, ymmword ptr [rsi - 352]
	vmovdqu	ymm8, ymmword ptr [rsi - 288]
	vpsrlw	ymm7, ymm7, 6
	vpand	ymm7, ymm7, ymm5
	vpaddb	ymm8, ymm8, ymm8
	vpaddb	ymm8, ymm8, ymm8
	vpor	ymm7, ymm8, ymm7
	vpand	ymm9, ymm7, ymm4
	vpshufb	ymm10, ymm0, ymm9
	vpshufb	ymm11, ymm1, ymm9
	vpsllw	ymm8, ymm8, 3
	vpblendvb	ymm10, ymm10, ymm11, ymm8
	vpshufb	ymm11, ymm2, ymm9
	vpshufb	ymm9, ymm3, ymm9
	vpblendvb	ymm8, ymm11, ymm9, ymm8
	vpsllw	ymm7, ymm7, 2
	vpblendvb	ymm7, ymm10, ymm8, ymm7
	vmovdqu	ymmword ptr [rdi - 416], ymm7
	vmovdqu	ymm7, ymmword ptr [rsi - 288]
	vmovdqu	ymm8, ymmword ptr [rsi - 224]
	vpsrlw	ymm7, ymm7, 4
	vpandn	ymm7, ymm6, ymm7
	vpsllw	ymm8, ymm8, 4
	vpand	ymm8, ymm8, ymm6
	vpor	ymm7, ymm8, ymm7
	vpand	ymm9, ymm7, ymm4
	vpshufb	ymm10, ymm0, ymm9
	vpshufb	ymm11, ymm1, ymm9
	vpsllw	ymm8, ymm8, 3
	vpblendvb	ymm10, ymm10, ymm11, ymm8
	vpshufb	ymm11, ymm2, ymm9
	vpshufb	ymm9, ymm3, ymm9
	vpblendvb	ymm8, ymm11, ymm9, ymm8
	vpsllw	ymm7, ymm7, 2
	vpblendvb	ymm7, ymm10, ymm8, ymm7
	vmovdqu	ymmword ptr [rdi - 352], ymm7
	vmovdqu	ymm7, ymmword ptr [rsi - 224]
	vpsrlw	ymm8, ymm7, 2
	vpand	ymm9, ymm8, ymm4
	vpshufb	ymm10, ymm0, ymm9
	vpshufb	ymm11, ymm1, ymm9
	vpaddw	ymm7, ymm7, ymm7
	vpblendvb	ymm10, ymm10, ymm11, ymm7
	vpshufb	ymm11, ymm2, ymm9
	vpshufb	ymm9, ymm3, ymm9
	vpblendvb	ymm7, ymm11, ymm9, ymm7
	vpsllw	ymm8, ymm8, 2
	vpblendvb	ymm7, ymm10, ymm7, ymm8
	vmovdqu	ymmword ptr [rdi - 288], ymm7
	vmovdqu	ymm7, ymmword ptr [rsi - 160]
	vpand	ymm8, ymm7, ymm4
	vpshufb	ymm9, ymm0, ymm8
	vpshufb	ymm10, ymm1, ymm8
	vpsllw	ymm11, ymm7, 3
	vpblendvb	ymm9, ymm9, ymm10, ymm11
	vpshufb	ymm10, ymm2, ymm8
	vpshufb	ymm8, ymm3, ymm8
	vpblendvb	ymm8, ymm10, ymm8, ymm11
	vpsllw	ymm7, ymm7, 2
	vpblendvb	ymm7, ymm9, ymm8, ymm7
	vmovdqu	ymmword ptr [rdi - 224], ymm7
	vmovdqu	ymm7, ymmword ptr [rsi - 160]
	vmovdqu	ymm8, ymmword ptr [rsi - 96]
	vpsrlw	ymm7, ymm7, 6
	vpand	ymm7, ymm7, ymm5
	vpaddb	ymm8, ymm8, ymm8
	vpaddb	ymm8, ymm8, ymm8
	vpor	ymm7, ymm8, ymm7
	vpand	ymm9, ymm7, ymm4
	vpshufb	ymm10, ymm0, ymm9
	vpshufb	ymm11, ymm1, ymm9
	vpsllw	ymm8, ymm8, 3
	vpblendvb	ymm10, ymm10, ymm11, ymm8
	vpshufb	ymm11, ymm2, ymm9
	vpshufb	ymm9, ymm3, ymm9
	vpblendvb	ymm8, ymm11, ymm9, ymm8
	vpsllw	ymm7, ymm7, 2
	vpblendvb	ymm7, ymm10, ymm8, ymm7
	vmovdqu	ymmword ptr [rdi - 160], ymm7
	vmovdqu	ymm7, ymmword ptr [rsi - 96]
	vmovdqu	ymm8, ymmword ptr [rsi - 32]
	vpsrlw	ymm7, ymm7, 4
	vpandn	ymm7, ymm6, ymm7
	vpsllw	ymm8, ymm8, 4
	vpand	ymm8, ymm8, ymm6
	vpor	ymm7, ymm8, ymm7
	vpand	ymm9, ymm7, ymm4
	vpshufb	ymm10, ymm0, ymm9
	vpshufb	ymm11, ymm1, ymm9
	vpsllw	ymm8, ymm8, 3
	vpblendvb	ymm10, ymm10, ymm11, ymm8
	vpshufb	ymm11, ymm2, ymm9
	vpshufb	ymm9, ymm3, ymm9
	vpblendvb	ymm8, ymm11, ymm9, ymm8
	vpsllw	ymm7, ymm7, 2
	vpblendvb	ymm7, ymm10, ymm8, ymm7
	vmovdqu	ymmword ptr [rdi - 96], ymm7
	vmovdqu	ymm7, ymmword ptr [rsi - 32]
	vpsrlw	ymm8, ymm7, 2
	vpand	ymm9, ymm8, ymm4
	vpshufb	ymm10, ymm0, ymm9
	vpshufb	ymm11, ymm1, ymm9
	vpaddw	ymm7, ymm7, ymm7
	vpblendvb	ymm10, ymm10, ymm11, ymm7
	vpshufb	ymm11, ymm2, ymm9
	vpshufb	ymm9, ymm3, ymm9
	vpblendvb	ymm7, ymm11, ymm9, ymm7
	vpsllw	ymm8, ymm8, 2
	vpblendvb	ymm7, ymm10, ymm7, ymm8
	vmovdqu	ymmword ptr [rdi - 32], ymm7
	vmovdqu	ymm7, ymmword ptr [rsi - 320]
	vpand	ymm8, ymm7, ymm4
	vpshufb	ymm9, ymm0, ymm8
	vpshufb	ymm10, ymm1, ymm8
	vpsllw	ymm11, ymm7, 3
	vpblendvb	ymm9, ymm9, ymm10, ymm11
	vpshufb	ymm10, ymm2, ymm8
	vpshufb	ymm8, ymm3, ymm8
	vpblendvb	ymm8, ymm10, ymm8, ymm11
	vpsllw	ymm7, ymm7, 2
	vpblendvb	ymm7, ymm9, ymm8, ymm7
	vmovdqu	ymmword ptr [rdi - 448], ymm7
	vmovdqu	ymm7, ymmword ptr [rsi - 320]
	vmovdqu	ymm8, ymmword ptr [rsi - 256]
	vpsrlw	ymm7, ymm7, 6
	vpand	ymm7, ymm7, ymm5
	vpaddb	ymm8, ymm8, ymm8
	vpaddb	ymm8, ymm8, ymm8
	vpor	ymm7, ymm8, ymm7
	vpand	ymm9, ymm7, ymm4
	vpshufb	ymm10, ymm0, ymm9
	vpshufb	ymm11, ymm1, ymm9
	vpsllw	ymm8, ymm8, 3
	vpblendvb	ymm10, ymm10, ymm11, ymm8
	vpshufb	ymm11, ymm2, ymm9
	vpshufb	ymm9, ymm3, ymm9
	vpblendvb	ymm8, ymm11, ymm9, ymm8
	vpsllw	ymm7, ymm7, 2
	vpblendvb	ymm7, ymm10, ymm8, ymm7
	vmovdqu	ymmword ptr [rdi - 384], ymm7
	vmovdqu	ymm7, ymmword ptr [rsi - 256]
	vmovdqu	ymm8, ymmword ptr [rsi - 192]
	vpsrlw	ymm7, ymm7, 4
	vpandn	ymm7, ymm6, ymm7
	vpsllw	ymm8, ymm8, 4
	vpand	ymm8, ymm8, ymm6
	vpor	ymm7, ymm8, ymm7
	vpand	ymm9, ymm7, ymm4
	vpshufb	ymm10, ymm0, ymm9
	vpshufb	ymm11, ymm1, ymm9
	vpsllw	ymm8, ymm8, 3
	vpblendvb	ymm10, ymm10, ymm11, ymm8
	vpshufb	ymm11, ymm2, ymm9
	vpshufb	ymm9, ymm3, ymm9
	vpblendvb	ymm8, ymm11, ymm9, ymm8
	vpsllw	ymm7, ymm7, 2
	vpblendvb	ymm7, ymm10, ymm8, ymm7
	vmovdqu	ymmword ptr [rdi - 320], ymm7
	vmovdqu	ymm7, ymmword ptr [rsi - 192]
	vpsrlw	ymm8, ymm7, 2
	vpand	ymm9, ymm8, ymm4
	vpshufb	ymm10, ymm0, ymm9
	vpshufb	ymm11, ymm1, ymm9
	vpaddw	ymm7, ymm7, ymm7
	vpblendvb	ymm10, ymm10, ymm11, ymm7
	vpshufb	ymm11, ymm2, ymm9
	vpshufb	ymm9, ymm3, ymm9
	vpblendvb	ymm7, ymm11, ymm9, ymm7
	vpsllw	ymm8, ymm8, 2
	vpblendvb	ymm7, ymm10, ymm7, ymm8
	vmovdqu	ymmword ptr [rdi - 256], ymm7
	vmovdqu	ymm7, ymmword ptr [rsi - 128]
	vpand	ymm8, ymm7, ymm4
	vpshufb	ymm9, ymm0, ymm8
	vpshufb	ymm10, ymm1, ymm8
	vpsllw	ymm11, ymm7, 3
	vpblendvb	ymm9, ymm9, ymm10, ymm11
	vpshufb	ymm10, ymm2, ymm8
	vpshufb	ymm8, ymm3, ymm8
	vpblendvb	ymm8, ymm10, ymm8, ymm11
	vpsllw	ymm7, ymm7, 2
	vpblendvb	ymm7, ymm9, ymm8, ymm7
	vmovdqu	ymmword ptr [rdi - 192], ymm7
	vmovdqu	ymm7, ymmword ptr [rsi - 128]
	vmovdqu	ymm8, ymmword ptr [rsi - 64]
	vpsrlw	ymm7, ymm7, 6
	vpand	ymm7, ymm7, ymm5
	vpaddb	ymm8, ymm8, ymm8
	vpaddb	ymm8, ymm8, ymm8
	vpor	ymm7, ymm8, ymm7
	vpand	ymm9, ymm7, ymm4
	vpshufb	ymm10, ymm0, ymm9
	vpshufb	ymm11, ymm1, ymm9
	vpsllw	ymm8, ymm8, 3
	vpblendvb	ymm10, ymm10, ymm11, ymm8
	vpshufb	ymm11, ymm2, ymm9
	vpshufb	ymm9, ymm3, ymm9
	vpblendvb	ymm8, ymm11, ymm9, ymm8
	vpsllw	ymm7, ymm7, 2
	vpblendvb	ymm7, ymm10, ymm8, ymm7
	vmovdqu	ymmword ptr [rdi - 128], ymm7
	vmovdqu	ymm7, ymmword ptr [rsi - 64]
	vmovdqu	ymm8, ymmword ptr [rsi]
	vpsrlw	ymm7, ymm7, 4
	vpandn	ymm7, ymm6, ymm7
	vpsllw	ymm8, ymm8, 4
	vpand	ymm8, ymm8, ymm6
	vpor	ymm7, ymm8, ymm7
	vpand	ymm9, ymm7, ymm4
	vpshufb	ymm10, ymm0, ymm9
	vpshufb	ymm11, ymm1, ymm9
	vpsllw	ymm8, ymm8, 3
	vpblendvb	ymm10, ymm10, ymm11, ymm8
	vpshufb	ymm11, ymm2, ymm9
	vpshufb	ymm9, ymm3, ymm9
	vpblendvb	ymm8, ymm11, ymm9, ymm8
	vpsllw	ymm7, ymm7, 2
	vpblendvb	ymm7, ymm10, ymm8, ymm7
	vmovdqu	ymmword ptr [rdi - 64], ymm7
	vmovdqu	ymm7, ymmword ptr [rsi]
	vpsrlw	ymm8, ymm7, 2
	vpand	ymm9, ymm8, ymm4
	vpshufb	ymm10, ymm0, ymm9
	vpshufb	ymm11, ymm1, ymm9
	vpaddw	ymm7, ymm7, ymm7
	vpblendvb	ymm10, ymm10, ymm11, ymm7
	vpshufb	ymm11, ymm2, ymm9
	vpshufb	ymm9, ymm3, ymm9
	vpblendvb	ymm7, ymm11, ymm9, ymm7
	vpsllw	ymm8, ymm8, 2
	vpblendvb	ymm7, ymm10, ymm7, ymm8
	vmovdqu	ymmword ptr [rdi], ymm7
	add	rsi, 384
	add	rdi, 512
	dec	rdx
	jne	2402b
2412:
	add	rsp, 40
	vzeroupper
	ret
	.p2align	4
2422:
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 16
	mov	qword ptr [rsp + 8], rsi
	shr	rsi, 6
	mov	qword ptr [rsp], r8
	je	2442f
	vmovd	xmm0, r8d
	vpbroadcastb	ymm0, xmm0
	shl	rsi, 3
	xor	eax, eax
	xor	r11d, r11d
	.p2align	4
2432:
	mov	rbx, rax
	mov	r13, qword ptr [rdx + r11]
	movzx	r14d, r13b
	mov	r10d, r13d
	mov	ebp, r13d
	movzx	r8d, r13w
	popcnt	r15d, r13d
	mov	r12, r13
	popcnt	rax, r13
	shr	r13d, 4
	and	r13d, 4080
	vmovdqu	xmm1, xmmword ptr [r9 + r13 + 4096]
	lea	r13, [rcx + rbx]
	shl	r14d, 4
	vpaddb	xmm1, xmm1, xmmword ptr [r9 + r14]
	shr	r10d, 12
	and	r10d, 4080
	shr	ebp, 20
	and	ebp, -16
	vmovdqu	xmm2, xmmword ptr [r9 + rbp + 4096]
	vpaddb	xmm2, xmm2, xmmword ptr [r9 + r10]
	vinserti128	ymm1, ymm1, xmm2, 1
	popcnt	r8d, r8d
	vmovdqu	xmm2, xmmword ptr [rcx + rbx]
	vinserti128	ymm2, ymm2, xmmword ptr [r8 + r13], 1
	vpshufb	ymm2, ymm2, ymm1
	vpblendvb	ymm1, ymm2, ymm0, ymm1
	shr	r12, 32
	#APP
	#NO_APP
	movzx	r8d, r12b
	mov	r10d, r12d
	mov	r14d, r12d
	movzx	ebp, r12w
	shr	r12d, 4
	and	r12d, 4080
	vmovdqu	xmm2, xmmword ptr [r9 + r12 + 4096]
	shl	r8d, 4
	vpaddb	xmm2, xmm2, xmmword ptr [r9 + r8]
	lea	r8, [r13 + r15]
	shr	r10d, 12
	and	r10d, 4080
	shr	r14d, 20
	and	r14d, -16
	vmovdqu	xmm3, xmmword ptr [r9 + r14 + 4096]
	vpaddb	xmm3, xmm3, xmmword ptr [r9 + r10]
	vinserti128	ymm2, ymm2, xmm3, 1
	popcnt	r10d, ebp
	vmovdqu	xmm3, xmmword ptr [r15 + r13]
	vinserti128	ymm3, ymm3, xmmword ptr [r10 + r8], 1
	vpshufb	ymm3, ymm3, ymm2
	vpblendvb	ymm2, ymm3, ymm0, ymm2
	vmovdqu	ymmword ptr [rdi + 8*r11], ymm1
	vmovdqu	ymmword ptr [rdi + 8*r11 + 32], ymm2
	add	rax, rbx
	add	r11, 8
	cmp	rsi, r11
	jne	2432b
	mov	r15, qword ptr [rsp + 8]
	mov	rsi, r15
	and	rsi, 63
	jne	2452f
	jmp	2562f
2442:
	xor	eax, eax
	mov	r15, qword ptr [rsp + 8]
	mov	rsi, r15
	and	rsi, 63
	je	2562f
2452:
	mov	r10d, r15d
	and	r10d, -64
	mov	r8d, r10d
	shr	r8d, 3
	add	rdx, r8
	lea	r8d, [rsi + 7]
	shr	r8d, 3
	cmp	rsi, 25
	jb	2462f
	mov	r11d, dword ptr [rdx]
	mov	edx, dword ptr [rdx + r8 - 4]
	add	r8, -4
	jmp	2472f
2462:
	cmp	esi, 9
	jb	2482f
	movzx	r11d, word ptr [rdx]
	movzx	edx, word ptr [rdx + r8 - 2]
	add	r8, -2
2472:
	shl	r8d, 3
	shlx	rdx, rdx, r8
	or	rdx, r11
	jmp	2492f
2482:
	movzx	edx, byte ptr [rdx]
2492:
	bzhi	rdx, rdx, rsi
	lea	r11, [rcx + rax]
	vmovd	xmm0, dword ptr [rsp]
	vpbroadcastb	ymm1, xmm0
	movzx	esi, dl
	shl	esi, 4
	mov	r8d, edx
	shr	r8d, 4
	and	r8d, 4080
	vmovdqu	xmm0, xmmword ptr [r9 + r8 + 4096]
	vpaddb	xmm0, xmm0, xmmword ptr [r9 + rsi]
	mov	esi, edx
	shr	esi, 12
	and	esi, 4080
	mov	r8d, edx
	shr	r8d, 20
	and	r8d, -16
	vmovdqu	xmm2, xmmword ptr [r9 + r8 + 4096]
	vpaddb	xmm2, xmm2, xmmword ptr [r9 + rsi]
	vinserti128	ymm0, ymm0, xmm2, 1
	movzx	esi, dx
	popcnt	esi, esi
	vmovdqu	xmm2, xmmword ptr [rcx + rax]
	vinserti128	ymm2, ymm2, xmmword ptr [rsi + r11], 1
	vpshufb	ymm2, ymm2, ymm0
	vpblendvb	ymm0, ymm2, ymm1, ymm0
	popcnt	ecx, edx
	mov	rbx, rdx
	shr	rbx, 32
	#APP
	#NO_APP
	movzx	esi, bl
	mov	r8d, ebx
	mov	r14d, ebx
	movzx	ebp, bx
	shr	ebx, 4
	and	ebx, 4080
	vmovdqu	xmm2, xmmword ptr [r9 + rbx + 4096]
	lea	rbx, [r11 + rcx]
	shl	esi, 4
	shr	r8d, 12
	and	r8d, 4080
	shr	r14d, 20
	and	r14d, -16
	vmovdqu	xmm3, xmmword ptr [r9 + r14 + 4096]
	popcnt	r14d, ebp
	vmovdqu	xmm4, xmmword ptr [rcx + r11]
	add	rdi, r10
	vinserti128	ymm4, ymm4, xmmword ptr [r14 + rbx], 1
	vpaddb	xmm2, xmm2, xmmword ptr [r9 + rsi]
	vpaddb	xmm3, xmm3, xmmword ptr [r9 + r8]
	vinserti128	ymm2, ymm2, xmm3, 1
	vpshufb	ymm3, ymm4, ymm2
	vpblendvb	ymm1, ymm3, ymm1, ymm2
	test	r15b, 32
	je	2502f
	vmovdqu	ymmword ptr [rdi], ymm0
	add	rdi, 32
	vmovdqa	ymm0, ymm1
	vpxor	xmm1, xmm1, xmm1
2502:
	test	r15b, 16
	je	2512f
	vmovdqu	xmmword ptr [rdi], xmm0
	vperm2i128	ymm0, ymm0, ymm1, 33
	add	rdi, 16
2512:
	vmovq	rsi, xmm0
	vpextrq	rcx, xmm0, 1
	test	r15b, 8
	cmove	rcx, rsi
	jne	2572f
	test	r15b, 4
	jne	2582f
2522:
	test	r15b, 2
	jne	2592f
2532:
	test	r15b, 1
	je	2552f
2542:
	mov	byte ptr [rdi], cl
2552:
	popcnt	rcx, rdx
	add	rax, rcx
2562:
	add	rsp, 16
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	vzeroupper
	ret
2572:
	mov	qword ptr [rdi], rsi
	add	rdi, 8
	test	r15b, 4
	je	2522b
2582:
	mov	dword ptr [rdi], ecx
	add	rdi, 4
	shr	rcx, 32
	test	r15b, 2
	je	2532b
2592:
	mov	word ptr [rdi], cx
	add	rdi, 2
	shr	rcx, 16
	test	r15b, 1
	jne	2542b
	jmp	2552b
	.p2align	4
2602:
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	push	rax
	mov	qword ptr [rsp], rsi
	shr	rsi, 6
	je	2622f
	shl	rsi, 3
	xor	eax, eax
	vpcmpeqd	ymm0, ymm0, ymm0
	xor	ebx, ebx
	xor	r10d, r10d
	.p2align	4
2612:
	mov	r14, qword ptr [rdx + rbx]
	movzx	r15d, r14b
	mov	r13d, r14d
	mov	r12d, r14d
	mov	ebp, r14d
	shr	ebp, 4
	and	ebp, 4080
	vmovdqu	xmm1, xmmword ptr [r9 + rbp + 4096]
	movzx	ebp, r14w
	shl	r15d, 4
	vpaddb	xmm1, xmm1, xmmword ptr [r9 + r15]
	lea	r11, [rcx + r10]
	shr	r12d, 20
	and	r12d, -16
	vmovdqu	xmm2, xmmword ptr [r9 + r12 + 4096]
	lea	r12, [r8 + rax]
	shr	r13d, 12
	and	r13d, 4080
	vpaddb	xmm2, xmm2, xmmword ptr [r9 + r13]
	popcnt	r13d, ebp
	vmovdqu	xmm3, xmmword ptr [r8 + rax]
	vinserti128	ymm3, ymm3, xmmword ptr [r13 + r12], 1
	mov	r15, r11
	sub	r15, r13
	popcnt	ebp, r14d
	vmovdqu	xmm4, xmmword ptr [rcx + r10]
	vinserti128	ymm4, ymm4, xmmword ptr [r15 + 16], 1
	mov	r13, r14
	vinserti128	ymm1, ymm1, xmm2, 1
	vpshufb	ymm2, ymm3, ymm1
	vpxor	ymm1, ymm1, ymm0
	vpshufb	ymm1, ymm4, ymm1
	vpor	ymm1, ymm1, ymm2
	sub	r11, rbp
	vmovdqu	xmm2, xmmword ptr [rbp + r12]
	lea	r15, [r12 + rbp]
	shr	r13, 32
	#APP
	#NO_APP
	mov	r12d, r13d
	shr	r12d, 4
	and	r12d, 4080
	vmovdqu	xmm3, xmmword ptr [r9 + r12 + 4096]
	movzx	r12d, r13b
	shl	r12d, 4
	vpaddb	xmm3, xmm3, xmmword ptr [r9 + r12]
	mov	r12d, r13d
	shr	r12d, 20
	and	r12d, -16
	vmovdqu	xmm4, xmmword ptr [r9 + r12 + 4096]
	mov	r12d, r13d
	shr	r12d, 12
	and	r12d, 4080
	vpaddb	xmm4, xmm4, xmmword ptr [r9 + r12]
	movzx	ebp, r13w
	popcnt	r12d, ebp
	vinserti128	ymm2, ymm2, xmmword ptr [r12 + r15], 1
	lea	r15, [r11 + 32]
	sub	r15, r12
	vmovdqu	xmm5, xmmword ptr [r11 + 32]
	vinserti128	ymm5, ymm5, xmmword ptr [r15 + 16], 1
	popcnt	r11, r14
	add	rax, r11
	sub	r10, r11
	vinserti128	ymm3, ymm3, xmm4, 1
	vpshufb	ymm2, ymm2, ymm3
	vpxor	ymm3, ymm3, ymm0
	vpshufb	ymm3, ymm5, ymm3
	vpor	ymm2, ymm3, ymm2
	vmovdqu	ymmword ptr [rdi + 8*rbx], ymm1
	vmovdqu	ymmword ptr [rdi + 8*rbx + 32], ymm2
	add	r10, 64
	add	rbx, 8
	cmp	rsi, rbx
	jne	2612b
	mov	r13, qword ptr [rsp]
	mov	rbx, r13
	and	rbx, 63
	jne	2632f
	jmp	2742f
2622:
	xor	r10d, r10d
	xor	eax, eax
	mov	r13, qword ptr [rsp]
	mov	rbx, r13
	and	rbx, 63
	je	2742f
2632:
	mov	r11d, r13d
	and	r11d, -64
	mov	esi, r11d
	shr	esi, 3
	add	rdx, rsi
	lea	r14d, [rbx + 7]
	shr	r14d, 3
	cmp	rbx, 25
	jb	2642f
	mov	esi, dword ptr [rdx]
	mov	edx, dword ptr [rdx + r14 - 4]
	add	r14, -4
	jmp	2652f
2642:
	cmp	ebx, 9
	jb	2662f
	movzx	esi, word ptr [rdx]
	movzx	edx, word ptr [rdx + r14 - 2]
	add	r14, -2
2652:
	shl	r14d, 3
	shlx	rdx, rdx, r14
	or	rdx, rsi
	jmp	2672f
2662:
	movzx	edx, byte ptr [rdx]
2672:
	bzhi	rdx, rdx, rbx
	lea	rbx, [rcx + r10]
	lea	r14, [r8 + rax]
	movzx	esi, dl
	shl	esi, 4
	mov	r15d, edx
	shr	r15d, 4
	and	r15d, 4080
	vmovdqu	xmm0, xmmword ptr [r9 + r15 + 4096]
	vpaddb	xmm0, xmm0, xmmword ptr [r9 + rsi]
	mov	esi, edx
	shr	esi, 12
	and	esi, 4080
	mov	r15d, edx
	shr	r15d, 20
	and	r15d, -16
	vmovdqu	xmm1, xmmword ptr [r9 + r15 + 4096]
	vpaddb	xmm1, xmm1, xmmword ptr [r9 + rsi]
	vinserti128	ymm0, ymm0, xmm1, 1
	movzx	esi, dx
	popcnt	esi, esi
	vmovdqu	xmm1, xmmword ptr [r8 + rax]
	vinserti128	ymm1, ymm1, xmmword ptr [rsi + r14], 1
	vpshufb	ymm2, ymm1, ymm0
	mov	r8, rbx
	sub	r8, rsi
	vmovdqu	xmm1, xmmword ptr [rcx + r10]
	vinserti128	ymm3, ymm1, xmmword ptr [r8 + 16], 1
	vpcmpeqd	ymm1, ymm1, ymm1
	vpxor	ymm0, ymm0, ymm1
	vpshufb	ymm0, ymm3, ymm0
	vpor	ymm0, ymm0, ymm2
	popcnt	r8d, edx
	sub	rbx, r8
	lea	rcx, [rbx + 32]
	mov	rsi, rdx
	shr	rsi, 32
	#APP
	#NO_APP
	movzx	r10d, sil
	mov	r15d, esi
	mov	r12d, esi
	movzx	ebp, si
	shr	esi, 4
	and	esi, 4080
	vmovdqu	xmm2, xmmword ptr [r9 + rsi + 4096]
	lea	rsi, [r14 + r8]
	shl	r10d, 4
	shr	r15d, 12
	and	r15d, 4080
	shr	r12d, 20
	and	r12d, -16
	vmovdqu	xmm3, xmmword ptr [r9 + r12 + 4096]
	popcnt	r12d, ebp
	vmovdqu	xmm4, xmmword ptr [r8 + r14]
	sub	rcx, r12
	vmovdqu	xmm5, xmmword ptr [rbx + 32]
	add	rdi, r11
	vinserti128	ymm4, ymm4, xmmword ptr [r12 + rsi], 1
	vpaddb	xmm2, xmm2, xmmword ptr [r9 + r10]
	vpaddb	xmm3, xmm3, xmmword ptr [r9 + r15]
	vinserti128	ymm2, ymm2, xmm3, 1
	vpshufb	ymm3, ymm4, ymm2
	vinserti128	ymm4, ymm5, xmmword ptr [rcx + 16], 1
	vpxor	ymm1, ymm2, ymm1
	vpshufb	ymm1, ymm4, ymm1
	vpor	ymm1, ymm1, ymm3
	test	r13b, 32
	je	2682f
	vmovdqu	ymmword ptr [rdi], ymm0
	add	rdi, 32
	vmovdqa	ymm0, ymm1
	vpxor	xmm1, xmm1, xmm1
2682:
	test	r13b, 16
	je	2692f
	vmovdqu	xmmword ptr [rdi], xmm0
	vperm2i128	ymm0, ymm0, ymm1, 33
	add	rdi, 16
2692:
	vmovq	r8, xmm0
	vpextrq	rcx, xmm0, 1
	test	r13b, 8
	cmove	rcx, r8
	jne	2752f
	test	r13b, 4
	jne	2762f
2702:
	test	r13b, 2
	jne	2772f
2712:
	test	r13b, 1
	je	2732f
2722:
	mov	byte ptr [rdi], cl
2732:
	popcnt	rcx, rdx
	add	rax, rcx
2742:
	add	rsp, 8
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	vzeroupper
	ret
2752:
	mov	qword ptr [rdi], r8
	add	rdi, 8
	test	r13b, 4
	je	2702b
2762:
	mov	dword ptr [rdi], ecx
	add	rdi, 4
	shr	rcx, 32
	test	r13b, 2
	je	2712b
2772:
	mov	word ptr [rdi], cx
	add	rdi, 2
	shr	rcx, 16
	test	r13b, 1
	jne	2722b
	jmp	2732b
	.p2align	4, 0x0
2782:
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	2
	.byte	2
	.byte	3
	.byte	3
	.byte	4
	.byte	3
	.byte	4
	.byte	4
	.byte	5
	.p2align	4, 0x0
2792:
	.byte	5
	.byte	6
	.byte	5
	.byte	6
	.byte	6
	.byte	7
	.byte	6
	.byte	7
	.byte	7
	.byte	8
	.byte	8
	.byte	9
	.byte	8
	.byte	9
	.byte	9
	.byte	10
	.p2align	4, 0x0
2802:
	.short	2048
	.short	64
	.short	512
	.short	16
	.short	128
	.short	1024
	.short	32
	.short	256
	.p2align	4, 0x0
2812:
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	2
	.byte	1
	.byte	2
	.byte	2
	.byte	3
	.byte	2
	.byte	3
	.p2align	4, 0x0
2822:
	.byte	3
	.byte	4
	.byte	3
	.byte	4
	.byte	3
	.byte	4
	.byte	4
	.byte	5
	.byte	4
	.byte	5
	.byte	4
	.byte	5
	.byte	5
	.byte	6
	.byte	5
	.byte	6
	.p2align	4, 0x0
2832:
	.short	8192
	.short	1024
	.short	128
	.short	4096
	.short	512
	.short	64
	.short	2048
	.short	256
	.p2align	4, 0x0
2842:
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	1
	.byte	2
	.byte	2
	.byte	3
	.byte	3
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	6
	.byte	6
	.byte	7
	.p2align	4, 0x0
2852:
	.byte	7
	.byte	8
	.byte	7
	.byte	8
	.byte	8
	.byte	9
	.byte	9
	.byte	10
	.byte	10
	.byte	11
	.byte	11
	.byte	12
	.byte	12
	.byte	13
	.byte	13
	.byte	14
	.p2align	4, 0x0
2862:
	.short	512
	.short	4
	.short	8
	.short	16
	.short	32
	.short	64
	.short	128
	.short	256
	.p2align	4, 0x0
2872:
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	2
	.byte	1
	.byte	2
	.byte	1
	.byte	2
	.p2align	4, 0x0
2882:
	.byte	2
	.byte	3
	.byte	2
	.byte	3
	.byte	2
	.byte	3
	.byte	2
	.byte	3
	.byte	3
	.byte	4
	.byte	3
	.byte	4
	.byte	3
	.byte	4
	.byte	3
	.byte	4
	.p2align	3, 0x0
2892:
	.short	16384
	.short	4096
	.short	1024
	.short	256
	.p2align	2, 0x0
2902:
	.byte	3
	.byte	4
	.byte	3
	.byte	6
	.p2align	4, 0x0
2912:
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	2
	.byte	2
	.byte	3
	.byte	2
	.byte	3
	.byte	3
	.byte	4
	.byte	3
	.byte	4
	.p2align	4, 0x0
2922:
	.byte	4
	.byte	5
	.byte	4
	.byte	5
	.byte	5
	.byte	6
	.byte	5
	.byte	6
	.byte	6
	.byte	7
	.byte	6
	.byte	7
	.byte	7
	.byte	8
	.byte	7
	.byte	8
	.p2align	2, 0x0
2932:
	.short	4096
	.short	256
	.p2align	4, 0x0
2942:
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	1
	.byte	2
	.byte	2
	.byte	3
	.byte	3
	.byte	4
	.byte	3
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	6
	.p2align	4, 0x0
2952:
	.byte	6
	.byte	7
	.byte	6
	.byte	7
	.byte	7
	.byte	8
	.byte	8
	.byte	9
	.byte	9
	.byte	10
	.byte	9
	.byte	10
	.byte	10
	.byte	11
	.byte	11
	.byte	12
	.p2align	3, 0x0
2962:
	.short	1024
	.short	16
	.short	64
	.short	256
	.p2align	2, 0x0
2972:
	.byte	127
	.p2align	5, 0x0
2982:
	.zero	32,127
	.p2align	5, 0x0
2992:
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	13
	.byte	13
	.byte	13
	.byte	13
	.byte	13
	.byte	13
	.byte	13
	.byte	13
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	15
	.byte	15
	.byte	15
	.byte	15
	.byte	15
	.byte	15
	.byte	15
	.byte	15
	.p2align	3, 0x0
3002:
	.byte	1
	.byte	2
	.byte	4
	.byte	8
	.byte	16
	.byte	32
	.byte	64
	.byte	128
	.p2align	5, 0x0
3012:
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.p2align	5, 0x0
3022:
	.byte	15
	.p2align	5, 0x0
3032:
	.byte	127
	.p2align	5, 0x0
3042:
	.zero	32,1
	.p2align	5, 0x0
3052:
	.zero	32,3
	.p2align	5, 0x0
3062:
	.zero	32,7
	.p2align	5, 0x0
3072:
	.zero	32,248
	.p2align	5, 0x0
3082:
	.zero	32,15
	.p2align	5, 0x0
3092:
	.zero	32,240
	.p2align	5, 0x0
3102:
	.zero	32,31
	.p2align	5, 0x0
3112:
	.zero	32,224
	.p2align	5, 0x0
3122:
	.zero	32,192
	.p2align	5, 0x0
3132:
	.zero	32,63
	.p2align	5, 0x0
3142:
	.byte	3
	.p2align	5, 0x0
3152:
	.byte	31
	.p2align	5, 0x0
3162:
	.byte	240
	.p2align	5, 0x0
3172:
	.byte	248
	.p2align	5, 0x0
3182:
	.byte	1
	.p2align	5, 0x0
3192:
	.byte	7
	.p2align	5, 0x0
3202:
	.byte	63

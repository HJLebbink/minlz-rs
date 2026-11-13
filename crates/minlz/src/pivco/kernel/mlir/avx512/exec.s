# minlz_pivco_exec of crates/minlz/mlir/pivco.mlir for avx512, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 88
	mov	r14, qword ptr [rdi + 8]
	test	r14, r14
	je	102f
	mov	r12, qword ptr [rdi]
	mov	rbp, qword ptr [rdi + 16]
	mov	rax, qword ptr [rdi + 24]
	mov	qword ptr [rsp + 24], rax
	mov	r13, qword ptr [rdi + 32]
	mov	r15, qword ptr [rdi + 40]
	mov	rax, qword ptr [rdi + 48]
	mov	qword ptr [rsp + 80], rax
	mov	rax, qword ptr [rdi + 56]
	mov	qword ptr [rsp + 72], rax
	mov	rax, qword ptr [rdi + 64]
	mov	qword ptr [rsp + 56], rax
	mov	rax, qword ptr [rdi + 72]
	mov	qword ptr [rsp + 64], rax
	sub	rdi, -128
	mov	qword ptr [rsp + 32], rdi
	xor	ebx, ebx
	mov	qword ptr [rsp + 48], r14
	mov	qword ptr [rsp + 40], rbp
	mov	qword ptr [rsp + 16], r15
	jmp	32f
2:
	cmp	r8b, 9
	setb	r9b
	add	r11, 7
	shr	r11, 3
	add	r11, rsi
	mov	r15, qword ptr [rsp + 24]
	cmp	r11, r15
	setbe	r11b
	and	r11b, r9b
	and	cl, r11b
	cmp	cl, 1
	jne	122f
	mov	r9, r15
	sub	r9, rsi
	mov	rcx, qword ptr [rsp + 32]
	mov	qword ptr [rsp], rcx
	mov	rsi, rax
	mov	rcx, r8
	mov	r8, r9
	mov	r9, r10
	call	132f
12:
	mov	r15, qword ptr [rsp + 16]
22:
	inc	rbx
	add	r12, 32
	cmp	r14, rbx
	je	112f
32:
	movzx	r8d, byte ptr [r12 + 2]
	cmp	r8, 2
	setae	cl
	movzx	r10d, byte ptr [r12 + 3]
	mov	edx, dword ptr [r12 + 8]
	mov	eax, dword ptr [r12 + 20]
	test	byte ptr [r12 + 1], 1
	mov	rdi, qword ptr [rsp + 80]
	cmove	rdi, r13
	mov	rsi, qword ptr [rsp + 72]
	cmove	rsi, r15
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
	mov	esi, dword ptr [r12 + 16]
	add	rdi, rax
	lea	rax, [rbp + rsi]
	movzx	r9d, byte ptr [r12]
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
	mov	r15d, 128
	jmp	72f
	.p2align	4
42:
	mov	r15d, dword ptr [r12 + 12]
	mov	r11d, dword ptr [r12 + 28]
	lea	rcx, [rdx + 7]
	shr	rcx, 3
	add	rcx, rsi
	lea	r8, [r13 + r11]
	add	r11, rdx
	test	r9d, r9d
	je	92f
	cmp	r9d, 1
	je	82f
	cmp	r9d, 2
	jne	122f
	cmp	rcx, qword ptr [rsp + 24]
	ja	122f
	movzx	r8d, byte ptr [r12 + 4]
	mov	rsi, rdx
	mov	rdx, rax
	mov	rcx, r10
	call	422f
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
	cmp	rsi, qword ptr [rsp + 24]
	ja	122f
	mov	rsi, rax
	call	502f
	jmp	22b
62:
	mov	r9d, 64
	mov	r15d, 512
72:
	cmp	r8b, 8
	setb	bpl
	lea	r14d, [r15 - 1]
	test	r14d, edx
	sete	r14b
	shr	r11, 3
	add	r11, rsi
	cmp	r11, qword ptr [rsp + 24]
	setbe	sil
	and	r14b, bpl
	and	r14b, sil
	and	cl, r14b
	cmp	cl, 1
	jne	122f
	rep		bsf	rcx, r15
	shrx	rdx, rdx, rcx
	mov	rsi, rax
	mov	rcx, r10
	call	542f
	mov	r14, qword ptr [rsp + 48]
	mov	rbp, qword ptr [rsp + 40]
	jmp	12b
82:
	cmp	rcx, qword ptr [rsp + 24]
	ja	122f
	cmp	r11, qword ptr [rsp + 16]
	ja	122f
	mov	rsi, rdx
	mov	rdx, rax
	mov	rcx, r8
	mov	r8, r10
	call	792f
	cmp	rax, r15
	mov	r15, qword ptr [rsp + 16]
	je	22b
	jmp	122f
92:
	cmp	rcx, qword ptr [rsp + 24]
	ja	122f
	mov	ecx, dword ptr [r12 + 24]
	lea	rsi, [rcx + rdx]
	mov	r9, qword ptr [rsp + 16]
	cmp	rsi, r9
	ja	122f
	cmp	r11, r9
	ja	122f
	add	rcx, r13
	mov	rsi, rdx
	mov	rdx, rax
	call	882f
	cmp	rax, r15
	mov	r15, qword ptr [rsp + 16]
	je	22b
	jmp	122f
102:
	xor	ebx, ebx
	jmp	122f
112:
	mov	rbx, r14
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
	mov	rax, qword ptr [rsp + 8]
	vmovdqu64	zmm0, zmmword ptr [r9]
	cmp	rcx, 4
	jle	172f
	cmp	rcx, 6
	jg	212f
	cmp	rcx, 5
	jne	332f
	cmp	rdx, 64
	setb	cl
	cmp	r8, 64
	setb	r9b
	or	r9b, cl
	vshufi64x2	zmm0, zmm0, zmm0, 68
	jne	152f
	vmovdqa64	zmm1, zmmword ptr [rip + 972f]
	vpbroadcastq	zmm2, qword ptr [rip + 982f]
	add	r8, -40
	.p2align	4
142:
	vpermb	zmm3, zmm1, zmmword ptr [rsi]
	vpmultishiftqb	zmm3, zmm2, zmm3
	vpermb	zmm3, zmm3, zmm0
	vmovdqu64	zmmword ptr [rdi], zmm3
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
	je	412f
	vmovdqa64	zmm1, zmmword ptr [rip + 972f]
	vpbroadcastq	zmm2, qword ptr [rip + 982f]
	mov	rcx, -1
	.p2align	4
162:
	cmp	rdx, 64
	mov	r8d, 64
	cmovb	r8, rdx
	lea	r9d, [r8 + 4*r8 + 7]
	shr	r9d, 3
	bzhi	r9, rcx, r9
	kmovq	k1, r9
	vmovdqu8	zmm3 {k1} {z}, zmmword ptr [rsi]
	vmovdqu64	zmmword ptr [rax], zmm3
	vpermb	zmm3, zmm1, zmm3
	vpmultishiftqb	zmm3, zmm2, zmm3
	vpermb	zmm3, zmm3, zmm0
	bzhi	r9, rcx, r8
	kmovq	k1, r9
	vmovdqu8	zmmword ptr [rdi] {k1}, zmm3
	add	rdi, 64
	add	rsi, 40
	sub	rdx, r8
	jne	162b
	jmp	412f
172:
	cmp	rcx, 2
	je	252f
	cmp	rcx, 3
	jne	292f
	cmp	rdx, 64
	setb	cl
	cmp	r8, 64
	setb	r9b
	or	r9b, cl
	jne	192f
	vmovdqa64	zmm1, zmmword ptr [rip + 992f]
	vpbroadcastq	zmm2, qword ptr [rip + 1002f]
	vpbroadcastq	zmm3, xmm0
	add	r8, -24
	.p2align	4
182:
	vpermb	zmm4, zmm1, zmmword ptr [rsi]
	vpmultishiftqb	zmm4, zmm2, zmm4
	vpermb	zmm4, zmm4, zmm3
	vmovdqu64	zmmword ptr [rdi], zmm4
	add	rdi, 64
	add	rsi, 24
	add	rdx, -64
	cmp	rdx, 64
	jb	192f
	cmp	r8, 63
	lea	r8, [r8 - 24]
	ja	182b
192:
	test	rdx, rdx
	je	412f
	vmovdqa64	zmm1, zmmword ptr [rip + 992f]
	vpbroadcastq	zmm2, qword ptr [rip + 1002f]
	vpbroadcastq	zmm0, xmm0
	mov	rcx, -1
	.p2align	4
202:
	cmp	rdx, 64
	mov	r8d, 64
	cmovb	r8, rdx
	lea	r9d, [r8 + 2*r8 + 7]
	shr	r9d, 3
	bzhi	r9, rcx, r9
	kmovq	k1, r9
	vmovdqu8	zmm3 {k1} {z}, zmmword ptr [rsi]
	vmovdqu64	zmmword ptr [rax], zmm3
	vpermb	zmm3, zmm1, zmm3
	vpmultishiftqb	zmm3, zmm2, zmm3
	vpermb	zmm3, zmm3, zmm0
	bzhi	r9, rcx, r8
	kmovq	k1, r9
	vmovdqu8	zmmword ptr [rdi] {k1}, zmm3
	add	rdi, 64
	add	rsi, 24
	sub	rdx, r8
	jne	202b
	jmp	412f
212:
	cmp	rcx, 7
	jne	372f
	vmovdqu64	zmm1, zmmword ptr [r9 + 64]
	cmp	rdx, 64
	setb	cl
	cmp	r8, 64
	setb	r9b
	or	r9b, cl
	jne	232f
	vmovdqa64	zmm2, zmmword ptr [rip + 1012f]
	vpbroadcastq	zmm3, qword ptr [rip + 1022f]
	add	r8, -56
	.p2align	4
222:
	vpermb	zmm4, zmm2, zmmword ptr [rsi]
	vpmultishiftqb	zmm4, zmm3, zmm4
	vpermi2b	zmm4, zmm0, zmm1
	vmovdqu64	zmmword ptr [rdi], zmm4
	add	rdi, 64
	add	rsi, 56
	add	rdx, -64
	cmp	rdx, 64
	jb	232f
	cmp	r8, 63
	lea	r8, [r8 - 56]
	ja	222b
232:
	test	rdx, rdx
	je	412f
	vmovdqa64	zmm2, zmmword ptr [rip + 1012f]
	vpbroadcastq	zmm3, qword ptr [rip + 1022f]
	mov	rcx, -1
	.p2align	4
242:
	cmp	rdx, 64
	mov	r8d, 64
	cmovb	r8, rdx
	lea	r9d, [8*r8]
	sub	r9d, r8d
	add	r9d, 7
	shr	r9d, 3
	bzhi	r9, rcx, r9
	kmovq	k1, r9
	vmovdqu8	zmm4 {k1} {z}, zmmword ptr [rsi]
	vmovdqu64	zmmword ptr [rax], zmm4
	vpermb	zmm4, zmm2, zmm4
	vpmultishiftqb	zmm4, zmm3, zmm4
	vpermi2b	zmm4, zmm0, zmm1
	bzhi	r9, rcx, r8
	kmovq	k1, r9
	vmovdqu8	zmmword ptr [rdi] {k1}, zmm4
	add	rdi, 64
	add	rsi, 56
	sub	rdx, r8
	jne	242b
	jmp	412f
252:
	cmp	rdx, 64
	setb	cl
	cmp	r8, 64
	setb	r9b
	or	r9b, cl
	jne	272f
	vmovdqa64	zmm1, zmmword ptr [rip + 1032f]
	vpbroadcastq	zmm2, qword ptr [rip + 1042f]
	vpbroadcastd	zmm3, xmm0
	add	r8, -16
	.p2align	4
262:
	vpermb	zmm4, zmm1, zmmword ptr [rsi]
	vpmultishiftqb	zmm4, zmm2, zmm4
	vpermb	zmm4, zmm4, zmm3
	vmovdqu64	zmmword ptr [rdi], zmm4
	add	rdi, 64
	add	rsi, 16
	add	rdx, -64
	cmp	rdx, 64
	jb	272f
	cmp	r8, 63
	lea	r8, [r8 - 16]
	ja	262b
272:
	test	rdx, rdx
	je	412f
	vmovdqa64	zmm1, zmmword ptr [rip + 1032f]
	vpbroadcastq	zmm2, qword ptr [rip + 1042f]
	vpbroadcastd	zmm0, xmm0
	xor	ecx, ecx
	mov	r8, -1
	.p2align	4
282:
	cmp	rdx, 64
	mov	r9d, 64
	cmovb	r9, rdx
	lea	r10d, [r9 + r9 + 6]
	shr	r10d, 3
	bzhi	r10, r8, r10
	kmovq	k1, r10
	vmovdqu8	zmm3 {k1} {z}, zmmword ptr [rsi + rcx]
	vmovdqu64	zmmword ptr [rax], zmm3
	vpermb	zmm3, zmm1, zmm3
	vpmultishiftqb	zmm3, zmm2, zmm3
	vpermb	zmm3, zmm3, zmm0
	bzhi	r10, r8, r9
	kmovq	k1, r10
	vmovdqu8	zmmword ptr [rdi + 4*rcx] {k1}, zmm3
	add	rcx, 16
	sub	rdx, r9
	jne	282b
	jmp	412f
292:
	cmp	rdx, 64
	setb	cl
	cmp	r8, 64
	setb	r9b
	or	r9b, cl
	vshufi64x2	zmm0, zmm0, zmm0, 0
	jne	312f
	vmovdqa64	zmm1, zmmword ptr [rip + 1052f]
	vpbroadcastq	zmm2, qword ptr [rip + 1062f]
	add	r8, -32
	.p2align	4
302:
	vpermb	zmm3, zmm1, zmmword ptr [rsi]
	vpmultishiftqb	zmm3, zmm2, zmm3
	vpermb	zmm3, zmm3, zmm0
	vmovdqu64	zmmword ptr [rdi], zmm3
	add	rdi, 64
	add	rsi, 32
	add	rdx, -64
	cmp	rdx, 64
	jb	312f
	cmp	r8, 63
	lea	r8, [r8 - 32]
	ja	302b
312:
	test	rdx, rdx
	je	412f
	vmovdqa64	zmm1, zmmword ptr [rip + 1052f]
	vpbroadcastq	zmm2, qword ptr [rip + 1062f]
	xor	ecx, ecx
	mov	r8, -1
	.p2align	4
322:
	cmp	rdx, 64
	mov	r9d, 64
	cmovb	r9, rdx
	lea	r10d, [4*r9 + 4]
	shr	r10d, 3
	bzhi	r10, r8, r10
	kmovq	k1, r10
	vmovdqu8	zmm3 {k1} {z}, zmmword ptr [rsi + rcx]
	vmovdqu64	zmmword ptr [rax], zmm3
	vpermb	zmm3, zmm1, zmm3
	vpmultishiftqb	zmm3, zmm2, zmm3
	vpermb	zmm3, zmm3, zmm0
	bzhi	r10, r8, r9
	kmovq	k1, r10
	vmovdqu8	zmmword ptr [rdi + 2*rcx] {k1}, zmm3
	add	rcx, 32
	sub	rdx, r9
	jne	322b
	jmp	412f
332:
	cmp	rdx, 64
	setb	cl
	cmp	r8, 64
	setb	r9b
	or	r9b, cl
	jne	352f
	vmovdqa64	zmm1, zmmword ptr [rip + 1072f]
	vpbroadcastq	zmm2, qword ptr [rip + 1082f]
	add	r8, -48
	.p2align	4
342:
	vpermb	zmm3, zmm1, zmmword ptr [rsi]
	vpmultishiftqb	zmm3, zmm2, zmm3
	vpermb	zmm3, zmm3, zmm0
	vmovdqu64	zmmword ptr [rdi], zmm3
	add	rdi, 64
	add	rsi, 48
	add	rdx, -64
	cmp	rdx, 64
	jb	352f
	cmp	r8, 63
	lea	r8, [r8 - 48]
	ja	342b
352:
	test	rdx, rdx
	je	412f
	vmovdqa64	zmm1, zmmword ptr [rip + 1072f]
	vpbroadcastq	zmm2, qword ptr [rip + 1082f]
	mov	rcx, -1
	.p2align	4
362:
	cmp	rdx, 64
	mov	r8d, 64
	cmovb	r8, rdx
	lea	r9d, [r8 + 2*r8]
	lea	r9d, [r9 + r9 + 6]
	shr	r9d, 3
	bzhi	r9, rcx, r9
	kmovq	k1, r9
	vmovdqu8	zmm3 {k1} {z}, zmmword ptr [rsi]
	vmovdqu64	zmmword ptr [rax], zmm3
	vpermb	zmm3, zmm1, zmm3
	vpmultishiftqb	zmm3, zmm2, zmm3
	vpermb	zmm3, zmm3, zmm0
	bzhi	r9, rcx, r8
	kmovq	k1, r9
	vmovdqu8	zmmword ptr [rdi] {k1}, zmm3
	add	rdi, 64
	add	rsi, 48
	sub	rdx, r8
	jne	362b
	jmp	412f
372:
	vmovdqu64	zmm1, zmmword ptr [r9 + 64]
	vmovdqu64	zmm2, zmmword ptr [r9 + 128]
	vmovdqu64	zmm3, zmmword ptr [r9 + 192]
	cmp	rdx, 64
	setb	cl
	cmp	r8, 64
	setb	r9b
	or	r9b, cl
	jne	392f
	add	r8, -64
	.p2align	4
382:
	vmovdqu64	zmm4, zmmword ptr [rsi]
	vmovdqa64	zmm5, zmm0
	vpermt2b	zmm5, zmm4, zmm1
	vmovdqa64	zmm6, zmm2
	vpermt2b	zmm6, zmm4, zmm3
	vpmovb2m	k1, zmm4
	vmovdqu8	zmm5 {k1}, zmm6
	vmovdqu64	zmmword ptr [rdi], zmm5
	add	rdi, 64
	add	rsi, 64
	add	rdx, -64
	cmp	rdx, 64
	jb	392f
	cmp	r8, 63
	lea	r8, [r8 - 64]
	ja	382b
392:
	test	rdx, rdx
	je	412f
	xor	ecx, ecx
	mov	r8, -1
	.p2align	4
402:
	cmp	rdx, 64
	mov	r9d, 64
	cmovb	r9, rdx
	bzhi	r10, r8, r9
	kmovq	k1, r10
	vmovdqu8	zmm4 {k1} {z}, zmmword ptr [rsi + rcx]
	vmovdqu64	zmmword ptr [rax], zmm4
	vmovdqa64	zmm5, zmm0
	vpermt2b	zmm5, zmm4, zmm1
	vmovdqa64	zmm6, zmm2
	vpermt2b	zmm6, zmm4, zmm3
	vpmovb2m	k2, zmm4
	vmovdqu8	zmm5 {k2}, zmm6
	vmovdqu8	zmmword ptr [rdi + rcx] {k1}, zmm5
	add	rcx, 64
	sub	rdx, r9
	jne	402b
412:
	vzeroupper
	ret
	.p2align	4
422:
	vpbroadcastb	zmm0, ecx
	xor	r8d, ecx
	vpbroadcastb	zmm1, r8d
	mov	rax, rsi
	shr	rax, 6
	vpxorq	zmm1, zmm0, zmm1
	je	442f
	shl	rax, 3
	xor	ecx, ecx
	.p2align	4
432:
	kmovq	k1, qword ptr [rdx + rcx]
	vpblendmb	zmm2 {k1}, zmm0, zmm1
	vmovdqu64	zmmword ptr [rdi + 8*rcx], zmm2
	add	rcx, 8
	cmp	rax, rcx
	jne	432b
442:
	mov	rax, rsi
	and	rax, 63
	je	492f
	and	esi, -64
	mov	ecx, esi
	shr	ecx, 3
	add	rdx, rcx
	lea	ecx, [rax + 7]
	shr	ecx, 3
	cmp	rax, 25
	jb	452f
	mov	r8d, dword ptr [rdx]
	mov	edx, dword ptr [rdx + rcx - 4]
	add	rcx, -4
	jmp	462f
452:
	cmp	eax, 9
	jb	472f
	movzx	r8d, word ptr [rdx]
	movzx	edx, word ptr [rdx + rcx - 2]
	add	rcx, -2
462:
	shl	ecx, 3
	shlx	rcx, rdx, rcx
	or	rcx, r8
	jmp	482f
472:
	movzx	ecx, byte ptr [rdx]
482:
	kmovq	k1, rcx
	vmovdqu8	zmm0 {k1}, zmm1
	mov	rcx, -1
	bzhi	rax, rcx, rax
	kmovq	k1, rax
	vmovdqu8	zmmword ptr [rdi + rsi] {k1}, zmm0
492:
	vzeroupper
	ret
	.p2align	4
502:
	mov	rax, rdx
	shr	rax, 6
	je	522f
	shl	rax, 6
	xor	ecx, ecx
	.p2align	4
512:
	vmovdqu64	zmm0, zmmword ptr [rsi + rcx]
	vmovdqu64	zmmword ptr [rdi + rcx], zmm0
	add	rcx, 64
	cmp	rax, rcx
	jne	512b
522:
	mov	rax, rdx
	and	rax, 63
	je	532f
	and	edx, -64
	mov	rcx, -1
	bzhi	rax, rcx, rax
	kmovq	k1, rax
	vmovdqu8	zmm0 {k1} {z}, zmmword ptr [rsi + rdx]
	vmovdqu8	zmmword ptr [rdi + rdx] {k1}, zmm0
532:
	vzeroupper
	ret
	.p2align	4
542:
	cmp	r9, 16
	jne	562f
	cmp	r8, 4
	jg	582f
	cmp	r8, 2
	je	622f
	cmp	r8, 3
	je	702f
	cmp	r8, 4
	jne	782f
	test	rdx, rdx
	je	782f
	vmovdqu	xmm0, xmmword ptr [rcx]
	shl	rdx, 6
	xor	eax, eax
	.p2align	4
552:
	vmovdqu	xmm1, xmmword ptr [rsi + rax]
	vmovdqu	xmm2, xmmword ptr [rsi + rax + 16]
	vmovdqu	xmm3, xmmword ptr [rsi + rax + 32]
	vmovdqu	xmm4, xmmword ptr [rsi + rax + 48]
	vpermb	xmm5, xmm1, xmm0
	#APP
	#NO_APP
	vmovdqu	xmmword ptr [rdi + 2*rax], xmm5
	vpsrlw	xmm1, xmm1, 4
	vpermb	xmm1, xmm1, xmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi + 2*rax + 16], xmm1
	vpermb	xmm1, xmm2, xmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi + 2*rax + 32], xmm1
	vpsrlw	xmm1, xmm2, 4
	vpermb	xmm1, xmm1, xmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi + 2*rax + 48], xmm1
	vpermb	xmm1, xmm3, xmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi + 2*rax + 64], xmm1
	vpsrlw	xmm1, xmm3, 4
	vpermb	xmm1, xmm1, xmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi + 2*rax + 80], xmm1
	vpermb	xmm1, xmm4, xmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi + 2*rax + 96], xmm1
	vpsrlw	xmm1, xmm4, 4
	vpermb	xmm1, xmm1, xmm0
	#APP
	#NO_APP
	vmovdqu	xmmword ptr [rdi + 2*rax + 112], xmm1
	add	rax, 64
	cmp	rdx, rax
	jne	552b
	jmp	782f
562:
	cmp	r8, 4
	jg	602f
	cmp	r8, 2
	je	642f
	cmp	r8, 3
	je	722f
	cmp	r8, 4
	jne	782f
	test	rdx, rdx
	je	782f
	vmovdqu64	zmm0, zmmword ptr [rcx]
	vshufi64x2	zmm0, zmm0, zmm0, 0
	shl	rdx, 8
	xor	eax, eax
	.p2align	4
572:
	vmovdqu64	zmm1, zmmword ptr [rsi + rax]
	vmovdqu64	zmm2, zmmword ptr [rsi + rax + 64]
	vmovdqu64	zmm3, zmmword ptr [rsi + rax + 128]
	vmovdqu64	zmm4, zmmword ptr [rsi + rax + 192]
	vpermb	zmm5, zmm1, zmm0
	vmovdqu64	zmmword ptr [rdi + 2*rax], zmm5
	vpsrlw	zmm1, zmm1, 4
	vpermb	zmm1, zmm1, zmm0
	vmovdqu64	zmmword ptr [rdi + 2*rax + 64], zmm1
	vpermb	zmm1, zmm2, zmm0
	vmovdqu64	zmmword ptr [rdi + 2*rax + 128], zmm1
	vpsrlw	zmm1, zmm2, 4
	vpermb	zmm1, zmm1, zmm0
	vmovdqu64	zmmword ptr [rdi + 2*rax + 192], zmm1
	vpermb	zmm1, zmm3, zmm0
	vmovdqu64	zmmword ptr [rdi + 2*rax + 256], zmm1
	vpsrlw	zmm1, zmm3, 4
	vpermb	zmm1, zmm1, zmm0
	vmovdqu64	zmmword ptr [rdi + 2*rax + 320], zmm1
	vpermb	zmm1, zmm4, zmm0
	vmovdqu64	zmmword ptr [rdi + 2*rax + 384], zmm1
	vpsrlw	zmm1, zmm4, 4
	vpermb	zmm1, zmm1, zmm0
	vmovdqu64	zmmword ptr [rdi + 2*rax + 448], zmm1
	add	rax, 256
	cmp	rdx, rax
	jne	572b
	jmp	782f
582:
	cmp	r8, 5
	je	662f
	cmp	r8, 6
	je	742f
	cmp	r8, 7
	jne	782f
	test	rdx, rdx
	je	782f
	vmovdqu64	zmm0, zmmword ptr [rcx]
	vmovdqu64	zmm1, zmmword ptr [rcx + 64]
	add	rsi, 96
	add	rdi, 112
	vpbroadcastb	zmm2, byte ptr [rip + 1092f]
	vpbroadcastb	zmm3, byte ptr [rip + 1102f]
	vpbroadcastb	zmm4, byte ptr [rip + 1112f]
	vpbroadcastb	zmm5, byte ptr [rip + 1122f]
	vpbroadcastb	zmm6, byte ptr [rip + 1132f]
	vpbroadcastb	zmm7, byte ptr [rip + 1142f]
	vpbroadcastb	zmm8, byte ptr [rip + 1152f]
	vpbroadcastb	zmm9, byte ptr [rip + 1162f]
	vpbroadcastb	zmm10, byte ptr [rip + 1172f]
	vpbroadcastb	zmm11, byte ptr [rip + 1182f]
	vpbroadcastb	zmm12, byte ptr [rip + 1192f]
	vpbroadcastb	zmm13, byte ptr [rip + 1202f]
	.p2align	4
592:
	vmovdqu64	xmm16, xmmword ptr [rsi - 96]
	vmovdqu64	xmm17, xmmword ptr [rsi - 80]
	vmovdqu64	xmm18, xmmword ptr [rsi - 64]
	vmovdqu64	xmm19, xmmword ptr [rsi - 48]
	vmovdqu64	xmm20, xmmword ptr [rsi - 32]
	vmovdqu	xmm15, xmmword ptr [rsi - 16]
	vmovdqu	xmm14, xmmword ptr [rsi]
	vmovdqa64	zmm21, zmm0
	vpermt2b	zmm21, zmm16, zmm1
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 112], xmm21
	vpsrlw	zmm16, zmm16, 7
	vpaddw	zmm21, zmm17, zmm17
	vpandq	zmm21, zmm21, zmm2
	vpternlogq	zmm21, zmm16, zmm3, 248
	vpermi2b	zmm21, zmm0, zmm1
	#APP
	#NO_APP
	vmovdqu64	xmmword ptr [rdi - 96], xmm21
	vpsrlw	zmm16, zmm17, 6
	vpsllw	zmm17, zmm18, 2
	vpandq	zmm17, zmm17, zmm4
	vpternlogq	zmm17, zmm16, zmm5, 248
	vpermi2b	zmm17, zmm0, zmm1
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 80], xmm17
	vpsrlw	zmm16, zmm18, 5
	vpsllw	zmm17, zmm19, 3
	vpandq	zmm17, zmm17, zmm6
	vpternlogq	zmm17, zmm16, zmm7, 248
	vpermi2b	zmm17, zmm0, zmm1
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 64], xmm17
	vpsrlw	zmm16, zmm19, 4
	vpsllw	zmm17, zmm20, 4
	vpandq	zmm17, zmm17, zmm8
	vpternlogq	zmm17, zmm16, zmm9, 248
	vpermi2b	zmm17, zmm0, zmm1
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 48], xmm17
	vpsrlw	zmm16, zmm20, 3
	vpsllw	zmm17, zmm15, 5
	vpandq	zmm17, zmm17, zmm10
	vpternlogq	zmm17, zmm16, zmm11, 248
	vpermi2b	zmm17, zmm0, zmm1
	#APP
	#NO_APP
	vmovdqu64	xmmword ptr [rdi - 32], xmm17
	vpsrlw	zmm15, zmm15, 2
	vpsllw	zmm16, zmm14, 6
	vpandq	zmm16, zmm16, zmm12
	vpternlogq	zmm16, zmm15, zmm13, 248
	vpermi2b	zmm16, zmm0, zmm1
	#APP
	#NO_APP
	vmovdqu64	xmmword ptr [rdi - 16], xmm16
	vpsrlw	zmm14, zmm14, 1
	vpermi2b	zmm14, zmm0, zmm1
	#APP
	#NO_APP
	vmovdqu	xmmword ptr [rdi], xmm14
	add	rsi, 112
	sub	rdi, -128
	dec	rdx
	jne	592b
	jmp	782f
602:
	cmp	r8, 5
	je	682f
	cmp	r8, 6
	je	762f
	cmp	r8, 7
	jne	782f
	test	rdx, rdx
	je	782f
	vmovdqu64	zmm0, zmmword ptr [rcx]
	vmovdqu64	zmm1, zmmword ptr [rcx + 64]
	add	rsi, 384
	add	rdi, 448
	vpbroadcastb	zmm2, byte ptr [rip + 1102f]
	vpbroadcastb	zmm3, byte ptr [rip + 1092f]
	vpbroadcastb	zmm4, byte ptr [rip + 1112f]
	vpbroadcastb	zmm5, byte ptr [rip + 1122f]
	vpbroadcastb	zmm6, byte ptr [rip + 1132f]
	vpbroadcastb	zmm7, byte ptr [rip + 1142f]
	vpbroadcastb	zmm8, byte ptr [rip + 1152f]
	vpbroadcastb	zmm9, byte ptr [rip + 1162f]
	vpbroadcastb	zmm10, byte ptr [rip + 1172f]
	vpbroadcastb	zmm11, byte ptr [rip + 1182f]
	vpbroadcastb	zmm12, byte ptr [rip + 1192f]
	vpbroadcastb	zmm13, byte ptr [rip + 1202f]
	.p2align	4
612:
	vmovdqu64	zmm14, zmmword ptr [rsi - 384]
	vmovdqu64	zmm15, zmmword ptr [rsi - 320]
	vmovdqu64	zmm16, zmmword ptr [rsi - 256]
	vmovdqu64	zmm17, zmmword ptr [rsi - 192]
	vmovdqu64	zmm18, zmmword ptr [rsi - 128]
	vmovdqu64	zmm19, zmmword ptr [rsi - 64]
	vmovdqu64	zmm20, zmmword ptr [rsi]
	vmovdqa64	zmm21, zmm0
	vpermt2b	zmm21, zmm14, zmm1
	vmovdqu64	zmmword ptr [rdi - 448], zmm21
	vpsrlw	zmm14, zmm14, 7
	vpandq	zmm14, zmm14, zmm2
	vpaddw	zmm21, zmm15, zmm15
	vpternlogq	zmm21, zmm14, zmm3, 236
	vpermi2b	zmm21, zmm0, zmm1
	vmovdqu64	zmmword ptr [rdi - 384], zmm21
	vpsrlw	zmm14, zmm15, 6
	vpsllw	zmm15, zmm16, 2
	vpandq	zmm15, zmm15, zmm4
	vpternlogq	zmm15, zmm14, zmm5, 248
	vpermi2b	zmm15, zmm0, zmm1
	vmovdqu64	zmmword ptr [rdi - 320], zmm15
	vpsrlw	zmm14, zmm16, 5
	vpsllw	zmm15, zmm17, 3
	vpandq	zmm15, zmm15, zmm6
	vpternlogq	zmm15, zmm14, zmm7, 248
	vpermi2b	zmm15, zmm0, zmm1
	vmovdqu64	zmmword ptr [rdi - 256], zmm15
	vpsrlw	zmm14, zmm17, 4
	vpsllw	zmm15, zmm18, 4
	vpandq	zmm15, zmm15, zmm8
	vpternlogq	zmm15, zmm14, zmm9, 248
	vpermi2b	zmm15, zmm0, zmm1
	vmovdqu64	zmmword ptr [rdi - 192], zmm15
	vpsrlw	zmm14, zmm18, 3
	vpsllw	zmm15, zmm19, 5
	vpandq	zmm15, zmm15, zmm10
	vpternlogq	zmm15, zmm14, zmm11, 248
	vpermi2b	zmm15, zmm0, zmm1
	vmovdqu64	zmmword ptr [rdi - 128], zmm15
	vpsrlw	zmm14, zmm19, 2
	vpsllw	zmm15, zmm20, 6
	vpandq	zmm15, zmm15, zmm12
	vpternlogq	zmm15, zmm14, zmm13, 248
	vpermi2b	zmm15, zmm0, zmm1
	vmovdqu64	zmmword ptr [rdi - 64], zmm15
	vpsrlw	zmm14, zmm20, 1
	vpermi2b	zmm14, zmm0, zmm1
	vmovdqu64	zmmword ptr [rdi], zmm14
	add	rsi, 448
	add	rdi, 512
	dec	rdx
	jne	612b
	jmp	782f
622:
	test	rdx, rdx
	je	782f
	vpbroadcastd	xmm0, dword ptr [rcx]
	shl	rdx, 5
	xor	eax, eax
	.p2align	4
632:
	vmovdqu	xmm1, xmmword ptr [rsi + rax]
	vmovdqu	xmm2, xmmword ptr [rsi + rax + 16]
	vpermb	xmm3, xmm1, xmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi + 4*rax], xmm3
	vpsrlw	xmm3, xmm1, 2
	vpermb	xmm3, xmm3, xmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi + 4*rax + 16], xmm3
	vpsrlw	xmm3, xmm1, 4
	vpermb	xmm3, xmm3, xmm0
	#APP
	#NO_APP
	vmovdqu	xmmword ptr [rdi + 4*rax + 32], xmm3
	vpsrlw	xmm1, xmm1, 6
	vpermb	xmm1, xmm1, xmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi + 4*rax + 48], xmm1
	vpermb	xmm1, xmm2, xmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi + 4*rax + 64], xmm1
	vpsrlw	xmm1, xmm2, 2
	vpermb	xmm1, xmm1, xmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi + 4*rax + 80], xmm1
	vpsrlw	xmm1, xmm2, 4
	vpermb	xmm1, xmm1, xmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi + 4*rax + 96], xmm1
	vpsrlw	xmm1, xmm2, 6
	vpermb	xmm1, xmm1, xmm0
	#APP
	#NO_APP
	vmovdqu	xmmword ptr [rdi + 4*rax + 112], xmm1
	add	rax, 32
	cmp	rdx, rax
	jne	632b
	jmp	782f
642:
	test	rdx, rdx
	je	782f
	vpbroadcastd	zmm0, dword ptr [rcx]
	shl	rdx, 7
	xor	eax, eax
	.p2align	4
652:
	vmovdqu64	zmm1, zmmword ptr [rsi + rax]
	vmovdqu64	zmm2, zmmword ptr [rsi + rax + 64]
	vpermb	zmm3, zmm1, zmm0
	vmovdqu64	zmmword ptr [rdi + 4*rax], zmm3
	vpsrlw	zmm3, zmm1, 2
	vpermb	zmm3, zmm3, zmm0
	vmovdqu64	zmmword ptr [rdi + 4*rax + 64], zmm3
	vpsrlw	zmm3, zmm1, 4
	vpermb	zmm3, zmm3, zmm0
	vmovdqu64	zmmword ptr [rdi + 4*rax + 128], zmm3
	vpsrlw	zmm1, zmm1, 6
	vpermb	zmm1, zmm1, zmm0
	vmovdqu64	zmmword ptr [rdi + 4*rax + 192], zmm1
	vpermb	zmm1, zmm2, zmm0
	vmovdqu64	zmmword ptr [rdi + 4*rax + 256], zmm1
	vpsrlw	zmm1, zmm2, 2
	vpermb	zmm1, zmm1, zmm0
	vmovdqu64	zmmword ptr [rdi + 4*rax + 320], zmm1
	vpsrlw	zmm1, zmm2, 4
	vpermb	zmm1, zmm1, zmm0
	vmovdqu64	zmmword ptr [rdi + 4*rax + 384], zmm1
	vpsrlw	zmm1, zmm2, 6
	vpermb	zmm1, zmm1, zmm0
	vmovdqu64	zmmword ptr [rdi + 4*rax + 448], zmm1
	sub	rax, -128
	cmp	rdx, rax
	jne	652b
	jmp	782f
662:
	test	rdx, rdx
	je	782f
	vmovdqu	ymm0, ymmword ptr [rcx]
	add	rsi, 64
	add	rdi, 112
	vpbroadcastd	ymm1, dword ptr [rip + 1212f]
	vpbroadcastd	ymm2, dword ptr [rip + 1222f]
	vpbroadcastd	ymm3, dword ptr [rip + 1232f]
	vpbroadcastd	ymm4, dword ptr [rip + 1242f]
	.p2align	4
672:
	vmovdqu	xmm6, xmmword ptr [rsi - 64]
	vmovdqu	xmm7, xmmword ptr [rsi - 48]
	vmovdqu	xmm8, xmmword ptr [rsi - 32]
	vmovdqu	xmm9, xmmword ptr [rsi - 16]
	vmovdqu	xmm5, xmmword ptr [rsi]
	vpermb	ymm10, ymm6, ymm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 112], xmm10
	vpsllw	ymm10, ymm7, 3
	vpsrlw	ymm6, ymm6, 5
	vpternlogd	ymm6, ymm10, ymm1, 216
	vpermb	ymm6, ymm6, ymm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 96], xmm6
	vpsrlw	ymm6, ymm7, 2
	vpermb	ymm6, ymm6, ymm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 80], xmm6
	vpaddw	ymm6, ymm8, ymm8
	vpsrlw	ymm7, ymm7, 7
	vpternlogd	ymm7, ymm6, ymm2, 216
	vpermb	ymm6, ymm7, ymm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 64], xmm6
	vpsllw	ymm6, ymm9, 4
	vpsrlw	ymm7, ymm8, 4
	vpternlogd	ymm7, ymm6, ymm3, 216
	vpermb	ymm6, ymm7, ymm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 48], xmm6
	vpsrlw	ymm6, ymm9, 1
	vpermb	ymm6, ymm6, ymm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 32], xmm6
	vpsllw	ymm6, ymm5, 2
	vpsrlw	ymm7, ymm9, 6
	vpternlogd	ymm7, ymm6, ymm4, 216
	vpermb	ymm6, ymm7, ymm0
	#APP
	#NO_APP
	vmovdqu	xmmword ptr [rdi - 16], xmm6
	vpsrlw	ymm5, ymm5, 3
	vpermb	ymm5, ymm5, ymm0
	#APP
	#NO_APP
	vmovdqu	xmmword ptr [rdi], xmm5
	add	rsi, 80
	sub	rdi, -128
	dec	rdx
	jne	672b
	jmp	782f
682:
	test	rdx, rdx
	je	782f
	vmovdqu64	zmm0, zmmword ptr [rcx]
	vshufi64x2	zmm0, zmm0, zmm0, 68
	add	rsi, 256
	add	rdi, 448
	vpbroadcastb	zmm1, byte ptr [rip + 1142f]
	vpbroadcastb	zmm2, byte ptr [rip + 1252f]
	vpbroadcastb	zmm3, byte ptr [rip + 1262f]
	vpbroadcastb	zmm4, byte ptr [rip + 1102f]
	vpbroadcastb	zmm5, byte ptr [rip + 1272f]
	vpbroadcastb	zmm6, byte ptr [rip + 1162f]
	vpbroadcastb	zmm7, byte ptr [rip + 1282f]
	vpbroadcastb	zmm8, byte ptr [rip + 1122f]
	.p2align	4
692:
	vmovdqu64	zmm9, zmmword ptr [rsi - 256]
	vmovdqu64	zmm10, zmmword ptr [rsi - 192]
	vmovdqu64	zmm11, zmmword ptr [rsi - 128]
	vmovdqu64	zmm12, zmmword ptr [rsi - 64]
	vmovdqu64	zmm13, zmmword ptr [rsi]
	vpermb	zmm14, zmm9, zmm0
	vmovdqu64	zmmword ptr [rdi - 448], zmm14
	vpsrlw	zmm9, zmm9, 5
	vpandq	zmm9, zmm9, zmm1
	vpsllw	zmm14, zmm10, 3
	vpternlogq	zmm14, zmm9, zmm2, 236
	vpermb	zmm9, zmm14, zmm0
	vmovdqu64	zmmword ptr [rdi - 384], zmm9
	vpsrlw	zmm9, zmm10, 2
	vpermb	zmm9, zmm9, zmm0
	vmovdqu64	zmmword ptr [rdi - 320], zmm9
	vpsrlw	zmm9, zmm10, 7
	vpaddw	zmm10, zmm11, zmm11
	vpandq	zmm10, zmm10, zmm3
	vpternlogq	zmm10, zmm9, zmm4, 248
	vpermb	zmm9, zmm10, zmm0
	vmovdqu64	zmmword ptr [rdi - 256], zmm9
	vpsrlw	zmm9, zmm11, 4
	vpsllw	zmm10, zmm12, 4
	vpandq	zmm10, zmm10, zmm5
	vpternlogq	zmm10, zmm9, zmm6, 248
	vpermb	zmm9, zmm10, zmm0
	vmovdqu64	zmmword ptr [rdi - 192], zmm9
	vpsrlw	zmm9, zmm12, 1
	vpermb	zmm9, zmm9, zmm0
	vmovdqu64	zmmword ptr [rdi - 128], zmm9
	vpsrlw	zmm9, zmm12, 6
	vpsllw	zmm10, zmm13, 2
	vpandq	zmm10, zmm10, zmm7
	vpternlogq	zmm10, zmm9, zmm8, 248
	vpermb	zmm9, zmm10, zmm0
	vmovdqu64	zmmword ptr [rdi - 64], zmm9
	vpsrlw	zmm9, zmm13, 3
	vpermb	zmm9, zmm9, zmm0
	vmovdqu64	zmmword ptr [rdi], zmm9
	add	rsi, 320
	add	rdi, 512
	dec	rdx
	jne	692b
	jmp	782f
702:
	test	rdx, rdx
	je	782f
	vpbroadcastq	xmm0, qword ptr [rcx]
	add	rsi, 32
	add	rdi, 112
	vpbroadcastd	xmm1, dword ptr [rip + 1242f]
	vpbroadcastd	xmm2, dword ptr [rip + 1222f]
	.p2align	4
712:
	vmovdqu	xmm3, xmmword ptr [rsi - 32]
	vmovdqu	xmm4, xmmword ptr [rsi - 16]
	vmovdqu	xmm5, xmmword ptr [rsi]
	vpermb	xmm6, xmm3, xmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 112], xmm6
	vpsrlw	xmm6, xmm3, 3
	vpermb	xmm6, xmm6, xmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 96], xmm6
	vpsllw	xmm6, xmm4, 2
	vpsrlw	xmm3, xmm3, 6
	vpternlogd	xmm3, xmm6, xmm1, 216
	vpermb	xmm3, xmm3, xmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 80], xmm3
	vpsrlw	xmm3, xmm4, 1
	vpermb	xmm3, xmm3, xmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 64], xmm3
	vpsrlw	xmm3, xmm4, 4
	vpermb	xmm3, xmm3, xmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 48], xmm3
	vpaddw	xmm3, xmm5, xmm5
	vpsrlw	xmm4, xmm4, 7
	vpternlogd	xmm4, xmm3, xmm2, 216
	vpermb	xmm3, xmm4, xmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 32], xmm3
	vpsrlw	xmm3, xmm5, 2
	vpermb	xmm3, xmm3, xmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 16], xmm3
	vpsrlw	xmm3, xmm5, 5
	vpermb	xmm3, xmm3, xmm0
	#APP
	#NO_APP
	vmovdqu	xmmword ptr [rdi], xmm3
	add	rsi, 48
	sub	rdi, -128
	dec	rdx
	jne	712b
	jmp	782f
722:
	test	rdx, rdx
	je	782f
	vpbroadcastq	zmm0, qword ptr [rcx]
	sub	rsi, -128
	add	rdi, 448
	vpbroadcastb	zmm1, byte ptr [rip + 1122f]
	vpbroadcastb	zmm2, byte ptr [rip + 1282f]
	vpbroadcastb	zmm3, byte ptr [rip + 1262f]
	vpbroadcastb	zmm4, byte ptr [rip + 1102f]
	.p2align	4
732:
	vmovdqu64	zmm5, zmmword ptr [rsi - 128]
	vmovdqu64	zmm6, zmmword ptr [rsi - 64]
	vmovdqu64	zmm7, zmmword ptr [rsi]
	vpermb	zmm8, zmm5, zmm0
	vmovdqu64	zmmword ptr [rdi - 448], zmm8
	vpsrlw	zmm8, zmm5, 3
	vpermb	zmm8, zmm8, zmm0
	vmovdqu64	zmmword ptr [rdi - 384], zmm8
	vpsrlw	zmm5, zmm5, 6
	vpandq	zmm5, zmm5, zmm1
	vpsllw	zmm8, zmm6, 2
	vpternlogq	zmm8, zmm5, zmm2, 236
	vpermb	zmm5, zmm8, zmm0
	vmovdqu64	zmmword ptr [rdi - 320], zmm5
	vpsrlw	zmm5, zmm6, 1
	vpermb	zmm5, zmm5, zmm0
	vmovdqu64	zmmword ptr [rdi - 256], zmm5
	vpsrlw	zmm5, zmm6, 4
	vpermb	zmm5, zmm5, zmm0
	vmovdqu64	zmmword ptr [rdi - 192], zmm5
	vpsrlw	zmm5, zmm6, 7
	vpaddw	zmm6, zmm7, zmm7
	vpandq	zmm6, zmm6, zmm3
	vpternlogq	zmm6, zmm5, zmm4, 248
	vpermb	zmm5, zmm6, zmm0
	vmovdqu64	zmmword ptr [rdi - 128], zmm5
	vpsrlw	zmm5, zmm7, 2
	vpermb	zmm5, zmm5, zmm0
	vmovdqu64	zmmword ptr [rdi - 64], zmm5
	vpsrlw	zmm5, zmm7, 5
	vpermb	zmm5, zmm5, zmm0
	vmovdqu64	zmmword ptr [rdi], zmm5
	add	rsi, 192
	add	rdi, 512
	dec	rdx
	jne	732b
	jmp	782f
742:
	test	rdx, rdx
	je	782f
	vmovdqu64	zmm0, zmmword ptr [rcx]
	add	rsi, 80
	add	rdi, 112
	vpbroadcastb	zmm1, byte ptr [rip + 1122f]
	vpbroadcastb	zmm2, byte ptr [rip + 1282f]
	vpbroadcastb	zmm3, byte ptr [rip + 1162f]
	vpbroadcastb	zmm4, byte ptr [rip + 1272f]
	.p2align	4
752:
	vmovdqu	xmm5, xmmword ptr [rsi - 80]
	vmovdqu	xmm6, xmmword ptr [rsi - 64]
	vmovdqu	xmm7, xmmword ptr [rsi - 48]
	vmovdqu	xmm8, xmmword ptr [rsi - 32]
	vmovdqu	xmm9, xmmword ptr [rsi - 16]
	vmovdqu	xmm10, xmmword ptr [rsi]
	vpermb	zmm11, zmm5, zmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 112], xmm11
	vpsrlw	zmm5, zmm5, 6
	vpsllw	zmm11, zmm6, 2
	vpandq	zmm11, zmm11, zmm2
	vpternlogq	zmm11, zmm5, zmm1, 248
	vpermb	zmm5, zmm11, zmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 96], xmm5
	vpsrlw	zmm5, zmm6, 4
	vpsllw	zmm6, zmm7, 4
	vpandq	zmm6, zmm6, zmm4
	vpternlogq	zmm6, zmm5, zmm3, 248
	vpermb	zmm5, zmm6, zmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 80], xmm5
	vpsrlw	zmm5, zmm7, 2
	vpermb	zmm5, zmm5, zmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 64], xmm5
	vpermb	zmm5, zmm8, zmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 48], xmm5
	vpsrlw	zmm5, zmm8, 6
	vpsllw	zmm6, zmm9, 2
	vpandq	zmm6, zmm6, zmm2
	vpternlogq	zmm6, zmm5, zmm1, 248
	vpermb	zmm5, zmm6, zmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 32], xmm5
	vpsrlw	zmm5, zmm9, 4
	vpsllw	zmm6, zmm10, 4
	vpandq	zmm6, zmm6, zmm4
	vpternlogq	zmm6, zmm5, zmm3, 248
	vpermb	zmm5, zmm6, zmm0
	#APP
	#NO_APP
	vmovups	xmmword ptr [rdi - 16], xmm5
	vpsrlw	zmm5, zmm10, 2
	vpermb	zmm5, zmm5, zmm0
	#APP
	#NO_APP
	vmovdqu	xmmword ptr [rdi], xmm5
	add	rsi, 96
	sub	rdi, -128
	dec	rdx
	jne	752b
	jmp	782f
762:
	test	rdx, rdx
	je	782f
	vmovdqu64	zmm0, zmmword ptr [rcx]
	add	rsi, 320
	add	rdi, 448
	vpbroadcastb	zmm1, byte ptr [rip + 1122f]
	vpbroadcastb	zmm2, byte ptr [rip + 1282f]
	vpbroadcastb	zmm3, byte ptr [rip + 1162f]
	vpbroadcastb	zmm4, byte ptr [rip + 1272f]
	.p2align	4
772:
	vmovdqu64	zmm5, zmmword ptr [rsi - 320]
	vmovdqu64	zmm6, zmmword ptr [rsi - 256]
	vmovdqu64	zmm7, zmmword ptr [rsi - 192]
	vmovdqu64	zmm8, zmmword ptr [rsi - 128]
	vmovdqu64	zmm9, zmmword ptr [rsi - 64]
	vmovdqu64	zmm10, zmmword ptr [rsi]
	vpermb	zmm11, zmm5, zmm0
	vmovdqu64	zmmword ptr [rdi - 448], zmm11
	vpsrlw	zmm5, zmm5, 6
	vpsllw	zmm11, zmm6, 2
	vpandq	zmm5, zmm5, zmm1
	vpternlogq	zmm5, zmm11, zmm2, 248
	vpermb	zmm5, zmm5, zmm0
	vmovdqu64	zmmword ptr [rdi - 384], zmm5
	vpsrlw	zmm5, zmm6, 4
	vpsllw	zmm6, zmm7, 4
	vpandq	zmm6, zmm6, zmm4
	vpternlogq	zmm6, zmm5, zmm3, 248
	vpermb	zmm5, zmm6, zmm0
	vmovdqu64	zmmword ptr [rdi - 320], zmm5
	vpsrlw	zmm5, zmm7, 2
	vpermb	zmm5, zmm5, zmm0
	vmovdqu64	zmmword ptr [rdi - 256], zmm5
	vpermb	zmm5, zmm8, zmm0
	vmovdqu64	zmmword ptr [rdi - 192], zmm5
	vpsrlw	zmm5, zmm8, 6
	vpsllw	zmm6, zmm9, 2
	vpandq	zmm5, zmm5, zmm1
	vpternlogq	zmm5, zmm6, zmm2, 248
	vpermb	zmm5, zmm5, zmm0
	vmovdqu64	zmmword ptr [rdi - 128], zmm5
	vpsrlw	zmm5, zmm9, 4
	vpsllw	zmm6, zmm10, 4
	vpandq	zmm6, zmm6, zmm4
	vpternlogq	zmm6, zmm5, zmm3, 248
	vpermb	zmm5, zmm6, zmm0
	vmovdqu64	zmmword ptr [rdi - 64], zmm5
	vpsrlw	zmm5, zmm10, 2
	vpermb	zmm5, zmm5, zmm0
	vmovdqu64	zmmword ptr [rdi], zmm5
	add	rsi, 384
	add	rdi, 512
	dec	rdx
	jne	772b
782:
	vzeroupper
	ret
	.p2align	4
792:
	vpbroadcastb	zmm0, r8d
	mov	r8, rsi
	shr	r8, 6
	je	822f
	shl	r8, 3
	xor	eax, eax
	xor	r9d, r9d
	.p2align	4
802:
	mov	r10, rax
	mov	r11, qword ptr [rdx + r9]
	popcnt	rax, r11
	kmovq	k1, r11
	vmovups	zmm1, zmmword ptr [rcx + r10]
	#APP
	#NO_APP
	vmovdqa64	zmm2, zmm0
	vpexpandb	zmm2 {k1}, zmm1
	vmovdqu64	zmmword ptr [rdi + 8*r9], zmm2
	add	rax, r10
	add	r9, 8
	cmp	r8, r9
	jne	802b
	mov	r8, rsi
	and	r8, 63
	jne	832f
812:
	vzeroupper
	ret
822:
	xor	eax, eax
	mov	r8, rsi
	and	r8, 63
	je	812b
832:
	and	esi, -64
	mov	r9d, esi
	shr	r9d, 3
	add	rdx, r9
	lea	r9d, [r8 + 7]
	shr	r9d, 3
	cmp	r8, 25
	jb	842f
	mov	r10d, dword ptr [rdx]
	mov	edx, dword ptr [rdx + r9 - 4]
	add	r9, -4
	jmp	852f
842:
	cmp	r8d, 9
	jb	862f
	movzx	r10d, word ptr [rdx]
	movzx	edx, word ptr [rdx + r9 - 2]
	add	r9, -2
852:
	shl	r9d, 3
	shlx	rdx, rdx, r9
	or	rdx, r10
	jmp	872f
862:
	movzx	edx, byte ptr [rdx]
872:
	bzhi	rdx, rdx, r8
	popcnt	r9, rdx
	kmovq	k1, rdx
	vmovups	zmm1, zmmword ptr [rcx + rax]
	#APP
	#NO_APP
	vpexpandb	zmm0 {k1}, zmm1
	mov	rcx, -1
	bzhi	rcx, rcx, r8
	kmovq	k1, rcx
	vmovdqu8	zmmword ptr [rdi + rsi] {k1}, zmm0
	add	rax, r9
	vzeroupper
	ret
	.p2align	4
882:
	push	r14
	push	rbx
	mov	r10, rsi
	shr	r10, 6
	je	912f
	shl	r10, 3
	xor	eax, eax
	xor	r11d, r11d
	xor	r9d, r9d
	.p2align	4
892:
	mov	rbx, qword ptr [rdx + r11]
	popcnt	r14, rbx
	kmovq	k1, rbx
	vmovups	zmm0, zmmword ptr [r8 + rax]
	#APP
	#NO_APP
	knotq	k2, k1
	vmovups	zmm1, zmmword ptr [rcx + r9]
	#APP
	#NO_APP
	vxorps	xmm2, xmm2, xmm2
	#APP
	#NO_APP
	vpexpandb	zmm2 {k2}, zmm1
	vpexpandb	zmm2 {k1}, zmm0
	vmovdqu64	zmmword ptr [rdi + 8*r11], zmm2
	add	rax, r14
	sub	r9, r14
	add	r9, 64
	add	r11, 8
	cmp	r10, r11
	jne	892b
	mov	r10, rsi
	and	r10, 63
	jne	922f
902:
	pop	rbx
	pop	r14
	vzeroupper
	ret
912:
	xor	r9d, r9d
	xor	eax, eax
	mov	r10, rsi
	and	r10, 63
	je	902b
922:
	and	esi, -64
	mov	r11d, esi
	shr	r11d, 3
	add	rdx, r11
	lea	r11d, [r10 + 7]
	shr	r11d, 3
	cmp	r10, 25
	jb	932f
	mov	ebx, dword ptr [rdx]
	mov	edx, dword ptr [rdx + r11 - 4]
	add	r11, -4
	jmp	942f
932:
	cmp	r10d, 9
	jb	952f
	movzx	ebx, word ptr [rdx]
	movzx	edx, word ptr [rdx + r11 - 2]
	add	r11, -2
942:
	shl	r11d, 3
	shlx	rdx, rdx, r11
	or	rdx, rbx
	jmp	962f
952:
	movzx	edx, byte ptr [rdx]
962:
	bzhi	rdx, rdx, r10
	popcnt	r11, rdx
	kmovq	k1, rdx
	vmovups	zmm0, zmmword ptr [r8 + rax]
	#APP
	#NO_APP
	knotq	k2, k1
	vmovups	zmm1, zmmword ptr [rcx + r9]
	#APP
	#NO_APP
	vpxor	xmm2, xmm2, xmm2
	#APP
	#NO_APP
	vpexpandb	zmm2 {k2}, zmm1
	vpexpandb	zmm2 {k1}, zmm0
	mov	rcx, -1
	bzhi	rcx, rcx, r10
	kmovq	k1, rcx
	vmovdqu8	zmmword ptr [rdi + rsi] {k1}, zmm2
	add	rax, r11
	pop	rbx
	pop	r14
	vzeroupper
	ret
	.p2align	6, 0x0
972:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	14
	.byte	15
	.byte	16
	.byte	17
	.byte	15
	.byte	16
	.byte	17
	.byte	18
	.byte	19
	.byte	20
	.byte	21
	.byte	22
	.byte	20
	.byte	21
	.byte	22
	.byte	23
	.byte	24
	.byte	25
	.byte	26
	.byte	27
	.byte	25
	.byte	26
	.byte	27
	.byte	28
	.byte	29
	.byte	30
	.byte	31
	.byte	32
	.byte	30
	.byte	31
	.byte	32
	.byte	33
	.byte	34
	.byte	35
	.byte	36
	.byte	37
	.byte	35
	.byte	36
	.byte	37
	.byte	38
	.byte	39
	.byte	40
	.byte	41
	.byte	42
	.p2align	3, 0x0
982:
	.byte	0
	.byte	5
	.byte	10
	.byte	15
	.byte	20
	.byte	25
	.byte	30
	.byte	35
	.p2align	6, 0x0
992:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	14
	.byte	15
	.byte	16
	.byte	12
	.byte	13
	.byte	14
	.byte	15
	.byte	16
	.byte	17
	.byte	18
	.byte	19
	.byte	15
	.byte	16
	.byte	17
	.byte	18
	.byte	19
	.byte	20
	.byte	21
	.byte	22
	.byte	18
	.byte	19
	.byte	20
	.byte	21
	.byte	22
	.byte	23
	.byte	24
	.byte	25
	.byte	21
	.byte	22
	.byte	23
	.byte	24
	.byte	25
	.byte	26
	.byte	27
	.byte	28
	.p2align	3, 0x0
1002:
	.byte	0
	.byte	3
	.byte	6
	.byte	9
	.byte	12
	.byte	15
	.byte	18
	.byte	21
	.p2align	6, 0x0
1012:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	14
	.byte	14
	.byte	15
	.byte	16
	.byte	17
	.byte	18
	.byte	19
	.byte	20
	.byte	21
	.byte	21
	.byte	22
	.byte	23
	.byte	24
	.byte	25
	.byte	26
	.byte	27
	.byte	28
	.byte	28
	.byte	29
	.byte	30
	.byte	31
	.byte	32
	.byte	33
	.byte	34
	.byte	35
	.byte	35
	.byte	36
	.byte	37
	.byte	38
	.byte	39
	.byte	40
	.byte	41
	.byte	42
	.byte	42
	.byte	43
	.byte	44
	.byte	45
	.byte	46
	.byte	47
	.byte	48
	.byte	49
	.byte	49
	.byte	50
	.byte	51
	.byte	52
	.byte	53
	.byte	54
	.byte	55
	.byte	56
	.p2align	3, 0x0
1022:
	.byte	0
	.byte	7
	.byte	14
	.byte	21
	.byte	28
	.byte	35
	.byte	42
	.byte	49
	.p2align	6, 0x0
1032:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	14
	.byte	15
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	14
	.byte	15
	.byte	16
	.byte	17
	.byte	12
	.byte	13
	.byte	14
	.byte	15
	.byte	16
	.byte	17
	.byte	18
	.byte	19
	.byte	14
	.byte	15
	.byte	16
	.byte	17
	.byte	18
	.byte	19
	.byte	20
	.byte	21
	.p2align	3, 0x0
1042:
	.byte	0
	.byte	2
	.byte	4
	.byte	6
	.byte	8
	.byte	10
	.byte	12
	.byte	14
	.p2align	6, 0x0
1052:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	14
	.byte	15
	.byte	12
	.byte	13
	.byte	14
	.byte	15
	.byte	16
	.byte	17
	.byte	18
	.byte	19
	.byte	16
	.byte	17
	.byte	18
	.byte	19
	.byte	20
	.byte	21
	.byte	22
	.byte	23
	.byte	20
	.byte	21
	.byte	22
	.byte	23
	.byte	24
	.byte	25
	.byte	26
	.byte	27
	.byte	24
	.byte	25
	.byte	26
	.byte	27
	.byte	28
	.byte	29
	.byte	30
	.byte	31
	.byte	28
	.byte	29
	.byte	30
	.byte	31
	.byte	32
	.byte	33
	.byte	34
	.byte	35
	.p2align	3, 0x0
1062:
	.byte	0
	.byte	4
	.byte	8
	.byte	12
	.byte	16
	.byte	20
	.byte	24
	.byte	28
	.p2align	6, 0x0
1072:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	12
	.byte	13
	.byte	14
	.byte	15
	.byte	16
	.byte	17
	.byte	18
	.byte	19
	.byte	18
	.byte	19
	.byte	20
	.byte	21
	.byte	22
	.byte	23
	.byte	24
	.byte	25
	.byte	24
	.byte	25
	.byte	26
	.byte	27
	.byte	28
	.byte	29
	.byte	30
	.byte	31
	.byte	30
	.byte	31
	.byte	32
	.byte	33
	.byte	34
	.byte	35
	.byte	36
	.byte	37
	.byte	36
	.byte	37
	.byte	38
	.byte	39
	.byte	40
	.byte	41
	.byte	42
	.byte	43
	.byte	42
	.byte	43
	.byte	44
	.byte	45
	.byte	46
	.byte	47
	.byte	48
	.byte	49
	.p2align	3, 0x0
1082:
	.byte	0
	.byte	6
	.byte	12
	.byte	18
	.byte	24
	.byte	30
	.byte	36
	.byte	42
	.p2align	6, 0x0
1092:
	.byte	126
	.p2align	6, 0x0
1102:
	.byte	1
	.p2align	6, 0x0
1112:
	.byte	124
	.p2align	6, 0x0
1122:
	.byte	3
	.p2align	6, 0x0
1132:
	.byte	120
	.p2align	6, 0x0
1142:
	.byte	7
	.p2align	6, 0x0
1152:
	.byte	112
	.p2align	6, 0x0
1162:
	.byte	15
	.p2align	6, 0x0
1172:
	.byte	96
	.p2align	6, 0x0
1182:
	.byte	31
	.p2align	6, 0x0
1192:
	.byte	64
	.p2align	6, 0x0
1202:
	.byte	63
	.p2align	2, 0x0
1212:
	.long	4177066232
	.p2align	2, 0x0
1222:
	.long	4278124286
	.p2align	2, 0x0
1232:
	.long	4042322160
	.p2align	2, 0x0
1242:
	.long	4244438268
	.p2align	6, 0x0
1252:
	.byte	56
	.p2align	6, 0x0
1262:
	.byte	62
	.p2align	6, 0x0
1272:
	.byte	48
	.p2align	6, 0x0
1282:
	.byte	60

# minlz_exec_plain of crates/minlz/mlir/exec64.mlir for avx512, written by
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
	mov	qword ptr [rsp + 88], rax
	add	rsi, rax
	test	r8, r8
	jle	562f
	lea	r10, [rdi + 512]
	mov	eax, 192
	mov	qword ptr [rsp + 56], rax
	mov	eax, 7
	mov	qword ptr [rsp + 40], rax
	mov	qword ptr [rsp + 64], 0
	vmovdqa64	zmm0, zmmword ptr [rip + 572f]
	vpbroadcastb	zmm1, byte ptr [rip + 582f]
	vpbroadcastb	zmm2, byte ptr [rip + 592f]
	vpbroadcastd	zmm3, dword ptr [rip + 602f]
	vpternlogd	zmm4, zmm4, zmm4, 255
	vpbroadcastd	zmm5, dword ptr [rip + 612f]
	vpbroadcastd	zmm6, dword ptr [rip + 622f]
	vpxor	xmm7, xmm7, xmm7
	vbroadcasti32x4	zmm8, xmmword ptr [rip + 632f]
	vpbroadcastd	zmm9, dword ptr [rip + 642f]
	vmovdqa64	zmm10, zmmword ptr [rip + 652f]
	vpbroadcastd	zmm11, dword ptr [rip + 662f]
	mov	r9, r10
	mov	rbp, r8
	xor	eax, eax
	mov	qword ptr [rsp + 96], r8
	jmp	12f
	.p2align	4
2:
	mov	rbp, qword ptr [rsp + 136]
	add	rbp, -64
	inc	qword ptr [rsp + 64]
	add	qword ptr [rsp + 56], 64
	add	qword ptr [rsp + 40], -64
	mov	r9, qword ptr [rsp + 80]
	add	r9, -64
	mov	r8, qword ptr [rsp + 96]
	mov	rax, qword ptr [rsp + 128]
	cmp	rax, r8
	lea	r10, [rdi + 512]
	jge	562f
12:
	mov	qword ptr [rsp + 80], r9
	cmp	rbp, 1
	mov	qword ptr [rsp + 136], rbp
	adc	rbp, 0
	cmp	rbp, 64
	mov	r9d, 64
	cmovae	rbp, r9
	sub	r8, rax
	cmp	r8, 64
	mov	r14d, 64
	mov	qword ptr [rsp + 48], r8
	cmovb	r14, r8
	mov	r13, qword ptr [rdi + 16]
	mov	r8, qword ptr [rdi + 24]
	mov	qword ptr [rsp + 104], r8
	mov	r8, qword ptr [rdi + 32]
	mov	qword ptr [rsp + 112], r8
	mov	r8, qword ptr [rdi + 40]
	mov	qword ptr [rsp], r8
	mov	r12, qword ptr [rdi + 64]
	mov	r8, qword ptr [rdi + 72]
	mov	qword ptr [rsp + 32], r8
	mov	r8, qword ptr [rdi + 96]
	mov	qword ptr [rsp + 120], r8
	mov	r8, qword ptr [rdi + 112]
	mov	qword ptr [rsp + 8], r8
	mov	rbx, qword ptr [rdi + 128]
	mov	r8, qword ptr [rdi + 136]
	mov	qword ptr [rsp + 16], r8
	lea	r15, [r12 + 7]
	lea	r8, [rax + 64]
	mov	qword ptr [rsp + 128], r8
	cmp	r8, r15
	mov	qword ptr [rsp + 72], rbx
	jbe	52f
	cmp	rax, r15
	mov	r8, r10
	jge	62f
	mov	r8, qword ptr [rsp + 64]
	shl	r8, 6
	mov	r11d, 7
	sub	r11, r8
	add	r11, r12
	cmp	r11, 16
	jb	22f
	add	r8, r13
	mov	r9, rdi
	sub	r9, r8
	add	r9, 511
	cmp	r9, 255
	jae	82f
22:
	mov	r9, rax
32:
	mov	r8, qword ptr [rsp + 80]
	.p2align	4
42:
	movzx	eax, byte ptr [r13 + r9]
	mov	byte ptr [r8 + r9], al
	inc	r9
	cmp	r15, r9
	jne	42b
	mov	r8, r10
	jmp	62f
	.p2align	4
52:
	add	r13, rax
	mov	r8, r13
62:
	vmovdqu64	zmm13, zmmword ptr [r8]
	vpbroadcastb	zmm12, r14d
	vpcmpnleub	k2, zmm12, zmm0
	vptestmb	k1 {k2}, zmm13, zmm1
	vptestnmb	k2 {k2}, zmm13, zmm2
	mov	rax, qword ptr [rsp + 104]
	vpexpandb	zmm12 {k1} {z}, zmmword ptr [rax + rbx]
	vmovdqu64	zmmword ptr [rdi + 192], zmm12
	mov	r10, qword ptr [rsp + 16]
	mov	rax, qword ptr [rsp + 112]
	vpexpandb	zmm12 {k2} {z}, zmmword ptr [rax + r10]
	vmovdqu64	zmmword ptr [rdi + 512], zmm13
	mov	r8, qword ptr [rsp + 32]
	mov	r9, r8
	shr	r9, 3
	lea	rax, [r9 + 64]
	mov	r11, qword ptr [rsp + 8]
	cmp	rax, r11
	jbe	72f
	sub	r11, r9
	lea	r13, [rdi + 576]
	mov	r15, r13
	mov	r12, qword ptr [rsp]
	jbe	152f
	cmp	r11, 16
	mov	rbx, r9
	jb	132f
	lea	r14, [r9 + r12]
	mov	rax, rdi
	sub	rax, r14
	add	rax, 575
	cmp	rax, 255
	mov	rbx, r9
	jb	132f
	cmp	r11, 256
	jae	92f
	xor	eax, eax
	jmp	112f
	.p2align	4
72:
	mov	r12, qword ptr [rsp]
	add	r9, r12
	mov	r15, r9
	lea	r13, [rdi + 576]
	jmp	152f
82:
	cmp	r11, 256
	mov	qword ptr [rsp + 24], r11
	jae	172f
	xor	r11d, r11d
	jmp	192f
92:
	mov	rax, r11
	and	rax, -256
	lea	rbx, [r9 + rax]
	lea	r8, [r12 + r9 + 192]
	xor	r10d, r10d
	.p2align	4
102:
	vmovdqu64	zmm13, zmmword ptr [r8 + r10 - 192]
	vmovdqu64	zmm14, zmmword ptr [r8 + r10 - 128]
	vmovdqu64	zmm15, zmmword ptr [r8 + r10 - 64]
	vmovdqu64	zmm16, zmmword ptr [r8 + r10]
	vmovdqu64	zmmword ptr [rdi + r10 + 576], zmm13
	vmovdqu64	zmmword ptr [rdi + r10 + 640], zmm14
	vmovdqu64	zmmword ptr [rdi + r10 + 704], zmm15
	vmovdqu64	zmmword ptr [rdi + r10 + 768], zmm16
	add	r10, 256
	cmp	rax, r10
	jne	102b
	cmp	r11, rax
	mov	r15, r13
	mov	r10, qword ptr [rsp + 16]
	mov	r8, qword ptr [rsp + 32]
	je	152f
	test	r11b, -16
	je	132f
112:
	mov	r8, r11
	and	r8, -16
	lea	rbx, [r9 + r8]
	.p2align	4
122:
	vmovdqu	xmm13, xmmword ptr [r14 + rax]
	vmovdqu	xmmword ptr [r13 + rax], xmm13
	add	rax, 16
	cmp	r8, rax
	jne	122b
	cmp	r11, r8
	mov	r15, r13
	mov	r8, qword ptr [rsp + 32]
	je	152f
	.p2align	4
132:
	mov	rax, r13
	sub	rax, r9
	mov	r9, qword ptr [rsp + 8]
	.p2align	4
142:
	movzx	r8d, byte ptr [r12 + rbx]
	mov	byte ptr [rax + rbx], r8b
	inc	rbx
	cmp	r9, rbx
	jne	142b
	mov	r15, r13
	mov	r8, qword ptr [rsp + 32]
152:
	mov	rax, qword ptr [rsp + 120]
	vpbroadcastd	zmm14, eax
	vpmovzxbd	zmm13, xmm12
	vpsrld	zmm15, zmm13, 3
	vpmaxud	zmm15, zmm15, zmm3
	vpaddd	zmm15, zmm15, zmm4
	vpminud	zmm16, zmm13, zmm6
	vpandd	zmm16, zmm16, zmm6
	vpternlogd	zmm16, zmm13, zmm5, 248
	vpsllvd	zmm13, zmm16, zmm15
	vpsllvd	zmm16, zmm4, zmm15
	valignd	zmm17, zmm15, zmm7, 15
	vpaddd	zmm17, zmm17, zmm15
	valignq	zmm18, zmm17, zmm7, 7
	vpaddd	zmm17, zmm18, zmm17
	valignq	zmm18, zmm17, zmm7, 6
	vpaddd	zmm17, zmm18, zmm17
	valignq	zmm18, zmm17, zmm7, 4
	vpaddd	zmm17, zmm18, zmm17
	vpsubd	zmm15, zmm17, zmm15
	mov	eax, r8d
	and	eax, 7
	vpbroadcastd	zmm18, eax
	vpaddd	zmm15, zmm15, zmm18
	vpsrld	zmm18, zmm15, 3
	vpandd	zmm15, zmm15, zmm5
	vpshufb	zmm18, zmm18, zmm8
	vpaddb	zmm18, zmm18, zmm9
	vpermb	zmm18, zmm18, zmmword ptr [r15]
	vpsrlvd	zmm15, zmm18, zmm15
	vpandnd	zmm15, zmm16, zmm15
	vpaddd	zmm13, zmm15, zmm13
	vptestmd	k3, zmm13, zmm13
	vpord	zmm13 {k3} {z}, zmm13, zmm10
	valignd	zmm15, zmm13, zmm7, 15
	vpmaxud	zmm13, zmm13, zmm15
	valignq	zmm15, zmm13, zmm7, 7
	vpmaxud	zmm13, zmm13, zmm15
	valignq	zmm15, zmm13, zmm7, 6
	vpmaxud	zmm13, zmm13, zmm15
	valignq	zmm15, zmm13, zmm7, 4
	vpmaxud	zmm13, zmm13, zmm15
	vptestmd	k3, zmm13, zmm13
	vpandd	zmm14 {k3}, zmm13, zmm11
	vpshufd	zmm13, zmm14, 255
	vshufi64x2	zmm13, zmm13, zmm13, 255
	vextracti32x4	xmm15, zmm17, 3
	vpextrd	r9d, xmm15, 3
	add	r9, r8
	vmovdqu64	zmmword ptr [rdi + 256], zmm14
	cmp	qword ptr [rsp + 48], 17
	jb	442f
	mov	rax, r9
	shr	rax, 3
	lea	r8, [rax + 64]
	mov	r11, qword ptr [rsp + 8]
	cmp	r8, r11
	jbe	162f
	sub	r11, rax
	mov	r12, r13
	jbe	272f
	cmp	r11, 16
	mov	rbx, rax
	jb	252f
	mov	r8, qword ptr [rsp]
	lea	r14, [rax + r8]
	mov	r8, rdi
	sub	r8, r14
	add	r8, 575
	cmp	r8, 255
	mov	rbx, rax
	jb	252f
	cmp	r11, 256
	jae	212f
	xor	r15d, r15d
	jmp	232f
	.p2align	4
162:
	add	rax, r12
	mov	r12, rax
	jmp	272f
172:
	and	r11, -256
	lea	r9, [rax + r11]
	mov	r8, qword ptr [rsp + 56]
	lea	rbx, [r13 + r8]
	mov	r8, qword ptr [rsp + 40]
	add	r8, r12
	and	r8, -256
	xor	r10d, r10d
	.p2align	4
182:
	vmovdqu64	zmm12, zmmword ptr [rbx + r10 - 192]
	vmovdqu64	zmm13, zmmword ptr [rbx + r10 - 128]
	vmovdqu64	zmm14, zmmword ptr [rbx + r10 - 64]
	vmovdqu64	zmm15, zmmword ptr [rbx + r10]
	vmovdqu64	zmmword ptr [rdi + r10 + 512], zmm12
	vmovdqu64	zmmword ptr [rdi + r10 + 576], zmm13
	vmovdqu64	zmmword ptr [rdi + r10 + 640], zmm14
	vmovdqu64	zmmword ptr [rdi + r10 + 704], zmm15
	add	r10, 256
	cmp	r8, r10
	jne	182b
	cmp	qword ptr [rsp + 24], r11
	lea	r10, [rdi + 512]
	mov	r8, r10
	mov	rbx, qword ptr [rsp + 72]
	je	62b
	test	byte ptr [rsp + 24], -16
	je	32b
192:
	mov	r9, qword ptr [rsp + 24]
	and	r9, -16
	lea	r8, [r13 + rax]
	add	rax, r9
	add	r12, qword ptr [rsp + 40]
	and	r12, -16
	.p2align	4
202:
	vmovdqu	xmm12, xmmword ptr [r8 + r11]
	vmovdqu	xmmword ptr [r10 + r11], xmm12
	add	r11, 16
	cmp	r12, r11
	jne	202b
	cmp	qword ptr [rsp + 24], r9
	mov	r9, rax
	mov	r8, r10
	je	62b
	jmp	32b
212:
	mov	r15, r11
	and	r15, -256
	lea	rbx, [rax + r15]
	mov	r8, qword ptr [rsp]
	lea	r8, [r8 + rax + 192]
	xor	r10d, r10d
	.p2align	4
222:
	vmovdqu64	zmm14, zmmword ptr [r8 + r10 - 192]
	vmovdqu64	zmm15, zmmword ptr [r8 + r10 - 128]
	vmovdqu64	zmm16, zmmword ptr [r8 + r10 - 64]
	vmovdqu64	zmm17, zmmword ptr [r8 + r10]
	vmovdqu64	zmmword ptr [rdi + r10 + 576], zmm14
	vmovdqu64	zmmword ptr [rdi + r10 + 640], zmm15
	vmovdqu64	zmmword ptr [rdi + r10 + 704], zmm16
	vmovdqu64	zmmword ptr [rdi + r10 + 768], zmm17
	add	r10, 256
	cmp	r15, r10
	jne	222b
	cmp	r11, r15
	mov	r12, r13
	mov	r10, qword ptr [rsp + 16]
	je	272f
	test	r11b, -16
	je	252f
232:
	mov	r8, r11
	and	r8, -16
	lea	rbx, [rax + r8]
	.p2align	4
242:
	vmovdqu	xmm14, xmmword ptr [r14 + r15]
	vmovdqu	xmmword ptr [r13 + r15], xmm14
	add	r15, 16
	cmp	r8, r15
	jne	242b
	cmp	r11, r8
	mov	r12, r13
	je	272f
252:
	mov	r8, r13
	sub	r8, rax
	mov	r11, qword ptr [rsp]
	mov	r14, qword ptr [rsp + 8]
	.p2align	4
262:
	movzx	eax, byte ptr [r11 + rbx]
	mov	byte ptr [r8 + rbx], al
	inc	rbx
	cmp	r14, rbx
	jne	262b
	mov	r12, r13
272:
	vextracti128	xmm14, ymm12, 1
	vpmovzxbd	zmm14, xmm14
	vpsrld	zmm15, zmm14, 3
	vpmaxud	zmm15, zmm15, zmm3
	vpaddd	zmm15, zmm15, zmm4
	vpminud	zmm16, zmm14, zmm6
	vpandd	zmm16, zmm16, zmm6
	vpternlogd	zmm16, zmm14, zmm5, 248
	vpsllvd	zmm14, zmm16, zmm15
	vpsllvd	zmm16, zmm4, zmm15
	valignd	zmm17, zmm15, zmm7, 15
	vpaddd	zmm17, zmm17, zmm15
	valignq	zmm18, zmm17, zmm7, 7
	vpaddd	zmm17, zmm18, zmm17
	valignq	zmm18, zmm17, zmm7, 6
	vpaddd	zmm17, zmm18, zmm17
	valignq	zmm18, zmm17, zmm7, 4
	vpaddd	zmm17, zmm18, zmm17
	vpsubd	zmm15, zmm17, zmm15
	mov	eax, r9d
	and	eax, 7
	vpbroadcastd	zmm18, eax
	vpaddd	zmm15, zmm18, zmm15
	vpsrld	zmm18, zmm15, 3
	vpandd	zmm15, zmm15, zmm5
	vpshufb	zmm18, zmm18, zmm8
	vpaddb	zmm18, zmm18, zmm9
	vpermb	zmm18, zmm18, zmmword ptr [r12]
	vpsrlvd	zmm15, zmm18, zmm15
	vpandnd	zmm15, zmm16, zmm15
	vpaddd	zmm14, zmm15, zmm14
	vptestmd	k3, zmm14, zmm14
	vpord	zmm14 {k3} {z}, zmm14, zmm10
	valignd	zmm15, zmm14, zmm7, 15
	vpmaxud	zmm14, zmm14, zmm15
	valignq	zmm15, zmm14, zmm7, 7
	vpmaxud	zmm14, zmm14, zmm15
	valignq	zmm15, zmm14, zmm7, 6
	vpmaxud	zmm14, zmm14, zmm15
	valignq	zmm15, zmm14, zmm7, 4
	vpmaxud	zmm14, zmm14, zmm15
	vptestmd	k3, zmm14, zmm14
	vpandd	zmm13 {k3}, zmm14, zmm11
	vpshufd	zmm14, zmm13, 255
	vmovdqu64	zmmword ptr [rdi + 320], zmm13
	vshufi64x2	zmm13, zmm14, zmm14, 255
	vextracti32x4	xmm14, zmm17, 3
	vpextrd	eax, xmm14, 3
	add	r9, rax
	cmp	qword ptr [rsp + 48], 33
	jb	442f
	mov	rax, r9
	shr	rax, 3
	lea	r8, [rax + 64]
	mov	r11, qword ptr [rsp + 8]
	cmp	r8, r11
	jbe	282f
	sub	r11, rax
	mov	r12, r13
	jbe	352f
	cmp	r11, 16
	mov	rbx, rax
	jb	332f
	mov	r8, qword ptr [rsp]
	lea	r14, [rax + r8]
	mov	r8, rdi
	sub	r8, r14
	add	r8, 575
	cmp	r8, 255
	mov	rbx, rax
	jb	332f
	cmp	r11, 256
	jae	292f
	xor	r15d, r15d
	jmp	312f
282:
	add	rax, qword ptr [rsp]
	mov	r12, rax
	jmp	352f
292:
	mov	r15, r11
	and	r15, -256
	lea	rbx, [rax + r15]
	mov	r8, qword ptr [rsp]
	lea	r8, [r8 + rax + 192]
	xor	r10d, r10d
	.p2align	4
302:
	vmovdqu64	zmm14, zmmword ptr [r8 + r10 - 192]
	vmovdqu64	zmm15, zmmword ptr [r8 + r10 - 128]
	vmovdqu64	zmm16, zmmword ptr [r8 + r10 - 64]
	vmovdqu64	zmm17, zmmword ptr [r8 + r10]
	vmovdqu64	zmmword ptr [rdi + r10 + 576], zmm14
	vmovdqu64	zmmword ptr [rdi + r10 + 640], zmm15
	vmovdqu64	zmmword ptr [rdi + r10 + 704], zmm16
	vmovdqu64	zmmword ptr [rdi + r10 + 768], zmm17
	add	r10, 256
	cmp	r15, r10
	jne	302b
	cmp	r11, r15
	mov	r12, r13
	mov	r10, qword ptr [rsp + 16]
	je	352f
	test	r11b, -16
	je	332f
312:
	mov	r8, r11
	and	r8, -16
	lea	rbx, [rax + r8]
	.p2align	4
322:
	vmovdqu	xmm14, xmmword ptr [r14 + r15]
	vmovdqu	xmmword ptr [r13 + r15], xmm14
	add	r15, 16
	cmp	r8, r15
	jne	322b
	cmp	r11, r8
	mov	r12, r13
	je	352f
332:
	mov	r8, r13
	sub	r8, rax
	mov	r11, qword ptr [rsp]
	mov	r14, qword ptr [rsp + 8]
	.p2align	4
342:
	movzx	eax, byte ptr [r11 + rbx]
	mov	byte ptr [r8 + rbx], al
	inc	rbx
	cmp	r14, rbx
	jne	342b
	mov	r12, r13
352:
	vextracti32x4	xmm14, zmm12, 2
	vpmovzxbd	zmm14, xmm14
	vpsrld	zmm15, zmm14, 3
	vpmaxud	zmm15, zmm15, zmm3
	vpaddd	zmm15, zmm15, zmm4
	vpminud	zmm16, zmm14, zmm6
	vpandd	zmm16, zmm16, zmm6
	vpternlogd	zmm16, zmm14, zmm5, 248
	vpsllvd	zmm14, zmm16, zmm15
	vpsllvd	zmm16, zmm4, zmm15
	valignd	zmm17, zmm15, zmm7, 15
	vpaddd	zmm17, zmm17, zmm15
	valignq	zmm18, zmm17, zmm7, 7
	vpaddd	zmm17, zmm18, zmm17
	valignq	zmm18, zmm17, zmm7, 6
	vpaddd	zmm17, zmm18, zmm17
	valignq	zmm18, zmm17, zmm7, 4
	vpaddd	zmm17, zmm18, zmm17
	vpsubd	zmm15, zmm17, zmm15
	mov	eax, r9d
	and	eax, 7
	vpbroadcastd	zmm18, eax
	vpaddd	zmm15, zmm18, zmm15
	vpsrld	zmm18, zmm15, 3
	vpandd	zmm15, zmm15, zmm5
	vpshufb	zmm18, zmm18, zmm8
	vpaddb	zmm18, zmm18, zmm9
	vpermb	zmm18, zmm18, zmmword ptr [r12]
	vpsrlvd	zmm15, zmm18, zmm15
	vpandnd	zmm15, zmm16, zmm15
	vpaddd	zmm14, zmm15, zmm14
	vptestmd	k3, zmm14, zmm14
	vpord	zmm14 {k3} {z}, zmm14, zmm10
	valignd	zmm15, zmm14, zmm7, 15
	vpmaxud	zmm14, zmm14, zmm15
	valignq	zmm15, zmm14, zmm7, 7
	vpmaxud	zmm14, zmm14, zmm15
	valignq	zmm15, zmm14, zmm7, 6
	vpmaxud	zmm14, zmm14, zmm15
	valignq	zmm15, zmm14, zmm7, 4
	vpmaxud	zmm14, zmm14, zmm15
	vptestmd	k3, zmm14, zmm14
	vpandd	zmm13 {k3}, zmm14, zmm11
	vpshufd	zmm14, zmm13, 255
	vmovdqu64	zmmword ptr [rdi + 384], zmm13
	vshufi64x2	zmm13, zmm14, zmm14, 255
	vextracti32x4	xmm14, zmm17, 3
	vpextrd	eax, xmm14, 3
	add	r9, rax
	cmp	qword ptr [rsp + 48], 49
	jb	442f
	mov	rax, r9
	shr	rax, 3
	lea	r8, [rax + 64]
	mov	r11, qword ptr [rsp + 8]
	cmp	r8, r11
	jbe	362f
	sub	r11, rax
	mov	r12, r13
	jbe	432f
	cmp	r11, 16
	mov	rbx, rax
	jb	412f
	mov	r8, qword ptr [rsp]
	lea	r14, [rax + r8]
	mov	r8, rdi
	sub	r8, r14
	add	r8, 575
	cmp	r8, 255
	mov	rbx, rax
	jb	412f
	cmp	r11, 256
	jae	372f
	xor	r15d, r15d
	jmp	392f
362:
	mov	r12, qword ptr [rsp]
	add	r12, rax
	jmp	432f
372:
	mov	r15, r11
	and	r15, -256
	lea	rbx, [rax + r15]
	mov	r8, qword ptr [rsp]
	lea	r8, [r8 + rax + 192]
	xor	r10d, r10d
	.p2align	4
382:
	vmovdqu64	zmm14, zmmword ptr [r8 + r10 - 192]
	vmovdqu64	zmm15, zmmword ptr [r8 + r10 - 128]
	vmovdqu64	zmm16, zmmword ptr [r8 + r10 - 64]
	vmovdqu64	zmm17, zmmword ptr [r8 + r10]
	vmovdqu64	zmmword ptr [rdi + r10 + 576], zmm14
	vmovdqu64	zmmword ptr [rdi + r10 + 640], zmm15
	vmovdqu64	zmmword ptr [rdi + r10 + 704], zmm16
	vmovdqu64	zmmword ptr [rdi + r10 + 768], zmm17
	add	r10, 256
	cmp	r15, r10
	jne	382b
	cmp	r11, r15
	mov	r12, r13
	mov	r10, qword ptr [rsp + 16]
	je	432f
	test	r11b, -16
	je	412f
392:
	mov	r8, r11
	and	r8, -16
	lea	rbx, [rax + r8]
	.p2align	4
402:
	vmovdqu	xmm14, xmmword ptr [r14 + r15]
	vmovdqu	xmmword ptr [r13 + r15], xmm14
	add	r15, 16
	cmp	r8, r15
	jne	402b
	cmp	r11, r8
	mov	r12, r13
	je	432f
412:
	mov	r8, r13
	sub	r8, rax
	mov	r11, qword ptr [rsp]
	mov	r14, qword ptr [rsp + 8]
	.p2align	4
422:
	movzx	eax, byte ptr [r11 + rbx]
	mov	byte ptr [r8 + rbx], al
	inc	rbx
	cmp	r14, rbx
	jne	422b
	mov	r12, r13
432:
	vextracti32x4	xmm12, zmm12, 3
	vpmovzxbd	zmm12, xmm12
	vpsrld	zmm14, zmm12, 3
	vpmaxud	zmm14, zmm14, zmm3
	vpaddd	zmm14, zmm14, zmm4
	vpminud	zmm15, zmm12, zmm6
	vpandd	zmm15, zmm15, zmm6
	vpternlogd	zmm15, zmm12, zmm5, 248
	vpsllvd	zmm12, zmm15, zmm14
	vpsllvd	zmm15, zmm4, zmm14
	valignd	zmm16, zmm14, zmm7, 15
	vpaddd	zmm16, zmm16, zmm14
	valignq	zmm17, zmm16, zmm7, 7
	vpaddd	zmm16, zmm17, zmm16
	valignq	zmm17, zmm16, zmm7, 6
	vpaddd	zmm16, zmm17, zmm16
	valignq	zmm17, zmm16, zmm7, 4
	vpaddd	zmm16, zmm17, zmm16
	vpsubd	zmm14, zmm16, zmm14
	mov	eax, r9d
	and	eax, 7
	vpbroadcastd	zmm17, eax
	vpaddd	zmm14, zmm17, zmm14
	vpsrld	zmm17, zmm14, 3
	vpandd	zmm14, zmm14, zmm5
	vpshufb	zmm17, zmm17, zmm8
	vpaddb	zmm17, zmm17, zmm9
	vpermb	zmm17, zmm17, zmmword ptr [r12]
	vpsrlvd	zmm14, zmm17, zmm14
	vpandnd	zmm14, zmm15, zmm14
	vpaddd	zmm12, zmm14, zmm12
	vptestmd	k3, zmm12, zmm12
	vpord	zmm12 {k3} {z}, zmm12, zmm10
	valignd	zmm14, zmm12, zmm7, 15
	vpmaxud	zmm12, zmm12, zmm14
	valignq	zmm14, zmm12, zmm7, 7
	vpmaxud	zmm12, zmm12, zmm14
	valignq	zmm14, zmm12, zmm7, 6
	vpmaxud	zmm12, zmm12, zmm14
	valignq	zmm14, zmm12, zmm7, 4
	vpmaxud	zmm12, zmm12, zmm14
	vptestmd	k3, zmm12, zmm12
	vpandd	zmm13 {k3}, zmm12, zmm11
	vpshufd	zmm12, zmm13, 255
	vmovdqu64	zmmword ptr [rdi + 448], zmm13
	vshufi64x2	zmm13, zmm12, zmm12, 255
	vextracti32x4	xmm12, zmm16, 3
	vpextrd	eax, xmm12, 3
	add	r9, rax
	.p2align	4
442:
	kmovq	rax, k2
	popcnt	rax, rax
	add	rax, r10
	kmovq	r8, k1
	popcnt	r8, r8
	add	r8, qword ptr [rsp + 72]
	vmovd	r10d, xmm13
	mov	qword ptr [rdi + 72], r9
	mov	qword ptr [rdi + 96], r10
	mov	qword ptr [rdi + 128], r8
	mov	qword ptr [rdi + 136], rax
	xor	eax, eax
	.p2align	4
452:
	movzx	r10d, byte ptr [rdi + rax + 512]
	movzx	r8d, byte ptr [rdi + rax + 192]
	cmp	r8, 33
	mov	r9d, dword ptr [rdi + 4*rax + 256]
	vmovdqu	ymm12, ymmword ptr [rsi]
	vmovdqu	ymmword ptr [rdx], ymm12
	jae	492f
462:
	add	rdx, r8
	mov	r11d, r10d
	shr	r11d, 2
	cmp	r9, r11
	jb	542f
	mov	rbx, rdx
	sub	rbx, r9
	cmp	rbx, rcx
	jl	542f
	vmovdqu	ymm12, ymmword ptr [rbx]
472:
	vmovdqu	ymmword ptr [rdx], ymm12
	cmp	r10b, -124
	jae	512f
482:
	add	rdx, r11
	add	rsi, r8
	inc	rax
	cmp	rax, rbp
	jne	452b
	jmp	2b
492:
	mov	r8, qword ptr [rdi + 48]
	mov	r11, qword ptr [rdi + 120]
	movzx	r8d, byte ptr [r8 + r11]
	inc	r11
	mov	qword ptr [rdi + 120], r11
	add	r8, 33
	mov	r11d, 32
	.p2align	4
502:
	vmovdqu	ymm12, ymmword ptr [rsi + r11]
	vmovdqu	ymmword ptr [rdx + r11], ymm12
	add	r11, 32
	cmp	r11, r8
	jb	502b
	jmp	462b
512:
	cmp	r9, 31
	ja	522f
	mov	qword ptr [rdi + 104], 1
522:
	mov	r9, qword ptr [rdi + 48]
	mov	r10, qword ptr [rdi + 120]
	movzx	r11d, byte ptr [r9 + r10]
	inc	r10
	mov	qword ptr [rdi + 120], r10
	add	r11, 33
	mov	r9d, 32
	.p2align	4
532:
	vmovdqu	ymm12, ymmword ptr [rbx + r9]
	vmovdqu	ymmword ptr [rdx + r9], ymm12
	add	r9, 32
	cmp	r9, r11
	jb	532b
	jmp	482b
542:
	mov	rbx, rdx
	sub	rbx, rcx
	cmp	r9, rbx
	cmovae	r9, rbx
	sub	rbx, r9
	cmp	r9, r11
	jae	552f
	mov	r14, qword ptr [rdi + 56]
	mov	r15, r9
	shl	r15, 5
	vmovdqu	ymm12, ymmword ptr [r14 + r15 + 2048]
	vpermb	ymm12, ymm12, ymmword ptr [rcx + rbx]
	add	rbx, rcx
	jmp	472b
552:
	vmovdqu	ymm12, ymmword ptr [rcx + rbx]
	add	rbx, rcx
	jmp	472b
562:
	sub	rdx, rcx
	sub	rsi, qword ptr [rsp + 88]
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
572:
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
582:
	.byte	2
	.p2align	6, 0x0
592:
	.byte	1
	.p2align	2, 0x0
602:
	.long	1
	.p2align	2, 0x0
612:
	.long	7
	.p2align	2, 0x0
622:
	.long	8
	.p2align	4, 0x0
632:
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
642:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	6, 0x0
652:
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
662:
	.long	134217727

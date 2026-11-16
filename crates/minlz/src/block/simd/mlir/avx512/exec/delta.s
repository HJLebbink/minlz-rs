# minlz_exec_delta of crates/minlz/mlir/exec64.mlir for avx512, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 152
	mov	rcx, qword ptr [rdi]
	mov	rax, qword ptr [rdi + 8]
	mov	r8, qword ptr [rdi + 64]
	mov	rdx, qword ptr [rdi + 80]
	add	rdx, rcx
	mov	rsi, qword ptr [rdi + 88]
	mov	qword ptr [rsp + 88], rax
	add	rsi, rax
	test	r8, r8
	jle	592f
	mov	r15, qword ptr [rdi + 96]
	lea	rax, [rdi + 512]
	lea	r10, [rdi + 576]
	mov	r9d, 192
	mov	qword ptr [rsp + 32], r9
	mov	r9d, 7
	mov	qword ptr [rsp + 16], r9
	mov	qword ptr [rsp + 48], 0
	vmovdqa64	zmm0, zmmword ptr [rip + 602f]
	vpbroadcastb	zmm1, byte ptr [rip + 612f]
	vpbroadcastb	zmm2, byte ptr [rip + 622f]
	vpbroadcastd	zmm3, dword ptr [rip + 632f]
	vpternlogd	zmm4, zmm4, zmm4, 255
	vpbroadcastd	zmm5, dword ptr [rip + 642f]
	vpbroadcastd	zmm6, dword ptr [rip + 652f]
	vpxor	xmm7, xmm7, xmm7
	vbroadcasti32x4	zmm8, xmmword ptr [rip + 662f]
	vpbroadcastd	zmm9, dword ptr [rip + 672f]
	vmovdqa64	zmm10, zmmword ptr [rip + 682f]
	vpbroadcastd	zmm11, dword ptr [rip + 692f]
	mov	qword ptr [rsp + 40], rax
	mov	rbp, r8
	xor	r11d, r11d
	mov	qword ptr [rsp + 96], r8
	jmp	12f
	.p2align	4
2:
	mov	rbp, qword ptr [rsp + 144]
	add	rbp, -64
	inc	qword ptr [rsp + 48]
	add	qword ptr [rsp + 32], 64
	add	qword ptr [rsp + 16], -64
	add	qword ptr [rsp + 40], -64
	mov	r8, qword ptr [rsp + 96]
	mov	r11, qword ptr [rsp + 136]
	cmp	r11, r8
	mov	r15, rax
	lea	rax, [rdi + 512]
	lea	r10, [rdi + 576]
	jge	592f
12:
	cmp	rbp, 1
	mov	qword ptr [rsp + 144], rbp
	adc	rbp, 0
	cmp	rbp, 64
	mov	r9d, 64
	cmovae	rbp, r9
	sub	r8, r11
	cmp	r8, 64
	mov	qword ptr [rsp + 24], r8
	cmovb	r9, r8
	mov	qword ptr [rsp + 104], r9
	mov	r8, qword ptr [rdi + 16]
	mov	r9, qword ptr [rdi + 24]
	mov	qword ptr [rsp + 112], r9
	mov	r9, qword ptr [rdi + 32]
	mov	qword ptr [rsp + 120], r9
	mov	r9, qword ptr [rdi + 40]
	mov	qword ptr [rsp], r9
	mov	rbx, qword ptr [rdi + 64]
	mov	r9, qword ptr [rdi + 72]
	mov	qword ptr [rsp + 56], r9
	mov	r9, qword ptr [rdi + 96]
	mov	qword ptr [rsp + 128], r9
	mov	r9, qword ptr [rdi + 112]
	mov	qword ptr [rsp + 8], r9
	mov	r9, qword ptr [rdi + 128]
	mov	qword ptr [rsp + 72], r9
	mov	r9, qword ptr [rdi + 136]
	mov	qword ptr [rsp + 64], r9
	lea	r12, [rbx + 7]
	lea	r9, [r11 + 64]
	mov	qword ptr [rsp + 136], r9
	cmp	r9, r12
	jbe	52f
	cmp	r11, r12
	jge	62f
	mov	rax, qword ptr [rsp + 48]
	shl	rax, 6
	mov	r13d, 7
	sub	r13, rax
	add	r13, rbx
	cmp	r13, 16
	jb	22f
	add	rax, r8
	mov	r9, rdi
	sub	r9, rax
	add	r9, 511
	cmp	r9, 255
	jae	82f
22:
	mov	r13, r11
32:
	mov	r9, qword ptr [rsp + 40]
	.p2align	4
42:
	movzx	eax, byte ptr [r8 + r13]
	mov	byte ptr [r9 + r13], al
	inc	r13
	cmp	r12, r13
	jne	42b
	lea	rax, [rdi + 512]
	jmp	62f
	.p2align	4
52:
	add	r8, r11
	mov	rax, r8
62:
	vmovdqu64	zmm13, zmmword ptr [rax]
	mov	rax, qword ptr [rsp + 104]
	vpbroadcastb	zmm12, eax
	vpcmpnleub	k2, zmm12, zmm0
	vptestmb	k1 {k2}, zmm13, zmm1
	vptestnmb	k2 {k2}, zmm13, zmm2
	mov	rax, qword ptr [rsp + 72]
	mov	r8, qword ptr [rsp + 112]
	vpexpandb	zmm12 {k1} {z}, zmmword ptr [r8 + rax]
	vmovdqu64	zmmword ptr [rdi + 192], zmm12
	mov	rax, qword ptr [rsp + 64]
	mov	r8, qword ptr [rsp + 120]
	vpexpandb	zmm12 {k2} {z}, zmmword ptr [r8 + rax]
	vmovdqu64	zmmword ptr [rdi + 512], zmm13
	mov	rax, qword ptr [rsp + 56]
	shr	rax, 3
	lea	r8, [rax + 64]
	mov	r9, qword ptr [rsp + 8]
	cmp	r8, r9
	jbe	72f
	mov	r8, r9
	sub	r8, rax
	mov	r12, r10
	mov	r13, qword ptr [rsp]
	jbe	152f
	cmp	r8, 16
	mov	rbx, rax
	jb	132f
	lea	r14, [rax + r13]
	mov	r9, rdi
	sub	r9, r14
	add	r9, 575
	cmp	r9, 255
	mov	rbx, rax
	jb	132f
	cmp	r8, 256
	jae	92f
	xor	r11d, r11d
	jmp	112f
	.p2align	4
72:
	mov	r13, qword ptr [rsp]
	add	rax, r13
	mov	r12, rax
	jmp	152f
82:
	cmp	r13, 256
	jae	172f
	xor	r14d, r14d
	mov	r9, r13
	jmp	192f
92:
	mov	r11, r8
	and	r11, -256
	lea	rbx, [rax + r11]
	lea	r9, [r13 + rax + 192]
	xor	r10d, r10d
	.p2align	4
102:
	vmovdqu64	zmm13, zmmword ptr [r9 + r10 - 192]
	vmovdqu64	zmm14, zmmword ptr [r9 + r10 - 128]
	vmovdqu64	zmm15, zmmword ptr [r9 + r10 - 64]
	vmovdqu64	zmm16, zmmword ptr [r9 + r10]
	vmovdqu64	zmmword ptr [rdi + r10 + 576], zmm13
	vmovdqu64	zmmword ptr [rdi + r10 + 640], zmm14
	vmovdqu64	zmmword ptr [rdi + r10 + 704], zmm15
	vmovdqu64	zmmword ptr [rdi + r10 + 768], zmm16
	add	r10, 256
	cmp	r11, r10
	jne	102b
	cmp	r8, r11
	lea	r10, [rdi + 576]
	mov	r12, r10
	je	152f
	test	r8b, -16
	je	132f
112:
	mov	r9, r8
	and	r9, -16
	lea	rbx, [rax + r9]
	.p2align	4
122:
	vmovdqu	xmm13, xmmword ptr [r14 + r11]
	vmovdqu	xmmword ptr [r10 + r11], xmm13
	add	r11, 16
	cmp	r9, r11
	jne	122b
	cmp	r8, r9
	mov	r12, r10
	je	152f
	.p2align	4
132:
	mov	r8, r10
	sub	r8, rax
	mov	r9, qword ptr [rsp + 8]
	.p2align	4
142:
	movzx	eax, byte ptr [r13 + rbx]
	mov	byte ptr [r8 + rbx], al
	inc	rbx
	cmp	r9, rbx
	jne	142b
	mov	r12, r10
152:
	mov	rax, qword ptr [rsp + 128]
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
	mov	r8, qword ptr [rsp + 56]
	mov	eax, r8d
	and	eax, 7
	vpbroadcastd	zmm18, eax
	vpaddd	zmm15, zmm15, zmm18
	vpsrld	zmm18, zmm15, 3
	vpandd	zmm15, zmm15, zmm5
	vpshufb	zmm18, zmm18, zmm8
	vpaddb	zmm18, zmm18, zmm9
	vpermb	zmm18, zmm18, zmmword ptr [r12]
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
	vpextrd	eax, xmm15, 3
	add	rax, r8
	vmovdqu64	zmmword ptr [rdi + 256], zmm14
	cmp	qword ptr [rsp + 24], 17
	jb	442f
	mov	r8, rax
	shr	r8, 3
	lea	r9, [r8 + 64]
	mov	r11, qword ptr [rsp + 8]
	cmp	r9, r11
	jbe	162f
	sub	r11, r8
	mov	r13, r10
	jbe	272f
	cmp	r11, 16
	mov	rbx, r8
	jb	252f
	mov	r9, qword ptr [rsp]
	lea	r14, [r8 + r9]
	mov	r9, rdi
	sub	r9, r14
	add	r9, 575
	cmp	r9, 255
	mov	rbx, r8
	jb	252f
	cmp	r11, 256
	jae	212f
	xor	r12d, r12d
	jmp	232f
	.p2align	4
162:
	add	r8, r13
	mov	r13, r8
	jmp	272f
172:
	mov	qword ptr [rsp + 80], r13
	mov	r14, r13
	and	r14, -256
	lea	r13, [r11 + r14]
	mov	rax, qword ptr [rsp + 32]
	lea	r10, [r8 + rax]
	mov	rax, qword ptr [rsp + 16]
	lea	r9, [rbx + rax]
	and	r9, -256
	xor	eax, eax
	.p2align	4
182:
	vmovdqu64	zmm12, zmmword ptr [r10 + rax - 192]
	vmovdqu64	zmm13, zmmword ptr [r10 + rax - 128]
	vmovdqu64	zmm14, zmmword ptr [r10 + rax - 64]
	vmovdqu64	zmm15, zmmword ptr [r10 + rax]
	vmovdqu64	zmmword ptr [rdi + rax + 512], zmm12
	vmovdqu64	zmmword ptr [rdi + rax + 576], zmm13
	vmovdqu64	zmmword ptr [rdi + rax + 640], zmm14
	vmovdqu64	zmmword ptr [rdi + rax + 704], zmm15
	add	rax, 256
	cmp	r9, rax
	jne	182b
	mov	r9, qword ptr [rsp + 80]
	cmp	r9, r14
	lea	rax, [rdi + 512]
	lea	r10, [rdi + 576]
	je	62b
	test	r9b, -16
	je	32b
192:
	mov	r10, r9
	and	r10, -16
	mov	r13, r9
	lea	r9, [r8 + r11]
	add	r11, r10
	add	rbx, qword ptr [rsp + 16]
	and	rbx, -16
	lea	rax, [rdi + 512]
	.p2align	4
202:
	vmovdqu	xmm12, xmmword ptr [r9 + r14]
	vmovdqu	xmmword ptr [rax + r14], xmm12
	add	r14, 16
	cmp	rbx, r14
	jne	202b
	cmp	r13, r10
	mov	r13, r11
	lea	r10, [rdi + 576]
	je	62b
	jmp	32b
212:
	mov	r12, r11
	and	r12, -256
	lea	rbx, [r8 + r12]
	mov	r9, qword ptr [rsp]
	lea	r9, [r9 + r8 + 192]
	xor	r10d, r10d
	.p2align	4
222:
	vmovdqu64	zmm14, zmmword ptr [r9 + r10 - 192]
	vmovdqu64	zmm15, zmmword ptr [r9 + r10 - 128]
	vmovdqu64	zmm16, zmmword ptr [r9 + r10 - 64]
	vmovdqu64	zmm17, zmmword ptr [r9 + r10]
	vmovdqu64	zmmword ptr [rdi + r10 + 576], zmm14
	vmovdqu64	zmmword ptr [rdi + r10 + 640], zmm15
	vmovdqu64	zmmword ptr [rdi + r10 + 704], zmm16
	vmovdqu64	zmmword ptr [rdi + r10 + 768], zmm17
	add	r10, 256
	cmp	r12, r10
	jne	222b
	cmp	r11, r12
	lea	r10, [rdi + 576]
	mov	r13, r10
	je	272f
	test	r11b, -16
	je	252f
232:
	mov	r9, r11
	and	r9, -16
	lea	rbx, [r8 + r9]
	.p2align	4
242:
	vmovdqu	xmm14, xmmword ptr [r14 + r12]
	vmovdqu	xmmword ptr [r10 + r12], xmm14
	add	r12, 16
	cmp	r9, r12
	jne	242b
	cmp	r11, r9
	mov	r13, r10
	je	272f
252:
	mov	r9, r10
	sub	r9, r8
	mov	r11, qword ptr [rsp]
	mov	r14, qword ptr [rsp + 8]
	.p2align	4
262:
	movzx	r8d, byte ptr [r11 + rbx]
	mov	byte ptr [r9 + rbx], r8b
	inc	rbx
	cmp	r14, rbx
	jne	262b
	mov	r13, r10
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
	mov	r8d, eax
	and	r8d, 7
	vpbroadcastd	zmm18, r8d
	vpaddd	zmm15, zmm18, zmm15
	vpsrld	zmm18, zmm15, 3
	vpandd	zmm15, zmm15, zmm5
	vpshufb	zmm18, zmm18, zmm8
	vpaddb	zmm18, zmm18, zmm9
	vpermb	zmm18, zmm18, zmmword ptr [r13]
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
	vpextrd	r8d, xmm14, 3
	add	rax, r8
	cmp	qword ptr [rsp + 24], 33
	jb	442f
	mov	r8, rax
	shr	r8, 3
	lea	r9, [r8 + 64]
	mov	r11, qword ptr [rsp + 8]
	cmp	r9, r11
	jbe	282f
	sub	r11, r8
	mov	r13, r10
	jbe	352f
	cmp	r11, 16
	mov	rbx, r8
	jb	332f
	mov	r9, qword ptr [rsp]
	lea	r14, [r8 + r9]
	mov	r9, rdi
	sub	r9, r14
	add	r9, 575
	cmp	r9, 255
	mov	rbx, r8
	jb	332f
	cmp	r11, 256
	jae	292f
	xor	r12d, r12d
	jmp	312f
282:
	add	r8, qword ptr [rsp]
	mov	r13, r8
	jmp	352f
292:
	mov	r12, r11
	and	r12, -256
	lea	rbx, [r8 + r12]
	mov	r9, qword ptr [rsp]
	lea	r9, [r9 + r8 + 192]
	xor	r10d, r10d
	.p2align	4
302:
	vmovdqu64	zmm14, zmmword ptr [r9 + r10 - 192]
	vmovdqu64	zmm15, zmmword ptr [r9 + r10 - 128]
	vmovdqu64	zmm16, zmmword ptr [r9 + r10 - 64]
	vmovdqu64	zmm17, zmmword ptr [r9 + r10]
	vmovdqu64	zmmword ptr [rdi + r10 + 576], zmm14
	vmovdqu64	zmmword ptr [rdi + r10 + 640], zmm15
	vmovdqu64	zmmword ptr [rdi + r10 + 704], zmm16
	vmovdqu64	zmmword ptr [rdi + r10 + 768], zmm17
	add	r10, 256
	cmp	r12, r10
	jne	302b
	cmp	r11, r12
	lea	r10, [rdi + 576]
	mov	r13, r10
	je	352f
	test	r11b, -16
	je	332f
312:
	mov	r9, r11
	and	r9, -16
	lea	rbx, [r8 + r9]
	.p2align	4
322:
	vmovdqu	xmm14, xmmword ptr [r14 + r12]
	vmovdqu	xmmword ptr [r10 + r12], xmm14
	add	r12, 16
	cmp	r9, r12
	jne	322b
	cmp	r11, r9
	mov	r13, r10
	je	352f
332:
	mov	r9, r10
	sub	r9, r8
	mov	r11, qword ptr [rsp]
	mov	r14, qword ptr [rsp + 8]
	.p2align	4
342:
	movzx	r8d, byte ptr [r11 + rbx]
	mov	byte ptr [r9 + rbx], r8b
	inc	rbx
	cmp	r14, rbx
	jne	342b
	mov	r13, r10
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
	mov	r8d, eax
	and	r8d, 7
	vpbroadcastd	zmm18, r8d
	vpaddd	zmm15, zmm18, zmm15
	vpsrld	zmm18, zmm15, 3
	vpandd	zmm15, zmm15, zmm5
	vpshufb	zmm18, zmm18, zmm8
	vpaddb	zmm18, zmm18, zmm9
	vpermb	zmm18, zmm18, zmmword ptr [r13]
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
	vpextrd	r8d, xmm14, 3
	add	rax, r8
	cmp	qword ptr [rsp + 24], 49
	jb	442f
	mov	r8, rax
	shr	r8, 3
	lea	r9, [r8 + 64]
	mov	r11, qword ptr [rsp + 8]
	cmp	r9, r11
	jbe	362f
	sub	r11, r8
	mov	r13, r10
	jbe	432f
	cmp	r11, 16
	mov	rbx, r8
	jb	412f
	mov	r9, qword ptr [rsp]
	lea	r14, [r8 + r9]
	mov	r9, rdi
	sub	r9, r14
	add	r9, 575
	cmp	r9, 255
	mov	rbx, r8
	jb	412f
	cmp	r11, 256
	jae	372f
	xor	r12d, r12d
	jmp	392f
362:
	mov	r13, qword ptr [rsp]
	add	r13, r8
	jmp	432f
372:
	mov	r12, r11
	and	r12, -256
	lea	rbx, [r8 + r12]
	mov	r9, qword ptr [rsp]
	lea	r9, [r9 + r8 + 192]
	xor	r10d, r10d
	.p2align	4
382:
	vmovdqu64	zmm14, zmmword ptr [r9 + r10 - 192]
	vmovdqu64	zmm15, zmmword ptr [r9 + r10 - 128]
	vmovdqu64	zmm16, zmmword ptr [r9 + r10 - 64]
	vmovdqu64	zmm17, zmmword ptr [r9 + r10]
	vmovdqu64	zmmword ptr [rdi + r10 + 576], zmm14
	vmovdqu64	zmmword ptr [rdi + r10 + 640], zmm15
	vmovdqu64	zmmword ptr [rdi + r10 + 704], zmm16
	vmovdqu64	zmmword ptr [rdi + r10 + 768], zmm17
	add	r10, 256
	cmp	r12, r10
	jne	382b
	cmp	r11, r12
	lea	r10, [rdi + 576]
	mov	r13, r10
	je	432f
	test	r11b, -16
	je	412f
392:
	mov	r9, r11
	and	r9, -16
	lea	rbx, [r8 + r9]
	.p2align	4
402:
	vmovdqu	xmm14, xmmword ptr [r14 + r12]
	vmovdqu	xmmword ptr [r10 + r12], xmm14
	add	r12, 16
	cmp	r9, r12
	jne	402b
	cmp	r11, r9
	mov	r13, r10
	je	432f
412:
	mov	r9, r10
	sub	r9, r8
	mov	r11, qword ptr [rsp]
	mov	r14, qword ptr [rsp + 8]
	.p2align	4
422:
	movzx	r8d, byte ptr [r11 + rbx]
	mov	byte ptr [r9 + rbx], r8b
	inc	rbx
	cmp	r14, rbx
	jne	422b
	mov	r13, r10
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
	mov	r8d, eax
	and	r8d, 7
	vpbroadcastd	zmm17, r8d
	vpaddd	zmm14, zmm17, zmm14
	vpsrld	zmm17, zmm14, 3
	vpandd	zmm14, zmm14, zmm5
	vpshufb	zmm17, zmm17, zmm8
	vpaddb	zmm17, zmm17, zmm9
	vpermb	zmm17, zmm17, zmmword ptr [r13]
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
	vpextrd	r8d, xmm12, 3
	add	rax, r8
	.p2align	4
442:
	kmovq	r8, k2
	popcnt	r8, r8
	add	r8, qword ptr [rsp + 64]
	kmovq	r9, k1
	popcnt	r9, r9
	add	r9, qword ptr [rsp + 72]
	vmovd	r10d, xmm13
	mov	qword ptr [rdi + 72], rax
	mov	qword ptr [rdi + 96], r10
	mov	qword ptr [rdi + 128], r9
	mov	qword ptr [rdi + 136], r8
	xor	r8d, r8d
	.p2align	4
452:
	movzx	r10d, byte ptr [rdi + r8 + 512]
	movzx	r9d, byte ptr [rdi + r8 + 192]
	mov	eax, dword ptr [rdi + 4*r8 + 256]
	vmovdqu	ymm12, ymmword ptr [rsi]
	cmp	r15, 32
	jb	552f
	mov	r11, rdx
	sub	r11, r15
	cmp	r11, rcx
	jl	552f
	vmovdqu	ymm13, ymmword ptr [r11]
462:
	vpaddb	ymm12, ymm13, ymm12
	vmovdqu	ymmword ptr [rdx], ymm12
	cmp	r9b, 33
	jae	502f
472:
	add	rdx, r9
	mov	r11d, r10d
	shr	r11d, 2
	cmp	rax, r11
	jb	562f
	mov	rbx, rdx
	sub	rbx, rax
	cmp	rbx, rcx
	jl	562f
	vmovdqu	ymm12, ymmword ptr [rbx]
	mov	r14, rax
482:
	vmovdqu	ymmword ptr [rdx], ymm12
	cmp	r10b, -124
	jae	522f
492:
	add	rdx, r11
	add	rsi, r9
	inc	r8
	cmp	r8, rbp
	mov	r15, rax
	jne	452b
	jmp	2b
502:
	mov	r9, qword ptr [rdi + 48]
	mov	r11, qword ptr [rdi + 120]
	movzx	r9d, byte ptr [r9 + r11]
	inc	r11
	mov	qword ptr [rdi + 120], r11
	add	r9, 33
	mov	r11d, 32
	.p2align	4
512:
	vmovdqu	ymm12, ymmword ptr [rsi + r11]
	vmovdqu	ymmword ptr [rdx + r11], ymm12
	add	r11, 32
	cmp	r11, r9
	jb	512b
	jmp	472b
522:
	cmp	r14, 31
	ja	532f
	mov	qword ptr [rdi + 104], 1
532:
	mov	r10, qword ptr [rdi + 48]
	mov	r14, qword ptr [rdi + 120]
	movzx	r11d, byte ptr [r10 + r14]
	inc	r14
	mov	qword ptr [rdi + 120], r14
	add	r11, 33
	mov	r10d, 32
	.p2align	4
542:
	vmovdqu	ymm12, ymmword ptr [rbx + r10]
	vmovdqu	ymmword ptr [rdx + r10], ymm12
	add	r10, 32
	cmp	r10, r11
	jb	542b
	jmp	492b
552:
	mov	r11, rdx
	sub	r11, rcx
	cmp	r15, r11
	cmovae	r15, r11
	sub	r11, r15
	cmp	r15, 31
	jbe	572f
	vmovdqu	ymm13, ymmword ptr [rcx + r11]
	jmp	462b
562:
	mov	rbx, rdx
	sub	rbx, rcx
	cmp	rax, rbx
	mov	r14, rbx
	cmovb	r14, rax
	sub	rbx, r14
	cmp	r14, r11
	jae	582f
	mov	r15, qword ptr [rdi + 56]
	mov	r12, r14
	shl	r12, 5
	vmovdqu	ymm12, ymmword ptr [r15 + r12 + 2048]
	vpermb	ymm12, ymm12, ymmword ptr [rcx + rbx]
	add	rbx, rcx
	jmp	482b
572:
	mov	rbx, qword ptr [rdi + 56]
	shl	r15, 5
	vmovdqu	ymm13, ymmword ptr [rbx + r15 + 2048]
	vpermb	ymm13, ymm13, ymmword ptr [rcx + r11]
	jmp	462b
582:
	vmovdqu	ymm12, ymmword ptr [rcx + rbx]
	add	rbx, rcx
	jmp	482b
592:
	sub	rdx, rcx
	sub	rsi, qword ptr [rsp + 88]
	mov	qword ptr [rdi + 80], rdx
	mov	qword ptr [rdi + 88], rsi
	add	rsp, 152
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	vzeroupper
	ret
	.p2align	6, 0x0
602:
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
612:
	.byte	2
	.p2align	6, 0x0
622:
	.byte	1
	.p2align	2, 0x0
632:
	.long	1
	.p2align	2, 0x0
642:
	.long	7
	.p2align	2, 0x0
652:
	.long	8
	.p2align	4, 0x0
662:
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
672:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	6, 0x0
682:
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
692:
	.long	134217727

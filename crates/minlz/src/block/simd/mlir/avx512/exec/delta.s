# minlz_exec_delta of crates/minlz/mlir/exec64.mlir for avx512, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 168
	mov	r12, rdi
	mov	r10, qword ptr [rdi]
	mov	rax, qword ptr [rdi + 8]
	mov	rcx, qword ptr [rdi + 64]
	mov	r14, qword ptr [rdi + 80]
	add	r14, r10
	mov	r8, qword ptr [rdi + 88]
	mov	qword ptr [rsp + 120], rax
	add	r8, rax
	test	rcx, rcx
	jle	1052f
	mov	rax, qword ptr [r12 + 16]
	mov	qword ptr [rsp + 128], rax
	mov	rbx, qword ptr [r12 + 96]
	lea	r11, [r12 + 512]
	lea	rax, [r12 + 576]
	mov	qword ptr [rsp + 80], rax
	mov	eax, 192
	mov	qword ptr [rsp + 88], rax
	mov	eax, 7
	mov	qword ptr [rsp + 64], rax
	mov	qword ptr [rsp + 104], 0
	vmovdqa64	zmm0, zmmword ptr [rip + 1062f]
	vpbroadcastb	zmm1, byte ptr [rip + 1072f]
	vpbroadcastb	zmm2, byte ptr [rip + 1082f]
	vpbroadcastd	zmm3, dword ptr [rip + 1092f]
	vpternlogd	zmm4, zmm4, zmm4, 255
	vpbroadcastd	zmm5, dword ptr [rip + 1102f]
	vpbroadcastd	zmm6, dword ptr [rip + 1112f]
	vpxor	xmm7, xmm7, xmm7
	vbroadcasti32x4	zmm8, xmmword ptr [rip + 1122f]
	vpbroadcastd	zmm9, dword ptr [rip + 1132f]
	vmovdqa64	zmm10, zmmword ptr [rip + 1142f]
	vpbroadcastd	zmm11, dword ptr [rip + 1152f]
	mov	rax, r11
	xor	edx, edx
	mov	qword ptr [rsp + 56], r12
	mov	qword ptr [rsp], r10
	mov	qword ptr [rsp + 96], r11
	mov	qword ptr [rsp + 136], rcx
	jmp	12f
	.p2align	4
2:
	inc	qword ptr [rsp + 104]
	add	qword ptr [rsp + 88], 64
	add	qword ptr [rsp + 64], -64
	mov	rax, qword ptr [rsp + 112]
	add	rax, -64
	mov	rcx, qword ptr [rsp + 136]
	mov	rdx, qword ptr [rsp + 160]
	cmp	rdx, rcx
	jge	1052f
12:
	mov	qword ptr [rsp + 8], r8
	mov	qword ptr [rsp + 112], rax
	mov	qword ptr [rsp + 48], r14
	sub	rcx, rdx
	cmp	rcx, 64
	mov	eax, 64
	mov	qword ptr [rsp + 32], rcx
	cmovb	rax, rcx
	mov	qword ptr [rsp + 72], rax
	mov	rdi, qword ptr [r12 + 16]
	mov	rcx, qword ptr [r12 + 24]
	mov	r8, qword ptr [r12 + 32]
	mov	r9, qword ptr [r12 + 40]
	mov	r15, qword ptr [r12 + 64]
	mov	rax, qword ptr [r12 + 72]
	mov	qword ptr [rsp + 152], rax
	mov	rax, qword ptr [r12 + 96]
	mov	qword ptr [rsp + 40], rax
	mov	rsi, qword ptr [r12 + 112]
	mov	rax, qword ptr [r12 + 128]
	mov	qword ptr [rsp + 144], rax
	mov	rax, qword ptr [r12 + 136]
	mov	qword ptr [rsp + 16], rax
	lea	r14, [r15 + 7]
	lea	rax, [rdx + 64]
	mov	qword ptr [rsp + 160], rax
	cmp	rax, r14
	mov	qword ptr [rsp + 24], rdx
	jbe	22f
	cmp	rdx, r14
	mov	rax, r11
	jge	92f
	mov	rax, qword ptr [rsp + 104]
	shl	rax, 6
	mov	edx, 7
	sub	rdx, rax
	add	rdx, r15
	cmp	rdx, 16
	mov	rbp, qword ptr [rsp + 24]
	jb	72f
	add	rax, rdi
	mov	r10, r12
	sub	r10, rax
	add	r10, 511
	cmp	r10, 255
	mov	r10, qword ptr [rsp]
	mov	rbp, qword ptr [rsp + 24]
	jb	72f
	cmp	rdx, 256
	jae	32f
	xor	r13d, r13d
	jmp	52f
	.p2align	4
22:
	add	rdi, rdx
	mov	rax, rdi
	jmp	92f
32:
	mov	r13, rdx
	and	r13, -256
	mov	rax, qword ptr [rsp + 24]
	lea	rbp, [rax + r13]
	mov	rax, qword ptr [rsp + 88]
	lea	r11, [rdi + rax]
	mov	rax, qword ptr [rsp + 64]
	lea	r10, [r15 + rax]
	and	r10, -256
	xor	eax, eax
	.p2align	4
42:
	vmovdqu64	zmm12, zmmword ptr [r11 + rax - 192]
	vmovdqu64	zmm13, zmmword ptr [r11 + rax - 128]
	vmovdqu64	zmm14, zmmword ptr [r11 + rax - 64]
	vmovdqu64	zmm15, zmmword ptr [r11 + rax]
	vmovdqu64	zmmword ptr [r12 + rax + 512], zmm12
	vmovdqu64	zmmword ptr [r12 + rax + 576], zmm13
	vmovdqu64	zmmword ptr [r12 + rax + 640], zmm14
	vmovdqu64	zmmword ptr [r12 + rax + 704], zmm15
	add	rax, 256
	cmp	r10, rax
	jne	42b
	cmp	rdx, r13
	mov	r11, qword ptr [rsp + 96]
	mov	rax, r11
	mov	r10, qword ptr [rsp]
	je	92f
	test	dl, -16
	je	72f
52:
	mov	r10, rdx
	and	r10, -16
	mov	rax, qword ptr [rsp + 24]
	lea	rbp, [rax + r10]
	add	rax, rdi
	add	r15, qword ptr [rsp + 64]
	and	r15, -16
	.p2align	4
62:
	vmovdqu	xmm12, xmmword ptr [rax + r13]
	vmovdqu	xmmword ptr [r11 + r13], xmm12
	add	r13, 16
	cmp	r15, r13
	jne	62b
	cmp	rdx, r10
	mov	rax, r11
	mov	r10, qword ptr [rsp]
	je	92f
	.p2align	4
72:
	mov	rdx, qword ptr [rsp + 112]
	.p2align	4
82:
	movzx	eax, byte ptr [rdi + rbp]
	mov	byte ptr [rdx + rbp], al
	inc	rbp
	cmp	r14, rbp
	jne	82b
	mov	rax, r11
92:
	vmovdqu64	zmm12, zmmword ptr [rax]
	mov	rax, qword ptr [rsp + 72]
	vpbroadcastb	zmm13, eax
	vpcmpnleub	k2, zmm13, zmm0
	vptestmb	k1 {k2}, zmm12, zmm1
	vptestnmb	k2 {k2}, zmm12, zmm2
	mov	rbp, qword ptr [rsp + 144]
	vpexpandb	zmm12 {k1} {z}, zmmword ptr [rcx + rbp]
	vmovdqu64	zmmword ptr [r12 + 192], zmm12
	mov	rax, qword ptr [rsp + 16]
	vpexpandb	zmm12 {k2} {z}, zmmword ptr [r8 + rax]
	mov	r8, qword ptr [rsp + 152]
	mov	rax, r8
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, rsi
	jbe	102f
	mov	rcx, rsi
	sub	rcx, rax
	mov	r13, qword ptr [rsp + 80]
	mov	r15, r13
	jbe	172f
	cmp	rcx, 16
	mov	rdi, rax
	jb	152f
	lea	r14, [rax + r9]
	mov	rdx, r12
	sub	rdx, r14
	add	rdx, 575
	cmp	rdx, 255
	mov	rdi, rax
	jb	152f
	cmp	rcx, 256
	jae	112f
	xor	edx, edx
	jmp	132f
	.p2align	4
102:
	add	rax, r9
	mov	r15, rax
	mov	r13, qword ptr [rsp + 80]
	jmp	172f
112:
	mov	rdx, rcx
	and	rdx, -256
	lea	rdi, [rax + rdx]
	lea	r10, [r9 + rax + 192]
	xor	r11d, r11d
	.p2align	4
122:
	vmovdqu64	zmm13, zmmword ptr [r10 + r11 - 192]
	vmovdqu64	zmm14, zmmword ptr [r10 + r11 - 128]
	vmovdqu64	zmm15, zmmword ptr [r10 + r11 - 64]
	vmovdqu64	zmm16, zmmword ptr [r10 + r11]
	vmovdqu64	zmmword ptr [r12 + r11 + 576], zmm13
	vmovdqu64	zmmword ptr [r12 + r11 + 640], zmm14
	vmovdqu64	zmmword ptr [r12 + r11 + 704], zmm15
	vmovdqu64	zmmword ptr [r12 + r11 + 768], zmm16
	add	r11, 256
	cmp	rdx, r11
	jne	122b
	cmp	rcx, rdx
	mov	r15, r13
	mov	r10, qword ptr [rsp]
	je	172f
	test	cl, -16
	je	152f
132:
	mov	r10, rcx
	and	r10, -16
	lea	rdi, [rax + r10]
	.p2align	4
142:
	vmovdqu	xmm13, xmmword ptr [r14 + rdx]
	vmovdqu	xmmword ptr [r13 + rdx], xmm13
	add	rdx, 16
	cmp	r10, rdx
	jne	142b
	cmp	rcx, r10
	mov	r15, r13
	mov	r10, qword ptr [rsp]
	je	172f
	.p2align	4
152:
	mov	rcx, r13
	sub	rcx, rax
	.p2align	4
162:
	movzx	eax, byte ptr [r9 + rdi]
	mov	byte ptr [rcx + rdi], al
	inc	rdi
	cmp	rsi, rdi
	jne	162b
	mov	r15, r13
172:
	mov	rax, qword ptr [rsp + 40]
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
	vpextrd	r11d, xmm15, 3
	add	r11, r8
	vmovdqu64	zmmword ptr [r12 + 256], zmm14
	mov	r15, qword ptr [rsp + 32]
	cmp	r15, 17
	jb	422f
	mov	rax, r11
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, rsi
	jbe	182f
	mov	rcx, rsi
	sub	rcx, rax
	mov	r14, r13
	jbe	252f
	cmp	rcx, 16
	mov	rdi, rax
	jb	232f
	lea	r8, [rax + r9]
	mov	rdx, r12
	sub	rdx, r8
	add	rdx, 575
	cmp	rdx, 255
	mov	rdi, rax
	jb	232f
	cmp	rcx, 256
	jae	192f
	xor	edx, edx
	jmp	212f
	.p2align	4
182:
	add	rax, r9
	mov	r14, rax
	jmp	252f
192:
	mov	rdx, rcx
	and	rdx, -256
	lea	rdi, [rax + rdx]
	lea	r10, [r9 + rax + 192]
	xor	r14d, r14d
	.p2align	4
202:
	vmovdqu64	zmm14, zmmword ptr [r10 + r14 - 192]
	vmovdqu64	zmm15, zmmword ptr [r10 + r14 - 128]
	vmovdqu64	zmm16, zmmword ptr [r10 + r14 - 64]
	vmovdqu64	zmm17, zmmword ptr [r10 + r14]
	vmovdqu64	zmmword ptr [r12 + r14 + 576], zmm14
	vmovdqu64	zmmword ptr [r12 + r14 + 640], zmm15
	vmovdqu64	zmmword ptr [r12 + r14 + 704], zmm16
	vmovdqu64	zmmword ptr [r12 + r14 + 768], zmm17
	add	r14, 256
	cmp	rdx, r14
	jne	202b
	cmp	rcx, rdx
	mov	r14, r13
	mov	r10, qword ptr [rsp]
	je	252f
	test	cl, -16
	je	232f
212:
	mov	r10, rcx
	and	r10, -16
	lea	rdi, [rax + r10]
	.p2align	4
222:
	vmovdqu	xmm14, xmmword ptr [r8 + rdx]
	vmovdqu	xmmword ptr [r13 + rdx], xmm14
	add	rdx, 16
	cmp	r10, rdx
	jne	222b
	cmp	rcx, r10
	mov	r14, r13
	mov	r10, qword ptr [rsp]
	je	252f
232:
	mov	rcx, r13
	sub	rcx, rax
	.p2align	4
242:
	movzx	eax, byte ptr [r9 + rdi]
	mov	byte ptr [rcx + rdi], al
	inc	rdi
	cmp	rsi, rdi
	jne	242b
	mov	r14, r13
252:
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
	mov	eax, r11d
	and	eax, 7
	vpbroadcastd	zmm18, eax
	vpaddd	zmm15, zmm18, zmm15
	vpsrld	zmm18, zmm15, 3
	vpandd	zmm15, zmm15, zmm5
	vpshufb	zmm18, zmm18, zmm8
	vpaddb	zmm18, zmm18, zmm9
	vpermb	zmm18, zmm18, zmmword ptr [r14]
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
	vmovdqu64	zmmword ptr [r12 + 320], zmm13
	vshufi64x2	zmm13, zmm14, zmm14, 255
	vextracti32x4	xmm14, zmm17, 3
	vpextrd	eax, xmm14, 3
	add	r11, rax
	cmp	r15, 33
	jb	422f
	mov	rax, r11
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, rsi
	jbe	262f
	mov	rcx, rsi
	sub	rcx, rax
	mov	r14, r13
	jbe	332f
	cmp	rcx, 16
	mov	rdi, rax
	jb	312f
	lea	r8, [rax + r9]
	mov	rdx, r12
	sub	rdx, r8
	add	rdx, 575
	cmp	rdx, 255
	mov	rdi, rax
	jb	312f
	cmp	rcx, 256
	jae	272f
	xor	edx, edx
	jmp	292f
262:
	add	rax, r9
	mov	r14, rax
	jmp	332f
272:
	mov	rdx, rcx
	and	rdx, -256
	lea	rdi, [rax + rdx]
	lea	r10, [r9 + rax + 192]
	xor	r14d, r14d
	.p2align	4
282:
	vmovdqu64	zmm14, zmmword ptr [r10 + r14 - 192]
	vmovdqu64	zmm15, zmmword ptr [r10 + r14 - 128]
	vmovdqu64	zmm16, zmmword ptr [r10 + r14 - 64]
	vmovdqu64	zmm17, zmmword ptr [r10 + r14]
	vmovdqu64	zmmword ptr [r12 + r14 + 576], zmm14
	vmovdqu64	zmmword ptr [r12 + r14 + 640], zmm15
	vmovdqu64	zmmword ptr [r12 + r14 + 704], zmm16
	vmovdqu64	zmmword ptr [r12 + r14 + 768], zmm17
	add	r14, 256
	cmp	rdx, r14
	jne	282b
	cmp	rcx, rdx
	mov	r14, r13
	mov	r10, qword ptr [rsp]
	je	332f
	test	cl, -16
	je	312f
292:
	mov	r10, rcx
	and	r10, -16
	lea	rdi, [rax + r10]
	.p2align	4
302:
	vmovdqu	xmm14, xmmword ptr [r8 + rdx]
	vmovdqu	xmmword ptr [r13 + rdx], xmm14
	add	rdx, 16
	cmp	r10, rdx
	jne	302b
	cmp	rcx, r10
	mov	r14, r13
	mov	r10, qword ptr [rsp]
	je	332f
312:
	mov	rcx, r13
	sub	rcx, rax
	.p2align	4
322:
	movzx	eax, byte ptr [r9 + rdi]
	mov	byte ptr [rcx + rdi], al
	inc	rdi
	cmp	rsi, rdi
	jne	322b
	mov	r14, r13
332:
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
	mov	eax, r11d
	and	eax, 7
	vpbroadcastd	zmm18, eax
	vpaddd	zmm15, zmm18, zmm15
	vpsrld	zmm18, zmm15, 3
	vpandd	zmm15, zmm15, zmm5
	vpshufb	zmm18, zmm18, zmm8
	vpaddb	zmm18, zmm18, zmm9
	vpermb	zmm18, zmm18, zmmword ptr [r14]
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
	vmovdqu64	zmmword ptr [r12 + 384], zmm13
	vshufi64x2	zmm13, zmm14, zmm14, 255
	vextracti32x4	xmm14, zmm17, 3
	vpextrd	eax, xmm14, 3
	add	r11, rax
	cmp	r15, 49
	jb	422f
	mov	rax, r11
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, rsi
	jbe	342f
	mov	rcx, rsi
	sub	rcx, rax
	mov	r10, r13
	jbe	412f
	cmp	rcx, 16
	mov	rdi, rax
	jb	392f
	lea	r8, [rax + r9]
	mov	rdx, r12
	sub	rdx, r8
	add	rdx, 575
	cmp	rdx, 255
	mov	rdi, rax
	jb	392f
	cmp	rcx, 256
	jae	352f
	xor	edx, edx
	jmp	372f
342:
	add	r9, rax
	mov	r10, r9
	jmp	412f
352:
	mov	rdx, rcx
	and	rdx, -256
	lea	rdi, [rax + rdx]
	lea	r10, [r9 + rax + 192]
	xor	r14d, r14d
	.p2align	4
362:
	vmovdqu64	zmm14, zmmword ptr [r10 + r14 - 192]
	vmovdqu64	zmm15, zmmword ptr [r10 + r14 - 128]
	vmovdqu64	zmm16, zmmword ptr [r10 + r14 - 64]
	vmovdqu64	zmm17, zmmword ptr [r10 + r14]
	vmovdqu64	zmmword ptr [r12 + r14 + 576], zmm14
	vmovdqu64	zmmword ptr [r12 + r14 + 640], zmm15
	vmovdqu64	zmmword ptr [r12 + r14 + 704], zmm16
	vmovdqu64	zmmword ptr [r12 + r14 + 768], zmm17
	add	r14, 256
	cmp	rdx, r14
	jne	362b
	cmp	rcx, rdx
	mov	r10, r13
	je	412f
	test	cl, -16
	je	392f
372:
	mov	r10, rcx
	and	r10, -16
	lea	rdi, [rax + r10]
	.p2align	4
382:
	vmovdqu	xmm14, xmmword ptr [r8 + rdx]
	vmovdqu	xmmword ptr [r13 + rdx], xmm14
	add	rdx, 16
	cmp	r10, rdx
	jne	382b
	cmp	rcx, r10
	mov	r10, r13
	je	412f
392:
	mov	rcx, r13
	sub	rcx, rax
	.p2align	4
402:
	movzx	eax, byte ptr [r9 + rdi]
	mov	byte ptr [rcx + rdi], al
	inc	rdi
	cmp	rsi, rdi
	jne	402b
	mov	r10, r13
412:
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
	mov	eax, r11d
	and	eax, 7
	vpbroadcastd	zmm17, eax
	vpaddd	zmm14, zmm17, zmm14
	vpsrld	zmm17, zmm14, 3
	vpandd	zmm14, zmm14, zmm5
	vpshufb	zmm17, zmm17, zmm8
	vpaddb	zmm17, zmm17, zmm9
	vpermb	zmm17, zmm17, zmmword ptr [r10]
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
	vmovdqu64	zmmword ptr [r12 + 448], zmm13
	vshufi64x2	zmm13, zmm12, zmm12, 255
	vextracti32x4	xmm12, zmm16, 3
	vpextrd	eax, xmm12, 3
	add	r11, rax
	mov	r10, qword ptr [rsp]
	.p2align	4
422:
	mov	r8, qword ptr [rsp + 8]
	kmovq	rax, k2
	popcnt	rax, rax
	add	rax, qword ptr [rsp + 16]
	kmovq	rcx, k1
	popcnt	rcx, rcx
	add	rcx, rbp
	vmovd	edx, xmm13
	mov	qword ptr [r12 + 72], r11
	mov	qword ptr [r12 + 96], rdx
	mov	qword ptr [r12 + 128], rcx
	mov	qword ptr [r12 + 136], rax
	mov	rax, qword ptr [rsp + 24]
	add	rax, qword ptr [rsp + 128]
	mov	qword ptr [rsp + 24], rax
	mov	rbp, qword ptr [rsp + 72]
	and	rbp, 124
	mov	r13, qword ptr [rsp + 48]
	je	902f
	xor	edx, edx
	.p2align	4
432:
	mov	rax, r13
	sub	rax, r10
	cmp	rbx, rax
	cmovae	rbx, rax
	cmp	rbx, 31
	jbe	582f
	mov	rax, r13
	sub	rax, rbx
	vmovdqu	ymm12, ymmword ptr [rax]
442:
	mov	rbx, qword ptr [rsp + 24]
	movzx	ecx, byte ptr [rbx + rdx]
	movzx	r15d, byte ptr [r12 + rdx + 192]
	mov	eax, dword ptr [r12 + 4*rdx + 256]
	vpaddb	ymm12, ymm12, ymmword ptr [r8]
	vmovdqu	ymmword ptr [r13], ymm12
	cmp	r15b, 33
	jae	592f
452:
	lea	r9, [r13 + r15]
	mov	r11d, ecx
	shr	r11d, 2
	cmp	rax, r11
	mov	qword ptr [rsp + 8], r8
	jb	822f
	mov	rsi, r9
	sub	rsi, rax
	cmp	rsi, r10
	jl	822f
	vmovdqu	ymm12, ymmword ptr [rsi]
	mov	rdi, rax
462:
	vmovdqu	ymmword ptr [r9], ymm12
	cmp	cl, -124
	jae	612f
472:
	lea	rsi, [rdx + 1]
	mov	qword ptr [rsp + 16], r11
	add	r9, r11
	movzx	ecx, byte ptr [rbx + rsi]
	movzx	r14d, byte ptr [r12 + rsi + 192]
	mov	esi, dword ptr [r12 + 4*rsi + 256]
	vmovdqu	ymm12, ymmword ptr [r8 + r15]
	mov	rdi, r9
	sub	rdi, r10
	cmp	rax, rdi
	cmovae	rax, rdi
	cmp	rax, 31
	jbe	642f
	mov	rdi, r9
	sub	rdi, rax
	vmovdqu	ymm13, ymmword ptr [rdi]
482:
	vpaddb	ymm12, ymm13, ymm12
	lea	r11, [r8 + r15]
	vmovdqu	ymmword ptr [r9], ymm12
	cmp	r14b, 33
	jae	652f
492:
	mov	qword ptr [rsp + 32], r15
	add	r9, r14
	mov	r15d, ecx
	shr	r15d, 2
	cmp	rsi, r15
	jb	832f
	mov	rax, r9
	sub	rax, rsi
	cmp	rax, r10
	jl	832f
	vmovdqu	ymm12, ymmword ptr [rax]
	mov	rdi, rsi
502:
	vmovdqu	ymmword ptr [r9], ymm12
	cmp	cl, -124
	jae	672f
512:
	lea	rcx, [rdx + 2]
	add	r9, r15
	movzx	eax, byte ptr [rbx + rcx]
	movzx	r8d, byte ptr [r12 + rcx + 192]
	mov	ecx, dword ptr [r12 + 4*rcx + 256]
	vmovdqu	ymm12, ymmword ptr [r11 + r14]
	mov	rdi, r9
	sub	rdi, r10
	cmp	rsi, rdi
	cmovae	rsi, rdi
	cmp	rsi, 31
	jbe	702f
	mov	rdi, r9
	sub	rdi, rsi
	vmovdqu	ymm13, ymmword ptr [rdi]
	vpaddb	ymm12, ymm13, ymm12
	vmovdqu	ymmword ptr [r9], ymm12
	cmp	r8b, 33
	jae	712f
522:
	mov	qword ptr [rsp + 48], r13
	add	r9, r8
	mov	r13d, eax
	shr	r13d, 2
	cmp	rcx, r13
	jb	842f
	mov	rsi, r9
	sub	rsi, rcx
	cmp	rsi, r10
	jl	842f
	vmovdqu	ymm12, ymmword ptr [rsi]
	mov	rdi, rcx
532:
	vmovdqu	ymmword ptr [r9], ymm12
	cmp	al, -124
	jae	732f
542:
	lea	rsi, [rdx + 3]
	add	r11, r14
	add	r9, r13
	movzx	edi, byte ptr [rbx + rsi]
	movzx	eax, byte ptr [r12 + rsi + 192]
	mov	ebx, dword ptr [r12 + 4*rsi + 256]
	vmovdqu	ymm12, ymmword ptr [r11 + r8]
	mov	rsi, r9
	sub	rsi, r10
	cmp	rcx, rsi
	cmovae	rcx, rsi
	cmp	rcx, 31
	jbe	762f
	mov	rsi, r9
	sub	rsi, rcx
	vmovdqu	ymm13, ymmword ptr [rsi]
	vpaddb	ymm12, ymm13, ymm12
	vmovdqu	ymmword ptr [r9], ymm12
	cmp	al, 33
	jae	772f
552:
	add	r9, rax
	mov	ecx, edi
	shr	ecx, 2
	cmp	rbx, rcx
	jb	852f
	mov	r10, r9
	sub	r10, rbx
	cmp	r10, qword ptr [rsp]
	jl	852f
	vmovdqu	ymm12, ymmword ptr [r10]
	mov	r12, rbx
562:
	vmovdqu	ymmword ptr [r9], ymm12
	cmp	dil, -124
	jae	792f
572:
	add	r11, r8
	add	r9, rcx
	add	r11, rax
	add	rdx, 4
	cmp	rdx, rbp
	mov	r8, r11
	mov	r13, r9
	mov	r12, qword ptr [rsp + 56]
	mov	r10, qword ptr [rsp]
	jb	432b
	jmp	912f
582:
	sub	rax, rbx
	mov	rcx, qword ptr [r12 + 56]
	shl	rbx, 5
	vmovdqu	ymm12, ymmword ptr [rcx + rbx + 2048]
	vpermb	ymm12, ymm12, ymmword ptr [r10 + rax]
	jmp	442b
592:
	mov	rsi, qword ptr [r12 + 48]
	mov	rdi, qword ptr [r12 + 120]
	movzx	r15d, byte ptr [rsi + rdi]
	inc	rdi
	mov	qword ptr [r12 + 120], rdi
	add	r15, 33
	mov	esi, 32
	.p2align	4
602:
	vmovdqu	ymm12, ymmword ptr [r8 + rsi]
	vmovdqu	ymmword ptr [r13 + rsi], ymm12
	add	rsi, 32
	cmp	rsi, r15
	jb	602b
	jmp	452b
612:
	cmp	rdi, 31
	ja	622f
	mov	qword ptr [r12 + 104], 1
622:
	mov	rcx, qword ptr [r12 + 48]
	mov	rdi, qword ptr [r12 + 120]
	movzx	r11d, byte ptr [rcx + rdi]
	inc	rdi
	mov	qword ptr [r12 + 120], rdi
	add	r11, 33
	mov	ecx, 32
	.p2align	4
632:
	vmovdqu	ymm12, ymmword ptr [rsi + rcx]
	vmovdqu	ymmword ptr [r9 + rcx], ymm12
	add	rcx, 32
	cmp	rcx, r11
	jb	632b
	jmp	472b
642:
	sub	rdi, rax
	mov	r8, qword ptr [r12 + 56]
	shl	rax, 5
	vmovdqu	ymm13, ymmword ptr [r8 + rax + 2048]
	mov	r8, qword ptr [rsp + 8]
	vpermb	ymm13, ymm13, ymmword ptr [r10 + rdi]
	jmp	482b
652:
	mov	rax, qword ptr [r12 + 48]
	mov	rdi, qword ptr [r12 + 120]
	movzx	r14d, byte ptr [rax + rdi]
	inc	rdi
	mov	qword ptr [r12 + 120], rdi
	add	r14, 33
	mov	rax, qword ptr [rsp + 16]
	add	rax, r15
	add	rax, r13
	mov	edi, 32
	.p2align	4
662:
	vmovdqu	ymm12, ymmword ptr [r11 + rdi]
	vmovdqu	ymmword ptr [rax + rdi], ymm12
	add	rdi, 32
	cmp	rdi, r14
	jb	662b
	jmp	492b
672:
	cmp	rdi, 31
	ja	682f
	mov	qword ptr [r12 + 104], 1
682:
	mov	rcx, qword ptr [r12 + 48]
	mov	rdi, qword ptr [r12 + 120]
	movzx	r15d, byte ptr [rcx + rdi]
	inc	rdi
	mov	qword ptr [r12 + 120], rdi
	add	r15, 33
	mov	rcx, qword ptr [rsp + 32]
	add	rcx, r14
	mov	rdi, qword ptr [rsp + 16]
	add	rdi, r13
	add	rcx, rdi
	mov	edi, 32
	.p2align	4
692:
	vmovdqu	ymm12, ymmword ptr [rax + rdi]
	vmovdqu	ymmword ptr [rcx + rdi], ymm12
	add	rdi, 32
	cmp	rdi, r15
	jb	692b
	jmp	512b
702:
	sub	rdi, rsi
	mov	r10, qword ptr [r12 + 56]
	shl	rsi, 5
	vmovdqu	ymm13, ymmword ptr [r10 + rsi + 2048]
	mov	r10, qword ptr [rsp]
	vpermb	ymm13, ymm13, ymmword ptr [r10 + rdi]
	vpaddb	ymm12, ymm13, ymm12
	vmovdqu	ymmword ptr [r9], ymm12
	cmp	r8b, 33
	jb	522b
712:
	mov	rsi, qword ptr [r12 + 48]
	mov	rdi, qword ptr [r12 + 120]
	movzx	r8d, byte ptr [rsi + rdi]
	inc	rdi
	mov	qword ptr [r12 + 120], rdi
	add	r8, 33
	mov	rsi, qword ptr [rsp + 32]
	add	rsi, r14
	mov	rdi, qword ptr [rsp + 16]
	add	rdi, r15
	add	rdi, rsi
	add	rdi, r13
	add	rsi, qword ptr [rsp + 8]
	mov	r10d, 32
	.p2align	4
722:
	vmovdqu	ymm12, ymmword ptr [rsi + r10]
	vmovdqu	ymmword ptr [rdi + r10], ymm12
	add	r10, 32
	cmp	r10, r8
	jb	722b
	mov	r10, qword ptr [rsp]
	jmp	522b
732:
	cmp	rdi, 31
	ja	742f
	mov	qword ptr [r12 + 104], 1
742:
	mov	rax, qword ptr [r12 + 48]
	mov	rdi, qword ptr [r12 + 120]
	movzx	r13d, byte ptr [rax + rdi]
	inc	rdi
	mov	qword ptr [r12 + 120], rdi
	add	r13, 33
	mov	rax, qword ptr [rsp + 32]
	lea	rdi, [rax + r8]
	lea	rax, [r15 + r14]
	add	rax, rdi
	mov	qword ptr [rsp + 40], rax
	mov	rdi, qword ptr [rsp + 48]
	mov	rax, qword ptr [rsp + 16]
	add	rdi, rax
	mov	rax, qword ptr [rsp + 40]
	add	rax, rdi
	mov	edi, 32
	.p2align	4
752:
	vmovdqu	ymm12, ymmword ptr [rsi + rdi]
	vmovdqu	ymmword ptr [rax + rdi], ymm12
	add	rdi, 32
	cmp	rdi, r13
	jb	752b
	jmp	542b
762:
	sub	rsi, rcx
	mov	r10, qword ptr [r12 + 56]
	shl	rcx, 5
	vmovdqu	ymm13, ymmword ptr [r10 + rcx + 2048]
	mov	rcx, qword ptr [rsp]
	vpermb	ymm13, ymm13, ymmword ptr [rcx + rsi]
	vpaddb	ymm12, ymm13, ymm12
	vmovdqu	ymmword ptr [r9], ymm12
	cmp	al, 33
	jb	552b
772:
	mov	rax, qword ptr [r12 + 48]
	mov	rcx, qword ptr [r12 + 120]
	movzx	eax, byte ptr [rax + rcx]
	inc	rcx
	mov	qword ptr [r12 + 120], rcx
	add	rax, 33
	mov	rcx, qword ptr [rsp + 32]
	lea	rsi, [rcx + r8]
	lea	r10, [r13 + r15]
	add	r10, rsi
	mov	rcx, qword ptr [rsp + 16]
	add	rcx, r14
	add	rcx, qword ptr [rsp + 48]
	add	rcx, r10
	mov	r10, qword ptr [rsp + 8]
	add	r10, r14
	add	r10, rsi
	mov	esi, 32
	.p2align	4
782:
	vmovdqu	ymm12, ymmword ptr [r10 + rsi]
	vmovdqu	ymmword ptr [rcx + rsi], ymm12
	add	rsi, 32
	cmp	rsi, rax
	jb	782b
	jmp	552b
792:
	cmp	r12, 31
	mov	rdi, qword ptr [rsp + 56]
	ja	802f
	mov	qword ptr [rdi + 104], 1
802:
	mov	rcx, qword ptr [rdi + 48]
	mov	rsi, qword ptr [rdi + 120]
	movzx	ecx, byte ptr [rcx + rsi]
	inc	rsi
	mov	qword ptr [rdi + 120], rsi
	add	rcx, 33
	mov	rsi, qword ptr [rsp + 32]
	add	rsi, rax
	add	r13, r8
	add	r13, rsi
	add	r15, r14
	add	r15, qword ptr [rsp + 16]
	add	r15, r13
	mov	rdi, qword ptr [rsp + 48]
	add	rdi, r15
	mov	esi, 32
	.p2align	4
812:
	vmovdqu	ymm12, ymmword ptr [r10 + rsi]
	vmovdqu	ymmword ptr [rdi + rsi], ymm12
	add	rsi, 32
	cmp	rsi, rcx
	jb	812b
	jmp	572b
822:
	mov	rsi, r9
	sub	rsi, r10
	cmp	rax, rsi
	mov	rdi, rsi
	cmovb	rdi, rax
	sub	rsi, rdi
	cmp	rdi, r11
	jae	862f
	mov	r8, qword ptr [r12 + 56]
	mov	r10, rdi
	shl	r10, 5
	vmovdqu	ymm12, ymmword ptr [r8 + r10 + 2048]
	mov	r8, qword ptr [rsp + 8]
	mov	r10, qword ptr [rsp]
	vpermb	ymm12, ymm12, ymmword ptr [r10 + rsi]
	add	rsi, r10
	jmp	462b
832:
	mov	rax, r9
	sub	rax, r10
	cmp	rsi, rax
	mov	rdi, rax
	cmovb	rdi, rsi
	sub	rax, rdi
	cmp	rdi, r15
	jae	872f
	mov	r8, qword ptr [r12 + 56]
	mov	r10, rdi
	shl	r10, 5
	vmovdqu	ymm12, ymmword ptr [r8 + r10 + 2048]
	mov	r10, qword ptr [rsp]
	vpermb	ymm12, ymm12, ymmword ptr [r10 + rax]
	add	rax, r10
	jmp	502b
842:
	mov	rsi, r9
	sub	rsi, r10
	cmp	rcx, rsi
	mov	rdi, rsi
	cmovb	rdi, rcx
	sub	rsi, rdi
	cmp	rdi, r13
	jae	882f
	mov	r10, qword ptr [r12 + 56]
	mov	r12, rdi
	shl	r12, 5
	vmovdqu	ymm12, ymmword ptr [r10 + r12 + 2048]
	mov	r10, qword ptr [rsp]
	mov	r12, qword ptr [rsp + 56]
	vpermb	ymm12, ymm12, ymmword ptr [r10 + rsi]
	add	rsi, r10
	jmp	532b
852:
	mov	r10, r9
	mov	rsi, qword ptr [rsp]
	sub	r10, rsi
	cmp	rbx, r10
	mov	r12, r10
	cmovb	r12, rbx
	sub	r10, r12
	cmp	r12, rcx
	jae	892f
	mov	rsi, qword ptr [rsp + 56]
	mov	rsi, qword ptr [rsi + 56]
	mov	qword ptr [rsp + 8], rsi
	mov	rsi, r12
	shl	rsi, 5
	mov	qword ptr [rsp + 40], r14
	mov	r14, qword ptr [rsp + 8]
	vmovdqu	ymm12, ymmword ptr [r14 + rsi + 2048]
	mov	r14, qword ptr [rsp + 40]
	mov	rsi, qword ptr [rsp]
	vpermb	ymm12, ymm12, ymmword ptr [rsi + r10]
	add	r10, rsi
	jmp	562b
862:
	vmovdqu	ymm12, ymmword ptr [r10 + rsi]
	add	rsi, r10
	jmp	462b
872:
	vmovdqu	ymm12, ymmword ptr [r10 + rax]
	add	rax, r10
	jmp	502b
882:
	vmovdqu	ymm12, ymmword ptr [r10 + rsi]
	add	rsi, r10
	jmp	532b
892:
	vmovdqu	ymm12, ymmword ptr [rsi + r10]
	add	r10, rsi
	jmp	562b
	.p2align	4
902:
	mov	r9, r13
	mov	r11, r8
912:
	mov	r15, qword ptr [rsp + 72]
	cmp	rbp, r15
	mov	r14, r9
	mov	r8, r11
	mov	r11, qword ptr [rsp + 96]
	je	2b
	.p2align	4
922:
	mov	rax, r14
	sub	rax, r10
	cmp	rbx, rax
	cmovae	rbx, rax
	cmp	rbx, 31
	jbe	972f
	mov	rax, r14
	sub	rax, rbx
	vmovdqu	ymm12, ymmword ptr [rax]
932:
	mov	rax, qword ptr [rsp + 24]
	movzx	ecx, byte ptr [rax + rbp]
	movzx	eax, byte ptr [r12 + rbp + 192]
	mov	ebx, dword ptr [r12 + 4*rbp + 256]
	vpaddb	ymm12, ymm12, ymmword ptr [r8]
	vmovdqu	ymmword ptr [r14], ymm12
	cmp	al, 33
	jae	982f
942:
	add	r14, rax
	mov	edx, ecx
	shr	edx, 2
	cmp	rbx, rdx
	jb	1032f
	mov	rdi, r14
	sub	rdi, rbx
	cmp	rdi, r10
	jl	1032f
	vmovdqu	ymm12, ymmword ptr [rdi]
	mov	rsi, rbx
952:
	vmovdqu	ymmword ptr [r14], ymm12
	cmp	cl, -124
	jae	1002f
962:
	add	r14, rdx
	add	r8, rax
	inc	rbp
	cmp	rbp, r15
	jb	922b
	jmp	2b
972:
	sub	rax, rbx
	mov	rcx, qword ptr [r12 + 56]
	shl	rbx, 5
	vmovdqu	ymm12, ymmword ptr [rcx + rbx + 2048]
	vpermb	ymm12, ymm12, ymmword ptr [r10 + rax]
	jmp	932b
982:
	mov	rax, qword ptr [r12 + 48]
	mov	rdx, qword ptr [r12 + 120]
	movzx	eax, byte ptr [rax + rdx]
	inc	rdx
	mov	qword ptr [r12 + 120], rdx
	add	rax, 33
	mov	edx, 32
	.p2align	4
992:
	vmovdqu	ymm12, ymmword ptr [r8 + rdx]
	vmovdqu	ymmword ptr [r14 + rdx], ymm12
	add	rdx, 32
	cmp	rdx, rax
	jb	992b
	jmp	942b
1002:
	cmp	rsi, 31
	ja	1012f
	mov	qword ptr [r12 + 104], 1
1012:
	mov	rcx, qword ptr [r12 + 48]
	mov	rsi, qword ptr [r12 + 120]
	movzx	edx, byte ptr [rcx + rsi]
	inc	rsi
	mov	qword ptr [r12 + 120], rsi
	add	rdx, 33
	mov	ecx, 32
	.p2align	4
1022:
	vmovdqu	ymm12, ymmword ptr [rdi + rcx]
	vmovdqu	ymmword ptr [r14 + rcx], ymm12
	add	rcx, 32
	cmp	rcx, rdx
	jb	1022b
	jmp	962b
1032:
	mov	rdi, r14
	sub	rdi, r10
	cmp	rbx, rdi
	mov	rsi, rdi
	cmovb	rsi, rbx
	sub	rdi, rsi
	cmp	rsi, rdx
	jae	1042f
	mov	r13, r8
	mov	r8, qword ptr [r12 + 56]
	mov	r9, rsi
	shl	r9, 5
	vmovdqu	ymm12, ymmword ptr [r8 + r9 + 2048]
	mov	r8, r13
	vpermb	ymm12, ymm12, ymmword ptr [r10 + rdi]
	add	rdi, r10
	jmp	952b
1042:
	vmovdqu	ymm12, ymmword ptr [r10 + rdi]
	add	rdi, r10
	jmp	952b
1052:
	sub	r14, r10
	sub	r8, qword ptr [rsp + 120]
	mov	qword ptr [r12 + 80], r14
	mov	qword ptr [r12 + 88], r8
	add	rsp, 168
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	vzeroupper
	ret
	.p2align	6, 0x0
1062:
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
1072:
	.byte	2
	.p2align	6, 0x0
1082:
	.byte	1
	.p2align	2, 0x0
1092:
	.long	1
	.p2align	2, 0x0
1102:
	.long	7
	.p2align	2, 0x0
1112:
	.long	8
	.p2align	4, 0x0
1122:
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
1132:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	6, 0x0
1142:
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
1152:
	.long	134217727

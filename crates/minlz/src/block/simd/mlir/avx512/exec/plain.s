# minlz_exec_plain of crates/minlz/mlir/exec64.mlir for avx512, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 168
	mov	rbx, qword ptr [rdi]
	mov	rax, qword ptr [rdi + 8]
	mov	rcx, qword ptr [rdi + 64]
	mov	r12, qword ptr [rdi + 80]
	add	r12, rbx
	mov	r14, qword ptr [rdi + 88]
	mov	qword ptr [rsp + 128], rax
	add	r14, rax
	test	rcx, rcx
	jle	972f
	mov	rax, qword ptr [rdi + 16]
	mov	qword ptr [rsp + 136], rax
	lea	r10, [rdi + 512]
	lea	r8, [rdi + 576]
	mov	edx, 192
	mov	qword ptr [rsp + 112], rdx
	mov	edx, 7
	mov	qword ptr [rsp + 72], rdx
	mov	qword ptr [rsp + 120], 0
	vmovdqa64	zmm0, zmmword ptr [rip + 982f]
	vpbroadcastb	zmm1, byte ptr [rip + 992f]
	vpbroadcastb	zmm2, byte ptr [rip + 1002f]
	vpbroadcastd	zmm3, dword ptr [rip + 1012f]
	vpternlogd	zmm4, zmm4, zmm4, 255
	vpbroadcastd	zmm5, dword ptr [rip + 1022f]
	vpbroadcastd	zmm6, dword ptr [rip + 1032f]
	vpxor	xmm7, xmm7, xmm7
	vbroadcasti32x4	zmm8, xmmword ptr [rip + 1042f]
	vpbroadcastd	zmm9, dword ptr [rip + 1052f]
	vmovdqa64	zmm10, zmmword ptr [rip + 1062f]
	vpbroadcastd	zmm11, dword ptr [rip + 1072f]
	mov	qword ptr [rsp + 104], r10
	xor	eax, eax
	mov	qword ptr [rsp + 8], r8
	mov	qword ptr [rsp + 16], rdi
	mov	qword ptr [rsp], rbx
	mov	qword ptr [rsp + 144], rcx
	jmp	12f
	.p2align	4
2:
	inc	qword ptr [rsp + 120]
	add	qword ptr [rsp + 112], 64
	add	qword ptr [rsp + 72], -64
	add	r10, -64
	mov	rcx, qword ptr [rsp + 144]
	mov	rax, qword ptr [rsp + 160]
	cmp	rax, rcx
	mov	r8, qword ptr [rsp + 8]
	jge	972f
12:
	mov	qword ptr [rsp + 24], r14
	mov	qword ptr [rsp + 96], r10
	mov	r10, rax
	sub	rcx, rax
	cmp	rcx, 64
	mov	eax, 64
	mov	qword ptr [rsp + 32], rcx
	cmovb	rax, rcx
	mov	qword ptr [rsp + 64], rax
	mov	r14, qword ptr [rdi + 16]
	mov	rbx, qword ptr [rdi + 24]
	mov	rax, qword ptr [rdi + 32]
	mov	rdx, qword ptr [rdi + 40]
	mov	r11, qword ptr [rdi + 64]
	mov	rcx, qword ptr [rdi + 72]
	mov	qword ptr [rsp + 80], rcx
	mov	rcx, qword ptr [rdi + 96]
	mov	qword ptr [rsp + 88], rcx
	mov	r9, qword ptr [rdi + 112]
	mov	rcx, qword ptr [rdi + 128]
	mov	qword ptr [rsp + 152], rcx
	mov	rsi, qword ptr [rdi + 136]
	mov	qword ptr [rsp + 48], rsi
	lea	r15, [r11 + 7]
	lea	rsi, [r10 + 64]
	mov	qword ptr [rsp + 160], rsi
	mov	rcx, rbx
	mov	rbx, r10
	cmp	rsi, r15
	jbe	22f
	cmp	r10, r15
	mov	rdi, qword ptr [rsp + 104]
	mov	rsi, rdi
	jge	92f
	mov	rsi, qword ptr [rsp + 120]
	shl	rsi, 6
	mov	r10d, 7
	sub	r10, rsi
	add	r10, r11
	cmp	r10, 16
	mov	r13, rbx
	jb	72f
	add	rsi, r14
	mov	r8, qword ptr [rsp + 16]
	sub	r8, rsi
	add	r8, 511
	cmp	r8, 255
	mov	r8, qword ptr [rsp + 8]
	mov	r13, rbx
	jb	72f
	cmp	r10, 256
	jae	32f
	xor	ebp, ebp
	jmp	52f
	.p2align	4
22:
	add	r14, r10
	mov	rsi, r14
	jmp	92f
32:
	mov	qword ptr [rsp + 40], r12
	mov	rbp, r10
	and	rbp, -256
	lea	r13, [rbx + rbp]
	mov	rsi, qword ptr [rsp + 112]
	lea	r8, [r14 + rsi]
	mov	rsi, qword ptr [rsp + 72]
	add	rsi, r11
	and	rsi, -256
	xor	r12d, r12d
	mov	rdi, qword ptr [rsp + 16]
	.p2align	4
42:
	vmovdqu64	zmm12, zmmword ptr [r8 + r12 - 192]
	vmovdqu64	zmm13, zmmword ptr [r8 + r12 - 128]
	vmovdqu64	zmm14, zmmword ptr [r8 + r12 - 64]
	vmovdqu64	zmm15, zmmword ptr [r8 + r12]
	vmovdqu64	zmmword ptr [rdi + r12 + 512], zmm12
	vmovdqu64	zmmword ptr [rdi + r12 + 576], zmm13
	vmovdqu64	zmmword ptr [rdi + r12 + 640], zmm14
	vmovdqu64	zmmword ptr [rdi + r12 + 704], zmm15
	add	r12, 256
	cmp	rsi, r12
	jne	42b
	cmp	r10, rbp
	mov	rdi, qword ptr [rsp + 104]
	mov	rsi, rdi
	mov	r8, qword ptr [rsp + 8]
	mov	r12, qword ptr [rsp + 40]
	je	92f
	test	r10b, -16
	je	72f
52:
	mov	rsi, r10
	and	rsi, -16
	lea	r13, [rbx + rsi]
	lea	r8, [r14 + rbx]
	add	r11, qword ptr [rsp + 72]
	and	r11, -16
	.p2align	4
62:
	vmovdqu	xmm12, xmmword ptr [r8 + rbp]
	vmovdqu	xmmword ptr [rdi + rbp], xmm12
	add	rbp, 16
	cmp	r11, rbp
	jne	62b
	cmp	r10, rsi
	mov	rsi, rdi
	mov	r8, qword ptr [rsp + 8]
	je	92f
	.p2align	4
72:
	mov	r10, qword ptr [rsp + 96]
	.p2align	4
82:
	movzx	esi, byte ptr [r14 + r13]
	mov	byte ptr [r10 + r13], sil
	inc	r13
	cmp	r15, r13
	jne	82b
	mov	rsi, rdi
92:
	vmovdqu64	zmm12, zmmword ptr [rsi]
	mov	rsi, qword ptr [rsp + 64]
	vpbroadcastb	zmm13, esi
	vpcmpnleub	k2, zmm13, zmm0
	vptestmb	k1 {k2}, zmm12, zmm1
	vptestnmb	k2 {k2}, zmm12, zmm2
	mov	rbp, qword ptr [rsp + 152]
	vpexpandb	zmm12 {k1} {z}, zmmword ptr [rcx + rbp]
	mov	rdi, qword ptr [rsp + 16]
	vmovdqu64	zmmword ptr [rdi + 192], zmm12
	mov	rcx, qword ptr [rsp + 48]
	vpexpandb	zmm12 {k2} {z}, zmmword ptr [rax + rcx]
	mov	rax, qword ptr [rsp + 80]
	mov	rcx, rax
	shr	rcx, 3
	lea	rsi, [rcx + 64]
	cmp	rsi, r9
	mov	qword ptr [rsp + 56], rbx
	jbe	102f
	mov	r10, r9
	sub	r10, rcx
	mov	r15, r8
	jbe	172f
	cmp	r10, 16
	mov	r11, rcx
	jb	152f
	lea	rbx, [rcx + rdx]
	mov	rsi, rdi
	sub	rsi, rbx
	add	rsi, 575
	cmp	rsi, 255
	mov	r11, rcx
	jb	152f
	cmp	r10, 256
	jae	112f
	xor	r14d, r14d
	jmp	132f
	.p2align	4
102:
	add	rcx, rdx
	mov	r15, rcx
	jmp	172f
112:
	mov	r14, r10
	and	r14, -256
	lea	r11, [rcx + r14]
	lea	rsi, [rdx + rcx + 192]
	xor	r8d, r8d
	.p2align	4
122:
	vmovdqu64	zmm13, zmmword ptr [rsi + r8 - 192]
	vmovdqu64	zmm14, zmmword ptr [rsi + r8 - 128]
	vmovdqu64	zmm15, zmmword ptr [rsi + r8 - 64]
	vmovdqu64	zmm16, zmmword ptr [rsi + r8]
	vmovdqu64	zmmword ptr [rdi + r8 + 576], zmm13
	vmovdqu64	zmmword ptr [rdi + r8 + 640], zmm14
	vmovdqu64	zmmword ptr [rdi + r8 + 704], zmm15
	vmovdqu64	zmmword ptr [rdi + r8 + 768], zmm16
	add	r8, 256
	cmp	r14, r8
	jne	122b
	cmp	r10, r14
	mov	r8, qword ptr [rsp + 8]
	mov	r15, r8
	je	172f
	test	r10b, -16
	je	152f
132:
	mov	rsi, r10
	and	rsi, -16
	lea	r11, [rcx + rsi]
	.p2align	4
142:
	vmovdqu	xmm13, xmmword ptr [rbx + r14]
	vmovdqu	xmmword ptr [r8 + r14], xmm13
	add	r14, 16
	cmp	rsi, r14
	jne	142b
	cmp	r10, rsi
	mov	r15, r8
	je	172f
	.p2align	4
152:
	mov	rsi, r8
	sub	rsi, rcx
	.p2align	4
162:
	movzx	ecx, byte ptr [rdx + r11]
	mov	byte ptr [rsi + r11], cl
	inc	r11
	cmp	r9, r11
	jne	162b
	mov	r15, r8
172:
	mov	rcx, qword ptr [rsp + 88]
	vpbroadcastd	zmm14, ecx
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
	mov	ecx, eax
	and	ecx, 7
	vpbroadcastd	zmm18, ecx
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
	vpextrd	esi, xmm15, 3
	add	rsi, rax
	vmovdqu64	zmmword ptr [rdi + 256], zmm14
	mov	r15, qword ptr [rsp + 32]
	cmp	r15, 17
	jb	422f
	mov	rax, rsi
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, r9
	jbe	182f
	mov	rcx, r9
	sub	rcx, rax
	mov	r14, r8
	jbe	252f
	cmp	rcx, 16
	mov	r10, rax
	jb	232f
	lea	r11, [rax + rdx]
	mov	r8, rdi
	sub	r8, r11
	add	r8, 575
	cmp	r8, 255
	mov	r8, qword ptr [rsp + 8]
	mov	r10, rax
	jb	232f
	cmp	rcx, 256
	jae	192f
	xor	ebx, ebx
	jmp	212f
	.p2align	4
182:
	add	rax, rdx
	mov	r14, rax
	jmp	252f
192:
	mov	rbx, rcx
	and	rbx, -256
	lea	r10, [rax + rbx]
	lea	r8, [rdx + rax + 192]
	xor	r14d, r14d
	.p2align	4
202:
	vmovdqu64	zmm14, zmmword ptr [r8 + r14 - 192]
	vmovdqu64	zmm15, zmmword ptr [r8 + r14 - 128]
	vmovdqu64	zmm16, zmmword ptr [r8 + r14 - 64]
	vmovdqu64	zmm17, zmmword ptr [r8 + r14]
	vmovdqu64	zmmword ptr [rdi + r14 + 576], zmm14
	vmovdqu64	zmmword ptr [rdi + r14 + 640], zmm15
	vmovdqu64	zmmword ptr [rdi + r14 + 704], zmm16
	vmovdqu64	zmmword ptr [rdi + r14 + 768], zmm17
	add	r14, 256
	cmp	rbx, r14
	jne	202b
	cmp	rcx, rbx
	mov	r8, qword ptr [rsp + 8]
	mov	r14, r8
	je	252f
	test	cl, -16
	je	232f
212:
	mov	r15, r8
	mov	r8, rcx
	and	r8, -16
	lea	r10, [rax + r8]
	.p2align	4
222:
	vmovdqu	xmm14, xmmword ptr [r11 + rbx]
	vmovdqu	xmmword ptr [r15 + rbx], xmm14
	add	rbx, 16
	cmp	r8, rbx
	jne	222b
	cmp	rcx, r8
	mov	r14, r15
	mov	r8, r15
	mov	r15, qword ptr [rsp + 32]
	je	252f
232:
	mov	rcx, r8
	sub	rcx, rax
	.p2align	4
242:
	movzx	eax, byte ptr [rdx + r10]
	mov	byte ptr [rcx + r10], al
	inc	r10
	cmp	r9, r10
	jne	242b
	mov	r14, r8
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
	mov	eax, esi
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
	vmovdqu64	zmmword ptr [rdi + 320], zmm13
	vshufi64x2	zmm13, zmm14, zmm14, 255
	vextracti32x4	xmm14, zmm17, 3
	vpextrd	eax, xmm14, 3
	add	rsi, rax
	cmp	r15, 33
	jb	422f
	mov	rax, rsi
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, r9
	jbe	262f
	mov	rcx, r9
	sub	rcx, rax
	mov	r14, r8
	jbe	332f
	cmp	rcx, 16
	mov	r10, rax
	jb	312f
	lea	r11, [rax + rdx]
	mov	r8, rdi
	sub	r8, r11
	add	r8, 575
	cmp	r8, 255
	mov	r8, qword ptr [rsp + 8]
	mov	r10, rax
	jb	312f
	cmp	rcx, 256
	jae	272f
	xor	ebx, ebx
	jmp	292f
262:
	add	rax, rdx
	mov	r14, rax
	jmp	332f
272:
	mov	rbx, rcx
	and	rbx, -256
	lea	r10, [rax + rbx]
	lea	r8, [rdx + rax + 192]
	xor	r14d, r14d
	.p2align	4
282:
	vmovdqu64	zmm14, zmmword ptr [r8 + r14 - 192]
	vmovdqu64	zmm15, zmmword ptr [r8 + r14 - 128]
	vmovdqu64	zmm16, zmmword ptr [r8 + r14 - 64]
	vmovdqu64	zmm17, zmmword ptr [r8 + r14]
	vmovdqu64	zmmword ptr [rdi + r14 + 576], zmm14
	vmovdqu64	zmmword ptr [rdi + r14 + 640], zmm15
	vmovdqu64	zmmword ptr [rdi + r14 + 704], zmm16
	vmovdqu64	zmmword ptr [rdi + r14 + 768], zmm17
	add	r14, 256
	cmp	rbx, r14
	jne	282b
	cmp	rcx, rbx
	mov	r8, qword ptr [rsp + 8]
	mov	r14, r8
	je	332f
	test	cl, -16
	je	312f
292:
	mov	r15, r8
	mov	r8, rcx
	and	r8, -16
	lea	r10, [rax + r8]
	.p2align	4
302:
	vmovdqu	xmm14, xmmword ptr [r11 + rbx]
	vmovdqu	xmmword ptr [r15 + rbx], xmm14
	add	rbx, 16
	cmp	r8, rbx
	jne	302b
	cmp	rcx, r8
	mov	r14, r15
	mov	r8, r15
	mov	r15, qword ptr [rsp + 32]
	je	332f
312:
	mov	rcx, r8
	sub	rcx, rax
	.p2align	4
322:
	movzx	eax, byte ptr [rdx + r10]
	mov	byte ptr [rcx + r10], al
	inc	r10
	cmp	r9, r10
	jne	322b
	mov	r14, r8
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
	mov	eax, esi
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
	vmovdqu64	zmmword ptr [rdi + 384], zmm13
	vshufi64x2	zmm13, zmm14, zmm14, 255
	vextracti32x4	xmm14, zmm17, 3
	vpextrd	eax, xmm14, 3
	add	rsi, rax
	cmp	r15, 49
	jb	422f
	mov	rax, rsi
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, r9
	jbe	342f
	mov	rcx, r9
	sub	rcx, rax
	mov	r14, r8
	jbe	412f
	cmp	rcx, 16
	mov	r10, rax
	jb	392f
	lea	r11, [rax + rdx]
	mov	r8, rdi
	sub	r8, r11
	add	r8, 575
	cmp	r8, 255
	mov	r8, qword ptr [rsp + 8]
	mov	r10, rax
	jb	392f
	cmp	rcx, 256
	jae	352f
	xor	ebx, ebx
	jmp	372f
342:
	add	rdx, rax
	mov	r14, rdx
	jmp	412f
352:
	mov	rbx, rcx
	and	rbx, -256
	lea	r10, [rax + rbx]
	lea	r8, [rdx + rax + 192]
	xor	r14d, r14d
	.p2align	4
362:
	vmovdqu64	zmm14, zmmword ptr [r8 + r14 - 192]
	vmovdqu64	zmm15, zmmword ptr [r8 + r14 - 128]
	vmovdqu64	zmm16, zmmword ptr [r8 + r14 - 64]
	vmovdqu64	zmm17, zmmword ptr [r8 + r14]
	vmovdqu64	zmmword ptr [rdi + r14 + 576], zmm14
	vmovdqu64	zmmword ptr [rdi + r14 + 640], zmm15
	vmovdqu64	zmmword ptr [rdi + r14 + 704], zmm16
	vmovdqu64	zmmword ptr [rdi + r14 + 768], zmm17
	add	r14, 256
	cmp	rbx, r14
	jne	362b
	cmp	rcx, rbx
	mov	r8, qword ptr [rsp + 8]
	mov	r14, r8
	je	412f
	test	cl, -16
	je	392f
372:
	mov	r15, r8
	mov	r8, rcx
	and	r8, -16
	lea	r10, [rax + r8]
	.p2align	4
382:
	vmovdqu	xmm14, xmmword ptr [r11 + rbx]
	vmovdqu	xmmword ptr [r15 + rbx], xmm14
	add	rbx, 16
	cmp	r8, rbx
	jne	382b
	cmp	rcx, r8
	mov	r14, r15
	mov	r8, r15
	je	412f
392:
	mov	rcx, r8
	sub	rcx, rax
	.p2align	4
402:
	movzx	eax, byte ptr [rdx + r10]
	mov	byte ptr [rcx + r10], al
	inc	r10
	cmp	r9, r10
	jne	402b
	mov	r14, r8
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
	mov	eax, esi
	and	eax, 7
	vpbroadcastd	zmm17, eax
	vpaddd	zmm14, zmm17, zmm14
	vpsrld	zmm17, zmm14, 3
	vpandd	zmm14, zmm14, zmm5
	vpshufb	zmm17, zmm17, zmm8
	vpaddb	zmm17, zmm17, zmm9
	vpermb	zmm17, zmm17, zmmword ptr [r14]
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
	add	rsi, rax
	.p2align	4
422:
	mov	rbx, qword ptr [rsp]
	mov	r9, qword ptr [rsp + 24]
	kmovq	rax, k2
	popcnt	rax, rax
	add	rax, qword ptr [rsp + 48]
	kmovq	rcx, k1
	popcnt	rcx, rcx
	add	rcx, rbp
	vmovd	edx, xmm13
	mov	qword ptr [rdi + 72], rsi
	mov	qword ptr [rdi + 96], rdx
	mov	qword ptr [rdi + 128], rcx
	mov	qword ptr [rdi + 136], rax
	mov	rax, qword ptr [rsp + 56]
	add	rax, qword ptr [rsp + 136]
	mov	qword ptr [rsp + 56], rax
	mov	rdx, qword ptr [rsp + 64]
	and	rdx, 124
	je	842f
	xor	esi, esi
	.p2align	4
432:
	mov	rax, qword ptr [rsp + 56]
	movzx	ecx, byte ptr [rax + rsi]
	movzx	ebp, byte ptr [rdi + rsi + 192]
	cmp	rbp, 33
	mov	eax, dword ptr [rdi + 4*rsi + 256]
	vmovdqu	ymm12, ymmword ptr [r9]
	vmovdqu	ymmword ptr [r12], ymm12
	jae	562f
442:
	mov	qword ptr [rsp + 40], r12
	lea	r8, [r12 + rbp]
	mov	r12d, ecx
	shr	r12d, 2
	cmp	rax, r12
	jb	762f
	mov	r10, r8
	sub	r10, rax
	cmp	r10, rbx
	jl	762f
	vmovdqu	ymm12, ymmword ptr [r10]
452:
	vmovdqu	ymmword ptr [r8], ymm12
	cmp	cl, -124
	jae	582f
462:
	lea	rcx, [rsi + 1]
	lea	rax, [r9 + rbp]
	mov	r10, qword ptr [rsp + 56]
	movzx	r11d, byte ptr [r10 + rcx]
	movzx	r10d, byte ptr [rdi + rcx + 192]
	cmp	r10, 33
	mov	ecx, dword ptr [rdi + 4*rcx + 256]
	mov	qword ptr [rsp + 24], r9
	vmovdqu	ymm12, ymmword ptr [r9 + rbp]
	mov	r9, r10
	vmovdqu	ymmword ptr [r8 + r12], ymm12
	jae	612f
472:
	add	r8, r12
	add	r8, r9
	mov	r14d, r11d
	shr	r14d, 2
	cmp	rcx, r14
	jb	772f
	mov	r10, r8
	sub	r10, rcx
	cmp	r10, rbx
	jl	772f
	vmovdqu	ymm12, ymmword ptr [r10]
482:
	vmovdqu	ymmword ptr [r8], ymm12
	cmp	r11b, -124
	mov	qword ptr [rsp + 32], r9
	jae	632f
492:
	mov	qword ptr [rsp + 48], rbp
	lea	rcx, [rsi + 2]
	mov	r10, qword ptr [rsp + 56]
	movzx	r11d, byte ptr [r10 + rcx]
	movzx	r15d, byte ptr [rdi + rcx + 192]
	cmp	r15, 33
	mov	r13d, dword ptr [rdi + 4*rcx + 256]
	vmovdqu	ymm12, ymmword ptr [rax + r9]
	vmovdqu	ymmword ptr [r8 + r14], ymm12
	jae	662f
502:
	add	r8, r14
	add	r8, r15
	mov	ebp, r11d
	shr	ebp, 2
	cmp	r13, rbp
	jb	782f
	mov	r10, r8
	sub	r10, r13
	cmp	r10, rbx
	jl	782f
	vmovdqu	ymm12, ymmword ptr [r10]
512:
	vmovdqu	ymmword ptr [r8], ymm12
	cmp	r11b, -124
	jae	682f
522:
	lea	r10, [rsi + 3]
	add	rax, r9
	mov	rcx, qword ptr [rsp + 56]
	movzx	ebx, byte ptr [rcx + r10]
	mov	rdi, qword ptr [rsp + 16]
	movzx	ecx, byte ptr [rdi + r10 + 192]
	cmp	rcx, 33
	mov	r9d, dword ptr [rdi + 4*r10 + 256]
	vmovdqu	ymm12, ymmword ptr [rax + r15]
	vmovdqu	ymmword ptr [r8 + rbp], ymm12
	jae	712f
532:
	add	r8, rbp
	add	r8, rcx
	mov	r11d, ebx
	shr	r11d, 2
	cmp	r9, r11
	jb	792f
	mov	r10, r8
	sub	r10, r9
	cmp	r10, qword ptr [rsp]
	jl	792f
	vmovdqu	ymm12, ymmword ptr [r10]
542:
	vmovdqu	ymmword ptr [r8], ymm12
	cmp	bl, -124
	mov	rbx, qword ptr [rsp]
	jae	732f
552:
	add	rax, r15
	add	r8, r11
	add	rax, rcx
	add	rsi, 4
	cmp	rsi, rdx
	mov	r9, rax
	mov	r12, r8
	jb	432b
	jmp	852f
562:
	mov	r8, qword ptr [rdi + 48]
	mov	r10, qword ptr [rdi + 120]
	movzx	ebp, byte ptr [r8 + r10]
	inc	r10
	mov	qword ptr [rdi + 120], r10
	add	rbp, 33
	mov	r8d, 32
	.p2align	4
572:
	vmovdqu	ymm12, ymmword ptr [r9 + r8]
	vmovdqu	ymmword ptr [r12 + r8], ymm12
	add	r8, 32
	cmp	r8, rbp
	jb	572b
	jmp	442b
582:
	cmp	rax, 31
	ja	592f
	mov	qword ptr [rdi + 104], 1
592:
	mov	rax, qword ptr [rdi + 48]
	mov	rcx, qword ptr [rdi + 120]
	movzx	r12d, byte ptr [rax + rcx]
	inc	rcx
	mov	qword ptr [rdi + 120], rcx
	add	r12, 33
	mov	eax, 32
	.p2align	4
602:
	vmovdqu	ymm12, ymmword ptr [r10 + rax]
	vmovdqu	ymmword ptr [r8 + rax], ymm12
	add	rax, 32
	cmp	rax, r12
	jb	602b
	jmp	462b
612:
	mov	r10, qword ptr [rdi + 48]
	mov	r14, qword ptr [rdi + 120]
	movzx	r9d, byte ptr [r10 + r14]
	inc	r14
	mov	qword ptr [rdi + 120], r14
	add	r9, 33
	lea	r10, [rbp + r12]
	add	r10, qword ptr [rsp + 40]
	mov	r14d, 32
	.p2align	4
622:
	vmovdqu	ymm12, ymmword ptr [rax + r14]
	vmovdqu	ymmword ptr [r10 + r14], ymm12
	add	r14, 32
	cmp	r14, r9
	jb	622b
	jmp	472b
632:
	cmp	rcx, 31
	ja	642f
	mov	qword ptr [rdi + 104], 1
642:
	mov	rcx, qword ptr [rdi + 48]
	mov	r11, qword ptr [rdi + 120]
	movzx	r14d, byte ptr [rcx + r11]
	inc	r11
	mov	qword ptr [rdi + 120], r11
	add	r14, 33
	lea	rcx, [rbp + r9]
	mov	r9, qword ptr [rsp + 40]
	add	rcx, r9
	add	rcx, r12
	mov	r11d, 32
	.p2align	4
652:
	vmovdqu	ymm12, ymmword ptr [r10 + r11]
	vmovdqu	ymmword ptr [rcx + r11], ymm12
	add	r11, 32
	cmp	r11, r14
	jb	652b
	mov	r9, qword ptr [rsp + 32]
	jmp	492b
662:
	mov	rdi, qword ptr [rsp + 16]
	mov	r10, qword ptr [rdi + 48]
	mov	rcx, qword ptr [rdi + 120]
	movzx	r15d, byte ptr [r10 + rcx]
	inc	rcx
	mov	qword ptr [rdi + 120], rcx
	add	r15, 33
	mov	rcx, qword ptr [rsp + 48]
	lea	r10, [rcx + r9]
	lea	rcx, [r14 + r12]
	add	rcx, r10
	add	rcx, qword ptr [rsp + 40]
	add	r10, qword ptr [rsp + 24]
	mov	ebp, 32
	.p2align	4
672:
	vmovdqu	ymm12, ymmword ptr [r10 + rbp]
	vmovdqu	ymmword ptr [rcx + rbp], ymm12
	add	rbp, 32
	cmp	rbp, r15
	jb	672b
	jmp	502b
682:
	cmp	r13, 31
	mov	rdi, qword ptr [rsp + 16]
	ja	692f
	mov	qword ptr [rdi + 104], 1
692:
	mov	rcx, qword ptr [rdi + 48]
	mov	r11, qword ptr [rdi + 120]
	movzx	ebp, byte ptr [rcx + r11]
	inc	r11
	mov	qword ptr [rdi + 120], r11
	add	rbp, 33
	mov	rcx, qword ptr [rsp + 48]
	lea	r11, [rcx + r15]
	lea	rcx, [r14 + r9]
	add	rcx, r11
	mov	rdi, qword ptr [rsp + 40]
	add	rcx, rdi
	add	rcx, r12
	mov	r11d, 32
	.p2align	4
702:
	vmovdqu	ymm12, ymmword ptr [r10 + r11]
	vmovdqu	ymmword ptr [rcx + r11], ymm12
	add	r11, 32
	cmp	r11, rbp
	jb	702b
	jmp	522b
712:
	mov	rcx, qword ptr [rdi + 48]
	mov	r10, qword ptr [rdi + 120]
	movzx	ecx, byte ptr [rcx + r10]
	inc	r10
	mov	qword ptr [rdi + 120], r10
	add	rcx, 33
	mov	r10, qword ptr [rsp + 48]
	lea	r11, [r10 + r15]
	mov	qword ptr [rsp + 80], r11
	lea	r10, [rbp + r14]
	add	r10, r11
	mov	r11, qword ptr [rsp + 32]
	add	r11, r12
	add	r11, qword ptr [rsp + 40]
	add	r11, r10
	mov	qword ptr [rsp + 88], r11
	mov	r10, qword ptr [rsp + 24]
	add	r10, qword ptr [rsp + 32]
	add	r10, qword ptr [rsp + 80]
	mov	qword ptr [rsp + 24], r10
	mov	r10d, 32
	.p2align	4
722:
	mov	r11, qword ptr [rsp + 24]
	vmovdqu	ymm12, ymmword ptr [r11 + r10]
	mov	r11, qword ptr [rsp + 88]
	vmovdqu	ymmword ptr [r11 + r10], ymm12
	add	r10, 32
	cmp	r10, rcx
	jb	722b
	jmp	532b
732:
	cmp	r9, 31
	ja	742f
	mov	qword ptr [rdi + 104], 1
742:
	mov	r11, qword ptr [rdi + 48]
	mov	r9, qword ptr [rdi + 120]
	movzx	r11d, byte ptr [r11 + r9]
	inc	r9
	mov	qword ptr [rdi + 120], r9
	add	r11, 33
	mov	r9, qword ptr [rsp + 48]
	add	r9, rcx
	add	rbp, r15
	add	rbp, r9
	add	r14, qword ptr [rsp + 32]
	add	r14, r12
	add	r14, rbp
	mov	r12, qword ptr [rsp + 40]
	add	r12, r14
	mov	r9d, 32
	.p2align	4
752:
	vmovdqu	ymm12, ymmword ptr [r10 + r9]
	vmovdqu	ymmword ptr [r12 + r9], ymm12
	add	r9, 32
	cmp	r9, r11
	jb	752b
	jmp	552b
762:
	mov	r10, r8
	sub	r10, rbx
	cmp	rax, r10
	cmovae	rax, r10
	sub	r10, rax
	cmp	rax, r12
	jae	802f
	mov	r11, qword ptr [rdi + 56]
	mov	rbx, rax
	shl	rbx, 5
	vmovdqu	ymm12, ymmword ptr [r11 + rbx + 2048]
	mov	rbx, qword ptr [rsp]
	vpermb	ymm12, ymm12, ymmword ptr [rbx + r10]
	add	r10, rbx
	jmp	452b
772:
	mov	r10, r8
	sub	r10, rbx
	cmp	rcx, r10
	cmovae	rcx, r10
	sub	r10, rcx
	cmp	rcx, r14
	jae	812f
	mov	r15, qword ptr [rdi + 56]
	mov	r13, rcx
	shl	r13, 5
	vmovdqu	ymm12, ymmword ptr [r15 + r13 + 2048]
	mov	rdi, qword ptr [rsp + 16]
	vpermb	ymm12, ymm12, ymmword ptr [rbx + r10]
	add	r10, rbx
	jmp	482b
782:
	mov	r10, r8
	sub	r10, rbx
	cmp	r13, r10
	cmovae	r13, r10
	sub	r10, r13
	cmp	r13, rbp
	jae	822f
	mov	rcx, qword ptr [rsp + 16]
	mov	rdi, qword ptr [rcx + 56]
	mov	rcx, r13
	shl	rcx, 5
	vmovdqu	ymm12, ymmword ptr [rdi + rcx + 2048]
	vpermb	ymm12, ymm12, ymmword ptr [rbx + r10]
	add	r10, rbx
	jmp	512b
792:
	mov	r10, r8
	sub	r10, qword ptr [rsp]
	cmp	r9, r10
	cmovae	r9, r10
	sub	r10, r9
	cmp	r9, r11
	jae	832f
	mov	rdi, qword ptr [rdi + 56]
	mov	r13, r9
	shl	r13, 5
	vmovdqu	ymm12, ymmword ptr [rdi + r13 + 2048]
	mov	rdi, qword ptr [rsp + 16]
	mov	r13, qword ptr [rsp]
	vpermb	ymm12, ymm12, ymmword ptr [r13 + r10]
	add	r10, qword ptr [rsp]
	jmp	542b
802:
	vmovdqu	ymm12, ymmword ptr [rbx + r10]
	add	r10, rbx
	jmp	452b
812:
	vmovdqu	ymm12, ymmword ptr [rbx + r10]
	add	r10, rbx
	jmp	482b
822:
	vmovdqu	ymm12, ymmword ptr [rbx + r10]
	add	r10, rbx
	jmp	512b
832:
	mov	r13, qword ptr [rsp]
	vmovdqu	ymm12, ymmword ptr [r13 + r10]
	add	r10, qword ptr [rsp]
	jmp	542b
	.p2align	4
842:
	mov	r8, r12
	mov	rax, r9
852:
	cmp	rdx, qword ptr [rsp + 64]
	mov	r12, r8
	mov	r14, rax
	mov	r10, qword ptr [rsp + 96]
	je	2b
	.p2align	4
862:
	mov	rax, qword ptr [rsp + 56]
	movzx	esi, byte ptr [rax + rdx]
	movzx	eax, byte ptr [rdi + rdx + 192]
	cmp	rax, 33
	mov	ecx, dword ptr [rdi + 4*rdx + 256]
	vmovdqu	ymm12, ymmword ptr [r14]
	vmovdqu	ymmword ptr [r12], ymm12
	jae	902f
872:
	add	r12, rax
	mov	r8d, esi
	shr	r8d, 2
	cmp	rcx, r8
	jb	952f
	mov	r9, r12
	sub	r9, rcx
	cmp	r9, rbx
	jl	952f
	vmovdqu	ymm12, ymmword ptr [r9]
882:
	vmovdqu	ymmword ptr [r12], ymm12
	cmp	sil, -124
	jae	922f
892:
	add	r12, r8
	add	r14, rax
	inc	rdx
	cmp	rdx, qword ptr [rsp + 64]
	jb	862b
	jmp	2b
902:
	mov	rax, qword ptr [rdi + 48]
	mov	r8, qword ptr [rdi + 120]
	movzx	eax, byte ptr [rax + r8]
	inc	r8
	mov	qword ptr [rdi + 120], r8
	add	rax, 33
	mov	r8d, 32
	.p2align	4
912:
	vmovdqu	ymm12, ymmword ptr [r14 + r8]
	vmovdqu	ymmword ptr [r12 + r8], ymm12
	add	r8, 32
	cmp	r8, rax
	jb	912b
	jmp	872b
922:
	cmp	rcx, 31
	ja	932f
	mov	qword ptr [rdi + 104], 1
932:
	mov	rcx, qword ptr [rdi + 48]
	mov	rsi, qword ptr [rdi + 120]
	movzx	r8d, byte ptr [rcx + rsi]
	inc	rsi
	mov	qword ptr [rdi + 120], rsi
	add	r8, 33
	mov	ecx, 32
	.p2align	4
942:
	vmovdqu	ymm12, ymmword ptr [r9 + rcx]
	vmovdqu	ymmword ptr [r12 + rcx], ymm12
	add	rcx, 32
	cmp	rcx, r8
	jb	942b
	jmp	892b
952:
	mov	r9, r12
	sub	r9, rbx
	cmp	rcx, r9
	cmovae	rcx, r9
	sub	r9, rcx
	cmp	rcx, r8
	jae	962f
	mov	r10, qword ptr [rdi + 56]
	mov	r11, rcx
	shl	r11, 5
	vmovdqu	ymm12, ymmword ptr [r10 + r11 + 2048]
	mov	r10, qword ptr [rsp + 96]
	vpermb	ymm12, ymm12, ymmword ptr [rbx + r9]
	add	r9, rbx
	jmp	882b
962:
	vmovdqu	ymm12, ymmword ptr [rbx + r9]
	add	r9, rbx
	jmp	882b
972:
	sub	r12, rbx
	sub	r14, qword ptr [rsp + 128]
	mov	qword ptr [rdi + 80], r12
	mov	qword ptr [rdi + 88], r14
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
982:
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
992:
	.byte	2
	.p2align	6, 0x0
1002:
	.byte	1
	.p2align	2, 0x0
1012:
	.long	1
	.p2align	2, 0x0
1022:
	.long	7
	.p2align	2, 0x0
1032:
	.long	8
	.p2align	4, 0x0
1042:
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
1052:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	6, 0x0
1062:
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
1072:
	.long	134217727

# minlz_exec_flat_delta of crates/minlz/mlir/exec64.mlir for avx512, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 176
	mov	rax, qword ptr [rdi + 64]
	mov	r12, qword ptr [rdi + 80]
	mov	rcx, qword ptr [rdi + 88]
	mov	qword ptr [rsp + 16], rcx
	test	rax, rax
	mov	qword ptr [rsp], rdi
	jle	772f
	mov	r14, qword ptr [rdi]
	mov	rbx, qword ptr [rdi + 8]
	mov	rcx, qword ptr [rdi + 16]
	mov	qword ptr [rsp + 144], rcx
	mov	r11, qword ptr [rdi + 96]
	lea	rcx, [rdi + 512]
	lea	rdx, [rdi + 576]
	mov	qword ptr [rsp + 104], rdx
	mov	edx, 192
	mov	qword ptr [rsp + 112], rdx
	mov	edx, 7
	mov	qword ptr [rsp + 88], rdx
	mov	qword ptr [rsp + 120], 0
	vmovdqa64	zmm0, zmmword ptr [rip + 782f]
	vpbroadcastb	zmm1, byte ptr [rip + 792f]
	vpbroadcastb	zmm2, byte ptr [rip + 802f]
	vpbroadcastd	zmm3, dword ptr [rip + 812f]
	vpternlogd	zmm4, zmm4, zmm4, 255
	vpbroadcastd	zmm5, dword ptr [rip + 822f]
	vpbroadcastd	zmm6, dword ptr [rip + 832f]
	vpxor	xmm7, xmm7, xmm7
	vbroadcasti32x4	zmm8, xmmword ptr [rip + 842f]
	vpbroadcastd	zmm9, dword ptr [rip + 852f]
	vmovdqa64	zmm10, zmmword ptr [rip + 862f]
	vpbroadcastd	zmm11, dword ptr [rip + 872f]
	mov	r8, rcx
	xor	edx, edx
	mov	qword ptr [rsp + 152], rax
	mov	qword ptr [rsp + 136], rcx
	mov	qword ptr [rsp + 32], r14
	mov	qword ptr [rsp + 80], rbx
	jmp	12f
	.p2align	4
2:
	mov	qword ptr [rsp + 16], r8
	inc	qword ptr [rsp + 120]
	add	qword ptr [rsp + 112], 64
	add	qword ptr [rsp + 88], -64
	mov	r8, qword ptr [rsp + 72]
	add	r8, -64
	mov	rax, qword ptr [rsp + 152]
	mov	rdx, qword ptr [rsp + 168]
	cmp	rdx, rax
	mov	rcx, qword ptr [rsp + 136]
	jge	772f
12:
	mov	qword ptr [rsp + 48], r11
	mov	qword ptr [rsp + 40], r12
	mov	rsi, rax
	sub	rsi, rdx
	cmp	rsi, 64
	mov	eax, 64
	mov	qword ptr [rsp + 8], rsi
	cmovb	rax, rsi
	mov	qword ptr [rsp + 96], rax
	mov	rdi, qword ptr [rsp]
	mov	rbx, qword ptr [rdi + 16]
	mov	rax, qword ptr [rdi + 24]
	mov	qword ptr [rsp + 160], rax
	mov	rsi, qword ptr [rdi + 32]
	mov	r9, qword ptr [rdi + 40]
	mov	r15, qword ptr [rdi + 64]
	mov	rax, qword ptr [rdi + 72]
	mov	qword ptr [rsp + 64], rax
	mov	rax, qword ptr [rdi + 96]
	mov	qword ptr [rsp + 56], rax
	mov	r13, qword ptr [rdi + 112]
	mov	r10, qword ptr [rdi + 128]
	mov	rdi, qword ptr [rdi + 136]
	lea	r14, [r15 + 7]
	lea	rax, [rdx + 64]
	mov	qword ptr [rsp + 168], rax
	cmp	rax, r14
	mov	qword ptr [rsp + 72], r8
	mov	qword ptr [rsp + 24], rdx
	jbe	22f
	cmp	rdx, r14
	mov	rdx, rcx
	jge	82f
	mov	rdx, qword ptr [rsp + 120]
	shl	rdx, 6
	mov	r11d, 7
	sub	r11, rdx
	add	r11, r15
	cmp	r11, 16
	mov	rbp, qword ptr [rsp + 24]
	jb	72f
	add	rdx, rbx
	mov	r8, qword ptr [rsp]
	sub	r8, rdx
	add	r8, 511
	cmp	r8, 255
	mov	r8, qword ptr [rsp + 72]
	mov	rbp, qword ptr [rsp + 24]
	jb	72f
	cmp	r11, 256
	jae	32f
	xor	r12d, r12d
	jmp	52f
	.p2align	4
22:
	add	rbx, rdx
	mov	rdx, rbx
	jmp	82f
32:
	mov	qword ptr [rsp + 128], rdi
	mov	rdi, r10
	mov	r12, r11
	and	r12, -256
	mov	rax, qword ptr [rsp + 24]
	lea	rbp, [rax + r12]
	mov	rax, qword ptr [rsp + 112]
	lea	r10, [rbx + rax]
	mov	rax, qword ptr [rsp + 88]
	lea	rdx, [r15 + rax]
	and	rdx, -256
	xor	r8d, r8d
	mov	rax, qword ptr [rsp]
	.p2align	4
42:
	vmovdqu64	zmm12, zmmword ptr [r10 + r8 - 192]
	vmovdqu64	zmm13, zmmword ptr [r10 + r8 - 128]
	vmovdqu64	zmm14, zmmword ptr [r10 + r8 - 64]
	vmovdqu64	zmm15, zmmword ptr [r10 + r8]
	vmovdqu64	zmmword ptr [rax + r8 + 512], zmm12
	vmovdqu64	zmmword ptr [rax + r8 + 576], zmm13
	vmovdqu64	zmmword ptr [rax + r8 + 640], zmm14
	vmovdqu64	zmmword ptr [rax + r8 + 704], zmm15
	add	r8, 256
	cmp	rdx, r8
	jne	42b
	cmp	r11, r12
	mov	rdx, rcx
	mov	r8, qword ptr [rsp + 72]
	mov	r10, rdi
	mov	rdi, qword ptr [rsp + 128]
	je	82f
	test	r11b, -16
	je	72f
52:
	mov	rdx, r11
	and	rdx, -16
	mov	rax, qword ptr [rsp + 24]
	lea	rbp, [rax + rdx]
	lea	r8, [rbx + rax]
	add	r15, qword ptr [rsp + 88]
	and	r15, -16
	.p2align	4
62:
	vmovdqu	xmm12, xmmword ptr [r8 + r12]
	vmovdqu	xmmword ptr [rcx + r12], xmm12
	add	r12, 16
	cmp	r15, r12
	jne	62b
	cmp	r11, rdx
	mov	rdx, rcx
	mov	r8, qword ptr [rsp + 72]
	je	82f
	.p2align	4
72:
	movzx	edx, byte ptr [rbx + rbp]
	mov	byte ptr [r8 + rbp], dl
	inc	rbp
	cmp	r14, rbp
	jne	72b
	mov	rdx, rcx
82:
	vmovdqu64	zmm12, zmmword ptr [rdx]
	mov	rax, qword ptr [rsp + 96]
	vpbroadcastb	zmm13, eax
	vpcmpnleub	k2, zmm13, zmm0
	vptestmb	k1 {k2}, zmm12, zmm1
	vptestnmb	k2 {k2}, zmm12, zmm2
	mov	rax, qword ptr [rsp + 160]
	vpexpandb	zmm12 {k1} {z}, zmmword ptr [rax + r10]
	mov	rax, qword ptr [rsp]
	vmovdqu64	zmmword ptr [rax + 192], zmm12
	mov	r12, rdi
	vpexpandb	zmm12 {k2} {z}, zmmword ptr [rsi + rdi]
	mov	rsi, qword ptr [rsp + 64]
	mov	rdx, rsi
	shr	rdx, 3
	lea	r8, [rdx + 64]
	cmp	r8, r13
	jbe	92f
	mov	r8, r13
	sub	r8, rdx
	mov	rcx, qword ptr [rsp + 104]
	mov	r15, rcx
	mov	rbp, qword ptr [rsp + 40]
	mov	rax, qword ptr [rsp + 8]
	jbe	162f
	cmp	r8, 16
	mov	rbx, rdx
	jb	142f
	lea	r14, [rdx + r9]
	mov	rdi, r10
	mov	r10, qword ptr [rsp]
	sub	r10, r14
	add	r10, 575
	cmp	r10, 255
	mov	r10, rdi
	mov	rbx, rdx
	jb	142f
	cmp	r8, 256
	jae	102f
	xor	r11d, r11d
	jmp	122f
	.p2align	4
92:
	add	rdx, r9
	mov	r15, rdx
	mov	rcx, qword ptr [rsp + 104]
	mov	rbp, qword ptr [rsp + 40]
	mov	rax, qword ptr [rsp + 8]
	jmp	162f
102:
	mov	r11, r8
	and	r11, -256
	lea	rbx, [rdx + r11]
	lea	r10, [r9 + rdx + 192]
	xor	r15d, r15d
	mov	rax, qword ptr [rsp]
	.p2align	4
112:
	vmovdqu64	zmm13, zmmword ptr [r10 + r15 - 192]
	vmovdqu64	zmm14, zmmword ptr [r10 + r15 - 128]
	vmovdqu64	zmm15, zmmword ptr [r10 + r15 - 64]
	vmovdqu64	zmm16, zmmword ptr [r10 + r15]
	vmovdqu64	zmmword ptr [rax + r15 + 576], zmm13
	vmovdqu64	zmmword ptr [rax + r15 + 640], zmm14
	vmovdqu64	zmmword ptr [rax + r15 + 704], zmm15
	vmovdqu64	zmmword ptr [rax + r15 + 768], zmm16
	add	r15, 256
	cmp	r11, r15
	jne	112b
	cmp	r8, r11
	mov	r15, rcx
	mov	r10, rdi
	mov	rax, qword ptr [rsp + 8]
	je	162f
	test	r8b, -16
	je	142f
122:
	mov	r10, r8
	and	r10, -16
	lea	rbx, [rdx + r10]
	.p2align	4
132:
	vmovdqu	xmm13, xmmword ptr [r14 + r11]
	vmovdqu	xmmword ptr [rcx + r11], xmm13
	add	r11, 16
	cmp	r10, r11
	jne	132b
	cmp	r8, r10
	mov	r15, rcx
	mov	r10, rdi
	je	162f
	.p2align	4
142:
	mov	r8, rcx
	sub	r8, rdx
	.p2align	4
152:
	movzx	edx, byte ptr [r9 + rbx]
	mov	byte ptr [r8 + rbx], dl
	inc	rbx
	cmp	r13, rbx
	jne	152b
	mov	r15, rcx
162:
	mov	rdx, qword ptr [rsp + 56]
	vpbroadcastd	zmm14, edx
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
	mov	edx, esi
	and	edx, 7
	vpbroadcastd	zmm18, edx
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
	add	r11, rsi
	mov	rdx, qword ptr [rsp]
	vmovdqu64	zmmword ptr [rdx + 256], zmm14
	cmp	rax, 17
	jb	332f
	mov	rdx, r11
	shr	rdx, 3
	lea	rsi, [rdx + 64]
	cmp	rsi, r13
	jbe	172f
	mov	rsi, r13
	sub	rsi, rdx
	mov	r15, rcx
	jbe	242f
	cmp	rsi, 16
	mov	r8, rdx
	jb	222f
	lea	rbx, [rdx + r9]
	mov	r8, qword ptr [rsp]
	sub	r8, rbx
	add	r8, 575
	cmp	r8, 255
	mov	r8, rdx
	jb	222f
	cmp	rsi, 256
	jae	182f
	xor	r14d, r14d
	jmp	202f
	.p2align	4
172:
	add	rdx, r9
	mov	r15, rdx
	jmp	242f
182:
	mov	rdi, r10
	mov	r14, rsi
	and	r14, -256
	lea	r8, [rdx + r14]
	lea	r10, [r9 + rdx + 192]
	xor	r15d, r15d
	mov	rax, qword ptr [rsp]
	.p2align	4
192:
	vmovdqu64	zmm14, zmmword ptr [r10 + r15 - 192]
	vmovdqu64	zmm15, zmmword ptr [r10 + r15 - 128]
	vmovdqu64	zmm16, zmmword ptr [r10 + r15 - 64]
	vmovdqu64	zmm17, zmmword ptr [r10 + r15]
	vmovdqu64	zmmword ptr [rax + r15 + 576], zmm14
	vmovdqu64	zmmword ptr [rax + r15 + 640], zmm15
	vmovdqu64	zmmword ptr [rax + r15 + 704], zmm16
	vmovdqu64	zmmword ptr [rax + r15 + 768], zmm17
	add	r15, 256
	cmp	r14, r15
	jne	192b
	cmp	rsi, r14
	mov	r15, rcx
	mov	r10, rdi
	mov	rax, qword ptr [rsp + 8]
	je	242f
	test	sil, -16
	je	222f
202:
	mov	rax, r10
	mov	r10, rsi
	and	r10, -16
	lea	r8, [rdx + r10]
	.p2align	4
212:
	vmovdqu	xmm14, xmmword ptr [rbx + r14]
	vmovdqu	xmmword ptr [rcx + r14], xmm14
	add	r14, 16
	cmp	r10, r14
	jne	212b
	cmp	rsi, r10
	mov	r15, rcx
	mov	r10, rax
	mov	rax, qword ptr [rsp + 8]
	je	242f
222:
	mov	rsi, rcx
	sub	rsi, rdx
	.p2align	4
232:
	movzx	edx, byte ptr [r9 + r8]
	mov	byte ptr [rsi + r8], dl
	inc	r8
	cmp	r13, r8
	jne	232b
	mov	r15, rcx
242:
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
	mov	edx, r11d
	and	edx, 7
	vpbroadcastd	zmm18, edx
	vpaddd	zmm15, zmm18, zmm15
	vpsrld	zmm18, zmm15, 3
	vpandd	zmm15, zmm15, zmm5
	vpshufb	zmm18, zmm18, zmm8
	vpaddb	zmm18, zmm18, zmm9
	vpermb	zmm18, zmm18, zmmword ptr [r15]
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
	mov	rsi, qword ptr [rsp]
	vmovdqu64	zmmword ptr [rsi + 320], zmm13
	vshufi64x2	zmm13, zmm14, zmm14, 255
	vextracti32x4	xmm14, zmm17, 3
	vpextrd	edx, xmm14, 3
	add	r11, rdx
	cmp	rax, 33
	jb	332f
	mov	rdx, r11
	shr	rdx, 3
	lea	rsi, [rdx + 64]
	cmp	rsi, r13
	jbe	252f
	mov	rsi, r13
	sub	rsi, rdx
	mov	r15, rcx
	jbe	322f
	cmp	rsi, 16
	mov	r8, rdx
	jb	302f
	lea	rbx, [rdx + r9]
	mov	r8, qword ptr [rsp]
	sub	r8, rbx
	add	r8, 575
	cmp	r8, 255
	mov	r8, rdx
	jb	302f
	cmp	rsi, 256
	jae	262f
	xor	r14d, r14d
	jmp	282f
252:
	add	rdx, r9
	mov	r15, rdx
	jmp	322f
262:
	mov	rdi, r10
	mov	r14, rsi
	and	r14, -256
	lea	r8, [rdx + r14]
	lea	r10, [r9 + rdx + 192]
	xor	r15d, r15d
	mov	rax, qword ptr [rsp]
	.p2align	4
272:
	vmovdqu64	zmm14, zmmword ptr [r10 + r15 - 192]
	vmovdqu64	zmm15, zmmword ptr [r10 + r15 - 128]
	vmovdqu64	zmm16, zmmword ptr [r10 + r15 - 64]
	vmovdqu64	zmm17, zmmword ptr [r10 + r15]
	vmovdqu64	zmmword ptr [rax + r15 + 576], zmm14
	vmovdqu64	zmmword ptr [rax + r15 + 640], zmm15
	vmovdqu64	zmmword ptr [rax + r15 + 704], zmm16
	vmovdqu64	zmmword ptr [rax + r15 + 768], zmm17
	add	r15, 256
	cmp	r14, r15
	jne	272b
	cmp	rsi, r14
	mov	r15, rcx
	mov	r10, rdi
	mov	rax, qword ptr [rsp + 8]
	je	322f
	test	sil, -16
	je	302f
282:
	mov	rax, r10
	mov	r10, rsi
	and	r10, -16
	lea	r8, [rdx + r10]
	.p2align	4
292:
	vmovdqu	xmm14, xmmword ptr [rbx + r14]
	vmovdqu	xmmword ptr [rcx + r14], xmm14
	add	r14, 16
	cmp	r10, r14
	jne	292b
	cmp	rsi, r10
	mov	r15, rcx
	mov	r10, rax
	mov	rax, qword ptr [rsp + 8]
	je	322f
302:
	mov	rsi, rcx
	sub	rsi, rdx
	.p2align	4
312:
	movzx	edx, byte ptr [r9 + r8]
	mov	byte ptr [rsi + r8], dl
	inc	r8
	cmp	r13, r8
	jne	312b
	mov	r15, rcx
322:
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
	mov	edx, r11d
	and	edx, 7
	vpbroadcastd	zmm18, edx
	vpaddd	zmm15, zmm18, zmm15
	vpsrld	zmm18, zmm15, 3
	vpandd	zmm15, zmm15, zmm5
	vpshufb	zmm18, zmm18, zmm8
	vpaddb	zmm18, zmm18, zmm9
	vpermb	zmm18, zmm18, zmmword ptr [r15]
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
	mov	rsi, qword ptr [rsp]
	vmovdqu64	zmmword ptr [rsi + 384], zmm13
	vshufi64x2	zmm13, zmm14, zmm14, 255
	vextracti32x4	xmm14, zmm17, 3
	vpextrd	edx, xmm14, 3
	add	r11, rdx
	cmp	rax, 49
	jb	332f
	mov	rdx, r11
	shr	rdx, 3
	lea	rsi, [rdx + 64]
	cmp	rsi, r13
	mov	r15, qword ptr [rsp + 16]
	jbe	692f
	mov	rsi, r13
	sub	rsi, rdx
	mov	r14, rcx
	jbe	762f
	cmp	rsi, 16
	mov	r8, rdx
	jb	742f
	lea	rdi, [rdx + r9]
	mov	r8, qword ptr [rsp]
	sub	r8, rdi
	add	r8, 575
	cmp	r8, 255
	mov	r8, rdx
	jb	742f
	cmp	rsi, 256
	jae	702f
	xor	ebx, ebx
	jmp	722f
	.p2align	4
332:
	mov	r14, qword ptr [rsp + 32]
	mov	r15, qword ptr [rsp + 16]
342:
	kmovq	rdx, k2
	popcnt	rdx, rdx
	add	rdx, r12
	kmovq	rsi, k1
	popcnt	rsi, rsi
	add	rsi, r10
	vmovd	r8d, xmm13
	mov	rax, qword ptr [rsp]
	mov	qword ptr [rax + 72], r11
	mov	qword ptr [rax + 96], r8
	mov	qword ptr [rax + 128], rsi
	mov	qword ptr [rax + 136], rdx
	mov	r13, qword ptr [rsp + 24]
	add	r13, qword ptr [rsp + 144]
	mov	r9, qword ptr [rsp + 96]
	and	r9, 124
	mov	rbx, qword ptr [rsp + 80]
	je	602f
	xor	r10d, r10d
	mov	qword ptr [rsp + 24], r13
	.p2align	4
352:
	movzx	edi, byte ptr [r13 + r10]
	mov	r8, qword ptr [rsp]
	movzx	r12d, byte ptr [r8 + r10 + 192]
	mov	rcx, qword ptr [rsp + 48]
	cmp	rcx, 33
	mov	eax, 32
	cmovb	rcx, rax
	mov	rdx, rbp
	sub	rdx, rcx
	mov	esi, 0
	cmovae	rsi, rdx
	cmp	r12, 33
	mov	eax, dword ptr [r8 + 4*r10 + 256]
	vmovdqu	ymm12, ymmword ptr [r14 + rsi]
	vpaddb	ymm12, ymm12, ymmword ptr [rbx + r15]
	vmovdqu	ymmword ptr [r14 + rbp], ymm12
	jae	442f
362:
	mov	esi, edi
	lea	rcx, [r12 + rbp]
	shr	edi, 2
	cmp	rdi, 32
	mov	edx, 32
	cmovb	rdx, rdi
	cmp	rax, rdx
	cmova	rdx, rax
	mov	r8, rcx
	sub	r8, rdx
	mov	r14d, 0
	cmovae	r14, r8
	mov	r8, qword ptr [rsp + 32]
	vmovdqu	ymm12, ymmword ptr [r8 + r14]
	mov	r11, qword ptr [rsp + 32]
	vmovdqu	ymmword ptr [r11 + rcx], ymm12
	cmp	sil, -124
	mov	r14, qword ptr [rsp]
	jae	462f
372:
	mov	qword ptr [rsp + 40], rbp
	lea	rdx, [r10 + 1]
	mov	qword ptr [rsp + 16], r15
	mov	qword ptr [rsp + 8], r12
	add	r15, r12
	add	rcx, rdi
	cmp	rax, 33
	mov	esi, 32
	cmovb	rax, rsi
	mov	rsi, rcx
	sub	rsi, rax
	mov	eax, 0
	cmovae	rax, rsi
	movzx	esi, byte ptr [r13 + rdx]
	vmovdqu	ymm12, ymmword ptr [r11 + rax]
	movzx	ebp, byte ptr [r14 + rdx + 192]
	cmp	rbp, 33
	mov	eax, dword ptr [r14 + 4*rdx + 256]
	vpaddb	ymm12, ymm12, ymmword ptr [rbx + r15]
	vmovdqu	ymmword ptr [r11 + rcx], ymm12
	jae	482f
382:
	mov	r8d, esi
	add	rcx, rbp
	shr	esi, 2
	cmp	rsi, 32
	mov	edx, 32
	cmovb	rdx, rsi
	cmp	rax, rdx
	cmova	rdx, rax
	mov	r12, rcx
	sub	r12, rdx
	mov	r13d, 0
	cmovae	r13, r12
	vmovdqu	ymm12, ymmword ptr [r11 + r13]
	vmovdqu	ymmword ptr [r11 + rcx], ymm12
	cmp	r8b, -124
	mov	qword ptr [rsp + 56], rbp
	jae	502f
392:
	lea	r8, [r10 + 2]
	add	r15, rbp
	add	rcx, rsi
	mov	rdx, qword ptr [rsp + 24]
	movzx	ebp, byte ptr [rdx + r8]
	movzx	edx, byte ptr [r14 + r8 + 192]
	cmp	rax, 33
	mov	r12d, 32
	cmovb	rax, r12
	mov	r12, rcx
	sub	r12, rax
	mov	r13d, 0
	cmovae	r13, r12
	cmp	rdx, 33
	mov	eax, dword ptr [r14 + 4*r8 + 256]
	vmovdqu	ymm12, ymmword ptr [r11 + r13]
	vpaddb	ymm12, ymm12, ymmword ptr [rbx + r15]
	vmovdqu	ymmword ptr [r11 + rcx], ymm12
	jae	522f
402:
	mov	r12d, ebp
	add	rcx, rdx
	shr	ebp, 2
	cmp	rbp, 32
	mov	r8d, 32
	cmovb	r8, rbp
	cmp	rax, r8
	cmova	r8, rax
	mov	r13, rcx
	sub	r13, r8
	mov	ebx, 0
	cmovae	rbx, r13
	vmovdqu	ymm12, ymmword ptr [r11 + rbx]
	vmovdqu	ymmword ptr [r11 + rcx], ymm12
	cmp	r12b, -124
	mov	r13, rdx
	mov	qword ptr [rsp + 64], rdx
	jae	542f
412:
	mov	rdx, r9
	lea	rbx, [r10 + 3]
	add	r15, r13
	add	rcx, rbp
	mov	r8, qword ptr [rsp + 24]
	movzx	r12d, byte ptr [r8 + rbx]
	movzx	r8d, byte ptr [r14 + rbx + 192]
	cmp	rax, 33
	mov	r13d, 32
	cmovb	rax, r13
	mov	r13, rcx
	sub	r13, rax
	mov	eax, 0
	cmovae	rax, r13
	cmp	r8, 33
	mov	r9d, dword ptr [r14 + 4*rbx + 256]
	vmovdqu	ymm12, ymmword ptr [r11 + rax]
	mov	rbx, qword ptr [rsp + 80]
	vpaddb	ymm12, ymm12, ymmword ptr [rbx + r15]
	vmovdqu	ymmword ptr [r11 + rcx], ymm12
	mov	qword ptr [rsp + 48], r9
	jae	562f
422:
	mov	eax, r12d
	add	rcx, r8
	shr	r12d, 2
	cmp	r12, 32
	mov	r13d, 32
	cmovb	r13, r12
	cmp	r9, r13
	cmova	r13, r9
	mov	rbx, rcx
	sub	rbx, r13
	mov	r14d, 0
	cmovae	r14, rbx
	mov	rbx, qword ptr [rsp + 32]
	vmovdqu	ymm12, ymmword ptr [rbx + r14]
	mov	r14, qword ptr [rsp + 32]
	vmovdqu	ymmword ptr [r14 + rcx], ymm12
	cmp	al, -124
	mov	r9, rdx
	jae	582f
432:
	add	r8, r15
	add	r12, rcx
	add	r10, 4
	cmp	r10, r9
	mov	r15, r8
	mov	rbp, r12
	mov	rbx, qword ptr [rsp + 80]
	mov	r13, qword ptr [rsp + 24]
	jb	352b
	jmp	612f
442:
	lea	rdx, [rbx + r15]
	lea	rsi, [r14 + rbp]
	mov	rcx, qword ptr [rsp]
	mov	r8, qword ptr [rcx + 48]
	mov	rcx, qword ptr [rsp]
	mov	rbx, qword ptr [rcx + 120]
	movzx	r12d, byte ptr [r8 + rbx]
	inc	rbx
	mov	rcx, qword ptr [rsp]
	mov	qword ptr [rcx + 120], rbx
	add	r12, 33
	mov	r8d, 32
	.p2align	4
452:
	vmovdqu	ymm12, ymmword ptr [rdx + r8]
	vmovdqu	ymmword ptr [rsi + r8], ymm12
	add	r8, 32
	cmp	r8, r12
	jb	452b
	mov	rbx, qword ptr [rsp + 80]
	jmp	362b
462:
	lea	rsi, [r11 + rcx]
	mov	r8, qword ptr [r14 + 48]
	mov	rdi, qword ptr [rsp]
	mov	r14, qword ptr [rdi + 120]
	movzx	edi, byte ptr [r8 + r14]
	inc	r14
	mov	r8, qword ptr [rsp]
	mov	qword ptr [r8 + 120], r14
	mov	r14, qword ptr [rsp]
	add	rdi, 33
	cmp	rdx, rcx
	cmovae	rdx, rcx
	mov	r8, rsi
	sub	r8, rdx
	mov	edx, 32
	.p2align	4
472:
	vmovdqu	ymm12, ymmword ptr [r8 + rdx]
	vmovdqu	ymmword ptr [rsi + rdx], ymm12
	add	rdx, 32
	cmp	rdx, rdi
	jb	472b
	mov	r11, qword ptr [rsp + 32]
	jmp	372b
482:
	lea	rdx, [rbx + r15]
	mov	r8, qword ptr [r14 + 48]
	mov	r12, qword ptr [r14 + 120]
	movzx	ebp, byte ptr [r8 + r12]
	inc	r12
	mov	qword ptr [r14 + 120], r12
	add	rbp, 33
	lea	r8, [r11 + rcx]
	mov	r12d, 32
	.p2align	4
492:
	vmovdqu	ymm12, ymmword ptr [rdx + r12]
	vmovdqu	ymmword ptr [r8 + r12], ymm12
	add	r12, 32
	cmp	r12, rbp
	jb	492b
	jmp	382b
502:
	lea	r8, [r11 + rcx]
	mov	rsi, qword ptr [r14 + 48]
	mov	r12, qword ptr [r14 + 120]
	movzx	esi, byte ptr [rsi + r12]
	inc	r12
	mov	qword ptr [r14 + 120], r12
	add	rsi, 33
	mov	r12, qword ptr [rsp + 8]
	lea	r13, [rdi + r12]
	mov	r12, qword ptr [rsp + 40]
	add	r12, rbp
	add	r12, r13
	cmp	rdx, rcx
	cmovae	rdx, rcx
	sub	r12, rdx
	add	r12, r11
	mov	edx, 32
	.p2align	4
512:
	vmovdqu	ymm12, ymmword ptr [r12 + rdx]
	vmovdqu	ymmword ptr [r8 + rdx], ymm12
	add	rdx, 32
	cmp	rdx, rsi
	jb	512b
	mov	rbp, qword ptr [rsp + 56]
	jmp	392b
522:
	mov	rdx, qword ptr [r14 + 48]
	mov	r8, qword ptr [r14 + 120]
	movzx	r13d, byte ptr [rdx + r8]
	inc	r8
	mov	qword ptr [r14 + 120], r8
	add	r13, 33
	mov	rdx, qword ptr [rsp + 8]
	lea	r12, [rdi + rdx]
	mov	rdx, qword ptr [rsp + 56]
	lea	r8, [rsi + rdx]
	mov	rdx, r13
	add	r8, r12
	add	r8, qword ptr [rsp + 40]
	add	r8, r11
	lea	r12, [rbx + r15]
	mov	r13d, 32
	.p2align	4
532:
	vmovdqu	ymm12, ymmword ptr [r12 + r13]
	vmovdqu	ymmword ptr [r8 + r13], ymm12
	add	r13, 32
	cmp	r13, rdx
	jb	532b
	jmp	402b
542:
	lea	r12, [r11 + rcx]
	mov	rbx, qword ptr [r14 + 48]
	mov	rdx, qword ptr [r14 + 120]
	movzx	ebp, byte ptr [rbx + rdx]
	inc	rdx
	mov	qword ptr [r14 + 120], rdx
	add	rbp, 33
	mov	rdx, qword ptr [rsp + 8]
	lea	r13, [r13 + rsi]
	add	r13, rdi
	add	r13, rdx
	mov	rbx, qword ptr [rsp + 40]
	mov	rdx, qword ptr [rsp + 56]
	add	rbx, rdx
	add	r13, rbx
	cmp	r8, rcx
	cmovae	r8, rcx
	sub	r13, r8
	add	r13, r11
	mov	r8d, 32
	.p2align	4
552:
	vmovdqu	ymm12, ymmword ptr [r13 + r8]
	vmovdqu	ymmword ptr [r12 + r8], ymm12
	add	r8, 32
	cmp	r8, rbp
	jb	552b
	mov	r13, qword ptr [rsp + 64]
	jmp	412b
562:
	mov	rax, qword ptr [r14 + 48]
	mov	r13, qword ptr [r14 + 120]
	movzx	r8d, byte ptr [rax + r13]
	inc	r13
	mov	qword ptr [r14 + 120], r13
	add	r8, 33
	mov	r9, qword ptr [rsp + 8]
	mov	r14, qword ptr [rsp + 64]
	lea	r13, [rbp + r14]
	add	r13, rdi
	add	r13, r9
	mov	rax, qword ptr [rsp + 56]
	lea	r14, [rsi + rax]
	add	r14, qword ptr [rsp + 40]
	add	r14, r13
	add	r14, r11
	add	rax, r9
	mov	r11, qword ptr [rsp + 16]
	add	r11, qword ptr [rsp + 64]
	add	r11, rax
	add	r11, rbx
	mov	r13d, 32
	.p2align	4
572:
	vmovdqu	ymm12, ymmword ptr [r11 + r13]
	vmovdqu	ymmword ptr [r14 + r13], ymm12
	add	r13, 32
	cmp	r13, r8
	jb	572b
	mov	r9, qword ptr [rsp + 48]
	jmp	422b
582:
	lea	rdx, [r14 + rcx]
	mov	r11, qword ptr [rsp]
	mov	rax, qword ptr [r11 + 48]
	mov	rbx, qword ptr [r11 + 120]
	movzx	r12d, byte ptr [rax + rbx]
	inc	rbx
	mov	qword ptr [r11 + 120], rbx
	add	r12, 33
	add	rdi, qword ptr [rsp + 8]
	add	rbp, r8
	add	rbp, rdi
	mov	rax, qword ptr [rsp + 64]
	add	rax, rsi
	add	rax, qword ptr [rsp + 56]
	add	rax, rbp
	add	rax, qword ptr [rsp + 40]
	cmp	r13, rcx
	cmovae	r13, rcx
	sub	rax, r13
	add	rax, r14
	mov	esi, 32
	.p2align	4
592:
	vmovdqu	ymm12, ymmword ptr [rax + rsi]
	vmovdqu	ymmword ptr [rdx + rsi], ymm12
	add	rsi, 32
	cmp	rsi, r12
	jb	592b
	jmp	432b
	.p2align	4
602:
	mov	r12, rbp
	mov	r8, r15
612:
	mov	r15, qword ptr [rsp + 96]
	cmp	r9, r15
	mov	r11, qword ptr [rsp + 48]
	je	2b
	.p2align	4
622:
	movzx	edx, byte ptr [r13 + r9]
	mov	rdi, qword ptr [rsp]
	movzx	esi, byte ptr [rdi + r9 + 192]
	cmp	r11, 33
	mov	eax, 32
	cmovb	r11, rax
	mov	rax, r12
	sub	rax, r11
	mov	ecx, 0
	cmovae	rcx, rax
	cmp	rsi, 33
	mov	r11d, dword ptr [rdi + 4*r9 + 256]
	vmovdqu	ymm12, ymmword ptr [r14 + rcx]
	mov	rbp, r8
	vpaddb	ymm12, ymm12, ymmword ptr [rbx + r8]
	vmovdqu	ymmword ptr [r14 + r12], ymm12
	jae	652f
632:
	mov	eax, edx
	add	r12, rsi
	shr	edx, 2
	cmp	rdx, 32
	mov	r8d, 32
	cmovb	r8, rdx
	cmp	r11, r8
	cmova	r8, r11
	mov	rcx, r12
	sub	rcx, r8
	mov	r10d, 0
	cmovae	r10, rcx
	vmovdqu	ymm12, ymmword ptr [r14 + r10]
	vmovdqu	ymmword ptr [r14 + r12], ymm12
	cmp	al, -124
	jae	672f
642:
	mov	r8, rbp
	add	r8, rsi
	add	r12, rdx
	inc	r9
	cmp	r9, r15
	jb	622b
	jmp	2b
652:
	mov	qword ptr [rsp + 48], r9
	mov	r9, r11
	lea	r8, [rbx + rbp]
	lea	r10, [r14 + r12]
	mov	rdi, qword ptr [rsp]
	mov	rax, qword ptr [rdi + 48]
	mov	rcx, qword ptr [rdi + 120]
	movzx	esi, byte ptr [rax + rcx]
	inc	rcx
	mov	qword ptr [rdi + 120], rcx
	add	rsi, 33
	mov	r11d, 32
	.p2align	4
662:
	vmovdqu	ymm12, ymmword ptr [r8 + r11]
	vmovdqu	ymmword ptr [r10 + r11], ymm12
	add	r11, 32
	cmp	r11, rsi
	jb	662b
	mov	r11, r9
	mov	r9, qword ptr [rsp + 48]
	jmp	632b
672:
	mov	qword ptr [rsp + 48], r11
	lea	r10, [r14 + r12]
	mov	rdi, qword ptr [rsp]
	mov	rax, qword ptr [rdi + 48]
	mov	rcx, qword ptr [rdi + 120]
	movzx	edx, byte ptr [rax + rcx]
	inc	rcx
	mov	qword ptr [rdi + 120], rcx
	add	rdx, 33
	cmp	r8, r12
	cmovae	r8, r12
	mov	r11, r10
	sub	r11, r8
	mov	r8d, 32
	.p2align	4
682:
	vmovdqu	ymm12, ymmword ptr [r11 + r8]
	vmovdqu	ymmword ptr [r10 + r8], ymm12
	add	r8, 32
	cmp	r8, rdx
	jb	682b
	mov	r11, qword ptr [rsp + 48]
	jmp	642b
692:
	add	r9, rdx
	mov	r14, r9
	jmp	762f
702:
	mov	rbx, rsi
	and	rbx, -256
	lea	r8, [rdx + rbx]
	lea	r14, [r9 + rdx + 192]
	xor	r15d, r15d
	mov	rax, qword ptr [rsp]
	.p2align	4
712:
	vmovdqu64	zmm14, zmmword ptr [r14 + r15 - 192]
	vmovdqu64	zmm15, zmmword ptr [r14 + r15 - 128]
	vmovdqu64	zmm16, zmmword ptr [r14 + r15 - 64]
	vmovdqu64	zmm17, zmmword ptr [r14 + r15]
	vmovdqu64	zmmword ptr [rax + r15 + 576], zmm14
	vmovdqu64	zmmword ptr [rax + r15 + 640], zmm15
	vmovdqu64	zmmword ptr [rax + r15 + 704], zmm16
	vmovdqu64	zmmword ptr [rax + r15 + 768], zmm17
	add	r15, 256
	cmp	rbx, r15
	jne	712b
	cmp	rsi, rbx
	mov	r14, rcx
	mov	r15, qword ptr [rsp + 16]
	je	762f
	test	sil, -16
	je	742f
722:
	mov	r14, rsi
	and	r14, -16
	lea	r8, [rdx + r14]
	.p2align	4
732:
	vmovdqu	xmm14, xmmword ptr [rdi + rbx]
	vmovdqu	xmmword ptr [rcx + rbx], xmm14
	add	rbx, 16
	cmp	r14, rbx
	jne	732b
	cmp	rsi, r14
	mov	r14, rcx
	je	762f
742:
	mov	rsi, rcx
	sub	rsi, rdx
	.p2align	4
752:
	movzx	edx, byte ptr [r9 + r8]
	mov	byte ptr [rsi + r8], dl
	inc	r8
	cmp	r13, r8
	jne	752b
	mov	r14, rcx
762:
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
	mov	edx, r11d
	and	edx, 7
	vpbroadcastd	zmm17, edx
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
	mov	rax, qword ptr [rsp]
	vmovdqu64	zmmword ptr [rax + 448], zmm13
	vshufi64x2	zmm13, zmm12, zmm12, 255
	vextracti32x4	xmm12, zmm16, 3
	vpextrd	edx, xmm12, 3
	add	r11, rdx
	mov	r14, qword ptr [rsp + 32]
	jmp	342b
772:
	mov	rcx, qword ptr [rsp]
	mov	qword ptr [rcx + 80], r12
	mov	rax, qword ptr [rsp + 16]
	mov	qword ptr [rcx + 88], rax
	add	rsp, 176
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	vzeroupper
	ret
	.p2align	6, 0x0
782:
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
792:
	.byte	2
	.p2align	6, 0x0
802:
	.byte	1
	.p2align	2, 0x0
812:
	.long	1
	.p2align	2, 0x0
822:
	.long	7
	.p2align	2, 0x0
832:
	.long	8
	.p2align	4, 0x0
842:
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
852:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	6, 0x0
862:
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
872:
	.long	134217727

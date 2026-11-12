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
	vpbroadcastb	zmm3, byte ptr [rip + 812f]
	vpxor	xmm4, xmm4, xmm4
	vmovdqa64	zmm5, zmmword ptr [rip + 822f]
	vmovdqa64	zmm6, zmmword ptr [rip + 832f]
	vmovdqa64	zmm26, zmmword ptr [rip + 842f]
	vmovdqa64	zmm8, zmmword ptr [rip + 852f]
	vpbroadcastd	zmm9, dword ptr [rip + 862f]
	vpternlogd	zmm10, zmm10, zmm10, 255
	vpbroadcastd	zmm11, dword ptr [rip + 872f]
	vpbroadcastd	zmm12, dword ptr [rip + 882f]
	vbroadcasti32x4	zmm13, xmmword ptr [rip + 892f]
	vpbroadcastd	zmm14, dword ptr [rip + 902f]
	vmovdqa64	zmm15, zmmword ptr [rip + 912f]
	vpbroadcastd	zmm16, dword ptr [rip + 922f]
	mov	rsi, rcx
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
	mov	rsi, qword ptr [rsp + 72]
	add	rsi, -64
	mov	rax, qword ptr [rsp + 152]
	mov	rdx, qword ptr [rsp + 168]
	cmp	rdx, rax
	mov	rcx, qword ptr [rsp + 136]
	jge	772f
12:
	mov	qword ptr [rsp + 56], r11
	mov	qword ptr [rsp + 48], r12
	mov	r8, rax
	sub	r8, rdx
	cmp	r8, 64
	mov	eax, 64
	mov	qword ptr [rsp + 8], r8
	cmovb	rax, r8
	mov	qword ptr [rsp + 96], rax
	mov	rdi, qword ptr [rsp]
	mov	rbx, qword ptr [rdi + 16]
	mov	r8, qword ptr [rdi + 24]
	mov	rax, qword ptr [rdi + 32]
	mov	qword ptr [rsp + 160], rax
	mov	r9, qword ptr [rdi + 40]
	mov	r15, qword ptr [rdi + 64]
	mov	rax, qword ptr [rdi + 72]
	mov	qword ptr [rsp + 40], rax
	mov	rax, qword ptr [rdi + 96]
	mov	qword ptr [rsp + 64], rax
	mov	r13, qword ptr [rdi + 112]
	mov	r10, qword ptr [rdi + 128]
	mov	rdi, qword ptr [rdi + 136]
	lea	r14, [r15 + 7]
	lea	rax, [rdx + 64]
	mov	qword ptr [rsp + 168], rax
	cmp	rax, r14
	mov	qword ptr [rsp + 72], rsi
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
	mov	rsi, qword ptr [rsp]
	sub	rsi, rdx
	add	rsi, 511
	cmp	rsi, 255
	mov	rsi, qword ptr [rsp + 72]
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
	lea	rsi, [r15 + rax]
	and	rsi, -256
	xor	edx, edx
	mov	rax, qword ptr [rsp]
	.p2align	4
42:
	vmovdqu64	zmm17, zmmword ptr [r10 + rdx - 192]
	vmovdqu64	zmm18, zmmword ptr [r10 + rdx - 128]
	vmovdqu64	zmm19, zmmword ptr [r10 + rdx - 64]
	vmovdqu64	zmm20, zmmword ptr [r10 + rdx]
	vmovdqu64	zmmword ptr [rax + rdx + 512], zmm17
	vmovdqu64	zmmword ptr [rax + rdx + 576], zmm18
	vmovdqu64	zmmword ptr [rax + rdx + 640], zmm19
	vmovdqu64	zmmword ptr [rax + rdx + 704], zmm20
	add	rdx, 256
	cmp	rsi, rdx
	jne	42b
	cmp	r11, r12
	mov	rdx, rcx
	mov	rsi, qword ptr [rsp + 72]
	mov	r10, rdi
	mov	rdi, qword ptr [rsp + 128]
	je	82f
	test	r11b, -16
	je	72f
52:
	mov	rsi, r11
	and	rsi, -16
	mov	rax, qword ptr [rsp + 24]
	lea	rbp, [rax + rsi]
	lea	rdx, [rbx + rax]
	add	r15, qword ptr [rsp + 88]
	and	r15, -16
	.p2align	4
62:
	vmovdqu64	xmm17, xmmword ptr [rdx + r12]
	vmovdqu64	xmmword ptr [rcx + r12], xmm17
	add	r12, 16
	cmp	r15, r12
	jne	62b
	cmp	r11, rsi
	mov	rdx, rcx
	mov	rsi, qword ptr [rsp + 72]
	je	82f
	.p2align	4
72:
	movzx	edx, byte ptr [rbx + rbp]
	mov	byte ptr [rsi + rbp], dl
	inc	rbp
	cmp	r14, rbp
	jne	72b
	mov	rdx, rcx
82:
	vmovdqu64	zmm17, zmmword ptr [rdx]
	mov	rax, qword ptr [rsp + 96]
	vpbroadcastb	zmm18, eax
	vpcmpnleub	k2, zmm18, zmm0
	vptestmb	k1 {k2}, zmm17, zmm1
	vptestnmb	k2 {k2}, zmm17, zmm2
	vpexpandb	zmm17 {k1} {z}, zmmword ptr [r8 + r10]
	mov	rax, qword ptr [rsp]
	vmovdqu64	zmmword ptr [rax + 192], zmm17
	mov	rax, qword ptr [rsp + 160]
	vpexpandb	zmm17 {k2} {z}, zmmword ptr [rax + rdi]
	mov	rdx, qword ptr [rsp + 40]
	shr	rdx, 3
	lea	rsi, [rdx + 64]
	cmp	rsi, r13
	jbe	92f
	mov	r8, r13
	sub	r8, rdx
	mov	rcx, qword ptr [rsp + 104]
	mov	r15, rcx
	mov	rbp, qword ptr [rsp + 48]
	mov	rax, qword ptr [rsp + 8]
	jbe	162f
	cmp	r8, 16
	mov	rbx, rdx
	jb	142f
	lea	r14, [rdx + r9]
	mov	rsi, qword ptr [rsp]
	sub	rsi, r14
	add	rsi, 575
	cmp	rsi, 255
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
	mov	rbp, qword ptr [rsp + 48]
	mov	rax, qword ptr [rsp + 8]
	jmp	162f
102:
	mov	r12, rdi
	mov	rdi, r10
	mov	r11, r8
	and	r11, -256
	lea	rbx, [rdx + r11]
	lea	rsi, [r9 + rdx + 192]
	xor	r10d, r10d
	mov	rax, qword ptr [rsp]
	.p2align	4
112:
	vmovdqu64	zmm18, zmmword ptr [rsi + r10 - 192]
	vmovdqu64	zmm19, zmmword ptr [rsi + r10 - 128]
	vmovdqu64	zmm20, zmmword ptr [rsi + r10 - 64]
	vmovdqu64	zmm21, zmmword ptr [rsi + r10]
	vmovdqu64	zmmword ptr [rax + r10 + 576], zmm18
	vmovdqu64	zmmword ptr [rax + r10 + 640], zmm19
	vmovdqu64	zmmword ptr [rax + r10 + 704], zmm20
	vmovdqu64	zmmword ptr [rax + r10 + 768], zmm21
	add	r10, 256
	cmp	r11, r10
	jne	112b
	cmp	r8, r11
	mov	r15, rcx
	mov	r10, rdi
	mov	rdi, r12
	mov	rax, qword ptr [rsp + 8]
	je	162f
	test	r8b, -16
	je	142f
122:
	mov	rsi, r8
	and	rsi, -16
	lea	rbx, [rdx + rsi]
	.p2align	4
132:
	vmovdqu64	xmm18, xmmword ptr [r14 + r11]
	vmovdqu64	xmmword ptr [rcx + r11], xmm18
	add	r11, 16
	cmp	rsi, r11
	jne	132b
	cmp	r8, rsi
	mov	r15, rcx
	je	162f
	.p2align	4
142:
	mov	rsi, rcx
	sub	rsi, rdx
	.p2align	4
152:
	movzx	edx, byte ptr [r9 + rbx]
	mov	byte ptr [rsi + rbx], dl
	inc	rbx
	cmp	r13, rbx
	jne	152b
	mov	r15, rcx
162:
	mov	r12, rdi
	vpsrlw	zmm18, zmm17, 3
	vpandq	zmm18, zmm18, zmm3
	vpsubusb	zmm18, zmm18, zmm2
	vpsllq	zmm19, zmm18, 8
	vpaddb	zmm19, zmm18, zmm19
	vpsllq	zmm20, zmm19, 16
	vpaddb	zmm19, zmm19, zmm20
	vpsllq	zmm20, zmm19, 32
	vpaddb	zmm19, zmm19, zmm20
	vpsubb	zmm20, zmm19, zmm18
	mov	rdx, qword ptr [rsp + 64]
	vpbroadcastd	zmm21, edx
	vmovdqa64	zmm18, zmm19
	vpermt2b	zmm18, zmm8, zmm4
	vpmovzxbd	zmm22, xmm20
	vpaddd	zmm18, zmm18, zmm22
	vpmovzxbd	zmm22, xmm17
	vpsrld	zmm23, zmm22, 3
	vpmaxud	zmm23, zmm23, zmm9
	vpaddd	zmm23, zmm23, zmm10
	vpminud	zmm24, zmm22, zmm12
	vpandd	zmm24, zmm24, zmm12
	vpternlogd	zmm24, zmm22, zmm11, 248
	vpsllvd	zmm22, zmm24, zmm23
	vpsllvd	zmm24, zmm10, zmm23
	vpaddd	zmm23, zmm18, zmm23
	mov	rsi, qword ptr [rsp + 40]
	mov	edx, esi
	and	edx, 7
	vpbroadcastd	zmm25, edx
	vpaddd	zmm18, zmm18, zmm25
	vpsrld	zmm25, zmm18, 3
	vpandd	zmm18, zmm18, zmm11
	vpshufb	zmm25, zmm25, zmm13
	vpaddb	zmm25, zmm25, zmm14
	vpermb	zmm25, zmm25, zmmword ptr [r15]
	vpsrlvd	zmm18, zmm25, zmm18
	vpandnd	zmm18, zmm24, zmm18
	vpaddd	zmm18, zmm18, zmm22
	vptestmd	k3, zmm18, zmm18
	vpord	zmm18 {k3} {z}, zmm18, zmm15
	valignd	zmm22, zmm18, zmm4, 15
	vpmaxud	zmm18, zmm18, zmm22
	valignq	zmm22, zmm18, zmm4, 7
	vpmaxud	zmm18, zmm18, zmm22
	valignq	zmm22, zmm18, zmm4, 6
	vpmaxud	zmm18, zmm18, zmm22
	valignq	zmm22, zmm18, zmm4, 4
	vpmaxud	zmm18, zmm18, zmm22
	vptestmd	k3, zmm18, zmm18
	vpandd	zmm21 {k3}, zmm18, zmm16
	vpshufd	zmm18, zmm21, 255
	vshufi64x2	zmm18, zmm18, zmm18, 255
	vextracti32x4	xmm7, zmm23, 3
	vpextrd	r11d, xmm7, 3
	add	r11, rsi
	mov	rdx, qword ptr [rsp]
	vmovdqu64	zmmword ptr [rdx + 256], zmm21
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
	vmovdqu64	zmm7, zmmword ptr [r10 + r15 - 192]
	vmovdqu64	zmm21, zmmword ptr [r10 + r15 - 128]
	vmovdqu64	zmm22, zmmword ptr [r10 + r15 - 64]
	vmovdqu64	zmm23, zmmword ptr [r10 + r15]
	vmovdqu64	zmmword ptr [rax + r15 + 576], zmm7
	vmovdqu64	zmmword ptr [rax + r15 + 640], zmm21
	vmovdqu64	zmmword ptr [rax + r15 + 704], zmm22
	vmovdqu64	zmmword ptr [rax + r15 + 768], zmm23
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
	vmovdqu	xmm7, xmmword ptr [rbx + r14]
	vmovdqu	xmmword ptr [rcx + r14], xmm7
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
	vextracti32x4	xmm7, ymm20, 1
	vpmovzxbd	zmm7, xmm7
	vmovdqa64	zmm21, zmm19
	vpermt2b	zmm21, zmm5, zmm4
	vpaddd	zmm7, zmm21, zmm7
	vextracti32x4	xmm21, ymm17, 1
	vpmovzxbd	zmm21, xmm21
	vpsrld	zmm22, zmm21, 3
	vpmaxud	zmm22, zmm22, zmm9
	vpaddd	zmm22, zmm22, zmm10
	vpminud	zmm23, zmm21, zmm12
	vpandd	zmm23, zmm23, zmm12
	vpternlogd	zmm23, zmm21, zmm11, 248
	vpsllvd	zmm21, zmm23, zmm22
	vpsllvd	zmm23, zmm10, zmm22
	vpaddd	zmm22, zmm7, zmm22
	mov	edx, r11d
	and	edx, 7
	vpbroadcastd	zmm24, edx
	vpaddd	zmm7, zmm24, zmm7
	vpsrld	zmm24, zmm7, 3
	vpandd	zmm7, zmm7, zmm11
	vpshufb	zmm24, zmm24, zmm13
	vpaddb	zmm24, zmm24, zmm14
	vpermb	zmm24, zmm24, zmmword ptr [r15]
	vpsrlvd	zmm7, zmm24, zmm7
	vpandnd	zmm7, zmm23, zmm7
	vpaddd	zmm7, zmm7, zmm21
	vptestmd	k3, zmm7, zmm7
	vpord	zmm7 {k3} {z}, zmm7, zmm15
	valignd	zmm21, zmm7, zmm4, 15
	vpmaxud	zmm7, zmm7, zmm21
	valignq	zmm21, zmm7, zmm4, 7
	vpmaxud	zmm7, zmm7, zmm21
	valignq	zmm21, zmm7, zmm4, 6
	vpmaxud	zmm7, zmm7, zmm21
	valignq	zmm21, zmm7, zmm4, 4
	vpmaxud	zmm7, zmm7, zmm21
	vptestmd	k3, zmm7, zmm7
	vpandd	zmm18 {k3}, zmm7, zmm16
	vpshufd	zmm7, zmm18, 255
	mov	rsi, qword ptr [rsp]
	vmovdqu64	zmmword ptr [rsi + 320], zmm18
	vshufi64x2	zmm18, zmm7, zmm7, 255
	vextracti32x4	xmm7, zmm22, 3
	vpextrd	edx, xmm7, 3
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
	vmovdqu64	zmm7, zmmword ptr [r10 + r15 - 192]
	vmovdqu64	zmm21, zmmword ptr [r10 + r15 - 128]
	vmovdqu64	zmm22, zmmword ptr [r10 + r15 - 64]
	vmovdqu64	zmm23, zmmword ptr [r10 + r15]
	vmovdqu64	zmmword ptr [rax + r15 + 576], zmm7
	vmovdqu64	zmmword ptr [rax + r15 + 640], zmm21
	vmovdqu64	zmmword ptr [rax + r15 + 704], zmm22
	vmovdqu64	zmmword ptr [rax + r15 + 768], zmm23
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
	vmovdqu	xmm7, xmmword ptr [rbx + r14]
	vmovdqu	xmmword ptr [rcx + r14], xmm7
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
	vextracti32x4	xmm7, zmm20, 2
	vpmovzxbd	zmm7, xmm7
	vmovdqa64	zmm21, zmm19
	vpermt2b	zmm21, zmm6, zmm4
	vpaddd	zmm7, zmm21, zmm7
	vextracti32x4	xmm21, zmm17, 2
	vpmovzxbd	zmm21, xmm21
	vpsrld	zmm22, zmm21, 3
	vpmaxud	zmm22, zmm22, zmm9
	vpaddd	zmm22, zmm22, zmm10
	vpminud	zmm23, zmm21, zmm12
	vpandd	zmm23, zmm23, zmm12
	vpternlogd	zmm23, zmm21, zmm11, 248
	vpsllvd	zmm21, zmm23, zmm22
	vpsllvd	zmm23, zmm10, zmm22
	vpaddd	zmm22, zmm7, zmm22
	mov	edx, r11d
	and	edx, 7
	vpbroadcastd	zmm24, edx
	vpaddd	zmm7, zmm24, zmm7
	vpsrld	zmm24, zmm7, 3
	vpandd	zmm7, zmm7, zmm11
	vpshufb	zmm24, zmm24, zmm13
	vpaddb	zmm24, zmm24, zmm14
	vpermb	zmm24, zmm24, zmmword ptr [r15]
	vpsrlvd	zmm7, zmm24, zmm7
	vpandnd	zmm7, zmm23, zmm7
	vpaddd	zmm7, zmm7, zmm21
	vptestmd	k3, zmm7, zmm7
	vpord	zmm7 {k3} {z}, zmm7, zmm15
	valignd	zmm21, zmm7, zmm4, 15
	vpmaxud	zmm7, zmm7, zmm21
	valignq	zmm21, zmm7, zmm4, 7
	vpmaxud	zmm7, zmm7, zmm21
	valignq	zmm21, zmm7, zmm4, 6
	vpmaxud	zmm7, zmm7, zmm21
	valignq	zmm21, zmm7, zmm4, 4
	vpmaxud	zmm7, zmm7, zmm21
	vptestmd	k3, zmm7, zmm7
	vpandd	zmm18 {k3}, zmm7, zmm16
	vpshufd	zmm7, zmm18, 255
	mov	rsi, qword ptr [rsp]
	vmovdqu64	zmmword ptr [rsi + 384], zmm18
	vshufi64x2	zmm18, zmm7, zmm7, 255
	vextracti32x4	xmm7, zmm22, 3
	vpextrd	edx, xmm7, 3
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
	vmovd	r8d, xmm18
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
	mov	rcx, qword ptr [rsp + 56]
	cmp	rcx, 33
	mov	eax, 32
	cmovb	rcx, rax
	mov	rdx, rbp
	sub	rdx, rcx
	mov	esi, 0
	cmovae	rsi, rdx
	cmp	r12, 33
	mov	eax, dword ptr [r8 + 4*r10 + 256]
	vmovdqu	ymm7, ymmword ptr [r14 + rsi]
	vpaddb	ymm7, ymm7, ymmword ptr [rbx + r15]
	vmovdqu	ymmword ptr [r14 + rbp], ymm7
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
	vmovdqu	ymm7, ymmword ptr [r8 + r14]
	mov	r11, qword ptr [rsp + 32]
	vmovdqu	ymmword ptr [r11 + rcx], ymm7
	cmp	sil, -124
	mov	r14, qword ptr [rsp]
	jae	462f
372:
	mov	qword ptr [rsp + 48], rbp
	lea	rdx, [r10 + 1]
	mov	qword ptr [rsp + 16], r15
	mov	qword ptr [rsp + 40], r12
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
	vmovdqu	ymm7, ymmword ptr [r11 + rax]
	movzx	ebp, byte ptr [r14 + rdx + 192]
	cmp	rbp, 33
	mov	eax, dword ptr [r14 + 4*rdx + 256]
	vpaddb	ymm7, ymm7, ymmword ptr [rbx + r15]
	vmovdqu	ymmword ptr [r11 + rcx], ymm7
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
	vmovdqu	ymm7, ymmword ptr [r11 + r13]
	vmovdqu	ymmword ptr [r11 + rcx], ymm7
	cmp	r8b, -124
	mov	qword ptr [rsp + 8], rbp
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
	vmovdqu	ymm7, ymmword ptr [r11 + r13]
	vpaddb	ymm7, ymm7, ymmword ptr [rbx + r15]
	vmovdqu	ymmword ptr [r11 + rcx], ymm7
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
	vmovdqu	ymm7, ymmword ptr [r11 + rbx]
	vmovdqu	ymmword ptr [r11 + rcx], ymm7
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
	vmovdqu	ymm7, ymmword ptr [r11 + rax]
	mov	rbx, qword ptr [rsp + 80]
	vpaddb	ymm7, ymm7, ymmword ptr [rbx + r15]
	vmovdqu	ymmword ptr [r11 + rcx], ymm7
	mov	qword ptr [rsp + 56], r9
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
	vmovdqu	ymm7, ymmword ptr [rbx + r14]
	mov	r14, qword ptr [rsp + 32]
	vmovdqu	ymmword ptr [r14 + rcx], ymm7
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
	vmovdqu	ymm7, ymmword ptr [rdx + r8]
	vmovdqu	ymmword ptr [rsi + r8], ymm7
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
	vmovdqu	ymm7, ymmword ptr [r8 + rdx]
	vmovdqu	ymmword ptr [rsi + rdx], ymm7
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
	vmovdqu	ymm7, ymmword ptr [rdx + r12]
	vmovdqu	ymmword ptr [r8 + r12], ymm7
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
	mov	r12, qword ptr [rsp + 40]
	lea	r13, [rdi + r12]
	mov	r12, qword ptr [rsp + 48]
	add	r12, rbp
	add	r12, r13
	cmp	rdx, rcx
	cmovae	rdx, rcx
	sub	r12, rdx
	add	r12, r11
	mov	edx, 32
	.p2align	4
512:
	vmovdqu	ymm7, ymmword ptr [r12 + rdx]
	vmovdqu	ymmword ptr [r8 + rdx], ymm7
	add	rdx, 32
	cmp	rdx, rsi
	jb	512b
	mov	rbp, qword ptr [rsp + 8]
	jmp	392b
522:
	mov	rdx, qword ptr [r14 + 48]
	mov	r8, qword ptr [r14 + 120]
	movzx	r13d, byte ptr [rdx + r8]
	inc	r8
	mov	qword ptr [r14 + 120], r8
	add	r13, 33
	mov	rdx, qword ptr [rsp + 40]
	lea	r12, [rdi + rdx]
	mov	rdx, qword ptr [rsp + 8]
	lea	r8, [rsi + rdx]
	mov	rdx, r13
	add	r8, r12
	add	r8, qword ptr [rsp + 48]
	add	r8, r11
	lea	r12, [rbx + r15]
	mov	r13d, 32
	.p2align	4
532:
	vmovdqu	ymm7, ymmword ptr [r12 + r13]
	vmovdqu	ymmword ptr [r8 + r13], ymm7
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
	mov	rdx, qword ptr [rsp + 40]
	lea	r13, [r13 + rsi]
	add	r13, rdi
	add	r13, rdx
	mov	rbx, qword ptr [rsp + 48]
	mov	rdx, qword ptr [rsp + 8]
	add	rbx, rdx
	add	r13, rbx
	cmp	r8, rcx
	cmovae	r8, rcx
	sub	r13, r8
	add	r13, r11
	mov	r8d, 32
	.p2align	4
552:
	vmovdqu	ymm7, ymmword ptr [r13 + r8]
	vmovdqu	ymmword ptr [r12 + r8], ymm7
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
	mov	r9, qword ptr [rsp + 40]
	mov	r14, qword ptr [rsp + 64]
	lea	r13, [rbp + r14]
	add	r13, rdi
	add	r13, r9
	mov	rax, qword ptr [rsp + 8]
	lea	r14, [rsi + rax]
	add	r14, qword ptr [rsp + 48]
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
	vmovdqu	ymm7, ymmword ptr [r11 + r13]
	vmovdqu	ymmword ptr [r14 + r13], ymm7
	add	r13, 32
	cmp	r13, r8
	jb	572b
	mov	r9, qword ptr [rsp + 56]
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
	add	rdi, qword ptr [rsp + 40]
	add	rbp, r8
	add	rbp, rdi
	mov	rax, qword ptr [rsp + 64]
	add	rax, rsi
	add	rax, qword ptr [rsp + 8]
	add	rax, rbp
	add	rax, qword ptr [rsp + 48]
	cmp	r13, rcx
	cmovae	r13, rcx
	sub	rax, r13
	add	rax, r14
	mov	esi, 32
	.p2align	4
592:
	vmovdqu	ymm7, ymmword ptr [rax + rsi]
	vmovdqu	ymmword ptr [rdx + rsi], ymm7
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
	mov	r11, qword ptr [rsp + 56]
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
	vmovdqu	ymm7, ymmword ptr [r14 + rcx]
	mov	rbp, r8
	vpaddb	ymm7, ymm7, ymmword ptr [rbx + r8]
	vmovdqu	ymmword ptr [r14 + r12], ymm7
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
	vmovdqu	ymm7, ymmword ptr [r14 + r10]
	vmovdqu	ymmword ptr [r14 + r12], ymm7
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
	mov	qword ptr [rsp + 56], r9
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
	vmovdqu	ymm7, ymmword ptr [r8 + r11]
	vmovdqu	ymmword ptr [r10 + r11], ymm7
	add	r11, 32
	cmp	r11, rsi
	jb	662b
	mov	r11, r9
	mov	r9, qword ptr [rsp + 56]
	jmp	632b
672:
	mov	qword ptr [rsp + 56], r11
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
	vmovdqu	ymm7, ymmword ptr [r11 + r8]
	vmovdqu	ymmword ptr [r10 + r8], ymm7
	add	r8, 32
	cmp	r8, rdx
	jb	682b
	mov	r11, qword ptr [rsp + 56]
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
	vmovdqu64	zmm7, zmmword ptr [r14 + r15 - 192]
	vmovdqu64	zmm21, zmmword ptr [r14 + r15 - 128]
	vmovdqu64	zmm22, zmmword ptr [r14 + r15 - 64]
	vmovdqu64	zmm23, zmmword ptr [r14 + r15]
	vmovdqu64	zmmword ptr [rax + r15 + 576], zmm7
	vmovdqu64	zmmword ptr [rax + r15 + 640], zmm21
	vmovdqu64	zmmword ptr [rax + r15 + 704], zmm22
	vmovdqu64	zmmword ptr [rax + r15 + 768], zmm23
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
	vmovdqu	xmm7, xmmword ptr [rdi + rbx]
	vmovdqu	xmmword ptr [rcx + rbx], xmm7
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
	vextracti32x4	xmm7, zmm20, 3
	vpmovzxbd	zmm7, xmm7
	vpermt2b	zmm19, zmm26, zmm4
	vpaddd	zmm7, zmm19, zmm7
	vextracti32x4	xmm17, zmm17, 3
	vpmovzxbd	zmm17, xmm17
	vpsrld	zmm19, zmm17, 3
	vpmaxud	zmm19, zmm19, zmm9
	vpaddd	zmm19, zmm19, zmm10
	vpminud	zmm20, zmm17, zmm12
	vpandd	zmm20, zmm20, zmm12
	vpternlogd	zmm20, zmm17, zmm11, 248
	vpsllvd	zmm17, zmm20, zmm19
	vpsllvd	zmm20, zmm10, zmm19
	vpaddd	zmm19, zmm7, zmm19
	mov	edx, r11d
	and	edx, 7
	vpbroadcastd	zmm21, edx
	vpaddd	zmm7, zmm21, zmm7
	vpsrld	zmm21, zmm7, 3
	vpandd	zmm7, zmm7, zmm11
	vpshufb	zmm21, zmm21, zmm13
	vpaddb	zmm21, zmm21, zmm14
	vpermb	zmm21, zmm21, zmmword ptr [r14]
	vpsrlvd	zmm7, zmm21, zmm7
	vpandnd	zmm7, zmm20, zmm7
	vpaddd	zmm7, zmm7, zmm17
	vptestmd	k3, zmm7, zmm7
	vpord	zmm7 {k3} {z}, zmm7, zmm15
	valignd	zmm17, zmm7, zmm4, 15
	vpmaxud	zmm7, zmm7, zmm17
	valignq	zmm17, zmm7, zmm4, 7
	vpmaxud	zmm7, zmm7, zmm17
	valignq	zmm17, zmm7, zmm4, 6
	vpmaxud	zmm7, zmm7, zmm17
	valignq	zmm17, zmm7, zmm4, 4
	vpmaxud	zmm7, zmm7, zmm17
	vptestmd	k3, zmm7, zmm7
	vpandd	zmm18 {k3}, zmm7, zmm16
	vpshufd	zmm7, zmm18, 255
	mov	rax, qword ptr [rsp]
	vmovdqu64	zmmword ptr [rax + 448], zmm18
	vshufi64x2	zmm18, zmm7, zmm7, 255
	vextracti32x4	xmm7, zmm19, 3
	vpextrd	edx, xmm7, 3
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
	.p2align	6, 0x0
812:
	.byte	31
	.p2align	6, 0x0
822:
	.byte	64
	.byte	65
	.byte	66
	.byte	67
	.byte	68
	.byte	69
	.byte	70
	.byte	71
	.byte	72
	.byte	73
	.byte	74
	.byte	75
	.byte	76
	.byte	77
	.byte	78
	.byte	79
	.byte	80
	.byte	81
	.byte	82
	.byte	83
	.byte	84
	.byte	85
	.byte	86
	.byte	87
	.byte	88
	.byte	89
	.byte	90
	.byte	91
	.byte	92
	.byte	93
	.byte	94
	.byte	95
	.byte	23
	.byte	97
	.byte	98
	.byte	99
	.byte	23
	.byte	101
	.byte	102
	.byte	103
	.byte	23
	.byte	105
	.byte	106
	.byte	107
	.byte	23
	.byte	109
	.byte	110
	.byte	111
	.byte	23
	.byte	113
	.byte	114
	.byte	115
	.byte	23
	.byte	117
	.byte	118
	.byte	119
	.byte	23
	.byte	121
	.byte	122
	.byte	123
	.byte	23
	.byte	125
	.byte	126
	.byte	127
	.p2align	6, 0x0
832:
	.byte	64
	.byte	65
	.byte	66
	.byte	67
	.byte	68
	.byte	69
	.byte	70
	.byte	71
	.byte	72
	.byte	73
	.byte	74
	.byte	75
	.byte	76
	.byte	77
	.byte	78
	.byte	79
	.byte	80
	.byte	81
	.byte	82
	.byte	83
	.byte	84
	.byte	85
	.byte	86
	.byte	87
	.byte	88
	.byte	89
	.byte	90
	.byte	91
	.byte	92
	.byte	93
	.byte	94
	.byte	95
	.byte	39
	.byte	97
	.byte	98
	.byte	99
	.byte	39
	.byte	101
	.byte	102
	.byte	103
	.byte	39
	.byte	105
	.byte	106
	.byte	107
	.byte	39
	.byte	109
	.byte	110
	.byte	111
	.byte	39
	.byte	113
	.byte	114
	.byte	115
	.byte	39
	.byte	117
	.byte	118
	.byte	119
	.byte	39
	.byte	121
	.byte	122
	.byte	123
	.byte	39
	.byte	125
	.byte	126
	.byte	127
	.p2align	6, 0x0
842:
	.byte	64
	.byte	65
	.byte	66
	.byte	67
	.byte	68
	.byte	69
	.byte	70
	.byte	71
	.byte	72
	.byte	73
	.byte	74
	.byte	75
	.byte	76
	.byte	77
	.byte	78
	.byte	79
	.byte	80
	.byte	81
	.byte	82
	.byte	83
	.byte	84
	.byte	85
	.byte	86
	.byte	87
	.byte	88
	.byte	89
	.byte	90
	.byte	91
	.byte	92
	.byte	93
	.byte	94
	.byte	95
	.byte	55
	.byte	97
	.byte	98
	.byte	99
	.byte	55
	.byte	101
	.byte	102
	.byte	103
	.byte	55
	.byte	105
	.byte	106
	.byte	107
	.byte	55
	.byte	109
	.byte	110
	.byte	111
	.byte	55
	.byte	113
	.byte	114
	.byte	115
	.byte	55
	.byte	117
	.byte	118
	.byte	119
	.byte	55
	.byte	121
	.byte	122
	.byte	123
	.byte	55
	.byte	125
	.byte	126
	.byte	127
	.p2align	6, 0x0
852:
	.byte	64
	.byte	65
	.byte	66
	.byte	67
	.byte	68
	.byte	69
	.byte	70
	.byte	71
	.byte	72
	.byte	73
	.byte	74
	.byte	75
	.byte	76
	.byte	77
	.byte	78
	.byte	79
	.byte	80
	.byte	81
	.byte	82
	.byte	83
	.byte	84
	.byte	85
	.byte	86
	.byte	87
	.byte	88
	.byte	89
	.byte	90
	.byte	91
	.byte	92
	.byte	93
	.byte	94
	.byte	95
	.byte	7
	.byte	97
	.byte	98
	.byte	99
	.byte	7
	.byte	101
	.byte	102
	.byte	103
	.byte	7
	.byte	105
	.byte	106
	.byte	107
	.byte	7
	.byte	109
	.byte	110
	.byte	111
	.byte	7
	.byte	113
	.byte	114
	.byte	115
	.byte	7
	.byte	117
	.byte	118
	.byte	119
	.byte	7
	.byte	121
	.byte	122
	.byte	123
	.byte	7
	.byte	125
	.byte	126
	.byte	127
	.p2align	2, 0x0
862:
	.long	1
	.p2align	2, 0x0
872:
	.long	7
	.p2align	2, 0x0
882:
	.long	8
	.p2align	4, 0x0
892:
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
902:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	6, 0x0
912:
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
922:
	.long	134217727

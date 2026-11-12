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
	mov	rax, qword ptr [rdi + 64]
	mov	r14, qword ptr [rdi + 80]
	mov	r11, qword ptr [rdi + 88]
	test	rax, rax
	jle	1052f
	mov	rcx, qword ptr [r12]
	mov	r15, qword ptr [r12 + 8]
	mov	rdx, qword ptr [r12 + 16]
	mov	qword ptr [rsp + 136], rdx
	mov	rbp, qword ptr [r12 + 96]
	lea	rdi, [r12 + 512]
	lea	rdx, [r12 + 576]
	mov	qword ptr [rsp], rdx
	mov	edx, 192
	mov	qword ptr [rsp + 112], rdx
	mov	edx, 7
	mov	qword ptr [rsp + 96], rdx
	mov	qword ptr [rsp + 128], 0
	vmovdqa64	zmm0, zmmword ptr [rip + 1062f]
	vpbroadcastb	zmm1, byte ptr [rip + 1072f]
	vpbroadcastb	zmm2, byte ptr [rip + 1082f]
	vpbroadcastb	zmm3, byte ptr [rip + 1092f]
	vpxor	xmm4, xmm4, xmm4
	vmovdqa64	zmm5, zmmword ptr [rip + 1102f]
	vmovdqa64	zmm6, zmmword ptr [rip + 1112f]
	vmovdqa64	zmm26, zmmword ptr [rip + 1122f]
	vmovdqa64	zmm8, zmmword ptr [rip + 1132f]
	vpbroadcastd	zmm9, dword ptr [rip + 1142f]
	vpternlogd	zmm10, zmm10, zmm10, 255
	vpbroadcastd	zmm11, dword ptr [rip + 1152f]
	vpbroadcastd	zmm12, dword ptr [rip + 1162f]
	vbroadcasti32x4	zmm13, xmmword ptr [rip + 1172f]
	vpbroadcastd	zmm14, dword ptr [rip + 1182f]
	vmovdqa64	zmm15, zmmword ptr [rip + 1192f]
	vpbroadcastd	zmm16, dword ptr [rip + 1202f]
	mov	rsi, rdi
	xor	edx, edx
	mov	qword ptr [rsp + 120], rdi
	mov	qword ptr [rsp + 64], r12
	mov	qword ptr [rsp + 144], rax
	mov	qword ptr [rsp + 40], r15
	jmp	12f
	.p2align	4
2:
	inc	qword ptr [rsp + 128]
	add	qword ptr [rsp + 112], 64
	add	qword ptr [rsp + 96], -64
	mov	rsi, qword ptr [rsp + 88]
	add	rsi, -64
	mov	rax, qword ptr [rsp + 144]
	mov	rdx, qword ptr [rsp + 160]
	cmp	rdx, rax
	mov	rdi, qword ptr [rsp + 120]
	jge	1052f
12:
	mov	qword ptr [rsp + 72], r11
	mov	r8, rax
	sub	r8, rdx
	cmp	r8, 64
	mov	eax, 64
	mov	qword ptr [rsp + 80], r8
	cmovb	rax, r8
	mov	qword ptr [rsp + 56], rax
	mov	rbx, qword ptr [r12 + 16]
	mov	rax, qword ptr [r12 + 24]
	mov	qword ptr [rsp + 152], rax
	mov	rax, qword ptr [r12 + 32]
	mov	qword ptr [rsp + 104], rax
	mov	r8, qword ptr [r12 + 40]
	mov	r13, qword ptr [r12 + 64]
	mov	rax, qword ptr [r12 + 72]
	mov	qword ptr [rsp + 24], rax
	mov	rax, qword ptr [r12 + 96]
	mov	qword ptr [rsp + 32], rax
	mov	r10, qword ptr [r12 + 112]
	mov	r11, qword ptr [r12 + 128]
	mov	rax, qword ptr [r12 + 136]
	mov	qword ptr [rsp + 16], rax
	lea	r15, [r13 + 7]
	lea	rax, [rdx + 64]
	mov	qword ptr [rsp + 160], rax
	cmp	rax, r15
	mov	qword ptr [rsp + 88], rsi
	mov	qword ptr [rsp + 48], rdx
	jbe	22f
	cmp	rdx, r15
	mov	rax, rdi
	jge	82f
	mov	rax, qword ptr [rsp + 128]
	shl	rax, 6
	mov	edx, 7
	sub	rdx, rax
	add	rdx, r13
	cmp	rdx, 16
	mov	r9, qword ptr [rsp + 48]
	jb	72f
	add	rax, rbx
	mov	rsi, qword ptr [rsp + 64]
	sub	rsi, rax
	add	rsi, 511
	cmp	rsi, 255
	mov	rsi, qword ptr [rsp + 88]
	mov	r9, qword ptr [rsp + 48]
	jb	72f
	cmp	rdx, 256
	jae	32f
	xor	r12d, r12d
	jmp	52f
	.p2align	4
22:
	add	rbx, rdx
	mov	rax, rbx
	jmp	82f
32:
	mov	qword ptr [rsp + 8], r11
	mov	r12, rdx
	and	r12, -256
	mov	rax, qword ptr [rsp + 48]
	lea	r9, [rax + r12]
	mov	rax, qword ptr [rsp + 112]
	lea	r11, [rbx + rax]
	mov	rax, qword ptr [rsp + 96]
	add	rax, r13
	and	rax, -256
	xor	esi, esi
	mov	rdi, qword ptr [rsp + 64]
	.p2align	4
42:
	vmovdqu64	zmm17, zmmword ptr [r11 + rsi - 192]
	vmovdqu64	zmm18, zmmword ptr [r11 + rsi - 128]
	vmovdqu64	zmm19, zmmword ptr [r11 + rsi - 64]
	vmovdqu64	zmm20, zmmword ptr [r11 + rsi]
	vmovdqu64	zmmword ptr [rdi + rsi + 512], zmm17
	vmovdqu64	zmmword ptr [rdi + rsi + 576], zmm18
	vmovdqu64	zmmword ptr [rdi + rsi + 640], zmm19
	vmovdqu64	zmmword ptr [rdi + rsi + 704], zmm20
	add	rsi, 256
	cmp	rax, rsi
	jne	42b
	cmp	rdx, r12
	mov	rdi, qword ptr [rsp + 120]
	mov	rax, rdi
	mov	rsi, qword ptr [rsp + 88]
	mov	r11, qword ptr [rsp + 8]
	je	82f
	test	dl, -16
	je	72f
52:
	mov	rax, rdx
	and	rax, -16
	mov	rsi, qword ptr [rsp + 48]
	lea	r9, [rsi + rax]
	add	rsi, rbx
	add	r13, qword ptr [rsp + 96]
	and	r13, -16
	.p2align	4
62:
	vmovdqu64	xmm17, xmmword ptr [rsi + r12]
	vmovdqu64	xmmword ptr [rdi + r12], xmm17
	add	r12, 16
	cmp	r13, r12
	jne	62b
	cmp	rdx, rax
	mov	rax, rdi
	mov	rsi, qword ptr [rsp + 88]
	je	82f
	.p2align	4
72:
	movzx	eax, byte ptr [rbx + r9]
	mov	byte ptr [rsi + r9], al
	inc	r9
	cmp	r15, r9
	jne	72b
	mov	rax, rdi
82:
	vmovdqu64	zmm17, zmmword ptr [rax]
	mov	rax, qword ptr [rsp + 56]
	vpbroadcastb	zmm18, eax
	vpcmpnleub	k2, zmm18, zmm0
	vptestmb	k1 {k2}, zmm17, zmm1
	vptestnmb	k2 {k2}, zmm17, zmm2
	mov	rax, qword ptr [rsp + 152]
	vpexpandb	zmm17 {k1} {z}, zmmword ptr [rax + r11]
	mov	r12, qword ptr [rsp + 64]
	vmovdqu64	zmmword ptr [r12 + 192], zmm17
	mov	rax, qword ptr [rsp + 16]
	mov	rdx, qword ptr [rsp + 104]
	vpexpandb	zmm17 {k2} {z}, zmmword ptr [rdx + rax]
	mov	rsi, qword ptr [rsp + 24]
	shr	rsi, 3
	lea	rax, [rsi + 64]
	cmp	rax, r10
	jbe	92f
	mov	rdi, r10
	sub	rdi, rsi
	mov	r15, qword ptr [rsp]
	mov	r13, qword ptr [rsp + 72]
	jbe	162f
	cmp	rdi, 16
	mov	r9, rsi
	jb	142f
	lea	rbx, [rsi + r8]
	mov	rax, r12
	sub	rax, rbx
	add	rax, 575
	cmp	rax, 255
	mov	r9, rsi
	jb	142f
	cmp	rdi, 256
	jae	102f
	xor	edx, edx
	jmp	122f
	.p2align	4
92:
	add	rsi, r8
	mov	r15, rsi
	mov	r13, qword ptr [rsp + 72]
	jmp	162f
102:
	mov	qword ptr [rsp + 8], r11
	mov	rdx, rdi
	and	rdx, -256
	lea	r9, [rsi + rdx]
	lea	rax, [r8 + rsi + 192]
	xor	r11d, r11d
	.p2align	4
112:
	vmovdqu64	zmm18, zmmword ptr [rax + r11 - 192]
	vmovdqu64	zmm19, zmmword ptr [rax + r11 - 128]
	vmovdqu64	zmm20, zmmword ptr [rax + r11 - 64]
	vmovdqu64	zmm21, zmmword ptr [rax + r11]
	vmovdqu64	zmmword ptr [r12 + r11 + 576], zmm18
	vmovdqu64	zmmword ptr [r12 + r11 + 640], zmm19
	vmovdqu64	zmmword ptr [r12 + r11 + 704], zmm20
	vmovdqu64	zmmword ptr [r12 + r11 + 768], zmm21
	add	r11, 256
	cmp	rdx, r11
	jne	112b
	cmp	rdi, rdx
	mov	r15, qword ptr [rsp]
	mov	r11, qword ptr [rsp + 8]
	je	162f
	test	dil, -16
	je	142f
122:
	mov	rax, rdi
	and	rax, -16
	lea	r9, [rsi + rax]
	mov	r15, qword ptr [rsp]
	.p2align	4
132:
	vmovdqu64	xmm18, xmmword ptr [rbx + rdx]
	vmovdqu64	xmmword ptr [r15 + rdx], xmm18
	add	rdx, 16
	cmp	rax, rdx
	jne	132b
	cmp	rdi, rax
	je	162f
	.p2align	4
142:
	mov	rdi, qword ptr [rsp]
	mov	rax, rdi
	sub	rax, rsi
	.p2align	4
152:
	movzx	edx, byte ptr [r8 + r9]
	mov	byte ptr [rax + r9], dl
	inc	r9
	cmp	r10, r9
	jne	152b
	mov	r15, rdi
162:
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
	mov	rax, qword ptr [rsp + 32]
	vpbroadcastd	zmm21, eax
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
	mov	rdx, qword ptr [rsp + 24]
	mov	eax, edx
	and	eax, 7
	vpbroadcastd	zmm25, eax
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
	vpextrd	r15d, xmm7, 3
	add	r15, rdx
	vmovdqu64	zmmword ptr [r12 + 256], zmm21
	cmp	qword ptr [rsp + 80], 17
	jb	332f
	mov	rax, r15
	shr	rax, 3
	lea	rdx, [rax + 64]
	cmp	rdx, r10
	jbe	172f
	mov	rdx, r10
	sub	rdx, rax
	mov	rbx, qword ptr [rsp]
	jbe	242f
	cmp	rdx, 16
	mov	rsi, rax
	jb	222f
	lea	rdi, [rax + r8]
	mov	rsi, r12
	sub	rsi, rdi
	add	rsi, 575
	cmp	rsi, 255
	mov	rsi, rax
	jb	222f
	cmp	rdx, 256
	mov	qword ptr [rsp + 8], r11
	jae	182f
	xor	r9d, r9d
	jmp	202f
	.p2align	4
172:
	add	rax, r8
	mov	rbx, rax
	jmp	242f
182:
	mov	r9, rdx
	and	r9, -256
	lea	rsi, [rax + r9]
	lea	r11, [r8 + rax + 192]
	xor	ebx, ebx
	.p2align	4
192:
	vmovdqu64	zmm7, zmmword ptr [r11 + rbx - 192]
	vmovdqu64	zmm21, zmmword ptr [r11 + rbx - 128]
	vmovdqu64	zmm22, zmmword ptr [r11 + rbx - 64]
	vmovdqu64	zmm23, zmmword ptr [r11 + rbx]
	vmovdqu64	zmmword ptr [r12 + rbx + 576], zmm7
	vmovdqu64	zmmword ptr [r12 + rbx + 640], zmm21
	vmovdqu64	zmmword ptr [r12 + rbx + 704], zmm22
	vmovdqu64	zmmword ptr [r12 + rbx + 768], zmm23
	add	rbx, 256
	cmp	r9, rbx
	jne	192b
	cmp	rdx, r9
	mov	rbx, qword ptr [rsp]
	mov	r11, qword ptr [rsp + 8]
	je	242f
	test	dl, -16
	je	222f
202:
	mov	r11, rdx
	and	r11, -16
	lea	rsi, [rax + r11]
	mov	rbx, qword ptr [rsp]
	.p2align	4
212:
	vmovdqu	xmm7, xmmword ptr [rdi + r9]
	vmovdqu	xmmword ptr [rbx + r9], xmm7
	add	r9, 16
	cmp	r11, r9
	jne	212b
	cmp	rdx, r11
	mov	r11, qword ptr [rsp + 8]
	je	242f
222:
	mov	rdx, qword ptr [rsp]
	sub	rdx, rax
	.p2align	4
232:
	movzx	eax, byte ptr [r8 + rsi]
	mov	byte ptr [rdx + rsi], al
	inc	rsi
	cmp	r10, rsi
	jne	232b
	mov	rbx, qword ptr [rsp]
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
	mov	eax, r15d
	and	eax, 7
	vpbroadcastd	zmm24, eax
	vpaddd	zmm7, zmm24, zmm7
	vpsrld	zmm24, zmm7, 3
	vpandd	zmm7, zmm7, zmm11
	vpshufb	zmm24, zmm24, zmm13
	vpaddb	zmm24, zmm24, zmm14
	vpermb	zmm24, zmm24, zmmword ptr [rbx]
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
	vmovdqu64	zmmword ptr [r12 + 320], zmm18
	vshufi64x2	zmm18, zmm7, zmm7, 255
	vextracti32x4	xmm7, zmm22, 3
	vpextrd	eax, xmm7, 3
	add	r15, rax
	cmp	qword ptr [rsp + 80], 33
	jb	332f
	mov	rax, r15
	shr	rax, 3
	lea	rdx, [rax + 64]
	cmp	rdx, r10
	jbe	252f
	mov	rdx, r10
	sub	rdx, rax
	mov	rbx, qword ptr [rsp]
	jbe	322f
	cmp	rdx, 16
	mov	rsi, rax
	jb	302f
	lea	rdi, [rax + r8]
	mov	rsi, r12
	sub	rsi, rdi
	add	rsi, 575
	cmp	rsi, 255
	mov	rsi, rax
	jb	302f
	cmp	rdx, 256
	mov	qword ptr [rsp + 8], r11
	jae	262f
	xor	r9d, r9d
	jmp	282f
252:
	add	rax, r8
	mov	rbx, rax
	jmp	322f
262:
	mov	r9, rdx
	and	r9, -256
	lea	rsi, [rax + r9]
	lea	r11, [r8 + rax + 192]
	xor	ebx, ebx
	.p2align	4
272:
	vmovdqu64	zmm7, zmmword ptr [r11 + rbx - 192]
	vmovdqu64	zmm21, zmmword ptr [r11 + rbx - 128]
	vmovdqu64	zmm22, zmmword ptr [r11 + rbx - 64]
	vmovdqu64	zmm23, zmmword ptr [r11 + rbx]
	vmovdqu64	zmmword ptr [r12 + rbx + 576], zmm7
	vmovdqu64	zmmword ptr [r12 + rbx + 640], zmm21
	vmovdqu64	zmmword ptr [r12 + rbx + 704], zmm22
	vmovdqu64	zmmword ptr [r12 + rbx + 768], zmm23
	add	rbx, 256
	cmp	r9, rbx
	jne	272b
	cmp	rdx, r9
	mov	rbx, qword ptr [rsp]
	mov	r11, qword ptr [rsp + 8]
	je	322f
	test	dl, -16
	je	302f
282:
	mov	r11, rdx
	and	r11, -16
	lea	rsi, [rax + r11]
	mov	rbx, qword ptr [rsp]
	.p2align	4
292:
	vmovdqu	xmm7, xmmword ptr [rdi + r9]
	vmovdqu	xmmword ptr [rbx + r9], xmm7
	add	r9, 16
	cmp	r11, r9
	jne	292b
	cmp	rdx, r11
	mov	r11, qword ptr [rsp + 8]
	je	322f
302:
	mov	rdx, qword ptr [rsp]
	sub	rdx, rax
	.p2align	4
312:
	movzx	eax, byte ptr [r8 + rsi]
	mov	byte ptr [rdx + rsi], al
	inc	rsi
	cmp	r10, rsi
	jne	312b
	mov	rbx, qword ptr [rsp]
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
	mov	eax, r15d
	and	eax, 7
	vpbroadcastd	zmm24, eax
	vpaddd	zmm7, zmm24, zmm7
	vpsrld	zmm24, zmm7, 3
	vpandd	zmm7, zmm7, zmm11
	vpshufb	zmm24, zmm24, zmm13
	vpaddb	zmm24, zmm24, zmm14
	vpermb	zmm24, zmm24, zmmword ptr [rbx]
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
	vmovdqu64	zmmword ptr [r12 + 384], zmm18
	vshufi64x2	zmm18, zmm7, zmm7, 255
	vextracti32x4	xmm7, zmm22, 3
	vpextrd	eax, xmm7, 3
	add	r15, rax
	cmp	qword ptr [rsp + 80], 49
	jb	332f
	mov	qword ptr [rsp + 8], r11
	mov	rax, r15
	shr	rax, 3
	lea	rdx, [rax + 64]
	cmp	rdx, r10
	jbe	972f
	mov	rdx, r10
	sub	rdx, rax
	mov	r11, qword ptr [rsp]
	jbe	1042f
	cmp	rdx, 16
	mov	rsi, rax
	jb	1022f
	lea	rdi, [rax + r8]
	mov	rsi, r12
	sub	rsi, rdi
	add	rsi, 575
	cmp	rsi, 255
	mov	rsi, rax
	jb	1022f
	cmp	rdx, 256
	jae	982f
	xor	r9d, r9d
	jmp	1002f
	.p2align	4
332:
	mov	rdi, qword ptr [rsp + 56]
342:
	kmovq	rax, k2
	popcnt	rax, rax
	add	rax, qword ptr [rsp + 16]
	kmovq	rdx, k1
	popcnt	rdx, rdx
	add	rdx, r11
	vmovd	esi, xmm18
	mov	qword ptr [r12 + 72], r15
	mov	qword ptr [r12 + 96], rsi
	mov	qword ptr [r12 + 128], rdx
	mov	qword ptr [r12 + 136], rax
	mov	rax, qword ptr [rsp + 48]
	add	rax, qword ptr [rsp + 136]
	mov	qword ptr [rsp + 48], rax
	mov	rbx, rdi
	and	rbx, 124
	je	822f
	xor	r9d, r9d
	mov	r15, qword ptr [rsp + 40]
	mov	qword ptr [rsp + 80], rbx
	.p2align	4
352:
	cmp	rbp, r14
	cmovae	rbp, r14
	mov	rax, r14
	sub	rax, rbp
	cmp	rbp, 31
	jbe	502f
	vmovdqu64	ymm17, ymmword ptr [rcx + rax]
362:
	mov	rbp, qword ptr [rsp + 48]
	movzx	edx, byte ptr [rbp + r9]
	movzx	r10d, byte ptr [r12 + r9 + 192]
	mov	eax, dword ptr [r12 + 4*r9 + 256]
	vpaddb	ymm7, ymm17, ymmword ptr [r15 + r13]
	vmovdqu	ymmword ptr [rcx + r14], ymm7
	cmp	r10b, 33
	jae	512f
372:
	lea	r11, [r10 + r14]
	mov	r8d, edx
	shr	r8d, 2
	cmp	eax, r8d
	mov	qword ptr [rsp + 32], r10
	jb	742f
	mov	rsi, r11
	sub	rsi, rax
	jb	742f
	vmovdqu64	ymm17, ymmword ptr [rcx + rsi]
	mov	rdi, rax
382:
	vmovdqu64	ymmword ptr [rcx + r11], ymm17
	cmp	dl, -124
	jae	532f
392:
	mov	qword ptr [rsp + 24], r8
	lea	rsi, [r9 + 1]
	lea	rbx, [r10 + r13]
	add	r11, r8
	movzx	edx, byte ptr [rbp + rsi]
	movzx	r8d, byte ptr [r12 + rsi + 192]
	mov	esi, dword ptr [r12 + 4*rsi + 256]
	vmovdqu64	ymm17, ymmword ptr [r15 + rbx]
	cmp	rax, r11
	cmovae	rax, r11
	mov	rdi, r11
	sub	rdi, rax
	cmp	rax, 31
	jbe	562f
	vmovdqu64	ymm18, ymmword ptr [rcx + rdi]
	vpaddb	ymm7, ymm18, ymm17
	vmovdqu	ymmword ptr [rcx + r11], ymm7
	cmp	r8b, 33
	jae	572f
402:
	mov	qword ptr [rsp + 16], r8
	add	r11, r8
	mov	eax, edx
	shr	eax, 2
	cmp	esi, eax
	jb	752f
	mov	rdi, r11
	sub	rdi, rsi
	jb	752f
	vmovdqu64	ymm17, ymmword ptr [rcx + rdi]
	mov	r8, rsi
412:
	vmovdqu64	ymmword ptr [rcx + r11], ymm17
	cmp	dl, -124
	jae	592f
422:
	lea	rdi, [r9 + 2]
	add	rbx, qword ptr [rsp + 16]
	add	r11, rax
	movzx	r8d, byte ptr [rbp + rdi]
	movzx	edx, byte ptr [r12 + rdi + 192]
	mov	edi, dword ptr [r12 + 4*rdi + 256]
	vmovdqu64	ymm17, ymmword ptr [r15 + rbx]
	cmp	rsi, r11
	cmovae	rsi, r11
	mov	r10, r11
	sub	r10, rsi
	cmp	rsi, 31
	jbe	622f
	vmovdqu64	ymm18, ymmword ptr [rcx + r10]
	vpaddb	ymm7, ymm18, ymm17
	vmovdqu	ymmword ptr [rcx + r11], ymm7
	cmp	dl, 33
	jae	632f
432:
	mov	qword ptr [rsp + 72], r13
	add	r11, rdx
	mov	r13d, r8d
	shr	r13d, 2
	cmp	edi, r13d
	jb	762f
	mov	rsi, r11
	sub	rsi, rdi
	jb	762f
	vmovdqu64	ymm17, ymmword ptr [rcx + rsi]
	mov	r10, rdi
442:
	vmovdqu64	ymmword ptr [rcx + r11], ymm17
	cmp	r8b, -124
	jae	652f
452:
	lea	r8, [r9 + 3]
	add	rbx, rdx
	add	r11, r13
	movzx	r10d, byte ptr [rbp + r8]
	movzx	esi, byte ptr [r12 + r8 + 192]
	mov	ebp, dword ptr [r12 + 4*r8 + 256]
	vmovdqu64	ymm17, ymmword ptr [r15 + rbx]
	cmp	rdi, r11
	cmovae	rdi, r11
	mov	r8, r11
	sub	r8, rdi
	cmp	rdi, 31
	jbe	682f
	vmovdqu64	ymm18, ymmword ptr [rcx + r8]
462:
	vpaddb	ymm7, ymm18, ymm17
	vmovdqu	ymmword ptr [rcx + r11], ymm7
	cmp	sil, 33
	mov	r8, qword ptr [rsp + 24]
	jae	692f
472:
	add	r11, rsi
	mov	edi, r10d
	shr	edi, 2
	cmp	ebp, edi
	jb	772f
	mov	r15, r11
	sub	r15, rbp
	jb	772f
	vmovdqu64	ymm17, ymmword ptr [rcx + r15]
	mov	r12, rbp
482:
	vmovdqu64	ymmword ptr [rcx + r11], ymm17
	cmp	r10b, -124
	jae	712f
492:
	add	rsi, rbx
	add	rdi, r11
	add	r9, 4
	mov	rbx, qword ptr [rsp + 80]
	cmp	r9, rbx
	mov	r13, rsi
	mov	r14, rdi
	mov	r12, qword ptr [rsp + 64]
	mov	r15, qword ptr [rsp + 40]
	jb	352b
	jmp	832f
502:
	mov	rdx, qword ptr [r12 + 56]
	shl	rbp, 5
	vmovdqu	ymm7, ymmword ptr [rdx + rbp + 2048]
	vpermb	ymm17, ymm7, ymmword ptr [rcx + rax]
	jmp	362b
512:
	lea	rsi, [r15 + r13]
	lea	rdi, [rcx + r14]
	mov	r8, qword ptr [r12 + 48]
	mov	r10, qword ptr [r12 + 120]
	movzx	r8d, byte ptr [r8 + r10]
	inc	r10
	mov	qword ptr [r12 + 120], r10
	mov	r10, r8
	add	r10, 33
	mov	r8d, 32
	.p2align	4
522:
	vmovdqu	ymm7, ymmword ptr [rsi + r8]
	vmovdqu	ymmword ptr [rdi + r8], ymm7
	add	r8, 32
	cmp	r8, r10
	jb	522b
	jmp	372b
532:
	cmp	rdi, 31
	ja	542f
	mov	qword ptr [r12 + 104], 1
542:
	lea	rdx, [rcx + r11]
	mov	rdi, qword ptr [r12 + 48]
	mov	r8, qword ptr [r12 + 120]
	movzx	edi, byte ptr [rdi + r8]
	inc	r8
	mov	qword ptr [r12 + 120], r8
	mov	r8, rdi
	add	r8, 33
	add	rsi, rcx
	mov	edi, 32
	.p2align	4
552:
	vmovdqu	ymm7, ymmword ptr [rsi + rdi]
	vmovdqu	ymmword ptr [rdx + rdi], ymm7
	add	rdi, 32
	cmp	rdi, r8
	jb	552b
	jmp	392b
562:
	mov	qword ptr [rsp + 16], r8
	mov	r8, qword ptr [r12 + 56]
	shl	rax, 5
	vmovdqu	ymm7, ymmword ptr [r8 + rax + 2048]
	mov	r8, qword ptr [rsp + 16]
	vpermb	ymm18, ymm7, ymmword ptr [rcx + rdi]
	vpaddb	ymm7, ymm18, ymm17
	vmovdqu	ymmword ptr [rcx + r11], ymm7
	cmp	r8b, 33
	jb	402b
572:
	mov	rdi, qword ptr [r12 + 48]
	mov	r8, qword ptr [r12 + 120]
	movzx	eax, byte ptr [rdi + r8]
	inc	r8
	mov	qword ptr [r12 + 120], r8
	add	rax, 33
	mov	r8d, 32
	.p2align	4
582:
	lea	rdi, [r15 + rbx]
	vmovdqu	ymm7, ymmword ptr [rdi + r8]
	lea	rdi, [rcx + r11]
	vmovdqu	ymmword ptr [rdi + r8], ymm7
	add	r8, 32
	cmp	r8, rax
	jb	582b
	mov	r8, rax
	jmp	402b
592:
	cmp	r8, 31
	ja	602f
	mov	qword ptr [r12 + 104], 1
602:
	mov	rax, qword ptr [r12 + 48]
	mov	rdx, qword ptr [r12 + 120]
	movzx	eax, byte ptr [rax + rdx]
	inc	rdx
	mov	qword ptr [r12 + 120], rdx
	add	rax, 33
	add	rdi, rcx
	mov	rdx, qword ptr [rsp + 24]
	lea	r8, [rdx + r10]
	mov	rdx, qword ptr [rsp + 16]
	add	rdx, r14
	add	rdx, r8
	add	rdx, rcx
	mov	r8d, 32
	.p2align	4
612:
	vmovdqu	ymm7, ymmword ptr [rdi + r8]
	vmovdqu	ymmword ptr [rdx + r8], ymm7
	add	r8, 32
	cmp	r8, rax
	jb	612b
	jmp	422b
622:
	mov	r15, qword ptr [r12 + 56]
	shl	rsi, 5
	vmovdqu	ymm7, ymmword ptr [r15 + rsi + 2048]
	mov	r15, qword ptr [rsp + 40]
	vpermb	ymm18, ymm7, ymmword ptr [rcx + r10]
	vpaddb	ymm7, ymm18, ymm17
	vmovdqu	ymmword ptr [rcx + r11], ymm7
	cmp	dl, 33
	jb	432b
632:
	mov	rdx, qword ptr [r12 + 48]
	mov	rsi, qword ptr [r12 + 120]
	movzx	edx, byte ptr [rdx + rsi]
	inc	rsi
	mov	qword ptr [r12 + 120], rsi
	add	rdx, 33
	mov	rsi, qword ptr [rsp + 32]
	mov	r10, qword ptr [rsp + 24]
	add	r10, rsi
	mov	rsi, qword ptr [rsp + 16]
	add	rsi, rax
	add	rsi, r10
	add	rsi, r14
	add	rsi, rcx
	lea	r10, [r15 + rbx]
	mov	r15d, 32
	.p2align	4
642:
	vmovdqu	ymm7, ymmword ptr [r10 + r15]
	vmovdqu	ymmword ptr [rsi + r15], ymm7
	add	r15, 32
	cmp	r15, rdx
	jb	642b
	mov	r15, qword ptr [rsp + 40]
	jmp	432b
652:
	cmp	r10, 31
	ja	662f
	mov	qword ptr [r12 + 104], 1
662:
	mov	r8, qword ptr [r12 + 48]
	mov	r10, qword ptr [r12 + 120]
	movzx	r13d, byte ptr [r8 + r10]
	inc	r10
	mov	qword ptr [r12 + 120], r10
	add	r13, 33
	add	rsi, rcx
	mov	r8, qword ptr [rsp + 32]
	mov	r10, qword ptr [rsp + 24]
	add	r10, r8
	lea	r8, [rdx + rax]
	add	r8, r10
	mov	r10, qword ptr [rsp + 16]
	add	r10, r14
	add	r8, r10
	add	r8, rcx
	mov	r10d, 32
	.p2align	4
672:
	vmovdqu	ymm7, ymmword ptr [rsi + r10]
	vmovdqu	ymmword ptr [r8 + r10], ymm7
	add	r10, 32
	cmp	r10, r13
	jb	672b
	jmp	452b
682:
	mov	r15, qword ptr [r12 + 56]
	shl	rdi, 5
	vmovdqu	ymm7, ymmword ptr [r15 + rdi + 2048]
	mov	r15, qword ptr [rsp + 40]
	vpermb	ymm18, ymm7, ymmword ptr [rcx + r8]
	jmp	462b
692:
	mov	rsi, qword ptr [r12 + 48]
	mov	rdi, qword ptr [r12 + 120]
	movzx	esi, byte ptr [rsi + rdi]
	inc	rdi
	mov	qword ptr [r12 + 120], rdi
	add	rsi, 33
	mov	rdi, qword ptr [rsp + 32]
	add	rdi, r8
	lea	r8, [r13 + rdx]
	add	r8, rdi
	mov	r12, qword ptr [rsp + 16]
	lea	rdi, [rax + r12]
	add	rdi, r14
	add	rdi, r8
	add	rdi, rcx
	mov	r8, qword ptr [rsp + 32]
	add	r8, r12
	mov	r12, qword ptr [rsp + 72]
	add	r12, rdx
	add	r12, r8
	add	r12, r15
	mov	r8d, 32
	.p2align	4
702:
	vmovdqu	ymm7, ymmword ptr [r12 + r8]
	vmovdqu	ymmword ptr [rdi + r8], ymm7
	add	r8, 32
	cmp	r8, rsi
	jb	702b
	jmp	472b
712:
	cmp	r12, 31
	mov	r10, qword ptr [rsp + 64]
	ja	722f
	mov	qword ptr [r10 + 104], 1
722:
	mov	rdi, qword ptr [r10 + 48]
	mov	r8, qword ptr [r10 + 120]
	movzx	edi, byte ptr [rdi + r8]
	inc	r8
	mov	qword ptr [r10 + 120], r8
	add	rdi, 33
	add	r15, rcx
	mov	r8, qword ptr [rsp + 24]
	add	r8, qword ptr [rsp + 32]
	add	r13, rsi
	add	r13, r8
	add	rdx, rax
	add	rdx, qword ptr [rsp + 16]
	add	rdx, r13
	add	rdx, r14
	add	rdx, rcx
	mov	eax, 32
	.p2align	4
732:
	vmovdqu	ymm7, ymmword ptr [r15 + rax]
	vmovdqu	ymmword ptr [rdx + rax], ymm7
	add	rax, 32
	cmp	rax, rdi
	jb	732b
	jmp	492b
742:
	cmp	rax, r11
	mov	rdi, r11
	cmovb	rdi, rax
	mov	rsi, r11
	sub	rsi, rdi
	cmp	rdi, r8
	jae	782f
	mov	qword ptr [rsp + 24], r8
	mov	r8, qword ptr [r12 + 56]
	mov	r10, rdi
	shl	r10, 5
	vmovdqu	ymm7, ymmword ptr [r8 + r10 + 2048]
	mov	r8, qword ptr [rsp + 24]
	mov	r10, qword ptr [rsp + 32]
	vpermb	ymm17, ymm7, ymmword ptr [rcx + rsi]
	jmp	382b
752:
	cmp	rsi, r11
	mov	r8, r11
	cmovb	r8, rsi
	mov	rdi, r11
	sub	rdi, r8
	cmp	r8, rax
	jae	792f
	mov	r10, qword ptr [r12 + 56]
	mov	r15, r8
	shl	r15, 5
	vmovdqu	ymm7, ymmword ptr [r10 + r15 + 2048]
	mov	r10, qword ptr [rsp + 32]
	mov	r15, qword ptr [rsp + 40]
	vpermb	ymm17, ymm7, ymmword ptr [rcx + rdi]
	jmp	412b
762:
	cmp	rdi, r11
	mov	r10, r11
	cmovb	r10, rdi
	mov	rsi, r11
	sub	rsi, r10
	cmp	r10, r13
	jae	802f
	mov	r15, qword ptr [r12 + 56]
	mov	r12, r10
	shl	r12, 5
	vmovdqu	ymm7, ymmword ptr [r15 + r12 + 2048]
	mov	r15, qword ptr [rsp + 40]
	mov	r12, qword ptr [rsp + 64]
	vpermb	ymm17, ymm7, ymmword ptr [rcx + rsi]
	jmp	442b
772:
	cmp	rbp, r11
	mov	r12, r11
	cmovb	r12, rbp
	mov	r15, r11
	sub	r15, r12
	cmp	r12, rdi
	jae	812f
	mov	r8, qword ptr [rsp + 64]
	mov	r8, qword ptr [r8 + 56]
	mov	qword ptr [rsp + 72], r8
	mov	r8, r12
	shl	r8, 5
	mov	qword ptr [rsp + 104], rcx
	mov	rcx, qword ptr [rsp + 72]
	vmovdqu	ymm7, ymmword ptr [rcx + r8 + 2048]
	mov	rcx, qword ptr [rsp + 104]
	vpermb	ymm17, ymm7, ymmword ptr [rcx + r15]
	jmp	482b
782:
	vmovdqu64	ymm17, ymmword ptr [rcx + rsi]
	jmp	382b
792:
	vmovdqu64	ymm17, ymmword ptr [rcx + rdi]
	jmp	412b
802:
	vmovdqu64	ymm17, ymmword ptr [rcx + rsi]
	jmp	442b
812:
	vmovdqu64	ymm17, ymmword ptr [rcx + r15]
	jmp	482b
	.p2align	4
822:
	mov	rdi, r14
	mov	rsi, r13
	mov	r15, qword ptr [rsp + 40]
832:
	mov	r9, qword ptr [rsp + 56]
	cmp	rbx, r9
	mov	r14, rdi
	mov	r11, rsi
	je	2b
	.p2align	4
842:
	cmp	rbp, r14
	cmovae	rbp, r14
	mov	rax, r14
	sub	rax, rbp
	cmp	rbp, 31
	jbe	892f
	vmovdqu64	ymm17, ymmword ptr [rcx + rax]
852:
	mov	rax, qword ptr [rsp + 48]
	movzx	edx, byte ptr [rax + rbx]
	movzx	eax, byte ptr [r12 + rbx + 192]
	mov	ebp, dword ptr [r12 + 4*rbx + 256]
	vpaddb	ymm7, ymm17, ymmword ptr [r15 + r11]
	vmovdqu	ymmword ptr [rcx + r14], ymm7
	cmp	al, 33
	jae	902f
862:
	add	r14, rax
	mov	esi, edx
	shr	esi, 2
	cmp	ebp, esi
	jb	952f
	mov	rdi, r14
	sub	rdi, rbp
	jb	952f
	vmovdqu64	ymm17, ymmword ptr [rcx + rdi]
	mov	r8, rbp
872:
	vmovdqu64	ymmword ptr [rcx + r14], ymm17
	cmp	dl, -124
	jae	922f
882:
	add	r11, rax
	add	r14, rsi
	inc	rbx
	cmp	rbx, r9
	jb	842b
	jmp	2b
892:
	mov	rdx, qword ptr [r12 + 56]
	shl	rbp, 5
	vmovdqu	ymm7, ymmword ptr [rdx + rbp + 2048]
	vpermb	ymm17, ymm7, ymmword ptr [rcx + rax]
	jmp	852b
902:
	lea	rsi, [r15 + r11]
	lea	rdi, [rcx + r14]
	mov	rax, qword ptr [r12 + 48]
	mov	r8, qword ptr [r12 + 120]
	movzx	eax, byte ptr [rax + r8]
	inc	r8
	mov	qword ptr [r12 + 120], r8
	add	rax, 33
	mov	r8d, 32
	.p2align	4
912:
	vmovdqu	ymm7, ymmword ptr [rsi + r8]
	vmovdqu	ymmword ptr [rdi + r8], ymm7
	add	r8, 32
	cmp	r8, rax
	jb	912b
	jmp	862b
922:
	cmp	r8, 31
	ja	932f
	mov	qword ptr [r12 + 104], 1
932:
	lea	rdx, [rcx + r14]
	mov	rsi, qword ptr [r12 + 48]
	mov	r8, qword ptr [r12 + 120]
	movzx	esi, byte ptr [rsi + r8]
	inc	r8
	mov	qword ptr [r12 + 120], r8
	add	rsi, 33
	add	rdi, rcx
	mov	r8d, 32
	.p2align	4
942:
	vmovdqu	ymm7, ymmword ptr [rdi + r8]
	vmovdqu	ymmword ptr [rdx + r8], ymm7
	add	r8, 32
	cmp	r8, rsi
	jb	942b
	jmp	882b
952:
	cmp	rbp, r14
	mov	r8, r14
	cmovb	r8, rbp
	mov	rdi, r14
	sub	rdi, r8
	cmp	r8, rsi
	jae	962f
	mov	r9, qword ptr [r12 + 56]
	mov	r10, r8
	shl	r10, 5
	vmovdqu	ymm7, ymmword ptr [r9 + r10 + 2048]
	mov	r9, qword ptr [rsp + 56]
	vpermb	ymm17, ymm7, ymmword ptr [rcx + rdi]
	jmp	872b
962:
	vmovdqu64	ymm17, ymmword ptr [rcx + rdi]
	jmp	872b
972:
	add	r8, rax
	mov	r11, r8
	jmp	1042f
982:
	mov	r9, rdx
	and	r9, -256
	lea	rsi, [rax + r9]
	lea	r11, [r8 + rax + 192]
	xor	ebx, ebx
	.p2align	4
992:
	vmovdqu64	zmm7, zmmword ptr [r11 + rbx - 192]
	vmovdqu64	zmm21, zmmword ptr [r11 + rbx - 128]
	vmovdqu64	zmm22, zmmword ptr [r11 + rbx - 64]
	vmovdqu64	zmm23, zmmword ptr [r11 + rbx]
	vmovdqu64	zmmword ptr [r12 + rbx + 576], zmm7
	vmovdqu64	zmmword ptr [r12 + rbx + 640], zmm21
	vmovdqu64	zmmword ptr [r12 + rbx + 704], zmm22
	vmovdqu64	zmmword ptr [r12 + rbx + 768], zmm23
	add	rbx, 256
	cmp	r9, rbx
	jne	992b
	cmp	rdx, r9
	mov	r11, qword ptr [rsp]
	je	1042f
	test	dl, -16
	je	1022f
1002:
	mov	r11, rdx
	and	r11, -16
	lea	rsi, [rax + r11]
	mov	rbx, qword ptr [rsp]
	.p2align	4
1012:
	vmovdqu	xmm7, xmmword ptr [rdi + r9]
	vmovdqu	xmmword ptr [rbx + r9], xmm7
	add	r9, 16
	cmp	r11, r9
	jne	1012b
	cmp	rdx, r11
	mov	r11, rbx
	je	1042f
1022:
	mov	rdx, qword ptr [rsp]
	sub	rdx, rax
	.p2align	4
1032:
	movzx	eax, byte ptr [r8 + rsi]
	mov	byte ptr [rdx + rsi], al
	inc	rsi
	cmp	r10, rsi
	jne	1032b
	mov	r11, qword ptr [rsp]
1042:
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
	mov	eax, r15d
	and	eax, 7
	vpbroadcastd	zmm21, eax
	vpaddd	zmm7, zmm21, zmm7
	vpsrld	zmm21, zmm7, 3
	vpandd	zmm7, zmm7, zmm11
	vpshufb	zmm21, zmm21, zmm13
	vpaddb	zmm21, zmm21, zmm14
	vpermb	zmm21, zmm21, zmmword ptr [r11]
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
	vmovdqu64	zmmword ptr [r12 + 448], zmm18
	vshufi64x2	zmm18, zmm7, zmm7, 255
	vextracti32x4	xmm7, zmm19, 3
	vpextrd	eax, xmm7, 3
	add	r15, rax
	mov	rdi, qword ptr [rsp + 56]
	mov	r11, qword ptr [rsp + 8]
	jmp	342b
1052:
	mov	qword ptr [r12 + 80], r14
	mov	qword ptr [r12 + 88], r11
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
	.p2align	6, 0x0
1092:
	.byte	31
	.p2align	6, 0x0
1102:
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
1112:
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
1122:
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
1132:
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
1142:
	.long	1
	.p2align	2, 0x0
1152:
	.long	7
	.p2align	2, 0x0
1162:
	.long	8
	.p2align	4, 0x0
1172:
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
1182:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	6, 0x0
1192:
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
1202:
	.long	134217727

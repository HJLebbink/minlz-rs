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
	mov	r15, qword ptr [rdi + 80]
	mov	r11, qword ptr [rdi + 88]
	test	rax, rax
	jle	1052f
	mov	rcx, qword ptr [r12]
	mov	r14, qword ptr [r12 + 8]
	mov	rdx, qword ptr [r12 + 16]
	mov	qword ptr [rsp + 136], rdx
	mov	rbp, qword ptr [r12 + 96]
	lea	rdi, [r12 + 512]
	lea	rsi, [r12 + 576]
	mov	qword ptr [rsp], rsi
	mov	esi, 192
	mov	qword ptr [rsp + 120], rsi
	mov	esi, 7
	mov	qword ptr [rsp + 96], rsi
	mov	qword ptr [rsp + 128], 0
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
	mov	qword ptr [rsp + 112], rdi
	xor	edx, edx
	mov	qword ptr [rsp + 64], r12
	mov	qword ptr [rsp + 144], rax
	mov	qword ptr [rsp + 40], r14
	jmp	12f
	.p2align	4
2:
	inc	qword ptr [rsp + 128]
	add	qword ptr [rsp + 120], 64
	add	qword ptr [rsp + 96], -64
	mov	rdi, qword ptr [rsp + 88]
	add	rdi, -64
	mov	rax, qword ptr [rsp + 144]
	mov	rdx, qword ptr [rsp + 160]
	cmp	rdx, rax
	jge	1052f
12:
	mov	qword ptr [rsp + 80], r11
	mov	rsi, rax
	sub	rsi, rdx
	cmp	rsi, 64
	mov	eax, 64
	mov	qword ptr [rsp + 8], rsi
	cmovb	rax, rsi
	mov	qword ptr [rsp + 56], rax
	mov	rbx, qword ptr [r12 + 16]
	mov	rax, qword ptr [r12 + 24]
	mov	qword ptr [rsp + 152], rax
	mov	rax, qword ptr [r12 + 32]
	mov	qword ptr [rsp + 104], rax
	mov	r8, qword ptr [r12 + 40]
	mov	r13, qword ptr [r12 + 64]
	mov	rax, qword ptr [r12 + 72]
	mov	qword ptr [rsp + 72], rax
	mov	rax, qword ptr [r12 + 96]
	mov	qword ptr [rsp + 32], rax
	mov	r10, qword ptr [r12 + 112]
	mov	r11, qword ptr [r12 + 128]
	mov	rax, qword ptr [r12 + 136]
	mov	qword ptr [rsp + 16], rax
	lea	r14, [r13 + 7]
	lea	rax, [rdx + 64]
	mov	qword ptr [rsp + 160], rax
	cmp	rax, r14
	mov	qword ptr [rsp + 88], rdi
	mov	qword ptr [rsp + 48], rdx
	jbe	22f
	cmp	rdx, r14
	mov	rax, qword ptr [rsp + 112]
	mov	rsi, rax
	jge	82f
	mov	rsi, qword ptr [rsp + 128]
	shl	rsi, 6
	mov	edx, 7
	sub	rdx, rsi
	add	rdx, r13
	cmp	rdx, 16
	mov	r9, qword ptr [rsp + 48]
	jb	72f
	add	rsi, rbx
	mov	rdi, qword ptr [rsp + 64]
	sub	rdi, rsi
	add	rdi, 511
	cmp	rdi, 255
	mov	rdi, qword ptr [rsp + 88]
	mov	r9, qword ptr [rsp + 48]
	jb	72f
	cmp	rdx, 256
	jae	32f
	xor	r12d, r12d
	jmp	52f
	.p2align	4
22:
	add	rbx, rdx
	mov	rsi, rbx
	jmp	82f
32:
	mov	qword ptr [rsp + 24], r11
	mov	r12, rdx
	and	r12, -256
	mov	rax, qword ptr [rsp + 48]
	lea	r9, [rax + r12]
	mov	rax, qword ptr [rsp + 120]
	lea	r11, [rbx + rax]
	mov	rax, qword ptr [rsp + 96]
	lea	rsi, [r13 + rax]
	and	rsi, -256
	xor	edi, edi
	mov	rax, qword ptr [rsp + 64]
	.p2align	4
42:
	vmovdqu64	zmm12, zmmword ptr [r11 + rdi - 192]
	vmovdqu64	zmm13, zmmword ptr [r11 + rdi - 128]
	vmovdqu64	zmm14, zmmword ptr [r11 + rdi - 64]
	vmovdqu64	zmm15, zmmword ptr [r11 + rdi]
	vmovdqu64	zmmword ptr [rax + rdi + 512], zmm12
	vmovdqu64	zmmword ptr [rax + rdi + 576], zmm13
	vmovdqu64	zmmword ptr [rax + rdi + 640], zmm14
	vmovdqu64	zmmword ptr [rax + rdi + 704], zmm15
	add	rdi, 256
	cmp	rsi, rdi
	jne	42b
	cmp	rdx, r12
	mov	rax, qword ptr [rsp + 112]
	mov	rsi, rax
	mov	rdi, qword ptr [rsp + 88]
	mov	r11, qword ptr [rsp + 24]
	je	82f
	test	dl, -16
	je	72f
52:
	mov	rsi, rdx
	and	rsi, -16
	mov	rdi, qword ptr [rsp + 48]
	lea	r9, [rdi + rsi]
	add	rdi, rbx
	add	r13, qword ptr [rsp + 96]
	and	r13, -16
	.p2align	4
62:
	vmovdqu	xmm12, xmmword ptr [rdi + r12]
	vmovdqu	xmmword ptr [rax + r12], xmm12
	add	r12, 16
	cmp	r13, r12
	jne	62b
	cmp	rdx, rsi
	mov	rsi, rax
	mov	rdi, qword ptr [rsp + 88]
	je	82f
	.p2align	4
72:
	movzx	edx, byte ptr [rbx + r9]
	mov	byte ptr [rdi + r9], dl
	inc	r9
	cmp	r14, r9
	jne	72b
	mov	rsi, rax
82:
	vmovdqu64	zmm12, zmmword ptr [rsi]
	mov	rax, qword ptr [rsp + 56]
	vpbroadcastb	zmm13, eax
	vpcmpnleub	k2, zmm13, zmm0
	vptestmb	k1 {k2}, zmm12, zmm1
	vptestnmb	k2 {k2}, zmm12, zmm2
	mov	rax, qword ptr [rsp + 152]
	vpexpandb	zmm12 {k1} {z}, zmmword ptr [rax + r11]
	mov	r12, qword ptr [rsp + 64]
	vmovdqu64	zmmword ptr [r12 + 192], zmm12
	mov	rax, qword ptr [rsp + 16]
	mov	rdx, qword ptr [rsp + 104]
	vpexpandb	zmm12 {k2} {z}, zmmword ptr [rdx + rax]
	mov	rax, qword ptr [rsp + 72]
	mov	rsi, rax
	shr	rsi, 3
	lea	rdx, [rsi + 64]
	cmp	rdx, r10
	jbe	92f
	mov	rdi, r10
	sub	rdi, rsi
	mov	r14, qword ptr [rsp]
	mov	r13, qword ptr [rsp + 80]
	jbe	162f
	cmp	rdi, 16
	mov	r9, rsi
	jb	142f
	lea	rbx, [rsi + r8]
	mov	rdx, r12
	sub	rdx, rbx
	add	rdx, 575
	cmp	rdx, 255
	mov	r9, rsi
	jb	142f
	cmp	rdi, 256
	jae	102f
	xor	edx, edx
	jmp	122f
	.p2align	4
92:
	add	rsi, r8
	mov	r14, rsi
	mov	r13, qword ptr [rsp + 80]
	jmp	162f
102:
	mov	rax, r11
	mov	rdx, rdi
	and	rdx, -256
	lea	r9, [rsi + rdx]
	lea	r11, [r8 + rsi + 192]
	xor	r14d, r14d
	.p2align	4
112:
	vmovdqu64	zmm13, zmmword ptr [r11 + r14 - 192]
	vmovdqu64	zmm14, zmmword ptr [r11 + r14 - 128]
	vmovdqu64	zmm15, zmmword ptr [r11 + r14 - 64]
	vmovdqu64	zmm16, zmmword ptr [r11 + r14]
	vmovdqu64	zmmword ptr [r12 + r14 + 576], zmm13
	vmovdqu64	zmmword ptr [r12 + r14 + 640], zmm14
	vmovdqu64	zmmword ptr [r12 + r14 + 704], zmm15
	vmovdqu64	zmmword ptr [r12 + r14 + 768], zmm16
	add	r14, 256
	cmp	rdx, r14
	jne	112b
	cmp	rdi, rdx
	mov	r14, qword ptr [rsp]
	mov	r11, rax
	mov	rax, qword ptr [rsp + 72]
	je	162f
	test	dil, -16
	je	142f
122:
	mov	rax, r11
	mov	r11, rdi
	and	r11, -16
	lea	r9, [rsi + r11]
	mov	r14, qword ptr [rsp]
	.p2align	4
132:
	vmovdqu	xmm13, xmmword ptr [rbx + rdx]
	vmovdqu	xmmword ptr [r14 + rdx], xmm13
	add	rdx, 16
	cmp	r11, rdx
	jne	132b
	cmp	rdi, r11
	mov	r11, rax
	mov	rax, qword ptr [rsp + 72]
	je	162f
	.p2align	4
142:
	mov	rax, qword ptr [rsp]
	mov	rdx, rax
	sub	rdx, rsi
	.p2align	4
152:
	movzx	esi, byte ptr [r8 + r9]
	mov	byte ptr [rdx + r9], sil
	inc	r9
	cmp	r10, r9
	jne	152b
	mov	r14, rax
	mov	rax, qword ptr [rsp + 72]
162:
	mov	rdx, qword ptr [rsp + 32]
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
	mov	edx, eax
	and	edx, 7
	vpbroadcastd	zmm18, edx
	vpaddd	zmm15, zmm15, zmm18
	vpsrld	zmm18, zmm15, 3
	vpandd	zmm15, zmm15, zmm5
	vpshufb	zmm18, zmm18, zmm8
	vpaddb	zmm18, zmm18, zmm9
	vpermb	zmm18, zmm18, zmmword ptr [r14]
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
	vpextrd	r14d, xmm15, 3
	add	r14, rax
	vmovdqu64	zmmword ptr [r12 + 256], zmm14
	cmp	qword ptr [rsp + 8], 17
	jb	332f
	mov	rax, r14
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
	mov	qword ptr [rsp + 24], r11
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
	vmovdqu64	zmm14, zmmword ptr [r11 + rbx - 192]
	vmovdqu64	zmm15, zmmword ptr [r11 + rbx - 128]
	vmovdqu64	zmm16, zmmword ptr [r11 + rbx - 64]
	vmovdqu64	zmm17, zmmword ptr [r11 + rbx]
	vmovdqu64	zmmword ptr [r12 + rbx + 576], zmm14
	vmovdqu64	zmmword ptr [r12 + rbx + 640], zmm15
	vmovdqu64	zmmword ptr [r12 + rbx + 704], zmm16
	vmovdqu64	zmmword ptr [r12 + rbx + 768], zmm17
	add	rbx, 256
	cmp	r9, rbx
	jne	192b
	cmp	rdx, r9
	mov	rbx, qword ptr [rsp]
	mov	r11, qword ptr [rsp + 24]
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
	vmovdqu	xmm14, xmmword ptr [rdi + r9]
	vmovdqu	xmmword ptr [rbx + r9], xmm14
	add	r9, 16
	cmp	r11, r9
	jne	212b
	cmp	rdx, r11
	mov	r11, qword ptr [rsp + 24]
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
	mov	eax, r14d
	and	eax, 7
	vpbroadcastd	zmm18, eax
	vpaddd	zmm15, zmm18, zmm15
	vpsrld	zmm18, zmm15, 3
	vpandd	zmm15, zmm15, zmm5
	vpshufb	zmm18, zmm18, zmm8
	vpaddb	zmm18, zmm18, zmm9
	vpermb	zmm18, zmm18, zmmword ptr [rbx]
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
	add	r14, rax
	cmp	qword ptr [rsp + 8], 33
	jb	332f
	mov	rax, r14
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
	mov	qword ptr [rsp + 24], r11
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
	vmovdqu64	zmm14, zmmword ptr [r11 + rbx - 192]
	vmovdqu64	zmm15, zmmword ptr [r11 + rbx - 128]
	vmovdqu64	zmm16, zmmword ptr [r11 + rbx - 64]
	vmovdqu64	zmm17, zmmword ptr [r11 + rbx]
	vmovdqu64	zmmword ptr [r12 + rbx + 576], zmm14
	vmovdqu64	zmmword ptr [r12 + rbx + 640], zmm15
	vmovdqu64	zmmword ptr [r12 + rbx + 704], zmm16
	vmovdqu64	zmmword ptr [r12 + rbx + 768], zmm17
	add	rbx, 256
	cmp	r9, rbx
	jne	272b
	cmp	rdx, r9
	mov	rbx, qword ptr [rsp]
	mov	r11, qword ptr [rsp + 24]
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
	vmovdqu	xmm14, xmmword ptr [rdi + r9]
	vmovdqu	xmmword ptr [rbx + r9], xmm14
	add	r9, 16
	cmp	r11, r9
	jne	292b
	cmp	rdx, r11
	mov	r11, qword ptr [rsp + 24]
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
	mov	eax, r14d
	and	eax, 7
	vpbroadcastd	zmm18, eax
	vpaddd	zmm15, zmm18, zmm15
	vpsrld	zmm18, zmm15, 3
	vpandd	zmm15, zmm15, zmm5
	vpshufb	zmm18, zmm18, zmm8
	vpaddb	zmm18, zmm18, zmm9
	vpermb	zmm18, zmm18, zmmword ptr [rbx]
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
	add	r14, rax
	cmp	qword ptr [rsp + 8], 49
	jb	332f
	mov	qword ptr [rsp + 24], r11
	mov	rax, r14
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
	vmovd	esi, xmm13
	mov	qword ptr [r12 + 72], r14
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
	mov	r14, qword ptr [rsp + 40]
	mov	qword ptr [rsp + 72], rbx
	.p2align	4
352:
	cmp	rbp, r15
	cmovae	rbp, r15
	mov	rax, r15
	sub	rax, rbp
	cmp	rbp, 31
	jbe	502f
	vmovdqu	ymm12, ymmword ptr [rcx + rax]
362:
	mov	rbp, qword ptr [rsp + 48]
	movzx	edx, byte ptr [rbp + r9]
	movzx	r10d, byte ptr [r12 + r9 + 192]
	mov	eax, dword ptr [r12 + 4*r9 + 256]
	vpaddb	ymm12, ymm12, ymmword ptr [r14 + r13]
	vmovdqu	ymmword ptr [rcx + r15], ymm12
	cmp	r10b, 33
	jae	512f
372:
	lea	r11, [r10 + r15]
	mov	r8d, edx
	shr	r8d, 2
	cmp	eax, r8d
	mov	qword ptr [rsp + 32], r10
	jb	742f
	mov	rsi, r11
	sub	rsi, rax
	jb	742f
	vmovdqu	ymm12, ymmword ptr [rcx + rsi]
	mov	rdi, rax
382:
	vmovdqu	ymmword ptr [rcx + r11], ymm12
	cmp	dl, -124
	jae	532f
392:
	mov	qword ptr [rsp + 8], r8
	lea	rsi, [r9 + 1]
	lea	rbx, [r10 + r13]
	add	r11, r8
	movzx	edx, byte ptr [rbp + rsi]
	movzx	r8d, byte ptr [r12 + rsi + 192]
	mov	esi, dword ptr [r12 + 4*rsi + 256]
	vmovdqu	ymm12, ymmword ptr [r14 + rbx]
	cmp	rax, r11
	cmovae	rax, r11
	mov	rdi, r11
	sub	rdi, rax
	cmp	rax, 31
	jbe	562f
	vmovdqu	ymm13, ymmword ptr [rcx + rdi]
	vpaddb	ymm12, ymm13, ymm12
	vmovdqu	ymmword ptr [rcx + r11], ymm12
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
	vmovdqu	ymm12, ymmword ptr [rcx + rdi]
	mov	r8, rsi
412:
	vmovdqu	ymmword ptr [rcx + r11], ymm12
	cmp	dl, -124
	jae	592f
422:
	lea	rdi, [r9 + 2]
	add	rbx, qword ptr [rsp + 16]
	add	r11, rax
	movzx	r8d, byte ptr [rbp + rdi]
	movzx	edx, byte ptr [r12 + rdi + 192]
	mov	edi, dword ptr [r12 + 4*rdi + 256]
	vmovdqu	ymm12, ymmword ptr [r14 + rbx]
	cmp	rsi, r11
	cmovae	rsi, r11
	mov	r10, r11
	sub	r10, rsi
	cmp	rsi, 31
	jbe	622f
	vmovdqu	ymm13, ymmword ptr [rcx + r10]
	vpaddb	ymm12, ymm13, ymm12
	vmovdqu	ymmword ptr [rcx + r11], ymm12
	cmp	dl, 33
	jae	632f
432:
	mov	qword ptr [rsp + 80], r13
	add	r11, rdx
	mov	r13d, r8d
	shr	r13d, 2
	cmp	edi, r13d
	jb	762f
	mov	rsi, r11
	sub	rsi, rdi
	jb	762f
	vmovdqu	ymm12, ymmword ptr [rcx + rsi]
	mov	r10, rdi
442:
	vmovdqu	ymmword ptr [rcx + r11], ymm12
	cmp	r8b, -124
	jae	652f
452:
	lea	r8, [r9 + 3]
	add	rbx, rdx
	add	r11, r13
	movzx	r10d, byte ptr [rbp + r8]
	movzx	esi, byte ptr [r12 + r8 + 192]
	mov	ebp, dword ptr [r12 + 4*r8 + 256]
	vmovdqu	ymm12, ymmword ptr [r14 + rbx]
	cmp	rdi, r11
	cmovae	rdi, r11
	mov	r8, r11
	sub	r8, rdi
	cmp	rdi, 31
	jbe	682f
	vmovdqu	ymm13, ymmword ptr [rcx + r8]
462:
	vpaddb	ymm12, ymm13, ymm12
	vmovdqu	ymmword ptr [rcx + r11], ymm12
	cmp	sil, 33
	mov	r8, qword ptr [rsp + 8]
	jae	692f
472:
	add	r11, rsi
	mov	edi, r10d
	shr	edi, 2
	cmp	ebp, edi
	jb	772f
	mov	r14, r11
	sub	r14, rbp
	jb	772f
	vmovdqu	ymm12, ymmword ptr [rcx + r14]
	mov	r12, rbp
482:
	vmovdqu	ymmword ptr [rcx + r11], ymm12
	cmp	r10b, -124
	jae	712f
492:
	add	rsi, rbx
	add	rdi, r11
	add	r9, 4
	mov	rbx, qword ptr [rsp + 72]
	cmp	r9, rbx
	mov	r13, rsi
	mov	r15, rdi
	mov	r12, qword ptr [rsp + 64]
	mov	r14, qword ptr [rsp + 40]
	jb	352b
	jmp	832f
502:
	mov	rdx, qword ptr [r12 + 56]
	shl	rbp, 5
	vmovdqu	ymm12, ymmword ptr [rdx + rbp + 2048]
	vpermb	ymm12, ymm12, ymmword ptr [rcx + rax]
	jmp	362b
512:
	lea	rsi, [r14 + r13]
	lea	rdi, [rcx + r15]
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
	vmovdqu	ymm12, ymmword ptr [rsi + r8]
	vmovdqu	ymmword ptr [rdi + r8], ymm12
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
	vmovdqu	ymm12, ymmword ptr [rsi + rdi]
	vmovdqu	ymmword ptr [rdx + rdi], ymm12
	add	rdi, 32
	cmp	rdi, r8
	jb	552b
	jmp	392b
562:
	mov	qword ptr [rsp + 16], r8
	mov	r8, qword ptr [r12 + 56]
	shl	rax, 5
	vmovdqu	ymm13, ymmword ptr [r8 + rax + 2048]
	mov	r8, qword ptr [rsp + 16]
	vpermb	ymm13, ymm13, ymmword ptr [rcx + rdi]
	vpaddb	ymm12, ymm13, ymm12
	vmovdqu	ymmword ptr [rcx + r11], ymm12
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
	lea	rdi, [r14 + rbx]
	vmovdqu	ymm12, ymmword ptr [rdi + r8]
	lea	rdi, [rcx + r11]
	vmovdqu	ymmword ptr [rdi + r8], ymm12
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
	mov	rdx, qword ptr [rsp + 8]
	lea	r8, [rdx + r10]
	mov	rdx, qword ptr [rsp + 16]
	add	rdx, r15
	add	rdx, r8
	add	rdx, rcx
	mov	r8d, 32
	.p2align	4
612:
	vmovdqu	ymm12, ymmword ptr [rdi + r8]
	vmovdqu	ymmword ptr [rdx + r8], ymm12
	add	r8, 32
	cmp	r8, rax
	jb	612b
	jmp	422b
622:
	mov	r14, qword ptr [r12 + 56]
	shl	rsi, 5
	vmovdqu	ymm13, ymmword ptr [r14 + rsi + 2048]
	mov	r14, qword ptr [rsp + 40]
	vpermb	ymm13, ymm13, ymmword ptr [rcx + r10]
	vpaddb	ymm12, ymm13, ymm12
	vmovdqu	ymmword ptr [rcx + r11], ymm12
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
	mov	r10, qword ptr [rsp + 8]
	add	r10, rsi
	mov	rsi, qword ptr [rsp + 16]
	add	rsi, rax
	add	rsi, r10
	add	rsi, r15
	add	rsi, rcx
	lea	r10, [r14 + rbx]
	mov	r14d, 32
	.p2align	4
642:
	vmovdqu	ymm12, ymmword ptr [r10 + r14]
	vmovdqu	ymmword ptr [rsi + r14], ymm12
	add	r14, 32
	cmp	r14, rdx
	jb	642b
	mov	r14, qword ptr [rsp + 40]
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
	mov	r10, qword ptr [rsp + 8]
	add	r10, r8
	lea	r8, [rdx + rax]
	add	r8, r10
	mov	r10, qword ptr [rsp + 16]
	add	r10, r15
	add	r8, r10
	add	r8, rcx
	mov	r10d, 32
	.p2align	4
672:
	vmovdqu	ymm12, ymmword ptr [rsi + r10]
	vmovdqu	ymmword ptr [r8 + r10], ymm12
	add	r10, 32
	cmp	r10, r13
	jb	672b
	jmp	452b
682:
	mov	r14, qword ptr [r12 + 56]
	shl	rdi, 5
	vmovdqu	ymm13, ymmword ptr [r14 + rdi + 2048]
	mov	r14, qword ptr [rsp + 40]
	vpermb	ymm13, ymm13, ymmword ptr [rcx + r8]
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
	add	rdi, r15
	add	rdi, r8
	add	rdi, rcx
	mov	r8, qword ptr [rsp + 32]
	add	r8, r12
	mov	r12, qword ptr [rsp + 80]
	add	r12, rdx
	add	r12, r8
	add	r12, r14
	mov	r8d, 32
	.p2align	4
702:
	vmovdqu	ymm12, ymmword ptr [r12 + r8]
	vmovdqu	ymmword ptr [rdi + r8], ymm12
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
	add	r14, rcx
	mov	r8, qword ptr [rsp + 8]
	add	r8, qword ptr [rsp + 32]
	add	r13, rsi
	add	r13, r8
	add	rdx, rax
	add	rdx, qword ptr [rsp + 16]
	add	rdx, r13
	add	rdx, r15
	add	rdx, rcx
	mov	eax, 32
	.p2align	4
732:
	vmovdqu	ymm12, ymmword ptr [r14 + rax]
	vmovdqu	ymmword ptr [rdx + rax], ymm12
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
	mov	qword ptr [rsp + 8], r8
	mov	r8, qword ptr [r12 + 56]
	mov	r10, rdi
	shl	r10, 5
	vmovdqu	ymm12, ymmword ptr [r8 + r10 + 2048]
	mov	r8, qword ptr [rsp + 8]
	mov	r10, qword ptr [rsp + 32]
	vpermb	ymm12, ymm12, ymmword ptr [rcx + rsi]
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
	mov	r14, r8
	shl	r14, 5
	vmovdqu	ymm12, ymmword ptr [r10 + r14 + 2048]
	mov	r10, qword ptr [rsp + 32]
	mov	r14, qword ptr [rsp + 40]
	vpermb	ymm12, ymm12, ymmword ptr [rcx + rdi]
	jmp	412b
762:
	cmp	rdi, r11
	mov	r10, r11
	cmovb	r10, rdi
	mov	rsi, r11
	sub	rsi, r10
	cmp	r10, r13
	jae	802f
	mov	r14, qword ptr [r12 + 56]
	mov	r12, r10
	shl	r12, 5
	vmovdqu	ymm12, ymmword ptr [r14 + r12 + 2048]
	mov	r14, qword ptr [rsp + 40]
	mov	r12, qword ptr [rsp + 64]
	vpermb	ymm12, ymm12, ymmword ptr [rcx + rsi]
	jmp	442b
772:
	cmp	rbp, r11
	mov	r12, r11
	cmovb	r12, rbp
	mov	r14, r11
	sub	r14, r12
	cmp	r12, rdi
	jae	812f
	mov	r8, qword ptr [rsp + 64]
	mov	r8, qword ptr [r8 + 56]
	mov	qword ptr [rsp + 80], r8
	mov	r8, r12
	shl	r8, 5
	mov	qword ptr [rsp + 104], rcx
	mov	rcx, qword ptr [rsp + 80]
	vmovdqu	ymm12, ymmword ptr [rcx + r8 + 2048]
	mov	rcx, qword ptr [rsp + 104]
	vpermb	ymm12, ymm12, ymmword ptr [rcx + r14]
	jmp	482b
782:
	vmovdqu	ymm12, ymmword ptr [rcx + rsi]
	jmp	382b
792:
	vmovdqu	ymm12, ymmword ptr [rcx + rdi]
	jmp	412b
802:
	vmovdqu	ymm12, ymmword ptr [rcx + rsi]
	jmp	442b
812:
	vmovdqu	ymm12, ymmword ptr [rcx + r14]
	jmp	482b
	.p2align	4
822:
	mov	rdi, r15
	mov	rsi, r13
	mov	r14, qword ptr [rsp + 40]
832:
	mov	r9, qword ptr [rsp + 56]
	cmp	rbx, r9
	mov	r15, rdi
	mov	r11, rsi
	je	2b
	.p2align	4
842:
	cmp	rbp, r15
	cmovae	rbp, r15
	mov	rax, r15
	sub	rax, rbp
	cmp	rbp, 31
	jbe	892f
	vmovdqu	ymm12, ymmword ptr [rcx + rax]
852:
	mov	rax, qword ptr [rsp + 48]
	movzx	edx, byte ptr [rax + rbx]
	movzx	eax, byte ptr [r12 + rbx + 192]
	mov	ebp, dword ptr [r12 + 4*rbx + 256]
	vpaddb	ymm12, ymm12, ymmword ptr [r14 + r11]
	vmovdqu	ymmword ptr [rcx + r15], ymm12
	cmp	al, 33
	jae	902f
862:
	add	r15, rax
	mov	esi, edx
	shr	esi, 2
	cmp	ebp, esi
	jb	952f
	mov	rdi, r15
	sub	rdi, rbp
	jb	952f
	vmovdqu	ymm12, ymmword ptr [rcx + rdi]
	mov	r8, rbp
872:
	vmovdqu	ymmword ptr [rcx + r15], ymm12
	cmp	dl, -124
	jae	922f
882:
	add	r11, rax
	add	r15, rsi
	inc	rbx
	cmp	rbx, r9
	jb	842b
	jmp	2b
892:
	mov	rdx, qword ptr [r12 + 56]
	shl	rbp, 5
	vmovdqu	ymm12, ymmword ptr [rdx + rbp + 2048]
	vpermb	ymm12, ymm12, ymmword ptr [rcx + rax]
	jmp	852b
902:
	lea	rsi, [r14 + r11]
	lea	rdi, [rcx + r15]
	mov	rax, qword ptr [r12 + 48]
	mov	r8, qword ptr [r12 + 120]
	movzx	eax, byte ptr [rax + r8]
	inc	r8
	mov	qword ptr [r12 + 120], r8
	add	rax, 33
	mov	r8d, 32
	.p2align	4
912:
	vmovdqu	ymm12, ymmword ptr [rsi + r8]
	vmovdqu	ymmword ptr [rdi + r8], ymm12
	add	r8, 32
	cmp	r8, rax
	jb	912b
	jmp	862b
922:
	cmp	r8, 31
	ja	932f
	mov	qword ptr [r12 + 104], 1
932:
	lea	rdx, [rcx + r15]
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
	vmovdqu	ymm12, ymmword ptr [rdi + r8]
	vmovdqu	ymmword ptr [rdx + r8], ymm12
	add	r8, 32
	cmp	r8, rsi
	jb	942b
	jmp	882b
952:
	cmp	rbp, r15
	mov	r8, r15
	cmovb	r8, rbp
	mov	rdi, r15
	sub	rdi, r8
	cmp	r8, rsi
	jae	962f
	mov	r9, qword ptr [r12 + 56]
	mov	r10, r8
	shl	r10, 5
	vmovdqu	ymm12, ymmword ptr [r9 + r10 + 2048]
	mov	r9, qword ptr [rsp + 56]
	vpermb	ymm12, ymm12, ymmword ptr [rcx + rdi]
	jmp	872b
962:
	vmovdqu	ymm12, ymmword ptr [rcx + rdi]
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
	vmovdqu64	zmm14, zmmword ptr [r11 + rbx - 192]
	vmovdqu64	zmm15, zmmword ptr [r11 + rbx - 128]
	vmovdqu64	zmm16, zmmword ptr [r11 + rbx - 64]
	vmovdqu64	zmm17, zmmword ptr [r11 + rbx]
	vmovdqu64	zmmword ptr [r12 + rbx + 576], zmm14
	vmovdqu64	zmmword ptr [r12 + rbx + 640], zmm15
	vmovdqu64	zmmword ptr [r12 + rbx + 704], zmm16
	vmovdqu64	zmmword ptr [r12 + rbx + 768], zmm17
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
	vmovdqu	xmm14, xmmword ptr [rdi + r9]
	vmovdqu	xmmword ptr [rbx + r9], xmm14
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
	mov	eax, r14d
	and	eax, 7
	vpbroadcastd	zmm17, eax
	vpaddd	zmm14, zmm17, zmm14
	vpsrld	zmm17, zmm14, 3
	vpandd	zmm14, zmm14, zmm5
	vpshufb	zmm17, zmm17, zmm8
	vpaddb	zmm17, zmm17, zmm9
	vpermb	zmm17, zmm17, zmmword ptr [r11]
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
	add	r14, rax
	mov	rdi, qword ptr [rsp + 56]
	mov	r11, qword ptr [rsp + 24]
	jmp	342b
1052:
	mov	qword ptr [r12 + 80], r15
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

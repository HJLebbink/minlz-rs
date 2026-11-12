# minlz_exec_flat of crates/minlz/mlir/exec64.mlir for avx512, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 160
	mov	r13, qword ptr [rdi]
	mov	rax, qword ptr [rdi + 8]
	mov	rcx, qword ptr [rdi + 64]
	mov	r10, qword ptr [rdi + 80]
	add	r10, r13
	mov	rbx, qword ptr [rdi + 88]
	mov	qword ptr [rsp + 128], rax
	add	rbx, rax
	test	rcx, rcx
	jle	892f
	mov	rax, qword ptr [rdi + 16]
	mov	qword ptr [rsp + 136], rax
	lea	rax, [rdi + 512]
	lea	rdx, [rdi + 576]
	mov	esi, 192
	mov	qword ptr [rsp + 96], rsi
	mov	esi, 7
	mov	qword ptr [rsp + 56], rsi
	mov	qword ptr [rsp + 104], 0
	vmovdqa64	zmm22, zmmword ptr [rip + 902f]
	vpbroadcastb	zmm1, byte ptr [rip + 912f]
	vpbroadcastb	zmm2, byte ptr [rip + 922f]
	vpbroadcastd	zmm3, dword ptr [rip + 932f]
	vpternlogd	zmm4, zmm4, zmm4, 255
	vpbroadcastd	zmm5, dword ptr [rip + 942f]
	vpbroadcastd	zmm6, dword ptr [rip + 952f]
	vpxor	xmm7, xmm7, xmm7
	vbroadcasti32x4	zmm8, xmmword ptr [rip + 962f]
	vpbroadcastd	zmm9, dword ptr [rip + 972f]
	vmovdqa64	zmm10, zmmword ptr [rip + 982f]
	vpbroadcastd	zmm11, dword ptr [rip + 992f]
	vpbroadcastb	xmm12, byte ptr [rip + 1002f]
	vpbroadcastb	xmm13, byte ptr [rip + 1012f]
	mov	qword ptr [rsp + 88], rax
	xor	esi, esi
	mov	qword ptr [rsp + 24], rdi
	mov	qword ptr [rsp + 32], r13
	mov	qword ptr [rsp + 144], rcx
	mov	qword ptr [rsp], rdx
	jmp	12f
	.p2align	4
2:
	inc	qword ptr [rsp + 104]
	add	qword ptr [rsp + 96], 64
	add	qword ptr [rsp + 56], -64
	mov	rax, qword ptr [rsp + 112]
	add	rax, -64
	mov	rcx, qword ptr [rsp + 144]
	mov	rsi, qword ptr [rsp + 152]
	cmp	rsi, rcx
	jge	892f
12:
	mov	qword ptr [rsp + 40], rbx
	mov	qword ptr [rsp + 16], r10
	mov	qword ptr [rsp + 112], rax
	sub	rcx, rsi
	cmp	rcx, 64
	mov	eax, 64
	mov	qword ptr [rsp + 48], rcx
	cmovb	rax, rcx
	mov	qword ptr [rsp + 72], rax
	mov	r15, qword ptr [rdi + 16]
	mov	rbx, qword ptr [rdi + 24]
	mov	r11, qword ptr [rdi + 32]
	mov	rdx, qword ptr [rdi + 40]
	mov	r13, qword ptr [rdi + 64]
	mov	r10, qword ptr [rdi + 72]
	mov	rax, qword ptr [rdi + 96]
	mov	qword ptr [rsp + 64], rax
	mov	r9, qword ptr [rdi + 112]
	mov	r12, qword ptr [rdi + 128]
	mov	rax, qword ptr [rdi + 136]
	mov	qword ptr [rsp + 8], rax
	lea	rcx, [r13 + 7]
	lea	rax, [rsi + 64]
	mov	qword ptr [rsp + 152], rax
	mov	r14, rsi
	cmp	rax, rcx
	jbe	22f
	cmp	rsi, rcx
	mov	rdi, qword ptr [rsp + 88]
	mov	rax, rdi
	jge	92f
	mov	rax, qword ptr [rsp + 104]
	shl	rax, 6
	mov	esi, 7
	sub	rsi, rax
	add	rsi, r13
	cmp	rsi, 16
	mov	r8, r14
	jb	72f
	add	rax, r15
	mov	r8, qword ptr [rsp + 24]
	sub	r8, rax
	add	r8, 511
	cmp	r8, 255
	mov	r8, r14
	jb	72f
	cmp	rsi, 256
	mov	qword ptr [rsp + 80], r12
	jae	32f
	xor	ebp, ebp
	jmp	52f
	.p2align	4
22:
	add	r15, rsi
	mov	rax, r15
	jmp	92f
32:
	mov	qword ptr [rsp + 120], r10
	mov	rbp, rsi
	and	rbp, -256
	lea	r8, [r14 + rbp]
	mov	rax, qword ptr [rsp + 96]
	lea	r10, [r15 + rax]
	mov	rax, qword ptr [rsp + 56]
	lea	r12, [r13 + rax]
	and	r12, -256
	xor	eax, eax
	mov	rdi, qword ptr [rsp + 24]
	.p2align	4
42:
	vmovdqu64	zmm14, zmmword ptr [r10 + rax - 192]
	vmovdqu64	zmm15, zmmword ptr [r10 + rax - 128]
	vmovdqu64	zmm16, zmmword ptr [r10 + rax - 64]
	vmovdqu64	zmm17, zmmword ptr [r10 + rax]
	vmovdqu64	zmmword ptr [rdi + rax + 512], zmm14
	vmovdqu64	zmmword ptr [rdi + rax + 576], zmm15
	vmovdqu64	zmmword ptr [rdi + rax + 640], zmm16
	vmovdqu64	zmmword ptr [rdi + rax + 704], zmm17
	add	rax, 256
	cmp	r12, rax
	jne	42b
	cmp	rsi, rbp
	mov	rdi, qword ptr [rsp + 88]
	mov	rax, rdi
	mov	r12, qword ptr [rsp + 80]
	mov	r10, qword ptr [rsp + 120]
	je	92f
	test	sil, -16
	je	72f
52:
	mov	r12, r10
	mov	r10, rsi
	and	r10, -16
	lea	r8, [r14 + r10]
	lea	rax, [r15 + r14]
	add	r13, qword ptr [rsp + 56]
	and	r13, -16
	.p2align	4
62:
	vmovdqu	xmm14, xmmword ptr [rax + rbp]
	vmovdqu	xmmword ptr [rdi + rbp], xmm14
	add	rbp, 16
	cmp	r13, rbp
	jne	62b
	cmp	rsi, r10
	mov	rax, rdi
	mov	r10, r12
	mov	r12, qword ptr [rsp + 80]
	je	92f
	.p2align	4
72:
	mov	rsi, qword ptr [rsp + 112]
	.p2align	4
82:
	movzx	eax, byte ptr [r15 + r8]
	mov	byte ptr [rsi + r8], al
	inc	r8
	cmp	rcx, r8
	jne	82b
	mov	rax, rdi
92:
	vmovdqu64	zmm14, zmmword ptr [rax]
	mov	rax, qword ptr [rsp + 72]
	vpbroadcastb	zmm15, eax
	vpcmpnleub	k2, zmm15, zmm22
	vptestmb	k1 {k2}, zmm14, zmm1
	vptestnmb	k2 {k2}, zmm14, zmm2
	mov	r15, r12
	vpexpandb	zmm15 {k1} {z}, zmmword ptr [rbx + r12]
	mov	rdi, qword ptr [rsp + 24]
	vmovdqu64	zmmword ptr [rdi + 192], zmm15
	mov	rax, qword ptr [rsp + 8]
	vpexpandb	zmm15 {k2} {z}, zmmword ptr [r11 + rax]
	mov	r12, r10
	mov	rcx, r10
	shr	rcx, 3
	lea	rax, [rcx + 64]
	cmp	rax, r9
	jbe	102f
	mov	r11, r9
	sub	r11, rcx
	mov	r10, qword ptr [rsp]
	mov	r13, qword ptr [rsp + 32]
	mov	rbp, r14
	mov	r14, qword ptr [rsp + 40]
	jbe	172f
	cmp	r11, 16
	mov	r8, rcx
	jb	152f
	lea	rbx, [rcx + rdx]
	mov	rax, rdi
	sub	rax, rbx
	add	rax, 575
	cmp	rax, 255
	mov	r8, rcx
	jb	152f
	cmp	r11, 256
	jae	112f
	xor	esi, esi
	jmp	132f
	.p2align	4
102:
	add	rcx, rdx
	mov	r10, rcx
	mov	r13, qword ptr [rsp + 32]
	mov	rbp, r14
	mov	r14, qword ptr [rsp + 40]
	jmp	172f
112:
	mov	rsi, r11
	and	rsi, -256
	lea	r8, [rcx + rsi]
	lea	r10, [rdx + rcx + 192]
	xor	eax, eax
	.p2align	4
122:
	vmovdqu64	zmm16, zmmword ptr [r10 + rax - 192]
	vmovdqu64	zmm17, zmmword ptr [r10 + rax - 128]
	vmovdqu64	zmm18, zmmword ptr [r10 + rax - 64]
	vmovdqu64	zmm19, zmmword ptr [r10 + rax]
	vmovdqu64	zmmword ptr [rdi + rax + 576], zmm16
	vmovdqu64	zmmword ptr [rdi + rax + 640], zmm17
	vmovdqu64	zmmword ptr [rdi + rax + 704], zmm18
	vmovdqu64	zmmword ptr [rdi + rax + 768], zmm19
	add	rax, 256
	cmp	rsi, rax
	jne	122b
	cmp	r11, rsi
	mov	r10, qword ptr [rsp]
	je	172f
	test	r11b, -16
	je	152f
132:
	mov	rax, r11
	and	rax, -16
	lea	r8, [rcx + rax]
	mov	r10, qword ptr [rsp]
	.p2align	4
142:
	vmovdqu64	xmm16, xmmword ptr [rbx + rsi]
	vmovdqu64	xmmword ptr [r10 + rsi], xmm16
	add	rsi, 16
	cmp	rax, rsi
	jne	142b
	cmp	r11, rax
	je	172f
	.p2align	4
152:
	mov	r10, qword ptr [rsp]
	mov	rax, r10
	sub	rax, rcx
	.p2align	4
162:
	movzx	ecx, byte ptr [rdx + r8]
	mov	byte ptr [rax + r8], cl
	inc	r8
	cmp	r9, r8
	jne	162b
172:
	mov	rax, qword ptr [rsp + 64]
	vpbroadcastd	zmm17, eax
	vpmovzxbd	zmm16, xmm15
	vpsrld	zmm18, zmm16, 3
	vpmaxud	zmm18, zmm18, zmm3
	vpaddd	zmm18, zmm18, zmm4
	vpminud	zmm19, zmm16, zmm6
	vpandd	zmm19, zmm19, zmm6
	vpternlogd	zmm19, zmm16, zmm5, 248
	vpsllvd	zmm16, zmm19, zmm18
	vpsllvd	zmm19, zmm4, zmm18
	valignd	zmm20, zmm18, zmm7, 15
	vpaddd	zmm20, zmm20, zmm18
	valignq	zmm21, zmm20, zmm7, 7
	vpaddd	zmm20, zmm21, zmm20
	valignq	zmm21, zmm20, zmm7, 6
	vpaddd	zmm20, zmm21, zmm20
	valignq	zmm21, zmm20, zmm7, 4
	vpaddd	zmm20, zmm21, zmm20
	vpsubd	zmm18, zmm20, zmm18
	mov	eax, r12d
	and	eax, 7
	vpbroadcastd	zmm21, eax
	vpaddd	zmm18, zmm18, zmm21
	vpsrld	zmm21, zmm18, 3
	vpandd	zmm18, zmm18, zmm5
	vpshufb	zmm21, zmm21, zmm8
	vpaddb	zmm21, zmm21, zmm9
	vpermb	zmm21, zmm21, zmmword ptr [r10]
	vpsrlvd	zmm18, zmm21, zmm18
	vpandnd	zmm18, zmm19, zmm18
	vpaddd	zmm16, zmm18, zmm16
	vptestmd	k3, zmm16, zmm16
	vpord	zmm16 {k3} {z}, zmm16, zmm10
	valignd	zmm18, zmm16, zmm7, 15
	vpmaxud	zmm16, zmm16, zmm18
	valignq	zmm18, zmm16, zmm7, 7
	vpmaxud	zmm16, zmm16, zmm18
	valignq	zmm18, zmm16, zmm7, 6
	vpmaxud	zmm16, zmm16, zmm18
	valignq	zmm18, zmm16, zmm7, 4
	vpmaxud	zmm16, zmm16, zmm18
	vptestmd	k3, zmm16, zmm16
	vpandd	zmm17 {k3}, zmm16, zmm11
	vpshufd	zmm16, zmm17, 255
	vshufi64x2	zmm16, zmm16, zmm16, 255
	vpsrlw	xmm18, xmm14, 2
	vpandq	xmm18, xmm18, xmm12
	vpminub	xmm18, xmm18, xmm13
	vpmovzxbd	zmm18, xmm18
	vpmaxud	zmm17, zmm17, zmm18
	vextracti32x4	xmm0, zmm20, 3
	vpextrd	esi, xmm0, 3
	add	rsi, r12
	vmovdqu64	zmmword ptr [rdi + 256], zmm17
	cmp	qword ptr [rsp + 48], 17
	jb	182f
	mov	rax, rsi
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, r9
	mov	r12, r15
	jbe	192f
	mov	rcx, r9
	sub	rcx, rax
	mov	rbx, qword ptr [rsp]
	mov	r15, qword ptr [rsp + 8]
	jbe	262f
	cmp	rcx, 16
	mov	r8, rax
	jb	242f
	lea	r11, [rax + rdx]
	mov	r8, rdi
	sub	r8, r11
	add	r8, 575
	cmp	r8, 255
	mov	r8, rax
	jb	242f
	cmp	rcx, 256
	jae	202f
	xor	r10d, r10d
	jmp	222f
	.p2align	4
182:
	mov	r11, qword ptr [rsp + 16]
	mov	r12, r15
	mov	r15, qword ptr [rsp + 8]
	jmp	442f
	.p2align	4
192:
	add	rax, rdx
	mov	rbx, rax
	mov	r15, qword ptr [rsp + 8]
	jmp	262f
202:
	mov	r10, rcx
	and	r10, -256
	lea	r8, [rax + r10]
	lea	rbx, [rdx + rax + 192]
	xor	r15d, r15d
	.p2align	4
212:
	vmovdqu64	zmm0, zmmword ptr [rbx + r15 - 192]
	vmovdqu64	zmm17, zmmword ptr [rbx + r15 - 128]
	vmovdqu64	zmm18, zmmword ptr [rbx + r15 - 64]
	vmovdqu64	zmm19, zmmword ptr [rbx + r15]
	vmovdqu64	zmmword ptr [rdi + r15 + 576], zmm0
	vmovdqu64	zmmword ptr [rdi + r15 + 640], zmm17
	vmovdqu64	zmmword ptr [rdi + r15 + 704], zmm18
	vmovdqu64	zmmword ptr [rdi + r15 + 768], zmm19
	add	r15, 256
	cmp	r10, r15
	jne	212b
	cmp	rcx, r10
	mov	rbx, qword ptr [rsp]
	mov	r15, qword ptr [rsp + 8]
	je	262f
	test	cl, -16
	je	242f
222:
	mov	rbx, rcx
	and	rbx, -16
	lea	r8, [rax + rbx]
	mov	r15, qword ptr [rsp]
	.p2align	4
232:
	vmovdqu	xmm0, xmmword ptr [r11 + r10]
	vmovdqu	xmmword ptr [r15 + r10], xmm0
	add	r10, 16
	cmp	rbx, r10
	jne	232b
	cmp	rcx, rbx
	mov	rbx, r15
	mov	r15, qword ptr [rsp + 8]
	je	262f
242:
	mov	rcx, qword ptr [rsp]
	sub	rcx, rax
	.p2align	4
252:
	movzx	eax, byte ptr [rdx + r8]
	mov	byte ptr [rcx + r8], al
	inc	r8
	cmp	r9, r8
	jne	252b
	mov	rbx, qword ptr [rsp]
262:
	vextracti128	xmm0, ymm15, 1
	vpmovzxbd	zmm0, xmm0
	vpsrld	zmm17, zmm0, 3
	vpmaxud	zmm17, zmm17, zmm3
	vpaddd	zmm17, zmm17, zmm4
	vpminud	zmm18, zmm0, zmm6
	vpandd	zmm18, zmm18, zmm6
	vpternlogd	zmm18, zmm0, zmm5, 248
	vpsllvd	zmm0, zmm18, zmm17
	vpsllvd	zmm18, zmm4, zmm17
	valignd	zmm19, zmm17, zmm7, 15
	vpaddd	zmm19, zmm19, zmm17
	valignq	zmm20, zmm19, zmm7, 7
	vpaddd	zmm19, zmm20, zmm19
	valignq	zmm20, zmm19, zmm7, 6
	vpaddd	zmm19, zmm20, zmm19
	valignq	zmm20, zmm19, zmm7, 4
	vpaddd	zmm19, zmm20, zmm19
	vpsubd	zmm17, zmm19, zmm17
	mov	eax, esi
	and	eax, 7
	vpbroadcastd	zmm20, eax
	vpaddd	zmm17, zmm20, zmm17
	vpsrld	zmm20, zmm17, 3
	vpandd	zmm17, zmm17, zmm5
	vpshufb	zmm20, zmm20, zmm8
	vpaddb	zmm20, zmm20, zmm9
	vpermb	zmm20, zmm20, zmmword ptr [rbx]
	vpsrlvd	zmm17, zmm20, zmm17
	vpandnd	zmm17, zmm18, zmm17
	vpaddd	zmm0, zmm17, zmm0
	vptestmd	k3, zmm0, zmm0
	vpord	zmm0 {k3} {z}, zmm0, zmm10
	valignd	zmm17, zmm0, zmm7, 15
	vpmaxud	zmm0, zmm0, zmm17
	valignq	zmm17, zmm0, zmm7, 7
	vpmaxud	zmm0, zmm0, zmm17
	valignq	zmm17, zmm0, zmm7, 6
	vpmaxud	zmm0, zmm0, zmm17
	valignq	zmm17, zmm0, zmm7, 4
	vpmaxud	zmm0, zmm0, zmm17
	vptestmd	k3, zmm0, zmm0
	vpandd	zmm16 {k3}, zmm0, zmm11
	vpshufd	zmm0, zmm16, 255
	vextracti32x4	xmm17, ymm14, 1
	vpsrlw	xmm17, xmm17, 2
	vpandq	xmm17, xmm17, xmm12
	vpminub	xmm17, xmm17, xmm13
	vpmovzxbd	zmm17, xmm17
	vpmaxud	zmm17, zmm16, zmm17
	vshufi64x2	zmm16, zmm0, zmm0, 255
	vextracti32x4	xmm0, zmm19, 3
	vpextrd	eax, xmm0, 3
	add	rsi, rax
	vmovdqu64	zmmword ptr [rdi + 320], zmm17
	cmp	qword ptr [rsp + 48], 33
	jb	432f
	mov	rax, rsi
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, r9
	jbe	272f
	mov	rcx, r9
	sub	rcx, rax
	mov	rbx, qword ptr [rsp]
	jbe	342f
	cmp	rcx, 16
	mov	r8, rax
	jb	322f
	lea	r11, [rax + rdx]
	mov	r8, rdi
	sub	r8, r11
	add	r8, 575
	cmp	r8, 255
	mov	r8, rax
	jb	322f
	cmp	rcx, 256
	jae	282f
	xor	r10d, r10d
	jmp	302f
272:
	add	rax, rdx
	mov	rbx, rax
	jmp	342f
282:
	mov	r10, rcx
	and	r10, -256
	lea	r8, [rax + r10]
	lea	rbx, [rdx + rax + 192]
	xor	r15d, r15d
	.p2align	4
292:
	vmovdqu64	zmm0, zmmword ptr [rbx + r15 - 192]
	vmovdqu64	zmm17, zmmword ptr [rbx + r15 - 128]
	vmovdqu64	zmm18, zmmword ptr [rbx + r15 - 64]
	vmovdqu64	zmm19, zmmword ptr [rbx + r15]
	vmovdqu64	zmmword ptr [rdi + r15 + 576], zmm0
	vmovdqu64	zmmword ptr [rdi + r15 + 640], zmm17
	vmovdqu64	zmmword ptr [rdi + r15 + 704], zmm18
	vmovdqu64	zmmword ptr [rdi + r15 + 768], zmm19
	add	r15, 256
	cmp	r10, r15
	jne	292b
	cmp	rcx, r10
	mov	rbx, qword ptr [rsp]
	mov	r15, qword ptr [rsp + 8]
	je	342f
	test	cl, -16
	je	322f
302:
	mov	rbx, rcx
	and	rbx, -16
	lea	r8, [rax + rbx]
	mov	r15, qword ptr [rsp]
	.p2align	4
312:
	vmovdqu	xmm0, xmmword ptr [r11 + r10]
	vmovdqu	xmmword ptr [r15 + r10], xmm0
	add	r10, 16
	cmp	rbx, r10
	jne	312b
	cmp	rcx, rbx
	mov	rbx, r15
	mov	r15, qword ptr [rsp + 8]
	je	342f
322:
	mov	rcx, qword ptr [rsp]
	sub	rcx, rax
	.p2align	4
332:
	movzx	eax, byte ptr [rdx + r8]
	mov	byte ptr [rcx + r8], al
	inc	r8
	cmp	r9, r8
	jne	332b
	mov	rbx, qword ptr [rsp]
342:
	vextracti32x4	xmm0, zmm15, 2
	vpmovzxbd	zmm0, xmm0
	vpsrld	zmm17, zmm0, 3
	vpmaxud	zmm17, zmm17, zmm3
	vpaddd	zmm17, zmm17, zmm4
	vpminud	zmm18, zmm0, zmm6
	vpandd	zmm18, zmm18, zmm6
	vpternlogd	zmm18, zmm0, zmm5, 248
	vpsllvd	zmm0, zmm18, zmm17
	vpsllvd	zmm18, zmm4, zmm17
	valignd	zmm19, zmm17, zmm7, 15
	vpaddd	zmm19, zmm19, zmm17
	valignq	zmm20, zmm19, zmm7, 7
	vpaddd	zmm19, zmm20, zmm19
	valignq	zmm20, zmm19, zmm7, 6
	vpaddd	zmm19, zmm20, zmm19
	valignq	zmm20, zmm19, zmm7, 4
	vpaddd	zmm19, zmm20, zmm19
	vpsubd	zmm17, zmm19, zmm17
	mov	eax, esi
	and	eax, 7
	vpbroadcastd	zmm20, eax
	vpaddd	zmm17, zmm20, zmm17
	vpsrld	zmm20, zmm17, 3
	vpandd	zmm17, zmm17, zmm5
	vpshufb	zmm20, zmm20, zmm8
	vpaddb	zmm20, zmm20, zmm9
	vpermb	zmm20, zmm20, zmmword ptr [rbx]
	vpsrlvd	zmm17, zmm20, zmm17
	vpandnd	zmm17, zmm18, zmm17
	vpaddd	zmm0, zmm17, zmm0
	vptestmd	k3, zmm0, zmm0
	vpord	zmm0 {k3} {z}, zmm0, zmm10
	valignd	zmm17, zmm0, zmm7, 15
	vpmaxud	zmm0, zmm0, zmm17
	valignq	zmm17, zmm0, zmm7, 7
	vpmaxud	zmm0, zmm0, zmm17
	valignq	zmm17, zmm0, zmm7, 6
	vpmaxud	zmm0, zmm0, zmm17
	valignq	zmm17, zmm0, zmm7, 4
	vpmaxud	zmm0, zmm0, zmm17
	vptestmd	k3, zmm0, zmm0
	vpandd	zmm16 {k3}, zmm0, zmm11
	vpshufd	zmm0, zmm16, 255
	vextracti32x4	xmm17, zmm14, 2
	vpsrlw	xmm17, xmm17, 2
	vpandq	xmm17, xmm17, xmm12
	vpminub	xmm17, xmm17, xmm13
	vpmovzxbd	zmm17, xmm17
	vpmaxud	zmm17, zmm16, zmm17
	vshufi64x2	zmm16, zmm0, zmm0, 255
	vextracti32x4	xmm0, zmm19, 3
	vpextrd	eax, xmm0, 3
	add	rsi, rax
	vmovdqu64	zmmword ptr [rdi + 384], zmm17
	cmp	qword ptr [rsp + 48], 49
	jb	432f
	mov	rax, rsi
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, r9
	jbe	352f
	mov	rcx, r9
	sub	rcx, rax
	mov	rbx, qword ptr [rsp]
	jbe	422f
	cmp	rcx, 16
	mov	r8, rax
	jb	402f
	lea	r11, [rax + rdx]
	mov	r8, rdi
	sub	r8, r11
	add	r8, 575
	cmp	r8, 255
	mov	r8, rax
	jb	402f
	cmp	rcx, 256
	jae	362f
	xor	r10d, r10d
	jmp	382f
352:
	add	rdx, rax
	mov	rbx, rdx
	jmp	422f
362:
	mov	r10, rcx
	and	r10, -256
	lea	r8, [rax + r10]
	lea	rbx, [rdx + rax + 192]
	xor	r15d, r15d
	.p2align	4
372:
	vmovdqu64	zmm0, zmmword ptr [rbx + r15 - 192]
	vmovdqu64	zmm17, zmmword ptr [rbx + r15 - 128]
	vmovdqu64	zmm18, zmmword ptr [rbx + r15 - 64]
	vmovdqu64	zmm19, zmmword ptr [rbx + r15]
	vmovdqu64	zmmword ptr [rdi + r15 + 576], zmm0
	vmovdqu64	zmmword ptr [rdi + r15 + 640], zmm17
	vmovdqu64	zmmword ptr [rdi + r15 + 704], zmm18
	vmovdqu64	zmmword ptr [rdi + r15 + 768], zmm19
	add	r15, 256
	cmp	r10, r15
	jne	372b
	cmp	rcx, r10
	mov	rbx, qword ptr [rsp]
	mov	r15, qword ptr [rsp + 8]
	je	422f
	test	cl, -16
	je	402f
382:
	mov	rbx, rcx
	and	rbx, -16
	lea	r8, [rax + rbx]
	mov	r15, qword ptr [rsp]
	.p2align	4
392:
	vmovdqu	xmm0, xmmword ptr [r11 + r10]
	vmovdqu	xmmword ptr [r15 + r10], xmm0
	add	r10, 16
	cmp	rbx, r10
	jne	392b
	cmp	rcx, rbx
	mov	rbx, r15
	mov	r15, qword ptr [rsp + 8]
	je	422f
402:
	mov	rcx, qword ptr [rsp]
	sub	rcx, rax
	.p2align	4
412:
	movzx	eax, byte ptr [rdx + r8]
	mov	byte ptr [rcx + r8], al
	inc	r8
	cmp	r9, r8
	jne	412b
	mov	rbx, qword ptr [rsp]
422:
	vextracti32x4	xmm0, zmm15, 3
	vpmovzxbd	zmm0, xmm0
	vpsrld	zmm15, zmm0, 3
	vpmaxud	zmm15, zmm15, zmm3
	vpaddd	zmm15, zmm15, zmm4
	vpminud	zmm17, zmm0, zmm6
	vpandd	zmm17, zmm17, zmm6
	vpternlogd	zmm17, zmm0, zmm5, 248
	vpsllvd	zmm0, zmm17, zmm15
	vpsllvd	zmm17, zmm4, zmm15
	valignd	zmm18, zmm15, zmm7, 15
	vpaddd	zmm18, zmm18, zmm15
	valignq	zmm19, zmm18, zmm7, 7
	vpaddd	zmm18, zmm19, zmm18
	valignq	zmm19, zmm18, zmm7, 6
	vpaddd	zmm18, zmm19, zmm18
	valignq	zmm19, zmm18, zmm7, 4
	vpaddd	zmm18, zmm19, zmm18
	vpsubd	zmm15, zmm18, zmm15
	mov	eax, esi
	and	eax, 7
	vpbroadcastd	zmm19, eax
	vpaddd	zmm15, zmm19, zmm15
	vpsrld	zmm19, zmm15, 3
	vpandd	zmm15, zmm15, zmm5
	vpshufb	zmm19, zmm19, zmm8
	vpaddb	zmm19, zmm19, zmm9
	vpermb	zmm19, zmm19, zmmword ptr [rbx]
	vpsrlvd	zmm15, zmm19, zmm15
	vpandnd	zmm15, zmm17, zmm15
	vpaddd	zmm0, zmm15, zmm0
	vptestmd	k3, zmm0, zmm0
	vpord	zmm0 {k3} {z}, zmm0, zmm10
	valignd	zmm15, zmm0, zmm7, 15
	vpmaxud	zmm0, zmm0, zmm15
	valignq	zmm15, zmm0, zmm7, 7
	vpmaxud	zmm0, zmm0, zmm15
	valignq	zmm15, zmm0, zmm7, 6
	vpmaxud	zmm0, zmm0, zmm15
	valignq	zmm15, zmm0, zmm7, 4
	vpmaxud	zmm0, zmm0, zmm15
	vptestmd	k3, zmm0, zmm0
	vpandd	zmm16 {k3}, zmm0, zmm11
	vpshufd	zmm0, zmm16, 255
	vextracti32x4	xmm14, zmm14, 3
	vpsrlw	xmm14, xmm14, 2
	vpand	xmm14, xmm14, xmm12
	vpminub	xmm14, xmm14, xmm13
	vpmovzxbd	zmm14, xmm14
	vpmaxud	zmm14, zmm16, zmm14
	vshufi64x2	zmm16, zmm0, zmm0, 255
	vextracti32x4	xmm0, zmm18, 3
	vpextrd	eax, xmm0, 3
	add	rsi, rax
	vmovdqu64	zmmword ptr [rdi + 448], zmm14
432:
	mov	r11, qword ptr [rsp + 16]
442:
	kmovq	rax, k2
	popcnt	rax, rax
	add	rax, r15
	kmovq	rcx, k1
	popcnt	rcx, rcx
	add	rcx, r12
	vmovd	edx, xmm16
	mov	qword ptr [rdi + 72], rsi
	mov	qword ptr [rdi + 96], rdx
	mov	qword ptr [rdi + 128], rcx
	mov	qword ptr [rdi + 136], rax
	add	rbp, qword ptr [rsp + 136]
	mov	rdx, qword ptr [rsp + 72]
	and	rdx, 124
	je	782f
	xor	esi, esi
	mov	qword ptr [rsp + 8], rbp
	.p2align	4
452:
	movzx	r9d, byte ptr [rbp + rsi]
	movzx	r12d, byte ptr [rdi + rsi + 192]
	cmp	r12, 33
	mov	eax, dword ptr [rdi + 4*rsi + 256]
	vmovdqu	ymm0, ymmword ptr [r14]
	vmovdqu	ymmword ptr [r11], ymm0
	jae	582f
462:
	lea	r8, [r11 + r12]
	mov	rcx, r8
	sub	rcx, rax
	cmp	rcx, r13
	jl	602f
472:
	vmovdqu	ymm0, ymmword ptr [rcx]
	vmovdqu	ymmword ptr [r8], ymm0
	cmp	r9b, -124
	mov	qword ptr [rsp + 16], r11
	jae	612f
	shr	r9d, 2
482:
	lea	rcx, [rsi + 1]
	lea	rax, [r14 + r12]
	movzx	r11d, byte ptr [rbp + rcx]
	movzx	ebx, byte ptr [rdi + rcx + 192]
	cmp	rbx, 33
	mov	ecx, dword ptr [rdi + 4*rcx + 256]
	vmovdqu	ymm0, ymmword ptr [r14 + r12]
	vmovdqu	ymmword ptr [r8 + r9], ymm0
	jae	632f
492:
	add	r8, r9
	add	r8, rbx
	mov	r10, r8
	sub	r10, rcx
	cmp	r10, r13
	jl	652f
502:
	mov	qword ptr [rsp + 40], r14
	vmovdqu	ymm0, ymmword ptr [r10]
	vmovdqu	ymmword ptr [r8], ymm0
	cmp	r11b, -124
	jae	662f
	shr	r11d, 2
512:
	lea	rcx, [rsi + 2]
	movzx	ebp, byte ptr [rbp + rcx]
	movzx	r15d, byte ptr [rdi + rcx + 192]
	cmp	r15, 33
	mov	ecx, dword ptr [rdi + 4*rcx + 256]
	vmovdqu	ymm0, ymmword ptr [rax + rbx]
	vmovdqu	ymmword ptr [r8 + r11], ymm0
	jae	682f
522:
	add	r8, r11
	add	r8, r15
	mov	r10, r8
	sub	r10, rcx
	cmp	r10, r13
	jl	702f
	vmovdqu	ymm0, ymmword ptr [r10]
	vmovdqu	ymmword ptr [r8], ymm0
	cmp	bpl, -124
	jae	712f
532:
	shr	ebp, 2
542:
	lea	r10, [rsi + 3]
	add	rax, rbx
	mov	rcx, qword ptr [rsp + 8]
	movzx	r13d, byte ptr [rcx + r10]
	mov	rdi, qword ptr [rsp + 24]
	movzx	ecx, byte ptr [rdi + r10 + 192]
	cmp	rcx, 33
	mov	r10d, dword ptr [rdi + 4*r10 + 256]
	vmovdqu	ymm0, ymmword ptr [rax + r15]
	vmovdqu	ymmword ptr [r8 + rbp], ymm0
	jae	732f
552:
	add	r8, rbp
	add	r8, rcx
	mov	rdi, r8
	sub	rdi, r10
	cmp	rdi, qword ptr [rsp + 32]
	jl	752f
	vmovdqu	ymm0, ymmword ptr [rdi]
	vmovdqu	ymmword ptr [r8], ymm0
	cmp	r13b, -124
	jae	762f
562:
	shr	r13d, 2
572:
	mov	rbp, qword ptr [rsp + 8]
	add	rax, r15
	add	r8, r13
	add	rax, rcx
	add	rsi, 4
	cmp	rsi, rdx
	mov	r14, rax
	mov	r11, r8
	mov	rdi, qword ptr [rsp + 24]
	mov	r13, qword ptr [rsp + 32]
	jb	452b
	jmp	792f
582:
	mov	rcx, qword ptr [rdi + 48]
	mov	r8, qword ptr [rdi + 120]
	movzx	r12d, byte ptr [rcx + r8]
	inc	r8
	mov	qword ptr [rdi + 120], r8
	add	r12, 33
	mov	ecx, 32
	.p2align	4
592:
	vmovdqu	ymm0, ymmword ptr [r14 + rcx]
	vmovdqu	ymmword ptr [r11 + rcx], ymm0
	add	rcx, 32
	cmp	rcx, r12
	jb	592b
	jmp	462b
602:
	mov	r10, r8
	sub	r10, r13
	sub	r10, rax
	mov	ecx, 0
	cmovae	rcx, r10
	add	rcx, r13
	jmp	472b
612:
	mov	rax, qword ptr [rdi + 48]
	mov	r10, qword ptr [rdi + 120]
	movzx	r9d, byte ptr [rax + r10]
	inc	r10
	mov	qword ptr [rdi + 120], r10
	add	r9, 33
	mov	eax, 32
	.p2align	4
622:
	vmovdqu	ymm0, ymmword ptr [rcx + rax]
	vmovdqu	ymmword ptr [r8 + rax], ymm0
	add	rax, 32
	cmp	rax, r9
	jb	622b
	jmp	482b
632:
	mov	r10, qword ptr [rdi + 48]
	mov	r15, qword ptr [rdi + 120]
	movzx	ebx, byte ptr [r10 + r15]
	inc	r15
	mov	qword ptr [rdi + 120], r15
	add	rbx, 33
	lea	r10, [r12 + r9]
	add	r10, qword ptr [rsp + 16]
	mov	r15d, 32
	.p2align	4
642:
	vmovdqu	ymm0, ymmword ptr [rax + r15]
	vmovdqu	ymmword ptr [r10 + r15], ymm0
	add	r15, 32
	cmp	r15, rbx
	jb	642b
	jmp	492b
652:
	mov	r15, r8
	sub	r15, r13
	sub	r15, rcx
	mov	r10d, 0
	cmovae	r10, r15
	add	r10, r13
	jmp	502b
662:
	mov	rcx, qword ptr [rdi + 48]
	mov	r15, qword ptr [rdi + 120]
	movzx	r11d, byte ptr [rcx + r15]
	inc	r15
	mov	qword ptr [rdi + 120], r15
	add	r11, 33
	lea	rcx, [r12 + rbx]
	mov	r14, qword ptr [rsp + 16]
	add	rcx, r14
	add	rcx, r9
	mov	r15d, 32
	.p2align	4
672:
	vmovdqu	ymm0, ymmword ptr [r10 + r15]
	vmovdqu	ymmword ptr [rcx + r15], ymm0
	add	r15, 32
	cmp	r15, r11
	jb	672b
	jmp	512b
682:
	mov	r10, qword ptr [rdi + 48]
	mov	r13, qword ptr [rdi + 120]
	movzx	r15d, byte ptr [r10 + r13]
	inc	r13
	mov	qword ptr [rdi + 120], r13
	add	r15, 33
	lea	rdi, [r12 + rbx]
	lea	r13, [r11 + r9]
	add	r13, rdi
	add	r13, qword ptr [rsp + 16]
	add	rdi, qword ptr [rsp + 40]
	mov	r10d, 32
	.p2align	4
692:
	vmovdqu	ymm0, ymmword ptr [rdi + r10]
	vmovdqu	ymmword ptr [r13 + r10], ymm0
	add	r10, 32
	cmp	r10, r15
	jb	692b
	mov	rdi, qword ptr [rsp + 24]
	mov	r13, qword ptr [rsp + 32]
	jmp	522b
702:
	mov	r13, r8
	sub	r13, qword ptr [rsp + 32]
	sub	r13, rcx
	mov	r10d, 0
	cmovae	r10, r13
	mov	rdi, qword ptr [rsp + 24]
	add	r10, qword ptr [rsp + 32]
	vmovdqu	ymm0, ymmword ptr [r10]
	vmovdqu	ymmword ptr [r8], ymm0
	cmp	bpl, -124
	jb	532b
712:
	mov	rcx, qword ptr [rdi + 48]
	mov	r13, qword ptr [rdi + 120]
	movzx	ebp, byte ptr [rcx + r13]
	inc	r13
	mov	qword ptr [rdi + 120], r13
	add	rbp, 33
	lea	rcx, [r11 + rbx]
	add	rcx, r12
	add	rcx, r15
	mov	rdi, qword ptr [rsp + 16]
	add	rcx, rdi
	add	rcx, r9
	mov	r13d, 32
	.p2align	4
722:
	vmovdqu	ymm0, ymmword ptr [r10 + r13]
	vmovdqu	ymmword ptr [rcx + r13], ymm0
	add	r13, 32
	cmp	r13, rbp
	jb	722b
	jmp	542b
732:
	mov	rdi, qword ptr [rsp + 24]
	mov	rcx, qword ptr [rdi + 48]
	mov	r14, qword ptr [rdi + 120]
	movzx	ecx, byte ptr [rcx + r14]
	inc	r14
	mov	qword ptr [rdi + 120], r14
	add	rcx, 33
	lea	r14, [rbp + r11]
	add	r14, r12
	add	r14, r15
	lea	rdi, [rbx + r9]
	add	rdi, qword ptr [rsp + 16]
	add	rdi, r14
	mov	qword ptr [rsp + 64], rdi
	mov	rdi, qword ptr [rsp + 40]
	add	rdi, rbx
	add	rdi, r12
	add	rdi, r15
	mov	qword ptr [rsp + 40], rdi
	mov	edi, 32
	mov	qword ptr [rsp + 48], rdi
	.p2align	4
742:
	mov	rdi, qword ptr [rsp + 40]
	mov	r14, qword ptr [rsp + 48]
	vmovdqu	ymm0, ymmword ptr [rdi + r14]
	mov	rdi, qword ptr [rsp + 64]
	vmovdqu	ymmword ptr [rdi + r14], ymm0
	add	r14, 32
	mov	qword ptr [rsp + 48], r14
	cmp	r14, rcx
	jb	742b
	jmp	552b
752:
	mov	rdi, r8
	mov	r14, qword ptr [rsp + 32]
	sub	rdi, r14
	sub	rdi, r10
	mov	r10, rdi
	mov	edi, 0
	cmovae	rdi, r10
	add	rdi, r14
	vmovdqu	ymm0, ymmword ptr [rdi]
	vmovdqu	ymmword ptr [r8], ymm0
	cmp	r13b, -124
	jb	562b
762:
	mov	r14, qword ptr [rsp + 24]
	mov	r13, qword ptr [r14 + 48]
	mov	r10, qword ptr [r14 + 120]
	movzx	r13d, byte ptr [r13 + r10]
	inc	r10
	mov	qword ptr [r14 + 120], r10
	add	r13, 33
	add	r12, rcx
	add	rbp, r15
	add	rbp, r12
	add	r11, rbx
	add	r11, r9
	add	r11, rbp
	mov	r10, qword ptr [rsp + 16]
	add	r10, r11
	mov	r9d, 32
	.p2align	4
772:
	vmovdqu	ymm0, ymmword ptr [rdi + r9]
	vmovdqu	ymmword ptr [r10 + r9], ymm0
	add	r9, 32
	cmp	r9, r13
	jb	772b
	jmp	572b
	.p2align	4
782:
	mov	r8, r11
	mov	rax, r14
792:
	mov	r11, qword ptr [rsp + 72]
	cmp	rdx, r11
	mov	r10, r8
	mov	rbx, rax
	je	2b
	.p2align	4
802:
	movzx	ecx, byte ptr [rbp + rdx]
	movzx	eax, byte ptr [rdi + rdx + 192]
	cmp	rax, 33
	mov	esi, dword ptr [rdi + 4*rdx + 256]
	vmovdqu	ymm0, ymmword ptr [rbx]
	vmovdqu	ymmword ptr [r10], ymm0
	jae	842f
812:
	add	r10, rax
	mov	r8, r10
	sub	r8, rsi
	cmp	r8, r13
	jl	862f
	vmovdqu	ymm0, ymmword ptr [r8]
	vmovdqu	ymmword ptr [r10], ymm0
	cmp	cl, -124
	jae	872f
822:
	shr	ecx, 2
832:
	add	r10, rcx
	add	rbx, rax
	inc	rdx
	cmp	rdx, r11
	jb	802b
	jmp	2b
842:
	mov	rax, qword ptr [rdi + 48]
	mov	r8, qword ptr [rdi + 120]
	movzx	eax, byte ptr [rax + r8]
	inc	r8
	mov	qword ptr [rdi + 120], r8
	add	rax, 33
	mov	r8d, 32
	.p2align	4
852:
	vmovdqu	ymm0, ymmword ptr [rbx + r8]
	vmovdqu	ymmword ptr [r10 + r8], ymm0
	add	r8, 32
	cmp	r8, rax
	jb	852b
	jmp	812b
862:
	mov	r9, r10
	sub	r9, r13
	sub	r9, rsi
	mov	r8d, 0
	cmovae	r8, r9
	add	r8, r13
	vmovdqu	ymm0, ymmword ptr [r8]
	vmovdqu	ymmword ptr [r10], ymm0
	cmp	cl, -124
	jb	822b
872:
	mov	rcx, qword ptr [rdi + 48]
	mov	rsi, qword ptr [rdi + 120]
	movzx	ecx, byte ptr [rcx + rsi]
	inc	rsi
	mov	qword ptr [rdi + 120], rsi
	add	rcx, 33
	mov	esi, 32
	.p2align	4
882:
	vmovdqu	ymm0, ymmword ptr [r8 + rsi]
	vmovdqu	ymmword ptr [r10 + rsi], ymm0
	add	rsi, 32
	cmp	rsi, rcx
	jb	882b
	jmp	832b
892:
	sub	r10, r13
	sub	rbx, qword ptr [rsp + 128]
	mov	qword ptr [rdi + 80], r10
	mov	qword ptr [rdi + 88], rbx
	add	rsp, 160
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	vzeroupper
	ret
	.p2align	6, 0x0
902:
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
912:
	.byte	2
	.p2align	6, 0x0
922:
	.byte	1
	.p2align	2, 0x0
932:
	.long	1
	.p2align	2, 0x0
942:
	.long	7
	.p2align	2, 0x0
952:
	.long	8
	.p2align	4, 0x0
962:
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
972:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	6, 0x0
982:
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
992:
	.long	134217727
	.p2align	6, 0x0
1002:
	.byte	63
	.p2align	6, 0x0
1012:
	.byte	32

# minlz_exec_flat of crates/minlz/mlir/exec64.mlir for avx512, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 160
	mov	r9, rdi
	mov	rax, qword ptr [rdi + 64]
	mov	r13, qword ptr [rdi + 80]
	mov	r12, qword ptr [rdi + 88]
	test	rax, rax
	jle	802f
	mov	rcx, qword ptr [r9]
	mov	qword ptr [rsp + 8], rcx
	mov	rbx, qword ptr [r9 + 8]
	mov	rcx, qword ptr [r9 + 16]
	mov	qword ptr [rsp + 136], rcx
	lea	rcx, [r9 + 512]
	lea	r14, [r9 + 576]
	mov	edx, 192
	mov	qword ptr [rsp + 104], rdx
	mov	edx, 7
	mov	qword ptr [rsp + 88], rdx
	mov	qword ptr [rsp + 120], 0
	vmovdqa64	zmm22, zmmword ptr [rip + 812f]
	vpbroadcastb	zmm1, byte ptr [rip + 822f]
	vpbroadcastb	zmm2, byte ptr [rip + 832f]
	vpbroadcastd	zmm3, dword ptr [rip + 842f]
	vpternlogd	zmm4, zmm4, zmm4, 255
	vpbroadcastd	zmm5, dword ptr [rip + 852f]
	vpbroadcastd	zmm6, dword ptr [rip + 862f]
	vpxor	xmm7, xmm7, xmm7
	vbroadcasti32x4	zmm8, xmmword ptr [rip + 872f]
	vpbroadcastd	zmm9, dword ptr [rip + 882f]
	vmovdqa64	zmm10, zmmword ptr [rip + 892f]
	vpbroadcastd	zmm11, dword ptr [rip + 902f]
	vpbroadcastb	xmm12, byte ptr [rip + 912f]
	vpbroadcastb	xmm13, byte ptr [rip + 922f]
	mov	rdx, rcx
	xor	esi, esi
	mov	qword ptr [rsp + 112], rcx
	mov	qword ptr [rsp], r9
	mov	qword ptr [rsp + 144], rax
	mov	qword ptr [rsp + 40], rbx
	mov	qword ptr [rsp + 96], r14
	jmp	12f
	.p2align	4
2:
	inc	qword ptr [rsp + 120]
	add	qword ptr [rsp + 104], 64
	add	qword ptr [rsp + 88], -64
	mov	rdx, qword ptr [rsp + 128]
	add	rdx, -64
	mov	rax, qword ptr [rsp + 144]
	mov	rsi, qword ptr [rsp + 152]
	cmp	rsi, rax
	mov	rcx, qword ptr [rsp + 112]
	jge	802f
12:
	mov	qword ptr [rsp + 56], r12
	mov	qword ptr [rsp + 128], rdx
	mov	r10, rsi
	mov	rdx, rax
	sub	rdx, rsi
	cmp	rdx, 64
	mov	eax, 64
	mov	qword ptr [rsp + 24], rdx
	cmovb	rax, rdx
	mov	qword ptr [rsp + 72], rax
	mov	rsi, qword ptr [r9 + 16]
	mov	r11, qword ptr [r9 + 24]
	mov	rdx, qword ptr [r9 + 32]
	mov	rax, r9
	mov	r9, qword ptr [r9 + 40]
	mov	r14, qword ptr [rax + 64]
	mov	rdi, qword ptr [rax + 72]
	mov	qword ptr [rsp + 48], rdi
	mov	rdi, qword ptr [rax + 96]
	mov	qword ptr [rsp + 64], rdi
	mov	r12, qword ptr [rax + 112]
	mov	r8, qword ptr [rax + 128]
	mov	rax, qword ptr [rax + 136]
	mov	qword ptr [rsp + 32], rax
	lea	rbx, [r14 + 7]
	lea	rax, [r10 + 64]
	mov	qword ptr [rsp + 152], rax
	cmp	rax, rbx
	jbe	22f
	cmp	r10, rbx
	mov	rax, rcx
	jge	92f
	mov	rax, qword ptr [rsp + 120]
	shl	rax, 6
	mov	edi, 7
	sub	rdi, rax
	add	rdi, r14
	cmp	rdi, 16
	mov	r15, r10
	jb	72f
	add	rax, rsi
	mov	qword ptr [rsp + 16], r8
	mov	r8, qword ptr [rsp]
	sub	r8, rax
	add	r8, 511
	cmp	r8, 255
	mov	r8, qword ptr [rsp + 16]
	mov	r15, r10
	jb	72f
	cmp	rdi, 256
	jae	32f
	xor	ebp, ebp
	jmp	52f
	.p2align	4
22:
	add	rsi, r10
	mov	rax, rsi
	jmp	92f
32:
	mov	rbp, rdi
	and	rbp, -256
	mov	qword ptr [rsp + 80], r10
	lea	r15, [r10 + rbp]
	mov	rax, qword ptr [rsp + 104]
	add	rax, rsi
	mov	rcx, qword ptr [rsp + 88]
	lea	r8, [r14 + rcx]
	and	r8, -256
	xor	r10d, r10d
	mov	rcx, qword ptr [rsp]
	.p2align	4
42:
	vmovdqu64	zmm14, zmmword ptr [rax + r10 - 192]
	vmovdqu64	zmm15, zmmword ptr [rax + r10 - 128]
	vmovdqu64	zmm16, zmmword ptr [rax + r10 - 64]
	vmovdqu64	zmm17, zmmword ptr [rax + r10]
	vmovdqu64	zmmword ptr [rcx + r10 + 512], zmm14
	vmovdqu64	zmmword ptr [rcx + r10 + 576], zmm15
	vmovdqu64	zmmword ptr [rcx + r10 + 640], zmm16
	vmovdqu64	zmmword ptr [rcx + r10 + 704], zmm17
	add	r10, 256
	cmp	r8, r10
	jne	42b
	cmp	rdi, rbp
	mov	rcx, qword ptr [rsp + 112]
	mov	rax, rcx
	mov	r10, qword ptr [rsp + 80]
	mov	r8, qword ptr [rsp + 16]
	je	92f
	test	dil, -16
	je	72f
52:
	mov	rax, rdi
	and	rax, -16
	lea	r15, [r10 + rax]
	lea	r8, [rsi + r10]
	add	r14, qword ptr [rsp + 88]
	and	r14, -16
	.p2align	4
62:
	vmovdqu	xmm14, xmmword ptr [r8 + rbp]
	vmovdqu	xmmword ptr [rcx + rbp], xmm14
	add	rbp, 16
	cmp	r14, rbp
	jne	62b
	cmp	rdi, rax
	mov	rax, rcx
	mov	r8, qword ptr [rsp + 16]
	je	92f
	.p2align	4
72:
	mov	rdi, qword ptr [rsp + 128]
	.p2align	4
82:
	movzx	eax, byte ptr [rsi + r15]
	mov	byte ptr [rdi + r15], al
	inc	r15
	cmp	rbx, r15
	jne	82b
	mov	rax, rcx
92:
	vmovdqu64	zmm14, zmmword ptr [rax]
	mov	rax, qword ptr [rsp + 72]
	vpbroadcastb	zmm15, eax
	vpcmpnleub	k2, zmm15, zmm22
	vptestmb	k1 {k2}, zmm14, zmm1
	vptestnmb	k2 {k2}, zmm14, zmm2
	vpexpandb	zmm15 {k1} {z}, zmmword ptr [r11 + r8]
	mov	rax, qword ptr [rsp]
	vmovdqu64	zmmword ptr [rax + 192], zmm15
	mov	rax, qword ptr [rsp + 32]
	vpexpandb	zmm15 {k2} {z}, zmmword ptr [rdx + rax]
	mov	rcx, qword ptr [rsp + 48]
	mov	rdx, rcx
	shr	rdx, 3
	lea	rax, [rdx + 64]
	cmp	rax, r12
	jbe	102f
	mov	rsi, r12
	sub	rsi, rdx
	mov	r15, qword ptr [rsp + 96]
	mov	r14, r15
	mov	rbp, qword ptr [rsp + 56]
	jbe	172f
	cmp	rsi, 16
	mov	rdi, rdx
	jb	152f
	lea	r11, [rdx + r9]
	mov	rax, qword ptr [rsp]
	sub	rax, r11
	add	rax, 575
	cmp	rax, 255
	mov	rdi, rdx
	jb	152f
	cmp	rsi, 256
	jae	112f
	xor	ebx, ebx
	jmp	132f
	.p2align	4
102:
	add	rdx, r9
	mov	r14, rdx
	mov	r15, qword ptr [rsp + 96]
	mov	rbp, qword ptr [rsp + 56]
	jmp	172f
112:
	mov	qword ptr [rsp + 16], r8
	mov	rbx, rsi
	and	rbx, -256
	lea	rdi, [rdx + rbx]
	lea	rax, [r9 + rdx + 192]
	xor	r8d, r8d
	mov	rcx, qword ptr [rsp]
	.p2align	4
122:
	vmovdqu64	zmm16, zmmword ptr [rax + r8 - 192]
	vmovdqu64	zmm17, zmmword ptr [rax + r8 - 128]
	vmovdqu64	zmm18, zmmword ptr [rax + r8 - 64]
	vmovdqu64	zmm19, zmmword ptr [rax + r8]
	vmovdqu64	zmmword ptr [rcx + r8 + 576], zmm16
	vmovdqu64	zmmword ptr [rcx + r8 + 640], zmm17
	vmovdqu64	zmmword ptr [rcx + r8 + 704], zmm18
	vmovdqu64	zmmword ptr [rcx + r8 + 768], zmm19
	add	r8, 256
	cmp	rbx, r8
	jne	122b
	cmp	rsi, rbx
	mov	r14, r15
	mov	r8, qword ptr [rsp + 16]
	mov	rcx, qword ptr [rsp + 48]
	je	172f
	test	sil, -16
	je	152f
132:
	mov	rax, rsi
	and	rax, -16
	lea	rdi, [rdx + rax]
	.p2align	4
142:
	vmovdqu64	xmm16, xmmword ptr [r11 + rbx]
	vmovdqu64	xmmword ptr [r15 + rbx], xmm16
	add	rbx, 16
	cmp	rax, rbx
	jne	142b
	cmp	rsi, rax
	mov	r14, r15
	je	172f
	.p2align	4
152:
	mov	rax, r15
	sub	rax, rdx
	.p2align	4
162:
	movzx	edx, byte ptr [r9 + rdi]
	mov	byte ptr [rax + rdi], dl
	inc	rdi
	cmp	r12, rdi
	jne	162b
	mov	r14, r15
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
	mov	eax, ecx
	and	eax, 7
	vpbroadcastd	zmm21, eax
	vpaddd	zmm18, zmm18, zmm21
	vpsrld	zmm21, zmm18, 3
	vpandd	zmm18, zmm18, zmm5
	vpshufb	zmm21, zmm21, zmm8
	vpaddb	zmm21, zmm21, zmm9
	vpermb	zmm21, zmm21, zmmword ptr [r14]
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
	vpextrd	eax, xmm0, 3
	add	rax, rcx
	mov	rcx, qword ptr [rsp]
	vmovdqu64	zmmword ptr [rcx + 256], zmm17
	cmp	qword ptr [rsp + 24], 17
	jb	182f
	mov	r14, r10
	mov	rdx, rax
	shr	rdx, 3
	lea	rsi, [rdx + 64]
	cmp	rsi, r12
	jbe	192f
	mov	rsi, r12
	sub	rsi, rdx
	mov	rbx, r15
	jbe	262f
	cmp	rsi, 16
	mov	rdi, rdx
	jb	242f
	lea	r10, [rdx + r9]
	mov	rdi, qword ptr [rsp]
	sub	rdi, r10
	add	rdi, 575
	cmp	rdi, 255
	mov	rdi, rdx
	jb	242f
	cmp	rsi, 256
	jae	202f
	xor	r11d, r11d
	jmp	222f
	.p2align	4
182:
	mov	r9, qword ptr [rsp]
	mov	rcx, qword ptr [rsp + 8]
	jmp	452f
	.p2align	4
192:
	add	rdx, r9
	mov	rbx, rdx
	jmp	262f
202:
	mov	qword ptr [rsp + 16], r8
	mov	r11, rsi
	and	r11, -256
	lea	rdi, [rdx + r11]
	lea	r8, [r9 + rdx + 192]
	xor	ebx, ebx
	mov	rcx, qword ptr [rsp]
	.p2align	4
212:
	vmovdqu64	zmm0, zmmword ptr [r8 + rbx - 192]
	vmovdqu64	zmm17, zmmword ptr [r8 + rbx - 128]
	vmovdqu64	zmm18, zmmword ptr [r8 + rbx - 64]
	vmovdqu64	zmm19, zmmword ptr [r8 + rbx]
	vmovdqu64	zmmword ptr [rcx + rbx + 576], zmm0
	vmovdqu64	zmmword ptr [rcx + rbx + 640], zmm17
	vmovdqu64	zmmword ptr [rcx + rbx + 704], zmm18
	vmovdqu64	zmmword ptr [rcx + rbx + 768], zmm19
	add	rbx, 256
	cmp	r11, rbx
	jne	212b
	cmp	rsi, r11
	mov	rbx, r15
	mov	r8, qword ptr [rsp + 16]
	je	262f
	test	sil, -16
	je	242f
222:
	mov	rcx, r8
	mov	r8, rsi
	and	r8, -16
	lea	rdi, [rdx + r8]
	.p2align	4
232:
	vmovdqu	xmm0, xmmword ptr [r10 + r11]
	vmovdqu	xmmword ptr [r15 + r11], xmm0
	add	r11, 16
	cmp	r8, r11
	jne	232b
	cmp	rsi, r8
	mov	rbx, r15
	mov	r8, rcx
	je	262f
242:
	mov	rsi, r15
	sub	rsi, rdx
	.p2align	4
252:
	movzx	edx, byte ptr [r9 + rdi]
	mov	byte ptr [rsi + rdi], dl
	inc	rdi
	cmp	r12, rdi
	jne	252b
	mov	rbx, r15
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
	mov	edx, eax
	and	edx, 7
	vpbroadcastd	zmm20, edx
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
	vpextrd	edx, xmm0, 3
	add	rax, rdx
	mov	rcx, qword ptr [rsp]
	vmovdqu64	zmmword ptr [rcx + 320], zmm17
	cmp	qword ptr [rsp + 24], 33
	jb	352f
	mov	rdx, rax
	shr	rdx, 3
	lea	rsi, [rdx + 64]
	cmp	rsi, r12
	jbe	272f
	mov	rsi, r12
	sub	rsi, rdx
	mov	rbx, r15
	jbe	342f
	cmp	rsi, 16
	mov	rdi, rdx
	jb	322f
	lea	r10, [rdx + r9]
	mov	rdi, qword ptr [rsp]
	sub	rdi, r10
	add	rdi, 575
	cmp	rdi, 255
	mov	rdi, rdx
	jb	322f
	cmp	rsi, 256
	jae	282f
	xor	r11d, r11d
	jmp	302f
272:
	add	rdx, r9
	mov	rbx, rdx
	jmp	342f
282:
	mov	qword ptr [rsp + 16], r8
	mov	r11, rsi
	and	r11, -256
	lea	rdi, [rdx + r11]
	lea	r8, [r9 + rdx + 192]
	xor	ebx, ebx
	mov	rcx, qword ptr [rsp]
	.p2align	4
292:
	vmovdqu64	zmm0, zmmword ptr [r8 + rbx - 192]
	vmovdqu64	zmm17, zmmword ptr [r8 + rbx - 128]
	vmovdqu64	zmm18, zmmword ptr [r8 + rbx - 64]
	vmovdqu64	zmm19, zmmword ptr [r8 + rbx]
	vmovdqu64	zmmword ptr [rcx + rbx + 576], zmm0
	vmovdqu64	zmmword ptr [rcx + rbx + 640], zmm17
	vmovdqu64	zmmword ptr [rcx + rbx + 704], zmm18
	vmovdqu64	zmmword ptr [rcx + rbx + 768], zmm19
	add	rbx, 256
	cmp	r11, rbx
	jne	292b
	cmp	rsi, r11
	mov	rbx, r15
	mov	r8, qword ptr [rsp + 16]
	je	342f
	test	sil, -16
	je	322f
302:
	mov	rcx, r8
	mov	r8, rsi
	and	r8, -16
	lea	rdi, [rdx + r8]
	.p2align	4
312:
	vmovdqu	xmm0, xmmword ptr [r10 + r11]
	vmovdqu	xmmword ptr [r15 + r11], xmm0
	add	r11, 16
	cmp	r8, r11
	jne	312b
	cmp	rsi, r8
	mov	rbx, r15
	mov	r8, rcx
	je	342f
322:
	mov	rsi, r15
	sub	rsi, rdx
	.p2align	4
332:
	movzx	edx, byte ptr [r9 + rdi]
	mov	byte ptr [rsi + rdi], dl
	inc	rdi
	cmp	r12, rdi
	jne	332b
	mov	rbx, r15
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
	mov	edx, eax
	and	edx, 7
	vpbroadcastd	zmm20, edx
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
	vpextrd	edx, xmm0, 3
	add	rax, rdx
	mov	rcx, qword ptr [rsp]
	vmovdqu64	zmmword ptr [rcx + 384], zmm17
	cmp	qword ptr [rsp + 24], 49
	jb	352f
	mov	rdx, rax
	shr	rdx, 3
	lea	rsi, [rdx + 64]
	cmp	rsi, r12
	mov	rcx, qword ptr [rsp + 8]
	jbe	362f
	mov	rsi, r12
	sub	rsi, rdx
	mov	r11, r15
	jbe	432f
	cmp	rsi, 16
	mov	rdi, rdx
	jb	412f
	lea	rbx, [rdx + r9]
	mov	rdi, qword ptr [rsp]
	sub	rdi, rbx
	add	rdi, 575
	cmp	rdi, 255
	mov	rdi, rdx
	jb	412f
	cmp	rsi, 256
	jae	372f
	xor	r10d, r10d
	jmp	392f
	.p2align	4
352:
	mov	r9, qword ptr [rsp]
	mov	rcx, qword ptr [rsp + 8]
	jmp	442f
362:
	add	r9, rdx
	mov	r11, r9
	jmp	432f
372:
	mov	r10, rsi
	and	r10, -256
	lea	rdi, [rdx + r10]
	lea	r11, [r9 + rdx + 192]
	xor	ebx, ebx
	mov	rcx, qword ptr [rsp]
	.p2align	4
382:
	vmovdqu64	zmm0, zmmword ptr [r11 + rbx - 192]
	vmovdqu64	zmm17, zmmword ptr [r11 + rbx - 128]
	vmovdqu64	zmm18, zmmword ptr [r11 + rbx - 64]
	vmovdqu64	zmm19, zmmword ptr [r11 + rbx]
	vmovdqu64	zmmword ptr [rcx + rbx + 576], zmm0
	vmovdqu64	zmmword ptr [rcx + rbx + 640], zmm17
	vmovdqu64	zmmword ptr [rcx + rbx + 704], zmm18
	vmovdqu64	zmmword ptr [rcx + rbx + 768], zmm19
	add	rbx, 256
	cmp	r10, rbx
	jne	382b
	cmp	rsi, r10
	mov	r11, r15
	mov	rcx, qword ptr [rsp + 8]
	lea	rbx, [rdx + r9]
	je	432f
	test	sil, -16
	je	412f
392:
	mov	r11, rsi
	and	r11, -16
	lea	rdi, [rdx + r11]
	.p2align	4
402:
	vmovdqu	xmm0, xmmword ptr [rbx + r10]
	vmovdqu	xmmword ptr [r15 + r10], xmm0
	add	r10, 16
	cmp	r11, r10
	jne	402b
	cmp	rsi, r11
	mov	r11, r15
	je	432f
412:
	mov	rsi, r15
	sub	rsi, rdx
	.p2align	4
422:
	movzx	edx, byte ptr [r9 + rdi]
	mov	byte ptr [rsi + rdi], dl
	inc	rdi
	cmp	r12, rdi
	jne	422b
	mov	r11, r15
432:
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
	mov	edx, eax
	and	edx, 7
	vpbroadcastd	zmm19, edx
	vpaddd	zmm15, zmm19, zmm15
	vpsrld	zmm19, zmm15, 3
	vpandd	zmm15, zmm15, zmm5
	vpshufb	zmm19, zmm19, zmm8
	vpaddb	zmm19, zmm19, zmm9
	vpermb	zmm19, zmm19, zmmword ptr [r11]
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
	vpextrd	edx, xmm0, 3
	add	rax, rdx
	mov	r9, qword ptr [rsp]
	vmovdqu64	zmmword ptr [r9 + 448], zmm14
442:
	mov	r10, r14
452:
	kmovq	rdx, k2
	popcnt	rdx, rdx
	add	rdx, qword ptr [rsp + 32]
	kmovq	rsi, k1
	popcnt	rsi, rsi
	add	rsi, r8
	vmovd	edi, xmm16
	mov	qword ptr [r9 + 72], rax
	mov	qword ptr [r9 + 96], rdi
	mov	qword ptr [r9 + 128], rsi
	mov	qword ptr [r9 + 136], rdx
	add	r10, qword ptr [rsp + 136]
	mov	rax, qword ptr [rsp + 72]
	and	rax, 124
	je	712f
	xor	r8d, r8d
	.p2align	4
462:
	movzx	r12d, byte ptr [r10 + r8]
	movzx	ebx, byte ptr [r9 + r8 + 192]
	cmp	rbx, 33
	mov	edx, dword ptr [r9 + 4*r8 + 256]
	mov	r15, qword ptr [rsp + 40]
	vmovdqu	ymm0, ymmword ptr [r15 + rbp]
	vmovdqu	ymmword ptr [rcx + r13], ymm0
	jae	552f
472:
	mov	qword ptr [rsp + 32], r13
	add	r13, rbx
	mov	rsi, r13
	sub	rsi, rdx
	mov	edi, 0
	cmovae	rdi, rsi
	vmovdqu	ymm0, ymmword ptr [rcx + rdi]
	vmovdqu	ymmword ptr [rcx + r13], ymm0
	cmp	r12b, -124
	jae	572f
	shr	r12d, 2
482:
	lea	rdx, [r8 + 1]
	mov	qword ptr [rsp + 24], rbx
	lea	r11, [rbx + rbp]
	add	r13, r12
	movzx	r14d, byte ptr [r10 + rdx]
	movzx	ebx, byte ptr [r9 + rdx + 192]
	cmp	rbx, 33
	mov	edx, dword ptr [r9 + 4*rdx + 256]
	vmovdqu	ymm0, ymmword ptr [r15 + r11]
	vmovdqu	ymmword ptr [rcx + r13], ymm0
	jae	592f
492:
	add	r13, rbx
	mov	rsi, r13
	sub	rsi, rdx
	mov	edi, 0
	cmovae	rdi, rsi
	vmovdqu	ymm0, ymmword ptr [rcx + rdi]
	vmovdqu	ymmword ptr [rcx + r13], ymm0
	cmp	r14b, -124
	mov	qword ptr [rsp + 56], rbp
	jae	612f
	shr	r14d, 2
502:
	lea	rsi, [r8 + 2]
	add	r11, rbx
	add	r13, r14
	movzx	edx, byte ptr [r10 + rsi]
	movzx	ebp, byte ptr [r9 + rsi + 192]
	cmp	rbp, 33
	mov	esi, dword ptr [r9 + 4*rsi + 256]
	vmovdqu	ymm0, ymmword ptr [r15 + r11]
	vmovdqu	ymmword ptr [rcx + r13], ymm0
	mov	qword ptr [rsp + 48], r12
	jae	632f
512:
	add	r13, rbp
	mov	rdi, r13
	sub	rdi, rsi
	mov	r15d, 0
	cmovae	r15, rdi
	vmovdqu	ymm0, ymmword ptr [rcx + r15]
	vmovdqu	ymmword ptr [rcx + r13], ymm0
	cmp	dl, -124
	jae	652f
	shr	edx, 2
522:
	lea	rdi, [r8 + 3]
	add	r11, rbp
	add	r13, rdx
	mov	r12, r10
	movzx	r15d, byte ptr [r10 + rdi]
	movzx	esi, byte ptr [r9 + rdi + 192]
	cmp	rsi, 33
	mov	edi, dword ptr [r9 + 4*rdi + 256]
	mov	r10, qword ptr [rsp + 40]
	vmovdqu	ymm0, ymmword ptr [r10 + r11]
	vmovdqu	ymmword ptr [rcx + r13], ymm0
	jae	672f
532:
	add	r13, rsi
	mov	r9, r13
	sub	r9, rdi
	mov	ecx, 0
	cmovae	rcx, r9
	mov	r9, qword ptr [rsp + 8]
	vmovdqu	ymm0, ymmword ptr [r9 + rcx]
	mov	rcx, qword ptr [rsp + 8]
	vmovdqu	ymmword ptr [rcx + r13], ymm0
	cmp	r15b, -124
	mov	r10, r12
	jae	692f
	shr	r15d, 2
	mov	r9, qword ptr [rsp]
542:
	add	rsi, r11
	add	r15, r13
	add	r8, 4
	cmp	r8, rax
	mov	rbp, rsi
	mov	r13, r15
	jb	462b
	jmp	722f
552:
	lea	rsi, [r15 + rbp]
	lea	rdi, [rcx + r13]
	mov	rcx, r9
	mov	r9, qword ptr [r9 + 48]
	mov	r11, qword ptr [rcx + 120]
	movzx	ebx, byte ptr [r9 + r11]
	inc	r11
	mov	qword ptr [rcx + 120], r11
	add	rbx, 33
	mov	r9d, 32
	.p2align	4
562:
	vmovdqu	ymm0, ymmword ptr [rsi + r9]
	vmovdqu	ymmword ptr [rdi + r9], ymm0
	add	r9, 32
	cmp	r9, rbx
	jb	562b
	mov	r9, qword ptr [rsp]
	mov	rcx, qword ptr [rsp + 8]
	jmp	472b
572:
	lea	rsi, [rcx + r13]
	mov	rdi, qword ptr [r9 + 48]
	mov	r11, qword ptr [r9 + 120]
	movzx	r12d, byte ptr [rdi + r11]
	inc	r11
	mov	qword ptr [r9 + 120], r11
	add	r12, 33
	cmp	r13, rdx
	cmovb	rdx, r13
	mov	rdi, rsi
	sub	rdi, rdx
	mov	edx, 32
	.p2align	4
582:
	vmovdqu	ymm0, ymmword ptr [rdi + rdx]
	vmovdqu	ymmword ptr [rsi + rdx], ymm0
	add	rdx, 32
	cmp	rdx, r12
	jb	582b
	jmp	482b
592:
	lea	rsi, [r15 + r11]
	mov	rdi, qword ptr [r9 + 48]
	mov	r15, qword ptr [r9 + 120]
	movzx	ebx, byte ptr [rdi + r15]
	inc	r15
	mov	qword ptr [r9 + 120], r15
	add	rbx, 33
	lea	rdi, [rcx + r13]
	mov	r15d, 32
	.p2align	4
602:
	vmovdqu	ymm0, ymmword ptr [rsi + r15]
	vmovdqu	ymmword ptr [rdi + r15], ymm0
	add	r15, 32
	cmp	r15, rbx
	jb	602b
	mov	r15, qword ptr [rsp + 40]
	jmp	492b
612:
	lea	rsi, [rcx + r13]
	mov	rdi, qword ptr [r9 + 48]
	mov	r15, qword ptr [r9 + 120]
	movzx	r14d, byte ptr [rdi + r15]
	inc	r15
	mov	qword ptr [r9 + 120], r15
	add	r14, 33
	mov	rdi, qword ptr [rsp + 24]
	lea	r15, [r12 + rdi]
	mov	rdi, qword ptr [rsp + 32]
	add	rdi, rbx
	add	rdi, r15
	cmp	r13, rdx
	cmovb	rdx, r13
	sub	rdi, rdx
	add	rdi, rcx
	mov	edx, 32
	.p2align	4
622:
	vmovdqu	ymm0, ymmword ptr [rdi + rdx]
	vmovdqu	ymmword ptr [rsi + rdx], ymm0
	add	rdx, 32
	cmp	rdx, r14
	jb	622b
	mov	r15, qword ptr [rsp + 40]
	jmp	502b
632:
	mov	qword ptr [rsp + 80], r10
	mov	rdi, qword ptr [r9 + 48]
	mov	r15, qword ptr [r9 + 120]
	movzx	ebp, byte ptr [rdi + r15]
	inc	r15
	mov	qword ptr [r9 + 120], r15
	add	rbp, 33
	mov	rdi, qword ptr [rsp + 24]
	lea	r15, [r12 + rdi]
	lea	rdi, [r14 + rbx]
	add	rdi, r15
	add	rdi, qword ptr [rsp + 32]
	add	rdi, rcx
	mov	r10, qword ptr [rsp + 40]
	add	r10, r11
	mov	r15d, 32
	.p2align	4
642:
	vmovdqu	ymm0, ymmword ptr [r10 + r15]
	vmovdqu	ymmword ptr [rdi + r15], ymm0
	add	r15, 32
	cmp	r15, rbp
	jb	642b
	mov	r10, qword ptr [rsp + 80]
	mov	r12, qword ptr [rsp + 48]
	jmp	512b
652:
	mov	rdx, qword ptr [r9 + 48]
	mov	r15, qword ptr [r9 + 120]
	movzx	edx, byte ptr [rdx + r15]
	inc	r15
	mov	qword ptr [r9 + 120], r15
	add	rdx, 33
	mov	rdi, qword ptr [rsp + 24]
	add	rdi, r12
	lea	r15, [rbp + r14]
	add	r15, rdi
	mov	rdi, qword ptr [rsp + 32]
	add	rdi, rbx
	add	r15, rdi
	lea	rdi, [rcx + r13]
	cmp	r13, rsi
	cmovb	rsi, r13
	sub	r15, rsi
	add	r15, rcx
	mov	esi, 32
	.p2align	4
662:
	vmovdqu	ymm0, ymmword ptr [r15 + rsi]
	vmovdqu	ymmword ptr [rdi + rsi], ymm0
	add	rsi, 32
	cmp	rsi, rdx
	jb	662b
	jmp	522b
672:
	mov	rsi, qword ptr [r9 + 48]
	mov	r10, qword ptr [r9 + 120]
	movzx	esi, byte ptr [rsi + r10]
	inc	r10
	mov	qword ptr [r9 + 120], r10
	add	rsi, 33
	mov	r9, qword ptr [rsp + 48]
	mov	r10, qword ptr [rsp + 24]
	add	r9, r10
	mov	qword ptr [rsp + 64], r9
	lea	r9, [rdx + rbp]
	add	r9, qword ptr [rsp + 64]
	mov	qword ptr [rsp + 64], r9
	lea	r9, [r14 + rbx]
	add	r9, qword ptr [rsp + 32]
	add	r9, qword ptr [rsp + 64]
	add	r9, rcx
	add	r10, rbx
	mov	rcx, qword ptr [rsp + 56]
	add	rcx, rbp
	add	rcx, r10
	add	rcx, qword ptr [rsp + 40]
	mov	r10d, 32
	.p2align	4
682:
	vmovdqu	ymm0, ymmword ptr [rcx + r10]
	vmovdqu	ymmword ptr [r9 + r10], ymm0
	add	r10, 32
	cmp	r10, rsi
	jb	682b
	jmp	532b
692:
	add	rcx, r13
	mov	qword ptr [rsp + 56], rcx
	mov	rcx, qword ptr [rsp]
	mov	r15, qword ptr [rcx + 48]
	mov	r9, qword ptr [rcx + 120]
	movzx	r15d, byte ptr [r15 + r9]
	inc	r9
	mov	qword ptr [rcx + 120], r9
	mov	r9, rcx
	mov	rcx, qword ptr [rsp + 8]
	add	r15, 33
	mov	r12, qword ptr [rsp + 48]
	add	r12, qword ptr [rsp + 24]
	add	rdx, rsi
	add	rdx, r12
	add	rbp, r14
	add	rbp, rbx
	add	rbp, rdx
	add	rbp, qword ptr [rsp + 32]
	cmp	r13, rdi
	cmovb	rdi, r13
	sub	rbp, rdi
	mov	rdi, qword ptr [rsp + 56]
	add	rbp, rcx
	mov	edx, 32
	.p2align	4
702:
	vmovdqu	ymm0, ymmword ptr [rbp + rdx]
	vmovdqu	ymmword ptr [rdi + rdx], ymm0
	add	rdx, 32
	cmp	rdx, r15
	jb	702b
	jmp	542b
	.p2align	4
712:
	mov	r15, r13
	mov	rsi, rbp
722:
	mov	rdx, qword ptr [rsp + 72]
	cmp	rax, rdx
	mov	r13, r15
	mov	r15, rdx
	mov	r12, rsi
	mov	rbx, qword ptr [rsp + 40]
	je	2b
	.p2align	4
732:
	movzx	edx, byte ptr [r10 + rax]
	movzx	esi, byte ptr [r9 + rax + 192]
	cmp	rsi, 33
	mov	edi, dword ptr [r9 + 4*rax + 256]
	vmovdqu	ymm0, ymmword ptr [rbx + r12]
	vmovdqu	ymmword ptr [rcx + r13], ymm0
	jae	762f
742:
	add	r13, rsi
	mov	rcx, r13
	sub	rcx, rdi
	mov	r8d, 0
	cmovae	r8, rcx
	mov	rcx, qword ptr [rsp + 8]
	vmovdqu	ymm0, ymmword ptr [rcx + r8]
	vmovdqu	ymmword ptr [rcx + r13], ymm0
	cmp	dl, -124
	jae	782f
	shr	edx, 2
752:
	add	r12, rsi
	add	r13, rdx
	inc	rax
	cmp	rax, r15
	jb	732b
	jmp	2b
762:
	mov	r15, r10
	lea	r8, [rbx + r12]
	mov	r11, r9
	lea	r9, [rcx + r13]
	mov	rcx, qword ptr [r11 + 48]
	mov	r10, qword ptr [r11 + 120]
	movzx	esi, byte ptr [rcx + r10]
	inc	r10
	mov	qword ptr [r11 + 120], r10
	add	rsi, 33
	mov	r10d, 32
	.p2align	4
772:
	vmovdqu	ymm0, ymmword ptr [r8 + r10]
	vmovdqu	ymmword ptr [r9 + r10], ymm0
	add	r10, 32
	cmp	r10, rsi
	jb	772b
	mov	r9, qword ptr [rsp]
	mov	r10, r15
	mov	r15, qword ptr [rsp + 72]
	jmp	742b
782:
	mov	r11, r10
	lea	r8, [rcx + r13]
	mov	rcx, qword ptr [r9 + 48]
	mov	r10, r9
	mov	r9, qword ptr [r9 + 120]
	movzx	edx, byte ptr [rcx + r9]
	inc	r9
	mov	qword ptr [r10 + 120], r9
	add	rdx, 33
	cmp	r13, rdi
	cmovb	rdi, r13
	mov	r9, r8
	sub	r9, rdi
	mov	edi, 32
	.p2align	4
792:
	vmovdqu	ymm0, ymmword ptr [r9 + rdi]
	vmovdqu	ymmword ptr [r8 + rdi], ymm0
	add	rdi, 32
	cmp	rdi, rdx
	jb	792b
	mov	r9, qword ptr [rsp]
	mov	rcx, qword ptr [rsp + 8]
	mov	r10, r11
	jmp	752b
802:
	mov	qword ptr [r9 + 80], r13
	mov	qword ptr [r9 + 88], r12
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
812:
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
822:
	.byte	2
	.p2align	6, 0x0
832:
	.byte	1
	.p2align	2, 0x0
842:
	.long	1
	.p2align	2, 0x0
852:
	.long	7
	.p2align	2, 0x0
862:
	.long	8
	.p2align	4, 0x0
872:
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
882:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	6, 0x0
892:
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
902:
	.long	134217727
	.p2align	6, 0x0
912:
	.byte	63
	.p2align	6, 0x0
922:
	.byte	32

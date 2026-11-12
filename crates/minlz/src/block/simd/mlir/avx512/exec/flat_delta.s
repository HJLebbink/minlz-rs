# minlz_exec_flat_delta of crates/minlz/mlir/exec64.mlir for avx512, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 168
	mov	rbp, rdi
	mov	r15, qword ptr [rdi]
	mov	rax, qword ptr [rdi + 8]
	mov	rcx, qword ptr [rdi + 64]
	mov	rbx, qword ptr [rdi + 80]
	add	rbx, r15
	mov	r12, qword ptr [rdi + 88]
	mov	qword ptr [rsp + 112], rax
	add	r12, rax
	test	rcx, rcx
	jle	852f
	mov	rax, qword ptr [rbp + 16]
	mov	qword ptr [rsp + 120], rax
	mov	r8, qword ptr [rbp + 96]
	lea	rax, [rbp + 512]
	lea	rdx, [rbp + 576]
	mov	qword ptr [rsp], rdx
	mov	edx, 192
	mov	qword ptr [rsp + 88], rdx
	mov	edx, 7
	mov	qword ptr [rsp + 72], rdx
	mov	qword ptr [rsp + 96], 0
	vmovdqa64	zmm0, zmmword ptr [rip + 862f]
	vpbroadcastb	zmm1, byte ptr [rip + 872f]
	vpbroadcastb	zmm2, byte ptr [rip + 882f]
	vpbroadcastd	zmm3, dword ptr [rip + 892f]
	vpternlogd	zmm4, zmm4, zmm4, 255
	vpbroadcastd	zmm5, dword ptr [rip + 902f]
	vpbroadcastd	zmm6, dword ptr [rip + 912f]
	vpxor	xmm7, xmm7, xmm7
	vbroadcasti32x4	zmm8, xmmword ptr [rip + 922f]
	vpbroadcastd	zmm9, dword ptr [rip + 932f]
	vmovdqa64	zmm10, zmmword ptr [rip + 942f]
	vpbroadcastd	zmm11, dword ptr [rip + 952f]
	mov	r11, rax
	xor	edx, edx
	mov	qword ptr [rsp + 160], rbp
	mov	qword ptr [rsp + 64], rax
	mov	qword ptr [rsp + 40], r15
	mov	qword ptr [rsp + 128], rcx
	jmp	12f
	.p2align	4
2:
	inc	qword ptr [rsp + 96]
	add	qword ptr [rsp + 88], 64
	add	qword ptr [rsp + 72], -64
	add	r11, -64
	mov	rcx, qword ptr [rsp + 128]
	mov	rdx, qword ptr [rsp + 152]
	cmp	rdx, rcx
	mov	rax, qword ptr [rsp + 64]
	jge	852f
12:
	mov	qword ptr [rsp + 48], r12
	mov	qword ptr [rsp + 104], r11
	mov	qword ptr [rsp + 24], rbx
	mov	rdi, rdx
	mov	rdx, rcx
	sub	rdx, rdi
	cmp	rdx, 64
	mov	ecx, 64
	mov	qword ptr [rsp + 32], rdx
	cmovb	rcx, rdx
	mov	qword ptr [rsp + 80], rcx
	mov	rbx, qword ptr [rbp + 16]
	mov	r10, qword ptr [rbp + 24]
	mov	rcx, qword ptr [rbp + 32]
	mov	qword ptr [rsp + 136], rcx
	mov	r13, qword ptr [rbp + 40]
	mov	r14, qword ptr [rbp + 64]
	mov	rsi, qword ptr [rbp + 72]
	mov	rcx, qword ptr [rbp + 96]
	mov	qword ptr [rsp + 144], rcx
	mov	rdx, qword ptr [rbp + 112]
	mov	r9, qword ptr [rbp + 128]
	mov	rcx, qword ptr [rbp + 136]
	mov	qword ptr [rsp + 16], rcx
	lea	r11, [r14 + 7]
	lea	rcx, [rdi + 64]
	mov	qword ptr [rsp + 152], rcx
	cmp	rcx, r11
	mov	qword ptr [rsp + 8], rdi
	jbe	22f
	cmp	rdi, r11
	jge	92f
	mov	rax, qword ptr [rsp + 96]
	shl	rax, 6
	mov	r15d, 7
	sub	r15, rax
	add	r15, r14
	cmp	r15, 16
	mov	rdi, qword ptr [rsp + 8]
	jb	72f
	add	rax, rbx
	mov	rcx, rbp
	sub	rcx, rax
	add	rcx, 511
	cmp	rcx, 255
	mov	rdi, qword ptr [rsp + 8]
	jb	72f
	cmp	r15, 256
	mov	qword ptr [rsp + 56], r9
	jae	32f
	xor	r12d, r12d
	jmp	52f
	.p2align	4
22:
	add	rbx, rdi
	mov	rax, rbx
	jmp	92f
32:
	mov	r12, r15
	and	r12, -256
	mov	rax, qword ptr [rsp + 8]
	lea	rdi, [rax + r12]
	mov	rax, qword ptr [rsp + 88]
	add	rax, rbx
	mov	rcx, qword ptr [rsp + 72]
	lea	r9, [r14 + rcx]
	and	r9, -256
	xor	ecx, ecx
	.p2align	4
42:
	vmovdqu64	zmm12, zmmword ptr [rax + rcx - 192]
	vmovdqu64	zmm13, zmmword ptr [rax + rcx - 128]
	vmovdqu64	zmm14, zmmword ptr [rax + rcx - 64]
	vmovdqu64	zmm15, zmmword ptr [rax + rcx]
	vmovdqu64	zmmword ptr [rbp + rcx + 512], zmm12
	vmovdqu64	zmmword ptr [rbp + rcx + 576], zmm13
	vmovdqu64	zmmword ptr [rbp + rcx + 640], zmm14
	vmovdqu64	zmmword ptr [rbp + rcx + 704], zmm15
	add	rcx, 256
	cmp	r9, rcx
	jne	42b
	cmp	r15, r12
	mov	rax, qword ptr [rsp + 64]
	mov	r9, qword ptr [rsp + 56]
	je	92f
	test	r15b, -16
	je	72f
52:
	mov	rax, r15
	and	rax, -16
	mov	rcx, qword ptr [rsp + 8]
	lea	rdi, [rcx + rax]
	add	rcx, rbx
	add	r14, qword ptr [rsp + 72]
	and	r14, -16
	mov	r9, qword ptr [rsp + 64]
	.p2align	4
62:
	vmovdqu	xmm12, xmmword ptr [rcx + r12]
	vmovdqu	xmmword ptr [r9 + r12], xmm12
	add	r12, 16
	cmp	r14, r12
	jne	62b
	cmp	r15, rax
	mov	rax, r9
	mov	r9, qword ptr [rsp + 56]
	je	92f
	.p2align	4
72:
	mov	rcx, qword ptr [rsp + 104]
	.p2align	4
82:
	movzx	eax, byte ptr [rbx + rdi]
	mov	byte ptr [rcx + rdi], al
	inc	rdi
	cmp	r11, rdi
	jne	82b
	mov	rax, qword ptr [rsp + 64]
92:
	vmovdqu64	zmm12, zmmword ptr [rax]
	mov	rax, qword ptr [rsp + 80]
	vpbroadcastb	zmm13, eax
	vpcmpnleub	k2, zmm13, zmm0
	vptestmb	k1 {k2}, zmm12, zmm1
	vptestnmb	k2 {k2}, zmm12, zmm2
	vpexpandb	zmm12 {k1} {z}, zmmword ptr [r10 + r9]
	vmovdqu64	zmmword ptr [rbp + 192], zmm12
	mov	rax, qword ptr [rsp + 16]
	mov	rcx, qword ptr [rsp + 136]
	vpexpandb	zmm12 {k2} {z}, zmmword ptr [rcx + rax]
	mov	rcx, rsi
	shr	rcx, 3
	lea	rax, [rcx + 64]
	cmp	rax, rdx
	jbe	102f
	mov	rdi, rdx
	sub	rdi, rcx
	mov	r15, qword ptr [rsp]
	mov	r14, r15
	mov	r12, qword ptr [rsp + 24]
	jbe	172f
	cmp	rdi, 16
	mov	r10, rcx
	jb	152f
	lea	r11, [rcx + r13]
	mov	rax, rbp
	sub	rax, r11
	add	rax, 575
	cmp	rax, 255
	mov	r10, rcx
	jb	152f
	cmp	rdi, 256
	jae	112f
	xor	ebx, ebx
	jmp	132f
	.p2align	4
102:
	add	rcx, r13
	mov	r14, rcx
	mov	r12, qword ptr [rsp + 24]
	jmp	172f
112:
	mov	qword ptr [rsp + 56], r9
	mov	rbx, rdi
	and	rbx, -256
	lea	r10, [rcx + rbx]
	lea	rax, [r13 + rcx + 192]
	xor	r9d, r9d
	.p2align	4
122:
	vmovdqu64	zmm13, zmmword ptr [rax + r9 - 192]
	vmovdqu64	zmm14, zmmword ptr [rax + r9 - 128]
	vmovdqu64	zmm15, zmmword ptr [rax + r9 - 64]
	vmovdqu64	zmm16, zmmword ptr [rax + r9]
	vmovdqu64	zmmword ptr [rbp + r9 + 576], zmm13
	vmovdqu64	zmmword ptr [rbp + r9 + 640], zmm14
	vmovdqu64	zmmword ptr [rbp + r9 + 704], zmm15
	vmovdqu64	zmmword ptr [rbp + r9 + 768], zmm16
	add	r9, 256
	cmp	rbx, r9
	jne	122b
	cmp	rdi, rbx
	mov	r14, r15
	mov	r9, qword ptr [rsp + 56]
	je	172f
	test	dil, -16
	je	152f
132:
	mov	rax, rdi
	and	rax, -16
	lea	r10, [rcx + rax]
	.p2align	4
142:
	vmovdqu	xmm13, xmmword ptr [r11 + rbx]
	vmovdqu	xmmword ptr [r15 + rbx], xmm13
	add	rbx, 16
	cmp	rax, rbx
	jne	142b
	cmp	rdi, rax
	mov	r14, r15
	je	172f
	.p2align	4
152:
	mov	rax, r15
	sub	rax, rcx
	.p2align	4
162:
	movzx	ecx, byte ptr [r13 + r10]
	mov	byte ptr [rax + r10], cl
	inc	r10
	cmp	rdx, r10
	jne	162b
	mov	r14, r15
172:
	mov	rax, qword ptr [rsp + 144]
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
	mov	eax, esi
	and	eax, 7
	vpbroadcastd	zmm18, eax
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
	vpextrd	r10d, xmm15, 3
	add	r10, rsi
	vmovdqu64	zmmword ptr [rbp + 256], zmm14
	mov	r14, qword ptr [rsp + 32]
	cmp	r14, 17
	mov	r15, qword ptr [rsp + 40]
	jb	342f
	mov	rax, r10
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, rdx
	jbe	182f
	mov	rcx, rdx
	sub	rcx, rax
	mov	rbx, qword ptr [rsp]
	jbe	252f
	cmp	rcx, 16
	mov	rsi, rax
	jb	232f
	lea	rdi, [rax + r13]
	mov	rsi, rbp
	sub	rsi, rdi
	add	rsi, 575
	cmp	rsi, 255
	mov	rsi, rax
	jb	232f
	cmp	rcx, 256
	jae	192f
	xor	r11d, r11d
	jmp	212f
	.p2align	4
182:
	add	rax, r13
	mov	rbx, rax
	jmp	252f
192:
	mov	r14, r9
	mov	r11, rcx
	and	r11, -256
	lea	rsi, [rax + r11]
	lea	r9, [r13 + rax + 192]
	xor	ebx, ebx
	.p2align	4
202:
	vmovdqu64	zmm14, zmmword ptr [r9 + rbx - 192]
	vmovdqu64	zmm15, zmmword ptr [r9 + rbx - 128]
	vmovdqu64	zmm16, zmmword ptr [r9 + rbx - 64]
	vmovdqu64	zmm17, zmmword ptr [r9 + rbx]
	vmovdqu64	zmmword ptr [rbp + rbx + 576], zmm14
	vmovdqu64	zmmword ptr [rbp + rbx + 640], zmm15
	vmovdqu64	zmmword ptr [rbp + rbx + 704], zmm16
	vmovdqu64	zmmword ptr [rbp + rbx + 768], zmm17
	add	rbx, 256
	cmp	r11, rbx
	jne	202b
	cmp	rcx, r11
	mov	rbx, qword ptr [rsp]
	mov	r9, r14
	mov	r14, qword ptr [rsp + 32]
	je	252f
	test	cl, -16
	je	232f
212:
	mov	r14, r9
	mov	r9, rcx
	and	r9, -16
	lea	rsi, [rax + r9]
	mov	rbx, qword ptr [rsp]
	.p2align	4
222:
	vmovdqu	xmm14, xmmword ptr [rdi + r11]
	vmovdqu	xmmword ptr [rbx + r11], xmm14
	add	r11, 16
	cmp	r9, r11
	jne	222b
	cmp	rcx, r9
	mov	r9, r14
	mov	r14, qword ptr [rsp + 32]
	je	252f
232:
	mov	rcx, qword ptr [rsp]
	sub	rcx, rax
	.p2align	4
242:
	movzx	eax, byte ptr [r13 + rsi]
	mov	byte ptr [rcx + rsi], al
	inc	rsi
	cmp	rdx, rsi
	jne	242b
	mov	rbx, qword ptr [rsp]
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
	mov	eax, r10d
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
	vmovdqu64	zmmword ptr [rbp + 320], zmm13
	vshufi64x2	zmm13, zmm14, zmm14, 255
	vextracti32x4	xmm14, zmm17, 3
	vpextrd	eax, xmm14, 3
	add	r10, rax
	cmp	r14, 33
	jb	342f
	mov	rax, r10
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, rdx
	jbe	262f
	mov	rcx, rdx
	sub	rcx, rax
	mov	rbx, qword ptr [rsp]
	jbe	332f
	cmp	rcx, 16
	mov	rsi, rax
	jb	312f
	lea	rdi, [rax + r13]
	mov	rsi, rbp
	sub	rsi, rdi
	add	rsi, 575
	cmp	rsi, 255
	mov	rsi, rax
	jb	312f
	cmp	rcx, 256
	jae	272f
	xor	r11d, r11d
	jmp	292f
262:
	add	rax, r13
	mov	rbx, rax
	jmp	332f
272:
	mov	r14, r9
	mov	r11, rcx
	and	r11, -256
	lea	rsi, [rax + r11]
	lea	r9, [r13 + rax + 192]
	xor	ebx, ebx
	.p2align	4
282:
	vmovdqu64	zmm14, zmmword ptr [r9 + rbx - 192]
	vmovdqu64	zmm15, zmmword ptr [r9 + rbx - 128]
	vmovdqu64	zmm16, zmmword ptr [r9 + rbx - 64]
	vmovdqu64	zmm17, zmmword ptr [r9 + rbx]
	vmovdqu64	zmmword ptr [rbp + rbx + 576], zmm14
	vmovdqu64	zmmword ptr [rbp + rbx + 640], zmm15
	vmovdqu64	zmmword ptr [rbp + rbx + 704], zmm16
	vmovdqu64	zmmword ptr [rbp + rbx + 768], zmm17
	add	rbx, 256
	cmp	r11, rbx
	jne	282b
	cmp	rcx, r11
	mov	rbx, qword ptr [rsp]
	mov	r9, r14
	mov	r14, qword ptr [rsp + 32]
	je	332f
	test	cl, -16
	je	312f
292:
	mov	r14, r9
	mov	r9, rcx
	and	r9, -16
	lea	rsi, [rax + r9]
	mov	rbx, qword ptr [rsp]
	.p2align	4
302:
	vmovdqu	xmm14, xmmword ptr [rdi + r11]
	vmovdqu	xmmword ptr [rbx + r11], xmm14
	add	r11, 16
	cmp	r9, r11
	jne	302b
	cmp	rcx, r9
	mov	r9, r14
	mov	r14, qword ptr [rsp + 32]
	je	332f
312:
	mov	rcx, qword ptr [rsp]
	sub	rcx, rax
	.p2align	4
322:
	movzx	eax, byte ptr [r13 + rsi]
	mov	byte ptr [rcx + rsi], al
	inc	rsi
	cmp	rdx, rsi
	jne	322b
	mov	rbx, qword ptr [rsp]
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
	mov	eax, r10d
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
	vmovdqu64	zmmword ptr [rbp + 384], zmm13
	vshufi64x2	zmm13, zmm14, zmm14, 255
	vextracti32x4	xmm14, zmm17, 3
	vpextrd	eax, xmm14, 3
	add	r10, rax
	cmp	r14, 49
	jb	342f
	mov	r14, r9
	mov	rax, r10
	shr	rax, 3
	lea	rcx, [rax + 64]
	cmp	rcx, rdx
	mov	rbx, qword ptr [rsp + 8]
	jbe	772f
	mov	rcx, rdx
	sub	rcx, rax
	mov	r11, qword ptr [rsp]
	jbe	842f
	cmp	rcx, 16
	mov	rsi, rax
	jb	822f
	lea	rdi, [rax + r13]
	mov	rsi, rbp
	sub	rsi, rdi
	add	rsi, 575
	cmp	rsi, 255
	mov	rsi, rax
	jb	822f
	cmp	rcx, 256
	jae	782f
	xor	r9d, r9d
	jmp	802f
	.p2align	4
342:
	mov	rbx, qword ptr [rsp + 8]
352:
	kmovq	rax, k2
	popcnt	rax, rax
	add	rax, qword ptr [rsp + 16]
	kmovq	rcx, k1
	popcnt	rcx, rcx
	add	rcx, r9
	vmovd	edx, xmm13
	mov	qword ptr [rbp + 72], r10
	mov	qword ptr [rbp + 96], rdx
	mov	qword ptr [rbp + 128], rcx
	mov	qword ptr [rbp + 136], rax
	add	rbx, qword ptr [rsp + 120]
	mov	qword ptr [rsp + 8], rbx
	mov	r13, qword ptr [rsp + 80]
	and	r13, 124
	mov	r10, qword ptr [rsp + 48]
	je	672f
	xor	r9d, r9d
	mov	edx, 32
	mov	qword ptr [rsp + 32], r13
	.p2align	4
362:
	mov	rbx, qword ptr [rsp + 8]
	movzx	esi, byte ptr [rbx + r9]
	movzx	r11d, byte ptr [rbp + r9 + 192]
	cmp	r8, 33
	cmovb	r8, rdx
	mov	rcx, r12
	sub	rcx, r15
	cmp	r8, rcx
	cmovb	rcx, r8
	neg	rcx
	cmp	r11, 33
	mov	eax, dword ptr [rbp + 4*r9 + 256]
	vmovdqu	ymm12, ymmword ptr [r12 + rcx]
	vpaddb	ymm12, ymm12, ymmword ptr [r10]
	vmovdqu	ymmword ptr [r12], ymm12
	jae	472f
372:
	mov	qword ptr [rsp + 48], r10
	lea	rcx, [r12 + r11]
	mov	r13d, esi
	shr	r13d, 2
	cmp	r13, 32
	mov	r8d, 32
	cmovb	r8, r13
	cmp	rax, r8
	cmova	r8, rax
	mov	rdi, rcx
	sub	rdi, r8
	cmp	rdi, r15
	jl	492f
382:
	mov	qword ptr [rsp + 16], r11
	vmovdqu	ymm12, ymmword ptr [rdi]
	vmovdqu	ymmword ptr [rcx], ymm12
	cmp	sil, -124
	jae	502f
392:
	lea	rsi, [r9 + 1]
	lea	r8, [rcx + r13]
	cmp	rax, 33
	cmovb	rax, rdx
	mov	rdi, r8
	sub	rdi, r15
	cmp	rax, rdi
	cmovb	rdi, rax
	mov	r10, r8
	sub	r10, rdi
	movzx	eax, byte ptr [rbx + rsi]
	vmovdqu	ymm12, ymmword ptr [r10]
	movzx	r14d, byte ptr [rbp + rsi + 192]
	mov	r11d, dword ptr [rbp + 4*rsi + 256]
	mov	rsi, qword ptr [rsp + 48]
	mov	rdi, qword ptr [rsp + 16]
	vpaddb	ymm12, ymm12, ymmword ptr [rsi + rdi]
	vmovdqu	ymmword ptr [rcx + r13], ymm12
	add	rsi, rdi
	cmp	r14, 33
	jae	522f
402:
	mov	qword ptr [rsp + 24], r12
	add	r8, r14
	mov	r12d, eax
	shr	r12d, 2
	cmp	r12, 32
	mov	edi, 32
	cmovb	rdi, r12
	cmp	r11, rdi
	cmova	rdi, r11
	mov	rcx, r8
	sub	rcx, rdi
	cmp	rcx, r15
	jl	542f
	vmovdqu	ymm12, ymmword ptr [rcx]
	vmovdqu	ymmword ptr [r8], ymm12
	cmp	al, -124
	jae	552f
412:
	lea	rdi, [r9 + 2]
	lea	rcx, [r8 + r12]
	movzx	ebx, byte ptr [rbx + rdi]
	movzx	eax, byte ptr [rbp + rdi + 192]
	cmp	r11, 33
	cmovb	r11, rdx
	mov	r10, rcx
	sub	r10, r15
	cmp	r11, r10
	cmovb	r10, r11
	mov	rdx, r15
	mov	r15, rcx
	sub	r15, r10
	cmp	rax, 33
	mov	r11d, dword ptr [rbp + 4*rdi + 256]
	vmovdqu	ymm12, ymmword ptr [r15]
	vpaddb	ymm12, ymm12, ymmword ptr [rsi + r14]
	vmovdqu	ymmword ptr [r8 + r12], ymm12
	jae	572f
422:
	add	rcx, rax
	mov	r15d, ebx
	shr	r15d, 2
	cmp	r15, 32
	mov	r8d, 32
	cmovb	r8, r15
	cmp	r11, r8
	cmova	r8, r11
	mov	rdi, rcx
	sub	rdi, r8
	cmp	rdi, rdx
	jl	592f
	vmovdqu	ymm12, ymmword ptr [rdi]
	vmovdqu	ymmword ptr [rcx], ymm12
	cmp	bl, -124
	jae	602f
432:
	add	rsi, r14
	lea	r8, [r9 + 3]
	lea	rbx, [rcx + r15]
	cmp	r11, 33
	mov	edx, 32
	cmovb	r11, rdx
	mov	rdi, rbx
	mov	rdx, qword ptr [rsp + 40]
	sub	rdi, rdx
	cmp	r11, rdi
	cmovb	rdi, r11
	mov	r10, rbx
	sub	r10, rdi
	mov	rdi, qword ptr [rsp + 8]
	movzx	edi, byte ptr [rdi + r8]
	vmovdqu	ymm12, ymmword ptr [r10]
	movzx	r11d, byte ptr [rbp + r8 + 192]
	mov	r8d, dword ptr [rbp + 4*r8 + 256]
	vpaddb	ymm12, ymm12, ymmword ptr [rsi + rax]
	vmovdqu	ymmword ptr [rcx + r15], ymm12
	cmp	r11, 33
	jae	622f
442:
	add	rbx, r11
	mov	ecx, edi
	shr	ecx, 2
	cmp	rcx, 32
	mov	ebp, 32
	cmovb	rbp, rcx
	cmp	r8, rbp
	cmova	rbp, r8
	mov	r10, rbx
	sub	r10, rbp
	cmp	r10, rdx
	jl	642f
452:
	vmovdqu	ymm12, ymmword ptr [r10]
	vmovdqu	ymmword ptr [rbx], ymm12
	cmp	dil, -124
	mov	rbp, qword ptr [rsp + 160]
	jae	652f
462:
	add	rsi, rax
	add	rbx, rcx
	add	rsi, r11
	add	r9, 4
	mov	r13, qword ptr [rsp + 32]
	cmp	r9, r13
	mov	r10, rsi
	mov	r12, rbx
	mov	r15, qword ptr [rsp + 40]
	mov	edx, 32
	jb	362b
	jmp	682f
472:
	mov	rcx, qword ptr [rbp + 48]
	mov	rdi, qword ptr [rbp + 120]
	movzx	r11d, byte ptr [rcx + rdi]
	inc	rdi
	mov	qword ptr [rbp + 120], rdi
	add	r11, 33
	mov	ecx, 32
	.p2align	4
482:
	vmovdqu	ymm12, ymmword ptr [r10 + rcx]
	vmovdqu	ymmword ptr [r12 + rcx], ymm12
	add	rcx, 32
	cmp	rcx, r11
	jb	482b
	jmp	372b
492:
	mov	r10, rcx
	sub	r10, r15
	sub	r10, r8
	mov	edi, 0
	cmovae	rdi, r10
	add	rdi, r15
	jmp	382b
502:
	mov	rsi, qword ptr [rbp + 48]
	mov	r8, qword ptr [rbp + 120]
	movzx	r13d, byte ptr [rsi + r8]
	inc	r8
	mov	qword ptr [rbp + 120], r8
	add	r13, 33
	mov	esi, 32
	.p2align	4
512:
	vmovdqu	ymm12, ymmword ptr [rdi + rsi]
	vmovdqu	ymmword ptr [rcx + rsi], ymm12
	add	rsi, 32
	cmp	rsi, r13
	jb	512b
	jmp	392b
522:
	mov	rcx, qword ptr [rbp + 48]
	mov	rdi, qword ptr [rbp + 120]
	movzx	r14d, byte ptr [rcx + rdi]
	inc	rdi
	mov	qword ptr [rbp + 120], rdi
	add	r14, 33
	mov	rcx, qword ptr [rsp + 16]
	add	rcx, r13
	add	rcx, r12
	mov	edi, 32
	.p2align	4
532:
	vmovdqu	ymm12, ymmword ptr [rsi + rdi]
	vmovdqu	ymmword ptr [rcx + rdi], ymm12
	add	rdi, 32
	cmp	rdi, r14
	jb	532b
	jmp	402b
542:
	mov	r10, r8
	sub	r10, r15
	sub	r10, rdi
	mov	ecx, 0
	cmovae	rcx, r10
	add	rcx, r15
	vmovdqu	ymm12, ymmword ptr [rcx]
	vmovdqu	ymmword ptr [r8], ymm12
	cmp	al, -124
	jb	412b
552:
	mov	rax, qword ptr [rbp + 48]
	mov	rdi, qword ptr [rbp + 120]
	movzx	r12d, byte ptr [rax + rdi]
	inc	rdi
	mov	qword ptr [rbp + 120], rdi
	add	r12, 33
	mov	rax, qword ptr [rsp + 16]
	add	rax, r14
	mov	rdx, qword ptr [rsp + 24]
	add	rax, rdx
	add	rax, r13
	mov	edi, 32
	.p2align	4
562:
	vmovdqu	ymm12, ymmword ptr [rcx + rdi]
	vmovdqu	ymmword ptr [rax + rdi], ymm12
	add	rdi, 32
	cmp	rdi, r12
	jb	562b
	mov	edx, 32
	jmp	412b
572:
	mov	rax, qword ptr [rbp + 48]
	mov	rdi, qword ptr [rbp + 120]
	movzx	eax, byte ptr [rax + rdi]
	inc	rdi
	mov	qword ptr [rbp + 120], rdi
	add	rax, 33
	mov	rdx, qword ptr [rsp + 16]
	lea	rdi, [rdx + r14]
	lea	r8, [r12 + r13]
	add	r8, rdi
	add	r8, qword ptr [rsp + 24]
	add	rdi, qword ptr [rsp + 48]
	mov	r10d, 32
	.p2align	4
582:
	vmovdqu	ymm12, ymmword ptr [rdi + r10]
	vmovdqu	ymmword ptr [r8 + r10], ymm12
	add	r10, 32
	cmp	r10, rax
	jb	582b
	mov	rdx, qword ptr [rsp + 40]
	jmp	422b
592:
	mov	r10, rcx
	mov	rdx, qword ptr [rsp + 40]
	sub	r10, rdx
	sub	r10, r8
	mov	edi, 0
	cmovae	rdi, r10
	add	rdi, rdx
	vmovdqu	ymm12, ymmword ptr [rdi]
	vmovdqu	ymmword ptr [rcx], ymm12
	cmp	bl, -124
	jb	432b
602:
	mov	r8, qword ptr [rbp + 48]
	mov	r10, qword ptr [rbp + 120]
	movzx	r15d, byte ptr [r8 + r10]
	inc	r10
	mov	qword ptr [rbp + 120], r10
	add	r15, 33
	mov	rdx, qword ptr [rsp + 16]
	lea	r8, [r12 + r14]
	add	r8, rdx
	add	r8, rax
	mov	rdx, qword ptr [rsp + 24]
	add	r8, rdx
	add	r8, r13
	mov	r10d, 32
	.p2align	4
612:
	vmovdqu	ymm12, ymmword ptr [rdi + r10]
	vmovdqu	ymmword ptr [r8 + r10], ymm12
	add	r10, 32
	cmp	r10, r15
	jb	612b
	jmp	432b
622:
	mov	rcx, qword ptr [rbp + 48]
	mov	r10, qword ptr [rbp + 120]
	movzx	r11d, byte ptr [rcx + r10]
	inc	r10
	mov	qword ptr [rbp + 120], r10
	add	r11, 33
	mov	rcx, qword ptr [rsp + 16]
	lea	r10, [rcx + rax]
	lea	rbp, [r15 + r12]
	add	rbp, r10
	lea	rcx, [r14 + r13]
	add	rcx, qword ptr [rsp + 24]
	add	rcx, rbp
	mov	rdx, qword ptr [rsp + 48]
	add	rdx, r14
	add	rdx, r10
	mov	r10d, 32
	.p2align	4
632:
	vmovdqu	ymm12, ymmword ptr [rdx + r10]
	vmovdqu	ymmword ptr [rcx + r10], ymm12
	add	r10, 32
	cmp	r10, r11
	jb	632b
	mov	rdx, qword ptr [rsp + 40]
	jmp	442b
642:
	mov	r10, rbx
	mov	rdx, qword ptr [rsp + 40]
	sub	r10, rdx
	sub	r10, rbp
	mov	rbp, r10
	mov	r10d, 0
	cmovae	r10, rbp
	add	r10, rdx
	jmp	452b
652:
	mov	rcx, qword ptr [rbp + 48]
	mov	rdi, qword ptr [rbp + 120]
	movzx	ecx, byte ptr [rcx + rdi]
	inc	rdi
	mov	qword ptr [rbp + 120], rdi
	add	rcx, 33
	mov	rdx, qword ptr [rsp + 16]
	add	rdx, r11
	add	r15, rax
	add	r15, rdx
	add	r12, r14
	add	r12, r13
	add	r12, r15
	mov	rdx, qword ptr [rsp + 24]
	add	rdx, r12
	mov	edi, 32
	.p2align	4
662:
	vmovdqu	ymm12, ymmword ptr [r10 + rdi]
	vmovdqu	ymmword ptr [rdx + rdi], ymm12
	add	rdi, 32
	cmp	rdi, rcx
	jb	662b
	jmp	462b
	.p2align	4
672:
	mov	rbx, r12
	mov	rsi, r10
	mov	edx, 32
682:
	mov	r14, qword ptr [rsp + 80]
	cmp	r13, r14
	mov	r12, rsi
	mov	r11, qword ptr [rsp + 104]
	je	2b
	.p2align	4
692:
	mov	rax, qword ptr [rsp + 8]
	movzx	ecx, byte ptr [rax + r13]
	movzx	eax, byte ptr [rbp + r13 + 192]
	cmp	r8, 33
	cmovb	r8, rdx
	mov	rsi, rbx
	sub	rsi, r15
	cmp	r8, rsi
	cmovb	rsi, r8
	neg	rsi
	cmp	rax, 33
	mov	r8d, dword ptr [rbp + 4*r13 + 256]
	vmovdqu	ymm12, ymmword ptr [rbx + rsi]
	vpaddb	ymm12, ymm12, ymmword ptr [r12]
	vmovdqu	ymmword ptr [rbx], ymm12
	jae	722f
702:
	add	rbx, rax
	mov	esi, ecx
	shr	esi, 2
	cmp	rsi, 32
	mov	r9d, 32
	cmovb	r9, rsi
	cmp	r8, r9
	cmova	r9, r8
	mov	rdi, rbx
	sub	rdi, r9
	cmp	rdi, r15
	jl	742f
	vmovdqu	ymm12, ymmword ptr [rdi]
	vmovdqu	ymmword ptr [rbx], ymm12
	cmp	cl, -124
	jae	752f
712:
	add	rbx, rsi
	add	r12, rax
	inc	r13
	cmp	r13, r14
	jb	692b
	jmp	2b
722:
	mov	rax, qword ptr [rbp + 48]
	mov	rsi, qword ptr [rbp + 120]
	movzx	eax, byte ptr [rax + rsi]
	inc	rsi
	mov	qword ptr [rbp + 120], rsi
	add	rax, 33
	mov	esi, 32
	.p2align	4
732:
	vmovdqu	ymm12, ymmword ptr [r12 + rsi]
	vmovdqu	ymmword ptr [rbx + rsi], ymm12
	add	rsi, 32
	cmp	rsi, rax
	jb	732b
	jmp	702b
742:
	mov	r10, rbx
	sub	r10, r15
	sub	r10, r9
	mov	edi, 0
	cmovae	rdi, r10
	add	rdi, r15
	vmovdqu	ymm12, ymmword ptr [rdi]
	vmovdqu	ymmword ptr [rbx], ymm12
	cmp	cl, -124
	jb	712b
752:
	mov	rcx, qword ptr [rbp + 48]
	mov	r9, qword ptr [rbp + 120]
	movzx	esi, byte ptr [rcx + r9]
	inc	r9
	mov	qword ptr [rbp + 120], r9
	add	rsi, 33
	mov	ecx, 32
	.p2align	4
762:
	vmovdqu	ymm12, ymmword ptr [rdi + rcx]
	vmovdqu	ymmword ptr [rbx + rcx], ymm12
	add	rcx, 32
	cmp	rcx, rsi
	jb	762b
	jmp	712b
772:
	add	r13, rax
	mov	r11, r13
	jmp	842f
782:
	mov	r9, rcx
	and	r9, -256
	lea	rsi, [rax + r9]
	lea	r11, [r13 + rax + 192]
	xor	ebx, ebx
	.p2align	4
792:
	vmovdqu64	zmm14, zmmword ptr [r11 + rbx - 192]
	vmovdqu64	zmm15, zmmword ptr [r11 + rbx - 128]
	vmovdqu64	zmm16, zmmword ptr [r11 + rbx - 64]
	vmovdqu64	zmm17, zmmword ptr [r11 + rbx]
	vmovdqu64	zmmword ptr [rbp + rbx + 576], zmm14
	vmovdqu64	zmmword ptr [rbp + rbx + 640], zmm15
	vmovdqu64	zmmword ptr [rbp + rbx + 704], zmm16
	vmovdqu64	zmmword ptr [rbp + rbx + 768], zmm17
	add	rbx, 256
	cmp	r9, rbx
	jne	792b
	cmp	rcx, r9
	mov	r11, qword ptr [rsp]
	mov	rbx, qword ptr [rsp + 8]
	je	842f
	test	cl, -16
	je	822f
802:
	mov	r11, rcx
	and	r11, -16
	lea	rsi, [rax + r11]
	mov	rbx, qword ptr [rsp]
	.p2align	4
812:
	vmovdqu	xmm14, xmmword ptr [rdi + r9]
	vmovdqu	xmmword ptr [rbx + r9], xmm14
	add	r9, 16
	cmp	r11, r9
	jne	812b
	cmp	rcx, r11
	mov	r11, rbx
	mov	rbx, qword ptr [rsp + 8]
	je	842f
822:
	mov	rcx, qword ptr [rsp]
	sub	rcx, rax
	.p2align	4
832:
	movzx	eax, byte ptr [r13 + rsi]
	mov	byte ptr [rcx + rsi], al
	inc	rsi
	cmp	rdx, rsi
	jne	832b
	mov	r11, qword ptr [rsp]
842:
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
	mov	eax, r10d
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
	vmovdqu64	zmmword ptr [rbp + 448], zmm13
	vshufi64x2	zmm13, zmm12, zmm12, 255
	vextracti32x4	xmm12, zmm16, 3
	vpextrd	eax, xmm12, 3
	add	r10, rax
	mov	r9, r14
	jmp	352b
852:
	sub	rbx, r15
	sub	r12, qword ptr [rsp + 112]
	mov	qword ptr [rbp + 80], rbx
	mov	qword ptr [rbp + 88], r12
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
862:
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
872:
	.byte	2
	.p2align	6, 0x0
882:
	.byte	1
	.p2align	2, 0x0
892:
	.long	1
	.p2align	2, 0x0
902:
	.long	7
	.p2align	2, 0x0
912:
	.long	8
	.p2align	4, 0x0
922:
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
932:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	6, 0x0
942:
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
952:
	.long	134217727

# minlz_exec_plain of crates/minlz/mlir/exec64.mlir for avx512, written by
# cargo xtask mlir. Do not edit.
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 160
	mov	rcx, rdi
	mov	rax, qword ptr [rdi + 64]
	mov	rbp, qword ptr [rdi + 80]
	mov	r11, qword ptr [rdi + 88]
	test	rax, rax
	jle	922f
	mov	r13, qword ptr [rcx]
	mov	r12, qword ptr [rcx + 8]
	mov	rdx, qword ptr [rcx + 16]
	mov	qword ptr [rsp + 136], rdx
	lea	r14, [rcx + 512]
	lea	rdx, [rcx + 576]
	mov	qword ptr [rsp + 64], rdx
	mov	edx, 192
	mov	qword ptr [rsp + 104], rdx
	mov	edx, 7
	mov	qword ptr [rsp + 96], rdx
	mov	qword ptr [rsp + 112], 0
	vmovdqa64	zmm0, zmmword ptr [rip + 932f]
	vpbroadcastb	zmm1, byte ptr [rip + 942f]
	vpbroadcastb	zmm2, byte ptr [rip + 952f]
	vpbroadcastd	zmm3, dword ptr [rip + 962f]
	vpternlogd	zmm4, zmm4, zmm4, 255
	vpbroadcastd	zmm5, dword ptr [rip + 972f]
	vpbroadcastd	zmm6, dword ptr [rip + 982f]
	vpxor	xmm7, xmm7, xmm7
	vbroadcasti32x4	zmm8, xmmword ptr [rip + 992f]
	vpbroadcastd	zmm9, dword ptr [rip + 1002f]
	vmovdqa64	zmm10, zmmword ptr [rip + 1012f]
	vpbroadcastd	zmm11, dword ptr [rip + 1022f]
	mov	rdx, r14
	xor	esi, esi
	mov	qword ptr [rsp], rcx
	mov	qword ptr [rsp + 80], r14
	mov	qword ptr [rsp + 144], rax
	mov	qword ptr [rsp + 56], r13
	mov	qword ptr [rsp + 72], r12
	jmp	12f
	.p2align	4
2:
	inc	qword ptr [rsp + 112]
	add	qword ptr [rsp + 104], 64
	add	qword ptr [rsp + 96], -64
	mov	rdx, qword ptr [rsp + 128]
	add	rdx, -64
	mov	rax, qword ptr [rsp + 144]
	mov	rsi, qword ptr [rsp + 152]
	cmp	rsi, rax
	jge	922f
12:
	mov	qword ptr [rsp + 48], r11
	mov	qword ptr [rsp + 128], rdx
	mov	r8, rsi
	mov	rdx, rax
	sub	rdx, rsi
	cmp	rdx, 64
	mov	eax, 64
	mov	qword ptr [rsp + 16], rdx
	cmovb	rax, rdx
	mov	qword ptr [rsp + 32], rax
	mov	r11, qword ptr [rcx + 16]
	mov	rsi, qword ptr [rcx + 24]
	mov	rdx, qword ptr [rcx + 32]
	mov	r9, qword ptr [rcx + 40]
	mov	rdi, qword ptr [rcx + 64]
	mov	r10, qword ptr [rcx + 72]
	mov	rax, qword ptr [rcx + 96]
	mov	qword ptr [rsp + 120], rax
	mov	r12, qword ptr [rcx + 112]
	mov	rax, qword ptr [rcx + 128]
	mov	qword ptr [rsp + 24], rax
	mov	rax, qword ptr [rcx + 136]
	mov	qword ptr [rsp + 88], rax
	lea	rbx, [rdi + 7]
	lea	rax, [r8 + 64]
	mov	qword ptr [rsp + 152], rax
	cmp	rax, rbx
	mov	qword ptr [rsp + 8], r8
	jbe	22f
	cmp	r8, rbx
	mov	rax, r14
	mov	r8, qword ptr [rsp + 16]
	jge	92f
	mov	rax, qword ptr [rsp + 112]
	shl	rax, 6
	mov	r14d, 7
	sub	r14, rax
	add	r14, rdi
	cmp	r14, 16
	mov	r15, qword ptr [rsp + 8]
	jb	72f
	add	rax, r11
	mov	r8, rcx
	sub	r8, rax
	add	r8, 511
	cmp	r8, 255
	mov	r8, qword ptr [rsp + 16]
	mov	r15, qword ptr [rsp + 8]
	jb	72f
	cmp	r14, 256
	mov	qword ptr [rsp + 40], rbp
	jae	32f
	xor	r13d, r13d
	jmp	52f
	.p2align	4
22:
	add	r11, r8
	mov	rax, r11
	mov	r8, qword ptr [rsp + 16]
	jmp	92f
32:
	mov	r13, r14
	and	r13, -256
	mov	rax, qword ptr [rsp + 8]
	lea	r15, [rax + r13]
	mov	rax, qword ptr [rsp + 104]
	lea	rbp, [r11 + rax]
	mov	rax, qword ptr [rsp + 96]
	add	rax, rdi
	and	rax, -256
	xor	r8d, r8d
	.p2align	4
42:
	vmovdqu64	zmm12, zmmword ptr [rbp + r8 - 192]
	vmovdqu64	zmm13, zmmword ptr [rbp + r8 - 128]
	vmovdqu64	zmm14, zmmword ptr [rbp + r8 - 64]
	vmovdqu64	zmm15, zmmword ptr [rbp + r8]
	vmovdqu64	zmmword ptr [rcx + r8 + 512], zmm12
	vmovdqu64	zmmword ptr [rcx + r8 + 576], zmm13
	vmovdqu64	zmmword ptr [rcx + r8 + 640], zmm14
	vmovdqu64	zmmword ptr [rcx + r8 + 704], zmm15
	add	r8, 256
	cmp	rax, r8
	jne	42b
	cmp	r14, r13
	mov	rax, qword ptr [rsp + 80]
	mov	rbp, qword ptr [rsp + 40]
	mov	r8, qword ptr [rsp + 16]
	je	92f
	test	r14b, -16
	je	72f
52:
	mov	rax, r14
	and	rax, -16
	mov	r8, qword ptr [rsp + 8]
	lea	r15, [r8 + rax]
	add	r8, r11
	add	rdi, qword ptr [rsp + 96]
	and	rdi, -16
	mov	rbp, qword ptr [rsp + 80]
	.p2align	4
62:
	vmovdqu	xmm12, xmmword ptr [r8 + r13]
	vmovdqu	xmmword ptr [rbp + r13], xmm12
	add	r13, 16
	cmp	rdi, r13
	jne	62b
	cmp	r14, rax
	mov	rax, rbp
	mov	rbp, qword ptr [rsp + 40]
	mov	r8, qword ptr [rsp + 16]
	je	92f
	.p2align	4
72:
	mov	rdi, qword ptr [rsp + 128]
	.p2align	4
82:
	movzx	eax, byte ptr [r11 + r15]
	mov	byte ptr [rdi + r15], al
	inc	r15
	cmp	rbx, r15
	jne	82b
	mov	rax, qword ptr [rsp + 80]
92:
	vmovdqu64	zmm12, zmmword ptr [rax]
	mov	rax, qword ptr [rsp + 32]
	vpbroadcastb	zmm13, eax
	vpcmpnleub	k2, zmm13, zmm0
	vptestmb	k1 {k2}, zmm12, zmm1
	vptestnmb	k2 {k2}, zmm12, zmm2
	mov	rax, qword ptr [rsp + 24]
	vpexpandb	zmm12 {k1} {z}, zmmword ptr [rsi + rax]
	vmovdqu64	zmmword ptr [rcx + 192], zmm12
	mov	rax, qword ptr [rsp + 88]
	vpexpandb	zmm12 {k2} {z}, zmmword ptr [rdx + rax]
	mov	rdx, r10
	shr	rdx, 3
	lea	rax, [rdx + 64]
	cmp	rax, r12
	jbe	102f
	mov	rsi, r12
	sub	rsi, rdx
	mov	r14, qword ptr [rsp + 64]
	mov	r15, qword ptr [rsp + 48]
	mov	r13, qword ptr [rsp + 120]
	jbe	172f
	cmp	rsi, 16
	mov	rdi, rdx
	jb	152f
	lea	r11, [rdx + r9]
	mov	rax, rcx
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
	mov	r15, qword ptr [rsp + 48]
	mov	r13, qword ptr [rsp + 120]
	jmp	172f
112:
	mov	rbx, rsi
	and	rbx, -256
	lea	rdi, [rdx + rbx]
	lea	rax, [r9 + rdx + 192]
	xor	r8d, r8d
	.p2align	4
122:
	vmovdqu64	zmm13, zmmword ptr [rax + r8 - 192]
	vmovdqu64	zmm14, zmmword ptr [rax + r8 - 128]
	vmovdqu64	zmm15, zmmword ptr [rax + r8 - 64]
	vmovdqu64	zmm16, zmmword ptr [rax + r8]
	vmovdqu64	zmmword ptr [rcx + r8 + 576], zmm13
	vmovdqu64	zmmword ptr [rcx + r8 + 640], zmm14
	vmovdqu64	zmmword ptr [rcx + r8 + 704], zmm15
	vmovdqu64	zmmword ptr [rcx + r8 + 768], zmm16
	add	r8, 256
	cmp	rbx, r8
	jne	122b
	cmp	rsi, rbx
	mov	r14, qword ptr [rsp + 64]
	mov	r8, qword ptr [rsp + 16]
	je	172f
	test	sil, -16
	je	152f
132:
	mov	rax, rsi
	and	rax, -16
	lea	rdi, [rdx + rax]
	mov	r14, qword ptr [rsp + 64]
	.p2align	4
142:
	vmovdqu	xmm13, xmmword ptr [r11 + rbx]
	vmovdqu	xmmword ptr [r14 + rbx], xmm13
	add	rbx, 16
	cmp	rax, rbx
	jne	142b
	cmp	rsi, rax
	je	172f
	.p2align	4
152:
	mov	rsi, qword ptr [rsp + 64]
	mov	rax, rsi
	sub	rax, rdx
	.p2align	4
162:
	movzx	edx, byte ptr [r9 + rdi]
	mov	byte ptr [rax + rdi], dl
	inc	rdi
	cmp	r12, rdi
	jne	162b
	mov	r14, rsi
172:
	vpbroadcastd	zmm14, r13d
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
	mov	eax, r10d
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
	vpextrd	eax, xmm15, 3
	add	rax, r10
	vmovdqu64	zmmword ptr [rcx + 256], zmm14
	cmp	r8, 17
	mov	r13, qword ptr [rsp + 56]
	jb	422f
	mov	rdx, rax
	shr	rdx, 3
	lea	rsi, [rdx + 64]
	cmp	rsi, r12
	mov	r14, qword ptr [rsp + 64]
	jbe	182f
	mov	rsi, r12
	sub	rsi, rdx
	mov	rbx, r14
	jbe	252f
	cmp	rsi, 16
	mov	rdi, rdx
	jb	232f
	lea	r10, [rdx + r9]
	mov	rdi, rcx
	sub	rdi, r10
	add	rdi, 575
	cmp	rdi, 255
	mov	rdi, rdx
	jb	232f
	cmp	rsi, 256
	jae	192f
	xor	r11d, r11d
	jmp	212f
	.p2align	4
182:
	add	rdx, r9
	mov	rbx, rdx
	jmp	252f
192:
	mov	r11, rsi
	and	r11, -256
	lea	rdi, [rdx + r11]
	lea	rbx, [r9 + rdx + 192]
	xor	r8d, r8d
	.p2align	4
202:
	vmovdqu64	zmm14, zmmword ptr [rbx + r8 - 192]
	vmovdqu64	zmm15, zmmword ptr [rbx + r8 - 128]
	vmovdqu64	zmm16, zmmword ptr [rbx + r8 - 64]
	vmovdqu64	zmm17, zmmword ptr [rbx + r8]
	vmovdqu64	zmmword ptr [rcx + r8 + 576], zmm14
	vmovdqu64	zmmword ptr [rcx + r8 + 640], zmm15
	vmovdqu64	zmmword ptr [rcx + r8 + 704], zmm16
	vmovdqu64	zmmword ptr [rcx + r8 + 768], zmm17
	add	r8, 256
	cmp	r11, r8
	jne	202b
	cmp	rsi, r11
	mov	rbx, r14
	mov	r8, qword ptr [rsp + 16]
	je	252f
	test	sil, -16
	je	232f
212:
	mov	r8, rsi
	and	r8, -16
	lea	rdi, [rdx + r8]
	.p2align	4
222:
	vmovdqu	xmm14, xmmword ptr [r10 + r11]
	vmovdqu	xmmword ptr [r14 + r11], xmm14
	add	r11, 16
	cmp	r8, r11
	jne	222b
	cmp	rsi, r8
	mov	rbx, r14
	mov	r8, qword ptr [rsp + 16]
	je	252f
232:
	mov	rsi, r14
	sub	rsi, rdx
	.p2align	4
242:
	movzx	edx, byte ptr [r9 + rdi]
	mov	byte ptr [rsi + rdi], dl
	inc	rdi
	cmp	r12, rdi
	jne	242b
	mov	rbx, r14
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
	mov	edx, eax
	and	edx, 7
	vpbroadcastd	zmm18, edx
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
	vmovdqu64	zmmword ptr [rcx + 320], zmm13
	vshufi64x2	zmm13, zmm14, zmm14, 255
	vextracti32x4	xmm14, zmm17, 3
	vpextrd	edx, xmm14, 3
	add	rax, rdx
	cmp	r8, 33
	jb	422f
	mov	rdx, rax
	shr	rdx, 3
	lea	rsi, [rdx + 64]
	cmp	rsi, r12
	jbe	262f
	mov	rsi, r12
	sub	rsi, rdx
	mov	rbx, r14
	jbe	332f
	cmp	rsi, 16
	mov	rdi, rdx
	jb	312f
	lea	r10, [rdx + r9]
	mov	rdi, rcx
	sub	rdi, r10
	add	rdi, 575
	cmp	rdi, 255
	mov	rdi, rdx
	jb	312f
	cmp	rsi, 256
	jae	272f
	xor	r11d, r11d
	jmp	292f
262:
	add	rdx, r9
	mov	rbx, rdx
	jmp	332f
272:
	mov	r11, rsi
	and	r11, -256
	lea	rdi, [rdx + r11]
	lea	rbx, [r9 + rdx + 192]
	xor	r8d, r8d
	.p2align	4
282:
	vmovdqu64	zmm14, zmmword ptr [rbx + r8 - 192]
	vmovdqu64	zmm15, zmmword ptr [rbx + r8 - 128]
	vmovdqu64	zmm16, zmmword ptr [rbx + r8 - 64]
	vmovdqu64	zmm17, zmmword ptr [rbx + r8]
	vmovdqu64	zmmword ptr [rcx + r8 + 576], zmm14
	vmovdqu64	zmmword ptr [rcx + r8 + 640], zmm15
	vmovdqu64	zmmword ptr [rcx + r8 + 704], zmm16
	vmovdqu64	zmmword ptr [rcx + r8 + 768], zmm17
	add	r8, 256
	cmp	r11, r8
	jne	282b
	cmp	rsi, r11
	mov	rbx, r14
	mov	r8, qword ptr [rsp + 16]
	je	332f
	test	sil, -16
	je	312f
292:
	mov	r8, rsi
	and	r8, -16
	lea	rdi, [rdx + r8]
	.p2align	4
302:
	vmovdqu	xmm14, xmmword ptr [r10 + r11]
	vmovdqu	xmmword ptr [r14 + r11], xmm14
	add	r11, 16
	cmp	r8, r11
	jne	302b
	cmp	rsi, r8
	mov	rbx, r14
	mov	r8, qword ptr [rsp + 16]
	je	332f
312:
	mov	rsi, r14
	sub	rsi, rdx
	.p2align	4
322:
	movzx	edx, byte ptr [r9 + rdi]
	mov	byte ptr [rsi + rdi], dl
	inc	rdi
	cmp	r12, rdi
	jne	322b
	mov	rbx, r14
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
	mov	edx, eax
	and	edx, 7
	vpbroadcastd	zmm18, edx
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
	vmovdqu64	zmmword ptr [rcx + 384], zmm13
	vshufi64x2	zmm13, zmm14, zmm14, 255
	vextracti32x4	xmm14, zmm17, 3
	vpextrd	edx, xmm14, 3
	add	rax, rdx
	cmp	r8, 49
	jb	422f
	mov	rdx, rax
	shr	rdx, 3
	lea	rsi, [rdx + 64]
	cmp	rsi, r12
	jbe	342f
	mov	rsi, r12
	sub	rsi, rdx
	mov	r11, r14
	jbe	412f
	cmp	rsi, 16
	mov	rdi, rdx
	jb	392f
	lea	r8, [rdx + r9]
	mov	rdi, rcx
	sub	rdi, r8
	add	rdi, 575
	cmp	rdi, 255
	mov	rdi, rdx
	jb	392f
	cmp	rsi, 256
	jae	352f
	xor	r10d, r10d
	jmp	372f
342:
	add	r9, rdx
	mov	r11, r9
	jmp	412f
352:
	mov	r10, rsi
	and	r10, -256
	lea	rdi, [rdx + r10]
	lea	r11, [r9 + rdx + 192]
	xor	ebx, ebx
	.p2align	4
362:
	vmovdqu64	zmm14, zmmword ptr [r11 + rbx - 192]
	vmovdqu64	zmm15, zmmword ptr [r11 + rbx - 128]
	vmovdqu64	zmm16, zmmword ptr [r11 + rbx - 64]
	vmovdqu64	zmm17, zmmword ptr [r11 + rbx]
	vmovdqu64	zmmword ptr [rcx + rbx + 576], zmm14
	vmovdqu64	zmmword ptr [rcx + rbx + 640], zmm15
	vmovdqu64	zmmword ptr [rcx + rbx + 704], zmm16
	vmovdqu64	zmmword ptr [rcx + rbx + 768], zmm17
	add	rbx, 256
	cmp	r10, rbx
	jne	362b
	cmp	rsi, r10
	mov	r11, r14
	je	412f
	test	sil, -16
	je	392f
372:
	mov	r11, rsi
	and	r11, -16
	lea	rdi, [rdx + r11]
	.p2align	4
382:
	vmovdqu	xmm14, xmmword ptr [r8 + r10]
	vmovdqu	xmmword ptr [r14 + r10], xmm14
	add	r10, 16
	cmp	r11, r10
	jne	382b
	cmp	rsi, r11
	mov	r11, r14
	je	412f
392:
	mov	rsi, r14
	sub	rsi, rdx
	.p2align	4
402:
	movzx	edx, byte ptr [r9 + rdi]
	mov	byte ptr [rsi + rdi], dl
	inc	rdi
	cmp	r12, rdi
	jne	402b
	mov	r11, r14
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
	mov	edx, eax
	and	edx, 7
	vpbroadcastd	zmm17, edx
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
	vmovdqu64	zmmword ptr [rcx + 448], zmm13
	vshufi64x2	zmm13, zmm12, zmm12, 255
	vextracti32x4	xmm12, zmm16, 3
	vpextrd	edx, xmm12, 3
	add	rax, rdx
	.p2align	4
422:
	mov	r8, qword ptr [rsp + 32]
	kmovq	rdx, k2
	popcnt	rdx, rdx
	add	rdx, qword ptr [rsp + 88]
	kmovq	rsi, k1
	popcnt	rsi, rsi
	add	rsi, qword ptr [rsp + 24]
	vmovd	edi, xmm13
	mov	qword ptr [rcx + 72], rax
	mov	qword ptr [rcx + 96], rdi
	mov	qword ptr [rcx + 128], rsi
	mov	qword ptr [rcx + 136], rdx
	mov	rax, qword ptr [rsp + 8]
	add	rax, qword ptr [rsp + 136]
	mov	qword ptr [rsp + 8], rax
	mov	rax, r8
	and	rax, 124
	mov	r12, qword ptr [rsp + 72]
	je	802f
	xor	r8d, r8d
	.p2align	4
432:
	mov	r14, qword ptr [rsp + 8]
	movzx	esi, byte ptr [r14 + r8]
	movzx	ebx, byte ptr [rcx + r8 + 192]
	cmp	rbx, 33
	mov	edx, dword ptr [rcx + 4*r8 + 256]
	vmovdqu	ymm12, ymmword ptr [r12 + r15]
	vmovdqu	ymmword ptr [r13 + rbp], ymm12
	jae	562f
442:
	lea	r9, [rbx + rbp]
	mov	r10d, esi
	shr	r10d, 2
	cmp	edx, r10d
	mov	qword ptr [rsp + 24], rbx
	jb	642f
	mov	rdi, r9
	sub	rdi, rdx
	jb	642f
452:
	vmovdqu	ymm12, ymmword ptr [r13 + rdi]
	vmovdqu	ymmword ptr [r13 + r9], ymm12
	cmp	sil, -124
	jae	652f
462:
	lea	rdx, [r8 + 1]
	mov	qword ptr [rsp + 48], r15
	lea	r11, [rbx + r15]
	add	r9, r10
	movzx	esi, byte ptr [r14 + rdx]
	movzx	ebx, byte ptr [rcx + rdx + 192]
	cmp	rbx, 33
	mov	edx, dword ptr [rcx + 4*rdx + 256]
	vmovdqu	ymm12, ymmword ptr [r12 + r11]
	vmovdqu	ymmword ptr [r13 + r9], ymm12
	jae	582f
472:
	add	r9, rbx
	mov	r15d, esi
	shr	r15d, 2
	cmp	edx, r15d
	mov	qword ptr [rsp + 40], rbp
	jb	682f
	mov	rdi, r9
	sub	rdi, rdx
	jb	682f
482:
	vmovdqu	ymm12, ymmword ptr [r13 + rdi]
	vmovdqu	ymmword ptr [r13 + r9], ymm12
	cmp	sil, -124
	jae	692f
492:
	lea	rdx, [r8 + 2]
	add	r11, rbx
	add	r9, r15
	movzx	edi, byte ptr [r14 + rdx]
	movzx	ebp, byte ptr [rcx + rdx + 192]
	cmp	rbp, 33
	mov	esi, dword ptr [rcx + 4*rdx + 256]
	vmovdqu	ymm12, ymmword ptr [r12 + r11]
	vmovdqu	ymmword ptr [r13 + r9], ymm12
	jae	602f
502:
	add	r9, rbp
	mov	edx, edi
	shr	edx, 2
	cmp	esi, edx
	jb	722f
	mov	r14, r9
	sub	r14, rsi
	jb	722f
512:
	vmovdqu	ymm12, ymmword ptr [r13 + r14]
	vmovdqu	ymmword ptr [r13 + r9], ymm12
	cmp	dil, -124
	jae	732f
522:
	lea	rdi, [r8 + 3]
	add	r11, rbp
	add	r9, rdx
	mov	rsi, qword ptr [rsp + 8]
	movzx	r12d, byte ptr [rsi + rdi]
	movzx	esi, byte ptr [rcx + rdi + 192]
	cmp	rsi, 33
	mov	ecx, dword ptr [rcx + 4*rdi + 256]
	mov	rdi, qword ptr [rsp + 72]
	vmovdqu	ymm12, ymmword ptr [rdi + r11]
	vmovdqu	ymmword ptr [r13 + r9], ymm12
	jae	622f
532:
	add	r9, rsi
	mov	r14d, r12d
	shr	r14d, 2
	cmp	ecx, r14d
	jb	762f
	mov	r13, r9
	sub	r13, rcx
	jb	762f
542:
	mov	rdi, qword ptr [rsp + 56]
	vmovdqu	ymm12, ymmword ptr [rdi + r13]
	vmovdqu	ymmword ptr [rdi + r9], ymm12
	cmp	r12b, -124
	jae	772f
552:
	add	rsi, r11
	add	r14, r9
	add	r8, 4
	cmp	r8, rax
	mov	r15, rsi
	mov	rbp, r14
	mov	rcx, qword ptr [rsp]
	mov	r13, qword ptr [rsp + 56]
	mov	r12, qword ptr [rsp + 72]
	jb	432b
	jmp	812f
562:
	lea	rdi, [r12 + r15]
	lea	r9, [r13 + rbp]
	mov	r10, qword ptr [rcx + 48]
	mov	r11, qword ptr [rcx + 120]
	movzx	ebx, byte ptr [r10 + r11]
	inc	r11
	mov	qword ptr [rcx + 120], r11
	add	rbx, 33
	mov	r10d, 32
	.p2align	4
572:
	vmovdqu	ymm12, ymmword ptr [rdi + r10]
	vmovdqu	ymmword ptr [r9 + r10], ymm12
	add	r10, 32
	cmp	r10, rbx
	jb	572b
	jmp	442b
582:
	lea	rdi, [r12 + r11]
	mov	rbx, qword ptr [rcx + 48]
	mov	r14, qword ptr [rcx + 120]
	movzx	ebx, byte ptr [rbx + r14]
	inc	r14
	mov	qword ptr [rcx + 120], r14
	add	rbx, 33
	lea	r14, [r13 + r9]
	mov	r15d, 32
	.p2align	4
592:
	vmovdqu	ymm12, ymmword ptr [rdi + r15]
	vmovdqu	ymmword ptr [r14 + r15], ymm12
	add	r15, 32
	cmp	r15, rbx
	jb	592b
	mov	r14, qword ptr [rsp + 8]
	jmp	472b
602:
	mov	rdx, qword ptr [rcx + 48]
	mov	r14, qword ptr [rcx + 120]
	movzx	ebp, byte ptr [rdx + r14]
	inc	r14
	mov	qword ptr [rcx + 120], r14
	add	rbp, 33
	mov	rdx, qword ptr [rsp + 24]
	lea	r14, [r10 + rdx]
	lea	rdx, [r15 + rbx]
	add	rdx, r14
	add	rdx, qword ptr [rsp + 40]
	add	rdx, r13
	lea	r14, [r12 + r11]
	mov	r12d, 32
	.p2align	4
612:
	vmovdqu	ymm12, ymmword ptr [r14 + r12]
	vmovdqu	ymmword ptr [rdx + r12], ymm12
	add	r12, 32
	cmp	r12, rbp
	jb	612b
	jmp	502b
622:
	mov	rdi, qword ptr [rsp]
	mov	rsi, qword ptr [rdi + 48]
	mov	r14, qword ptr [rdi + 120]
	movzx	esi, byte ptr [rsi + r14]
	inc	r14
	mov	qword ptr [rdi + 120], r14
	add	rsi, 33
	mov	rdi, qword ptr [rsp + 24]
	lea	r13, [rdx + rbp]
	add	r13, r10
	add	r13, rdi
	lea	r14, [r15 + rbx]
	add	r14, qword ptr [rsp + 40]
	add	r14, r13
	add	r14, qword ptr [rsp + 56]
	lea	r13, [rbx + rdi]
	mov	rdi, qword ptr [rsp + 48]
	add	rdi, rbp
	add	rdi, r13
	add	rdi, qword ptr [rsp + 72]
	mov	r13d, 32
	.p2align	4
632:
	vmovdqu	ymm12, ymmword ptr [rdi + r13]
	vmovdqu	ymmword ptr [r14 + r13], ymm12
	add	r13, 32
	cmp	r13, rsi
	jb	632b
	jmp	532b
642:
	cmp	rdx, r9
	cmovae	rdx, r9
	mov	rdi, r9
	sub	rdi, rdx
	cmp	rdx, r10
	jae	452b
	mov	r11, qword ptr [rcx + 56]
	mov	qword ptr [rsp + 48], r11
	mov	rbx, rdx
	shl	rbx, 5
	mov	r11, qword ptr [rsp + 48]
	vmovdqu	ymm12, ymmword ptr [r11 + rbx + 2048]
	mov	rbx, qword ptr [rsp + 24]
	vpermb	ymm12, ymm12, ymmword ptr [r13 + rdi]
	vmovdqu	ymmword ptr [r13 + r9], ymm12
	cmp	sil, -124
	jb	462b
652:
	cmp	rdx, 31
	ja	662f
	mov	qword ptr [rcx + 104], 1
662:
	lea	rdx, [r13 + r9]
	mov	rsi, qword ptr [rcx + 48]
	mov	r11, qword ptr [rcx + 120]
	movzx	r10d, byte ptr [rsi + r11]
	inc	r11
	mov	qword ptr [rcx + 120], r11
	add	r10, 33
	add	rdi, r13
	mov	esi, 32
	.p2align	4
672:
	vmovdqu	ymm12, ymmword ptr [rdi + rsi]
	vmovdqu	ymmword ptr [rdx + rsi], ymm12
	add	rsi, 32
	cmp	rsi, r10
	jb	672b
	jmp	462b
682:
	cmp	rdx, r9
	cmovae	rdx, r9
	mov	rdi, r9
	sub	rdi, rdx
	cmp	rdx, r15
	jae	482b
	mov	r14, qword ptr [rcx + 56]
	mov	r12, rdx
	shl	r12, 5
	vmovdqu	ymm12, ymmword ptr [r14 + r12 + 2048]
	mov	r14, qword ptr [rsp + 8]
	mov	r12, qword ptr [rsp + 72]
	vpermb	ymm12, ymm12, ymmword ptr [r13 + rdi]
	vmovdqu	ymmword ptr [r13 + r9], ymm12
	cmp	sil, -124
	jb	492b
692:
	cmp	rdx, 31
	ja	702f
	mov	qword ptr [rcx + 104], 1
702:
	mov	rdx, qword ptr [rcx + 48]
	mov	rsi, qword ptr [rcx + 120]
	movzx	r15d, byte ptr [rdx + rsi]
	inc	rsi
	mov	qword ptr [rcx + 120], rsi
	add	r15, 33
	add	rdi, r13
	mov	rdx, qword ptr [rsp + 24]
	lea	rsi, [r10 + rdx]
	mov	rdx, qword ptr [rsp + 40]
	add	rdx, rbx
	add	rdx, rsi
	add	rdx, r13
	mov	esi, 32
	.p2align	4
712:
	vmovdqu	ymm12, ymmword ptr [rdi + rsi]
	vmovdqu	ymmword ptr [rdx + rsi], ymm12
	add	rsi, 32
	cmp	rsi, r15
	jb	712b
	jmp	492b
722:
	cmp	rsi, r9
	cmovae	rsi, r9
	mov	r14, r9
	sub	r14, rsi
	cmp	rsi, rdx
	jae	512b
	mov	r12, qword ptr [rcx + 56]
	mov	r13, rsi
	shl	r13, 5
	vmovdqu	ymm12, ymmword ptr [r12 + r13 + 2048]
	mov	r13, qword ptr [rsp + 56]
	vpermb	ymm12, ymm12, ymmword ptr [r13 + r14]
	vmovdqu	ymmword ptr [r13 + r9], ymm12
	cmp	dil, -124
	jb	522b
732:
	cmp	rsi, 31
	ja	742f
	mov	qword ptr [rcx + 104], 1
742:
	mov	rdx, qword ptr [rcx + 48]
	mov	rsi, qword ptr [rcx + 120]
	movzx	edx, byte ptr [rdx + rsi]
	inc	rsi
	mov	qword ptr [rcx + 120], rsi
	add	rdx, 33
	add	r14, r13
	mov	rsi, qword ptr [rsp + 24]
	lea	rdi, [r10 + rsi]
	lea	rsi, [rbp + r15]
	add	rsi, rdi
	mov	rdi, qword ptr [rsp + 40]
	add	rdi, rbx
	add	rsi, rdi
	add	rsi, r13
	mov	edi, 32
	.p2align	4
752:
	vmovdqu	ymm12, ymmword ptr [r14 + rdi]
	vmovdqu	ymmword ptr [rsi + rdi], ymm12
	add	rdi, 32
	cmp	rdi, rdx
	jb	752b
	jmp	522b
762:
	cmp	rcx, r9
	cmovae	rcx, r9
	mov	r13, r9
	sub	r13, rcx
	cmp	rcx, r14
	jae	542b
	mov	rdi, qword ptr [rsp]
	mov	rdi, qword ptr [rdi + 56]
	mov	qword ptr [rsp + 48], rdi
	mov	rdi, rcx
	shl	rdi, 5
	mov	qword ptr [rsp + 88], rbx
	mov	rbx, qword ptr [rsp + 48]
	vmovdqu	ymm12, ymmword ptr [rbx + rdi + 2048]
	mov	rbx, qword ptr [rsp + 88]
	mov	rdi, qword ptr [rsp + 56]
	vpermb	ymm12, ymm12, ymmword ptr [rdi + r13]
	vmovdqu	ymmword ptr [rdi + r9], ymm12
	cmp	r12b, -124
	jb	552b
772:
	cmp	rcx, 31
	mov	rcx, qword ptr [rsp]
	ja	782f
	mov	qword ptr [rcx + 104], 1
782:
	mov	r12, rcx
	mov	rcx, qword ptr [rcx + 48]
	mov	rdi, qword ptr [r12 + 120]
	movzx	r14d, byte ptr [rcx + rdi]
	inc	rdi
	mov	qword ptr [r12 + 120], rdi
	add	r14, 33
	mov	rcx, qword ptr [rsp + 56]
	add	r13, rcx
	add	r10, qword ptr [rsp + 24]
	add	rdx, rsi
	add	rdx, r10
	add	rbp, r15
	add	rbp, rbx
	add	rbp, rdx
	add	rbp, qword ptr [rsp + 40]
	add	rbp, rcx
	mov	edx, 32
	.p2align	4
792:
	vmovdqu	ymm12, ymmword ptr [r13 + rdx]
	vmovdqu	ymmword ptr [rbp + rdx], ymm12
	add	rdx, 32
	cmp	rdx, r14
	jb	792b
	jmp	552b
	.p2align	4
802:
	mov	r14, rbp
	mov	rsi, r15
812:
	mov	r10, qword ptr [rsp + 32]
	cmp	rax, r10
	mov	rbp, r14
	mov	r11, rsi
	mov	r14, qword ptr [rsp + 80]
	je	2b
	.p2align	4
822:
	mov	rdx, qword ptr [rsp + 8]
	movzx	edi, byte ptr [rdx + rax]
	movzx	edx, byte ptr [rcx + rax + 192]
	cmp	rdx, 33
	mov	esi, dword ptr [rcx + 4*rax + 256]
	vmovdqu	ymm12, ymmword ptr [r12 + r11]
	vmovdqu	ymmword ptr [r13 + rbp], ymm12
	jae	862f
832:
	add	rbp, rdx
	mov	r8d, edi
	shr	r8d, 2
	cmp	esi, r8d
	jb	882f
	mov	r9, rbp
	sub	r9, rsi
	jb	882f
842:
	vmovdqu	ymm12, ymmword ptr [r13 + r9]
	vmovdqu	ymmword ptr [r13 + rbp], ymm12
	cmp	dil, -124
	jae	892f
852:
	add	r11, rdx
	add	rbp, r8
	inc	rax
	cmp	rax, r10
	jb	822b
	jmp	2b
862:
	lea	r8, [r12 + r11]
	lea	r9, [r13 + rbp]
	mov	rcx, qword ptr [rsp]
	mov	rcx, qword ptr [rcx + 48]
	mov	rdx, qword ptr [rsp]
	mov	r10, qword ptr [rdx + 120]
	movzx	edx, byte ptr [rcx + r10]
	mov	rcx, qword ptr [rsp]
	inc	r10
	mov	qword ptr [rcx + 120], r10
	add	rdx, 33
	mov	r10d, 32
	.p2align	4
872:
	vmovdqu	ymm12, ymmword ptr [r8 + r10]
	vmovdqu	ymmword ptr [r9 + r10], ymm12
	add	r10, 32
	cmp	r10, rdx
	jb	872b
	mov	r10, qword ptr [rsp + 32]
	jmp	832b
882:
	cmp	rsi, rbp
	cmovae	rsi, rbp
	mov	r9, rbp
	sub	r9, rsi
	cmp	rsi, r8
	jae	842b
	mov	rcx, qword ptr [rsp]
	mov	rcx, qword ptr [rcx + 56]
	mov	r10, rsi
	shl	r10, 5
	vmovdqu	ymm12, ymmword ptr [rcx + r10 + 2048]
	mov	r10, qword ptr [rsp + 32]
	mov	rcx, qword ptr [rsp]
	vpermb	ymm12, ymm12, ymmword ptr [r13 + r9]
	vmovdqu	ymmword ptr [r13 + rbp], ymm12
	cmp	dil, -124
	jb	852b
892:
	cmp	rsi, 31
	ja	902f
	mov	qword ptr [rcx + 104], 1
902:
	lea	rsi, [r13 + rbp]
	mov	rcx, qword ptr [rsp]
	mov	rcx, qword ptr [rcx + 48]
	mov	rdi, qword ptr [rsp]
	mov	rdi, qword ptr [rdi + 120]
	movzx	r8d, byte ptr [rcx + rdi]
	mov	rcx, qword ptr [rsp]
	inc	rdi
	mov	qword ptr [rcx + 120], rdi
	add	r8, 33
	add	r9, r13
	mov	edi, 32
	.p2align	4
912:
	vmovdqu	ymm12, ymmword ptr [r9 + rdi]
	vmovdqu	ymmword ptr [rsi + rdi], ymm12
	add	rdi, 32
	cmp	rdi, r8
	jb	912b
	jmp	852b
922:
	mov	qword ptr [rcx + 80], rbp
	mov	qword ptr [rcx + 88], r11
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
932:
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
942:
	.byte	2
	.p2align	6, 0x0
952:
	.byte	1
	.p2align	2, 0x0
962:
	.long	1
	.p2align	2, 0x0
972:
	.long	7
	.p2align	2, 0x0
982:
	.long	8
	.p2align	4, 0x0
992:
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
1002:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.p2align	6, 0x0
1012:
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
1022:
	.long	134217727

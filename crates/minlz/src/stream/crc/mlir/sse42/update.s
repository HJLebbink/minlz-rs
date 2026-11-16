# minlz_crc32c_update of crates/minlz/mlir/crc32c_chains.mlir for sse42, written by
# cargo xtask mlir. Do not edit.
	push	r15
	push	r14
	push	r12
	push	rbx
	mov	rcx, rdx
	movabs	rdx, -6148914691236517205
	mov	rax, rcx
	mul	rdx
	shr	rdx, 11
	mov	rax, rdx
	shl	rax, 10
	lea	r9, [rax + 2*rax]
	mov	r8, rcx
	sub	r8, r9
	mov	r11d, edi
	cmp	rcx, 3072
	jb	22f
	lea	rax, [rsi + 2048]
	xor	edi, edi
	.p2align	4
2:
	mov	r14, -8
	xor	r10d, r10d
	xor	ebx, ebx
	.p2align	4
12:
	crc32	r11, qword ptr [rax + r14 - 2040]
	crc32	rbx, qword ptr [rax + r14 - 1016]
	crc32	r10, qword ptr [rax + r14 + 8]
	add	r14, 8
	cmp	r14, 1016
	jb	12b
	lea	r14, [r11 + r11]
	lea	r15, [8*r11]
	xor	r15, r14
	mov	r14, r11
	shl	r14, 4
	mov	r12, r11
	shl	r12, 5
	xor	r12, r14
	xor	r12, r15
	mov	r14, r11
	shl	r14, 6
	mov	r15, r11
	shl	r15, 7
	xor	r15, r14
	mov	r14, r11
	shl	r14, 9
	xor	r14, r15
	xor	r14, r12
	mov	r15, r11
	shl	r15, 10
	mov	r12, r11
	shl	r12, 12
	xor	r12, r15
	mov	r15, r11
	shl	r15, 13
	xor	r15, r12
	mov	r12, r11
	shl	r12, 14
	xor	r12, r15
	xor	r12, r14
	mov	r14, r11
	shl	r14, 24
	mov	r15, r11
	shl	r15, 25
	xor	r15, r14
	mov	r14, r11
	shl	r14, 26
	xor	r14, r15
	shl	r11, 28
	xor	r11, r14
	xor	r11, r12
	xor	r14d, r14d
	crc32	r14, r11
	xor	r14, rbx
	lea	r11, [r14 + r14]
	lea	rbx, [8*r14]
	xor	rbx, r11
	mov	r11, r14
	shl	r11, 4
	mov	r15, r14
	shl	r15, 5
	xor	r15, r11
	xor	r15, rbx
	mov	r11, r14
	shl	r11, 6
	mov	rbx, r14
	shl	rbx, 7
	xor	rbx, r11
	mov	r11, r14
	shl	r11, 9
	xor	r11, rbx
	xor	r11, r15
	mov	rbx, r14
	shl	rbx, 10
	mov	r15, r14
	shl	r15, 12
	xor	r15, rbx
	mov	rbx, r14
	shl	rbx, 13
	xor	rbx, r15
	mov	r15, r14
	shl	r15, 14
	xor	r15, rbx
	xor	r15, r11
	mov	r11, r14
	shl	r11, 24
	mov	rbx, r14
	shl	rbx, 25
	xor	rbx, r11
	mov	r11, r14
	shl	r11, 26
	xor	r11, rbx
	shl	r14, 28
	xor	r14, r11
	xor	r14, r15
	xor	r11d, r11d
	crc32	r11, r14
	xor	r11, r10
	inc	rdi
	add	rax, 3072
	cmp	rdi, rdx
	jne	2b
22:
	and	r8, -64
	add	r8, r9
	mov	eax, r11d
	cmp	r9, r8
	jge	42f
	.p2align	4
32:
	crc32	rax, qword ptr [rsi + r9]
	crc32	rax, qword ptr [rsi + r9 + 8]
	crc32	rax, qword ptr [rsi + r9 + 16]
	crc32	rax, qword ptr [rsi + r9 + 24]
	crc32	rax, qword ptr [rsi + r9 + 32]
	crc32	rax, qword ptr [rsi + r9 + 40]
	crc32	rax, qword ptr [rsi + r9 + 48]
	crc32	rax, qword ptr [rsi + r9 + 56]
	add	r9, 64
	cmp	r9, r8
	jl	32b
42:
	test	cl, 32
	jne	112f
	test	cl, 16
	jne	122f
52:
	test	cl, 8
	jne	132f
62:
	test	cl, 4
	jne	142f
72:
	test	cl, 2
	jne	152f
82:
	test	cl, 1
	je	102f
92:
	crc32	eax, byte ptr [rsi + r8]
102:
	pop	rbx
	pop	r12
	pop	r14
	pop	r15
	ret
112:
	crc32	rax, qword ptr [rsi + r8]
	crc32	rax, qword ptr [rsi + r8 + 8]
	crc32	rax, qword ptr [rsi + r8 + 16]
	crc32	rax, qword ptr [rsi + r8 + 24]
	or	r8, 32
	test	cl, 16
	je	52b
122:
	crc32	rax, qword ptr [rsi + r8]
	crc32	rax, qword ptr [rsi + r8 + 8]
	add	r8, 16
	test	cl, 8
	je	62b
132:
	crc32	rax, qword ptr [rsi + r8]
	add	r8, 8
	test	cl, 4
	je	72b
142:
	crc32	eax, dword ptr [rsi + r8]
	add	r8, 4
	test	cl, 2
	je	82b
152:
	crc32	eax, word ptr [rsi + r8]
	add	r8, 2
	test	cl, 1
	jne	92b
	jmp	102b

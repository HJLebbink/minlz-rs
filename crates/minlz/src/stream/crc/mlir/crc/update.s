// minlz_crc32c_update of crates/minlz/mlir/crc32c_chains.mlir for crc, written by
// cargo xtask mlir. Do not edit.
	mov	x8, #-6148914691236517206
	movk	x8, #43691
	umulh	x8, x2, x8
	lsr	x8, x8, #11
	cmp	x2, #3072
	b.lo	22f
	mov	x9, xzr
	mov	x10, x1
	.p2align	5, , 16
2:
	mov	x13, #-8
	mov	w11, wzr
	mov	w12, wzr
	mov	x14, x10
	.p2align	5, , 16
12:
	ldp	x15, x16, [x14]
	ldr	x17, [x14, #1024]
	add	x13, x13, #32
	crc32cx	w15, w0, x15
	ldr	x0, [x14, #2048]
	crc32cx	w12, w12, x17
	ldr	x17, [x14, #1032]
	crc32cx	w15, w15, x16
	ldr	x16, [x14, #1040]
	crc32cx	w11, w11, x0
	ldr	x0, [x14, #2056]
	crc32cx	w12, w12, x17
	crc32cx	w12, w12, x16
	ldr	x16, [x14, #1048]
	crc32cx	w11, w11, x0
	ldp	x17, x0, [x14, #16]
	crc32cx	w12, w12, x16
	crc32cx	w15, w15, x17
	ldr	x17, [x14, #2064]
	crc32cx	w0, w15, x0
	crc32cx	w11, w11, x17
	ldr	x17, [x14, #2072]
	add	x14, x14, #32
	crc32cx	w11, w11, x17
	cmp	x13, #1016
	b.lo	12b
	ubfiz	x13, x0, #3, #32
	add	x9, x9, #1
	add	x10, x10, #3072
	eor	x13, x13, x0, lsl #1
	eor	x13, x13, x0, lsl #4
	eor	x13, x13, x0, lsl #5
	eor	x13, x13, x0, lsl #6
	eor	x13, x13, x0, lsl #7
	eor	x13, x13, x0, lsl #9
	eor	x13, x13, x0, lsl #10
	eor	x13, x13, x0, lsl #12
	eor	x13, x13, x0, lsl #13
	eor	x13, x13, x0, lsl #14
	eor	x13, x13, x0, lsl #24
	eor	x13, x13, x0, lsl #25
	eor	x13, x13, x0, lsl #26
	eor	x13, x13, x0, lsl #28
	crc32cx	w13, wzr, x13
	eor	w12, w13, w12
	ubfiz	x13, x12, #3, #32
	eor	x13, x13, x12, lsl #1
	eor	x13, x13, x12, lsl #4
	eor	x13, x13, x12, lsl #5
	eor	x13, x13, x12, lsl #6
	eor	x13, x13, x12, lsl #7
	eor	x13, x13, x12, lsl #9
	eor	x13, x13, x12, lsl #10
	eor	x13, x13, x12, lsl #12
	eor	x13, x13, x12, lsl #13
	eor	x13, x13, x12, lsl #14
	eor	x13, x13, x12, lsl #24
	eor	x13, x13, x12, lsl #25
	eor	x13, x13, x12, lsl #26
	eor	x12, x13, x12, lsl #28
	crc32cx	w12, wzr, x12
	eor	w0, w12, w11
	cmp	x9, x8
	b.ne	2b
22:
	add	x8, x8, x8, lsl #1
	lsl	x9, x8, #10
	sub	x8, x2, x9
	and	x8, x8, #0xffffffffffffffc0
	add	x8, x8, x9
	cmp	x9, x8
	b.ge	42f
	.p2align	5, , 16
32:
	add	x10, x1, x9
	add	x9, x9, #64
	ldp	x11, x12, [x10]
	crc32cx	w11, w0, x11
	crc32cx	w11, w11, x12
	ldp	x12, x13, [x10, #16]
	crc32cx	w11, w11, x12
	crc32cx	w11, w11, x13
	ldp	x12, x13, [x10, #32]
	crc32cx	w11, w11, x12
	ldp	x12, x10, [x10, #48]
	crc32cx	w11, w11, x13
	crc32cx	w11, w11, x12
	crc32cx	w0, w11, x10
	cmp	x9, x8
	b.lt	32b
42:
	tbnz	w2, #5, 102f
	tbnz	w2, #4, 112f
52:
	tbnz	w2, #3, 122f
62:
	tbnz	w2, #2, 132f
72:
	tbnz	w2, #1, 142f
82:
	tbnz	w2, #0, 152f
92:
	ret
102:
	add	x9, x1, x8
	orr	x8, x8, #0x20
	ldp	x10, x11, [x9]
	crc32cx	w10, w0, x10
	crc32cx	w10, w10, x11
	ldp	x11, x9, [x9, #16]
	crc32cx	w10, w10, x11
	crc32cx	w0, w10, x9
	tbz	w2, #4, 52b
112:
	add	x9, x1, x8
	add	x8, x8, #16
	ldp	x10, x9, [x9]
	crc32cx	w10, w0, x10
	crc32cx	w0, w10, x9
	tbz	w2, #3, 62b
122:
	ldr	x9, [x1, x8]
	add	x8, x8, #8
	crc32cx	w0, w0, x9
	tbz	w2, #2, 72b
132:
	ldr	w9, [x1, x8]
	add	x8, x8, #4
	crc32cw	w0, w0, w9
	tbz	w2, #1, 82b
142:
	ldrh	w9, [x1, x8]
	add	x8, x8, #2
	crc32ch	w0, w0, w9
	tbz	w2, #0, 92b
152:
	ldrb	w8, [x1, x8]
	crc32cb	w0, w0, w8
	ret

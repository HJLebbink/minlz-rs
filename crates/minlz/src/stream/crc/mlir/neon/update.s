// minlz_crc32c_update of crates/minlz/mlir/crc32c_fold.mlir for neon, written by
// cargo xtask mlir. Do not edit.
	cmp	x2, #2048
	b.lo	42f
	stp	d9, d8, [sp, #-48]!
	mov	x15, #9363
	mov	x11, #129012227637248
	lsr	x14, x2, #8
	mov	x16, #23360327122944
	mov	x9, #196009422487552
	mov	x12, #110939005255680
	movk	x15, #37449, lsl #16
	movk	x11, #61186, lsl #48
	movk	x16, #29719, lsl #48
	movk	x9, #25975, lsl #48
	mov	x13, #6588479832064
	movk	x12, #50743, lsl #48
	movk	x15, #18724, lsl #32
	fmov	d1, x11
	fmov	d17, x9
	dup	v4.2d, x16
	mov	x16, #177863185661952
	movk	x13, #30797, lsl #48
	movk	x15, #9362, lsl #48
	and	x8, x2, #0xffffffffffffff80
	movk	x16, #15808, lsl #48
	str	x21, [sp, #16]
	mov	x10, xzr
	umulh	x14, x14, x15
	mov	w15, w0
	fmov	d0, x15
	add	x15, x1, #1024
	stp	x20, x19, [sp, #32]
	movi	v6.2d, #0000000000000000
	mov	x17, x1
	movi	v7.2d, #0000000000000000
	movi	v5.2d, #0000000000000000
	movi	v3.2d, #0000000000000000
	movi	v2.2d, #0000000000000000
	pmull	v16.1q, v0.1d, v1.1d
	movi	v1.2d, #0000000000000000
	movi	v0.2d, #0000000000000000
	.p2align	5, , 16
2:
	mov	w4, #8
	mov	w7, wzr
	mov	w6, wzr
	mov	w5, wzr
	mov	x0, x15
	mov	x3, x17
	.p2align	5, , 16
12:
	ldp	q19, q18, [x3, #96]
	ldp	q21, q20, [x3, #64]
	ldp	q23, q22, [x3, #32]
	pmull	v26.1q, v16.1d, v17.1d
	pmull2	v16.1q, v16.2d, v4.2d
	subs	x4, x4, #1
	ldp	q25, q24, [x3], #128
	ldp	x19, x20, [x0]
	eor	v16.16b, v16.16b, v26.16b
	crc32cx	w5, w5, x19
	ldp	x19, x21, [x0, #256]
	crc32cx	w5, w5, x20
	eor	v16.16b, v25.16b, v16.16b
	pmull	v25.1q, v6.1d, v17.1d
	pmull2	v6.1q, v6.2d, v4.2d
	eor	v6.16b, v6.16b, v25.16b
	crc32cx	w6, w6, x19
	ldr	x19, [x0, #512]
	crc32cx	w6, w6, x21
	eor	v6.16b, v24.16b, v6.16b
	pmull	v24.1q, v7.1d, v17.1d
	pmull2	v7.1q, v7.2d, v4.2d
	eor	v7.16b, v7.16b, v24.16b
	crc32cx	w7, w7, x19
	ldr	x19, [x0, #520]
	eor	v7.16b, v23.16b, v7.16b
	pmull	v23.1q, v5.1d, v17.1d
	pmull2	v5.1q, v5.2d, v4.2d
	eor	v5.16b, v5.16b, v23.16b
	crc32cx	w7, w7, x19
	ldp	x19, x20, [x0, #16]
	eor	v5.16b, v22.16b, v5.16b
	pmull	v22.1q, v3.1d, v17.1d
	pmull2	v3.1q, v3.2d, v4.2d
	eor	v3.16b, v3.16b, v22.16b
	crc32cx	w5, w5, x19
	ldp	x19, x21, [x0, #272]
	crc32cx	w5, w5, x20
	eor	v3.16b, v21.16b, v3.16b
	pmull	v21.1q, v2.1d, v17.1d
	pmull2	v2.1q, v2.2d, v4.2d
	eor	v2.16b, v2.16b, v21.16b
	crc32cx	w6, w6, x19
	ldr	x19, [x0, #528]
	crc32cx	w6, w6, x21
	eor	v2.16b, v20.16b, v2.16b
	pmull	v20.1q, v1.1d, v17.1d
	pmull2	v1.1q, v1.2d, v4.2d
	eor	v1.16b, v1.16b, v20.16b
	crc32cx	w7, w7, x19
	ldr	x19, [x0, #536]
	add	x0, x0, #32
	eor	v1.16b, v19.16b, v1.16b
	pmull	v19.1q, v0.1d, v17.1d
	pmull2	v0.1q, v0.2d, v4.2d
	eor	v0.16b, v0.16b, v19.16b
	crc32cx	w7, w7, x19
	eor	v0.16b, v18.16b, v0.16b
	b.ne	12b
	fmov	d21, x13
	add	x10, x10, #1
	add	x17, x17, #1792
	add	x15, x15, #1792
	pmull	v22.1q, v16.1d, v21.1d
	dup	v23.2d, x12
	pmull	v24.1q, v6.1d, v21.1d
	pmull	v25.1q, v7.1d, v21.1d
	pmull	v26.1q, v5.1d, v21.1d
	pmull	v27.1q, v3.1d, v21.1d
	pmull	v28.1q, v2.1d, v21.1d
	pmull	v29.1q, v1.1d, v21.1d
	pmull	v21.1q, v0.1d, v21.1d
	pmull2	v0.1q, v0.2d, v23.2d
	fmov	d18, x5
	fmov	d19, x6
	pmull2	v16.1q, v16.2d, v23.2d
	pmull2	v6.1q, v6.2d, v23.2d
	pmull2	v7.1q, v7.2d, v23.2d
	pmull2	v5.1q, v5.2d, v23.2d
	pmull2	v3.1q, v3.2d, v23.2d
	pmull2	v2.1q, v2.2d, v23.2d
	pmull2	v1.1q, v1.2d, v23.2d
	eor	v0.16b, v0.16b, v21.16b
	fmov	d21, x16
	eor	v16.16b, v16.16b, v22.16b
	fmov	d20, x7
	eor	v6.16b, v6.16b, v24.16b
	eor	v7.16b, v7.16b, v25.16b
	eor	v5.16b, v5.16b, v26.16b
	eor	v3.16b, v3.16b, v27.16b
	eor	v2.16b, v2.16b, v28.16b
	eor	v1.16b, v1.16b, v29.16b
	pmull	v18.1q, v18.1d, v21.1d
	fmov	d21, x9
	pmull	v19.1q, v19.1d, v21.1d
	eor	v18.16b, v18.16b, v19.16b
	eor	v16.16b, v18.16b, v16.16b
	fmov	d18, x11
	pmull	v18.1q, v20.1d, v18.1d
	eor	v16.16b, v16.16b, v18.16b
	cmp	x10, x14
	b.ne	2b
	lsl	x10, x14, #11
	sub	x10, x10, x14, lsl #8
	cmp	x10, x8
	b.ge	32f
	fmov	d17, x9
	.p2align	5, , 16
22:
	add	x9, x1, x10
	pmull	v24.1q, v16.1d, v17.1d
	pmull2	v16.1q, v16.2d, v4.2d
	pmull	v25.1q, v6.1d, v17.1d
	pmull2	v6.1q, v6.2d, v4.2d
	add	x10, x10, #128
	ldp	q19, q18, [x9, #96]
	ldp	q21, q20, [x9, #64]
	ldp	q23, q22, [x9, #32]
	ldp	q9, q8, [x9]
	pmull	v26.1q, v7.1d, v17.1d
	pmull2	v7.1q, v7.2d, v4.2d
	pmull	v27.1q, v5.1d, v17.1d
	pmull2	v5.1q, v5.2d, v4.2d
	pmull	v28.1q, v3.1d, v17.1d
	pmull2	v3.1q, v3.2d, v4.2d
	pmull	v29.1q, v2.1d, v17.1d
	pmull2	v2.1q, v2.2d, v4.2d
	pmull	v30.1q, v1.1d, v17.1d
	pmull2	v1.1q, v1.2d, v4.2d
	pmull	v31.1q, v0.1d, v17.1d
	pmull2	v0.1q, v0.2d, v4.2d
	eor	v16.16b, v16.16b, v24.16b
	eor	v6.16b, v6.16b, v25.16b
	eor	v7.16b, v7.16b, v26.16b
	eor	v5.16b, v5.16b, v27.16b
	eor	v3.16b, v3.16b, v28.16b
	eor	v2.16b, v2.16b, v29.16b
	eor	v1.16b, v1.16b, v30.16b
	eor	v0.16b, v0.16b, v31.16b
	eor	v6.16b, v8.16b, v6.16b
	eor	v5.16b, v22.16b, v5.16b
	eor	v2.16b, v20.16b, v2.16b
	eor	v0.16b, v18.16b, v0.16b
	eor	v16.16b, v9.16b, v16.16b
	eor	v7.16b, v23.16b, v7.16b
	eor	v3.16b, v21.16b, v3.16b
	eor	v1.16b, v19.16b, v1.16b
	cmp	x10, x8
	b.lt	22b
32:
	mov	x9, #126126009614336
	mov	x10, #137606457196544
	ldp	x20, x19, [sp, #32]
	ldr	x21, [sp, #16]
	movk	x9, #5780, lsl #48
	movk	x10, #18748, lsl #48
	fmov	d4, x9
	mov	x9, #107533096189952
	movk	x9, #38462, lsl #48
	dup	v17.2d, x9
	mov	x9, #168830869438464
	movk	x9, #51503, lsl #48
	pmull	v4.1q, v16.1d, v4.1d
	pmull2	v16.1q, v16.2d, v17.2d
	fmov	d17, x9
	mov	x9, #57629871177728
	movk	x9, #13157, lsl #48
	dup	v18.2d, x9
	mov	x9, #239981297664000
	eor	v4.16b, v16.16b, v4.16b
	movk	x9, #7234, lsl #48
	pmull	v17.1q, v6.1d, v17.1d
	pmull2	v6.1q, v6.2d, v18.2d
	fmov	d18, x9
	mov	x9, #68410239090688
	movk	x9, #28040, lsl #48
	dup	v19.2d, x9
	mov	x9, #39835821670400
	eor	v6.16b, v17.16b, v6.16b
	movk	x9, #7193, lsl #48
	pmull	v18.1q, v7.1d, v18.1d
	eor	v4.16b, v4.16b, v6.16b
	pmull2	v7.1q, v7.2d, v19.2d
	fmov	d19, x9
	mov	x9, #180710748979200
	movk	x9, #30139, lsl #48
	dup	v20.2d, x9
	mov	x9, #269010981617664
	eor	v6.16b, v18.16b, v7.16b
	movk	x9, #42094, lsl #48
	pmull	v19.1q, v5.1d, v19.1d
	pmull2	v5.1q, v5.2d, v20.2d
	fmov	d20, x9
	mov	x9, #39853001539584
	eor	v6.16b, v6.16b, v19.16b
	movk	x9, #24657, lsl #48
	dup	v21.2d, x9
	mov	x9, #206416128245760
	eor	v4.16b, v4.16b, v6.16b
	movk	x9, #13260, lsl #48
	pmull	v20.1q, v3.1d, v20.1d
	pmull2	v3.1q, v3.2d, v21.2d
	fmov	d21, x9
	mov	x9, #153055454560256
	eor	v5.16b, v5.16b, v20.16b
	movk	x9, #41493, lsl #48
	dup	v22.2d, x9
	mov	x9, #272391120879616
	eor	v3.16b, v5.16b, v3.16b
	movk	x9, #14147, lsl #48
	pmull	v21.1q, v2.1d, v21.1d
	pmull2	v2.1q, v2.2d, v22.2d
	fmov	d22, x9
	mov	x9, #233302623518720
	eor	v3.16b, v3.16b, v21.16b
	movk	x9, #12657, lsl #48
	dup	v23.2d, x9
	mov	x9, #187707250704384
	eor	v3.16b, v4.16b, v3.16b
	movk	x9, #56645, lsl #48
	pmull	v22.1q, v1.1d, v22.1d
	pmull2	v1.1q, v1.2d, v23.2d
	fmov	d23, x9
	mov	x9, #130777459195904
	eor	v2.16b, v2.16b, v22.16b
	movk	x9, #1516, lsl #48
	dup	v25.2d, x9
	eor	v1.16b, v2.16b, v1.16b
	pmull	v24.1q, v0.1d, v23.1d
	eor	v1.16b, v3.16b, v1.16b
	pmull2	v0.1q, v0.2d, v25.2d
	eor	v0.16b, v0.16b, v24.16b
	eor	v0.16b, v0.16b, v1.16b
	fmov	d1, x10
	mov	x9, v0.d[1]
	pmull	v0.1q, v0.1d, v1.1d
	fmov	x10, d0
	eor	x10, x10, x9, lsl #32
	fmov	d1, x10
	pmull	v1.1q, v1.1d, v23.1d
	eor	v0.16b, v1.16b, v0.16b
	mov	x10, v0.d[1]
	mov	w11, w10
	eor	x9, x11, x9, lsr #32
	fmov	d0, x9
	mov	x9, #5105
	movk	x9, #56999, lsl #16
	fmov	d1, x9
	pmull	v0.1q, v0.1d, v1.1d
	fmov	x9, d0
	mov	w9, w9
	fmov	d0, x9
	mov	x9, #30449
	movk	x9, #1516, lsl #16
	movk	x9, #1, lsl #32
	fmov	d1, x9
	pmull	v0.1q, v0.1d, v1.1d
	fmov	x9, d0
	eor	x9, x10, x9
	lsr	x0, x9, #32
	ldp	d9, d8, [sp], #48
	sub	x9, x2, x8
	and	x9, x9, #0xffffffffffffffc0
	add	x9, x9, x8
	cmp	x8, x9
	b.lt	52f
	b	62f
42:
	mov	x8, xzr
	sub	x9, x2, xzr
	and	x9, x9, #0xffffffffffffffc0
	add	x9, x9, xzr
	cmp	xzr, x9
	b.ge	62f
	.p2align	5, , 16
52:
	add	x10, x1, x8
	add	x8, x8, #64
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
	cmp	x8, x9
	b.lt	52b
62:
	tbnz	w2, #5, 122f
	tbnz	w2, #4, 132f
72:
	tbnz	w2, #3, 142f
82:
	tbnz	w2, #2, 152f
92:
	tbnz	w2, #1, 162f
102:
	tbnz	w2, #0, 172f
112:
	ret
122:
	add	x8, x1, x9
	orr	x9, x9, #0x20
	ldp	x10, x11, [x8]
	crc32cx	w10, w0, x10
	crc32cx	w10, w10, x11
	ldp	x11, x8, [x8, #16]
	crc32cx	w10, w10, x11
	crc32cx	w0, w10, x8
	tbz	w2, #4, 72b
132:
	add	x8, x1, x9
	add	x9, x9, #16
	ldp	x10, x8, [x8]
	crc32cx	w10, w0, x10
	crc32cx	w0, w10, x8
	tbz	w2, #3, 82b
142:
	ldr	x8, [x1, x9]
	add	x9, x9, #8
	crc32cx	w0, w0, x8
	tbz	w2, #2, 92b
152:
	ldr	w8, [x1, x9]
	add	x9, x9, #4
	crc32cw	w0, w0, w8
	tbz	w2, #1, 102b
162:
	ldrh	w8, [x1, x9]
	add	x9, x9, #2
	crc32ch	w0, w0, w8
	tbz	w2, #0, 112b
172:
	ldrb	w8, [x1, x9]
	crc32cb	w0, w0, w8
	ret

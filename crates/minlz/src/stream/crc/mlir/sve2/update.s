// minlz_crc32c_update of crates/minlz/mlir/crc32c_fold.mlir for sve2, written by
// cargo xtask mlir. Do not edit.
	cmp	x2, #2048
	b.lo	42f
	str	x19, [sp, #-16]!
	mov	x12, #9363
	lsr	x11, x2, #8
	mov	x13, #108825881346048
	mov	x14, #6588479832064
	mov	x10, #129012227637248
	and	x8, x2, #0xffffffffffffff80
	movk	x12, #37449, lsl #16
	movk	x13, #3743, lsl #48
	movk	x14, #30797, lsl #48
	movk	x10, #61186, lsl #48
	mov	x9, xzr
	movi	v6.2d, #0000000000000000
	movk	x12, #18724, lsl #32
	fmov	d1, x10
	mov	x15, x1
	movi	v5.2d, #0000000000000000
	movi	v4.2d, #0000000000000000
	movi	v3.2d, #0000000000000000
	movk	x12, #9362, lsl #48
	movi	v2.2d, #0000000000000000
	umulh	x11, x11, x12
	mov	w12, w0
	fmov	d0, x12
	mov	x12, #196009422487552
	movk	x12, #25975, lsl #48
	index	z16.d, x12, x13
	mov	x13, #104350525423616
	movk	x13, #19946, lsl #48
	pmull	v7.1q, v0.1d, v1.1d
	movi	v1.2d, #0000000000000000
	movi	v0.2d, #0000000000000000
	index	z17.d, x14, x13
	mov	x14, #177863185661952
	add	x13, x1, #1024
	movk	x14, #15808, lsl #48
	.p2align	5, , 16
2:
	mov	w0, #8
	mov	w5, wzr
	mov	w3, wzr
	mov	w4, wzr
	mov	x16, x13
	mov	x17, x15
	.p2align	5, , 16
12:
	ldp	x6, x7, [x16]
	ldp	q19, q18, [x17, #96]
	pmullb	z26.q, z7.d, z16.d
	ldp	q21, q20, [x17, #64]
	ldp	q23, q22, [x17, #32]
	ldp	q25, q24, [x17], #128
	pmullt	z7.q, z7.d, z16.d
	subs	x0, x0, #1
	crc32cx	w4, w4, x6
	ldp	x6, x19, [x16, #256]
	crc32cx	w4, w4, x7
	eor3	z7.d, z7.d, z25.d, z26.d
	pmullb	z25.q, z6.d, z16.d
	pmullt	z6.q, z6.d, z16.d
	crc32cx	w3, w3, x6
	ldr	x6, [x16, #512]
	eor3	z6.d, z6.d, z24.d, z25.d
	pmullb	z24.q, z5.d, z16.d
	pmullt	z5.q, z5.d, z16.d
	crc32cx	w3, w3, x19
	eor3	z5.d, z5.d, z23.d, z24.d
	pmullb	z23.q, z4.d, z16.d
	pmullt	z4.q, z4.d, z16.d
	crc32cx	w5, w5, x6
	ldr	x6, [x16, #520]
	eor3	z4.d, z4.d, z22.d, z23.d
	pmullb	z22.q, z3.d, z16.d
	pmullt	z3.q, z3.d, z16.d
	eor3	z3.d, z3.d, z21.d, z22.d
	pmullb	z21.q, z2.d, z16.d
	pmullt	z2.q, z2.d, z16.d
	crc32cx	w5, w5, x6
	ldp	x6, x7, [x16, #16]
	eor3	z2.d, z2.d, z20.d, z21.d
	pmullb	z20.q, z1.d, z16.d
	pmullt	z1.q, z1.d, z16.d
	eor3	z1.d, z1.d, z19.d, z20.d
	pmullb	z19.q, z0.d, z16.d
	pmullt	z0.q, z0.d, z16.d
	crc32cx	w4, w4, x6
	ldp	x6, x19, [x16, #272]
	eor3	z0.d, z0.d, z18.d, z19.d
	crc32cx	w4, w4, x7
	crc32cx	w3, w3, x6
	ldr	x6, [x16, #528]
	crc32cx	w3, w3, x19
	crc32cx	w5, w5, x6
	ldr	x6, [x16, #536]
	add	x16, x16, #32
	crc32cx	w5, w5, x6
	b.ne	12b
	pmullb	z21.q, z7.d, z17.d
	pmullt	z7.q, z7.d, z17.d
	fmov	d18, x4
	fmov	d19, x3
	add	x9, x9, #1
	add	x15, x15, #1792
	add	x13, x13, #1792
	eor	z7.d, z21.d, z7.d
	pmullb	z21.q, z6.d, z17.d
	pmullt	z6.q, z6.d, z17.d
	fmov	d20, x5
	eor	z6.d, z21.d, z6.d
	pmullb	z21.q, z5.d, z17.d
	pmullt	z5.q, z5.d, z17.d
	eor	z5.d, z21.d, z5.d
	pmullb	z21.q, z4.d, z17.d
	pmullt	z4.q, z4.d, z17.d
	eor	z4.d, z21.d, z4.d
	pmullb	z21.q, z3.d, z17.d
	pmullt	z3.q, z3.d, z17.d
	eor	z3.d, z21.d, z3.d
	pmullb	z21.q, z2.d, z17.d
	pmullt	z2.q, z2.d, z17.d
	eor	z2.d, z21.d, z2.d
	pmullb	z21.q, z1.d, z17.d
	pmullt	z1.q, z1.d, z17.d
	eor	z1.d, z21.d, z1.d
	pmullb	z21.q, z0.d, z17.d
	pmullt	z0.q, z0.d, z17.d
	eor	z0.d, z21.d, z0.d
	fmov	d21, x14
	pmull	v18.1q, v18.1d, v21.1d
	eor	v7.16b, v18.16b, v7.16b
	fmov	d18, x12
	pmull	v18.1q, v19.1d, v18.1d
	fmov	d19, x10
	pmull	v19.1q, v20.1d, v19.1d
	eor3	z7.d, z7.d, z18.d, z19.d
	cmp	x9, x11
	b.ne	2b
	lsl	x9, x11, #11
	sub	x9, x9, x11, lsl #8
	cmp	x9, x8
	ldr	x19, [sp], #16
	b.ge	32f
	mov	x10, #108825881346048
	mov	x11, #196009422487552
	movk	x10, #3743, lsl #48
	movk	x11, #25975, lsl #48
	index	z16.d, x11, x10
	.p2align	5, , 16
22:
	add	x10, x1, x9
	pmullb	z23.q, z7.d, z16.d
	pmullt	z7.q, z7.d, z16.d
	add	x9, x9, #128
	ldp	q22, q21, [x10]
	ldp	q20, q19, [x10, #32]
	ldp	q18, q17, [x10, #96]
	eor3	z7.d, z7.d, z22.d, z23.d
	pmullb	z22.q, z6.d, z16.d
	pmullt	z6.q, z6.d, z16.d
	eor3	z6.d, z6.d, z21.d, z22.d
	pmullb	z21.q, z5.d, z16.d
	pmullt	z5.q, z5.d, z16.d
	pmullb	z22.q, z4.d, z16.d
	pmullt	z4.q, z4.d, z16.d
	eor3	z5.d, z5.d, z20.d, z21.d
	ldp	q21, q20, [x10, #64]
	eor3	z4.d, z4.d, z19.d, z22.d
	pmullb	z19.q, z3.d, z16.d
	pmullt	z3.q, z3.d, z16.d
	eor3	z3.d, z3.d, z21.d, z19.d
	pmullb	z19.q, z2.d, z16.d
	pmullt	z2.q, z2.d, z16.d
	eor3	z2.d, z2.d, z20.d, z19.d
	pmullb	z19.q, z1.d, z16.d
	pmullt	z1.q, z1.d, z16.d
	eor3	z1.d, z1.d, z18.d, z19.d
	pmullb	z18.q, z0.d, z16.d
	pmullt	z0.q, z0.d, z16.d
	eor3	z0.d, z0.d, z17.d, z18.d
	cmp	x9, x8
	b.lt	22b
32:
	mov	x9, #262882063286272
	mov	x10, #126126009614336
	mov	x11, #137606457196544
	movk	x9, #32681, lsl #48
	movk	x10, #5780, lsl #48
	movk	x11, #18748, lsl #48
	index	z16.d, x10, x9
	mov	x9, #170273978449920
	mov	x10, #168830869438464
	movk	x9, #27189, lsl #48
	movk	x10, #51503, lsl #48
	index	z17.d, x10, x9
	mov	x9, #109903918137344
	mov	x10, #239981297664000
	movk	x9, #20805, lsl #48
	movk	x10, #7234, lsl #48
	pmullb	z18.q, z7.d, z16.d
	pmullt	z7.q, z7.d, z16.d
	pmullb	z16.q, z6.d, z17.d
	pmullt	z6.q, z6.d, z17.d
	eor	z7.d, z18.d, z7.d
	eor	z6.d, z16.d, z6.d
	eor	v6.16b, v6.16b, v7.16b
	index	z16.d, x10, x9
	mov	x9, #140874927308800
	mov	x10, #39835821670400
	movk	x9, #22946, lsl #48
	movk	x10, #7193, lsl #48
	index	z17.d, x10, x9
	mov	x9, #52316996632576
	mov	x10, #269010981617664
	movk	x9, #48098, lsl #48
	movk	x10, #42094, lsl #48
	pmullb	z18.q, z5.d, z16.d
	pmullt	z5.q, z5.d, z16.d
	pmullb	z16.q, z4.d, z17.d
	pmullt	z4.q, z4.d, z17.d
	eor	z5.d, z18.d, z5.d
	eor	z4.d, z16.d, z4.d
	eor3	z6.d, z6.d, z5.d, z4.d
	index	z16.d, x10, x9
	mov	x9, #228114303025152
	mov	x10, #206416128245760
	movk	x9, #28232, lsl #48
	movk	x10, #13260, lsl #48
	index	z17.d, x10, x9
	mov	x9, #242386479349760
	mov	x10, #272391120879616
	movk	x9, #64045, lsl #48
	movk	x10, #14147, lsl #48
	pmullb	z18.q, z3.d, z16.d
	pmullt	z3.q, z3.d, z16.d
	pmullb	z16.q, z2.d, z17.d
	pmullt	z2.q, z2.d, z17.d
	eor	z3.d, z18.d, z3.d
	eor	z2.d, z16.d, z2.d
	eor3	z6.d, z6.d, z3.d, z2.d
	index	z16.d, x10, x9
	mov	x9, #224545185202176
	mov	x10, #187707250704384
	movk	x9, #10406, lsl #48
	movk	x10, #56645, lsl #48
	index	z17.d, x10, x9
	pmullb	z18.q, z1.d, z16.d
	pmullt	z1.q, z1.d, z16.d
	pmullb	z16.q, z0.d, z17.d
	pmullt	z0.q, z0.d, z17.d
	eor	z1.d, z18.d, z1.d
	eor	z0.d, z16.d, z0.d
	eor3	z6.d, z6.d, z1.d, z0.d
	fmov	d0, x11
	fmov	d1, x10
	mov	x9, v6.d[1]
	pmull	v0.1q, v6.1d, v0.1d
	fmov	x12, d0
	mov	x11, v0.d[1]
	eor	x12, x12, x9, lsl #32
	eor	x9, x11, x9, lsr #32
	fmov	d0, x12
	pmull	v0.1q, v0.1d, v1.1d
	mov	x10, v0.d[1]
	eor	x9, x9, x10
	mov	w10, w9
	fmov	d0, x10
	mov	x10, #5105
	movk	x10, #56999, lsl #16
	fmov	d1, x10
	pmull	v0.1q, v0.1d, v1.1d
	fmov	x10, d0
	mov	w10, w10
	fmov	d0, x10
	mov	x10, #30449
	movk	x10, #1516, lsl #16
	movk	x10, #1, lsl #32
	fmov	d1, x10
	pmull	v0.1q, v0.1d, v1.1d
	fmov	x10, d0
	eor	x9, x10, x9
	lsr	x0, x9, #32
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

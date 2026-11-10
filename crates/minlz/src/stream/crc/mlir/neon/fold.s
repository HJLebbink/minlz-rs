// minlz_crc32c_fold of crates/minlz/mlir/crc32c.mlir for neon, written by
// cargo xtask mlir. Do not edit.
	stp	d9, d8, [sp, #-32]!
	mov	x10, #129012227637248
	mov	x12, #9363
	mov	w9, w0
	fmov	d0, x9
	mov	x11, #23360327122944
	lsr	x9, x2, #8
	movk	x10, #61186, lsl #48
	movk	x12, #37449, lsl #16
	movk	x11, #29719, lsl #48
	mov	x8, #196009422487552
	movk	x8, #25975, lsl #48
	movi	v5.2d, #0000000000000000
	fmov	d1, x10
	movk	x12, #18724, lsl #32
	stp	x20, x19, [sp, #16]
	movk	x12, #9362, lsl #48
	umulh	x9, x9, x12
	pmull	v16.1q, v0.1d, v1.1d
	dup	v0.2d, x11
	cmp	x2, #1792
	b.hs	2f
	movi	v7.2d, #0000000000000000
	movi	v6.2d, #0000000000000000
	movi	v4.2d, #0000000000000000
	movi	v3.2d, #0000000000000000
	movi	v2.2d, #0000000000000000
	movi	v1.2d, #0000000000000000
	b	32f
2:
	fmov	d17, x8
	mov	x12, #110939005255680
	mov	x13, #6588479832064
	mov	x15, #177863185661952
	add	x14, x1, #1024
	mov	x11, xzr
	movk	x12, #50743, lsl #48
	movk	x13, #30797, lsl #48
	movk	x15, #15808, lsl #48
	mov	x16, x1
	movi	v7.2d, #0000000000000000
	movi	v6.2d, #0000000000000000
	movi	v4.2d, #0000000000000000
	movi	v3.2d, #0000000000000000
	movi	v2.2d, #0000000000000000
	movi	v1.2d, #0000000000000000
	.p2align	5, , 16
12:
	mov	w3, #8
	mov	w6, wzr
	mov	w4, wzr
	mov	w5, wzr
	mov	x17, x14
	mov	x0, x16
	.p2align	5, , 16
22:
	ldp	x7, x19, [x17]
	ldp	q19, q18, [x0, #96]
	pmull	v26.1q, v16.1d, v17.1d
	ldp	q21, q20, [x0, #64]
	ldp	q23, q22, [x0, #32]
	ldp	q25, q24, [x0], #128
	pmull2	v16.1q, v16.2d, v0.2d
	pmull	v27.1q, v5.1d, v17.1d
	pmull2	v5.1q, v5.2d, v0.2d
	pmull	v28.1q, v7.1d, v17.1d
	pmull2	v7.1q, v7.2d, v0.2d
	pmull	v29.1q, v6.1d, v17.1d
	crc32cx	w5, w5, x7
	ldp	x7, x20, [x17, #256]
	pmull2	v6.1q, v6.2d, v0.2d
	pmull	v30.1q, v4.1d, v17.1d
	pmull2	v4.1q, v4.2d, v0.2d
	crc32cx	w5, w5, x19
	pmull	v31.1q, v3.1d, v17.1d
	pmull2	v3.1q, v3.2d, v0.2d
	pmull	v8.1q, v2.1d, v17.1d
	pmull2	v2.1q, v2.2d, v0.2d
	pmull	v9.1q, v1.1d, v17.1d
	pmull2	v1.1q, v1.2d, v0.2d
	eor	v16.16b, v16.16b, v26.16b
	eor	v5.16b, v5.16b, v27.16b
	eor	v7.16b, v7.16b, v28.16b
	eor	v6.16b, v6.16b, v29.16b
	eor	v4.16b, v4.16b, v30.16b
	eor	v3.16b, v3.16b, v31.16b
	eor	v2.16b, v2.16b, v8.16b
	eor	v1.16b, v1.16b, v9.16b
	eor	v16.16b, v25.16b, v16.16b
	eor	v5.16b, v24.16b, v5.16b
	eor	v7.16b, v23.16b, v7.16b
	crc32cx	w4, w4, x7
	ldr	x7, [x17, #512]
	eor	v6.16b, v22.16b, v6.16b
	eor	v4.16b, v21.16b, v4.16b
	eor	v3.16b, v20.16b, v3.16b
	eor	v2.16b, v19.16b, v2.16b
	crc32cx	w4, w4, x20
	eor	v1.16b, v18.16b, v1.16b
	subs	x3, x3, #1
	crc32cx	w6, w6, x7
	ldr	x7, [x17, #520]
	crc32cx	w6, w6, x7
	ldp	x7, x19, [x17, #16]
	crc32cx	w5, w5, x7
	ldp	x7, x20, [x17, #272]
	crc32cx	w5, w5, x19
	crc32cx	w4, w4, x7
	ldr	x7, [x17, #528]
	crc32cx	w4, w4, x20
	crc32cx	w6, w6, x7
	ldr	x7, [x17, #536]
	add	x17, x17, #32
	crc32cx	w6, w6, x7
	b.ne	22b
	fmov	d21, x13
	add	x11, x11, #1
	add	x16, x16, #1792
	add	x14, x14, #1792
	pmull	v22.1q, v16.1d, v21.1d
	dup	v23.2d, x12
	pmull	v24.1q, v5.1d, v21.1d
	pmull	v25.1q, v7.1d, v21.1d
	pmull	v26.1q, v6.1d, v21.1d
	pmull	v27.1q, v4.1d, v21.1d
	pmull	v28.1q, v3.1d, v21.1d
	pmull	v29.1q, v2.1d, v21.1d
	pmull	v21.1q, v1.1d, v21.1d
	pmull2	v1.1q, v1.2d, v23.2d
	fmov	d18, x5
	fmov	d19, x4
	pmull2	v16.1q, v16.2d, v23.2d
	pmull2	v5.1q, v5.2d, v23.2d
	pmull2	v7.1q, v7.2d, v23.2d
	pmull2	v6.1q, v6.2d, v23.2d
	pmull2	v4.1q, v4.2d, v23.2d
	pmull2	v3.1q, v3.2d, v23.2d
	pmull2	v2.1q, v2.2d, v23.2d
	eor	v1.16b, v1.16b, v21.16b
	fmov	d21, x15
	eor	v16.16b, v16.16b, v22.16b
	fmov	d20, x6
	eor	v5.16b, v5.16b, v24.16b
	eor	v7.16b, v7.16b, v25.16b
	eor	v6.16b, v6.16b, v26.16b
	eor	v4.16b, v4.16b, v27.16b
	eor	v3.16b, v3.16b, v28.16b
	eor	v2.16b, v2.16b, v29.16b
	pmull	v18.1q, v18.1d, v21.1d
	fmov	d21, x8
	pmull	v19.1q, v19.1d, v21.1d
	eor	v18.16b, v18.16b, v19.16b
	eor	v16.16b, v18.16b, v16.16b
	fmov	d18, x10
	pmull	v18.1q, v20.1d, v18.1d
	eor	v16.16b, v16.16b, v18.16b
	cmp	x11, x9
	b.ne	12b
32:
	lsl	x10, x9, #11
	sub	x9, x10, x9, lsl #8
	cmp	x9, x2
	b.ge	52f
	fmov	d17, x8
	.p2align	5, , 16
42:
	add	x8, x1, x9
	pmull	v24.1q, v16.1d, v17.1d
	pmull2	v16.1q, v16.2d, v0.2d
	pmull	v25.1q, v5.1d, v17.1d
	pmull2	v5.1q, v5.2d, v0.2d
	add	x9, x9, #128
	ldp	q19, q18, [x8, #96]
	ldp	q21, q20, [x8, #64]
	ldp	q23, q22, [x8, #32]
	ldp	q9, q8, [x8]
	pmull	v26.1q, v7.1d, v17.1d
	pmull2	v7.1q, v7.2d, v0.2d
	pmull	v27.1q, v6.1d, v17.1d
	pmull2	v6.1q, v6.2d, v0.2d
	pmull	v28.1q, v4.1d, v17.1d
	pmull2	v4.1q, v4.2d, v0.2d
	pmull	v29.1q, v3.1d, v17.1d
	pmull2	v3.1q, v3.2d, v0.2d
	pmull	v30.1q, v2.1d, v17.1d
	pmull2	v2.1q, v2.2d, v0.2d
	pmull	v31.1q, v1.1d, v17.1d
	pmull2	v1.1q, v1.2d, v0.2d
	eor	v16.16b, v16.16b, v24.16b
	eor	v5.16b, v5.16b, v25.16b
	eor	v7.16b, v7.16b, v26.16b
	eor	v6.16b, v6.16b, v27.16b
	eor	v4.16b, v4.16b, v28.16b
	eor	v3.16b, v3.16b, v29.16b
	eor	v2.16b, v2.16b, v30.16b
	eor	v1.16b, v1.16b, v31.16b
	eor	v5.16b, v8.16b, v5.16b
	eor	v6.16b, v22.16b, v6.16b
	eor	v3.16b, v20.16b, v3.16b
	eor	v1.16b, v18.16b, v1.16b
	eor	v16.16b, v9.16b, v16.16b
	eor	v7.16b, v23.16b, v7.16b
	eor	v4.16b, v21.16b, v4.16b
	eor	v2.16b, v19.16b, v2.16b
	cmp	x9, x2
	b.lt	42b
52:
	mov	x8, #126126009614336
	mov	x9, #137606457196544
	ldp	x20, x19, [sp, #16]
	movk	x8, #5780, lsl #48
	movk	x9, #18748, lsl #48
	fmov	d0, x8
	mov	x8, #107533096189952
	movk	x8, #38462, lsl #48
	dup	v17.2d, x8
	mov	x8, #168830869438464
	movk	x8, #51503, lsl #48
	pmull	v0.1q, v16.1d, v0.1d
	pmull2	v16.1q, v16.2d, v17.2d
	fmov	d17, x8
	mov	x8, #57629871177728
	movk	x8, #13157, lsl #48
	dup	v18.2d, x8
	mov	x8, #239981297664000
	eor	v0.16b, v16.16b, v0.16b
	movk	x8, #7234, lsl #48
	pmull	v17.1q, v5.1d, v17.1d
	pmull2	v5.1q, v5.2d, v18.2d
	fmov	d18, x8
	mov	x8, #68410239090688
	movk	x8, #28040, lsl #48
	dup	v19.2d, x8
	mov	x8, #39835821670400
	eor	v5.16b, v17.16b, v5.16b
	movk	x8, #7193, lsl #48
	pmull	v18.1q, v7.1d, v18.1d
	eor	v0.16b, v0.16b, v5.16b
	pmull2	v7.1q, v7.2d, v19.2d
	fmov	d19, x8
	mov	x8, #180710748979200
	movk	x8, #30139, lsl #48
	dup	v20.2d, x8
	mov	x8, #269010981617664
	eor	v5.16b, v18.16b, v7.16b
	movk	x8, #42094, lsl #48
	pmull	v19.1q, v6.1d, v19.1d
	pmull2	v6.1q, v6.2d, v20.2d
	fmov	d20, x8
	mov	x8, #39853001539584
	eor	v5.16b, v5.16b, v19.16b
	movk	x8, #24657, lsl #48
	dup	v21.2d, x8
	mov	x8, #206416128245760
	eor	v0.16b, v0.16b, v5.16b
	movk	x8, #13260, lsl #48
	pmull	v20.1q, v4.1d, v20.1d
	pmull2	v4.1q, v4.2d, v21.2d
	fmov	d21, x8
	mov	x8, #153055454560256
	eor	v5.16b, v6.16b, v20.16b
	movk	x8, #41493, lsl #48
	dup	v22.2d, x8
	mov	x8, #272391120879616
	eor	v4.16b, v5.16b, v4.16b
	movk	x8, #14147, lsl #48
	pmull	v21.1q, v3.1d, v21.1d
	pmull2	v3.1q, v3.2d, v22.2d
	fmov	d22, x8
	mov	x8, #233302623518720
	eor	v4.16b, v4.16b, v21.16b
	movk	x8, #12657, lsl #48
	dup	v23.2d, x8
	mov	x8, #187707250704384
	eor	v0.16b, v0.16b, v4.16b
	movk	x8, #56645, lsl #48
	pmull	v22.1q, v2.1d, v22.1d
	pmull2	v2.1q, v2.2d, v23.2d
	fmov	d23, x8
	mov	x8, #130777459195904
	eor	v3.16b, v3.16b, v22.16b
	movk	x8, #1516, lsl #48
	dup	v25.2d, x8
	eor	v2.16b, v3.16b, v2.16b
	pmull	v24.1q, v1.1d, v23.1d
	eor	v0.16b, v0.16b, v2.16b
	pmull2	v1.1q, v1.2d, v25.2d
	eor	v1.16b, v1.16b, v24.16b
	eor	v0.16b, v1.16b, v0.16b
	fmov	d1, x9
	mov	x8, v0.d[1]
	pmull	v0.1q, v0.1d, v1.1d
	fmov	x9, d0
	eor	x9, x9, x8, lsl #32
	fmov	d1, x9
	pmull	v1.1q, v1.1d, v23.1d
	eor	v0.16b, v1.16b, v0.16b
	mov	x9, v0.d[1]
	mov	w10, w9
	eor	x8, x10, x8, lsr #32
	fmov	d0, x8
	mov	x8, #5105
	movk	x8, #56999, lsl #16
	fmov	d1, x8
	pmull	v0.1q, v0.1d, v1.1d
	fmov	x8, d0
	mov	w8, w8
	fmov	d0, x8
	mov	x8, #30449
	movk	x8, #1516, lsl #16
	movk	x8, #1, lsl #32
	fmov	d1, x8
	pmull	v0.1q, v0.1d, v1.1d
	fmov	x8, d0
	eor	x8, x9, x8
	lsr	x0, x8, #32
	ldp	d9, d8, [sp], #32
	ret

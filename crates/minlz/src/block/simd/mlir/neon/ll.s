// minlz_stats_ll of crates/minlz/mlir/stats.mlir for neon, written by
// cargo xtask mlir. Do not edit.
	cmp	x1, #1
	b.lt	42f
	movi	v1.16b, #33
	movi	v2.2d, #0xffffffffffffffff
	mov	w10, #32897
	mov	x8, xzr
	mov	x9, xzr
	mov	x12, xzr
	movk	w10, #32896, lsl #16
	movi	v0.2d, #0000000000000000
	movi	v3.2d, #0000000000000000
	movi	v4.2d, #0000000000000000
	movi	v5.2d, #0000000000000000
	b	12f
	.p2align	5, , 16
2:
	add	x9, x9, xzr
	add	x8, x8, xzr
	mov	x12, x11
	cmp	x11, x1
	b.ge	32f
12:
	add	x11, x12, #2, lsl #12
	cmp	x11, x1
	csel	x13, x11, x1, lo
	cmp	x12, x13
	b.ge	2b
	movi	v6.2d, #0000000000000000
	movi	v7.2d, #0000000000000000
	movi	v16.2d, #0000000000000000
	movi	v17.2d, #0000000000000000
	movi	v18.2d, #0000000000000000
	movi	v19.2d, #0000000000000000
	movi	v20.2d, #0000000000000000
	movi	v21.2d, #0000000000000000
	.p2align	5, , 16
22:
	add	x14, x0, x12
	add	x12, x12, #64
	ldp	q22, q23, [x14]
	cmeq	v27.16b, v23.16b, v1.16b
	ldp	q25, q24, [x14, #32]
	cmeq	v29.16b, v24.16b, v1.16b
	uadalp	v19.8h, v23.16b
	uadalp	v21.8h, v24.16b
	add	v23.16b, v23.16b, v2.16b
	add	v24.16b, v24.16b, v2.16b
	cmeq	v26.16b, v22.16b, v1.16b
	cmeq	v28.16b, v25.16b, v1.16b
	uadalp	v20.8h, v25.16b
	uadalp	v18.8h, v22.16b
	uadalp	v17.8h, v29.16b
	uadalp	v7.8h, v27.16b
	add	v22.16b, v22.16b, v2.16b
	add	v25.16b, v25.16b, v2.16b
	umax	v5.16b, v5.16b, v24.16b
	umax	v0.16b, v0.16b, v23.16b
	uadalp	v16.8h, v28.16b
	uadalp	v6.8h, v26.16b
	umax	v4.16b, v4.16b, v25.16b
	umax	v3.16b, v3.16b, v22.16b
	cmp	x12, x13
	b.lt	22b
	uaddl2	v22.4s, v18.8h, v20.8h
	uaddl2	v23.4s, v19.8h, v21.8h
	uaddl	v18.4s, v18.4h, v20.4h
	uaddl	v19.4s, v19.4h, v21.4h
	add	v22.4s, v22.4s, v23.4s
	add	v18.4s, v18.4s, v19.4s
	uaddl2	v19.4s, v7.8h, v17.8h
	uaddl	v7.4s, v7.4h, v17.4h
	add	v18.4s, v18.4s, v22.4s
	addv	s18, v18.4s
	fmov	w12, s18
	uaddl2	v18.4s, v6.8h, v16.8h
	uaddl	v6.4s, v6.4h, v16.4h
	add	v18.4s, v18.4s, v19.4s
	add	v6.4s, v6.4s, v7.4s
	add	v6.4s, v6.4s, v18.4s
	addv	s6, v6.4s
	fmov	w13, s6
	umull	x13, w13, w10
	lsr	x13, x13, #39
	add	x9, x9, x12
	add	x8, x8, x13
	mov	x12, x11
	cmp	x11, x1
	b.lt	12b
32:
	umax	v1.16b, v3.16b, v4.16b
	umax	v0.16b, v0.16b, v5.16b
	umax	v0.16b, v1.16b, v0.16b
	umaxv	b0, v0.16b
	fmov	w10, s0
	cmp	w10, #32
	cset	w0, hi
	stp	x9, x8, [x2]
	ret
42:
	mov	x0, xzr
	stp	xzr, xzr, [x2]
	ret

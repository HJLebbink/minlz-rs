// minlz_stats_off of crates/minlz/mlir/stats.mlir for neon, written by
// cargo xtask mlir. Do not edit.
	cmp	x1, #1
	b.lt	42f
	movi	v1.16b, #1
	movi	v3.2d, #0xffffffffffffffff
	mov	x8, xzr
	mov	x10, xzr
	movi	v0.2d, #0000000000000000
	movi	v2.2d, #0000000000000000
	movi	v4.2d, #0000000000000000
	movi	v5.2d, #0000000000000000
	b	12f
	.p2align	5, , 16
2:
	add	x8, x8, xzr
	mov	x10, x9
	cmp	x9, x1
	b.ge	32f
12:
	add	x9, x10, #2, lsl #12
	cmp	x9, x1
	csel	x11, x9, x1, lo
	cmp	x10, x11
	b.ge	2b
	movi	v6.2d, #0000000000000000
	movi	v7.2d, #0000000000000000
	movi	v16.2d, #0000000000000000
	movi	v17.2d, #0000000000000000
	.p2align	5, , 16
22:
	add	x12, x0, x10
	add	x10, x10, #64
	ldp	q18, q19, [x12]
	ushr	v24.16b, v19.16b, #3
	ldp	q20, q21, [x12, #32]
	ushr	v22.16b, v21.16b, #3
	add	v19.16b, v19.16b, v3.16b
	add	v21.16b, v21.16b, v3.16b
	ushr	v23.16b, v20.16b, #3
	ushr	v25.16b, v18.16b, #3
	uqsub	v24.16b, v24.16b, v1.16b
	uqsub	v22.16b, v22.16b, v1.16b
	add	v18.16b, v18.16b, v3.16b
	add	v20.16b, v20.16b, v3.16b
	umax	v5.16b, v5.16b, v21.16b
	umax	v0.16b, v0.16b, v19.16b
	uqsub	v25.16b, v25.16b, v1.16b
	uqsub	v23.16b, v23.16b, v1.16b
	uadalp	v17.8h, v22.16b
	uadalp	v7.8h, v24.16b
	umax	v4.16b, v4.16b, v20.16b
	umax	v2.16b, v2.16b, v18.16b
	uadalp	v16.8h, v23.16b
	uadalp	v6.8h, v25.16b
	cmp	x10, x11
	b.lt	22b
	uaddl2	v18.4s, v6.8h, v16.8h
	uaddl2	v19.4s, v7.8h, v17.8h
	uaddl	v6.4s, v6.4h, v16.4h
	uaddl	v7.4s, v7.4h, v17.4h
	add	v18.4s, v18.4s, v19.4s
	add	v6.4s, v6.4s, v7.4s
	add	v6.4s, v6.4s, v18.4s
	addv	s6, v6.4s
	fmov	w10, s6
	add	x8, x8, x10
	mov	x10, x9
	cmp	x9, x1
	b.lt	12b
32:
	umax	v1.16b, v2.16b, v4.16b
	umax	v0.16b, v0.16b, v5.16b
	str	x8, [x2]
	umax	v0.16b, v1.16b, v0.16b
	umaxv	b0, v0.16b
	fmov	w9, s0
	cmp	w9, #174
	cset	w0, hi
	ret
42:
	mov	x0, xzr
	str	xzr, [x2]
	ret

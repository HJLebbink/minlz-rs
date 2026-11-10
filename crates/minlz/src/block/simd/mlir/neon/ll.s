// minlz_stats_ll of crates/minlz/mlir/stats.mlir for neon, written by
// cargo xtask mlir. Do not edit.
	cmp	x1, #1
	b.lt	42f
	movi	v1.16b, #33
	movi	v2.16b, #1
	movi	v4.2d, #0xffffffffffffffff
	mov	x8, xzr
	mov	x9, xzr
	mov	x11, xzr
	movi	v0.2d, #0000000000000000
	movi	v3.2d, #0000000000000000
	movi	v5.2d, #0000000000000000
	movi	v6.2d, #0000000000000000
	b	12f
	.p2align	5, , 16
2:
	add	x9, x9, xzr
	add	x8, x8, xzr
	mov	x11, x10
	cmp	x10, x1
	b.ge	32f
12:
	add	x10, x11, #2, lsl #12
	cmp	x10, x1
	csel	x12, x10, x1, lo
	cmp	x11, x12
	b.ge	2b
	movi	v7.2d, #0000000000000000
	movi	v16.2d, #0000000000000000
	movi	v17.2d, #0000000000000000
	movi	v18.2d, #0000000000000000
	movi	v19.2d, #0000000000000000
	movi	v20.2d, #0000000000000000
	movi	v21.2d, #0000000000000000
	movi	v22.2d, #0000000000000000
	.p2align	5, , 16
22:
	add	x13, x0, x11
	add	x11, x11, #64
	ldp	q23, q24, [x13]
	cmeq	v28.16b, v24.16b, v1.16b
	ldp	q26, q25, [x13, #32]
	cmeq	v30.16b, v25.16b, v1.16b
	uadalp	v20.8h, v24.16b
	uadalp	v22.8h, v25.16b
	add	v24.16b, v24.16b, v4.16b
	add	v25.16b, v25.16b, v4.16b
	cmeq	v27.16b, v23.16b, v1.16b
	cmeq	v29.16b, v26.16b, v1.16b
	and	v28.16b, v28.16b, v2.16b
	and	v30.16b, v30.16b, v2.16b
	uadalp	v21.8h, v26.16b
	uadalp	v19.8h, v23.16b
	add	v23.16b, v23.16b, v4.16b
	add	v26.16b, v26.16b, v4.16b
	umax	v6.16b, v6.16b, v25.16b
	umax	v0.16b, v0.16b, v24.16b
	and	v27.16b, v27.16b, v2.16b
	and	v29.16b, v29.16b, v2.16b
	uadalp	v18.8h, v30.16b
	uadalp	v16.8h, v28.16b
	umax	v5.16b, v5.16b, v26.16b
	umax	v3.16b, v3.16b, v23.16b
	uadalp	v17.8h, v29.16b
	uadalp	v7.8h, v27.16b
	cmp	x11, x12
	b.lt	22b
	uaddl2	v23.4s, v19.8h, v21.8h
	uaddl2	v24.4s, v20.8h, v22.8h
	uaddl	v19.4s, v19.4h, v21.4h
	uaddl	v20.4s, v20.4h, v22.4h
	add	v23.4s, v23.4s, v24.4s
	add	v19.4s, v19.4s, v20.4s
	uaddl2	v20.4s, v16.8h, v18.8h
	uaddl	v16.4s, v16.4h, v18.4h
	add	v19.4s, v19.4s, v23.4s
	addv	s19, v19.4s
	fmov	w11, s19
	uaddl2	v19.4s, v7.8h, v17.8h
	uaddl	v7.4s, v7.4h, v17.4h
	add	v19.4s, v19.4s, v20.4s
	add	v7.4s, v7.4s, v16.4s
	add	v7.4s, v7.4s, v19.4s
	addv	s7, v7.4s
	fmov	w12, s7
	add	x9, x9, x11
	add	x8, x8, x12
	mov	x11, x10
	cmp	x10, x1
	b.lt	12b
32:
	umax	v1.16b, v3.16b, v5.16b
	umax	v0.16b, v0.16b, v6.16b
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

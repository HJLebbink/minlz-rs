// minlz_stats_tok of crates/minlz/mlir/stats.mlir for neon, written by
// cargo xtask mlir. Do not edit.
	cmp	x1, #1
	b.lt	52f
	stp	d13, d12, [sp, #-48]!
	movi	v2.16b, #1
	stp	d11, d10, [sp, #16]
	stp	d9, d8, [sp, #32]
	mov	x8, xzr
	mov	x9, xzr
	mov	x10, xzr
	mov	x11, xzr
	mov	x13, xzr
	movi	v0.2d, #0000000000000000
	movi	v1.2d, #0000000000000000
	movi	v3.2d, #0000000000000000
	movi	v4.2d, #0000000000000000
	b	22f
	.p2align	5, , 16
2:
	mov	x13, xzr
	mov	x14, xzr
	mov	x15, xzr
	mov	x16, xzr
12:
	add	x11, x11, x13
	add	x10, x10, x14
	add	x9, x9, x15
	add	x8, x8, x16
	mov	x13, x12
	cmp	x12, x1
	b.ge	42f
22:
	add	x12, x13, #2, lsl #12
	cmp	x12, x1
	csel	x14, x12, x1, lo
	cmp	x13, x14
	b.ge	2b
	movi	v5.2d, #0000000000000000
	movi	v6.2d, #0000000000000000
	movi	v7.2d, #0000000000000000
	movi	v16.2d, #0000000000000000
	movi	v17.2d, #0000000000000000
	movi	v18.2d, #0000000000000000
	movi	v19.2d, #0000000000000000
	movi	v20.2d, #0000000000000000
	movi	v21.2d, #0000000000000000
	movi	v22.2d, #0000000000000000
	movi	v23.2d, #0000000000000000
	movi	v24.2d, #0000000000000000
	movi	v25.2d, #0000000000000000
	movi	v26.2d, #0000000000000000
	movi	v27.2d, #0000000000000000
	movi	v28.2d, #0000000000000000
	.p2align	5, , 16
32:
	add	x15, x0, x13
	add	x13, x13, #64
	ldp	q8, q30, [x15, #32]
	ushr	v13.16b, v30.16b, #1
	ldp	q29, q31, [x15]
	ushr	v10.16b, v31.16b, #2
	ushr	v12.16b, v30.16b, #2
	umax	v0.16b, v0.16b, v31.16b
	umax	v4.16b, v4.16b, v30.16b
	and	v13.16b, v13.16b, v2.16b
	ushr	v9.16b, v29.16b, #2
	ushr	v11.16b, v8.16b, #2
	uadalp	v26.8h, v10.16b
	uadalp	v28.8h, v12.16b
	umax	v3.16b, v3.16b, v8.16b
	umax	v1.16b, v1.16b, v29.16b
	uadalp	v24.8h, v13.16b
	ushr	v13.16b, v8.16b, #1
	uadalp	v25.8h, v9.16b
	uadalp	v27.8h, v11.16b
	and	v13.16b, v13.16b, v2.16b
	uadalp	v23.8h, v13.16b
	ushr	v13.16b, v31.16b, #1
	and	v13.16b, v13.16b, v2.16b
	uadalp	v22.8h, v13.16b
	ushr	v13.16b, v29.16b, #1
	and	v13.16b, v13.16b, v2.16b
	uadalp	v21.8h, v13.16b
	and	v13.16b, v30.16b, v2.16b
	uadalp	v20.8h, v13.16b
	and	v13.16b, v8.16b, v2.16b
	uadalp	v19.8h, v13.16b
	and	v13.16b, v31.16b, v2.16b
	uadalp	v18.8h, v13.16b
	and	v13.16b, v29.16b, v2.16b
	uadalp	v17.8h, v13.16b
	ushr	v13.16b, v29.16b, #7
	and	v9.16b, v13.16b, v9.16b
	ushr	v13.16b, v31.16b, #7
	and	v10.16b, v13.16b, v10.16b
	ushr	v13.16b, v8.16b, #7
	uadalp	v5.8h, v9.16b
	and	v11.16b, v13.16b, v11.16b
	ushr	v13.16b, v30.16b, #7
	uadalp	v6.8h, v10.16b
	and	v12.16b, v13.16b, v12.16b
	uadalp	v7.8h, v11.16b
	uadalp	v16.8h, v12.16b
	cmp	x13, x14
	b.lt	32b
	uaddl2	v29.4s, v25.8h, v27.8h
	uaddl2	v30.4s, v26.8h, v28.8h
	uaddl	v25.4s, v25.4h, v27.4h
	uaddl	v26.4s, v26.4h, v28.4h
	add	v29.4s, v29.4s, v30.4s
	add	v25.4s, v25.4s, v26.4s
	uaddl2	v26.4s, v22.8h, v24.8h
	uaddl	v22.4s, v22.4h, v24.4h
	add	v25.4s, v25.4s, v29.4s
	addv	s25, v25.4s
	fmov	w13, s25
	uaddl2	v25.4s, v21.8h, v23.8h
	uaddl	v21.4s, v21.4h, v23.4h
	add	v25.4s, v25.4s, v26.4s
	add	v21.4s, v21.4s, v22.4s
	uaddl2	v22.4s, v18.8h, v20.8h
	uaddl	v18.4s, v18.4h, v20.4h
	add	v21.4s, v21.4s, v25.4s
	addv	s21, v21.4s
	fmov	w14, s21
	uaddl2	v21.4s, v17.8h, v19.8h
	uaddl	v17.4s, v17.4h, v19.4h
	add	v21.4s, v21.4s, v22.4s
	add	v17.4s, v17.4s, v18.4s
	uaddl2	v18.4s, v6.8h, v16.8h
	uaddl	v6.4s, v6.4h, v16.4h
	add	v17.4s, v17.4s, v21.4s
	addv	s17, v17.4s
	fmov	w15, s17
	uaddl2	v17.4s, v5.8h, v7.8h
	uaddl	v5.4s, v5.4h, v7.4h
	add	v17.4s, v17.4s, v18.4s
	add	v5.4s, v5.4s, v6.4s
	add	v5.4s, v5.4s, v17.4s
	addv	s5, v5.4s
	fmov	w16, s5
	b	12b
42:
	umax	v1.16b, v1.16b, v3.16b
	umax	v0.16b, v0.16b, v4.16b
	ldp	d9, d8, [sp, #32]
	ldp	d11, d10, [sp, #16]
	umax	v0.16b, v1.16b, v0.16b
	umaxv	b0, v0.16b
	fmov	w12, s0
	cmp	w12, #135
	cset	w0, hi
	ldp	d13, d12, [sp], #48
	stp	x11, x10, [x2]
	stp	x9, x8, [x2, #16]
	ret
52:
	mov	x0, xzr
	stp	xzr, xzr, [x2]
	stp	xzr, xzr, [x2, #16]
	ret

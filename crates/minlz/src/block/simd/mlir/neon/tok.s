// minlz_stats_tok of crates/minlz/mlir/stats.mlir for neon, written by
// cargo xtask mlir. Do not edit.
	cmp	x1, #1
	b.lt	42f
	str	d14, [sp, #-64]!
	movi	v1.16b, #3
	movi	v2.16b, #1
	mov	w10, #32897
	stp	d13, d12, [sp, #16]
	mov	x8, xzr
	movk	w10, #32896, lsl #16
	stp	d11, d10, [sp, #32]
	stp	d9, d8, [sp, #48]
	mov	x9, xzr
	mov	x12, xzr
	movi	v0.2d, #0000000000000000
	movi	v3.2d, #0000000000000000
	movi	v4.2d, #0000000000000000
	movi	v5.2d, #0000000000000000
	movi	v6.2d, #0000000000000000
	b	12f
	.p2align	5, , 16
2:
	movi	v7.2d, #0000000000000000
	add	v0.2d, v0.2d, v7.2d
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
	movi	v29.2d, #0000000000000000
	movi	v30.2d, #0000000000000000
	.p2align	5, , 16
22:
	add	x14, x0, x12
	add	x12, x12, #64
	ldp	q31, q8, [x14]
	and	v12.16b, v8.16b, v1.16b
	ldp	q10, q9, [x14, #32]
	and	v14.16b, v9.16b, v1.16b
	uadalp	v28.8h, v8.16b
	uadalp	v30.8h, v9.16b
	umax	v4.16b, v4.16b, v8.16b
	umax	v6.16b, v6.16b, v9.16b
	and	v11.16b, v31.16b, v1.16b
	and	v13.16b, v10.16b, v1.16b
	uadalp	v26.8h, v14.16b
	uadalp	v24.8h, v12.16b
	cmtst	v12.16b, v8.16b, v2.16b
	cmtst	v14.16b, v9.16b, v2.16b
	uadalp	v29.8h, v10.16b
	uadalp	v27.8h, v31.16b
	umax	v5.16b, v5.16b, v10.16b
	umax	v3.16b, v3.16b, v31.16b
	uadalp	v25.8h, v13.16b
	uadalp	v23.8h, v11.16b
	cmtst	v11.16b, v31.16b, v2.16b
	cmtst	v13.16b, v10.16b, v2.16b
	uadalp	v22.8h, v14.16b
	uadalp	v20.8h, v12.16b
	shl	v12.16b, v8.16b, #5
	shl	v14.16b, v9.16b, #5
	uadalp	v21.8h, v13.16b
	uadalp	v19.8h, v11.16b
	shl	v11.16b, v31.16b, #5
	shl	v13.16b, v10.16b, #5
	and	v14.16b, v14.16b, v9.16b
	and	v12.16b, v12.16b, v8.16b
	and	v13.16b, v13.16b, v10.16b
	and	v11.16b, v11.16b, v31.16b
	cmlt	v12.16b, v12.16b, #0
	cmlt	v14.16b, v14.16b, #0
	cmlt	v11.16b, v11.16b, #0
	cmlt	v13.16b, v13.16b, #0
	uadalp	v18.8h, v14.16b
	uadalp	v16.8h, v12.16b
	uadalp	v17.8h, v13.16b
	uadalp	v7.8h, v11.16b
	cmp	x12, x13
	b.lt	22b
	uaddl2	v31.4s, v27.8h, v29.8h
	uaddl2	v8.4s, v28.8h, v30.8h
	uaddl	v27.4s, v27.4h, v29.4h
	uaddl	v28.4s, v28.4h, v30.4h
	add	v31.4s, v31.4s, v8.4s
	add	v27.4s, v27.4s, v28.4s
	uaddl2	v28.4s, v24.8h, v26.8h
	uaddl	v24.4s, v24.4h, v26.4h
	add	v27.4s, v27.4s, v31.4s
	addv	s27, v27.4s
	fmov	w12, s27
	uaddl2	v27.4s, v23.8h, v25.8h
	uaddl	v23.4s, v23.4h, v25.4h
	add	v27.4s, v27.4s, v28.4s
	add	v23.4s, v23.4s, v24.4s
	uaddl2	v24.4s, v20.8h, v22.8h
	uaddl	v20.4s, v20.4h, v22.4h
	add	v23.4s, v23.4s, v27.4s
	addv	s23, v23.4s
	fmov	w13, s23
	uaddl2	v23.4s, v19.8h, v21.8h
	uaddl	v19.4s, v19.4h, v21.4h
	uaddl2	v21.4s, v16.8h, v18.8h
	uaddl	v16.4s, v16.4h, v18.4h
	add	v19.4s, v19.4s, v20.4s
	uaddl2	v20.4s, v7.8h, v17.8h
	uaddl	v7.4s, v7.4h, v17.4h
	add	v23.4s, v23.4s, v24.4s
	add	v20.4s, v20.4s, v21.4s
	add	v7.4s, v7.4s, v16.4s
	add	v19.4s, v19.4s, v23.4s
	add	v7.4s, v7.4s, v20.4s
	addv	s19, v19.4s
	addv	s7, v7.4s
	mov	v19.s[1], v7.s[0]
	dup	v7.2s, w10
	umull	v7.2d, v19.2s, v7.2s
	ushr	v7.2d, v7.2d, #39
	add	v0.2d, v0.2d, v7.2d
	add	x9, x9, x12
	add	x8, x8, x13
	mov	x12, x11
	cmp	x11, x1
	b.lt	12b
32:
	umax	v1.16b, v3.16b, v5.16b
	umax	v2.16b, v4.16b, v6.16b
	ldp	d9, d8, [sp, #48]
	ldp	d11, d10, [sp, #32]
	ldp	d13, d12, [sp, #16]
	umax	v1.16b, v1.16b, v2.16b
	umaxv	b1, v1.16b
	fmov	w10, s1
	cmp	w10, #135
	cset	w0, hi
	ldr	d14, [sp], #64
	b	52f
42:
	mov	x9, xzr
	mov	x8, xzr
	mov	x0, xzr
	movi	v0.2d, #0000000000000000
52:
	fmov	x10, d0
	sub	x9, x9, x8
	lsr	x9, x9, #2
	str	q0, [x2, #16]
	sub	x8, x8, x10
	lsr	x8, x8, #1
	stp	x9, x8, [x2]
	ret

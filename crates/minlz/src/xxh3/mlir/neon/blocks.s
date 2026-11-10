// minlz_xxh3_blocks of crates/minlz/mlir/xxh3.mlir for neon, written by
// crates/minlz/mlir/build.sh. Do not edit.
	ldp	q6, q7, [x0, #32]
	ldp	q3, q5, [x0]
	cmp	x2, #1
	b.lt	22f
	str	d12, [sp, #-48]!
	ldr	q0, [x3, #1072]
	ldr	q1, [x3, #1056]
	ldr	q2, [x3, #1040]
	mov	w10, #31153
	add	x9, x3, #128
	mov	x8, xzr
	ldr	q4, [x3, #1024]
	movk	w10, #40503, lsl #16
	stp	d11, d10, [sp, #16]
	stp	d9, d8, [sp, #32]
	.p2align	5, , 16
2:
	mov	w12, #192
	movi	v16.2d, #0000000000000000
	mov	x11, x9
	movi	v20.2d, #0000000000000000
	movi	v21.2d, #0000000000000000
	movi	v22.2d, #0000000000000000
	movi	v23.2d, #0000000000000000
	movi	v17.2d, #0000000000000000
	movi	v18.2d, #0000000000000000
	movi	v19.2d, #0000000000000000
	.p2align	5, , 16
12:
	add	x13, x1, x12
	ldp	q28, q29, [x11, #-128]
	ldp	q25, q26, [x13, #-192]
	ldp	q27, q24, [x13, #-160]
	ldp	q30, q31, [x11, #-96]
	ldp	q10, q11, [x11, #32]
	eor	v31.16b, v31.16b, v24.16b
	eor	v29.16b, v29.16b, v26.16b
	add	v24.2d, v24.2d, v23.2d
	add	v21.2d, v26.2d, v21.2d
	eor	v30.16b, v30.16b, v27.16b
	eor	v28.16b, v28.16b, v25.16b
	add	v23.2d, v25.2d, v20.2d
	add	v20.2d, v27.2d, v22.2d
	ldp	q26, q25, [x13, #-128]
	uzp1	v8.4s, v28.4s, v29.4s
	uzp2	v28.4s, v28.4s, v29.4s
	//APP
	//NO_APP
	//APP
	//NO_APP
	uzp1	v29.4s, v30.4s, v31.4s
	uzp2	v30.4s, v30.4s, v31.4s
	//APP
	//NO_APP
	//APP
	//NO_APP
	umlal	v17.2d, v28.2s, v8.2s
	umlal	v18.2d, v30.2s, v29.2s
	umlal2	v16.2d, v28.4s, v8.4s
	umlal2	v19.2d, v30.4s, v29.4s
	ldp	q22, q27, [x13, #-96]
	ldp	q28, q29, [x11, #-64]
	ldp	q30, q31, [x11, #-32]
	eor	v31.16b, v31.16b, v27.16b
	eor	v29.16b, v29.16b, v25.16b
	eor	v30.16b, v30.16b, v22.16b
	eor	v28.16b, v28.16b, v26.16b
	uzp1	v8.4s, v28.4s, v29.4s
	uzp2	v28.4s, v28.4s, v29.4s
	//APP
	//NO_APP
	//APP
	//NO_APP
	uzp1	v29.4s, v30.4s, v31.4s
	uzp2	v30.4s, v30.4s, v31.4s
	//APP
	//NO_APP
	//APP
	//NO_APP
	umlal2	v19.2d, v30.4s, v29.4s
	umlal2	v16.2d, v28.4s, v8.4s
	umlal	v18.2d, v30.2s, v29.2s
	umlal	v17.2d, v28.2s, v8.2s
	ldp	q28, q29, [x13, #-64]
	add	v25.2d, v25.2d, v29.2d
	add	v26.2d, v26.2d, v28.2d
	ldp	q30, q31, [x13, #-32]
	ldp	q8, q9, [x11]
	add	v27.2d, v27.2d, v31.2d
	add	v22.2d, v22.2d, v30.2d
	eor	v11.16b, v11.16b, v31.16b
	eor	v10.16b, v10.16b, v30.16b
	eor	v9.16b, v9.16b, v29.16b
	eor	v8.16b, v8.16b, v28.16b
	add	v24.2d, v24.2d, v27.2d
	add	v21.2d, v21.2d, v25.2d
	ldp	q28, q29, [x11, #64]
	add	v23.2d, v23.2d, v26.2d
	add	v20.2d, v20.2d, v22.2d
	ldp	q25, q26, [x13]
	uzp1	v12.4s, v8.4s, v9.4s
	uzp2	v8.4s, v8.4s, v9.4s
	ldp	q22, q27, [x13, #32]
	ldp	q30, q31, [x11, #96]
	//APP
	//NO_APP
	//APP
	//NO_APP
	uzp1	v9.4s, v10.4s, v11.4s
	uzp2	v10.4s, v10.4s, v11.4s
	//APP
	//NO_APP
	//APP
	//NO_APP
	umlal	v17.2d, v8.2s, v12.2s
	umlal	v18.2d, v10.2s, v9.2s
	umlal2	v16.2d, v8.4s, v12.4s
	umlal2	v19.2d, v10.4s, v9.4s
	sub	x13, x12, #192
	add	x12, x12, #256
	add	x11, x11, #256
	eor	v31.16b, v31.16b, v27.16b
	eor	v29.16b, v29.16b, v26.16b
	add	v21.2d, v21.2d, v26.2d
	eor	v30.16b, v30.16b, v22.16b
	eor	v28.16b, v28.16b, v25.16b
	add	v22.2d, v20.2d, v22.2d
	add	v20.2d, v23.2d, v25.2d
	add	v23.2d, v24.2d, v27.2d
	uzp1	v8.4s, v28.4s, v29.4s
	uzp2	v28.4s, v28.4s, v29.4s
	//APP
	//NO_APP
	//APP
	//NO_APP
	uzp1	v29.4s, v30.4s, v31.4s
	uzp2	v30.4s, v30.4s, v31.4s
	//APP
	//NO_APP
	//APP
	//NO_APP
	umlal2	v19.2d, v30.4s, v29.4s
	umlal2	v16.2d, v28.4s, v8.4s
	umlal	v18.2d, v30.2s, v29.2s
	umlal	v17.2d, v28.2s, v8.2s
	cmp	x13, #768
	b.lo	12b
	ext	v20.16b, v20.16b, v20.16b, #8
	add	v3.2d, v17.2d, v3.2d
	ext	v21.16b, v21.16b, v21.16b, #8
	add	v7.2d, v19.2d, v7.2d
	add	x8, x8, #1
	add	x1, x1, #1024
	add	v5.2d, v16.2d, v5.2d
	ext	v22.16b, v22.16b, v22.16b, #8
	add	v6.2d, v18.2d, v6.2d
	ext	v23.16b, v23.16b, v23.16b, #8
	add	v3.2d, v3.2d, v20.2d
	add	v5.2d, v5.2d, v21.2d
	add	v6.2d, v6.2d, v22.2d
	add	v7.2d, v7.2d, v23.2d
	ushr	v19.2d, v3.2d, #47
	eor	v3.16b, v4.16b, v3.16b
	ushr	v18.2d, v5.2d, #47
	eor	v5.16b, v2.16b, v5.16b
	ushr	v17.2d, v6.2d, #47
	eor	v6.16b, v1.16b, v6.16b
	ushr	v16.2d, v7.2d, #47
	eor	v7.16b, v0.16b, v7.16b
	eor	v3.16b, v3.16b, v19.16b
	eor	v5.16b, v5.16b, v18.16b
	eor	v6.16b, v6.16b, v17.16b
	eor	v7.16b, v7.16b, v16.16b
	fmov	x12, d3
	mov	x11, v3.d[1]
	mul	x12, x12, x10
	mul	x11, x11, x10
	fmov	d3, x12
	fmov	x12, d5
	mul	x12, x12, x10
	mov	v3.d[1], x11
	mov	x11, v5.d[1]
	fmov	d5, x12
	mul	x11, x11, x10
	fmov	x12, d6
	mul	x12, x12, x10
	mov	v5.d[1], x11
	mov	x11, v6.d[1]
	fmov	d6, x12
	fmov	x12, d7
	mul	x11, x11, x10
	mul	x12, x12, x10
	mov	v6.d[1], x11
	mov	x11, v7.d[1]
	fmov	d7, x12
	mul	x11, x11, x10
	mov	v7.d[1], x11
	cmp	x8, x2
	b.ne	2b
	ldp	d9, d8, [sp, #32]
	ldp	d11, d10, [sp, #16]
	ldr	d12, [sp], #48
22:
	stp	q3, q5, [x0]
	stp	q6, q7, [x0, #32]
	ret

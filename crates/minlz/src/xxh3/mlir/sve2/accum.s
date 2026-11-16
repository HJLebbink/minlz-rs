// minlz_xxh3_accum of crates/minlz/mlir/xxh3.mlir for sve2, written by
// cargo xtask mlir. Do not edit.
	str	d12, [sp, #-48]!
	ldp	q2, q1, [x0, #32]
	ldp	q0, q3, [x0]
	sub	x8, x2, #1
	lsr	x9, x8, #10
	stp	d11, d10, [sp, #16]
	stp	d9, d8, [sp, #32]
	cbz	x9, 22f
	ldr	q4, [x3, #1072]
	ldr	q5, [x3, #1056]
	ldr	q6, [x3, #1040]
	mov	w11, #31153
	mov	x10, xzr
	mov	x12, x1
	ldr	q7, [x3, #1024]
	movk	w11, #40503, lsl #16
	.p2align	5, , 16
2:
	add	x13, x3, #128
	mov	w14, #192
	movi	v16.2d, #0000000000000000
	movi	v22.2d, #0000000000000000
	movi	v21.2d, #0000000000000000
	movi	v20.2d, #0000000000000000
	movi	v23.2d, #0000000000000000
	movi	v17.2d, #0000000000000000
	movi	v18.2d, #0000000000000000
	movi	v19.2d, #0000000000000000
	.p2align	5, , 16
12:
	add	x15, x12, x14
	ldp	q28, q29, [x13, #-128]
	ldp	q24, q25, [x15, #-192]
	ldp	q26, q27, [x15, #-160]
	ldp	q30, q31, [x13, #-96]
	ldp	q10, q11, [x13, #32]
	eor	v31.16b, v31.16b, v27.16b
	eor	v29.16b, v29.16b, v25.16b
	add	v23.2d, v27.2d, v23.2d
	add	v21.2d, v25.2d, v21.2d
	eor	v30.16b, v30.16b, v26.16b
	eor	v28.16b, v28.16b, v24.16b
	add	v22.2d, v24.2d, v22.2d
	add	v20.2d, v26.2d, v20.2d
	ldp	q26, q25, [x15, #-128]
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
	ldp	q24, q27, [x15, #-96]
	ldp	q28, q29, [x13, #-64]
	ldp	q30, q31, [x13, #-32]
	eor	v31.16b, v31.16b, v27.16b
	eor	v29.16b, v29.16b, v25.16b
	eor	v30.16b, v30.16b, v24.16b
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
	ldp	q28, q29, [x15, #-64]
	add	v25.2d, v25.2d, v29.2d
	add	v26.2d, v26.2d, v28.2d
	ldp	q30, q31, [x15, #-32]
	ldp	q8, q9, [x13]
	add	v27.2d, v27.2d, v31.2d
	add	v24.2d, v24.2d, v30.2d
	eor	v11.16b, v11.16b, v31.16b
	eor	v10.16b, v10.16b, v30.16b
	eor	v9.16b, v9.16b, v29.16b
	eor	v8.16b, v8.16b, v28.16b
	add	v23.2d, v23.2d, v27.2d
	add	v21.2d, v21.2d, v25.2d
	ldp	q28, q29, [x13, #64]
	add	v22.2d, v22.2d, v26.2d
	add	v20.2d, v20.2d, v24.2d
	ldp	q24, q25, [x15]
	uzp1	v12.4s, v8.4s, v9.4s
	uzp2	v8.4s, v8.4s, v9.4s
	ldp	q26, q27, [x15, #32]
	ldp	q30, q31, [x13, #96]
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
	sub	x15, x14, #192
	add	x14, x14, #256
	add	x13, x13, #256
	eor	v31.16b, v31.16b, v27.16b
	eor	v29.16b, v29.16b, v25.16b
	add	v21.2d, v21.2d, v25.2d
	add	v23.2d, v23.2d, v27.2d
	eor	v30.16b, v30.16b, v26.16b
	eor	v28.16b, v28.16b, v24.16b
	add	v20.2d, v20.2d, v26.2d
	add	v22.2d, v22.2d, v24.2d
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
	cmp	x15, #768
	b.lo	12b
	ext	v20.16b, v20.16b, v20.16b, #8
	add	v2.2d, v18.2d, v2.2d
	ext	v21.16b, v21.16b, v21.16b, #8
	add	v3.2d, v16.2d, v3.2d
	add	x10, x10, #1
	add	x12, x12, #1024
	ext	v22.16b, v22.16b, v22.16b, #8
	add	v0.2d, v17.2d, v0.2d
	ext	v23.16b, v23.16b, v23.16b, #8
	add	v1.2d, v19.2d, v1.2d
	add	v2.2d, v2.2d, v20.2d
	add	v3.2d, v3.2d, v21.2d
	mov	z21.d, z5.d
	add	v0.2d, v0.2d, v22.2d
	add	v1.2d, v1.2d, v23.2d
	mov	z20.d, z4.d
	ushr	v18.2d, v2.2d, #47
	ushr	v17.2d, v3.2d, #47
	ushr	v16.2d, v0.2d, #47
	ushr	v19.2d, v1.2d, #47
	eor3	z21.d, z21.d, z18.d, z2.d
	mov	z2.d, z6.d
	eor3	z20.d, z20.d, z19.d, z1.d
	eor3	z2.d, z2.d, z17.d, z3.d
	mov	z3.d, z7.d
	eor3	z3.d, z3.d, z16.d, z0.d
	mov	z16.d, x11
	mul	z0.d, z3.d, z16.d
	mul	z3.d, z2.d, z16.d
	mul	z2.d, z21.d, z16.d
	mul	z1.d, z20.d, z16.d
	cmp	x10, x9
	b.ne	2b
22:
	and	x9, x8, #0xfffffffffffffc00
	ands	x10, x8, #0x300
	add	x9, x1, x9
	b.eq	42f
	mov	x11, xzr
	movi	v16.2d, #0000000000000000
	movi	v18.2d, #0000000000000000
	movi	v17.2d, #0000000000000000
	movi	v19.2d, #0000000000000000
	movi	v4.2d, #0000000000000000
	movi	v5.2d, #0000000000000000
	movi	v6.2d, #0000000000000000
	movi	v7.2d, #0000000000000000
	.p2align	5, , 16
32:
	add	x13, x9, x11
	add	x12, x3, x11
	add	x11, x11, #256
	ldp	q21, q22, [x13]
	ldp	q23, q20, [x13, #32]
	ldp	q24, q25, [x12]
	ldp	q26, q27, [x12, #32]
	ldp	q30, q31, [x12, #160]
	eor	v27.16b, v27.16b, v20.16b
	eor	v25.16b, v25.16b, v22.16b
	add	v20.2d, v20.2d, v19.2d
	add	v18.2d, v22.2d, v18.2d
	eor	v26.16b, v26.16b, v23.16b
	eor	v24.16b, v24.16b, v21.16b
	add	v19.2d, v21.2d, v16.2d
	add	v16.2d, v23.2d, v17.2d
	ldp	q22, q21, [x13, #64]
	uzp1	v28.4s, v24.4s, v25.4s
	uzp2	v24.4s, v24.4s, v25.4s
	//APP
	//NO_APP
	//APP
	//NO_APP
	uzp1	v25.4s, v26.4s, v27.4s
	uzp2	v26.4s, v26.4s, v27.4s
	//APP
	//NO_APP
	//APP
	//NO_APP
	umlal	v4.2d, v24.2s, v28.2s
	umlal	v6.2d, v26.2s, v25.2s
	umlal2	v5.2d, v24.4s, v28.4s
	umlal2	v7.2d, v26.4s, v25.4s
	ldp	q17, q23, [x13, #96]
	ldp	q24, q25, [x12, #64]
	ldp	q26, q27, [x12, #96]
	eor	v27.16b, v27.16b, v23.16b
	eor	v25.16b, v25.16b, v21.16b
	eor	v26.16b, v26.16b, v17.16b
	eor	v24.16b, v24.16b, v22.16b
	uzp1	v28.4s, v24.4s, v25.4s
	uzp2	v24.4s, v24.4s, v25.4s
	//APP
	//NO_APP
	//APP
	//NO_APP
	uzp1	v25.4s, v26.4s, v27.4s
	uzp2	v26.4s, v26.4s, v27.4s
	//APP
	//NO_APP
	//APP
	//NO_APP
	umlal2	v7.2d, v26.4s, v25.4s
	umlal2	v5.2d, v24.4s, v28.4s
	umlal	v6.2d, v26.2s, v25.2s
	umlal	v4.2d, v24.2s, v28.2s
	ldp	q24, q25, [x13, #128]
	add	v21.2d, v21.2d, v25.2d
	add	v22.2d, v22.2d, v24.2d
	ldp	q26, q27, [x13, #160]
	ldp	q28, q29, [x12, #128]
	add	v23.2d, v23.2d, v27.2d
	add	v17.2d, v17.2d, v26.2d
	eor	v31.16b, v31.16b, v27.16b
	eor	v30.16b, v30.16b, v26.16b
	eor	v29.16b, v29.16b, v25.16b
	eor	v28.16b, v28.16b, v24.16b
	add	v20.2d, v20.2d, v23.2d
	add	v18.2d, v18.2d, v21.2d
	ldp	q24, q25, [x12, #192]
	add	v19.2d, v19.2d, v22.2d
	add	v16.2d, v16.2d, v17.2d
	ldp	q21, q22, [x13, #192]
	uzp1	v8.4s, v28.4s, v29.4s
	uzp2	v28.4s, v28.4s, v29.4s
	ldp	q17, q23, [x13, #224]
	ldp	q26, q27, [x12, #224]
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
	umlal	v4.2d, v28.2s, v8.2s
	umlal	v6.2d, v30.2s, v29.2s
	umlal2	v5.2d, v28.4s, v8.4s
	umlal2	v7.2d, v30.4s, v29.4s
	eor	v27.16b, v27.16b, v23.16b
	eor	v25.16b, v25.16b, v22.16b
	add	v18.2d, v18.2d, v22.2d
	eor	v26.16b, v26.16b, v17.16b
	eor	v24.16b, v24.16b, v21.16b
	add	v17.2d, v16.2d, v17.2d
	add	v16.2d, v19.2d, v21.2d
	add	v19.2d, v20.2d, v23.2d
	uzp1	v28.4s, v24.4s, v25.4s
	uzp2	v24.4s, v24.4s, v25.4s
	//APP
	//NO_APP
	//APP
	//NO_APP
	uzp1	v25.4s, v26.4s, v27.4s
	uzp2	v26.4s, v26.4s, v27.4s
	//APP
	//NO_APP
	//APP
	//NO_APP
	umlal2	v7.2d, v26.4s, v25.4s
	umlal2	v5.2d, v24.4s, v28.4s
	umlal	v6.2d, v26.2s, v25.2s
	umlal	v4.2d, v24.2s, v28.2s
	cmp	x11, x10
	b.lo	32b
	and	x8, x8, #0x3c0
	b	62f
42:
	movi	v4.2d, #0000000000000000
	movi	v5.2d, #0000000000000000
	movi	v6.2d, #0000000000000000
	movi	v7.2d, #0000000000000000
	movi	v16.2d, #0000000000000000
	movi	v18.2d, #0000000000000000
	movi	v17.2d, #0000000000000000
	movi	v19.2d, #0000000000000000
	and	x8, x8, #0x3c0
	b	62f
	.p2align	5, , 16
52:
	add	x11, x9, x10
	add	x12, x3, x10
	add	x10, x10, #64
	ldp	q20, q21, [x11]
	ldp	q22, q23, [x11, #32]
	ldp	q24, q25, [x12]
	ldp	q26, q27, [x12, #32]
	eor	v27.16b, v27.16b, v23.16b
	eor	v25.16b, v25.16b, v21.16b
	add	v18.2d, v21.2d, v18.2d
	add	v19.2d, v23.2d, v19.2d
	eor	v26.16b, v26.16b, v22.16b
	eor	v24.16b, v24.16b, v20.16b
	add	v17.2d, v22.2d, v17.2d
	add	v16.2d, v20.2d, v16.2d
	uzp1	v28.4s, v24.4s, v25.4s
	uzp2	v24.4s, v24.4s, v25.4s
	//APP
	//NO_APP
	//APP
	//NO_APP
	uzp1	v25.4s, v26.4s, v27.4s
	uzp2	v26.4s, v26.4s, v27.4s
	//APP
	//NO_APP
	//APP
	//NO_APP
	umlal2	v7.2d, v26.4s, v25.4s
	umlal2	v5.2d, v24.4s, v28.4s
	umlal	v6.2d, v26.2s, v25.2s
	umlal	v4.2d, v24.2s, v28.2s
62:
	cmp	x10, x8
	b.lo	52b
	add	x8, x1, x2
	ldr	q24, [x3, #1088]
	ldr	q25, [x3, #1104]
	ldr	q26, [x3, #1120]
	ldr	q27, [x3, #1136]
	ldp	q20, q21, [x8, #-64]
	add	v18.2d, v21.2d, v18.2d
	ldp	d9, d8, [sp, #32]
	ldp	q22, q23, [x8, #-32]
	add	v19.2d, v23.2d, v19.2d
	ldp	d11, d10, [sp, #16]
	eor	v27.16b, v27.16b, v23.16b
	eor	v25.16b, v25.16b, v21.16b
	add	v17.2d, v22.2d, v17.2d
	add	v16.2d, v20.2d, v16.2d
	ext	v19.16b, v19.16b, v19.16b, #8
	ext	v18.16b, v18.16b, v18.16b, #8
	eor	v26.16b, v26.16b, v22.16b
	eor	v24.16b, v24.16b, v20.16b
	ext	v16.16b, v16.16b, v16.16b, #8
	ext	v17.16b, v17.16b, v17.16b, #8
	add	v3.2d, v3.2d, v18.2d
	add	v1.2d, v1.2d, v19.2d
	uzp1	v28.4s, v24.4s, v25.4s
	uzp2	v24.4s, v24.4s, v25.4s
	//APP
	//NO_APP
	//APP
	//NO_APP
	uzp1	v25.4s, v26.4s, v27.4s
	uzp2	v26.4s, v26.4s, v27.4s
	//APP
	//NO_APP
	//APP
	//NO_APP
	add	v2.2d, v2.2d, v17.2d
	add	v0.2d, v0.2d, v16.2d
	add	v3.2d, v5.2d, v3.2d
	add	v1.2d, v7.2d, v1.2d
	add	v2.2d, v6.2d, v2.2d
	add	v0.2d, v4.2d, v0.2d
	umlal2	v1.2d, v26.4s, v25.4s
	umlal2	v3.2d, v24.4s, v28.4s
	umlal	v2.2d, v26.2s, v25.2s
	umlal	v0.2d, v24.2s, v28.2s
	stp	q0, q3, [x0]
	stp	q2, q1, [x0, #32]
	ldr	d12, [sp], #48
	ret

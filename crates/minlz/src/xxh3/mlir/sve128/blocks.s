// minlz_xxh3_blocks of crates/minlz/mlir/xxh3.mlir for sve128, written by
// cargo xtask mlir. Do not edit.
	stp	d15, d14, [sp, #-64]!
	ptrue	p0.d
	stp	d13, d12, [sp, #16]
	stp	d11, d10, [sp, #32]
	mov	x8, #128
	stp	d9, d8, [sp, #48]
	ld2d	{ z0.d, z1.d }, p0/z, [x0]
	ld2d	{ z4.d, z5.d }, p0/z, [x0, #2, mul vl]
	ld2d	{ z2.d, z3.d }, p0/z, [x3, x8, lsl #3]
	add	x8, x3, #1024
	ld2d	{ z6.d, z7.d }, p0/z, [x8, #2, mul vl]
	cmp	x2, #1
	b.lt	22f
	mov	w13, #31153
	mov	x9, #32
	mov	x10, #40
	mov	x11, #48
	mov	x12, #56
	mov	x8, xzr
	movk	w13, #40503, lsl #16
	.p2align	5, , 16
2:
	mov	x14, #-256
	movi	v16.2d, #0000000000000000
	movi	v21.2d, #0000000000000000
	movi	v17.2d, #0000000000000000
	movi	v20.2d, #0000000000000000
	movi	v18.2d, #0000000000000000
	movi	v22.2d, #0000000000000000
	movi	v19.2d, #0000000000000000
	movi	v23.2d, #0000000000000000
	.p2align	5, , 16
12:
	add	x16, x1, x14
	add	x15, x3, x14
	add	x14, x14, #256
	add	x17, x16, #256
	add	x4, x15, #384
	ld2d	{ z24.d, z25.d }, p0/z, [x16, x9, lsl #3]
	ld2d	{ z26.d, z27.d }, p0/z, [x17, #2, mul vl]
	add	x17, x15, #256
	add	z21.d, z26.d, z21.d
	ld2d	{ z28.d, z29.d }, p0/z, [x15, x9, lsl #3]
	ld2d	{ z30.d, z31.d }, p0/z, [x17, #2, mul vl]
	add	x17, x16, #320
	eor	z8.d, z30.d, z26.d
	eor	z30.d, z31.d, z27.d
	eor	z31.d, z28.d, z24.d
	eor	z28.d, z29.d, z25.d
	add	z26.d, z27.d, z20.d
	add	z20.d, z24.d, z16.d
	add	z16.d, z25.d, z17.d
	movprfx	z29, z28
	and	z29.d, z29.d, #0xffffffff
	movprfx	z9, z31
	and	z9.d, z9.d, #0xffffffff
	movprfx	z10, z30
	and	z10.d, z10.d, #0xffffffff
	movprfx	z11, z8
	and	z11.d, z11.d, #0xffffffff
	lsr	z28.d, z28.d, #32
	lsr	z31.d, z31.d, #32
	lsr	z30.d, z30.d, #32
	lsr	z8.d, z8.d, #32
	mla	z22.d, p0/m, z11.d, z8.d
	mla	z23.d, p0/m, z10.d, z30.d
	mad	z31.d, p0/m, z9.d, z18.d
	mad	z28.d, p0/m, z29.d, z19.d
	ld2d	{ z18.d, z19.d }, p0/z, [x16, x10, lsl #3]
	ld2d	{ z29.d, z30.d }, p0/z, [x17, #2, mul vl]
	add	x17, x15, #320
	ld2d	{ z8.d, z9.d }, p0/z, [x15, x10, lsl #3]
	ld2d	{ z10.d, z11.d }, p0/z, [x17, #2, mul vl]
	add	x17, x16, #384
	eor	z17.d, z9.d, z19.d
	eor	z24.d, z8.d, z18.d
	eor	z25.d, z11.d, z30.d
	eor	z27.d, z10.d, z29.d
	movprfx	z8, z27
	and	z8.d, z8.d, #0xffffffff
	movprfx	z9, z25
	and	z9.d, z9.d, #0xffffffff
	movprfx	z10, z24
	and	z10.d, z10.d, #0xffffffff
	movprfx	z11, z17
	and	z11.d, z11.d, #0xffffffff
	lsr	z27.d, z27.d, #32
	lsr	z25.d, z25.d, #32
	lsr	z24.d, z24.d, #32
	lsr	z17.d, z17.d, #32
	mad	z17.d, p0/m, z11.d, z28.d
	mad	z24.d, p0/m, z10.d, z31.d
	mla	z23.d, p0/m, z9.d, z25.d
	mla	z22.d, p0/m, z8.d, z27.d
	ld2d	{ z27.d, z28.d }, p0/z, [x16, x11, lsl #3]
	ld2d	{ z8.d, z9.d }, p0/z, [x17, #2, mul vl]
	ld2d	{ z10.d, z11.d }, p0/z, [x15, x11, lsl #3]
	ld2d	{ z12.d, z13.d }, p0/z, [x4, #2, mul vl]
	eor	z25.d, z12.d, z8.d
	eor	z31.d, z13.d, z9.d
	eor	z12.d, z10.d, z27.d
	eor	z10.d, z11.d, z28.d
	movprfx	z15, z25
	and	z15.d, z15.d, #0xffffffff
	lsr	z25.d, z25.d, #32
	movprfx	z14, z31
	and	z14.d, z14.d, #0xffffffff
	lsr	z31.d, z31.d, #32
	movprfx	z11, z10
	and	z11.d, z11.d, #0xffffffff
	lsr	z10.d, z10.d, #32
	movprfx	z13, z12
	and	z13.d, z13.d, #0xffffffff
	lsr	z12.d, z12.d, #32
	mla	z22.d, p0/m, z15.d, z25.d
	add	z25.d, z29.d, z8.d
	mla	z23.d, p0/m, z14.d, z31.d
	mla	z17.d, p0/m, z11.d, z10.d
	mla	z24.d, p0/m, z13.d, z12.d
	add	z21.d, z21.d, z25.d
	add	z25.d, z30.d, z9.d
	add	z25.d, z26.d, z25.d
	ld2d	{ z29.d, z30.d }, p0/z, [x16, x12, lsl #3]
	add	x16, x16, #448
	ld2d	{ z8.d, z9.d }, p0/z, [x16, #2, mul vl]
	add	z26.d, z18.d, z27.d
	ld2d	{ z10.d, z11.d }, p0/z, [x15, x12, lsl #3]
	add	x15, x15, #448
	ld2d	{ z12.d, z13.d }, p0/z, [x15, #2, mul vl]
	add	z18.d, z19.d, z28.d
	add	z20.d, z20.d, z26.d
	add	z16.d, z16.d, z18.d
	add	z21.d, z21.d, z8.d
	eor	z26.d, z13.d, z9.d
	eor	z27.d, z12.d, z8.d
	eor	z18.d, z11.d, z30.d
	eor	z19.d, z10.d, z29.d
	movprfx	z28, z27
	and	z28.d, z28.d, #0xffffffff
	movprfx	z31, z26
	and	z31.d, z31.d, #0xffffffff
	lsr	z27.d, z27.d, #32
	lsr	z26.d, z26.d, #32
	movprfx	z11, z18
	and	z11.d, z11.d, #0xffffffff
	lsr	z18.d, z18.d, #32
	movprfx	z10, z19
	and	z10.d, z10.d, #0xffffffff
	lsr	z12.d, z19.d, #32
	mla	z23.d, p0/m, z31.d, z26.d
	mla	z22.d, p0/m, z28.d, z27.d
	movprfx	z19, z17
	mla	z19.d, p0/m, z11.d, z18.d
	add	z17.d, z16.d, z30.d
	add	z16.d, z20.d, z29.d
	add	z20.d, z25.d, z9.d
	movprfx	z18, z24
	mla	z18.d, p0/m, z10.d, z12.d
	cmp	x14, #768
	b.lo	12b
	add	z4.d, z22.d, z4.d
	add	z0.d, z18.d, z0.d
	add	z23.d, z23.d, z5.d
	add	z5.d, z19.d, z1.d
	add	x8, x8, #1
	add	x1, x1, #1024
	add	z4.d, z4.d, z20.d
	add	z0.d, z0.d, z17.d
	add	z1.d, z5.d, z16.d
	add	z5.d, z23.d, z21.d
	lsr	z17.d, z4.d, #47
	eor	z4.d, z6.d, z4.d
	lsr	z19.d, z0.d, #47
	eor	z0.d, z2.d, z0.d
	lsr	z18.d, z1.d, #47
	eor	z1.d, z3.d, z1.d
	lsr	z16.d, z5.d, #47
	eor	z20.d, z7.d, z5.d
	eor	z4.d, z4.d, z17.d
	mov	z17.d, x13
	eor	z0.d, z0.d, z19.d
	eor	z5.d, z1.d, z18.d
	eor	z16.d, z20.d, z16.d
	mul	z0.d, p0/m, z0.d, z17.d
	movprfx	z1, z5
	mul	z1.d, p0/m, z1.d, z17.d
	mul	z4.d, p0/m, z4.d, z17.d
	movprfx	z5, z16
	mul	z5.d, p0/m, z5.d, z17.d
	cmp	x8, x2
	b.ne	2b
22:
	st2d	{ z0.d, z1.d }, p0, [x0]
	st2d	{ z4.d, z5.d }, p0, [x0, #2, mul vl]
	ldp	d9, d8, [sp, #48]
	ldp	d11, d10, [sp, #32]
	ldp	d13, d12, [sp, #16]
	ldp	d15, d14, [sp], #64
	ret

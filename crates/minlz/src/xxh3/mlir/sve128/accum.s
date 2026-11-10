// minlz_xxh3_accum of crates/minlz/mlir/xxh3.mlir for sve128, written by
// crates/minlz/mlir/build.sh. Do not edit.
	stp	d15, d14, [sp, #-64]!
	ptrue	p0.d
	stp	d13, d12, [sp, #16]
	stp	d11, d10, [sp, #32]
	mov	x9, #128
	stp	d9, d8, [sp, #48]
	add	x10, x3, #1024
	sub	x8, x2, #1
	ld2d	{ z0.d, z1.d }, p0/z, [x0]
	ld2d	{ z2.d, z3.d }, p0/z, [x0, #2, mul vl]
	ld2d	{ z4.d, z5.d }, p0/z, [x3, x9, lsl #3]
	ld2d	{ z6.d, z7.d }, p0/z, [x10, #2, mul vl]
	lsr	x9, x8, #10
	cbz	x9, 22f
	mov	w15, #31153
	mov	x11, #32
	mov	x12, #40
	mov	x13, #48
	mov	x14, #56
	mov	x10, xzr
	movk	w15, #40503, lsl #16
	mov	x16, x1
	.p2align	5, , 16
2:
	mov	x17, #-256
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
	add	x5, x16, x17
	add	x4, x3, x17
	add	x17, x17, #256
	add	x6, x5, #256
	add	x7, x4, #384
	ld2d	{ z24.d, z25.d }, p0/z, [x5, x11, lsl #3]
	ld2d	{ z26.d, z27.d }, p0/z, [x6, #2, mul vl]
	add	x6, x4, #256
	add	z21.d, z26.d, z21.d
	ld2d	{ z28.d, z29.d }, p0/z, [x4, x11, lsl #3]
	ld2d	{ z30.d, z31.d }, p0/z, [x6, #2, mul vl]
	add	x6, x5, #320
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
	ld2d	{ z18.d, z19.d }, p0/z, [x5, x12, lsl #3]
	ld2d	{ z29.d, z30.d }, p0/z, [x6, #2, mul vl]
	add	x6, x4, #320
	ld2d	{ z8.d, z9.d }, p0/z, [x4, x12, lsl #3]
	ld2d	{ z10.d, z11.d }, p0/z, [x6, #2, mul vl]
	add	x6, x5, #384
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
	ld2d	{ z27.d, z28.d }, p0/z, [x5, x13, lsl #3]
	ld2d	{ z8.d, z9.d }, p0/z, [x6, #2, mul vl]
	ld2d	{ z10.d, z11.d }, p0/z, [x4, x13, lsl #3]
	ld2d	{ z12.d, z13.d }, p0/z, [x7, #2, mul vl]
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
	ld2d	{ z29.d, z30.d }, p0/z, [x5, x14, lsl #3]
	add	x5, x5, #448
	ld2d	{ z8.d, z9.d }, p0/z, [x5, #2, mul vl]
	add	z26.d, z18.d, z27.d
	ld2d	{ z10.d, z11.d }, p0/z, [x4, x14, lsl #3]
	add	x4, x4, #448
	ld2d	{ z12.d, z13.d }, p0/z, [x4, #2, mul vl]
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
	cmp	x17, #768
	b.lo	12b
	add	z2.d, z22.d, z2.d
	add	z0.d, z18.d, z0.d
	add	z23.d, z23.d, z3.d
	add	z3.d, z19.d, z1.d
	add	x10, x10, #1
	add	x16, x16, #1024
	add	z2.d, z2.d, z20.d
	add	z0.d, z0.d, z17.d
	add	z1.d, z3.d, z16.d
	add	z3.d, z23.d, z21.d
	lsr	z17.d, z2.d, #47
	eor	z2.d, z6.d, z2.d
	lsr	z19.d, z0.d, #47
	eor	z0.d, z4.d, z0.d
	lsr	z18.d, z1.d, #47
	eor	z1.d, z5.d, z1.d
	lsr	z16.d, z3.d, #47
	eor	z20.d, z7.d, z3.d
	eor	z2.d, z2.d, z17.d
	mov	z17.d, x15
	eor	z0.d, z0.d, z19.d
	eor	z3.d, z1.d, z18.d
	eor	z16.d, z20.d, z16.d
	mul	z0.d, p0/m, z0.d, z17.d
	movprfx	z1, z3
	mul	z1.d, p0/m, z1.d, z17.d
	mul	z2.d, p0/m, z2.d, z17.d
	movprfx	z3, z16
	mul	z3.d, p0/m, z3.d, z17.d
	cmp	x10, x9
	b.ne	2b
22:
	and	x9, x8, #0xfffffffffffffc00
	ands	x10, x8, #0x300
	add	x9, x1, x9
	b.eq	42f
	mov	x12, #8
	mov	x13, #16
	mov	x14, #24
	mov	x11, xzr
	movi	v7.2d, #0000000000000000
	movi	v5.2d, #0000000000000000
	movi	v6.2d, #0000000000000000
	movi	v4.2d, #0000000000000000
	movi	v16.2d, #0000000000000000
	movi	v18.2d, #0000000000000000
	movi	v17.2d, #0000000000000000
	movi	v19.2d, #0000000000000000
	.p2align	5, , 16
32:
	add	x16, x9, x11
	add	x15, x3, x11
	add	x11, x11, #256
	add	x17, x16, #64
	add	x4, x15, #128
	ld2d	{ z25.d, z26.d }, p0/z, [x16]
	add	z7.d, z25.d, z7.d
	add	z6.d, z26.d, z6.d
	ld2d	{ z27.d, z28.d }, p0/z, [x16, #2, mul vl]
	add	z5.d, z27.d, z5.d
	add	z4.d, z28.d, z4.d
	ld2d	{ z20.d, z21.d }, p0/z, [x15]
	eor	z24.d, z20.d, z25.d
	eor	z20.d, z21.d, z26.d
	ld2d	{ z22.d, z23.d }, p0/z, [x15, #2, mul vl]
	eor	z29.d, z22.d, z27.d
	eor	z21.d, z23.d, z28.d
	movprfx	z22, z21
	and	z22.d, z22.d, #0xffffffff
	movprfx	z23, z20
	and	z23.d, z23.d, #0xffffffff
	movprfx	z30, z29
	and	z30.d, z30.d, #0xffffffff
	movprfx	z31, z24
	and	z31.d, z31.d, #0xffffffff
	lsr	z21.d, z21.d, #32
	lsr	z20.d, z20.d, #32
	lsr	z29.d, z29.d, #32
	lsr	z24.d, z24.d, #32
	mad	z31.d, p0/m, z24.d, z16.d
	mla	z18.d, p0/m, z30.d, z29.d
	mla	z17.d, p0/m, z23.d, z20.d
	mla	z19.d, p0/m, z22.d, z21.d
	ld2d	{ z23.d, z24.d }, p0/z, [x16, x12, lsl #3]
	ld2d	{ z21.d, z22.d }, p0/z, [x17, #2, mul vl]
	add	x17, x15, #64
	ld2d	{ z29.d, z30.d }, p0/z, [x15, x12, lsl #3]
	ld2d	{ z8.d, z9.d }, p0/z, [x17, #2, mul vl]
	add	x17, x16, #128
	eor	z16.d, z9.d, z22.d
	eor	z20.d, z30.d, z24.d
	eor	z25.d, z8.d, z21.d
	eor	z26.d, z29.d, z23.d
	movprfx	z27, z26
	and	z27.d, z27.d, #0xffffffff
	movprfx	z28, z25
	and	z28.d, z28.d, #0xffffffff
	movprfx	z29, z20
	and	z29.d, z29.d, #0xffffffff
	movprfx	z30, z16
	and	z30.d, z30.d, #0xffffffff
	lsr	z26.d, z26.d, #32
	lsr	z25.d, z25.d, #32
	lsr	z20.d, z20.d, #32
	lsr	z16.d, z16.d, #32
	mad	z16.d, p0/m, z30.d, z19.d
	mla	z17.d, p0/m, z29.d, z20.d
	mla	z18.d, p0/m, z28.d, z25.d
	movprfx	z19, z31
	mla	z19.d, p0/m, z27.d, z26.d
	ld2d	{ z28.d, z29.d }, p0/z, [x16, x13, lsl #3]
	ld2d	{ z30.d, z31.d }, p0/z, [x17, #2, mul vl]
	ld2d	{ z8.d, z9.d }, p0/z, [x15, x13, lsl #3]
	ld2d	{ z10.d, z11.d }, p0/z, [x4, #2, mul vl]
	eor	z26.d, z10.d, z30.d
	eor	z25.d, z8.d, z28.d
	eor	z27.d, z9.d, z29.d
	add	z9.d, z23.d, z28.d
	add	z23.d, z24.d, z29.d
	eor	z8.d, z11.d, z31.d
	add	z10.d, z21.d, z30.d
	add	z21.d, z22.d, z31.d
	ld2d	{ z28.d, z29.d }, p0/z, [x16, x14, lsl #3]
	add	x16, x16, #192
	ld2d	{ z30.d, z31.d }, p0/z, [x16, #2, mul vl]
	add	z5.d, z5.d, z10.d
	ld2d	{ z11.d, z12.d }, p0/z, [x15, x14, lsl #3]
	add	x15, x15, #192
	ld2d	{ z13.d, z14.d }, p0/z, [x15, #2, mul vl]
	add	z4.d, z4.d, z21.d
	movprfx	z24, z27
	and	z24.d, z24.d, #0xffffffff
	lsr	z27.d, z27.d, #32
	movprfx	z20, z8
	and	z20.d, z20.d, #0xffffffff
	lsr	z8.d, z8.d, #32
	mla	z17.d, p0/m, z24.d, z27.d
	mla	z16.d, p0/m, z20.d, z8.d
	add	z5.d, z5.d, z30.d
	add	z4.d, z4.d, z31.d
	add	z6.d, z6.d, z29.d
	add	z7.d, z7.d, z28.d
	eor	z22.d, z13.d, z30.d
	movprfx	z30, z26
	and	z30.d, z30.d, #0xffffffff
	lsr	z26.d, z26.d, #32
	eor	z21.d, z14.d, z31.d
	eor	z31.d, z12.d, z29.d
	eor	z10.d, z11.d, z28.d
	movprfx	z11, z25
	and	z11.d, z11.d, #0xffffffff
	lsr	z25.d, z25.d, #32
	add	z6.d, z6.d, z23.d
	add	z7.d, z7.d, z9.d
	mla	z18.d, p0/m, z30.d, z26.d
	movprfx	z29, z22
	and	z29.d, z29.d, #0xffffffff
	movprfx	z23, z31
	and	z23.d, z23.d, #0xffffffff
	lsr	z22.d, z22.d, #32
	lsr	z31.d, z31.d, #32
	mad	z25.d, p0/m, z11.d, z19.d
	movprfx	z28, z10
	and	z28.d, z28.d, #0xffffffff
	movprfx	z9, z21
	and	z9.d, z9.d, #0xffffffff
	lsr	z10.d, z10.d, #32
	lsr	z21.d, z21.d, #32
	mla	z17.d, p0/m, z23.d, z31.d
	movprfx	z19, z16
	mla	z19.d, p0/m, z9.d, z21.d
	mla	z18.d, p0/m, z29.d, z22.d
	movprfx	z16, z25
	mla	z16.d, p0/m, z28.d, z10.d
	cmp	x11, x10
	b.lo	32b
	and	x8, x8, #0x3c0
	b	62f
42:
	movi	v16.2d, #0000000000000000
	movi	v18.2d, #0000000000000000
	movi	v17.2d, #0000000000000000
	movi	v19.2d, #0000000000000000
	movi	v7.2d, #0000000000000000
	movi	v5.2d, #0000000000000000
	movi	v6.2d, #0000000000000000
	movi	v4.2d, #0000000000000000
	and	x8, x8, #0x3c0
	b	62f
	.p2align	5, , 16
52:
	add	x11, x9, x10
	ld2d	{ z20.d, z21.d }, p0/z, [x11]
	add	z6.d, z21.d, z6.d
	ld2d	{ z22.d, z23.d }, p0/z, [x11, #2, mul vl]
	add	x11, x3, x10
	add	z4.d, z23.d, z4.d
	ld2d	{ z24.d, z25.d }, p0/z, [x11]
	add	z5.d, z22.d, z5.d
	add	z7.d, z20.d, z7.d
	ld2d	{ z26.d, z27.d }, p0/z, [x11, #2, mul vl]
	add	x10, x10, #64
	eor	z28.d, z27.d, z23.d
	eor	z29.d, z25.d, z21.d
	eor	z26.d, z26.d, z22.d
	eor	z24.d, z24.d, z20.d
	movprfx	z25, z24
	and	z25.d, z25.d, #0xffffffff
	movprfx	z27, z26
	and	z27.d, z27.d, #0xffffffff
	movprfx	z30, z29
	and	z30.d, z30.d, #0xffffffff
	movprfx	z31, z28
	and	z31.d, z31.d, #0xffffffff
	lsr	z24.d, z24.d, #32
	lsr	z26.d, z26.d, #32
	lsr	z29.d, z29.d, #32
	lsr	z28.d, z28.d, #32
	mla	z19.d, p0/m, z31.d, z28.d
	mla	z17.d, p0/m, z30.d, z29.d
	mla	z18.d, p0/m, z27.d, z26.d
	mla	z16.d, p0/m, z25.d, z24.d
62:
	cmp	x10, x8
	b.lo	52b
	add	x8, x1, x2
	mov	x10, #-8
	add	z19.d, z19.d, z3.d
	add	z2.d, z18.d, z2.d
	add	z3.d, z17.d, z1.d
	add	z0.d, z16.d, z0.d
	sub	x9, x8, #64
	ld2d	{ z20.d, z21.d }, p0/z, [x8, x10, lsl #3]
	mov	x10, #136
	add	x8, x3, #1088
	ld2d	{ z22.d, z23.d }, p0/z, [x9, #2, mul vl]
	ld2d	{ z24.d, z25.d }, p0/z, [x3, x10, lsl #3]
	ld2d	{ z26.d, z27.d }, p0/z, [x8, #2, mul vl]
	add	z6.d, z21.d, z6.d
	add	z7.d, z20.d, z7.d
	add	z4.d, z23.d, z4.d
	add	z5.d, z22.d, z5.d
	eor	z28.d, z24.d, z20.d
	eor	z24.d, z25.d, z21.d
	eor	z25.d, z26.d, z22.d
	eor	z26.d, z27.d, z23.d
	movprfx	z27, z26
	and	z27.d, z27.d, #0xffffffff
	movprfx	z29, z25
	and	z29.d, z29.d, #0xffffffff
	movprfx	z30, z24
	and	z30.d, z30.d, #0xffffffff
	movprfx	z31, z28
	and	z31.d, z31.d, #0xffffffff
	lsr	z26.d, z26.d, #32
	lsr	z25.d, z25.d, #32
	lsr	z24.d, z24.d, #32
	lsr	z28.d, z28.d, #32
	mla	z0.d, p0/m, z31.d, z28.d
	mla	z3.d, p0/m, z30.d, z24.d
	mla	z2.d, p0/m, z29.d, z25.d
	mla	z19.d, p0/m, z27.d, z26.d
	add	z17.d, z19.d, z5.d
	add	z16.d, z2.d, z4.d
	add	z2.d, z3.d, z7.d
	add	z1.d, z0.d, z6.d
	st2d	{ z1.d, z2.d }, p0, [x0]
	st2d	{ z16.d, z17.d }, p0, [x0, #2, mul vl]
	ldp	d9, d8, [sp, #48]
	ldp	d11, d10, [sp, #32]
	ldp	d13, d12, [sp, #16]
	ldp	d15, d14, [sp], #64
	ret

// minlz_xxh3_blocks of crates/minlz/mlir/xxh3.mlir for sve256, written by
// cargo xtask mlir. Do not edit.
	ptrue	p0.d
	mov	x8, #128
	ld2d	{ z0.d, z1.d }, p0/z, [x0]
	ld2d	{ z2.d, z3.d }, p0/z, [x3, x8, lsl #3]
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
	movi	v4.2d, #0000000000000000
	movi	v5.2d, #0000000000000000
	movi	v7.2d, #0000000000000000
	movi	v6.2d, #0000000000000000
	.p2align	5, , 16
12:
	add	x15, x1, x14
	add	x16, x3, x14
	add	x14, x14, #256
	ld2d	{ z16.d, z17.d }, p0/z, [x15, x9, lsl #3]
	ld2d	{ z18.d, z19.d }, p0/z, [x16, x9, lsl #3]
	eor	z20.d, z18.d, z16.d
	eor	z18.d, z19.d, z17.d
	add	z4.d, z16.d, z4.d
	add	z5.d, z17.d, z5.d
	movprfx	z21, z20
	and	z21.d, z21.d, #0xffffffff
	lsr	z20.d, z20.d, #32
	movprfx	z19, z18
	and	z19.d, z19.d, #0xffffffff
	lsr	z18.d, z18.d, #32
	mla	z7.d, p0/m, z21.d, z20.d
	mla	z6.d, p0/m, z19.d, z18.d
	ld2d	{ z20.d, z21.d }, p0/z, [x15, x10, lsl #3]
	ld2d	{ z22.d, z23.d }, p0/z, [x16, x10, lsl #3]
	eor	z16.d, z23.d, z21.d
	eor	z17.d, z22.d, z20.d
	movprfx	z18, z17
	and	z18.d, z18.d, #0xffffffff
	movprfx	z19, z16
	and	z19.d, z19.d, #0xffffffff
	lsr	z17.d, z17.d, #32
	lsr	z16.d, z16.d, #32
	mla	z6.d, p0/m, z19.d, z16.d
	mla	z7.d, p0/m, z18.d, z17.d
	ld2d	{ z16.d, z17.d }, p0/z, [x15, x11, lsl #3]
	ld2d	{ z18.d, z19.d }, p0/z, [x16, x11, lsl #3]
	eor	z22.d, z18.d, z16.d
	eor	z18.d, z19.d, z17.d
	movprfx	z19, z18
	and	z19.d, z19.d, #0xffffffff
	lsr	z18.d, z18.d, #32
	movprfx	z23, z22
	and	z23.d, z23.d, #0xffffffff
	lsr	z22.d, z22.d, #32
	mla	z6.d, p0/m, z19.d, z18.d
	add	z18.d, z20.d, z16.d
	add	z16.d, z21.d, z17.d
	mla	z7.d, p0/m, z23.d, z22.d
	add	z4.d, z4.d, z18.d
	add	z5.d, z5.d, z16.d
	ld2d	{ z16.d, z17.d }, p0/z, [x15, x12, lsl #3]
	ld2d	{ z18.d, z19.d }, p0/z, [x16, x12, lsl #3]
	eor	z20.d, z19.d, z17.d
	eor	z18.d, z18.d, z16.d
	add	z5.d, z5.d, z17.d
	add	z4.d, z4.d, z16.d
	movprfx	z19, z18
	and	z19.d, z19.d, #0xffffffff
	movprfx	z21, z20
	and	z21.d, z21.d, #0xffffffff
	lsr	z18.d, z18.d, #32
	lsr	z20.d, z20.d, #32
	mla	z6.d, p0/m, z21.d, z20.d
	mla	z7.d, p0/m, z19.d, z18.d
	cmp	x14, #768
	b.lo	12b
	add	z0.d, z7.d, z0.d
	add	z6.d, z6.d, z1.d
	add	x8, x8, #1
	add	x1, x1, #1024
	add	z0.d, z0.d, z5.d
	add	z1.d, z6.d, z4.d
	lsr	z5.d, z0.d, #47
	eor	z0.d, z2.d, z0.d
	lsr	z4.d, z1.d, #47
	eor	z6.d, z3.d, z1.d
	eor	z0.d, z0.d, z5.d
	mov	z5.d, x13
	eor	z4.d, z6.d, z4.d
	mul	z0.d, p0/m, z0.d, z5.d
	movprfx	z1, z4
	mul	z1.d, p0/m, z1.d, z5.d
	cmp	x8, x2
	b.ne	2b
22:
	st2d	{ z0.d, z1.d }, p0, [x0]
	ret

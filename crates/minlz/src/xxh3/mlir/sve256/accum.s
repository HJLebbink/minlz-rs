// minlz_xxh3_accum of crates/minlz/mlir/xxh3.mlir for sve256, written by
// cargo xtask mlir. Do not edit.
	ptrue	p0.d
	mov	x10, #128
	sub	x8, x2, #1
	lsr	x9, x8, #10
	ld2d	{ z0.d, z1.d }, p0/z, [x0]
	ld2d	{ z2.d, z3.d }, p0/z, [x3, x10, lsl #3]
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
	movi	v4.2d, #0000000000000000
	movi	v5.2d, #0000000000000000
	movi	v7.2d, #0000000000000000
	movi	v6.2d, #0000000000000000
	.p2align	5, , 16
12:
	add	x4, x16, x17
	add	x5, x3, x17
	add	x17, x17, #256
	ld2d	{ z16.d, z17.d }, p0/z, [x4, x11, lsl #3]
	ld2d	{ z18.d, z19.d }, p0/z, [x5, x11, lsl #3]
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
	ld2d	{ z20.d, z21.d }, p0/z, [x4, x12, lsl #3]
	ld2d	{ z22.d, z23.d }, p0/z, [x5, x12, lsl #3]
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
	ld2d	{ z16.d, z17.d }, p0/z, [x4, x13, lsl #3]
	ld2d	{ z18.d, z19.d }, p0/z, [x5, x13, lsl #3]
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
	ld2d	{ z16.d, z17.d }, p0/z, [x4, x14, lsl #3]
	ld2d	{ z18.d, z19.d }, p0/z, [x5, x14, lsl #3]
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
	cmp	x17, #768
	b.lo	12b
	add	z0.d, z7.d, z0.d
	add	z6.d, z6.d, z1.d
	add	x10, x10, #1
	add	x16, x16, #1024
	add	z0.d, z0.d, z5.d
	add	z1.d, z6.d, z4.d
	lsr	z5.d, z0.d, #47
	eor	z0.d, z2.d, z0.d
	lsr	z4.d, z1.d, #47
	eor	z6.d, z3.d, z1.d
	eor	z0.d, z0.d, z5.d
	mov	z5.d, x15
	eor	z4.d, z6.d, z4.d
	mul	z0.d, p0/m, z0.d, z5.d
	movprfx	z1, z4
	mul	z1.d, p0/m, z1.d, z5.d
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
	movi	v2.2d, #0000000000000000
	movi	v4.2d, #0000000000000000
	movi	v5.2d, #0000000000000000
	movi	v3.2d, #0000000000000000
	.p2align	5, , 16
32:
	add	x15, x9, x11
	add	x16, x3, x11
	add	x11, x11, #256
	ld2d	{ z6.d, z7.d }, p0/z, [x15]
	add	z2.d, z6.d, z2.d
	add	z4.d, z7.d, z4.d
	ld2d	{ z16.d, z17.d }, p0/z, [x16]
	eor	z18.d, z16.d, z6.d
	eor	z16.d, z17.d, z7.d
	movprfx	z19, z18
	and	z19.d, z19.d, #0xffffffff
	lsr	z18.d, z18.d, #32
	movprfx	z17, z16
	and	z17.d, z17.d, #0xffffffff
	lsr	z16.d, z16.d, #32
	mla	z5.d, p0/m, z19.d, z18.d
	mla	z3.d, p0/m, z17.d, z16.d
	ld2d	{ z18.d, z19.d }, p0/z, [x15, x12, lsl #3]
	ld2d	{ z20.d, z21.d }, p0/z, [x16, x12, lsl #3]
	eor	z6.d, z21.d, z19.d
	eor	z7.d, z20.d, z18.d
	movprfx	z16, z7
	and	z16.d, z16.d, #0xffffffff
	movprfx	z17, z6
	and	z17.d, z17.d, #0xffffffff
	lsr	z7.d, z7.d, #32
	lsr	z6.d, z6.d, #32
	mla	z3.d, p0/m, z17.d, z6.d
	mla	z5.d, p0/m, z16.d, z7.d
	ld2d	{ z6.d, z7.d }, p0/z, [x15, x13, lsl #3]
	ld2d	{ z16.d, z17.d }, p0/z, [x16, x13, lsl #3]
	eor	z20.d, z16.d, z6.d
	add	z21.d, z18.d, z6.d
	add	z6.d, z19.d, z7.d
	eor	z16.d, z17.d, z7.d
	movprfx	z7, z16
	and	z7.d, z7.d, #0xffffffff
	lsr	z16.d, z16.d, #32
	ld2d	{ z18.d, z19.d }, p0/z, [x15, x14, lsl #3]
	ld2d	{ z22.d, z23.d }, p0/z, [x16, x14, lsl #3]
	movprfx	z17, z20
	and	z17.d, z17.d, #0xffffffff
	lsr	z20.d, z20.d, #32
	mla	z3.d, p0/m, z7.d, z16.d
	mla	z5.d, p0/m, z17.d, z20.d
	eor	z7.d, z23.d, z19.d
	eor	z16.d, z22.d, z18.d
	add	z4.d, z4.d, z19.d
	add	z2.d, z2.d, z18.d
	movprfx	z17, z16
	and	z17.d, z17.d, #0xffffffff
	movprfx	z20, z7
	and	z20.d, z20.d, #0xffffffff
	lsr	z16.d, z16.d, #32
	lsr	z7.d, z7.d, #32
	add	z4.d, z4.d, z6.d
	add	z2.d, z2.d, z21.d
	mla	z3.d, p0/m, z20.d, z7.d
	mla	z5.d, p0/m, z17.d, z16.d
	cmp	x11, x10
	b.lo	32b
	and	x8, x8, #0x3c0
	b	62f
42:
	movi	v5.2d, #0000000000000000
	movi	v3.2d, #0000000000000000
	movi	v2.2d, #0000000000000000
	movi	v4.2d, #0000000000000000
	and	x8, x8, #0x3c0
	b	62f
	.p2align	5, , 16
52:
	add	x11, x9, x10
	ld2d	{ z6.d, z7.d }, p0/z, [x11]
	add	x11, x3, x10
	add	x10, x10, #64
	ld2d	{ z16.d, z17.d }, p0/z, [x11]
	add	z4.d, z7.d, z4.d
	add	z2.d, z6.d, z2.d
	eor	z18.d, z17.d, z7.d
	eor	z16.d, z16.d, z6.d
	movprfx	z17, z16
	and	z17.d, z17.d, #0xffffffff
	movprfx	z19, z18
	and	z19.d, z19.d, #0xffffffff
	lsr	z16.d, z16.d, #32
	lsr	z18.d, z18.d, #32
	mla	z3.d, p0/m, z19.d, z18.d
	mla	z5.d, p0/m, z17.d, z16.d
62:
	cmp	x10, x8
	b.lo	52b
	add	x8, x1, x2
	mov	x9, #-8
	mov	x10, #136
	add	z3.d, z3.d, z1.d
	add	z0.d, z5.d, z0.d
	ld2d	{ z6.d, z7.d }, p0/z, [x8, x9, lsl #3]
	ld2d	{ z16.d, z17.d }, p0/z, [x3, x10, lsl #3]
	eor	z18.d, z16.d, z6.d
	eor	z16.d, z17.d, z7.d
	add	z2.d, z6.d, z2.d
	add	z4.d, z7.d, z4.d
	movprfx	z17, z16
	and	z17.d, z17.d, #0xffffffff
	movprfx	z19, z18
	and	z19.d, z19.d, #0xffffffff
	lsr	z16.d, z16.d, #32
	lsr	z18.d, z18.d, #32
	mla	z0.d, p0/m, z19.d, z18.d
	mla	z3.d, p0/m, z17.d, z16.d
	add	z2.d, z3.d, z2.d
	add	z1.d, z0.d, z4.d
	st2d	{ z1.d, z2.d }, p0, [x0]
	ret

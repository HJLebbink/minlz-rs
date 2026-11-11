// minlz_exec_plain of crates/minlz/mlir/exec8.mlir for neon, written by
// cargo xtask mlir. Do not edit.
	ldr	x8, [x0, #64]
	mov	x16, #72340172838076673
	//APP
	//NO_APP
	cbz	x8, 792f
	stp	x29, x30, [sp, #-96]!
	ldp	x15, x17, [x0, #16]
	ldp	x1, x11, [x0, #32]
	stp	x24, x23, [sp, #48]
	stp	x22, x21, [sp, #64]
	ldp	x9, x10, [x0]
	ldr	x12, [x0, #56]
	ldr	x14, [x15]
	ldr	d0, [x17]
	ldp	x22, x21, [x0, #88]
	ldp	x23, x24, [x0, #72]
	and	x13, x16, x14, lsr #1
	bic	x2, x16, x14
	and	x14, x14, x16
	stp	x28, x27, [sp, #16]
	stp	x26, x25, [sp, #32]
	stp	x20, x19, [sp, #80]
	mul	x4, x13, x16
	sub	x3, x4, x13
	eor	x13, x13, x16
	orr	x13, x3, x13, lsl #7
	mul	x3, x2, x16
	fmov	d1, x13
	sub	x2, x3, x2
	orr	x14, x2, x14, lsl #7
	tbl	v0.8b, { v0.16b }, v1.8b
	fmov	d1, x14
	fmov	x13, d0
	ldr	d0, [x1]
	tbl	v0.8b, { v0.16b }, v1.8b
	fmov	x14, d0
	cmp	x8, #8
	b.lo	672f
	lsr	x3, x3, #56
	lsr	x4, x4, #56
	mov	x2, xzr
	mov	x6, x15
	.p2align	5, , 16
2:
	subs	x8, x8, #8
	mov	x20, x13
	mov	x19, x14
	b.ne	12f
	mov	x13, x20
	mov	x14, x19
	b	22f
	.p2align	5, , 16
12:
	ldr	x14, [x6, #8]
	ldr	d0, [x17, x4]
	and	x13, x16, x14, lsr #1
	bic	x5, x16, x14
	and	x14, x14, x16
	mul	x7, x13, x16
	sub	x25, x7, x13
	eor	x13, x13, x16
	add	x4, x4, x7, lsr #56
	mul	x7, x5, x16
	orr	x13, x25, x13, lsl #7
	fmov	d1, x13
	sub	x5, x7, x5
	orr	x14, x5, x14, lsl #7
	tbl	v0.8b, { v0.16b }, v1.8b
	fmov	d1, x14
	fmov	x13, d0
	ldr	d0, [x1, x3]
	add	x3, x3, x7, lsr #56
	tbl	v0.8b, { v0.16b }, v1.8b
	fmov	x14, d0
22:
	ubfiz	x5, x19, #3, #8
	and	x27, x23, #0x7
	ldr	x7, [x6]
	and	x26, x20, #0xff
	add	x28, x9, x24
	ldr	x25, [x12, x5]
	lsr	x5, x23, #3
	ldr	x5, [x11, x5]
	lsr	x5, x5, x27
	add	x27, x10, x22
	and	w5, w25, w5
	adds	x5, x5, x25, lsr #40
	ldp	q0, q1, [x27]
	csel	x21, x21, x5, eq
	stp	q0, q1, [x28]
	cmp	x26, #33
	b.hs	272f
32:
	and	x30, x7, #0xff
	add	x24, x26, x24
	lsr	x27, x30, #2
	cmp	x21, x27
	ccmp	x24, x21, #0, hs
	b.lo	512f
	sub	x29, x24, x21
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	mov	x5, x21
42:
	add	x28, x9, x24
	stp	q0, q1, [x28]
	cmp	x30, #132
	b.hs	282f
52:
	lsr	x5, x25, #32
	add	x22, x26, x22
	add	x26, x27, x24
	ubfx	x25, x20, #8, #8
	add	x23, x23, w5, uxtb
	lsr	x5, x19, #5
	add	x28, x9, x26
	and	x5, x5, #0x7f8
	ldr	x24, [x12, x5]
	lsr	x5, x23, #3
	and	x27, x23, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x27
	add	x27, x10, x22
	ldp	q0, q1, [x27]
	and	w5, w24, w5
	adds	x5, x5, x24, lsr #40
	csel	x21, x21, x5, eq
	stp	q0, q1, [x28]
	cmp	x25, #33
	b.hs	302f
62:
	ubfx	x30, x7, #8, #8
	add	x26, x25, x26
	lsr	x27, x30, #2
	cmp	x21, x27
	ccmp	x26, x21, #0, hs
	b.lo	522f
	sub	x29, x26, x21
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	mov	x5, x21
72:
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x30, #132
	b.hs	312f
82:
	lsr	x5, x24, #32
	add	x22, x25, x22
	add	x27, x27, x26
	ubfx	x26, x20, #16, #8
	add	x24, x23, w5, uxtb
	lsr	x5, x19, #13
	add	x28, x9, x27
	and	x5, x5, #0x7f8
	ldr	x25, [x12, x5]
	lsr	x5, x24, #3
	and	x23, x24, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x23
	and	w5, w25, w5
	adds	x5, x5, x25, lsr #40
	csel	x23, x21, x5, eq
	add	x21, x10, x22
	ldp	q0, q1, [x21]
	stp	q0, q1, [x28]
	cmp	x26, #33
	b.hs	332f
92:
	ubfx	x30, x7, #16, #8
	add	x27, x26, x27
	lsr	x28, x30, #2
	cmp	x23, x28
	ccmp	x27, x23, #0, hs
	b.lo	532f
	sub	x29, x27, x23
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	mov	x5, x23
102:
	add	x21, x9, x27
	stp	q0, q1, [x21]
	cmp	x30, #132
	b.hs	342f
112:
	lsr	x5, x25, #32
	add	x22, x26, x22
	add	x26, x28, x27
	lsr	w25, w20, #24
	add	x21, x24, w5, uxtb
	lsr	x5, x19, #21
	add	x28, x9, x26
	and	x5, x5, #0x7f8
	ldr	x24, [x12, x5]
	lsr	x5, x21, #3
	and	x27, x21, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x27
	add	x27, x10, x22
	ldp	q0, q1, [x27]
	and	w5, w24, w5
	adds	x5, x5, x24, lsr #40
	csel	x23, x23, x5, eq
	stp	q0, q1, [x28]
	cmp	x25, #33
	b.hs	362f
122:
	lsr	w30, w7, #24
	add	x26, x25, x26
	lsr	x27, x30, #2
	cmp	x23, x27
	b.lo	542f
	subs	x29, x26, x23
	b.lo	542f
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	mov	x5, x23
132:
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x30, #132
	b.hs	372f
142:
	lsr	x5, x24, #32
	add	x22, x25, x22
	add	x27, x27, x26
	ubfx	x26, x20, #32, #8
	add	x24, x21, w5, uxtb
	lsr	x5, x19, #29
	add	x28, x9, x27
	and	x5, x5, #0x7f8
	ldr	x25, [x12, x5]
	lsr	x5, x24, #3
	and	x21, x24, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x21
	and	w5, w25, w5
	adds	x5, x5, x25, lsr #40
	csel	x21, x23, x5, eq
	add	x23, x10, x22
	ldp	q0, q1, [x23]
	stp	q0, q1, [x28]
	cmp	x26, #33
	b.hs	392f
152:
	ubfx	x30, x7, #32, #8
	add	x27, x26, x27
	lsr	x28, x30, #2
	cmp	x21, x28
	b.lo	552f
	subs	x29, x27, x21
	b.lo	552f
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	mov	x5, x21
162:
	add	x23, x9, x27
	stp	q0, q1, [x23]
	cmp	x30, #132
	b.hs	402f
172:
	lsr	x5, x25, #32
	add	x22, x26, x22
	add	x26, x28, x27
	ubfx	x25, x20, #40, #8
	add	x23, x24, w5, uxtb
	lsr	x5, x19, #37
	add	x28, x9, x26
	and	x5, x5, #0x7f8
	ldr	x24, [x12, x5]
	lsr	x5, x23, #3
	and	x27, x23, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x27
	add	x27, x10, x22
	ldp	q0, q1, [x27]
	and	w5, w24, w5
	adds	x5, x5, x24, lsr #40
	csel	x21, x21, x5, eq
	stp	q0, q1, [x28]
	cmp	x25, #33
	b.hs	422f
182:
	ubfx	x30, x7, #40, #8
	add	x26, x25, x26
	lsr	x27, x30, #2
	cmp	x21, x27
	b.lo	562f
	subs	x29, x26, x21
	b.lo	562f
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	mov	x5, x21
192:
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x30, #132
	b.hs	432f
202:
	lsr	x5, x24, #32
	add	x22, x25, x22
	add	x26, x27, x26
	ubfx	x25, x20, #48, #8
	add	x23, x23, w5, uxtb
	lsr	x5, x19, #45
	add	x28, x9, x26
	and	x5, x5, #0x7f8
	ldr	x24, [x12, x5]
	lsr	x5, x23, #3
	and	x27, x23, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x27
	add	x27, x10, x22
	ldp	q0, q1, [x27]
	and	w5, w24, w5
	adds	x5, x5, x24, lsr #40
	csel	x21, x21, x5, eq
	stp	q0, q1, [x28]
	cmp	x25, #33
	b.hs	452f
212:
	ubfx	x30, x7, #48, #8
	add	x26, x25, x26
	lsr	x27, x30, #2
	cmp	x21, x27
	b.lo	572f
	subs	x29, x26, x21
	b.lo	572f
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	mov	x5, x21
222:
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x30, #132
	b.hs	462f
232:
	lsr	x5, x24, #32
	add	x22, x25, x22
	add	x24, x27, x26
	lsr	x20, x20, #56
	add	x23, x23, w5, uxtb
	lsr	x5, x19, #53
	add	x26, x9, x24
	and	x5, x5, #0x7f8
	ldr	x19, [x12, x5]
	lsr	x5, x23, #3
	and	x25, x23, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x25
	add	x25, x10, x22
	ldp	q0, q1, [x25]
	and	w5, w19, w5
	adds	x5, x5, x19, lsr #40
	csel	x21, x21, x5, eq
	stp	q0, q1, [x26]
	cmp	x20, #33
	b.hs	482f
242:
	add	x24, x20, x24
	lsr	x7, x7, #58
	cmp	x21, x7
	b.lo	582f
	subs	x26, x24, x21
	b.lo	582f
	add	x5, x9, x26
	ldp	q0, q1, [x5]
	mov	x5, x21
252:
	add	x25, x9, x24
	stp	q0, q1, [x25]
	cmp	x7, #33
	b.hs	492f
262:
	lsr	x5, x19, #32
	add	x22, x20, x22
	add	x24, x7, x24
	sub	x2, x2, #8
	add	x6, x6, #8
	add	x23, x23, w5, uxtb
	cmp	x8, #7
	b.hi	2b
	b	682f
272:
	ldr	x5, [x0, #48]
	ldr	x26, [x0, #120]
	ldrb	w29, [x5, x26]
	add	x5, x26, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x26, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	32b
	ldp	q0, q1, [x27, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	32b
	ldp	q0, q1, [x27, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	32b
	ldp	q0, q1, [x27, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 32b
	ldp	q0, q1, [x27, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	32b
	ldp	q0, q1, [x27, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	32b
	ldp	q0, q1, [x27, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	32b
	ldp	q0, q1, [x27, #256]
	stp	q0, q1, [x28, #256]
	b	32b
282:
	cmp	x5, #31
	b.hi	292f
	mov	w5, #1
	str	x5, [x0, #104]
292:
	ldr	x5, [x0, #48]
	ldr	x27, [x0, #120]
	add	x29, x9, x29
	ldrb	w30, [x5, x27]
	add	x5, x27, #1
	add	x27, x30, #33
	str	x5, [x0, #120]
	ldp	q0, q1, [x29, #32]
	stp	q0, q1, [x28, #32]
	cmp	w30, #32
	b.lo	52b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x28, #64]
	cmp	w30, #64
	b.lo	52b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x28, #96]
	cmp	w30, #96
	b.lo	52b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x28, #128]
	tbz	w30, #7, 52b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x28, #160]
	cmp	w30, #160
	b.lo	52b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x28, #192]
	cmp	w30, #192
	b.lo	52b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x28, #224]
	cmp	w30, #224
	b.lo	52b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x28, #256]
	b	52b
302:
	ldr	x5, [x0, #48]
	ldr	x25, [x0, #120]
	ldrb	w29, [x5, x25]
	add	x5, x25, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x25, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	62b
	ldp	q0, q1, [x27, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	62b
	ldp	q0, q1, [x27, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	62b
	ldp	q0, q1, [x27, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 62b
	ldp	q0, q1, [x27, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	62b
	ldp	q0, q1, [x27, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	62b
	ldp	q0, q1, [x27, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	62b
	ldp	q0, q1, [x27, #256]
	stp	q0, q1, [x28, #256]
	b	62b
312:
	cmp	x5, #31
	b.hi	322f
	mov	w5, #1
	str	x5, [x0, #104]
322:
	ldr	x5, [x0, #48]
	ldr	x27, [x0, #120]
	add	x29, x9, x29
	ldrb	w30, [x5, x27]
	add	x5, x27, #1
	add	x27, x30, #33
	str	x5, [x0, #120]
	ldp	q0, q1, [x29, #32]
	stp	q0, q1, [x28, #32]
	cmp	w30, #32
	b.lo	82b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x28, #64]
	cmp	w30, #64
	b.lo	82b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x28, #96]
	cmp	w30, #96
	b.lo	82b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x28, #128]
	tbz	w30, #7, 82b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x28, #160]
	cmp	w30, #160
	b.lo	82b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x28, #192]
	cmp	w30, #192
	b.lo	82b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x28, #224]
	cmp	w30, #224
	b.lo	82b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x28, #256]
	b	82b
332:
	ldr	x5, [x0, #48]
	ldr	x26, [x0, #120]
	ldrb	w29, [x5, x26]
	add	x5, x26, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x21, #32]
	add	x26, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	92b
	ldp	q0, q1, [x21, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	92b
	ldp	q0, q1, [x21, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	92b
	ldp	q0, q1, [x21, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 92b
	ldp	q0, q1, [x21, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	92b
	ldp	q0, q1, [x21, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	92b
	ldp	q0, q1, [x21, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	92b
	ldp	q0, q1, [x21, #256]
	stp	q0, q1, [x28, #256]
	b	92b
342:
	cmp	x5, #31
	b.hi	352f
	mov	w5, #1
	str	x5, [x0, #104]
352:
	ldr	x5, [x0, #48]
	ldr	x28, [x0, #120]
	add	x29, x9, x29
	ldrb	w30, [x5, x28]
	add	x5, x28, #1
	add	x28, x30, #33
	str	x5, [x0, #120]
	ldp	q0, q1, [x29, #32]
	stp	q0, q1, [x21, #32]
	cmp	w30, #32
	b.lo	112b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x21, #64]
	cmp	w30, #64
	b.lo	112b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x21, #96]
	cmp	w30, #96
	b.lo	112b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x21, #128]
	tbz	w30, #7, 112b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x21, #160]
	cmp	w30, #160
	b.lo	112b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x21, #192]
	cmp	w30, #192
	b.lo	112b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x21, #224]
	cmp	w30, #224
	b.lo	112b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x21, #256]
	b	112b
362:
	ldr	x5, [x0, #48]
	ldr	x25, [x0, #120]
	ldrb	w29, [x5, x25]
	add	x5, x25, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x25, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	122b
	ldp	q0, q1, [x27, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	122b
	ldp	q0, q1, [x27, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	122b
	ldp	q0, q1, [x27, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 122b
	ldp	q0, q1, [x27, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	122b
	ldp	q0, q1, [x27, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	122b
	ldp	q0, q1, [x27, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	122b
	ldp	q0, q1, [x27, #256]
	stp	q0, q1, [x28, #256]
	b	122b
372:
	cmp	x5, #31
	b.hi	382f
	mov	w5, #1
	str	x5, [x0, #104]
382:
	ldr	x5, [x0, #48]
	ldr	x27, [x0, #120]
	add	x29, x9, x29
	ldrb	w30, [x5, x27]
	add	x5, x27, #1
	add	x27, x30, #33
	str	x5, [x0, #120]
	ldp	q0, q1, [x29, #32]
	stp	q0, q1, [x28, #32]
	cmp	w30, #32
	b.lo	142b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x28, #64]
	cmp	w30, #64
	b.lo	142b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x28, #96]
	cmp	w30, #96
	b.lo	142b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x28, #128]
	tbz	w30, #7, 142b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x28, #160]
	cmp	w30, #160
	b.lo	142b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x28, #192]
	cmp	w30, #192
	b.lo	142b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x28, #224]
	cmp	w30, #224
	b.lo	142b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x28, #256]
	b	142b
392:
	ldr	x5, [x0, #48]
	ldr	x26, [x0, #120]
	ldrb	w29, [x5, x26]
	add	x5, x26, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x23, #32]
	add	x26, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	152b
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	152b
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	152b
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 152b
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	152b
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	152b
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	152b
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x28, #256]
	b	152b
402:
	cmp	x5, #31
	b.hi	412f
	mov	w5, #1
	str	x5, [x0, #104]
412:
	ldr	x5, [x0, #48]
	ldr	x28, [x0, #120]
	add	x29, x9, x29
	ldrb	w30, [x5, x28]
	add	x5, x28, #1
	add	x28, x30, #33
	str	x5, [x0, #120]
	ldp	q0, q1, [x29, #32]
	stp	q0, q1, [x23, #32]
	cmp	w30, #32
	b.lo	172b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x23, #64]
	cmp	w30, #64
	b.lo	172b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x23, #96]
	cmp	w30, #96
	b.lo	172b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x23, #128]
	tbz	w30, #7, 172b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x23, #160]
	cmp	w30, #160
	b.lo	172b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x23, #192]
	cmp	w30, #192
	b.lo	172b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x23, #224]
	cmp	w30, #224
	b.lo	172b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x23, #256]
	b	172b
422:
	ldr	x5, [x0, #48]
	ldr	x25, [x0, #120]
	ldrb	w29, [x5, x25]
	add	x5, x25, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x25, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	182b
	ldp	q0, q1, [x27, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	182b
	ldp	q0, q1, [x27, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	182b
	ldp	q0, q1, [x27, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 182b
	ldp	q0, q1, [x27, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	182b
	ldp	q0, q1, [x27, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	182b
	ldp	q0, q1, [x27, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	182b
	ldp	q0, q1, [x27, #256]
	stp	q0, q1, [x28, #256]
	b	182b
432:
	cmp	x5, #31
	b.hi	442f
	mov	w5, #1
	str	x5, [x0, #104]
442:
	ldr	x5, [x0, #48]
	ldr	x27, [x0, #120]
	add	x29, x9, x29
	ldrb	w30, [x5, x27]
	add	x5, x27, #1
	add	x27, x30, #33
	str	x5, [x0, #120]
	ldp	q0, q1, [x29, #32]
	stp	q0, q1, [x28, #32]
	cmp	w30, #32
	b.lo	202b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x28, #64]
	cmp	w30, #64
	b.lo	202b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x28, #96]
	cmp	w30, #96
	b.lo	202b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x28, #128]
	tbz	w30, #7, 202b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x28, #160]
	cmp	w30, #160
	b.lo	202b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x28, #192]
	cmp	w30, #192
	b.lo	202b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x28, #224]
	cmp	w30, #224
	b.lo	202b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x28, #256]
	b	202b
452:
	ldr	x5, [x0, #48]
	ldr	x25, [x0, #120]
	ldrb	w29, [x5, x25]
	add	x5, x25, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x25, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	212b
	ldp	q0, q1, [x27, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	212b
	ldp	q0, q1, [x27, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	212b
	ldp	q0, q1, [x27, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 212b
	ldp	q0, q1, [x27, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	212b
	ldp	q0, q1, [x27, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	212b
	ldp	q0, q1, [x27, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	212b
	ldp	q0, q1, [x27, #256]
	stp	q0, q1, [x28, #256]
	b	212b
462:
	cmp	x5, #31
	b.hi	472f
	mov	w5, #1
	str	x5, [x0, #104]
472:
	ldr	x5, [x0, #48]
	ldr	x27, [x0, #120]
	add	x29, x9, x29
	ldrb	w30, [x5, x27]
	add	x5, x27, #1
	add	x27, x30, #33
	str	x5, [x0, #120]
	ldp	q0, q1, [x29, #32]
	stp	q0, q1, [x28, #32]
	cmp	w30, #32
	b.lo	232b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x28, #64]
	cmp	w30, #64
	b.lo	232b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x28, #96]
	cmp	w30, #96
	b.lo	232b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x28, #128]
	tbz	w30, #7, 232b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x28, #160]
	cmp	w30, #160
	b.lo	232b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x28, #192]
	cmp	w30, #192
	b.lo	232b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x28, #224]
	cmp	w30, #224
	b.lo	232b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x28, #256]
	b	232b
482:
	ldr	x5, [x0, #48]
	ldr	x20, [x0, #120]
	ldrb	w27, [x5, x20]
	add	x5, x20, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x25, #32]
	add	x20, x27, #33
	stp	q0, q1, [x26, #32]
	cmp	w27, #32
	b.lo	242b
	ldp	q0, q1, [x25, #64]
	stp	q0, q1, [x26, #64]
	cmp	w27, #64
	b.lo	242b
	ldp	q0, q1, [x25, #96]
	stp	q0, q1, [x26, #96]
	cmp	w27, #96
	b.lo	242b
	ldp	q0, q1, [x25, #128]
	stp	q0, q1, [x26, #128]
	tbz	w27, #7, 242b
	ldp	q0, q1, [x25, #160]
	stp	q0, q1, [x26, #160]
	cmp	w27, #160
	b.lo	242b
	ldp	q0, q1, [x25, #192]
	stp	q0, q1, [x26, #192]
	cmp	w27, #192
	b.lo	242b
	ldp	q0, q1, [x25, #224]
	stp	q0, q1, [x26, #224]
	cmp	w27, #224
	b.lo	242b
	ldp	q0, q1, [x25, #256]
	stp	q0, q1, [x26, #256]
	b	242b
492:
	cmp	x5, #31
	b.hi	502f
	mov	w5, #1
	str	x5, [x0, #104]
502:
	ldr	x5, [x0, #48]
	ldr	x7, [x0, #120]
	add	x26, x9, x26
	ldrb	w27, [x5, x7]
	add	x5, x7, #1
	add	x7, x27, #33
	str	x5, [x0, #120]
	ldp	q0, q1, [x26, #32]
	stp	q0, q1, [x25, #32]
	cmp	w27, #32
	b.lo	262b
	ldp	q0, q1, [x26, #64]
	stp	q0, q1, [x25, #64]
	cmp	w27, #64
	b.lo	262b
	ldp	q0, q1, [x26, #96]
	stp	q0, q1, [x25, #96]
	cmp	w27, #96
	b.lo	262b
	ldp	q0, q1, [x26, #128]
	stp	q0, q1, [x25, #128]
	tbz	w27, #7, 262b
	ldp	q0, q1, [x26, #160]
	stp	q0, q1, [x25, #160]
	cmp	w27, #160
	b.lo	262b
	ldp	q0, q1, [x26, #192]
	stp	q0, q1, [x25, #192]
	cmp	w27, #192
	b.lo	262b
	ldp	q0, q1, [x26, #224]
	stp	q0, q1, [x25, #224]
	cmp	w27, #224
	b.lo	262b
	ldp	q0, q1, [x26, #256]
	stp	q0, q1, [x25, #256]
	b	262b
512:
	cmp	x21, x24
	csel	x5, x21, x24, lo
	sub	x29, x24, x5
	cmp	x5, x27
	b.hs	592f
	ldr	x28, [x0, #56]
	add	x28, x28, x5, lsl #5
	ldr	q1, [x28, #2064]
	ldr	q0, [x28, #2048]
	add	x28, x9, x29
	ldp	q2, q3, [x28]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	42b
522:
	cmp	x21, x26
	csel	x5, x21, x26, lo
	sub	x29, x26, x5
	cmp	x5, x27
	b.hs	602f
	ldr	x28, [x0, #56]
	add	x28, x28, x5, lsl #5
	ldr	q1, [x28, #2064]
	ldr	q0, [x28, #2048]
	add	x28, x9, x29
	ldp	q2, q3, [x28]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	72b
532:
	cmp	x23, x27
	csel	x5, x23, x27, lo
	sub	x29, x27, x5
	cmp	x5, x28
	b.hs	612f
	ldr	x21, [x0, #56]
	add	x21, x21, x5, lsl #5
	ldr	q1, [x21, #2064]
	ldr	q0, [x21, #2048]
	add	x21, x9, x29
	ldp	q2, q3, [x21]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	102b
542:
	cmp	x23, x26
	csel	x5, x23, x26, lo
	sub	x29, x26, x5
	cmp	x5, x27
	b.hs	622f
	ldr	x28, [x0, #56]
	add	x28, x28, x5, lsl #5
	ldr	q1, [x28, #2064]
	ldr	q0, [x28, #2048]
	add	x28, x9, x29
	ldp	q2, q3, [x28]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	132b
552:
	cmp	x21, x27
	csel	x5, x21, x27, lo
	sub	x29, x27, x5
	cmp	x5, x28
	b.hs	632f
	ldr	x23, [x0, #56]
	add	x23, x23, x5, lsl #5
	ldr	q1, [x23, #2064]
	ldr	q0, [x23, #2048]
	add	x23, x9, x29
	ldp	q2, q3, [x23]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	162b
562:
	cmp	x21, x26
	csel	x5, x21, x26, lo
	sub	x29, x26, x5
	cmp	x5, x27
	b.hs	642f
	ldr	x28, [x0, #56]
	add	x28, x28, x5, lsl #5
	ldr	q1, [x28, #2064]
	ldr	q0, [x28, #2048]
	add	x28, x9, x29
	ldp	q2, q3, [x28]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	192b
572:
	cmp	x21, x26
	csel	x5, x21, x26, lo
	sub	x29, x26, x5
	cmp	x5, x27
	b.hs	652f
	ldr	x28, [x0, #56]
	add	x28, x28, x5, lsl #5
	ldr	q1, [x28, #2064]
	ldr	q0, [x28, #2048]
	add	x28, x9, x29
	ldp	q2, q3, [x28]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	222b
582:
	cmp	x21, x24
	csel	x5, x21, x24, lo
	sub	x26, x24, x5
	cmp	x5, x7
	b.hs	662f
	ldr	x25, [x0, #56]
	add	x25, x25, x5, lsl #5
	ldr	q1, [x25, #2064]
	ldr	q0, [x25, #2048]
	add	x25, x9, x26
	ldp	q2, q3, [x25]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	252b
592:
	add	x28, x9, x29
	ldp	q0, q1, [x28]
	b	42b
602:
	add	x28, x9, x29
	ldp	q0, q1, [x28]
	b	72b
612:
	add	x21, x9, x29
	ldp	q0, q1, [x21]
	b	102b
622:
	add	x28, x9, x29
	ldp	q0, q1, [x28]
	b	132b
632:
	add	x23, x9, x29
	ldp	q0, q1, [x23]
	b	162b
642:
	add	x28, x9, x29
	ldp	q0, q1, [x28]
	b	192b
652:
	add	x28, x9, x29
	ldp	q0, q1, [x28]
	b	222b
662:
	add	x25, x9, x26
	ldp	q0, q1, [x25]
	b	252b
672:
	mov	x16, xzr
	b	692f
682:
	cbz	x8, 782f
	neg	x16, x2
692:
	ldr	x15, [x15, x16]
	mov	w16, #1
	.p2align	5, , 16
702:
	lsr	x2, x23, #3
	ubfiz	x17, x14, #3, #8
	and	x3, x23, #0x7
	and	x1, x13, #0xff
	ldr	x2, [x11, x2]
	ldr	x17, [x12, x17]
	lsr	x2, x2, x3
	add	x3, x9, x24
	and	w2, w17, w2
	adds	x2, x2, x17, lsr #40
	csel	x21, x21, x2, eq
	add	x2, x10, x22
	ldp	q0, q1, [x2]
	stp	q0, q1, [x3]
	cmp	x1, #33
	b.hs	742f
712:
	and	x6, x15, #0xff
	add	x2, x1, x24
	lsr	x3, x6, #2
	cmp	x21, x3
	ccmp	x2, x21, #0, hs
	b.lo	752f
	sub	x5, x2, x21
	mov	x7, x21
722:
	add	x4, x9, x5
	ldp	q0, q1, [x4]
	add	x4, x9, x2
	stp	q0, q1, [x4]
	cmp	x6, #132
	b.hs	762f
732:
	lsr	x17, x17, #32
	add	x22, x1, x22
	add	x24, x3, x2
	subs	x8, x8, #1
	lsr	x15, x15, #8
	lsr	x13, x13, #8
	add	x23, x23, w17, uxtb
	lsr	x14, x14, #8
	b.ne	702b
	b	782f
742:
	ldr	x1, [x0, #48]
	ldr	x5, [x0, #120]
	ldrb	w4, [x1, x5]
	add	x1, x5, #1
	str	x1, [x0, #120]
	ldp	q0, q1, [x2, #32]
	add	x1, x4, #33
	stp	q0, q1, [x3, #32]
	cmp	w4, #32
	b.lo	712b
	ldp	q0, q1, [x2, #64]
	stp	q0, q1, [x3, #64]
	cmp	w4, #64
	b.lo	712b
	ldp	q0, q1, [x2, #96]
	stp	q0, q1, [x3, #96]
	cmp	w4, #96
	b.lo	712b
	ldp	q0, q1, [x2, #128]
	stp	q0, q1, [x3, #128]
	tbz	w4, #7, 712b
	ldp	q0, q1, [x2, #160]
	stp	q0, q1, [x3, #160]
	cmp	w4, #160
	b.lo	712b
	ldp	q0, q1, [x2, #192]
	stp	q0, q1, [x3, #192]
	cmp	w4, #192
	b.lo	712b
	ldp	q0, q1, [x2, #224]
	stp	q0, q1, [x3, #224]
	cmp	w4, #224
	b.lo	712b
	ldp	q0, q1, [x2, #256]
	stp	q0, q1, [x3, #256]
	b	712b
752:
	cmp	x21, x2
	csel	x7, x21, x2, lo
	sub	x5, x2, x7
	cmp	x7, x3
	b.hs	722b
	ldr	x4, [x0, #56]
	add	x4, x4, x7, lsl #5
	ldr	q1, [x4, #2064]
	ldr	q0, [x4, #2048]
	add	x4, x9, x5
	ldp	q2, q3, [x4]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	add	x4, x9, x2
	stp	q0, q1, [x4]
	cmp	x6, #132
	b.lo	732b
762:
	cmp	x7, #31
	b.hi	772f
	str	x16, [x0, #104]
772:
	ldr	x3, [x0, #48]
	ldr	x7, [x0, #120]
	add	x5, x9, x5
	ldrb	w6, [x3, x7]
	add	x3, x7, #1
	str	x3, [x0, #120]
	ldp	q0, q1, [x5, #32]
	add	x3, x6, #33
	stp	q0, q1, [x4, #32]
	cmp	w6, #32
	b.lo	732b
	ldp	q0, q1, [x5, #64]
	stp	q0, q1, [x4, #64]
	cmp	w6, #64
	b.lo	732b
	ldp	q0, q1, [x5, #96]
	stp	q0, q1, [x4, #96]
	cmp	w6, #96
	b.lo	732b
	ldp	q0, q1, [x5, #128]
	stp	q0, q1, [x4, #128]
	tbz	w6, #7, 732b
	ldp	q0, q1, [x5, #160]
	stp	q0, q1, [x4, #160]
	cmp	w6, #160
	b.lo	732b
	ldp	q0, q1, [x5, #192]
	stp	q0, q1, [x4, #192]
	cmp	w6, #192
	b.lo	732b
	ldp	q0, q1, [x5, #224]
	stp	q0, q1, [x4, #224]
	cmp	w6, #224
	b.lo	732b
	ldp	q0, q1, [x5, #256]
	stp	q0, q1, [x4, #256]
	b	732b
782:
	stp	x24, x22, [x0, #80]
	str	x21, [x0, #96]
	ldp	x20, x19, [sp, #80]
	ldp	x22, x21, [sp, #64]
	ldp	x24, x23, [sp, #48]
	ldp	x26, x25, [sp, #32]
	ldp	x28, x27, [sp, #16]
	ldp	x29, x30, [sp], #96
792:
	ret

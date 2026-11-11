// minlz_exec_delta of crates/minlz/mlir/exec8.mlir for neon, written by
// cargo xtask mlir. Do not edit.
	ldr	x8, [x0, #64]
	mov	x16, #72340172838076673
	//APP
	//NO_APP
	cbz	x8, 972f
	stp	x29, x30, [sp, #-96]!
	ldp	x15, x17, [x0, #16]
	ldp	x1, x11, [x0, #32]
	stp	x24, x23, [sp, #48]
	stp	x22, x21, [sp, #64]
	ldp	x9, x10, [x0]
	ldr	x12, [x0, #56]
	ldr	x14, [x15]
	ldr	d0, [x17]
	ldp	x21, x22, [x0, #88]
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
	b.lo	832f
	lsr	x3, x3, #56
	lsr	x4, x4, #56
	mov	x2, xzr
	mov	x6, x15
	.p2align	5, , 16
2:
	subs	x8, x8, #8
	mov	x19, x13
	mov	x20, x14
	b.ne	12f
	mov	x13, x19
	mov	x14, x20
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
	ubfiz	x5, x20, #3, #8
	and	x7, x23, #0x7
	ldr	x26, [x12, x5]
	lsr	x5, x23, #3
	ldr	x5, [x11, x5]
	lsr	x5, x5, x7
	and	w5, w26, w5
	adds	x5, x5, x26, lsr #40
	csel	x25, x22, x5, eq
	cmp	x22, x24
	csel	x7, x22, x24, lo
	sub	x5, x24, x7
	cmp	x7, #31
	b.ls	352f
	add	x5, x9, x5
	ldp	q0, q1, [x5]
32:
	add	x22, x10, x21
	ldr	x7, [x6]
	and	x27, x19, #0xff
	add	x28, x9, x24
	ldp	q3, q2, [x22]
	add	v1.16b, v1.16b, v2.16b
	add	v0.16b, v0.16b, v3.16b
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.hs	362f
42:
	and	x30, x7, #0xff
	add	x28, x27, x24
	lsr	x29, x30, #2
	cmp	x25, x29
	ccmp	x28, x25, #0, hs
	b.lo	672f
	sub	x24, x28, x25
	add	x5, x9, x24
	ldp	q0, q1, [x5]
	mov	x5, x25
52:
	add	x22, x9, x28
	stp	q0, q1, [x22]
	cmp	x30, #132
	b.hs	372f
62:
	lsr	x5, x26, #32
	add	x24, x27, x21
	add	x26, x29, x28
	add	x22, x23, w5, uxtb
	lsr	x5, x20, #5
	add	x27, x10, x24
	and	x5, x5, #0x7f8
	ldp	q0, q1, [x27]
	ldr	x23, [x12, x5]
	lsr	x5, x22, #3
	and	x21, x22, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x21
	and	w5, w23, w5
	adds	x5, x5, x23, lsr #40
	csel	x21, x25, x5, eq
	cmp	x25, x26
	csel	x25, x25, x26, lo
	sub	x5, x26, x25
	cmp	x25, #31
	b.ls	392f
	add	x5, x9, x5
	ldp	q2, q3, [x5]
72:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	ubfx	x25, x19, #8, #8
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x25, #33
	b.hs	402f
82:
	ubfx	x30, x7, #8, #8
	add	x26, x25, x26
	lsr	x27, x30, #2
	cmp	x21, x27
	ccmp	x26, x21, #0, hs
	b.lo	682f
	sub	x29, x26, x21
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	mov	x5, x21
92:
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x30, #132
	b.hs	412f
102:
	lsr	x5, x23, #32
	add	x24, x25, x24
	add	x26, x27, x26
	add	x23, x22, w5, uxtb
	lsr	x5, x20, #13
	add	x27, x10, x24
	and	x5, x5, #0x7f8
	ldp	q0, q1, [x27]
	ldr	x25, [x12, x5]
	lsr	x5, x23, #3
	and	x22, x23, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x22
	and	w5, w25, w5
	adds	x5, x5, x25, lsr #40
	csel	x22, x21, x5, eq
	cmp	x21, x26
	csel	x21, x21, x26, lo
	sub	x5, x26, x21
	cmp	x21, #31
	b.ls	432f
	add	x5, x9, x5
	ldp	q2, q3, [x5]
112:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	ubfx	x21, x19, #16, #8
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x21, #33
	b.hs	442f
122:
	ubfx	x30, x7, #16, #8
	add	x26, x21, x26
	lsr	x27, x30, #2
	cmp	x22, x27
	b.lo	692f
	subs	x29, x26, x22
	b.lo	692f
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	mov	x5, x22
132:
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x30, #132
	b.hs	452f
142:
	lsr	x5, x25, #32
	add	x24, x21, x24
	add	x26, x27, x26
	add	x23, x23, w5, uxtb
	lsr	x5, x20, #21
	add	x27, x10, x24
	and	x5, x5, #0x7f8
	ldp	q0, q1, [x27]
	ldr	x25, [x12, x5]
	lsr	x5, x23, #3
	and	x21, x23, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x21
	and	w5, w25, w5
	adds	x5, x5, x25, lsr #40
	csel	x21, x22, x5, eq
	cmp	x22, x26
	csel	x22, x22, x26, lo
	sub	x5, x26, x22
	cmp	x22, #31
	b.ls	472f
	add	x5, x9, x5
	ldp	q2, q3, [x5]
152:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	lsr	w22, w19, #24
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x22, #33
	b.hs	482f
162:
	lsr	w30, w7, #24
	add	x26, x22, x26
	lsr	x27, x30, #2
	cmp	x21, x27
	b.lo	702f
	subs	x29, x26, x21
	b.lo	702f
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	mov	x5, x21
172:
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x30, #132
	b.hs	492f
182:
	lsr	x5, x25, #32
	add	x24, x22, x24
	add	x26, x27, x26
	add	x23, x23, w5, uxtb
	lsr	x5, x20, #29
	add	x27, x10, x24
	and	x5, x5, #0x7f8
	ldp	q0, q1, [x27]
	ldr	x25, [x12, x5]
	lsr	x5, x23, #3
	and	x22, x23, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x22
	and	w5, w25, w5
	adds	x5, x5, x25, lsr #40
	csel	x22, x21, x5, eq
	cmp	x21, x26
	csel	x21, x21, x26, lo
	sub	x5, x26, x21
	cmp	x21, #31
	b.ls	512f
	add	x5, x9, x5
	ldp	q2, q3, [x5]
192:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	ubfx	x21, x19, #32, #8
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x21, #33
	b.hs	522f
202:
	ubfx	x30, x7, #32, #8
	add	x26, x21, x26
	lsr	x27, x30, #2
	cmp	x22, x27
	b.lo	712f
	subs	x29, x26, x22
	b.lo	712f
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	mov	x5, x22
212:
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x30, #132
	b.hs	532f
222:
	lsr	x5, x25, #32
	add	x24, x21, x24
	add	x27, x27, x26
	add	x23, x23, w5, uxtb
	lsr	x5, x20, #37
	add	x28, x10, x24
	and	x5, x5, #0x7f8
	ldp	q0, q1, [x28]
	ldr	x25, [x12, x5]
	lsr	x5, x23, #3
	and	x21, x23, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x21
	and	w5, w25, w5
	adds	x5, x5, x25, lsr #40
	csel	x21, x22, x5, eq
	cmp	x22, x27
	csel	x22, x22, x27, lo
	sub	x5, x27, x22
	cmp	x22, #31
	b.ls	552f
	add	x5, x9, x5
	ldp	q2, q3, [x5]
232:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	ubfx	x26, x19, #40, #8
	add	x22, x9, x27
	stp	q0, q1, [x22]
	cmp	x26, #33
	b.hs	562f
242:
	ubfx	x30, x7, #40, #8
	add	x27, x26, x27
	lsr	x28, x30, #2
	cmp	x21, x28
	b.lo	722f
	subs	x29, x27, x21
	b.lo	722f
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	mov	x5, x21
252:
	add	x22, x9, x27
	stp	q0, q1, [x22]
	cmp	x30, #132
	b.hs	572f
262:
	lsr	x5, x25, #32
	add	x24, x26, x24
	add	x26, x28, x27
	add	x22, x23, w5, uxtb
	lsr	x5, x20, #45
	add	x27, x10, x24
	and	x5, x5, #0x7f8
	ldp	q0, q1, [x27]
	ldr	x25, [x12, x5]
	lsr	x5, x22, #3
	and	x23, x22, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x23
	and	w5, w25, w5
	adds	x5, x5, x25, lsr #40
	csel	x23, x21, x5, eq
	cmp	x21, x26
	csel	x21, x21, x26, lo
	sub	x5, x26, x21
	cmp	x21, #31
	b.ls	592f
	add	x5, x9, x5
	ldp	q2, q3, [x5]
272:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	ubfx	x21, x19, #48, #8
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x21, #33
	b.hs	602f
282:
	ubfx	x30, x7, #48, #8
	add	x26, x21, x26
	lsr	x27, x30, #2
	cmp	x23, x27
	b.lo	732f
	subs	x29, x26, x23
	b.lo	732f
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	mov	x5, x23
292:
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x30, #132
	b.hs	612f
302:
	lsr	x5, x25, #32
	add	x21, x21, x24
	add	x24, x27, x26
	add	x25, x22, w5, uxtb
	lsr	x5, x20, #53
	add	x26, x10, x21
	and	x5, x5, #0x7f8
	ldp	q0, q1, [x26]
	ldr	x20, [x12, x5]
	lsr	x5, x25, #3
	and	x22, x25, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x22
	and	w5, w20, w5
	adds	x5, x5, x20, lsr #40
	csel	x22, x23, x5, eq
	cmp	x23, x24
	csel	x23, x23, x24, lo
	sub	x5, x24, x23
	cmp	x23, #31
	b.ls	632f
	add	x5, x9, x5
	ldp	q2, q3, [x5]
312:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	lsr	x19, x19, #56
	add	x23, x9, x24
	stp	q0, q1, [x23]
	cmp	x19, #33
	b.hs	642f
322:
	add	x24, x19, x24
	lsr	x7, x7, #58
	cmp	x22, x7
	b.lo	742f
	subs	x26, x24, x22
	b.lo	742f
	add	x5, x9, x26
	ldp	q0, q1, [x5]
	mov	x5, x22
332:
	add	x23, x9, x24
	stp	q0, q1, [x23]
	cmp	x7, #33
	b.hs	652f
342:
	lsr	x5, x20, #32
	add	x21, x19, x21
	add	x24, x7, x24
	sub	x2, x2, #8
	add	x6, x6, #8
	add	x23, x25, w5, uxtb
	cmp	x8, #7
	b.hi	2b
	b	842f
352:
	ldr	x22, [x0, #56]
	add	x5, x9, x5
	ldp	q2, q3, [x5]
	add	x7, x22, x7, lsl #5
	ldr	q1, [x7, #2064]
	ldr	q0, [x7, #2048]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	32b
362:
	ldr	x5, [x0, #48]
	ldr	x27, [x0, #120]
	ldrb	w29, [x5, x27]
	add	x5, x27, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x22, #32]
	add	x27, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	42b
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	42b
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	42b
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 42b
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	42b
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	42b
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	42b
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x28, #256]
	b	42b
372:
	cmp	x5, #31
	b.hi	382f
	mov	w5, #1
	str	x5, [x0, #104]
382:
	ldr	x5, [x0, #48]
	ldr	x29, [x0, #120]
	add	x24, x9, x24
	ldrb	w30, [x5, x29]
	add	x5, x29, #1
	add	x29, x30, #33
	str	x5, [x0, #120]
	ldp	q0, q1, [x24, #32]
	stp	q0, q1, [x22, #32]
	cmp	w30, #32
	b.lo	62b
	ldp	q0, q1, [x24, #64]
	stp	q0, q1, [x22, #64]
	cmp	w30, #64
	b.lo	62b
	ldp	q0, q1, [x24, #96]
	stp	q0, q1, [x22, #96]
	cmp	w30, #96
	b.lo	62b
	ldp	q0, q1, [x24, #128]
	stp	q0, q1, [x22, #128]
	tbz	w30, #7, 62b
	ldp	q0, q1, [x24, #160]
	stp	q0, q1, [x22, #160]
	cmp	w30, #160
	b.lo	62b
	ldp	q0, q1, [x24, #192]
	stp	q0, q1, [x22, #192]
	cmp	w30, #192
	b.lo	62b
	ldp	q0, q1, [x24, #224]
	stp	q0, q1, [x22, #224]
	cmp	w30, #224
	b.lo	62b
	ldp	q0, q1, [x24, #256]
	stp	q0, q1, [x22, #256]
	b	62b
392:
	ldr	x28, [x0, #56]
	add	x5, x9, x5
	ldp	q4, q5, [x5]
	add	x25, x28, x25, lsl #5
	ldr	q3, [x25, #2064]
	ldr	q2, [x25, #2048]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	72b
402:
	ldr	x5, [x0, #48]
	ldr	x25, [x0, #120]
	ldrb	w29, [x5, x25]
	add	x5, x25, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x25, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	82b
	ldp	q0, q1, [x27, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	82b
	ldp	q0, q1, [x27, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	82b
	ldp	q0, q1, [x27, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 82b
	ldp	q0, q1, [x27, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	82b
	ldp	q0, q1, [x27, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	82b
	ldp	q0, q1, [x27, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	82b
	ldp	q0, q1, [x27, #256]
	stp	q0, q1, [x28, #256]
	b	82b
412:
	cmp	x5, #31
	b.hi	422f
	mov	w5, #1
	str	x5, [x0, #104]
422:
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
	b.lo	102b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x28, #64]
	cmp	w30, #64
	b.lo	102b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x28, #96]
	cmp	w30, #96
	b.lo	102b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x28, #128]
	tbz	w30, #7, 102b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x28, #160]
	cmp	w30, #160
	b.lo	102b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x28, #192]
	cmp	w30, #192
	b.lo	102b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x28, #224]
	cmp	w30, #224
	b.lo	102b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x28, #256]
	b	102b
432:
	ldr	x28, [x0, #56]
	add	x5, x9, x5
	ldp	q4, q5, [x5]
	add	x21, x28, x21, lsl #5
	ldr	q3, [x21, #2064]
	ldr	q2, [x21, #2048]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	112b
442:
	ldr	x5, [x0, #48]
	ldr	x21, [x0, #120]
	ldrb	w29, [x5, x21]
	add	x5, x21, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x21, x29, #33
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
452:
	cmp	x5, #31
	b.hi	462f
	mov	w5, #1
	str	x5, [x0, #104]
462:
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
472:
	ldr	x28, [x0, #56]
	add	x5, x9, x5
	ldp	q4, q5, [x5]
	add	x22, x28, x22, lsl #5
	ldr	q3, [x22, #2064]
	ldr	q2, [x22, #2048]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	152b
482:
	ldr	x5, [x0, #48]
	ldr	x22, [x0, #120]
	ldrb	w29, [x5, x22]
	add	x5, x22, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x22, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	162b
	ldp	q0, q1, [x27, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	162b
	ldp	q0, q1, [x27, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	162b
	ldp	q0, q1, [x27, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 162b
	ldp	q0, q1, [x27, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	162b
	ldp	q0, q1, [x27, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	162b
	ldp	q0, q1, [x27, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	162b
	ldp	q0, q1, [x27, #256]
	stp	q0, q1, [x28, #256]
	b	162b
492:
	cmp	x5, #31
	b.hi	502f
	mov	w5, #1
	str	x5, [x0, #104]
502:
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
	b.lo	182b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x28, #64]
	cmp	w30, #64
	b.lo	182b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x28, #96]
	cmp	w30, #96
	b.lo	182b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x28, #128]
	tbz	w30, #7, 182b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x28, #160]
	cmp	w30, #160
	b.lo	182b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x28, #192]
	cmp	w30, #192
	b.lo	182b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x28, #224]
	cmp	w30, #224
	b.lo	182b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x28, #256]
	b	182b
512:
	ldr	x28, [x0, #56]
	add	x5, x9, x5
	ldp	q4, q5, [x5]
	add	x21, x28, x21, lsl #5
	ldr	q3, [x21, #2064]
	ldr	q2, [x21, #2048]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	192b
522:
	ldr	x5, [x0, #48]
	ldr	x21, [x0, #120]
	ldrb	w29, [x5, x21]
	add	x5, x21, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x21, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	202b
	ldp	q0, q1, [x27, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	202b
	ldp	q0, q1, [x27, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	202b
	ldp	q0, q1, [x27, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 202b
	ldp	q0, q1, [x27, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	202b
	ldp	q0, q1, [x27, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	202b
	ldp	q0, q1, [x27, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	202b
	ldp	q0, q1, [x27, #256]
	stp	q0, q1, [x28, #256]
	b	202b
532:
	cmp	x5, #31
	b.hi	542f
	mov	w5, #1
	str	x5, [x0, #104]
542:
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
	b.lo	222b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x28, #64]
	cmp	w30, #64
	b.lo	222b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x28, #96]
	cmp	w30, #96
	b.lo	222b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x28, #128]
	tbz	w30, #7, 222b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x28, #160]
	cmp	w30, #160
	b.lo	222b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x28, #192]
	cmp	w30, #192
	b.lo	222b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x28, #224]
	cmp	w30, #224
	b.lo	222b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x28, #256]
	b	222b
552:
	ldr	x26, [x0, #56]
	add	x5, x9, x5
	ldp	q4, q5, [x5]
	add	x22, x26, x22, lsl #5
	ldr	q3, [x22, #2064]
	ldr	q2, [x22, #2048]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	232b
562:
	ldr	x5, [x0, #48]
	ldr	x26, [x0, #120]
	ldrb	w29, [x5, x26]
	add	x5, x26, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x28, #32]
	add	x26, x29, #33
	stp	q0, q1, [x22, #32]
	cmp	w29, #32
	b.lo	242b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x22, #64]
	cmp	w29, #64
	b.lo	242b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x22, #96]
	cmp	w29, #96
	b.lo	242b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x22, #128]
	tbz	w29, #7, 242b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x22, #160]
	cmp	w29, #160
	b.lo	242b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x22, #192]
	cmp	w29, #192
	b.lo	242b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x22, #224]
	cmp	w29, #224
	b.lo	242b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x22, #256]
	b	242b
572:
	cmp	x5, #31
	b.hi	582f
	mov	w5, #1
	str	x5, [x0, #104]
582:
	ldr	x5, [x0, #48]
	ldr	x28, [x0, #120]
	add	x29, x9, x29
	ldrb	w30, [x5, x28]
	add	x5, x28, #1
	add	x28, x30, #33
	str	x5, [x0, #120]
	ldp	q0, q1, [x29, #32]
	stp	q0, q1, [x22, #32]
	cmp	w30, #32
	b.lo	262b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x22, #64]
	cmp	w30, #64
	b.lo	262b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x22, #96]
	cmp	w30, #96
	b.lo	262b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x22, #128]
	tbz	w30, #7, 262b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x22, #160]
	cmp	w30, #160
	b.lo	262b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x22, #192]
	cmp	w30, #192
	b.lo	262b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x22, #224]
	cmp	w30, #224
	b.lo	262b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x22, #256]
	b	262b
592:
	ldr	x28, [x0, #56]
	add	x5, x9, x5
	ldp	q4, q5, [x5]
	add	x21, x28, x21, lsl #5
	ldr	q3, [x21, #2064]
	ldr	q2, [x21, #2048]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	272b
602:
	ldr	x5, [x0, #48]
	ldr	x21, [x0, #120]
	ldrb	w29, [x5, x21]
	add	x5, x21, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x21, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	282b
	ldp	q0, q1, [x27, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	282b
	ldp	q0, q1, [x27, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	282b
	ldp	q0, q1, [x27, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 282b
	ldp	q0, q1, [x27, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	282b
	ldp	q0, q1, [x27, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	282b
	ldp	q0, q1, [x27, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	282b
	ldp	q0, q1, [x27, #256]
	stp	q0, q1, [x28, #256]
	b	282b
612:
	cmp	x5, #31
	b.hi	622f
	mov	w5, #1
	str	x5, [x0, #104]
622:
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
	b.lo	302b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x28, #64]
	cmp	w30, #64
	b.lo	302b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x28, #96]
	cmp	w30, #96
	b.lo	302b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x28, #128]
	tbz	w30, #7, 302b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x28, #160]
	cmp	w30, #160
	b.lo	302b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x28, #192]
	cmp	w30, #192
	b.lo	302b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x28, #224]
	cmp	w30, #224
	b.lo	302b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x28, #256]
	b	302b
632:
	ldr	x27, [x0, #56]
	add	x5, x9, x5
	ldp	q4, q5, [x5]
	add	x23, x27, x23, lsl #5
	ldr	q3, [x23, #2064]
	ldr	q2, [x23, #2048]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	312b
642:
	ldr	x5, [x0, #48]
	ldr	x19, [x0, #120]
	ldrb	w27, [x5, x19]
	add	x5, x19, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x26, #32]
	add	x19, x27, #33
	stp	q0, q1, [x23, #32]
	cmp	w27, #32
	b.lo	322b
	ldp	q0, q1, [x26, #64]
	stp	q0, q1, [x23, #64]
	cmp	w27, #64
	b.lo	322b
	ldp	q0, q1, [x26, #96]
	stp	q0, q1, [x23, #96]
	cmp	w27, #96
	b.lo	322b
	ldp	q0, q1, [x26, #128]
	stp	q0, q1, [x23, #128]
	tbz	w27, #7, 322b
	ldp	q0, q1, [x26, #160]
	stp	q0, q1, [x23, #160]
	cmp	w27, #160
	b.lo	322b
	ldp	q0, q1, [x26, #192]
	stp	q0, q1, [x23, #192]
	cmp	w27, #192
	b.lo	322b
	ldp	q0, q1, [x26, #224]
	stp	q0, q1, [x23, #224]
	cmp	w27, #224
	b.lo	322b
	ldp	q0, q1, [x26, #256]
	stp	q0, q1, [x23, #256]
	b	322b
652:
	cmp	x5, #31
	b.hi	662f
	mov	w5, #1
	str	x5, [x0, #104]
662:
	ldr	x5, [x0, #48]
	ldr	x7, [x0, #120]
	add	x26, x9, x26
	ldrb	w27, [x5, x7]
	add	x5, x7, #1
	add	x7, x27, #33
	str	x5, [x0, #120]
	ldp	q0, q1, [x26, #32]
	stp	q0, q1, [x23, #32]
	cmp	w27, #32
	b.lo	342b
	ldp	q0, q1, [x26, #64]
	stp	q0, q1, [x23, #64]
	cmp	w27, #64
	b.lo	342b
	ldp	q0, q1, [x26, #96]
	stp	q0, q1, [x23, #96]
	cmp	w27, #96
	b.lo	342b
	ldp	q0, q1, [x26, #128]
	stp	q0, q1, [x23, #128]
	tbz	w27, #7, 342b
	ldp	q0, q1, [x26, #160]
	stp	q0, q1, [x23, #160]
	cmp	w27, #160
	b.lo	342b
	ldp	q0, q1, [x26, #192]
	stp	q0, q1, [x23, #192]
	cmp	w27, #192
	b.lo	342b
	ldp	q0, q1, [x26, #224]
	stp	q0, q1, [x23, #224]
	cmp	w27, #224
	b.lo	342b
	ldp	q0, q1, [x26, #256]
	stp	q0, q1, [x23, #256]
	b	342b
672:
	cmp	x25, x28
	csel	x5, x25, x28, lo
	sub	x24, x28, x5
	cmp	x5, x29
	b.hs	752f
	ldr	x22, [x0, #56]
	add	x22, x22, x5, lsl #5
	ldr	q1, [x22, #2064]
	ldr	q0, [x22, #2048]
	add	x22, x9, x24
	ldp	q2, q3, [x22]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	52b
682:
	cmp	x21, x26
	csel	x5, x21, x26, lo
	sub	x29, x26, x5
	cmp	x5, x27
	b.hs	762f
	ldr	x28, [x0, #56]
	add	x28, x28, x5, lsl #5
	ldr	q1, [x28, #2064]
	ldr	q0, [x28, #2048]
	add	x28, x9, x29
	ldp	q2, q3, [x28]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	92b
692:
	cmp	x22, x26
	csel	x5, x22, x26, lo
	sub	x29, x26, x5
	cmp	x5, x27
	b.hs	772f
	ldr	x28, [x0, #56]
	add	x28, x28, x5, lsl #5
	ldr	q1, [x28, #2064]
	ldr	q0, [x28, #2048]
	add	x28, x9, x29
	ldp	q2, q3, [x28]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	132b
702:
	cmp	x21, x26
	csel	x5, x21, x26, lo
	sub	x29, x26, x5
	cmp	x5, x27
	b.hs	782f
	ldr	x28, [x0, #56]
	add	x28, x28, x5, lsl #5
	ldr	q1, [x28, #2064]
	ldr	q0, [x28, #2048]
	add	x28, x9, x29
	ldp	q2, q3, [x28]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	172b
712:
	cmp	x22, x26
	csel	x5, x22, x26, lo
	sub	x29, x26, x5
	cmp	x5, x27
	b.hs	792f
	ldr	x28, [x0, #56]
	add	x28, x28, x5, lsl #5
	ldr	q1, [x28, #2064]
	ldr	q0, [x28, #2048]
	add	x28, x9, x29
	ldp	q2, q3, [x28]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	212b
722:
	cmp	x21, x27
	csel	x5, x21, x27, lo
	sub	x29, x27, x5
	cmp	x5, x28
	b.hs	802f
	ldr	x22, [x0, #56]
	add	x22, x22, x5, lsl #5
	ldr	q1, [x22, #2064]
	ldr	q0, [x22, #2048]
	add	x22, x9, x29
	ldp	q2, q3, [x22]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	252b
732:
	cmp	x23, x26
	csel	x5, x23, x26, lo
	sub	x29, x26, x5
	cmp	x5, x27
	b.hs	812f
	ldr	x28, [x0, #56]
	add	x28, x28, x5, lsl #5
	ldr	q1, [x28, #2064]
	ldr	q0, [x28, #2048]
	add	x28, x9, x29
	ldp	q2, q3, [x28]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	292b
742:
	cmp	x22, x24
	csel	x5, x22, x24, lo
	sub	x26, x24, x5
	cmp	x5, x7
	b.hs	822f
	ldr	x23, [x0, #56]
	add	x23, x23, x5, lsl #5
	ldr	q1, [x23, #2064]
	ldr	q0, [x23, #2048]
	add	x23, x9, x26
	ldp	q2, q3, [x23]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	332b
752:
	add	x22, x9, x24
	ldp	q0, q1, [x22]
	b	52b
762:
	add	x28, x9, x29
	ldp	q0, q1, [x28]
	b	92b
772:
	add	x28, x9, x29
	ldp	q0, q1, [x28]
	b	132b
782:
	add	x28, x9, x29
	ldp	q0, q1, [x28]
	b	172b
792:
	add	x28, x9, x29
	ldp	q0, q1, [x28]
	b	212b
802:
	add	x22, x9, x29
	ldp	q0, q1, [x22]
	b	252b
812:
	add	x28, x9, x29
	ldp	q0, q1, [x28]
	b	292b
822:
	add	x23, x9, x26
	ldp	q0, q1, [x23]
	b	332b
832:
	mov	x16, xzr
	b	852f
842:
	cbz	x8, 962f
	neg	x16, x2
852:
	ldr	x15, [x15, x16]
	mov	w16, #1
	.p2align	5, , 16
862:
	lsr	x2, x23, #3
	ubfiz	x17, x14, #3, #8
	and	x3, x23, #0x7
	mov	x1, x22
	ldr	x2, [x11, x2]
	ldr	x17, [x12, x17]
	lsr	x2, x2, x3
	and	w2, w17, w2
	adds	x2, x2, x17, lsr #40
	csel	x22, x22, x2, eq
	cmp	x1, x24
	csel	x2, x1, x24, lo
	sub	x1, x24, x2
	cmp	x2, #31
	b.ls	912f
	add	x1, x9, x1
	ldp	q0, q1, [x1]
872:
	add	x2, x10, x21
	and	x1, x13, #0xff
	add	x3, x9, x24
	ldp	q3, q2, [x2]
	add	v1.16b, v1.16b, v2.16b
	add	v0.16b, v0.16b, v3.16b
	stp	q0, q1, [x3]
	cmp	x1, #33
	b.hs	922f
882:
	and	x6, x15, #0xff
	add	x2, x1, x24
	lsr	x3, x6, #2
	cmp	x22, x3
	ccmp	x2, x22, #0, hs
	b.lo	932f
	sub	x5, x2, x22
	mov	x7, x22
892:
	add	x4, x9, x5
	ldp	q0, q1, [x4]
	add	x4, x9, x2
	stp	q0, q1, [x4]
	cmp	x6, #132
	b.hs	942f
902:
	lsr	x17, x17, #32
	add	x21, x1, x21
	add	x24, x3, x2
	subs	x8, x8, #1
	lsr	x15, x15, #8
	lsr	x13, x13, #8
	add	x23, x23, w17, uxtb
	lsr	x14, x14, #8
	b.ne	862b
	b	962f
912:
	ldr	x3, [x0, #56]
	add	x1, x9, x1
	ldp	q2, q3, [x1]
	add	x2, x3, x2, lsl #5
	ldr	q1, [x2, #2064]
	ldr	q0, [x2, #2048]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	872b
922:
	ldr	x1, [x0, #48]
	ldr	x5, [x0, #120]
	ldrb	w4, [x1, x5]
	add	x1, x5, #1
	str	x1, [x0, #120]
	ldp	q0, q1, [x2, #32]
	add	x1, x4, #33
	stp	q0, q1, [x3, #32]
	cmp	w4, #32
	b.lo	882b
	ldp	q0, q1, [x2, #64]
	stp	q0, q1, [x3, #64]
	cmp	w4, #64
	b.lo	882b
	ldp	q0, q1, [x2, #96]
	stp	q0, q1, [x3, #96]
	cmp	w4, #96
	b.lo	882b
	ldp	q0, q1, [x2, #128]
	stp	q0, q1, [x3, #128]
	tbz	w4, #7, 882b
	ldp	q0, q1, [x2, #160]
	stp	q0, q1, [x3, #160]
	cmp	w4, #160
	b.lo	882b
	ldp	q0, q1, [x2, #192]
	stp	q0, q1, [x3, #192]
	cmp	w4, #192
	b.lo	882b
	ldp	q0, q1, [x2, #224]
	stp	q0, q1, [x3, #224]
	cmp	w4, #224
	b.lo	882b
	ldp	q0, q1, [x2, #256]
	stp	q0, q1, [x3, #256]
	b	882b
932:
	cmp	x22, x2
	csel	x7, x22, x2, lo
	sub	x5, x2, x7
	cmp	x7, x3
	b.hs	892b
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
	b.lo	902b
942:
	cmp	x7, #31
	b.hi	952f
	str	x16, [x0, #104]
952:
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
	b.lo	902b
	ldp	q0, q1, [x5, #64]
	stp	q0, q1, [x4, #64]
	cmp	w6, #64
	b.lo	902b
	ldp	q0, q1, [x5, #96]
	stp	q0, q1, [x4, #96]
	cmp	w6, #96
	b.lo	902b
	ldp	q0, q1, [x5, #128]
	stp	q0, q1, [x4, #128]
	tbz	w6, #7, 902b
	ldp	q0, q1, [x5, #160]
	stp	q0, q1, [x4, #160]
	cmp	w6, #160
	b.lo	902b
	ldp	q0, q1, [x5, #192]
	stp	q0, q1, [x4, #192]
	cmp	w6, #192
	b.lo	902b
	ldp	q0, q1, [x5, #224]
	stp	q0, q1, [x4, #224]
	cmp	w6, #224
	b.lo	902b
	ldp	q0, q1, [x5, #256]
	stp	q0, q1, [x4, #256]
	b	902b
962:
	stp	x24, x21, [x0, #80]
	str	x22, [x0, #96]
	ldp	x20, x19, [sp, #80]
	ldp	x22, x21, [sp, #64]
	ldp	x24, x23, [sp, #48]
	ldp	x26, x25, [sp, #32]
	ldp	x28, x27, [sp, #16]
	ldp	x29, x30, [sp], #96
972:
	ret

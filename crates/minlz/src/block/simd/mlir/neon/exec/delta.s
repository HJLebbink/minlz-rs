// minlz_exec_delta of crates/minlz/mlir/exec8.mlir for neon, written by
// cargo xtask mlir. Do not edit.
	ldr	x10, [x0, #64]
	mov	x16, #72340172838076673
	//APP
	//NO_APP
	cbz	x10, 1262f
	stp	x29, x30, [sp, #-96]!
	stp	x24, x23, [sp, #48]
	ldp	x8, x9, [x0]
	ldp	x15, x1, [x0, #16]
	ldp	x24, x17, [x0, #72]
	stp	x26, x25, [sp, #32]
	stp	x22, x21, [sp, #64]
	ldp	x14, x22, [x0, #88]
	ldp	x2, x11, [x0, #32]
	ldr	x12, [x0, #56]
	add	x25, x8, x17
	ldr	x17, [x15]
	add	x23, x9, x14
	ldr	d0, [x1]
	ldr	x13, [x0, #120]
	stp	x28, x27, [sp, #16]
	stp	x20, x19, [sp, #80]
	and	x14, x16, x17, lsr #1
	bic	x3, x16, x17
	and	x17, x17, x16
	mul	x5, x14, x16
	sub	x4, x5, x14
	eor	x14, x14, x16
	orr	x14, x4, x14, lsl #7
	mul	x4, x3, x16
	fmov	d1, x14
	sub	x3, x4, x3
	orr	x17, x3, x17, lsl #7
	tbl	v0.8b, { v0.16b }, v1.8b
	fmov	d1, x17
	fmov	x14, d0
	ldr	d0, [x2]
	tbl	v0.8b, { v0.16b }, v1.8b
	fmov	x17, d0
	cmp	x10, #8
	b.lo	1082f
	lsr	x4, x4, #56
	lsr	x5, x5, #56
	mov	x3, xzr
	mov	x7, x15
	.p2align	5, , 16
2:
	subs	x10, x10, #8
	b.ne	12f
	mov	x19, x14
	mov	x20, x17
	b	22f
	.p2align	5, , 16
12:
	ldr	x20, [x7, #8]
	ldr	d0, [x1, x5]
	and	x19, x16, x20, lsr #1
	bic	x21, x16, x20
	and	x20, x20, x16
	mul	x26, x19, x16
	sub	x27, x26, x19
	eor	x19, x19, x16
	add	x5, x5, x26, lsr #56
	mul	x26, x21, x16
	orr	x19, x27, x19, lsl #7
	fmov	d1, x19
	sub	x21, x26, x21
	orr	x20, x21, x20, lsl #7
	tbl	v0.8b, { v0.16b }, v1.8b
	fmov	d1, x20
	fmov	x19, d0
	ldr	d0, [x2, x4]
	add	x4, x4, x26, lsr #56
	tbl	v0.8b, { v0.16b }, v1.8b
	fmov	x20, d0
22:
	and	x21, x17, #0xff
	//APP
	//NO_APP
	ldr	x27, [x12, x21, lsl #3]
	lsr	x21, x24, #3
	and	x26, x24, #0x7
	ldr	x21, [x11, x21]
	lsr	x21, x21, x26
	and	w21, w21, w27, lsr #8
	adds	x21, x21, x27, lsr #32
	csel	x26, x22, x21, eq
	cmp	x22, #32
	b.lo	862f
	sub	x21, x25, x22
	cmp	x21, x8
	b.lt	862f
32:
	ldp	q0, q1, [x21]
42:
	ldp	q3, q2, [x23]
	ldr	x21, [x7]
	and	x22, x14, #0xff
	add	v1.16b, v1.16b, v2.16b
	add	v0.16b, v0.16b, v3.16b
	stp	q0, q1, [x25]
	cmp	x22, #33
	b.hs	362f
	add	x25, x25, x22
	ubfx	x29, x21, #2, #6
	sub	x28, x25, x26
	cmp	x26, x29
	ccmp	x28, x8, #8, hs
	b.lt	382f
52:
	ldp	q1, q0, [x28]
	mov	x30, x26
62:
	stp	q1, q0, [x25]
	cmp	x29, #33
	b.hs	392f
72:
	add	x24, x24, w27, uxtb
	add	x27, x25, x29
	add	x23, x23, x22
	ubfx	x22, x17, #8, #8
	//APP
	//NO_APP
	ldr	x25, [x12, x22, lsl #3]
	ldp	q0, q1, [x23]
	neg	x6, x26
	lsr	x22, x24, #3
	and	x28, x24, #0x7
	ldr	x22, [x11, x22]
	lsr	x22, x22, x28
	add	x28, x27, x6
	and	w22, w22, w25, lsr #8
	adds	x22, x22, x25, lsr #32
	csel	x22, x26, x22, eq
	cmp	x26, #32
	ccmp	x28, x8, #8, hs
	b.lt	842f
	ldp	q2, q3, [x28]
82:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	ubfx	x26, x14, #8, #8
	stp	q0, q1, [x27]
	cmp	x26, #33
	b.hs	422f
	add	x27, x27, x26
	ubfx	x29, x21, #10, #6
	sub	x28, x27, x22
	cmp	x22, x29
	ccmp	x28, x8, #8, hs
	b.lt	442f
92:
	ldp	q1, q0, [x28]
	mov	x30, x22
102:
	stp	q1, q0, [x27]
	cmp	x29, #33
	b.hs	452f
112:
	add	x25, x24, w25, uxtb
	add	x24, x23, x26
	ubfx	x23, x17, #16, #8
	//APP
	//NO_APP
	ldr	x26, [x12, x23, lsl #3]
	neg	x6, x22
	ldp	q0, q1, [x24]
	add	x27, x27, x29
	lsr	x23, x25, #3
	and	x28, x25, #0x7
	ldr	x23, [x11, x23]
	lsr	x23, x23, x28
	add	x28, x27, x6
	and	w23, w23, w26, lsr #8
	adds	x23, x23, x26, lsr #32
	csel	x23, x22, x23, eq
	cmp	x22, #32
	ccmp	x28, x8, #8, hs
	b.lt	852f
	ldp	q2, q3, [x28]
122:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	ubfx	x22, x14, #16, #8
	stp	q0, q1, [x27]
	cmp	x22, #33
	b.hs	482f
	add	x27, x27, x22
	ubfx	x29, x21, #18, #6
	cmp	x23, x29
	b.lo	502f
132:
	sub	x28, x27, x23
	cmp	x28, x8
	b.lt	502f
	ldp	q1, q0, [x28]
	mov	x30, x23
142:
	stp	q1, q0, [x27]
	cmp	x29, #33
	b.hs	512f
152:
	add	x25, x25, w26, uxtb
	lsr	w6, w17, #24
	//APP
	//NO_APP
	ldr	x26, [x12, x6, lsl #3]
	add	x24, x24, x22
	add	x27, x27, x29
	ldp	q0, q1, [x24]
	lsr	x6, x25, #3
	and	x22, x25, #0x7
	ldr	x6, [x11, x6]
	lsr	x6, x6, x22
	and	w6, w6, w26, lsr #8
	adds	x6, x6, x26, lsr #32
	csel	x22, x23, x6, eq
	cmp	x23, #32
	b.lo	872f
	neg	x6, x23
	add	x28, x27, x6
	cmp	x28, x8
	b.lt	872f
	ldp	q2, q3, [x28]
162:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	lsr	w23, w14, #24
	stp	q0, q1, [x27]
	cmp	x23, #33
	b.hs	542f
	add	x27, x27, x23
	lsr	w29, w21, #26
	cmp	x22, x29
	b.lo	562f
172:
	sub	x28, x27, x22
	cmp	x28, x8
	b.lt	562f
	ldp	q1, q0, [x28]
	mov	x30, x22
182:
	stp	q1, q0, [x27]
	cmp	x29, #33
	b.hs	572f
192:
	add	x25, x25, w26, uxtb
	ubfx	x6, x17, #32, #8
	//APP
	//NO_APP
	ldr	x26, [x12, x6, lsl #3]
	add	x24, x24, x23
	add	x27, x27, x29
	ldp	q0, q1, [x24]
	lsr	x6, x25, #3
	and	x23, x25, #0x7
	ldr	x6, [x11, x6]
	lsr	x6, x6, x23
	and	w6, w6, w26, lsr #8
	adds	x6, x6, x26, lsr #32
	csel	x23, x22, x6, eq
	cmp	x22, #32
	b.lo	882f
	neg	x6, x22
	add	x28, x27, x6
	cmp	x28, x8
	b.lt	882f
	ldp	q2, q3, [x28]
202:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	ubfx	x22, x14, #32, #8
	stp	q0, q1, [x27]
	cmp	x22, #33
	b.hs	602f
	add	x27, x27, x22
	ubfx	x29, x21, #34, #6
	cmp	x23, x29
	b.lo	622f
212:
	sub	x28, x27, x23
	cmp	x28, x8
	b.lt	622f
	ldp	q1, q0, [x28]
	mov	x30, x23
222:
	stp	q1, q0, [x27]
	cmp	x29, #33
	b.hs	632f
232:
	add	x25, x25, w26, uxtb
	ubfx	x6, x17, #40, #8
	//APP
	//NO_APP
	ldr	x26, [x12, x6, lsl #3]
	add	x24, x24, x22
	add	x27, x27, x29
	ldp	q0, q1, [x24]
	lsr	x6, x25, #3
	and	x22, x25, #0x7
	ldr	x6, [x11, x6]
	lsr	x6, x6, x22
	and	w6, w6, w26, lsr #8
	adds	x6, x6, x26, lsr #32
	csel	x22, x23, x6, eq
	cmp	x23, #32
	b.lo	892f
	neg	x6, x23
	add	x28, x27, x6
	cmp	x28, x8
	b.lt	892f
	ldp	q2, q3, [x28]
242:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	ubfx	x23, x14, #40, #8
	stp	q0, q1, [x27]
	cmp	x23, #33
	b.hs	662f
	add	x27, x27, x23
	ubfx	x29, x21, #42, #6
	cmp	x22, x29
	b.lo	682f
252:
	sub	x28, x27, x22
	cmp	x28, x8
	b.lt	682f
	ldp	q1, q0, [x28]
	mov	x30, x22
262:
	stp	q1, q0, [x27]
	cmp	x29, #33
	b.hs	692f
272:
	add	x26, x25, w26, uxtb
	add	x25, x24, x23
	ubfx	x6, x17, #48, #8
	//APP
	//NO_APP
	ldr	x24, [x12, x6, lsl #3]
	add	x27, x27, x29
	ldp	q0, q1, [x25]
	lsr	x6, x26, #3
	and	x23, x26, #0x7
	ldr	x6, [x11, x6]
	lsr	x6, x6, x23
	and	w6, w6, w24, lsr #8
	adds	x6, x6, x24, lsr #32
	csel	x23, x22, x6, eq
	cmp	x22, #32
	b.lo	902f
	neg	x6, x22
	add	x28, x27, x6
	cmp	x28, x8
	b.lt	902f
	ldp	q2, q3, [x28]
282:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	ubfx	x22, x14, #48, #8
	stp	q0, q1, [x27]
	cmp	x22, #33
	b.hs	722f
	add	x27, x27, x22
	ubfx	x29, x21, #50, #6
	cmp	x23, x29
	b.lo	742f
292:
	sub	x28, x27, x23
	cmp	x28, x8
	b.lt	742f
	ldp	q1, q0, [x28]
	mov	x30, x23
302:
	stp	q1, q0, [x27]
	cmp	x29, #33
	b.hs	752f
312:
	add	x24, x26, w24, uxtb
	lsr	x17, x17, #56
	//APP
	//NO_APP
	ldr	x17, [x12, x17, lsl #3]
	add	x26, x25, x22
	add	x27, x27, x29
	ldp	q0, q1, [x26]
	lsr	x6, x24, #3
	and	x22, x24, #0x7
	ldr	x6, [x11, x6]
	lsr	x6, x6, x22
	and	w6, w6, w17, lsr #8
	adds	x6, x6, x17, lsr #32
	csel	x22, x23, x6, eq
	cmp	x23, #32
	b.lo	912f
	neg	x6, x23
	add	x25, x27, x6
	cmp	x25, x8
	b.lt	912f
	ldp	q2, q3, [x25]
322:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	lsr	x14, x14, #56
	stp	q0, q1, [x27]
	cmp	x14, #33
	b.hs	782f
	add	x23, x27, x14
	lsr	x25, x21, #58
	cmp	x22, x25
	b.lo	802f
332:
	sub	x21, x23, x22
	cmp	x21, x8
	b.lt	802f
	ldp	q1, q0, [x21]
	mov	x27, x22
342:
	stp	q1, q0, [x23]
	cmp	x25, #33
	b.hs	812f
352:
	add	x24, x24, w17, uxtb
	add	x25, x23, x25
	add	x23, x26, x14
	sub	x3, x3, #8
	add	x7, x7, #8
	mov	x17, x20
	mov	x14, x19
	cmp	x10, #7
	b.hi	2b
	b	1092f
362:
	ldr	x22, [x0, #48]
	ldp	q0, q1, [x23, #32]
	ldrb	w22, [x22, x13]
	stp	q0, q1, [x25, #32]
	cmp	w22, #32
	b.lo	372f
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x25, #64]
	cmp	w22, #64
	b.lo	372f
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x25, #96]
	cmp	w22, #96
	b.lo	372f
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x25, #128]
	tbz	w22, #7, 372f
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x25, #160]
	cmp	w22, #160
	b.lo	372f
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x25, #192]
	cmp	w22, #192
	b.lo	372f
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x25, #224]
	cmp	w22, #224
	b.lo	372f
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x25, #256]
372:
	add	x22, x22, #33
	add	x13, x13, #1
	add	x25, x25, x22
	ubfx	x29, x21, #2, #6
	sub	x28, x25, x26
	cmp	x26, x29
	ccmp	x28, x8, #8, hs
	b.ge	52b
382:
	sub	x28, x25, x8
	cmp	x26, x28
	csel	x30, x26, x28, lo
	sub	x28, x28, x30
	cmp	x30, x29
	b.hs	922f
	add	x6, x12, x30, lsl #5
	ldr	q0, [x6, #2064]
	ldr	q1, [x6, #2048]
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x6]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	62b
392:
	cmp	x30, #31
	b.hi	402f
	mov	w6, #1
	str	x6, [x0, #104]
402:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x28, #32]
	ldrb	w29, [x6, x13]
	stp	q0, q1, [x25, #32]
	cmp	w29, #32
	b.lo	412f
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x25, #64]
	cmp	w29, #64
	b.lo	412f
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x25, #96]
	cmp	w29, #96
	b.lo	412f
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x25, #128]
	tbz	w29, #7, 412f
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x25, #160]
	cmp	w29, #160
	b.lo	412f
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x25, #192]
	cmp	w29, #192
	b.lo	412f
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x25, #224]
	cmp	w29, #224
	b.lo	412f
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x25, #256]
412:
	add	x29, x29, #33
	add	x13, x13, #1
	b	72b
422:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x23, #32]
	ldrb	w26, [x6, x13]
	stp	q0, q1, [x27, #32]
	cmp	w26, #32
	b.lo	432f
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x27, #64]
	cmp	w26, #64
	b.lo	432f
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x27, #96]
	cmp	w26, #96
	b.lo	432f
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x27, #128]
	tbz	w26, #7, 432f
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x27, #160]
	cmp	w26, #160
	b.lo	432f
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x27, #192]
	cmp	w26, #192
	b.lo	432f
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x27, #224]
	cmp	w26, #224
	b.lo	432f
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x27, #256]
432:
	add	x26, x26, #33
	add	x13, x13, #1
	add	x27, x27, x26
	ubfx	x29, x21, #10, #6
	sub	x28, x27, x22
	cmp	x22, x29
	ccmp	x28, x8, #8, hs
	b.ge	92b
442:
	sub	x6, x27, x8
	cmp	x22, x6
	csel	x30, x22, x6, lo
	sub	x28, x6, x30
	cmp	x30, x29
	b.hs	932f
	add	x6, x12, x30, lsl #5
	ldr	q0, [x6, #2064]
	ldr	q1, [x6, #2048]
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x6]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	102b
452:
	cmp	x30, #31
	b.hi	462f
	mov	w6, #1
	str	x6, [x0, #104]
462:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x28, #32]
	ldrb	w29, [x6, x13]
	stp	q0, q1, [x27, #32]
	cmp	w29, #32
	b.lo	472f
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x27, #64]
	cmp	w29, #64
	b.lo	472f
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x27, #96]
	cmp	w29, #96
	b.lo	472f
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x27, #128]
	tbz	w29, #7, 472f
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x27, #160]
	cmp	w29, #160
	b.lo	472f
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x27, #192]
	cmp	w29, #192
	b.lo	472f
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x27, #224]
	cmp	w29, #224
	b.lo	472f
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x27, #256]
472:
	add	x29, x29, #33
	add	x13, x13, #1
	b	112b
482:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x24, #32]
	ldrb	w22, [x6, x13]
	stp	q0, q1, [x27, #32]
	cmp	w22, #32
	b.lo	492f
	ldp	q0, q1, [x24, #64]
	stp	q0, q1, [x27, #64]
	cmp	w22, #64
	b.lo	492f
	ldp	q0, q1, [x24, #96]
	stp	q0, q1, [x27, #96]
	cmp	w22, #96
	b.lo	492f
	ldp	q0, q1, [x24, #128]
	stp	q0, q1, [x27, #128]
	tbz	w22, #7, 492f
	ldp	q0, q1, [x24, #160]
	stp	q0, q1, [x27, #160]
	cmp	w22, #160
	b.lo	492f
	ldp	q0, q1, [x24, #192]
	stp	q0, q1, [x27, #192]
	cmp	w22, #192
	b.lo	492f
	ldp	q0, q1, [x24, #224]
	stp	q0, q1, [x27, #224]
	cmp	w22, #224
	b.lo	492f
	ldp	q0, q1, [x24, #256]
	stp	q0, q1, [x27, #256]
492:
	add	x22, x22, #33
	add	x13, x13, #1
	add	x27, x27, x22
	ubfx	x29, x21, #18, #6
	cmp	x23, x29
	b.hs	132b
502:
	sub	x6, x27, x8
	cmp	x23, x6
	csel	x30, x23, x6, lo
	sub	x28, x6, x30
	cmp	x30, x29
	b.hs	962f
	add	x6, x12, x30, lsl #5
	ldr	q0, [x6, #2064]
	ldr	q1, [x6, #2048]
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x6]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	142b
512:
	cmp	x30, #31
	b.hi	522f
	mov	w6, #1
	str	x6, [x0, #104]
522:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x28, #32]
	ldrb	w29, [x6, x13]
	stp	q0, q1, [x27, #32]
	cmp	w29, #32
	b.lo	532f
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x27, #64]
	cmp	w29, #64
	b.lo	532f
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x27, #96]
	cmp	w29, #96
	b.lo	532f
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x27, #128]
	tbz	w29, #7, 532f
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x27, #160]
	cmp	w29, #160
	b.lo	532f
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x27, #192]
	cmp	w29, #192
	b.lo	532f
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x27, #224]
	cmp	w29, #224
	b.lo	532f
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x27, #256]
532:
	add	x29, x29, #33
	add	x13, x13, #1
	b	152b
542:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x24, #32]
	ldrb	w23, [x6, x13]
	stp	q0, q1, [x27, #32]
	cmp	w23, #32
	b.lo	552f
	ldp	q0, q1, [x24, #64]
	stp	q0, q1, [x27, #64]
	cmp	w23, #64
	b.lo	552f
	ldp	q0, q1, [x24, #96]
	stp	q0, q1, [x27, #96]
	cmp	w23, #96
	b.lo	552f
	ldp	q0, q1, [x24, #128]
	stp	q0, q1, [x27, #128]
	tbz	w23, #7, 552f
	ldp	q0, q1, [x24, #160]
	stp	q0, q1, [x27, #160]
	cmp	w23, #160
	b.lo	552f
	ldp	q0, q1, [x24, #192]
	stp	q0, q1, [x27, #192]
	cmp	w23, #192
	b.lo	552f
	ldp	q0, q1, [x24, #224]
	stp	q0, q1, [x27, #224]
	cmp	w23, #224
	b.lo	552f
	ldp	q0, q1, [x24, #256]
	stp	q0, q1, [x27, #256]
552:
	add	x23, x23, #33
	add	x13, x13, #1
	add	x27, x27, x23
	lsr	w29, w21, #26
	cmp	x22, x29
	b.hs	172b
562:
	sub	x6, x27, x8
	cmp	x22, x6
	csel	x30, x22, x6, lo
	sub	x28, x6, x30
	cmp	x30, x29
	b.hs	972f
	add	x6, x12, x30, lsl #5
	ldr	q0, [x6, #2064]
	ldr	q1, [x6, #2048]
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x6]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	182b
572:
	cmp	x30, #31
	b.hi	582f
	mov	w6, #1
	str	x6, [x0, #104]
582:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x28, #32]
	ldrb	w29, [x6, x13]
	stp	q0, q1, [x27, #32]
	cmp	w29, #32
	b.lo	592f
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x27, #64]
	cmp	w29, #64
	b.lo	592f
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x27, #96]
	cmp	w29, #96
	b.lo	592f
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x27, #128]
	tbz	w29, #7, 592f
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x27, #160]
	cmp	w29, #160
	b.lo	592f
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x27, #192]
	cmp	w29, #192
	b.lo	592f
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x27, #224]
	cmp	w29, #224
	b.lo	592f
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x27, #256]
592:
	add	x29, x29, #33
	add	x13, x13, #1
	b	192b
602:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x24, #32]
	ldrb	w22, [x6, x13]
	stp	q0, q1, [x27, #32]
	cmp	w22, #32
	b.lo	612f
	ldp	q0, q1, [x24, #64]
	stp	q0, q1, [x27, #64]
	cmp	w22, #64
	b.lo	612f
	ldp	q0, q1, [x24, #96]
	stp	q0, q1, [x27, #96]
	cmp	w22, #96
	b.lo	612f
	ldp	q0, q1, [x24, #128]
	stp	q0, q1, [x27, #128]
	tbz	w22, #7, 612f
	ldp	q0, q1, [x24, #160]
	stp	q0, q1, [x27, #160]
	cmp	w22, #160
	b.lo	612f
	ldp	q0, q1, [x24, #192]
	stp	q0, q1, [x27, #192]
	cmp	w22, #192
	b.lo	612f
	ldp	q0, q1, [x24, #224]
	stp	q0, q1, [x27, #224]
	cmp	w22, #224
	b.lo	612f
	ldp	q0, q1, [x24, #256]
	stp	q0, q1, [x27, #256]
612:
	add	x22, x22, #33
	add	x13, x13, #1
	add	x27, x27, x22
	ubfx	x29, x21, #34, #6
	cmp	x23, x29
	b.hs	212b
622:
	sub	x6, x27, x8
	cmp	x23, x6
	csel	x30, x23, x6, lo
	sub	x28, x6, x30
	cmp	x30, x29
	b.hs	982f
	add	x6, x12, x30, lsl #5
	ldr	q0, [x6, #2064]
	ldr	q1, [x6, #2048]
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x6]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	222b
632:
	cmp	x30, #31
	b.hi	642f
	mov	w6, #1
	str	x6, [x0, #104]
642:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x28, #32]
	ldrb	w29, [x6, x13]
	stp	q0, q1, [x27, #32]
	cmp	w29, #32
	b.lo	652f
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x27, #64]
	cmp	w29, #64
	b.lo	652f
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x27, #96]
	cmp	w29, #96
	b.lo	652f
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x27, #128]
	tbz	w29, #7, 652f
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x27, #160]
	cmp	w29, #160
	b.lo	652f
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x27, #192]
	cmp	w29, #192
	b.lo	652f
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x27, #224]
	cmp	w29, #224
	b.lo	652f
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x27, #256]
652:
	add	x29, x29, #33
	add	x13, x13, #1
	b	232b
662:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x24, #32]
	ldrb	w23, [x6, x13]
	stp	q0, q1, [x27, #32]
	cmp	w23, #32
	b.lo	672f
	ldp	q0, q1, [x24, #64]
	stp	q0, q1, [x27, #64]
	cmp	w23, #64
	b.lo	672f
	ldp	q0, q1, [x24, #96]
	stp	q0, q1, [x27, #96]
	cmp	w23, #96
	b.lo	672f
	ldp	q0, q1, [x24, #128]
	stp	q0, q1, [x27, #128]
	tbz	w23, #7, 672f
	ldp	q0, q1, [x24, #160]
	stp	q0, q1, [x27, #160]
	cmp	w23, #160
	b.lo	672f
	ldp	q0, q1, [x24, #192]
	stp	q0, q1, [x27, #192]
	cmp	w23, #192
	b.lo	672f
	ldp	q0, q1, [x24, #224]
	stp	q0, q1, [x27, #224]
	cmp	w23, #224
	b.lo	672f
	ldp	q0, q1, [x24, #256]
	stp	q0, q1, [x27, #256]
672:
	add	x23, x23, #33
	add	x13, x13, #1
	add	x27, x27, x23
	ubfx	x29, x21, #42, #6
	cmp	x22, x29
	b.hs	252b
682:
	sub	x6, x27, x8
	cmp	x22, x6
	csel	x30, x22, x6, lo
	sub	x28, x6, x30
	cmp	x30, x29
	b.hs	992f
	add	x6, x12, x30, lsl #5
	ldr	q0, [x6, #2064]
	ldr	q1, [x6, #2048]
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x6]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	262b
692:
	cmp	x30, #31
	b.hi	702f
	mov	w6, #1
	str	x6, [x0, #104]
702:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x28, #32]
	ldrb	w29, [x6, x13]
	stp	q0, q1, [x27, #32]
	cmp	w29, #32
	b.lo	712f
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x27, #64]
	cmp	w29, #64
	b.lo	712f
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x27, #96]
	cmp	w29, #96
	b.lo	712f
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x27, #128]
	tbz	w29, #7, 712f
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x27, #160]
	cmp	w29, #160
	b.lo	712f
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x27, #192]
	cmp	w29, #192
	b.lo	712f
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x27, #224]
	cmp	w29, #224
	b.lo	712f
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x27, #256]
712:
	add	x29, x29, #33
	add	x13, x13, #1
	b	272b
722:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x25, #32]
	ldrb	w22, [x6, x13]
	stp	q0, q1, [x27, #32]
	cmp	w22, #32
	b.lo	732f
	ldp	q0, q1, [x25, #64]
	stp	q0, q1, [x27, #64]
	cmp	w22, #64
	b.lo	732f
	ldp	q0, q1, [x25, #96]
	stp	q0, q1, [x27, #96]
	cmp	w22, #96
	b.lo	732f
	ldp	q0, q1, [x25, #128]
	stp	q0, q1, [x27, #128]
	tbz	w22, #7, 732f
	ldp	q0, q1, [x25, #160]
	stp	q0, q1, [x27, #160]
	cmp	w22, #160
	b.lo	732f
	ldp	q0, q1, [x25, #192]
	stp	q0, q1, [x27, #192]
	cmp	w22, #192
	b.lo	732f
	ldp	q0, q1, [x25, #224]
	stp	q0, q1, [x27, #224]
	cmp	w22, #224
	b.lo	732f
	ldp	q0, q1, [x25, #256]
	stp	q0, q1, [x27, #256]
732:
	add	x22, x22, #33
	add	x13, x13, #1
	add	x27, x27, x22
	ubfx	x29, x21, #50, #6
	cmp	x23, x29
	b.hs	292b
742:
	sub	x6, x27, x8
	cmp	x23, x6
	csel	x30, x23, x6, lo
	sub	x28, x6, x30
	cmp	x30, x29
	b.hs	1002f
	add	x6, x12, x30, lsl #5
	ldr	q0, [x6, #2064]
	ldr	q1, [x6, #2048]
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x6]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	302b
752:
	cmp	x30, #31
	b.hi	762f
	mov	w6, #1
	str	x6, [x0, #104]
762:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x28, #32]
	ldrb	w29, [x6, x13]
	stp	q0, q1, [x27, #32]
	cmp	w29, #32
	b.lo	772f
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x27, #64]
	cmp	w29, #64
	b.lo	772f
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x27, #96]
	cmp	w29, #96
	b.lo	772f
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x27, #128]
	tbz	w29, #7, 772f
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x27, #160]
	cmp	w29, #160
	b.lo	772f
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x27, #192]
	cmp	w29, #192
	b.lo	772f
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x27, #224]
	cmp	w29, #224
	b.lo	772f
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x27, #256]
772:
	add	x29, x29, #33
	add	x13, x13, #1
	b	312b
782:
	ldr	x14, [x0, #48]
	ldp	q0, q1, [x26, #32]
	ldrb	w14, [x14, x13]
	stp	q0, q1, [x27, #32]
	cmp	w14, #32
	b.lo	792f
	ldp	q0, q1, [x26, #64]
	stp	q0, q1, [x27, #64]
	cmp	w14, #64
	b.lo	792f
	ldp	q0, q1, [x26, #96]
	stp	q0, q1, [x27, #96]
	cmp	w14, #96
	b.lo	792f
	ldp	q0, q1, [x26, #128]
	stp	q0, q1, [x27, #128]
	tbz	w14, #7, 792f
	ldp	q0, q1, [x26, #160]
	stp	q0, q1, [x27, #160]
	cmp	w14, #160
	b.lo	792f
	ldp	q0, q1, [x26, #192]
	stp	q0, q1, [x27, #192]
	cmp	w14, #192
	b.lo	792f
	ldp	q0, q1, [x26, #224]
	stp	q0, q1, [x27, #224]
	cmp	w14, #224
	b.lo	792f
	ldp	q0, q1, [x26, #256]
	stp	q0, q1, [x27, #256]
792:
	add	x14, x14, #33
	add	x13, x13, #1
	add	x23, x27, x14
	lsr	x25, x21, #58
	cmp	x22, x25
	b.hs	332b
802:
	sub	x6, x23, x8
	cmp	x22, x6
	csel	x27, x22, x6, lo
	sub	x21, x6, x27
	cmp	x27, x25
	b.hs	1012f
	add	x6, x12, x27, lsl #5
	ldr	q0, [x6, #2064]
	ldr	q1, [x6, #2048]
	add	x6, x8, x21
	add	x21, x8, x21
	ldp	q2, q3, [x6]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	342b
812:
	cmp	x27, #31
	b.hi	822f
	mov	w6, #1
	str	x6, [x0, #104]
822:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x21, #32]
	ldrb	w25, [x6, x13]
	stp	q0, q1, [x23, #32]
	cmp	w25, #32
	b.lo	832f
	ldp	q0, q1, [x21, #64]
	stp	q0, q1, [x23, #64]
	cmp	w25, #64
	b.lo	832f
	ldp	q0, q1, [x21, #96]
	stp	q0, q1, [x23, #96]
	cmp	w25, #96
	b.lo	832f
	ldp	q0, q1, [x21, #128]
	stp	q0, q1, [x23, #128]
	tbz	w25, #7, 832f
	ldp	q0, q1, [x21, #160]
	stp	q0, q1, [x23, #160]
	cmp	w25, #160
	b.lo	832f
	ldp	q0, q1, [x21, #192]
	stp	q0, q1, [x23, #192]
	cmp	w25, #192
	b.lo	832f
	ldp	q0, q1, [x21, #224]
	stp	q0, q1, [x23, #224]
	cmp	w25, #224
	b.lo	832f
	ldp	q0, q1, [x21, #256]
	stp	q0, q1, [x23, #256]
832:
	add	x25, x25, #33
	add	x13, x13, #1
	b	352b
842:
	sub	x6, x27, x8
	cmp	x26, x6
	csel	x28, x26, x6, lo
	sub	x26, x6, x28
	cmp	x28, #31
	b.ls	942f
	add	x6, x8, x26
	ldp	q2, q3, [x6]
	b	82b
852:
	sub	x6, x27, x8
	cmp	x22, x6
	csel	x28, x22, x6, lo
	sub	x22, x6, x28
	cmp	x28, #31
	b.ls	952f
	add	x6, x8, x22
	ldp	q2, q3, [x6]
	b	122b
862:
	sub	x21, x25, x8
	cmp	x22, x21
	csel	x22, x22, x21, lo
	sub	x21, x21, x22
	cmp	x22, #31
	b.ls	1022f
	add	x21, x8, x21
	b	32b
872:
	sub	x6, x27, x8
	cmp	x23, x6
	csel	x28, x23, x6, lo
	sub	x23, x6, x28
	cmp	x28, #31
	b.ls	1032f
	add	x6, x8, x23
	ldp	q2, q3, [x6]
	b	162b
882:
	sub	x6, x27, x8
	cmp	x22, x6
	csel	x28, x22, x6, lo
	sub	x22, x6, x28
	cmp	x28, #31
	b.ls	1042f
	add	x6, x8, x22
	ldp	q2, q3, [x6]
	b	202b
892:
	sub	x6, x27, x8
	cmp	x23, x6
	csel	x28, x23, x6, lo
	sub	x23, x6, x28
	cmp	x28, #31
	b.ls	1052f
	add	x6, x8, x23
	ldp	q2, q3, [x6]
	b	242b
902:
	sub	x6, x27, x8
	cmp	x22, x6
	csel	x28, x22, x6, lo
	sub	x22, x6, x28
	cmp	x28, #31
	b.ls	1062f
	add	x6, x8, x22
	ldp	q2, q3, [x6]
	b	282b
912:
	sub	x6, x27, x8
	cmp	x23, x6
	csel	x25, x23, x6, lo
	sub	x23, x6, x25
	cmp	x25, #31
	b.ls	1072f
	add	x6, x8, x23
	ldp	q2, q3, [x6]
	b	322b
922:
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x6]
	b	62b
932:
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x6]
	b	102b
942:
	add	x6, x12, x28, lsl #5
	ldr	q3, [x6, #2064]
	ldr	q2, [x6, #2048]
	add	x6, x8, x26
	ldp	q4, q5, [x6]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	82b
952:
	add	x6, x12, x28, lsl #5
	ldr	q3, [x6, #2064]
	ldr	q2, [x6, #2048]
	add	x6, x8, x22
	ldp	q4, q5, [x6]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	122b
962:
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x6]
	b	142b
972:
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x6]
	b	182b
982:
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x6]
	b	222b
992:
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x6]
	b	262b
1002:
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x6]
	b	302b
1012:
	add	x6, x8, x21
	add	x21, x8, x21
	ldp	q1, q0, [x6]
	b	342b
1022:
	add	x22, x12, x22, lsl #5
	add	x21, x8, x21
	ldp	q2, q3, [x21]
	ldr	q1, [x22, #2064]
	ldr	q0, [x22, #2048]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	42b
1032:
	add	x6, x12, x28, lsl #5
	ldr	q3, [x6, #2064]
	ldr	q2, [x6, #2048]
	add	x6, x8, x23
	ldp	q4, q5, [x6]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	162b
1042:
	add	x6, x12, x28, lsl #5
	ldr	q3, [x6, #2064]
	ldr	q2, [x6, #2048]
	add	x6, x8, x22
	ldp	q4, q5, [x6]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	202b
1052:
	add	x6, x12, x28, lsl #5
	ldr	q3, [x6, #2064]
	ldr	q2, [x6, #2048]
	add	x6, x8, x23
	ldp	q4, q5, [x6]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	242b
1062:
	add	x6, x12, x28, lsl #5
	ldr	q3, [x6, #2064]
	ldr	q2, [x6, #2048]
	add	x6, x8, x22
	ldp	q4, q5, [x6]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	282b
1072:
	add	x6, x12, x25, lsl #5
	ldr	q3, [x6, #2064]
	ldr	q2, [x6, #2048]
	add	x6, x8, x23
	ldp	q4, q5, [x6]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	322b
1082:
	mov	x16, xzr
	b	1102f
1092:
	cbz	x10, 1252f
	neg	x16, x3
	mov	x17, x20
	mov	x14, x19
1102:
	ldr	x15, [x15, x16]
	mov	w16, #1
	mov	x2, x22
	.p2align	5, , 16
1112:
	lsr	x3, x24, #3
	and	x1, x17, #0xff
	//APP
	//NO_APP
	ldr	x1, [x12, x1, lsl #3]
	and	x4, x24, #0x7
	ldr	x3, [x11, x3]
	lsr	x3, x3, x4
	and	w3, w3, w1, lsr #8
	adds	x3, x3, x1, lsr #32
	csel	x22, x2, x3, eq
	cmp	x2, #32
	b.lo	1222f
	sub	x3, x25, x2
	cmp	x3, x8
	b.lt	1222f
	ldp	q0, q1, [x3]
1122:
	ldp	q3, q2, [x23]
	and	x2, x14, #0xff
	add	v1.16b, v1.16b, v2.16b
	add	v0.16b, v0.16b, v3.16b
	stp	q0, q1, [x25]
	cmp	x2, #33
	b.hs	1162f
	add	x3, x25, x2
	ubfx	x5, x15, #2, #6
	sub	x4, x3, x22
	cmp	x22, x5
	ccmp	x4, x8, #8, hs
	b.lt	1182f
1132:
	ldp	q1, q0, [x4]
	mov	x6, x22
1142:
	stp	q1, q0, [x3]
	cmp	x5, #33
	b.hs	1192f
1152:
	add	x24, x24, w1, uxtb
	add	x25, x3, x5
	add	x23, x23, x2
	subs	x10, x10, #1
	lsr	x15, x15, #8
	lsr	x14, x14, #8
	lsr	x17, x17, #8
	mov	x2, x22
	b.ne	1112b
	b	1252f
1162:
	ldr	x2, [x0, #48]
	ldp	q0, q1, [x23, #32]
	ldrb	w2, [x2, x13]
	stp	q0, q1, [x25, #32]
	cmp	w2, #32
	b.lo	1172f
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x25, #64]
	cmp	w2, #64
	b.lo	1172f
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x25, #96]
	cmp	w2, #96
	b.lo	1172f
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x25, #128]
	tbz	w2, #7, 1172f
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x25, #160]
	cmp	w2, #160
	b.lo	1172f
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x25, #192]
	cmp	w2, #192
	b.lo	1172f
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x25, #224]
	cmp	w2, #224
	b.lo	1172f
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x25, #256]
1172:
	add	x2, x2, #33
	add	x13, x13, #1
	add	x3, x25, x2
	ubfx	x5, x15, #2, #6
	sub	x4, x3, x22
	cmp	x22, x5
	ccmp	x4, x8, #8, hs
	b.ge	1132b
1182:
	sub	x4, x3, x8
	cmp	x22, x4
	csel	x6, x22, x4, lo
	sub	x4, x4, x6
	cmp	x6, x5
	b.hs	1232f
	add	x7, x12, x6, lsl #5
	ldr	q0, [x7, #2064]
	ldr	q1, [x7, #2048]
	add	x7, x8, x4
	add	x4, x8, x4
	ldp	q2, q3, [x7]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	1142b
1192:
	cmp	x6, #31
	b.hi	1202f
	str	x16, [x0, #104]
1202:
	ldr	x5, [x0, #48]
	ldp	q0, q1, [x4, #32]
	ldrb	w5, [x5, x13]
	stp	q0, q1, [x3, #32]
	cmp	w5, #32
	b.lo	1212f
	ldp	q0, q1, [x4, #64]
	stp	q0, q1, [x3, #64]
	cmp	w5, #64
	b.lo	1212f
	ldp	q0, q1, [x4, #96]
	stp	q0, q1, [x3, #96]
	cmp	w5, #96
	b.lo	1212f
	ldp	q0, q1, [x4, #128]
	stp	q0, q1, [x3, #128]
	tbz	w5, #7, 1212f
	ldp	q0, q1, [x4, #160]
	stp	q0, q1, [x3, #160]
	cmp	w5, #160
	b.lo	1212f
	ldp	q0, q1, [x4, #192]
	stp	q0, q1, [x3, #192]
	cmp	w5, #192
	b.lo	1212f
	ldp	q0, q1, [x4, #224]
	stp	q0, q1, [x3, #224]
	cmp	w5, #224
	b.lo	1212f
	ldp	q0, q1, [x4, #256]
	stp	q0, q1, [x3, #256]
1212:
	add	x5, x5, #33
	add	x13, x13, #1
	b	1152b
1222:
	sub	x4, x25, x8
	cmp	x2, x4
	csel	x3, x2, x4, lo
	sub	x2, x4, x3
	cmp	x3, #31
	b.ls	1242f
	add	x2, x8, x2
	ldp	q0, q1, [x2]
	b	1122b
1232:
	add	x7, x8, x4
	add	x4, x8, x4
	ldp	q1, q0, [x7]
	b	1142b
1242:
	add	x3, x12, x3, lsl #5
	add	x2, x8, x2
	ldp	q2, q3, [x2]
	ldr	q1, [x3, #2064]
	ldr	q0, [x3, #2048]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	1122b
1252:
	sub	x8, x25, x8
	sub	x9, x23, x9
	str	x22, [x0, #96]
	ldp	x20, x19, [sp, #80]
	ldp	x22, x21, [sp, #64]
	ldp	x24, x23, [sp, #48]
	ldp	x26, x25, [sp, #32]
	ldp	x28, x27, [sp, #16]
	stp	x8, x9, [x0, #80]
	ldp	x29, x30, [sp], #96
1262:
	ret

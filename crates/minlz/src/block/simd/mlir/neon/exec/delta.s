// minlz_exec_delta of crates/minlz/mlir/exec8.mlir for neon, written by
// cargo xtask mlir. Do not edit.
	ldr	x10, [x0, #64]
	mov	x16, #72340172838076673
	//APP
	//NO_APP
	cbz	x10, 1082f
	stp	x29, x30, [sp, #-96]!
	stp	x24, x23, [sp, #48]
	ldp	x8, x9, [x0]
	ldp	x15, x17, [x0, #16]
	ldp	x23, x14, [x0, #72]
	stp	x22, x21, [sp, #64]
	ldp	x13, x21, [x0, #88]
	ldp	x1, x11, [x0, #32]
	ldr	x12, [x0, #56]
	stp	x28, x27, [sp, #16]
	add	x24, x8, x14
	ldr	x14, [x15]
	add	x22, x9, x13
	ldr	d0, [x17]
	stp	x26, x25, [sp, #32]
	and	x13, x16, x14, lsr #1
	bic	x2, x16, x14
	and	x14, x14, x16
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
	cmp	x10, #8
	b.lo	922f
	lsr	x3, x3, #56
	lsr	x4, x4, #56
	mov	w5, #1
	mov	x2, xzr
	mov	x6, x15
	.p2align	5, , 16
2:
	subs	x10, x10, #8
	mov	x7, x13
	mov	x20, x14
	b.ne	12f
	mov	x13, x7
	mov	x14, x20
	b	22f
	.p2align	5, , 16
12:
	ldr	x14, [x6, #8]
	ldr	d0, [x17, x4]
	and	x13, x16, x14, lsr #1
	bic	x19, x16, x14
	and	x14, x14, x16
	mul	x25, x13, x16
	sub	x26, x25, x13
	eor	x13, x13, x16
	add	x4, x4, x25, lsr #56
	mul	x25, x19, x16
	orr	x13, x26, x13, lsl #7
	fmov	d1, x13
	sub	x19, x25, x19
	orr	x14, x19, x14, lsl #7
	tbl	v0.8b, { v0.16b }, v1.8b
	fmov	d1, x14
	fmov	x13, d0
	ldr	d0, [x1, x3]
	add	x3, x3, x25, lsr #56
	tbl	v0.8b, { v0.16b }, v1.8b
	fmov	x14, d0
22:
	and	x19, x20, #0xff
	//APP
	//NO_APP
	ldr	x26, [x12, x19, lsl #3]
	lsr	x19, x23, #3
	and	x25, x23, #0x7
	ldr	x19, [x11, x19]
	lsr	x19, x19, x25
	and	w19, w19, w26, lsr #8
	adds	x19, x19, x26, lsr #32
	csel	x25, x21, x19, eq
	cmp	x21, #32
	b.lo	642f
	sub	x19, x24, x21
	cmp	x19, x8
	b.lt	642f
32:
	ldp	q0, q1, [x19]
42:
	ldp	q3, q2, [x22]
	ldr	x19, [x6]
	and	x21, x7, #0xff
	add	v1.16b, v1.16b, v2.16b
	add	v0.16b, v0.16b, v3.16b
	stp	q0, q1, [x24]
	cmp	x21, #33
	b.hs	362f
52:
	add	x24, x24, x21
	ubfx	x27, x19, #2, #6
	sub	x28, x24, x25
	cmp	x25, x27
	ccmp	x28, x8, #8, hs
	b.lt	602f
	ldp	q1, q0, [x28]
	mov	x29, x25
62:
	stp	q1, q0, [x24]
	cmp	x27, #33
	b.hs	372f
72:
	add	x23, x23, w26, uxtb
	add	x26, x24, x27
	add	x22, x22, x21
	ubfx	x21, x20, #8, #8
	//APP
	//NO_APP
	ldr	x24, [x12, x21, lsl #3]
	ldp	q0, q1, [x22]
	neg	x28, x25
	lsr	x21, x23, #3
	and	x27, x23, #0x7
	ldr	x21, [x11, x21]
	lsr	x21, x21, x27
	add	x27, x26, x28
	and	w21, w21, w24, lsr #8
	adds	x21, x21, x24, lsr #32
	csel	x21, x25, x21, eq
	cmp	x25, #32
	ccmp	x27, x8, #8, hs
	b.lt	612f
	ldp	q2, q3, [x27]
82:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	ubfx	x25, x7, #8, #8
	stp	q0, q1, [x26]
	cmp	x25, #33
	b.hs	392f
92:
	add	x26, x26, x25
	ubfx	x27, x19, #10, #6
	sub	x28, x26, x21
	cmp	x21, x27
	ccmp	x28, x8, #8, hs
	b.lt	622f
	ldp	q1, q0, [x28]
	mov	x29, x21
102:
	stp	q1, q0, [x26]
	cmp	x27, #33
	b.hs	402f
112:
	add	x24, x23, w24, uxtb
	add	x23, x22, x25
	ubfx	x22, x20, #16, #8
	//APP
	//NO_APP
	ldr	x25, [x12, x22, lsl #3]
	add	x26, x26, x27
	ldp	q0, q1, [x23]
	neg	x28, x21
	lsr	x22, x24, #3
	and	x27, x24, #0x7
	ldr	x22, [x11, x22]
	lsr	x22, x22, x27
	add	x27, x26, x28
	and	w22, w22, w25, lsr #8
	adds	x22, x22, x25, lsr #32
	csel	x22, x21, x22, eq
	cmp	x21, #32
	ccmp	x27, x8, #8, hs
	b.lt	632f
	ldp	q2, q3, [x27]
122:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	ubfx	x21, x7, #16, #8
	stp	q0, q1, [x26]
	cmp	x21, #33
	b.hs	422f
132:
	add	x26, x26, x21
	ubfx	x27, x19, #18, #6
	cmp	x22, x27
	b.lo	652f
	sub	x28, x26, x22
	cmp	x28, x8
	b.lt	652f
	ldp	q1, q0, [x28]
	mov	x29, x22
142:
	stp	q1, q0, [x26]
	cmp	x27, #33
	b.hs	432f
152:
	add	x24, x24, w25, uxtb
	add	x23, x23, x21
	lsr	w21, w20, #24
	//APP
	//NO_APP
	ldr	x25, [x12, x21, lsl #3]
	add	x26, x26, x27
	ldp	q0, q1, [x23]
	lsr	x21, x24, #3
	and	x27, x24, #0x7
	ldr	x21, [x11, x21]
	lsr	x21, x21, x27
	and	w21, w21, w25, lsr #8
	adds	x21, x21, x25, lsr #32
	csel	x21, x22, x21, eq
	cmp	x22, #32
	b.lo	662f
	neg	x27, x22
	add	x27, x26, x27
	cmp	x27, x8
	b.lt	662f
	ldp	q2, q3, [x27]
162:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	lsr	w22, w7, #24
	stp	q0, q1, [x26]
	cmp	x22, #33
	b.hs	452f
172:
	add	x26, x26, x22
	lsr	w27, w19, #26
	cmp	x21, x27
	b.lo	672f
	sub	x28, x26, x21
	cmp	x28, x8
	b.lt	672f
	ldp	q1, q0, [x28]
	mov	x29, x21
182:
	stp	q1, q0, [x26]
	cmp	x27, #33
	b.hs	462f
192:
	add	x24, x24, w25, uxtb
	add	x23, x23, x22
	ubfx	x22, x20, #32, #8
	//APP
	//NO_APP
	ldr	x25, [x12, x22, lsl #3]
	add	x26, x26, x27
	ldp	q0, q1, [x23]
	lsr	x22, x24, #3
	and	x27, x24, #0x7
	ldr	x22, [x11, x22]
	lsr	x22, x22, x27
	and	w22, w22, w25, lsr #8
	adds	x22, x22, x25, lsr #32
	csel	x22, x21, x22, eq
	cmp	x21, #32
	b.lo	682f
	neg	x27, x21
	add	x27, x26, x27
	cmp	x27, x8
	b.lt	682f
	ldp	q2, q3, [x27]
202:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	ubfx	x21, x7, #32, #8
	stp	q0, q1, [x26]
	cmp	x21, #33
	b.hs	482f
212:
	add	x26, x26, x21
	ubfx	x27, x19, #34, #6
	cmp	x22, x27
	b.lo	692f
	sub	x28, x26, x22
	cmp	x28, x8
	b.lt	692f
	ldp	q1, q0, [x28]
	mov	x29, x22
222:
	stp	q1, q0, [x26]
	cmp	x27, #33
	b.hs	492f
232:
	add	x24, x24, w25, uxtb
	add	x23, x23, x21
	ubfx	x21, x20, #40, #8
	//APP
	//NO_APP
	ldr	x25, [x12, x21, lsl #3]
	add	x26, x26, x27
	ldp	q0, q1, [x23]
	lsr	x21, x24, #3
	and	x27, x24, #0x7
	ldr	x21, [x11, x21]
	lsr	x21, x21, x27
	and	w21, w21, w25, lsr #8
	adds	x21, x21, x25, lsr #32
	csel	x21, x22, x21, eq
	cmp	x22, #32
	b.lo	702f
	neg	x27, x22
	add	x27, x26, x27
	cmp	x27, x8
	b.lt	702f
	ldp	q2, q3, [x27]
242:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	ubfx	x22, x7, #40, #8
	stp	q0, q1, [x26]
	cmp	x22, #33
	b.hs	512f
252:
	add	x26, x26, x22
	ubfx	x27, x19, #42, #6
	cmp	x21, x27
	b.lo	712f
	sub	x28, x26, x21
	cmp	x28, x8
	b.lt	712f
	ldp	q1, q0, [x28]
	mov	x29, x21
262:
	stp	q1, q0, [x26]
	cmp	x27, #33
	b.hs	522f
272:
	add	x25, x24, w25, uxtb
	add	x24, x23, x22
	ubfx	x22, x20, #48, #8
	//APP
	//NO_APP
	ldr	x23, [x12, x22, lsl #3]
	add	x26, x26, x27
	ldp	q0, q1, [x24]
	lsr	x22, x25, #3
	and	x27, x25, #0x7
	ldr	x22, [x11, x22]
	lsr	x22, x22, x27
	and	w22, w22, w23, lsr #8
	adds	x22, x22, x23, lsr #32
	csel	x22, x21, x22, eq
	cmp	x21, #32
	b.lo	722f
	neg	x27, x21
	add	x27, x26, x27
	cmp	x27, x8
	b.lt	722f
	ldp	q2, q3, [x27]
282:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	ubfx	x21, x7, #48, #8
	stp	q0, q1, [x26]
	cmp	x21, #33
	b.hs	542f
292:
	add	x26, x26, x21
	ubfx	x27, x19, #50, #6
	cmp	x22, x27
	b.lo	732f
	sub	x28, x26, x22
	cmp	x28, x8
	b.lt	732f
	ldp	q1, q0, [x28]
	mov	x29, x22
302:
	stp	q1, q0, [x26]
	cmp	x27, #33
	b.hs	552f
312:
	add	x23, x25, w23, uxtb
	add	x25, x24, x21
	lsr	x20, x20, #56
	//APP
	//NO_APP
	ldr	x20, [x12, x20, lsl #3]
	add	x26, x26, x27
	ldp	q0, q1, [x25]
	lsr	x21, x23, #3
	and	x24, x23, #0x7
	ldr	x21, [x11, x21]
	lsr	x21, x21, x24
	and	w21, w21, w20, lsr #8
	adds	x21, x21, x20, lsr #32
	csel	x21, x22, x21, eq
	cmp	x22, #32
	b.lo	742f
	neg	x24, x22
	add	x24, x26, x24
	cmp	x24, x8
	b.lt	742f
	ldp	q2, q3, [x24]
322:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	lsr	x7, x7, #56
	stp	q0, q1, [x26]
	cmp	x7, #33
	b.hs	572f
332:
	add	x22, x26, x7
	lsr	x19, x19, #58
	cmp	x21, x19
	b.lo	752f
	sub	x24, x22, x21
	cmp	x24, x8
	b.lt	752f
	ldp	q1, q0, [x24]
	mov	x26, x21
342:
	stp	q1, q0, [x22]
	cmp	x19, #33
	b.hs	582f
352:
	add	x23, x23, w20, uxtb
	add	x24, x22, x19
	add	x22, x25, x7
	sub	x2, x2, #8
	add	x6, x6, #8
	cmp	x10, #7
	b.hi	2b
	b	932f
362:
	ldr	x21, [x0, #48]
	ldr	x28, [x0, #120]
	ldrb	w27, [x21, x28]
	add	x21, x28, #1
	str	x21, [x0, #120]
	ldp	q0, q1, [x22, #32]
	add	x21, x27, #33
	stp	q0, q1, [x24, #32]
	cmp	w27, #32
	b.lo	52b
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x24, #64]
	cmp	w27, #64
	b.lo	52b
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x24, #96]
	cmp	w27, #96
	b.lo	52b
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x24, #128]
	tbz	w27, #7, 52b
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x24, #160]
	cmp	w27, #160
	b.lo	52b
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x24, #192]
	cmp	w27, #192
	b.lo	52b
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x24, #224]
	cmp	w27, #224
	b.lo	52b
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x24, #256]
	b	52b
372:
	cmp	x29, #31
	b.hi	382f
	str	x5, [x0, #104]
382:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x27, x30]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldp	q0, q1, [x28, #32]
	add	x27, x29, #33
	stp	q0, q1, [x24, #32]
	cmp	w29, #32
	b.lo	72b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x24, #64]
	cmp	w29, #64
	b.lo	72b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x24, #96]
	cmp	w29, #96
	b.lo	72b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x24, #128]
	tbz	w29, #7, 72b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x24, #160]
	cmp	w29, #160
	b.lo	72b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x24, #192]
	cmp	w29, #192
	b.lo	72b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x24, #224]
	cmp	w29, #224
	b.lo	72b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x24, #256]
	b	72b
392:
	ldr	x25, [x0, #48]
	ldr	x28, [x0, #120]
	ldrb	w27, [x25, x28]
	add	x25, x28, #1
	str	x25, [x0, #120]
	ldp	q0, q1, [x22, #32]
	add	x25, x27, #33
	stp	q0, q1, [x26, #32]
	cmp	w27, #32
	b.lo	92b
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x26, #64]
	cmp	w27, #64
	b.lo	92b
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x26, #96]
	cmp	w27, #96
	b.lo	92b
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x26, #128]
	tbz	w27, #7, 92b
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x26, #160]
	cmp	w27, #160
	b.lo	92b
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x26, #192]
	cmp	w27, #192
	b.lo	92b
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x26, #224]
	cmp	w27, #224
	b.lo	92b
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x26, #256]
	b	92b
402:
	cmp	x29, #31
	b.hi	412f
	str	x5, [x0, #104]
412:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x27, x30]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldp	q0, q1, [x28, #32]
	add	x27, x29, #33
	stp	q0, q1, [x26, #32]
	cmp	w29, #32
	b.lo	112b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x26, #64]
	cmp	w29, #64
	b.lo	112b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x26, #96]
	cmp	w29, #96
	b.lo	112b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x26, #128]
	tbz	w29, #7, 112b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x26, #160]
	cmp	w29, #160
	b.lo	112b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x26, #192]
	cmp	w29, #192
	b.lo	112b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x26, #224]
	cmp	w29, #224
	b.lo	112b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x26, #256]
	b	112b
422:
	ldr	x21, [x0, #48]
	ldr	x28, [x0, #120]
	ldrb	w27, [x21, x28]
	add	x21, x28, #1
	str	x21, [x0, #120]
	ldp	q0, q1, [x23, #32]
	add	x21, x27, #33
	stp	q0, q1, [x26, #32]
	cmp	w27, #32
	b.lo	132b
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x26, #64]
	cmp	w27, #64
	b.lo	132b
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x26, #96]
	cmp	w27, #96
	b.lo	132b
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x26, #128]
	tbz	w27, #7, 132b
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x26, #160]
	cmp	w27, #160
	b.lo	132b
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x26, #192]
	cmp	w27, #192
	b.lo	132b
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x26, #224]
	cmp	w27, #224
	b.lo	132b
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x26, #256]
	b	132b
432:
	cmp	x29, #31
	b.hi	442f
	str	x5, [x0, #104]
442:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x27, x30]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldp	q0, q1, [x28, #32]
	add	x27, x29, #33
	stp	q0, q1, [x26, #32]
	cmp	w29, #32
	b.lo	152b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x26, #64]
	cmp	w29, #64
	b.lo	152b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x26, #96]
	cmp	w29, #96
	b.lo	152b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x26, #128]
	tbz	w29, #7, 152b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x26, #160]
	cmp	w29, #160
	b.lo	152b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x26, #192]
	cmp	w29, #192
	b.lo	152b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x26, #224]
	cmp	w29, #224
	b.lo	152b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x26, #256]
	b	152b
452:
	ldr	x22, [x0, #48]
	ldr	x28, [x0, #120]
	ldrb	w27, [x22, x28]
	add	x22, x28, #1
	str	x22, [x0, #120]
	ldp	q0, q1, [x23, #32]
	add	x22, x27, #33
	stp	q0, q1, [x26, #32]
	cmp	w27, #32
	b.lo	172b
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x26, #64]
	cmp	w27, #64
	b.lo	172b
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x26, #96]
	cmp	w27, #96
	b.lo	172b
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x26, #128]
	tbz	w27, #7, 172b
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x26, #160]
	cmp	w27, #160
	b.lo	172b
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x26, #192]
	cmp	w27, #192
	b.lo	172b
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x26, #224]
	cmp	w27, #224
	b.lo	172b
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x26, #256]
	b	172b
462:
	cmp	x29, #31
	b.hi	472f
	str	x5, [x0, #104]
472:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x27, x30]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldp	q0, q1, [x28, #32]
	add	x27, x29, #33
	stp	q0, q1, [x26, #32]
	cmp	w29, #32
	b.lo	192b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x26, #64]
	cmp	w29, #64
	b.lo	192b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x26, #96]
	cmp	w29, #96
	b.lo	192b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x26, #128]
	tbz	w29, #7, 192b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x26, #160]
	cmp	w29, #160
	b.lo	192b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x26, #192]
	cmp	w29, #192
	b.lo	192b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x26, #224]
	cmp	w29, #224
	b.lo	192b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x26, #256]
	b	192b
482:
	ldr	x21, [x0, #48]
	ldr	x28, [x0, #120]
	ldrb	w27, [x21, x28]
	add	x21, x28, #1
	str	x21, [x0, #120]
	ldp	q0, q1, [x23, #32]
	add	x21, x27, #33
	stp	q0, q1, [x26, #32]
	cmp	w27, #32
	b.lo	212b
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x26, #64]
	cmp	w27, #64
	b.lo	212b
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x26, #96]
	cmp	w27, #96
	b.lo	212b
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x26, #128]
	tbz	w27, #7, 212b
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x26, #160]
	cmp	w27, #160
	b.lo	212b
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x26, #192]
	cmp	w27, #192
	b.lo	212b
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x26, #224]
	cmp	w27, #224
	b.lo	212b
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x26, #256]
	b	212b
492:
	cmp	x29, #31
	b.hi	502f
	str	x5, [x0, #104]
502:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x27, x30]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldp	q0, q1, [x28, #32]
	add	x27, x29, #33
	stp	q0, q1, [x26, #32]
	cmp	w29, #32
	b.lo	232b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x26, #64]
	cmp	w29, #64
	b.lo	232b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x26, #96]
	cmp	w29, #96
	b.lo	232b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x26, #128]
	tbz	w29, #7, 232b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x26, #160]
	cmp	w29, #160
	b.lo	232b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x26, #192]
	cmp	w29, #192
	b.lo	232b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x26, #224]
	cmp	w29, #224
	b.lo	232b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x26, #256]
	b	232b
512:
	ldr	x22, [x0, #48]
	ldr	x28, [x0, #120]
	ldrb	w27, [x22, x28]
	add	x22, x28, #1
	str	x22, [x0, #120]
	ldp	q0, q1, [x23, #32]
	add	x22, x27, #33
	stp	q0, q1, [x26, #32]
	cmp	w27, #32
	b.lo	252b
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x26, #64]
	cmp	w27, #64
	b.lo	252b
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x26, #96]
	cmp	w27, #96
	b.lo	252b
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x26, #128]
	tbz	w27, #7, 252b
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x26, #160]
	cmp	w27, #160
	b.lo	252b
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x26, #192]
	cmp	w27, #192
	b.lo	252b
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x26, #224]
	cmp	w27, #224
	b.lo	252b
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x26, #256]
	b	252b
522:
	cmp	x29, #31
	b.hi	532f
	str	x5, [x0, #104]
532:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x27, x30]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldp	q0, q1, [x28, #32]
	add	x27, x29, #33
	stp	q0, q1, [x26, #32]
	cmp	w29, #32
	b.lo	272b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x26, #64]
	cmp	w29, #64
	b.lo	272b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x26, #96]
	cmp	w29, #96
	b.lo	272b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x26, #128]
	tbz	w29, #7, 272b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x26, #160]
	cmp	w29, #160
	b.lo	272b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x26, #192]
	cmp	w29, #192
	b.lo	272b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x26, #224]
	cmp	w29, #224
	b.lo	272b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x26, #256]
	b	272b
542:
	ldr	x21, [x0, #48]
	ldr	x28, [x0, #120]
	ldrb	w27, [x21, x28]
	add	x21, x28, #1
	str	x21, [x0, #120]
	ldp	q0, q1, [x24, #32]
	add	x21, x27, #33
	stp	q0, q1, [x26, #32]
	cmp	w27, #32
	b.lo	292b
	ldp	q0, q1, [x24, #64]
	stp	q0, q1, [x26, #64]
	cmp	w27, #64
	b.lo	292b
	ldp	q0, q1, [x24, #96]
	stp	q0, q1, [x26, #96]
	cmp	w27, #96
	b.lo	292b
	ldp	q0, q1, [x24, #128]
	stp	q0, q1, [x26, #128]
	tbz	w27, #7, 292b
	ldp	q0, q1, [x24, #160]
	stp	q0, q1, [x26, #160]
	cmp	w27, #160
	b.lo	292b
	ldp	q0, q1, [x24, #192]
	stp	q0, q1, [x26, #192]
	cmp	w27, #192
	b.lo	292b
	ldp	q0, q1, [x24, #224]
	stp	q0, q1, [x26, #224]
	cmp	w27, #224
	b.lo	292b
	ldp	q0, q1, [x24, #256]
	stp	q0, q1, [x26, #256]
	b	292b
552:
	cmp	x29, #31
	b.hi	562f
	str	x5, [x0, #104]
562:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x27, x30]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldp	q0, q1, [x28, #32]
	add	x27, x29, #33
	stp	q0, q1, [x26, #32]
	cmp	w29, #32
	b.lo	312b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x26, #64]
	cmp	w29, #64
	b.lo	312b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x26, #96]
	cmp	w29, #96
	b.lo	312b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x26, #128]
	tbz	w29, #7, 312b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x26, #160]
	cmp	w29, #160
	b.lo	312b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x26, #192]
	cmp	w29, #192
	b.lo	312b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x26, #224]
	cmp	w29, #224
	b.lo	312b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x26, #256]
	b	312b
572:
	ldr	x7, [x0, #48]
	ldr	x24, [x0, #120]
	ldrb	w22, [x7, x24]
	add	x7, x24, #1
	str	x7, [x0, #120]
	ldp	q0, q1, [x25, #32]
	add	x7, x22, #33
	stp	q0, q1, [x26, #32]
	cmp	w22, #32
	b.lo	332b
	ldp	q0, q1, [x25, #64]
	stp	q0, q1, [x26, #64]
	cmp	w22, #64
	b.lo	332b
	ldp	q0, q1, [x25, #96]
	stp	q0, q1, [x26, #96]
	cmp	w22, #96
	b.lo	332b
	ldp	q0, q1, [x25, #128]
	stp	q0, q1, [x26, #128]
	tbz	w22, #7, 332b
	ldp	q0, q1, [x25, #160]
	stp	q0, q1, [x26, #160]
	cmp	w22, #160
	b.lo	332b
	ldp	q0, q1, [x25, #192]
	stp	q0, q1, [x26, #192]
	cmp	w22, #192
	b.lo	332b
	ldp	q0, q1, [x25, #224]
	stp	q0, q1, [x26, #224]
	cmp	w22, #224
	b.lo	332b
	ldp	q0, q1, [x25, #256]
	stp	q0, q1, [x26, #256]
	b	332b
582:
	cmp	x26, #31
	b.hi	592f
	str	x5, [x0, #104]
592:
	ldr	x19, [x0, #48]
	ldr	x27, [x0, #120]
	ldrb	w26, [x19, x27]
	add	x19, x27, #1
	str	x19, [x0, #120]
	ldp	q0, q1, [x24, #32]
	add	x19, x26, #33
	stp	q0, q1, [x22, #32]
	cmp	w26, #32
	b.lo	352b
	ldp	q0, q1, [x24, #64]
	stp	q0, q1, [x22, #64]
	cmp	w26, #64
	b.lo	352b
	ldp	q0, q1, [x24, #96]
	stp	q0, q1, [x22, #96]
	cmp	w26, #96
	b.lo	352b
	ldp	q0, q1, [x24, #128]
	stp	q0, q1, [x22, #128]
	tbz	w26, #7, 352b
	ldp	q0, q1, [x24, #160]
	stp	q0, q1, [x22, #160]
	cmp	w26, #160
	b.lo	352b
	ldp	q0, q1, [x24, #192]
	stp	q0, q1, [x22, #192]
	cmp	w26, #192
	b.lo	352b
	ldp	q0, q1, [x24, #224]
	stp	q0, q1, [x22, #224]
	cmp	w26, #224
	b.lo	352b
	ldp	q0, q1, [x24, #256]
	stp	q0, q1, [x22, #256]
	b	352b
602:
	sub	x28, x24, x8
	cmp	x25, x28
	csel	x29, x25, x28, lo
	sub	x28, x28, x29
	cmp	x29, x27
	b.hs	762f
	ldr	x30, [x0, #56]
	add	x30, x30, x29, lsl #5
	ldr	q0, [x30, #2064]
	ldr	q1, [x30, #2048]
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x30]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	62b
612:
	sub	x28, x26, x8
	cmp	x25, x28
	csel	x27, x25, x28, lo
	sub	x25, x28, x27
	cmp	x27, #31
	b.ls	772f
	add	x25, x8, x25
	ldp	q2, q3, [x25]
	b	82b
622:
	sub	x28, x26, x8
	cmp	x21, x28
	csel	x29, x21, x28, lo
	sub	x28, x28, x29
	cmp	x29, x27
	b.hs	782f
	ldr	x30, [x0, #56]
	add	x30, x30, x29, lsl #5
	ldr	q0, [x30, #2064]
	ldr	q1, [x30, #2048]
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x30]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	102b
632:
	sub	x28, x26, x8
	cmp	x21, x28
	csel	x27, x21, x28, lo
	sub	x21, x28, x27
	cmp	x27, #31
	b.ls	792f
	add	x21, x8, x21
	ldp	q2, q3, [x21]
	b	122b
642:
	sub	x19, x24, x8
	cmp	x21, x19
	csel	x21, x21, x19, lo
	sub	x19, x19, x21
	cmp	x21, #31
	b.ls	802f
	add	x19, x8, x19
	b	32b
652:
	sub	x28, x26, x8
	cmp	x22, x28
	csel	x29, x22, x28, lo
	sub	x28, x28, x29
	cmp	x29, x27
	b.hs	812f
	ldr	x30, [x0, #56]
	add	x30, x30, x29, lsl #5
	ldr	q0, [x30, #2064]
	ldr	q1, [x30, #2048]
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x30]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	142b
662:
	sub	x28, x26, x8
	cmp	x22, x28
	csel	x27, x22, x28, lo
	sub	x22, x28, x27
	cmp	x27, #31
	b.ls	822f
	add	x22, x8, x22
	ldp	q2, q3, [x22]
	b	162b
672:
	sub	x28, x26, x8
	cmp	x21, x28
	csel	x29, x21, x28, lo
	sub	x28, x28, x29
	cmp	x29, x27
	b.hs	832f
	ldr	x30, [x0, #56]
	add	x30, x30, x29, lsl #5
	ldr	q0, [x30, #2064]
	ldr	q1, [x30, #2048]
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x30]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	182b
682:
	sub	x28, x26, x8
	cmp	x21, x28
	csel	x27, x21, x28, lo
	sub	x21, x28, x27
	cmp	x27, #31
	b.ls	842f
	add	x21, x8, x21
	ldp	q2, q3, [x21]
	b	202b
692:
	sub	x28, x26, x8
	cmp	x22, x28
	csel	x29, x22, x28, lo
	sub	x28, x28, x29
	cmp	x29, x27
	b.hs	852f
	ldr	x30, [x0, #56]
	add	x30, x30, x29, lsl #5
	ldr	q0, [x30, #2064]
	ldr	q1, [x30, #2048]
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x30]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	222b
702:
	sub	x28, x26, x8
	cmp	x22, x28
	csel	x27, x22, x28, lo
	sub	x22, x28, x27
	cmp	x27, #31
	b.ls	862f
	add	x22, x8, x22
	ldp	q2, q3, [x22]
	b	242b
712:
	sub	x28, x26, x8
	cmp	x21, x28
	csel	x29, x21, x28, lo
	sub	x28, x28, x29
	cmp	x29, x27
	b.hs	872f
	ldr	x30, [x0, #56]
	add	x30, x30, x29, lsl #5
	ldr	q0, [x30, #2064]
	ldr	q1, [x30, #2048]
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x30]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	262b
722:
	sub	x28, x26, x8
	cmp	x21, x28
	csel	x27, x21, x28, lo
	sub	x21, x28, x27
	cmp	x27, #31
	b.ls	882f
	add	x21, x8, x21
	ldp	q2, q3, [x21]
	b	282b
732:
	sub	x28, x26, x8
	cmp	x22, x28
	csel	x29, x22, x28, lo
	sub	x28, x28, x29
	cmp	x29, x27
	b.hs	892f
	ldr	x30, [x0, #56]
	add	x30, x30, x29, lsl #5
	ldr	q0, [x30, #2064]
	ldr	q1, [x30, #2048]
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x30]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	302b
742:
	sub	x27, x26, x8
	cmp	x22, x27
	csel	x24, x22, x27, lo
	sub	x22, x27, x24
	cmp	x24, #31
	b.ls	902f
	add	x22, x8, x22
	ldp	q2, q3, [x22]
	b	322b
752:
	sub	x24, x22, x8
	cmp	x21, x24
	csel	x26, x21, x24, lo
	sub	x24, x24, x26
	cmp	x26, x19
	b.hs	912f
	ldr	x27, [x0, #56]
	add	x27, x27, x26, lsl #5
	ldr	q0, [x27, #2064]
	ldr	q1, [x27, #2048]
	add	x27, x8, x24
	add	x24, x8, x24
	ldp	q2, q3, [x27]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	342b
762:
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x30]
	b	62b
772:
	ldr	x28, [x0, #56]
	add	x25, x8, x25
	ldp	q4, q5, [x25]
	add	x27, x28, x27, lsl #5
	ldr	q3, [x27, #2064]
	ldr	q2, [x27, #2048]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	82b
782:
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x30]
	b	102b
792:
	ldr	x28, [x0, #56]
	add	x21, x8, x21
	ldp	q4, q5, [x21]
	add	x27, x28, x27, lsl #5
	ldr	q3, [x27, #2064]
	ldr	q2, [x27, #2048]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	122b
802:
	ldr	x27, [x0, #56]
	add	x19, x8, x19
	ldp	q2, q3, [x19]
	add	x21, x27, x21, lsl #5
	ldr	q1, [x21, #2064]
	ldr	q0, [x21, #2048]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	42b
812:
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x30]
	b	142b
822:
	ldr	x28, [x0, #56]
	add	x22, x8, x22
	ldp	q4, q5, [x22]
	add	x27, x28, x27, lsl #5
	ldr	q3, [x27, #2064]
	ldr	q2, [x27, #2048]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	162b
832:
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x30]
	b	182b
842:
	ldr	x28, [x0, #56]
	add	x21, x8, x21
	ldp	q4, q5, [x21]
	add	x27, x28, x27, lsl #5
	ldr	q3, [x27, #2064]
	ldr	q2, [x27, #2048]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	202b
852:
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x30]
	b	222b
862:
	ldr	x28, [x0, #56]
	add	x22, x8, x22
	ldp	q4, q5, [x22]
	add	x27, x28, x27, lsl #5
	ldr	q3, [x27, #2064]
	ldr	q2, [x27, #2048]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	242b
872:
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x30]
	b	262b
882:
	ldr	x28, [x0, #56]
	add	x21, x8, x21
	ldp	q4, q5, [x21]
	add	x27, x28, x27, lsl #5
	ldr	q3, [x27, #2064]
	ldr	q2, [x27, #2048]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	282b
892:
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x30]
	b	302b
902:
	ldr	x27, [x0, #56]
	add	x22, x8, x22
	ldp	q4, q5, [x22]
	add	x24, x27, x24, lsl #5
	ldr	q3, [x24, #2064]
	ldr	q2, [x24, #2048]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	322b
912:
	add	x27, x8, x24
	add	x24, x8, x24
	ldp	q1, q0, [x27]
	b	342b
922:
	mov	x16, xzr
	b	942f
932:
	cbz	x10, 1072f
	neg	x16, x2
942:
	ldr	x15, [x15, x16]
	mov	w16, #1
	.p2align	5, , 16
952:
	lsr	x2, x23, #3
	and	x17, x14, #0xff
	//APP
	//NO_APP
	ldr	x17, [x12, x17, lsl #3]
	and	x3, x23, #0x7
	mov	x1, x21
	ldr	x2, [x11, x2]
	lsr	x2, x2, x3
	and	w2, w2, w17, lsr #8
	adds	x2, x2, x17, lsr #32
	csel	x21, x21, x2, eq
	cmp	x1, #32
	b.lo	1042f
	sub	x2, x24, x1
	cmp	x2, x8
	b.lt	1042f
	ldp	q0, q1, [x2]
962:
	ldp	q3, q2, [x22]
	and	x1, x13, #0xff
	add	v1.16b, v1.16b, v2.16b
	add	v0.16b, v0.16b, v3.16b
	stp	q0, q1, [x24]
	cmp	x1, #33
	b.hs	1002f
972:
	add	x2, x24, x1
	ubfx	x3, x15, #2, #6
	sub	x4, x2, x21
	cmp	x21, x3
	ccmp	x4, x8, #8, hs
	b.lt	1032f
	ldp	q1, q0, [x4]
	mov	x5, x21
982:
	stp	q1, q0, [x2]
	cmp	x3, #33
	b.hs	1012f
992:
	add	x23, x23, w17, uxtb
	add	x24, x2, x3
	add	x22, x22, x1
	subs	x10, x10, #1
	lsr	x15, x15, #8
	lsr	x13, x13, #8
	lsr	x14, x14, #8
	b.ne	952b
	b	1072f
1002:
	ldr	x1, [x0, #48]
	ldr	x3, [x0, #120]
	ldrb	w2, [x1, x3]
	add	x1, x3, #1
	str	x1, [x0, #120]
	ldp	q0, q1, [x22, #32]
	add	x1, x2, #33
	stp	q0, q1, [x24, #32]
	cmp	w2, #32
	b.lo	972b
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x24, #64]
	cmp	w2, #64
	b.lo	972b
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x24, #96]
	cmp	w2, #96
	b.lo	972b
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x24, #128]
	tbz	w2, #7, 972b
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x24, #160]
	cmp	w2, #160
	b.lo	972b
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x24, #192]
	cmp	w2, #192
	b.lo	972b
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x24, #224]
	cmp	w2, #224
	b.lo	972b
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x24, #256]
	b	972b
1012:
	cmp	x5, #31
	b.hi	1022f
	str	x16, [x0, #104]
1022:
	ldr	x3, [x0, #48]
	ldr	x6, [x0, #120]
	ldrb	w5, [x3, x6]
	add	x3, x6, #1
	str	x3, [x0, #120]
	ldp	q0, q1, [x4, #32]
	add	x3, x5, #33
	stp	q0, q1, [x2, #32]
	cmp	w5, #32
	b.lo	992b
	ldp	q0, q1, [x4, #64]
	stp	q0, q1, [x2, #64]
	cmp	w5, #64
	b.lo	992b
	ldp	q0, q1, [x4, #96]
	stp	q0, q1, [x2, #96]
	cmp	w5, #96
	b.lo	992b
	ldp	q0, q1, [x4, #128]
	stp	q0, q1, [x2, #128]
	tbz	w5, #7, 992b
	ldp	q0, q1, [x4, #160]
	stp	q0, q1, [x2, #160]
	cmp	w5, #160
	b.lo	992b
	ldp	q0, q1, [x4, #192]
	stp	q0, q1, [x2, #192]
	cmp	w5, #192
	b.lo	992b
	ldp	q0, q1, [x4, #224]
	stp	q0, q1, [x2, #224]
	cmp	w5, #224
	b.lo	992b
	ldp	q0, q1, [x4, #256]
	stp	q0, q1, [x2, #256]
	b	992b
1032:
	sub	x4, x2, x8
	cmp	x21, x4
	csel	x5, x21, x4, lo
	sub	x4, x4, x5
	cmp	x5, x3
	b.hs	1052f
	ldr	x6, [x0, #56]
	add	x6, x6, x5, lsl #5
	ldr	q0, [x6, #2064]
	ldr	q1, [x6, #2048]
	add	x6, x8, x4
	add	x4, x8, x4
	ldp	q2, q3, [x6]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	982b
1042:
	sub	x3, x24, x8
	cmp	x1, x3
	csel	x2, x1, x3, lo
	sub	x1, x3, x2
	cmp	x2, #31
	b.ls	1062f
	add	x1, x8, x1
	ldp	q0, q1, [x1]
	b	962b
1052:
	add	x6, x8, x4
	add	x4, x8, x4
	ldp	q1, q0, [x6]
	b	982b
1062:
	ldr	x3, [x0, #56]
	add	x1, x8, x1
	ldp	q2, q3, [x1]
	add	x2, x3, x2, lsl #5
	ldr	q1, [x2, #2064]
	ldr	q0, [x2, #2048]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	962b
1072:
	sub	x8, x24, x8
	sub	x9, x22, x9
	str	x21, [x0, #96]
	ldp	x20, x19, [sp, #80]
	ldp	x22, x21, [sp, #64]
	ldp	x24, x23, [sp, #48]
	ldp	x26, x25, [sp, #32]
	ldp	x28, x27, [sp, #16]
	stp	x8, x9, [x0, #80]
	ldp	x29, x30, [sp], #96
1082:
	ret

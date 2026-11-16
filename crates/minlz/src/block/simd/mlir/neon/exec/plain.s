// minlz_exec_plain of crates/minlz/mlir/exec8.mlir for neon, written by
// cargo xtask mlir. Do not edit.
	ldr	x10, [x0, #64]
	mov	x16, #72340172838076673
	//APP
	//NO_APP
	cbz	x10, 982f
	stp	x29, x30, [sp, #-96]!
	stp	x24, x23, [sp, #48]
	ldp	x8, x9, [x0]
	ldp	x14, x1, [x0, #16]
	ldp	x24, x17, [x0, #72]
	stp	x26, x25, [sp, #32]
	stp	x22, x21, [sp, #64]
	ldp	x15, x22, [x0, #88]
	ldp	x2, x11, [x0, #32]
	ldr	x12, [x0, #56]
	add	x25, x8, x17
	ldr	x17, [x14]
	add	x23, x9, x15
	ldr	d0, [x1]
	ldr	x13, [x0, #120]
	stp	x28, x27, [sp, #16]
	stp	x20, x19, [sp, #80]
	and	x15, x16, x17, lsr #1
	bic	x3, x16, x17
	and	x17, x17, x16
	mul	x5, x15, x16
	sub	x4, x5, x15
	eor	x15, x15, x16
	orr	x15, x4, x15, lsl #7
	mul	x4, x3, x16
	fmov	d1, x15
	sub	x3, x4, x3
	orr	x17, x3, x17, lsl #7
	tbl	v0.8b, { v0.16b }, v1.8b
	fmov	d1, x17
	fmov	x15, d0
	ldr	d0, [x2]
	tbl	v0.8b, { v0.16b }, v1.8b
	fmov	x17, d0
	cmp	x10, #8
	b.lo	832f
	lsr	x4, x4, #56
	lsr	x5, x5, #56
	mov	x3, xzr
	mov	x7, x14
	.p2align	5, , 16
2:
	subs	x10, x10, #8
	b.ne	12f
	mov	x19, x15
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
	and	x26, x17, #0xff
	//APP
	//NO_APP
	ldr	x27, [x12, x26, lsl #3]
	lsr	x26, x24, #3
	and	x29, x24, #0x7
	ldr	x21, [x7]
	ldr	x26, [x11, x26]
	ldp	q0, q1, [x23]
	and	x28, x15, #0xff
	lsr	x26, x26, x29
	and	w26, w26, w27, lsr #8
	stp	q0, q1, [x25]
	adds	x26, x26, x27, lsr #32
	csel	x26, x22, x26, eq
	cmp	x28, #33
	b.hs	272f
	add	x22, x25, x28
	ubfx	x29, x21, #2, #6
	sub	x25, x22, x26
	cmp	x26, x29
	ccmp	x25, x8, #8, hs
	b.lt	292f
32:
	ldp	q1, q0, [x25]
	mov	x30, x26
42:
	stp	q1, q0, [x22]
	cmp	x29, #33
	b.hs	302f
52:
	add	x24, x24, w27, uxtb
	ubfx	x6, x17, #8, #8
	//APP
	//NO_APP
	ldr	x25, [x12, x6, lsl #3]
	add	x29, x22, x29
	add	x22, x23, x28
	ldp	q0, q1, [x22]
	ubfx	x27, x15, #8, #8
	lsr	x6, x24, #3
	and	x23, x24, #0x7
	ldr	x6, [x11, x6]
	lsr	x6, x6, x23
	stp	q0, q1, [x29]
	and	w6, w6, w25, lsr #8
	adds	x6, x6, x25, lsr #32
	csel	x23, x26, x6, eq
	cmp	x27, #33
	b.hs	332f
	add	x26, x29, x27
	ubfx	x29, x21, #10, #6
	sub	x28, x26, x23
	cmp	x23, x29
	ccmp	x28, x8, #8, hs
	b.lt	352f
62:
	ldp	q1, q0, [x28]
	mov	x30, x23
72:
	stp	q1, q0, [x26]
	cmp	x29, #33
	b.hs	362f
82:
	add	x25, x24, w25, uxtb
	add	x28, x26, x29
	ubfx	x6, x17, #16, #8
	//APP
	//NO_APP
	ldr	x26, [x12, x6, lsl #3]
	add	x22, x22, x27
	ldp	q0, q1, [x22]
	ubfx	x27, x15, #16, #8
	lsr	x6, x25, #3
	and	x24, x25, #0x7
	ldr	x6, [x11, x6]
	lsr	x6, x6, x24
	stp	q0, q1, [x28]
	and	w6, w6, w26, lsr #8
	adds	x6, x6, x26, lsr #32
	csel	x24, x23, x6, eq
	cmp	x27, #33
	b.hs	392f
	add	x28, x28, x27
	ubfx	x29, x21, #18, #6
	sub	x23, x28, x24
	cmp	x24, x29
	ccmp	x23, x8, #8, hs
	b.lt	412f
92:
	ldp	q1, q0, [x23]
	mov	x30, x24
102:
	stp	q1, q0, [x28]
	cmp	x29, #33
	b.hs	422f
112:
	add	x23, x25, w26, uxtb
	lsr	w6, w17, #24
	//APP
	//NO_APP
	ldr	x26, [x12, x6, lsl #3]
	add	x22, x22, x27
	add	x28, x28, x29
	ldp	q0, q1, [x22]
	lsr	w27, w15, #24
	lsr	x6, x23, #3
	and	x25, x23, #0x7
	ldr	x6, [x11, x6]
	lsr	x6, x6, x25
	stp	q0, q1, [x28]
	and	w6, w6, w26, lsr #8
	adds	x6, x6, x26, lsr #32
	csel	x25, x24, x6, eq
	cmp	x27, #33
	b.hs	452f
	add	x28, x28, x27
	lsr	w29, w21, #26
	sub	x24, x28, x25
	cmp	x25, x29
	ccmp	x24, x8, #8, hs
	b.lt	472f
122:
	ldp	q1, q0, [x24]
	mov	x30, x25
132:
	stp	q1, q0, [x28]
	cmp	x29, #33
	b.hs	482f
142:
	add	x24, x23, w26, uxtb
	ubfx	x6, x17, #32, #8
	//APP
	//NO_APP
	ldr	x26, [x12, x6, lsl #3]
	add	x22, x22, x27
	add	x28, x28, x29
	ldp	q0, q1, [x22]
	ubfx	x27, x15, #32, #8
	lsr	x6, x24, #3
	and	x23, x24, #0x7
	ldr	x6, [x11, x6]
	lsr	x6, x6, x23
	stp	q0, q1, [x28]
	and	w6, w6, w26, lsr #8
	adds	x6, x6, x26, lsr #32
	csel	x23, x25, x6, eq
	cmp	x27, #33
	b.hs	512f
	add	x25, x28, x27
	ubfx	x29, x21, #34, #6
	cmp	x23, x29
	b.lo	532f
152:
	sub	x28, x25, x23
	cmp	x28, x8
	b.lt	532f
	ldp	q1, q0, [x28]
	mov	x30, x23
162:
	stp	q1, q0, [x25]
	cmp	x29, #33
	b.hs	542f
172:
	add	x24, x24, w26, uxtb
	add	x28, x25, x29
	ubfx	x6, x17, #40, #8
	//APP
	//NO_APP
	ldr	x25, [x12, x6, lsl #3]
	add	x22, x22, x27
	ldp	q0, q1, [x22]
	ubfx	x26, x15, #40, #8
	lsr	x6, x24, #3
	and	x27, x24, #0x7
	ldr	x6, [x11, x6]
	lsr	x6, x6, x27
	stp	q0, q1, [x28]
	and	w6, w6, w25, lsr #8
	adds	x6, x6, x25, lsr #32
	csel	x23, x23, x6, eq
	cmp	x26, #33
	b.hs	572f
	add	x27, x28, x26
	ubfx	x29, x21, #42, #6
	cmp	x23, x29
	b.lo	592f
182:
	sub	x28, x27, x23
	cmp	x28, x8
	b.lt	592f
	ldp	q1, q0, [x28]
	mov	x30, x23
192:
	stp	q1, q0, [x27]
	cmp	x29, #33
	b.hs	602f
202:
	add	x24, x24, w25, uxtb
	add	x22, x22, x26
	ubfx	x6, x17, #48, #8
	//APP
	//NO_APP
	ldr	x26, [x12, x6, lsl #3]
	add	x28, x27, x29
	ldp	q0, q1, [x22]
	ubfx	x27, x15, #48, #8
	lsr	x6, x24, #3
	and	x25, x24, #0x7
	ldr	x6, [x11, x6]
	lsr	x6, x6, x25
	stp	q0, q1, [x28]
	and	w6, w6, w26, lsr #8
	adds	x6, x6, x26, lsr #32
	csel	x25, x23, x6, eq
	cmp	x27, #33
	b.hs	632f
	add	x23, x28, x27
	ubfx	x29, x21, #50, #6
	cmp	x25, x29
	b.lo	652f
212:
	sub	x28, x23, x25
	cmp	x28, x8
	b.lt	652f
	ldp	q1, q0, [x28]
	mov	x30, x25
222:
	stp	q1, q0, [x23]
	cmp	x29, #33
	b.hs	662f
232:
	add	x24, x24, w26, uxtb
	lsr	x26, x15, #56
	lsr	x15, x17, #56
	//APP
	//NO_APP
	ldr	x15, [x12, x15, lsl #3]
	add	x28, x23, x29
	add	x23, x22, x27
	ldp	q0, q1, [x23]
	lsr	x17, x24, #3
	and	x6, x24, #0x7
	ldr	x17, [x11, x17]
	lsr	x17, x17, x6
	stp	q0, q1, [x28]
	and	w17, w17, w15, lsr #8
	adds	x17, x17, x15, lsr #32
	csel	x22, x25, x17, eq
	cmp	x26, #33
	b.hs	692f
	add	x17, x28, x26
	lsr	x25, x21, #58
	cmp	x22, x25
	b.lo	712f
242:
	sub	x21, x17, x22
	cmp	x21, x8
	b.lt	712f
	ldp	q1, q0, [x21]
	mov	x27, x22
252:
	stp	q1, q0, [x17]
	cmp	x25, #33
	b.hs	722f
262:
	add	x24, x24, w15, uxtb
	add	x25, x17, x25
	add	x23, x23, x26
	sub	x3, x3, #8
	add	x7, x7, #8
	mov	x17, x20
	mov	x15, x19
	cmp	x10, #7
	b.hi	2b
	b	842f
272:
	ldr	x22, [x0, #48]
	ldp	q0, q1, [x23, #32]
	ldrb	w22, [x22, x13]
	stp	q0, q1, [x25, #32]
	cmp	w22, #32
	b.lo	282f
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x25, #64]
	cmp	w22, #64
	b.lo	282f
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x25, #96]
	cmp	w22, #96
	b.lo	282f
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x25, #128]
	tbz	w22, #7, 282f
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x25, #160]
	cmp	w22, #160
	b.lo	282f
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x25, #192]
	cmp	w22, #192
	b.lo	282f
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x25, #224]
	cmp	w22, #224
	b.lo	282f
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x25, #256]
282:
	add	x28, x22, #33
	add	x13, x13, #1
	add	x22, x25, x28
	ubfx	x29, x21, #2, #6
	sub	x25, x22, x26
	cmp	x26, x29
	ccmp	x25, x8, #8, hs
	b.ge	32b
292:
	sub	x25, x22, x8
	cmp	x26, x25
	csel	x30, x26, x25, lo
	sub	x25, x25, x30
	cmp	x30, x29
	b.hs	752f
	add	x6, x12, x30, lsl #5
	ldr	q0, [x6, #2064]
	ldr	q1, [x6, #2048]
	add	x6, x8, x25
	add	x25, x8, x25
	ldp	q2, q3, [x6]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	42b
302:
	cmp	x30, #31
	b.hi	312f
	mov	w6, #1
	str	x6, [x0, #104]
312:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x25, #32]
	ldrb	w29, [x6, x13]
	stp	q0, q1, [x22, #32]
	cmp	w29, #32
	b.lo	322f
	ldp	q0, q1, [x25, #64]
	stp	q0, q1, [x22, #64]
	cmp	w29, #64
	b.lo	322f
	ldp	q0, q1, [x25, #96]
	stp	q0, q1, [x22, #96]
	cmp	w29, #96
	b.lo	322f
	ldp	q0, q1, [x25, #128]
	stp	q0, q1, [x22, #128]
	tbz	w29, #7, 322f
	ldp	q0, q1, [x25, #160]
	stp	q0, q1, [x22, #160]
	cmp	w29, #160
	b.lo	322f
	ldp	q0, q1, [x25, #192]
	stp	q0, q1, [x22, #192]
	cmp	w29, #192
	b.lo	322f
	ldp	q0, q1, [x25, #224]
	stp	q0, q1, [x22, #224]
	cmp	w29, #224
	b.lo	322f
	ldp	q0, q1, [x25, #256]
	stp	q0, q1, [x22, #256]
322:
	add	x29, x29, #33
	add	x13, x13, #1
	b	52b
332:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x22, #32]
	ldrb	w26, [x6, x13]
	stp	q0, q1, [x29, #32]
	cmp	w26, #32
	b.lo	342f
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x29, #64]
	cmp	w26, #64
	b.lo	342f
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x29, #96]
	cmp	w26, #96
	b.lo	342f
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x29, #128]
	tbz	w26, #7, 342f
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x29, #160]
	cmp	w26, #160
	b.lo	342f
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x29, #192]
	cmp	w26, #192
	b.lo	342f
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x29, #224]
	cmp	w26, #224
	b.lo	342f
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x29, #256]
342:
	add	x27, x26, #33
	add	x13, x13, #1
	add	x26, x29, x27
	ubfx	x29, x21, #10, #6
	sub	x28, x26, x23
	cmp	x23, x29
	ccmp	x28, x8, #8, hs
	b.ge	62b
352:
	sub	x6, x26, x8
	cmp	x23, x6
	csel	x30, x23, x6, lo
	sub	x28, x6, x30
	cmp	x30, x29
	b.hs	762f
	add	x6, x12, x30, lsl #5
	ldr	q0, [x6, #2064]
	ldr	q1, [x6, #2048]
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x6]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	72b
362:
	cmp	x30, #31
	b.hi	372f
	mov	w6, #1
	str	x6, [x0, #104]
372:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x28, #32]
	ldrb	w29, [x6, x13]
	stp	q0, q1, [x26, #32]
	cmp	w29, #32
	b.lo	382f
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x26, #64]
	cmp	w29, #64
	b.lo	382f
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x26, #96]
	cmp	w29, #96
	b.lo	382f
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x26, #128]
	tbz	w29, #7, 382f
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x26, #160]
	cmp	w29, #160
	b.lo	382f
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x26, #192]
	cmp	w29, #192
	b.lo	382f
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x26, #224]
	cmp	w29, #224
	b.lo	382f
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x26, #256]
382:
	add	x29, x29, #33
	add	x13, x13, #1
	b	82b
392:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x22, #32]
	ldrb	w23, [x6, x13]
	stp	q0, q1, [x28, #32]
	cmp	w23, #32
	b.lo	402f
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x28, #64]
	cmp	w23, #64
	b.lo	402f
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x28, #96]
	cmp	w23, #96
	b.lo	402f
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x28, #128]
	tbz	w23, #7, 402f
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x28, #160]
	cmp	w23, #160
	b.lo	402f
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x28, #192]
	cmp	w23, #192
	b.lo	402f
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x28, #224]
	cmp	w23, #224
	b.lo	402f
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x28, #256]
402:
	add	x27, x23, #33
	add	x13, x13, #1
	add	x28, x28, x27
	ubfx	x29, x21, #18, #6
	sub	x23, x28, x24
	cmp	x24, x29
	ccmp	x23, x8, #8, hs
	b.ge	92b
412:
	sub	x6, x28, x8
	cmp	x24, x6
	csel	x30, x24, x6, lo
	sub	x23, x6, x30
	cmp	x30, x29
	b.hs	772f
	add	x6, x12, x30, lsl #5
	ldr	q0, [x6, #2064]
	ldr	q1, [x6, #2048]
	add	x6, x8, x23
	add	x23, x8, x23
	ldp	q2, q3, [x6]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	102b
422:
	cmp	x30, #31
	b.hi	432f
	mov	w6, #1
	str	x6, [x0, #104]
432:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x23, #32]
	ldrb	w29, [x6, x13]
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	442f
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	442f
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	442f
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 442f
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	442f
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	442f
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	442f
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x28, #256]
442:
	add	x29, x29, #33
	add	x13, x13, #1
	b	112b
452:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x22, #32]
	ldrb	w24, [x6, x13]
	stp	q0, q1, [x28, #32]
	cmp	w24, #32
	b.lo	462f
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x28, #64]
	cmp	w24, #64
	b.lo	462f
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x28, #96]
	cmp	w24, #96
	b.lo	462f
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x28, #128]
	tbz	w24, #7, 462f
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x28, #160]
	cmp	w24, #160
	b.lo	462f
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x28, #192]
	cmp	w24, #192
	b.lo	462f
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x28, #224]
	cmp	w24, #224
	b.lo	462f
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x28, #256]
462:
	add	x27, x24, #33
	add	x13, x13, #1
	add	x28, x28, x27
	lsr	w29, w21, #26
	sub	x24, x28, x25
	cmp	x25, x29
	ccmp	x24, x8, #8, hs
	b.ge	122b
472:
	sub	x6, x28, x8
	cmp	x25, x6
	csel	x30, x25, x6, lo
	sub	x24, x6, x30
	cmp	x30, x29
	b.hs	782f
	add	x6, x12, x30, lsl #5
	ldr	q0, [x6, #2064]
	ldr	q1, [x6, #2048]
	add	x6, x8, x24
	add	x24, x8, x24
	ldp	q2, q3, [x6]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	132b
482:
	cmp	x30, #31
	b.hi	492f
	mov	w6, #1
	str	x6, [x0, #104]
492:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x24, #32]
	ldrb	w29, [x6, x13]
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	502f
	ldp	q0, q1, [x24, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	502f
	ldp	q0, q1, [x24, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	502f
	ldp	q0, q1, [x24, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 502f
	ldp	q0, q1, [x24, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	502f
	ldp	q0, q1, [x24, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	502f
	ldp	q0, q1, [x24, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	502f
	ldp	q0, q1, [x24, #256]
	stp	q0, q1, [x28, #256]
502:
	add	x29, x29, #33
	add	x13, x13, #1
	b	142b
512:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x22, #32]
	ldrb	w25, [x6, x13]
	stp	q0, q1, [x28, #32]
	cmp	w25, #32
	b.lo	522f
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x28, #64]
	cmp	w25, #64
	b.lo	522f
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x28, #96]
	cmp	w25, #96
	b.lo	522f
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x28, #128]
	tbz	w25, #7, 522f
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x28, #160]
	cmp	w25, #160
	b.lo	522f
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x28, #192]
	cmp	w25, #192
	b.lo	522f
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x28, #224]
	cmp	w25, #224
	b.lo	522f
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x28, #256]
522:
	add	x27, x25, #33
	add	x13, x13, #1
	add	x25, x28, x27
	ubfx	x29, x21, #34, #6
	cmp	x23, x29
	b.hs	152b
532:
	sub	x6, x25, x8
	cmp	x23, x6
	csel	x30, x23, x6, lo
	sub	x28, x6, x30
	cmp	x30, x29
	b.hs	792f
	add	x6, x12, x30, lsl #5
	ldr	q0, [x6, #2064]
	ldr	q1, [x6, #2048]
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x6]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	162b
542:
	cmp	x30, #31
	b.hi	552f
	mov	w6, #1
	str	x6, [x0, #104]
552:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x28, #32]
	ldrb	w29, [x6, x13]
	stp	q0, q1, [x25, #32]
	cmp	w29, #32
	b.lo	562f
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x25, #64]
	cmp	w29, #64
	b.lo	562f
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x25, #96]
	cmp	w29, #96
	b.lo	562f
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x25, #128]
	tbz	w29, #7, 562f
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x25, #160]
	cmp	w29, #160
	b.lo	562f
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x25, #192]
	cmp	w29, #192
	b.lo	562f
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x25, #224]
	cmp	w29, #224
	b.lo	562f
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x25, #256]
562:
	add	x29, x29, #33
	add	x13, x13, #1
	b	172b
572:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x22, #32]
	ldrb	w26, [x6, x13]
	stp	q0, q1, [x28, #32]
	cmp	w26, #32
	b.lo	582f
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x28, #64]
	cmp	w26, #64
	b.lo	582f
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x28, #96]
	cmp	w26, #96
	b.lo	582f
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x28, #128]
	tbz	w26, #7, 582f
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x28, #160]
	cmp	w26, #160
	b.lo	582f
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x28, #192]
	cmp	w26, #192
	b.lo	582f
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x28, #224]
	cmp	w26, #224
	b.lo	582f
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x28, #256]
582:
	add	x26, x26, #33
	add	x13, x13, #1
	add	x27, x28, x26
	ubfx	x29, x21, #42, #6
	cmp	x23, x29
	b.hs	182b
592:
	sub	x6, x27, x8
	cmp	x23, x6
	csel	x30, x23, x6, lo
	sub	x28, x6, x30
	cmp	x30, x29
	b.hs	802f
	add	x6, x12, x30, lsl #5
	ldr	q0, [x6, #2064]
	ldr	q1, [x6, #2048]
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x6]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	192b
602:
	cmp	x30, #31
	b.hi	612f
	mov	w6, #1
	str	x6, [x0, #104]
612:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x28, #32]
	ldrb	w29, [x6, x13]
	stp	q0, q1, [x27, #32]
	cmp	w29, #32
	b.lo	622f
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x27, #64]
	cmp	w29, #64
	b.lo	622f
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x27, #96]
	cmp	w29, #96
	b.lo	622f
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x27, #128]
	tbz	w29, #7, 622f
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x27, #160]
	cmp	w29, #160
	b.lo	622f
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x27, #192]
	cmp	w29, #192
	b.lo	622f
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x27, #224]
	cmp	w29, #224
	b.lo	622f
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x27, #256]
622:
	add	x29, x29, #33
	add	x13, x13, #1
	b	202b
632:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x22, #32]
	ldrb	w23, [x6, x13]
	stp	q0, q1, [x28, #32]
	cmp	w23, #32
	b.lo	642f
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x28, #64]
	cmp	w23, #64
	b.lo	642f
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x28, #96]
	cmp	w23, #96
	b.lo	642f
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x28, #128]
	tbz	w23, #7, 642f
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x28, #160]
	cmp	w23, #160
	b.lo	642f
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x28, #192]
	cmp	w23, #192
	b.lo	642f
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x28, #224]
	cmp	w23, #224
	b.lo	642f
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x28, #256]
642:
	add	x27, x23, #33
	add	x13, x13, #1
	add	x23, x28, x27
	ubfx	x29, x21, #50, #6
	cmp	x25, x29
	b.hs	212b
652:
	sub	x6, x23, x8
	cmp	x25, x6
	csel	x30, x25, x6, lo
	sub	x28, x6, x30
	cmp	x30, x29
	b.hs	812f
	add	x6, x12, x30, lsl #5
	ldr	q0, [x6, #2064]
	ldr	q1, [x6, #2048]
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x6]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	222b
662:
	cmp	x30, #31
	b.hi	672f
	mov	w6, #1
	str	x6, [x0, #104]
672:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x28, #32]
	ldrb	w29, [x6, x13]
	stp	q0, q1, [x23, #32]
	cmp	w29, #32
	b.lo	682f
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x23, #64]
	cmp	w29, #64
	b.lo	682f
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x23, #96]
	cmp	w29, #96
	b.lo	682f
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x23, #128]
	tbz	w29, #7, 682f
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x23, #160]
	cmp	w29, #160
	b.lo	682f
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x23, #192]
	cmp	w29, #192
	b.lo	682f
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x23, #224]
	cmp	w29, #224
	b.lo	682f
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x23, #256]
682:
	add	x29, x29, #33
	add	x13, x13, #1
	b	232b
692:
	ldr	x17, [x0, #48]
	ldp	q0, q1, [x23, #32]
	ldrb	w17, [x17, x13]
	stp	q0, q1, [x28, #32]
	cmp	w17, #32
	b.lo	702f
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x28, #64]
	cmp	w17, #64
	b.lo	702f
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x28, #96]
	cmp	w17, #96
	b.lo	702f
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x28, #128]
	tbz	w17, #7, 702f
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x28, #160]
	cmp	w17, #160
	b.lo	702f
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x28, #192]
	cmp	w17, #192
	b.lo	702f
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x28, #224]
	cmp	w17, #224
	b.lo	702f
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x28, #256]
702:
	add	x26, x17, #33
	add	x13, x13, #1
	add	x17, x28, x26
	lsr	x25, x21, #58
	cmp	x22, x25
	b.hs	242b
712:
	sub	x6, x17, x8
	cmp	x22, x6
	csel	x27, x22, x6, lo
	sub	x21, x6, x27
	cmp	x27, x25
	b.hs	822f
	add	x6, x12, x27, lsl #5
	ldr	q0, [x6, #2064]
	ldr	q1, [x6, #2048]
	add	x6, x8, x21
	add	x21, x8, x21
	ldp	q2, q3, [x6]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	252b
722:
	cmp	x27, #31
	b.hi	732f
	mov	w6, #1
	str	x6, [x0, #104]
732:
	ldr	x6, [x0, #48]
	ldp	q0, q1, [x21, #32]
	ldrb	w25, [x6, x13]
	stp	q0, q1, [x17, #32]
	cmp	w25, #32
	b.lo	742f
	ldp	q0, q1, [x21, #64]
	stp	q0, q1, [x17, #64]
	cmp	w25, #64
	b.lo	742f
	ldp	q0, q1, [x21, #96]
	stp	q0, q1, [x17, #96]
	cmp	w25, #96
	b.lo	742f
	ldp	q0, q1, [x21, #128]
	stp	q0, q1, [x17, #128]
	tbz	w25, #7, 742f
	ldp	q0, q1, [x21, #160]
	stp	q0, q1, [x17, #160]
	cmp	w25, #160
	b.lo	742f
	ldp	q0, q1, [x21, #192]
	stp	q0, q1, [x17, #192]
	cmp	w25, #192
	b.lo	742f
	ldp	q0, q1, [x21, #224]
	stp	q0, q1, [x17, #224]
	cmp	w25, #224
	b.lo	742f
	ldp	q0, q1, [x21, #256]
	stp	q0, q1, [x17, #256]
742:
	add	x25, x25, #33
	add	x13, x13, #1
	b	262b
752:
	add	x6, x8, x25
	add	x25, x8, x25
	ldp	q1, q0, [x6]
	b	42b
762:
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x6]
	b	72b
772:
	add	x6, x8, x23
	add	x23, x8, x23
	ldp	q1, q0, [x6]
	b	102b
782:
	add	x6, x8, x24
	add	x24, x8, x24
	ldp	q1, q0, [x6]
	b	132b
792:
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x6]
	b	162b
802:
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x6]
	b	192b
812:
	add	x6, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x6]
	b	222b
822:
	add	x6, x8, x21
	add	x21, x8, x21
	ldp	q1, q0, [x6]
	b	252b
832:
	mov	x16, xzr
	b	852f
842:
	cbz	x10, 972f
	neg	x16, x3
	mov	x17, x20
	mov	x15, x19
852:
	ldr	x14, [x14, x16]
	mov	w16, #1
	.p2align	5, , 16
862:
	lsr	x3, x24, #3
	and	x1, x17, #0xff
	//APP
	//NO_APP
	ldr	x1, [x12, x1, lsl #3]
	and	x4, x24, #0x7
	and	x2, x15, #0xff
	ldr	x3, [x11, x3]
	ldp	q0, q1, [x23]
	lsr	x3, x3, x4
	and	w3, w3, w1, lsr #8
	stp	q0, q1, [x25]
	adds	x3, x3, x1, lsr #32
	csel	x22, x22, x3, eq
	cmp	x2, #33
	b.hs	902f
	add	x3, x25, x2
	ubfx	x5, x14, #2, #6
	sub	x4, x3, x22
	cmp	x22, x5
	ccmp	x4, x8, #8, hs
	b.lt	922f
872:
	ldp	q1, q0, [x4]
	mov	x6, x22
882:
	stp	q1, q0, [x3]
	cmp	x5, #33
	b.hs	932f
892:
	add	x24, x24, w1, uxtb
	add	x25, x3, x5
	add	x23, x23, x2
	subs	x10, x10, #1
	lsr	x14, x14, #8
	lsr	x15, x15, #8
	lsr	x17, x17, #8
	b.ne	862b
	b	972f
902:
	ldr	x2, [x0, #48]
	ldp	q0, q1, [x23, #32]
	ldrb	w2, [x2, x13]
	stp	q0, q1, [x25, #32]
	cmp	w2, #32
	b.lo	912f
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x25, #64]
	cmp	w2, #64
	b.lo	912f
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x25, #96]
	cmp	w2, #96
	b.lo	912f
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x25, #128]
	tbz	w2, #7, 912f
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x25, #160]
	cmp	w2, #160
	b.lo	912f
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x25, #192]
	cmp	w2, #192
	b.lo	912f
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x25, #224]
	cmp	w2, #224
	b.lo	912f
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x25, #256]
912:
	add	x2, x2, #33
	add	x13, x13, #1
	add	x3, x25, x2
	ubfx	x5, x14, #2, #6
	sub	x4, x3, x22
	cmp	x22, x5
	ccmp	x4, x8, #8, hs
	b.ge	872b
922:
	sub	x4, x3, x8
	cmp	x22, x4
	csel	x6, x22, x4, lo
	sub	x4, x4, x6
	cmp	x6, x5
	b.hs	962f
	add	x7, x12, x6, lsl #5
	ldr	q0, [x7, #2064]
	ldr	q1, [x7, #2048]
	add	x7, x8, x4
	add	x4, x8, x4
	ldp	q2, q3, [x7]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	882b
932:
	cmp	x6, #31
	b.hi	942f
	str	x16, [x0, #104]
942:
	ldr	x5, [x0, #48]
	ldp	q0, q1, [x4, #32]
	ldrb	w5, [x5, x13]
	stp	q0, q1, [x3, #32]
	cmp	w5, #32
	b.lo	952f
	ldp	q0, q1, [x4, #64]
	stp	q0, q1, [x3, #64]
	cmp	w5, #64
	b.lo	952f
	ldp	q0, q1, [x4, #96]
	stp	q0, q1, [x3, #96]
	cmp	w5, #96
	b.lo	952f
	ldp	q0, q1, [x4, #128]
	stp	q0, q1, [x3, #128]
	tbz	w5, #7, 952f
	ldp	q0, q1, [x4, #160]
	stp	q0, q1, [x3, #160]
	cmp	w5, #160
	b.lo	952f
	ldp	q0, q1, [x4, #192]
	stp	q0, q1, [x3, #192]
	cmp	w5, #192
	b.lo	952f
	ldp	q0, q1, [x4, #224]
	stp	q0, q1, [x3, #224]
	cmp	w5, #224
	b.lo	952f
	ldp	q0, q1, [x4, #256]
	stp	q0, q1, [x3, #256]
952:
	add	x5, x5, #33
	add	x13, x13, #1
	b	892b
962:
	add	x7, x8, x4
	add	x4, x8, x4
	ldp	q1, q0, [x7]
	b	882b
972:
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
982:
	ret

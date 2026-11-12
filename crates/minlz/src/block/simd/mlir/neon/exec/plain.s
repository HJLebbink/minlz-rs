// minlz_exec_plain of crates/minlz/mlir/exec8.mlir for neon, written by
// cargo xtask mlir. Do not edit.
	ldr	x10, [x0, #64]
	mov	x16, #72340172838076673
	//APP
	//NO_APP
	cbz	x10, 802f
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
	b.lo	672f
	lsr	x3, x3, #56
	lsr	x4, x4, #56
	mov	w5, #1
	mov	x2, xzr
	mov	x6, x15
	.p2align	5, , 16
2:
	subs	x10, x10, #8
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
	bic	x7, x16, x14
	and	x14, x14, x16
	mul	x25, x13, x16
	sub	x26, x25, x13
	eor	x13, x13, x16
	add	x4, x4, x25, lsr #56
	mul	x25, x7, x16
	orr	x13, x26, x13, lsl #7
	fmov	d1, x13
	sub	x7, x25, x7
	orr	x14, x7, x14, lsl #7
	tbl	v0.8b, { v0.16b }, v1.8b
	fmov	d1, x14
	fmov	x13, d0
	ldr	d0, [x1, x3]
	add	x3, x3, x25, lsr #56
	tbl	v0.8b, { v0.16b }, v1.8b
	fmov	x14, d0
22:
	and	x25, x19, #0xff
	//APP
	//NO_APP
	ldr	x27, [x12, x25, lsl #3]
	lsr	x25, x23, #3
	and	x28, x23, #0x7
	ldr	x7, [x6]
	ldr	x25, [x11, x25]
	ldp	q0, q1, [x22]
	and	x26, x20, #0xff
	lsr	x25, x25, x28
	and	w25, w25, w27, lsr #8
	stp	q0, q1, [x24]
	adds	x25, x25, x27, lsr #32
	csel	x25, x21, x25, eq
	cmp	x26, #33
	b.hs	272f
32:
	add	x21, x24, x26
	ubfx	x24, x7, #2, #6
	sub	x28, x21, x25
	cmp	x25, x24
	ccmp	x28, x8, #8, hs
	b.lt	512f
	ldp	q1, q0, [x28]
	mov	x29, x25
42:
	stp	q1, q0, [x21]
	cmp	x24, #33
	b.hs	282f
52:
	add	x23, x23, w27, uxtb
	add	x27, x21, x24
	add	x21, x22, x26
	ubfx	x22, x19, #8, #8
	//APP
	//NO_APP
	ldr	x24, [x12, x22, lsl #3]
	ldp	q0, q1, [x21]
	ubfx	x26, x20, #8, #8
	lsr	x22, x23, #3
	and	x28, x23, #0x7
	ldr	x22, [x11, x22]
	lsr	x22, x22, x28
	stp	q0, q1, [x27]
	and	w22, w22, w24, lsr #8
	adds	x22, x22, x24, lsr #32
	csel	x22, x25, x22, eq
	cmp	x26, #33
	b.hs	302f
62:
	add	x25, x27, x26
	ubfx	x27, x7, #10, #6
	sub	x28, x25, x22
	cmp	x22, x27
	ccmp	x28, x8, #8, hs
	b.lt	522f
	ldp	q1, q0, [x28]
	mov	x29, x22
72:
	stp	q1, q0, [x25]
	cmp	x27, #33
	b.hs	312f
82:
	add	x24, x23, w24, uxtb
	add	x27, x25, x27
	ubfx	x23, x19, #16, #8
	//APP
	//NO_APP
	ldr	x25, [x12, x23, lsl #3]
	add	x21, x21, x26
	ldp	q0, q1, [x21]
	ubfx	x26, x20, #16, #8
	lsr	x23, x24, #3
	and	x28, x24, #0x7
	ldr	x23, [x11, x23]
	lsr	x23, x23, x28
	stp	q0, q1, [x27]
	and	w23, w23, w25, lsr #8
	adds	x23, x23, x25, lsr #32
	csel	x23, x22, x23, eq
	cmp	x26, #33
	b.hs	332f
92:
	add	x27, x27, x26
	ubfx	x28, x7, #18, #6
	sub	x22, x27, x23
	cmp	x23, x28
	ccmp	x22, x8, #8, hs
	b.lt	532f
	ldp	q1, q0, [x22]
	mov	x29, x23
102:
	stp	q1, q0, [x27]
	cmp	x28, #33
	b.hs	342f
112:
	add	x22, x24, w25, uxtb
	add	x21, x21, x26
	lsr	w24, w19, #24
	//APP
	//NO_APP
	ldr	x26, [x12, x24, lsl #3]
	add	x27, x27, x28
	ldp	q0, q1, [x21]
	lsr	w25, w20, #24
	lsr	x24, x22, #3
	and	x28, x22, #0x7
	ldr	x24, [x11, x24]
	lsr	x24, x24, x28
	stp	q0, q1, [x27]
	and	w24, w24, w26, lsr #8
	adds	x24, x24, x26, lsr #32
	csel	x24, x23, x24, eq
	cmp	x25, #33
	b.hs	362f
122:
	add	x27, x27, x25
	lsr	w28, w7, #26
	sub	x23, x27, x24
	cmp	x24, x28
	ccmp	x23, x8, #8, hs
	b.lt	542f
	ldp	q1, q0, [x23]
	mov	x29, x24
132:
	stp	q1, q0, [x27]
	cmp	x28, #33
	b.hs	372f
142:
	add	x23, x22, w26, uxtb
	add	x21, x21, x25
	ubfx	x22, x19, #32, #8
	//APP
	//NO_APP
	ldr	x25, [x12, x22, lsl #3]
	add	x27, x27, x28
	ldp	q0, q1, [x21]
	ubfx	x26, x20, #32, #8
	lsr	x22, x23, #3
	and	x28, x23, #0x7
	ldr	x22, [x11, x22]
	lsr	x22, x22, x28
	stp	q0, q1, [x27]
	and	w22, w22, w25, lsr #8
	adds	x22, x22, x25, lsr #32
	csel	x22, x24, x22, eq
	cmp	x26, #33
	b.hs	392f
152:
	add	x24, x27, x26
	ubfx	x27, x7, #34, #6
	cmp	x22, x27
	b.lo	552f
	sub	x28, x24, x22
	cmp	x28, x8
	b.lt	552f
	ldp	q1, q0, [x28]
	mov	x29, x22
162:
	stp	q1, q0, [x24]
	cmp	x27, #33
	b.hs	402f
172:
	add	x23, x23, w25, uxtb
	add	x21, x21, x26
	add	x27, x24, x27
	ubfx	x24, x19, #40, #8
	//APP
	//NO_APP
	ldr	x24, [x12, x24, lsl #3]
	ldp	q0, q1, [x21]
	ubfx	x25, x20, #40, #8
	lsr	x26, x23, #3
	and	x28, x23, #0x7
	ldr	x26, [x11, x26]
	lsr	x26, x26, x28
	stp	q0, q1, [x27]
	and	w26, w26, w24, lsr #8
	adds	x26, x26, x24, lsr #32
	csel	x22, x22, x26, eq
	cmp	x25, #33
	b.hs	422f
182:
	add	x26, x27, x25
	ubfx	x27, x7, #42, #6
	cmp	x22, x27
	b.lo	562f
	sub	x28, x26, x22
	cmp	x28, x8
	b.lt	562f
	ldp	q1, q0, [x28]
	mov	x29, x22
192:
	stp	q1, q0, [x26]
	cmp	x27, #33
	b.hs	432f
202:
	add	x23, x23, w24, uxtb
	add	x21, x21, x25
	ubfx	x24, x19, #48, #8
	//APP
	//NO_APP
	ldr	x25, [x12, x24, lsl #3]
	add	x27, x26, x27
	ldp	q0, q1, [x21]
	ubfx	x26, x20, #48, #8
	lsr	x24, x23, #3
	and	x28, x23, #0x7
	ldr	x24, [x11, x24]
	lsr	x24, x24, x28
	stp	q0, q1, [x27]
	and	w24, w24, w25, lsr #8
	adds	x24, x24, x25, lsr #32
	csel	x24, x22, x24, eq
	cmp	x26, #33
	b.hs	452f
212:
	add	x22, x27, x26
	ubfx	x27, x7, #50, #6
	cmp	x24, x27
	b.lo	572f
	sub	x28, x22, x24
	cmp	x28, x8
	b.lt	572f
	ldp	q1, q0, [x28]
	mov	x29, x24
222:
	stp	q1, q0, [x22]
	cmp	x27, #33
	b.hs	462f
232:
	add	x23, x23, w25, uxtb
	add	x25, x22, x27
	add	x22, x21, x26
	lsr	x19, x19, #56
	//APP
	//NO_APP
	ldr	x19, [x12, x19, lsl #3]
	ldp	q0, q1, [x22]
	lsr	x20, x20, #56
	lsr	x21, x23, #3
	and	x26, x23, #0x7
	ldr	x21, [x11, x21]
	lsr	x21, x21, x26
	stp	q0, q1, [x25]
	and	w21, w21, w19, lsr #8
	adds	x21, x21, x19, lsr #32
	csel	x21, x24, x21, eq
	cmp	x20, #33
	b.hs	482f
242:
	add	x24, x25, x20
	lsr	x7, x7, #58
	cmp	x21, x7
	b.lo	582f
	sub	x25, x24, x21
	cmp	x25, x8
	b.lt	582f
	ldp	q1, q0, [x25]
	mov	x26, x21
252:
	stp	q1, q0, [x24]
	cmp	x7, #33
	b.hs	492f
262:
	add	x23, x23, w19, uxtb
	add	x24, x24, x7
	add	x22, x22, x20
	sub	x2, x2, #8
	add	x6, x6, #8
	cmp	x10, #7
	b.hi	2b
	b	682f
272:
	ldr	x21, [x0, #48]
	ldr	x26, [x0, #120]
	ldrb	w21, [x21, x26]
	add	x26, x26, #1
	str	x26, [x0, #120]
	ldp	q0, q1, [x22, #32]
	add	x26, x21, #33
	stp	q0, q1, [x24, #32]
	cmp	w21, #32
	b.lo	32b
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x24, #64]
	cmp	w21, #64
	b.lo	32b
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x24, #96]
	cmp	w21, #96
	b.lo	32b
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x24, #128]
	tbz	w21, #7, 32b
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x24, #160]
	cmp	w21, #160
	b.lo	32b
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x24, #192]
	cmp	w21, #192
	b.lo	32b
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x24, #224]
	cmp	w21, #224
	b.lo	32b
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x24, #256]
	b	32b
282:
	cmp	x29, #31
	b.hi	292f
	str	x5, [x0, #104]
292:
	ldr	x24, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x24, x30]
	add	x24, x30, #1
	str	x24, [x0, #120]
	ldp	q0, q1, [x28, #32]
	add	x24, x29, #33
	stp	q0, q1, [x21, #32]
	cmp	w29, #32
	b.lo	52b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x21, #64]
	cmp	w29, #64
	b.lo	52b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x21, #96]
	cmp	w29, #96
	b.lo	52b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x21, #128]
	tbz	w29, #7, 52b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x21, #160]
	cmp	w29, #160
	b.lo	52b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x21, #192]
	cmp	w29, #192
	b.lo	52b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x21, #224]
	cmp	w29, #224
	b.lo	52b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x21, #256]
	b	52b
302:
	ldr	x25, [x0, #48]
	ldr	x26, [x0, #120]
	ldrb	w25, [x25, x26]
	add	x26, x26, #1
	str	x26, [x0, #120]
	ldp	q0, q1, [x21, #32]
	add	x26, x25, #33
	stp	q0, q1, [x27, #32]
	cmp	w25, #32
	b.lo	62b
	ldp	q0, q1, [x21, #64]
	stp	q0, q1, [x27, #64]
	cmp	w25, #64
	b.lo	62b
	ldp	q0, q1, [x21, #96]
	stp	q0, q1, [x27, #96]
	cmp	w25, #96
	b.lo	62b
	ldp	q0, q1, [x21, #128]
	stp	q0, q1, [x27, #128]
	tbz	w25, #7, 62b
	ldp	q0, q1, [x21, #160]
	stp	q0, q1, [x27, #160]
	cmp	w25, #160
	b.lo	62b
	ldp	q0, q1, [x21, #192]
	stp	q0, q1, [x27, #192]
	cmp	w25, #192
	b.lo	62b
	ldp	q0, q1, [x21, #224]
	stp	q0, q1, [x27, #224]
	cmp	w25, #224
	b.lo	62b
	ldp	q0, q1, [x21, #256]
	stp	q0, q1, [x27, #256]
	b	62b
312:
	cmp	x29, #31
	b.hi	322f
	str	x5, [x0, #104]
322:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x27, x30]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldp	q0, q1, [x28, #32]
	add	x27, x29, #33
	stp	q0, q1, [x25, #32]
	cmp	w29, #32
	b.lo	82b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x25, #64]
	cmp	w29, #64
	b.lo	82b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x25, #96]
	cmp	w29, #96
	b.lo	82b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x25, #128]
	tbz	w29, #7, 82b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x25, #160]
	cmp	w29, #160
	b.lo	82b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x25, #192]
	cmp	w29, #192
	b.lo	82b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x25, #224]
	cmp	w29, #224
	b.lo	82b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x25, #256]
	b	82b
332:
	ldr	x22, [x0, #48]
	ldr	x26, [x0, #120]
	ldrb	w22, [x22, x26]
	add	x26, x26, #1
	str	x26, [x0, #120]
	ldp	q0, q1, [x21, #32]
	add	x26, x22, #33
	stp	q0, q1, [x27, #32]
	cmp	w22, #32
	b.lo	92b
	ldp	q0, q1, [x21, #64]
	stp	q0, q1, [x27, #64]
	cmp	w22, #64
	b.lo	92b
	ldp	q0, q1, [x21, #96]
	stp	q0, q1, [x27, #96]
	cmp	w22, #96
	b.lo	92b
	ldp	q0, q1, [x21, #128]
	stp	q0, q1, [x27, #128]
	tbz	w22, #7, 92b
	ldp	q0, q1, [x21, #160]
	stp	q0, q1, [x27, #160]
	cmp	w22, #160
	b.lo	92b
	ldp	q0, q1, [x21, #192]
	stp	q0, q1, [x27, #192]
	cmp	w22, #192
	b.lo	92b
	ldp	q0, q1, [x21, #224]
	stp	q0, q1, [x27, #224]
	cmp	w22, #224
	b.lo	92b
	ldp	q0, q1, [x21, #256]
	stp	q0, q1, [x27, #256]
	b	92b
342:
	cmp	x29, #31
	b.hi	352f
	str	x5, [x0, #104]
352:
	ldr	x28, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x28, x30]
	add	x28, x30, #1
	str	x28, [x0, #120]
	ldp	q0, q1, [x22, #32]
	add	x28, x29, #33
	stp	q0, q1, [x27, #32]
	cmp	w29, #32
	b.lo	112b
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x27, #64]
	cmp	w29, #64
	b.lo	112b
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x27, #96]
	cmp	w29, #96
	b.lo	112b
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x27, #128]
	tbz	w29, #7, 112b
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x27, #160]
	cmp	w29, #160
	b.lo	112b
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x27, #192]
	cmp	w29, #192
	b.lo	112b
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x27, #224]
	cmp	w29, #224
	b.lo	112b
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x27, #256]
	b	112b
362:
	ldr	x23, [x0, #48]
	ldr	x25, [x0, #120]
	ldrb	w23, [x23, x25]
	add	x25, x25, #1
	str	x25, [x0, #120]
	ldp	q0, q1, [x21, #32]
	add	x25, x23, #33
	stp	q0, q1, [x27, #32]
	cmp	w23, #32
	b.lo	122b
	ldp	q0, q1, [x21, #64]
	stp	q0, q1, [x27, #64]
	cmp	w23, #64
	b.lo	122b
	ldp	q0, q1, [x21, #96]
	stp	q0, q1, [x27, #96]
	cmp	w23, #96
	b.lo	122b
	ldp	q0, q1, [x21, #128]
	stp	q0, q1, [x27, #128]
	tbz	w23, #7, 122b
	ldp	q0, q1, [x21, #160]
	stp	q0, q1, [x27, #160]
	cmp	w23, #160
	b.lo	122b
	ldp	q0, q1, [x21, #192]
	stp	q0, q1, [x27, #192]
	cmp	w23, #192
	b.lo	122b
	ldp	q0, q1, [x21, #224]
	stp	q0, q1, [x27, #224]
	cmp	w23, #224
	b.lo	122b
	ldp	q0, q1, [x21, #256]
	stp	q0, q1, [x27, #256]
	b	122b
372:
	cmp	x29, #31
	b.hi	382f
	str	x5, [x0, #104]
382:
	ldr	x28, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x28, x30]
	add	x28, x30, #1
	str	x28, [x0, #120]
	ldp	q0, q1, [x23, #32]
	add	x28, x29, #33
	stp	q0, q1, [x27, #32]
	cmp	w29, #32
	b.lo	142b
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x27, #64]
	cmp	w29, #64
	b.lo	142b
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x27, #96]
	cmp	w29, #96
	b.lo	142b
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x27, #128]
	tbz	w29, #7, 142b
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x27, #160]
	cmp	w29, #160
	b.lo	142b
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x27, #192]
	cmp	w29, #192
	b.lo	142b
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x27, #224]
	cmp	w29, #224
	b.lo	142b
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x27, #256]
	b	142b
392:
	ldr	x24, [x0, #48]
	ldr	x26, [x0, #120]
	ldrb	w24, [x24, x26]
	add	x26, x26, #1
	str	x26, [x0, #120]
	ldp	q0, q1, [x21, #32]
	add	x26, x24, #33
	stp	q0, q1, [x27, #32]
	cmp	w24, #32
	b.lo	152b
	ldp	q0, q1, [x21, #64]
	stp	q0, q1, [x27, #64]
	cmp	w24, #64
	b.lo	152b
	ldp	q0, q1, [x21, #96]
	stp	q0, q1, [x27, #96]
	cmp	w24, #96
	b.lo	152b
	ldp	q0, q1, [x21, #128]
	stp	q0, q1, [x27, #128]
	tbz	w24, #7, 152b
	ldp	q0, q1, [x21, #160]
	stp	q0, q1, [x27, #160]
	cmp	w24, #160
	b.lo	152b
	ldp	q0, q1, [x21, #192]
	stp	q0, q1, [x27, #192]
	cmp	w24, #192
	b.lo	152b
	ldp	q0, q1, [x21, #224]
	stp	q0, q1, [x27, #224]
	cmp	w24, #224
	b.lo	152b
	ldp	q0, q1, [x21, #256]
	stp	q0, q1, [x27, #256]
	b	152b
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
	stp	q0, q1, [x24, #32]
	cmp	w29, #32
	b.lo	172b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x24, #64]
	cmp	w29, #64
	b.lo	172b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x24, #96]
	cmp	w29, #96
	b.lo	172b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x24, #128]
	tbz	w29, #7, 172b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x24, #160]
	cmp	w29, #160
	b.lo	172b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x24, #192]
	cmp	w29, #192
	b.lo	172b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x24, #224]
	cmp	w29, #224
	b.lo	172b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x24, #256]
	b	172b
422:
	ldr	x25, [x0, #48]
	ldr	x28, [x0, #120]
	ldrb	w26, [x25, x28]
	add	x25, x28, #1
	str	x25, [x0, #120]
	ldp	q0, q1, [x21, #32]
	add	x25, x26, #33
	stp	q0, q1, [x27, #32]
	cmp	w26, #32
	b.lo	182b
	ldp	q0, q1, [x21, #64]
	stp	q0, q1, [x27, #64]
	cmp	w26, #64
	b.lo	182b
	ldp	q0, q1, [x21, #96]
	stp	q0, q1, [x27, #96]
	cmp	w26, #96
	b.lo	182b
	ldp	q0, q1, [x21, #128]
	stp	q0, q1, [x27, #128]
	tbz	w26, #7, 182b
	ldp	q0, q1, [x21, #160]
	stp	q0, q1, [x27, #160]
	cmp	w26, #160
	b.lo	182b
	ldp	q0, q1, [x21, #192]
	stp	q0, q1, [x27, #192]
	cmp	w26, #192
	b.lo	182b
	ldp	q0, q1, [x21, #224]
	stp	q0, q1, [x27, #224]
	cmp	w26, #224
	b.lo	182b
	ldp	q0, q1, [x21, #256]
	stp	q0, q1, [x27, #256]
	b	182b
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
	b.lo	202b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x26, #64]
	cmp	w29, #64
	b.lo	202b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x26, #96]
	cmp	w29, #96
	b.lo	202b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x26, #128]
	tbz	w29, #7, 202b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x26, #160]
	cmp	w29, #160
	b.lo	202b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x26, #192]
	cmp	w29, #192
	b.lo	202b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x26, #224]
	cmp	w29, #224
	b.lo	202b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x26, #256]
	b	202b
452:
	ldr	x22, [x0, #48]
	ldr	x26, [x0, #120]
	ldrb	w22, [x22, x26]
	add	x26, x26, #1
	str	x26, [x0, #120]
	ldp	q0, q1, [x21, #32]
	add	x26, x22, #33
	stp	q0, q1, [x27, #32]
	cmp	w22, #32
	b.lo	212b
	ldp	q0, q1, [x21, #64]
	stp	q0, q1, [x27, #64]
	cmp	w22, #64
	b.lo	212b
	ldp	q0, q1, [x21, #96]
	stp	q0, q1, [x27, #96]
	cmp	w22, #96
	b.lo	212b
	ldp	q0, q1, [x21, #128]
	stp	q0, q1, [x27, #128]
	tbz	w22, #7, 212b
	ldp	q0, q1, [x21, #160]
	stp	q0, q1, [x27, #160]
	cmp	w22, #160
	b.lo	212b
	ldp	q0, q1, [x21, #192]
	stp	q0, q1, [x27, #192]
	cmp	w22, #192
	b.lo	212b
	ldp	q0, q1, [x21, #224]
	stp	q0, q1, [x27, #224]
	cmp	w22, #224
	b.lo	212b
	ldp	q0, q1, [x21, #256]
	stp	q0, q1, [x27, #256]
	b	212b
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
	stp	q0, q1, [x22, #32]
	cmp	w29, #32
	b.lo	232b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x22, #64]
	cmp	w29, #64
	b.lo	232b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x22, #96]
	cmp	w29, #96
	b.lo	232b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x22, #128]
	tbz	w29, #7, 232b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x22, #160]
	cmp	w29, #160
	b.lo	232b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x22, #192]
	cmp	w29, #192
	b.lo	232b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x22, #224]
	cmp	w29, #224
	b.lo	232b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x22, #256]
	b	232b
482:
	ldr	x20, [x0, #48]
	ldr	x26, [x0, #120]
	ldrb	w24, [x20, x26]
	add	x20, x26, #1
	str	x20, [x0, #120]
	ldp	q0, q1, [x22, #32]
	add	x20, x24, #33
	stp	q0, q1, [x25, #32]
	cmp	w24, #32
	b.lo	242b
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x25, #64]
	cmp	w24, #64
	b.lo	242b
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x25, #96]
	cmp	w24, #96
	b.lo	242b
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x25, #128]
	tbz	w24, #7, 242b
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x25, #160]
	cmp	w24, #160
	b.lo	242b
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x25, #192]
	cmp	w24, #192
	b.lo	242b
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x25, #224]
	cmp	w24, #224
	b.lo	242b
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x25, #256]
	b	242b
492:
	cmp	x26, #31
	b.hi	502f
	str	x5, [x0, #104]
502:
	ldr	x7, [x0, #48]
	ldr	x27, [x0, #120]
	ldrb	w26, [x7, x27]
	add	x7, x27, #1
	str	x7, [x0, #120]
	ldp	q0, q1, [x25, #32]
	add	x7, x26, #33
	stp	q0, q1, [x24, #32]
	cmp	w26, #32
	b.lo	262b
	ldp	q0, q1, [x25, #64]
	stp	q0, q1, [x24, #64]
	cmp	w26, #64
	b.lo	262b
	ldp	q0, q1, [x25, #96]
	stp	q0, q1, [x24, #96]
	cmp	w26, #96
	b.lo	262b
	ldp	q0, q1, [x25, #128]
	stp	q0, q1, [x24, #128]
	tbz	w26, #7, 262b
	ldp	q0, q1, [x25, #160]
	stp	q0, q1, [x24, #160]
	cmp	w26, #160
	b.lo	262b
	ldp	q0, q1, [x25, #192]
	stp	q0, q1, [x24, #192]
	cmp	w26, #192
	b.lo	262b
	ldp	q0, q1, [x25, #224]
	stp	q0, q1, [x24, #224]
	cmp	w26, #224
	b.lo	262b
	ldp	q0, q1, [x25, #256]
	stp	q0, q1, [x24, #256]
	b	262b
512:
	sub	x28, x21, x8
	cmp	x25, x28
	csel	x29, x25, x28, lo
	sub	x28, x28, x29
	cmp	x29, x24
	b.hs	592f
	ldr	x30, [x0, #56]
	add	x30, x30, x29, lsl #5
	ldr	q0, [x30, #2064]
	ldr	q1, [x30, #2048]
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x30]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	42b
522:
	sub	x28, x25, x8
	cmp	x22, x28
	csel	x29, x22, x28, lo
	sub	x28, x28, x29
	cmp	x29, x27
	b.hs	602f
	ldr	x30, [x0, #56]
	add	x30, x30, x29, lsl #5
	ldr	q0, [x30, #2064]
	ldr	q1, [x30, #2048]
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x30]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	72b
532:
	sub	x22, x27, x8
	cmp	x23, x22
	csel	x29, x23, x22, lo
	sub	x22, x22, x29
	cmp	x29, x28
	b.hs	612f
	ldr	x30, [x0, #56]
	add	x30, x30, x29, lsl #5
	ldr	q0, [x30, #2064]
	ldr	q1, [x30, #2048]
	add	x30, x8, x22
	add	x22, x8, x22
	ldp	q2, q3, [x30]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	102b
542:
	sub	x23, x27, x8
	cmp	x24, x23
	csel	x29, x24, x23, lo
	sub	x23, x23, x29
	cmp	x29, x28
	b.hs	622f
	ldr	x30, [x0, #56]
	add	x30, x30, x29, lsl #5
	ldr	q0, [x30, #2064]
	ldr	q1, [x30, #2048]
	add	x30, x8, x23
	add	x23, x8, x23
	ldp	q2, q3, [x30]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	132b
552:
	sub	x28, x24, x8
	cmp	x22, x28
	csel	x29, x22, x28, lo
	sub	x28, x28, x29
	cmp	x29, x27
	b.hs	632f
	ldr	x30, [x0, #56]
	add	x30, x30, x29, lsl #5
	ldr	q0, [x30, #2064]
	ldr	q1, [x30, #2048]
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x30]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	162b
562:
	sub	x28, x26, x8
	cmp	x22, x28
	csel	x29, x22, x28, lo
	sub	x28, x28, x29
	cmp	x29, x27
	b.hs	642f
	ldr	x30, [x0, #56]
	add	x30, x30, x29, lsl #5
	ldr	q0, [x30, #2064]
	ldr	q1, [x30, #2048]
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q2, q3, [x30]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	192b
572:
	sub	x28, x22, x8
	cmp	x24, x28
	csel	x29, x24, x28, lo
	sub	x28, x28, x29
	cmp	x29, x27
	b.hs	652f
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
582:
	sub	x25, x24, x8
	cmp	x21, x25
	csel	x26, x21, x25, lo
	sub	x25, x25, x26
	cmp	x26, x7
	b.hs	662f
	ldr	x27, [x0, #56]
	add	x27, x27, x26, lsl #5
	ldr	q0, [x27, #2064]
	ldr	q1, [x27, #2048]
	add	x27, x8, x25
	add	x25, x8, x25
	ldp	q2, q3, [x27]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	252b
592:
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x30]
	b	42b
602:
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x30]
	b	72b
612:
	add	x30, x8, x22
	add	x22, x8, x22
	ldp	q1, q0, [x30]
	b	102b
622:
	add	x30, x8, x23
	add	x23, x8, x23
	ldp	q1, q0, [x30]
	b	132b
632:
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x30]
	b	162b
642:
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x30]
	b	192b
652:
	add	x30, x8, x28
	add	x28, x8, x28
	ldp	q1, q0, [x30]
	b	222b
662:
	add	x27, x8, x25
	add	x25, x8, x25
	ldp	q1, q0, [x27]
	b	252b
672:
	mov	x16, xzr
	b	692f
682:
	cbz	x10, 792f
	neg	x16, x2
692:
	ldr	x15, [x15, x16]
	mov	w16, #1
	.p2align	5, , 16
702:
	lsr	x2, x23, #3
	and	x1, x14, #0xff
	//APP
	//NO_APP
	ldr	x1, [x12, x1, lsl #3]
	and	x3, x23, #0x7
	and	x17, x13, #0xff
	ldr	x2, [x11, x2]
	ldp	q0, q1, [x22]
	lsr	x2, x2, x3
	and	w2, w2, w1, lsr #8
	stp	q0, q1, [x24]
	adds	x2, x2, x1, lsr #32
	csel	x21, x21, x2, eq
	cmp	x17, #33
	b.hs	742f
712:
	add	x2, x24, x17
	ubfx	x3, x15, #2, #6
	sub	x4, x2, x21
	cmp	x21, x3
	ccmp	x4, x8, #8, hs
	b.lt	772f
	ldp	q1, q0, [x4]
	mov	x5, x21
722:
	stp	q1, q0, [x2]
	cmp	x3, #33
	b.hs	752f
732:
	add	x23, x23, w1, uxtb
	add	x24, x2, x3
	add	x22, x22, x17
	subs	x10, x10, #1
	lsr	x15, x15, #8
	lsr	x13, x13, #8
	lsr	x14, x14, #8
	b.ne	702b
	b	792f
742:
	ldr	x17, [x0, #48]
	ldr	x3, [x0, #120]
	ldrb	w2, [x17, x3]
	add	x17, x3, #1
	str	x17, [x0, #120]
	ldp	q0, q1, [x22, #32]
	add	x17, x2, #33
	stp	q0, q1, [x24, #32]
	cmp	w2, #32
	b.lo	712b
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x24, #64]
	cmp	w2, #64
	b.lo	712b
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x24, #96]
	cmp	w2, #96
	b.lo	712b
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x24, #128]
	tbz	w2, #7, 712b
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x24, #160]
	cmp	w2, #160
	b.lo	712b
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x24, #192]
	cmp	w2, #192
	b.lo	712b
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x24, #224]
	cmp	w2, #224
	b.lo	712b
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x24, #256]
	b	712b
752:
	cmp	x5, #31
	b.hi	762f
	str	x16, [x0, #104]
762:
	ldr	x3, [x0, #48]
	ldr	x6, [x0, #120]
	ldrb	w5, [x3, x6]
	add	x3, x6, #1
	str	x3, [x0, #120]
	ldp	q0, q1, [x4, #32]
	add	x3, x5, #33
	stp	q0, q1, [x2, #32]
	cmp	w5, #32
	b.lo	732b
	ldp	q0, q1, [x4, #64]
	stp	q0, q1, [x2, #64]
	cmp	w5, #64
	b.lo	732b
	ldp	q0, q1, [x4, #96]
	stp	q0, q1, [x2, #96]
	cmp	w5, #96
	b.lo	732b
	ldp	q0, q1, [x4, #128]
	stp	q0, q1, [x2, #128]
	tbz	w5, #7, 732b
	ldp	q0, q1, [x4, #160]
	stp	q0, q1, [x2, #160]
	cmp	w5, #160
	b.lo	732b
	ldp	q0, q1, [x4, #192]
	stp	q0, q1, [x2, #192]
	cmp	w5, #192
	b.lo	732b
	ldp	q0, q1, [x4, #224]
	stp	q0, q1, [x2, #224]
	cmp	w5, #224
	b.lo	732b
	ldp	q0, q1, [x4, #256]
	stp	q0, q1, [x2, #256]
	b	732b
772:
	sub	x4, x2, x8
	cmp	x21, x4
	csel	x5, x21, x4, lo
	sub	x4, x4, x5
	cmp	x5, x3
	b.hs	782f
	ldr	x6, [x0, #56]
	add	x6, x6, x5, lsl #5
	ldr	q0, [x6, #2064]
	ldr	q1, [x6, #2048]
	add	x6, x8, x4
	add	x4, x8, x4
	ldp	q2, q3, [x6]
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	b	722b
782:
	add	x6, x8, x4
	add	x4, x8, x4
	ldp	q1, q0, [x6]
	b	722b
792:
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
802:
	ret

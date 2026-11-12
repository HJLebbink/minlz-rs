// minlz_exec_flat_delta of crates/minlz/mlir/exec8.mlir for neon, written by
// cargo xtask mlir. Do not edit.
	ldr	x10, [x0, #64]
	mov	x16, #72340172838076673
	//APP
	//NO_APP
	cbz	x10, 682f
	stp	x29, x30, [sp, #-96]!
	stp	x24, x23, [sp, #48]
	ldp	x8, x9, [x0]
	ldp	x15, x17, [x0, #16]
	ldp	x23, x14, [x0, #72]
	stp	x22, x21, [sp, #64]
	ldp	x13, x22, [x0, #88]
	ldp	x1, x11, [x0, #32]
	ldr	x12, [x0, #56]
	stp	x28, x27, [sp, #16]
	add	x24, x8, x14
	ldr	x14, [x15]
	add	x21, x9, x13
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
	b.lo	592f
	lsr	x3, x3, #56
	lsr	x4, x4, #56
	mov	w5, #32
	mov	x2, xzr
	mov	x6, x15
	.p2align	5, , 16
2:
	subs	x10, x10, #8
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
	and	x7, x20, #0xff
	//APP
	//NO_APP
	ldr	x26, [x12, x7, lsl #3]
	lsr	x7, x23, #3
	and	x25, x23, #0x7
	ldr	x7, [x11, x7]
	lsr	x7, x7, x25
	and	w7, w7, w26, lsr #8
	adds	x7, x7, x26, lsr #32
	csel	x25, x22, x7, eq
	cmp	x22, #32
	csel	x7, x22, x5, hi
	sub	x27, x24, x7
	cmp	x27, x8
	b.lt	272f
32:
	ldp	q1, q0, [x21]
	ldp	q3, q2, [x27]
	ldr	x7, [x6]
	and	x22, x19, #0xff
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x24]
	cmp	x22, #33
	b.hs	282f
42:
	ubfx	x27, x7, #2, #6
	tst	x5, x7, lsr #2
	add	x24, x24, x22
	csel	x28, x27, x5, eq
	cmp	x25, x28
	csel	x29, x25, x28, hi
	sub	x28, x24, x29
	cmp	x28, x8
	b.lt	292f
	ldp	q0, q1, [x28]
	stp	q0, q1, [x24]
	cmp	x27, #33
	b.hs	302f
52:
	add	x23, x23, w26, uxtb
	add	x26, x24, x27
	add	x22, x21, x22
	ubfx	x21, x20, #8, #8
	//APP
	//NO_APP
	ldr	x24, [x12, x21, lsl #3]
	ldp	q1, q0, [x22]
	lsr	x21, x23, #3
	and	x27, x23, #0x7
	ldr	x21, [x11, x21]
	lsr	x21, x21, x27
	and	w21, w21, w24, lsr #8
	adds	x21, x21, x24, lsr #32
	csel	x21, x25, x21, eq
	cmp	x25, #32
	csel	x25, x25, x5, hi
	sub	x27, x26, x25
	cmp	x27, x8
	b.lt	312f
62:
	ldp	q3, q2, [x27]
	ubfx	x25, x19, #8, #8
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x26]
	cmp	x25, #33
	b.hs	322f
72:
	ubfx	x27, x7, #10, #6
	tst	x5, x7, lsr #10
	add	x26, x26, x25
	csel	x28, x27, x5, eq
	cmp	x21, x28
	csel	x29, x21, x28, hi
	sub	x28, x26, x29
	cmp	x28, x8
	b.lt	332f
	ldp	q0, q1, [x28]
	stp	q0, q1, [x26]
	cmp	x27, #33
	b.hs	342f
82:
	add	x24, x23, w24, uxtb
	add	x23, x22, x25
	ubfx	x22, x20, #16, #8
	//APP
	//NO_APP
	ldr	x25, [x12, x22, lsl #3]
	add	x26, x26, x27
	ldp	q1, q0, [x23]
	lsr	x22, x24, #3
	and	x27, x24, #0x7
	ldr	x22, [x11, x22]
	lsr	x22, x22, x27
	and	w22, w22, w25, lsr #8
	adds	x22, x22, x25, lsr #32
	csel	x22, x21, x22, eq
	cmp	x21, #32
	csel	x21, x21, x5, hi
	sub	x27, x26, x21
	cmp	x27, x8
	b.lt	352f
92:
	ldp	q3, q2, [x27]
	ubfx	x21, x19, #16, #8
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x26]
	cmp	x21, #33
	b.hs	362f
102:
	ubfx	x27, x7, #18, #6
	tst	x5, x7, lsr #18
	add	x26, x26, x21
	csel	x28, x27, x5, eq
	cmp	x22, x28
	csel	x29, x22, x28, hi
	sub	x28, x26, x29
	cmp	x28, x8
	b.lt	372f
	ldp	q0, q1, [x28]
	stp	q0, q1, [x26]
	cmp	x27, #33
	b.hs	382f
112:
	add	x24, x24, w25, uxtb
	add	x23, x23, x21
	lsr	w21, w20, #24
	//APP
	//NO_APP
	ldr	x25, [x12, x21, lsl #3]
	add	x26, x26, x27
	ldp	q1, q0, [x23]
	lsr	x21, x24, #3
	and	x27, x24, #0x7
	ldr	x21, [x11, x21]
	lsr	x21, x21, x27
	and	w21, w21, w25, lsr #8
	adds	x21, x21, x25, lsr #32
	csel	x21, x22, x21, eq
	cmp	x22, #32
	csel	x22, x22, x5, hi
	sub	x27, x26, x22
	cmp	x27, x8
	b.lt	392f
122:
	ldp	q3, q2, [x27]
	lsr	w22, w19, #24
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x26]
	cmp	x22, #33
	b.hs	402f
132:
	lsr	w27, w7, #26
	tst	x5, x7, lsr #26
	add	x26, x26, x22
	csel	x28, x27, x5, eq
	cmp	x21, x28
	csel	x29, x21, x28, hi
	sub	x28, x26, x29
	cmp	x28, x8
	b.lt	412f
	ldp	q0, q1, [x28]
	stp	q0, q1, [x26]
	cmp	x27, #33
	b.hs	422f
142:
	add	x24, x24, w25, uxtb
	add	x23, x23, x22
	ubfx	x22, x20, #32, #8
	//APP
	//NO_APP
	ldr	x25, [x12, x22, lsl #3]
	add	x26, x26, x27
	ldp	q1, q0, [x23]
	lsr	x22, x24, #3
	and	x27, x24, #0x7
	ldr	x22, [x11, x22]
	lsr	x22, x22, x27
	and	w22, w22, w25, lsr #8
	adds	x22, x22, x25, lsr #32
	csel	x22, x21, x22, eq
	cmp	x21, #32
	csel	x21, x21, x5, hi
	sub	x27, x26, x21
	cmp	x27, x8
	b.lt	432f
152:
	ldp	q3, q2, [x27]
	ubfx	x21, x19, #32, #8
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x26]
	cmp	x21, #33
	b.hs	442f
162:
	ubfx	x27, x7, #34, #6
	tst	x5, x7, lsr #34
	add	x26, x26, x21
	csel	x28, x27, x5, eq
	cmp	x22, x28
	csel	x29, x22, x28, hi
	sub	x28, x26, x29
	cmp	x28, x8
	b.lt	452f
	ldp	q0, q1, [x28]
	stp	q0, q1, [x26]
	cmp	x27, #33
	b.hs	462f
172:
	add	x24, x24, w25, uxtb
	add	x23, x23, x21
	ubfx	x21, x20, #40, #8
	//APP
	//NO_APP
	ldr	x25, [x12, x21, lsl #3]
	add	x26, x26, x27
	ldp	q1, q0, [x23]
	lsr	x21, x24, #3
	and	x27, x24, #0x7
	ldr	x21, [x11, x21]
	lsr	x21, x21, x27
	and	w21, w21, w25, lsr #8
	adds	x21, x21, x25, lsr #32
	csel	x21, x22, x21, eq
	cmp	x22, #32
	csel	x22, x22, x5, hi
	sub	x27, x26, x22
	cmp	x27, x8
	b.lt	472f
182:
	ldp	q3, q2, [x27]
	ubfx	x22, x19, #40, #8
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x26]
	cmp	x22, #33
	b.hs	482f
192:
	ubfx	x27, x7, #42, #6
	tst	x5, x7, lsr #42
	add	x26, x26, x22
	csel	x28, x27, x5, eq
	cmp	x21, x28
	csel	x29, x21, x28, hi
	sub	x28, x26, x29
	cmp	x28, x8
	b.lt	492f
	ldp	q0, q1, [x28]
	stp	q0, q1, [x26]
	cmp	x27, #33
	b.hs	502f
202:
	add	x24, x24, w25, uxtb
	add	x22, x23, x22
	ubfx	x23, x20, #48, #8
	//APP
	//NO_APP
	ldr	x25, [x12, x23, lsl #3]
	add	x26, x26, x27
	ldp	q1, q0, [x22]
	lsr	x23, x24, #3
	and	x27, x24, #0x7
	ldr	x23, [x11, x23]
	lsr	x23, x23, x27
	and	w23, w23, w25, lsr #8
	adds	x23, x23, x25, lsr #32
	csel	x23, x21, x23, eq
	cmp	x21, #32
	csel	x21, x21, x5, hi
	sub	x27, x26, x21
	cmp	x27, x8
	b.lt	512f
212:
	ldp	q3, q2, [x27]
	ubfx	x21, x19, #48, #8
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x26]
	cmp	x21, #33
	b.hs	522f
222:
	ubfx	x27, x7, #50, #6
	tst	x5, x7, lsr #50
	add	x26, x26, x21
	csel	x28, x27, x5, eq
	cmp	x23, x28
	csel	x29, x23, x28, hi
	sub	x28, x26, x29
	cmp	x28, x8
	b.lt	532f
	ldp	q0, q1, [x28]
	stp	q0, q1, [x26]
	cmp	x27, #33
	b.hs	542f
232:
	add	x24, x24, w25, uxtb
	add	x21, x22, x21
	lsr	x20, x20, #56
	//APP
	//NO_APP
	ldr	x20, [x12, x20, lsl #3]
	add	x25, x26, x27
	ldp	q1, q0, [x21]
	lsr	x22, x24, #3
	and	x26, x24, #0x7
	ldr	x22, [x11, x22]
	lsr	x22, x22, x26
	and	w22, w22, w20, lsr #8
	adds	x22, x22, x20, lsr #32
	csel	x22, x23, x22, eq
	cmp	x23, #32
	csel	x26, x23, x5, hi
	sub	x23, x25, x26
	cmp	x23, x8
	b.lt	552f
242:
	ldp	q3, q2, [x23]
	lsr	x19, x19, #56
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x25]
	cmp	x19, #33
	b.hs	562f
252:
	lsr	x7, x7, #58
	add	x25, x25, x19
	cmp	x7, #32
	csel	x23, x7, x5, lo
	cmp	x22, x23
	csel	x26, x22, x23, hi
	sub	x23, x25, x26
	cmp	x23, x8
	b.lt	572f
	ldp	q0, q1, [x23]
	stp	q0, q1, [x25]
	cmp	x7, #33
	b.hs	582f
262:
	add	x23, x24, w20, uxtb
	add	x24, x25, x7
	add	x21, x21, x19
	sub	x2, x2, #8
	add	x6, x6, #8
	cmp	x10, #7
	b.hi	2b
	b	602f
272:
	sub	x22, x24, x8
	subs	x7, x22, x7
	csel	x7, xzr, x7, lo
	add	x27, x8, x7
	b	32b
282:
	ldr	x22, [x0, #48]
	ldr	x28, [x0, #120]
	ldrb	w27, [x22, x28]
	add	x22, x28, #1
	str	x22, [x0, #120]
	ldp	q0, q1, [x21, #32]
	add	x22, x27, #33
	stp	q0, q1, [x24, #32]
	cmp	w27, #32
	b.lo	42b
	ldp	q0, q1, [x21, #64]
	stp	q0, q1, [x24, #64]
	cmp	w27, #64
	b.lo	42b
	ldp	q0, q1, [x21, #96]
	stp	q0, q1, [x24, #96]
	cmp	w27, #96
	b.lo	42b
	ldp	q0, q1, [x21, #128]
	stp	q0, q1, [x24, #128]
	tbz	w27, #7, 42b
	ldp	q0, q1, [x21, #160]
	stp	q0, q1, [x24, #160]
	cmp	w27, #160
	b.lo	42b
	ldp	q0, q1, [x21, #192]
	stp	q0, q1, [x24, #192]
	cmp	w27, #192
	b.lo	42b
	ldp	q0, q1, [x21, #224]
	stp	q0, q1, [x24, #224]
	cmp	w27, #224
	b.lo	42b
	ldp	q0, q1, [x21, #256]
	stp	q0, q1, [x24, #256]
	b	42b
292:
	sub	x28, x24, x8
	subs	x28, x28, x29
	csel	x28, xzr, x28, lo
	add	x28, x8, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x24]
	cmp	x27, #33
	b.lo	52b
302:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x27, x30]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldp	q0, q1, [x28, #32]
	add	x27, x29, #33
	stp	q0, q1, [x24, #32]
	cmp	w29, #32
	b.lo	52b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x24, #64]
	cmp	w29, #64
	b.lo	52b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x24, #96]
	cmp	w29, #96
	b.lo	52b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x24, #128]
	tbz	w29, #7, 52b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x24, #160]
	cmp	w29, #160
	b.lo	52b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x24, #192]
	cmp	w29, #192
	b.lo	52b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x24, #224]
	cmp	w29, #224
	b.lo	52b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x24, #256]
	b	52b
312:
	sub	x27, x26, x8
	subs	x25, x27, x25
	csel	x25, xzr, x25, lo
	add	x27, x8, x25
	b	62b
322:
	ldr	x25, [x0, #48]
	ldr	x28, [x0, #120]
	ldrb	w27, [x25, x28]
	add	x25, x28, #1
	str	x25, [x0, #120]
	ldp	q0, q1, [x22, #32]
	add	x25, x27, #33
	stp	q0, q1, [x26, #32]
	cmp	w27, #32
	b.lo	72b
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x26, #64]
	cmp	w27, #64
	b.lo	72b
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x26, #96]
	cmp	w27, #96
	b.lo	72b
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x26, #128]
	tbz	w27, #7, 72b
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x26, #160]
	cmp	w27, #160
	b.lo	72b
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x26, #192]
	cmp	w27, #192
	b.lo	72b
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x26, #224]
	cmp	w27, #224
	b.lo	72b
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x26, #256]
	b	72b
332:
	sub	x28, x26, x8
	subs	x28, x28, x29
	csel	x28, xzr, x28, lo
	add	x28, x8, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x26]
	cmp	x27, #33
	b.lo	82b
342:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x27, x30]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldp	q0, q1, [x28, #32]
	add	x27, x29, #33
	stp	q0, q1, [x26, #32]
	cmp	w29, #32
	b.lo	82b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x26, #64]
	cmp	w29, #64
	b.lo	82b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x26, #96]
	cmp	w29, #96
	b.lo	82b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x26, #128]
	tbz	w29, #7, 82b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x26, #160]
	cmp	w29, #160
	b.lo	82b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x26, #192]
	cmp	w29, #192
	b.lo	82b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x26, #224]
	cmp	w29, #224
	b.lo	82b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x26, #256]
	b	82b
352:
	sub	x27, x26, x8
	subs	x21, x27, x21
	csel	x21, xzr, x21, lo
	add	x27, x8, x21
	b	92b
362:
	ldr	x21, [x0, #48]
	ldr	x28, [x0, #120]
	ldrb	w27, [x21, x28]
	add	x21, x28, #1
	str	x21, [x0, #120]
	ldp	q0, q1, [x23, #32]
	add	x21, x27, #33
	stp	q0, q1, [x26, #32]
	cmp	w27, #32
	b.lo	102b
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x26, #64]
	cmp	w27, #64
	b.lo	102b
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x26, #96]
	cmp	w27, #96
	b.lo	102b
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x26, #128]
	tbz	w27, #7, 102b
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x26, #160]
	cmp	w27, #160
	b.lo	102b
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x26, #192]
	cmp	w27, #192
	b.lo	102b
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x26, #224]
	cmp	w27, #224
	b.lo	102b
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x26, #256]
	b	102b
372:
	sub	x28, x26, x8
	subs	x28, x28, x29
	csel	x28, xzr, x28, lo
	add	x28, x8, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x26]
	cmp	x27, #33
	b.lo	112b
382:
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
392:
	sub	x27, x26, x8
	subs	x22, x27, x22
	csel	x22, xzr, x22, lo
	add	x27, x8, x22
	b	122b
402:
	ldr	x22, [x0, #48]
	ldr	x28, [x0, #120]
	ldrb	w27, [x22, x28]
	add	x22, x28, #1
	str	x22, [x0, #120]
	ldp	q0, q1, [x23, #32]
	add	x22, x27, #33
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
412:
	sub	x28, x26, x8
	subs	x28, x28, x29
	csel	x28, xzr, x28, lo
	add	x28, x8, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x26]
	cmp	x27, #33
	b.lo	142b
422:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x27, x30]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldp	q0, q1, [x28, #32]
	add	x27, x29, #33
	stp	q0, q1, [x26, #32]
	cmp	w29, #32
	b.lo	142b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x26, #64]
	cmp	w29, #64
	b.lo	142b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x26, #96]
	cmp	w29, #96
	b.lo	142b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x26, #128]
	tbz	w29, #7, 142b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x26, #160]
	cmp	w29, #160
	b.lo	142b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x26, #192]
	cmp	w29, #192
	b.lo	142b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x26, #224]
	cmp	w29, #224
	b.lo	142b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x26, #256]
	b	142b
432:
	sub	x27, x26, x8
	subs	x21, x27, x21
	csel	x21, xzr, x21, lo
	add	x27, x8, x21
	b	152b
442:
	ldr	x21, [x0, #48]
	ldr	x28, [x0, #120]
	ldrb	w27, [x21, x28]
	add	x21, x28, #1
	str	x21, [x0, #120]
	ldp	q0, q1, [x23, #32]
	add	x21, x27, #33
	stp	q0, q1, [x26, #32]
	cmp	w27, #32
	b.lo	162b
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x26, #64]
	cmp	w27, #64
	b.lo	162b
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x26, #96]
	cmp	w27, #96
	b.lo	162b
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x26, #128]
	tbz	w27, #7, 162b
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x26, #160]
	cmp	w27, #160
	b.lo	162b
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x26, #192]
	cmp	w27, #192
	b.lo	162b
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x26, #224]
	cmp	w27, #224
	b.lo	162b
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x26, #256]
	b	162b
452:
	sub	x28, x26, x8
	subs	x28, x28, x29
	csel	x28, xzr, x28, lo
	add	x28, x8, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x26]
	cmp	x27, #33
	b.lo	172b
462:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x27, x30]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldp	q0, q1, [x28, #32]
	add	x27, x29, #33
	stp	q0, q1, [x26, #32]
	cmp	w29, #32
	b.lo	172b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x26, #64]
	cmp	w29, #64
	b.lo	172b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x26, #96]
	cmp	w29, #96
	b.lo	172b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x26, #128]
	tbz	w29, #7, 172b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x26, #160]
	cmp	w29, #160
	b.lo	172b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x26, #192]
	cmp	w29, #192
	b.lo	172b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x26, #224]
	cmp	w29, #224
	b.lo	172b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x26, #256]
	b	172b
472:
	sub	x27, x26, x8
	subs	x22, x27, x22
	csel	x22, xzr, x22, lo
	add	x27, x8, x22
	b	182b
482:
	ldr	x22, [x0, #48]
	ldr	x28, [x0, #120]
	ldrb	w27, [x22, x28]
	add	x22, x28, #1
	str	x22, [x0, #120]
	ldp	q0, q1, [x23, #32]
	add	x22, x27, #33
	stp	q0, q1, [x26, #32]
	cmp	w27, #32
	b.lo	192b
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x26, #64]
	cmp	w27, #64
	b.lo	192b
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x26, #96]
	cmp	w27, #96
	b.lo	192b
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x26, #128]
	tbz	w27, #7, 192b
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x26, #160]
	cmp	w27, #160
	b.lo	192b
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x26, #192]
	cmp	w27, #192
	b.lo	192b
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x26, #224]
	cmp	w27, #224
	b.lo	192b
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x26, #256]
	b	192b
492:
	sub	x28, x26, x8
	subs	x28, x28, x29
	csel	x28, xzr, x28, lo
	add	x28, x8, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x26]
	cmp	x27, #33
	b.lo	202b
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
512:
	sub	x27, x26, x8
	subs	x21, x27, x21
	csel	x21, xzr, x21, lo
	add	x27, x8, x21
	b	212b
522:
	ldr	x21, [x0, #48]
	ldr	x28, [x0, #120]
	ldrb	w27, [x21, x28]
	add	x21, x28, #1
	str	x21, [x0, #120]
	ldp	q0, q1, [x22, #32]
	add	x21, x27, #33
	stp	q0, q1, [x26, #32]
	cmp	w27, #32
	b.lo	222b
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x26, #64]
	cmp	w27, #64
	b.lo	222b
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x26, #96]
	cmp	w27, #96
	b.lo	222b
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x26, #128]
	tbz	w27, #7, 222b
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x26, #160]
	cmp	w27, #160
	b.lo	222b
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x26, #192]
	cmp	w27, #192
	b.lo	222b
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x26, #224]
	cmp	w27, #224
	b.lo	222b
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x26, #256]
	b	222b
532:
	sub	x28, x26, x8
	subs	x28, x28, x29
	csel	x28, xzr, x28, lo
	add	x28, x8, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x26]
	cmp	x27, #33
	b.lo	232b
542:
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
552:
	sub	x23, x25, x8
	subs	x23, x23, x26
	csel	x23, xzr, x23, lo
	add	x23, x8, x23
	b	242b
562:
	ldr	x19, [x0, #48]
	ldr	x26, [x0, #120]
	ldrb	w23, [x19, x26]
	add	x19, x26, #1
	str	x19, [x0, #120]
	ldp	q0, q1, [x21, #32]
	add	x19, x23, #33
	stp	q0, q1, [x25, #32]
	cmp	w23, #32
	b.lo	252b
	ldp	q0, q1, [x21, #64]
	stp	q0, q1, [x25, #64]
	cmp	w23, #64
	b.lo	252b
	ldp	q0, q1, [x21, #96]
	stp	q0, q1, [x25, #96]
	cmp	w23, #96
	b.lo	252b
	ldp	q0, q1, [x21, #128]
	stp	q0, q1, [x25, #128]
	tbz	w23, #7, 252b
	ldp	q0, q1, [x21, #160]
	stp	q0, q1, [x25, #160]
	cmp	w23, #160
	b.lo	252b
	ldp	q0, q1, [x21, #192]
	stp	q0, q1, [x25, #192]
	cmp	w23, #192
	b.lo	252b
	ldp	q0, q1, [x21, #224]
	stp	q0, q1, [x25, #224]
	cmp	w23, #224
	b.lo	252b
	ldp	q0, q1, [x21, #256]
	stp	q0, q1, [x25, #256]
	b	252b
572:
	sub	x23, x25, x8
	subs	x23, x23, x26
	csel	x23, xzr, x23, lo
	add	x23, x8, x23
	ldp	q0, q1, [x23]
	stp	q0, q1, [x25]
	cmp	x7, #33
	b.lo	262b
582:
	ldr	x7, [x0, #48]
	ldr	x27, [x0, #120]
	ldrb	w26, [x7, x27]
	add	x7, x27, #1
	str	x7, [x0, #120]
	ldp	q0, q1, [x23, #32]
	add	x7, x26, #33
	stp	q0, q1, [x25, #32]
	cmp	w26, #32
	b.lo	262b
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x25, #64]
	cmp	w26, #64
	b.lo	262b
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x25, #96]
	cmp	w26, #96
	b.lo	262b
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x25, #128]
	tbz	w26, #7, 262b
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x25, #160]
	cmp	w26, #160
	b.lo	262b
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x25, #192]
	cmp	w26, #192
	b.lo	262b
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x25, #224]
	cmp	w26, #224
	b.lo	262b
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x25, #256]
	b	262b
592:
	mov	x16, xzr
	b	612f
602:
	cbz	x10, 672f
	neg	x16, x2
612:
	ldr	x15, [x15, x16]
	mov	w16, #32
	.p2align	5, , 16
622:
	lsr	x3, x23, #3
	and	x1, x14, #0xff
	//APP
	//NO_APP
	ldr	x1, [x12, x1, lsl #3]
	and	x4, x23, #0x7
	mov	x2, x22
	ldr	x3, [x11, x3]
	ldp	q1, q0, [x21]
	and	x17, x13, #0xff
	lsr	x3, x3, x4
	sub	x4, x24, x8
	and	w3, w3, w1, lsr #8
	adds	x3, x3, x1, lsr #32
	csel	x22, x22, x3, eq
	cmp	x2, #32
	csel	x2, x2, x16, hi
	sub	x3, x24, x2
	subs	x2, x4, x2
	csel	x2, xzr, x2, lo
	add	x2, x8, x2
	cmp	x3, x8
	csel	x2, x3, x2, ge
	ldp	q3, q2, [x2]
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x24]
	cmp	x17, #33
	b.hs	652f
632:
	ubfx	x3, x15, #2, #6
	tst	x16, x15, lsr #2
	add	x2, x24, x17
	csel	x4, x3, x16, eq
	sub	x6, x2, x8
	cmp	x22, x4
	csel	x4, x22, x4, hi
	sub	x5, x2, x4
	subs	x4, x6, x4
	csel	x4, xzr, x4, lo
	add	x4, x8, x4
	cmp	x5, x8
	csel	x4, x5, x4, ge
	ldp	q0, q1, [x4]
	stp	q0, q1, [x2]
	cmp	x3, #33
	b.hs	662f
642:
	add	x23, x23, w1, uxtb
	add	x24, x2, x3
	add	x21, x21, x17
	subs	x10, x10, #1
	lsr	x15, x15, #8
	lsr	x13, x13, #8
	lsr	x14, x14, #8
	b.ne	622b
	b	672f
652:
	ldr	x17, [x0, #48]
	ldr	x3, [x0, #120]
	ldrb	w2, [x17, x3]
	add	x17, x3, #1
	str	x17, [x0, #120]
	ldp	q0, q1, [x21, #32]
	add	x17, x2, #33
	stp	q0, q1, [x24, #32]
	cmp	w2, #32
	b.lo	632b
	ldp	q0, q1, [x21, #64]
	stp	q0, q1, [x24, #64]
	cmp	w2, #64
	b.lo	632b
	ldp	q0, q1, [x21, #96]
	stp	q0, q1, [x24, #96]
	cmp	w2, #96
	b.lo	632b
	ldp	q0, q1, [x21, #128]
	stp	q0, q1, [x24, #128]
	tbz	w2, #7, 632b
	ldp	q0, q1, [x21, #160]
	stp	q0, q1, [x24, #160]
	cmp	w2, #160
	b.lo	632b
	ldp	q0, q1, [x21, #192]
	stp	q0, q1, [x24, #192]
	cmp	w2, #192
	b.lo	632b
	ldp	q0, q1, [x21, #224]
	stp	q0, q1, [x24, #224]
	cmp	w2, #224
	b.lo	632b
	ldp	q0, q1, [x21, #256]
	stp	q0, q1, [x24, #256]
	b	632b
662:
	ldr	x3, [x0, #48]
	ldr	x6, [x0, #120]
	ldrb	w5, [x3, x6]
	add	x3, x6, #1
	str	x3, [x0, #120]
	ldp	q0, q1, [x4, #32]
	add	x3, x5, #33
	stp	q0, q1, [x2, #32]
	cmp	w5, #32
	b.lo	642b
	ldp	q0, q1, [x4, #64]
	stp	q0, q1, [x2, #64]
	cmp	w5, #64
	b.lo	642b
	ldp	q0, q1, [x4, #96]
	stp	q0, q1, [x2, #96]
	cmp	w5, #96
	b.lo	642b
	ldp	q0, q1, [x4, #128]
	stp	q0, q1, [x2, #128]
	tbz	w5, #7, 642b
	ldp	q0, q1, [x4, #160]
	stp	q0, q1, [x2, #160]
	cmp	w5, #160
	b.lo	642b
	ldp	q0, q1, [x4, #192]
	stp	q0, q1, [x2, #192]
	cmp	w5, #192
	b.lo	642b
	ldp	q0, q1, [x4, #224]
	stp	q0, q1, [x2, #224]
	cmp	w5, #224
	b.lo	642b
	ldp	q0, q1, [x4, #256]
	stp	q0, q1, [x2, #256]
	b	642b
672:
	sub	x8, x24, x8
	sub	x9, x21, x9
	str	x22, [x0, #96]
	ldp	x20, x19, [sp, #80]
	ldp	x22, x21, [sp, #64]
	ldp	x24, x23, [sp, #48]
	ldp	x26, x25, [sp, #32]
	ldp	x28, x27, [sp, #16]
	stp	x8, x9, [x0, #80]
	ldp	x29, x30, [sp], #96
682:
	ret

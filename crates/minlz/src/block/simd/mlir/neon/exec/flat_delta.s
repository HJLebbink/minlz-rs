// minlz_exec_flat_delta of crates/minlz/mlir/exec8.mlir for neon, written by
// cargo xtask mlir. Do not edit.
	ldr	x10, [x0, #64]
	mov	x16, #72340172838076673
	//APP
	//NO_APP
	cbz	x10, 862f
	stp	x29, x30, [sp, #-96]!
	stp	x24, x23, [sp, #48]
	ldp	x8, x9, [x0]
	ldp	x14, x17, [x0, #16]
	ldp	x23, x2, [x0, #72]
	stp	x26, x25, [sp, #32]
	ldp	x15, x24, [x0, #88]
	stp	x22, x21, [sp, #64]
	ldp	x1, x11, [x0, #32]
	ldr	x12, [x0, #56]
	add	x25, x8, x2
	ldr	x2, [x14]
	add	x22, x9, x15
	ldr	d0, [x17]
	ldr	x13, [x0, #120]
	stp	x28, x27, [sp, #16]
	stp	x20, x19, [sp, #80]
	and	x15, x16, x2, lsr #1
	bic	x3, x16, x2
	and	x2, x2, x16
	mul	x5, x15, x16
	sub	x4, x5, x15
	eor	x15, x15, x16
	orr	x15, x4, x15, lsl #7
	mul	x4, x3, x16
	fmov	d1, x15
	sub	x3, x4, x3
	orr	x2, x3, x2, lsl #7
	tbl	v0.8b, { v0.16b }, v1.8b
	fmov	d1, x2
	fmov	x15, d0
	ldr	d0, [x1]
	tbl	v0.8b, { v0.16b }, v1.8b
	fmov	x2, d0
	cmp	x10, #8
	b.lo	752f
	lsr	x4, x4, #56
	lsr	x5, x5, #56
	mov	w6, #32
	mov	x3, xzr
	mov	x7, x14
	.p2align	5, , 16
2:
	subs	x10, x10, #8
	b.ne	12f
	mov	x19, x15
	mov	x20, x2
	b	22f
	.p2align	5, , 16
12:
	ldr	x20, [x7, #8]
	ldr	d0, [x17, x5]
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
	ldr	d0, [x1, x4]
	add	x4, x4, x26, lsr #56
	tbl	v0.8b, { v0.16b }, v1.8b
	fmov	x20, d0
22:
	and	x21, x2, #0xff
	//APP
	//NO_APP
	ldr	x27, [x12, x21, lsl #3]
	lsr	x21, x23, #3
	and	x26, x23, #0x7
	ldr	x21, [x11, x21]
	lsr	x21, x21, x26
	and	w21, w21, w27, lsr #8
	adds	x21, x21, x27, lsr #32
	csel	x26, x24, x21, eq
	cmp	x24, #32
	csel	x21, x24, x6, hi
	sub	x24, x25, x21
	cmp	x24, x8
	b.lt	272f
32:
	ldp	q1, q0, [x22]
	ldp	q3, q2, [x24]
	ldr	x21, [x7]
	and	x28, x15, #0xff
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x25]
	cmp	x28, #33
	b.hs	282f
42:
	ubfx	x29, x21, #2, #6
	tst	x6, x21, lsr #2
	add	x25, x25, x28
	csel	x24, x29, x6, eq
	cmp	x26, x24
	csel	x30, x26, x24, hi
	sub	x24, x25, x30
	cmp	x24, x8
	b.lt	302f
	ldp	q0, q1, [x24]
	stp	q0, q1, [x25]
	cmp	x29, #33
	b.hs	312f
52:
	add	x24, x23, w27, uxtb
	add	x27, x25, x29
	add	x23, x22, x28
	ubfx	x22, x2, #8, #8
	//APP
	//NO_APP
	ldr	x25, [x12, x22, lsl #3]
	ldp	q1, q0, [x23]
	lsr	x22, x24, #3
	and	x28, x24, #0x7
	ldr	x22, [x11, x22]
	lsr	x22, x22, x28
	and	w22, w22, w25, lsr #8
	adds	x22, x22, x25, lsr #32
	csel	x22, x26, x22, eq
	cmp	x26, #32
	csel	x26, x26, x6, hi
	sub	x28, x27, x26
	cmp	x28, x8
	b.lt	332f
62:
	ldp	q3, q2, [x28]
	ubfx	x26, x15, #8, #8
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x27]
	cmp	x26, #33
	b.hs	342f
72:
	ubfx	x29, x21, #10, #6
	tst	x6, x21, lsr #10
	add	x27, x27, x26
	csel	x28, x29, x6, eq
	cmp	x22, x28
	csel	x30, x22, x28, hi
	sub	x28, x27, x30
	cmp	x28, x8
	b.lt	362f
	ldp	q0, q1, [x28]
	stp	q0, q1, [x27]
	cmp	x29, #33
	b.hs	372f
82:
	add	x25, x24, w25, uxtb
	add	x24, x23, x26
	ubfx	x23, x2, #16, #8
	//APP
	//NO_APP
	ldr	x26, [x12, x23, lsl #3]
	add	x27, x27, x29
	ldp	q1, q0, [x24]
	lsr	x23, x25, #3
	and	x28, x25, #0x7
	ldr	x23, [x11, x23]
	lsr	x23, x23, x28
	and	w23, w23, w26, lsr #8
	adds	x23, x23, x26, lsr #32
	csel	x23, x22, x23, eq
	cmp	x22, #32
	csel	x22, x22, x6, hi
	sub	x28, x27, x22
	cmp	x28, x8
	b.lt	392f
92:
	ldp	q3, q2, [x28]
	ubfx	x22, x15, #16, #8
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x27]
	cmp	x22, #33
	b.hs	402f
102:
	ubfx	x29, x21, #18, #6
	tst	x6, x21, lsr #18
	add	x27, x27, x22
	csel	x28, x29, x6, eq
	cmp	x23, x28
	csel	x30, x23, x28, hi
	sub	x28, x27, x30
	cmp	x28, x8
	b.lt	422f
	ldp	q0, q1, [x28]
	stp	q0, q1, [x27]
	cmp	x29, #33
	b.hs	432f
112:
	add	x25, x25, w26, uxtb
	add	x24, x24, x22
	lsr	w22, w2, #24
	//APP
	//NO_APP
	ldr	x26, [x12, x22, lsl #3]
	add	x27, x27, x29
	ldp	q1, q0, [x24]
	lsr	x22, x25, #3
	and	x28, x25, #0x7
	ldr	x22, [x11, x22]
	lsr	x22, x22, x28
	and	w22, w22, w26, lsr #8
	adds	x22, x22, x26, lsr #32
	csel	x22, x23, x22, eq
	cmp	x23, #32
	csel	x23, x23, x6, hi
	sub	x28, x27, x23
	cmp	x28, x8
	b.lt	452f
122:
	ldp	q3, q2, [x28]
	lsr	w23, w15, #24
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x27]
	cmp	x23, #33
	b.hs	462f
132:
	lsr	w29, w21, #26
	tst	x6, x21, lsr #26
	add	x27, x27, x23
	csel	x28, x29, x6, eq
	cmp	x22, x28
	csel	x30, x22, x28, hi
	sub	x28, x27, x30
	cmp	x28, x8
	b.lt	482f
	ldp	q0, q1, [x28]
	stp	q0, q1, [x27]
	cmp	x29, #33
	b.hs	492f
142:
	add	x25, x25, w26, uxtb
	add	x24, x24, x23
	ubfx	x23, x2, #32, #8
	//APP
	//NO_APP
	ldr	x26, [x12, x23, lsl #3]
	add	x27, x27, x29
	ldp	q1, q0, [x24]
	lsr	x23, x25, #3
	and	x28, x25, #0x7
	ldr	x23, [x11, x23]
	lsr	x23, x23, x28
	and	w23, w23, w26, lsr #8
	adds	x23, x23, x26, lsr #32
	csel	x23, x22, x23, eq
	cmp	x22, #32
	csel	x22, x22, x6, hi
	sub	x28, x27, x22
	cmp	x28, x8
	b.lt	512f
152:
	ldp	q3, q2, [x28]
	ubfx	x22, x15, #32, #8
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x27]
	cmp	x22, #33
	b.hs	522f
162:
	ubfx	x29, x21, #34, #6
	tst	x6, x21, lsr #34
	add	x27, x27, x22
	csel	x28, x29, x6, eq
	cmp	x23, x28
	csel	x30, x23, x28, hi
	sub	x28, x27, x30
	cmp	x28, x8
	b.lt	542f
	ldp	q0, q1, [x28]
	stp	q0, q1, [x27]
	cmp	x29, #33
	b.hs	552f
172:
	add	x25, x25, w26, uxtb
	add	x24, x24, x22
	ubfx	x22, x2, #40, #8
	//APP
	//NO_APP
	ldr	x26, [x12, x22, lsl #3]
	add	x27, x27, x29
	ldp	q1, q0, [x24]
	lsr	x22, x25, #3
	and	x28, x25, #0x7
	ldr	x22, [x11, x22]
	lsr	x22, x22, x28
	and	w22, w22, w26, lsr #8
	adds	x22, x22, x26, lsr #32
	csel	x22, x23, x22, eq
	cmp	x23, #32
	csel	x23, x23, x6, hi
	sub	x28, x27, x23
	cmp	x28, x8
	b.lt	572f
182:
	ldp	q3, q2, [x28]
	ubfx	x23, x15, #40, #8
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x27]
	cmp	x23, #33
	b.hs	582f
192:
	ubfx	x29, x21, #42, #6
	tst	x6, x21, lsr #42
	add	x27, x27, x23
	csel	x28, x29, x6, eq
	cmp	x22, x28
	csel	x30, x22, x28, hi
	sub	x28, x27, x30
	cmp	x28, x8
	b.lt	602f
	ldp	q0, q1, [x28]
	stp	q0, q1, [x27]
	cmp	x29, #33
	b.hs	612f
202:
	add	x25, x25, w26, uxtb
	add	x24, x24, x23
	ubfx	x23, x2, #48, #8
	//APP
	//NO_APP
	ldr	x26, [x12, x23, lsl #3]
	add	x27, x27, x29
	ldp	q1, q0, [x24]
	lsr	x23, x25, #3
	and	x28, x25, #0x7
	ldr	x23, [x11, x23]
	lsr	x23, x23, x28
	and	w23, w23, w26, lsr #8
	adds	x23, x23, x26, lsr #32
	csel	x23, x22, x23, eq
	cmp	x22, #32
	csel	x22, x22, x6, hi
	sub	x28, x27, x22
	cmp	x28, x8
	b.lt	632f
212:
	ldp	q3, q2, [x28]
	ubfx	x22, x15, #48, #8
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x27]
	cmp	x22, #33
	b.hs	642f
222:
	ubfx	x29, x21, #50, #6
	tst	x6, x21, lsr #50
	add	x27, x27, x22
	csel	x28, x29, x6, eq
	cmp	x23, x28
	csel	x30, x23, x28, hi
	sub	x28, x27, x30
	cmp	x28, x8
	b.lt	662f
	ldp	q0, q1, [x28]
	stp	q0, q1, [x27]
	cmp	x29, #33
	b.hs	672f
232:
	add	x25, x25, w26, uxtb
	add	x22, x24, x22
	lsr	x2, x2, #56
	//APP
	//NO_APP
	ldr	x2, [x12, x2, lsl #3]
	add	x26, x27, x29
	ldp	q1, q0, [x22]
	lsr	x24, x25, #3
	and	x27, x25, #0x7
	ldr	x24, [x11, x24]
	lsr	x24, x24, x27
	and	w24, w24, w2, lsr #8
	adds	x24, x24, x2, lsr #32
	csel	x24, x23, x24, eq
	cmp	x23, #32
	csel	x27, x23, x6, hi
	sub	x23, x26, x27
	cmp	x23, x8
	b.lt	692f
242:
	ldp	q3, q2, [x23]
	lsr	x15, x15, #56
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x26]
	cmp	x15, #33
	b.hs	702f
252:
	lsr	x27, x21, #58
	add	x26, x26, x15
	cmp	x27, #32
	csel	x21, x27, x6, lo
	cmp	x24, x21
	csel	x23, x24, x21, hi
	sub	x21, x26, x23
	cmp	x21, x8
	b.lt	722f
	ldp	q0, q1, [x21]
	stp	q0, q1, [x26]
	cmp	x27, #33
	b.hs	732f
262:
	add	x23, x25, w2, uxtb
	add	x25, x26, x27
	add	x22, x22, x15
	sub	x3, x3, #8
	add	x7, x7, #8
	mov	x2, x20
	mov	x15, x19
	cmp	x10, #7
	b.hi	2b
	b	762f
272:
	sub	x24, x25, x8
	subs	x21, x24, x21
	csel	x21, xzr, x21, lo
	add	x24, x8, x21
	b	32b
282:
	ldr	x24, [x0, #48]
	ldp	q0, q1, [x22, #32]
	ldrb	w24, [x24, x13]
	stp	q0, q1, [x25, #32]
	cmp	w24, #32
	b.lo	292f
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x25, #64]
	cmp	w24, #64
	b.lo	292f
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x25, #96]
	cmp	w24, #96
	b.lo	292f
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x25, #128]
	tbz	w24, #7, 292f
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x25, #160]
	cmp	w24, #160
	b.lo	292f
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x25, #192]
	cmp	w24, #192
	b.lo	292f
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x25, #224]
	cmp	w24, #224
	b.lo	292f
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x25, #256]
292:
	add	x28, x24, #33
	add	x13, x13, #1
	b	42b
302:
	sub	x24, x25, x8
	subs	x24, x24, x30
	csel	x24, xzr, x24, lo
	add	x24, x8, x24
	ldp	q0, q1, [x24]
	stp	q0, q1, [x25]
	cmp	x29, #33
	b.lo	52b
312:
	ldr	x29, [x0, #48]
	ldp	q0, q1, [x24, #32]
	ldrb	w29, [x29, x13]
	stp	q0, q1, [x25, #32]
	cmp	w29, #32
	b.lo	322f
	ldp	q0, q1, [x24, #64]
	stp	q0, q1, [x25, #64]
	cmp	w29, #64
	b.lo	322f
	ldp	q0, q1, [x24, #96]
	stp	q0, q1, [x25, #96]
	cmp	w29, #96
	b.lo	322f
	ldp	q0, q1, [x24, #128]
	stp	q0, q1, [x25, #128]
	tbz	w29, #7, 322f
	ldp	q0, q1, [x24, #160]
	stp	q0, q1, [x25, #160]
	cmp	w29, #160
	b.lo	322f
	ldp	q0, q1, [x24, #192]
	stp	q0, q1, [x25, #192]
	cmp	w29, #192
	b.lo	322f
	ldp	q0, q1, [x24, #224]
	stp	q0, q1, [x25, #224]
	cmp	w29, #224
	b.lo	322f
	ldp	q0, q1, [x24, #256]
	stp	q0, q1, [x25, #256]
322:
	add	x29, x29, #33
	add	x13, x13, #1
	b	52b
332:
	sub	x28, x27, x8
	subs	x26, x28, x26
	csel	x26, xzr, x26, lo
	add	x28, x8, x26
	b	62b
342:
	ldr	x26, [x0, #48]
	ldp	q0, q1, [x23, #32]
	ldrb	w26, [x26, x13]
	stp	q0, q1, [x27, #32]
	cmp	w26, #32
	b.lo	352f
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x27, #64]
	cmp	w26, #64
	b.lo	352f
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x27, #96]
	cmp	w26, #96
	b.lo	352f
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x27, #128]
	tbz	w26, #7, 352f
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x27, #160]
	cmp	w26, #160
	b.lo	352f
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x27, #192]
	cmp	w26, #192
	b.lo	352f
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x27, #224]
	cmp	w26, #224
	b.lo	352f
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x27, #256]
352:
	add	x26, x26, #33
	add	x13, x13, #1
	b	72b
362:
	sub	x28, x27, x8
	subs	x28, x28, x30
	csel	x28, xzr, x28, lo
	add	x28, x8, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x27]
	cmp	x29, #33
	b.lo	82b
372:
	ldr	x29, [x0, #48]
	ldp	q0, q1, [x28, #32]
	ldrb	w29, [x29, x13]
	stp	q0, q1, [x27, #32]
	cmp	w29, #32
	b.lo	382f
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x27, #64]
	cmp	w29, #64
	b.lo	382f
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x27, #96]
	cmp	w29, #96
	b.lo	382f
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x27, #128]
	tbz	w29, #7, 382f
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x27, #160]
	cmp	w29, #160
	b.lo	382f
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x27, #192]
	cmp	w29, #192
	b.lo	382f
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x27, #224]
	cmp	w29, #224
	b.lo	382f
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x27, #256]
382:
	add	x29, x29, #33
	add	x13, x13, #1
	b	82b
392:
	sub	x28, x27, x8
	subs	x22, x28, x22
	csel	x22, xzr, x22, lo
	add	x28, x8, x22
	b	92b
402:
	ldr	x22, [x0, #48]
	ldp	q0, q1, [x24, #32]
	ldrb	w22, [x22, x13]
	stp	q0, q1, [x27, #32]
	cmp	w22, #32
	b.lo	412f
	ldp	q0, q1, [x24, #64]
	stp	q0, q1, [x27, #64]
	cmp	w22, #64
	b.lo	412f
	ldp	q0, q1, [x24, #96]
	stp	q0, q1, [x27, #96]
	cmp	w22, #96
	b.lo	412f
	ldp	q0, q1, [x24, #128]
	stp	q0, q1, [x27, #128]
	tbz	w22, #7, 412f
	ldp	q0, q1, [x24, #160]
	stp	q0, q1, [x27, #160]
	cmp	w22, #160
	b.lo	412f
	ldp	q0, q1, [x24, #192]
	stp	q0, q1, [x27, #192]
	cmp	w22, #192
	b.lo	412f
	ldp	q0, q1, [x24, #224]
	stp	q0, q1, [x27, #224]
	cmp	w22, #224
	b.lo	412f
	ldp	q0, q1, [x24, #256]
	stp	q0, q1, [x27, #256]
412:
	add	x22, x22, #33
	add	x13, x13, #1
	b	102b
422:
	sub	x28, x27, x8
	subs	x28, x28, x30
	csel	x28, xzr, x28, lo
	add	x28, x8, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x27]
	cmp	x29, #33
	b.lo	112b
432:
	ldr	x29, [x0, #48]
	ldp	q0, q1, [x28, #32]
	ldrb	w29, [x29, x13]
	stp	q0, q1, [x27, #32]
	cmp	w29, #32
	b.lo	442f
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x27, #64]
	cmp	w29, #64
	b.lo	442f
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x27, #96]
	cmp	w29, #96
	b.lo	442f
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x27, #128]
	tbz	w29, #7, 442f
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x27, #160]
	cmp	w29, #160
	b.lo	442f
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x27, #192]
	cmp	w29, #192
	b.lo	442f
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x27, #224]
	cmp	w29, #224
	b.lo	442f
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x27, #256]
442:
	add	x29, x29, #33
	add	x13, x13, #1
	b	112b
452:
	sub	x28, x27, x8
	subs	x23, x28, x23
	csel	x23, xzr, x23, lo
	add	x28, x8, x23
	b	122b
462:
	ldr	x23, [x0, #48]
	ldp	q0, q1, [x24, #32]
	ldrb	w23, [x23, x13]
	stp	q0, q1, [x27, #32]
	cmp	w23, #32
	b.lo	472f
	ldp	q0, q1, [x24, #64]
	stp	q0, q1, [x27, #64]
	cmp	w23, #64
	b.lo	472f
	ldp	q0, q1, [x24, #96]
	stp	q0, q1, [x27, #96]
	cmp	w23, #96
	b.lo	472f
	ldp	q0, q1, [x24, #128]
	stp	q0, q1, [x27, #128]
	tbz	w23, #7, 472f
	ldp	q0, q1, [x24, #160]
	stp	q0, q1, [x27, #160]
	cmp	w23, #160
	b.lo	472f
	ldp	q0, q1, [x24, #192]
	stp	q0, q1, [x27, #192]
	cmp	w23, #192
	b.lo	472f
	ldp	q0, q1, [x24, #224]
	stp	q0, q1, [x27, #224]
	cmp	w23, #224
	b.lo	472f
	ldp	q0, q1, [x24, #256]
	stp	q0, q1, [x27, #256]
472:
	add	x23, x23, #33
	add	x13, x13, #1
	b	132b
482:
	sub	x28, x27, x8
	subs	x28, x28, x30
	csel	x28, xzr, x28, lo
	add	x28, x8, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x27]
	cmp	x29, #33
	b.lo	142b
492:
	ldr	x29, [x0, #48]
	ldp	q0, q1, [x28, #32]
	ldrb	w29, [x29, x13]
	stp	q0, q1, [x27, #32]
	cmp	w29, #32
	b.lo	502f
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x27, #64]
	cmp	w29, #64
	b.lo	502f
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x27, #96]
	cmp	w29, #96
	b.lo	502f
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x27, #128]
	tbz	w29, #7, 502f
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x27, #160]
	cmp	w29, #160
	b.lo	502f
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x27, #192]
	cmp	w29, #192
	b.lo	502f
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x27, #224]
	cmp	w29, #224
	b.lo	502f
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x27, #256]
502:
	add	x29, x29, #33
	add	x13, x13, #1
	b	142b
512:
	sub	x28, x27, x8
	subs	x22, x28, x22
	csel	x22, xzr, x22, lo
	add	x28, x8, x22
	b	152b
522:
	ldr	x22, [x0, #48]
	ldp	q0, q1, [x24, #32]
	ldrb	w22, [x22, x13]
	stp	q0, q1, [x27, #32]
	cmp	w22, #32
	b.lo	532f
	ldp	q0, q1, [x24, #64]
	stp	q0, q1, [x27, #64]
	cmp	w22, #64
	b.lo	532f
	ldp	q0, q1, [x24, #96]
	stp	q0, q1, [x27, #96]
	cmp	w22, #96
	b.lo	532f
	ldp	q0, q1, [x24, #128]
	stp	q0, q1, [x27, #128]
	tbz	w22, #7, 532f
	ldp	q0, q1, [x24, #160]
	stp	q0, q1, [x27, #160]
	cmp	w22, #160
	b.lo	532f
	ldp	q0, q1, [x24, #192]
	stp	q0, q1, [x27, #192]
	cmp	w22, #192
	b.lo	532f
	ldp	q0, q1, [x24, #224]
	stp	q0, q1, [x27, #224]
	cmp	w22, #224
	b.lo	532f
	ldp	q0, q1, [x24, #256]
	stp	q0, q1, [x27, #256]
532:
	add	x22, x22, #33
	add	x13, x13, #1
	b	162b
542:
	sub	x28, x27, x8
	subs	x28, x28, x30
	csel	x28, xzr, x28, lo
	add	x28, x8, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x27]
	cmp	x29, #33
	b.lo	172b
552:
	ldr	x29, [x0, #48]
	ldp	q0, q1, [x28, #32]
	ldrb	w29, [x29, x13]
	stp	q0, q1, [x27, #32]
	cmp	w29, #32
	b.lo	562f
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x27, #64]
	cmp	w29, #64
	b.lo	562f
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x27, #96]
	cmp	w29, #96
	b.lo	562f
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x27, #128]
	tbz	w29, #7, 562f
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x27, #160]
	cmp	w29, #160
	b.lo	562f
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x27, #192]
	cmp	w29, #192
	b.lo	562f
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x27, #224]
	cmp	w29, #224
	b.lo	562f
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x27, #256]
562:
	add	x29, x29, #33
	add	x13, x13, #1
	b	172b
572:
	sub	x28, x27, x8
	subs	x23, x28, x23
	csel	x23, xzr, x23, lo
	add	x28, x8, x23
	b	182b
582:
	ldr	x23, [x0, #48]
	ldp	q0, q1, [x24, #32]
	ldrb	w23, [x23, x13]
	stp	q0, q1, [x27, #32]
	cmp	w23, #32
	b.lo	592f
	ldp	q0, q1, [x24, #64]
	stp	q0, q1, [x27, #64]
	cmp	w23, #64
	b.lo	592f
	ldp	q0, q1, [x24, #96]
	stp	q0, q1, [x27, #96]
	cmp	w23, #96
	b.lo	592f
	ldp	q0, q1, [x24, #128]
	stp	q0, q1, [x27, #128]
	tbz	w23, #7, 592f
	ldp	q0, q1, [x24, #160]
	stp	q0, q1, [x27, #160]
	cmp	w23, #160
	b.lo	592f
	ldp	q0, q1, [x24, #192]
	stp	q0, q1, [x27, #192]
	cmp	w23, #192
	b.lo	592f
	ldp	q0, q1, [x24, #224]
	stp	q0, q1, [x27, #224]
	cmp	w23, #224
	b.lo	592f
	ldp	q0, q1, [x24, #256]
	stp	q0, q1, [x27, #256]
592:
	add	x23, x23, #33
	add	x13, x13, #1
	b	192b
602:
	sub	x28, x27, x8
	subs	x28, x28, x30
	csel	x28, xzr, x28, lo
	add	x28, x8, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x27]
	cmp	x29, #33
	b.lo	202b
612:
	ldr	x29, [x0, #48]
	ldp	q0, q1, [x28, #32]
	ldrb	w29, [x29, x13]
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
	sub	x28, x27, x8
	subs	x22, x28, x22
	csel	x22, xzr, x22, lo
	add	x28, x8, x22
	b	212b
642:
	ldr	x22, [x0, #48]
	ldp	q0, q1, [x24, #32]
	ldrb	w22, [x22, x13]
	stp	q0, q1, [x27, #32]
	cmp	w22, #32
	b.lo	652f
	ldp	q0, q1, [x24, #64]
	stp	q0, q1, [x27, #64]
	cmp	w22, #64
	b.lo	652f
	ldp	q0, q1, [x24, #96]
	stp	q0, q1, [x27, #96]
	cmp	w22, #96
	b.lo	652f
	ldp	q0, q1, [x24, #128]
	stp	q0, q1, [x27, #128]
	tbz	w22, #7, 652f
	ldp	q0, q1, [x24, #160]
	stp	q0, q1, [x27, #160]
	cmp	w22, #160
	b.lo	652f
	ldp	q0, q1, [x24, #192]
	stp	q0, q1, [x27, #192]
	cmp	w22, #192
	b.lo	652f
	ldp	q0, q1, [x24, #224]
	stp	q0, q1, [x27, #224]
	cmp	w22, #224
	b.lo	652f
	ldp	q0, q1, [x24, #256]
	stp	q0, q1, [x27, #256]
652:
	add	x22, x22, #33
	add	x13, x13, #1
	b	222b
662:
	sub	x28, x27, x8
	subs	x28, x28, x30
	csel	x28, xzr, x28, lo
	add	x28, x8, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x27]
	cmp	x29, #33
	b.lo	232b
672:
	ldr	x29, [x0, #48]
	ldp	q0, q1, [x28, #32]
	ldrb	w29, [x29, x13]
	stp	q0, q1, [x27, #32]
	cmp	w29, #32
	b.lo	682f
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x27, #64]
	cmp	w29, #64
	b.lo	682f
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x27, #96]
	cmp	w29, #96
	b.lo	682f
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x27, #128]
	tbz	w29, #7, 682f
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x27, #160]
	cmp	w29, #160
	b.lo	682f
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x27, #192]
	cmp	w29, #192
	b.lo	682f
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x27, #224]
	cmp	w29, #224
	b.lo	682f
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x27, #256]
682:
	add	x29, x29, #33
	add	x13, x13, #1
	b	232b
692:
	sub	x23, x26, x8
	subs	x23, x23, x27
	csel	x23, xzr, x23, lo
	add	x23, x8, x23
	b	242b
702:
	ldr	x15, [x0, #48]
	ldp	q0, q1, [x22, #32]
	ldrb	w15, [x15, x13]
	stp	q0, q1, [x26, #32]
	cmp	w15, #32
	b.lo	712f
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x26, #64]
	cmp	w15, #64
	b.lo	712f
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x26, #96]
	cmp	w15, #96
	b.lo	712f
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x26, #128]
	tbz	w15, #7, 712f
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x26, #160]
	cmp	w15, #160
	b.lo	712f
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x26, #192]
	cmp	w15, #192
	b.lo	712f
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x26, #224]
	cmp	w15, #224
	b.lo	712f
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x26, #256]
712:
	add	x15, x15, #33
	add	x13, x13, #1
	b	252b
722:
	sub	x21, x26, x8
	subs	x21, x21, x23
	csel	x21, xzr, x21, lo
	add	x21, x8, x21
	ldp	q0, q1, [x21]
	stp	q0, q1, [x26]
	cmp	x27, #33
	b.lo	262b
732:
	ldr	x23, [x0, #48]
	ldp	q0, q1, [x21, #32]
	ldrb	w23, [x23, x13]
	stp	q0, q1, [x26, #32]
	cmp	w23, #32
	b.lo	742f
	ldp	q0, q1, [x21, #64]
	stp	q0, q1, [x26, #64]
	cmp	w23, #64
	b.lo	742f
	ldp	q0, q1, [x21, #96]
	stp	q0, q1, [x26, #96]
	cmp	w23, #96
	b.lo	742f
	ldp	q0, q1, [x21, #128]
	stp	q0, q1, [x26, #128]
	tbz	w23, #7, 742f
	ldp	q0, q1, [x21, #160]
	stp	q0, q1, [x26, #160]
	cmp	w23, #160
	b.lo	742f
	ldp	q0, q1, [x21, #192]
	stp	q0, q1, [x26, #192]
	cmp	w23, #192
	b.lo	742f
	ldp	q0, q1, [x21, #224]
	stp	q0, q1, [x26, #224]
	cmp	w23, #224
	b.lo	742f
	ldp	q0, q1, [x21, #256]
	stp	q0, q1, [x26, #256]
742:
	add	x27, x23, #33
	add	x13, x13, #1
	b	262b
752:
	mov	x16, xzr
	b	772f
762:
	cbz	x10, 852f
	neg	x16, x3
	mov	x2, x20
	mov	x15, x19
772:
	ldr	x14, [x14, x16]
	mov	w16, #32
	mov	x3, x24
	.p2align	5, , 16
782:
	lsr	x4, x23, #3
	and	x17, x2, #0xff
	//APP
	//NO_APP
	ldr	x17, [x12, x17, lsl #3]
	and	x5, x23, #0x7
	and	x1, x15, #0xff
	ldr	x4, [x11, x4]
	ldp	q1, q0, [x22]
	lsr	x4, x4, x5
	sub	x5, x25, x8
	and	w4, w4, w17, lsr #8
	adds	x4, x4, x17, lsr #32
	csel	x24, x3, x4, eq
	cmp	x3, #32
	csel	x3, x3, x16, hi
	sub	x4, x25, x3
	subs	x3, x5, x3
	csel	x3, xzr, x3, lo
	add	x3, x8, x3
	cmp	x4, x8
	csel	x3, x4, x3, ge
	ldp	q3, q2, [x3]
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x25]
	cmp	x1, #33
	b.hs	812f
792:
	ubfx	x5, x14, #2, #6
	tst	x16, x14, lsr #2
	add	x3, x25, x1
	csel	x4, x5, x16, eq
	sub	x7, x3, x8
	cmp	x24, x4
	csel	x4, x24, x4, hi
	sub	x6, x3, x4
	subs	x4, x7, x4
	csel	x4, xzr, x4, lo
	add	x4, x8, x4
	cmp	x6, x8
	csel	x4, x6, x4, ge
	ldp	q0, q1, [x4]
	stp	q0, q1, [x3]
	cmp	x5, #33
	b.hs	832f
802:
	add	x23, x23, w17, uxtb
	add	x25, x3, x5
	add	x22, x22, x1
	subs	x10, x10, #1
	lsr	x14, x14, #8
	lsr	x15, x15, #8
	lsr	x2, x2, #8
	mov	x3, x24
	b.ne	782b
	b	852f
812:
	ldr	x1, [x0, #48]
	ldp	q0, q1, [x22, #32]
	ldrb	w1, [x1, x13]
	stp	q0, q1, [x25, #32]
	cmp	w1, #32
	b.lo	822f
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x25, #64]
	cmp	w1, #64
	b.lo	822f
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x25, #96]
	cmp	w1, #96
	b.lo	822f
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x25, #128]
	tbz	w1, #7, 822f
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x25, #160]
	cmp	w1, #160
	b.lo	822f
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x25, #192]
	cmp	w1, #192
	b.lo	822f
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x25, #224]
	cmp	w1, #224
	b.lo	822f
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x25, #256]
822:
	add	x1, x1, #33
	add	x13, x13, #1
	b	792b
832:
	ldr	x5, [x0, #48]
	ldp	q0, q1, [x4, #32]
	ldrb	w5, [x5, x13]
	stp	q0, q1, [x3, #32]
	cmp	w5, #32
	b.lo	842f
	ldp	q0, q1, [x4, #64]
	stp	q0, q1, [x3, #64]
	cmp	w5, #64
	b.lo	842f
	ldp	q0, q1, [x4, #96]
	stp	q0, q1, [x3, #96]
	cmp	w5, #96
	b.lo	842f
	ldp	q0, q1, [x4, #128]
	stp	q0, q1, [x3, #128]
	tbz	w5, #7, 842f
	ldp	q0, q1, [x4, #160]
	stp	q0, q1, [x3, #160]
	cmp	w5, #160
	b.lo	842f
	ldp	q0, q1, [x4, #192]
	stp	q0, q1, [x3, #192]
	cmp	w5, #192
	b.lo	842f
	ldp	q0, q1, [x4, #224]
	stp	q0, q1, [x3, #224]
	cmp	w5, #224
	b.lo	842f
	ldp	q0, q1, [x4, #256]
	stp	q0, q1, [x3, #256]
842:
	add	x5, x5, #33
	add	x13, x13, #1
	b	802b
852:
	sub	x8, x25, x8
	sub	x9, x22, x9
	str	x24, [x0, #96]
	ldp	x20, x19, [sp, #80]
	ldp	x22, x21, [sp, #64]
	ldp	x24, x23, [sp, #48]
	ldp	x26, x25, [sp, #32]
	ldp	x28, x27, [sp, #16]
	stp	x8, x9, [x0, #80]
	ldp	x29, x30, [sp], #96
862:
	ret

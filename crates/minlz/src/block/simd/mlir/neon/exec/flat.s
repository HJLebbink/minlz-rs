// minlz_exec_flat of crates/minlz/mlir/exec8.mlir for neon, written by
// cargo xtask mlir. Do not edit.
	ldr	x10, [x0, #64]
	mov	x15, #72340172838076673
	//APP
	//NO_APP
	cbz	x10, 702f
	stp	x29, x30, [sp, #-96]!
	stp	x24, x23, [sp, #48]
	ldp	x8, x9, [x0]
	ldp	x14, x1, [x0, #16]
	ldp	x24, x17, [x0, #72]
	stp	x26, x25, [sp, #32]
	stp	x22, x21, [sp, #64]
	ldp	x16, x22, [x0, #88]
	ldp	x2, x11, [x0, #32]
	ldr	x12, [x0, #56]
	add	x25, x8, x17
	ldr	x17, [x14]
	add	x23, x9, x16
	ldr	d0, [x1]
	ldr	x13, [x0, #120]
	stp	x28, x27, [sp, #16]
	stp	x20, x19, [sp, #80]
	and	x16, x15, x17, lsr #1
	bic	x3, x15, x17
	and	x17, x17, x15
	mul	x5, x16, x15
	sub	x4, x5, x16
	eor	x16, x16, x15
	orr	x16, x4, x16, lsl #7
	mul	x4, x3, x15
	fmov	d1, x16
	sub	x3, x4, x3
	orr	x17, x3, x17, lsl #7
	tbl	v0.8b, { v0.16b }, v1.8b
	fmov	d1, x17
	fmov	x16, d0
	ldr	d0, [x2]
	tbl	v0.8b, { v0.16b }, v1.8b
	fmov	x17, d0
	cmp	x10, #8
	b.lo	592f
	lsr	x4, x4, #56
	lsr	x5, x5, #56
	mov	w6, #32
	mov	x3, xzr
	mov	x7, x14
	.p2align	5, , 16
2:
	subs	x10, x10, #8
	b.ne	12f
	mov	x19, x16
	mov	x20, x17
	b	22f
	.p2align	5, , 16
12:
	ldr	x20, [x7, #8]
	ldr	d0, [x1, x5]
	and	x19, x15, x20, lsr #1
	bic	x21, x15, x20
	and	x20, x20, x15
	mul	x26, x19, x15
	sub	x27, x26, x19
	eor	x19, x19, x15
	add	x5, x5, x26, lsr #56
	mul	x26, x21, x15
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
	and	x28, x16, #0xff
	lsr	x26, x26, x29
	and	w26, w26, w27, lsr #8
	stp	q0, q1, [x25]
	adds	x26, x26, x27, lsr #32
	csel	x26, x22, x26, eq
	cmp	x28, #33
	b.hs	192f
32:
	ubfx	x29, x21, #2, #6
	tst	x6, x21, lsr #2
	add	x22, x25, x28
	csel	x25, x29, x6, eq
	cmp	x26, x25
	csel	x30, x26, x25, hi
	sub	x25, x22, x30
	cmp	x25, x8
	b.lt	212f
	ldp	q0, q1, [x25]
	stp	q0, q1, [x22]
	cmp	x29, #33
	b.hs	222f
42:
	add	x24, x24, w27, uxtb
	add	x29, x22, x29
	add	x22, x23, x28
	ubfx	x23, x17, #8, #8
	//APP
	//NO_APP
	ldr	x25, [x12, x23, lsl #3]
	ldp	q0, q1, [x22]
	ubfx	x27, x16, #8, #8
	lsr	x23, x24, #3
	and	x28, x24, #0x7
	ldr	x23, [x11, x23]
	lsr	x23, x23, x28
	stp	q0, q1, [x29]
	and	w23, w23, w25, lsr #8
	adds	x23, x23, x25, lsr #32
	csel	x23, x26, x23, eq
	cmp	x27, #33
	b.hs	242f
52:
	add	x26, x29, x27
	ubfx	x29, x21, #10, #6
	tst	x6, x21, lsr #10
	csel	x28, x29, x6, eq
	cmp	x23, x28
	csel	x30, x23, x28, hi
	sub	x28, x26, x30
	cmp	x28, x8
	b.lt	262f
	ldp	q0, q1, [x28]
	stp	q0, q1, [x26]
	cmp	x29, #33
	b.hs	272f
62:
	add	x25, x24, w25, uxtb
	add	x28, x26, x29
	ubfx	x24, x17, #16, #8
	//APP
	//NO_APP
	ldr	x26, [x12, x24, lsl #3]
	add	x22, x22, x27
	ldp	q0, q1, [x22]
	ubfx	x27, x16, #16, #8
	lsr	x24, x25, #3
	and	x29, x25, #0x7
	ldr	x24, [x11, x24]
	lsr	x24, x24, x29
	stp	q0, q1, [x28]
	and	w24, w24, w26, lsr #8
	adds	x24, x24, x26, lsr #32
	csel	x24, x23, x24, eq
	cmp	x27, #33
	b.hs	292f
72:
	ubfx	x29, x21, #18, #6
	tst	x6, x21, lsr #18
	add	x28, x28, x27
	csel	x23, x29, x6, eq
	cmp	x24, x23
	csel	x30, x24, x23, hi
	sub	x23, x28, x30
	cmp	x23, x8
	b.lt	312f
	ldp	q0, q1, [x23]
	stp	q0, q1, [x28]
	cmp	x29, #33
	b.hs	322f
82:
	add	x23, x25, w26, uxtb
	add	x22, x22, x27
	lsr	w25, w17, #24
	//APP
	//NO_APP
	ldr	x25, [x12, x25, lsl #3]
	add	x28, x28, x29
	ldp	q0, q1, [x22]
	lsr	w26, w16, #24
	lsr	x27, x23, #3
	and	x29, x23, #0x7
	ldr	x27, [x11, x27]
	lsr	x27, x27, x29
	stp	q0, q1, [x28]
	and	w27, w27, w25, lsr #8
	adds	x27, x27, x25, lsr #32
	csel	x24, x24, x27, eq
	cmp	x26, #33
	b.hs	342f
92:
	lsr	w29, w21, #26
	tst	x6, x21, lsr #26
	add	x27, x28, x26
	csel	x28, x29, x6, eq
	cmp	x24, x28
	csel	x30, x24, x28, hi
	sub	x28, x27, x30
	cmp	x28, x8
	b.lt	362f
	ldp	q0, q1, [x28]
	stp	q0, q1, [x27]
	cmp	x29, #33
	b.hs	372f
102:
	add	x23, x23, w25, uxtb
	ubfx	x25, x17, #32, #8
	//APP
	//NO_APP
	ldr	x25, [x12, x25, lsl #3]
	add	x22, x22, x26
	add	x27, x27, x29
	ldp	q0, q1, [x22]
	ubfx	x26, x16, #32, #8
	lsr	x28, x23, #3
	and	x29, x23, #0x7
	ldr	x28, [x11, x28]
	lsr	x28, x28, x29
	stp	q0, q1, [x27]
	and	w28, w28, w25, lsr #8
	adds	x28, x28, x25, lsr #32
	csel	x24, x24, x28, eq
	cmp	x26, #33
	b.hs	392f
112:
	ubfx	x29, x21, #34, #6
	tst	x6, x21, lsr #34
	add	x27, x27, x26
	csel	x28, x29, x6, eq
	cmp	x24, x28
	csel	x30, x24, x28, hi
	sub	x28, x27, x30
	cmp	x28, x8
	b.lt	412f
	ldp	q0, q1, [x28]
	stp	q0, q1, [x27]
	cmp	x29, #33
	b.hs	422f
122:
	add	x23, x23, w25, uxtb
	ubfx	x25, x17, #40, #8
	//APP
	//NO_APP
	ldr	x25, [x12, x25, lsl #3]
	add	x22, x22, x26
	add	x27, x27, x29
	ldp	q0, q1, [x22]
	ubfx	x26, x16, #40, #8
	lsr	x28, x23, #3
	and	x29, x23, #0x7
	ldr	x28, [x11, x28]
	lsr	x28, x28, x29
	stp	q0, q1, [x27]
	and	w28, w28, w25, lsr #8
	adds	x28, x28, x25, lsr #32
	csel	x24, x24, x28, eq
	cmp	x26, #33
	b.hs	442f
132:
	ubfx	x29, x21, #42, #6
	tst	x6, x21, lsr #42
	add	x27, x27, x26
	csel	x28, x29, x6, eq
	cmp	x24, x28
	csel	x30, x24, x28, hi
	sub	x28, x27, x30
	cmp	x28, x8
	b.lt	462f
	ldp	q0, q1, [x28]
	stp	q0, q1, [x27]
	cmp	x29, #33
	b.hs	472f
142:
	add	x23, x23, w25, uxtb
	add	x22, x22, x26
	ubfx	x25, x17, #48, #8
	//APP
	//NO_APP
	ldr	x26, [x12, x25, lsl #3]
	add	x28, x27, x29
	ldp	q0, q1, [x22]
	ubfx	x27, x16, #48, #8
	lsr	x25, x23, #3
	and	x29, x23, #0x7
	ldr	x25, [x11, x25]
	lsr	x25, x25, x29
	stp	q0, q1, [x28]
	and	w25, w25, w26, lsr #8
	adds	x25, x25, x26, lsr #32
	csel	x25, x24, x25, eq
	cmp	x27, #33
	b.hs	492f
152:
	ubfx	x29, x21, #50, #6
	tst	x6, x21, lsr #50
	add	x28, x28, x27
	csel	x24, x29, x6, eq
	cmp	x25, x24
	csel	x30, x25, x24, hi
	sub	x24, x28, x30
	cmp	x24, x8
	b.lt	512f
	ldp	q0, q1, [x24]
	stp	q0, q1, [x28]
	cmp	x29, #33
	b.hs	522f
162:
	add	x24, x23, w26, uxtb
	lsr	x26, x16, #56
	lsr	x16, x17, #56
	//APP
	//NO_APP
	ldr	x16, [x12, x16, lsl #3]
	add	x23, x22, x27
	ldp	q0, q1, [x23]
	add	x28, x28, x29
	lsr	x17, x24, #3
	and	x22, x24, #0x7
	ldr	x17, [x11, x17]
	lsr	x17, x17, x22
	stp	q0, q1, [x28]
	and	w17, w17, w16, lsr #8
	adds	x17, x17, x16, lsr #32
	csel	x22, x25, x17, eq
	cmp	x26, #33
	b.hs	542f
172:
	lsr	x25, x21, #58
	add	x17, x28, x26
	cmp	x25, #32
	csel	x21, x25, x6, lo
	cmp	x22, x21
	csel	x27, x22, x21, hi
	sub	x21, x17, x27
	cmp	x21, x8
	b.lt	562f
	ldp	q0, q1, [x21]
	stp	q0, q1, [x17]
	cmp	x25, #33
	b.hs	572f
182:
	add	x24, x24, w16, uxtb
	add	x25, x17, x25
	add	x23, x23, x26
	sub	x3, x3, #8
	add	x7, x7, #8
	mov	x17, x20
	mov	x16, x19
	cmp	x10, #7
	b.hi	2b
	b	602f
192:
	ldr	x22, [x0, #48]
	ldp	q0, q1, [x23, #32]
	ldrb	w22, [x22, x13]
	stp	q0, q1, [x25, #32]
	cmp	w22, #32
	b.lo	202f
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x25, #64]
	cmp	w22, #64
	b.lo	202f
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x25, #96]
	cmp	w22, #96
	b.lo	202f
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x25, #128]
	tbz	w22, #7, 202f
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x25, #160]
	cmp	w22, #160
	b.lo	202f
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x25, #192]
	cmp	w22, #192
	b.lo	202f
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x25, #224]
	cmp	w22, #224
	b.lo	202f
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x25, #256]
202:
	add	x28, x22, #33
	add	x13, x13, #1
	b	32b
212:
	sub	x25, x22, x8
	subs	x25, x25, x30
	csel	x25, xzr, x25, lo
	add	x25, x8, x25
	ldp	q0, q1, [x25]
	stp	q0, q1, [x22]
	cmp	x29, #33
	b.lo	42b
222:
	ldr	x29, [x0, #48]
	ldp	q0, q1, [x25, #32]
	ldrb	w29, [x29, x13]
	stp	q0, q1, [x22, #32]
	cmp	w29, #32
	b.lo	232f
	ldp	q0, q1, [x25, #64]
	stp	q0, q1, [x22, #64]
	cmp	w29, #64
	b.lo	232f
	ldp	q0, q1, [x25, #96]
	stp	q0, q1, [x22, #96]
	cmp	w29, #96
	b.lo	232f
	ldp	q0, q1, [x25, #128]
	stp	q0, q1, [x22, #128]
	tbz	w29, #7, 232f
	ldp	q0, q1, [x25, #160]
	stp	q0, q1, [x22, #160]
	cmp	w29, #160
	b.lo	232f
	ldp	q0, q1, [x25, #192]
	stp	q0, q1, [x22, #192]
	cmp	w29, #192
	b.lo	232f
	ldp	q0, q1, [x25, #224]
	stp	q0, q1, [x22, #224]
	cmp	w29, #224
	b.lo	232f
	ldp	q0, q1, [x25, #256]
	stp	q0, q1, [x22, #256]
232:
	add	x29, x29, #33
	add	x13, x13, #1
	b	42b
242:
	ldr	x26, [x0, #48]
	ldp	q0, q1, [x22, #32]
	ldrb	w26, [x26, x13]
	stp	q0, q1, [x29, #32]
	cmp	w26, #32
	b.lo	252f
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x29, #64]
	cmp	w26, #64
	b.lo	252f
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x29, #96]
	cmp	w26, #96
	b.lo	252f
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x29, #128]
	tbz	w26, #7, 252f
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x29, #160]
	cmp	w26, #160
	b.lo	252f
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x29, #192]
	cmp	w26, #192
	b.lo	252f
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x29, #224]
	cmp	w26, #224
	b.lo	252f
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x29, #256]
252:
	add	x27, x26, #33
	add	x13, x13, #1
	b	52b
262:
	sub	x28, x26, x8
	subs	x28, x28, x30
	csel	x28, xzr, x28, lo
	add	x28, x8, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x26]
	cmp	x29, #33
	b.lo	62b
272:
	ldr	x29, [x0, #48]
	ldp	q0, q1, [x28, #32]
	ldrb	w29, [x29, x13]
	stp	q0, q1, [x26, #32]
	cmp	w29, #32
	b.lo	282f
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x26, #64]
	cmp	w29, #64
	b.lo	282f
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x26, #96]
	cmp	w29, #96
	b.lo	282f
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x26, #128]
	tbz	w29, #7, 282f
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x26, #160]
	cmp	w29, #160
	b.lo	282f
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x26, #192]
	cmp	w29, #192
	b.lo	282f
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x26, #224]
	cmp	w29, #224
	b.lo	282f
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x26, #256]
282:
	add	x29, x29, #33
	add	x13, x13, #1
	b	62b
292:
	ldr	x23, [x0, #48]
	ldp	q0, q1, [x22, #32]
	ldrb	w23, [x23, x13]
	stp	q0, q1, [x28, #32]
	cmp	w23, #32
	b.lo	302f
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x28, #64]
	cmp	w23, #64
	b.lo	302f
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x28, #96]
	cmp	w23, #96
	b.lo	302f
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x28, #128]
	tbz	w23, #7, 302f
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x28, #160]
	cmp	w23, #160
	b.lo	302f
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x28, #192]
	cmp	w23, #192
	b.lo	302f
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x28, #224]
	cmp	w23, #224
	b.lo	302f
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x28, #256]
302:
	add	x27, x23, #33
	add	x13, x13, #1
	b	72b
312:
	sub	x23, x28, x8
	subs	x23, x23, x30
	csel	x23, xzr, x23, lo
	add	x23, x8, x23
	ldp	q0, q1, [x23]
	stp	q0, q1, [x28]
	cmp	x29, #33
	b.lo	82b
322:
	ldr	x29, [x0, #48]
	ldp	q0, q1, [x23, #32]
	ldrb	w29, [x29, x13]
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	332f
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	332f
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	332f
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 332f
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	332f
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	332f
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	332f
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x28, #256]
332:
	add	x29, x29, #33
	add	x13, x13, #1
	b	82b
342:
	ldr	x26, [x0, #48]
	ldp	q0, q1, [x22, #32]
	ldrb	w26, [x26, x13]
	stp	q0, q1, [x28, #32]
	cmp	w26, #32
	b.lo	352f
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x28, #64]
	cmp	w26, #64
	b.lo	352f
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x28, #96]
	cmp	w26, #96
	b.lo	352f
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x28, #128]
	tbz	w26, #7, 352f
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x28, #160]
	cmp	w26, #160
	b.lo	352f
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x28, #192]
	cmp	w26, #192
	b.lo	352f
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x28, #224]
	cmp	w26, #224
	b.lo	352f
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x28, #256]
352:
	add	x26, x26, #33
	add	x13, x13, #1
	b	92b
362:
	sub	x28, x27, x8
	subs	x28, x28, x30
	csel	x28, xzr, x28, lo
	add	x28, x8, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x27]
	cmp	x29, #33
	b.lo	102b
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
	b	102b
392:
	ldr	x26, [x0, #48]
	ldp	q0, q1, [x22, #32]
	ldrb	w26, [x26, x13]
	stp	q0, q1, [x27, #32]
	cmp	w26, #32
	b.lo	402f
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x27, #64]
	cmp	w26, #64
	b.lo	402f
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x27, #96]
	cmp	w26, #96
	b.lo	402f
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x27, #128]
	tbz	w26, #7, 402f
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x27, #160]
	cmp	w26, #160
	b.lo	402f
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x27, #192]
	cmp	w26, #192
	b.lo	402f
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x27, #224]
	cmp	w26, #224
	b.lo	402f
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x27, #256]
402:
	add	x26, x26, #33
	add	x13, x13, #1
	b	112b
412:
	sub	x28, x27, x8
	subs	x28, x28, x30
	csel	x28, xzr, x28, lo
	add	x28, x8, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x27]
	cmp	x29, #33
	b.lo	122b
422:
	ldr	x29, [x0, #48]
	ldp	q0, q1, [x28, #32]
	ldrb	w29, [x29, x13]
	stp	q0, q1, [x27, #32]
	cmp	w29, #32
	b.lo	432f
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x27, #64]
	cmp	w29, #64
	b.lo	432f
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x27, #96]
	cmp	w29, #96
	b.lo	432f
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x27, #128]
	tbz	w29, #7, 432f
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x27, #160]
	cmp	w29, #160
	b.lo	432f
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x27, #192]
	cmp	w29, #192
	b.lo	432f
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x27, #224]
	cmp	w29, #224
	b.lo	432f
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x27, #256]
432:
	add	x29, x29, #33
	add	x13, x13, #1
	b	122b
442:
	ldr	x26, [x0, #48]
	ldp	q0, q1, [x22, #32]
	ldrb	w26, [x26, x13]
	stp	q0, q1, [x27, #32]
	cmp	w26, #32
	b.lo	452f
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x27, #64]
	cmp	w26, #64
	b.lo	452f
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x27, #96]
	cmp	w26, #96
	b.lo	452f
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x27, #128]
	tbz	w26, #7, 452f
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x27, #160]
	cmp	w26, #160
	b.lo	452f
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x27, #192]
	cmp	w26, #192
	b.lo	452f
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x27, #224]
	cmp	w26, #224
	b.lo	452f
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x27, #256]
452:
	add	x26, x26, #33
	add	x13, x13, #1
	b	132b
462:
	sub	x28, x27, x8
	subs	x28, x28, x30
	csel	x28, xzr, x28, lo
	add	x28, x8, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x27]
	cmp	x29, #33
	b.lo	142b
472:
	ldr	x29, [x0, #48]
	ldp	q0, q1, [x28, #32]
	ldrb	w29, [x29, x13]
	stp	q0, q1, [x27, #32]
	cmp	w29, #32
	b.lo	482f
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x27, #64]
	cmp	w29, #64
	b.lo	482f
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x27, #96]
	cmp	w29, #96
	b.lo	482f
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x27, #128]
	tbz	w29, #7, 482f
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x27, #160]
	cmp	w29, #160
	b.lo	482f
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x27, #192]
	cmp	w29, #192
	b.lo	482f
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x27, #224]
	cmp	w29, #224
	b.lo	482f
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x27, #256]
482:
	add	x29, x29, #33
	add	x13, x13, #1
	b	142b
492:
	ldr	x24, [x0, #48]
	ldp	q0, q1, [x22, #32]
	ldrb	w24, [x24, x13]
	stp	q0, q1, [x28, #32]
	cmp	w24, #32
	b.lo	502f
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x28, #64]
	cmp	w24, #64
	b.lo	502f
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x28, #96]
	cmp	w24, #96
	b.lo	502f
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x28, #128]
	tbz	w24, #7, 502f
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x28, #160]
	cmp	w24, #160
	b.lo	502f
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x28, #192]
	cmp	w24, #192
	b.lo	502f
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x28, #224]
	cmp	w24, #224
	b.lo	502f
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x28, #256]
502:
	add	x27, x24, #33
	add	x13, x13, #1
	b	152b
512:
	sub	x24, x28, x8
	subs	x24, x24, x30
	csel	x24, xzr, x24, lo
	add	x24, x8, x24
	ldp	q0, q1, [x24]
	stp	q0, q1, [x28]
	cmp	x29, #33
	b.lo	162b
522:
	ldr	x29, [x0, #48]
	ldp	q0, q1, [x24, #32]
	ldrb	w29, [x29, x13]
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	532f
	ldp	q0, q1, [x24, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	532f
	ldp	q0, q1, [x24, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	532f
	ldp	q0, q1, [x24, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 532f
	ldp	q0, q1, [x24, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	532f
	ldp	q0, q1, [x24, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	532f
	ldp	q0, q1, [x24, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	532f
	ldp	q0, q1, [x24, #256]
	stp	q0, q1, [x28, #256]
532:
	add	x29, x29, #33
	add	x13, x13, #1
	b	162b
542:
	ldr	x17, [x0, #48]
	ldp	q0, q1, [x23, #32]
	ldrb	w17, [x17, x13]
	stp	q0, q1, [x28, #32]
	cmp	w17, #32
	b.lo	552f
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x28, #64]
	cmp	w17, #64
	b.lo	552f
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x28, #96]
	cmp	w17, #96
	b.lo	552f
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x28, #128]
	tbz	w17, #7, 552f
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x28, #160]
	cmp	w17, #160
	b.lo	552f
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x28, #192]
	cmp	w17, #192
	b.lo	552f
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x28, #224]
	cmp	w17, #224
	b.lo	552f
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x28, #256]
552:
	add	x26, x17, #33
	add	x13, x13, #1
	b	172b
562:
	sub	x21, x17, x8
	subs	x21, x21, x27
	csel	x21, xzr, x21, lo
	add	x21, x8, x21
	ldp	q0, q1, [x21]
	stp	q0, q1, [x17]
	cmp	x25, #33
	b.lo	182b
572:
	ldr	x25, [x0, #48]
	ldp	q0, q1, [x21, #32]
	ldrb	w25, [x25, x13]
	stp	q0, q1, [x17, #32]
	cmp	w25, #32
	b.lo	582f
	ldp	q0, q1, [x21, #64]
	stp	q0, q1, [x17, #64]
	cmp	w25, #64
	b.lo	582f
	ldp	q0, q1, [x21, #96]
	stp	q0, q1, [x17, #96]
	cmp	w25, #96
	b.lo	582f
	ldp	q0, q1, [x21, #128]
	stp	q0, q1, [x17, #128]
	tbz	w25, #7, 582f
	ldp	q0, q1, [x21, #160]
	stp	q0, q1, [x17, #160]
	cmp	w25, #160
	b.lo	582f
	ldp	q0, q1, [x21, #192]
	stp	q0, q1, [x17, #192]
	cmp	w25, #192
	b.lo	582f
	ldp	q0, q1, [x21, #224]
	stp	q0, q1, [x17, #224]
	cmp	w25, #224
	b.lo	582f
	ldp	q0, q1, [x21, #256]
	stp	q0, q1, [x17, #256]
582:
	add	x25, x25, #33
	add	x13, x13, #1
	b	182b
592:
	mov	x15, xzr
	b	612f
602:
	cbz	x10, 692f
	neg	x15, x3
	mov	x17, x20
	mov	x16, x19
612:
	ldr	x14, [x14, x15]
	mov	w15, #32
	.p2align	5, , 16
622:
	lsr	x3, x24, #3
	and	x1, x17, #0xff
	//APP
	//NO_APP
	ldr	x1, [x12, x1, lsl #3]
	and	x4, x24, #0x7
	and	x2, x16, #0xff
	ldr	x3, [x11, x3]
	ldp	q0, q1, [x23]
	lsr	x3, x3, x4
	and	w3, w3, w1, lsr #8
	stp	q0, q1, [x25]
	adds	x3, x3, x1, lsr #32
	csel	x22, x22, x3, eq
	cmp	x2, #33
	b.hs	652f
632:
	ubfx	x5, x14, #2, #6
	tst	x15, x14, lsr #2
	add	x3, x25, x2
	csel	x4, x5, x15, eq
	sub	x7, x3, x8
	cmp	x22, x4
	csel	x4, x22, x4, hi
	sub	x6, x3, x4
	subs	x4, x7, x4
	csel	x4, xzr, x4, lo
	add	x4, x8, x4
	cmp	x6, x8
	csel	x4, x6, x4, ge
	ldp	q0, q1, [x4]
	stp	q0, q1, [x3]
	cmp	x5, #33
	b.hs	672f
642:
	add	x24, x24, w1, uxtb
	add	x25, x3, x5
	add	x23, x23, x2
	subs	x10, x10, #1
	lsr	x14, x14, #8
	lsr	x16, x16, #8
	lsr	x17, x17, #8
	b.ne	622b
	b	692f
652:
	ldr	x2, [x0, #48]
	ldp	q0, q1, [x23, #32]
	ldrb	w2, [x2, x13]
	stp	q0, q1, [x25, #32]
	cmp	w2, #32
	b.lo	662f
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x25, #64]
	cmp	w2, #64
	b.lo	662f
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x25, #96]
	cmp	w2, #96
	b.lo	662f
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x25, #128]
	tbz	w2, #7, 662f
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x25, #160]
	cmp	w2, #160
	b.lo	662f
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x25, #192]
	cmp	w2, #192
	b.lo	662f
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x25, #224]
	cmp	w2, #224
	b.lo	662f
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x25, #256]
662:
	add	x2, x2, #33
	add	x13, x13, #1
	b	632b
672:
	ldr	x5, [x0, #48]
	ldp	q0, q1, [x4, #32]
	ldrb	w5, [x5, x13]
	stp	q0, q1, [x3, #32]
	cmp	w5, #32
	b.lo	682f
	ldp	q0, q1, [x4, #64]
	stp	q0, q1, [x3, #64]
	cmp	w5, #64
	b.lo	682f
	ldp	q0, q1, [x4, #96]
	stp	q0, q1, [x3, #96]
	cmp	w5, #96
	b.lo	682f
	ldp	q0, q1, [x4, #128]
	stp	q0, q1, [x3, #128]
	tbz	w5, #7, 682f
	ldp	q0, q1, [x4, #160]
	stp	q0, q1, [x3, #160]
	cmp	w5, #160
	b.lo	682f
	ldp	q0, q1, [x4, #192]
	stp	q0, q1, [x3, #192]
	cmp	w5, #192
	b.lo	682f
	ldp	q0, q1, [x4, #224]
	stp	q0, q1, [x3, #224]
	cmp	w5, #224
	b.lo	682f
	ldp	q0, q1, [x4, #256]
	stp	q0, q1, [x3, #256]
682:
	add	x5, x5, #33
	add	x13, x13, #1
	b	642b
692:
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
702:
	ret

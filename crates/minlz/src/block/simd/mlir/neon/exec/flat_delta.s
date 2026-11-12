// minlz_exec_flat_delta of crates/minlz/mlir/exec8.mlir for neon, written by
// cargo xtask mlir. Do not edit.
	ldr	x10, [x0, #64]
	mov	x16, #72340172838076673
	//APP
	//NO_APP
	cbz	x10, 532f
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
	b.lo	432f
	lsr	x3, x3, #56
	lsr	x4, x4, #56
	mov	w5, #32
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
	ldp	q1, q0, [x22]
	and	x26, x20, #0xff
	lsr	x25, x25, x28
	sub	x28, x24, x8
	and	w25, w27, w25
	adds	x25, x25, x27, lsr #40
	csel	x25, x21, x25, eq
	cmp	x21, #32
	csel	x21, x21, x5, hi
	cmp	x21, x28
	csel	x21, x21, x28, lo
	sub	x21, x24, x21
	ldp	q3, q2, [x21]
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x24]
	cmp	x26, #33
	b.hs	272f
32:
	add	x21, x24, x26
	ubfx	x24, x7, #2, #6
	tst	x5, x7, lsr #2
	csel	x28, x24, x5, eq
	sub	x30, x21, x8
	cmp	x25, x28
	csel	x29, x25, x28, hi
	mov	x28, x8
	cmp	x29, x30
	b.hi	42f
	sub	x28, x21, x29
42:
	ldp	q0, q1, [x28]
	stp	q0, q1, [x21]
	cmp	x24, #33
	b.hs	282f
52:
	lsr	x27, x27, #32
	add	x23, x23, w27, uxtb
	add	x27, x21, x24
	add	x21, x22, x26
	ubfx	x22, x19, #8, #8
	//APP
	//NO_APP
	ldr	x24, [x12, x22, lsl #3]
	ubfx	x26, x20, #8, #8
	ldp	q1, q0, [x21]
	lsr	x22, x23, #3
	and	x28, x23, #0x7
	ldr	x22, [x11, x22]
	lsr	x22, x22, x28
	sub	x28, x27, x8
	and	w22, w24, w22
	adds	x22, x22, x24, lsr #40
	csel	x22, x25, x22, eq
	cmp	x25, #32
	csel	x25, x25, x5, hi
	cmp	x25, x28
	csel	x25, x25, x28, lo
	sub	x25, x27, x25
	ldp	q3, q2, [x25]
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x27]
	cmp	x26, #33
	b.hs	292f
62:
	add	x25, x27, x26
	ubfx	x27, x7, #10, #6
	tst	x5, x7, lsr #10
	csel	x28, x27, x5, eq
	sub	x30, x25, x8
	cmp	x22, x28
	csel	x29, x22, x28, hi
	mov	x28, x8
	cmp	x29, x30
	b.hi	72f
	sub	x28, x25, x29
72:
	ldp	q0, q1, [x28]
	stp	q0, q1, [x25]
	cmp	x27, #33
	b.hs	302f
82:
	lsr	x24, x24, #32
	add	x27, x25, x27
	ubfx	x25, x20, #16, #8
	add	x24, x23, w24, uxtb
	add	x23, x21, x26
	ubfx	x21, x19, #16, #8
	//APP
	//NO_APP
	ldr	x26, [x12, x21, lsl #3]
	ldp	q1, q0, [x23]
	lsr	x21, x24, #3
	and	x28, x24, #0x7
	ldr	x21, [x11, x21]
	lsr	x21, x21, x28
	sub	x28, x27, x8
	and	w21, w26, w21
	adds	x21, x21, x26, lsr #40
	csel	x21, x22, x21, eq
	cmp	x22, #32
	csel	x22, x22, x5, hi
	cmp	x22, x28
	csel	x22, x22, x28, lo
	sub	x22, x27, x22
	ldp	q3, q2, [x22]
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x27]
	cmp	x25, #33
	b.hs	312f
92:
	add	x22, x27, x25
	ubfx	x27, x7, #18, #6
	tst	x5, x7, lsr #18
	csel	x28, x27, x5, eq
	sub	x30, x22, x8
	cmp	x21, x28
	csel	x29, x21, x28, hi
	mov	x28, x8
	cmp	x29, x30
	b.hi	102f
	sub	x28, x22, x29
102:
	ldp	q0, q1, [x28]
	stp	q0, q1, [x22]
	cmp	x27, #33
	b.hs	322f
112:
	lsr	x26, x26, #32
	add	x27, x22, x27
	lsr	w22, w19, #24
	//APP
	//NO_APP
	add	x23, x23, x25
	lsr	w25, w20, #24
	add	x24, x24, w26, uxtb
	ldr	x26, [x12, x22, lsl #3]
	ldp	q1, q0, [x23]
	lsr	x22, x24, #3
	and	x28, x24, #0x7
	ldr	x22, [x11, x22]
	lsr	x22, x22, x28
	sub	x28, x27, x8
	and	w22, w26, w22
	adds	x22, x22, x26, lsr #40
	csel	x22, x21, x22, eq
	cmp	x21, #32
	csel	x21, x21, x5, hi
	cmp	x21, x28
	csel	x21, x21, x28, lo
	sub	x21, x27, x21
	ldp	q3, q2, [x21]
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x27]
	cmp	x25, #33
	b.hs	332f
122:
	add	x21, x27, x25
	lsr	w27, w7, #26
	tst	x5, x7, lsr #26
	csel	x28, x27, x5, eq
	sub	x30, x21, x8
	cmp	x22, x28
	csel	x29, x22, x28, hi
	mov	x28, x8
	cmp	x29, x30
	b.hi	132f
	sub	x28, x21, x29
132:
	ldp	q0, q1, [x28]
	stp	q0, q1, [x21]
	cmp	x27, #33
	b.hs	342f
142:
	lsr	x26, x26, #32
	add	x27, x21, x27
	ubfx	x21, x19, #32, #8
	//APP
	//NO_APP
	add	x23, x23, x25
	ubfx	x25, x20, #32, #8
	add	x24, x24, w26, uxtb
	ldr	x26, [x12, x21, lsl #3]
	ldp	q1, q0, [x23]
	lsr	x21, x24, #3
	and	x28, x24, #0x7
	ldr	x21, [x11, x21]
	lsr	x21, x21, x28
	sub	x28, x27, x8
	and	w21, w26, w21
	adds	x21, x21, x26, lsr #40
	csel	x21, x22, x21, eq
	cmp	x22, #32
	csel	x22, x22, x5, hi
	cmp	x22, x28
	csel	x22, x22, x28, lo
	sub	x22, x27, x22
	ldp	q3, q2, [x22]
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x27]
	cmp	x25, #33
	b.hs	352f
152:
	add	x22, x27, x25
	ubfx	x27, x7, #34, #6
	tst	x5, x7, lsr #34
	csel	x28, x27, x5, eq
	sub	x30, x22, x8
	cmp	x21, x28
	csel	x29, x21, x28, hi
	mov	x28, x8
	cmp	x29, x30
	b.hi	162f
	sub	x28, x22, x29
162:
	ldp	q0, q1, [x28]
	stp	q0, q1, [x22]
	cmp	x27, #33
	b.hs	362f
172:
	lsr	x26, x26, #32
	add	x27, x22, x27
	ubfx	x22, x19, #40, #8
	//APP
	//NO_APP
	add	x23, x23, x25
	ubfx	x25, x20, #40, #8
	add	x24, x24, w26, uxtb
	ldr	x26, [x12, x22, lsl #3]
	ldp	q1, q0, [x23]
	lsr	x22, x24, #3
	and	x28, x24, #0x7
	ldr	x22, [x11, x22]
	lsr	x22, x22, x28
	sub	x28, x27, x8
	and	w22, w26, w22
	adds	x22, x22, x26, lsr #40
	csel	x22, x21, x22, eq
	cmp	x21, #32
	csel	x21, x21, x5, hi
	cmp	x21, x28
	csel	x21, x21, x28, lo
	sub	x21, x27, x21
	ldp	q3, q2, [x21]
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x27]
	cmp	x25, #33
	b.hs	372f
182:
	add	x21, x27, x25
	ubfx	x27, x7, #42, #6
	tst	x5, x7, lsr #42
	csel	x28, x27, x5, eq
	sub	x30, x21, x8
	cmp	x22, x28
	csel	x29, x22, x28, hi
	mov	x28, x8
	cmp	x29, x30
	b.hi	192f
	sub	x28, x21, x29
192:
	ldp	q0, q1, [x28]
	stp	q0, q1, [x21]
	cmp	x27, #33
	b.hs	382f
202:
	lsr	x26, x26, #32
	add	x27, x21, x27
	add	x21, x23, x25
	ubfx	x23, x19, #48, #8
	//APP
	//NO_APP
	ubfx	x25, x20, #48, #8
	add	x24, x24, w26, uxtb
	ldr	x26, [x12, x23, lsl #3]
	ldp	q1, q0, [x21]
	lsr	x23, x24, #3
	and	x28, x24, #0x7
	ldr	x23, [x11, x23]
	lsr	x23, x23, x28
	sub	x28, x27, x8
	and	w23, w26, w23
	adds	x23, x23, x26, lsr #40
	csel	x23, x22, x23, eq
	cmp	x22, #32
	csel	x22, x22, x5, hi
	cmp	x22, x28
	csel	x22, x22, x28, lo
	sub	x22, x27, x22
	ldp	q3, q2, [x22]
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x27]
	cmp	x25, #33
	b.hs	392f
212:
	add	x22, x27, x25
	ubfx	x27, x7, #50, #6
	tst	x5, x7, lsr #50
	csel	x28, x27, x5, eq
	sub	x30, x22, x8
	cmp	x23, x28
	csel	x29, x23, x28, hi
	mov	x28, x8
	cmp	x29, x30
	b.hi	222f
	sub	x28, x22, x29
222:
	ldp	q0, q1, [x28]
	stp	q0, q1, [x22]
	cmp	x27, #33
	b.hs	402f
232:
	lsr	x26, x26, #32
	lsr	x19, x19, #56
	//APP
	//NO_APP
	ldr	x19, [x12, x19, lsl #3]
	lsr	x20, x20, #56
	add	x24, x24, w26, uxtb
	add	x26, x22, x27
	add	x22, x21, x25
	ldp	q1, q0, [x22]
	lsr	x21, x24, #3
	and	x25, x24, #0x7
	ldr	x21, [x11, x21]
	lsr	x21, x21, x25
	sub	x25, x26, x8
	and	w21, w19, w21
	adds	x21, x21, x19, lsr #40
	csel	x21, x23, x21, eq
	cmp	x23, #32
	csel	x23, x23, x5, hi
	cmp	x23, x25
	csel	x23, x23, x25, lo
	sub	x23, x26, x23
	ldp	q3, q2, [x23]
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x26]
	cmp	x20, #33
	b.hs	412f
242:
	lsr	x7, x7, #58
	add	x25, x26, x20
	cmp	x7, #32
	csel	x23, x7, x5, lo
	sub	x27, x25, x8
	cmp	x21, x23
	csel	x26, x21, x23, hi
	mov	x23, x8
	cmp	x26, x27
	b.hi	252f
	sub	x23, x25, x26
252:
	ldp	q0, q1, [x23]
	stp	q0, q1, [x25]
	cmp	x7, #33
	b.hs	422f
262:
	lsr	x19, x19, #32
	add	x22, x22, x20
	sub	x2, x2, #8
	add	x6, x6, #8
	add	x23, x24, w19, uxtb
	add	x24, x25, x7
	cmp	x10, #7
	b.hi	2b
	b	442f
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
292:
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
302:
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
312:
	ldr	x22, [x0, #48]
	ldr	x25, [x0, #120]
	ldrb	w22, [x22, x25]
	add	x25, x25, #1
	str	x25, [x0, #120]
	ldp	q0, q1, [x23, #32]
	add	x25, x22, #33
	stp	q0, q1, [x27, #32]
	cmp	w22, #32
	b.lo	92b
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x27, #64]
	cmp	w22, #64
	b.lo	92b
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x27, #96]
	cmp	w22, #96
	b.lo	92b
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x27, #128]
	tbz	w22, #7, 92b
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x27, #160]
	cmp	w22, #160
	b.lo	92b
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x27, #192]
	cmp	w22, #192
	b.lo	92b
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x27, #224]
	cmp	w22, #224
	b.lo	92b
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x27, #256]
	b	92b
322:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x27, x30]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldp	q0, q1, [x28, #32]
	add	x27, x29, #33
	stp	q0, q1, [x22, #32]
	cmp	w29, #32
	b.lo	112b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x22, #64]
	cmp	w29, #64
	b.lo	112b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x22, #96]
	cmp	w29, #96
	b.lo	112b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x22, #128]
	tbz	w29, #7, 112b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x22, #160]
	cmp	w29, #160
	b.lo	112b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x22, #192]
	cmp	w29, #192
	b.lo	112b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x22, #224]
	cmp	w29, #224
	b.lo	112b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x22, #256]
	b	112b
332:
	ldr	x21, [x0, #48]
	ldr	x25, [x0, #120]
	ldrb	w21, [x21, x25]
	add	x25, x25, #1
	str	x25, [x0, #120]
	ldp	q0, q1, [x23, #32]
	add	x25, x21, #33
	stp	q0, q1, [x27, #32]
	cmp	w21, #32
	b.lo	122b
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x27, #64]
	cmp	w21, #64
	b.lo	122b
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x27, #96]
	cmp	w21, #96
	b.lo	122b
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x27, #128]
	tbz	w21, #7, 122b
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x27, #160]
	cmp	w21, #160
	b.lo	122b
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x27, #192]
	cmp	w21, #192
	b.lo	122b
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x27, #224]
	cmp	w21, #224
	b.lo	122b
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x27, #256]
	b	122b
342:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x27, x30]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldp	q0, q1, [x28, #32]
	add	x27, x29, #33
	stp	q0, q1, [x21, #32]
	cmp	w29, #32
	b.lo	142b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x21, #64]
	cmp	w29, #64
	b.lo	142b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x21, #96]
	cmp	w29, #96
	b.lo	142b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x21, #128]
	tbz	w29, #7, 142b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x21, #160]
	cmp	w29, #160
	b.lo	142b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x21, #192]
	cmp	w29, #192
	b.lo	142b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x21, #224]
	cmp	w29, #224
	b.lo	142b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x21, #256]
	b	142b
352:
	ldr	x22, [x0, #48]
	ldr	x25, [x0, #120]
	ldrb	w22, [x22, x25]
	add	x25, x25, #1
	str	x25, [x0, #120]
	ldp	q0, q1, [x23, #32]
	add	x25, x22, #33
	stp	q0, q1, [x27, #32]
	cmp	w22, #32
	b.lo	152b
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x27, #64]
	cmp	w22, #64
	b.lo	152b
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x27, #96]
	cmp	w22, #96
	b.lo	152b
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x27, #128]
	tbz	w22, #7, 152b
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x27, #160]
	cmp	w22, #160
	b.lo	152b
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x27, #192]
	cmp	w22, #192
	b.lo	152b
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x27, #224]
	cmp	w22, #224
	b.lo	152b
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x27, #256]
	b	152b
362:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x27, x30]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldp	q0, q1, [x28, #32]
	add	x27, x29, #33
	stp	q0, q1, [x22, #32]
	cmp	w29, #32
	b.lo	172b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x22, #64]
	cmp	w29, #64
	b.lo	172b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x22, #96]
	cmp	w29, #96
	b.lo	172b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x22, #128]
	tbz	w29, #7, 172b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x22, #160]
	cmp	w29, #160
	b.lo	172b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x22, #192]
	cmp	w29, #192
	b.lo	172b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x22, #224]
	cmp	w29, #224
	b.lo	172b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x22, #256]
	b	172b
372:
	ldr	x21, [x0, #48]
	ldr	x25, [x0, #120]
	ldrb	w21, [x21, x25]
	add	x25, x25, #1
	str	x25, [x0, #120]
	ldp	q0, q1, [x23, #32]
	add	x25, x21, #33
	stp	q0, q1, [x27, #32]
	cmp	w21, #32
	b.lo	182b
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x27, #64]
	cmp	w21, #64
	b.lo	182b
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x27, #96]
	cmp	w21, #96
	b.lo	182b
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x27, #128]
	tbz	w21, #7, 182b
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x27, #160]
	cmp	w21, #160
	b.lo	182b
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x27, #192]
	cmp	w21, #192
	b.lo	182b
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x27, #224]
	cmp	w21, #224
	b.lo	182b
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x27, #256]
	b	182b
382:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x27, x30]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldp	q0, q1, [x28, #32]
	add	x27, x29, #33
	stp	q0, q1, [x21, #32]
	cmp	w29, #32
	b.lo	202b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x21, #64]
	cmp	w29, #64
	b.lo	202b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x21, #96]
	cmp	w29, #96
	b.lo	202b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x21, #128]
	tbz	w29, #7, 202b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x21, #160]
	cmp	w29, #160
	b.lo	202b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x21, #192]
	cmp	w29, #192
	b.lo	202b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x21, #224]
	cmp	w29, #224
	b.lo	202b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x21, #256]
	b	202b
392:
	ldr	x22, [x0, #48]
	ldr	x25, [x0, #120]
	ldrb	w22, [x22, x25]
	add	x25, x25, #1
	str	x25, [x0, #120]
	ldp	q0, q1, [x21, #32]
	add	x25, x22, #33
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
402:
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
412:
	ldr	x20, [x0, #48]
	ldr	x25, [x0, #120]
	ldrb	w23, [x20, x25]
	add	x20, x25, #1
	str	x20, [x0, #120]
	ldp	q0, q1, [x22, #32]
	add	x20, x23, #33
	stp	q0, q1, [x26, #32]
	cmp	w23, #32
	b.lo	242b
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x26, #64]
	cmp	w23, #64
	b.lo	242b
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x26, #96]
	cmp	w23, #96
	b.lo	242b
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x26, #128]
	tbz	w23, #7, 242b
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x26, #160]
	cmp	w23, #160
	b.lo	242b
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x26, #192]
	cmp	w23, #192
	b.lo	242b
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x26, #224]
	cmp	w23, #224
	b.lo	242b
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x26, #256]
	b	242b
422:
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
432:
	mov	x16, xzr
	b	452f
442:
	cbz	x10, 522f
	neg	x16, x2
452:
	ldr	x15, [x15, x16]
	mov	w16, #32
	.p2align	5, , 16
462:
	lsr	x3, x23, #3
	and	x1, x14, #0xff
	//APP
	//NO_APP
	ldr	x1, [x12, x1, lsl #3]
	and	x4, x23, #0x7
	mov	x2, x21
	ldr	x3, [x11, x3]
	ldp	q1, q0, [x22]
	and	x17, x13, #0xff
	lsr	x3, x3, x4
	and	w3, w1, w3
	adds	x3, x3, x1, lsr #40
	csel	x21, x21, x3, eq
	cmp	x2, #32
	csel	x2, x2, x16, hi
	sub	x3, x24, x8
	cmp	x2, x3
	csel	x2, x2, x3, lo
	sub	x2, x24, x2
	ldp	q3, q2, [x2]
	add	v0.16b, v2.16b, v0.16b
	add	v1.16b, v3.16b, v1.16b
	stp	q1, q0, [x24]
	cmp	x17, #33
	b.hs	502f
472:
	ubfx	x3, x15, #2, #6
	tst	x16, x15, lsr #2
	add	x2, x24, x17
	csel	x4, x3, x16, eq
	sub	x6, x2, x8
	cmp	x21, x4
	csel	x5, x21, x4, hi
	mov	x4, x8
	cmp	x5, x6
	b.hi	482f
	sub	x4, x2, x5
482:
	ldp	q0, q1, [x4]
	stp	q0, q1, [x2]
	cmp	x3, #33
	b.hs	512f
492:
	lsr	x1, x1, #32
	add	x24, x2, x3
	add	x22, x22, x17
	subs	x10, x10, #1
	lsr	x15, x15, #8
	lsr	x13, x13, #8
	add	x23, x23, w1, uxtb
	lsr	x14, x14, #8
	b.ne	462b
	b	522f
502:
	ldr	x17, [x0, #48]
	ldr	x3, [x0, #120]
	ldrb	w2, [x17, x3]
	add	x17, x3, #1
	str	x17, [x0, #120]
	ldp	q0, q1, [x22, #32]
	add	x17, x2, #33
	stp	q0, q1, [x24, #32]
	cmp	w2, #32
	b.lo	472b
	ldp	q0, q1, [x22, #64]
	stp	q0, q1, [x24, #64]
	cmp	w2, #64
	b.lo	472b
	ldp	q0, q1, [x22, #96]
	stp	q0, q1, [x24, #96]
	cmp	w2, #96
	b.lo	472b
	ldp	q0, q1, [x22, #128]
	stp	q0, q1, [x24, #128]
	tbz	w2, #7, 472b
	ldp	q0, q1, [x22, #160]
	stp	q0, q1, [x24, #160]
	cmp	w2, #160
	b.lo	472b
	ldp	q0, q1, [x22, #192]
	stp	q0, q1, [x24, #192]
	cmp	w2, #192
	b.lo	472b
	ldp	q0, q1, [x22, #224]
	stp	q0, q1, [x24, #224]
	cmp	w2, #224
	b.lo	472b
	ldp	q0, q1, [x22, #256]
	stp	q0, q1, [x24, #256]
	b	472b
512:
	ldr	x3, [x0, #48]
	ldr	x6, [x0, #120]
	ldrb	w5, [x3, x6]
	add	x3, x6, #1
	str	x3, [x0, #120]
	ldp	q0, q1, [x4, #32]
	add	x3, x5, #33
	stp	q0, q1, [x2, #32]
	cmp	w5, #32
	b.lo	492b
	ldp	q0, q1, [x4, #64]
	stp	q0, q1, [x2, #64]
	cmp	w5, #64
	b.lo	492b
	ldp	q0, q1, [x4, #96]
	stp	q0, q1, [x2, #96]
	cmp	w5, #96
	b.lo	492b
	ldp	q0, q1, [x4, #128]
	stp	q0, q1, [x2, #128]
	tbz	w5, #7, 492b
	ldp	q0, q1, [x4, #160]
	stp	q0, q1, [x2, #160]
	cmp	w5, #160
	b.lo	492b
	ldp	q0, q1, [x4, #192]
	stp	q0, q1, [x2, #192]
	cmp	w5, #192
	b.lo	492b
	ldp	q0, q1, [x4, #224]
	stp	q0, q1, [x2, #224]
	cmp	w5, #224
	b.lo	492b
	ldp	q0, q1, [x4, #256]
	stp	q0, q1, [x2, #256]
	b	492b
522:
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
532:
	ret

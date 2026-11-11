// minlz_exec_flat of crates/minlz/mlir/exec8.mlir for neon, written by
// cargo xtask mlir. Do not edit.
	ldr	x8, [x0, #64]
	mov	x16, #72340172838076673
	//APP
	//NO_APP
	cbz	x8, 442f
	sub	sp, sp, #112
	ldp	x15, x17, [x0, #16]
	ldp	x1, x11, [x0, #32]
	stp	x24, x23, [sp, #64]
	stp	x22, x21, [sp, #80]
	ldp	x9, x10, [x0]
	ldr	x12, [x0, #56]
	ldr	x14, [x15]
	ldr	d0, [x17]
	ldp	x22, x21, [x0, #88]
	ldp	x23, x24, [x0, #72]
	and	x13, x16, x14, lsr #1
	bic	x2, x16, x14
	and	x14, x14, x16
	stp	x29, x30, [sp, #16]
	stp	x28, x27, [sp, #32]
	stp	x26, x25, [sp, #48]
	stp	x20, x19, [sp, #96]
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
	b.lo	352f
	lsr	x3, x3, #56
	lsr	x4, x4, #56
	mov	w5, #32
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
	ubfiz	x25, x19, #3, #8
	and	x28, x23, #0x7
	ldr	x7, [x6]
	and	x27, x20, #0xff
	ldr	x26, [x12, x25]
	lsr	x25, x23, #3
	ldr	x25, [x11, x25]
	lsr	x25, x25, x28
	add	x28, x9, x24
	and	w25, w26, w25
	adds	x25, x25, x26, lsr #40
	csel	x25, x21, x25, eq
	add	x21, x10, x22
	ldp	q0, q1, [x21]
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.hs	192f
32:
	and	x30, x7, #0xff
	add	x24, x27, x24
	lsr	x28, x30, #2
	add	x29, x9, x24
	cmp	x28, #32
	csel	x21, x28, x5, lo
	cmp	x25, x21
	csel	x21, x25, x21, hi
	subs	x21, x24, x21
	csel	x21, xzr, x21, lo
	add	x21, x9, x21
	ldp	q0, q1, [x21]
	stp	q0, q1, [x29]
	cmp	x30, #132
	b.hs	202f
42:
	lsr	x21, x26, #32
	add	x22, x27, x22
	add	x27, x28, x24
	ubfx	x26, x20, #8, #8
	add	x21, x23, w21, uxtb
	lsr	x23, x19, #5
	and	x23, x23, #0x7f8
	ldr	x24, [x12, x23]
	lsr	x23, x21, #3
	and	x28, x21, #0x7
	ldr	x23, [x11, x23]
	lsr	x23, x23, x28
	add	x28, x9, x27
	and	w23, w24, w23
	adds	x23, x23, x24, lsr #40
	csel	x23, x25, x23, eq
	add	x25, x10, x22
	ldp	q0, q1, [x25]
	stp	q0, q1, [x28]
	cmp	x26, #33
	b.hs	212f
52:
	ubfx	x30, x7, #8, #8
	add	x25, x26, x27
	lsr	x27, x30, #2
	add	x29, x9, x25
	cmp	x27, #32
	csel	x28, x27, x5, lo
	cmp	x23, x28
	csel	x28, x23, x28, hi
	subs	x28, x25, x28
	csel	x28, xzr, x28, lo
	add	x28, x9, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x29]
	cmp	x30, #132
	b.hs	222f
62:
	lsr	x24, x24, #32
	add	x22, x26, x22
	add	x26, x27, x25
	ubfx	x25, x20, #16, #8
	add	x21, x21, w24, uxtb
	lsr	x24, x19, #13
	and	x24, x24, #0x7f8
	lsr	x27, x21, #3
	ldr	x24, [x12, x24]
	and	x28, x21, #0x7
	ldr	x27, [x11, x27]
	lsr	x27, x27, x28
	add	x28, x9, x26
	and	w27, w24, w27
	adds	x27, x27, x24, lsr #40
	csel	x23, x23, x27, eq
	add	x27, x10, x22
	ldp	q0, q1, [x27]
	stp	q0, q1, [x28]
	cmp	x25, #33
	b.hs	232f
72:
	ubfx	x30, x7, #16, #8
	add	x26, x25, x26
	lsr	x27, x30, #2
	add	x29, x9, x26
	cmp	x27, #32
	csel	x28, x27, x5, lo
	cmp	x23, x28
	csel	x28, x23, x28, hi
	subs	x28, x26, x28
	csel	x28, xzr, x28, lo
	add	x28, x9, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x29]
	cmp	x30, #132
	b.hs	242f
82:
	lsr	x24, x24, #32
	add	x26, x27, x26
	add	x22, x25, x22
	lsr	w25, w20, #24
	add	x21, x21, w24, uxtb
	lsr	x24, x19, #21
	and	x24, x24, #0x7f8
	lsr	x27, x21, #3
	ldr	x24, [x12, x24]
	and	x28, x21, #0x7
	ldr	x27, [x11, x27]
	lsr	x27, x27, x28
	add	x28, x9, x26
	and	w27, w24, w27
	adds	x27, x27, x24, lsr #40
	csel	x23, x23, x27, eq
	add	x27, x10, x22
	ldp	q0, q1, [x27]
	stp	q0, q1, [x28]
	cmp	x25, #33
	b.hs	252f
92:
	lsr	w30, w7, #24
	add	x26, x25, x26
	lsr	x27, x30, #2
	add	x29, x9, x26
	cmp	x27, #32
	csel	x28, x27, x5, lo
	cmp	x23, x28
	csel	x28, x23, x28, hi
	subs	x28, x26, x28
	csel	x28, xzr, x28, lo
	add	x28, x9, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x29]
	cmp	x30, #132
	b.hs	262f
102:
	lsr	x24, x24, #32
	add	x26, x27, x26
	add	x22, x25, x22
	ubfx	x25, x20, #32, #8
	add	x21, x21, w24, uxtb
	lsr	x24, x19, #29
	and	x24, x24, #0x7f8
	lsr	x27, x21, #3
	ldr	x24, [x12, x24]
	and	x28, x21, #0x7
	ldr	x27, [x11, x27]
	lsr	x27, x27, x28
	add	x28, x9, x26
	and	w27, w24, w27
	adds	x27, x27, x24, lsr #40
	csel	x23, x23, x27, eq
	add	x27, x10, x22
	ldp	q0, q1, [x27]
	stp	q0, q1, [x28]
	cmp	x25, #33
	b.hs	272f
112:
	ubfx	x30, x7, #32, #8
	add	x26, x25, x26
	lsr	x27, x30, #2
	add	x29, x9, x26
	cmp	x27, #32
	csel	x28, x27, x5, lo
	cmp	x23, x28
	csel	x28, x23, x28, hi
	subs	x28, x26, x28
	csel	x28, xzr, x28, lo
	add	x28, x9, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x29]
	cmp	x30, #132
	b.hs	282f
122:
	lsr	x24, x24, #32
	add	x26, x27, x26
	add	x22, x25, x22
	ubfx	x25, x20, #40, #8
	add	x21, x21, w24, uxtb
	lsr	x24, x19, #37
	and	x24, x24, #0x7f8
	lsr	x27, x21, #3
	ldr	x24, [x12, x24]
	and	x28, x21, #0x7
	ldr	x27, [x11, x27]
	lsr	x27, x27, x28
	add	x28, x9, x26
	and	w27, w24, w27
	adds	x27, x27, x24, lsr #40
	csel	x23, x23, x27, eq
	add	x27, x10, x22
	ldp	q0, q1, [x27]
	stp	q0, q1, [x28]
	cmp	x25, #33
	b.hs	292f
132:
	ubfx	x30, x7, #40, #8
	add	x26, x25, x26
	lsr	x27, x30, #2
	add	x29, x9, x26
	cmp	x27, #32
	csel	x28, x27, x5, lo
	cmp	x23, x28
	csel	x28, x23, x28, hi
	subs	x28, x26, x28
	csel	x28, xzr, x28, lo
	add	x28, x9, x28
	ldp	q0, q1, [x28]
	stp	q0, q1, [x29]
	cmp	x30, #132
	b.hs	302f
142:
	lsr	x24, x24, #32
	add	x22, x25, x22
	add	x27, x27, x26
	ubfx	x26, x20, #48, #8
	add	x21, x21, w24, uxtb
	lsr	x24, x19, #45
	and	x24, x24, #0x7f8
	ldr	x25, [x12, x24]
	lsr	x24, x21, #3
	and	x28, x21, #0x7
	ldr	x24, [x11, x24]
	lsr	x24, x24, x28
	add	x28, x9, x27
	and	w24, w25, w24
	adds	x24, x24, x25, lsr #40
	csel	x24, x23, x24, eq
	add	x23, x10, x22
	ldp	q0, q1, [x23]
	stp	q0, q1, [x28]
	cmp	x26, #33
	b.hs	312f
152:
	ubfx	x30, x7, #48, #8
	add	x27, x26, x27
	lsr	x28, x30, #2
	add	x29, x9, x27
	cmp	x28, #32
	csel	x23, x28, x5, lo
	cmp	x24, x23
	csel	x23, x24, x23, hi
	subs	x23, x27, x23
	csel	x23, xzr, x23, lo
	add	x23, x9, x23
	ldp	q0, q1, [x23]
	stp	q0, q1, [x29]
	cmp	x30, #132
	b.hs	322f
162:
	lsr	x23, x25, #32
	lsr	x19, x19, #53
	add	x22, x26, x22
	add	x25, x28, x27
	lsr	x20, x20, #56
	add	x23, x21, w23, uxtb
	and	x19, x19, #0x7f8
	ldr	x19, [x12, x19]
	lsr	x21, x23, #3
	and	x26, x23, #0x7
	ldr	x21, [x11, x21]
	lsr	x21, x21, x26
	add	x26, x9, x25
	and	w21, w19, w21
	adds	x21, x21, x19, lsr #40
	csel	x21, x24, x21, eq
	add	x24, x10, x22
	ldp	q0, q1, [x24]
	stp	q0, q1, [x26]
	cmp	x20, #33
	b.hs	332f
172:
	lsr	x7, x7, #58
	add	x24, x20, x25
	cmp	x7, #32
	csel	x25, x7, x5, lo
	add	x26, x9, x24
	cmp	x21, x25
	csel	x25, x21, x25, hi
	subs	x25, x24, x25
	csel	x25, xzr, x25, lo
	add	x25, x9, x25
	ldp	q0, q1, [x25]
	stp	q0, q1, [x26]
	cmp	x7, #33
	b.hs	342f
182:
	lsr	x19, x19, #32
	add	x22, x20, x22
	add	x24, x7, x24
	sub	x2, x2, #8
	add	x6, x6, #8
	add	x23, x23, w19, uxtb
	cmp	x8, #7
	b.hi	2b
	b	362f
192:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x27, x30]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldp	q0, q1, [x21, #32]
	add	x27, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	32b
	ldp	q0, q1, [x21, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	32b
	ldp	q0, q1, [x21, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	32b
	ldp	q0, q1, [x21, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 32b
	ldp	q0, q1, [x21, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	32b
	ldp	q0, q1, [x21, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	32b
	ldp	q0, q1, [x21, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	32b
	ldp	q0, q1, [x21, #256]
	stp	q0, q1, [x28, #256]
	b	32b
202:
	ldr	x28, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w28, [x28, x30]
	str	x28, [sp, #8]
	add	x28, x30, #1
	str	x28, [x0, #120]
	ldr	x30, [sp, #8]
	ldp	q0, q1, [x21, #32]
	add	x28, x30, #33
	stp	q0, q1, [x29, #32]
	cmp	w30, #32
	b.lo	42b
	ldp	q0, q1, [x21, #64]
	stp	q0, q1, [x29, #64]
	cmp	w30, #64
	b.lo	42b
	ldp	q0, q1, [x21, #96]
	stp	q0, q1, [x29, #96]
	cmp	w30, #96
	b.lo	42b
	ldp	q0, q1, [x21, #128]
	stp	q0, q1, [x29, #128]
	tbz	w30, #7, 42b
	ldp	q0, q1, [x21, #160]
	stp	q0, q1, [x29, #160]
	cmp	w30, #160
	b.lo	42b
	ldp	q0, q1, [x21, #192]
	stp	q0, q1, [x29, #192]
	cmp	w30, #192
	b.lo	42b
	ldp	q0, q1, [x21, #224]
	stp	q0, q1, [x29, #224]
	cmp	w30, #224
	b.lo	42b
	ldp	q0, q1, [x21, #256]
	stp	q0, q1, [x29, #256]
	b	42b
212:
	ldr	x26, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x26, x30]
	add	x26, x30, #1
	str	x26, [x0, #120]
	ldp	q0, q1, [x25, #32]
	add	x26, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	52b
	ldp	q0, q1, [x25, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	52b
	ldp	q0, q1, [x25, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	52b
	ldp	q0, q1, [x25, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 52b
	ldp	q0, q1, [x25, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	52b
	ldp	q0, q1, [x25, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	52b
	ldp	q0, q1, [x25, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	52b
	ldp	q0, q1, [x25, #256]
	stp	q0, q1, [x28, #256]
	b	52b
222:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w27, [x27, x30]
	str	x27, [sp, #8]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldr	x30, [sp, #8]
	ldp	q0, q1, [x28, #32]
	add	x27, x30, #33
	stp	q0, q1, [x29, #32]
	cmp	w30, #32
	b.lo	62b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x29, #64]
	cmp	w30, #64
	b.lo	62b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x29, #96]
	cmp	w30, #96
	b.lo	62b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x29, #128]
	tbz	w30, #7, 62b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x29, #160]
	cmp	w30, #160
	b.lo	62b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x29, #192]
	cmp	w30, #192
	b.lo	62b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x29, #224]
	cmp	w30, #224
	b.lo	62b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x29, #256]
	b	62b
232:
	ldr	x25, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x25, x30]
	add	x25, x30, #1
	str	x25, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x25, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	72b
	ldp	q0, q1, [x27, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	72b
	ldp	q0, q1, [x27, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	72b
	ldp	q0, q1, [x27, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 72b
	ldp	q0, q1, [x27, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	72b
	ldp	q0, q1, [x27, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	72b
	ldp	q0, q1, [x27, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	72b
	ldp	q0, q1, [x27, #256]
	stp	q0, q1, [x28, #256]
	b	72b
242:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w27, [x27, x30]
	str	x27, [sp, #8]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldr	x30, [sp, #8]
	ldp	q0, q1, [x28, #32]
	add	x27, x30, #33
	stp	q0, q1, [x29, #32]
	cmp	w30, #32
	b.lo	82b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x29, #64]
	cmp	w30, #64
	b.lo	82b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x29, #96]
	cmp	w30, #96
	b.lo	82b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x29, #128]
	tbz	w30, #7, 82b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x29, #160]
	cmp	w30, #160
	b.lo	82b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x29, #192]
	cmp	w30, #192
	b.lo	82b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x29, #224]
	cmp	w30, #224
	b.lo	82b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x29, #256]
	b	82b
252:
	ldr	x25, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x25, x30]
	add	x25, x30, #1
	str	x25, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x25, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	92b
	ldp	q0, q1, [x27, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	92b
	ldp	q0, q1, [x27, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	92b
	ldp	q0, q1, [x27, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 92b
	ldp	q0, q1, [x27, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	92b
	ldp	q0, q1, [x27, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	92b
	ldp	q0, q1, [x27, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	92b
	ldp	q0, q1, [x27, #256]
	stp	q0, q1, [x28, #256]
	b	92b
262:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w27, [x27, x30]
	str	x27, [sp, #8]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldr	x30, [sp, #8]
	ldp	q0, q1, [x28, #32]
	add	x27, x30, #33
	stp	q0, q1, [x29, #32]
	cmp	w30, #32
	b.lo	102b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x29, #64]
	cmp	w30, #64
	b.lo	102b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x29, #96]
	cmp	w30, #96
	b.lo	102b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x29, #128]
	tbz	w30, #7, 102b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x29, #160]
	cmp	w30, #160
	b.lo	102b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x29, #192]
	cmp	w30, #192
	b.lo	102b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x29, #224]
	cmp	w30, #224
	b.lo	102b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x29, #256]
	b	102b
272:
	ldr	x25, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x25, x30]
	add	x25, x30, #1
	str	x25, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x25, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	112b
	ldp	q0, q1, [x27, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	112b
	ldp	q0, q1, [x27, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	112b
	ldp	q0, q1, [x27, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 112b
	ldp	q0, q1, [x27, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	112b
	ldp	q0, q1, [x27, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	112b
	ldp	q0, q1, [x27, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	112b
	ldp	q0, q1, [x27, #256]
	stp	q0, q1, [x28, #256]
	b	112b
282:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w27, [x27, x30]
	str	x27, [sp, #8]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldr	x30, [sp, #8]
	ldp	q0, q1, [x28, #32]
	add	x27, x30, #33
	stp	q0, q1, [x29, #32]
	cmp	w30, #32
	b.lo	122b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x29, #64]
	cmp	w30, #64
	b.lo	122b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x29, #96]
	cmp	w30, #96
	b.lo	122b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x29, #128]
	tbz	w30, #7, 122b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x29, #160]
	cmp	w30, #160
	b.lo	122b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x29, #192]
	cmp	w30, #192
	b.lo	122b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x29, #224]
	cmp	w30, #224
	b.lo	122b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x29, #256]
	b	122b
292:
	ldr	x25, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x25, x30]
	add	x25, x30, #1
	str	x25, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x25, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	132b
	ldp	q0, q1, [x27, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	132b
	ldp	q0, q1, [x27, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	132b
	ldp	q0, q1, [x27, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 132b
	ldp	q0, q1, [x27, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	132b
	ldp	q0, q1, [x27, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	132b
	ldp	q0, q1, [x27, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	132b
	ldp	q0, q1, [x27, #256]
	stp	q0, q1, [x28, #256]
	b	132b
302:
	ldr	x27, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w27, [x27, x30]
	str	x27, [sp, #8]
	add	x27, x30, #1
	str	x27, [x0, #120]
	ldr	x30, [sp, #8]
	ldp	q0, q1, [x28, #32]
	add	x27, x30, #33
	stp	q0, q1, [x29, #32]
	cmp	w30, #32
	b.lo	142b
	ldp	q0, q1, [x28, #64]
	stp	q0, q1, [x29, #64]
	cmp	w30, #64
	b.lo	142b
	ldp	q0, q1, [x28, #96]
	stp	q0, q1, [x29, #96]
	cmp	w30, #96
	b.lo	142b
	ldp	q0, q1, [x28, #128]
	stp	q0, q1, [x29, #128]
	tbz	w30, #7, 142b
	ldp	q0, q1, [x28, #160]
	stp	q0, q1, [x29, #160]
	cmp	w30, #160
	b.lo	142b
	ldp	q0, q1, [x28, #192]
	stp	q0, q1, [x29, #192]
	cmp	w30, #192
	b.lo	142b
	ldp	q0, q1, [x28, #224]
	stp	q0, q1, [x29, #224]
	cmp	w30, #224
	b.lo	142b
	ldp	q0, q1, [x28, #256]
	stp	q0, q1, [x29, #256]
	b	142b
312:
	ldr	x26, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x26, x30]
	add	x26, x30, #1
	str	x26, [x0, #120]
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
322:
	ldr	x28, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w28, [x28, x30]
	str	x28, [sp, #8]
	add	x28, x30, #1
	str	x28, [x0, #120]
	ldr	x30, [sp, #8]
	ldp	q0, q1, [x23, #32]
	add	x28, x30, #33
	stp	q0, q1, [x29, #32]
	cmp	w30, #32
	b.lo	162b
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x29, #64]
	cmp	w30, #64
	b.lo	162b
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x29, #96]
	cmp	w30, #96
	b.lo	162b
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x29, #128]
	tbz	w30, #7, 162b
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x29, #160]
	cmp	w30, #160
	b.lo	162b
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x29, #192]
	cmp	w30, #192
	b.lo	162b
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x29, #224]
	cmp	w30, #224
	b.lo	162b
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x29, #256]
	b	162b
332:
	ldr	x20, [x0, #48]
	ldr	x28, [x0, #120]
	ldrb	w27, [x20, x28]
	add	x20, x28, #1
	str	x20, [x0, #120]
	ldp	q0, q1, [x24, #32]
	add	x20, x27, #33
	stp	q0, q1, [x26, #32]
	cmp	w27, #32
	b.lo	172b
	ldp	q0, q1, [x24, #64]
	stp	q0, q1, [x26, #64]
	cmp	w27, #64
	b.lo	172b
	ldp	q0, q1, [x24, #96]
	stp	q0, q1, [x26, #96]
	cmp	w27, #96
	b.lo	172b
	ldp	q0, q1, [x24, #128]
	stp	q0, q1, [x26, #128]
	tbz	w27, #7, 172b
	ldp	q0, q1, [x24, #160]
	stp	q0, q1, [x26, #160]
	cmp	w27, #160
	b.lo	172b
	ldp	q0, q1, [x24, #192]
	stp	q0, q1, [x26, #192]
	cmp	w27, #192
	b.lo	172b
	ldp	q0, q1, [x24, #224]
	stp	q0, q1, [x26, #224]
	cmp	w27, #224
	b.lo	172b
	ldp	q0, q1, [x24, #256]
	stp	q0, q1, [x26, #256]
	b	172b
342:
	ldr	x7, [x0, #48]
	ldr	x28, [x0, #120]
	ldrb	w27, [x7, x28]
	add	x7, x28, #1
	str	x7, [x0, #120]
	ldp	q0, q1, [x25, #32]
	add	x7, x27, #33
	stp	q0, q1, [x26, #32]
	cmp	w27, #32
	b.lo	182b
	ldp	q0, q1, [x25, #64]
	stp	q0, q1, [x26, #64]
	cmp	w27, #64
	b.lo	182b
	ldp	q0, q1, [x25, #96]
	stp	q0, q1, [x26, #96]
	cmp	w27, #96
	b.lo	182b
	ldp	q0, q1, [x25, #128]
	stp	q0, q1, [x26, #128]
	tbz	w27, #7, 182b
	ldp	q0, q1, [x25, #160]
	stp	q0, q1, [x26, #160]
	cmp	w27, #160
	b.lo	182b
	ldp	q0, q1, [x25, #192]
	stp	q0, q1, [x26, #192]
	cmp	w27, #192
	b.lo	182b
	ldp	q0, q1, [x25, #224]
	stp	q0, q1, [x26, #224]
	cmp	w27, #224
	b.lo	182b
	ldp	q0, q1, [x25, #256]
	stp	q0, q1, [x26, #256]
	b	182b
352:
	mov	x16, xzr
	b	372f
362:
	cbz	x8, 432f
	neg	x16, x2
372:
	ldr	x15, [x15, x16]
	mov	w16, #32
	.p2align	5, , 16
382:
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
	b.hs	412f
392:
	and	x6, x15, #0xff
	add	x2, x1, x24
	lsr	x3, x6, #2
	add	x5, x9, x2
	cmp	x3, #32
	csel	x4, x3, x16, lo
	cmp	x21, x4
	csel	x4, x21, x4, hi
	subs	x4, x2, x4
	csel	x4, xzr, x4, lo
	add	x4, x9, x4
	ldp	q0, q1, [x4]
	stp	q0, q1, [x5]
	cmp	x6, #132
	b.hs	422f
402:
	lsr	x17, x17, #32
	add	x22, x1, x22
	add	x24, x3, x2
	subs	x8, x8, #1
	lsr	x15, x15, #8
	lsr	x13, x13, #8
	add	x23, x23, w17, uxtb
	lsr	x14, x14, #8
	b.ne	382b
	b	432f
412:
	ldr	x1, [x0, #48]
	ldr	x5, [x0, #120]
	ldrb	w4, [x1, x5]
	add	x1, x5, #1
	str	x1, [x0, #120]
	ldp	q0, q1, [x2, #32]
	add	x1, x4, #33
	stp	q0, q1, [x3, #32]
	cmp	w4, #32
	b.lo	392b
	ldp	q0, q1, [x2, #64]
	stp	q0, q1, [x3, #64]
	cmp	w4, #64
	b.lo	392b
	ldp	q0, q1, [x2, #96]
	stp	q0, q1, [x3, #96]
	cmp	w4, #96
	b.lo	392b
	ldp	q0, q1, [x2, #128]
	stp	q0, q1, [x3, #128]
	tbz	w4, #7, 392b
	ldp	q0, q1, [x2, #160]
	stp	q0, q1, [x3, #160]
	cmp	w4, #160
	b.lo	392b
	ldp	q0, q1, [x2, #192]
	stp	q0, q1, [x3, #192]
	cmp	w4, #192
	b.lo	392b
	ldp	q0, q1, [x2, #224]
	stp	q0, q1, [x3, #224]
	cmp	w4, #224
	b.lo	392b
	ldp	q0, q1, [x2, #256]
	stp	q0, q1, [x3, #256]
	b	392b
422:
	ldr	x3, [x0, #48]
	ldr	x7, [x0, #120]
	ldrb	w6, [x3, x7]
	add	x3, x7, #1
	str	x3, [x0, #120]
	ldp	q0, q1, [x4, #32]
	add	x3, x6, #33
	stp	q0, q1, [x5, #32]
	cmp	w6, #32
	b.lo	402b
	ldp	q0, q1, [x4, #64]
	stp	q0, q1, [x5, #64]
	cmp	w6, #64
	b.lo	402b
	ldp	q0, q1, [x4, #96]
	stp	q0, q1, [x5, #96]
	cmp	w6, #96
	b.lo	402b
	ldp	q0, q1, [x4, #128]
	stp	q0, q1, [x5, #128]
	tbz	w6, #7, 402b
	ldp	q0, q1, [x4, #160]
	stp	q0, q1, [x5, #160]
	cmp	w6, #160
	b.lo	402b
	ldp	q0, q1, [x4, #192]
	stp	q0, q1, [x5, #192]
	cmp	w6, #192
	b.lo	402b
	ldp	q0, q1, [x4, #224]
	stp	q0, q1, [x5, #224]
	cmp	w6, #224
	b.lo	402b
	ldp	q0, q1, [x4, #256]
	stp	q0, q1, [x5, #256]
	b	402b
432:
	stp	x24, x22, [x0, #80]
	str	x21, [x0, #96]
	ldp	x20, x19, [sp, #96]
	ldp	x22, x21, [sp, #80]
	ldp	x24, x23, [sp, #64]
	ldp	x26, x25, [sp, #48]
	ldp	x28, x27, [sp, #32]
	ldp	x29, x30, [sp, #16]
	add	sp, sp, #112
442:
	ret

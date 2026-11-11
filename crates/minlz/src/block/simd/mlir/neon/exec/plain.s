// minlz_exec_plain of crates/minlz/mlir/exec8.mlir for neon, written by
// cargo xtask mlir. Do not edit.
	ldr	x8, [x0, #64]
	mov	x16, #72340172838076673
	//APP
	//NO_APP
	cbz	x8, 712f
	stp	x29, x30, [sp, #-96]!
	ldp	x15, x17, [x0, #16]
	ldp	x1, x11, [x0, #32]
	stp	x24, x23, [sp, #48]
	stp	x22, x21, [sp, #64]
	ldp	x9, x10, [x0]
	ldr	x12, [x0, #56]
	ldr	x14, [x15]
	ldr	d0, [x17]
	ldp	x22, x21, [x0, #88]
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
	b.lo	592f
	lsr	x3, x3, #56
	lsr	x4, x4, #56
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
	lsr	x27, x23, #3
	ubfiz	x25, x19, #3, #8
	and	x28, x23, #0x7
	ldr	x7, [x6]
	and	x26, x20, #0xff
	ldr	x27, [x11, x27]
	ldr	x25, [x12, x25]
	lsr	x27, x27, x28
	add	x28, x9, x24
	and	w27, w25, w27
	adds	x27, x27, x25, lsr #40
	csel	x21, x21, x27, eq
	add	x27, x10, x22
	ldp	q0, q1, [x27]
	stp	q0, q1, [x28]
	cmp	x26, #33
	b.hs	222f
32:
	ubfx	x27, x7, #2, #6
	add	x24, x26, x24
	cmp	x21, x27
	ccmp	x24, x21, #0, hs
	b.lo	302f
	sub	x29, x24, x21
	mov	x30, x21
42:
	add	x28, x9, x29
	ldp	q0, q1, [x28]
	add	x28, x9, x24
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.hs	312f
52:
	lsr	x5, x25, #32
	add	x22, x26, x22
	add	x26, x27, x24
	ubfx	x25, x20, #8, #8
	add	x23, x23, w5, uxtb
	lsr	x5, x19, #5
	add	x28, x9, x26
	and	x5, x5, #0x7f8
	ldr	x24, [x12, x5]
	lsr	x5, x23, #3
	and	x27, x23, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x27
	add	x27, x10, x22
	ldp	q0, q1, [x27]
	and	w5, w24, w5
	adds	x5, x5, x24, lsr #40
	csel	x21, x21, x5, eq
	stp	q0, q1, [x28]
	cmp	x25, #33
	b.hs	232f
62:
	ubfx	x27, x7, #10, #6
	add	x26, x25, x26
	cmp	x21, x27
	ccmp	x26, x21, #0, hs
	b.lo	332f
	sub	x29, x26, x21
	mov	x30, x21
72:
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.hs	342f
82:
	lsr	x5, x24, #32
	add	x22, x25, x22
	add	x27, x27, x26
	ubfx	x26, x20, #16, #8
	add	x24, x23, w5, uxtb
	lsr	x5, x19, #13
	add	x28, x9, x27
	and	x5, x5, #0x7f8
	ldr	x25, [x12, x5]
	lsr	x5, x24, #3
	and	x23, x24, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x23
	and	w5, w25, w5
	adds	x5, x5, x25, lsr #40
	csel	x23, x21, x5, eq
	add	x21, x10, x22
	ldp	q0, q1, [x21]
	stp	q0, q1, [x28]
	cmp	x26, #33
	b.hs	242f
92:
	ubfx	x28, x7, #18, #6
	add	x27, x26, x27
	cmp	x23, x28
	ccmp	x27, x23, #0, hs
	b.lo	362f
	sub	x29, x27, x23
	mov	x30, x23
102:
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	add	x21, x9, x27
	stp	q0, q1, [x21]
	cmp	x28, #33
	b.hs	372f
112:
	lsr	x5, x25, #32
	add	x21, x26, x22
	add	x26, x28, x27
	add	x22, x24, w5, uxtb
	lsr	x5, x19, #21
	lsr	w24, w20, #24
	add	x28, x9, x26
	and	x5, x5, #0x7f8
	ldr	x25, [x12, x5]
	lsr	x5, x22, #3
	and	x27, x22, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x27
	add	x27, x10, x21
	ldp	q0, q1, [x27]
	and	w5, w25, w5
	adds	x5, x5, x25, lsr #40
	csel	x23, x23, x5, eq
	stp	q0, q1, [x28]
	cmp	x24, #33
	b.hs	252f
122:
	add	x26, x24, x26
	lsr	w27, w7, #26
	cmp	x23, x27
	b.lo	392f
	subs	x29, x26, x23
	b.lo	392f
	add	x5, x9, x29
	mov	x30, x23
	ldp	q0, q1, [x5]
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.hs	452f
132:
	lsr	x5, x25, #32
	add	x24, x24, x21
	add	x27, x27, x26
	ubfx	x26, x20, #32, #8
	add	x22, x22, w5, uxtb
	lsr	x5, x19, #29
	add	x28, x9, x27
	and	x5, x5, #0x7f8
	ldr	x25, [x12, x5]
	lsr	x5, x22, #3
	and	x21, x22, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x21
	and	w5, w25, w5
	adds	x5, x5, x25, lsr #40
	csel	x21, x23, x5, eq
	add	x23, x10, x24
	ldp	q0, q1, [x23]
	stp	q0, q1, [x28]
	cmp	x26, #33
	b.hs	262f
142:
	add	x27, x26, x27
	ubfx	x28, x7, #34, #6
	cmp	x21, x28
	b.lo	402f
	subs	x29, x27, x21
	b.lo	402f
	add	x5, x9, x29
	mov	x30, x21
	ldp	q0, q1, [x5]
	add	x23, x9, x27
	stp	q0, q1, [x23]
	cmp	x28, #33
	b.hs	482f
152:
	lsr	x5, x25, #32
	add	x23, x26, x24
	add	x26, x28, x27
	ubfx	x25, x20, #40, #8
	add	x22, x22, w5, uxtb
	lsr	x5, x19, #37
	add	x28, x9, x26
	and	x5, x5, #0x7f8
	ldr	x24, [x12, x5]
	lsr	x5, x22, #3
	and	x27, x22, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x27
	add	x27, x10, x23
	ldp	q0, q1, [x27]
	and	w5, w24, w5
	adds	x5, x5, x24, lsr #40
	csel	x21, x21, x5, eq
	stp	q0, q1, [x28]
	cmp	x25, #33
	b.hs	272f
162:
	add	x26, x25, x26
	ubfx	x27, x7, #42, #6
	cmp	x21, x27
	b.lo	412f
	subs	x29, x26, x21
	b.lo	412f
	add	x5, x9, x29
	mov	x30, x21
	ldp	q0, q1, [x5]
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.hs	512f
172:
	lsr	x5, x24, #32
	add	x23, x25, x23
	add	x26, x27, x26
	add	x24, x22, w5, uxtb
	lsr	x5, x19, #45
	ubfx	x22, x20, #48, #8
	add	x28, x9, x26
	and	x5, x5, #0x7f8
	ldr	x25, [x12, x5]
	lsr	x5, x24, #3
	and	x27, x24, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x27
	add	x27, x10, x23
	ldp	q0, q1, [x27]
	and	w5, w25, w5
	adds	x5, x5, x25, lsr #40
	csel	x21, x21, x5, eq
	stp	q0, q1, [x28]
	cmp	x22, #33
	b.hs	282f
182:
	add	x26, x22, x26
	ubfx	x27, x7, #50, #6
	cmp	x21, x27
	b.lo	422f
	subs	x29, x26, x21
	b.lo	422f
	add	x5, x9, x29
	mov	x30, x21
	ldp	q0, q1, [x5]
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.hs	542f
192:
	lsr	x5, x25, #32
	add	x22, x22, x23
	lsr	x20, x20, #56
	add	x23, x24, w5, uxtb
	lsr	x5, x19, #53
	add	x24, x27, x26
	and	x5, x5, #0x7f8
	add	x26, x9, x24
	ldr	x19, [x12, x5]
	lsr	x5, x23, #3
	and	x25, x23, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x25
	add	x25, x10, x22
	ldp	q0, q1, [x25]
	and	w5, w19, w5
	adds	x5, x5, x19, lsr #40
	csel	x21, x21, x5, eq
	stp	q0, q1, [x26]
	cmp	x20, #33
	b.hs	292f
202:
	add	x24, x20, x24
	lsr	x7, x7, #58
	cmp	x21, x7
	b.lo	432f
	subs	x26, x24, x21
	b.lo	432f
	add	x5, x9, x26
	mov	x27, x21
	ldp	q0, q1, [x5]
	add	x25, x9, x24
	stp	q0, q1, [x25]
	cmp	x7, #33
	b.hs	572f
212:
	lsr	x5, x19, #32
	add	x22, x20, x22
	add	x24, x7, x24
	sub	x2, x2, #8
	add	x6, x6, #8
	add	x23, x23, w5, uxtb
	cmp	x8, #7
	b.hi	2b
	b	602f
222:
	ldr	x26, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x26, x30]
	add	x26, x30, #1
	str	x26, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x26, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	32b
	ldp	q0, q1, [x27, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	32b
	ldp	q0, q1, [x27, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	32b
	ldp	q0, q1, [x27, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 32b
	ldp	q0, q1, [x27, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	32b
	ldp	q0, q1, [x27, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	32b
	ldp	q0, q1, [x27, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	32b
	ldp	q0, q1, [x27, #256]
	stp	q0, q1, [x28, #256]
	b	32b
232:
	ldr	x5, [x0, #48]
	ldr	x25, [x0, #120]
	ldrb	w29, [x5, x25]
	add	x5, x25, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x25, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	62b
	ldp	q0, q1, [x27, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	62b
	ldp	q0, q1, [x27, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	62b
	ldp	q0, q1, [x27, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 62b
	ldp	q0, q1, [x27, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	62b
	ldp	q0, q1, [x27, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	62b
	ldp	q0, q1, [x27, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	62b
	ldp	q0, q1, [x27, #256]
	stp	q0, q1, [x28, #256]
	b	62b
242:
	ldr	x5, [x0, #48]
	ldr	x26, [x0, #120]
	ldrb	w29, [x5, x26]
	add	x5, x26, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x21, #32]
	add	x26, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	92b
	ldp	q0, q1, [x21, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	92b
	ldp	q0, q1, [x21, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	92b
	ldp	q0, q1, [x21, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 92b
	ldp	q0, q1, [x21, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	92b
	ldp	q0, q1, [x21, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	92b
	ldp	q0, q1, [x21, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	92b
	ldp	q0, q1, [x21, #256]
	stp	q0, q1, [x28, #256]
	b	92b
252:
	ldr	x5, [x0, #48]
	ldr	x24, [x0, #120]
	ldrb	w29, [x5, x24]
	add	x5, x24, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x24, x29, #33
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
262:
	ldr	x5, [x0, #48]
	ldr	x26, [x0, #120]
	ldrb	w29, [x5, x26]
	add	x5, x26, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x23, #32]
	add	x26, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	142b
	ldp	q0, q1, [x23, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	142b
	ldp	q0, q1, [x23, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	142b
	ldp	q0, q1, [x23, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 142b
	ldp	q0, q1, [x23, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	142b
	ldp	q0, q1, [x23, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	142b
	ldp	q0, q1, [x23, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	142b
	ldp	q0, q1, [x23, #256]
	stp	q0, q1, [x28, #256]
	b	142b
272:
	ldr	x5, [x0, #48]
	ldr	x25, [x0, #120]
	ldrb	w29, [x5, x25]
	add	x5, x25, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x25, x29, #33
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
282:
	ldr	x5, [x0, #48]
	ldr	x22, [x0, #120]
	ldrb	w29, [x5, x22]
	add	x5, x22, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x22, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	182b
	ldp	q0, q1, [x27, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	182b
	ldp	q0, q1, [x27, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	182b
	ldp	q0, q1, [x27, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 182b
	ldp	q0, q1, [x27, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	182b
	ldp	q0, q1, [x27, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	182b
	ldp	q0, q1, [x27, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	182b
	ldp	q0, q1, [x27, #256]
	stp	q0, q1, [x28, #256]
	b	182b
292:
	ldr	x5, [x0, #48]
	ldr	x20, [x0, #120]
	ldrb	w27, [x5, x20]
	add	x5, x20, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x25, #32]
	add	x20, x27, #33
	stp	q0, q1, [x26, #32]
	cmp	w27, #32
	b.lo	202b
	ldp	q0, q1, [x25, #64]
	stp	q0, q1, [x26, #64]
	cmp	w27, #64
	b.lo	202b
	ldp	q0, q1, [x25, #96]
	stp	q0, q1, [x26, #96]
	cmp	w27, #96
	b.lo	202b
	ldp	q0, q1, [x25, #128]
	stp	q0, q1, [x26, #128]
	tbz	w27, #7, 202b
	ldp	q0, q1, [x25, #160]
	stp	q0, q1, [x26, #160]
	cmp	w27, #160
	b.lo	202b
	ldp	q0, q1, [x25, #192]
	stp	q0, q1, [x26, #192]
	cmp	w27, #192
	b.lo	202b
	ldp	q0, q1, [x25, #224]
	stp	q0, q1, [x26, #224]
	cmp	w27, #224
	b.lo	202b
	ldp	q0, q1, [x25, #256]
	stp	q0, q1, [x26, #256]
	b	202b
302:
	cmp	x21, x24
	csel	x30, x21, x24, lo
	sub	x29, x24, x30
	cmp	x30, x27
	b.hs	42b
	ldr	x28, [x0, #56]
	add	x28, x28, x30, lsl #5
	ldr	q1, [x28, #2064]
	ldr	q0, [x28, #2048]
	add	x28, x9, x29
	ldp	q2, q3, [x28]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	add	x28, x9, x24
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.lo	52b
312:
	cmp	x30, #31
	b.hi	322f
	mov	w5, #1
	str	x5, [x0, #104]
322:
	ldr	x27, [x0, #48]
	ldr	x5, [x0, #120]
	add	x29, x9, x29
	ldrb	w30, [x27, x5]
	add	x5, x5, #1
	add	x27, x30, #33
	str	x5, [x0, #120]
	ldp	q0, q1, [x29, #32]
	stp	q0, q1, [x28, #32]
	cmp	w30, #32
	b.lo	52b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x28, #64]
	cmp	w30, #64
	b.lo	52b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x28, #96]
	cmp	w30, #96
	b.lo	52b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x28, #128]
	tbz	w30, #7, 52b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x28, #160]
	cmp	w30, #160
	b.lo	52b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x28, #192]
	cmp	w30, #192
	b.lo	52b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x28, #224]
	cmp	w30, #224
	b.lo	52b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x28, #256]
	b	52b
332:
	cmp	x21, x26
	csel	x30, x21, x26, lo
	sub	x29, x26, x30
	cmp	x30, x27
	b.hs	72b
	ldr	x5, [x0, #56]
	add	x5, x5, x30, lsl #5
	ldr	q1, [x5, #2064]
	ldr	q0, [x5, #2048]
	add	x5, x9, x29
	ldp	q2, q3, [x5]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.lo	82b
342:
	cmp	x30, #31
	b.hi	352f
	mov	w5, #1
	str	x5, [x0, #104]
352:
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
	b.lo	82b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x28, #64]
	cmp	w30, #64
	b.lo	82b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x28, #96]
	cmp	w30, #96
	b.lo	82b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x28, #128]
	tbz	w30, #7, 82b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x28, #160]
	cmp	w30, #160
	b.lo	82b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x28, #192]
	cmp	w30, #192
	b.lo	82b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x28, #224]
	cmp	w30, #224
	b.lo	82b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x28, #256]
	b	82b
362:
	cmp	x23, x27
	csel	x30, x23, x27, lo
	sub	x29, x27, x30
	cmp	x30, x28
	b.hs	102b
	ldr	x5, [x0, #56]
	add	x5, x5, x30, lsl #5
	ldr	q1, [x5, #2064]
	ldr	q0, [x5, #2048]
	add	x5, x9, x29
	ldp	q2, q3, [x5]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	add	x21, x9, x27
	stp	q0, q1, [x21]
	cmp	x28, #33
	b.lo	112b
372:
	cmp	x30, #31
	b.hi	382f
	mov	w5, #1
	str	x5, [x0, #104]
382:
	ldr	x5, [x0, #48]
	ldr	x28, [x0, #120]
	add	x29, x9, x29
	ldrb	w30, [x5, x28]
	add	x5, x28, #1
	add	x28, x30, #33
	str	x5, [x0, #120]
	ldp	q0, q1, [x29, #32]
	stp	q0, q1, [x21, #32]
	cmp	w30, #32
	b.lo	112b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x21, #64]
	cmp	w30, #64
	b.lo	112b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x21, #96]
	cmp	w30, #96
	b.lo	112b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x21, #128]
	tbz	w30, #7, 112b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x21, #160]
	cmp	w30, #160
	b.lo	112b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x21, #192]
	cmp	w30, #192
	b.lo	112b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x21, #224]
	cmp	w30, #224
	b.lo	112b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x21, #256]
	b	112b
392:
	cmp	x23, x26
	csel	x30, x23, x26, lo
	sub	x29, x26, x30
	cmp	x30, x27
	b.hs	442f
	ldr	x5, [x0, #56]
	add	x5, x5, x30, lsl #5
	ldr	q1, [x5, #2064]
	ldr	q0, [x5, #2048]
	add	x5, x9, x29
	ldp	q2, q3, [x5]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.lo	132b
	b	452f
402:
	cmp	x21, x27
	csel	x30, x21, x27, lo
	sub	x29, x27, x30
	cmp	x30, x28
	b.hs	472f
	ldr	x5, [x0, #56]
	add	x5, x5, x30, lsl #5
	ldr	q1, [x5, #2064]
	ldr	q0, [x5, #2048]
	add	x5, x9, x29
	ldp	q2, q3, [x5]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	add	x23, x9, x27
	stp	q0, q1, [x23]
	cmp	x28, #33
	b.lo	152b
	b	482f
412:
	cmp	x21, x26
	csel	x30, x21, x26, lo
	sub	x29, x26, x30
	cmp	x30, x27
	b.hs	502f
	ldr	x5, [x0, #56]
	add	x5, x5, x30, lsl #5
	ldr	q1, [x5, #2064]
	ldr	q0, [x5, #2048]
	add	x5, x9, x29
	ldp	q2, q3, [x5]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.lo	172b
	b	512f
422:
	cmp	x21, x26
	csel	x30, x21, x26, lo
	sub	x29, x26, x30
	cmp	x30, x27
	b.hs	532f
	ldr	x5, [x0, #56]
	add	x5, x5, x30, lsl #5
	ldr	q1, [x5, #2064]
	ldr	q0, [x5, #2048]
	add	x5, x9, x29
	ldp	q2, q3, [x5]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.lo	192b
	b	542f
432:
	cmp	x21, x24
	csel	x27, x21, x24, lo
	sub	x26, x24, x27
	cmp	x27, x7
	b.hs	562f
	ldr	x5, [x0, #56]
	add	x5, x5, x27, lsl #5
	ldr	q1, [x5, #2064]
	ldr	q0, [x5, #2048]
	add	x5, x9, x26
	ldp	q2, q3, [x5]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	add	x25, x9, x24
	stp	q0, q1, [x25]
	cmp	x7, #33
	b.lo	212b
	b	572f
442:
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.lo	132b
452:
	cmp	x30, #31
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
	b.lo	132b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x28, #64]
	cmp	w30, #64
	b.lo	132b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x28, #96]
	cmp	w30, #96
	b.lo	132b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x28, #128]
	tbz	w30, #7, 132b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x28, #160]
	cmp	w30, #160
	b.lo	132b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x28, #192]
	cmp	w30, #192
	b.lo	132b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x28, #224]
	cmp	w30, #224
	b.lo	132b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x28, #256]
	b	132b
472:
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	add	x23, x9, x27
	stp	q0, q1, [x23]
	cmp	x28, #33
	b.lo	152b
482:
	cmp	x30, #31
	b.hi	492f
	mov	w5, #1
	str	x5, [x0, #104]
492:
	ldr	x5, [x0, #48]
	ldr	x28, [x0, #120]
	add	x29, x9, x29
	ldrb	w30, [x5, x28]
	add	x5, x28, #1
	add	x28, x30, #33
	str	x5, [x0, #120]
	ldp	q0, q1, [x29, #32]
	stp	q0, q1, [x23, #32]
	cmp	w30, #32
	b.lo	152b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x23, #64]
	cmp	w30, #64
	b.lo	152b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x23, #96]
	cmp	w30, #96
	b.lo	152b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x23, #128]
	tbz	w30, #7, 152b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x23, #160]
	cmp	w30, #160
	b.lo	152b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x23, #192]
	cmp	w30, #192
	b.lo	152b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x23, #224]
	cmp	w30, #224
	b.lo	152b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x23, #256]
	b	152b
502:
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.lo	172b
512:
	cmp	x30, #31
	b.hi	522f
	mov	w5, #1
	str	x5, [x0, #104]
522:
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
	b.lo	172b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x28, #64]
	cmp	w30, #64
	b.lo	172b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x28, #96]
	cmp	w30, #96
	b.lo	172b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x28, #128]
	tbz	w30, #7, 172b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x28, #160]
	cmp	w30, #160
	b.lo	172b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x28, #192]
	cmp	w30, #192
	b.lo	172b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x28, #224]
	cmp	w30, #224
	b.lo	172b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x28, #256]
	b	172b
532:
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.lo	192b
542:
	cmp	x30, #31
	b.hi	552f
	mov	w5, #1
	str	x5, [x0, #104]
552:
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
	b.lo	192b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x28, #64]
	cmp	w30, #64
	b.lo	192b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x28, #96]
	cmp	w30, #96
	b.lo	192b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x28, #128]
	tbz	w30, #7, 192b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x28, #160]
	cmp	w30, #160
	b.lo	192b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x28, #192]
	cmp	w30, #192
	b.lo	192b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x28, #224]
	cmp	w30, #224
	b.lo	192b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x28, #256]
	b	192b
562:
	add	x5, x9, x26
	ldp	q0, q1, [x5]
	add	x25, x9, x24
	stp	q0, q1, [x25]
	cmp	x7, #33
	b.lo	212b
572:
	cmp	x27, #31
	b.hi	582f
	mov	w5, #1
	str	x5, [x0, #104]
582:
	ldr	x5, [x0, #48]
	ldr	x7, [x0, #120]
	add	x26, x9, x26
	ldrb	w27, [x5, x7]
	add	x5, x7, #1
	add	x7, x27, #33
	str	x5, [x0, #120]
	ldp	q0, q1, [x26, #32]
	stp	q0, q1, [x25, #32]
	cmp	w27, #32
	b.lo	212b
	ldp	q0, q1, [x26, #64]
	stp	q0, q1, [x25, #64]
	cmp	w27, #64
	b.lo	212b
	ldp	q0, q1, [x26, #96]
	stp	q0, q1, [x25, #96]
	cmp	w27, #96
	b.lo	212b
	ldp	q0, q1, [x26, #128]
	stp	q0, q1, [x25, #128]
	tbz	w27, #7, 212b
	ldp	q0, q1, [x26, #160]
	stp	q0, q1, [x25, #160]
	cmp	w27, #160
	b.lo	212b
	ldp	q0, q1, [x26, #192]
	stp	q0, q1, [x25, #192]
	cmp	w27, #192
	b.lo	212b
	ldp	q0, q1, [x26, #224]
	stp	q0, q1, [x25, #224]
	cmp	w27, #224
	b.lo	212b
	ldp	q0, q1, [x26, #256]
	stp	q0, q1, [x25, #256]
	b	212b
592:
	mov	x16, xzr
	b	612f
602:
	cbz	x8, 702f
	neg	x16, x2
612:
	ldr	x15, [x15, x16]
	mov	w16, #1
	.p2align	5, , 16
622:
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
	b.hs	662f
632:
	ubfx	x3, x15, #2, #6
	add	x2, x1, x24
	cmp	x21, x3
	ccmp	x2, x21, #0, hs
	b.lo	672f
	sub	x5, x2, x21
	mov	x6, x21
642:
	add	x4, x9, x5
	ldp	q0, q1, [x4]
	add	x4, x9, x2
	stp	q0, q1, [x4]
	cmp	x3, #33
	b.hs	682f
652:
	lsr	x17, x17, #32
	add	x22, x1, x22
	add	x24, x3, x2
	subs	x8, x8, #1
	lsr	x15, x15, #8
	lsr	x13, x13, #8
	add	x23, x23, w17, uxtb
	lsr	x14, x14, #8
	b.ne	622b
	b	702f
662:
	ldr	x1, [x0, #48]
	ldr	x5, [x0, #120]
	ldrb	w4, [x1, x5]
	add	x1, x5, #1
	str	x1, [x0, #120]
	ldp	q0, q1, [x2, #32]
	add	x1, x4, #33
	stp	q0, q1, [x3, #32]
	cmp	w4, #32
	b.lo	632b
	ldp	q0, q1, [x2, #64]
	stp	q0, q1, [x3, #64]
	cmp	w4, #64
	b.lo	632b
	ldp	q0, q1, [x2, #96]
	stp	q0, q1, [x3, #96]
	cmp	w4, #96
	b.lo	632b
	ldp	q0, q1, [x2, #128]
	stp	q0, q1, [x3, #128]
	tbz	w4, #7, 632b
	ldp	q0, q1, [x2, #160]
	stp	q0, q1, [x3, #160]
	cmp	w4, #160
	b.lo	632b
	ldp	q0, q1, [x2, #192]
	stp	q0, q1, [x3, #192]
	cmp	w4, #192
	b.lo	632b
	ldp	q0, q1, [x2, #224]
	stp	q0, q1, [x3, #224]
	cmp	w4, #224
	b.lo	632b
	ldp	q0, q1, [x2, #256]
	stp	q0, q1, [x3, #256]
	b	632b
672:
	cmp	x21, x2
	csel	x6, x21, x2, lo
	sub	x5, x2, x6
	cmp	x6, x3
	b.hs	642b
	ldr	x4, [x0, #56]
	add	x4, x4, x6, lsl #5
	ldr	q1, [x4, #2064]
	ldr	q0, [x4, #2048]
	add	x4, x9, x5
	ldp	q2, q3, [x4]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	add	x4, x9, x2
	stp	q0, q1, [x4]
	cmp	x3, #33
	b.lo	652b
682:
	cmp	x6, #31
	b.hi	692f
	str	x16, [x0, #104]
692:
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
	b.lo	652b
	ldp	q0, q1, [x5, #64]
	stp	q0, q1, [x4, #64]
	cmp	w6, #64
	b.lo	652b
	ldp	q0, q1, [x5, #96]
	stp	q0, q1, [x4, #96]
	cmp	w6, #96
	b.lo	652b
	ldp	q0, q1, [x5, #128]
	stp	q0, q1, [x4, #128]
	tbz	w6, #7, 652b
	ldp	q0, q1, [x5, #160]
	stp	q0, q1, [x4, #160]
	cmp	w6, #160
	b.lo	652b
	ldp	q0, q1, [x5, #192]
	stp	q0, q1, [x4, #192]
	cmp	w6, #192
	b.lo	652b
	ldp	q0, q1, [x5, #224]
	stp	q0, q1, [x4, #224]
	cmp	w6, #224
	b.lo	652b
	ldp	q0, q1, [x5, #256]
	stp	q0, q1, [x4, #256]
	b	652b
702:
	stp	x24, x22, [x0, #80]
	str	x21, [x0, #96]
	ldp	x20, x19, [sp, #80]
	ldp	x22, x21, [sp, #64]
	ldp	x24, x23, [sp, #48]
	ldp	x26, x25, [sp, #32]
	ldp	x28, x27, [sp, #16]
	ldp	x29, x30, [sp], #96
712:
	ret

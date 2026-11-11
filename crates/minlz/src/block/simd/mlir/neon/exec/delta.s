// minlz_exec_delta of crates/minlz/mlir/exec8.mlir for neon, written by
// cargo xtask mlir. Do not edit.
	ldr	x8, [x0, #64]
	mov	x16, #72340172838076673
	//APP
	//NO_APP
	cbz	x8, 892f
	stp	x29, x30, [sp, #-96]!
	ldp	x15, x17, [x0, #16]
	ldp	x1, x11, [x0, #32]
	stp	x24, x23, [sp, #48]
	stp	x22, x21, [sp, #64]
	ldp	x9, x10, [x0]
	ldr	x12, [x0, #56]
	ldr	x14, [x15]
	ldr	d0, [x17]
	ldp	x21, x22, [x0, #88]
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
	b.lo	752f
	lsr	x3, x3, #56
	lsr	x4, x4, #56
	mov	x2, xzr
	mov	x6, x15
	.p2align	5, , 16
2:
	subs	x8, x8, #8
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
	ubfiz	x7, x20, #3, #8
	and	x25, x23, #0x7
	ldr	x26, [x12, x7]
	lsr	x7, x23, #3
	ldr	x7, [x11, x7]
	lsr	x7, x7, x25
	and	w7, w26, w7
	adds	x7, x7, x26, lsr #40
	csel	x25, x22, x7, eq
	cmp	x22, x24
	csel	x22, x22, x24, lo
	sub	x7, x24, x22
	cmp	x22, #31
	b.ls	292f
	add	x7, x9, x7
	ldp	q0, q1, [x7]
32:
	add	x27, x10, x21
	ldr	x7, [x6]
	and	x22, x19, #0xff
	add	x28, x9, x24
	ldp	q3, q2, [x27]
	add	v1.16b, v1.16b, v2.16b
	add	v0.16b, v0.16b, v3.16b
	stp	q0, q1, [x28]
	cmp	x22, #33
	b.hs	302f
42:
	ubfx	x28, x7, #2, #6
	add	x27, x22, x24
	cmp	x25, x28
	ccmp	x27, x25, #0, hs
	b.lo	452f
	sub	x29, x27, x25
	mov	x30, x25
52:
	add	x24, x9, x29
	ldp	q0, q1, [x24]
	add	x24, x9, x27
	stp	q0, q1, [x24]
	cmp	x28, #33
	b.hs	462f
62:
	lsr	x5, x26, #32
	add	x22, x22, x21
	add	x27, x28, x27
	add	x24, x23, w5, uxtb
	lsr	x5, x20, #5
	add	x28, x10, x22
	and	x5, x5, #0x7f8
	ldp	q0, q1, [x28]
	ldr	x26, [x12, x5]
	lsr	x5, x24, #3
	and	x21, x24, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x21
	and	w5, w26, w5
	adds	x5, x5, x26, lsr #40
	csel	x21, x25, x5, eq
	cmp	x25, x27
	csel	x25, x25, x27, lo
	sub	x23, x27, x25
	cmp	x25, #31
	b.ls	312f
	add	x5, x9, x23
	ldp	q2, q3, [x5]
72:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	ubfx	x23, x19, #8, #8
	add	x25, x9, x27
	stp	q0, q1, [x25]
	cmp	x23, #33
	b.hs	322f
82:
	add	x25, x23, x27
	ubfx	x27, x7, #10, #6
	cmp	x21, x27
	ccmp	x25, x21, #0, hs
	b.lo	482f
	sub	x29, x25, x21
	mov	x30, x21
92:
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	add	x28, x9, x25
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.hs	492f
102:
	lsr	x5, x26, #32
	add	x26, x27, x25
	add	x23, x23, x22
	add	x24, x24, w5, uxtb
	lsr	x5, x20, #13
	add	x27, x10, x23
	and	x5, x5, #0x7f8
	ldp	q0, q1, [x27]
	ldr	x25, [x12, x5]
	lsr	x5, x24, #3
	and	x22, x24, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x22
	and	w5, w25, w5
	adds	x5, x5, x25, lsr #40
	csel	x22, x21, x5, eq
	cmp	x21, x26
	csel	x28, x21, x26, lo
	sub	x21, x26, x28
	cmp	x28, #31
	b.ls	332f
	add	x5, x9, x21
	ldp	q2, q3, [x5]
112:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	ubfx	x21, x19, #16, #8
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x21, #33
	b.hs	342f
122:
	add	x26, x21, x26
	ubfx	x27, x7, #18, #6
	cmp	x22, x27
	b.lo	512f
	subs	x29, x26, x22
	b.lo	512f
	add	x5, x9, x29
	mov	x30, x22
	ldp	q0, q1, [x5]
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.hs	582f
132:
	lsr	x5, x25, #32
	add	x23, x21, x23
	add	x26, x27, x26
	add	x24, x24, w5, uxtb
	lsr	x5, x20, #21
	add	x27, x10, x23
	and	x5, x5, #0x7f8
	ldp	q0, q1, [x27]
	ldr	x25, [x12, x5]
	lsr	x5, x24, #3
	and	x21, x24, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x21
	and	w5, w25, w5
	adds	x5, x5, x25, lsr #40
	csel	x21, x22, x5, eq
	cmp	x22, x26
	csel	x28, x22, x26, lo
	sub	x22, x26, x28
	cmp	x28, #31
	b.ls	352f
	add	x5, x9, x22
	ldp	q2, q3, [x5]
142:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	lsr	w22, w19, #24
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x22, #33
	b.hs	362f
152:
	add	x26, x22, x26
	lsr	w27, w7, #26
	cmp	x21, x27
	b.lo	522f
	subs	x29, x26, x21
	b.lo	522f
	add	x5, x9, x29
	mov	x30, x21
	ldp	q0, q1, [x5]
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.hs	612f
162:
	lsr	x5, x25, #32
	add	x23, x22, x23
	add	x26, x27, x26
	add	x24, x24, w5, uxtb
	lsr	x5, x20, #29
	add	x27, x10, x23
	and	x5, x5, #0x7f8
	ldp	q0, q1, [x27]
	ldr	x25, [x12, x5]
	lsr	x5, x24, #3
	and	x22, x24, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x22
	and	w5, w25, w5
	adds	x5, x5, x25, lsr #40
	csel	x22, x21, x5, eq
	cmp	x21, x26
	csel	x28, x21, x26, lo
	sub	x21, x26, x28
	cmp	x28, #31
	b.ls	372f
	add	x5, x9, x21
	ldp	q2, q3, [x5]
172:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	ubfx	x21, x19, #32, #8
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x21, #33
	b.hs	382f
182:
	add	x26, x21, x26
	ubfx	x27, x7, #34, #6
	cmp	x22, x27
	b.lo	532f
	subs	x29, x26, x22
	b.lo	532f
	add	x5, x9, x29
	mov	x30, x22
	ldp	q0, q1, [x5]
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.hs	642f
192:
	lsr	x5, x25, #32
	add	x23, x21, x23
	add	x26, x27, x26
	add	x24, x24, w5, uxtb
	lsr	x5, x20, #37
	add	x27, x10, x23
	and	x5, x5, #0x7f8
	ldp	q0, q1, [x27]
	ldr	x25, [x12, x5]
	lsr	x5, x24, #3
	and	x21, x24, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x21
	and	w5, w25, w5
	adds	x5, x5, x25, lsr #40
	csel	x21, x22, x5, eq
	cmp	x22, x26
	csel	x28, x22, x26, lo
	sub	x22, x26, x28
	cmp	x28, #31
	b.ls	392f
	add	x5, x9, x22
	ldp	q2, q3, [x5]
202:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	ubfx	x22, x19, #40, #8
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x22, #33
	b.hs	402f
212:
	add	x26, x22, x26
	ubfx	x27, x7, #42, #6
	cmp	x21, x27
	b.lo	542f
	subs	x29, x26, x21
	b.lo	542f
	add	x5, x9, x29
	mov	x30, x21
	ldp	q0, q1, [x5]
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.hs	672f
222:
	lsr	x5, x25, #32
	add	x22, x22, x23
	add	x26, x27, x26
	add	x24, x24, w5, uxtb
	lsr	x5, x20, #45
	add	x27, x10, x22
	and	x5, x5, #0x7f8
	ldp	q0, q1, [x27]
	ldr	x25, [x12, x5]
	lsr	x5, x24, #3
	and	x23, x24, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x23
	and	w5, w25, w5
	adds	x5, x5, x25, lsr #40
	csel	x23, x21, x5, eq
	cmp	x21, x26
	csel	x28, x21, x26, lo
	sub	x21, x26, x28
	cmp	x28, #31
	b.ls	412f
	add	x5, x9, x21
	ldp	q2, q3, [x5]
232:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	ubfx	x21, x19, #48, #8
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x21, #33
	b.hs	422f
242:
	add	x26, x21, x26
	ubfx	x27, x7, #50, #6
	cmp	x23, x27
	b.lo	552f
	subs	x29, x26, x23
	b.lo	552f
	add	x5, x9, x29
	mov	x30, x23
	ldp	q0, q1, [x5]
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.hs	702f
252:
	lsr	x5, x25, #32
	add	x21, x21, x22
	add	x25, x27, x26
	add	x24, x24, w5, uxtb
	lsr	x5, x20, #53
	add	x26, x10, x21
	and	x5, x5, #0x7f8
	ldp	q0, q1, [x26]
	ldr	x20, [x12, x5]
	lsr	x5, x24, #3
	and	x22, x24, #0x7
	ldr	x5, [x11, x5]
	lsr	x5, x5, x22
	and	w5, w20, w5
	adds	x5, x5, x20, lsr #40
	csel	x22, x23, x5, eq
	cmp	x23, x25
	csel	x27, x23, x25, lo
	sub	x23, x25, x27
	cmp	x27, #31
	b.ls	432f
	add	x5, x9, x23
	ldp	q2, q3, [x5]
262:
	add	v1.16b, v3.16b, v1.16b
	add	v0.16b, v2.16b, v0.16b
	lsr	x19, x19, #56
	add	x23, x9, x25
	stp	q0, q1, [x23]
	cmp	x19, #33
	b.hs	442f
272:
	add	x25, x19, x25
	lsr	x7, x7, #58
	cmp	x22, x7
	b.lo	562f
	subs	x26, x25, x22
	b.lo	562f
	add	x5, x9, x26
	mov	x27, x22
	ldp	q0, q1, [x5]
	add	x23, x9, x25
	stp	q0, q1, [x23]
	cmp	x7, #33
	b.hs	732f
282:
	lsr	x5, x20, #32
	add	x21, x19, x21
	sub	x2, x2, #8
	add	x6, x6, #8
	add	x23, x24, w5, uxtb
	add	x24, x7, x25
	cmp	x8, #7
	b.hi	2b
	b	762f
292:
	ldr	x27, [x0, #56]
	add	x7, x9, x7
	ldp	q2, q3, [x7]
	add	x22, x27, x22, lsl #5
	ldr	q1, [x22, #2064]
	ldr	q0, [x22, #2048]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	32b
302:
	ldr	x22, [x0, #48]
	ldr	x30, [x0, #120]
	ldrb	w29, [x22, x30]
	add	x22, x30, #1
	str	x22, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x22, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	42b
	ldp	q0, q1, [x27, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	42b
	ldp	q0, q1, [x27, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	42b
	ldp	q0, q1, [x27, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 42b
	ldp	q0, q1, [x27, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	42b
	ldp	q0, q1, [x27, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	42b
	ldp	q0, q1, [x27, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	42b
	ldp	q0, q1, [x27, #256]
	stp	q0, q1, [x28, #256]
	b	42b
312:
	ldr	x5, [x0, #56]
	add	x5, x5, x25, lsl #5
	ldr	q3, [x5, #2064]
	ldr	q2, [x5, #2048]
	add	x5, x9, x23
	ldp	q4, q5, [x5]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	72b
322:
	ldr	x5, [x0, #48]
	ldr	x23, [x0, #120]
	ldrb	w29, [x5, x23]
	add	x5, x23, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x28, #32]
	add	x23, x29, #33
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
	ldr	x5, [x0, #56]
	add	x5, x5, x28, lsl #5
	ldr	q3, [x5, #2064]
	ldr	q2, [x5, #2048]
	add	x5, x9, x21
	ldp	q4, q5, [x5]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	112b
342:
	ldr	x5, [x0, #48]
	ldr	x21, [x0, #120]
	ldrb	w29, [x5, x21]
	add	x5, x21, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x21, x29, #33
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
352:
	ldr	x5, [x0, #56]
	add	x5, x5, x28, lsl #5
	ldr	q3, [x5, #2064]
	ldr	q2, [x5, #2048]
	add	x5, x9, x22
	ldp	q4, q5, [x5]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	142b
362:
	ldr	x5, [x0, #48]
	ldr	x22, [x0, #120]
	ldrb	w29, [x5, x22]
	add	x5, x22, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x22, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	152b
	ldp	q0, q1, [x27, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	152b
	ldp	q0, q1, [x27, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	152b
	ldp	q0, q1, [x27, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 152b
	ldp	q0, q1, [x27, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	152b
	ldp	q0, q1, [x27, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	152b
	ldp	q0, q1, [x27, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	152b
	ldp	q0, q1, [x27, #256]
	stp	q0, q1, [x28, #256]
	b	152b
372:
	ldr	x5, [x0, #56]
	add	x5, x5, x28, lsl #5
	ldr	q3, [x5, #2064]
	ldr	q2, [x5, #2048]
	add	x5, x9, x21
	ldp	q4, q5, [x5]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	172b
382:
	ldr	x5, [x0, #48]
	ldr	x21, [x0, #120]
	ldrb	w29, [x5, x21]
	add	x5, x21, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x21, x29, #33
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
392:
	ldr	x5, [x0, #56]
	add	x5, x5, x28, lsl #5
	ldr	q3, [x5, #2064]
	ldr	q2, [x5, #2048]
	add	x5, x9, x22
	ldp	q4, q5, [x5]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	202b
402:
	ldr	x5, [x0, #48]
	ldr	x22, [x0, #120]
	ldrb	w29, [x5, x22]
	add	x5, x22, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x22, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	212b
	ldp	q0, q1, [x27, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	212b
	ldp	q0, q1, [x27, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	212b
	ldp	q0, q1, [x27, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 212b
	ldp	q0, q1, [x27, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	212b
	ldp	q0, q1, [x27, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	212b
	ldp	q0, q1, [x27, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	212b
	ldp	q0, q1, [x27, #256]
	stp	q0, q1, [x28, #256]
	b	212b
412:
	ldr	x5, [x0, #56]
	add	x5, x5, x28, lsl #5
	ldr	q3, [x5, #2064]
	ldr	q2, [x5, #2048]
	add	x5, x9, x21
	ldp	q4, q5, [x5]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	232b
422:
	ldr	x5, [x0, #48]
	ldr	x21, [x0, #120]
	ldrb	w29, [x5, x21]
	add	x5, x21, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x27, #32]
	add	x21, x29, #33
	stp	q0, q1, [x28, #32]
	cmp	w29, #32
	b.lo	242b
	ldp	q0, q1, [x27, #64]
	stp	q0, q1, [x28, #64]
	cmp	w29, #64
	b.lo	242b
	ldp	q0, q1, [x27, #96]
	stp	q0, q1, [x28, #96]
	cmp	w29, #96
	b.lo	242b
	ldp	q0, q1, [x27, #128]
	stp	q0, q1, [x28, #128]
	tbz	w29, #7, 242b
	ldp	q0, q1, [x27, #160]
	stp	q0, q1, [x28, #160]
	cmp	w29, #160
	b.lo	242b
	ldp	q0, q1, [x27, #192]
	stp	q0, q1, [x28, #192]
	cmp	w29, #192
	b.lo	242b
	ldp	q0, q1, [x27, #224]
	stp	q0, q1, [x28, #224]
	cmp	w29, #224
	b.lo	242b
	ldp	q0, q1, [x27, #256]
	stp	q0, q1, [x28, #256]
	b	242b
432:
	ldr	x5, [x0, #56]
	add	x5, x5, x27, lsl #5
	ldr	q3, [x5, #2064]
	ldr	q2, [x5, #2048]
	add	x5, x9, x23
	ldp	q4, q5, [x5]
	tbl	v2.16b, { v4.16b, v5.16b }, v2.16b
	tbl	v3.16b, { v4.16b, v5.16b }, v3.16b
	b	262b
442:
	ldr	x5, [x0, #48]
	ldr	x19, [x0, #120]
	ldrb	w27, [x5, x19]
	add	x5, x19, #1
	str	x5, [x0, #120]
	ldp	q0, q1, [x26, #32]
	add	x19, x27, #33
	stp	q0, q1, [x23, #32]
	cmp	w27, #32
	b.lo	272b
	ldp	q0, q1, [x26, #64]
	stp	q0, q1, [x23, #64]
	cmp	w27, #64
	b.lo	272b
	ldp	q0, q1, [x26, #96]
	stp	q0, q1, [x23, #96]
	cmp	w27, #96
	b.lo	272b
	ldp	q0, q1, [x26, #128]
	stp	q0, q1, [x23, #128]
	tbz	w27, #7, 272b
	ldp	q0, q1, [x26, #160]
	stp	q0, q1, [x23, #160]
	cmp	w27, #160
	b.lo	272b
	ldp	q0, q1, [x26, #192]
	stp	q0, q1, [x23, #192]
	cmp	w27, #192
	b.lo	272b
	ldp	q0, q1, [x26, #224]
	stp	q0, q1, [x23, #224]
	cmp	w27, #224
	b.lo	272b
	ldp	q0, q1, [x26, #256]
	stp	q0, q1, [x23, #256]
	b	272b
452:
	cmp	x25, x27
	csel	x30, x25, x27, lo
	sub	x29, x27, x30
	cmp	x30, x28
	b.hs	52b
	ldr	x24, [x0, #56]
	add	x24, x24, x30, lsl #5
	ldr	q1, [x24, #2064]
	ldr	q0, [x24, #2048]
	add	x24, x9, x29
	ldp	q2, q3, [x24]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	add	x24, x9, x27
	stp	q0, q1, [x24]
	cmp	x28, #33
	b.lo	62b
462:
	cmp	x30, #31
	b.hi	472f
	mov	w5, #1
	str	x5, [x0, #104]
472:
	ldr	x28, [x0, #48]
	ldr	x5, [x0, #120]
	add	x29, x9, x29
	ldrb	w30, [x28, x5]
	add	x5, x5, #1
	add	x28, x30, #33
	str	x5, [x0, #120]
	ldp	q0, q1, [x29, #32]
	stp	q0, q1, [x24, #32]
	cmp	w30, #32
	b.lo	62b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x24, #64]
	cmp	w30, #64
	b.lo	62b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x24, #96]
	cmp	w30, #96
	b.lo	62b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x24, #128]
	tbz	w30, #7, 62b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x24, #160]
	cmp	w30, #160
	b.lo	62b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x24, #192]
	cmp	w30, #192
	b.lo	62b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x24, #224]
	cmp	w30, #224
	b.lo	62b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x24, #256]
	b	62b
482:
	cmp	x21, x25
	csel	x30, x21, x25, lo
	sub	x29, x25, x30
	cmp	x30, x27
	b.hs	92b
	ldr	x5, [x0, #56]
	add	x5, x5, x30, lsl #5
	ldr	q1, [x5, #2064]
	ldr	q0, [x5, #2048]
	add	x5, x9, x29
	ldp	q2, q3, [x5]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	add	x28, x9, x25
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.lo	102b
492:
	cmp	x30, #31
	b.hi	502f
	mov	w5, #1
	str	x5, [x0, #104]
502:
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
	b.lo	102b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x28, #64]
	cmp	w30, #64
	b.lo	102b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x28, #96]
	cmp	w30, #96
	b.lo	102b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x28, #128]
	tbz	w30, #7, 102b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x28, #160]
	cmp	w30, #160
	b.lo	102b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x28, #192]
	cmp	w30, #192
	b.lo	102b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x28, #224]
	cmp	w30, #224
	b.lo	102b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x28, #256]
	b	102b
512:
	cmp	x22, x26
	csel	x30, x22, x26, lo
	sub	x29, x26, x30
	cmp	x30, x27
	b.hs	572f
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
	b	582f
522:
	cmp	x21, x26
	csel	x30, x21, x26, lo
	sub	x29, x26, x30
	cmp	x30, x27
	b.hs	602f
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
	b.lo	162b
	b	612f
532:
	cmp	x22, x26
	csel	x30, x22, x26, lo
	sub	x29, x26, x30
	cmp	x30, x27
	b.hs	632f
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
	b	642f
542:
	cmp	x21, x26
	csel	x30, x21, x26, lo
	sub	x29, x26, x30
	cmp	x30, x27
	b.hs	662f
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
	b.lo	222b
	b	672f
552:
	cmp	x23, x26
	csel	x30, x23, x26, lo
	sub	x29, x26, x30
	cmp	x30, x27
	b.hs	692f
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
	b.lo	252b
	b	702f
562:
	cmp	x22, x25
	csel	x27, x22, x25, lo
	sub	x26, x25, x27
	cmp	x27, x7
	b.hs	722f
	ldr	x5, [x0, #56]
	add	x5, x5, x27, lsl #5
	ldr	q1, [x5, #2064]
	ldr	q0, [x5, #2048]
	add	x5, x9, x26
	ldp	q2, q3, [x5]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	add	x23, x9, x25
	stp	q0, q1, [x23]
	cmp	x7, #33
	b.lo	282b
	b	732f
572:
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.lo	132b
582:
	cmp	x30, #31
	b.hi	592f
	mov	w5, #1
	str	x5, [x0, #104]
592:
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
602:
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.lo	162b
612:
	cmp	x30, #31
	b.hi	622f
	mov	w5, #1
	str	x5, [x0, #104]
622:
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
	b.lo	162b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x28, #64]
	cmp	w30, #64
	b.lo	162b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x28, #96]
	cmp	w30, #96
	b.lo	162b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x28, #128]
	tbz	w30, #7, 162b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x28, #160]
	cmp	w30, #160
	b.lo	162b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x28, #192]
	cmp	w30, #192
	b.lo	162b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x28, #224]
	cmp	w30, #224
	b.lo	162b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x28, #256]
	b	162b
632:
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.lo	192b
642:
	cmp	x30, #31
	b.hi	652f
	mov	w5, #1
	str	x5, [x0, #104]
652:
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
662:
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.lo	222b
672:
	cmp	x30, #31
	b.hi	682f
	mov	w5, #1
	str	x5, [x0, #104]
682:
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
	b.lo	222b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x28, #64]
	cmp	w30, #64
	b.lo	222b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x28, #96]
	cmp	w30, #96
	b.lo	222b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x28, #128]
	tbz	w30, #7, 222b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x28, #160]
	cmp	w30, #160
	b.lo	222b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x28, #192]
	cmp	w30, #192
	b.lo	222b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x28, #224]
	cmp	w30, #224
	b.lo	222b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x28, #256]
	b	222b
692:
	add	x5, x9, x29
	ldp	q0, q1, [x5]
	add	x28, x9, x26
	stp	q0, q1, [x28]
	cmp	x27, #33
	b.lo	252b
702:
	cmp	x30, #31
	b.hi	712f
	mov	w5, #1
	str	x5, [x0, #104]
712:
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
	b.lo	252b
	ldp	q0, q1, [x29, #64]
	stp	q0, q1, [x28, #64]
	cmp	w30, #64
	b.lo	252b
	ldp	q0, q1, [x29, #96]
	stp	q0, q1, [x28, #96]
	cmp	w30, #96
	b.lo	252b
	ldp	q0, q1, [x29, #128]
	stp	q0, q1, [x28, #128]
	tbz	w30, #7, 252b
	ldp	q0, q1, [x29, #160]
	stp	q0, q1, [x28, #160]
	cmp	w30, #160
	b.lo	252b
	ldp	q0, q1, [x29, #192]
	stp	q0, q1, [x28, #192]
	cmp	w30, #192
	b.lo	252b
	ldp	q0, q1, [x29, #224]
	stp	q0, q1, [x28, #224]
	cmp	w30, #224
	b.lo	252b
	ldp	q0, q1, [x29, #256]
	stp	q0, q1, [x28, #256]
	b	252b
722:
	add	x5, x9, x26
	ldp	q0, q1, [x5]
	add	x23, x9, x25
	stp	q0, q1, [x23]
	cmp	x7, #33
	b.lo	282b
732:
	cmp	x27, #31
	b.hi	742f
	mov	w5, #1
	str	x5, [x0, #104]
742:
	ldr	x5, [x0, #48]
	ldr	x7, [x0, #120]
	add	x26, x9, x26
	ldrb	w27, [x5, x7]
	add	x5, x7, #1
	add	x7, x27, #33
	str	x5, [x0, #120]
	ldp	q0, q1, [x26, #32]
	stp	q0, q1, [x23, #32]
	cmp	w27, #32
	b.lo	282b
	ldp	q0, q1, [x26, #64]
	stp	q0, q1, [x23, #64]
	cmp	w27, #64
	b.lo	282b
	ldp	q0, q1, [x26, #96]
	stp	q0, q1, [x23, #96]
	cmp	w27, #96
	b.lo	282b
	ldp	q0, q1, [x26, #128]
	stp	q0, q1, [x23, #128]
	tbz	w27, #7, 282b
	ldp	q0, q1, [x26, #160]
	stp	q0, q1, [x23, #160]
	cmp	w27, #160
	b.lo	282b
	ldp	q0, q1, [x26, #192]
	stp	q0, q1, [x23, #192]
	cmp	w27, #192
	b.lo	282b
	ldp	q0, q1, [x26, #224]
	stp	q0, q1, [x23, #224]
	cmp	w27, #224
	b.lo	282b
	ldp	q0, q1, [x26, #256]
	stp	q0, q1, [x23, #256]
	b	282b
752:
	mov	x16, xzr
	b	772f
762:
	cbz	x8, 882f
	neg	x16, x2
772:
	ldr	x15, [x15, x16]
	mov	w16, #1
	.p2align	5, , 16
782:
	lsr	x2, x23, #3
	ubfiz	x17, x14, #3, #8
	and	x3, x23, #0x7
	mov	x1, x22
	ldr	x2, [x11, x2]
	ldr	x17, [x12, x17]
	lsr	x2, x2, x3
	and	w2, w17, w2
	adds	x2, x2, x17, lsr #40
	csel	x22, x22, x2, eq
	cmp	x1, x24
	csel	x2, x1, x24, lo
	sub	x1, x24, x2
	cmp	x2, #31
	b.ls	832f
	add	x1, x9, x1
	ldp	q0, q1, [x1]
792:
	add	x2, x10, x21
	and	x1, x13, #0xff
	add	x3, x9, x24
	ldp	q3, q2, [x2]
	add	v1.16b, v1.16b, v2.16b
	add	v0.16b, v0.16b, v3.16b
	stp	q0, q1, [x3]
	cmp	x1, #33
	b.hs	842f
802:
	ubfx	x3, x15, #2, #6
	add	x2, x1, x24
	cmp	x22, x3
	ccmp	x2, x22, #0, hs
	b.lo	852f
	sub	x5, x2, x22
	mov	x6, x22
812:
	add	x4, x9, x5
	ldp	q0, q1, [x4]
	add	x4, x9, x2
	stp	q0, q1, [x4]
	cmp	x3, #33
	b.hs	862f
822:
	lsr	x17, x17, #32
	add	x21, x1, x21
	add	x24, x3, x2
	subs	x8, x8, #1
	lsr	x15, x15, #8
	lsr	x13, x13, #8
	add	x23, x23, w17, uxtb
	lsr	x14, x14, #8
	b.ne	782b
	b	882f
832:
	ldr	x3, [x0, #56]
	add	x1, x9, x1
	ldp	q2, q3, [x1]
	add	x2, x3, x2, lsl #5
	ldr	q1, [x2, #2064]
	ldr	q0, [x2, #2048]
	tbl	v0.16b, { v2.16b, v3.16b }, v0.16b
	tbl	v1.16b, { v2.16b, v3.16b }, v1.16b
	b	792b
842:
	ldr	x1, [x0, #48]
	ldr	x5, [x0, #120]
	ldrb	w4, [x1, x5]
	add	x1, x5, #1
	str	x1, [x0, #120]
	ldp	q0, q1, [x2, #32]
	add	x1, x4, #33
	stp	q0, q1, [x3, #32]
	cmp	w4, #32
	b.lo	802b
	ldp	q0, q1, [x2, #64]
	stp	q0, q1, [x3, #64]
	cmp	w4, #64
	b.lo	802b
	ldp	q0, q1, [x2, #96]
	stp	q0, q1, [x3, #96]
	cmp	w4, #96
	b.lo	802b
	ldp	q0, q1, [x2, #128]
	stp	q0, q1, [x3, #128]
	tbz	w4, #7, 802b
	ldp	q0, q1, [x2, #160]
	stp	q0, q1, [x3, #160]
	cmp	w4, #160
	b.lo	802b
	ldp	q0, q1, [x2, #192]
	stp	q0, q1, [x3, #192]
	cmp	w4, #192
	b.lo	802b
	ldp	q0, q1, [x2, #224]
	stp	q0, q1, [x3, #224]
	cmp	w4, #224
	b.lo	802b
	ldp	q0, q1, [x2, #256]
	stp	q0, q1, [x3, #256]
	b	802b
852:
	cmp	x22, x2
	csel	x6, x22, x2, lo
	sub	x5, x2, x6
	cmp	x6, x3
	b.hs	812b
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
	b.lo	822b
862:
	cmp	x6, #31
	b.hi	872f
	str	x16, [x0, #104]
872:
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
	b.lo	822b
	ldp	q0, q1, [x5, #64]
	stp	q0, q1, [x4, #64]
	cmp	w6, #64
	b.lo	822b
	ldp	q0, q1, [x5, #96]
	stp	q0, q1, [x4, #96]
	cmp	w6, #96
	b.lo	822b
	ldp	q0, q1, [x5, #128]
	stp	q0, q1, [x4, #128]
	tbz	w6, #7, 822b
	ldp	q0, q1, [x5, #160]
	stp	q0, q1, [x4, #160]
	cmp	w6, #160
	b.lo	822b
	ldp	q0, q1, [x5, #192]
	stp	q0, q1, [x4, #192]
	cmp	w6, #192
	b.lo	822b
	ldp	q0, q1, [x5, #224]
	stp	q0, q1, [x4, #224]
	cmp	w6, #224
	b.lo	822b
	ldp	q0, q1, [x5, #256]
	stp	q0, q1, [x4, #256]
	b	822b
882:
	stp	x24, x21, [x0, #80]
	str	x22, [x0, #96]
	ldp	x20, x19, [sp, #80]
	ldp	x22, x21, [sp, #64]
	ldp	x24, x23, [sp, #48]
	ldp	x26, x25, [sp, #32]
	ldp	x28, x27, [sp, #16]
	ldp	x29, x30, [sp], #96
892:
	ret

// minlz_pivco_exec of crates/minlz/mlir/pivco.mlir for neon, written by
// cargo xtask mlir. Do not edit.
	sub	sp, sp, #128
	stp	x22, x21, [sp, #96]
	ldr	x22, [x0, #8]
	stp	x29, x30, [sp, #32]
	stp	x28, x27, [sp, #48]
	stp	x26, x25, [sp, #64]
	stp	x24, x23, [sp, #80]
	stp	x20, x19, [sp, #112]
	cbz	x22, 102f
	ldp	x9, x24, [x0, #16]
	ldp	x8, x21, [x0, #64]
	ldr	x10, [x0]
	mov	w23, #8
	ldp	x25, x26, [x0, #32]
	ldp	x27, x28, [x0, #48]
	mov	x20, x0
	mov	x19, xzr
	stp	x8, x9, [sp, #16]
	ldr	x8, [x0, #80]
	str	x8, [sp, #8]
	b	12f
2:
	ldr	x10, [sp, #24]
	ldr	x5, [sp, #8]
	add	x0, x11, x12
	add	x3, x25, x14
	mov	x1, x8
	mov	x4, x9
	add	x2, x10, x13
	bl	122f
	cmp	x0, x23
	mov	w23, #8
	b.eq	92f
	b	112f
	.p2align	5, , 16
12:
	ldrb	w8, [x10, #1]
	ldrb	w4, [x10, #2]
	ldrb	w9, [x10, #3]
	mov	w16, #1
	tst	w8, #0x1
	ldr	w8, [x10, #8]
	ldr	w12, [x10, #20]
	csel	x11, x25, x27, eq
	csel	x13, x26, x28, eq
	cmp	x4, #8
	csel	x14, x4, x23, lo
	cmp	w4, #1
	lsl	x14, x16, x14
	add	x14, x14, x9
	ccmp	x14, x21, #2, hi
	add	x15, x12, x8
	cset	w14, ls
	cmp	x15, x13
	b.hi	112f
	ldr	w13, [x10, #16]
	mov	x29, x10
	ldrb	w15, [x29], #32
	cmp	w15, #2
	b.le	22f
	umull	x10, w8, w4
	cmp	w15, #4
	b.gt	32f
	cmp	w15, #3
	b.eq	42f
	cmp	w15, #4
	b.ne	112f
	mov	w15, #128
	mov	w5, #16
	b	52f
	.p2align	5, , 16
22:
	ldr	w14, [x10, #28]
	ldr	w23, [x10, #12]
	add	x16, x8, #7
	add	x16, x13, x16, lsr #3
	add	x17, x14, x8
	cbz	w15, 82f
	cmp	w15, #1
	b.eq	72f
	cmp	w15, #2
	b.ne	112f
	cmp	x16, x24
	b.hi	112f
	ldrb	w4, [x10, #4]
	ldr	x10, [sp, #24]
	add	x0, x11, x12
	mov	x1, x8
	mov	x3, x9
	add	x2, x10, x13
	bl	312f
	mov	w23, #8
	b	92f
	.p2align	5, , 16
32:
	cmp	w15, #5
	b.eq	62f
	cmp	w15, #6
	b.ne	112f
	cmp	w4, #8
	b.ne	112f
	add	x9, x13, x8
	cmp	x9, x24
	b.hi	112f
	ldr	x9, [sp, #24]
	add	x0, x11, x12
	mov	x2, x8
	add	x1, x9, x13
	bl	492f
	b	92f
42:
	mov	w15, #512
	mov	w5, #64
52:
	sub	w16, w15, #1
	add	x10, x13, x10, lsr #3
	tst	x16, x8
	ccmp	w4, #8, #2, eq
	ccmp	x10, x24, #2, lo
	csel	w10, wzr, w14, hi
	cbz	w10, 112f
	rbit	x10, x15
	add	x0, x11, x12
	clz	x10, x10
	lsr	x2, x8, x10
	ldp	x8, x10, [sp, #16]
	add	x1, x10, x13
	add	x3, x8, x9
	bl	712f
	b	92f
62:
	add	x10, x10, #7
	cmp	w4, #9
	add	x10, x13, x10, lsr #3
	ccmp	x10, x24, #2, lo
	csel	w10, wzr, w14, hi
	cbz	w10, 112f
	add	x0, x11, x12
	ldr	x11, [sp, #24]
	sub	x10, x24, x13
	add	x6, x20, #128
	mov	x2, x8
	mov	x3, x4
	mov	x4, x10
	add	x1, x11, x13
	ldr	x11, [sp, #16]
	add	x5, x11, x9
	bl	972f
	b	92f
72:
	cmp	x16, x24
	b.hi	112f
	cmp	x17, x26
	b.ls	2b
	b	112f
82:
	ldr	w9, [x10, #24]
	cmp	x16, x24
	add	x10, x9, x8
	ccmp	x10, x26, #2, ls
	ccmp	x17, x26, #2, ls
	b.hi	112f
	ldr	x10, [sp, #24]
	ldr	x5, [sp, #8]
	add	x0, x11, x12
	add	x3, x25, x9
	add	x4, x25, x14
	mov	x1, x8
	add	x2, x10, x13
	bl	2692f
	cmp	x0, x23
	mov	w23, #8
	b.ne	112f
	.p2align	5, , 16
92:
	add	x19, x19, #1
	mov	x10, x29
	cmp	x22, x19
	b.ne	12b
	mov	x19, x22
	b	112f
102:
	mov	x19, xzr
112:
	mov	x0, x19
	ldp	x20, x19, [sp, #112]
	ldp	x22, x21, [sp, #96]
	ldp	x24, x23, [sp, #80]
	ldp	x26, x25, [sp, #64]
	ldp	x28, x27, [sp, #48]
	ldp	x29, x30, [sp, #32]
	add	sp, sp, #128
	ret
	.p2align	4
122:
	str	x19, [sp, #-16]!
	dup	v0.16b, w4
	lsr	x9, x1, #6
	mov	x8, x0
	mov	x0, xzr
	cbz	x9, 142f
	mov	x10, #72340172838076673
	mov	x11, x2
	mov	x12, x8
	.p2align	5, , 16
132:
	ldr	x13, [x11], #8
	mov	v7.16b, v0.16b
	subs	x9, x9, #1
	lsr	x15, x13, #4
	ubfiz	x14, x13, #4, #8
	lsr	x16, x13, #12
	lsr	x17, x13, #20
	lsr	x4, x13, #28
	lsr	x6, x13, #36
	lsr	x7, x13, #44
	lsr	x19, x13, #56
	fmov	d1, x13
	and	x13, x15, #0xff0
	ldr	q2, [x5, x14]
	and	x14, x16, #0xff0
	and	x15, x17, #0xff0
	and	x16, x4, #0xff0
	and	x17, x6, #0xff0
	add	x13, x5, x13
	ldr	q4, [x5, x14]
	add	x15, x5, x15
	ldr	q3, [x13, #4096]
	cnt	v1.8b, v1.8b
	add	x13, x3, x0
	fmov	x14, d1
	addv	b5, v1.8b
	ldr	q1, [x15, #4096]
	mul	x14, x14, x10
	add	v2.16b, v3.16b, v2.16b
	ldr	q3, [x13]
	ubfx	x15, x14, #8, #8
	ldr	q6, [x13, x15]
	lsr	w15, w14, #24
	ubfx	x14, x14, #40, #8
	add	v1.16b, v1.16b, v4.16b
	mov	v4.16b, v0.16b
	tbx	v7.16b, { v3.16b }, v2.16b
	mov	v2.16b, v0.16b
	tbx	v2.16b, { v6.16b }, v1.16b
	ldr	q1, [x5, x16]
	add	x16, x5, x17
	mov	v6.16b, v0.16b
	ldr	q3, [x16, #4096]
	add	v1.16b, v3.16b, v1.16b
	ldr	q3, [x13, x15]
	and	x15, x7, #0xff0
	tbx	v4.16b, { v3.16b }, v1.16b
	ldr	q1, [x5, x15]
	add	x15, x5, x19, lsl #4
	ldr	q3, [x15, #4096]
	add	v1.16b, v3.16b, v1.16b
	ldr	q3, [x13, x14]
	fmov	x13, d5
	add	x0, x13, x0
	tbx	v6.16b, { v3.16b }, v1.16b
	stp	q4, q6, [x12, #32]
	stp	q7, q2, [x12], #64
	b.ne	132b
142:
	ands	x9, x1, #0x3f
	b.eq	252f
	and	x10, x1, #0xffffffc0
	add	x12, x9, #7
	add	x11, x2, x10, lsr #3
	lsr	x12, x12, #3
	cmp	x9, #25
	b.lo	152f
	sub	x12, x12, #4
	ldr	w13, [x11]
	ldr	w11, [x11, x12]
	b	162f
152:
	cmp	x9, #9
	b.lo	172f
	sub	x12, x12, #2
	ldrh	w13, [x11]
	ldrh	w11, [x11, x12]
162:
	lsl	x12, x12, #3
	lsl	x11, x11, x12
	orr	x11, x11, x13
	b	182f
172:
	ldrb	w11, [x11]
182:
	mov	x12, #-1
	mov	x13, #72340172838076673
	add	x8, x8, x10
	lsl	x9, x12, x9
	bic	x9, x11, x9
	add	x11, x3, x0
	fmov	d1, x9
	lsr	x15, x9, #4
	ubfiz	x14, x9, #4, #8
	ldr	q4, [x11]
	and	x15, x15, #0xff0
	cnt	v1.8b, v1.8b
	fmov	x12, d1
	ldr	q1, [x5, x14]
	add	x14, x5, x15
	lsr	x15, x9, #20
	ldr	q3, [x14, #4096]
	lsr	x14, x9, #12
	and	x15, x15, #0xff0
	and	x14, x14, #0xff0
	mul	x12, x12, x13
	ldr	q2, [x5, x14]
	add	x14, x5, x15
	ldr	q5, [x14, #4096]
	ubfx	x13, x12, #8, #8
	ldr	q6, [x11, x13]
	add	v3.16b, v3.16b, v1.16b
	mov	v1.16b, v0.16b
	tbx	v1.16b, { v4.16b }, v3.16b
	add	v5.16b, v5.16b, v2.16b
	mov	v2.16b, v0.16b
	tbx	v2.16b, { v6.16b }, v5.16b
	tbnz	w1, #5, 262f
	tbnz	w1, #4, 272f
192:
	fmov	x11, d1
	tst	x1, #0x8
	mov	x10, v1.d[1]
	csel	x10, x11, x10, eq
	tbnz	w1, #3, 282f
202:
	tbnz	w1, #2, 292f
212:
	tbnz	w1, #1, 302f
222:
	tbz	w1, #0, 242f
232:
	strb	w10, [x8]
242:
	fmov	d0, x9
	cnt	v0.8b, v0.8b
	addv	b0, v0.8b
	fmov	x8, d0
	add	x0, x8, x0
252:
	ldr	x19, [sp], #16
	ret
262:
	lsr	x13, x9, #28
	lsr	x14, x9, #36
	lsr	w10, w12, #24
	ubfx	x12, x12, #40, #8
	and	x13, x13, #0xff0
	and	x14, x14, #0xff0
	ldr	q5, [x11, x10]
	lsr	x10, x9, #44
	ldr	q16, [x11, x12]
	ldr	q3, [x5, x13]
	add	x13, x5, x14
	and	x10, x10, #0xff0
	ldr	q4, [x13, #4096]
	lsr	x13, x9, #52
	ldr	q6, [x5, x10]
	and	x13, x13, #0x7f0
	add	x10, x5, x13
	ldr	q7, [x10, #4096]
	stp	q1, q2, [x8], #32
	mov	v2.16b, v0.16b
	add	v3.16b, v4.16b, v3.16b
	tbx	v0.16b, { v5.16b }, v3.16b
	add	v6.16b, v7.16b, v6.16b
	mov	v1.16b, v0.16b
	tbx	v2.16b, { v16.16b }, v6.16b
	tbz	w1, #4, 192b
272:
	str	q1, [x8], #16
	mov	v1.16b, v2.16b
	fmov	x11, d1
	tst	x1, #0x8
	mov	x10, v1.d[1]
	csel	x10, x11, x10, eq
	tbz	w1, #3, 202b
282:
	str	x11, [x8], #8
	tbz	w1, #2, 212b
292:
	str	w10, [x8], #4
	lsr	x10, x10, #32
	tbz	w1, #1, 222b
302:
	strh	w10, [x8], #2
	lsr	x10, x10, #16
	tbnz	w1, #0, 232b
	b	242b
	.p2align	4
312:
	eor	w8, w4, w3
	dup	v0.16b, w3
	adrp	x9, 2892f
	lsr	x10, x1, #6
	adrp	x12, 2902f
	adrp	x13, 2912f
	dup	v1.16b, w8
	adrp	x8, 2922f
	adrp	x11, 2932f
	cbz	x10, 332f
	ldr	q2, [x11, :lo12:2932f]
	ldr	q3, [x13, :lo12:2912f]
	ldr	q4, [x8, :lo12:2922f]
	mov	x14, x2
	mov	x15, x0
	ldr	q5, [x9, :lo12:2892f]
	ldr	q6, [x12, :lo12:2902f]
	.p2align	5, , 16
322:
	ldr	x16, [x14], #8
	subs	x10, x10, #1
	fmov	d7, x16
	tbl	v16.16b, { v7.16b }, v2.16b
	tbl	v17.16b, { v7.16b }, v3.16b
	tbl	v18.16b, { v7.16b }, v4.16b
	tbl	v7.16b, { v7.16b }, v5.16b
	and	v16.16b, v16.16b, v6.16b
	and	v17.16b, v17.16b, v6.16b
	and	v18.16b, v18.16b, v6.16b
	and	v7.16b, v7.16b, v6.16b
	cmeq	v16.16b, v16.16b, #0
	cmeq	v17.16b, v17.16b, #0
	cmeq	v18.16b, v18.16b, #0
	cmeq	v7.16b, v7.16b, #0
	bic	v7.16b, v1.16b, v7.16b
	bic	v18.16b, v1.16b, v18.16b
	bic	v17.16b, v1.16b, v17.16b
	bic	v16.16b, v1.16b, v16.16b
	eor	v16.16b, v16.16b, v0.16b
	eor	v17.16b, v17.16b, v0.16b
	eor	v18.16b, v18.16b, v0.16b
	eor	v7.16b, v7.16b, v0.16b
	stp	q18, q7, [x15, #32]
	stp	q16, q17, [x15], #64
	b.ne	322b
332:
	ands	x15, x1, #0x3f
	b.eq	432f
	and	x10, x1, #0xffffffc0
	add	x16, x15, #7
	add	x14, x2, x10, lsr #3
	lsr	x16, x16, #3
	cmp	x15, #25
	b.lo	342f
	sub	x15, x16, #4
	ldr	w16, [x14]
	ldr	w14, [x14, x15]
	b	352f
342:
	cmp	x15, #9
	b.lo	362f
	sub	x15, x16, #2
	ldrh	w16, [x14]
	ldrh	w14, [x14, x15]
352:
	lsl	x15, x15, #3
	lsl	x14, x14, x15
	orr	x14, x14, x16
	b	372f
362:
	ldrb	w14, [x14]
372:
	ldr	q2, [x13, :lo12:2912f]
	ldr	q3, [x11, :lo12:2932f]
	ldr	q5, [x12, :lo12:2902f]
	fmov	d4, x14
	add	x10, x0, x10
	tbl	v2.16b, { v4.16b }, v2.16b
	tbl	v3.16b, { v4.16b }, v3.16b
	and	v2.16b, v2.16b, v5.16b
	and	v3.16b, v3.16b, v5.16b
	cmeq	v2.16b, v2.16b, #0
	cmeq	v3.16b, v3.16b, #0
	bic	v6.16b, v1.16b, v3.16b
	bic	v2.16b, v1.16b, v2.16b
	eor	v3.16b, v2.16b, v0.16b
	eor	v2.16b, v6.16b, v0.16b
	tbnz	w1, #5, 442f
	tbnz	w1, #4, 452f
382:
	fmov	x9, d2
	tst	x1, #0x8
	mov	x8, v2.d[1]
	csel	x8, x9, x8, eq
	tbnz	w1, #3, 462f
392:
	tbnz	w1, #2, 472f
402:
	tbnz	w1, #1, 482f
412:
	tbz	w1, #0, 432f
422:
	strb	w8, [x10]
432:
	ret
442:
	ldr	q6, [x9, :lo12:2892f]
	ldr	q7, [x8, :lo12:2922f]
	stp	q2, q3, [x10], #32
	tbl	v6.16b, { v4.16b }, v6.16b
	tbl	v4.16b, { v4.16b }, v7.16b
	and	v6.16b, v6.16b, v5.16b
	and	v4.16b, v4.16b, v5.16b
	cmeq	v6.16b, v6.16b, #0
	cmeq	v4.16b, v4.16b, #0
	bic	v4.16b, v1.16b, v4.16b
	bic	v1.16b, v1.16b, v6.16b
	eor	v3.16b, v1.16b, v0.16b
	eor	v2.16b, v4.16b, v0.16b
	tbz	w1, #4, 382b
452:
	str	q2, [x10], #16
	mov	v2.16b, v3.16b
	fmov	x9, d2
	tst	x1, #0x8
	mov	x8, v2.d[1]
	csel	x8, x9, x8, eq
	tbz	w1, #3, 392b
462:
	str	x9, [x10], #8
	tbz	w1, #2, 402b
472:
	str	w8, [x10], #4
	lsr	x8, x8, #32
	tbz	w1, #1, 412b
482:
	strh	w8, [x10], #2
	lsr	x8, x8, #16
	tbnz	w1, #0, 422b
	b	432b
	.p2align	4
492:
	lsr	x8, x2, #6
	cbz	x8, 512f
	mov	x9, x1
	mov	x10, x0
	.p2align	5, , 16
502:
	ldp	q1, q0, [x9]
	ldp	q3, q2, [x9, #32]
	subs	x8, x8, #1
	add	x9, x9, #64
	stp	q3, q2, [x10, #32]
	stp	q1, q0, [x10], #64
	b.ne	502b
512:
	tst	x2, #0x3f
	b.eq	632f
	and	x8, x2, #0xffffffc0
	and	x12, x2, #0x7
	and	x10, x2, #0x38
	add	x9, x1, x8
	subs	x13, x12, #4
	add	x11, x9, x10
	b.lo	522f
	ldr	w12, [x11]
	ldr	w11, [x11, x13]
	b	532f
522:
	subs	x13, x12, #2
	b.lo	692f
	ldrh	w12, [x11]
	ldrh	w11, [x11, x13]
532:
	lsl	x13, x13, #3
	lsl	x11, x11, x13
	orr	x11, x11, x12
542:
	fmov	d0, x11
	tbnz	w2, #3, 552f
	movi	v1.2d, #0000000000000000
	add	x8, x0, x8
	tbnz	w2, #4, 562f
	b	572f
552:
	sub	x10, x10, #8
	movi	v1.2d, #0000000000000000
	ext	v1.16b, v0.16b, v1.16b, #8
	dup	v0.2d, v0.d[0]
	add	x11, x9, x10
	ld1	{ v0.d }[0], [x11]
	add	x8, x0, x8
	tbz	w2, #4, 572f
562:
	add	x10, x9, x10
	mov	v1.16b, v0.16b
	ldur	q0, [x10, #-16]
572:
	tbnz	w2, #5, 642f
	tbnz	w2, #4, 652f
582:
	fmov	x10, d0
	tst	x2, #0x8
	mov	x9, v0.d[1]
	csel	x9, x10, x9, eq
	tbnz	w2, #3, 662f
592:
	tbnz	w2, #2, 672f
602:
	tbnz	w2, #1, 682f
612:
	tbz	w2, #0, 632f
622:
	strb	w9, [x8]
632:
	ret
642:
	ldp	q2, q3, [x9]
	stp	q2, q3, [x8], #32
	tbz	w2, #4, 582b
652:
	str	q0, [x8], #16
	mov	v0.16b, v1.16b
	fmov	x10, d0
	tst	x2, #0x8
	mov	x9, v0.d[1]
	csel	x9, x10, x9, eq
	tbz	w2, #3, 592b
662:
	str	x10, [x8], #8
	tbz	w2, #2, 602b
672:
	str	w9, [x8], #4
	lsr	x9, x9, #32
	tbz	w2, #1, 612b
682:
	strh	w9, [x8], #2
	lsr	x9, x9, #16
	tbnz	w2, #0, 622b
	b	632b
692:
	cmp	x12, #1
	b.ne	702f
	ldrb	w11, [x11]
	b	542b
702:
	mov	x11, xzr
	b	542b
	.p2align	4
712:
	cmp	x5, #16
	b.ne	732f
	cmp	x4, #4
	b.gt	752f
	cmp	x4, #2
	b.eq	802f
	cmp	x4, #3
	b.eq	882f
	cmp	x4, #4
	b.ne	962f
	cbz	x2, 962f
	ldr	q0, [x3]
	movi	v1.16b, #15
	add	x8, x0, #64
	add	x9, x1, #32
	.p2align	5, , 16
722:
	ldp	q2, q3, [x9, #-32]
	subs	x2, x2, #1
	and	v4.16b, v2.16b, v1.16b
	ushr	v2.16b, v2.16b, #4
	ldp	q5, q6, [x9], #64
	tbl	v4.16b, { v0.16b }, v4.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	stp	q4, q2, [x8, #-64]
	and	v2.16b, v3.16b, v1.16b
	ushr	v3.16b, v3.16b, #4
	tbl	v2.16b, { v0.16b }, v2.16b
	tbl	v3.16b, { v0.16b }, v3.16b
	stp	q2, q3, [x8, #-32]
	and	v2.16b, v5.16b, v1.16b
	ushr	v3.16b, v5.16b, #4
	tbl	v2.16b, { v0.16b }, v2.16b
	tbl	v3.16b, { v0.16b }, v3.16b
	stp	q2, q3, [x8]
	and	v2.16b, v6.16b, v1.16b
	ushr	v3.16b, v6.16b, #4
	tbl	v2.16b, { v0.16b }, v2.16b
	tbl	v3.16b, { v0.16b }, v3.16b
	stp	q2, q3, [x8, #32]
	add	x8, x8, #128
	b.ne	722b
	b	962f
732:
	cmp	x4, #4
	b.gt	772f
	cmp	x4, #2
	b.eq	822f
	cmp	x4, #3
	b.eq	902f
	cmp	x4, #4
	b.ne	962f
	cbz	x2, 962f
	ldr	q0, [x3]
	movi	v1.16b, #15
	add	x8, x0, #256
	add	x9, x1, #128
	.p2align	5, , 16
742:
	ldur	q2, [x9, #-128]
	ldur	q3, [x9, #-64]
	ldr	q4, [x9]
	subs	x2, x2, #1
	and	v6.16b, v2.16b, v1.16b
	ushr	v2.16b, v2.16b, #4
	ldr	q5, [x9, #64]
	tbl	v2.16b, { v0.16b }, v2.16b
	tbl	v6.16b, { v0.16b }, v6.16b
	stur	q2, [x8, #-192]
	and	v2.16b, v3.16b, v1.16b
	stur	q6, [x8, #-256]
	tbl	v2.16b, { v0.16b }, v2.16b
	stur	q2, [x8, #-128]
	ushr	v2.16b, v3.16b, #4
	tbl	v2.16b, { v0.16b }, v2.16b
	stur	q2, [x8, #-64]
	and	v2.16b, v4.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8]
	ushr	v2.16b, v4.16b, #4
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #64]
	and	v2.16b, v5.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #128]
	ushr	v2.16b, v5.16b, #4
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #192]
	ldur	q2, [x9, #-112]
	ldur	q3, [x9, #-48]
	ldr	q4, [x9, #16]
	ldr	q5, [x9, #80]
	and	v6.16b, v2.16b, v1.16b
	ushr	v2.16b, v2.16b, #4
	tbl	v2.16b, { v0.16b }, v2.16b
	tbl	v6.16b, { v0.16b }, v6.16b
	stur	q2, [x8, #-176]
	and	v2.16b, v3.16b, v1.16b
	stur	q6, [x8, #-240]
	tbl	v2.16b, { v0.16b }, v2.16b
	stur	q2, [x8, #-112]
	ushr	v2.16b, v3.16b, #4
	tbl	v2.16b, { v0.16b }, v2.16b
	stur	q2, [x8, #-48]
	and	v2.16b, v4.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #16]
	ushr	v2.16b, v4.16b, #4
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #80]
	and	v2.16b, v5.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #144]
	ushr	v2.16b, v5.16b, #4
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #208]
	ldur	q2, [x9, #-96]
	ldur	q3, [x9, #-32]
	ldr	q4, [x9, #32]
	ldr	q5, [x9, #96]
	and	v6.16b, v2.16b, v1.16b
	ushr	v2.16b, v2.16b, #4
	tbl	v2.16b, { v0.16b }, v2.16b
	tbl	v6.16b, { v0.16b }, v6.16b
	stur	q2, [x8, #-160]
	and	v2.16b, v3.16b, v1.16b
	stur	q6, [x8, #-224]
	tbl	v2.16b, { v0.16b }, v2.16b
	stur	q2, [x8, #-96]
	ushr	v2.16b, v3.16b, #4
	tbl	v2.16b, { v0.16b }, v2.16b
	stur	q2, [x8, #-32]
	and	v2.16b, v4.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #32]
	ushr	v2.16b, v4.16b, #4
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #96]
	and	v2.16b, v5.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #160]
	ushr	v2.16b, v5.16b, #4
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #224]
	ldur	q2, [x9, #-80]
	ldur	q3, [x9, #-16]
	ldr	q4, [x9, #48]
	ldr	q5, [x9, #112]
	add	x9, x9, #256
	and	v6.16b, v2.16b, v1.16b
	ushr	v2.16b, v2.16b, #4
	tbl	v2.16b, { v0.16b }, v2.16b
	tbl	v6.16b, { v0.16b }, v6.16b
	stur	q2, [x8, #-144]
	and	v2.16b, v3.16b, v1.16b
	stur	q6, [x8, #-208]
	tbl	v2.16b, { v0.16b }, v2.16b
	stur	q2, [x8, #-80]
	ushr	v2.16b, v3.16b, #4
	tbl	v2.16b, { v0.16b }, v2.16b
	stur	q2, [x8, #-16]
	and	v2.16b, v4.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #48]
	ushr	v2.16b, v4.16b, #4
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #112]
	and	v2.16b, v5.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #176]
	ushr	v2.16b, v5.16b, #4
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #240]
	add	x8, x8, #512
	b.ne	742b
	b	962f
752:
	cmp	x4, #5
	b.eq	842f
	cmp	x4, #6
	b.eq	922f
	cmp	x4, #7
	b.ne	962f
	cbz	x2, 962f
	ldp	q0, q1, [x3]
	ldp	q2, q3, [x3, #32]
	ldp	q4, q5, [x3, #64]
	movi	v16.16b, #127
	movi	v17.16b, #192
	add	x8, x0, #64
	ldp	q6, q7, [x3, #96]
	add	x9, x1, #48
	.p2align	5, , 16
762:
	ldp	q19, q20, [x9, #-48]
	ldp	q21, q22, [x9, #-16]
	ldp	q25, q26, [x9, #16]
	subs	x2, x2, #1
	add	v27.16b, v20.16b, v20.16b
	ldr	q18, [x9, #48]
	add	x9, x9, #112
	usra	v27.16b, v19.16b, #7
	and	v23.16b, v19.16b, v16.16b
	tbl	v24.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v23.16b
	add	v23.16b, v23.16b, v17.16b
	and	v19.16b, v27.16b, v16.16b
	tbl	v23.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v23.16b
	orr	v23.16b, v23.16b, v24.16b
	tbl	v27.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v19.16b
	add	v19.16b, v19.16b, v17.16b
	shl	v24.16b, v21.16b, #2
	usra	v24.16b, v20.16b, #6
	tbl	v19.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v19.16b
	orr	v19.16b, v19.16b, v27.16b
	shl	v27.16b, v22.16b, #3
	usra	v27.16b, v21.16b, #5
	and	v20.16b, v24.16b, v16.16b
	stp	q23, q19, [x8, #-64]
	shl	v23.16b, v26.16b, #5
	usra	v23.16b, v25.16b, #3
	tbl	v24.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v20.16b
	add	v20.16b, v20.16b, v17.16b
	and	v21.16b, v27.16b, v16.16b
	add	v19.16b, v21.16b, v17.16b
	tbl	v27.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v21.16b
	shl	v21.16b, v25.16b, #4
	and	v23.16b, v23.16b, v16.16b
	shl	v25.16b, v18.16b, #6
	tbl	v20.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v20.16b
	usra	v21.16b, v22.16b, #4
	orr	v20.16b, v20.16b, v24.16b
	usra	v25.16b, v26.16b, #2
	tbl	v19.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v19.16b
	tbl	v24.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v23.16b
	add	v23.16b, v23.16b, v17.16b
	tbl	v23.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v23.16b
	and	v21.16b, v21.16b, v16.16b
	orr	v19.16b, v19.16b, v27.16b
	and	v25.16b, v25.16b, v16.16b
	tbl	v22.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v21.16b
	add	v21.16b, v21.16b, v17.16b
	stp	q20, q19, [x8, #-32]
	add	v19.16b, v25.16b, v17.16b
	tbl	v26.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v25.16b
	tbl	v21.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v21.16b
	tbl	v19.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v19.16b
	orr	v20.16b, v21.16b, v22.16b
	orr	v21.16b, v23.16b, v24.16b
	movi	v23.16b, #192
	ushr	v22.16b, v18.16b, #1
	orr	v19.16b, v19.16b, v26.16b
	usra	v23.16b, v18.16b, #1
	tbl	v22.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v22.16b
	stp	q20, q21, [x8]
	tbl	v18.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v23.16b
	orr	v18.16b, v18.16b, v22.16b
	stp	q19, q18, [x8, #32]
	add	x8, x8, #128
	b.ne	762b
	b	962f
772:
	cmp	x4, #5
	b.eq	862f
	cmp	x4, #6
	b.eq	942f
	cmp	x4, #7
	b.ne	962f
	cbz	x2, 962f
	ldp	q0, q1, [x3]
	ldp	q2, q3, [x3, #32]
	ldp	q4, q5, [x3, #64]
	movi	v16.16b, #127
	movi	v17.16b, #192
	add	x9, x1, #192
	ldp	q6, q7, [x3, #96]
	add	x10, x0, #256
	mov	x8, xzr
	.p2align	5, , 16
782:
	mov	w13, #4
	mov	x11, x10
	mov	x12, x9
	.p2align	5, , 16
792:
	ldur	q19, [x12, #-192]
	ldur	q20, [x12, #-128]
	ldur	q23, [x12, #-64]
	subs	x13, x13, #1
	and	v21.16b, v19.16b, v16.16b
	ldr	q24, [x12]
	ldr	q25, [x12, #64]
	ldr	q26, [x12, #128]
	ldr	q18, [x12, #192]
	add	x12, x12, #16
	tbl	v22.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v21.16b
	add	v21.16b, v21.16b, v17.16b
	tbl	v21.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v21.16b
	orr	v21.16b, v21.16b, v22.16b
	stur	q21, [x11, #-256]
	add	v21.16b, v20.16b, v20.16b
	usra	v21.16b, v19.16b, #7
	and	v19.16b, v21.16b, v16.16b
	tbl	v21.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v19.16b
	add	v19.16b, v19.16b, v17.16b
	tbl	v19.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v19.16b
	orr	v19.16b, v19.16b, v21.16b
	shl	v21.16b, v23.16b, #2
	usra	v21.16b, v20.16b, #6
	stur	q19, [x11, #-192]
	and	v20.16b, v21.16b, v16.16b
	add	v19.16b, v20.16b, v17.16b
	tbl	v21.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v20.16b
	shl	v20.16b, v24.16b, #3
	usra	v20.16b, v23.16b, #5
	and	v20.16b, v20.16b, v16.16b
	tbl	v19.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v19.16b
	orr	v19.16b, v19.16b, v21.16b
	shl	v21.16b, v25.16b, #4
	usra	v21.16b, v24.16b, #4
	tbl	v22.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v20.16b
	add	v20.16b, v20.16b, v17.16b
	stur	q19, [x11, #-128]
	tbl	v20.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v20.16b
	and	v21.16b, v21.16b, v16.16b
	add	v19.16b, v21.16b, v17.16b
	orr	v20.16b, v20.16b, v22.16b
	tbl	v23.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v21.16b
	shl	v21.16b, v26.16b, #5
	shl	v22.16b, v18.16b, #6
	usra	v21.16b, v25.16b, #3
	tbl	v19.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v19.16b
	usra	v22.16b, v26.16b, #2
	stur	q20, [x11, #-64]
	orr	v19.16b, v19.16b, v23.16b
	movi	v23.16b, #192
	and	v21.16b, v21.16b, v16.16b
	and	v22.16b, v22.16b, v16.16b
	usra	v23.16b, v18.16b, #1
	add	v20.16b, v22.16b, v17.16b
	tbl	v24.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v21.16b
	add	v21.16b, v21.16b, v17.16b
	str	q19, [x11]
	tbl	v25.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v22.16b
	ushr	v22.16b, v18.16b, #1
	tbl	v21.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v21.16b
	tbl	v20.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v20.16b
	tbl	v22.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v22.16b
	tbl	v18.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v23.16b
	orr	v21.16b, v21.16b, v24.16b
	orr	v20.16b, v20.16b, v25.16b
	orr	v18.16b, v18.16b, v22.16b
	str	q21, [x11, #64]
	str	q20, [x11, #128]
	str	q18, [x11, #192]
	add	x11, x11, #16
	b.ne	792b
	add	x8, x8, #1
	add	x9, x9, #448
	add	x10, x10, #512
	cmp	x8, x2
	b.ne	782b
	b	962f
802:
	cbz	x2, 962f
	ldr	q0, [x3]
	movi	v1.16b, #3
	add	x8, x0, #64
	add	x9, x1, #16
	.p2align	5, , 16
812:
	ldp	q2, q3, [x9, #-16]
	subs	x2, x2, #1
	add	x9, x9, #32
	ushr	v5.16b, v2.16b, #2
	and	v4.16b, v2.16b, v1.16b
	and	v5.16b, v5.16b, v1.16b
	tbl	v4.16b, { v0.16b }, v4.16b
	tbl	v5.16b, { v0.16b }, v5.16b
	stp	q4, q5, [x8, #-64]
	ushr	v4.16b, v2.16b, #4
	ushr	v2.16b, v2.16b, #6
	and	v4.16b, v4.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	tbl	v4.16b, { v0.16b }, v4.16b
	stp	q4, q2, [x8, #-32]
	ushr	v4.16b, v3.16b, #2
	and	v2.16b, v3.16b, v1.16b
	and	v4.16b, v4.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	tbl	v4.16b, { v0.16b }, v4.16b
	stp	q2, q4, [x8]
	ushr	v2.16b, v3.16b, #4
	ushr	v3.16b, v3.16b, #6
	and	v2.16b, v2.16b, v1.16b
	tbl	v3.16b, { v0.16b }, v3.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	stp	q2, q3, [x8, #32]
	add	x8, x8, #128
	b.ne	812b
	b	962f
822:
	cbz	x2, 962f
	ldr	q0, [x3]
	movi	v1.16b, #3
	add	x8, x0, #256
	add	x9, x1, #64
	.p2align	5, , 16
832:
	ldur	q2, [x9, #-64]
	ldr	q3, [x9]
	subs	x2, x2, #1
	and	v4.16b, v2.16b, v1.16b
	tbl	v4.16b, { v0.16b }, v4.16b
	stur	q4, [x8, #-256]
	ushr	v4.16b, v2.16b, #2
	and	v4.16b, v4.16b, v1.16b
	tbl	v4.16b, { v0.16b }, v4.16b
	stur	q4, [x8, #-192]
	ushr	v4.16b, v2.16b, #4
	ushr	v2.16b, v2.16b, #6
	tbl	v2.16b, { v0.16b }, v2.16b
	and	v4.16b, v4.16b, v1.16b
	stur	q2, [x8, #-64]
	and	v2.16b, v3.16b, v1.16b
	tbl	v4.16b, { v0.16b }, v4.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	stur	q4, [x8, #-128]
	str	q2, [x8]
	ushr	v2.16b, v3.16b, #2
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #64]
	ushr	v2.16b, v3.16b, #4
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #128]
	ushr	v2.16b, v3.16b, #6
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #192]
	ldur	q2, [x9, #-48]
	ldr	q3, [x9, #16]
	and	v4.16b, v2.16b, v1.16b
	tbl	v4.16b, { v0.16b }, v4.16b
	stur	q4, [x8, #-240]
	ushr	v4.16b, v2.16b, #2
	and	v4.16b, v4.16b, v1.16b
	tbl	v4.16b, { v0.16b }, v4.16b
	stur	q4, [x8, #-176]
	ushr	v4.16b, v2.16b, #4
	ushr	v2.16b, v2.16b, #6
	tbl	v2.16b, { v0.16b }, v2.16b
	and	v4.16b, v4.16b, v1.16b
	stur	q2, [x8, #-48]
	and	v2.16b, v3.16b, v1.16b
	tbl	v4.16b, { v0.16b }, v4.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	stur	q4, [x8, #-112]
	str	q2, [x8, #16]
	ushr	v2.16b, v3.16b, #2
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #80]
	ushr	v2.16b, v3.16b, #4
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #144]
	ushr	v2.16b, v3.16b, #6
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #208]
	ldur	q2, [x9, #-32]
	ldr	q3, [x9, #32]
	and	v4.16b, v2.16b, v1.16b
	tbl	v4.16b, { v0.16b }, v4.16b
	stur	q4, [x8, #-224]
	ushr	v4.16b, v2.16b, #2
	and	v4.16b, v4.16b, v1.16b
	tbl	v4.16b, { v0.16b }, v4.16b
	stur	q4, [x8, #-160]
	ushr	v4.16b, v2.16b, #4
	ushr	v2.16b, v2.16b, #6
	tbl	v2.16b, { v0.16b }, v2.16b
	and	v4.16b, v4.16b, v1.16b
	stur	q2, [x8, #-32]
	and	v2.16b, v3.16b, v1.16b
	tbl	v4.16b, { v0.16b }, v4.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	stur	q4, [x8, #-96]
	str	q2, [x8, #32]
	ushr	v2.16b, v3.16b, #2
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #96]
	ushr	v2.16b, v3.16b, #4
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #160]
	ushr	v2.16b, v3.16b, #6
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #224]
	ldur	q2, [x9, #-16]
	ldr	q3, [x9, #48]
	add	x9, x9, #128
	and	v4.16b, v2.16b, v1.16b
	tbl	v4.16b, { v0.16b }, v4.16b
	stur	q4, [x8, #-208]
	ushr	v4.16b, v2.16b, #2
	and	v4.16b, v4.16b, v1.16b
	tbl	v4.16b, { v0.16b }, v4.16b
	stur	q4, [x8, #-144]
	ushr	v4.16b, v2.16b, #4
	ushr	v2.16b, v2.16b, #6
	tbl	v2.16b, { v0.16b }, v2.16b
	and	v4.16b, v4.16b, v1.16b
	stur	q2, [x8, #-16]
	and	v2.16b, v3.16b, v1.16b
	tbl	v4.16b, { v0.16b }, v4.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	stur	q4, [x8, #-80]
	str	q2, [x8, #48]
	ushr	v2.16b, v3.16b, #2
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #112]
	ushr	v2.16b, v3.16b, #4
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #176]
	ushr	v2.16b, v3.16b, #6
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #240]
	add	x8, x8, #512
	b.ne	832b
	b	962f
842:
	cbz	x2, 962f
	ldp	q0, q1, [x3]
	movi	v2.16b, #31
	add	x8, x0, #64
	add	x9, x1, #32
	.p2align	5, , 16
852:
	ldp	q3, q4, [x9, #-32]
	ldp	q5, q6, [x9]
	ldr	q7, [x9, #32]
	subs	x2, x2, #1
	add	x9, x9, #80
	shl	v16.16b, v4.16b, #3
	usra	v16.16b, v3.16b, #5
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	and	v16.16b, v16.16b, v2.16b
	tbl	v16.16b, { v0.16b, v1.16b }, v16.16b
	stp	q3, q16, [x8, #-64]
	add	v16.16b, v5.16b, v5.16b
	ushr	v3.16b, v4.16b, #2
	usra	v16.16b, v4.16b, #7
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	and	v4.16b, v16.16b, v2.16b
	tbl	v4.16b, { v0.16b, v1.16b }, v4.16b
	stp	q3, q4, [x8, #-32]
	shl	v3.16b, v6.16b, #4
	ushr	v4.16b, v6.16b, #1
	usra	v3.16b, v5.16b, #4
	and	v4.16b, v4.16b, v2.16b
	tbl	v4.16b, { v0.16b, v1.16b }, v4.16b
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	stp	q3, q4, [x8]
	shl	v3.16b, v7.16b, #2
	ushr	v4.16b, v7.16b, #3
	usra	v3.16b, v6.16b, #6
	tbl	v4.16b, { v0.16b, v1.16b }, v4.16b
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	stp	q3, q4, [x8, #32]
	add	x8, x8, #128
	b.ne	852b
	b	962f
862:
	cbz	x2, 962f
	ldp	q0, q1, [x3]
	movi	v2.16b, #31
	add	x8, x0, #256
	add	x9, x1, #160
	.p2align	5, , 16
872:
	ldur	q3, [x9, #-160]
	ldur	q4, [x9, #-96]
	ldur	q5, [x9, #-32]
	subs	x2, x2, #1
	and	v16.16b, v3.16b, v2.16b
	ldr	q6, [x9, #32]
	ldr	q7, [x9, #96]
	tbl	v16.16b, { v0.16b, v1.16b }, v16.16b
	stur	q16, [x8, #-256]
	shl	v16.16b, v4.16b, #3
	usra	v16.16b, v3.16b, #5
	and	v3.16b, v16.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	stur	q3, [x8, #-192]
	ushr	v3.16b, v4.16b, #2
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	stur	q3, [x8, #-128]
	add	v3.16b, v5.16b, v5.16b
	usra	v3.16b, v4.16b, #7
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	stur	q3, [x8, #-64]
	shl	v3.16b, v6.16b, #4
	usra	v3.16b, v5.16b, #4
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	str	q3, [x8]
	ushr	v3.16b, v6.16b, #1
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	str	q3, [x8, #64]
	shl	v3.16b, v7.16b, #2
	usra	v3.16b, v6.16b, #6
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	str	q3, [x8, #128]
	ushr	v3.16b, v7.16b, #3
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	str	q3, [x8, #192]
	ldur	q3, [x9, #-144]
	ldur	q4, [x9, #-80]
	ldur	q5, [x9, #-16]
	ldr	q6, [x9, #48]
	ldr	q7, [x9, #112]
	and	v16.16b, v3.16b, v2.16b
	tbl	v16.16b, { v0.16b, v1.16b }, v16.16b
	stur	q16, [x8, #-240]
	shl	v16.16b, v4.16b, #3
	usra	v16.16b, v3.16b, #5
	and	v3.16b, v16.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	stur	q3, [x8, #-176]
	ushr	v3.16b, v4.16b, #2
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	stur	q3, [x8, #-112]
	add	v3.16b, v5.16b, v5.16b
	usra	v3.16b, v4.16b, #7
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	stur	q3, [x8, #-48]
	shl	v3.16b, v6.16b, #4
	usra	v3.16b, v5.16b, #4
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	str	q3, [x8, #16]
	ushr	v3.16b, v6.16b, #1
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	str	q3, [x8, #80]
	shl	v3.16b, v7.16b, #2
	usra	v3.16b, v6.16b, #6
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	str	q3, [x8, #144]
	ushr	v3.16b, v7.16b, #3
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	str	q3, [x8, #208]
	ldur	q3, [x9, #-128]
	ldur	q4, [x9, #-64]
	ldr	q5, [x9]
	ldr	q6, [x9, #64]
	ldr	q7, [x9, #128]
	and	v16.16b, v3.16b, v2.16b
	tbl	v16.16b, { v0.16b, v1.16b }, v16.16b
	stur	q16, [x8, #-224]
	shl	v16.16b, v4.16b, #3
	usra	v16.16b, v3.16b, #5
	and	v3.16b, v16.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	stur	q3, [x8, #-160]
	ushr	v3.16b, v4.16b, #2
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	stur	q3, [x8, #-96]
	add	v3.16b, v5.16b, v5.16b
	usra	v3.16b, v4.16b, #7
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	stur	q3, [x8, #-32]
	shl	v3.16b, v6.16b, #4
	usra	v3.16b, v5.16b, #4
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	str	q3, [x8, #32]
	ushr	v3.16b, v6.16b, #1
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	str	q3, [x8, #96]
	shl	v3.16b, v7.16b, #2
	usra	v3.16b, v6.16b, #6
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	str	q3, [x8, #160]
	ushr	v3.16b, v7.16b, #3
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	str	q3, [x8, #224]
	ldur	q3, [x9, #-112]
	ldur	q4, [x9, #-48]
	ldr	q5, [x9, #16]
	ldr	q6, [x9, #80]
	ldr	q7, [x9, #144]
	add	x9, x9, #320
	and	v16.16b, v3.16b, v2.16b
	tbl	v16.16b, { v0.16b, v1.16b }, v16.16b
	stur	q16, [x8, #-208]
	shl	v16.16b, v4.16b, #3
	usra	v16.16b, v3.16b, #5
	and	v3.16b, v16.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	stur	q3, [x8, #-144]
	ushr	v3.16b, v4.16b, #2
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	stur	q3, [x8, #-80]
	add	v3.16b, v5.16b, v5.16b
	usra	v3.16b, v4.16b, #7
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	stur	q3, [x8, #-16]
	shl	v3.16b, v6.16b, #4
	usra	v3.16b, v5.16b, #4
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	str	q3, [x8, #48]
	ushr	v3.16b, v6.16b, #1
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	str	q3, [x8, #112]
	shl	v3.16b, v7.16b, #2
	usra	v3.16b, v6.16b, #6
	and	v3.16b, v3.16b, v2.16b
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	str	q3, [x8, #176]
	ushr	v3.16b, v7.16b, #3
	tbl	v3.16b, { v0.16b, v1.16b }, v3.16b
	str	q3, [x8, #240]
	add	x8, x8, #512
	b.ne	872b
	b	962f
882:
	cbz	x2, 962f
	ldr	q0, [x3]
	movi	v1.16b, #7
	add	x8, x0, #64
	add	x9, x1, #32
	.p2align	5, , 16
892:
	ldp	q2, q3, [x9, #-32]
	ldr	q4, [x9], #48
	subs	x2, x2, #1
	ushr	v6.16b, v2.16b, #3
	and	v5.16b, v2.16b, v1.16b
	and	v6.16b, v6.16b, v1.16b
	tbl	v5.16b, { v0.16b }, v5.16b
	tbl	v6.16b, { v0.16b }, v6.16b
	stp	q5, q6, [x8, #-64]
	shl	v5.16b, v3.16b, #2
	usra	v5.16b, v2.16b, #6
	and	v2.16b, v5.16b, v1.16b
	ushr	v5.16b, v3.16b, #1
	and	v5.16b, v5.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	tbl	v5.16b, { v0.16b }, v5.16b
	stp	q2, q5, [x8, #-32]
	add	v5.16b, v4.16b, v4.16b
	ushr	v2.16b, v3.16b, #4
	usra	v5.16b, v3.16b, #7
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	and	v3.16b, v5.16b, v1.16b
	tbl	v3.16b, { v0.16b }, v3.16b
	stp	q2, q3, [x8]
	ushr	v2.16b, v4.16b, #2
	ushr	v3.16b, v4.16b, #5
	and	v2.16b, v2.16b, v1.16b
	tbl	v3.16b, { v0.16b }, v3.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	stp	q2, q3, [x8, #32]
	add	x8, x8, #128
	b.ne	892b
	b	962f
902:
	cbz	x2, 962f
	ldr	q0, [x3]
	movi	v1.16b, #7
	add	x8, x0, #256
	add	x9, x1, #96
	.p2align	5, , 16
912:
	ldur	q2, [x9, #-96]
	ldur	q3, [x9, #-32]
	ldr	q4, [x9, #32]
	subs	x2, x2, #1
	and	v5.16b, v2.16b, v1.16b
	tbl	v5.16b, { v0.16b }, v5.16b
	stur	q5, [x8, #-256]
	ushr	v5.16b, v2.16b, #3
	and	v5.16b, v5.16b, v1.16b
	tbl	v5.16b, { v0.16b }, v5.16b
	stur	q5, [x8, #-192]
	shl	v5.16b, v3.16b, #2
	usra	v5.16b, v2.16b, #6
	and	v2.16b, v5.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	stur	q2, [x8, #-128]
	ushr	v2.16b, v3.16b, #1
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	stur	q2, [x8, #-64]
	ushr	v2.16b, v3.16b, #4
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8]
	add	v2.16b, v4.16b, v4.16b
	usra	v2.16b, v3.16b, #7
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #64]
	ushr	v2.16b, v4.16b, #2
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #128]
	ushr	v2.16b, v4.16b, #5
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #192]
	ldur	q2, [x9, #-80]
	ldur	q3, [x9, #-16]
	ldr	q4, [x9, #48]
	and	v5.16b, v2.16b, v1.16b
	tbl	v5.16b, { v0.16b }, v5.16b
	stur	q5, [x8, #-240]
	ushr	v5.16b, v2.16b, #3
	and	v5.16b, v5.16b, v1.16b
	tbl	v5.16b, { v0.16b }, v5.16b
	stur	q5, [x8, #-176]
	shl	v5.16b, v3.16b, #2
	usra	v5.16b, v2.16b, #6
	and	v2.16b, v5.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	stur	q2, [x8, #-112]
	ushr	v2.16b, v3.16b, #1
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	stur	q2, [x8, #-48]
	ushr	v2.16b, v3.16b, #4
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #16]
	add	v2.16b, v4.16b, v4.16b
	usra	v2.16b, v3.16b, #7
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #80]
	ushr	v2.16b, v4.16b, #2
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #144]
	ushr	v2.16b, v4.16b, #5
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #208]
	ldur	q2, [x9, #-64]
	ldr	q3, [x9]
	ldr	q4, [x9, #64]
	and	v5.16b, v2.16b, v1.16b
	tbl	v5.16b, { v0.16b }, v5.16b
	stur	q5, [x8, #-224]
	ushr	v5.16b, v2.16b, #3
	and	v5.16b, v5.16b, v1.16b
	tbl	v5.16b, { v0.16b }, v5.16b
	stur	q5, [x8, #-160]
	shl	v5.16b, v3.16b, #2
	usra	v5.16b, v2.16b, #6
	and	v2.16b, v5.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	stur	q2, [x8, #-96]
	ushr	v2.16b, v3.16b, #1
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	stur	q2, [x8, #-32]
	ushr	v2.16b, v3.16b, #4
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #32]
	add	v2.16b, v4.16b, v4.16b
	usra	v2.16b, v3.16b, #7
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #96]
	ushr	v2.16b, v4.16b, #2
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #160]
	ushr	v2.16b, v4.16b, #5
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #224]
	ldur	q2, [x9, #-48]
	ldr	q3, [x9, #16]
	ldr	q4, [x9, #80]
	add	x9, x9, #192
	and	v5.16b, v2.16b, v1.16b
	tbl	v5.16b, { v0.16b }, v5.16b
	stur	q5, [x8, #-208]
	ushr	v5.16b, v2.16b, #3
	and	v5.16b, v5.16b, v1.16b
	tbl	v5.16b, { v0.16b }, v5.16b
	stur	q5, [x8, #-144]
	shl	v5.16b, v3.16b, #2
	usra	v5.16b, v2.16b, #6
	and	v2.16b, v5.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	stur	q2, [x8, #-80]
	ushr	v2.16b, v3.16b, #1
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	stur	q2, [x8, #-16]
	ushr	v2.16b, v3.16b, #4
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #48]
	add	v2.16b, v4.16b, v4.16b
	usra	v2.16b, v3.16b, #7
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #112]
	ushr	v2.16b, v4.16b, #2
	and	v2.16b, v2.16b, v1.16b
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #176]
	ushr	v2.16b, v4.16b, #5
	tbl	v2.16b, { v0.16b }, v2.16b
	str	q2, [x8, #240]
	add	x8, x8, #512
	b.ne	912b
	b	962f
922:
	cbz	x2, 962f
	ldp	q0, q1, [x3]
	ldp	q2, q3, [x3, #32]
	movi	v4.16b, #63
	add	x8, x0, #64
	add	x9, x1, #48
	.p2align	5, , 16
932:
	ldp	q5, q6, [x9, #-48]
	subs	x2, x2, #1
	shl	v16.16b, v6.16b, #2
	usra	v16.16b, v5.16b, #6
	and	v7.16b, v5.16b, v4.16b
	tbl	v7.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v7.16b
	and	v5.16b, v16.16b, v4.16b
	ldp	q16, q17, [x9, #-16]
	tbl	v5.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v5.16b
	shl	v18.16b, v16.16b, #4
	usra	v18.16b, v6.16b, #4
	ldp	q6, q19, [x9, #16]
	add	x9, x9, #96
	stp	q7, q5, [x8, #-64]
	ushr	v5.16b, v16.16b, #2
	and	v7.16b, v17.16b, v4.16b
	and	v18.16b, v18.16b, v4.16b
	tbl	v5.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v5.16b
	tbl	v7.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v7.16b
	tbl	v18.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v18.16b
	shl	v16.16b, v6.16b, #2
	usra	v16.16b, v17.16b, #6
	and	v16.16b, v16.16b, v4.16b
	stp	q18, q5, [x8, #-32]
	shl	v5.16b, v19.16b, #4
	usra	v5.16b, v6.16b, #4
	ushr	v6.16b, v19.16b, #2
	tbl	v16.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v16.16b
	tbl	v6.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v6.16b
	and	v5.16b, v5.16b, v4.16b
	tbl	v5.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v5.16b
	stp	q7, q16, [x8]
	stp	q5, q6, [x8, #32]
	add	x8, x8, #128
	b.ne	932b
	b	962f
942:
	cbz	x2, 962f
	ldp	q0, q1, [x3]
	ldp	q2, q3, [x3, #32]
	movi	v4.16b, #63
	add	x8, x0, #256
	add	x9, x1, #192
	.p2align	5, , 16
952:
	ldur	q5, [x9, #-192]
	ldur	q6, [x9, #-128]
	ldur	q7, [x9, #-64]
	subs	x2, x2, #1
	and	v19.16b, v5.16b, v4.16b
	ldr	q16, [x9, #64]
	ldr	q17, [x9, #128]
	ldr	q18, [x9]
	tbl	v19.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v19.16b
	stur	q19, [x8, #-256]
	shl	v19.16b, v6.16b, #2
	usra	v19.16b, v5.16b, #6
	shl	v5.16b, v7.16b, #4
	usra	v5.16b, v6.16b, #4
	ushr	v6.16b, v7.16b, #2
	tbl	v6.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v6.16b
	and	v7.16b, v19.16b, v4.16b
	and	v19.16b, v18.16b, v4.16b
	and	v5.16b, v5.16b, v4.16b
	tbl	v7.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v7.16b
	stur	q6, [x8, #-64]
	tbl	v6.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v19.16b
	shl	v19.16b, v16.16b, #2
	usra	v19.16b, v18.16b, #6
	and	v18.16b, v19.16b, v4.16b
	str	q6, [x8]
	shl	v6.16b, v17.16b, #4
	tbl	v5.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v5.16b
	usra	v6.16b, v16.16b, #4
	stur	q5, [x8, #-128]
	stur	q7, [x8, #-192]
	and	v5.16b, v6.16b, v4.16b
	ushr	v6.16b, v17.16b, #2
	tbl	v18.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v18.16b
	str	q18, [x8, #64]
	tbl	v5.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v5.16b
	tbl	v6.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v6.16b
	str	q5, [x8, #128]
	str	q6, [x8, #192]
	ldur	q5, [x9, #-176]
	ldur	q6, [x9, #-112]
	ldur	q7, [x9, #-48]
	ldr	q16, [x9, #16]
	ldr	q17, [x9, #80]
	ldr	q18, [x9, #144]
	and	v19.16b, v5.16b, v4.16b
	tbl	v19.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v19.16b
	stur	q19, [x8, #-240]
	shl	v19.16b, v6.16b, #2
	usra	v19.16b, v5.16b, #6
	shl	v5.16b, v7.16b, #4
	usra	v5.16b, v6.16b, #4
	ushr	v6.16b, v7.16b, #2
	and	v19.16b, v19.16b, v4.16b
	and	v5.16b, v5.16b, v4.16b
	tbl	v6.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v6.16b
	tbl	v7.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v19.16b
	shl	v19.16b, v17.16b, #2
	stur	q6, [x8, #-48]
	and	v6.16b, v16.16b, v4.16b
	usra	v19.16b, v16.16b, #6
	and	v16.16b, v19.16b, v4.16b
	tbl	v6.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v6.16b
	tbl	v5.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v5.16b
	stur	q5, [x8, #-112]
	ushr	v5.16b, v18.16b, #2
	stur	q7, [x8, #-176]
	str	q6, [x8, #16]
	shl	v6.16b, v18.16b, #4
	tbl	v16.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v16.16b
	tbl	v5.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v5.16b
	usra	v6.16b, v17.16b, #4
	str	q16, [x8, #80]
	str	q5, [x8, #208]
	and	v6.16b, v6.16b, v4.16b
	tbl	v6.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v6.16b
	str	q6, [x8, #144]
	ldur	q6, [x9, #-96]
	ldur	q5, [x9, #-160]
	ldur	q7, [x9, #-32]
	ldr	q16, [x9, #32]
	ldr	q17, [x9, #96]
	ldr	q18, [x9, #160]
	shl	v19.16b, v6.16b, #2
	usra	v19.16b, v5.16b, #6
	and	v5.16b, v5.16b, v4.16b
	and	v19.16b, v19.16b, v4.16b
	tbl	v5.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v5.16b
	stur	q5, [x8, #-224]
	ushr	v5.16b, v7.16b, #2
	tbl	v5.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v5.16b
	stur	q5, [x8, #-32]
	shl	v5.16b, v7.16b, #4
	and	v7.16b, v16.16b, v4.16b
	tbl	v7.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v7.16b
	usra	v5.16b, v6.16b, #4
	and	v5.16b, v5.16b, v4.16b
	str	q7, [x8, #32]
	shl	v7.16b, v17.16b, #2
	tbl	v6.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v19.16b
	stur	q6, [x8, #-160]
	ushr	v6.16b, v18.16b, #2
	usra	v7.16b, v16.16b, #6
	shl	v16.16b, v18.16b, #4
	usra	v16.16b, v17.16b, #4
	tbl	v5.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v5.16b
	tbl	v6.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v6.16b
	and	v7.16b, v7.16b, v4.16b
	stur	q5, [x8, #-96]
	str	q6, [x8, #224]
	and	v16.16b, v16.16b, v4.16b
	tbl	v7.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v7.16b
	tbl	v16.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v16.16b
	str	q7, [x8, #96]
	str	q16, [x8, #160]
	ldur	q5, [x9, #-144]
	ldur	q6, [x9, #-80]
	ldur	q7, [x9, #-16]
	ldr	q16, [x9, #112]
	ldr	q17, [x9, #176]
	ldr	q18, [x9, #48]
	add	x9, x9, #384
	and	v19.16b, v5.16b, v4.16b
	tbl	v19.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v19.16b
	stur	q19, [x8, #-208]
	shl	v19.16b, v6.16b, #2
	usra	v19.16b, v5.16b, #6
	shl	v5.16b, v7.16b, #4
	usra	v5.16b, v6.16b, #4
	ushr	v6.16b, v7.16b, #2
	and	v7.16b, v19.16b, v4.16b
	and	v19.16b, v18.16b, v4.16b
	tbl	v6.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v6.16b
	and	v5.16b, v5.16b, v4.16b
	stur	q6, [x8, #-16]
	tbl	v6.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v19.16b
	shl	v19.16b, v16.16b, #2
	usra	v19.16b, v18.16b, #6
	and	v18.16b, v19.16b, v4.16b
	str	q6, [x8, #48]
	shl	v6.16b, v17.16b, #4
	tbl	v5.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v5.16b
	usra	v6.16b, v16.16b, #4
	stur	q5, [x8, #-80]
	tbl	v7.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v7.16b
	stur	q7, [x8, #-144]
	tbl	v18.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v18.16b
	and	v5.16b, v6.16b, v4.16b
	ushr	v6.16b, v17.16b, #2
	tbl	v5.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v5.16b
	str	q18, [x8, #112]
	tbl	v6.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v6.16b
	str	q5, [x8, #176]
	str	q6, [x8, #240]
	add	x8, x8, #512
	b.ne	952b
962:
	ret
	.p2align	4
972:
	str	d10, [sp, #-32]!
	ldr	q0, [x5]
	stp	d9, d8, [sp, #16]
	cmp	x3, #4
	b.le	1222f
	ldp	q2, q3, [x5, #32]
	ldr	q1, [x5, #16]
	cmp	x3, #6
	b.gt	1452f
	cmp	x3, #5
	b.ne	2162f
	cmp	x4, #64
	mov	w8, #64
	adrp	x9, 2942f
	adrp	x10, 2952f
	ccmp	x2, x8, #0, hs
	adrp	x8, 2962f
	b.lo	992f
	ldr	q6, [x10, :lo12:2952f]
	ldr	q4, [x8, :lo12:2962f]
	ldr	q5, [x9, :lo12:2942f]
	movi	v7.16b, #31
	sub	x11, x4, #40
	neg	v6.8h, v6.8h
	.p2align	5, , 16
982:
	ldr	q16, [x1]
	sub	x2, x2, #64
	tbl	v17.16b, { v16.16b }, v4.16b
	tbl	v16.16b, { v16.16b }, v5.16b
	ushl	v16.8h, v16.8h, v6.8h
	ushl	v17.8h, v17.8h, v6.8h
	uzp1	v16.16b, v17.16b, v16.16b
	ldur	q17, [x1, #10]
	and	v16.16b, v16.16b, v7.16b
	tbl	v16.16b, { v0.16b, v1.16b }, v16.16b
	tbl	v18.16b, { v17.16b }, v4.16b
	tbl	v17.16b, { v17.16b }, v5.16b
	ushl	v17.8h, v17.8h, v6.8h
	ushl	v18.8h, v18.8h, v6.8h
	uzp1	v17.16b, v18.16b, v17.16b
	ldur	q18, [x1, #20]
	and	v17.16b, v17.16b, v7.16b
	tbl	v17.16b, { v0.16b, v1.16b }, v17.16b
	tbl	v19.16b, { v18.16b }, v4.16b
	tbl	v18.16b, { v18.16b }, v5.16b
	ushl	v18.8h, v18.8h, v6.8h
	ushl	v19.8h, v19.8h, v6.8h
	uzp1	v18.16b, v19.16b, v18.16b
	ldur	q19, [x1, #30]
	add	x1, x1, #40
	and	v18.16b, v18.16b, v7.16b
	tbl	v18.16b, { v0.16b, v1.16b }, v18.16b
	tbl	v20.16b, { v19.16b }, v4.16b
	tbl	v19.16b, { v19.16b }, v5.16b
	ushl	v19.8h, v19.8h, v6.8h
	ushl	v20.8h, v20.8h, v6.8h
	uzp1	v19.16b, v20.16b, v19.16b
	and	v19.16b, v19.16b, v7.16b
	tbl	v19.16b, { v0.16b, v1.16b }, v19.16b
	stp	q18, q19, [x0, #32]
	stp	q16, q17, [x0], #64
	cmp	x2, #64
	b.lo	992f
	cmp	x11, #63
	sub	x11, x11, #40
	b.hi	982b
992:
	cbz	x2, 2682f
	ldr	q6, [x10, :lo12:2952f]
	ldr	q4, [x8, :lo12:2962f]
	ldr	q5, [x9, :lo12:2942f]
	movi	v7.16b, #31
	add	x8, x0, #32
	mov	w9, #64
	neg	v6.8h, v6.8h
	b	1012f
	.p2align	5, , 16
1002:
	add	x0, x0, #64
	add	x1, x1, #40
	subs	x2, x2, x10
	add	x8, x8, #64
	b.eq	2682f
1012:
	cmp	x2, #64
	csel	x10, x2, x9, lo
	add	x11, x10, x10, lsl #2
	add	x11, x11, #7
	lsr	x12, x11, #3
	ubfx	x13, x11, #3, #3
	and	x12, x12, #0xf8
	cmp	x13, #4
	b.lo	1022f
	lsl	x14, x13, #3
	add	x13, x12, x13
	ldr	w15, [x1, x12]
	add	x13, x1, x13
	sub	x14, x14, #32
	ldur	w13, [x13, #-4]
	b	1032f
	.p2align	5, , 16
1022:
	cmp	x13, #2
	b.lo	1142f
	lsl	x14, x13, #3
	add	x13, x12, x13
	ldrh	w15, [x1, x12]
	add	x13, x1, x13
	sub	x14, x14, #16
	ldurh	w13, [x13, #-2]
1032:
	lsl	x13, x13, x14
	orr	x13, x13, x15
1042:
	fmov	d16, x13
	tbnz	w11, #6, 1052f
	movi	v17.2d, #0000000000000000
	movi	v18.2d, #0000000000000000
	movi	v19.2d, #0000000000000000
	tbnz	w11, #7, 1062f
	b	1072f
	.p2align	5, , 16
1052:
	add	x13, x1, x12
	movi	v18.2d, #0000000000000000
	ext	v17.16b, v16.16b, v18.16b, #8
	dup	v16.2d, v16.d[0]
	sub	x12, x12, #8
	sub	x13, x13, #8
	ld1	{ v16.d }[0], [x13]
	movi	v19.2d, #0000000000000000
	tbz	w11, #7, 1072f
1062:
	add	x12, x1, x12
	mov	v19.16b, v18.16b
	mov	v18.16b, v17.16b
	mov	v17.16b, v16.16b
	ldur	q20, [x12, #-16]
	mov	v16.16b, v20.16b
1072:
	tbz	w11, #8, 1082f
	mov	v18.16b, v16.16b
	mov	v19.16b, v17.16b
	ldp	q16, q17, [x1]
1082:
	mov	x12, v16.d[1]
	fmov	x14, d17
	extr	x12, x14, x12, #16
	stp	q16, q17, [x6]
	mov	x15, v17.d[1]
	tbl	v17.16b, { v16.16b }, v4.16b
	ushl	v17.8h, v17.8h, v6.8h
	extr	x16, x15, x14, #16
	extr	x14, x15, x14, #32
	tbl	v16.16b, { v16.16b }, v5.16b
	ushl	v16.8h, v16.8h, v6.8h
	uzp1	v16.16b, v17.16b, v16.16b
	fmov	d17, x12
	stp	q18, q19, [x6, #32]
	and	v16.16b, v16.16b, v7.16b
	mov	x11, v18.d[1]
	mov	v17.d[1], x16
	tbl	v16.16b, { v0.16b, v1.16b }, v16.16b
	fmov	x13, d18
	extr	x12, x13, x15, #32
	extr	x11, x11, x13, #48
	tbl	v18.16b, { v17.16b }, v4.16b
	tbl	v17.16b, { v17.16b }, v5.16b
	ushl	v17.8h, v17.8h, v6.8h
	ushl	v18.8h, v18.8h, v6.8h
	uzp1	v17.16b, v18.16b, v17.16b
	fmov	d18, x14
	and	v17.16b, v17.16b, v7.16b
	mov	v18.d[1], x12
	extr	x12, x13, x15, #48
	tbl	v17.16b, { v0.16b, v1.16b }, v17.16b
	tbl	v19.16b, { v18.16b }, v4.16b
	tbl	v18.16b, { v18.16b }, v5.16b
	ushl	v18.8h, v18.8h, v6.8h
	ushl	v19.8h, v19.8h, v6.8h
	uzp1	v18.16b, v19.16b, v18.16b
	fmov	d19, x12
	and	v18.16b, v18.16b, v7.16b
	mov	v19.d[1], x11
	tbl	v20.16b, { v19.16b }, v4.16b
	tbl	v19.16b, { v19.16b }, v5.16b
	ushl	v19.8h, v19.8h, v6.8h
	ushl	v20.8h, v20.8h, v6.8h
	uzp1	v19.16b, v20.16b, v19.16b
	and	v20.16b, v19.16b, v7.16b
	tbl	v19.16b, { v0.16b, v1.16b }, v18.16b
	tbl	v18.16b, { v0.16b, v1.16b }, v20.16b
	cmp	x2, #64
	b.lo	1092f
	stp	q16, q17, [x8, #-32]
	stp	q19, q18, [x8]
	b	1002b
	.p2align	5, , 16
1092:
	mov	x11, x0
	cmp	x2, #32
	b.hs	1152f
	tbnz	w10, #4, 1162f
1102:
	fmov	x13, d16
	tst	x10, #0x8
	mov	x12, v16.d[1]
	csel	x12, x13, x12, eq
	tbnz	w10, #3, 1172f
1112:
	tbnz	w10, #2, 1182f
1122:
	tbnz	w10, #1, 1192f
1132:
	tbz	w10, #0, 1002b
	b	1202f
	.p2align	5, , 16
1142:
	cmp	x13, #1
	b.ne	1212f
	ldrb	w13, [x1, x12]
	b	1042b
	.p2align	5, , 16
1152:
	stp	q16, q17, [x8, #-32]
	mov	v16.16b, v19.16b
	mov	v17.16b, v18.16b
	mov	x11, x8
	tbz	w10, #4, 1102b
1162:
	str	q16, [x11], #16
	mov	v16.16b, v17.16b
	fmov	x13, d16
	tst	x10, #0x8
	mov	x12, v16.d[1]
	csel	x12, x13, x12, eq
	tbz	w10, #3, 1112b
1172:
	str	x13, [x11], #8
	tbz	w10, #2, 1122b
1182:
	str	w12, [x11], #4
	lsr	x12, x12, #32
	tbz	w10, #1, 1132b
1192:
	strh	w12, [x11], #2
	lsr	x12, x12, #16
	tbz	w10, #0, 1002b
1202:
	strb	w12, [x11]
	b	1002b
1212:
	mov	x13, xzr
	b	1042b
1222:
	cmp	x3, #2
	b.eq	1692f
	cmp	x3, #3
	b.ne	1922f
	cmp	x4, #64
	mov	w8, #64
	adrp	x9, 2972f
	adrp	x10, 2982f
	ccmp	x2, x8, #0, hs
	adrp	x8, 2992f
	b.lo	1242f
	ldr	q6, [x10, :lo12:2982f]
	ldr	q4, [x8, :lo12:2992f]
	ldr	q5, [x9, :lo12:2972f]
	movi	v7.16b, #7
	sub	x11, x4, #24
	neg	v6.8h, v6.8h
	.p2align	5, , 16
1232:
	ldr	q16, [x1]
	sub	x2, x2, #64
	tbl	v17.16b, { v16.16b }, v4.16b
	tbl	v16.16b, { v16.16b }, v5.16b
	ushl	v16.8h, v16.8h, v6.8h
	ushl	v17.8h, v17.8h, v6.8h
	uzp1	v16.16b, v17.16b, v16.16b
	ldur	q17, [x1, #6]
	and	v16.16b, v16.16b, v7.16b
	tbl	v16.16b, { v0.16b }, v16.16b
	tbl	v18.16b, { v17.16b }, v4.16b
	tbl	v17.16b, { v17.16b }, v5.16b
	ushl	v17.8h, v17.8h, v6.8h
	ushl	v18.8h, v18.8h, v6.8h
	uzp1	v17.16b, v18.16b, v17.16b
	ldur	q18, [x1, #12]
	and	v17.16b, v17.16b, v7.16b
	tbl	v17.16b, { v0.16b }, v17.16b
	tbl	v19.16b, { v18.16b }, v4.16b
	tbl	v18.16b, { v18.16b }, v5.16b
	ushl	v18.8h, v18.8h, v6.8h
	ushl	v19.8h, v19.8h, v6.8h
	uzp1	v18.16b, v19.16b, v18.16b
	ldur	q19, [x1, #18]
	add	x1, x1, #24
	and	v18.16b, v18.16b, v7.16b
	tbl	v18.16b, { v0.16b }, v18.16b
	tbl	v20.16b, { v19.16b }, v4.16b
	tbl	v19.16b, { v19.16b }, v5.16b
	ushl	v19.8h, v19.8h, v6.8h
	ushl	v20.8h, v20.8h, v6.8h
	uzp1	v19.16b, v20.16b, v19.16b
	and	v19.16b, v19.16b, v7.16b
	tbl	v19.16b, { v0.16b }, v19.16b
	stp	q18, q19, [x0, #32]
	stp	q16, q17, [x0], #64
	cmp	x2, #64
	b.lo	1242f
	cmp	x11, #63
	sub	x11, x11, #24
	b.hi	1232b
1242:
	cbz	x2, 2682f
	ldr	q6, [x10, :lo12:2982f]
	ldr	q4, [x8, :lo12:2992f]
	ldr	q5, [x9, :lo12:2972f]
	movi	v7.16b, #7
	add	x8, x0, #32
	mov	w9, #64
	neg	v6.8h, v6.8h
	b	1272f
	.p2align	5, , 16
1252:
	stp	q16, q17, [x8, #-32]
	stp	q19, q18, [x8]
1262:
	add	x0, x0, #64
	add	x1, x1, #24
	subs	x2, x2, x10
	add	x8, x8, #64
	b.eq	2682f
1272:
	cmp	x2, #64
	csel	x10, x2, x9, lo
	add	x11, x10, x10, lsl #1
	add	x11, x11, #7
	lsr	x12, x11, #3
	ubfx	x13, x11, #3, #3
	and	x12, x12, #0x78
	cmp	x13, #4
	b.lo	1282f
	lsl	x14, x13, #3
	add	x13, x12, x13
	ldr	w15, [x1, x12]
	add	x13, x1, x13
	sub	x14, x14, #32
	ldur	w13, [x13, #-4]
	b	1292f
	.p2align	5, , 16
1282:
	cmp	x13, #2
	b.lo	1342f
	lsl	x14, x13, #3
	add	x13, x12, x13
	ldrh	w15, [x1, x12]
	add	x13, x1, x13
	sub	x14, x14, #16
	ldurh	w13, [x13, #-2]
1292:
	lsl	x13, x13, x14
	orr	x13, x13, x15
1302:
	fmov	d16, x13
	tbnz	w11, #6, 1312f
	movi	v17.2d, #0000000000000000
	movi	v18.2d, #0000000000000000
	movi	v19.2d, #0000000000000000
	tbnz	w11, #7, 1322f
	b	1332f
	.p2align	5, , 16
1312:
	add	x13, x1, x12
	movi	v18.2d, #0000000000000000
	ext	v17.16b, v16.16b, v18.16b, #8
	dup	v16.2d, v16.d[0]
	sub	x12, x12, #8
	sub	x13, x13, #8
	ld1	{ v16.d }[0], [x13]
	movi	v19.2d, #0000000000000000
	tbz	w11, #7, 1332f
1322:
	add	x11, x1, x12
	mov	v19.16b, v18.16b
	mov	v18.16b, v17.16b
	mov	v17.16b, v16.16b
	ldur	q20, [x11, #-16]
	mov	v16.16b, v20.16b
1332:
	fmov	x13, d16
	mov	x14, v16.d[1]
	extr	x13, x14, x13, #48
	stp	q16, q17, [x6]
	mov	x12, v17.d[1]
	fmov	x15, d17
	extr	x16, x15, x14, #48
	extr	x14, x15, x14, #32
	tbl	v17.16b, { v16.16b }, v4.16b
	ushl	v17.8h, v17.8h, v6.8h
	tbl	v16.16b, { v16.16b }, v5.16b
	ushl	v16.8h, v16.8h, v6.8h
	uzp1	v16.16b, v17.16b, v16.16b
	fmov	d17, x13
	extr	x13, x12, x15, #32
	and	v16.16b, v16.16b, v7.16b
	stp	q18, q19, [x6, #32]
	mov	v17.d[1], x16
	fmov	x11, d18
	extr	x11, x11, x12, #16
	extr	x12, x12, x15, #16
	tbl	v16.16b, { v0.16b }, v16.16b
	tbl	v18.16b, { v17.16b }, v4.16b
	tbl	v17.16b, { v17.16b }, v5.16b
	ushl	v17.8h, v17.8h, v6.8h
	ushl	v18.8h, v18.8h, v6.8h
	uzp1	v17.16b, v18.16b, v17.16b
	fmov	d18, x14
	and	v17.16b, v17.16b, v7.16b
	mov	v18.d[1], x13
	tbl	v17.16b, { v0.16b }, v17.16b
	tbl	v19.16b, { v18.16b }, v4.16b
	tbl	v18.16b, { v18.16b }, v5.16b
	ushl	v18.8h, v18.8h, v6.8h
	ushl	v19.8h, v19.8h, v6.8h
	uzp1	v18.16b, v19.16b, v18.16b
	fmov	d19, x12
	and	v18.16b, v18.16b, v7.16b
	mov	v19.d[1], x11
	tbl	v20.16b, { v19.16b }, v4.16b
	tbl	v19.16b, { v19.16b }, v5.16b
	ushl	v19.8h, v19.8h, v6.8h
	ushl	v20.8h, v20.8h, v6.8h
	uzp1	v19.16b, v20.16b, v19.16b
	and	v20.16b, v19.16b, v7.16b
	tbl	v19.16b, { v0.16b }, v18.16b
	tbl	v18.16b, { v0.16b }, v20.16b
	cmp	x2, #64
	b.hs	1252b
	cmp	x2, #32
	b.hs	1352f
	mov	x11, x0
	tbnz	w10, #4, 1362f
	b	1372f
	.p2align	5, , 16
1342:
	cmp	x13, #1
	b.ne	1442f
	ldrb	w13, [x1, x12]
	b	1302b
	.p2align	5, , 16
1352:
	stp	q16, q17, [x8, #-32]
	mov	v16.16b, v19.16b
	mov	v17.16b, v18.16b
	mov	x11, x8
	tbz	w10, #4, 1372f
1362:
	str	q16, [x11], #16
	mov	v16.16b, v17.16b
1372:
	fmov	x13, d16
	tst	x10, #0x8
	mov	x12, v16.d[1]
	csel	x12, x13, x12, eq
	tbnz	w10, #3, 1402f
	tbnz	w10, #2, 1412f
1382:
	tbnz	w10, #1, 1422f
1392:
	tbz	w10, #0, 1262b
	b	1432f
	.p2align	5, , 16
1402:
	str	x13, [x11], #8
	tbz	w10, #2, 1382b
1412:
	str	w12, [x11], #4
	lsr	x12, x12, #32
	tbz	w10, #1, 1392b
1422:
	strh	w12, [x11], #2
	lsr	x12, x12, #16
	tbz	w10, #0, 1262b
1432:
	strb	w12, [x11]
	b	1262b
1442:
	mov	x13, xzr
	b	1302b
1452:
	cmp	x3, #7
	b.ne	2412f
	ldp	q6, q7, [x5, #96]
	ldp	q4, q5, [x5, #64]
	cmp	x4, #64
	mov	w8, #64
	ccmp	x2, x8, #0, hs
	adrp	x8, 3002f
	adrp	x9, 3012f
	adrp	x10, 3022f
	b.lo	1472f
	ldr	q18, [x10, :lo12:3022f]
	ldr	q16, [x8, :lo12:3002f]
	ldr	q17, [x9, :lo12:3012f]
	movi	v19.16b, #127
	movi	v20.16b, #192
	sub	x11, x4, #56
	neg	v18.8h, v18.8h
	.p2align	5, , 16
1462:
	ldr	q21, [x1]
	sub	x2, x2, #64
	tbl	v22.16b, { v21.16b }, v16.16b
	tbl	v21.16b, { v21.16b }, v17.16b
	ushl	v21.8h, v21.8h, v18.8h
	ushl	v22.8h, v22.8h, v18.8h
	uzp1	v21.16b, v22.16b, v21.16b
	ldur	q22, [x1, #14]
	and	v21.16b, v21.16b, v19.16b
	tbl	v26.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v21.16b
	add	v21.16b, v21.16b, v20.16b
	tbl	v23.16b, { v22.16b }, v16.16b
	tbl	v22.16b, { v22.16b }, v17.16b
	tbl	v21.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v21.16b
	ushl	v22.8h, v22.8h, v18.8h
	ushl	v23.8h, v23.8h, v18.8h
	uzp1	v22.16b, v23.16b, v22.16b
	ldur	q23, [x1, #28]
	orr	v21.16b, v21.16b, v26.16b
	and	v22.16b, v22.16b, v19.16b
	tbl	v27.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v22.16b
	add	v22.16b, v22.16b, v20.16b
	tbl	v24.16b, { v23.16b }, v16.16b
	tbl	v23.16b, { v23.16b }, v17.16b
	tbl	v22.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v22.16b
	ushl	v23.8h, v23.8h, v18.8h
	ushl	v24.8h, v24.8h, v18.8h
	uzp1	v23.16b, v24.16b, v23.16b
	ldur	q24, [x1, #42]
	orr	v22.16b, v22.16b, v27.16b
	add	x1, x1, #56
	and	v23.16b, v23.16b, v19.16b
	tbl	v25.16b, { v24.16b }, v16.16b
	tbl	v24.16b, { v24.16b }, v17.16b
	ushl	v24.8h, v24.8h, v18.8h
	ushl	v25.8h, v25.8h, v18.8h
	uzp1	v24.16b, v25.16b, v24.16b
	tbl	v25.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v23.16b
	add	v23.16b, v23.16b, v20.16b
	and	v24.16b, v24.16b, v19.16b
	tbl	v23.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v23.16b
	orr	v23.16b, v23.16b, v25.16b
	tbl	v28.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v24.16b
	add	v24.16b, v24.16b, v20.16b
	tbl	v24.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v24.16b
	orr	v24.16b, v24.16b, v28.16b
	stp	q23, q24, [x0, #32]
	stp	q21, q22, [x0], #64
	cmp	x2, #64
	b.lo	1472f
	cmp	x11, #63
	sub	x11, x11, #56
	b.hi	1462b
1472:
	cbz	x2, 2682f
	ldr	q18, [x10, :lo12:3022f]
	ldr	q16, [x8, :lo12:3002f]
	ldr	q17, [x9, :lo12:3012f]
	movi	v19.16b, #127
	movi	v20.16b, #192
	add	x8, x0, #32
	mov	w9, #64
	neg	v18.8h, v18.8h
	b	1502f
	.p2align	5, , 16
1482:
	stp	q21, q22, [x8, #-32]
	stp	q24, q23, [x8]
1492:
	add	x0, x0, #64
	add	x1, x1, #56
	subs	x2, x2, x10
	add	x8, x8, #64
	b.eq	2682f
1502:
	cmp	x2, #64
	csel	x10, x2, x9, lo
	lsl	x11, x10, #3
	sub	x11, x11, x10
	add	x11, x11, #7
	lsr	x12, x11, #3
	ubfx	x13, x11, #3, #3
	and	x12, x12, #0xf8
	cmp	x13, #4
	b.lo	1512f
	lsl	x14, x13, #3
	add	x13, x12, x13
	ldr	w15, [x1, x12]
	add	x13, x1, x13
	sub	x14, x14, #32
	ldur	w13, [x13, #-4]
	b	1522f
	.p2align	5, , 16
1512:
	cmp	x13, #2
	b.lo	1582f
	lsl	x14, x13, #3
	add	x13, x12, x13
	ldrh	w15, [x1, x12]
	add	x13, x1, x13
	sub	x14, x14, #16
	ldurh	w13, [x13, #-2]
1522:
	lsl	x13, x13, x14
	orr	x13, x13, x15
1532:
	fmov	d23, x13
	tbnz	w11, #6, 1542f
	movi	v24.2d, #0000000000000000
	movi	v21.2d, #0000000000000000
	movi	v22.2d, #0000000000000000
	tbnz	w11, #7, 1552f
	b	1562f
	.p2align	5, , 16
1542:
	add	x13, x1, x12
	movi	v21.2d, #0000000000000000
	ext	v24.16b, v23.16b, v21.16b, #8
	dup	v23.2d, v23.d[0]
	sub	x12, x12, #8
	sub	x13, x13, #8
	ld1	{ v23.d }[0], [x13]
	movi	v22.2d, #0000000000000000
	tbz	w11, #7, 1562f
1552:
	add	x12, x1, x12
	mov	v22.16b, v21.16b
	mov	v21.16b, v24.16b
	mov	v24.16b, v23.16b
	ldur	q25, [x12, #-16]
	mov	v23.16b, v25.16b
1562:
	tbz	w11, #8, 1572f
	mov	v21.16b, v23.16b
	mov	v22.16b, v24.16b
	ldp	q23, q24, [x1]
1572:
	mov	x15, v23.d[1]
	fmov	x17, d24
	extr	x15, x17, x15, #48
	stp	q23, q24, [x6]
	mov	x16, v24.d[1]
	tbl	v24.16b, { v23.16b }, v16.16b
	ushl	v24.8h, v24.8h, v18.8h
	extr	x3, x16, x17, #48
	tbl	v23.16b, { v23.16b }, v17.16b
	ushl	v23.8h, v23.8h, v18.8h
	uzp1	v23.16b, v24.16b, v23.16b
	fmov	d24, x15
	fmov	x13, d21
	and	v23.16b, v23.16b, v19.16b
	mov	x14, v21.d[1]
	extr	x15, x14, x13, #32
	extr	x13, x13, x16, #32
	mov	v24.d[1], x3
	fmov	x11, d22
	mov	x12, v22.d[1]
	extr	x12, x12, x11, #16
	extr	x11, x11, x14, #16
	tbl	v25.16b, { v24.16b }, v16.16b
	tbl	v24.16b, { v24.16b }, v17.16b
	ushl	v24.8h, v24.8h, v18.8h
	ushl	v25.8h, v25.8h, v18.8h
	tbl	v27.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v23.16b
	add	v23.16b, v23.16b, v20.16b
	uzp1	v24.16b, v25.16b, v24.16b
	fmov	d25, x13
	stp	q21, q22, [x6, #32]
	tbl	v23.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v23.16b
	and	v24.16b, v24.16b, v19.16b
	mov	v25.d[1], x15
	tbl	v29.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v24.16b
	add	v24.16b, v24.16b, v20.16b
	tbl	v24.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v24.16b
	tbl	v26.16b, { v25.16b }, v16.16b
	tbl	v25.16b, { v25.16b }, v17.16b
	ushl	v25.8h, v25.8h, v18.8h
	ushl	v26.8h, v26.8h, v18.8h
	orr	v22.16b, v24.16b, v29.16b
	uzp1	v25.16b, v26.16b, v25.16b
	fmov	d26, x11
	and	v25.16b, v25.16b, v19.16b
	mov	v26.d[1], x12
	tbl	v30.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v25.16b
	add	v25.16b, v25.16b, v20.16b
	tbl	v25.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v25.16b
	tbl	v28.16b, { v26.16b }, v16.16b
	tbl	v26.16b, { v26.16b }, v17.16b
	ushl	v26.8h, v26.8h, v18.8h
	ushl	v28.8h, v28.8h, v18.8h
	orr	v24.16b, v25.16b, v30.16b
	uzp1	v26.16b, v28.16b, v26.16b
	and	v26.16b, v26.16b, v19.16b
	add	v21.16b, v26.16b, v20.16b
	tbl	v28.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v26.16b
	tbl	v26.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v21.16b
	orr	v21.16b, v23.16b, v27.16b
	orr	v23.16b, v26.16b, v28.16b
	cmp	x2, #64
	b.hs	1482b
	cmp	x2, #32
	b.hs	1592f
	mov	x11, x0
	tbnz	w10, #4, 1602f
	b	1612f
	.p2align	5, , 16
1582:
	cmp	x13, #1
	b.ne	1682f
	ldrb	w13, [x1, x12]
	b	1532b
	.p2align	5, , 16
1592:
	stp	q21, q22, [x8, #-32]
	mov	v21.16b, v24.16b
	mov	v22.16b, v23.16b
	mov	x11, x8
	tbz	w10, #4, 1612f
1602:
	str	q21, [x11], #16
	mov	v21.16b, v22.16b
1612:
	fmov	x13, d21
	tst	x10, #0x8
	mov	x12, v21.d[1]
	csel	x12, x13, x12, eq
	tbnz	w10, #3, 1642f
	tbnz	w10, #2, 1652f
1622:
	tbnz	w10, #1, 1662f
1632:
	tbz	w10, #0, 1492b
	b	1672f
	.p2align	5, , 16
1642:
	str	x13, [x11], #8
	tbz	w10, #2, 1622b
1652:
	str	w12, [x11], #4
	lsr	x12, x12, #32
	tbz	w10, #1, 1632b
1662:
	strh	w12, [x11], #2
	lsr	x12, x12, #16
	tbz	w10, #0, 1492b
1672:
	strb	w12, [x11]
	b	1492b
1682:
	mov	x13, xzr
	b	1532b
1692:
	cmp	x4, #64
	mov	w8, #64
	adrp	x9, 3032f
	adrp	x10, 3042f
	ccmp	x2, x8, #0, hs
	adrp	x8, 3052f
	b.lo	1712f
	ldr	q6, [x10, :lo12:3042f]
	ldr	q4, [x8, :lo12:3052f]
	ldr	q5, [x9, :lo12:3032f]
	movi	v7.16b, #3
	sub	x11, x4, #16
	neg	v6.8h, v6.8h
	.p2align	5, , 16
1702:
	ldr	q16, [x1]
	sub	x2, x2, #64
	tbl	v17.16b, { v16.16b }, v4.16b
	tbl	v16.16b, { v16.16b }, v5.16b
	ushl	v16.8h, v16.8h, v6.8h
	ushl	v17.8h, v17.8h, v6.8h
	uzp1	v16.16b, v17.16b, v16.16b
	ldur	q17, [x1, #4]
	and	v16.16b, v16.16b, v7.16b
	tbl	v16.16b, { v0.16b }, v16.16b
	tbl	v18.16b, { v17.16b }, v4.16b
	tbl	v17.16b, { v17.16b }, v5.16b
	ushl	v17.8h, v17.8h, v6.8h
	ushl	v18.8h, v18.8h, v6.8h
	uzp1	v17.16b, v18.16b, v17.16b
	ldur	q18, [x1, #8]
	and	v17.16b, v17.16b, v7.16b
	tbl	v17.16b, { v0.16b }, v17.16b
	tbl	v19.16b, { v18.16b }, v4.16b
	tbl	v18.16b, { v18.16b }, v5.16b
	ushl	v18.8h, v18.8h, v6.8h
	ushl	v19.8h, v19.8h, v6.8h
	uzp1	v18.16b, v19.16b, v18.16b
	ldur	q19, [x1, #12]
	add	x1, x1, #16
	and	v18.16b, v18.16b, v7.16b
	tbl	v18.16b, { v0.16b }, v18.16b
	tbl	v20.16b, { v19.16b }, v4.16b
	tbl	v19.16b, { v19.16b }, v5.16b
	ushl	v19.8h, v19.8h, v6.8h
	ushl	v20.8h, v20.8h, v6.8h
	uzp1	v19.16b, v20.16b, v19.16b
	and	v19.16b, v19.16b, v7.16b
	tbl	v19.16b, { v0.16b }, v19.16b
	stp	q18, q19, [x0, #32]
	stp	q16, q17, [x0], #64
	cmp	x2, #64
	b.lo	1712f
	cmp	x11, #63
	sub	x11, x11, #16
	b.hi	1702b
1712:
	cbz	x2, 2682f
	ldr	q6, [x10, :lo12:3042f]
	ldr	q4, [x8, :lo12:3052f]
	ldr	q5, [x9, :lo12:3032f]
	movi	v7.16b, #3
	add	x8, x0, #32
	mov	w9, #64
	neg	v6.8h, v6.8h
	b	1742f
	.p2align	5, , 16
1722:
	stp	q16, q17, [x8, #-32]
	stp	q19, q18, [x8]
1732:
	add	x0, x0, #64
	add	x1, x1, #16
	subs	x2, x2, x10
	add	x8, x8, #64
	b.eq	2682f
1742:
	cmp	x2, #64
	csel	x10, x2, x9, lo
	lsl	x11, x10, #1
	add	x11, x11, #6
	lsr	x12, x11, #3
	ubfx	x13, x11, #3, #3
	and	x12, x12, #0x38
	cmp	x13, #4
	b.lo	1752f
	lsl	x14, x13, #3
	add	x13, x12, x13
	ldr	w15, [x1, x12]
	add	x13, x1, x13
	sub	x14, x14, #32
	ldur	w13, [x13, #-4]
	b	1762f
	.p2align	5, , 16
1752:
	cmp	x13, #2
	b.lo	1812f
	lsl	x14, x13, #3
	add	x13, x12, x13
	ldrh	w15, [x1, x12]
	add	x13, x1, x13
	sub	x14, x14, #16
	ldurh	w13, [x13, #-2]
1762:
	lsl	x13, x13, x14
	orr	x13, x13, x15
1772:
	fmov	d16, x13
	tbnz	w11, #6, 1782f
	movi	v17.2d, #0000000000000000
	movi	v18.2d, #0000000000000000
	movi	v19.2d, #0000000000000000
	tbnz	w11, #7, 1792f
	b	1802f
	.p2align	5, , 16
1782:
	add	x13, x1, x12
	movi	v18.2d, #0000000000000000
	ext	v17.16b, v16.16b, v18.16b, #8
	dup	v16.2d, v16.d[0]
	sub	x12, x12, #8
	sub	x13, x13, #8
	ld1	{ v16.d }[0], [x13]
	movi	v19.2d, #0000000000000000
	tbz	w11, #7, 1802f
1792:
	add	x11, x1, x12
	mov	v19.16b, v18.16b
	mov	v18.16b, v17.16b
	mov	v17.16b, v16.16b
	ldur	q20, [x11, #-16]
	mov	v16.16b, v20.16b
1802:
	fmov	x12, d16
	mov	x13, v16.d[1]
	extr	x12, x13, x12, #32
	stp	q18, q19, [x6, #32]
	tbl	v18.16b, { v16.16b }, v4.16b
	ushl	v18.8h, v18.8h, v6.8h
	tbl	v19.16b, { v16.16b }, v5.16b
	ushl	v19.8h, v19.8h, v6.8h
	uzp1	v18.16b, v18.16b, v19.16b
	fmov	x14, d17
	extr	x15, x14, x13, #32
	fmov	d19, x12
	mov	x11, v17.d[1]
	fmov	d20, x15
	extr	x11, x11, x14, #32
	and	v18.16b, v18.16b, v7.16b
	stp	q16, q17, [x6]
	ext	v16.16b, v16.16b, v17.16b, #8
	tbl	v17.16b, { v16.16b }, v4.16b
	ushl	v17.8h, v17.8h, v6.8h
	mov	v19.d[1], x15
	tbl	v16.16b, { v16.16b }, v5.16b
	mov	v20.d[1], x11
	ushl	v16.8h, v16.8h, v6.8h
	uzp1	v16.16b, v17.16b, v16.16b
	tbl	v21.16b, { v19.16b }, v4.16b
	tbl	v19.16b, { v19.16b }, v5.16b
	tbl	v17.16b, { v20.16b }, v5.16b
	ushl	v19.8h, v19.8h, v6.8h
	ushl	v21.8h, v21.8h, v6.8h
	ushl	v17.8h, v17.8h, v6.8h
	uzp1	v19.16b, v21.16b, v19.16b
	and	v21.16b, v16.16b, v7.16b
	tbl	v16.16b, { v20.16b }, v4.16b
	ushl	v16.8h, v16.8h, v6.8h
	and	v19.16b, v19.16b, v7.16b
	uzp1	v16.16b, v16.16b, v17.16b
	tbl	v17.16b, { v0.16b }, v19.16b
	tbl	v19.16b, { v0.16b }, v21.16b
	and	v20.16b, v16.16b, v7.16b
	tbl	v16.16b, { v0.16b }, v18.16b
	tbl	v18.16b, { v0.16b }, v20.16b
	cmp	x2, #64
	b.hs	1722b
	cmp	x2, #32
	b.hs	1822f
	mov	x11, x0
	tbnz	w10, #4, 1832f
	b	1842f
	.p2align	5, , 16
1812:
	cmp	x13, #1
	b.ne	1912f
	ldrb	w13, [x1, x12]
	b	1772b
	.p2align	5, , 16
1822:
	stp	q16, q17, [x8, #-32]
	mov	v16.16b, v19.16b
	mov	v17.16b, v18.16b
	mov	x11, x8
	tbz	w10, #4, 1842f
1832:
	str	q16, [x11], #16
	mov	v16.16b, v17.16b
1842:
	fmov	x13, d16
	tst	x10, #0x8
	mov	x12, v16.d[1]
	csel	x12, x13, x12, eq
	tbnz	w10, #3, 1872f
	tbnz	w10, #2, 1882f
1852:
	tbnz	w10, #1, 1892f
1862:
	tbz	w10, #0, 1732b
	b	1902f
	.p2align	5, , 16
1872:
	str	x13, [x11], #8
	tbz	w10, #2, 1852b
1882:
	str	w12, [x11], #4
	lsr	x12, x12, #32
	tbz	w10, #1, 1862b
1892:
	strh	w12, [x11], #2
	lsr	x12, x12, #16
	tbz	w10, #0, 1732b
1902:
	strb	w12, [x11]
	b	1732b
1912:
	mov	x13, xzr
	b	1772b
1922:
	cmp	x4, #64
	mov	w8, #64
	adrp	x9, 3062f
	ccmp	x2, x8, #0, hs
	adrp	x8, 3072f
	b.lo	1942f
	ldr	q4, [x8, :lo12:3072f]
	ldr	q5, [x9, :lo12:3062f]
	movi	v6.4s, #4, lsl #16
	movi	v7.16b, #15
	sub	x10, x4, #32
	neg	v6.8h, v6.8h
	.p2align	5, , 16
1932:
	ldr	q16, [x1]
	sub	x2, x2, #64
	tbl	v17.16b, { v16.16b }, v4.16b
	tbl	v16.16b, { v16.16b }, v5.16b
	ushl	v16.8h, v16.8h, v6.8h
	ushl	v17.8h, v17.8h, v6.8h
	uzp1	v16.16b, v17.16b, v16.16b
	ldur	q17, [x1, #8]
	and	v16.16b, v16.16b, v7.16b
	tbl	v16.16b, { v0.16b }, v16.16b
	tbl	v18.16b, { v17.16b }, v4.16b
	tbl	v17.16b, { v17.16b }, v5.16b
	ushl	v17.8h, v17.8h, v6.8h
	ushl	v18.8h, v18.8h, v6.8h
	uzp1	v17.16b, v18.16b, v17.16b
	ldr	q18, [x1, #16]
	and	v17.16b, v17.16b, v7.16b
	tbl	v17.16b, { v0.16b }, v17.16b
	tbl	v19.16b, { v18.16b }, v4.16b
	tbl	v18.16b, { v18.16b }, v5.16b
	ushl	v18.8h, v18.8h, v6.8h
	ushl	v19.8h, v19.8h, v6.8h
	uzp1	v18.16b, v19.16b, v18.16b
	ldur	q19, [x1, #24]
	add	x1, x1, #32
	and	v18.16b, v18.16b, v7.16b
	tbl	v18.16b, { v0.16b }, v18.16b
	tbl	v20.16b, { v19.16b }, v4.16b
	tbl	v19.16b, { v19.16b }, v5.16b
	ushl	v19.8h, v19.8h, v6.8h
	ushl	v20.8h, v20.8h, v6.8h
	uzp1	v19.16b, v20.16b, v19.16b
	and	v19.16b, v19.16b, v7.16b
	tbl	v19.16b, { v0.16b }, v19.16b
	stp	q18, q19, [x0, #32]
	stp	q16, q17, [x0], #64
	cmp	x2, #64
	b.lo	1942f
	cmp	x10, #63
	sub	x10, x10, #32
	b.hi	1932b
1942:
	cbz	x2, 2682f
	ldr	q4, [x8, :lo12:3072f]
	ldr	q5, [x9, :lo12:3062f]
	movi	v6.4s, #4, lsl #16
	movi	v7.16b, #15
	add	x8, x0, #32
	mov	w9, #64
	neg	v6.8h, v6.8h
	b	1972f
	.p2align	5, , 16
1952:
	stp	q16, q17, [x8, #-32]
	stp	q19, q18, [x8]
1962:
	add	x0, x0, #64
	add	x1, x1, #32
	subs	x2, x2, x10
	add	x8, x8, #64
	b.eq	2682f
1972:
	cmp	x2, #64
	csel	x10, x2, x9, lo
	lsl	x11, x10, #2
	add	x11, x11, #4
	lsr	x12, x11, #3
	ubfx	x13, x11, #3, #3
	and	x12, x12, #0x78
	cmp	x13, #4
	b.lo	1982f
	lsl	x14, x13, #3
	add	x13, x12, x13
	ldr	w15, [x1, x12]
	add	x13, x1, x13
	sub	x14, x14, #32
	ldur	w13, [x13, #-4]
	b	1992f
	.p2align	5, , 16
1982:
	cmp	x13, #2
	b.lo	2052f
	lsl	x14, x13, #3
	add	x13, x12, x13
	ldrh	w15, [x1, x12]
	add	x13, x1, x13
	sub	x14, x14, #16
	ldurh	w13, [x13, #-2]
1992:
	lsl	x13, x13, x14
	orr	x13, x13, x15
2002:
	fmov	d17, x13
	tbnz	w11, #6, 2012f
	movi	v16.2d, #0000000000000000
	movi	v18.2d, #0000000000000000
	movi	v19.2d, #0000000000000000
	tbnz	w11, #7, 2022f
	b	2032f
	.p2align	5, , 16
2012:
	add	x13, x1, x12
	movi	v18.2d, #0000000000000000
	ext	v16.16b, v17.16b, v18.16b, #8
	dup	v17.2d, v17.d[0]
	sub	x12, x12, #8
	sub	x13, x13, #8
	ld1	{ v17.d }[0], [x13]
	movi	v19.2d, #0000000000000000
	tbz	w11, #7, 2032f
2022:
	add	x12, x1, x12
	mov	v19.16b, v18.16b
	mov	v18.16b, v16.16b
	mov	v16.16b, v17.16b
	ldur	q20, [x12, #-16]
	mov	v17.16b, v20.16b
2032:
	tbz	w11, #8, 2042f
	mov	v18.16b, v17.16b
	mov	v19.16b, v16.16b
	ldp	q17, q16, [x1]
2042:
	tbl	v20.16b, { v17.16b }, v5.16b
	stp	q17, q16, [x6]
	ushl	v20.8h, v20.8h, v6.8h
	tbl	v21.16b, { v16.16b }, v5.16b
	stp	q18, q19, [x6, #32]
	ushl	v21.8h, v21.8h, v6.8h
	tbl	v19.16b, { v17.16b }, v4.16b
	ushl	v19.8h, v19.8h, v6.8h
	ext	v17.16b, v17.16b, v16.16b, #8
	uzp1	v19.16b, v19.16b, v20.16b
	tbl	v20.16b, { v17.16b }, v4.16b
	tbl	v17.16b, { v17.16b }, v5.16b
	ushl	v17.8h, v17.8h, v6.8h
	ushl	v20.8h, v20.8h, v6.8h
	and	v19.16b, v19.16b, v7.16b
	uzp1	v17.16b, v20.16b, v17.16b
	tbl	v20.16b, { v16.16b }, v4.16b
	ext	v16.16b, v16.16b, v18.16b, #8
	tbl	v18.16b, { v16.16b }, v4.16b
	tbl	v16.16b, { v16.16b }, v5.16b
	ushl	v20.8h, v20.8h, v6.8h
	and	v17.16b, v17.16b, v7.16b
	ushl	v16.8h, v16.8h, v6.8h
	ushl	v18.8h, v18.8h, v6.8h
	uzp1	v20.16b, v20.16b, v21.16b
	tbl	v17.16b, { v0.16b }, v17.16b
	uzp1	v16.16b, v18.16b, v16.16b
	and	v20.16b, v20.16b, v7.16b
	and	v18.16b, v16.16b, v7.16b
	tbl	v16.16b, { v0.16b }, v19.16b
	tbl	v19.16b, { v0.16b }, v20.16b
	tbl	v18.16b, { v0.16b }, v18.16b
	cmp	x2, #64
	b.hs	1952b
	cmp	x2, #32
	b.hs	2062f
	mov	x11, x0
	tbnz	w10, #4, 2072f
	b	2082f
	.p2align	5, , 16
2052:
	cmp	x13, #1
	b.ne	2152f
	ldrb	w13, [x1, x12]
	b	2002b
	.p2align	5, , 16
2062:
	stp	q16, q17, [x8, #-32]
	mov	v16.16b, v19.16b
	mov	v17.16b, v18.16b
	mov	x11, x8
	tbz	w10, #4, 2082f
2072:
	str	q16, [x11], #16
	mov	v16.16b, v17.16b
2082:
	fmov	x13, d16
	tst	x10, #0x8
	mov	x12, v16.d[1]
	csel	x12, x13, x12, eq
	tbnz	w10, #3, 2112f
	tbnz	w10, #2, 2122f
2092:
	tbnz	w10, #1, 2132f
2102:
	tbz	w10, #0, 1962b
	b	2142f
	.p2align	5, , 16
2112:
	str	x13, [x11], #8
	tbz	w10, #2, 2092b
2122:
	str	w12, [x11], #4
	lsr	x12, x12, #32
	tbz	w10, #1, 2102b
2132:
	strh	w12, [x11], #2
	lsr	x12, x12, #16
	tbz	w10, #0, 1962b
2142:
	strb	w12, [x11]
	b	1962b
2152:
	mov	x13, xzr
	b	2002b
2162:
	cmp	x4, #64
	mov	w8, #64
	adrp	x9, 3082f
	adrp	x10, 3092f
	ccmp	x2, x8, #0, hs
	adrp	x8, 3102f
	b.lo	2182f
	ldr	q6, [x10, :lo12:3092f]
	ldr	q4, [x8, :lo12:3102f]
	ldr	q5, [x9, :lo12:3082f]
	movi	v7.16b, #63
	sub	x11, x4, #48
	neg	v6.8h, v6.8h
	.p2align	5, , 16
2172:
	ldr	q16, [x1]
	sub	x2, x2, #64
	tbl	v17.16b, { v16.16b }, v4.16b
	tbl	v16.16b, { v16.16b }, v5.16b
	ushl	v16.8h, v16.8h, v6.8h
	ushl	v17.8h, v17.8h, v6.8h
	uzp1	v16.16b, v17.16b, v16.16b
	ldur	q17, [x1, #12]
	and	v16.16b, v16.16b, v7.16b
	tbl	v16.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v16.16b
	tbl	v18.16b, { v17.16b }, v4.16b
	tbl	v17.16b, { v17.16b }, v5.16b
	ushl	v17.8h, v17.8h, v6.8h
	ushl	v18.8h, v18.8h, v6.8h
	uzp1	v17.16b, v18.16b, v17.16b
	ldur	q18, [x1, #24]
	and	v17.16b, v17.16b, v7.16b
	tbl	v17.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v17.16b
	tbl	v19.16b, { v18.16b }, v4.16b
	tbl	v18.16b, { v18.16b }, v5.16b
	ushl	v18.8h, v18.8h, v6.8h
	ushl	v19.8h, v19.8h, v6.8h
	uzp1	v18.16b, v19.16b, v18.16b
	ldur	q19, [x1, #36]
	add	x1, x1, #48
	and	v18.16b, v18.16b, v7.16b
	tbl	v18.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v18.16b
	tbl	v20.16b, { v19.16b }, v4.16b
	tbl	v19.16b, { v19.16b }, v5.16b
	ushl	v19.8h, v19.8h, v6.8h
	ushl	v20.8h, v20.8h, v6.8h
	uzp1	v19.16b, v20.16b, v19.16b
	and	v19.16b, v19.16b, v7.16b
	tbl	v19.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v19.16b
	stp	q18, q19, [x0, #32]
	stp	q16, q17, [x0], #64
	cmp	x2, #64
	b.lo	2182f
	cmp	x11, #63
	sub	x11, x11, #48
	b.hi	2172b
2182:
	cbz	x2, 2682f
	ldr	q6, [x10, :lo12:3092f]
	ldr	q4, [x8, :lo12:3102f]
	ldr	q5, [x9, :lo12:3082f]
	movi	v7.16b, #63
	add	x8, x0, #32
	mov	w9, #64
	mov	w10, #6
	mov	x11, #6
	neg	v6.8h, v6.8h
	b	2202f
	.p2align	5, , 16
2192:
	add	x0, x0, #64
	add	x1, x1, #48
	subs	x2, x2, x12
	add	x8, x8, #64
	b.eq	2682f
2202:
	cmp	x2, #64
	csel	x12, x2, x9, lo
	madd	x13, x12, x10, x11
	lsr	x14, x13, #3
	ubfx	x15, x13, #3, #3
	and	x14, x14, #0xf8
	cmp	x15, #4
	b.lo	2212f
	lsl	x16, x15, #3
	add	x15, x14, x15
	ldr	w17, [x1, x14]
	add	x15, x1, x15
	sub	x16, x16, #32
	ldur	w15, [x15, #-4]
	b	2222f
	.p2align	5, , 16
2212:
	cmp	x15, #2
	b.lo	2332f
	lsl	x16, x15, #3
	add	x15, x14, x15
	ldrh	w17, [x1, x14]
	add	x15, x1, x15
	sub	x16, x16, #16
	ldurh	w15, [x15, #-2]
2222:
	lsl	x15, x15, x16
	orr	x15, x15, x17
2232:
	fmov	d18, x15
	tbnz	w13, #6, 2242f
	movi	v16.2d, #0000000000000000
	movi	v17.2d, #0000000000000000
	movi	v19.2d, #0000000000000000
	tbnz	w13, #7, 2252f
	b	2262f
	.p2align	5, , 16
2242:
	add	x15, x1, x14
	movi	v17.2d, #0000000000000000
	ext	v16.16b, v18.16b, v17.16b, #8
	dup	v18.2d, v18.d[0]
	sub	x14, x14, #8
	sub	x15, x15, #8
	ld1	{ v18.d }[0], [x15]
	movi	v19.2d, #0000000000000000
	tbz	w13, #7, 2262f
2252:
	add	x14, x1, x14
	mov	v19.16b, v17.16b
	mov	v17.16b, v16.16b
	mov	v16.16b, v18.16b
	ldur	q20, [x14, #-16]
	mov	v18.16b, v20.16b
2262:
	tbz	w13, #8, 2272f
	mov	v17.16b, v18.16b
	mov	v19.16b, v16.16b
	ldp	q18, q16, [x1]
2272:
	mov	x14, v18.d[1]
	fmov	x17, d16
	extr	x14, x17, x14, #32
	stp	q18, q16, [x6]
	stp	q17, q19, [x6, #32]
	fmov	x3, d19
	tbl	v19.16b, { v18.16b }, v4.16b
	ushl	v19.8h, v19.8h, v6.8h
	tbl	v18.16b, { v18.16b }, v5.16b
	ushl	v18.8h, v18.8h, v6.8h
	uzp1	v18.16b, v19.16b, v18.16b
	fmov	d19, x14
	and	v18.16b, v18.16b, v7.16b
	mov	x15, v16.d[1]
	ext	v16.16b, v16.16b, v17.16b, #8
	extr	x15, x15, x17, #32
	mov	v19.d[1], x15
	fmov	x13, d17
	mov	x16, v17.d[1]
	extr	x13, x16, x13, #32
	extr	x3, x3, x16, #32
	tbl	v17.16b, { v16.16b }, v4.16b
	ushl	v17.8h, v17.8h, v6.8h
	tbl	v16.16b, { v16.16b }, v5.16b
	ushl	v16.8h, v16.8h, v6.8h
	uzp1	v16.16b, v17.16b, v16.16b
	tbl	v20.16b, { v19.16b }, v4.16b
	tbl	v19.16b, { v19.16b }, v5.16b
	ushl	v19.8h, v19.8h, v6.8h
	ushl	v20.8h, v20.8h, v6.8h
	uzp1	v19.16b, v20.16b, v19.16b
	and	v20.16b, v16.16b, v7.16b
	fmov	d16, x13
	and	v19.16b, v19.16b, v7.16b
	mov	v16.d[1], x3
	tbl	v17.16b, { v16.16b }, v4.16b
	tbl	v16.16b, { v16.16b }, v5.16b
	ushl	v21.8h, v16.8h, v6.8h
	ushl	v22.8h, v17.8h, v6.8h
	tbl	v17.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v19.16b
	uzp1	v19.16b, v22.16b, v21.16b
	and	v19.16b, v19.16b, v7.16b
	tbl	v16.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v18.16b
	tbl	v18.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v20.16b
	tbl	v19.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v19.16b
	cmp	x2, #64
	b.lo	2282f
	stp	q16, q17, [x8, #-32]
	stp	q18, q19, [x8]
	b	2192b
	.p2align	5, , 16
2282:
	mov	x13, x0
	cmp	x2, #32
	b.hs	2342f
	tbnz	w12, #4, 2352f
2292:
	fmov	x15, d16
	tst	x12, #0x8
	mov	x14, v16.d[1]
	csel	x14, x15, x14, eq
	tbnz	w12, #3, 2362f
2302:
	tbnz	w12, #2, 2372f
2312:
	tbnz	w12, #1, 2382f
2322:
	tbz	w12, #0, 2192b
	b	2392f
	.p2align	5, , 16
2332:
	cmp	x15, #1
	b.ne	2402f
	ldrb	w15, [x1, x14]
	b	2232b
	.p2align	5, , 16
2342:
	stp	q16, q17, [x8, #-32]
	mov	v16.16b, v18.16b
	mov	v17.16b, v19.16b
	mov	x13, x8
	tbz	w12, #4, 2292b
2352:
	str	q16, [x13], #16
	mov	v16.16b, v17.16b
	fmov	x15, d16
	tst	x12, #0x8
	mov	x14, v16.d[1]
	csel	x14, x15, x14, eq
	tbz	w12, #3, 2302b
2362:
	str	x15, [x13], #8
	tbz	w12, #2, 2312b
2372:
	str	w14, [x13], #4
	lsr	x14, x14, #32
	tbz	w12, #1, 2322b
2382:
	strh	w14, [x13], #2
	lsr	x14, x14, #16
	tbz	w12, #0, 2192b
2392:
	strb	w14, [x13]
	b	2192b
2402:
	mov	x15, xzr
	b	2232b
2412:
	ldp	q6, q7, [x5, #224]
	ldp	q4, q5, [x5, #192]
	ldp	q18, q19, [x5, #160]
	subs	x8, x4, #64
	mov	w9, #64
	ccmp	x2, x9, #0, hs
	ldp	q16, q17, [x5, #128]
	ldp	q22, q23, [x5, #96]
	ldp	q20, q21, [x5, #64]
	b.lo	2432f
	movi	v24.16b, #192
	movi	v25.16b, #128
	movi	v26.16b, #64
	.p2align	5, , 16
2422:
	ldr	q27, [x1]
	sub	x2, x2, #64
	tbl	v28.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v27.16b
	add	v29.16b, v27.16b, v24.16b
	tbx	v28.16b, { v20.16b, v21.16b, v22.16b, v23.16b }, v29.16b
	eor	v29.16b, v27.16b, v25.16b
	add	v27.16b, v27.16b, v26.16b
	tbx	v28.16b, { v16.16b, v17.16b, v18.16b, v19.16b }, v29.16b
	tbx	v28.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v27.16b
	ldr	q27, [x1, #16]
	tbl	v29.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v27.16b
	add	v30.16b, v27.16b, v24.16b
	tbx	v29.16b, { v20.16b, v21.16b, v22.16b, v23.16b }, v30.16b
	eor	v30.16b, v27.16b, v25.16b
	add	v27.16b, v27.16b, v26.16b
	tbx	v29.16b, { v16.16b, v17.16b, v18.16b, v19.16b }, v30.16b
	tbx	v29.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v27.16b
	ldr	q27, [x1, #32]
	tbl	v30.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v27.16b
	add	v31.16b, v27.16b, v24.16b
	tbx	v30.16b, { v20.16b, v21.16b, v22.16b, v23.16b }, v31.16b
	eor	v31.16b, v27.16b, v25.16b
	add	v27.16b, v27.16b, v26.16b
	tbx	v30.16b, { v16.16b, v17.16b, v18.16b, v19.16b }, v31.16b
	tbx	v30.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v27.16b
	ldr	q27, [x1, #48]
	add	x1, x1, #64
	tbl	v31.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v27.16b
	add	v8.16b, v27.16b, v24.16b
	tbx	v31.16b, { v20.16b, v21.16b, v22.16b, v23.16b }, v8.16b
	eor	v8.16b, v27.16b, v25.16b
	add	v27.16b, v27.16b, v26.16b
	tbx	v31.16b, { v16.16b, v17.16b, v18.16b, v19.16b }, v8.16b
	tbx	v31.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v27.16b
	stp	q30, q31, [x0, #32]
	stp	q28, q29, [x0], #64
	cmp	x2, #64
	b.lo	2432f
	cmp	x8, #63
	sub	x8, x8, #64
	b.hi	2422b
2432:
	cbz	x2, 2682f
	movi	v24.16b, #192
	movi	v25.16b, #128
	movi	v26.16b, #64
	mov	w9, #64
	mov	x8, xzr
	mov	x10, x0
	b	2452f
	.p2align	5, , 16
2442:
	add	x10, x10, #64
	subs	x2, x2, x11
	add	x8, x8, #64
	b.eq	2682f
2452:
	cmp	x2, #64
	csel	x11, x2, x9, lo
	b.lo	2462f
	add	x12, x1, x8
	ldp	q29, q30, [x12, #32]
	b	2532f
	.p2align	5, , 16
2462:
	and	x12, x11, #0x38
	and	x14, x11, #0x7
	add	x13, x1, x12
	cmp	x14, #4
	b.lo	2472f
	lsl	x15, x14, #3
	add	x14, x12, x14
	add	x16, x1, x8
	ldr	w13, [x13, x8]
	add	x14, x16, x14
	sub	x15, x15, #32
	ldur	w14, [x14, #-4]
	b	2482f
	.p2align	5, , 16
2472:
	cmp	x14, #2
	b.lo	2662f
	lsl	x15, x14, #3
	add	x14, x12, x14
	add	x16, x1, x8
	ldrh	w13, [x13, x8]
	add	x14, x16, x14
	sub	x15, x15, #16
	ldurh	w14, [x14, #-2]
2482:
	lsl	x14, x14, x15
	orr	x13, x14, x13
2492:
	fmov	d27, x13
	tbnz	w11, #3, 2502f
	movi	v28.2d, #0000000000000000
	movi	v29.2d, #0000000000000000
	movi	v30.2d, #0000000000000000
	tbnz	w11, #4, 2512f
	b	2522f
	.p2align	5, , 16
2502:
	add	x13, x1, x12
	movi	v29.2d, #0000000000000000
	ext	v28.16b, v27.16b, v29.16b, #8
	dup	v27.2d, v27.d[0]
	sub	x12, x12, #8
	add	x13, x13, x8
	sub	x13, x13, #8
	ld1	{ v27.d }[0], [x13]
	movi	v30.2d, #0000000000000000
	tbz	w11, #4, 2522f
2512:
	add	x12, x1, x12
	mov	v30.16b, v29.16b
	mov	v29.16b, v28.16b
	mov	v28.16b, v27.16b
	add	x12, x12, x8
	ldur	q31, [x12, #-16]
	mov	v27.16b, v31.16b
2522:
	cmp	x2, #32
	b.lo	2542f
	mov	v29.16b, v27.16b
	mov	v30.16b, v28.16b
	add	x12, x1, x8
2532:
	ldp	q27, q28, [x12]
2542:
	tbl	v31.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v27.16b
	add	v8.16b, v27.16b, v24.16b
	add	v9.16b, v28.16b, v24.16b
	add	v10.16b, v29.16b, v24.16b
	stp	q27, q28, [x6]
	stp	q29, q30, [x6, #32]
	tbx	v31.16b, { v20.16b, v21.16b, v22.16b, v23.16b }, v8.16b
	eor	v8.16b, v27.16b, v25.16b
	tbx	v31.16b, { v16.16b, v17.16b, v18.16b, v19.16b }, v8.16b
	add	v8.16b, v27.16b, v26.16b
	tbl	v27.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v30.16b
	tbx	v31.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v8.16b
	tbl	v8.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v28.16b
	tbx	v8.16b, { v20.16b, v21.16b, v22.16b, v23.16b }, v9.16b
	eor	v9.16b, v28.16b, v25.16b
	tbx	v8.16b, { v16.16b, v17.16b, v18.16b, v19.16b }, v9.16b
	add	v9.16b, v28.16b, v26.16b
	add	v28.16b, v30.16b, v24.16b
	tbx	v27.16b, { v20.16b, v21.16b, v22.16b, v23.16b }, v28.16b
	eor	v28.16b, v30.16b, v25.16b
	tbx	v8.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v9.16b
	tbl	v9.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v29.16b
	tbx	v27.16b, { v16.16b, v17.16b, v18.16b, v19.16b }, v28.16b
	add	v28.16b, v30.16b, v26.16b
	tbx	v9.16b, { v20.16b, v21.16b, v22.16b, v23.16b }, v10.16b
	eor	v10.16b, v29.16b, v25.16b
	tbx	v27.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v28.16b
	tbx	v9.16b, { v16.16b, v17.16b, v18.16b, v19.16b }, v10.16b
	add	v10.16b, v29.16b, v26.16b
	tbx	v9.16b, { v4.16b, v5.16b, v6.16b, v7.16b }, v10.16b
	cmp	x2, #64
	b.lo	2552f
	add	x12, x0, x8
	stp	q31, q8, [x12]
	stp	q9, q27, [x12, #32]
	b	2442b
	.p2align	5, , 16
2552:
	mov	x12, x10
	cmp	x2, #32
	b.hs	2602f
	tbnz	w11, #4, 2612f
2562:
	fmov	x14, d31
	tst	x11, #0x8
	mov	x13, v31.d[1]
	csel	x13, x14, x13, eq
	tbnz	w11, #3, 2622f
2572:
	tbnz	w11, #2, 2632f
2582:
	tbnz	w11, #1, 2642f
2592:
	tbz	w11, #0, 2442b
	b	2652f
	.p2align	5, , 16
2602:
	add	x12, x0, x8
	stp	q31, q8, [x12], #32
	mov	v31.16b, v9.16b
	mov	v8.16b, v27.16b
	tbz	w11, #4, 2562b
2612:
	str	q31, [x12], #16
	mov	v31.16b, v8.16b
	fmov	x14, d31
	tst	x11, #0x8
	mov	x13, v31.d[1]
	csel	x13, x14, x13, eq
	tbz	w11, #3, 2572b
2622:
	str	x14, [x12], #8
	tbz	w11, #2, 2582b
2632:
	str	w13, [x12], #4
	lsr	x13, x13, #32
	tbz	w11, #1, 2592b
2642:
	strh	w13, [x12], #2
	lsr	x13, x13, #16
	tbz	w11, #0, 2442b
2652:
	strb	w13, [x12]
	b	2442b
2662:
	cmp	x14, #1
	b.ne	2672f
	ldrb	w13, [x13, x8]
	b	2492b
2672:
	mov	x13, xzr
	b	2492b
2682:
	ldp	d9, d8, [sp, #16]
	ldr	d10, [sp], #32
	ret
	.p2align	4
2692:
	str	x23, [sp, #-48]!
	lsr	x10, x1, #6
	stp	x22, x21, [sp, #16]
	stp	x20, x19, [sp, #32]
	mov	x8, x0
	cbz	x10, 2722f
	mov	x11, #72340172838076673
	mov	x0, xzr
	mov	x9, xzr
	mov	x12, x2
	mov	x13, x8
	.p2align	5, , 16
2702:
	ldr	x19, [x12], #8
	add	x15, x3, x9
	add	x14, x4, x0
	subs	x10, x10, #1
	ldr	q5, [x15]
	fmov	d0, x19
	lsr	x16, x19, #4
	ubfiz	x17, x19, #4, #8
	lsr	x20, x19, #12
	lsr	x21, x19, #20
	lsr	x6, x19, #28
	lsr	x7, x19, #36
	lsr	x22, x19, #44
	lsr	x23, x19, #56
	and	x16, x16, #0xff0
	and	x21, x21, #0xff0
	and	x20, x20, #0xff0
	add	x16, x5, x16
	add	x21, x5, x21
	ldr	q3, [x5, x20]
	cnt	v0.8b, v0.8b
	ldr	q2, [x16, #4096]
	ldr	q4, [x21, #4096]
	addv	b1, v0.8b
	fmov	x19, d0
	ldr	q0, [x5, x17]
	mul	x19, x19, x11
	ubfx	x17, x19, #8, #8
	lsr	w16, w19, #24
	ubfx	x19, x19, #40, #8
	sub	x20, x15, x17
	sub	x21, x15, x16
	sub	x15, x15, x19
	add	v0.16b, v2.16b, v0.16b
	ldr	q2, [x14]
	mvn	v6.16b, v0.16b
	tbl	v5.16b, { v5.16b }, v6.16b
	tbx	v5.16b, { v2.16b }, v0.16b
	add	v0.16b, v4.16b, v3.16b
	ldr	q3, [x20, #16]
	ldr	q2, [x14, x17]
	and	x17, x6, #0xff0
	and	x6, x7, #0xff0
	mvn	v4.16b, v0.16b
	tbl	v3.16b, { v3.16b }, v4.16b
	ldr	q4, [x21, #32]
	tbx	v3.16b, { v2.16b }, v0.16b
	ldr	q0, [x5, x17]
	add	x17, x5, x6
	ldr	q2, [x17, #4096]
	add	v0.16b, v2.16b, v0.16b
	ldr	q2, [x14, x16]
	and	x16, x22, #0xff0
	mvn	v6.16b, v0.16b
	tbl	v4.16b, { v4.16b }, v6.16b
	ldr	q6, [x15, #48]
	tbx	v4.16b, { v2.16b }, v0.16b
	ldr	q0, [x5, x16]
	add	x16, x5, x23, lsl #4
	ldr	q2, [x16, #4096]
	add	v0.16b, v2.16b, v0.16b
	ldr	q2, [x14, x19]
	mvn	v7.16b, v0.16b
	fmov	x14, d1
	sub	x9, x9, x14
	add	x0, x14, x0
	add	x9, x9, #64
	tbl	v6.16b, { v6.16b }, v7.16b
	tbx	v6.16b, { v2.16b }, v0.16b
	stp	q4, q6, [x13, #32]
	stp	q5, q3, [x13], #64
	b.ne	2702b
	ands	x10, x1, #0x3f
	b.ne	2732f
2712:
	ldp	x20, x19, [sp, #32]
	ldp	x22, x21, [sp, #16]
	ldr	x23, [sp], #48
	ret
2722:
	mov	x9, xzr
	mov	x0, xzr
	ands	x10, x1, #0x3f
	b.eq	2712b
2732:
	and	x11, x1, #0xffffffc0
	add	x13, x10, #7
	add	x12, x2, x11, lsr #3
	lsr	x13, x13, #3
	cmp	x10, #25
	b.lo	2742f
	sub	x13, x13, #4
	ldr	w14, [x12]
	ldr	w12, [x12, x13]
	b	2752f
2742:
	cmp	x10, #9
	b.lo	2762f
	sub	x13, x13, #2
	ldrh	w14, [x12]
	ldrh	w12, [x12, x13]
2752:
	lsl	x13, x13, #3
	lsl	x12, x12, x13
	orr	x12, x12, x14
	b	2772f
2762:
	ldrb	w12, [x12]
2772:
	mov	x13, #-1
	mov	x14, #72340172838076673
	add	x8, x8, x11
	lsl	x10, x13, x10
	bic	x10, x12, x10
	add	x12, x3, x9
	add	x9, x4, x0
	fmov	d0, x10
	lsr	x17, x10, #4
	ubfiz	x16, x10, #4, #8
	ldr	q4, [x12]
	ldr	q3, [x9]
	and	x17, x17, #0xff0
	cnt	v0.8b, v0.8b
	fmov	x13, d0
	ldr	q0, [x5, x16]
	add	x16, x5, x17
	lsr	x17, x10, #20
	ldr	q2, [x16, #4096]
	lsr	x16, x10, #12
	and	x17, x17, #0xff0
	and	x16, x16, #0xff0
	mul	x13, x13, x14
	ldr	q1, [x5, x16]
	add	x16, x5, x17
	ldr	q5, [x16, #4096]
	ubfx	x14, x13, #8, #8
	sub	x15, x12, x14
	ldr	q6, [x9, x14]
	ldr	q7, [x15, #16]
	add	v2.16b, v2.16b, v0.16b
	mvn	v0.16b, v2.16b
	add	v5.16b, v5.16b, v1.16b
	tbl	v0.16b, { v4.16b }, v0.16b
	mvn	v1.16b, v5.16b
	tbx	v0.16b, { v3.16b }, v2.16b
	tbl	v1.16b, { v7.16b }, v1.16b
	tbx	v1.16b, { v6.16b }, v5.16b
	tbnz	w1, #5, 2842f
	tbnz	w1, #4, 2852f
2782:
	fmov	x11, d0
	tst	x1, #0x8
	mov	x9, v0.d[1]
	csel	x9, x11, x9, eq
	tbnz	w1, #3, 2862f
2792:
	tbnz	w1, #2, 2872f
2802:
	tbnz	w1, #1, 2882f
2812:
	tbz	w1, #0, 2832f
2822:
	strb	w9, [x8]
2832:
	fmov	d0, x10
	cnt	v0.8b, v0.8b
	addv	b0, v0.8b
	fmov	x8, d0
	add	x0, x8, x0
	ldp	x20, x19, [sp, #32]
	ldp	x22, x21, [sp, #16]
	ldr	x23, [sp], #48
	ret
2842:
	lsr	w11, w13, #24
	lsr	x15, x10, #28
	lsr	x16, x10, #36
	ubfx	x13, x13, #40, #8
	sub	x14, x12, x11
	ldr	q4, [x9, x11]
	lsr	x11, x10, #44
	and	x15, x15, #0xff0
	and	x16, x16, #0xff0
	sub	x12, x12, x13
	ldr	q16, [x9, x13]
	ldr	q5, [x14, #32]
	lsr	x14, x10, #52
	and	x11, x11, #0xff0
	ldr	q2, [x5, x15]
	add	x15, x5, x16
	ldr	q17, [x12, #48]
	and	x14, x14, #0x7f0
	ldr	q6, [x5, x11]
	ldr	q3, [x15, #4096]
	add	x11, x5, x14
	ldr	q7, [x11, #4096]
	add	v2.16b, v3.16b, v2.16b
	add	v6.16b, v7.16b, v6.16b
	stp	q0, q1, [x8], #32
	mvn	v0.16b, v2.16b
	mvn	v7.16b, v6.16b
	tbl	v0.16b, { v5.16b }, v0.16b
	tbl	v7.16b, { v17.16b }, v7.16b
	tbx	v0.16b, { v4.16b }, v2.16b
	tbx	v7.16b, { v16.16b }, v6.16b
	mov	v1.16b, v7.16b
	tbz	w1, #4, 2782b
2852:
	str	q0, [x8], #16
	mov	v0.16b, v1.16b
	fmov	x11, d0
	tst	x1, #0x8
	mov	x9, v0.d[1]
	csel	x9, x11, x9, eq
	tbz	w1, #3, 2792b
2862:
	str	x11, [x8], #8
	tbz	w1, #2, 2802b
2872:
	str	w9, [x8], #4
	lsr	x9, x9, #32
	tbz	w1, #1, 2812b
2882:
	strh	w9, [x8], #2
	lsr	x9, x9, #16
	tbnz	w1, #0, 2822b
	b	2832b
	.p2align	4, 0x0
2892:
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.p2align	4, 0x0
2902:
	.byte	1
	.byte	2
	.byte	4
	.byte	8
	.byte	16
	.byte	32
	.byte	64
	.byte	128
	.byte	1
	.byte	2
	.byte	4
	.byte	8
	.byte	16
	.byte	32
	.byte	64
	.byte	128
	.p2align	4, 0x0
2912:
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.p2align	4, 0x0
2922:
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.p2align	4, 0x0
2932:
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.p2align	4, 0x0
2942:
	.byte	5
	.byte	6
	.byte	5
	.byte	6
	.byte	6
	.byte	7
	.byte	6
	.byte	7
	.byte	7
	.byte	8
	.byte	8
	.byte	9
	.byte	8
	.byte	9
	.byte	9
	.byte	10
	.p2align	4, 0x0
2952:
	.hword	0
	.hword	5
	.hword	2
	.hword	7
	.hword	4
	.hword	1
	.hword	6
	.hword	3
	.p2align	4, 0x0
2962:
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	2
	.byte	2
	.byte	3
	.byte	3
	.byte	4
	.byte	3
	.byte	4
	.byte	4
	.byte	5
	.p2align	4, 0x0
2972:
	.byte	3
	.byte	4
	.byte	3
	.byte	4
	.byte	3
	.byte	4
	.byte	4
	.byte	5
	.byte	4
	.byte	5
	.byte	4
	.byte	5
	.byte	5
	.byte	6
	.byte	5
	.byte	6
	.p2align	4, 0x0
2982:
	.hword	0
	.hword	3
	.hword	6
	.hword	1
	.hword	4
	.hword	7
	.hword	2
	.hword	5
	.p2align	4, 0x0
2992:
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	2
	.byte	1
	.byte	2
	.byte	2
	.byte	3
	.byte	2
	.byte	3
	.p2align	4, 0x0
3002:
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	1
	.byte	2
	.byte	2
	.byte	3
	.byte	3
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	6
	.byte	6
	.byte	7
	.p2align	4, 0x0
3012:
	.byte	7
	.byte	8
	.byte	7
	.byte	8
	.byte	8
	.byte	9
	.byte	9
	.byte	10
	.byte	10
	.byte	11
	.byte	11
	.byte	12
	.byte	12
	.byte	13
	.byte	13
	.byte	14
	.p2align	4, 0x0
3022:
	.hword	0
	.hword	7
	.hword	6
	.hword	5
	.hword	4
	.hword	3
	.hword	2
	.hword	1
	.p2align	4, 0x0
3032:
	.byte	2
	.byte	3
	.byte	2
	.byte	3
	.byte	2
	.byte	3
	.byte	2
	.byte	3
	.byte	3
	.byte	4
	.byte	3
	.byte	4
	.byte	3
	.byte	4
	.byte	3
	.byte	4
	.p2align	4, 0x0
3042:
	.hword	0
	.hword	2
	.hword	4
	.hword	6
	.hword	0
	.hword	2
	.hword	4
	.hword	6
	.p2align	4, 0x0
3052:
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	2
	.byte	1
	.byte	2
	.byte	1
	.byte	2
	.p2align	4, 0x0
3062:
	.byte	4
	.byte	5
	.byte	4
	.byte	5
	.byte	5
	.byte	6
	.byte	5
	.byte	6
	.byte	6
	.byte	7
	.byte	6
	.byte	7
	.byte	7
	.byte	8
	.byte	7
	.byte	8
	.p2align	4, 0x0
3072:
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	2
	.byte	2
	.byte	3
	.byte	2
	.byte	3
	.byte	3
	.byte	4
	.byte	3
	.byte	4
	.p2align	4, 0x0
3082:
	.byte	6
	.byte	7
	.byte	6
	.byte	7
	.byte	7
	.byte	8
	.byte	8
	.byte	9
	.byte	9
	.byte	10
	.byte	9
	.byte	10
	.byte	10
	.byte	11
	.byte	11
	.byte	12
	.p2align	4, 0x0
3092:
	.hword	0
	.hword	6
	.hword	4
	.hword	2
	.hword	0
	.hword	6
	.hword	4
	.hword	2
	.p2align	4, 0x0
3102:
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	1
	.byte	2
	.byte	2
	.byte	3
	.byte	3
	.byte	4
	.byte	3
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	6

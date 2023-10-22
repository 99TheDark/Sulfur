	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
	.globl	"_.conv:bool_string"            ; -- Begin function .conv:bool_string
	.p2align	2
"_.conv:bool_string":                   ; @".conv:bool_string"
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	tbz	w0, #0, LBB0_2
; %bb.1:                                ; %if.then
Lloh0:
	adrp	x2, l_.strTrue@PAGE
	mov	w1, #4
Lloh1:
	add	x2, x2, l_.strTrue@PAGEOFF
	stp	w1, w1, [sp]
	mov	w0, w1
	str	x2, [sp, #8]
	add	sp, sp, #16
	ret
LBB0_2:                                 ; %if.else
Lloh2:
	adrp	x2, l_.strFalse@PAGE
	mov	w1, #5
Lloh3:
	add	x2, x2, l_.strFalse@PAGEOFF
	stp	w1, w1, [sp]
	mov	w0, w1
	str	x2, [sp, #8]
	add	sp, sp, #16
	ret
	.loh AdrpAdd	Lloh0, Lloh1
	.loh AdrpAdd	Lloh2, Lloh3
	.cfi_endproc
                                        ; -- End function
	.globl	"_newref:float"                 ; -- Begin function newref:float
	.p2align	2
"_newref:float":                        ; @"newref:float"
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w0, #16
	str	s0, [sp, #12]
	bl	_malloc
	str	x0, [sp]
	mov	w0, #4
	bl	_malloc
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	mov	x9, x0
	ldr	x8, [sp]
	ldr	s0, [sp, #12]
	mov	x0, x8
	str	x9, [x8]
	str	s0, [x9]
	str	wzr, [x8, #8]
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	"_ref:float"                    ; -- Begin function ref:float
	.p2align	2
"_ref:float":                           ; @"ref:float"
	.cfi_startproc
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	ldr	w8, [x0, #8]
	mov	x19, x0
	add	w20, w8, #1
	mov	w0, w20
	bl	_countMsg
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	str	w20, [x19, #8]
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_countMsg                       ; -- Begin function countMsg
	.p2align	2
_countMsg:                              ; @countMsg
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	"_.conv:int_string"
	mov	x8, #11
Lloh4:
	adrp	x5, l_.strCount@PAGE
	movk	x8, #11, lsl #32
Lloh5:
	add	x5, x5, l_.strCount@PAGEOFF
	mov	w3, #11
	mov	w4, #11
	stp	x8, x5, [sp]
	bl	"_.add:string_string"
	bl	_.println
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.loh AdrpAdd	Lloh4, Lloh5
	.cfi_endproc
                                        ; -- End function
	.globl	"_.conv:int_string"             ; -- Begin function .conv:int_string
	.p2align	2
"_.conv:int_string":                    ; @".conv:int_string"
	.cfi_startproc
; %bb.0:                                ; %entry
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	sub	sp, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	cbz	w0, LBB4_7
; %bb.1:                                ; %if.end
	mov	x19, sp
	sub	x20, x19, #16
	mov	sp, x20
	mov	x23, sp
	stur	w0, [x19, #-16]
	sub	x8, x23, #16
	mov	sp, x8
	mov	w0, #10
	mov	w22, #10
	bl	_malloc
	mov	x8, sp
	stur	x0, [x23, #-16]
	sub	x21, x8, #16
	mov	sp, x21
	mov	w9, #9
	mov	x10, sp
	stur	w9, [x8, #-16]
	sub	x8, x10, #16
	mov	sp, x8
	ldur	w9, [x19, #-16]
	mov	x19, x0
	stur	wzr, [x10, #-16]
	tbz	w9, #31, LBB4_3
; %bb.2:                                ; %if.then1
	neg	w9, w9
	mov	w10, #1
	str	w9, [x20]
	str	w10, [x8]
LBB4_3:                                 ; %while.cond.preheader
	mov	w9, #26215
	movk	w9, #26214, lsl #16
	ldr	w10, [x20]
	cmp	w10, #1
	b.lt	LBB4_5
LBB4_4:                                 ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	smull	x11, w10, w9
	lsr	x12, x11, #63
	asr	x11, x11, #34
	add	w11, w11, w12
	ldrsw	x12, [x21]
	msub	w10, w11, w22, w10
	sub	w13, w12, #1
	str	w11, [x20]
	add	w10, w10, #48
	strb	w10, [x19, x12]
	str	w13, [x21]
	mov	w10, w11
	cmp	w10, #1
	b.ge	LBB4_4
LBB4_5:                                 ; %while.end
	mov	x9, sp
	sub	x10, x9, #16
	mov	sp, x10
	ldr	w23, [x21]
	ldr	w22, [x8]
	sub	w8, w22, w23
	add	w20, w8, #9
	mov	w0, w20
	stur	w20, [x9, #-16]
	stp	w20, w20, [x29, #-64]
	bl	_malloc
	stur	x0, [x29, #-56]
	cbz	w22, LBB4_8
; %bb.6:                                ; %if.then2
	ldur	x8, [x29, #-56]
	mov	w9, #45
	strb	w9, [x8]
	b	LBB4_9
LBB4_7:                                 ; %if.then
Lloh6:
	adrp	x9, l_.strZero@PAGE
	mov	x8, #4294967297
Lloh7:
	add	x9, x9, l_.strZero@PAGEOFF
	stp	x8, x9, [x29, #-64]
	b	LBB4_12
LBB4_8:                                 ; %if.else2
	add	w8, w23, #1
	str	w8, [x21]
LBB4_9:                                 ; %if.end2
	mov	x10, sp
	sub	x8, x10, #16
	mov	sp, x8
	ldr	w9, [x21]
	stur	w22, [x10, #-16]
	ldr	w10, [x8]
	cmp	w10, w20
	b.ge	LBB4_11
LBB4_10:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	add	w11, w9, w10
	add	w13, w10, #1
	ldur	x12, [x29, #-56]
	ldrb	w11, [x19, w11, sxtw]
	str	w13, [x8]
	strb	w11, [x12, w10, sxtw]
	mov	w10, w13
	cmp	w10, w20
	b.lt	LBB4_10
LBB4_11:                                ; %for.end
	mov	x0, x19
	bl	_free
LBB4_12:                                ; %exit
	ldp	w0, w1, [x29, #-64]
	ldur	x2, [x29, #-56]
	sub	sp, x29, #48
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh6, Lloh7
	.cfi_endproc
                                        ; -- End function
	.globl	"_.add:string_string"           ; -- Begin function .add:string_string
	.p2align	2
"_.add:string_string":                  ; @".add:string_string"
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #96
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 96
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	add	w19, w1, w4
	add	w8, w0, w3
	stp	w0, w1, [sp, #32]
	mov	w0, w19
	mov	w20, w1
	str	x2, [sp, #40]
	stp	w3, w4, [sp, #16]
	str	x5, [sp, #24]
	stp	w8, w19, [sp, #48]
	bl	_malloc
	str	xzr, [sp, #8]
	str	x0, [sp, #56]
	lsr	x8, xzr, #32
	cmp	w8, w20
	b.ge	LBB5_3
LBB5_1:                                 ; %while1.body
                                        ; =>This Inner Loop Header: Depth=1
	ldrsw	x8, [sp, #12]
	ldr	x9, [sp, #40]
	ldr	x10, [sp, #56]
	ldrb	w9, [x9, x8]
	add	w11, w8, #1
	strb	w9, [x10, x8]
	str	w11, [sp, #12]
	mov	w8, w11
	cmp	w8, w20
	b.lt	LBB5_1
	b	LBB5_3
LBB5_2:                                 ; %while2.body
                                        ;   in Loop: Header=BB5_3 Depth=1
	ldpsw	x9, x8, [sp, #8]
	ldr	x10, [sp, #24]
	ldr	x11, [sp, #56]
	ldrb	w10, [x10, x9]
	add	w12, w8, #1
	add	w9, w9, #1
	strb	w10, [x11, x8]
	stp	w9, w12, [sp, #8]
LBB5_3:                                 ; %while2.cond
                                        ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #12]
	cmp	w8, w19
	b.lt	LBB5_2
; %bb.4:                                ; %while2.end
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	w0, w1, [sp, #48]
	ldr	x2, [sp, #56]
	add	sp, sp, #96
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_.println                       ; -- Begin function .println
	.p2align	2
_.println:                              ; @.println
	.cfi_startproc
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_.print
	mov	w0, #10
	bl	_putchar
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_.print                         ; -- Begin function .print
	.p2align	2
_.print:                                ; @.print
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 48
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	wzr, [sp, #8]
	str	x2, [sp, #24]
	stp	w0, w1, [sp, #16]
	mov	w8, wzr
	ldr	w9, [sp, #20]
	cmp	w8, w9
	b.ge	LBB7_2
LBB7_1:                                 ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	ldrsw	x8, [sp, #8]
	ldr	x9, [sp, #24]
	ldrb	w0, [x9, x8]
	bl	_putchar
	ldr	w8, [sp, #8]
	add	w8, w8, #1
	str	w8, [sp, #8]
	mov	w8, w8
	ldr	w9, [sp, #20]
	cmp	w8, w9
	b.lt	LBB7_1
LBB7_2:                                 ; %for.end
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	"_deref:float"                  ; -- Begin function deref:float
	.p2align	2
"_deref:float":                         ; @"deref:float"
	.cfi_startproc
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	ldr	w8, [x0, #8]
	mov	x19, x0
	sub	w20, w8, #1
	mov	w0, w20
	bl	_countMsg
	str	w20, [x19, #8]
	cbz	w20, LBB8_2
; %bb.1:                                ; %exit
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB8_2:                                 ; %if.then
	ldr	x0, [x19]
	bl	_free
	mov	x0, x19
	bl	_free
	bl	_freeMsg
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_freeMsg                        ; -- Begin function freeMsg
	.p2align	2
_freeMsg:                               ; @freeMsg
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	x8, #17
Lloh8:
	adrp	x2, l_.strFree@PAGE
	movk	x8, #17, lsl #32
Lloh9:
	add	x2, x2, l_.strFree@PAGEOFF
	mov	w0, #17
	mov	w1, #17
	stp	x8, x2, [sp]
	bl	_.println
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.loh AdrpAdd	Lloh8, Lloh9
	.cfi_endproc
                                        ; -- End function
	.globl	"_.conv:float_string"           ; -- Begin function .conv:float_string
	.p2align	2
"_.conv:float_string":                  ; @".conv:float_string"
	.cfi_startproc
; %bb.0:                                ; %entry
	stp	x28, x27, [sp, #-96]!           ; 16-byte Folded Spill
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	sub	sp, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	fcmp	s0, s0
	b.vc	LBB10_4
; %bb.1:                                ; %nan.then
Lloh10:
	adrp	x9, l_.strNaN@PAGE
	mov	x8, #12884901891
Lloh11:
	add	x9, x9, l_.strNaN@PAGEOFF
LBB10_2:                                ; %exit
	stp	x8, x9, [x29, #-96]
LBB10_3:                                ; %exit
	ldp	w0, w1, [x29, #-96]
	ldur	x2, [x29, #-88]
	sub	sp, x29, #80
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
LBB10_4:                                ; %nan.exit
	mov	w8, #2139095040
	fmov	s1, w8
	fcmp	s0, s1
	b.mi	LBB10_6
	b.gt	LBB10_6
; %bb.5:                                ; %pos_inf.then
Lloh12:
	adrp	x9, l_.strPosInf@PAGE
	mov	x8, #12884901891
Lloh13:
	add	x9, x9, l_.strPosInf@PAGEOFF
	b	LBB10_2
LBB10_6:                                ; %pos_inf.exit
	mov	w8, #-8388608
	fmov	s1, w8
	fcmp	s0, s1
	b.mi	LBB10_8
	b.gt	LBB10_8
; %bb.7:                                ; %neg_inf.then
Lloh14:
	adrp	x9, l_.strNegInf@PAGE
	mov	x8, #17179869188
Lloh15:
	add	x9, x9, l_.strNegInf@PAGEOFF
	b	LBB10_2
LBB10_8:                                ; %neg_inf.exit
	fcmp	s0, #0.0
	b.mi	LBB10_11
	b.gt	LBB10_11
; %bb.9:                                ; %zero.then
	fmov	w8, s0
	lsr	w8, w8, #31
	cbz	w8, LBB10_22
; %bb.10:                               ; %neg_zero.then
Lloh16:
	adrp	x9, l_.strNegZero@PAGE
	mov	x8, #17179869188
Lloh17:
	add	x9, x9, l_.strNegZero@PAGEOFF
	b	LBB10_2
LBB10_11:                               ; %zero.exit
	mov	x9, sp
	sub	x8, x9, #16
	mov	sp, x8
	mov	x11, sp
	sub	x8, x11, #16
	mov	sp, x8
	mov	x12, sp
	sub	x8, x12, #16
	mov	sp, x8
	mov	x13, sp
	sub	x10, x13, #16
	mov	sp, x10
	fmov	w14, s0
	stur	s0, [x9, #-16]
	and	w9, w14, #0x7fffff
	lsr	w15, w14, #31
	cmp	w15, #0
	ubfx	w16, w14, #23, #8
	cset	w15, eq
	stur	w9, [x13, #-16]
	sub	x9, sp, #16
	stur	w16, [x12, #-16]
	sturb	w15, [x11, #-16]
	mov	sp, x9
	sub	x25, sp, #16
	mov	sp, x25
	cbz	w16, LBB10_13
; %bb.12:                               ; %exp_zero.else
	ldr	w11, [x8]
	ldr	w10, [x10]
	sub	w11, w11, #150
	orr	w10, w10, #0x800000
	b	LBB10_14
LBB10_13:                               ; %exp_zero.then
	ldr	w10, [x10]
	mov	w11, #-149
LBB10_14:                               ; %exp_zero.exit
	str	w10, [x9]
	mov	x10, sp
	str	w11, [x25]
	sub	x11, x10, #16
	mov	sp, x11
	mov	x11, sp
	sub	x21, x11, #16
	mov	sp, x21
	mov	x12, sp
	sub	x22, x12, #16
	mov	sp, x22
	mov	x13, sp
	sub	x27, x13, #16
	mov	sp, x27
	ldr	w9, [x9]
	mov	w14, #8388608
	ldr	w8, [x8]
	mov	w16, #2
	sub	x26, sp, #16
	tst	w9, #0x1
	bfi	w16, w9, #2, #30
	cset	w15, eq
	cmp	w8, #2
	ccmp	w9, w14, #0, ge
	lsl	w14, w9, #2
	ldr	w9, [x25]
	mov	w8, #1
	stur	w16, [x12, #-16]
	cinc	w8, w8, ne
	stur	w14, [x11, #-16]
	sub	w11, w14, w8
	sub	w8, w9, #2
	sturb	w15, [x10, #-16]
	stur	w11, [x13, #-16]
	str	w8, [x25]
	mov	sp, x26
	sub	x19, sp, #16
	mov	sp, x19
	sub	x12, sp, #16
	mov	sp, x12
	sub	x13, sp, #16
	mov	sp, x13
	sub	x10, sp, #16
	mov	sp, x10
	sub	x16, sp, #16
	mov	sp, x16
	sub	x11, sp, #16
	mov	sp, x11
	mov	x9, sp
	sub	x17, x9, #16
	mov	sp, x17
	sub	x15, sp, #16
	stur	wzr, [x9, #-16]
	mov	sp, x15
	sub	x28, sp, #16
	mov	sp, x28
	sub	x24, sp, #16
	mov	sp, x24
	stp	x15, x12, [x29, #-112]          ; 16-byte Folded Spill
	tbnz	w8, #31, LBB10_19
; %bb.15:                               ; %if.then
	ldr	w23, [x25]
	mov	w8, #1208
	movk	w8, #13521, lsl #16
	stp	x17, x16, [x29, #-160]          ; 16-byte Folded Spill
	stp	x13, x11, [x29, #-144]          ; 16-byte Folded Spill
	scvtf	s0, w23
	stur	x10, [x29, #-128]               ; 8-byte Folded Spill
	fmov	s1, w8
	fmul	s0, s0, s1
	fcvtzs	w20, s0
	mov	w0, w20
	str	w20, [x15]
	bl	l_pow5bits
	ldr	w8, [x21]
	add	w9, w0, #58
	add	w10, w20, w9
	stur	x21, [x29, #-120]               ; 8-byte Folded Spill
	sub	w21, w10, w23
	mov	w1, w20
	mov	w0, w8
	mov	w2, w21
	str	w9, [x28]
	str	w21, [x24]
	bl	l_mulPow5InvDivPow2
	ldr	w8, [x22]
	str	w0, [x19]
	mov	w1, w20
	mov	w2, w21
	mov	w0, w8
	bl	l_mulPow5InvDivPow2
	mov	w19, w0
	ldr	w0, [x27]
	mov	w1, w20
	mov	w2, w21
	ldur	x23, [x29, #-112]               ; 8-byte Folded Reload
	str	w19, [x26]
	bl	l_mulPow5InvDivPow2
	ldur	x8, [x29, #-104]                ; 8-byte Folded Reload
	str	w0, [x8]
	cbz	w20, LBB10_18
; %bb.16:                               ; %if.then
	mov	w9, #26215
	sub	w8, w19, #1
	movk	w9, #26214, lsl #16
	smull	x8, w8, w9
	smull	x9, w0, w9
	lsr	x10, x8, #63
	asr	x8, x8, #34
	lsr	x11, x9, #63
	asr	x9, x9, #34
	add	w8, w8, w10
	add	w9, w9, w11
	cmp	w8, w9
	b.gt	LBB10_18
; %bb.17:                               ; %if.then2
	ldr	w8, [x23]
	sub	w19, w8, #1
	mov	w0, w19
	bl	l_pow5bits
	ldr	w8, [x25]
	mov	w1, w19
	ldur	x9, [x29, #-120]                ; 8-byte Folded Reload
	sub	w8, w19, w8
	add	w8, w0, w8
	ldr	w0, [x9]
	add	w2, w8, #58
	bl	l_mulPow5InvDivPow2
	mov	w8, #26215
	movk	w8, #26214, lsl #16
	smull	x8, w0, w8
	lsr	x9, x8, #63
	asr	x8, x8, #34
	add	w8, w8, w9
	mov	w9, #10
	msub	w8, w8, w9, w0
	ldur	x9, [x29, #-160]                ; 8-byte Folded Reload
	str	w8, [x9]
LBB10_18:                               ; %if.exit2
	ldr	w19, [x23]
	ldur	x8, [x29, #-120]                ; 8-byte Folded Reload
	mov	w1, w19
	ldr	w0, [x8]
	ldur	x8, [x29, #-144]                ; 8-byte Folded Reload
	str	w19, [x8]
	bl	l_multipleOfPow5
	and	w8, w0, #0x1
	ldr	w0, [x22]
	ldur	x9, [x29, #-152]                ; 8-byte Folded Reload
	mov	w1, w19
	strb	w8, [x9]
	bl	l_multipleOfPow5
	and	w8, w0, #0x1
	ldr	w0, [x27]
	ldur	x9, [x29, #-128]                ; 8-byte Folded Reload
	mov	w1, w19
	strb	w8, [x9]
	bl	l_multipleOfPow5
	and	w8, w0, #0x1
	ldur	x9, [x29, #-136]                ; 8-byte Folded Reload
	strb	w8, [x9]
	b	LBB10_3
LBB10_19:                               ; %if.else
	mov	x23, sp
	sub	x8, x23, #16
	stur	x8, [x29, #-120]                ; 8-byte Folded Spill
	mov	sp, x8
	ldr	w8, [x25]
	mov	w9, #32152
	movk	w9, #47511, lsl #16
	scvtf	s0, w8
	fmov	s1, w9
	fmul	s0, s0, s1
	fcvtzs	w25, s0
	add	w8, w8, w25
	str	w25, [x15]
	neg	w20, w8
	mov	w0, w20
	str	w20, [x28]
	bl	l_pow5bits
	ldr	w8, [x21]
	sub	w9, w0, #61
	sub	w21, w25, w9
	mov	w1, w20
	mov	w2, w21
	mov	w0, w8
	str	w9, [x24]
	stur	w21, [x23, #-16]
	bl	l_mulPow5InvDivPow2
	ldr	w8, [x22]
	str	w0, [x19]
	mov	w1, w20
	mov	w2, w21
	mov	w0, w8
	bl	l_mulPow5InvDivPow2
	mov	w19, w0
	ldr	w0, [x27]
	mov	w1, w20
	mov	w2, w21
	str	w19, [x26]
	bl	l_mulPow5InvDivPow2
	ldur	x8, [x29, #-104]                ; 8-byte Folded Reload
	str	w0, [x8]
	cbz	w25, LBB10_3
; %bb.20:                               ; %if.else
	mov	w9, #26215
	sub	w8, w19, #1
	movk	w9, #26214, lsl #16
	smull	x8, w8, w9
	smull	x9, w0, w9
	lsr	x10, x8, #63
	asr	x8, x8, #34
	lsr	x11, x9, #63
	asr	x9, x9, #34
	add	w8, w8, w10
	add	w9, w9, w11
	cmp	w8, w9
	b.gt	LBB10_3
; %bb.21:                               ; %if.then3
	ldr	w8, [x28]
	add	w0, w8, #1
	bl	l_pow5bits
	ldp	x9, x8, [x29, #-120]            ; 16-byte Folded Reload
	ldr	w8, [x8]
	sub	w8, w8, w0
	add	w8, w8, #60
	str	w8, [x9]
	b	LBB10_3
LBB10_22:                               ; %pos_zero.then
Lloh18:
	adrp	x9, l_.strPosZero@PAGE
	mov	x8, #12884901891
Lloh19:
	add	x9, x9, l_.strPosZero@PAGEOFF
	b	LBB10_2
	.loh AdrpAdd	Lloh10, Lloh11
	.loh AdrpAdd	Lloh12, Lloh13
	.loh AdrpAdd	Lloh14, Lloh15
	.loh AdrpAdd	Lloh16, Lloh17
	.loh AdrpAdd	Lloh18, Lloh19
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function pow5bits
l_pow5bits:                             ; @pow5bits
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	cbz	w0, LBB11_2
; %bb.1:                                ; %if.else
	mov	w8, #19536
	mov	w9, #38527
	movk	w8, #354, lsl #16
	movk	w9, #152, lsl #16
	madd	w8, w0, w8, w9
	add	w9, w9, #1
	sdiv	w8, w8, w9
	str	w8, [sp, #12]
	mov	w0, w8
	add	sp, sp, #16
	ret
LBB11_2:                                ; %if.then
	mov	w8, #1
	str	w8, [sp, #12]
	mov	w0, w8
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function mulPow5InvDivPow2
l_mulPow5InvDivPow2:                    ; @mulPow5InvDivPow2
	.cfi_startproc
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh20:
	adrp	x8, l_float_pow5_inv_split@PAGE
Lloh21:
	add	x8, x8, l_float_pow5_inv_split@PAGEOFF
	ldr	x1, [x8, w1, sxtw #3]
	bl	l_mulShift
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh20, Lloh21
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function multipleOfPow5
l_multipleOfPow5:                       ; @multipleOfPow5
	.cfi_startproc
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	w19, w1
	bl	l_pow5Factor
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	cmp	w0, w19
	cset	w0, ge
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function pow5Factor
l_pow5Factor:                           ; @pow5Factor
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	mov	w8, #52429
	mov	w9, #39321
	mov	w10, #13106
	mov	w11, #26215
	movk	w8, #52428, lsl #16
	movk	w9, #6553, lsl #16
	movk	w10, #13107, lsl #16
	movk	w11, #26214, lsl #16
	stp	wzr, w0, [sp, #8]
	ldr	w12, [sp, #12]
	cmp	w12, #1
	b.lt	LBB14_3
LBB14_1:                                ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	ldr	w12, [sp, #12]
	madd	w12, w12, w8, w9
	cmp	w12, w10
	b.hi	LBB14_3
; %bb.2:                                ; %if.exit
                                        ;   in Loop: Header=BB14_1 Depth=1
	ldp	w13, w12, [sp, #8]
                                        ; kill: def $w12 killed $w12 def $x12
	sxtw	x12, w12
	mul	x12, x12, x11
	add	w13, w13, #1
	lsr	x14, x12, #63
	asr	x12, x12, #33
	add	w12, w12, w14
	stp	w13, w12, [sp, #8]
	ldr	w12, [sp, #12]
	cmp	w12, #1
	b.ge	LBB14_1
LBB14_3:                                ; %exit
	ldr	w0, [sp, #8]
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function mulShift
l_mulShift:                             ; @mulShift
	.cfi_startproc
; %bb.0:                                ; %entry
	lsr	x8, x1, #32
	mov	w9, w0
	umull	x10, w1, w0
	mul	x8, x9, x8
	sub	w9, w2, #32
	add	x8, x8, x10, lsr #32
	lsr	x0, x8, x9
                                        ; kill: def $w0 killed $w0 killed $x0
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	"_newref:int"                   ; -- Begin function newref:int
	.p2align	2
"_newref:int":                          ; @"newref:int"
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	w0, [sp, #12]
	mov	w0, #16
	bl	_malloc
	str	x0, [sp]
	mov	w0, #4
	bl	_malloc
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	mov	x9, x0
	ldr	x8, [sp]
	ldr	w10, [sp, #12]
	mov	x0, x8
	str	x9, [x8]
	str	w10, [x9]
	str	wzr, [x8, #8]
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	"_ref:int"                      ; -- Begin function ref:int
	.p2align	2
"_ref:int":                             ; @"ref:int"
	.cfi_startproc
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	ldr	w8, [x0, #8]
	mov	x19, x0
	add	w20, w8, #1
	mov	w0, w20
	bl	_countMsg
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	str	w20, [x19, #8]
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	"_deref:int"                    ; -- Begin function deref:int
	.p2align	2
"_deref:int":                           ; @"deref:int"
	.cfi_startproc
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	ldr	w8, [x0, #8]
	mov	x19, x0
	sub	w20, w8, #1
	mov	w0, w20
	bl	_countMsg
	str	w20, [x19, #8]
	cbz	w20, LBB18_2
; %bb.1:                                ; %exit
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB18_2:                                ; %if.then
	ldr	x0, [x19]
	bl	_free
	mov	x0, x19
	bl	_free
	bl	_freeMsg
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_.refMsg                        ; -- Begin function .refMsg
	.p2align	2
_.refMsg:                               ; @.refMsg
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #80
	stp	x22, x21, [sp, #32]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 80
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	w19, w1
	bl	"_.conv:int_string"
	mov	x8, #9
Lloh22:
	adrp	x5, l_.str0@PAGE
	movk	x8, #9, lsl #32
Lloh23:
	add	x5, x5, l_.str0@PAGEOFF
	mov	w3, #9
	mov	w4, #9
	stp	x8, x5, [sp, #16]
	bl	"_.add:string_string"
	mov	w20, w0
	mov	w0, w19
	mov	w21, w1
	mov	x22, x2
	bl	"_.conv:int_string"
	mov	w3, w0
	mov	w4, w1
	mov	x5, x2
	mov	w0, w20
	mov	w1, w21
	mov	x2, x22
	bl	"_.add:string_string"
	mov	x8, #11
Lloh24:
	adrp	x5, l_.str1@PAGE
	movk	x8, #11, lsl #32
Lloh25:
	add	x5, x5, l_.str1@PAGEOFF
	mov	w3, #11
	mov	w4, #11
	stp	x8, x5, [sp]
	bl	"_.add:string_string"
	bl	_.println
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
	.loh AdrpAdd	Lloh24, Lloh25
	.loh AdrpAdd	Lloh22, Lloh23
	.cfi_endproc
                                        ; -- End function
	.globl	"_ref:string"                   ; -- Begin function ref:string
	.p2align	2
"_ref:string":                          ; @"ref:string"
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #64
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	w21, w0
	mov	w0, #4
	mov	x19, x2
	mov	w20, w1
	bl	_malloc
	mov	x8, x0
	mov	w9, #1
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	str	x0, [sp]
	mov	x0, sp
	stp	w21, w20, [x8]
	str	x19, [x8, #8]
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	str	w9, [sp, #8]
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	"_deref:string"                 ; -- Begin function deref:string
	.p2align	2
"_deref:string":                        ; @"deref:string"
	.cfi_startproc
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	w8, [x0, #8]
	subs	w8, w8, #1
	str	w8, [x0, #8]
	b.eq	LBB21_2
; %bb.1:                                ; %exit
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB21_2:                                ; %if.then
	ldr	x0, [x0]
	bl	_free
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w8, #37265
	movk	w8, #53013, lsl #16
	fmov	s0, w8
	bl	"_.conv:float_string"
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	stp	w0, w1, [sp]
	str	x2, [sp, #8]
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__literal4,4byte_literals
l_.strTrue:                             ; @.strTrue
	.ascii	"true"

	.section	__TEXT,__const
l_.strFalse:                            ; @.strFalse
	.ascii	"false"

	.p2align	3                               ; @float_pow5_inv_split
l_float_pow5_inv_split:
	.quad	576460752303423489              ; 0x800000000000001
	.quad	461168601842738791              ; 0x666666666666667
	.quad	368934881474191033              ; 0x51eb851eb851eb9
	.quad	295147905179352826              ; 0x4189374bc6a7efa
	.quad	472236648286964522              ; 0x68db8bac710cb2a
	.quad	377789318629571618              ; 0x53e2d6238da3c22
	.quad	302231454903657294              ; 0x431bde82d7b634e
	.quad	483570327845851670              ; 0x6b5fca6af2bd216
	.quad	386856262276681336              ; 0x55e63b88c230e78
	.quad	309485009821345069              ; 0x44b82fa09b5a52d
	.quad	495176015714152110              ; 0x6df37f675ef6eae
	.quad	396140812571321688              ; 0x57f5ff85e592558
	.quad	316912650057057351              ; 0x465e6604b7a8447
	.quad	507060240091291761              ; 0x709709a125da071
	.quad	405648192073033409              ; 0x5a126e1a84ae6c1
	.quad	324518553658426727              ; 0x480ebe7b9d58567
	.quad	519229685853482763              ; 0x734aca5f6226f0b
	.quad	415383748682786211              ; 0x5c3bd5191b525a3
	.quad	332306998946228969              ; 0x49c97747490eae9
	.quad	531691198313966350              ; 0x760f253edb4ab0e
	.quad	425352958651173080              ; 0x5e72843249088d8
	.quad	340282366920938464              ; 0x4b8ed0283a6d3e0
	.quad	544451787073501542              ; 0x78e480405d7b966
	.quad	435561429658801234              ; 0x60b6cd004ac9452
	.quad	348449143727040987              ; 0x4d5f0a66a23a9db
	.quad	557518629963265579              ; 0x7bcb43d769f762b
	.quad	446014903970612463              ; 0x63090312bb2c4ef
	.quad	356811923176489971              ; 0x4f3a68dbc8f03f3
	.quad	570899077082383953              ; 0x7ec3daf94180651
	.quad	456719261665907162              ; 0x65697bfa9acd1da
	.quad	365375409332725730              ; 0x51212ffbaf0a7e2

l_.strNaN:                              ; @.strNaN
	.ascii	"nan"

l_.strPosInf:                           ; @.strPosInf
	.ascii	"inf"

	.section	__TEXT,__literal4,4byte_literals
l_.strNegInf:                           ; @.strNegInf
	.ascii	"-inf"

	.section	__TEXT,__const
l_.strPosZero:                          ; @.strPosZero
	.ascii	"0.0"

	.section	__TEXT,__literal4,4byte_literals
l_.strNegZero:                          ; @.strNegZero
	.ascii	"-0.0"

	.section	__TEXT,__const
l_.strFree:                             ; @.strFree
	.ascii	"Freed from memory"

l_.strCount:                            ; @.strCount
	.ascii	" references"

l_.str0:                                ; @.str0
	.ascii	" now has "

l_.str1:                                ; @.str1
	.ascii	" references"

l_.strZero:                             ; @.strZero
	.byte	48

.subsections_via_symbols

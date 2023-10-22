	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
	.globl	"_newref:bool"                  ; -- Begin function newref:bool
	.p2align	2
"_newref:bool":                         ; @"newref:bool"
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	strb	w0, [sp, #12]
	mov	w0, #16
	bl	_malloc
	str	x0, [sp]
	mov	w0, #1
	bl	_malloc
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	mov	x9, x0
	ldr	x8, [sp]
	ldrb	w10, [sp, #12]
	mov	x0, x8
	str	x9, [x8]
	strb	w10, [x9]
	str	wzr, [x8, #8]
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	"_ref:bool"                     ; -- Begin function ref:bool
	.p2align	2
"_ref:bool":                            ; @"ref:bool"
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
	mov	x8, #13
Lloh0:
	adrp	x5, l_.strCount@PAGE
	movk	x8, #13, lsl #32
Lloh1:
	add	x5, x5, l_.strCount@PAGEOFF
	mov	w3, #13
	mov	w4, #13
	stp	x8, x5, [sp]
	bl	"_.add:string_string"
	bl	_.println
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.loh AdrpAdd	Lloh0, Lloh1
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
	cbz	w0, LBB3_7
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
	tbz	w9, #31, LBB3_3
; %bb.2:                                ; %if.then1
	neg	w9, w9
	mov	w10, #1
	str	w9, [x20]
	str	w10, [x8]
LBB3_3:                                 ; %while.cond.preheader
	mov	w9, #26215
	movk	w9, #26214, lsl #16
	ldr	w10, [x20]
	cmp	w10, #1
	b.lt	LBB3_5
LBB3_4:                                 ; %while.body
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
	b.ge	LBB3_4
LBB3_5:                                 ; %while.end
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
	cbz	w22, LBB3_8
; %bb.6:                                ; %if.then2
	ldur	x8, [x29, #-56]
	mov	w9, #45
	strb	w9, [x8]
	b	LBB3_9
LBB3_7:                                 ; %if.then
Lloh2:
	adrp	x9, l_.strZero@PAGE
	mov	x8, #4294967297
Lloh3:
	add	x9, x9, l_.strZero@PAGEOFF
	stp	x8, x9, [x29, #-64]
	b	LBB3_12
LBB3_8:                                 ; %if.else2
	add	w8, w23, #1
	str	w8, [x21]
LBB3_9:                                 ; %if.end2
	mov	x10, sp
	sub	x8, x10, #16
	mov	sp, x8
	ldr	w9, [x21]
	stur	w22, [x10, #-16]
	ldr	w10, [x8]
	cmp	w10, w20
	b.ge	LBB3_11
LBB3_10:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	add	w11, w9, w10
	add	w13, w10, #1
	ldur	x12, [x29, #-56]
	ldrb	w11, [x19, w11, sxtw]
	str	w13, [x8]
	strb	w11, [x12, w10, sxtw]
	mov	w10, w13
	cmp	w10, w20
	b.lt	LBB3_10
LBB3_11:                                ; %for.end
	mov	x0, x19
	bl	_free
LBB3_12:                                ; %exit
	ldp	w0, w1, [x29, #-64]
	ldur	x2, [x29, #-56]
	sub	sp, x29, #48
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh2, Lloh3
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
	b.ge	LBB4_3
LBB4_1:                                 ; %while1.body
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
	b.lt	LBB4_1
	b	LBB4_3
LBB4_2:                                 ; %while2.body
                                        ;   in Loop: Header=BB4_3 Depth=1
	ldpsw	x9, x8, [sp, #8]
	ldr	x10, [sp, #24]
	ldr	x11, [sp, #56]
	ldrb	w10, [x10, x9]
	add	w12, w8, #1
	add	w9, w9, #1
	strb	w10, [x11, x8]
	stp	w9, w12, [sp, #8]
LBB4_3:                                 ; %while2.cond
                                        ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #12]
	cmp	w8, w19
	b.lt	LBB4_2
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
	b.ge	LBB6_2
LBB6_1:                                 ; %for.body
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
	b.lt	LBB6_1
LBB6_2:                                 ; %for.end
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	"_deref:bool"                   ; -- Begin function deref:bool
	.p2align	2
"_deref:bool":                          ; @"deref:bool"
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
	cbz	w20, LBB7_2
; %bb.1:                                ; %exit
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB7_2:                                 ; %if.then
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
Lloh4:
	adrp	x2, l_.strFree@PAGE
	movk	x8, #17, lsl #32
Lloh5:
	add	x2, x2, l_.strFree@PAGEOFF
	mov	w0, #17
	mov	w1, #17
	stp	x8, x2, [sp]
	bl	_.println
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.loh AdrpAdd	Lloh4, Lloh5
	.cfi_endproc
                                        ; -- End function
	.globl	"_.conv:bool_string"            ; -- Begin function .conv:bool_string
	.p2align	2
"_.conv:bool_string":                   ; @".conv:bool_string"
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	tbz	w0, #0, LBB9_2
; %bb.1:                                ; %if.then
Lloh6:
	adrp	x2, l_.strTrue@PAGE
	mov	w1, #4
Lloh7:
	add	x2, x2, l_.strTrue@PAGEOFF
	stp	w1, w1, [sp]
	mov	w0, w1
	str	x2, [sp, #8]
	add	sp, sp, #16
	ret
LBB9_2:                                 ; %if.else
Lloh8:
	adrp	x2, l_.strFalse@PAGE
	mov	w1, #5
Lloh9:
	add	x2, x2, l_.strFalse@PAGEOFF
	stp	w1, w1, [sp]
	mov	w0, w1
	str	x2, [sp, #8]
	add	sp, sp, #16
	ret
	.loh AdrpAdd	Lloh6, Lloh7
	.loh AdrpAdd	Lloh8, Lloh9
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
	cbz	w20, LBB12_2
; %bb.1:                                ; %exit
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB12_2:                                ; %if.then
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
	.globl	"_.conv:float_string"           ; -- Begin function .conv:float_string
	.p2align	2
"_.conv:float_string":                  ; @".conv:float_string"
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #80
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 80
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	s0, [sp, #32]
	fcmp	s0, s0
	ldr	w8, [sp, #32]
	str	s0, [sp, #44]
	str	w8, [sp, #40]
	b.vc	LBB13_2
; %bb.1:                                ; %if.then
Lloh10:
	adrp	x9, l_.strNaN@PAGE
	mov	x8, #12884901891
Lloh11:
	add	x9, x9, l_.strNaN@PAGEOFF
	b	LBB13_6
LBB13_2:                                ; %if.else
	mov	w8, #2139095040
	ldr	s0, [sp, #44]
	fmov	s1, w8
	fcmp	s0, s1
	b.ne	LBB13_4
; %bb.3:                                ; %if.then2
Lloh12:
	adrp	x9, l_.strPosInf@PAGE
	mov	x8, #12884901891
Lloh13:
	add	x9, x9, l_.strPosInf@PAGEOFF
	b	LBB13_6
LBB13_4:                                ; %if.else6
	mov	w8, #-8388608
	ldr	s0, [sp, #44]
	fmov	s1, w8
	fcmp	s0, s1
	b.ne	LBB13_8
; %bb.5:                                ; %if.then8
Lloh14:
	adrp	x9, l_.strNegInf@PAGE
	mov	x8, #17179869188
Lloh15:
	add	x9, x9, l_.strNegInf@PAGEOFF
LBB13_6:                                ; %return
	str	x8, [sp, #16]
LBB13_7:                                ; %return
	str	x9, [sp, #24]
	ldr	q0, [sp, #16]
	str	q0, [sp, #48]
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	w0, w1, [sp, #48]
	ldr	x2, [sp, #56]
	add	sp, sp, #80
	ret
LBB13_8:                                ; %if.else12
	ldr	s0, [sp, #44]
	fcmp	s0, #0.0
	b.ne	LBB13_11
; %bb.9:                                ; %if.then14
	ldr	w8, [sp, #40]
	lsr	w8, w8, #31
	str	w8, [sp, #12]
	cbz	w8, LBB13_12
; %bb.10:                               ; %if.else20
	mov	w8, #4
Lloh16:
	adrp	x9, l_.strNegZero@PAGE
Lloh17:
	add	x9, x9, l_.strNegZero@PAGEOFF
	stp	w8, w8, [sp, #16]
	b	LBB13_7
LBB13_11:                               ; %if.else24
	ldr	s0, [sp, #44]
	ldr	w0, [sp, #40]
	bl	l_normalString
	stp	x0, x1, [sp, #48]
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	w0, w1, [sp, #48]
	ldr	x2, [sp, #56]
	add	sp, sp, #80
	ret
LBB13_12:                               ; %if.then16
	mov	w8, #3
Lloh18:
	adrp	x9, l_.strPosZero@PAGE
Lloh19:
	add	x9, x9, l_.strPosZero@PAGEOFF
	stp	w8, w8, [sp, #16]
	b	LBB13_7
	.loh AdrpAdd	Lloh10, Lloh11
	.loh AdrpAdd	Lloh12, Lloh13
	.loh AdrpAdd	Lloh14, Lloh15
	.loh AdrpAdd	Lloh16, Lloh17
	.loh AdrpAdd	Lloh18, Lloh19
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3                               ; -- Begin function normalString
lCPI14_0:
	.quad	0xbfe65df6555c52e7              ; double -0.69896999999999998
lCPI14_1:
	.quad	0x3fd34412e9e78fc7              ; double 0.30102990000000002
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	2
l_normalString:                         ; @normalString
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #224
	stp	x20, x19, [sp, #192]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #208]            ; 16-byte Folded Spill
	.cfi_def_cfa_offset 224
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	ubfx	w8, w0, #23, #8
	and	w9, w0, #0x7fffff
	str	s0, [sp, #172]
	stp	w8, w0, [sp, #164]
	str	w9, [sp, #160]
	cbz	w8, LBB14_2
; %bb.1:                                ; %if.else
	ldp	w9, w8, [sp, #160]
	sub	w8, w8, #150
	orr	w9, w9, #0x800000
	b	LBB14_3
LBB14_2:                                ; %if.then
	ldr	w9, [sp, #160]
	mov	w8, #-149
LBB14_3:                                ; %if.end
	stp	w9, w8, [sp, #152]
	ldr	w8, [sp, #164]
	mov	w9, w9
	mov	w11, #2
	lsl	w10, w9, #2
	str	wzr, [sp, #116]
	cmp	w8, #2
	mov	w8, #8388608
	ccmp	w9, w8, #0, ge
	ldr	w8, [sp, #156]
	bfi	w11, w9, #2, #30
	mov	w9, #1
	cinc	w9, w9, ne
	subs	w8, w8, #2
	sub	w9, w10, w9
	stp	w11, w10, [sp, #144]
	scvtf	d0, w8
	str	w8, [sp, #156]
	str	w9, [sp, #140]
	b.mi	LBB14_8
; %bb.4:                                ; %if.then9
Lloh20:
	adrp	x8, lCPI14_1@PAGE
Lloh21:
	ldr	d1, [x8, lCPI14_1@PAGEOFF]
	fmul	d0, d0, d1
	fcvtzs	w0, d0
	str	w0, [sp, #112]
	bl	l_pow5bits
	ldr	w1, [sp, #112]
	add	w9, w0, #58
	ldr	w8, [sp, #156]
	ldr	w0, [sp, #148]
	add	w10, w1, w9
	sub	w2, w10, w8
	stp	w2, w9, [sp, #104]
	bl	l_mulPow5InvDivPow2
	ldr	w8, [sp, #144]
	str	w0, [sp, #132]
	ldr	w1, [sp, #112]
	ldr	w2, [sp, #104]
	mov	w0, w8
	bl	l_mulPow5InvDivPow2
	ldr	w8, [sp, #140]
	str	w0, [sp, #136]
	ldr	w1, [sp, #112]
	ldr	w2, [sp, #104]
	mov	w0, w8
	bl	l_mulPow5InvDivPow2
	ldr	w8, [sp, #112]
	str	w0, [sp, #128]
	cbz	w8, LBB14_7
; %bb.5:                                ; %land.lhs.true
	ldr	w8, [sp, #136]
	mov	w19, #26215
	ldrsw	x9, [sp, #128]
	movk	w19, #26214, lsl #16
	sub	w8, w8, #1
	mul	x9, x9, x19
	smull	x8, w8, w19
	lsr	x11, x9, #63
	asr	x9, x9, #34
	lsr	x10, x8, #63
	asr	x8, x8, #34
	add	w8, w8, w10
	add	w9, w9, w11
	cmp	w8, w9
	b.gt	LBB14_7
; %bb.6:                                ; %if.then24
	ldr	w8, [sp, #112]
	sub	w0, w8, #1
	bl	l_pow5bits
	ldr	w8, [sp, #112]
	add	w10, w0, #58
	ldr	w9, [sp, #156]
	ldr	w0, [sp, #148]
	sub	w1, w8, #1
	str	w10, [sp, #100]
	sub	w9, w8, w9
	add	w9, w9, w10
	sub	w2, w9, #1
	bl	l_mulPow5InvDivPow2
	smull	x9, w0, w19
	mov	w8, #10
	lsr	x10, x9, #63
	asr	x9, x9, #34
	add	w9, w9, w10
	msub	w8, w9, w8, w0
	str	w8, [sp, #116]
LBB14_7:                                ; %if.end33
	ldr	w1, [sp, #112]
	ldr	w0, [sp, #144]
	str	w1, [sp, #124]
	bl	l_multipleOfPow5
	ldr	w8, [sp, #148]
	cmp	w0, #0
	cset	w9, ne
	ldr	w1, [sp, #112]
	mov	w0, w8
	strb	w9, [sp, #123]
	bl	l_multipleOfPow5
	ldr	w8, [sp, #140]
	cmp	w0, #0
	cset	w9, ne
	ldr	w1, [sp, #112]
	mov	w0, w8
	strb	w9, [sp, #122]
	bl	l_multipleOfPow5
	cmp	w0, #0
	cset	w8, ne
	strb	w8, [sp, #121]
	b	LBB14_15
LBB14_8:                                ; %if.else41
Lloh22:
	adrp	x8, lCPI14_0@PAGE
	ldr	w9, [sp, #156]
Lloh23:
	ldr	d1, [x8, lCPI14_0@PAGEOFF]
	fmul	d0, d0, d1
	fcvtzs	w8, d0
	add	w9, w9, w8
	neg	w0, w9
	stp	w0, w8, [sp, #92]
	bl	l_pow5bits
	ldp	w1, w8, [sp, #92]
	sub	w9, w0, #61
	ldr	w0, [sp, #148]
	sub	w2, w8, w9
	stp	w2, w9, [sp, #84]
	bl	l_mulPow5divPow2
	ldr	w8, [sp, #144]
	str	w0, [sp, #132]
	ldr	w1, [sp, #92]
	ldr	w2, [sp, #84]
	mov	w0, w8
	bl	l_mulPow5divPow2
	ldr	w8, [sp, #140]
	str	w0, [sp, #136]
	ldr	w1, [sp, #92]
	ldr	w2, [sp, #84]
	mov	w0, w8
	bl	l_mulPow5divPow2
	ldr	w8, [sp, #96]
	str	w0, [sp, #128]
	cbz	w8, LBB14_11
; %bb.9:                                ; %land.lhs.true58
	ldr	w8, [sp, #136]
	mov	w19, #26215
	ldrsw	x9, [sp, #128]
	movk	w19, #26214, lsl #16
	sub	w8, w8, #1
	mul	x9, x9, x19
	smull	x8, w8, w19
	lsr	x11, x9, #63
	asr	x9, x9, #34
	lsr	x10, x8, #63
	asr	x8, x8, #34
	add	w8, w8, w10
	add	w9, w9, w11
	cmp	w8, w9
	b.gt	LBB14_11
; %bb.10:                               ; %if.then64
	ldp	w8, w20, [sp, #92]
	add	w0, w8, #1
	bl	l_pow5bits
	ldr	w8, [sp, #92]
	sub	w9, w20, w0
	add	w2, w9, #60
	ldr	w0, [sp, #148]
	add	w1, w8, #1
	str	w2, [sp, #84]
	bl	l_mulPow5divPow2
	smull	x9, w0, w19
	mov	w8, #10
	lsr	x10, x9, #63
	asr	x9, x9, #34
	add	w9, w9, w10
	msub	w8, w9, w8, w0
	str	w8, [sp, #116]
LBB14_11:                               ; %if.end72
	ldr	w8, [sp, #96]
	ldr	w9, [sp, #156]
	cmp	w8, #2
	add	w9, w8, w9
	cset	w10, lt
	cmp	w8, #22
	str	w9, [sp, #124]
	strb	w10, [sp, #123]
	b.gt	LBB14_13
; %bb.12:                               ; %land.rhs
	ldr	w8, [sp, #96]
	mov	w10, #1
	ldr	w9, [sp, #148]
	sub	w8, w8, #1
	lsl	w8, w10, w8
	sub	w8, w8, #1
	tst	w9, w8
	cset	w8, eq
	b	LBB14_14
LBB14_13:
	mov	w8, wzr
LBB14_14:                               ; %land.end
	ldr	w9, [sp, #140]
	strb	w8, [sp, #122]
	cmp	w9, #0
	cinc	w10, w9, lt
	and	w10, w10, #0xfffffffe
	sub	w9, w9, w10
	ldr	w10, [sp, #96]
	cmp	w9, #1
	cset	w9, ne
	cmp	w9, w10
	cset	w9, ge
	strb	w9, [sp, #121]
LBB14_15:                               ; %if.end92
	ldr	w0, [sp, #136]
	bl	l_decimalLength
	ldr	w8, [sp, #124]
	str	wzr, [sp, #68]
	add	w8, w8, w0
	sub	w8, w8, #1
	cmn	w8, #3
	cset	w9, lt
	cmp	w8, #6
	cset	w10, gt
	stp	w8, w0, [sp, #76]
	orr	w9, w9, w10
	ldrb	w10, [sp, #123]
	strb	w9, [sp, #75]
	tbz	w10, #0, LBB14_17
; %bb.16:                               ; %if.then104
	ldr	w8, [sp, #136]
	sub	w8, w8, #1
	str	w8, [sp, #136]
LBB14_17:                               ; %while.cond.preheader
	mov	w8, #26215
	mov	w9, #52429
	mov	w10, #39320
	mov	w11, #39321
	movk	w8, #26214, lsl #16
	movk	w9, #52428, lsl #16
	movk	w10, #6553, lsl #16
	movk	w11, #6553, lsl #16
	mov	w12, #10
	b	LBB14_19
LBB14_18:                               ; %if.end116
                                        ;   in Loop: Header=BB14_19 Depth=1
	ldp	w13, w15, [sp, #128]
                                        ; kill: def $w15 killed $w15 def $x15
	ldrsw	x14, [sp, #136]
	sxtw	x15, w15
	ldrsw	x16, [sp, #128]
	madd	w13, w13, w9, w10
	mul	x14, x14, x8
	mul	x17, x15, x8
	mul	x16, x16, x8
	lsr	x0, x14, #63
	ror	w13, w13, #1
	asr	x14, x14, #34
	lsr	x1, x17, #63
	asr	x17, x17, #34
	add	w14, w14, w0
	lsr	x0, x16, #63
	asr	x16, x16, #34
	add	w17, w17, w1
	add	w16, w16, w0
	ldrb	w0, [sp, #121]
	cmp	w13, w11
	ldr	w13, [sp, #68]
	msub	w15, w17, w12, w15
	stp	w17, w14, [sp, #132]
	cset	w14, lo
	str	w16, [sp, #128]
	and	w14, w0, w14
	add	w13, w13, #1
	str	w15, [sp, #116]
	strb	w14, [sp, #121]
	str	w13, [sp, #68]
LBB14_19:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	ldrsw	x13, [sp, #136]
	ldrsw	x14, [sp, #128]
	mul	x13, x13, x8
	mul	x14, x14, x8
	lsr	x15, x13, #63
	asr	x13, x13, #34
	lsr	x16, x14, #63
	asr	x14, x14, #34
	add	w13, w13, w15
	add	w14, w14, w16
	cmp	w13, w14
	b.le	LBB14_22
; %bb.20:                               ; %while.body
                                        ;   in Loop: Header=BB14_19 Depth=1
	ldr	w13, [sp, #136]
	cmp	w13, #99
	b.gt	LBB14_18
; %bb.21:                               ; %land.lhs.true112
                                        ;   in Loop: Header=BB14_19 Depth=1
	ldrb	w13, [sp, #75]
	tbz	w13, #0, LBB14_18
LBB14_22:                               ; %while.end
	ldrb	w8, [sp, #121]
	tbz	w8, #0, LBB14_28
; %bb.23:                               ; %while.cond131.preheader
	mov	w8, #52429
	mov	w9, #39320
	mov	w10, #26215
	movk	w8, #52428, lsl #16
	movk	w9, #6553, lsl #16
	movk	w10, #26214, lsl #16
	mov	w11, #10
	b	LBB14_25
LBB14_24:                               ; %if.end142
                                        ;   in Loop: Header=BB14_25 Depth=1
	ldpsw	x13, x12, [sp, #132]
	ldrsw	x14, [sp, #128]
	mul	x12, x12, x10
	mul	x15, x13, x10
	lsr	x16, x12, #63
	asr	x12, x12, #34
	lsr	x17, x15, #63
	asr	x15, x15, #34
	mul	x14, x14, x10
	add	w12, w12, w16
	ldr	w16, [sp, #68]
	add	w15, w15, w17
	lsr	x17, x14, #63
	asr	x14, x14, #34
	msub	w13, w15, w11, w13
	add	w14, w14, w17
	stp	w15, w12, [sp, #132]
	add	w12, w16, #1
	str	w14, [sp, #128]
	str	w13, [sp, #116]
	str	w12, [sp, #68]
LBB14_25:                               ; %while.cond131
                                        ; =>This Inner Loop Header: Depth=1
	ldr	w12, [sp, #128]
	madd	w12, w12, w8, w9
	ror	w12, w12, #1
	cmp	w12, w9
	b.hi	LBB14_28
; %bb.26:                               ; %while.body135
                                        ;   in Loop: Header=BB14_25 Depth=1
	ldr	w12, [sp, #136]
	cmp	w12, #99
	b.gt	LBB14_24
; %bb.27:                               ; %land.lhs.true138
                                        ;   in Loop: Header=BB14_25 Depth=1
	ldrb	w12, [sp, #75]
	tbz	w12, #0, LBB14_24
LBB14_28:                               ; %if.end149
	ldrb	w8, [sp, #122]
	tbz	w8, #0, LBB14_31
; %bb.29:                               ; %if.end149
	ldr	w8, [sp, #116]
	cmp	w8, #5
	b.ne	LBB14_31
; %bb.30:                               ; %land.lhs.true155
	ldr	w8, [sp, #132]
	cmp	w8, #0
	cinc	w9, w8, lt
	and	w9, w9, #0xfffffffe
	cmp	w8, w9
	b.eq	LBB14_34
LBB14_31:                               ; %if.end160
	ldp	w9, w8, [sp, #128]
	cmp	w8, w9
	b.ne	LBB14_35
LBB14_32:                               ; %land.lhs.true163
	ldrb	w9, [sp, #121]
	tbnz	w9, #0, LBB14_35
; %bb.33:
	mov	w9, #1
	b	LBB14_36
LBB14_34:                               ; %if.then159
	mov	w8, #4
	str	w8, [sp, #116]
	ldp	w9, w8, [sp, #128]
	cmp	w8, w9
	b.eq	LBB14_32
LBB14_35:                               ; %lor.rhs165
	ldr	w9, [sp, #116]
	cmp	w9, #4
	cset	w9, gt
LBB14_36:                               ; %lor.end168
	ldr	w10, [sp, #80]
	add	w8, w8, w9
	ldr	w11, [sp, #68]
	mov	w0, #15
	sub	w9, w10, w11
	stp	w9, w8, [sp, #60]
	bl	_malloc
	ldr	s0, [sp, #172]
	str	x0, [sp, #48]
	str	wzr, [sp, #44]
	fcmp	s0, #0.0
	b.pl	LBB14_38
; %bb.37:                               ; %if.then175
	ldrsw	x8, [sp, #44]
	mov	w11, #45
	ldr	x10, [sp, #48]
	add	w9, w8, #1
	str	w9, [sp, #44]
	strb	w11, [x10, x8]
LBB14_38:                               ; %if.end177
	ldrb	w8, [sp, #75]
	tbz	w8, #0, LBB14_42
; %bb.39:                               ; %if.then179
	mov	w8, #26215
	mov	w9, #10
	movk	w8, #26214, lsl #16
	str	wzr, [sp, #40]
LBB14_40:                               ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	ldp	w13, w10, [sp, #60]
                                        ; kill: def $w10 killed $w10 def $x10
	sxtw	x10, w10
	mul	x11, x10, x8
	lsr	x12, x11, #63
	asr	x11, x11, #34
	add	w11, w11, w12
	ldr	w12, [sp, #40]
	msub	w10, w11, w9, w10
	sub	w11, w13, #1
	cmp	w12, w11
	b.ge	LBB14_49
; %bb.41:                               ; %for.body
                                        ;   in Loop: Header=BB14_40 Depth=1
	ldpsw	x13, x11, [sp, #60]
	ldpsw	x14, x12, [sp, #40]
	add	w15, w10, #48
	mul	x11, x11, x8
	add	x12, x12, x13
	ldr	w13, [sp, #40]
	sub	x12, x12, x14
	ldr	x14, [sp, #48]
	lsr	x16, x11, #63
	asr	x11, x11, #34
	add	w11, w11, w16
	strb	w15, [x14, x12]
	add	w12, w13, #1
	str	w11, [sp, #64]
	stp	w10, w12, [sp, #36]
	b	LBB14_40
LBB14_42:                               ; %if.else237
	ldr	w8, [sp, #76]
	tbnz	w8, #31, LBB14_56
; %bb.43:                               ; %if.else276
	ldr	w8, [sp, #76]
	ldr	w9, [sp, #60]
	add	w8, w8, #1
	cmp	w8, w9
	b.lt	LBB14_60
; %bb.44:                               ; %if.then280
	mov	w8, #26215
	mov	w9, #10
	movk	w8, #26214, lsl #16
	str	wzr, [sp, #20]
	mov	w10, wzr
	ldr	w11, [sp, #60]
	cmp	w10, w11
	b.ge	LBB14_46
LBB14_45:                               ; %for.body285
                                        ; =>This Inner Loop Header: Depth=1
	ldpsw	x13, x10, [sp, #60]
	ldrsw	x11, [sp, #44]
	ldrsw	x15, [sp, #20]
	mul	x12, x10, x8
	add	x11, x11, x13
	sub	x11, x11, x15
	add	w13, w15, #1
	lsr	x14, x12, #63
	asr	x12, x12, #34
	add	w12, w12, w14
	ldr	x14, [sp, #48]
	str	w13, [sp, #20]
	msub	w10, w12, w9, w10
	add	x11, x11, x14
	str	w12, [sp, #64]
	add	w10, w10, #48
	sturb	w10, [x11, #-1]
	mov	w10, w13
	ldr	w11, [sp, #60]
	cmp	w10, w11
	b.lt	LBB14_45
LBB14_46:                               ; %for.end297
	ldr	w9, [sp, #60]
	ldr	w8, [sp, #44]
	str	w9, [sp, #16]
	add	w10, w8, w9
	mov	w8, #48
	str	w10, [sp, #44]
LBB14_47:                               ; %for.cond300
                                        ; =>This Inner Loop Header: Depth=1
	ldrsw	x9, [sp, #44]
	ldr	w10, [sp, #76]
	ldr	w11, [sp, #16]
	add	w12, w9, #1
	add	w13, w10, #1
	ldr	x10, [sp, #48]
	cmp	w11, w13
	str	w12, [sp, #44]
	b.ge	LBB14_65
; %bb.48:                               ; %for.body304
                                        ;   in Loop: Header=BB14_47 Depth=1
	ldr	w11, [sp, #16]
	strb	w8, [x10, x9]
	add	w11, w11, #1
	str	w11, [sp, #16]
	b	LBB14_47
LBB14_49:                               ; %for.end
	ldrsw	x8, [sp, #44]
	add	w9, w10, #48
	ldr	x10, [sp, #48]
	strb	w9, [x10, x8]
	mov	w9, #46
	ldrsw	x8, [sp, #44]
	ldr	x10, [sp, #48]
	add	x8, x8, #1
	str	w8, [sp, #44]
	strb	w9, [x10, x8]
	ldr	w9, [sp, #60]
	ldr	w8, [sp, #44]
	cmp	w9, #1
	add	w8, w8, w9
	str	w8, [sp, #44]
	b.ne	LBB14_51
; %bb.50:                               ; %if.then205
	ldrsw	x8, [sp, #44]
	mov	w11, #48
	ldr	x10, [sp, #48]
	add	w9, w8, #1
	str	w9, [sp, #44]
	strb	w11, [x10, x8]
LBB14_51:                               ; %if.end209
	ldrsw	x8, [sp, #44]
	mov	w12, #101
	ldr	w10, [sp, #76]
	ldr	x11, [sp, #48]
	add	w9, w8, #1
	str	w9, [sp, #44]
	strb	w12, [x11, x8]
	tbz	w10, #31, LBB14_53
; %bb.52:                               ; %if.then215
	ldrsw	x8, [sp, #44]
	mov	w12, #45
	ldr	w9, [sp, #76]
	ldr	x11, [sp, #48]
	add	w10, w8, #1
	neg	w9, w9
	str	w10, [sp, #44]
	strb	w12, [x11, x8]
	str	w9, [sp, #76]
LBB14_53:                               ; %if.end220
	ldr	w8, [sp, #76]
	cmp	w8, #10
	b.lt	LBB14_55
; %bb.54:                               ; %if.then223
	ldrsw	x8, [sp, #76]
	mov	w9, #26215
	movk	w9, #26214, lsl #16
	ldrsw	x10, [sp, #44]
	mul	x8, x8, x9
	add	w11, w10, #1
	lsr	x9, x8, #63
	lsr	x8, x8, #34
	add	w8, w8, w9
	ldr	x9, [sp, #48]
	add	w8, w8, #48
	str	w11, [sp, #44]
	strb	w8, [x9, x10]
LBB14_55:                               ; %if.end230
	ldrsw	x8, [sp, #76]
	mov	w9, #26215
	movk	w9, #26214, lsl #16
	ldrsw	x11, [sp, #44]
	mul	x9, x8, x9
	lsr	x10, x9, #63
	lsr	x9, x9, #34
	add	w9, w9, w10
	mov	w10, #10
	msub	w8, w9, w10, w8
	add	w9, w11, #1
	ldr	x10, [sp, #48]
	add	w8, w8, #48
	str	w9, [sp, #44]
	strb	w8, [x10, x11]
	b	LBB14_67
LBB14_56:                               ; %if.then240
	ldrsw	x9, [sp, #44]
	mov	w8, #48
	ldr	x11, [sp, #48]
	mov	w12, #-1
	add	w10, w9, #1
	str	w12, [sp, #32]
	str	w10, [sp, #44]
	strb	w8, [x11, x9]
	mov	w11, #46
	ldrsw	x9, [sp, #44]
	ldr	x13, [sp, #48]
	add	w10, w9, #1
	str	w10, [sp, #44]
	strb	w11, [x13, x9]
	mov	w9, w12
	ldr	w10, [sp, #76]
	cmp	w9, w10
	b.le	LBB14_58
LBB14_57:                               ; %for.body251
                                        ; =>This Inner Loop Header: Depth=1
	ldrsw	x9, [sp, #44]
	ldr	w10, [sp, #32]
	ldr	x12, [sp, #48]
	add	w11, w9, #1
	sub	w10, w10, #1
	str	w11, [sp, #44]
	strb	w8, [x12, x9]
	str	w10, [sp, #32]
	mov	w9, w10
	ldr	w10, [sp, #76]
	cmp	w9, w10
	b.gt	LBB14_57
LBB14_58:                               ; %for.end257
	mov	w8, #26215
	ldr	w10, [sp, #44]
	movk	w8, #26214, lsl #16
	mov	w9, #10
	stp	wzr, w10, [sp, #24]
	ldr	w10, [sp, #24]
	ldr	w11, [sp, #60]
	cmp	w10, w11
	b.ge	LBB14_67
LBB14_59:                               ; %for.body262
                                        ; =>This Inner Loop Header: Depth=1
	ldpsw	x13, x10, [sp, #60]
	ldpsw	x15, x11, [sp, #24]
	mul	x12, x10, x8
	add	x11, x11, x13
	lsr	x14, x12, #63
	asr	x12, x12, #34
	add	w12, w12, w14
	ldr	x14, [sp, #48]
	sub	x11, x11, x15
	msub	w10, w12, w9, w10
	add	x11, x11, x14
	str	w12, [sp, #64]
	add	w10, w10, #48
	sturb	w10, [x11, #-1]
	add	w11, w15, #1
	ldr	w10, [sp, #44]
	str	w11, [sp, #24]
	add	w10, w10, #1
	str	w10, [sp, #44]
	mov	w10, w11
	ldr	w11, [sp, #60]
	cmp	w10, w11
	b.lt	LBB14_59
	b	LBB14_67
LBB14_60:                               ; %if.else317
	ldr	w8, [sp, #44]
	mov	w9, #26215
	movk	w9, #26214, lsl #16
	mov	w10, #10
	add	w11, w8, #1
	mov	w8, #46
	stp	wzr, w11, [sp, #8]
	b	LBB14_62
LBB14_61:                               ; %if.end336
                                        ;   in Loop: Header=BB14_62 Depth=1
	ldpsw	x14, x11, [sp, #60]
	ldpsw	x16, x12, [sp, #8]
	mul	x13, x11, x9
	add	x12, x12, x14
	add	w14, w16, #1
	lsr	x15, x13, #63
	asr	x13, x13, #34
	add	w13, w13, w15
	ldr	x15, [sp, #48]
	sub	x12, x12, x16
	str	w14, [sp, #8]
	msub	w11, w13, w10, w11
	add	x12, x12, x15
	str	w13, [sp, #64]
	add	w11, w11, #48
	sturb	w11, [x12, #-1]
LBB14_62:                               ; %for.cond321
                                        ; =>This Inner Loop Header: Depth=1
	ldr	w12, [sp, #8]
	ldr	w11, [sp, #60]
	cmp	w12, w11
	b.ge	LBB14_66
; %bb.63:                               ; %for.body324
                                        ;   in Loop: Header=BB14_62 Depth=1
	ldr	w12, [sp, #8]
	ldr	w13, [sp, #76]
	mvn	w12, w12
	add	w11, w12, w11
	cmp	w11, w13
	b.ne	LBB14_61
; %bb.64:                               ; %if.then329
                                        ;   in Loop: Header=BB14_62 Depth=1
	ldpsw	x13, x11, [sp, #8]
	ldrsw	x12, [sp, #60]
	ldr	x14, [sp, #48]
	add	x12, x11, x12
	sub	w11, w11, #1
	sub	x12, x12, x13
	add	x12, x12, x14
	str	w11, [sp, #12]
	sturb	w8, [x12, #-1]
	b	LBB14_61
LBB14_65:                               ; %for.end310
	mov	w8, #46
	strb	w8, [x10, x9]
	mov	w10, #48
	ldrsw	x8, [sp, #44]
	ldr	x11, [sp, #48]
	add	w9, w8, #1
	str	w9, [sp, #44]
	strb	w10, [x11, x8]
	b	LBB14_67
LBB14_66:                               ; %for.end348
	ldr	w8, [sp, #44]
	add	w8, w11, w8
	add	w8, w8, #1
	str	w8, [sp, #44]
LBB14_67:                               ; %if.end353
	ldr	w8, [sp, #44]
	ldrsw	x0, [sp, #44]
	stp	w8, w8, [sp, #176]
	bl	_malloc
	ldr	x1, [sp, #48]
	str	x0, [sp, #184]
	ldrsw	x2, [sp, #44]
	bl	_memcpy
	ldr	x0, [sp, #48]
	bl	_free
	ldp	x0, x1, [sp, #176]
	ldp	x29, x30, [sp, #208]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #192]            ; 16-byte Folded Reload
	add	sp, sp, #224
	ret
	.loh AdrpLdr	Lloh20, Lloh21
	.loh AdrpLdr	Lloh22, Lloh23
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function pow5bits
l_pow5bits:                             ; @pow5bits
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	w0, [sp, #12]
	cbz	w0, LBB15_2
; %bb.1:                                ; %cond.false
	ldr	w8, [sp, #12]
	mov	w9, #19536
	movk	w9, #354, lsl #16
	mov	w10, #38527
	movk	w10, #152, lsl #16
	madd	w8, w8, w9, w10
	add	w9, w10, #1
	sdiv	w0, w8, w9
	add	sp, sp, #16
	ret
LBB15_2:
	mov	w0, #1
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function mulPow5InvDivPow2
l_mulPow5InvDivPow2:                    ; @mulPow5InvDivPow2
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh24:
	adrp	x8, l_float_pow5_inv_split@PAGE
	stp	w1, w0, [sp, #8]
Lloh25:
	add	x8, x8, l_float_pow5_inv_split@PAGEOFF
	str	w2, [sp, #4]
	ldr	x8, [x8, w1, sxtw #3]
	mov	x1, x8
	bl	l_mulShift
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.loh AdrpAdd	Lloh24, Lloh25
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function multipleOfPow5
l_multipleOfPow5:                       ; @multipleOfPow5
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stp	w1, w0, [sp, #8]
	bl	l_pow5Factor
	ldr	w8, [sp, #8]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	cmp	w0, w8
	cset	w0, ge
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function mulPow5divPow2
l_mulPow5divPow2:                       ; @mulPow5divPow2
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh26:
	adrp	x8, l_float_pow5_split@PAGE
	stp	w1, w0, [sp, #8]
Lloh27:
	add	x8, x8, l_float_pow5_split@PAGEOFF
	str	w2, [sp, #4]
	ldr	x8, [x8, w1, sxtw #3]
	mov	x1, x8
	bl	l_mulShift
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.loh AdrpAdd	Lloh26, Lloh27
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function decimalLength
l_decimalLength:                        ; @decimalLength
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	mov	w10, #51712
	mov	w8, #26215
	mov	w9, #10
	movk	w10, #15258, lsl #16
	movk	w8, #26214, lsl #16
	stp	w9, w0, [sp, #8]
	str	w10, [sp, #4]
	ldr	w9, [sp, #8]
	cmp	w9, #1
	b.lt	LBB19_3
LBB19_1:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	ldr	w9, [sp, #12]
	ldr	w10, [sp, #4]
	cmp	w9, w10
	b.ge	LBB19_3
; %bb.2:                                ; %if.end
                                        ;   in Loop: Header=BB19_1 Depth=1
	ldp	w9, w10, [sp, #4]
                                        ; kill: def $w9 killed $w9 def $x9
	sxtw	x9, w9
	mul	x9, x9, x8
	sub	w10, w10, #1
	lsr	x11, x9, #63
	asr	x9, x9, #34
	add	w9, w9, w11
	stp	w9, w10, [sp, #4]
	ldr	w9, [sp, #8]
	cmp	w9, #1
	b.ge	LBB19_1
LBB19_3:                                ; %for.end
	ldr	w0, [sp, #8]
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function mulShift
l_mulShift:                             ; @mulShift
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
                                        ; kill: def $w0 killed $w0 def $x0
	smull	x10, w1, w0
	str	x1, [sp, #48]
	ldrsw	x11, [sp, #52]
	sxtw	x9, w0
	sub	w8, w2, #32
	str	w0, [sp, #60]
	stp	w1, w2, [sp, #40]
	str	x10, [sp, #24]
	mul	x9, x9, x11
	ldrsw	x10, [sp, #28]
	str	w11, [sp, #36]
	add	x10, x10, x9
	asr	x0, x10, x8
	stp	x10, x9, [sp, #8]
	str	x0, [sp], #64
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
	stp	wzr, w0, [sp, #4]
	ldr	w12, [sp, #8]
	cmp	w12, #1
	b.lt	LBB21_3
LBB21_1:                                ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	ldr	w12, [sp, #8]
	madd	w12, w12, w8, w9
	cmp	w12, w10
	b.ls	LBB21_4
; %bb.2:                                ; %if.end
                                        ;   in Loop: Header=BB21_1 Depth=1
	ldp	w13, w12, [sp, #4]
                                        ; kill: def $w12 killed $w12 def $x12
	sxtw	x12, w12
	mul	x12, x12, x11
	add	w13, w13, #1
	lsr	x14, x12, #63
	asr	x12, x12, #33
	add	w12, w12, w14
	stp	w13, w12, [sp, #4]
	ldr	w12, [sp, #8]
	cmp	w12, #1
	b.ge	LBB21_1
LBB21_3:                                ; %while.end
	str	wzr, [sp, #12]
	mov	w0, wzr
	add	sp, sp, #16
	ret
LBB21_4:                                ; %if.then
	ldr	w8, [sp, #4]
	str	w8, [sp, #12]
	mov	w0, w8
	add	sp, sp, #16
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
	cbz	w20, LBB24_2
; %bb.1:                                ; %exit
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB24_2:                                ; %if.then
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
Lloh28:
	adrp	x5, l_.str0@PAGE
	movk	x8, #9, lsl #32
Lloh29:
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
Lloh30:
	adrp	x5, l_.str1@PAGE
	movk	x8, #11, lsl #32
Lloh31:
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
	.loh AdrpAdd	Lloh30, Lloh31
	.loh AdrpAdd	Lloh28, Lloh29
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
	b.eq	LBB27_2
; %bb.1:                                ; %exit
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB27_2:                                ; %if.then
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
	sub	sp, sp, #112
	stp	x22, x21, [sp, #64]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 112
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
Lloh32:
	adrp	x19, l_.str0.1@PAGE
	mov	x8, #34359738376
Lloh33:
	add	x19, x19, l_.str0.1@PAGEOFF
	mov	w0, #10
	stp	x8, x19, [sp, #48]
	bl	"_.conv:int_string"
	mov	w3, w0
	mov	w4, w1
	mov	x5, x2
	mov	w0, #8
	mov	w1, #8
	mov	x2, x19
	bl	"_.add:string_string"
Lloh34:
	adrp	x5, l_.str1.2@PAGE
	mov	x8, #64424509455
Lloh35:
	add	x5, x5, l_.str1.2@PAGEOFF
	mov	w3, #15
	mov	w4, #15
	stp	x8, x5, [sp, #32]
	bl	"_.add:string_string"
	mov	w19, w0
	mov	w0, #1
	mov	w20, w1
	mov	x21, x2
	bl	"_.conv:bool_string"
	mov	w3, w0
	mov	w4, w1
	mov	x5, x2
	mov	w0, w19
	mov	w1, w20
	mov	x2, x21
	bl	"_.add:string_string"
	mov	w8, #53
	stp	w0, w1, [sp, #16]
	str	x2, [sp, #24]
	str	w8, [sp, #12]
	bl	_.println
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
	.loh AdrpAdd	Lloh34, Lloh35
	.loh AdrpAdd	Lloh32, Lloh33
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__literal4,4byte_literals
l_.strTrue:                             ; @.strTrue
	.ascii	"true"

	.section	__TEXT,__const
l_.strFalse:                            ; @.strFalse
	.ascii	"false"

	.p2align	4                               ; @float_pow5_inv_split
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

	.p2align	4                               ; @float_pow5_split
l_float_pow5_split:
	.quad	1152921504606846976             ; 0x1000000000000000
	.quad	1441151880758558720             ; 0x1400000000000000
	.quad	1801439850948198400             ; 0x1900000000000000
	.quad	2251799813685248000             ; 0x1f40000000000000
	.quad	1407374883553280000             ; 0x1388000000000000
	.quad	1759218604441600000             ; 0x186a000000000000
	.quad	2199023255552000000             ; 0x1e84800000000000
	.quad	1374389534720000000             ; 0x1312d00000000000
	.quad	1717986918400000000             ; 0x17d7840000000000
	.quad	2147483648000000000             ; 0x1dcd650000000000
	.quad	1342177280000000000             ; 0x12a05f2000000000
	.quad	1677721600000000000             ; 0x174876e800000000
	.quad	2097152000000000000             ; 0x1d1a94a200000000
	.quad	1310720000000000000             ; 0x12309ce540000000
	.quad	1638400000000000000             ; 0x16bcc41e90000000
	.quad	2048000000000000000             ; 0x1c6bf52634000000
	.quad	1280000000000000000             ; 0x11c37937e0800000
	.quad	1600000000000000000             ; 0x16345785d8a00000
	.quad	2000000000000000000             ; 0x1bc16d674ec80000
	.quad	1250000000000000000             ; 0x1158e460913d0000
	.quad	1562500000000000000             ; 0x15af1d78b58c4000
	.quad	1953125000000000000             ; 0x1b1ae4d6e2ef5000
	.quad	1220703125000000000             ; 0x10f0cf064dd59200
	.quad	1525878906250000000             ; 0x152d02c7e14af680
	.quad	1907348632812500000             ; 0x1a784379d99db420
	.quad	1192092895507812500             ; 0x108b2a2c28029094
	.quad	1490116119384765625             ; 0x14adf4b7320334b9
	.quad	1862645149230957031             ; 0x19d971e4fe8401e7
	.quad	1164153218269348144             ; 0x1027e72f1f128130
	.quad	1455191522836685180             ; 0x1431e0fae6d7217c
	.quad	1818989403545856475             ; 0x193e5939a08ce9db
	.quad	2273736754432320594             ; 0x1f8def8808b02452
	.quad	1421085471520200371             ; 0x13b8b5b5056e16b3
	.quad	1776356839400250464             ; 0x18a6e32246c99c60
	.quad	2220446049250313080             ; 0x1ed09bead87c0378
	.quad	1387778780781445675             ; 0x13426172c74d822b
	.quad	1734723475976807094             ; 0x1812f9cf7920e2b6
	.quad	2168404344971008868             ; 0x1e17b84357691b64
	.quad	1355252715606880542             ; 0x12ced32a16a1b11e
	.quad	1694065894508600678             ; 0x178287f49c4a1d66
	.quad	2117582368135750847             ; 0x1d6329f1c35ca4bf
	.quad	1323488980084844279             ; 0x125dfa371a19e6f7
	.quad	1654361225106055349             ; 0x16f578c4e0a060b5
	.quad	2067951531382569187             ; 0x1cb2d6f618c878e3
	.quad	1292469707114105741             ; 0x11efc659cf7d4b8d
	.quad	1615587133892632177             ; 0x166bb7f0435c9e71
	.quad	2019483917365790221             ; 0x1c06a5ec5433c60d

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
	.ascii	" reference(s)"

l_.str0:                                ; @.str0
	.ascii	" now has "

l_.str1:                                ; @.str1
	.ascii	" references"

l_.strZero:                             ; @.strZero
	.byte	48

	.section	__TEXT,__literal8,8byte_literals
l_.str0.1:                              ; @.str0.1
	.ascii	"I am in "

	.section	__TEXT,__const
l_.str1.2:                              ; @.str1.2
	.ascii	"th grade, it's "

.subsections_via_symbols

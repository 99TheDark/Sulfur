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
Lloh0:
	adrp	x3, l_.strCount@PAGE
	mov	w8, #13
Lloh1:
	add	x3, x3, l_.strCount@PAGEOFF
	mov	w2, #13
	str	w8, [sp]
	str	x3, [sp, #8]
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
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	sub	sp, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	stur	w0, [x29, #-36]
	cbz	w0, LBB3_7
; %bb.1:                                ; %if.end1
	mov	w19, w0
	mov	w0, #40
	bl	_malloc
	mov	w8, #9
	stur	x0, [x29, #-56]
	stp	wzr, w8, [x29, #-44]
	tbz	w19, #31, LBB3_3
; %bb.2:                                ; %if.then2
	neg	w8, w19
	mov	w9, #1
	stur	w8, [x29, #-36]
	stur	w9, [x29, #-44]
LBB3_3:                                 ; %while.cond.preheader
	mov	w8, #26215
	mov	w9, #10
	movk	w8, #26214, lsl #16
	ldur	w10, [x29, #-36]
	cmp	w10, #1
	b.lt	LBB3_5
LBB3_4:                                 ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	ldursw	x10, [x29, #-36]
	ldur	x13, [x29, #-56]
	mul	x11, x10, x8
	lsr	x12, x11, #63
	asr	x11, x11, #34
	add	w11, w11, w12
	ldursw	x12, [x29, #-40]
	msub	w10, w11, w9, w10
	sub	w14, w12, #1
	add	w10, w10, #48
	stp	w14, w11, [x29, #-40]
	str	w10, [x13, x12, lsl #2]
	ldur	w10, [x29, #-36]
	cmp	w10, #1
	b.ge	LBB3_4
LBB3_5:                                 ; %while.end
	ldp	w19, w8, [x29, #-44]
	sub	w8, w19, w8
	add	w8, w8, #9
	lsl	w0, w8, #2
	stur	w8, [x29, #-60]
	stur	w8, [x29, #-32]
	bl	_malloc
	stur	x0, [x29, #-24]
	cbz	w19, LBB3_8
; %bb.6:                                ; %if.then3
	ldur	x8, [x29, #-24]
	mov	w9, #45
	str	w9, [x8]
	b	LBB3_9
LBB3_7:                                 ; %if.then1
Lloh2:
	adrp	x9, l_.strZero@PAGE
	mov	w8, #1
Lloh3:
	add	x9, x9, l_.strZero@PAGEOFF
	stur	w8, [x29, #-32]
	stur	x9, [x29, #-24]
	mov	w0, w8
	mov	x1, x9
	sub	sp, x29, #16
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB3_8:                                 ; %if.else3
	ldur	w8, [x29, #-40]
	add	w8, w8, #1
	stur	w8, [x29, #-40]
LBB3_9:                                 ; %if.end3
	mov	x10, sp
	ldur	w9, [x29, #-44]
	sub	x8, x10, #16
	mov	sp, x8
	stur	w9, [x10, #-16]
	ldr	w9, [x8]
	ldur	w10, [x29, #-60]
	ldur	x0, [x29, #-56]
	cmp	w9, w10
	b.ge	LBB3_11
LBB3_10:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	ldur	w9, [x29, #-40]
	ldrsw	x10, [x8]
	ldur	x11, [x29, #-24]
	add	w9, w9, w10
	add	w12, w10, #1
	ldr	w9, [x0, w9, sxtw #2]
	str	w12, [x8]
	str	w9, [x11, x10, lsl #2]
	mov	w9, w12
	ldur	w10, [x29, #-60]
	ldur	x0, [x29, #-56]
	cmp	w9, w10
	b.lt	LBB3_10
LBB3_11:                                ; %for.end
	bl	_free
	ldur	w0, [x29, #-32]
	ldur	x1, [x29, #-24]
	sub	sp, x29, #16
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
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
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 96
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	add	w8, w0, w2
	mov	w20, w0
	str	w0, [sp, #16]
	lsl	w0, w8, #2
	mov	w19, w2
	str	w2, [sp]
	str	x1, [sp, #24]
	str	x3, [sp, #8]
	str	w8, [sp, #32]
	bl	_malloc
	ldr	x1, [sp, #24]
	lsl	w2, w20, #2
	mov	x21, x0
	str	x0, [sp, #40]
	bl	_memcpy
	add	x0, x21, w20, sxtw #2
	ldr	x1, [sp, #8]
	lsl	w2, w19, #2
	bl	_memcpy
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldr	w0, [sp, #32]
	ldr	x1, [sp, #40]
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
	stp	wzr, w0, [sp, #12]
	str	x1, [sp, #24]
	ldp	w8, w9, [sp, #12]
	cmp	w8, w9
	b.ge	LBB6_2
LBB6_1:                                 ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	ldrsw	x8, [sp, #12]
	ldr	x9, [sp, #24]
	ldr	w0, [x9, x8, lsl #2]
	bl	l_printChar
	ldr	w8, [sp, #12]
	add	w8, w8, #1
	str	w8, [sp, #12]
	ldp	w8, w9, [sp, #12]
	cmp	w8, w9
	b.lt	LBB6_1
LBB6_2:                                 ; %for.exit
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function printChar
l_printChar:                            ; @printChar
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #48
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 48
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	cmp	w0, #128
	str	w0, [sp, #12]
	b.lt	LBB7_7
; %bb.1:                                ; %if.else
	ldr	w8, [sp, #12]
	cmp	w0, #2047
	b.gt	LBB7_3
; %bb.2:                                ; %if.then2
	asr	w8, w8, #6
	orr	w0, w8, #0xc0
	b	LBB7_6
LBB7_3:                                 ; %if.else6
	ldr	w9, [sp, #12]
	cmp	w8, #16, lsl #12                ; =65536
	b.ge	LBB7_5
; %bb.4:                                ; %if.then8
	asr	w8, w9, #12
	orr	w0, w8, #0xe0
	bl	_putchar
	ldr	w8, [sp, #12]
	mov	w0, #128
	bfxil	w0, w8, #6, #6
	b	LBB7_6
LBB7_5:                                 ; %if.else19
	asr	w8, w9, #18
	orr	w0, w8, #0xf0
	bl	_putchar
	ldr	w8, [sp, #12]
	mov	w0, #128
	mov	w19, #128
	bfxil	w0, w8, #12, #6
	bl	_putchar
	ldr	w8, [sp, #12]
	bfxil	w19, w8, #6, #6
	mov	w0, w19
LBB7_6:                                 ; %if.end34
	bl	_putchar
	ldr	w8, [sp, #12]
	mov	w0, #128
	bfxil	w0, w8, #0, #6
LBB7_7:                                 ; %if.end35
	bl	_putchar
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
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
Lloh4:
	adrp	x1, l_.strFree@PAGE
	mov	w8, #17
Lloh5:
	add	x1, x1, l_.strFree@PAGEOFF
	mov	w0, #17
	str	w8, [sp]
	str	x1, [sp, #8]
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
	tbz	w0, #0, LBB10_2
; %bb.1:                                ; %if.then
Lloh6:
	adrp	x9, l_.strTrue@PAGE
	mov	w8, #4
Lloh7:
	add	x9, x9, l_.strTrue@PAGEOFF
	str	w8, [sp]
	mov	w0, w8
	str	x9, [sp, #8]
	mov	x1, x9
	add	sp, sp, #16
	ret
LBB10_2:                                ; %if.else
Lloh8:
	adrp	x9, l_.strFalse@PAGE
	mov	w8, #5
Lloh9:
	add	x9, x9, l_.strFalse@PAGEOFF
	str	w8, [sp]
	mov	w0, w8
	str	x9, [sp, #8]
	mov	x1, x9
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
	cbz	w20, LBB13_2
; %bb.1:                                ; %exit
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB13_2:                                ; %if.then
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
	b.vc	LBB14_2
; %bb.1:                                ; %if.then
Lloh10:
	adrp	x9, l_strNaN@PAGE
	mov	w8, #3
Lloh11:
	add	x9, x9, l_strNaN@PAGEOFF
	b	LBB14_6
LBB14_2:                                ; %if.else
	mov	w8, #2139095040
	ldr	s0, [sp, #44]
	fmov	s1, w8
	fcmp	s0, s1
	b.ne	LBB14_4
; %bb.3:                                ; %if.then2
Lloh12:
	adrp	x9, l_strPosInf@PAGE
	mov	w8, #3
Lloh13:
	add	x9, x9, l_strPosInf@PAGEOFF
	b	LBB14_6
LBB14_4:                                ; %if.else5
	mov	w8, #-8388608
	ldr	s0, [sp, #44]
	fmov	s1, w8
	fcmp	s0, s1
	b.ne	LBB14_8
; %bb.5:                                ; %if.then7
Lloh14:
	adrp	x9, l_strNegInf@PAGE
	mov	w8, #4
Lloh15:
	add	x9, x9, l_strNegInf@PAGEOFF
LBB14_6:                                ; %return
	str	w8, [sp, #16]
	str	x9, [sp, #24]
LBB14_7:                                ; %return
	ldr	q0, [sp, #16]
	str	q0, [sp, #48]
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldr	w0, [sp, #48]
	ldr	x1, [sp, #56]
	add	sp, sp, #80
	ret
LBB14_8:                                ; %if.else10
	ldr	s0, [sp, #44]
	fcmp	s0, #0.0
	b.ne	LBB14_11
; %bb.9:                                ; %if.then12
	ldr	w8, [sp, #40]
	lsr	w8, w8, #31
	str	w8, [sp, #12]
	cbz	w8, LBB14_12
; %bb.10:                               ; %if.else17
	mov	w8, #4
	str	w8, [sp, #16]
Lloh16:
	adrp	x8, l_strNegZero@PAGE
Lloh17:
	add	x8, x8, l_strNegZero@PAGEOFF
	b	LBB14_13
LBB14_11:                               ; %if.else20
	ldr	s0, [sp, #44]
	ldr	w0, [sp, #40]
	bl	l_normalString
	str	w0, [sp, #48]
	str	x1, [sp, #56]
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	mov	w0, w0
	add	sp, sp, #80
	ret
LBB14_12:                               ; %if.then14
	mov	w8, #3
	str	w8, [sp, #16]
Lloh18:
	adrp	x8, l_strPosZero@PAGE
Lloh19:
	add	x8, x8, l_strPosZero@PAGEOFF
LBB14_13:                               ; %if.end
	str	x8, [sp, #24]
	b	LBB14_7
	.loh AdrpAdd	Lloh10, Lloh11
	.loh AdrpAdd	Lloh12, Lloh13
	.loh AdrpAdd	Lloh14, Lloh15
	.loh AdrpAdd	Lloh16, Lloh17
	.loh AdrpAdd	Lloh18, Lloh19
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3                               ; -- Begin function normalString
lCPI15_0:
	.quad	0xbfe65df6555c52e7              ; double -0.69896999999999998
lCPI15_1:
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
	cbz	w8, LBB15_2
; %bb.1:                                ; %if.else
	ldp	w9, w8, [sp, #160]
	sub	w8, w8, #150
	orr	w9, w9, #0x800000
	b	LBB15_3
LBB15_2:                                ; %if.then
	ldr	w9, [sp, #160]
	mov	w8, #-149
LBB15_3:                                ; %if.end
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
	b.mi	LBB15_8
; %bb.4:                                ; %if.then9
Lloh20:
	adrp	x8, lCPI15_1@PAGE
Lloh21:
	ldr	d1, [x8, lCPI15_1@PAGEOFF]
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
	cbz	w8, LBB15_7
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
	b.gt	LBB15_7
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
LBB15_7:                                ; %if.end33
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
	b	LBB15_15
LBB15_8:                                ; %if.else41
Lloh22:
	adrp	x8, lCPI15_0@PAGE
	ldr	w9, [sp, #156]
Lloh23:
	ldr	d1, [x8, lCPI15_0@PAGEOFF]
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
	cbz	w8, LBB15_11
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
	b.gt	LBB15_11
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
LBB15_11:                               ; %if.end72
	ldr	w8, [sp, #96]
	ldr	w9, [sp, #156]
	cmp	w8, #2
	add	w9, w8, w9
	cset	w10, lt
	cmp	w8, #22
	str	w9, [sp, #124]
	strb	w10, [sp, #123]
	b.gt	LBB15_13
; %bb.12:                               ; %land.rhs
	ldr	w8, [sp, #96]
	mov	w10, #1
	ldr	w9, [sp, #148]
	sub	w8, w8, #1
	lsl	w8, w10, w8
	sub	w8, w8, #1
	tst	w9, w8
	cset	w8, eq
	b	LBB15_14
LBB15_13:
	mov	w8, wzr
LBB15_14:                               ; %land.end
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
LBB15_15:                               ; %if.end92
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
	tbz	w10, #0, LBB15_17
; %bb.16:                               ; %if.then104
	ldr	w8, [sp, #136]
	sub	w8, w8, #1
	str	w8, [sp, #136]
LBB15_17:                               ; %while.cond.preheader
	mov	w8, #26215
	mov	w9, #52429
	mov	w10, #39320
	mov	w11, #39321
	movk	w8, #26214, lsl #16
	movk	w9, #52428, lsl #16
	movk	w10, #6553, lsl #16
	movk	w11, #6553, lsl #16
	mov	w12, #10
	b	LBB15_19
LBB15_18:                               ; %if.end116
                                        ;   in Loop: Header=BB15_19 Depth=1
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
LBB15_19:                               ; %while.cond
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
	b.le	LBB15_22
; %bb.20:                               ; %while.body
                                        ;   in Loop: Header=BB15_19 Depth=1
	ldr	w13, [sp, #136]
	cmp	w13, #99
	b.gt	LBB15_18
; %bb.21:                               ; %land.lhs.true112
                                        ;   in Loop: Header=BB15_19 Depth=1
	ldrb	w13, [sp, #75]
	tbz	w13, #0, LBB15_18
LBB15_22:                               ; %while.end
	ldrb	w8, [sp, #121]
	tbz	w8, #0, LBB15_28
; %bb.23:                               ; %while.cond131.preheader
	mov	w8, #52429
	mov	w9, #39320
	mov	w10, #26215
	movk	w8, #52428, lsl #16
	movk	w9, #6553, lsl #16
	movk	w10, #26214, lsl #16
	mov	w11, #10
	b	LBB15_25
LBB15_24:                               ; %if.end142
                                        ;   in Loop: Header=BB15_25 Depth=1
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
LBB15_25:                               ; %while.cond131
                                        ; =>This Inner Loop Header: Depth=1
	ldr	w12, [sp, #128]
	madd	w12, w12, w8, w9
	ror	w12, w12, #1
	cmp	w12, w9
	b.hi	LBB15_28
; %bb.26:                               ; %while.body135
                                        ;   in Loop: Header=BB15_25 Depth=1
	ldr	w12, [sp, #136]
	cmp	w12, #99
	b.gt	LBB15_24
; %bb.27:                               ; %land.lhs.true138
                                        ;   in Loop: Header=BB15_25 Depth=1
	ldrb	w12, [sp, #75]
	tbz	w12, #0, LBB15_24
LBB15_28:                               ; %if.end149
	ldrb	w8, [sp, #122]
	tbz	w8, #0, LBB15_31
; %bb.29:                               ; %if.end149
	ldr	w8, [sp, #116]
	cmp	w8, #5
	b.ne	LBB15_31
; %bb.30:                               ; %land.lhs.true155
	ldr	w8, [sp, #132]
	cmp	w8, #0
	cinc	w9, w8, lt
	and	w9, w9, #0xfffffffe
	cmp	w8, w9
	b.eq	LBB15_34
LBB15_31:                               ; %if.end160
	ldp	w9, w8, [sp, #128]
	cmp	w8, w9
	b.ne	LBB15_35
LBB15_32:                               ; %land.lhs.true163
	ldrb	w9, [sp, #121]
	tbnz	w9, #0, LBB15_35
; %bb.33:
	mov	w9, #1
	b	LBB15_36
LBB15_34:                               ; %if.then159
	mov	w8, #4
	str	w8, [sp, #116]
	ldp	w9, w8, [sp, #128]
	cmp	w8, w9
	b.eq	LBB15_32
LBB15_35:                               ; %lor.rhs165
	ldr	w9, [sp, #116]
	cmp	w9, #4
	cset	w9, gt
LBB15_36:                               ; %lor.end168
	ldr	w10, [sp, #80]
	add	w8, w8, w9
	ldr	w11, [sp, #68]
	mov	w0, #60
	sub	w9, w10, w11
	stp	w9, w8, [sp, #60]
	bl	_malloc
	ldr	s0, [sp, #172]
	str	x0, [sp, #48]
	str	wzr, [sp, #44]
	fcmp	s0, #0.0
	b.pl	LBB15_38
; %bb.37:                               ; %if.then175
	ldrsw	x8, [sp, #44]
	mov	w11, #45
	ldr	x10, [sp, #48]
	add	w9, w8, #1
	str	w9, [sp, #44]
	str	w11, [x10, x8, lsl #2]
LBB15_38:                               ; %if.end177
	ldrb	w8, [sp, #75]
	tbz	w8, #0, LBB15_42
; %bb.39:                               ; %if.then179
	mov	w8, #26215
	mov	w9, #10
	movk	w8, #26214, lsl #16
	str	wzr, [sp, #40]
LBB15_40:                               ; %for.cond
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
	b.ge	LBB15_49
; %bb.41:                               ; %for.body
                                        ;   in Loop: Header=BB15_40 Depth=1
	ldp	w13, w11, [sp, #60]
	ldp	w14, w12, [sp, #40]
                                        ; kill: def $w11 killed $w11 def $x11
	add	w15, w10, #48
	sxtw	x11, w11
	add	w12, w12, w13
	mul	x11, x11, x8
	sub	w12, w12, w14
	ldr	x13, [sp, #48]
	lsr	x16, x11, #63
	asr	x11, x11, #34
	add	w11, w11, w16
	str	w15, [x13, w12, sxtw #2]
	add	w12, w14, #1
	str	w11, [sp, #64]
	stp	w10, w12, [sp, #36]
	b	LBB15_40
LBB15_42:                               ; %if.else232
	ldr	w8, [sp, #76]
	tbnz	w8, #31, LBB15_56
; %bb.43:                               ; %if.else270
	ldr	w8, [sp, #76]
	ldr	w9, [sp, #60]
	add	w8, w8, #1
	cmp	w8, w9
	b.lt	LBB15_60
; %bb.44:                               ; %if.then274
	mov	w8, #26215
	mov	w9, #10
	movk	w8, #26214, lsl #16
	str	wzr, [sp, #20]
	mov	w10, wzr
	ldr	w11, [sp, #60]
	cmp	w10, w11
	b.ge	LBB15_46
LBB15_45:                               ; %for.body279
                                        ; =>This Inner Loop Header: Depth=1
	ldp	w12, w10, [sp, #60]
                                        ; kill: def $w10 killed $w10 def $x10
	ldr	w11, [sp, #44]
	sxtw	x10, w10
	ldr	w14, [sp, #20]
	mul	x13, x10, x8
	add	w11, w11, w12
	mvn	w12, w14
	lsr	x15, x13, #63
	asr	x13, x13, #34
	add	w13, w13, w15
	add	w11, w12, w11
	add	w12, w14, #1
	ldr	x15, [sp, #48]
	msub	w10, w13, w9, w10
	str	w13, [sp, #64]
	add	w10, w10, #48
	str	w12, [sp, #20]
	str	w10, [x15, w11, sxtw #2]
	mov	w10, w12
	ldr	w11, [sp, #60]
	cmp	w10, w11
	b.lt	LBB15_45
LBB15_46:                               ; %for.end290
	ldr	w9, [sp, #60]
	ldr	w8, [sp, #44]
	str	w9, [sp, #16]
	add	w10, w8, w9
	mov	w8, #48
	str	w10, [sp, #44]
LBB15_47:                               ; %for.cond293
                                        ; =>This Inner Loop Header: Depth=1
	ldrsw	x9, [sp, #44]
	ldr	w10, [sp, #76]
	ldr	w11, [sp, #16]
	add	w12, w9, #1
	add	w13, w10, #1
	ldr	x10, [sp, #48]
	cmp	w11, w13
	str	w12, [sp, #44]
	b.ge	LBB15_65
; %bb.48:                               ; %for.body297
                                        ;   in Loop: Header=BB15_47 Depth=1
	ldr	w11, [sp, #16]
	str	w8, [x10, x9, lsl #2]
	add	w11, w11, #1
	str	w11, [sp, #16]
	b	LBB15_47
LBB15_49:                               ; %for.end
	ldrsw	x8, [sp, #44]
	add	w9, w10, #48
	ldr	x10, [sp, #48]
	str	w9, [x10, x8, lsl #2]
	mov	w9, #46
	ldrsw	x8, [sp, #44]
	ldr	x10, [sp, #48]
	add	x8, x8, #1
	str	w8, [sp, #44]
	str	w9, [x10, x8, lsl #2]
	ldr	w9, [sp, #60]
	ldr	w8, [sp, #44]
	cmp	w9, #1
	add	w8, w8, w9
	str	w8, [sp, #44]
	b.ne	LBB15_51
; %bb.50:                               ; %if.then202
	ldrsw	x8, [sp, #44]
	mov	w11, #48
	ldr	x10, [sp, #48]
	add	w9, w8, #1
	str	w9, [sp, #44]
	str	w11, [x10, x8, lsl #2]
LBB15_51:                               ; %if.end206
	ldrsw	x8, [sp, #44]
	mov	w12, #101
	ldr	w10, [sp, #76]
	ldr	x11, [sp, #48]
	add	w9, w8, #1
	str	w9, [sp, #44]
	str	w12, [x11, x8, lsl #2]
	tbz	w10, #31, LBB15_53
; %bb.52:                               ; %if.then212
	ldrsw	x8, [sp, #44]
	mov	w12, #45
	ldr	w9, [sp, #76]
	ldr	x11, [sp, #48]
	add	w10, w8, #1
	neg	w9, w9
	str	w10, [sp, #44]
	str	w12, [x11, x8, lsl #2]
	str	w9, [sp, #76]
LBB15_53:                               ; %if.end217
	ldr	w8, [sp, #76]
	cmp	w8, #10
	b.lt	LBB15_55
; %bb.54:                               ; %if.then220
	ldrsw	x8, [sp, #76]
	mov	w9, #26215
	movk	w9, #26214, lsl #16
	ldrsw	x10, [sp, #44]
	mul	x8, x8, x9
	add	w11, w10, #1
	lsr	x9, x8, #63
	asr	x8, x8, #34
	add	w8, w8, w9
	ldr	x9, [sp, #48]
	add	w8, w8, #48
	str	w11, [sp, #44]
	str	w8, [x9, x10, lsl #2]
LBB15_55:                               ; %if.end226
	ldrsw	x8, [sp, #76]
	mov	w9, #26215
	movk	w9, #26214, lsl #16
	ldrsw	x11, [sp, #44]
	mul	x9, x8, x9
	lsr	x10, x9, #63
	asr	x9, x9, #34
	add	w9, w9, w10
	mov	w10, #10
	msub	w8, w9, w10, w8
	add	w9, w11, #1
	ldr	x10, [sp, #48]
	add	w8, w8, #48
	str	w9, [sp, #44]
	str	w8, [x10, x11, lsl #2]
	b	LBB15_67
LBB15_56:                               ; %if.then235
	ldrsw	x9, [sp, #44]
	mov	w8, #48
	ldr	x11, [sp, #48]
	mov	w12, #-1
	add	w10, w9, #1
	str	w12, [sp, #32]
	str	w10, [sp, #44]
	str	w8, [x11, x9, lsl #2]
	mov	w11, #47
	ldrsw	x9, [sp, #44]
	ldr	x13, [sp, #48]
	add	w10, w9, #1
	str	w10, [sp, #44]
	str	w11, [x13, x9, lsl #2]
	mov	w9, w12
	ldr	w10, [sp, #76]
	cmp	w9, w10
	b.le	LBB15_58
LBB15_57:                               ; %for.body246
                                        ; =>This Inner Loop Header: Depth=1
	ldrsw	x9, [sp, #44]
	ldr	w10, [sp, #32]
	ldr	x12, [sp, #48]
	add	w11, w9, #1
	sub	w10, w10, #1
	str	w11, [sp, #44]
	str	w8, [x12, x9, lsl #2]
	str	w10, [sp, #32]
	mov	w9, w10
	ldr	w10, [sp, #76]
	cmp	w9, w10
	b.gt	LBB15_57
LBB15_58:                               ; %for.end252
	mov	w8, #26215
	ldr	w10, [sp, #44]
	movk	w8, #26214, lsl #16
	mov	w9, #10
	stp	wzr, w10, [sp, #24]
	ldr	w10, [sp, #24]
	ldr	w11, [sp, #60]
	cmp	w10, w11
	b.ge	LBB15_67
LBB15_59:                               ; %for.body257
                                        ; =>This Inner Loop Header: Depth=1
	ldp	w12, w10, [sp, #60]
                                        ; kill: def $w10 killed $w10 def $x10
	ldp	w14, w11, [sp, #24]
	sxtw	x10, w10
	mul	x13, x10, x8
	add	w11, w11, w12
	mvn	w12, w14
	lsr	x15, x13, #63
	asr	x13, x13, #34
	add	w13, w13, w15
	add	w11, w12, w11
	ldr	x12, [sp, #48]
	msub	w10, w13, w9, w10
	str	w13, [sp, #64]
	add	w10, w10, #48
	str	w10, [x12, w11, sxtw #2]
	add	w11, w14, #1
	ldr	w10, [sp, #44]
	str	w11, [sp, #24]
	add	w10, w10, #1
	str	w10, [sp, #44]
	mov	w10, w11
	ldr	w11, [sp, #60]
	cmp	w10, w11
	b.lt	LBB15_59
	b	LBB15_67
LBB15_60:                               ; %if.else310
	ldr	w8, [sp, #44]
	mov	w9, #26215
	movk	w9, #26214, lsl #16
	mov	w10, #10
	add	w11, w8, #1
	mov	w8, #46
	stp	wzr, w11, [sp, #8]
	b	LBB15_62
LBB15_61:                               ; %if.end329
                                        ;   in Loop: Header=BB15_62 Depth=1
	ldp	w13, w11, [sp, #60]
                                        ; kill: def $w11 killed $w11 def $x11
	ldp	w15, w12, [sp, #8]
	sxtw	x11, w11
	mul	x14, x11, x9
	add	w12, w12, w13
	mvn	w13, w15
	lsr	x16, x14, #63
	asr	x14, x14, #34
	add	w14, w14, w16
	add	w12, w13, w12
	add	w13, w15, #1
	ldr	x16, [sp, #48]
	msub	w11, w14, w10, w11
	str	w14, [sp, #64]
	add	w11, w11, #48
	str	w13, [sp, #8]
	str	w11, [x16, w12, sxtw #2]
LBB15_62:                               ; %for.cond314
                                        ; =>This Inner Loop Header: Depth=1
	ldr	w12, [sp, #8]
	ldr	w11, [sp, #60]
	cmp	w12, w11
	b.ge	LBB15_66
; %bb.63:                               ; %for.body317
                                        ;   in Loop: Header=BB15_62 Depth=1
	ldr	w12, [sp, #8]
	ldr	w13, [sp, #76]
	mvn	w12, w12
	add	w11, w12, w11
	cmp	w11, w13
	b.ne	LBB15_61
; %bb.64:                               ; %if.then322
                                        ;   in Loop: Header=BB15_62 Depth=1
	ldp	w13, w11, [sp, #8]
	ldr	w12, [sp, #60]
	add	w12, w11, w12
	mvn	w13, w13
	add	w12, w13, w12
	sub	w11, w11, #1
	ldr	x13, [sp, #48]
	str	w8, [x13, w12, sxtw #2]
	str	w11, [sp, #12]
	b	LBB15_61
LBB15_65:                               ; %for.end303
	mov	w8, #46
	str	w8, [x10, x9, lsl #2]
	mov	w10, #48
	ldrsw	x8, [sp, #44]
	ldr	x11, [sp, #48]
	add	w9, w8, #1
	str	w9, [sp, #44]
	str	w10, [x11, x8, lsl #2]
	b	LBB15_67
LBB15_66:                               ; %for.end340
	ldr	w8, [sp, #44]
	add	w8, w11, w8
	add	w8, w8, #1
	str	w8, [sp, #44]
LBB15_67:                               ; %if.end345
	ldrsw	x8, [sp, #44]
	ldr	w9, [sp, #44]
	lsl	x0, x8, #2
	str	w9, [sp, #176]
	bl	_malloc
	ldrsw	x8, [sp, #44]
	str	x0, [sp, #184]
	ldr	x1, [sp, #48]
	lsl	x2, x8, #2
	bl	_memcpy
	ldr	x0, [sp, #48]
	bl	_free
	ldp	x29, x30, [sp, #208]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #192]            ; 16-byte Folded Reload
	ldr	w0, [sp, #176]
	ldr	x1, [sp, #184]
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
	cbz	w0, LBB16_2
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
LBB16_2:
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
	adrp	x8, l_FLOAT_POW5_INV_SPLIT@PAGE
	stp	w1, w0, [sp, #8]
Lloh25:
	add	x8, x8, l_FLOAT_POW5_INV_SPLIT@PAGEOFF
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
	adrp	x8, l_FLOAT_POW5_SPLIT@PAGE
	stp	w1, w0, [sp, #8]
Lloh27:
	add	x8, x8, l_FLOAT_POW5_SPLIT@PAGEOFF
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
	b.lt	LBB20_3
LBB20_1:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	ldr	w9, [sp, #12]
	ldr	w10, [sp, #4]
	cmp	w9, w10
	b.ge	LBB20_3
; %bb.2:                                ; %if.end
                                        ;   in Loop: Header=BB20_1 Depth=1
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
	b.ge	LBB20_1
LBB20_3:                                ; %for.end
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
	b.lt	LBB22_3
LBB22_1:                                ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	ldr	w12, [sp, #8]
	madd	w12, w12, w8, w9
	cmp	w12, w10
	b.ls	LBB22_4
; %bb.2:                                ; %if.end
                                        ;   in Loop: Header=BB22_1 Depth=1
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
	b.ge	LBB22_1
LBB22_3:                                ; %while.end
	str	wzr, [sp, #12]
	mov	w0, wzr
	add	sp, sp, #16
	ret
LBB22_4:                                ; %if.then
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
	cbz	w20, LBB25_2
; %bb.1:                                ; %exit
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB25_2:                                ; %if.then
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
	.globl	_.copy                          ; -- Begin function .copy
	.p2align	2
_.copy:                                 ; @.copy
	.cfi_startproc
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	"_.copy:string"
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	"_.copy:string"                 ; -- Begin function .copy:string
	.p2align	2
"_.copy:string":                        ; @".copy:string"
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #64
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	lsl	w19, w0, #2
	str	w0, [sp]
	str	w0, [sp, #16]
	mov	w0, w19
	str	x1, [sp, #8]
	bl	_malloc
	ldr	x1, [sp, #8]
	mov	x2, x19
	mov	x20, x0
	bl	_memcpy
	mov	x1, x20
	str	x20, [sp, #24]
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldr	w0, [sp, #16]
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #80
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 80
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh28:
	adrp	x8, l_.str0@PAGE
Lloh29:
	adrp	x1, l_.str1@PAGE
Lloh30:
	add	x8, x8, l_.str0@PAGEOFF
	mov	w9, #5
Lloh31:
	add	x1, x1, l_.str1@PAGEOFF
	mov	w0, #5
	str	x8, [sp, #24]
	str	x8, [sp, #56]
	str	w9, [sp, #16]
	str	w9, [sp, #48]
	str	w9, [sp]
	str	x1, [sp, #8]
	str	w9, [sp, #32]
	str	x1, [sp, #40]
	bl	_.println
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
	.loh AdrpAdd	Lloh29, Lloh31
	.loh AdrpAdd	Lloh28, Lloh30
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	2                               ; @.strTrue
l_.strTrue:
	.long	116                             ; 0x74
	.long	114                             ; 0x72
	.long	117                             ; 0x75
	.long	101                             ; 0x65

	.section	__TEXT,__const
	.p2align	2                               ; @.strFalse
l_.strFalse:
	.long	102                             ; 0x66
	.long	97                              ; 0x61
	.long	108                             ; 0x6c
	.long	115                             ; 0x73
	.long	101                             ; 0x65

	.p2align	4                               ; @FLOAT_POW5_INV_SPLIT
l_FLOAT_POW5_INV_SPLIT:
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

	.p2align	4                               ; @FLOAT_POW5_SPLIT
l_FLOAT_POW5_SPLIT:
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

	.p2align	2                               ; @strNaN
l_strNaN:
	.long	110                             ; 0x6e
	.long	97                              ; 0x61
	.long	110                             ; 0x6e

	.p2align	2                               ; @strPosInf
l_strPosInf:
	.long	105                             ; 0x69
	.long	110                             ; 0x6e
	.long	102                             ; 0x66

	.section	__TEXT,__literal16,16byte_literals
	.p2align	4                               ; @strNegInf
l_strNegInf:
	.long	45                              ; 0x2d
	.long	105                             ; 0x69
	.long	110                             ; 0x6e
	.long	102                             ; 0x66

	.section	__TEXT,__const
	.p2align	2                               ; @strPosZero
l_strPosZero:
	.long	48                              ; 0x30
	.long	46                              ; 0x2e
	.long	48                              ; 0x30

	.section	__TEXT,__literal16,16byte_literals
	.p2align	4                               ; @strNegZero
l_strNegZero:
	.long	45                              ; 0x2d
	.long	48                              ; 0x30
	.long	46                              ; 0x2e
	.long	48                              ; 0x30

	.section	__TEXT,__const
	.p2align	2                               ; @.strFree
l_.strFree:
	.long	70                              ; 0x46
	.long	114                             ; 0x72
	.long	101                             ; 0x65
	.long	101                             ; 0x65
	.long	100                             ; 0x64
	.long	32                              ; 0x20
	.long	102                             ; 0x66
	.long	114                             ; 0x72
	.long	111                             ; 0x6f
	.long	109                             ; 0x6d
	.long	32                              ; 0x20
	.long	109                             ; 0x6d
	.long	101                             ; 0x65
	.long	109                             ; 0x6d
	.long	111                             ; 0x6f
	.long	114                             ; 0x72
	.long	121                             ; 0x79

	.p2align	2                               ; @.strCount
l_.strCount:
	.long	32                              ; 0x20
	.long	114                             ; 0x72
	.long	101                             ; 0x65
	.long	102                             ; 0x66
	.long	101                             ; 0x65
	.long	114                             ; 0x72
	.long	101                             ; 0x65
	.long	110                             ; 0x6e
	.long	99                              ; 0x63
	.long	101                             ; 0x65
	.long	40                              ; 0x28
	.long	115                             ; 0x73
	.long	41                              ; 0x29

	.section	__TEXT,__literal4,4byte_literals
	.p2align	2                               ; @.strZero
l_.strZero:
	.long	48                              ; 0x30

	.section	__TEXT,__const
	.p2align	2                               ; @.str0
l_.str0:
	.long	72                              ; 0x48
	.long	101                             ; 0x65
	.long	108                             ; 0x6c
	.long	108                             ; 0x6c
	.long	111                             ; 0x6f

	.p2align	2                               ; @.str1
l_.str1:
	.long	87                              ; 0x57
	.long	111                             ; 0x6f
	.long	114                             ; 0x72
	.long	108                             ; 0x6c
	.long	100                             ; 0x64

.subsections_via_symbols

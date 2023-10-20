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
Lloh10:
	adrp	x5, l_.str0@PAGE
	movk	x8, #9, lsl #32
Lloh11:
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
Lloh12:
	adrp	x5, l_.str1@PAGE
	movk	x8, #11, lsl #32
Lloh13:
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
	.loh AdrpAdd	Lloh12, Lloh13
	.loh AdrpAdd	Lloh10, Lloh11
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
	b.eq	LBB15_2
; %bb.1:                                ; %exit
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB15_2:                                ; %if.then
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
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	w8, #13107
	movk	w8, #16627, lsl #16
	fmov	s0, w8
	bl	"_newref:float"
	mov	x19, x0
	bl	"_ref:float"
	mov	x0, x19
	bl	l_mod.floatThing
	ldr	x8, [x19]
	ldr	s0, [x8]
	fcvtzs	w0, s0
	bl	"_.conv:int_string"
	bl	_.println
	mov	x0, x19
	bl	"_deref:float"
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function mod.floatThing
l_mod.floatThing:                       ; @mod.floatThing
	.cfi_startproc
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	w8, #52428
	ldr	x9, [x0]
	movk	w8, #16668, lsl #16
	ldr	s0, [x9]
	fmov	s1, w8
	fadd	s0, s0, s1
	str	s0, [x9]
	mov	w9, #1120403456
	ldr	x8, [x0]
	fmov	s1, w9
	ldr	s0, [x8]
	fcmp	s0, s1
	b.gt	LBB17_2
; %bb.1:                                ; %if.then0
	mov	x19, x0
	bl	"_ref:float"
	mov	x0, x19
	bl	l_mod.floatThing
	mov	x0, x19
	bl	"_deref:float"
LBB17_2:                                ; %if.end0
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__literal4,4byte_literals
l_.strTrue:                             ; @.strTrue
	.ascii	"true"

	.section	__TEXT,__const
l_.strFalse:                            ; @.strFalse
	.ascii	"false"

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

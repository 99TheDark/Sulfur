	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
	.globl	_.conv.int_string               ; -- Begin function .conv.int_string
	.p2align	2
_.conv.int_string:                      ; @.conv.int_string
	.cfi_startproc
; %bb.0:                                ; %entry
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	sub	sp, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	mov	x19, x0
	mov	w0, #10
	stur	w1, [x29, #-52]
	mov	w21, #10
	bl	_malloc
	mov	x20, x0
	mov	w9, #9
	ldur	w8, [x29, #-52]
	stur	x0, [x29, #-64]
	stp	wzr, w9, [x29, #-72]
	tbz	w8, #31, LBB0_2
; %bb.1:                                ; %if.then
	neg	w8, w8
	mov	w9, #1
	stur	w8, [x29, #-52]
	stur	w9, [x29, #-72]
LBB0_2:                                 ; %while.cond.preheader
	mov	w8, #26215
	movk	w8, #26214, lsl #16
	ldur	w9, [x29, #-52]
	cmp	w9, #1
	b.lt	LBB0_4
LBB0_3:                                 ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	smull	x10, w9, w8
	lsr	x11, x10, #63
	asr	x10, x10, #34
	add	w10, w10, w11
	ldursw	x11, [x29, #-68]
	msub	w9, w10, w21, w9
	sub	w12, w11, #1
	stur	w10, [x29, #-52]
	add	w9, w9, #48
	strb	w9, [x20, x11]
	stur	w12, [x29, #-68]
	mov	w9, w10
	cmp	w9, #1
	b.ge	LBB0_3
LBB0_4:                                 ; %while.end
	mov	x8, sp
	sub	x9, x8, #16
	mov	sp, x9
	ldp	w22, w23, [x29, #-72]
	sub	w9, w22, w23
	add	w21, w9, #9
	mov	w0, w21
	stur	w21, [x8, #-16]
	stp	w21, w21, [x19]
	bl	_malloc
	str	x0, [x19, #8]
	cbz	w22, LBB0_6
; %bb.5:                                ; %if.then2
	ldr	x8, [x19, #8]
	mov	w9, #45
	strb	w9, [x8]
	b	LBB0_7
LBB0_6:                                 ; %if.else2
	add	w8, w23, #1
	stur	w8, [x29, #-68]
LBB0_7:                                 ; %if.end2
	mov	x10, sp
	sub	x8, x10, #16
	mov	sp, x8
	ldur	w9, [x29, #-68]
	stur	w22, [x10, #-16]
	ldr	w10, [x8]
	cmp	w10, w21
	b.ge	LBB0_9
LBB0_8:                                 ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	add	w11, w9, w10
	add	w13, w10, #1
	ldr	x12, [x19, #8]
	ldrb	w11, [x20, w11, sxtw]
	str	w13, [x8]
	strb	w11, [x12, w10, sxtw]
	mov	w10, w13
	cmp	w10, w21
	b.lt	LBB0_8
LBB0_9:                                 ; %for.end
	mov	x0, x20
	bl	_free
	sub	sp, x29, #48
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_.print                         ; -- Begin function .print
	.p2align	2
_.print:                                ; @.print
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
	mov	x19, x0
	str	wzr, [sp, #8]
	mov	w8, wzr
	ldr	w9, [x19, #4]
	cmp	w8, w9
	b.ge	LBB1_2
LBB1_1:                                 ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	ldrsw	x8, [sp, #8]
	ldr	x9, [x19, #8]
	ldrb	w0, [x9, x8]
	bl	_putchar
	ldr	w8, [sp, #8]
	add	w8, w8, #1
	str	w8, [sp, #8]
	mov	w8, w8
	ldr	w9, [x19, #4]
	cmp	w8, w9
	b.lt	LBB1_1
LBB1_2:                                 ; %for.end
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #48
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
	.globl	_.add.string_string             ; -- Begin function .add.string_string
	.p2align	2
_.add.string_string:                    ; @.add.string_string
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #80
	stp	x24, x23, [sp, #16]             ; 16-byte Folded Spill
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
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	ldr	w8, [x1]
	mov	x20, x0
	ldr	w9, [x2]
	mov	x19, x2
	mov	x22, x1
	add	w8, w8, w9
	str	w8, [x0]
	ldr	w23, [x1, #4]
	ldr	w8, [x2, #4]
	add	w21, w23, w8
	str	w21, [x0, #4]
	mov	w0, w21
	bl	_malloc
	str	xzr, [sp, #8]
	str	x0, [x20, #8]
	lsr	x8, xzr, #32
	cmp	w8, w23
	b.ge	LBB3_3
LBB3_1:                                 ; %while1.body
                                        ; =>This Inner Loop Header: Depth=1
	ldrsw	x8, [sp, #12]
	ldr	x9, [x22, #8]
	ldr	x10, [x20, #8]
	ldrb	w9, [x9, x8]
	add	w11, w8, #1
	strb	w9, [x10, x8]
	str	w11, [sp, #12]
	mov	w8, w11
	cmp	w8, w23
	b.lt	LBB3_1
	b	LBB3_3
LBB3_2:                                 ; %while2.body
                                        ;   in Loop: Header=BB3_3 Depth=1
	ldpsw	x9, x8, [sp, #8]
	ldr	x10, [x19, #8]
	ldr	x11, [x20, #8]
	ldrb	w10, [x10, x9]
	add	w12, w8, #1
	add	w9, w9, #1
	strb	w10, [x11, x8]
	stp	w9, w12, [sp, #8]
LBB3_3:                                 ; %while2.cond
                                        ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #12]
	cmp	w8, w21
	b.lt	LBB3_2
; %bb.4:                                ; %while2.end
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #64
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh0:
	adrp	x9, l_.str1@PAGE
	mov	w1, #47302
	mov	x8, #64424509455
Lloh1:
	add	x9, x9, l_.str1@PAGEOFF
	add	x0, sp, #16
	movk	w1, #65177, lsl #16
	stp	x8, x9, [sp, #32]
	bl	_.conv.int_string
	mov	x0, sp
	add	x1, sp, #32
	add	x2, sp, #16
	bl	_.add.string_string
	mov	x0, sp
	bl	_.println
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.loh AdrpAdd	Lloh0, Lloh1
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__const
l_.str1:                                ; @.str1
	.ascii	"The number is: "

.subsections_via_symbols

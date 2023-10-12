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
	cbz	w1, LBB0_7
; %bb.1:                                ; %if.end
	mov	x20, sp
	sub	x21, x20, #16
	mov	sp, x21
	mov	x24, sp
	stur	w1, [x20, #-16]
	sub	x8, x24, #16
	mov	sp, x8
	mov	w0, #10
	mov	w23, #10
	bl	_malloc
	mov	x8, sp
	stur	x0, [x24, #-16]
	sub	x22, x8, #16
	mov	sp, x22
	mov	w9, #9
	mov	x10, sp
	stur	w9, [x8, #-16]
	sub	x8, x10, #16
	mov	sp, x8
	ldur	w9, [x20, #-16]
	mov	x20, x0
	stur	wzr, [x10, #-16]
	tbz	w9, #31, LBB0_3
; %bb.2:                                ; %if.then1
	neg	w9, w9
	mov	w10, #1
	str	w9, [x21]
	str	w10, [x8]
LBB0_3:                                 ; %while.cond.preheader
	mov	w9, #26215
	movk	w9, #26214, lsl #16
	ldr	w10, [x21]
	cmp	w10, #1
	b.lt	LBB0_5
LBB0_4:                                 ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	smull	x11, w10, w9
	lsr	x12, x11, #63
	asr	x11, x11, #34
	add	w11, w11, w12
	ldrsw	x12, [x22]
	msub	w10, w11, w23, w10
	sub	w13, w12, #1
	str	w11, [x21]
	add	w10, w10, #48
	strb	w10, [x20, x12]
	str	w13, [x22]
	mov	w10, w11
	cmp	w10, #1
	b.ge	LBB0_4
LBB0_5:                                 ; %while.end
	mov	x9, sp
	sub	x10, x9, #16
	mov	sp, x10
	ldr	w24, [x22]
	ldr	w23, [x8]
	sub	w8, w23, w24
	add	w21, w8, #9
	mov	w0, w21
	stur	w21, [x9, #-16]
	stp	w21, w21, [x19]
	bl	_malloc
	str	x0, [x19, #8]
	cbz	w23, LBB0_8
; %bb.6:                                ; %if.then2
	ldr	x8, [x19, #8]
	mov	w9, #45
	strb	w9, [x8]
	b	LBB0_9
LBB0_7:                                 ; %if.then
Lloh0:
	adrp	x9, l_.str0@PAGE
	mov	x8, #4294967297
Lloh1:
	add	x9, x9, l_.str0@PAGEOFF
	stp	x8, x9, [x19]
	sub	sp, x29, #48
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB0_8:                                 ; %if.else2
	add	w8, w24, #1
	str	w8, [x22]
LBB0_9:                                 ; %if.end2
	mov	x10, sp
	sub	x8, x10, #16
	mov	sp, x8
	ldr	w9, [x22]
	stur	w23, [x10, #-16]
	ldr	w10, [x8]
	cmp	w10, w21
	b.ge	LBB0_11
LBB0_10:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	add	w11, w9, w10
	add	w13, w10, #1
	ldr	x12, [x19, #8]
	ldrb	w11, [x20, w11, sxtw]
	str	w13, [x8]
	strb	w11, [x12, w10, sxtw]
	mov	w10, w13
	cmp	w10, w21
	b.lt	LBB0_10
LBB0_11:                                ; %for.end
	mov	x0, x20
	bl	_free
	sub	sp, x29, #48
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh0, Lloh1
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
	stp	x26, x25, [sp, #-80]!           ; 16-byte Folded Spill
	stp	x24, x23, [sp, #16]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
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
	.cfi_offset w25, -72
	.cfi_offset w26, -80
Lloh2:
	adrp	x21, l_.str0.1@PAGE
	mov	x23, #10
	mov	x24, #26
Lloh3:
	adrp	x25, l_.str1@PAGE
Lloh4:
	adrp	x26, l_.str2@PAGE
	mov	w8, #12
Lloh5:
	add	x21, x21, l_.str0.1@PAGEOFF
	mov	x22, #103079215128
	movk	x23, #10, lsl #32
	movk	x24, #26, lsl #32
Lloh6:
	add	x25, x25, l_.str1@PAGEOFF
Lloh7:
	add	x26, x26, l_.str2@PAGEOFF
	stur	w8, [x29, #-68]
	b	LBB4_3
LBB4_1:                                 ; %if.else0
                                        ;   in Loop: Header=BB4_3 Depth=1
	ldr	x2, [x8]
	stp	x24, x26, [x9, #-16]
LBB4_2:                                 ; %if.end0
                                        ;   in Loop: Header=BB4_3 Depth=1
	sub	x20, sp, #16
	mov	sp, x20
	mov	x0, x20
	bl	_.add.string_string
	mov	x8, sp
	sub	x2, x8, #16
	mov	sp, x2
	sub	x19, sp, #16
	stp	x23, x25, [x8, #-16]
	mov	sp, x19
	mov	x0, x19
	mov	x1, x20
	bl	_.add.string_string
	mov	x0, x19
	bl	_.println
	ldur	w8, [x29, #-68]
	add	w8, w8, #1
	stur	w8, [x29, #-68]
LBB4_3:                                 ; %for.cond0
                                        ; =>This Inner Loop Header: Depth=1
	ldur	w8, [x29, #-68]
	cmp	w8, #20
	b.gt	LBB4_6
; %bb.4:                                ; %for.body0
                                        ;   in Loop: Header=BB4_3 Depth=1
	ldur	w1, [x29, #-68]
	sub	x19, sp, #16
	mov	sp, x19
	mov	x0, x19
	bl	_.conv.int_string
	mov	x9, sp
	sub	x8, x9, #16
	mov	sp, x8
	stur	x19, [x9, #-16]
	mov	x9, sp
	ldur	w10, [x29, #-68]
	sub	x1, x9, #16
	cmp	w10, #18
	mov	sp, x1
	b.lt	LBB4_1
; %bb.5:                                ; %if.then0
                                        ;   in Loop: Header=BB4_3 Depth=1
	ldr	x2, [x8]
	stp	x22, x21, [x9, #-16]
	b	LBB4_2
LBB4_6:                                 ; %for.end0
	mov	x9, sp
Lloh8:
	adrp	x8, l_.str4@PAGE
	sub	x0, x9, #16
Lloh9:
	add	x8, x8, l_.str4@PAGEOFF
	mov	sp, x0
	mov	x10, #26
	movk	x10, #26, lsl #32
	stp	x10, x8, [x9, #-16]
	bl	_.println
	sub	sp, x29, #64
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp], #80             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh4, Lloh7
	.loh AdrpAdd	Lloh3, Lloh6
	.loh AdrpAdd	Lloh2, Lloh5
	.loh AdrpAdd	Lloh8, Lloh9
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__const
l_.str0:                                ; @.str0
	.byte	48

l_.str0.1:                              ; @.str0.1
	.ascii	"It is legal to drink at "

l_.str1:                                ; @.str1
	.ascii	" years old"

l_.str2:                                ; @.str2
	.ascii	"It is illegal to drink at "

l_.str4:                                ; @.str4
	.ascii	". . . . . . . . . . . . . "

.subsections_via_symbols

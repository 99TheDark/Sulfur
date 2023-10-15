	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
	.globl	_.conv.bool_string              ; -- Begin function .conv.bool_string
	.p2align	2
_.conv.bool_string:                     ; @.conv.bool_string
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	tbz	w0, #0, LBB0_2
; %bb.1:                                ; %if.then
Lloh0:
	adrp	x2, l_.str0@PAGE
	mov	w1, #4
Lloh1:
	add	x2, x2, l_.str0@PAGEOFF
	stp	w1, w1, [sp]
	mov	w0, w1
	str	x2, [sp, #8]
	add	sp, sp, #16
	ret
LBB0_2:                                 ; %if.else
Lloh2:
	adrp	x2, l_.str1@PAGE
	mov	w1, #5
Lloh3:
	add	x2, x2, l_.str1@PAGEOFF
	stp	w1, w1, [sp]
	mov	w0, w1
	str	x2, [sp, #8]
	add	sp, sp, #16
	ret
	.loh AdrpAdd	Lloh0, Lloh1
	.loh AdrpAdd	Lloh2, Lloh3
	.cfi_endproc
                                        ; -- End function
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
	cbz	w0, LBB1_7
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
	tbz	w9, #31, LBB1_3
; %bb.2:                                ; %if.then1
	neg	w9, w9
	mov	w10, #1
	str	w9, [x20]
	str	w10, [x8]
LBB1_3:                                 ; %while.cond.preheader
	mov	w9, #26215
	movk	w9, #26214, lsl #16
	ldr	w10, [x20]
	cmp	w10, #1
	b.lt	LBB1_5
LBB1_4:                                 ; %while.body
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
	b.ge	LBB1_4
LBB1_5:                                 ; %while.end
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
	cbz	w22, LBB1_8
; %bb.6:                                ; %if.then2
	ldur	x8, [x29, #-56]
	mov	w9, #45
	strb	w9, [x8]
	b	LBB1_9
LBB1_7:                                 ; %if.then
Lloh4:
	adrp	x9, l_.str0.1@PAGE
	mov	x8, #4294967297
Lloh5:
	add	x9, x9, l_.str0.1@PAGEOFF
	stp	x8, x9, [x29, #-64]
	b	LBB1_12
LBB1_8:                                 ; %if.else2
	add	w8, w23, #1
	str	w8, [x21]
LBB1_9:                                 ; %if.end2
	mov	x10, sp
	sub	x8, x10, #16
	mov	sp, x8
	ldr	w9, [x21]
	stur	w22, [x10, #-16]
	ldr	w10, [x8]
	cmp	w10, w20
	b.ge	LBB1_11
LBB1_10:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	add	w11, w9, w10
	add	w13, w10, #1
	ldur	x12, [x29, #-56]
	ldrb	w11, [x19, w11, sxtw]
	str	w13, [x8]
	strb	w11, [x12, w10, sxtw]
	mov	w10, w13
	cmp	w10, w20
	b.lt	LBB1_10
LBB1_11:                                ; %for.end
	mov	x0, x19
	bl	_free
LBB1_12:                                ; %exit
	ldp	w0, w1, [x29, #-64]
	ldur	x2, [x29, #-56]
	sub	sp, x29, #48
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh4, Lloh5
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
	b.ge	LBB2_2
LBB2_1:                                 ; %for.body
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
	b.lt	LBB2_1
LBB2_2:                                 ; %for.end
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
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
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #128
	stp	x22, x21, [sp, #80]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #96]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #112]            ; 16-byte Folded Spill
	.cfi_def_cfa_offset 128
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
Lloh6:
	adrp	x2, l_.str1.1@PAGE
	mov	x8, #5
Lloh7:
	adrp	x5, l_.str2@PAGE
	mov	x19, #17179869188
Lloh8:
	add	x2, x2, l_.str1.1@PAGEOFF
	movk	x8, #5, lsl #32
Lloh9:
	add	x5, x5, l_.str2@PAGEOFF
	mov	w0, #4
	mov	w1, #4
	mov	w3, #5
	mov	w4, #5
	stp	x19, x2, [sp, #64]
	stp	x19, x2, [sp, #48]
	stp	x8, x5, [sp, #32]
	stp	x8, x5, [sp, #16]
	bl	_mod.formatName
Lloh10:
	adrp	x5, l_.str3@PAGE
	mov	w3, #4
Lloh11:
	add	x5, x5, l_.str3@PAGEOFF
	mov	w4, #4
	stp	x19, x5, [sp]
	bl	_.add.string_string
	mov	w19, w0
	mov	w20, w1
	mov	w0, #6
	mov	w1, #4
	mov	x21, x2
	bl	_mod.add
	bl	_.conv.int_string
	mov	w3, w0
	mov	w4, w1
	mov	x5, x2
	mov	w0, w19
	mov	w1, w20
	mov	x2, x21
	bl	_.add.string_string
	bl	_.println
	bl	_mod.noReturn
	ldp	x29, x30, [sp, #112]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #96]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #80]             ; 16-byte Folded Reload
	add	sp, sp, #128
	ret
	.loh AdrpAdd	Lloh10, Lloh11
	.loh AdrpAdd	Lloh7, Lloh9
	.loh AdrpAdd	Lloh6, Lloh8
	.cfi_endproc
                                        ; -- End function
	.globl	_mod.formatName                 ; -- Begin function mod.formatName
	.p2align	2
_mod.formatName:                        ; @mod.formatName
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
	mov	x8, x5
Lloh12:
	adrp	x5, l_.str0.2@PAGE
	mov	x19, x2
	mov	w20, w1
	mov	w21, w0
	mov	x9, #8589934594
Lloh13:
	add	x5, x5, l_.str0.2@PAGEOFF
	mov	w0, w3
	mov	w1, w4
	mov	x2, x8
	mov	w3, #2
	mov	w4, #2
	stp	x9, x5, [sp]
	bl	_.add.string_string
	mov	w3, w21
	mov	w4, w20
	mov	x5, x19
	bl	_.add.string_string
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	str	x2, [sp, #24]
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	stp	w0, w1, [sp, #16]
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
	.loh AdrpAdd	Lloh12, Lloh13
	.cfi_endproc
                                        ; -- End function
	.globl	_mod.add                        ; -- Begin function mod.add
	.p2align	2
_mod.add:                               ; @mod.add
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	add	w0, w0, w1
	str	w0, [sp, #12]
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_mod.noReturn                   ; -- Begin function mod.noReturn
	.p2align	2
_mod.noReturn:                          ; @mod.noReturn
	.cfi_startproc
; %bb.0:                                ; %entry
	ret
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__literal4,4byte_literals
l_.str0:                                ; @.str0
	.ascii	"true"

	.section	__TEXT,__const
l_.str1:                                ; @.str1
	.ascii	"false"

l_.str0.1:                              ; @.str0.1
	.byte	48

l_.str0.2:                              ; @.str0.2
	.ascii	", "

	.section	__TEXT,__literal4,4byte_literals
l_.str1.1:                              ; @.str1.1
	.ascii	"John"

	.section	__TEXT,__const
l_.str2:                                ; @.str2
	.ascii	"Smith"

	.section	__TEXT,__literal4,4byte_literals
l_.str3:                                ; @.str3
	.ascii	" -> "

.subsections_via_symbols

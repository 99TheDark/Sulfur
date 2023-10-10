	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
	.globl	_print                          ; -- Begin function print
	.p2align	2
_print:                                 ; @print
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
	b.ge	LBB0_2
LBB0_1:                                 ; %for.body
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
	b.lt	LBB0_1
LBB0_2:                                 ; %for.end
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_println                        ; -- Begin function println
	.p2align	2
_println:                               ; @println
	.cfi_startproc
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_print
	mov	w0, #10
	bl	_putchar
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_concat                         ; -- Begin function concat
	.p2align	2
_concat:                                ; @concat
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
	b.ge	LBB2_3
LBB2_1:                                 ; %while1.body
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
	b.lt	LBB2_1
	b	LBB2_3
LBB2_2:                                 ; %while2.body
                                        ;   in Loop: Header=BB2_3 Depth=1
	ldpsw	x9, x8, [sp, #8]
	ldr	x10, [x19, #8]
	ldr	x11, [x20, #8]
	ldrb	w10, [x10, x9]
	add	w12, w8, #1
	add	w9, w9, #1
	strb	w10, [x11, x8]
	stp	w9, w12, [sp, #8]
LBB2_3:                                 ; %while2.cond
                                        ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #12]
	cmp	w8, w21
	b.lt	LBB2_2
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
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	sub	sp, sp, #160
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh0:
	adrp	x10, l_.str0@PAGE
	sub	x8, x29, #16
	mov	x9, #17179869188
Lloh1:
	add	x10, x10, l_.str0@PAGEOFF
	sub	x0, x29, #80
	sub	x1, x29, #16
	sub	x2, x29, #64
	stp	x9, x10, [x8]
Lloh2:
	adrp	x10, l_.str1@PAGE
Lloh3:
	add	x10, x10, l_.str1@PAGEOFF
	mov	x9, #5
	movk	x9, #5, lsl #32
	stp	x10, x8, [x29, #-32]
	sub	x8, x29, #40
	stp	x8, x9, [x29, #-48]
Lloh4:
	adrp	x8, l_.str2@PAGE
	mov	x9, #4294967297
Lloh5:
	add	x8, x8, l_.str2@PAGEOFF
	stp	x9, x8, [x29, #-64]
	bl	_concat
	ldur	x2, [x29, #-48]
	sub	x0, x29, #96
	sub	x1, x29, #80
	bl	_concat
	sub	x0, x29, #96
	bl	_println
Lloh6:
	adrp	x9, l_.str3@PAGE
	mov	x8, #8589934594
	ldur	x1, [x29, #-48]
Lloh7:
	add	x9, x9, l_.str3@PAGEOFF
	sub	x0, x29, #128
	sub	x2, x29, #112
	stp	x8, x9, [x29, #-112]
	bl	_concat
	ldur	x2, [x29, #-24]
	sub	x0, x29, #144
	sub	x1, x29, #128
	bl	_concat
	sub	x0, x29, #144
	bl	_println
	mov	w8, #7
	cmp	w8, #7
	stur	w8, [x29, #-148]
	b.gt	LBB3_2
; %bb.1:                                ; %if.then0
Lloh8:
	adrp	x8, l_.str4@PAGE
	mov	x10, sp
Lloh9:
	add	x8, x8, l_.str4@PAGEOFF
	sub	x0, x10, #16
	mov	sp, x0
	mov	w9, #16
	b	LBB3_3
LBB3_2:                                 ; %if.else0
Lloh10:
	adrp	x8, l_.str5@PAGE
	mov	x10, sp
Lloh11:
	add	x8, x8, l_.str5@PAGEOFF
	sub	x0, x10, #16
	mov	sp, x0
	mov	w9, #20
LBB3_3:                                 ; %if.end0
	stur	w9, [x10, #-16]
	str	w9, [x0, #4]
	str	x8, [x0, #8]
	bl	_println
	mov	x8, sp
	sub	x9, x8, #16
	mov	sp, x9
	mov	w9, #19
	cmp	w9, #13
	stur	w9, [x8, #-16]
	b.lt	LBB3_5
; %bb.4:                                ; %if.then1
	mov	x9, sp
Lloh12:
	adrp	x8, l_.str6@PAGE
	sub	x0, x9, #16
Lloh13:
	add	x8, x8, l_.str6@PAGEOFF
	mov	sp, x0
	mov	x10, #30064771079
	stp	x10, x8, [x9, #-16]
	bl	_println
LBB3_5:                                 ; %if.end1
	mov	sp, x29
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh6, Lloh7
	.loh AdrpAdd	Lloh4, Lloh5
	.loh AdrpAdd	Lloh2, Lloh3
	.loh AdrpAdd	Lloh0, Lloh1
	.loh AdrpAdd	Lloh8, Lloh9
	.loh AdrpAdd	Lloh10, Lloh11
	.loh AdrpAdd	Lloh12, Lloh13
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__literal4,4byte_literals
l_.str0:                                ; @.str0
	.ascii	"John"

	.section	__TEXT,__const
l_.str1:                                ; @.str1
	.ascii	"Smith"

l_.str2:                                ; @.str2
	.byte	32

l_.str3:                                ; @.str3
	.ascii	", "

	.section	__TEXT,__literal16,16byte_literals
l_.str4:                                ; @.str4
	.ascii	"x is less than 8"

	.section	__TEXT,__const
l_.str5:                                ; @.str5
	.ascii	"x is not less than 8"

l_.str6:                                ; @.str6
	.ascii	"No else"

.subsections_via_symbols

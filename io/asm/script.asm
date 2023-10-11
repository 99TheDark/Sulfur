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
	.globl	_int_string                     ; -- Begin function int_string
	.p2align	2
_int_string:                            ; @int_string
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #80
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 80
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	str	w0, [sp, #28]
	mov	w0, #10
	mov	w19, #10
	bl	_malloc
	mov	w8, #9
	ldr	w9, [sp, #28]
	str	x0, [sp, #16]
	stp	wzr, w8, [sp, #8]
	tbz	w9, #31, LBB3_2
; %bb.1:                                ; %if.then
	ldr	w8, [sp, #28]
	mov	w9, #1
	neg	w8, w8
	str	w9, [sp, #8]
	str	w8, [sp, #28]
LBB3_2:                                 ; %while.cond.preheader
	mov	w8, #26215
	movk	w8, #26214, lsl #16
	ldr	w9, [sp, #28]
	cmp	w9, #1
	b.lt	LBB3_4
LBB3_3:                                 ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	ldrsw	x9, [sp, #28]
	ldr	x12, [sp, #16]
	mul	x10, x9, x8
	lsr	x11, x10, #63
	asr	x10, x10, #34
	add	w10, w10, w11
	ldrsw	x11, [sp, #12]
	msub	w9, w10, w19, w9
	sub	w13, w11, #1
	str	w10, [sp, #28]
	add	w9, w9, #48
	strb	w9, [x12, x11]
	str	w13, [sp, #12]
	mov	w9, w10
	cmp	w9, #1
	b.ge	LBB3_3
LBB3_4:                                 ; %while.end
	ldp	w9, w8, [sp, #8]
	sub	w8, w9, w8
	add	w8, w8, #9
	sxtw	x0, w8
	str	w8, [sp, #4]
	stp	w8, w8, [sp, #32]
	bl	_malloc
	ldr	w8, [sp, #8]
	str	x0, [sp, #40]
	cbz	w8, LBB3_6
; %bb.5:                                ; %if.then7
	ldr	x8, [sp, #40]
	mov	w9, #45
	strb	w9, [x8]
	b	LBB3_7
LBB3_6:                                 ; %if.else
	ldr	w8, [sp, #12]
	add	w8, w8, #1
	str	w8, [sp, #12]
LBB3_7:                                 ; %if.end10
	ldr	w8, [sp, #8]
	str	w8, [sp]
	ldp	w8, w9, [sp]
	ldr	x0, [sp, #16]
	cmp	w8, w9
	b.ge	LBB3_9
LBB3_8:                                 ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	ldrsw	x8, [sp, #12]
	ldrsw	x9, [sp]
	ldr	x10, [sp, #40]
	add	x8, x8, x9
	add	w11, w9, #1
	ldrb	w8, [x0, x8]
	str	w11, [sp]
	strb	w8, [x10, x9]
	ldp	w8, w9, [sp]
	ldr	x0, [sp, #16]
	cmp	w8, w9
	b.lt	LBB3_8
LBB3_9:                                 ; %for.end
	bl	_free
	ldp	x0, x1, [sp, #32]
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 48
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w0, #57702
	str	wzr, [sp, #28]
	movk	w0, #3, lsl #16
	bl	_int_string
	stp	x0, x1, [sp, #8]
	add	x0, sp, #8
	bl	_println
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	mov	w0, wzr
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols

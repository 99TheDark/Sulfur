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
LBB0_1:                                 ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #8]
	ldr	w9, [x19, #4]
	cmp	w8, w9
	b.ge	LBB0_3
; %bb.2:                                ; %for.body
                                        ;   in Loop: Header=BB0_1 Depth=1
	ldrsw	x8, [sp, #8]
	ldr	x9, [x19, #8]
	ldrb	w0, [x9, x8]
	bl	_putchar
	ldr	w8, [sp, #8]
	add	w8, w8, #1
	str	w8, [sp, #8]
	b	LBB0_1
LBB0_3:                                 ; %for.end
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
Lloh0:
	adrp	x9, l_.str0@PAGE
	mov	x8, #25769803782
Lloh1:
	add	x9, x9, l_.str0@PAGEOFF
	add	x0, sp, #16
	stp	x8, x9, [sp, #16]
	bl	_println
	mov	x8, #5
Lloh2:
	adrp	x9, l_.str1@PAGE
	movk	x8, #5, lsl #32
Lloh3:
	add	x9, x9, l_.str1@PAGEOFF
	mov	x0, sp
	stp	x8, x9, [sp]
	bl	_println
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.loh AdrpAdd	Lloh2, Lloh3
	.loh AdrpAdd	Lloh0, Lloh1
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__const
l_.str0:                                ; @.str0
	.ascii	"Hello "

l_.str1:                                ; @.str1
	.ascii	"world"

.subsections_via_symbols

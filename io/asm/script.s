	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
	.globl	_print                          ; -- Begin function print
	.p2align	2
_print:                                 ; @print
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 48
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stp	xzr, x0, [sp, #8]
	str	x1, [sp, #24]
LBB0_1:                                 ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	ldp	x8, x9, [sp, #8]
	cmp	x8, x9
	b.ge	LBB0_3
; %bb.2:                                ; %for.body
                                        ;   in Loop: Header=BB0_1 Depth=1
	ldr	x8, [sp, #8]
	ldr	x9, [sp, #24]
	ldrsb	w0, [x9, x8]
	bl	_putchar
	ldr	x8, [sp, #8]
	add	x8, x8, #1
	str	x8, [sp, #8]
	b	LBB0_1
LBB0_3:                                 ; %for.end
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
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
Lloh0:
	adrp	x1, l_.str@PAGE
	mov	w8, #13
Lloh1:
	add	x1, x1, l_.str@PAGEOFF
	mov	w0, #13
	stp	x8, x1, [sp]
	bl	_print
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.loh AdrpAdd	Lloh0, Lloh1
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__const
l_.str:                                 ; @.str
	.ascii	"Hello, world!"

.subsections_via_symbols

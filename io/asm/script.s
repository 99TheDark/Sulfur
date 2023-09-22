	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
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
	adrp	x9, l_.str@PAGE
	mov	w8, #13
Lloh1:
	add	x9, x9, l_.str@PAGEOFF
	stp	x8, x9, [sp]
	bl	_print
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.loh AdrpAdd	Lloh0, Lloh1
	.cfi_endproc
                                        ; -- End function
	.globl	_print                          ; -- Begin function print
	.p2align	2
_print:                                 ; @print
	.cfi_startproc
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w0, #72
	bl	_putchar
	mov	w0, #101
	bl	_putchar
	mov	w0, #108
	bl	_putchar
	mov	w0, #108
	bl	_putchar
	mov	w0, #111
	bl	_putchar
	mov	w0, #32
	bl	_putchar
	mov	w0, #119
	bl	_putchar
	mov	w0, #111
	bl	_putchar
	mov	w0, #114
	bl	_putchar
	mov	w0, #108
	bl	_putchar
	mov	w0, #100
	bl	_putchar
	mov	w0, #33
	bl	_putchar
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__const
l_.str:                                 ; @.str
	.ascii	"Hello, world!"

.subsections_via_symbols

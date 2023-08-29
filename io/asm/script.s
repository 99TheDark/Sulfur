	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
Lloh0:
	adrp	x9, l_.str@PAGE
	mov	w8, #13
Lloh1:
	add	x9, x9, l_.str@PAGEOFF
	stp	x8, x9, [sp], #16
	ret
	.loh AdrpAdd	Lloh0, Lloh1
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__const
l_.str:                                 ; @.str
	.ascii	"Hello, world!"

.subsections_via_symbols

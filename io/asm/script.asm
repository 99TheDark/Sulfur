	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__const
l_.str0:                                ; @.str0
	.ascii	"Hello, world!"

	.section	__TEXT,__literal4,4byte_literals
l_.str1:                                ; @.str1
	.ascii	"John"

	.section	__TEXT,__const
l_.str2:                                ; @.str2
	.ascii	"Smith"

.subsections_via_symbols

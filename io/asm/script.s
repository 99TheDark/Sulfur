	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:                                ; %entry
	ret
	.cfi_endproc
                                        ; -- End function
	.section	__DATA,__data
	.globl	"_John "                        ; @"John "
"_John ":
	.ascii	"John "

.subsections_via_symbols

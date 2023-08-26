	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	mov	w9, #28490
	mov	w8, #32
	movk	w9, #28264, lsl #16
	mov	w10, #28484
	mov	w11, #101
	strb	w8, [sp, #15]
	stur	w9, [sp, #11]
	strh	w10, [sp, #8]
	strb	w11, [sp, #10]
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols

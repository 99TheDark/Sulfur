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
	mov	x8, #15
Lloh0:
	adrp	x9, l_.str@PAGE
	movk	x8, #16, lsl #32
Lloh1:
	add	x9, x9, l_.str@PAGEOFF
	mov	x0, sp
	stp	x8, x9, [sp]
	bl	_print
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.loh AdrpAdd	Lloh0, Lloh1
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__literal16,16byte_literals
l_.str:                                 ; @.str
	.ascii	"Hello, world! \316\265"

.subsections_via_symbols

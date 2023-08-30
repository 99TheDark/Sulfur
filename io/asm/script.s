	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
	.globl	_println                        ; -- Begin function println
	.p2align	2
_println:                               ; @println
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #64
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
Lloh0:
	adrp	x19, l_.char@PAGE
	str	wzr, [sp, #12]
Lloh1:
	add	x19, x19, l_.char@PAGEOFF
	stp	x0, x1, [sp, #16]
LBB0_1:                                 ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	ldrsw	x8, [sp, #12]
	ldr	x9, [sp, #16]
	cmp	x8, x9
	b.ge	LBB0_3
; %bb.2:                                ; %for.body
                                        ;   in Loop: Header=BB0_1 Depth=1
	ldrsw	x8, [sp, #12]
	mov	x0, x19
	ldr	x9, [sp, #24]
	ldrsb	x8, [x9, x8]
	str	x8, [sp]
	bl	_printf
	ldr	w8, [sp, #12]
	add	w8, w8, #1
	str	w8, [sp, #12]
	b	LBB0_1
LBB0_3:                                 ; %for.end
Lloh2:
	adrp	x0, l_.char@PAGE
	mov	w8, #10
Lloh3:
	add	x0, x0, l_.char@PAGEOFF
	str	x8, [sp]
	bl	_printf
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.loh AdrpAdd	Lloh0, Lloh1
	.loh AdrpAdd	Lloh2, Lloh3
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:                                ; %entry
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
Lloh4:
	adrp	x9, l_.str@PAGE
	mov	w8, #13
Lloh5:
	add	x9, x9, l_.str@PAGEOFF
	stp	x8, x9, [sp], #16
	ret
	.loh AdrpAdd	Lloh4, Lloh5
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__const
l_.str:                                 ; @.str
	.ascii	"Hello, world!"

	.section	__TEXT,__cstring,cstring_literals
l_.char:                                ; @.char
	.asciz	"%c"

.subsections_via_symbols

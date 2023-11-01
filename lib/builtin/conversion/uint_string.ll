source_filename = "lib/builtin/conversion/uint_string.ll"

%type.string = type { i32, i32* }

declare i8* @malloc(i32)
declare void @free(i8*)

@.strZero = private unnamed_addr constant [1 x i32] [i32 48], align 4

; define %type.string @".conv:uint_string"(i32 %int) {
; }
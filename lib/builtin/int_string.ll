source_filename = "lib/builtin/int_string"

%type.string = type { i32, i32, i8* }

declare i8* @malloc(i32)
declare void @free(i8*)

define void @int_string(%type.string* %ret, i32 %num) {
entry:
    ret void
}
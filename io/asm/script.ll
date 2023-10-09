source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [13 x i8] c"Hello, world!", align 1
@.str1 = private unnamed_addr constant [4 x i8] c"John", align 1
@.str2 = private unnamed_addr constant [5 x i8] c"Smith", align 1

define void @main() {
entry:
	%x = alloca i32
	%y = alloca i1
	%greeting = alloca %type.string
	%firstName = alloca %type.string
	%lastName = alloca %type.string
	ret void
}

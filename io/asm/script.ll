source_filename = "script.sulfur"

%type.string = type { i64, i8* }

@_string442929748 = global [1 x i8] c"\0A", align 1
@_string191697822 = global [13 x i8] c"Hello, world!", align 1

define void @main() {
entry:
	%0 = call i32 @println([13 x i8]* @_string191697822)
	ret void
}

define i32 @print() {
entry:
	ret void
}

define i32 @println(i32 %str) {
entry:
	%0 = call i32 @print(i32 %str)
	%1 = call i32 @print([1 x i8]* @_string442929748)
	ret void
}

%type.string = type { i64, i8* }

@_string648880846 = global [13 x i8] c"Hello, world!", align 1

define void @main() {
entry:
	%greeting = alloca %type.string, align 8
	%0 = getelementptr inbounds %type.string, %type.string* %greeting, i32 0, i32 0
	store i64 13, i64* %0, align 8
	%1 = getelementptr inbounds %type.string, %type.string* %greeting, i32 0, i32 1
	%2 = getelementptr inbounds [13 x i8]*, [13 x i8]* @_string648880846, i32 0
	ret void
}

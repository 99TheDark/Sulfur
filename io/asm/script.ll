source_filename = "script.sulfur"

%type.string = type { i64, i8* }

@.str = private unnamed_addr constant [13 x i8] c"Hello, world!", align 1

define void @main() {
entry:
	%0 = getelementptr inbounds [13 x i8], [13 x i8]* @.str, i32 0, i32 0
	%greeting = alloca %type.string, align 8
	%1 = getelementptr inbounds %type.string, %type.string* %greeting, i32 0, i32 0
	store i64 13, i64* %1, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %greeting, i32 0, i32 1
	store i8* %0, i8** %2, align 8
	ret void
}

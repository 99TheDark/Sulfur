%struct.String = type { i64, i8* }

@.str = private unnamed_addr constant [13 x i8] c"Hello, world!", align 1

define void @main() {
entry:
	%greeting = alloca %struct.String, align 8
	%0 = getelementptr inbounds %struct.String, %struct.String* %greeting, i32 0, i32 0
	store i64 13, i64* %0, align 8
	%1 = getelementptr inbounds %struct.String, %struct.String* %greeting, i32 0, i32 1
	%2 = getelementptr inbounds [13 x i8], [13 x i8]* @.str, i32 0, i32 0
	store i8* %2, i8** %1, align 8
	ret void
}

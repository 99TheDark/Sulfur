source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [6 x i8] c"Hello ", align 1
@.str1 = private unnamed_addr constant [5 x i8] c"world", align 1

declare void @print(%type.string*)
declare void @println(%type.string*)
declare void @concat(%type.string*, %type.string*, %type.string*)

define void @main() {
entry:
	; "Hello "
	%0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str0, i32 0, i32 0 
	%1 = alloca %type.string, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
	store i32 6, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
	store i32 6, i32* %3, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 2
	store i8* %0, i8** %4, align 8

	; "world"
	%5 = getelementptr inbounds [5 x i8], [5 x i8]* @.str1, i32 0, i32 0
	%6 = alloca %type.string, align 8
	%7 = getelementptr inbounds %type.string, %type.string* %6, i32 0, i32 0
	store i32 5, i32* %7, align 8
	%8 = getelementptr inbounds %type.string, %type.string* %6, i32 0, i32 1
	store i32 5, i32* %8, align 8
	%9 = getelementptr inbounds %type.string, %type.string* %6, i32 0, i32 2
	store i8* %5, i8** %9, align 8

	; concat("Hello ", "world")
	%10 = alloca %type.string, align 8
	call void @concat(%type.string* %10, %type.string* %1, %type.string* %6)

	; println
	call void @println(%type.string* %10)
	ret void
}

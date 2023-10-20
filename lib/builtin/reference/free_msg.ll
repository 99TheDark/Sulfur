source_filename = "lib/builtin/reference/int_ref"

%type.string = type { i32, i32, i8* }

@.strFree = private unnamed_addr constant [6 x i8] c"Freed ", align 1

declare void @.println(%type.string %0)
declare %type.string @".add:string_string"(%type.string, %type.string)
declare %type.string @".conv:int_string"(i32)

define void @freeMsg(i8* %ptr) {
entry:
	%0 = bitcast i8* %ptr to i32*
	%1 = load i32, i32* %0
	%2 = getelementptr inbounds [6 x i8], [6 x i8]* @.strFree, i32 0, i32 0
	%3 = alloca %type.string, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 0
	store i32 6, i32* %4, align 8
	%5 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 1
	store i32 6, i32* %5, align 8
	%6 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 2
	store i8* %2, i8** %6, align 8
	%7 = load %type.string, %type.string* %3, align 8
	%8 = call %type.string @".conv:int_string"(i32 %1)
	%9 = call %type.string @".add:string_string"(%type.string %7, %type.string %8)
	call void @.println(%type.string %9)
	br label %exit

exit:
	ret void
}
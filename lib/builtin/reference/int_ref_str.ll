source_filename = "temp"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [9 x i8] c" now has ", align 1
@.str1 = private unnamed_addr constant [11 x i8] c" references", align 1

declare void @.println(%type.string)
declare %type.string @".add:string_string"(%type.string, %type.string)
declare %type.string @".conv:int_string"(i32)

define void @.refMsg(i32 %0, i32 %1) {
entry:
	%2 = call %type.string @".conv:int_string"(i32 %0)
	%3 = getelementptr inbounds [9 x i8], [9 x i8]* @.str0, i32 0, i32 0
	%4 = alloca %type.string, align 8
	%5 = getelementptr inbounds %type.string, %type.string* %4, i32 0, i32 0
	store i32 9, i32* %5, align 8
	%6 = getelementptr inbounds %type.string, %type.string* %4, i32 0, i32 1
	store i32 9, i32* %6, align 8
	%7 = getelementptr inbounds %type.string, %type.string* %4, i32 0, i32 2
	store i8* %3, i8** %7, align 8
	%8 = load %type.string, %type.string* %4, align 8
	%9 = call %type.string @".add:string_string"(%type.string %2, %type.string %8)
	%10 = call %type.string @".conv:int_string"(i32 %1)
	%11 = call %type.string @".add:string_string"(%type.string %9, %type.string %10)
	%12 = getelementptr inbounds [11 x i8], [11 x i8]* @.str1, i32 0, i32 0
	%13 = alloca %type.string, align 8
	%14 = getelementptr inbounds %type.string, %type.string* %13, i32 0, i32 0
	store i32 11, i32* %14, align 8
	%15 = getelementptr inbounds %type.string, %type.string* %13, i32 0, i32 1
	store i32 11, i32* %15, align 8
	%16 = getelementptr inbounds %type.string, %type.string* %13, i32 0, i32 2
	store i8* %12, i8** %16, align 8
	%17 = load %type.string, %type.string* %13, align 8
	%18 = call %type.string @".add:string_string"(%type.string %11, %type.string %17)
	call void @.println(%type.string %18)
	br label %exit

exit:
	ret void
}
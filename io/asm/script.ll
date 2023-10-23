; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [7 x i8] c"Hello x", align 1
@.str1 = private unnamed_addr constant [7 x i8] c"Hello, ", align 1
@.str2 = private unnamed_addr constant [6 x i8] c"world!", align 1

define void @main() {
entry:
	%0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str0, i32 0, i32 0
	%1 = alloca %type.string, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
	store i32 7, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
	store i32 7, i32* %3, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 2
	store i8* %0, i8** %4, align 8
	%5 = load %type.string, %type.string* %1, align 8
	%x = alloca %type.string
	store %type.string %5, %type.string* %x
	%6 = load %type.string, %type.string* %x, align 16
	%7 = call %type.string @".conv:int_string"(i32 5)
	%8 = call %type.string @".add:string_string"(%type.string %6, %type.string %7)
	store %type.string %8, %type.string* %x
	%9 = load %type.string, %type.string* %x, align 16
	call void @.println(%type.string %9)
	%10 = getelementptr inbounds [7 x i8], [7 x i8]* @.str1, i32 0, i32 0
	%11 = alloca %type.string, align 8
	%12 = getelementptr inbounds %type.string, %type.string* %11, i32 0, i32 0
	store i32 7, i32* %12, align 8
	%13 = getelementptr inbounds %type.string, %type.string* %11, i32 0, i32 1
	store i32 7, i32* %13, align 8
	%14 = getelementptr inbounds %type.string, %type.string* %11, i32 0, i32 2
	store i8* %10, i8** %14, align 8
	%15 = load %type.string, %type.string* %11, align 8
	%y = alloca %type.string
	store %type.string %15, %type.string* %y
	%16 = load %type.string, %type.string* %y, align 16
	%17 = getelementptr inbounds [6 x i8], [6 x i8]* @.str2, i32 0, i32 0
	%18 = alloca %type.string, align 8
	%19 = getelementptr inbounds %type.string, %type.string* %18, i32 0, i32 0
	store i32 6, i32* %19, align 8
	%20 = getelementptr inbounds %type.string, %type.string* %18, i32 0, i32 1
	store i32 6, i32* %20, align 8
	%21 = getelementptr inbounds %type.string, %type.string* %18, i32 0, i32 2
	store i8* %17, i8** %21, align 8
	%22 = load %type.string, %type.string* %18, align 8
	%23 = call %type.string @".add:string_string"(%type.string %16, %type.string %22)
	store %type.string %23, %type.string* %y
	%24 = load %type.string, %type.string* %y, align 16
	call void @.println(%type.string %24)
	br label %exit

exit:
	ret void
}

declare void @.println(%type.string %0)

declare %type.string @".add:string_string"(%type.string %0, %type.string %1)

declare %type.string @".conv:int_string"(i32 %0)

; ModuleID = 'script.su'
source_filename = "script.su"

%type.utf8_string = type { i32, i32* }

@.str0 = private unnamed_addr constant [7 x i32] [i32 72, i32 101, i32 108, i32 108, i32 111, i32 44, i32 32], align 4
@.str1 = private unnamed_addr constant [6 x i32] [i32 119, i32 111, i32 114, i32 108, i32 100, i32 33], align 4
@.str2 = private unnamed_addr constant [3 x i32] [i32 32, i32 40, i32 120], align 4
@.str3 = private unnamed_addr constant [1 x i32] [i32 41], align 4

define void @main() {
entry:
	%0 = getelementptr inbounds [7 x i32], [7 x i32]* @.str0, i32 0, i32 0
	%1 = alloca %type.utf8_string, align 8
	%2 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %1, i32 0, i32 0
	store i32 7, i32* %2, align 8
	%3 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %1, i32 0, i32 1
	store i32* %0, i32** %3, align 8
	%4 = load %type.utf8_string, %type.utf8_string* %1, align 8
	%5 = getelementptr inbounds [6 x i32], [6 x i32]* @.str1, i32 0, i32 0
	%6 = alloca %type.utf8_string, align 8
	%7 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %6, i32 0, i32 0
	store i32 6, i32* %7, align 8
	%8 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %6, i32 0, i32 1
	store i32* %5, i32** %8, align 8
	%9 = load %type.utf8_string, %type.utf8_string* %6, align 8
	%10 = call %type.utf8_string @".add:string_string"(%type.utf8_string %4, %type.utf8_string %9)
	%11 = getelementptr inbounds [3 x i32], [3 x i32]* @.str2, i32 0, i32 0
	%12 = alloca %type.utf8_string, align 8
	%13 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %12, i32 0, i32 0
	store i32 3, i32* %13, align 8
	%14 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %12, i32 0, i32 1
	store i32* %11, i32** %14, align 8
	%15 = load %type.utf8_string, %type.utf8_string* %12, align 8
	%16 = call %type.utf8_string @".add:string_string"(%type.utf8_string %10, %type.utf8_string %15)
	%17 = call %type.utf8_string @".conv:int_string"(i32 10)
	%18 = call %type.utf8_string @".add:string_string"(%type.utf8_string %16, %type.utf8_string %17)
	%19 = getelementptr inbounds [1 x i32], [1 x i32]* @.str3, i32 0, i32 0
	%20 = alloca %type.utf8_string, align 8
	%21 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %20, i32 0, i32 0
	store i32 1, i32* %21, align 8
	%22 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %20, i32 0, i32 1
	store i32* %19, i32** %22, align 8
	%23 = load %type.utf8_string, %type.utf8_string* %20, align 8
	%24 = call %type.utf8_string @".add:string_string"(%type.utf8_string %18, %type.utf8_string %23)
	call void @.println(%type.utf8_string %24)
	br label %exit

exit:
	ret void
}

declare void @.println(%type.utf8_string %0)

declare %type.utf8_string @".add:string_string"(%type.utf8_string %0, %type.utf8_string %1)

declare %type.utf8_string @".conv:int_string"(i32 %0)

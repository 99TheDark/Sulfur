; ModuleID = 'script.su'
source_filename = "script.su"

%type.utf8_string = type { i32, i32* }
%ref.int = type { i32*, i32 }

@.str0 = private unnamed_addr constant [3 x i32] [i32 32, i32 40, i32 120], align 4
@.str1 = private unnamed_addr constant [1 x i32] [i32 41], align 4
@.str2 = private unnamed_addr constant [7 x i32] [i32 72, i32 101, i32 108, i32 108, i32 111, i32 44, i32 32], align 4
@.str3 = private unnamed_addr constant [6 x i32] [i32 119, i32 111, i32 114, i32 108, i32 100, i32 33], align 4

define void @main() {
entry:
	%x = alloca %ref.int*, align 8
	%str = alloca %type.utf8_string, align 8
	%0 = call %ref.int* @"newref:int"(i32 7)
	store %ref.int* %0, %ref.int** %x, align 8
	%1 = getelementptr inbounds [7 x i32], [7 x i32]* @.str2, i32 0, i32 0
	%2 = alloca %type.utf8_string, align 8
	%3 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %2, i32 0, i32 0
	store i32 7, i32* %3, align 8
	%4 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %2, i32 0, i32 1
	store i32* %1, i32** %4, align 8
	%5 = load %type.utf8_string, %type.utf8_string* %2, align 8
	%6 = getelementptr inbounds [6 x i32], [6 x i32]* @.str3, i32 0, i32 0
	%7 = alloca %type.utf8_string, align 8
	%8 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %7, i32 0, i32 0
	store i32 6, i32* %8, align 8
	%9 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %7, i32 0, i32 1
	store i32* %6, i32** %9, align 8
	%10 = load %type.utf8_string, %type.utf8_string* %7, align 8
	%11 = call %type.utf8_string @".add:string_string"(%type.utf8_string %5, %type.utf8_string %10)
	store %type.utf8_string %11, %type.utf8_string* %str
	%12 = load %ref.int*, %ref.int** %x, align 8
	call void @"ref:int"(%ref.int* %12)
	%13 = load %type.utf8_string, %type.utf8_string* %str, align 8
	call void @mod.something(%ref.int* %12, %type.utf8_string %13)
	%14 = load %ref.int*, %ref.int** %x, align 8
	call void @"deref:int"(%ref.int* %14)
	br label %exit

exit:
	ret void
}

declare %ref.int* @"newref:int"(i32 %0)

declare void @"ref:int"(%ref.int* %0)

declare void @"deref:int"(%ref.int* %0)

define private void @mod.something(%ref.int* %0, %type.utf8_string %1) {
entry:
	%msg = alloca %type.utf8_string, align 8
	%msg.1 = alloca i32, align 4
	%2 = getelementptr inbounds [3 x i32], [3 x i32]* @.str0, i32 0, i32 0
	%3 = alloca %type.utf8_string, align 8
	%4 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %3, i32 0, i32 0
	store i32 3, i32* %4, align 8
	%5 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %3, i32 0, i32 1
	store i32* %2, i32** %5, align 8
	%6 = load %type.utf8_string, %type.utf8_string* %3, align 8
	%7 = call %type.utf8_string @".add:string_string"(%type.utf8_string %1, %type.utf8_string %6)
	%8 = getelementptr inbounds %ref.int, %ref.int* %0, i32 0, i32 0
	%9 = load i32*, i32** %8, align 8
	%10 = load i32, i32* %9, align 4
	%11 = call %type.utf8_string @".conv:int_string"(i32 %10)
	%12 = call %type.utf8_string @".add:string_string"(%type.utf8_string %7, %type.utf8_string %11)
	%13 = getelementptr inbounds [1 x i32], [1 x i32]* @.str1, i32 0, i32 0
	%14 = alloca %type.utf8_string, align 8
	%15 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %14, i32 0, i32 0
	store i32 1, i32* %15, align 8
	%16 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %14, i32 0, i32 1
	store i32* %13, i32** %16, align 8
	%17 = load %type.utf8_string, %type.utf8_string* %14, align 8
	%18 = call %type.utf8_string @".add:string_string"(%type.utf8_string %12, %type.utf8_string %17)
	store %type.utf8_string %18, %type.utf8_string* %msg
	br i1 true, label %if.then0, label %if.end0

exit:
	ret void

if.then0:
	store i32 2160, i32* %msg.1
	%19 = load i32, i32* %msg.1, align 4
	%20 = call %type.utf8_string @".conv:int_string"(i32 %19)
	call void @.println(%type.utf8_string %20)
	br label %if.end0

if.end0:
	%21 = load %type.utf8_string, %type.utf8_string* %msg, align 8
	call void @.println(%type.utf8_string %21)
	br label %exit
}

declare void @.println(%type.utf8_string %0)

declare %type.utf8_string @".add:string_string"(%type.utf8_string %0, %type.utf8_string %1)

declare %type.utf8_string @".conv:int_string"(i32 %0)

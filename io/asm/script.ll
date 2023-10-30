; ModuleID = 'script.su'
source_filename = "script.su"

%type.utf8_string = type { i32, i32* }
%ref.int = type { i32*, i32 }

@.str0 = private unnamed_addr constant [7 x i32] [i32 72, i32 101, i32 108, i32 108, i32 111, i32 44, i32 32], align 4
@.str1 = private unnamed_addr constant [6 x i32] [i32 119, i32 111, i32 114, i32 108, i32 100, i32 33], align 4
@.str2 = private unnamed_addr constant [3 x i32] [i32 32, i32 40, i32 120], align 4
@.str3 = private unnamed_addr constant [1 x i32] [i32 41], align 4

define void @main() {
entry:
	call void @mod.otherthing()
	br label %exit

exit:
	ret void
}

declare %ref.int* @"newref:int"(i32 %0)

declare void @"ref:int"(%ref.int* %0)

declare void @"deref:int"(%ref.int* %0)

define private void @mod.something(%ref.int* %0) {
entry:
	%msg = alloca %type.utf8_string
	%msg.1 = alloca i32
	%1 = getelementptr inbounds [7 x i32], [7 x i32]* @.str0, i32 0, i32 0
	%2 = alloca %type.utf8_string, align 8
	%3 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %2, i32 0, i32 0
	store i32 7, i32* %3, align 8
	%4 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %2, i32 0, i32 1
	store i32* %1, i32** %4, align 8
	%5 = load %type.utf8_string, %type.utf8_string* %2, align 8
	%6 = getelementptr inbounds [6 x i32], [6 x i32]* @.str1, i32 0, i32 0
	%7 = alloca %type.utf8_string, align 8
	%8 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %7, i32 0, i32 0
	store i32 6, i32* %8, align 8
	%9 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %7, i32 0, i32 1
	store i32* %6, i32** %9, align 8
	%10 = load %type.utf8_string, %type.utf8_string* %7, align 8
	%11 = call %type.utf8_string @".add:string_string"(%type.utf8_string %5, %type.utf8_string %10)
	%12 = getelementptr inbounds [3 x i32], [3 x i32]* @.str2, i32 0, i32 0
	%13 = alloca %type.utf8_string, align 8
	%14 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %13, i32 0, i32 0
	store i32 3, i32* %14, align 8
	%15 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %13, i32 0, i32 1
	store i32* %12, i32** %15, align 8
	%16 = load %type.utf8_string, %type.utf8_string* %13, align 8
	%17 = call %type.utf8_string @".add:string_string"(%type.utf8_string %11, %type.utf8_string %16)
	%18 = getelementptr inbounds %ref.int, %ref.int* %0, i32 0, i32 0
	%19 = load i32*, i32** %18, align 8
	%20 = load i32, i32* %19, align 4
	%21 = call %type.utf8_string @".conv:int_string"(i32 %20)
	%22 = call %type.utf8_string @".add:string_string"(%type.utf8_string %17, %type.utf8_string %21)
	%23 = getelementptr inbounds [1 x i32], [1 x i32]* @.str3, i32 0, i32 0
	%24 = alloca %type.utf8_string, align 8
	%25 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %24, i32 0, i32 0
	store i32 1, i32* %25, align 8
	%26 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %24, i32 0, i32 1
	store i32* %23, i32** %26, align 8
	%27 = load %type.utf8_string, %type.utf8_string* %24, align 8
	%28 = call %type.utf8_string @".add:string_string"(%type.utf8_string %22, %type.utf8_string %27)
	store %type.utf8_string %28, %type.utf8_string* %msg
	br i1 true, label %if.then0, label %if.end0

exit:
	ret void

if.then0:
	store i32 2160, i32* %msg.1
	%29 = load i32, i32* %msg.1, align 4
	%30 = call %type.utf8_string @".conv:int_string"(i32 %29)
	call void @.println(%type.utf8_string %30)
	br label %if.end0

if.end0:
	%31 = load %type.utf8_string, %type.utf8_string* %msg, align 8
	call void @.println(%type.utf8_string %31)
	br label %exit
}

define private void @mod.otherthing() {
entry:
	%x = alloca %ref.int*
	%0 = call %ref.int* @"newref:int"(i32 7)
	store %ref.int* %0, %ref.int** %x, align 8
	%1 = load %ref.int*, %ref.int** %x, align 8
	call void @"ref:int"(%ref.int* %1)
	call void @mod.something(%ref.int* %1)
	br label %exit

exit:
	ret void
}

declare void @.println(%type.utf8_string %0)

declare %type.utf8_string @".add:string_string"(%type.utf8_string %0, %type.utf8_string %1)

declare %type.utf8_string @".conv:int_string"(i32 %0)

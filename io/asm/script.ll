; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32* }

@.str0 = private unnamed_addr constant [5 x i32] [i32 72, i32 101, i32 108, i32 108, i32 111], align 4
@.str1 = private unnamed_addr constant [5 x i32] [i32 87, i32 111, i32 114, i32 108, i32 100], align 4
@.str2 = private unnamed_addr constant [5 x i32] [i32 110, i32 111, i32 111, i32 111, i32 33], align 4

define void @main() {
entry:
	%z = alloca %type.string, align 8
	%x = alloca %type.string, align 8
	%y = alloca %type.string, align 8
	%0 = getelementptr inbounds [5 x i32], [5 x i32]* @.str0, i32 0, i32 0
	%1 = alloca %type.string, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
	store i32 5, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
	store i32* %0, i32** %3, align 8
	%4 = load %type.string, %type.string* %1, align 8
	%5 = call %type.string @".copy:string"(%type.string %4)
	store %type.string %5, %type.string* %x
	br i1 true, label %if.then0, label %if.end0

exit:
	ret void

if.then0:
	%6 = getelementptr inbounds [5 x i32], [5 x i32]* @.str1, i32 0, i32 0
	%7 = alloca %type.string, align 8
	%8 = getelementptr inbounds %type.string, %type.string* %7, i32 0, i32 0
	store i32 5, i32* %8, align 8
	%9 = getelementptr inbounds %type.string, %type.string* %7, i32 0, i32 1
	store i32* %6, i32** %9, align 8
	%10 = load %type.string, %type.string* %7, align 8
	%11 = call %type.string @".copy:string"(%type.string %10)
	store %type.string %11, %type.string* %y
	%12 = load %type.string, %type.string* %y, align 8
	store %type.string %12, %type.string* %z
	%13 = load %type.string, %type.string* %y, align 8
	call void @.println(%type.string %13)
	%14 = getelementptr inbounds [5 x i32], [5 x i32]* @.str2, i32 0, i32 0
	%15 = alloca %type.string, align 8
	%16 = getelementptr inbounds %type.string, %type.string* %15, i32 0, i32 0
	store i32 5, i32* %16, align 8
	%17 = getelementptr inbounds %type.string, %type.string* %15, i32 0, i32 1
	store i32* %14, i32** %17, align 8
	%18 = load %type.string, %type.string* %15, align 8
	%19 = call %type.string @".copy:string"(%type.string %18)
	store %type.string %19, %type.string* %y
	%20 = load %type.string, %type.string* %z, align 8
	call void @.println(%type.string %20)
	call void @".free:string"(%type.string %11)
	call void @".free:string"(%type.string %19)
	br label %if.end0

if.end0:
	br label %exit
}

declare void @.println(%type.string %0)

declare %type.string @".copy:string"(%type.string %0)

declare void @".free:string"(%type.string %0)

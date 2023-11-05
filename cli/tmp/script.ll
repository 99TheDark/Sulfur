; ModuleID = 'examples/main/script.su'
source_filename = "examples/main/script.su"

%type.string = type { i32, i32* }
%ref.int = type { i32*, i32 }

@.str0 = private unnamed_addr constant [42 x i32] [i32 84, i32 104, i32 105, i32 115, i32 32, i32 110, i32 117, i32 109, i32 98, i32 101, i32 114, i32 32, i32 105, i32 115, i32 32, i32 100, i32 105, i32 118, i32 105, i32 115, i32 105, i32 98, i32 108, i32 101, i32 32, i32 98, i32 121, i32 32, i32 56, i32 44, i32 32, i32 51, i32 32, i32 97, i32 110, i32 100, i32 32, i32 49, i32 48, i32 55, i32 58, i32 32], align 4

define i32 @main() {
entry:
	%i = alloca i32, align 4
	%x = alloca %ref.int*, align 8
	%y = alloca %ref.int*, align 8
	store i32 1, i32* %i
	br label %loop.body0

exit:
	ret i32 0

loop.body0:
	%0 = load i32, i32* %i, align 4
	%1 = srem i32 %0, 8
	%2 = icmp eq i32 %1, 0
	%3 = load i32, i32* %i, align 4
	%4 = srem i32 %3, 3
	%5 = icmp eq i32 %4, 0
	%6 = and i1 %2, %5
	%7 = load i32, i32* %i, align 4
	%8 = srem i32 %7, 107
	%9 = icmp eq i32 %8, 0
	%10 = and i1 %6, %9
	br i1 %10, label %if.then1, label %if.end1

loop.end0:
	%11 = load i32, i32* %i, align 4
	%12 = call %type.string @".conv:int_string"(i32 %11)
	call void @.println(%type.string %12)
	%13 = call %ref.int* @"newref:int"(i32 42)
	store %ref.int* %13, %ref.int** %x, align 8
	%14 = load %ref.int*, %ref.int** %x, align 8
	call void @"ref:int"(%ref.int* %14)
	store %ref.int* %14, %ref.int** %y, align 8
	%15 = load %ref.int*, %ref.int** %x, align 8
	call void @"deref:int"(%ref.int* %15)
	br label %exit

if.then1:
	%16 = getelementptr inbounds [42 x i32], [42 x i32]* @.str0, i32 0, i32 0
	%17 = alloca %type.string, align 8
	%18 = getelementptr inbounds %type.string, %type.string* %17, i32 0, i32 0
	store i32 42, i32* %18, align 8
	%19 = getelementptr inbounds %type.string, %type.string* %17, i32 0, i32 1
	store i32* %16, i32** %19, align 8
	%20 = load %type.string, %type.string* %17, align 8
	%21 = call %type.string @".copy:string"(%type.string %20)
	call void @.print(%type.string %21)
	call void @".free:string"(%type.string %21)
	br label %loop.end0

if.end1:
	%22 = load i32, i32* %i, align 4
	%23 = add i32 %22, 1
	store i32 %23, i32* %i
	br label %loop.body0
}

declare %ref.int* @"newref:int"(i32 %0)

declare void @"ref:int"(%ref.int* %0)

declare void @"deref:int"(%ref.int* %0)

declare fastcc void @.print(%type.string %0)

declare fastcc void @.println(%type.string %0)

declare %type.string @".conv:int_string"(i32 %0)

declare i32 @llvm.ctlz.i32(i32 %0, i1 immarg %1)

declare i32 @llvm.cttz.i32(i32 %0, i1 immarg %1)

declare %type.string @".copy:string"(%type.string %0)

declare void @".free:string"(%type.string %0)

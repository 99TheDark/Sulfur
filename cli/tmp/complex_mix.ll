; ModuleID = 'examples/complex_mix.su'
source_filename = "examples/complex_mix.su"

%type.string = type { i32, i32* }

@.str0 = private unnamed_addr constant [2 x i32] [i32 44, i32 32], align 4
@.str1 = private unnamed_addr constant [16 x i32] [i32 73, i32 32, i32 100, i32 105, i32 100, i32 32, i32 115, i32 111, i32 109, i32 101, i32 116, i32 104, i32 105, i32 110, i32 103, i32 33], align 4
@.str2 = private unnamed_addr constant [4 x i32] [i32 74, i32 111, i32 104, i32 110], align 4
@.str3 = private unnamed_addr constant [5 x i32] [i32 83, i32 109, i32 105, i32 116, i32 104], align 4

define void @main() {
entry:
	%0 = call i32 @mod.fibonacci(i32 25)
	%1 = call %type.string @".conv:int_string"(i32 %0)
	call void @.println(%type.string %1)
	%2 = getelementptr inbounds [4 x i32], [4 x i32]* @.str2, i32 0, i32 0
	%3 = alloca %type.string, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 0
	store i32 4, i32* %4, align 8
	%5 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 1
	store i32* %2, i32** %5, align 8
	%6 = load %type.string, %type.string* %3, align 8
	%7 = call %type.string @".copy:string"(%type.string %6)
	%8 = getelementptr inbounds [5 x i32], [5 x i32]* @.str3, i32 0, i32 0
	%9 = alloca %type.string, align 8
	%10 = getelementptr inbounds %type.string, %type.string* %9, i32 0, i32 0
	store i32 5, i32* %10, align 8
	%11 = getelementptr inbounds %type.string, %type.string* %9, i32 0, i32 1
	store i32* %8, i32** %11, align 8
	%12 = load %type.string, %type.string* %9, align 8
	%13 = call %type.string @".copy:string"(%type.string %12)
	%14 = call %type.string @mod.formatName(%type.string %7, %type.string %13)
	call void @.println(%type.string %14)
	br label %exit

exit:
	ret void
}

define private %type.string @mod.formatName(%type.string %0, %type.string %1) {
entry:
	%.ret = alloca %type.string
	%2 = getelementptr inbounds [2 x i32], [2 x i32]* @.str0, i32 0, i32 0
	%3 = alloca %type.string, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 0
	store i32 2, i32* %4, align 8
	%5 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 1
	store i32* %2, i32** %5, align 8
	%6 = load %type.string, %type.string* %3, align 8
	%7 = call %type.string @".copy:string"(%type.string %6)
	%8 = call %type.string @".add:string_string"(%type.string %1, %type.string %7)
	%9 = call %type.string @".add:string_string"(%type.string %8, %type.string %0)
	store %type.string %9, %type.string* %.ret, align 8
	br label %exit

exit:
	%10 = load %type.string, %type.string* %.ret
	ret %type.string %10
}

define private i32 @mod.fibonacci(i32 %0) {
entry:
	%.ret = alloca i32
	%1 = icmp sle i32 %0, 1
	br i1 %1, label %if.then0, label %if.else0

exit:
	%2 = load i32, i32* %.ret
	ret i32 %2

if.then0:
	store i32 1, i32* %.ret
	br label %exit

if.else0:
	%3 = sub i32 %0, 2
	%4 = call i32 @mod.fibonacci(i32 %3)
	%5 = sub i32 %0, 1
	%6 = call i32 @mod.fibonacci(i32 %5)
	%7 = add i32 %4, %6
	store i32 %7, i32* %.ret
	br label %exit

if.end0:
	br label %exit
}

declare void @.println(%type.string %0)

declare %type.string @".add:string_string"(%type.string %0, %type.string %1)

declare %type.string @".conv:int_string"(i32 %0)

declare i32 @llvm.ctlz.i32(i32 %0, i1 immarg %1)

declare i32 @llvm.cttz.i32(i32 %0, i1 immarg %1)

declare %type.string @".copy:string"(%type.string %0)

declare void @".free:string"(%type.string %0)

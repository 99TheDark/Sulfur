; ModuleID = 'examples/main/script.su'
source_filename = "examples/main/script.su"

%type.string = type { i32, i32* }

@.str0 = private unnamed_addr constant [2 x i32] [i32 124, i32 32], align 4
@.str1 = private unnamed_addr constant [1 x i32] [i32 32], align 4
@.str2 = private unnamed_addr constant [1 x i32] [i32 124], align 4

define i32 @main() {
entry:
	%j = alloca i32, align 4
	%x = alloca float, align 4
	%i = alloca i32, align 4
	store i32 0, i32* %i
	br label %while.cond0

exit:
	ret i32 0

while.cond0:
	%0 = load i32, i32* %i, align 4
	%1 = icmp slt i32 %0, 10
	br i1 %1, label %while.body0, label %while.end0

while.body0:
	%2 = load i32, i32* %i, align 4
	%3 = add i32 %2, 2
	store i32 %3, i32* %i
	br label %while.cond0

while.end0:
	%4 = getelementptr inbounds [2 x i32], [2 x i32]* @.str0, i32 0, i32 0
	%5 = alloca %type.string, align 8
	%6 = getelementptr inbounds %type.string, %type.string* %5, i32 0, i32 0
	store i32 2, i32* %6, align 8
	%7 = getelementptr inbounds %type.string, %type.string* %5, i32 0, i32 1
	store i32* %4, i32** %7, align 8
	%8 = load %type.string, %type.string* %5, align 8
	%9 = call %type.string @".copy:string"(%type.string %8)
	call void @.print(%type.string %9)
	store i32 0, i32* %j
	br label %for.cond1

for.cond1:
	%10 = load i32, i32* %j, align 4
	%11 = icmp slt i32 %10, 10
	br i1 %11, label %for.body1, label %for.end1

for.body1:
	%12 = load i32, i32* %j, align 4
	%13 = call %type.string @".conv:int_string"(i32 %12)
	%14 = getelementptr inbounds [1 x i32], [1 x i32]* @.str1, i32 0, i32 0
	%15 = alloca %type.string, align 8
	%16 = getelementptr inbounds %type.string, %type.string* %15, i32 0, i32 0
	store i32 1, i32* %16, align 8
	%17 = getelementptr inbounds %type.string, %type.string* %15, i32 0, i32 1
	store i32* %14, i32** %17, align 8
	%18 = load %type.string, %type.string* %15, align 8
	%19 = call %type.string @".copy:string"(%type.string %18)
	%20 = call %type.string @".add:string_string"(%type.string %13, %type.string %19)
	call void @.print(%type.string %20)
	call void @".free:string"(%type.string %19)
	br label %for.inc1

for.inc1:
	%21 = load i32, i32* %j, align 4
	%22 = add i32 %21, 1
	store i32 %22, i32* %j
	br label %for.cond1

for.end1:
	%23 = getelementptr inbounds [1 x i32], [1 x i32]* @.str2, i32 0, i32 0
	%24 = alloca %type.string, align 8
	%25 = getelementptr inbounds %type.string, %type.string* %24, i32 0, i32 0
	store i32 1, i32* %25, align 8
	%26 = getelementptr inbounds %type.string, %type.string* %24, i32 0, i32 1
	store i32* %23, i32** %26, align 8
	%27 = load %type.string, %type.string* %24, align 8
	%28 = call %type.string @".copy:string"(%type.string %27)
	call void @.println(%type.string %28)
	store float 5.0, float* %x
	br label %loop.body2

loop.body2:
	%29 = load float, float* %x, align 4
	%30 = fmul float %29, 0x4010CCCCC0000000
	store float %30, float* %x
	%31 = load i32, i32* %i, align 4
	%32 = srem i32 %31, 7
	%33 = icmp eq i32 %32, 0
	%34 = load i32, i32* %i, align 4
	%35 = srem i32 %34, 10
	%36 = icmp eq i32 %35, 0
	%37 = and i1 %33, %36
	br i1 %37, label %if.then3, label %if.end3

loop.end2:
	%38 = load i32, i32* %i, align 4
	%39 = call %type.string @".conv:int_string"(i32 %38)
	call void @.println(%type.string %39)
	%40 = load float, float* %x, align 4
	%41 = call %type.string @".conv:float_string"(float %40)
	call void @.println(%type.string %41)
	call void @".free:string"(%type.string %9)
	call void @".free:string"(%type.string %28)
	br label %exit

if.then3:
	br label %loop.end2

if.end3:
	%42 = load i32, i32* %i, align 4
	%43 = add i32 %42, 1
	store i32 %43, i32* %i
	br label %loop.body2
}

declare fastcc void @.print(%type.string %0)

declare fastcc void @.println(%type.string %0)

declare fastcc %type.string @".add:string_string"(%type.string %0, %type.string %1)

declare fastcc %type.string @".conv:int_string"(i32 %0)

declare fastcc %type.string @".conv:float_string"(float %0)

declare i32 @llvm.ctlz.i32(i32 %0, i1 immarg %1)

declare i32 @llvm.cttz.i32(i32 %0, i1 immarg %1)

declare %type.string @".copy:string"(%type.string %0)

declare void @".free:string"(%type.string %0)

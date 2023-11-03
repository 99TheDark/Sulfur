; ModuleID = 'examples/drink.su'
source_filename = "examples/drink.su"

%type.string = type { i32, i32* }

@.str0 = private unnamed_addr constant [24 x i32] [i32 73, i32 116, i32 32, i32 105, i32 115, i32 32, i32 108, i32 101, i32 103, i32 97, i32 108, i32 32, i32 116, i32 111, i32 32, i32 100, i32 114, i32 105, i32 110, i32 107, i32 32, i32 97, i32 116, i32 32], align 4
@.str1 = private unnamed_addr constant [10 x i32] [i32 32, i32 121, i32 101, i32 97, i32 114, i32 115, i32 32, i32 111, i32 108, i32 100], align 4
@.str2 = private unnamed_addr constant [26 x i32] [i32 73, i32 116, i32 32, i32 105, i32 115, i32 32, i32 105, i32 108, i32 108, i32 101, i32 103, i32 97, i32 108, i32 32, i32 116, i32 111, i32 32, i32 100, i32 114, i32 105, i32 110, i32 107, i32 32, i32 97, i32 116, i32 32], align 4
@.str4 = private unnamed_addr constant [26 x i32] [i32 46, i32 32, i32 46, i32 32, i32 46, i32 32, i32 46, i32 32, i32 46, i32 32, i32 46, i32 32, i32 46, i32 32, i32 46, i32 32, i32 46, i32 32, i32 46, i32 32, i32 46, i32 32, i32 46, i32 32, i32 46, i32 32], align 4

define void @main() {
entry:
	%age = alloca %type.string, align 8
	%i = alloca i32, align 4
	store i32 15, i32* %i
	br label %for.cond0

exit:
	ret void

for.cond0:
	%0 = load i32, i32* %i, align 4
	%1 = icmp sle i32 %0, 30
	br i1 %1, label %for.body0, label %for.end0

for.body0:
	%2 = load i32, i32* %i, align 4
	%3 = call %type.string @".conv:int_string"(i32 %2)
	store %type.string %3, %type.string* %age
	%4 = load i32, i32* %i, align 4
	%5 = icmp sge i32 %4, 21
	br i1 %5, label %if.then1, label %if.else1

for.inc0:
	%6 = load i32, i32* %i, align 4
	%7 = add i32 %6, 1
	store i32 %7, i32* %i
	br label %for.cond0

for.end0:
	%8 = getelementptr inbounds [26 x i32], [26 x i32]* @.str4, i32 0, i32 0
	%9 = alloca %type.string, align 8
	%10 = getelementptr inbounds %type.string, %type.string* %9, i32 0, i32 0
	store i32 26, i32* %10, align 8
	%11 = getelementptr inbounds %type.string, %type.string* %9, i32 0, i32 1
	store i32* %8, i32** %11, align 8
	%12 = load %type.string, %type.string* %9, align 8
	%13 = call %type.string @".copy:string"(%type.string %12)
	call void @.println(%type.string %13)
	br label %exit

if.then1:
	%14 = getelementptr inbounds [24 x i32], [24 x i32]* @.str0, i32 0, i32 0
	%15 = alloca %type.string, align 8
	%16 = getelementptr inbounds %type.string, %type.string* %15, i32 0, i32 0
	store i32 24, i32* %16, align 8
	%17 = getelementptr inbounds %type.string, %type.string* %15, i32 0, i32 1
	store i32* %14, i32** %17, align 8
	%18 = load %type.string, %type.string* %15, align 8
	%19 = call %type.string @".copy:string"(%type.string %18)
	%20 = load %type.string, %type.string* %age, align 8
	%21 = call %type.string @".add:string_string"(%type.string %19, %type.string %20)
	%22 = getelementptr inbounds [10 x i32], [10 x i32]* @.str1, i32 0, i32 0
	%23 = alloca %type.string, align 8
	%24 = getelementptr inbounds %type.string, %type.string* %23, i32 0, i32 0
	store i32 10, i32* %24, align 8
	%25 = getelementptr inbounds %type.string, %type.string* %23, i32 0, i32 1
	store i32* %22, i32** %25, align 8
	%26 = load %type.string, %type.string* %23, align 8
	%27 = call %type.string @".copy:string"(%type.string %26)
	%28 = call %type.string @".add:string_string"(%type.string %21, %type.string %27)
	call void @.println(%type.string %28)
	call void @".free:string"(%type.string %19)
	call void @".free:string"(%type.string %27)
	br label %if.end1

if.else1:
	%29 = getelementptr inbounds [26 x i32], [26 x i32]* @.str2, i32 0, i32 0
	%30 = alloca %type.string, align 8
	%31 = getelementptr inbounds %type.string, %type.string* %30, i32 0, i32 0
	store i32 26, i32* %31, align 8
	%32 = getelementptr inbounds %type.string, %type.string* %30, i32 0, i32 1
	store i32* %29, i32** %32, align 8
	%33 = load %type.string, %type.string* %30, align 8
	%34 = call %type.string @".copy:string"(%type.string %33)
	%35 = load %type.string, %type.string* %age, align 8
	%36 = call %type.string @".add:string_string"(%type.string %34, %type.string %35)
	%37 = getelementptr inbounds [10 x i32], [10 x i32]* @.str1, i32 0, i32 0
	%38 = alloca %type.string, align 8
	%39 = getelementptr inbounds %type.string, %type.string* %38, i32 0, i32 0
	store i32 10, i32* %39, align 8
	%40 = getelementptr inbounds %type.string, %type.string* %38, i32 0, i32 1
	store i32* %37, i32** %40, align 8
	%41 = load %type.string, %type.string* %38, align 8
	%42 = call %type.string @".copy:string"(%type.string %41)
	%43 = call %type.string @".add:string_string"(%type.string %36, %type.string %42)
	call void @.println(%type.string %43)
	call void @".free:string"(%type.string %42)
	call void @".free:string"(%type.string %34)
	br label %if.end1

if.end1:
	br label %for.inc0
}

declare void @.println(%type.string %0)

declare %type.string @".add:string_string"(%type.string %0, %type.string %1)

declare %type.string @".conv:int_string"(i32 %0)

declare i32 @llvm.ctlz.i32(i32 %0, i1 immarg %1)

declare i32 @llvm.cttz.i32(i32 %0, i1 immarg %1)

declare %type.string @".copy:string"(%type.string %0)

declare void @".free:string"(%type.string %0)

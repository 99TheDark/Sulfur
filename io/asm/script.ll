; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [1 x i8] c" ", align 1
@.str1 = private unnamed_addr constant [0 x i8] c"", align 1

define void @main() {
entry:
	%i = alloca i32
	store i32 0, i32* %i
	br label %while.cond0

exit:
	ret void

while.cond0:
	br i1 true, label %while.body0, label %while.end0

while.body0:
	%0 = load i32, i32* %i
	%1 = icmp sgt i32 %0, 30
	br i1 %1, label %if.then1, label %if.end1

while.end0:
	%2 = getelementptr inbounds [0 x i8], [0 x i8]* @.str1, i32 0, i32 0
	%3 = alloca %type.string, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 0
	store i32 0, i32* %4, align 8
	%5 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 1
	store i32 0, i32* %5, align 8
	%6 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 2
	store i8* %2, i8** %6, align 8
	%7 = load %type.string, %type.string* %3, align 8
	call void @.println(%type.string %7)
	%j = alloca i32
	store i32 0, i32* %j
	br label %while.body3

if.then1:
	br label %while.end0

if.end1:
	%8 = load i32, i32* %i
	%9 = srem i32 %8, 5
	%10 = icmp eq i32 %9, 0
	br i1 %10, label %if.then2, label %if.end2

if.then2:
	%11 = load i32, i32* %i
	%12 = add i32 %11, 1
	store i32 %12, i32* %i
	br label %while.cond0

if.end2:
	%13 = load i32, i32* %i
	%14 = call %type.string @.conv.int_string(i32 %13)
	%15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str0, i32 0, i32 0
	%16 = alloca %type.string, align 8
	%17 = getelementptr inbounds %type.string, %type.string* %16, i32 0, i32 0
	store i32 1, i32* %17, align 8
	%18 = getelementptr inbounds %type.string, %type.string* %16, i32 0, i32 1
	store i32 1, i32* %18, align 8
	%19 = getelementptr inbounds %type.string, %type.string* %16, i32 0, i32 2
	store i8* %15, i8** %19, align 8
	%20 = load %type.string, %type.string* %16, align 8
	%21 = call %type.string @.add.string_string(%type.string %14, %type.string %20)
	call void @.print(%type.string %21)
	%22 = load i32, i32* %i
	%23 = add i32 %22, 1
	store i32 %23, i32* %i
	br label %while.cond0

while.cond3:
	br i1 true, label %while.body3, label %while.end3

while.body3:
	%24 = load i32, i32* %j
	%25 = icmp sgt i32 %24, 30
	br i1 %25, label %if.then4, label %if.end4

while.end3:
	%26 = getelementptr inbounds [0 x i8], [0 x i8]* @.str1, i32 0, i32 0
	%27 = alloca %type.string, align 8
	%28 = getelementptr inbounds %type.string, %type.string* %27, i32 0, i32 0
	store i32 0, i32* %28, align 8
	%29 = getelementptr inbounds %type.string, %type.string* %27, i32 0, i32 1
	store i32 0, i32* %29, align 8
	%30 = getelementptr inbounds %type.string, %type.string* %27, i32 0, i32 2
	store i8* %26, i8** %30, align 8
	%31 = load %type.string, %type.string* %27, align 8
	call void @.println(%type.string %31)
	br label %exit

if.then4:
	br label %while.end3

if.end4:
	%32 = load i32, i32* %j
	%33 = srem i32 %32, 5
	%34 = icmp eq i32 %33, 0
	br i1 %34, label %if.then5, label %if.end5

if.then5:
	%35 = load i32, i32* %j
	%36 = add i32 %35, 1
	store i32 %36, i32* %j
	br label %while.cond3

if.end5:
	%37 = load i32, i32* %j
	%38 = call %type.string @.conv.int_string(i32 %37)
	%39 = getelementptr inbounds [1 x i8], [1 x i8]* @.str0, i32 0, i32 0
	%40 = alloca %type.string, align 8
	%41 = getelementptr inbounds %type.string, %type.string* %40, i32 0, i32 0
	store i32 1, i32* %41, align 8
	%42 = getelementptr inbounds %type.string, %type.string* %40, i32 0, i32 1
	store i32 1, i32* %42, align 8
	%43 = getelementptr inbounds %type.string, %type.string* %40, i32 0, i32 2
	store i8* %39, i8** %43, align 8
	%44 = load %type.string, %type.string* %40, align 8
	%45 = call %type.string @.add.string_string(%type.string %38, %type.string %44)
	call void @.print(%type.string %45)
	%46 = load i32, i32* %j
	%47 = add i32 %46, 1
	store i32 %47, i32* %j
	br label %while.cond3
}

declare void @.print(%type.string %0)

declare void @.println(%type.string %0)

declare %type.string @.add.string_string(%type.string %0, %type.string %1)

declare %type.string @.conv.int_string(i32 %0)

declare %type.string @.conv.bool_string(i1 %0)

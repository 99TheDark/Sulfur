; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [12 x i8] c"\0AExiting at ", align 1
@.str1 = private unnamed_addr constant [1 x i8] c" ", align 1
@.str2 = private unnamed_addr constant [0 x i8] c"", align 1

define void @main() {
entry:
	br i1 true, label %if.then0, label %if.end0

exit:
	ret void

if.then0:
	%i = alloca i32
	store i32 0, i32* %i
	br label %for.cond1

if.end0:
	br label %exit

for.cond1:
	%0 = load i32, i32* %i
	%1 = icmp sle i32 %0, 20
	br i1 %1, label %for.body1, label %for.end1

for.body1:
	%2 = load i32, i32* %i
	%3 = icmp sgt i32 %2, 10
	br i1 %3, label %if.then2, label %if.end2

for.inc1:
	%4 = load i32, i32* %i
	%5 = add i32 %4, 1
	store i32 %5, i32* %i
	br label %for.cond1

for.end1:
	%6 = getelementptr inbounds [0 x i8], [0 x i8]* @.str2, i32 0, i32 0
	%7 = alloca %type.string, align 8
	%8 = getelementptr inbounds %type.string, %type.string* %7, i32 0, i32 0
	store i32 0, i32* %8, align 8
	%9 = getelementptr inbounds %type.string, %type.string* %7, i32 0, i32 1
	store i32 0, i32* %9, align 8
	%10 = getelementptr inbounds %type.string, %type.string* %7, i32 0, i32 2
	store i8* %6, i8** %10, align 8
	%11 = load %type.string, %type.string* %7, align 8
	call void @.println(%type.string %11)
	br label %if.end0

if.then2:
	%12 = getelementptr inbounds [12 x i8], [12 x i8]* @.str0, i32 0, i32 0
	%13 = alloca %type.string, align 8
	%14 = getelementptr inbounds %type.string, %type.string* %13, i32 0, i32 0
	store i32 12, i32* %14, align 8
	%15 = getelementptr inbounds %type.string, %type.string* %13, i32 0, i32 1
	store i32 12, i32* %15, align 8
	%16 = getelementptr inbounds %type.string, %type.string* %13, i32 0, i32 2
	store i8* %12, i8** %16, align 8
	%17 = load %type.string, %type.string* %13, align 8
	%18 = load i32, i32* %i
	%19 = call %type.string @.conv.int_string(i32 %18)
	%20 = call %type.string @.add.string_string(%type.string %17, %type.string %19)
	call void @.print(%type.string %20)
	br label %for.end1

if.end2:
	%21 = load i32, i32* %i
	%22 = call %type.string @.conv.int_string(i32 %21)
	%23 = getelementptr inbounds [1 x i8], [1 x i8]* @.str1, i32 0, i32 0
	%24 = alloca %type.string, align 8
	%25 = getelementptr inbounds %type.string, %type.string* %24, i32 0, i32 0
	store i32 1, i32* %25, align 8
	%26 = getelementptr inbounds %type.string, %type.string* %24, i32 0, i32 1
	store i32 1, i32* %26, align 8
	%27 = getelementptr inbounds %type.string, %type.string* %24, i32 0, i32 2
	store i8* %23, i8** %27, align 8
	%28 = load %type.string, %type.string* %24, align 8
	%29 = call %type.string @.add.string_string(%type.string %22, %type.string %28)
	call void @.print(%type.string %29)
	br label %for.inc1
}

declare void @.print(%type.string %0)

declare void @.println(%type.string %0)

declare %type.string @.add.string_string(%type.string %0, %type.string %1)

declare %type.string @.conv.int_string(i32 %0)

declare %type.string @.conv.bool_string(i1 %0)

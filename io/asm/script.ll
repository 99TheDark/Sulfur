; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [1 x i8] c" ", align 1
@.str1 = private unnamed_addr constant [0 x i8] c"", align 1

define void @main() {
entry:
	%i = alloca i32
	store i32 0, i32* %i
	br label %for.cond0

exit:
	ret void

for.cond0:
	%0 = load i32, i32* %i
	%1 = icmp sle i32 %0, 20
	br i1 %1, label %for.body0, label %for.end0

for.body0:
	%2 = load i32, i32* %i
	%3 = srem i32 %2, 3
	%4 = icmp eq i32 %3, 0
	br i1 %4, label %if.then1, label %if.end1

for.inc0:
	%5 = load i32, i32* %i
	%6 = add i32 %5, 1
	store i32 %6, i32* %i
	br label %for.cond0

for.end0:
	%7 = getelementptr inbounds [0 x i8], [0 x i8]* @.str1, i32 0, i32 0
	%8 = alloca %type.string, align 8
	%9 = getelementptr inbounds %type.string, %type.string* %8, i32 0, i32 0
	store i32 0, i32* %9, align 8
	%10 = getelementptr inbounds %type.string, %type.string* %8, i32 0, i32 1
	store i32 0, i32* %10, align 8
	%11 = getelementptr inbounds %type.string, %type.string* %8, i32 0, i32 2
	store i8* %7, i8** %11, align 8
	%12 = load %type.string, %type.string* %8, align 8
	call void @.println(%type.string %12)
	br label %exit

if.then1:
	br label %for.inc0

if.end1:
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
	br label %for.inc0
}

declare void @.print(%type.string %0)

declare void @.println(%type.string %0)

declare %type.string @.add.string_string(%type.string %0, %type.string %1)

declare %type.string @.conv.int_string(i32 %0)

declare %type.string @.conv.bool_string(i1 %0)

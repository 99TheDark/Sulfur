; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [4 x i8] c"1 1 ", align 1
@.str1 = private unnamed_addr constant [1 x i8] c" ", align 1
@.str2 = private unnamed_addr constant [1 x i8] c"\0A", align 1

define void @main() {
entry:
	%0 = getelementptr inbounds [4 x i8], [4 x i8]* @.str0, i32 0, i32 0
	%1 = alloca %type.string, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
	store i32 4, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
	store i32 4, i32* %3, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 2
	store i8* %0, i8** %4, align 8
	%5 = load %type.string, %type.string* %1, align 8
	%str = alloca %type.string
	store %type.string %5, %type.string* %str
	%n1 = alloca i32
	store i32 1, i32* %n1
	%n2 = alloca i32
	store i32 1, i32* %n2
	%i = alloca i32
	store i32 0, i32* %i
	br label %for.cond0

exit:
	ret void

for.cond0:
	%6 = load i32, i32* %i
	%7 = icmp slt i32 %6, 40
	br i1 %7, label %for.body0, label %for.end0

for.body0:
	%8 = load i32, i32* %n1
	%9 = load i32, i32* %n2
	%10 = add i32 %8, %9
	%sum = alloca i32
	store i32 %10, i32* %sum
	%11 = load %type.string, %type.string* %str
	%12 = load i32, i32* %sum
	%13 = call %type.string @.conv.int_string(i32 %12)
	%14 = getelementptr inbounds [1 x i8], [1 x i8]* @.str1, i32 0, i32 0
	%15 = alloca %type.string, align 8
	%16 = getelementptr inbounds %type.string, %type.string* %15, i32 0, i32 0
	store i32 1, i32* %16, align 8
	%17 = getelementptr inbounds %type.string, %type.string* %15, i32 0, i32 1
	store i32 1, i32* %17, align 8
	%18 = getelementptr inbounds %type.string, %type.string* %15, i32 0, i32 2
	store i8* %14, i8** %18, align 8
	%19 = load %type.string, %type.string* %15, align 8
	%20 = call %type.string @.add.string_string(%type.string %13, %type.string %19)
	%21 = call %type.string @.add.string_string(%type.string %11, %type.string %20)
	store %type.string %21, %type.string* %str
	%22 = load i32, i32* %n2
	store i32 %22, i32* %n1
	%23 = load i32, i32* %sum
	store i32 %23, i32* %n2
	%24 = load i32, i32* %i
	%25 = icmp ne i32 %24, 0
	%26 = load i32, i32* %i
	%27 = srem i32 %26, 10
	%28 = icmp eq i32 %27, 0
	%29 = and i1 %25, %28
	br i1 %29, label %if.then1, label %if.end1

for.inc0:
	%30 = load i32, i32* %i
	%31 = add i32 %30, 1
	store i32 %31, i32* %i
	br label %for.cond0

for.end0:
	%32 = load %type.string, %type.string* %str
	call void @.println(%type.string %32)
	br label %exit

if.then1:
	%33 = load %type.string, %type.string* %str
	%34 = getelementptr inbounds [1 x i8], [1 x i8]* @.str2, i32 0, i32 0
	%35 = alloca %type.string, align 8
	%36 = getelementptr inbounds %type.string, %type.string* %35, i32 0, i32 0
	store i32 1, i32* %36, align 8
	%37 = getelementptr inbounds %type.string, %type.string* %35, i32 0, i32 1
	store i32 1, i32* %37, align 8
	%38 = getelementptr inbounds %type.string, %type.string* %35, i32 0, i32 2
	store i8* %34, i8** %38, align 8
	%39 = load %type.string, %type.string* %35, align 8
	%40 = call %type.string @.add.string_string(%type.string %33, %type.string %39)
	store %type.string %40, %type.string* %str
	br label %if.end1

if.end1:
	br label %for.inc0
}

declare void @.println(%type.string %0)

declare %type.string @.add.string_string(%type.string %0, %type.string %1)

declare %type.string @.conv.int_string(i32 %0)

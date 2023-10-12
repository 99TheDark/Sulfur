; ModuleID = 'script.sulfur'
source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [2 x i8] c"th", align 1
@.str1 = private unnamed_addr constant [2 x i8] c"st", align 1
@.str2 = private unnamed_addr constant [2 x i8] c"nd", align 1
@.str3 = private unnamed_addr constant [2 x i8] c"rd", align 1
@.str4 = private unnamed_addr constant [2 x i8] c", ", align 1

define void @main() {
entry:
	%i = alloca i32
	store i32 1, i32* %i
	br label %for.cond0

exit:
	ret void

for.cond0:
	%0 = load i32, i32* %i
	%1 = icmp sle i32 %0, 100
	br i1 %1, label %for.body0, label %for.end0

for.body0:
	%2 = load i32, i32* %i
	%3 = srem i32 %2, 10
	%end = alloca i32
	store i32 %3, i32* %end
	%4 = getelementptr inbounds [2 x i8], [2 x i8]* @.str0, i32 0, i32 0
	%5 = alloca %type.string, align 8
	%6 = getelementptr inbounds %type.string, %type.string* %5, i32 0, i32 0
	store i32 2, i32* %6, align 8
	%7 = getelementptr inbounds %type.string, %type.string* %5, i32 0, i32 1
	store i32 2, i32* %7, align 8
	%8 = getelementptr inbounds %type.string, %type.string* %5, i32 0, i32 2
	store i8* %4, i8** %8, align 8
	%suffix = alloca %type.string*
	store %type.string* %5, %type.string** %suffix
	%9 = load i32, i32* %i
	%10 = icmp sle i32 %9, 10
	%11 = load i32, i32* %i
	%12 = icmp sgt i32 %11, 20
	%13 = or i1 %10, %12
	br i1 %13, label %if.then1, label %if.end1

for.inc0:
	%14 = load i32, i32* %i
	%15 = add i32 %14, 1
	store i32 %15, i32* %i
	br label %for.cond0

for.end0:
	br label %exit

if.then1:
	%16 = load i32, i32* %end
	%17 = icmp eq i32 %16, 1
	br i1 %17, label %if.then2, label %if.else2

if.end1:
	%18 = load i32, i32* %i
	%19 = alloca %type.string, align 8
	call void @.conv.int_string(%type.string* %19, i32 %18)
	%20 = load %type.string*, %type.string** %suffix
	%21 = alloca %type.string, align 8
	call void @.add.string_string(%type.string* %21, %type.string* %19, %type.string* %20)
	%strNum = alloca %type.string*
	store %type.string* %21, %type.string** %strNum
	%22 = load i32, i32* %end
	%23 = icmp eq i32 %22, 0
	br i1 %23, label %if.then5, label %if.else5

if.then2:
	%24 = getelementptr inbounds [2 x i8], [2 x i8]* @.str1, i32 0, i32 0
	%25 = alloca %type.string, align 8
	%26 = getelementptr inbounds %type.string, %type.string* %25, i32 0, i32 0
	store i32 2, i32* %26, align 8
	%27 = getelementptr inbounds %type.string, %type.string* %25, i32 0, i32 1
	store i32 2, i32* %27, align 8
	%28 = getelementptr inbounds %type.string, %type.string* %25, i32 0, i32 2
	store i8* %24, i8** %28, align 8
	store %type.string* %25, %type.string** %suffix
	br label %if.end2

if.else2:
	%29 = load i32, i32* %end
	%30 = icmp eq i32 %29, 2
	br i1 %30, label %if.then3, label %if.else3

if.end2:
	br label %if.end1

if.then3:
	%31 = getelementptr inbounds [2 x i8], [2 x i8]* @.str2, i32 0, i32 0
	%32 = alloca %type.string, align 8
	%33 = getelementptr inbounds %type.string, %type.string* %32, i32 0, i32 0
	store i32 2, i32* %33, align 8
	%34 = getelementptr inbounds %type.string, %type.string* %32, i32 0, i32 1
	store i32 2, i32* %34, align 8
	%35 = getelementptr inbounds %type.string, %type.string* %32, i32 0, i32 2
	store i8* %31, i8** %35, align 8
	store %type.string* %32, %type.string** %suffix
	br label %if.end3

if.else3:
	%36 = load i32, i32* %end
	%37 = icmp eq i32 %36, 3
	br i1 %37, label %if.then4, label %if.end4

if.end3:
	br label %if.end2

if.then4:
	%38 = getelementptr inbounds [2 x i8], [2 x i8]* @.str3, i32 0, i32 0
	%39 = alloca %type.string, align 8
	%40 = getelementptr inbounds %type.string, %type.string* %39, i32 0, i32 0
	store i32 2, i32* %40, align 8
	%41 = getelementptr inbounds %type.string, %type.string* %39, i32 0, i32 1
	store i32 2, i32* %41, align 8
	%42 = getelementptr inbounds %type.string, %type.string* %39, i32 0, i32 2
	store i8* %38, i8** %42, align 8
	store %type.string* %39, %type.string** %suffix
	br label %if.end4

if.end4:
	br label %if.end3

if.then5:
	%43 = load %type.string*, %type.string** %strNum
	call void @.println(%type.string* %43)
	br label %if.end5

if.else5:
	%44 = load %type.string*, %type.string** %strNum
	%45 = getelementptr inbounds [2 x i8], [2 x i8]* @.str4, i32 0, i32 0
	%46 = alloca %type.string, align 8
	%47 = getelementptr inbounds %type.string, %type.string* %46, i32 0, i32 0
	store i32 2, i32* %47, align 8
	%48 = getelementptr inbounds %type.string, %type.string* %46, i32 0, i32 1
	store i32 2, i32* %48, align 8
	%49 = getelementptr inbounds %type.string, %type.string* %46, i32 0, i32 2
	store i8* %45, i8** %49, align 8
	%50 = alloca %type.string, align 8
	call void @.add.string_string(%type.string* %50, %type.string* %44, %type.string* %46)
	call void @.print(%type.string* %50)
	br label %if.end5

if.end5:
	br label %for.inc0
}

declare void @.print(%type.string* %0)

declare void @.println(%type.string* %0)

declare void @.add.string_string(%type.string* %ret, %type.string* %0, %type.string* %1)

declare void @.conv.int_string(%type.string* %ret, i32 %0)

declare void @.conv.bool_string(%type.string* %ret, i1 %0)

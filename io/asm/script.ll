; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [0 x i8] c"", align 1
@.str1 = private unnamed_addr constant [2 x i8] c"th", align 1
@.str2 = private unnamed_addr constant [2 x i8] c"st", align 1
@.str3 = private unnamed_addr constant [2 x i8] c"nd", align 1
@.str4 = private unnamed_addr constant [2 x i8] c"rd", align 1
@.str5 = private unnamed_addr constant [2 x i8] c", ", align 1

define void @main() {
entry:
	%j = alloca i32
	store i32 0, i32* %j
	br label %for.cond0

exit:
	ret void

for.cond0:
	%0 = load i32, i32* %j
	%1 = icmp slt i32 %0, 20
	br i1 %1, label %for.body0, label %for.end0

for.body0:
	%2 = load i32, i32* %j
	%3 = call i32 @mod.fib(i32 %2)
	%4 = alloca %type.string, align 8
	call void @.conv.int_string(%type.string* %4, i32 %3)
	call void @.println(%type.string* %4)
	br label %for.inc0

for.inc0:
	%5 = load i32, i32* %j
	%6 = add i32 %5, 1
	store i32 %6, i32* %j
	br label %for.cond0

for.end0:
	%7 = getelementptr inbounds [0 x i8], [0 x i8]* @.str0, i32 0, i32 0
	%8 = alloca %type.string, align 8
	%9 = getelementptr inbounds %type.string, %type.string* %8, i32 0, i32 0
	store i32 0, i32* %9, align 8
	%10 = getelementptr inbounds %type.string, %type.string* %8, i32 0, i32 1
	store i32 0, i32* %10, align 8
	%11 = getelementptr inbounds %type.string, %type.string* %8, i32 0, i32 2
	store i8* %7, i8** %11, align 8
	call void @.println(%type.string* %8)
	%i = alloca i32
	store i32 1, i32* %i
	br label %for.cond1

for.cond1:
	%12 = load i32, i32* %i
	%13 = icmp sle i32 %12, 100
	br i1 %13, label %for.body1, label %for.end1

for.body1:
	%14 = load i32, i32* %i
	%15 = srem i32 %14, 10
	%end = alloca i32
	store i32 %15, i32* %end
	%16 = getelementptr inbounds [2 x i8], [2 x i8]* @.str1, i32 0, i32 0
	%17 = alloca %type.string, align 8
	%18 = getelementptr inbounds %type.string, %type.string* %17, i32 0, i32 0
	store i32 2, i32* %18, align 8
	%19 = getelementptr inbounds %type.string, %type.string* %17, i32 0, i32 1
	store i32 2, i32* %19, align 8
	%20 = getelementptr inbounds %type.string, %type.string* %17, i32 0, i32 2
	store i8* %16, i8** %20, align 8
	%suffix = alloca %type.string*
	store %type.string* %17, %type.string** %suffix
	%21 = load i32, i32* %i
	%22 = icmp sle i32 %21, 10
	%23 = load i32, i32* %i
	%24 = icmp sgt i32 %23, 20
	%25 = or i1 %22, %24
	br i1 %25, label %if.then2, label %if.end2

for.inc1:
	%26 = load i32, i32* %i
	%27 = add i32 %26, 1
	store i32 %27, i32* %i
	br label %for.cond1

for.end1:
	br label %exit

if.then2:
	%28 = load i32, i32* %end
	%29 = icmp eq i32 %28, 1
	br i1 %29, label %if.then3, label %if.else3

if.end2:
	%30 = load i32, i32* %i
	%31 = alloca %type.string, align 8
	call void @.conv.int_string(%type.string* %31, i32 %30)
	%32 = load %type.string*, %type.string** %suffix
	%33 = alloca %type.string, align 8
	call void @.add.string_string(%type.string* %33, %type.string* %31, %type.string* %32)
	%strNum = alloca %type.string*
	store %type.string* %33, %type.string** %strNum
	%34 = load i32, i32* %end
	%35 = icmp eq i32 %34, 0
	br i1 %35, label %if.then6, label %if.else6

if.then3:
	%36 = getelementptr inbounds [2 x i8], [2 x i8]* @.str2, i32 0, i32 0
	%37 = alloca %type.string, align 8
	%38 = getelementptr inbounds %type.string, %type.string* %37, i32 0, i32 0
	store i32 2, i32* %38, align 8
	%39 = getelementptr inbounds %type.string, %type.string* %37, i32 0, i32 1
	store i32 2, i32* %39, align 8
	%40 = getelementptr inbounds %type.string, %type.string* %37, i32 0, i32 2
	store i8* %36, i8** %40, align 8
	store %type.string* %37, %type.string** %suffix
	br label %if.end3

if.else3:
	%41 = load i32, i32* %end
	%42 = icmp eq i32 %41, 2
	br i1 %42, label %if.then4, label %if.else4

if.end3:
	br label %if.end2

if.then4:
	%43 = getelementptr inbounds [2 x i8], [2 x i8]* @.str3, i32 0, i32 0
	%44 = alloca %type.string, align 8
	%45 = getelementptr inbounds %type.string, %type.string* %44, i32 0, i32 0
	store i32 2, i32* %45, align 8
	%46 = getelementptr inbounds %type.string, %type.string* %44, i32 0, i32 1
	store i32 2, i32* %46, align 8
	%47 = getelementptr inbounds %type.string, %type.string* %44, i32 0, i32 2
	store i8* %43, i8** %47, align 8
	store %type.string* %44, %type.string** %suffix
	br label %if.end4

if.else4:
	%48 = load i32, i32* %end
	%49 = icmp eq i32 %48, 3
	br i1 %49, label %if.then5, label %if.end5

if.end4:
	br label %if.end3

if.then5:
	%50 = getelementptr inbounds [2 x i8], [2 x i8]* @.str4, i32 0, i32 0
	%51 = alloca %type.string, align 8
	%52 = getelementptr inbounds %type.string, %type.string* %51, i32 0, i32 0
	store i32 2, i32* %52, align 8
	%53 = getelementptr inbounds %type.string, %type.string* %51, i32 0, i32 1
	store i32 2, i32* %53, align 8
	%54 = getelementptr inbounds %type.string, %type.string* %51, i32 0, i32 2
	store i8* %50, i8** %54, align 8
	store %type.string* %51, %type.string** %suffix
	br label %if.end5

if.end5:
	br label %if.end4

if.then6:
	%55 = load %type.string*, %type.string** %strNum
	call void @.println(%type.string* %55)
	br label %if.end6

if.else6:
	%56 = load %type.string*, %type.string** %strNum
	%57 = getelementptr inbounds [2 x i8], [2 x i8]* @.str5, i32 0, i32 0
	%58 = alloca %type.string, align 8
	%59 = getelementptr inbounds %type.string, %type.string* %58, i32 0, i32 0
	store i32 2, i32* %59, align 8
	%60 = getelementptr inbounds %type.string, %type.string* %58, i32 0, i32 1
	store i32 2, i32* %60, align 8
	%61 = getelementptr inbounds %type.string, %type.string* %58, i32 0, i32 2
	store i8* %57, i8** %61, align 8
	%62 = alloca %type.string, align 8
	call void @.add.string_string(%type.string* %62, %type.string* %56, %type.string* %58)
	call void @.print(%type.string* %62)
	br label %if.end6

if.end6:
	br label %for.inc1
}

define i32 @mod.fib(i32 %0) {
entry:
	%.ret = alloca i32
	%1 = icmp sle i32 %0, 1
	br i1 %1, label %if.then0, label %if.else0

exit:
	%2 = load i32, i32* %.ret
	ret i32 %2

if.then0:
	store i32 1, i32* %.ret
	br label %if.end0

if.else0:
	%3 = sub i32 %0, 2
	%4 = call i32 @mod.fib(i32 %3)
	%5 = sub i32 %0, 1
	%6 = call i32 @mod.fib(i32 %5)
	%7 = add i32 %4, %6
	store i32 %7, i32* %.ret
	br label %if.end0

if.end0:
	br label %exit
}

declare void @.print(%type.string* %0)

declare void @.println(%type.string* %0)

declare void @.add.string_string(%type.string* %.ret, %type.string* %0, %type.string* %1)

declare void @.conv.int_string(%type.string* %.ret, i32 %0)

declare void @.conv.bool_string(%type.string* %.ret, i1 %0)

source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [24 x i8] c"It is legal to drink at ", align 1
@.str1 = private unnamed_addr constant [10 x i8] c" years old", align 1
@.str2 = private unnamed_addr constant [26 x i8] c"It is illegal to drink at ", align 1
@.str4 = private unnamed_addr constant [26 x i8] c". . . . . . . . . . . . . ", align 1

define void @main() {
entry:
	%i = alloca i32
	store i32 12, i32* %i
	br label %for.cond0

exit:
	ret void

for.cond0:
	%0 = load i32, i32* %i
	%1 = icmp sle i32 %0, 20
	br i1 %1, label %for.body0, label %for.end0

for.body0:
	%2 = load i32, i32* %i
	%3 = alloca %type.string, align 8
	call void @.conv.int_string(%type.string* %3, i32 %2)
	%age = alloca %type.string*
	store %type.string* %3, %type.string** %age
	%4 = load i32, i32* %i
	%5 = icmp sge i32 %4, 18
	br i1 %5, label %if.then0, label %if.else0

if.then0:
	%6 = getelementptr inbounds [24 x i8], [24 x i8]* @.str0, i32 0, i32 0
	%7 = alloca %type.string, align 8
	%8 = getelementptr inbounds %type.string, %type.string* %7, i32 0, i32 0
	store i32 24, i32* %8, align 8
	%9 = getelementptr inbounds %type.string, %type.string* %7, i32 0, i32 1
	store i32 24, i32* %9, align 8
	%10 = getelementptr inbounds %type.string, %type.string* %7, i32 0, i32 2
	store i8* %6, i8** %10, align 8
	%11 = load %type.string*, %type.string** %age
	%12 = alloca %type.string, align 8
	call void @.add.string_string(%type.string* %12, %type.string* %7, %type.string* %11)
	%13 = getelementptr inbounds [10 x i8], [10 x i8]* @.str1, i32 0, i32 0
	%14 = alloca %type.string, align 8
	%15 = getelementptr inbounds %type.string, %type.string* %14, i32 0, i32 0
	store i32 10, i32* %15, align 8
	%16 = getelementptr inbounds %type.string, %type.string* %14, i32 0, i32 1
	store i32 10, i32* %16, align 8
	%17 = getelementptr inbounds %type.string, %type.string* %14, i32 0, i32 2
	store i8* %13, i8** %17, align 8
	%18 = alloca %type.string, align 8
	call void @.add.string_string(%type.string* %18, %type.string* %12, %type.string* %14)
	call void @.println(%type.string* %18)
	br label %if.end0

if.else0:
	%19 = getelementptr inbounds [26 x i8], [26 x i8]* @.str2, i32 0, i32 0
	%20 = alloca %type.string, align 8
	%21 = getelementptr inbounds %type.string, %type.string* %20, i32 0, i32 0
	store i32 26, i32* %21, align 8
	%22 = getelementptr inbounds %type.string, %type.string* %20, i32 0, i32 1
	store i32 26, i32* %22, align 8
	%23 = getelementptr inbounds %type.string, %type.string* %20, i32 0, i32 2
	store i8* %19, i8** %23, align 8
	%24 = load %type.string*, %type.string** %age
	%25 = alloca %type.string, align 8
	call void @.add.string_string(%type.string* %25, %type.string* %20, %type.string* %24)
	%26 = getelementptr inbounds [10 x i8], [10 x i8]* @.str1, i32 0, i32 0
	%27 = alloca %type.string, align 8
	%28 = getelementptr inbounds %type.string, %type.string* %27, i32 0, i32 0
	store i32 10, i32* %28, align 8
	%29 = getelementptr inbounds %type.string, %type.string* %27, i32 0, i32 1
	store i32 10, i32* %29, align 8
	%30 = getelementptr inbounds %type.string, %type.string* %27, i32 0, i32 2
	store i8* %26, i8** %30, align 8
	%31 = alloca %type.string, align 8
	call void @.add.string_string(%type.string* %31, %type.string* %25, %type.string* %27)
	call void @.println(%type.string* %31)
	br label %if.end0

if.end0:
	br label %for.inc0

for.inc0:
	%32 = load i32, i32* %i
	%33 = add i32 %32, 1
	store i32 %33, i32* %i
	br label %for.cond0

for.end0:
	%34 = getelementptr inbounds [26 x i8], [26 x i8]* @.str4, i32 0, i32 0
	%35 = alloca %type.string, align 8
	%36 = getelementptr inbounds %type.string, %type.string* %35, i32 0, i32 0
	store i32 26, i32* %36, align 8
	%37 = getelementptr inbounds %type.string, %type.string* %35, i32 0, i32 1
	store i32 26, i32* %37, align 8
	%38 = getelementptr inbounds %type.string, %type.string* %35, i32 0, i32 2
	store i8* %34, i8** %38, align 8
	call void @.println(%type.string* %35)
	br label %exit
}

declare void @.print(%type.string* %0)

declare void @.println(%type.string* %0)

declare void @.add.string_string(%type.string* %ret, %type.string* %0, %type.string* %1)

declare void @.conv.int_string(%type.string* %ret, i32 %0)

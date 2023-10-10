source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [4 x i8] c"John", align 1
@.str1 = private unnamed_addr constant [5 x i8] c"Smith", align 1
@.str2 = private unnamed_addr constant [1 x i8] c" ", align 1
@.str3 = private unnamed_addr constant [2 x i8] c", ", align 1
@.str4 = private unnamed_addr constant [16 x i8] c"x is less than 8", align 1
@.str5 = private unnamed_addr constant [20 x i8] c"x is not less than 8", align 1
@.str6 = private unnamed_addr constant [7 x i8] c"No else", align 1

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
	%firstName = alloca %type.string*
	store %type.string* %1, %type.string** %firstName
	%5 = getelementptr inbounds [5 x i8], [5 x i8]* @.str1, i32 0, i32 0
	%6 = alloca %type.string, align 8
	%7 = getelementptr inbounds %type.string, %type.string* %6, i32 0, i32 0
	store i32 5, i32* %7, align 8
	%8 = getelementptr inbounds %type.string, %type.string* %6, i32 0, i32 1
	store i32 5, i32* %8, align 8
	%9 = getelementptr inbounds %type.string, %type.string* %6, i32 0, i32 2
	store i8* %5, i8** %9, align 8
	%lastName = alloca %type.string*
	store %type.string* %6, %type.string** %lastName
	%10 = load %type.string*, %type.string** %firstName
	%11 = getelementptr inbounds [1 x i8], [1 x i8]* @.str2, i32 0, i32 0
	%12 = alloca %type.string, align 8
	%13 = getelementptr inbounds %type.string, %type.string* %12, i32 0, i32 0
	store i32 1, i32* %13, align 8
	%14 = getelementptr inbounds %type.string, %type.string* %12, i32 0, i32 1
	store i32 1, i32* %14, align 8
	%15 = getelementptr inbounds %type.string, %type.string* %12, i32 0, i32 2
	store i8* %11, i8** %15, align 8
	%16 = alloca %type.string, align 8
	call void @concat(%type.string* %16, %type.string* %10, %type.string* %12)
	%17 = load %type.string*, %type.string** %lastName
	%18 = alloca %type.string, align 8
	call void @concat(%type.string* %18, %type.string* %16, %type.string* %17)
	call void @println(%type.string* %18)
	%19 = load %type.string*, %type.string** %lastName
	%20 = getelementptr inbounds [2 x i8], [2 x i8]* @.str3, i32 0, i32 0
	%21 = alloca %type.string, align 8
	%22 = getelementptr inbounds %type.string, %type.string* %21, i32 0, i32 0
	store i32 2, i32* %22, align 8
	%23 = getelementptr inbounds %type.string, %type.string* %21, i32 0, i32 1
	store i32 2, i32* %23, align 8
	%24 = getelementptr inbounds %type.string, %type.string* %21, i32 0, i32 2
	store i8* %20, i8** %24, align 8
	%25 = alloca %type.string, align 8
	call void @concat(%type.string* %25, %type.string* %19, %type.string* %21)
	%26 = load %type.string*, %type.string** %firstName
	%27 = alloca %type.string, align 8
	call void @concat(%type.string* %27, %type.string* %25, %type.string* %26)
	call void @println(%type.string* %27)
	%x = alloca i32
	store i32 7, i32* %x
	%28 = load i32, i32* %x
	%29 = icmp slt i32 %28, 8
	br i1 %29, label %if.then0, label %if.else0

if.then0:
	%30 = getelementptr inbounds [16 x i8], [16 x i8]* @.str4, i32 0, i32 0
	%31 = alloca %type.string, align 8
	%32 = getelementptr inbounds %type.string, %type.string* %31, i32 0, i32 0
	store i32 16, i32* %32, align 8
	%33 = getelementptr inbounds %type.string, %type.string* %31, i32 0, i32 1
	store i32 16, i32* %33, align 8
	%34 = getelementptr inbounds %type.string, %type.string* %31, i32 0, i32 2
	store i8* %30, i8** %34, align 8
	call void @println(%type.string* %31)
	br label %if.end0

if.else0:
	%35 = getelementptr inbounds [20 x i8], [20 x i8]* @.str5, i32 0, i32 0
	%36 = alloca %type.string, align 8
	%37 = getelementptr inbounds %type.string, %type.string* %36, i32 0, i32 0
	store i32 20, i32* %37, align 8
	%38 = getelementptr inbounds %type.string, %type.string* %36, i32 0, i32 1
	store i32 20, i32* %38, align 8
	%39 = getelementptr inbounds %type.string, %type.string* %36, i32 0, i32 2
	store i8* %35, i8** %39, align 8
	call void @println(%type.string* %36)
	br label %if.end0

if.end0:
	%y = alloca i32
	store i32 19, i32* %y
	%40 = load i32, i32* %y
	%41 = icmp sgt i32 %40, 12
	br i1 %41, label %if.then1, label %if.end1

if.then1:
	%42 = getelementptr inbounds [7 x i8], [7 x i8]* @.str6, i32 0, i32 0
	%43 = alloca %type.string, align 8
	%44 = getelementptr inbounds %type.string, %type.string* %43, i32 0, i32 0
	store i32 7, i32* %44, align 8
	%45 = getelementptr inbounds %type.string, %type.string* %43, i32 0, i32 1
	store i32 7, i32* %45, align 8
	%46 = getelementptr inbounds %type.string, %type.string* %43, i32 0, i32 2
	store i8* %42, i8** %46, align 8
	call void @println(%type.string* %43)
	br label %if.end1

if.end1:
	ret void
}

declare void @print(%type.string* %0)

declare void @println(%type.string* %0)

declare void @concat(%type.string* %0, %type.string* %1, %type.string* %2)

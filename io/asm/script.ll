source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [4 x i8] c"John", align 1
@.str1 = private unnamed_addr constant [5 x i8] c"Smith", align 1
@.str2 = private unnamed_addr constant [1 x i8] c" ", align 1
@.str3 = private unnamed_addr constant [2 x i8] c", ", align 1
@.str4 = private unnamed_addr constant [0 x i8] c"", align 1
@.str5 = private unnamed_addr constant [16 x i8] c"x is less than 8", align 1
@.str6 = private unnamed_addr constant [20 x i8] c"x is not less than 8", align 1
@.str8 = private unnamed_addr constant [7 x i8] c"abcdefg", align 1

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
	%28 = getelementptr inbounds [0 x i8], [0 x i8]* @.str4, i32 0, i32 0
	%29 = alloca %type.string, align 8
	%30 = getelementptr inbounds %type.string, %type.string* %29, i32 0, i32 0
	store i32 0, i32* %30, align 8
	%31 = getelementptr inbounds %type.string, %type.string* %29, i32 0, i32 1
	store i32 0, i32* %31, align 8
	%32 = getelementptr inbounds %type.string, %type.string* %29, i32 0, i32 2
	store i8* %28, i8** %32, align 8
	call void @println(%type.string* %29)
	%x = alloca i32
	store i32 7, i32* %x
	%33 = load i32, i32* %x
	%34 = icmp slt i32 %33, 8
	br i1 %34, label %if.then, label %if.else

if.then:
	%35 = getelementptr inbounds [16 x i8], [16 x i8]* @.str5, i32 0, i32 0
	%36 = alloca %type.string, align 8
	%37 = getelementptr inbounds %type.string, %type.string* %36, i32 0, i32 0
	store i32 16, i32* %37, align 8
	%38 = getelementptr inbounds %type.string, %type.string* %36, i32 0, i32 1
	store i32 16, i32* %38, align 8
	%39 = getelementptr inbounds %type.string, %type.string* %36, i32 0, i32 2
	store i8* %35, i8** %39, align 8
	call void @println(%type.string* %36)
	br label %if.end

if.else:
	%40 = getelementptr inbounds [20 x i8], [20 x i8]* @.str6, i32 0, i32 0
	%41 = alloca %type.string, align 8
	%42 = getelementptr inbounds %type.string, %type.string* %41, i32 0, i32 0
	store i32 20, i32* %42, align 8
	%43 = getelementptr inbounds %type.string, %type.string* %41, i32 0, i32 1
	store i32 20, i32* %43, align 8
	%44 = getelementptr inbounds %type.string, %type.string* %41, i32 0, i32 2
	store i8* %40, i8** %44, align 8
	call void @println(%type.string* %41)
	br label %if.end

if.end:
	%45 = getelementptr inbounds [0 x i8], [0 x i8]* @.str4, i32 0, i32 0
	%46 = alloca %type.string, align 8
	%47 = getelementptr inbounds %type.string, %type.string* %46, i32 0, i32 0
	store i32 0, i32* %47, align 8
	%48 = getelementptr inbounds %type.string, %type.string* %46, i32 0, i32 1
	store i32 0, i32* %48, align 8
	%49 = getelementptr inbounds %type.string, %type.string* %46, i32 0, i32 2
	store i8* %45, i8** %49, align 8
	call void @println(%type.string* %46)
	%50 = getelementptr inbounds [7 x i8], [7 x i8]* @.str8, i32 0, i32 0
	%51 = alloca %type.string, align 8
	%52 = getelementptr inbounds %type.string, %type.string* %51, i32 0, i32 0
	store i32 7, i32* %52, align 8
	%53 = getelementptr inbounds %type.string, %type.string* %51, i32 0, i32 1
	store i32 7, i32* %53, align 8
	%54 = getelementptr inbounds %type.string, %type.string* %51, i32 0, i32 2
	store i8* %50, i8** %54, align 8
	call void @println(%type.string* %51)
	ret void
}

declare void @print(%type.string* %0)

declare void @println(%type.string* %0)

declare void @concat(%type.string* %0, %type.string* %1, %type.string* %2)

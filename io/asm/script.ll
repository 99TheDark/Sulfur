source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [6 x i8] c"1: abc", align 1
@.str1 = private unnamed_addr constant [6 x i8] c"2: def", align 1
@.str2 = private unnamed_addr constant [6 x i8] c"3: ghi", align 1

define void @main() {
entry:
	%x = alloca i32
	store i32 0, i32* %x
	%y = alloca i32
	store i32 0, i32* %y
	%z = alloca i32
	store i32 7, i32* %z
	%0 = load i32, i32* %z
	%1 = load i32, i32* %x
	%2 = add i32 %0, %1
	%3 = load i32, i32* %y
	%4 = icmp sgt i32 %2, %3
	br i1 %4, label %if.then0, label %if.else0

if.then0:
	%5 = getelementptr inbounds [6 x i8], [6 x i8]* @.str0, i32 0, i32 0
	%6 = alloca %type.string, align 8
	%7 = getelementptr inbounds %type.string, %type.string* %6, i32 0, i32 0
	store i32 6, i32* %7, align 8
	%8 = getelementptr inbounds %type.string, %type.string* %6, i32 0, i32 1
	store i32 6, i32* %8, align 8
	%9 = getelementptr inbounds %type.string, %type.string* %6, i32 0, i32 2
	store i8* %5, i8** %9, align 8
	call void @println(%type.string* %6)
	br label %if.end0

if.else0:
	%10 = load i32, i32* %z
	%11 = load i32, i32* %x
	%12 = icmp slt i32 %10, %11
	br label %if.end0

if.then1:
	%13 = getelementptr inbounds [6 x i8], [6 x i8]* @.str1, i32 0, i32 0
	%14 = alloca %type.string, align 8
	%15 = getelementptr inbounds %type.string, %type.string* %14, i32 0, i32 0
	store i32 6, i32* %15, align 8
	%16 = getelementptr inbounds %type.string, %type.string* %14, i32 0, i32 1
	store i32 6, i32* %16, align 8
	%17 = getelementptr inbounds %type.string, %type.string* %14, i32 0, i32 2
	store i8* %13, i8** %17, align 8
	call void @println(%type.string* %14)
	br label %if.end1

if.else1:
	%18 = getelementptr inbounds [6 x i8], [6 x i8]* @.str2, i32 0, i32 0
	%19 = alloca %type.string, align 8
	%20 = getelementptr inbounds %type.string, %type.string* %19, i32 0, i32 0
	store i32 6, i32* %20, align 8
	%21 = getelementptr inbounds %type.string, %type.string* %19, i32 0, i32 1
	store i32 6, i32* %21, align 8
	%22 = getelementptr inbounds %type.string, %type.string* %19, i32 0, i32 2
	store i8* %18, i8** %22, align 8
	call void @println(%type.string* %19)
	br label %if.end1

if.end1:
	br label %if.end0

if.end0:
	ret void
}

declare void @print(%type.string* %0)

declare void @println(%type.string* %0)

declare void @concat(%type.string* %0, %type.string* %1, %type.string* %2)

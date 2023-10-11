source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [2 x i8] c", ", align 1
@.str1 = private unnamed_addr constant [17 x i8] c"The numbers are: ", align 1
@.str3 = private unnamed_addr constant [6 x i8] c", and ", align 1

define void @main() {
entry:
	%0 = getelementptr inbounds [17 x i8], [17 x i8]* @.str1, i32 0, i32 0
	%1 = alloca %type.string, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
	store i32 17, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
	store i32 17, i32* %3, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 2
	store i8* %0, i8** %4, align 8
	%5 = sub i32 0, 43201
	%6 = alloca %type.string, align 8
	call void @.conv.int_string(%type.string* %6, i32 %5)
	%7 = alloca %type.string, align 8
	call void @.add.string_string(%type.string* %7, %type.string* %1, %type.string* %6)
	%8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str0, i32 0, i32 0
	%9 = alloca %type.string, align 8
	%10 = getelementptr inbounds %type.string, %type.string* %9, i32 0, i32 0
	store i32 2, i32* %10, align 8
	%11 = getelementptr inbounds %type.string, %type.string* %9, i32 0, i32 1
	store i32 2, i32* %11, align 8
	%12 = getelementptr inbounds %type.string, %type.string* %9, i32 0, i32 2
	store i8* %8, i8** %12, align 8
	%13 = alloca %type.string, align 8
	call void @.add.string_string(%type.string* %13, %type.string* %7, %type.string* %9)
	%14 = alloca %type.string, align 8
	call void @.conv.int_string(%type.string* %14, i32 0)
	%15 = alloca %type.string, align 8
	call void @.add.string_string(%type.string* %15, %type.string* %13, %type.string* %14)
	%16 = getelementptr inbounds [6 x i8], [6 x i8]* @.str3, i32 0, i32 0
	%17 = alloca %type.string, align 8
	%18 = getelementptr inbounds %type.string, %type.string* %17, i32 0, i32 0
	store i32 6, i32* %18, align 8
	%19 = getelementptr inbounds %type.string, %type.string* %17, i32 0, i32 1
	store i32 6, i32* %19, align 8
	%20 = getelementptr inbounds %type.string, %type.string* %17, i32 0, i32 2
	store i8* %16, i8** %20, align 8
	%21 = alloca %type.string, align 8
	call void @.add.string_string(%type.string* %21, %type.string* %15, %type.string* %17)
	%22 = alloca %type.string, align 8
	call void @.conv.int_string(%type.string* %22, i32 762)
	%23 = alloca %type.string, align 8
	call void @.add.string_string(%type.string* %23, %type.string* %21, %type.string* %22)
	call void @.println(%type.string* %23)
	ret void
}

declare void @.print(%type.string* %0)

declare void @.println(%type.string* %0)

declare void @.add.string_string(%type.string* %ret, %type.string* %0, %type.string* %1)

declare void @.conv.int_string(%type.string* %ret, i32 %0)

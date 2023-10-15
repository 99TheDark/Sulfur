; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [2 x i8] c", ", align 1
@.str1 = private unnamed_addr constant [4 x i8] c"John", align 1
@.str2 = private unnamed_addr constant [5 x i8] c"Smith", align 1

define void @main() {
entry:
	%i = alloca i32
	store i32 0, i32* %i
	br i1 true, label %if.then0, label %if.end0

exit:
	ret void

if.then0:
	%0 = load i32, i32* %i
	%1 = call %type.string @.conv.int_string(i32 %0)
	call void @.println(%type.string %1)
	br label %if.end0

if.end0:
	%2 = call i32 @mod.fibonacci(i32 12)
	%3 = call %type.string @.conv.int_string(i32 %2)
	call void @.println(%type.string %3)
	%4 = getelementptr inbounds [4 x i8], [4 x i8]* @.str1, i32 0, i32 0
	%5 = alloca %type.string, align 8
	%6 = getelementptr inbounds %type.string, %type.string* %5, i32 0, i32 0
	store i32 4, i32* %6, align 8
	%7 = getelementptr inbounds %type.string, %type.string* %5, i32 0, i32 1
	store i32 4, i32* %7, align 8
	%8 = getelementptr inbounds %type.string, %type.string* %5, i32 0, i32 2
	store i8* %4, i8** %8, align 8
	%9 = load %type.string, %type.string* %5, align 8
	%10 = getelementptr inbounds [5 x i8], [5 x i8]* @.str2, i32 0, i32 0
	%11 = alloca %type.string, align 8
	%12 = getelementptr inbounds %type.string, %type.string* %11, i32 0, i32 0
	store i32 5, i32* %12, align 8
	%13 = getelementptr inbounds %type.string, %type.string* %11, i32 0, i32 1
	store i32 5, i32* %13, align 8
	%14 = getelementptr inbounds %type.string, %type.string* %11, i32 0, i32 2
	store i8* %10, i8** %14, align 8
	%15 = load %type.string, %type.string* %11, align 8
	%16 = call %type.string @mod.formatName(%type.string %9, %type.string %15)
	call void @.println(%type.string %16)
	br label %exit
}

define %type.string @mod.formatName(%type.string %0, %type.string %1) {
entry:
	%.ret = alloca %type.string
	%2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str0, i32 0, i32 0
	%3 = alloca %type.string, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 0
	store i32 2, i32* %4, align 8
	%5 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 1
	store i32 2, i32* %5, align 8
	%6 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 2
	store i8* %2, i8** %6, align 8
	%7 = load %type.string, %type.string* %3, align 8
	%8 = call %type.string @.add.string_string(%type.string %1, %type.string %7)
	%9 = call %type.string @.add.string_string(%type.string %8, %type.string %0)
	store %type.string %9, %type.string* %.ret, align 8
	br label %exit

exit:
	%10 = load %type.string, %type.string* %.ret
	ret %type.string %10
}

define i32 @mod.fibonacci(i32 %0) {
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
	%4 = call i32 @mod.fibonacci(i32 %3)
	%5 = sub i32 %0, 1
	%6 = call i32 @mod.fibonacci(i32 %5)
	%7 = add i32 %4, %6
	store i32 %7, i32* %.ret
	br label %if.end0

if.end0:
	br label %exit
}

declare void @.print(%type.string %0)

declare void @.println(%type.string %0)

declare %type.string @.add.string_string(%type.string %0, %type.string %1)

declare %type.string @.conv.int_string(i32 %0)

declare %type.string @.conv.bool_string(i1 %0)

; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [2 x i8] c", ", align 1
@.str1 = private unnamed_addr constant [4 x i8] c"John", align 1
@.str2 = private unnamed_addr constant [5 x i8] c"Smith", align 1
@.str3 = private unnamed_addr constant [4 x i8] c" -> ", align 1

define void @main() {
entry:
	%0 = getelementptr inbounds [4 x i8], [4 x i8]* @.str1, i32 0, i32 0
	%1 = alloca %type.string, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
	store i32 4, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
	store i32 4, i32* %3, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 2
	store i8* %0, i8** %4, align 8
	%5 = load %type.string, %type.string* %1, align 8
	%firstName = alloca %type.string
	store %type.string %5, %type.string* %firstName
	%6 = getelementptr inbounds [5 x i8], [5 x i8]* @.str2, i32 0, i32 0
	%7 = alloca %type.string, align 8
	%8 = getelementptr inbounds %type.string, %type.string* %7, i32 0, i32 0
	store i32 5, i32* %8, align 8
	%9 = getelementptr inbounds %type.string, %type.string* %7, i32 0, i32 1
	store i32 5, i32* %9, align 8
	%10 = getelementptr inbounds %type.string, %type.string* %7, i32 0, i32 2
	store i8* %6, i8** %10, align 8
	%11 = load %type.string, %type.string* %7, align 8
	%lastName = alloca %type.string
	store %type.string %11, %type.string* %lastName
	%12 = load %type.string, %type.string* %firstName
	%13 = load %type.string, %type.string* %lastName
	%14 = call %type.string @mod.formatName(%type.string %12, %type.string %13)
	%15 = getelementptr inbounds [4 x i8], [4 x i8]* @.str3, i32 0, i32 0
	%16 = alloca %type.string, align 8
	%17 = getelementptr inbounds %type.string, %type.string* %16, i32 0, i32 0
	store i32 4, i32* %17, align 8
	%18 = getelementptr inbounds %type.string, %type.string* %16, i32 0, i32 1
	store i32 4, i32* %18, align 8
	%19 = getelementptr inbounds %type.string, %type.string* %16, i32 0, i32 2
	store i8* %15, i8** %19, align 8
	%20 = load %type.string, %type.string* %16, align 8
	%21 = call %type.string @.add.string_string(%type.string %14, %type.string %20)
	%22 = call i32 @mod.add(i32 6, i32 4)
	%23 = call %type.string @.conv.int_string(i32 %22)
	%24 = call %type.string @.add.string_string(%type.string %21, %type.string %23)
	call void @.println(%type.string %24)
	call void @mod.noReturn()
	br label %exit

exit:
	ret void
}

define i32 @mod.add(i32 %0, i32 %1) {
entry:
	%.ret = alloca i32
	%2 = add i32 %0, %1
	store i32 %2, i32* %.ret
	br label %exit

exit:
	%3 = load i32, i32* %.ret
	ret i32 %3
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

define void @mod.noReturn() {
entry:
	br label %exit

exit:
	ret void
}

declare void @.print(%type.string %0)

declare void @.println(%type.string %0)

declare %type.string @.add.string_string(%type.string %0, %type.string %1)

declare %type.string @.conv.int_string(i32 %0)

declare %type.string @.conv.bool_string(i1 %0)

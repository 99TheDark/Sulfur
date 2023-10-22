; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [8 x i8] c"I am in ", align 1
@.str1 = private unnamed_addr constant [15 x i8] c"th grade, it's ", align 1

define void @main() {
entry:
	%0 = getelementptr inbounds [8 x i8], [8 x i8]* @.str0, i32 0, i32 0
	%1 = alloca %type.string, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
	store i32 8, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
	store i32 8, i32* %3, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 2
	store i8* %0, i8** %4, align 8
	%5 = load %type.string, %type.string* %1, align 8
	%6 = call %type.string @".conv:int_string"(i32 10)
	%7 = call %type.string @".add:string_string"(%type.string %5, %type.string %6)
	%8 = getelementptr inbounds [15 x i8], [15 x i8]* @.str1, i32 0, i32 0
	%9 = alloca %type.string, align 8
	%10 = getelementptr inbounds %type.string, %type.string* %9, i32 0, i32 0
	store i32 15, i32* %10, align 8
	%11 = getelementptr inbounds %type.string, %type.string* %9, i32 0, i32 1
	store i32 15, i32* %11, align 8
	%12 = getelementptr inbounds %type.string, %type.string* %9, i32 0, i32 2
	store i8* %8, i8** %12, align 8
	%13 = load %type.string, %type.string* %9, align 8
	%14 = call %type.string @".add:string_string"(%type.string %7, %type.string %13)
	%15 = call %type.string @".conv:bool_string"(i1 true)
	%16 = call %type.string @".add:string_string"(%type.string %14, %type.string %15)
	%x = alloca %type.string
	store %type.string %16, %type.string* %x
	%y = alloca i32
	store i32 53, i32* %y
	%17 = load %type.string, %type.string* %x, align 16
	call void @.println(%type.string %17)
	br label %exit

exit:
	ret void
}

declare void @.println(%type.string %0)

declare %type.string @".add:string_string"(%type.string %0, %type.string %1)

declare %type.string @".conv:int_string"(i32 %0)

declare %type.string @".conv:bool_string"(i1 %0)

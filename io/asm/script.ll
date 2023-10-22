; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [15 x i8] c"Hi, my name is ", align 1
@.str1 = private unnamed_addr constant [13 x i8] c", and I'm in ", align 1
@.str2 = private unnamed_addr constant [15 x i8] c"th grade. It's ", align 1
@.str3 = private unnamed_addr constant [1 x i8] c"!", align 1
@.str4 = private unnamed_addr constant [7 x i8] c"TheDark", align 1

define void @main() {
entry:
	%0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str4, i32 0, i32 0
	%1 = alloca %type.string, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
	store i32 7, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
	store i32 7, i32* %3, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 2
	store i8* %0, i8** %4, align 8
	%5 = load %type.string, %type.string* %1, align 8
	%6 = call %type.string @mod.combine(%type.string %5, i1 true)
	call void @.println(%type.string %6)
	br label %exit

exit:
	ret void
}

define private %type.string @mod.combine(%type.string %0, i1 %1) {
entry:
	%.ret = alloca %type.string
	%2 = getelementptr inbounds [15 x i8], [15 x i8]* @.str0, i32 0, i32 0
	%3 = alloca %type.string, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 0
	store i32 15, i32* %4, align 8
	%5 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 1
	store i32 15, i32* %5, align 8
	%6 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 2
	store i8* %2, i8** %6, align 8
	%7 = load %type.string, %type.string* %3, align 8
	%8 = call %type.string @".add:string_string"(%type.string %7, %type.string %0)
	%9 = getelementptr inbounds [13 x i8], [13 x i8]* @.str1, i32 0, i32 0
	%10 = alloca %type.string, align 8
	%11 = getelementptr inbounds %type.string, %type.string* %10, i32 0, i32 0
	store i32 13, i32* %11, align 8
	%12 = getelementptr inbounds %type.string, %type.string* %10, i32 0, i32 1
	store i32 13, i32* %12, align 8
	%13 = getelementptr inbounds %type.string, %type.string* %10, i32 0, i32 2
	store i8* %9, i8** %13, align 8
	%14 = load %type.string, %type.string* %10, align 8
	%15 = call %type.string @".add:string_string"(%type.string %8, %type.string %14)
	%16 = call %type.string @".conv:int_string"(i32 10)
	%17 = call %type.string @".add:string_string"(%type.string %15, %type.string %16)
	%18 = getelementptr inbounds [15 x i8], [15 x i8]* @.str2, i32 0, i32 0
	%19 = alloca %type.string, align 8
	%20 = getelementptr inbounds %type.string, %type.string* %19, i32 0, i32 0
	store i32 15, i32* %20, align 8
	%21 = getelementptr inbounds %type.string, %type.string* %19, i32 0, i32 1
	store i32 15, i32* %21, align 8
	%22 = getelementptr inbounds %type.string, %type.string* %19, i32 0, i32 2
	store i8* %18, i8** %22, align 8
	%23 = load %type.string, %type.string* %19, align 8
	%24 = call %type.string @".add:string_string"(%type.string %17, %type.string %23)
	%25 = call %type.string @".conv:bool_string"(i1 %1)
	%26 = call %type.string @".add:string_string"(%type.string %24, %type.string %25)
	%27 = getelementptr inbounds [1 x i8], [1 x i8]* @.str3, i32 0, i32 0
	%28 = alloca %type.string, align 8
	%29 = getelementptr inbounds %type.string, %type.string* %28, i32 0, i32 0
	store i32 1, i32* %29, align 8
	%30 = getelementptr inbounds %type.string, %type.string* %28, i32 0, i32 1
	store i32 1, i32* %30, align 8
	%31 = getelementptr inbounds %type.string, %type.string* %28, i32 0, i32 2
	store i8* %27, i8** %31, align 8
	%32 = load %type.string, %type.string* %28, align 8
	%33 = call %type.string @".add:string_string"(%type.string %26, %type.string %32)
	store %type.string %33, %type.string* %.ret, align 8
	br label %exit

exit:
	%34 = load %type.string, %type.string* %.ret
	ret %type.string %34
}

declare void @.println(%type.string %0)

declare %type.string @".add:string_string"(%type.string %0, %type.string %1)

declare %type.string @".conv:int_string"(i32 %0)

declare %type.string @".conv:bool_string"(i1 %0)

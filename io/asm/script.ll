; ModuleID = 'script.su'
source_filename = "script.su"

%type.utf8_string = type { i32, i32* }

@.str0 = private unnamed_addr constant [8 x i32] [i32 97, i32 957, i32 1490, i32 2827, i32 66370, i32 145838, i32 172300, i32 33], align 4
@.str1 = private unnamed_addr constant [7 x i32] [i32 32, i32 72, i32 101, i32 108, i32 108, i32 111, i32 46], align 4
@.str2 = private unnamed_addr constant [1 x i32] [i32 60], align 4
@.str3 = private unnamed_addr constant [1 x i32] [i32 62], align 4
@.str4 = private unnamed_addr constant [1 x i32] [i32 32], align 4
@.str5 = private unnamed_addr constant [3 x i32] [i32 32, i32 43, i32 32], align 4

define void @main() {
entry:
	%0 = getelementptr inbounds [8 x i32], [8 x i32]* @.str0, i32 0, i32 0
	%1 = alloca %type.utf8_string, align 8
	%2 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %1, i32 0, i32 0
	store i32 8, i32* %2, align 8
	%3 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %1, i32 0, i32 1
	store i32* %0, i32** %3, align 8
	%4 = load %type.utf8_string, %type.utf8_string* %1, align 8
	%x = alloca %type.utf8_string
	store %type.utf8_string %4, %type.utf8_string* %x
	%5 = getelementptr inbounds [7 x i32], [7 x i32]* @.str1, i32 0, i32 0
	%6 = alloca %type.utf8_string, align 8
	%7 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %6, i32 0, i32 0
	store i32 7, i32* %7, align 8
	%8 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %6, i32 0, i32 1
	store i32* %5, i32** %8, align 8
	%9 = load %type.utf8_string, %type.utf8_string* %6, align 8
	%y = alloca %type.utf8_string
	store %type.utf8_string %9, %type.utf8_string* %y
	%z = alloca i32
	store i32 -804, i32* %z
	%w = alloca float
	store float 0x400921F9E0000000, float* %w
	%10 = load %type.utf8_string, %type.utf8_string* %x, align 8
	%11 = getelementptr inbounds [1 x i32], [1 x i32]* @.str2, i32 0, i32 0
	%12 = alloca %type.utf8_string, align 8
	%13 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %12, i32 0, i32 0
	store i32 1, i32* %13, align 8
	%14 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %12, i32 0, i32 1
	store i32* %11, i32** %14, align 8
	%15 = load %type.utf8_string, %type.utf8_string* %12, align 8
	%16 = call %type.utf8_string @".add:string_string"(%type.utf8_string %10, %type.utf8_string %15)
	%17 = call %type.utf8_string @".conv:int_string"(i32 0)
	%18 = call %type.utf8_string @".add:string_string"(%type.utf8_string %16, %type.utf8_string %17)
	%19 = getelementptr inbounds [1 x i32], [1 x i32]* @.str3, i32 0, i32 0
	%20 = alloca %type.utf8_string, align 8
	%21 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %20, i32 0, i32 0
	store i32 1, i32* %21, align 8
	%22 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %20, i32 0, i32 1
	store i32* %19, i32** %22, align 8
	%23 = load %type.utf8_string, %type.utf8_string* %20, align 8
	%24 = call %type.utf8_string @".add:string_string"(%type.utf8_string %18, %type.utf8_string %23)
	%25 = load %type.utf8_string, %type.utf8_string* %y, align 8
	%26 = call %type.utf8_string @".add:string_string"(%type.utf8_string %24, %type.utf8_string %25)
	%27 = getelementptr inbounds [1 x i32], [1 x i32]* @.str4, i32 0, i32 0
	%28 = alloca %type.utf8_string, align 8
	%29 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %28, i32 0, i32 0
	store i32 1, i32* %29, align 8
	%30 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %28, i32 0, i32 1
	store i32* %27, i32** %30, align 8
	%31 = load %type.utf8_string, %type.utf8_string* %28, align 8
	%32 = call %type.utf8_string @".add:string_string"(%type.utf8_string %26, %type.utf8_string %31)
	%33 = load i32, i32* %z, align 4
	%34 = call %type.utf8_string @".conv:int_string"(i32 %33)
	%35 = call %type.utf8_string @".add:string_string"(%type.utf8_string %32, %type.utf8_string %34)
	%36 = getelementptr inbounds [3 x i32], [3 x i32]* @.str5, i32 0, i32 0
	%37 = alloca %type.utf8_string, align 8
	%38 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %37, i32 0, i32 0
	store i32 3, i32* %38, align 8
	%39 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %37, i32 0, i32 1
	store i32* %36, i32** %39, align 8
	%40 = load %type.utf8_string, %type.utf8_string* %37, align 8
	%41 = call %type.utf8_string @".add:string_string"(%type.utf8_string %35, %type.utf8_string %40)
	%42 = load float, float* %w, align 4
	%43 = call %type.utf8_string @".conv:float_string"(float %42)
	%44 = call %type.utf8_string @".add:string_string"(%type.utf8_string %41, %type.utf8_string %43)
	%45 = call %type.utf8_string @".conv:bool_string"(i1 true)
	%46 = call %type.utf8_string @".add:string_string"(%type.utf8_string %44, %type.utf8_string %45)
	call void @.println(%type.utf8_string %46)
	br label %exit

exit:
	ret void
}

declare void @.println(%type.utf8_string %0)

declare %type.utf8_string @".add:string_string"(%type.utf8_string %0, %type.utf8_string %1)

declare %type.utf8_string @".conv:int_string"(i32 %0)

declare %type.utf8_string @".conv:float_string"(float %0)

declare %type.utf8_string @".conv:bool_string"(i1 %0)

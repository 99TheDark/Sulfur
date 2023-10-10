source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [5 x i8] c"John ", align 1
@.str1 = private unnamed_addr constant [5 x i8] c"Smith", align 1

declare void @print(%type.string* %0)

declare void @println(%type.string* %0)

declare void @concat(%type.string* %0, %type.string* %1, %type.string* %2)

define void @main() {
entry:
	%0 = getelementptr inbounds [5 x i8], [5 x i8]* @.str0, i32 0, i32 0
	%1 = alloca %type.string, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
	store i32 5, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
	store i32 5, i32* %3, align 8
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
	%11 = load %type.string*, %type.string** %lastName
	%12 = alloca %type.string, align 8
	call void @concat(%type.string* %12, %type.string* %10, %type.string* %11)
	call void @println(%type.string* %12)
	%13 = add i32 5, 3
	%x = alloca i32
	store i32 %13, i32* %x
	%14 = load i32, i32* %x
	%15 = load i32, i32* %x
	%16 = mul i32 %14, %15
	%17 = load i32, i32* %x
	%18 = sub i32 %16, %17
	%y = alloca i32
	store i32 %18, i32* %y
	%19 = frem float 0x3FB9999980000000, 0x40007AE140000000
	%20 = fsub float 0x401ECCCCC0000000, %19
	%abc = alloca float
	store float %20, float* %abc
	%21 = load float, float* %abc
	%22 = fadd float 0x400CCCCCC0000000, %21
	%def = alloca float
	store float %22, float* %def
	ret void
}

; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }
%type.complex = type { float, float }
%ref.int = type { i32*, i32 }

define void @main() {
entry:
	%x = alloca %ref.int*
	%0 = call %ref.int* @"newref:int"(i32 50)
	store %ref.int* %0, %ref.int** %x, align 8
	%1 = load %ref.int*, %ref.int** %x, align 8
	%2 = getelementptr inbounds %ref.int, %ref.int* %1, i32 0, i32 0
	%3 = load i32*, i32** %2, align 8
	%4 = load i32, i32* %3, align 4
	%5 = sub i32 %4, 1
	%6 = load %ref.int*, %ref.int** %x, align 8
	%7 = getelementptr inbounds %ref.int, %ref.int* %6, i32 0, i32 0
	%8 = load i32*, i32** %7, align 8
	store i32 %5, i32* %8, align 8
	%y = alloca float
	store float 0x4055133320000000, float* %y
	%9 = load float, float* %y, align 4
	%10 = sitofp i32 12 to float
	%11 = fadd float %9, %10
	store float %11, float* %y
	%12 = load %ref.int*, %ref.int** %x, align 8
	call void @"ref:int"(%ref.int* %12)
	%z = alloca %ref.int*
	store %ref.int* %12, %ref.int** %z, align 8
	%13 = load %ref.int*, %ref.int** %x, align 8
	%14 = getelementptr inbounds %ref.int, %ref.int* %13, i32 0, i32 0
	%15 = load i32*, i32** %14, align 8
	%16 = load i32, i32* %15, align 4
	%17 = call %type.string @".conv:int_string"(i32 %16)
	call void @.println(%type.string %17)
	%18 = load %ref.int*, %ref.int** %z, align 8
	call void @"ref:int"(%ref.int* %18)
	call void @mod.something(%ref.int* %18, i1 true)
	%19 = load %ref.int*, %ref.int** %x, align 8
	%20 = getelementptr inbounds %ref.int, %ref.int* %19, i32 0, i32 0
	%21 = load i32*, i32** %20, align 8
	%22 = load i32, i32* %21, align 4
	%23 = call %type.string @".conv:int_string"(i32 %22)
	call void @.println(%type.string %23)
	%24 = load %ref.int*, %ref.int** %x, align 8
	call void @"deref:int"(%ref.int* %24)
	%25 = load %ref.int*, %ref.int** %z, align 8
	call void @"deref:int"(%ref.int* %25)
	br label %exit

exit:
	ret void
}

declare %ref.int* @"newref:int"(i32 %0)

declare void @"ref:int"(%ref.int* %0)

declare void @"deref:int"(%ref.int* %0)

define private void @mod.something(%ref.int* %0, i1 %1) {
entry:
	%2 = call %type.string @".conv:bool_string"(i1 %1)
	call void @.println(%type.string %2)
	%3 = getelementptr inbounds %ref.int, %ref.int* %0, i32 0, i32 0
	%4 = load i32*, i32** %3, align 8
	%5 = load i32, i32* %4, align 4
	%6 = add i32 %5, 5
	%7 = getelementptr inbounds %ref.int, %ref.int* %0, i32 0, i32 0
	%8 = load i32*, i32** %7, align 8
	store i32 %6, i32* %8, align 8
	br label %exit

exit:
	ret void
}

declare void @.println(%type.string %0)

declare %type.string @".conv:int_string"(i32 %0)

declare %type.string @".conv:bool_string"(i1 %0)

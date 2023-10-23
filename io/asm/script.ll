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
	call void @"ref:int"(%ref.int* %1)
	call void @mod.something(%ref.int* %1)
	%2 = load %ref.int*, %ref.int** %x, align 8
	%3 = getelementptr inbounds %ref.int, %ref.int* %2, i32 0, i32 0
	%4 = load i32*, i32** %3, align 8
	%5 = load i32, i32* %4, align 4
	%6 = call %type.string @".conv:int_string"(i32 %5)
	call void @.println(%type.string %6)
	%7 = load %ref.int*, %ref.int** %x, align 8
	call void @"deref:int"(%ref.int* %7)
	br label %exit

exit:
	ret void
}

declare %ref.int* @"newref:int"(i32 %0)

declare void @"ref:int"(%ref.int* %0)

declare void @"deref:int"(%ref.int* %0)

define private void @mod.something(%ref.int* %0) {
entry:
	%1 = getelementptr inbounds %ref.int, %ref.int* %0, i32 0, i32 0
	%2 = load i32*, i32** %1, align 8
	%3 = load i32, i32* %2, align 4
	%4 = add i32 %3, 5
	%5 = getelementptr inbounds %ref.int, %ref.int* %0, i32 0, i32 0
	%6 = load i32*, i32** %5, align 8
	store i32 %4, i32* %6, align 8
	br label %exit

exit:
	ret void
}

declare void @.println(%type.string %0)

declare %type.string @".conv:int_string"(i32 %0)

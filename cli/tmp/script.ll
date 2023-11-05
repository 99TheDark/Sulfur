; ModuleID = 'examples/main/script.su'
source_filename = "examples/main/script.su"

%type.string = type { i32, i32* }
%ref.int = type { i32*, i32 }

define i32 @main() {
entry:
	%x = alloca %ref.int*, align 8
	%y = alloca %ref.int*, align 8
	%0 = call %ref.int* @"newref:int"(i32 42)
	store %ref.int* %0, %ref.int** %x, align 8
	%1 = load %ref.int*, %ref.int** %x, align 8
	call void @"ref:int"(%ref.int* %1)
	store %ref.int* %1, %ref.int** %y, align 8
	%2 = load %ref.int*, %ref.int** %y, align 8
	%3 = getelementptr inbounds %ref.int, %ref.int* %2, i32 0, i32 0
	%4 = load i32*, i32** %3, align 8
	%5 = load i32, i32* %4, align 4
	%6 = call %type.string @".conv:int_string"(i32 %5)
	call void @.println(%type.string %6)
	%7 = load %ref.int*, %ref.int** %x, align 8
	call void @"deref:int"(%ref.int* %7)
	br label %exit

exit:
	ret i32 0
}

declare %ref.int* @"newref:int"(i32 %0)

declare void @"ref:int"(%ref.int* %0)

declare void @"deref:int"(%ref.int* %0)

declare fastcc void @.println(%type.string %0)

declare %type.string @".conv:int_string"(i32 %0)

declare i32 @llvm.ctlz.i32(i32 %0, i1 immarg %1)

declare i32 @llvm.cttz.i32(i32 %0, i1 immarg %1)

declare %type.string @".copy:string"(%type.string %0)

declare void @".free:string"(%type.string %0)

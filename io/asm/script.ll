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
	call void @"deref:int"(%ref.int* %2)
	br label %exit

exit:
	ret void
}

declare %ref.int* @"newref:int"(i32 %0)

declare void @"ref:int"(%ref.int* %0)

declare void @"deref:int"(%ref.int* %0)

define private void @mod.something(%ref.int* %0) {
entry:
	br label %exit

exit:
	ret void
}

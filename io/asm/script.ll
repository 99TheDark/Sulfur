; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }
%ref.int = type { i32*, i32 }

declare %ref.int* @"ref:int"(i32)
declare void @"deref:int"(%ref.int*)
declare i32* @malloc(i32)

define void @main() {
entry:
	%value = alloca i32, align 4
	store i32 52, i32* %value, align 4
	%0 = load i32, i32* %value, align 4
	%ref = call %ref.int* @"ref:int"(i32 %0)
	call void @"deref:int"(%ref.int* %ref)
	br label %exit

exit:
	ret void
}
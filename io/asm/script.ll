; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }
%type.complex = type { float, float }
%ref.int = type { i32*, i32 }

define void @main() {
entry:
	%x = call %ref.int* @"newref:int"(i32 94)
	call void @"ref:int"(%ref.int* %x)
	call void @mod.something(%ref.int* %x)
	call void @"deref:int"(%ref.int* %x)
	br label %exit

exit:
	ret void
}

declare %ref.int* @"newref:int"(i32 %0)

declare void @"ref:int"(%ref.int* %0)

declare void @"deref:int"(%ref.int* %0)

define private void @mod.something(i32 %0) {
entry:
	%1 = call %type.string @".conv:int_string"(i32 %0)
	call void @.println(%type.string %1)
	br label %exit

exit:
	ret void
}

declare void @.println(%type.string %0)

declare %type.string @".conv:int_string"(i32 %0)

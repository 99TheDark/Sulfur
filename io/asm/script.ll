; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }

define void @main() {
entry:
	%x = alloca i32
	store i32 321, i32* %x
	%0 = load i32, i32* %x
	%1 = call %type.string @.conv.int_string(i32 %0)
	call void @.println(%type.string %1)
	br label %exit

exit:
	ret void
}

declare void @.println(%type.string %0)

declare %type.string @.conv.int_string(i32 %0)

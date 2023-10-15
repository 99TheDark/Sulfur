; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }

define void @main() {
entry:
	br label %exit

exit:
	ret void
}

define private void @mod.thing1() {
entry:
	%i = alloca i32
	store i32 0, i32* %i
	br label %exit

exit:
	ret void
}

define private void @mod.thing2() {
entry:
	%i = alloca i32
	store i32 3, i32* %i
	br label %exit

exit:
	ret void
}

declare void @.print(%type.string %0)

declare void @.println(%type.string %0)

declare %type.string @.add.string_string(%type.string %0, %type.string %1)

declare %type.string @.conv.int_string(i32 %0)

declare %type.string @.conv.bool_string(i1 %0)

; ModuleID = 'script.sulfur'
source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

define void @main() {
entry:
	%0 = add i32 5, 3
	%x = alloca i32
	store i32 %0, i32* %x
	br label %exit

exit:
	ret void
}

declare void @.print(%type.string* %0)

declare void @.println(%type.string* %0)

declare i32 @.add.int_int(i32 %0, i32 %1)

declare float @.add.float_float(float %0, float %1)

declare void @.add.string_string(%type.string* %ret, %type.string* %0, %type.string* %1)

declare void @.conv.int_string(%type.string* %ret, i32 %0)

declare void @.conv.bool_string(%type.string* %ret, i1 %0)

source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

define void @main() {
entry:
	%0 = srem i32 5, 2
	%1 = and i32 3, %0
	%2 = alloca %type.string, align 8
	call void @.conv.int_string(%type.string* %2, i32 %1)
	call void @.println(%type.string* %2)
	br label %exit

exit:
	ret void
}

declare void @.print(%type.string* %0)

declare void @.println(%type.string* %0)

declare void @.add.string_string(%type.string* %ret, %type.string* %0, %type.string* %1)

declare void @.conv.int_string(%type.string* %ret, i32 %0)

declare void @.conv.bool_string(%type.string* %ret, i1 %0)

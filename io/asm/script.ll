; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }

define void @main() {
entry:
	br label %exit

exit:
	ret void
}

declare void @.print(%type.string* %0)

declare void @.println(%type.string* %0)

declare void @.add.string_string(%type.string* %ret, %type.string* %0, %type.string* %1)

declare void @.conv.int_string(%type.string* %ret, i32 %0)

declare void @.conv.bool_string(%type.string* %ret, i1 %0)

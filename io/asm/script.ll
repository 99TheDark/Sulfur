; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }

declare void @.println(%type.string)
declare %type.string @.conv.bool_string(i1)

define void @main() {
entry:
    %0 = call %type.string @.conv.bool_string(i1 false)
	call void @.println(%type.string %0)
	br label %exit

exit:
	ret void
}
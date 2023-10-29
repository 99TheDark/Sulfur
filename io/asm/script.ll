; ModuleID = 'script.su'
source_filename = "script.su"

%type.utf8_string = type { i32, i32* }
%type.complex = type { float, float }

define void @main() {
entry:
	%0 = call %type.utf8_string @".conv:int_string"(i32 -632)
	call void @.println(%type.utf8_string %0)
	br label %exit

exit:
	ret void
}

declare void @.println(%type.utf8_string %0)

declare %type.utf8_string @".conv:int_string"(i32 %0)

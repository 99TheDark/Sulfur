; ModuleID = 'script.su'
source_filename = "script.su"

%type.utf8_string = type { i32, i32* }
%type.complex = type { float, float }

define void @main() {
entry:
	%0 = fdiv float 0.0, 0.0
	%1 = call %type.utf8_string @".conv:float_string"(float %0)
	call void @.println(%type.utf8_string %1)
	br label %exit

exit:
	ret void
}

declare void @.println(%type.utf8_string %0)

declare %type.utf8_string @".conv:float_string"(float %0)

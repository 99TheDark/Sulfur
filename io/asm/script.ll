; ModuleID = 'script.su'
source_filename = "script.su"

%type.utf8_string = type { i32, i32* }
%type.complex = type { float, float }

define void @main() {
entry:
    %num = alloca %type.utf8_string
	%0 = call %type.utf8_string @".conv:int_string"(i32 632)
    store %type.utf8_string %0, %type.utf8_string* %num, align 8
	%1 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %num, i32 0, i32 0
    %2 = load i32, i32* %1, align 4
    %3 = call %type.utf8_string @".conv:int_string"(i32 %2)
    call void @.println(%type.utf8_string %3)
	br label %exit

exit:
	ret void
}

declare void @.println(%type.utf8_string %0)

declare %type.utf8_string @".conv:int_string"(i32 %0)

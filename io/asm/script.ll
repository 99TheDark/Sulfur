; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }
%type.complex = type { float, float }

define void @main() {
entry:
	br label %exit

exit:
	ret void
}

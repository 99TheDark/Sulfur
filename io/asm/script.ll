; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }

define void @main() {
entry:
	br i1 true, label %if.then0, label %if.else0

exit:
	ret void

if.then0:
	br label %if.end0

if.else0:
	br label %if.end0

if.end0:
	br label %exit
}

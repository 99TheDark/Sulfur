; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }

define void @main() {
entry:
	%0 = call %type.string @".conv:float_string"(float 0xC1ADE9E9C0000000)
	%x = alloca %type.string
	store %type.string %0, %type.string* %x
	br label %exit

exit:
	ret void
}

declare %type.string @".conv:float_string"(float %0)

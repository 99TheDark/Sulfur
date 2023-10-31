; ModuleID = 'script.su'
source_filename = "script.su"

%type.utf8_string = type { i32, i32* }

define void @main() {
entry:
	%y = alloca i32, align 4
	%z = alloca i32, align 4
	%x = alloca i32, align 4
	store i32 7, i32* %x
	store i32 -7, i32* %y
	store i32 7, i32* %z
	%0 = load i32, i32* %x, align 4
	%1 = call %type.utf8_string @".conv:int_string"(i32 %0)
	call void @.println(%type.utf8_string %1)
	%2 = load i32, i32* %y, align 4
	%3 = call %type.utf8_string @".conv:int_string"(i32 %2)
	call void @.println(%type.utf8_string %3)
	%4 = load i32, i32* %z, align 4
	%5 = call %type.utf8_string @".conv:int_string"(i32 %4)
	call void @.println(%type.utf8_string %5)
	br label %exit

exit:
	ret void
}

declare void @.println(%type.utf8_string %0)

declare %type.utf8_string @".conv:int_string"(i32 %0)

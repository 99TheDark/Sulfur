; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32* }

define void @main() {
entry:
	%x = alloca i32, align 4
	store i32 15, i32* %x
	br label %exit

exit:
	ret void
}

declare %type.string @".copy:string"(%type.string %0)

declare void @".free:string"(%type.string %0)

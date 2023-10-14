; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }

define void @main() {
entry:
	%0 = sub i32 0, 17
	%1 = call i32 @mod.add(i32 54, i32 %0)
	%2 = call %type.string @mod.toString(i32 %1)
	call void @.println(%type.string %2)
	br label %exit

exit:
	ret void
}

define i32 @mod.add(i32 %0, i32 %1) {
entry:
	%.ret = alloca i32
	%2 = add i32 %0, %1
	store i32 %2, i32* %.ret
	br label %exit

exit:
	%3 = load i32, i32* %.ret
	ret i32 %3
}

define %type.string @mod.toString(i32 %0) {
entry:
	%.ret = alloca %type.string
	%1 = call %type.string @.conv.int_string(i32 %0)
	store %type.string %1, %type.string* %.ret, align 8
	br label %exit

exit:
	%2 = load %type.string, %type.string* %.ret
	ret %type.string %2
}

declare void @.print(%type.string %0)

declare void @.println(%type.string %0)

declare %type.string @.add.string_string(%type.string %0, %type.string %1)

declare %type.string @.conv.int_string(i32 %0)

declare %type.string @.conv.bool_string(i1 %0)

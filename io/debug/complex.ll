; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }

declare void @.println(%type.string*)
declare void @.conv.int_string(%type.string*, i32)

define void @main() {
entry:
    %0 = call i32 @mod.add(i32 24, i32 -6)
	%1 = alloca %type.string, align 8
	call void @mod.toString(%type.string* %0, i32 %0)
	call void @.println(%type.string* %0)
	br label %exit

exit:
	ret void
}

define void @mod.toString(%type.string* %.ret, i32 %0) {
entry:
	%1 = alloca %type.string, align 8
	call void @.conv.int_string(%type.string* %1, i32 %0)
	%2 = load %type.string, %type.string* %1
	store %type.string %2, %type.string* %.ret
	br label %exit

exit:
	ret void
}

define i32 @mod.add(i32 %a, i32 %b) {
entry:
    %0 = add i32 %a, %b
    ret i32 %0
}
; ModuleID = 'script.su'
source_filename = "script.su"

%type.utf8_string = type { i32, i32* }

@.str0 = private unnamed_addr constant [21 x i32] [i32 78, i32 111, i32 116, i32 104, i32 105, i32 110, i32 103, i32 32, i32 115, i32 104, i32 111, i32 117, i32 108, i32 100, i32 32, i32 104, i32 97, i32 112, i32 112, i32 101, i32 110], align 4

define void @main() {
entry:
	%0 = call i1 @mod.something()
	br label %exit

exit:
	ret void
}

define private i1 @mod.something() {
entry:
	%.ret = alloca i1
	store i1 true, i1* %.ret
	br label %exit

exit:
	%0 = load i1, i1* %.ret
	ret i1 %0
}

declare void @.println(%type.utf8_string %0)

; ModuleID = 'script.su'
source_filename = "script.su"

%type.utf8_string = type { i32, i32* }

@.str0 = private unnamed_addr constant [18 x i32] [i32 72, i32 101, i32 108, i32 108, i32 111, i32 44, i32 32, i32 34, i32 119, i32 111, i32 114, i32 108, i32 100, i32 33, i32 34, i32 10, i32 958, i32 172300], align 4

define void @main() {
entry:
	%0 = getelementptr inbounds [18 x i32], [18 x i32]* @.str0, i32 0, i32 0
	%1 = alloca %type.utf8_string, align 8
	%2 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %1, i32 0, i32 0
	store i32 18, i32* %2, align 8
	%3 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %1, i32 0, i32 1
	store i32* %0, i32** %3, align 8
	%4 = load %type.utf8_string, %type.utf8_string* %1, align 8
	call void @.println(%type.utf8_string %4)
	br label %exit

exit:
	ret void
}

declare void @.println(%type.utf8_string %0)

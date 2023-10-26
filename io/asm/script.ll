; ModuleID = 'script.su'
source_filename = "script.su"

%type.utf8_string = type { i32, i32* }
%type.complex = type { float, float }

@.str0 = private unnamed_addr constant [8 x i32] [i32 97, i32 957, i32 1490, i32 2827, i32 66370, i32 145838, i32 172300, i32 33], align 4

define void @main() {
entry:
	%0 = getelementptr inbounds [8 x i32], [8 x i32]* @.str0, i32 0, i32 0
	%1 = alloca %type.utf8_string, align 8
	%2 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %1, i32 0, i32 0
	store i32 8, i32* %2, align 8
	%3 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %1, i32 0, i32 1
	store i32* %0, i32** %3, align 8
	%4 = load %type.utf8_string, %type.utf8_string* %1, align 8
	%x = alloca %type.utf8_string
	store %type.utf8_string %4, %type.utf8_string* %x
	%5 = load %type.utf8_string, %type.utf8_string* %x, align 8
	call void @.println(%type.utf8_string %5)
	br label %exit

exit:
	ret void
}

declare void @.println(%type.utf8_string %0)

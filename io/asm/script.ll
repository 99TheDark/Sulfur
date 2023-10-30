; ModuleID = 'script.su'
source_filename = "script.su"

%type.utf8_string = type { i32, i32* }
%type.complex = type { float, float }

@.str0 = private unnamed_addr constant [1 x i32] [i32 60], align 4

define void @main() {
entry:
	%0 = getelementptr inbounds [1 x i32], [1 x i32]* @.str0, i32 0, i32 0
	%1 = alloca %type.utf8_string, align 8
	%2 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %1, i32 0, i32 0
	store i32 1, i32* %2, align 8
	%3 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %1, i32 0, i32 1
	store i32* %0, i32** %3, align 8
	%4 = load %type.utf8_string, %type.utf8_string* %1, align 8
	%5 = call %type.utf8_string @".conv:int_string"(i32 0)
	%6 = call %type.utf8_string @".add:string_string"(%type.utf8_string %4, %type.utf8_string %5)
	call void @.println(%type.utf8_string %6)
	br label %exit

exit:
	ret void
}

declare void @.println(%type.utf8_string %0)

declare %type.utf8_string @".add:string_string"(%type.utf8_string %0, %type.utf8_string %1)

declare %type.utf8_string @".conv:int_string"(i32 %0)

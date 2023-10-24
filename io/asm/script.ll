; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }
%type.complex = type { float, float }

@.str0 = private unnamed_addr constant [13 x i8] c"Hello, world!", align 1

define void @main() {
entry:
	%0 = getelementptr inbounds [13 x i8], [13 x i8]* @.str0, i32 0, i32 0
	%1 = alloca %type.string, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
	store i32 13, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
	store i32 13, i32* %3, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 2
	store i8* %0, i8** %4, align 8
	%5 = load %type.string, %type.string* %1, align 8
	%msg = alloca %type.string
	store %type.string %5, %type.string* %msg
	br label %exit

exit:
	ret void
}

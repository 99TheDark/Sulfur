; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32* }

@.str0 = private unnamed_addr constant [4 x i32] [i32 128075, i32 32, i32 61, i32 32], align 4

define void @main() {
entry:
	%"\F0\9F\91\8B" = alloca i32, align 4
	store i32 3, i32* %"\F0\9F\91\8B"
	%0 = getelementptr inbounds [4 x i32], [4 x i32]* @.str0, i32 0, i32 0
	%1 = alloca %type.string, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
	store i32 4, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
	store i32* %0, i32** %3, align 8
	%4 = load %type.string, %type.string* %1, align 8
	%5 = load i32, i32* %"\F0\9F\91\8B", align 4
	%6 = call %type.string @".conv:int_string"(i32 %5)
	%7 = call %type.string @".add:string_string"(%type.string %4, %type.string %6)
	call void @.println(%type.string %7)
	br label %exit

exit:
	ret void
}

declare void @.println(%type.string %0)

declare %type.string @".add:string_string"(%type.string %0, %type.string %1)

declare %type.string @".conv:int_string"(i32 %0)

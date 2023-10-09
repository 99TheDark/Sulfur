source_filename = "script.sulfur"

; length, size, address
%type.string = type { i32, i32, i8* }

@.str1 = private unnamed_addr constant [19 x i8] c"Hello, world! εⱞ", align 1

declare void @println(%type.string* %str)

define void @main() {
entry:
    %0 = getelementptr inbounds [19 x i8], [19 x i8]* @.str1, i32 0, i32 0
	%greeting = alloca %type.string, align 8
	%1 = getelementptr inbounds %type.string, %type.string* %greeting, i32 0, i32 0
	store i32 16, i32* %1, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %greeting, i32 0, i32 1
	store i32 19, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %greeting, i32 0, i32 2
	store i8* %0, i8** %3, align 8
	call void @println(%type.string* %greeting)
	ret void
}
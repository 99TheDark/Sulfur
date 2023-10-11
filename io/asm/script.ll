source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [2 x i8] c", ", align 1
@.str1 = private unnamed_addr constant [15 x i8] c"The number is: ", align 1

define void @main() {
entry:
	%0 = getelementptr inbounds [15 x i8], [15 x i8]* @.str1, i32 0, i32 0
	%1 = alloca %type.string, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
	store i32 15, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
	store i32 15, i32* %3, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 2
	store i8* %0, i8** %4, align 8
	%5 = sub i32 1, 23480123
	%6 = alloca %type.string, align 8
	call void @.conv.int_string(%type.string* %6, i32 %5)
	%7 = alloca %type.string, align 8
	call void @.add.string_string(%type.string* %7, %type.string* %1, %type.string* %6)
	call void @.println(%type.string* %7)
	ret void
}

declare void @.print(%type.string* %0)

declare void @.println(%type.string* %0)

declare void @.add.string_string(%type.string* %ret, %type.string* %0, %type.string* %1)

declare void @.conv.int_string(%type.string* %ret, i32 %0)

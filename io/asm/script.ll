; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32* }

@.str0 = private unnamed_addr constant [5 x i32] [i32 72, i32 101, i32 108, i32 108, i32 111], align 4
@.str1 = private unnamed_addr constant [5 x i32] [i32 87, i32 111, i32 114, i32 108, i32 100], align 4

define void @main() {
entry:
	%x = alloca %type.string, align 8
	%y = alloca %type.string, align 8
	%0 = getelementptr inbounds [5 x i32], [5 x i32]* @.str0, i32 0, i32 0
	%1 = alloca %type.string, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
	store i32 5, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
	store i32* %0, i32** %3, align 8
	%4 = load %type.string, %type.string* %1, align 8
	store %type.string %4, %type.string* %x
	br i1 true, label %if.then0, label %if.end0

exit:
	ret void

if.then0:
	%5 = getelementptr inbounds [5 x i32], [5 x i32]* @.str1, i32 0, i32 0
	%6 = alloca %type.string, align 8
	%7 = getelementptr inbounds %type.string, %type.string* %6, i32 0, i32 0
	store i32 5, i32* %7, align 8
	%8 = getelementptr inbounds %type.string, %type.string* %6, i32 0, i32 1
	store i32* %5, i32** %8, align 8
	%9 = load %type.string, %type.string* %6, align 8
	store %type.string %9, %type.string* %y
	%10 = load %type.string, %type.string* %y, align 8
	call void @.println(%type.string %10)
	br label %if.end0

if.end0:
	br label %exit
}

declare void @.println(%type.string %0)

; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }

define void @main() {
entry:
	%x = alloca i32
	store i32 0, i32* %x
	br i1 true, label %if.then0, label %if.end0

exit:
	ret void

if.then0:
	%x.1 = alloca i32
	store i32 3, i32* %x.1
	br i1 false, label %if.then1, label %if.end1

if.end0:
	%0 = load i32, i32* %x
	%1 = add i32 %0, 1
	store i32 %1, i32* %x
	br label %exit

if.then1:
	%x.2 = alloca i32
	store i32 0, i32* %x.2
	br label %if.end1

if.end1:
	store i32 6, i32* %x.1
	br label %if.end0
}

declare void @.print(%type.string %0)

declare void @.println(%type.string %0)

declare %type.string @.add.string_string(%type.string %0, %type.string %1)

declare %type.string @.conv.int_string(i32 %0)

declare %type.string @.conv.bool_string(i1 %0)

source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

define void @main() {
entry:
	%i = alloca i32
	store i32 0, i32* %i
	br label %while.body0

exit:
	ret void

while.cond0:
	%0 = load i32, i32* %i
	%1 = icmp sgt i32 %0, 0
	br i1 %1, label %while.body0, label %while.end0

while.body0:
	%2 = load i32, i32* %i
	%3 = alloca %type.string, align 8
	call void @.conv.int_string(%type.string* %3, i32 %2)
	call void @.println(%type.string* %3)
	%4 = load i32, i32* %i
	%5 = sub i32 %4, 1
	store i32 %5, i32* %i
	br label %while.cond0

while.end0:
	br label %exit
}

declare void @.print(%type.string* %0)

declare void @.println(%type.string* %0)

declare void @.add.string_string(%type.string* %ret, %type.string* %0, %type.string* %1)

declare void @.conv.int_string(%type.string* %ret, i32 %0)

declare void @.conv.bool_string(%type.string* %ret, i1 %0)

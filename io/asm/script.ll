; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }

define void @main() {
entry:
	%i = alloca i32
	store i32 0, i32* %i
	br label %for.cond0

exit:
	ret void

for.cond0:
	%0 = load i32, i32* %i
	%1 = icmp slt i32 %0, 10
	br i1 %1, label %for.body0, label %for.end0

for.body0:
	br label %for.inc0

for.inc0:
	%2 = load i32, i32* %i
	%3 = add i32 %2, 1
	store i32 %3, i32* %i
	br label %for.cond0

for.end0:
	%i = alloca i32
	store i32 0, i32* %i
	br label %for.cond1

for.cond1:
	%4 = load i32, i32* %i
	%5 = icmp slt i32 %4, 10
	br i1 %5, label %for.body1, label %for.end1

for.body1:
	br label %for.inc1

for.inc1:
	%6 = load i32, i32* %i
	%7 = add i32 %6, 1
	store i32 %7, i32* %i
	br label %for.cond1

for.end1:
	br label %exit
}

declare void @.print(%type.string %0)

declare void @.println(%type.string %0)

declare %type.string @.add.string_string(%type.string %0, %type.string %1)

declare %type.string @.conv.int_string(i32 %0)

declare %type.string @.conv.bool_string(i1 %0)

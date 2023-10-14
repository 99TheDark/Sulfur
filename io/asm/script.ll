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
	%1 = icmp slt i32 %0, 20
	br i1 %1, label %for.body0, label %for.end0

for.body0:
	%2 = load i32, i32* %i
	%3 = call i32 @mod.fib(i32 %2)
	%4 = alloca %type.string, align 8
	call void @.conv.int_string(%type.string* %4, i32 %3)
	call void @.println(%type.string* %4)
	br label %for.inc0

for.inc0:
	%5 = load i32, i32* %i
	%6 = add i32 %5, 1
	store i32 %6, i32* %i
	br label %for.cond0

for.end0:
	br label %exit
}

define i32 @mod.fib(i32 %0) {
entry:
	%.ret = alloca i32
	%1 = icmp sle i32 %0, 1
	br i1 %1, label %if.then0, label %if.else0

exit:
	%2 = load i32, i32* %.ret
	ret i32 %2

if.then0:
	store i32 1, i32* %.ret
	br label %if.end0

if.else0:
	%3 = sub i32 %0, 2
	%4 = call i32 @mod.fib(i32 %3)
	%5 = sub i32 %0, 1
	%6 = call i32 @mod.fib(i32 %5)
	%7 = add i32 %4, %6
	store i32 %7, i32* %.ret
	br label %if.end0

if.end0:
	br label %exit
}

declare void @.print(%type.string* %0)

declare void @.println(%type.string* %0)

declare void @.add.string_string(%type.string* %.ret, %type.string* %0, %type.string* %1)

declare void @.conv.int_string(%type.string* %.ret, i32 %0)

declare void @.conv.bool_string(%type.string* %.ret, i1 %0)

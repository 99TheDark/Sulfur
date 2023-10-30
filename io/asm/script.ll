; ModuleID = 'script.su'
source_filename = "script.su"

%type.utf8_string = type { i32, i32* }

@.str0 = private unnamed_addr constant [3 x i32] [i32 78, i32 111, i32 33], align 4

define void @main() {
entry:
	%a = alloca i32, align 4
	%i = alloca i32, align 4
	store i32 3, i32* %a
	store i32 0, i32* %i
	br label %for.cond0

exit:
	ret void

for.cond0:
	%0 = load i32, i32* %i, align 4
	%1 = icmp slt i32 %0, 10
	br i1 %1, label %for.body0, label %for.end0

for.body0:
	%2 = load i32, i32* %i, align 4
	%3 = call %type.utf8_string @".conv:int_string"(i32 %2)
	call void @.println(%type.utf8_string %3)
	%4 = getelementptr inbounds [3 x i32], [3 x i32]* @.str0, i32 0, i32 0
	%5 = alloca %type.utf8_string, align 8
	%6 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %5, i32 0, i32 0
	store i32 3, i32* %6, align 8
	%7 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %5, i32 0, i32 1
	store i32* %4, i32** %7, align 8
	%8 = load %type.utf8_string, %type.utf8_string* %5, align 8
	call void @.println(%type.utf8_string %8)
	br label %for.inc0

for.inc0:
	%9 = load i32, i32* %i, align 4
	%10 = add i32 %9, 1
	store i32 %10, i32* %i
	br label %for.cond0

for.end0:
	br label %exit
}

declare void @.println(%type.utf8_string %0)

declare %type.utf8_string @".conv:int_string"(i32 %0)

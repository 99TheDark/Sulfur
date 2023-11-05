; ModuleID = 'test.su'
source_filename = "test.su"

%type.string = type { i32, i32* }

define void @main() {
entry:
	%i = alloca i32, align 4
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
	%3 = call %type.string @".conv:int_string"(i32 %2)
	call void @.println(%type.string %3)
	br label %for.inc0

for.inc0:
	%4 = load i32, i32* %i, align 4
	%5 = add i32 %4, 1
	store i32 %5, i32* %i
	br label %for.cond0

for.end0:
	br label %exit
}

declare fastcc void @.println(%type.string %0)

declare %type.string @".conv:int_string"(i32 %0)

declare i32 @llvm.ctlz.i32(i32 %0, i1 immarg %1)

declare i32 @llvm.cttz.i32(i32 %0, i1 immarg %1)

declare %type.string @".copy:string"(%type.string %0)

declare void @".free:string"(%type.string %0)

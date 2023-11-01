; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32* }

define void @main() {
entry:
	%x = alloca i32, align 4
	%0 = add i32 15, 3
	%1 = sub i32 %0, 6
	store i32 %1, i32* %x
	%2 = load i32, i32* %x, align 4
	%3 = call i32 @llvm.ctlz.i32(i32 %2, i1 false)
	%4 = load i32, i32* %x, align 4
	%5 = call i32 @llvm.cttz.i32(i32 %4, i1 false)
	%6 = add i32 %3, %5
	%7 = call %type.string @".conv:int_string"(i32 %6)
	call void @.println(%type.string %7)
	br label %exit

exit:
	ret void
}

declare void @.println(%type.string %0)

declare %type.string @".conv:int_string"(i32 %0)

declare i32 @llvm.ctlz.i32(i32 %0, i1 immarg %1)

declare i32 @llvm.cttz.i32(i32 %0, i1 immarg %1)

declare %type.string @".copy:string"(%type.string %0)

declare void @".free:string"(%type.string %0)

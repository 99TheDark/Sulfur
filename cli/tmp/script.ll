; ModuleID = 'examples/main/script.su'
source_filename = "examples/main/script.su"

%type.string = type { i32, i32* }

define void @main() {
entry:
	%0 = ashr i32 -5, 3
	%1 = call %type.string @".conv:int_string"(i32 %0)
	call void @.println(%type.string %1)
	%2 = xor i32 5, -1
	%3 = lshr i32 %2, 3
	%4 = call %type.string @".conv:int_string"(i32 %3)
	call void @.println(%type.string %4)
	%5 = shl i32 -5, 3
	%6 = call %type.string @".conv:int_string"(i32 %5)
	call void @.println(%type.string %6)
	%7 = xor i32 5, -1
	%8 = shl i32 %7, 3
	%9 = call %type.string @".conv:int_string"(i32 %8)
	call void @.println(%type.string %9)
	br label %exit

exit:
	ret void
}

declare fastcc void @.println(%type.string %0)

declare %type.string @".conv:int_string"(i32 %0)

declare i32 @llvm.ctlz.i32(i32 %0, i1 immarg %1)

declare i32 @llvm.cttz.i32(i32 %0, i1 immarg %1)

declare %type.string @".copy:string"(%type.string %0)

declare void @".free:string"(%type.string %0)

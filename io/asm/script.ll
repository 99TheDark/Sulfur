; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32* }

define void @main() {
entry:
	%0 = icmp ult i32 3, 10
	%1 = call %type.string @".conv:bool_string"(i1 %0)
	call void @.println(%type.string %1)
	br label %exit

exit:
	ret void
}

declare void @.println(%type.string %0)

declare %type.string @".conv:bool_string"(i1 %0)

declare i32 @llvm.ctlz.i32(i32 %0, i1 immarg %1)

declare i32 @llvm.cttz.i32(i32 %0, i1 immarg %1)

declare %type.string @".copy:string"(%type.string %0)

declare void @".free:string"(%type.string %0)

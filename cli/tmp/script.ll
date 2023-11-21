; ModuleID = 'examples/main/script.su'
source_filename = "examples/main/script.su"

%type.string = type { i32, i32* }
%class.Person = type { %type.string, i32 }

define i32 @main() {
entry:
	br label %exit

exit:
	ret i32 0
}

declare i32 @llvm.ctlz.i32(i32 %0, i1 immarg %1)

declare i32 @llvm.cttz.i32(i32 %0, i1 immarg %1)

declare %type.string @".copy:string"(%type.string %0)

declare void @".free:string"(%type.string %0)

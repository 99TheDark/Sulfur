; ModuleID = 'examples/main/script.su'
source_filename = "examples/main/script.su"

%type.string = type { i32, i32* }

@.str0 = private unnamed_addr constant [5 x i32] [i32 72, i32 101, i32 108, i32 108, i32 111], align 4

define i32 @main() {
entry:
	call void @mod.outer()
	br label %exit

exit:
	ret i32 0
}

define private fastcc void @mod.inner() {
entry:
	%0 = getelementptr inbounds [5 x i32], [5 x i32]* @.str0, i32 0, i32 0
	%1 = alloca %type.string, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
	store i32 5, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
	store i32* %0, i32** %3, align 8
	%4 = load %type.string, %type.string* %1, align 8
	%5 = call %type.string @".copy:string"(%type.string %4)
	call void @.println(%type.string %5)
	br label %exit

exit:
	ret void
}

define private fastcc void @mod.outer() {
entry:
	call void @mod.inner()
	br label %exit

exit:
	ret void
}

declare fastcc void @.println(%type.string %0)

declare i32 @llvm.ctlz.i32(i32 %0, i1 immarg %1)

declare i32 @llvm.cttz.i32(i32 %0, i1 immarg %1)

declare %type.string @".copy:string"(%type.string %0)

declare void @".free:string"(%type.string %0)

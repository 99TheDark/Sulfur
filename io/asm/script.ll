; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32* }
%ref.uint = type { i32*, i32 }

define void @main() {
entry:
	%x = alloca %ref.uint*, align 8
	%0 = call %ref.uint* @"newref:uint"(i32 14)
	store %ref.uint* %0, %ref.uint** %x, align 8
	%1 = load %ref.uint*, %ref.uint** %x, align 8
	call void @"ref:uint"(%ref.uint* %1)
	call void @mod.change(%ref.uint* %1)
	%2 = load %ref.uint*, %ref.uint** %x, align 8
	%3 = getelementptr inbounds %ref.uint, %ref.uint* %2, i32 0, i32 0
	%4 = load i32*, i32** %3, align 8
	%5 = load i32, i32* %4, align 4
	%6 = call %type.string @".conv:uint_string"(i32 %5)
	call void @.println(%type.string %6)
	%7 = load %ref.uint*, %ref.uint** %x, align 8
	call void @"deref:uint"(%ref.uint* %7)
	br label %exit

exit:
	ret void
}

declare %ref.uint* @"newref:uint"(i32 %0)

declare void @"ref:uint"(%ref.uint* %0)

declare void @"deref:uint"(%ref.uint* %0)

define private void @mod.change(%ref.uint* %0) {
entry:
	%1 = getelementptr inbounds %ref.uint, %ref.uint* %0, i32 0, i32 0
	%2 = load i32*, i32** %1, align 8
	%3 = load i32, i32* %2, align 4
	%4 = add i32 %3, 4
	%5 = getelementptr inbounds %ref.uint, %ref.uint* %0, i32 0, i32 0
	%6 = load i32*, i32** %5, align 8
	store i32 %4, i32* %6, align 8
	br label %exit

exit:
	ret void
}

declare void @.println(%type.string %0)

declare %type.string @".conv:uint_string"(i32 %0)

declare i32 @llvm.ctlz.i32(i32 %0, i1 immarg %1)

declare i32 @llvm.cttz.i32(i32 %0, i1 immarg %1)

declare %type.string @".copy:string"(%type.string %0)

declare void @".free:string"(%type.string %0)

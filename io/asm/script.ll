; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }
%ref.int = type { i32*, i32 }

define void @main() {
entry:
	%x = alloca i32
	store i32 100, i32* %x
	%0 = load i32, i32* %x
	%1 = sub i32 %0, 2
	store i32 %1, i32* %x
	%2 = load i32, i32* %x
	%3 = add i32 %2, 1
	store i32 %3, i32* %x
	%4 = load i32, i32* %x
	call void @mod.byValue(i32 %4)
	%5 = load i32, i32* %x
	%6 = call %ref.int* @"ref:int"(i32 %5)
	call void @mod.byRef(%ref.int* %6)
	%7 = load i32, i32* %x
	%8 = call %type.string @".conv:int_string"(i32 %7)
	call void @.println(%type.string %8)
	br label %exit

exit:
	ret void
}

declare %ref.int* @"ref:int"(i32 %0)

declare void @"deref:int"(%ref.int* %0)

define private void @mod.byValue(i32 %0) {
entry:
	%1 = call %type.string @".conv:int_string"(i32 %0)
	call void @.println(%type.string %1)
	br label %exit

exit:
	ret void
}

define private void @mod.byRef(%ref.int* %0) {
entry:
	%1 = getelementptr inbounds %ref.int, %ref.int* %0, i32 0, i32 0
	%2 = load i32*, i32** %1, align 8
	%3 = load i32, i32* %2
	%4 = mul i32 %3, 2
	%5 = getelementptr inbounds %ref.int, %ref.int* %0, i32 0, i32 0
	%6 = load i32*, i32** %5, align 8
	store i32 %4, i32* %6, align 8
	%7 = getelementptr inbounds %ref.int, %ref.int* %0, i32 0, i32 0
	%8 = load i32*, i32** %7, align 8
	%9 = load i32, i32* %8
	%10 = call %type.string @".conv:int_string"(i32 %9)
	call void @.println(%type.string %10)
	br label %exit

exit:
	ret void
}

declare void @.println(%type.string %0)

declare %type.string @".conv:int_string"(i32 %0)

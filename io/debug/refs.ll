; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32* }
%ref.int = type { i32*, i32 }

define void @main() {
entry:
	%x = call %ref.int* @"ref:int"(i32 100)
	%0 = getelementptr inbounds %ref.int, %ref.int* %x, i32 0, i32 0
	%1 = load i32*, i32** %0, align 8
  	%2 = load i32, i32* %1, align 4
	call void @mod.byValue(i32 %2)
	call void @mod.byRef(%ref.int* %x)
  	%3 = load i32, i32* %1, align 4
	%4 = call %type.string @".conv:int_string"(i32 %3)
	call void @.println(%type.string %4)
	call void @"deref:int"(%ref.int* %x)
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
	%3 = load i32, i32* %2, align 4
	%4 = mul i32 %3, 2
	store i32 %4, i32* %2, align 4
	br label %exit

exit:
	ret void
}

declare void @.println(%type.string %0)

declare %type.string @".conv:int_string"(i32 %0)
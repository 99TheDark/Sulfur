; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }
%ref.int = type { i32*, i32 }

define void @main() {
entry:
	%x = call %ref.int* @"newref:int"(i32 499)
	%0 = getelementptr inbounds %ref.int, %ref.int* %x, i32 0, i32 0
	%1 = load i32*, i32** %0, align 8
	%2 = load i32, i32* %1, align 4
	%3 = call %type.string @".conv:int_string"(i32 %2)
	call void @.println(%type.string %3)
	call void @"ref:int"(%ref.int* %x)
	call void @mod.applyRec(%ref.int* %x)
	%4 = getelementptr inbounds %ref.int, %ref.int* %x, i32 0, i32 0
	%5 = load i32*, i32** %4, align 8
	%6 = load i32, i32* %5, align 4
	%7 = call %type.string @".conv:int_string"(i32 %6)
	call void @.println(%type.string %7)
	call void @"deref:int"(%ref.int* %x)
	br label %exit

exit:
	ret void
}

declare %ref.int* @"newref:int"(i32 %0)

declare void @"ref:int"(%ref.int* %0)

declare void @"deref:int"(%ref.int* %0)

define private void @mod.applyRec(%ref.int* %0) {
entry:
	%1 = getelementptr inbounds %ref.int, %ref.int* %0, i32 0, i32 0
	%2 = load i32*, i32** %1, align 8
	%3 = load i32, i32* %2, align 4
	%4 = srem i32 %3, 3
	%5 = icmp eq i32 %4, 0
	br i1 %5, label %if.then0, label %if.else0

exit:
	ret void

if.then0:
	%6 = getelementptr inbounds %ref.int, %ref.int* %0, i32 0, i32 0
	%7 = load i32*, i32** %6, align 8
	%8 = load i32, i32* %7, align 4
	%9 = add i32 %8, 1
	%10 = getelementptr inbounds %ref.int, %ref.int* %0, i32 0, i32 0
	%11 = load i32*, i32** %10, align 8
	store i32 %9, i32* %11, align 8
	br label %if.end0

if.else0:
	%12 = getelementptr inbounds %ref.int, %ref.int* %0, i32 0, i32 0
	%13 = load i32*, i32** %12, align 8
	%14 = load i32, i32* %13, align 4
	%15 = sub i32 %14, 71
	%16 = getelementptr inbounds %ref.int, %ref.int* %0, i32 0, i32 0
	%17 = load i32*, i32** %16, align 8
	store i32 %15, i32* %17, align 8
	call void @"ref:int"(%ref.int* %0)
	call void @mod.applyRec(%ref.int* %0)
	call void @"deref:int"(%ref.int* %0)
	br label %if.end0

if.end0:
	br label %exit
}

declare void @.println(%type.string %0)

declare %type.string @".conv:int_string"(i32 %0)

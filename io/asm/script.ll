; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }
%ref.bool = type { i1*, i32 }

define void @main() {
entry:
	%x = call %ref.bool* @"newref:bool"(i1 true)
	%0 = getelementptr inbounds %ref.bool, %ref.bool* %x, i32 0, i32 0
	%1 = load i1*, i1** %0, align 8
	%2 = load i1, i1* %1, align 1
	%3 = call %type.string @".conv:bool_string"(i1 %2)
	call void @.println(%type.string %3)
	call void @"ref:bool"(%ref.bool* %x)
	call void @mod.applyRec(%ref.bool* %x)
	%4 = getelementptr inbounds %ref.bool, %ref.bool* %x, i32 0, i32 0
	%5 = load i1*, i1** %4, align 8
	%6 = load i1, i1* %5, align 1
	%7 = call %type.string @".conv:bool_string"(i1 %6)
	call void @.println(%type.string %7)
	call void @"deref:bool"(%ref.bool* %x)
	br label %exit

exit:
	ret void
}

declare %ref.bool* @"newref:bool"(i1 %0)

declare void @"ref:bool"(%ref.bool* %0)

declare void @"deref:bool"(%ref.bool* %0)

define private void @mod.applyRec(%ref.bool* %0) {
entry:
	%1 = getelementptr inbounds %ref.bool, %ref.bool* %0, i32 0, i32 0
	%2 = load i1*, i1** %1, align 8
	%3 = load i1, i1* %2, align 1
	%4 = icmp eq i1 %3, 0
	br i1 %4, label %if.then0, label %if.end0

exit:
	ret void

if.then0:
	%5 = getelementptr inbounds %ref.bool, %ref.bool* %0, i32 0, i32 0
	%6 = load i1*, i1** %5, align 8
	%7 = load i1, i1* %6, align 1
	%8 = icmp eq i1 %7, 0
	%9 = getelementptr inbounds %ref.bool, %ref.bool* %0, i32 0, i32 0
	%10 = load i1*, i1** %9, align 8
	store i1 %8, i1* %10, align 8
	call void @"ref:bool"(%ref.bool* %0)
	call void @mod.applyRec(%ref.bool* %0)
	call void @"deref:bool"(%ref.bool* %0)
	br label %if.end0

if.end0:
	br label %exit
}

declare void @.println(%type.string %0)

declare %type.string @".conv:bool_string"(i1 %0)

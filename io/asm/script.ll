; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }
%ref.string = type { %type.string, i32 }

@.str0 = private unnamed_addr constant [5 x i8] c"Hello", align 1
@.str1 = private unnamed_addr constant [5 x i8] c"World", align 1

define void @main() {
entry:
	%0 = getelementptr inbounds [5 x i8], [5 x i8]* @.str0, i32 0, i32 0
	%1 = alloca %type.string, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
	store i32 5, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
	store i32 5, i32* %3, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 2
	store i8* %0, i8** %4, align 8
	%5 = load %type.string, %type.string* %1, align 8
	%x = alloca %type.string
	store %type.string %5, %type.string* %x
	%6 = load %type.string, %type.string* %x
	call void @mod.byValue(%type.string %6)
	%7 = load %type.string, %type.string* %x
	%8 = call %ref.string* @"ref:string"(%type.string %7)
	call void @mod.byRef(%ref.string* %8)
	%9 = load %type.string, %type.string* %x
	call void @.println(%type.string %9)
	br label %exit

exit:
	ret void
}

define private void @mod.byValue(%type.string %0) {
entry:
	call void @.println(%type.string %0)
	br label %exit

exit:
	ret void
}

define private void @mod.byRef(%type.string %0) {
entry:
	%1 = getelementptr inbounds [5 x i8], [5 x i8]* @.str1, i32 0, i32 0
	%2 = alloca %type.string, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %2, i32 0, i32 0
	store i32 5, i32* %3, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %2, i32 0, i32 1
	store i32 5, i32* %4, align 8
	%5 = getelementptr inbounds %type.string, %type.string* %2, i32 0, i32 2
	store i8* %1, i8** %5, align 8
	%6 = load %type.string, %type.string* %2, align 8
	br label %exit

exit:
	ret void
}

declare void @.println(%type.string %0)

declare %ref.string* @"ref:string"(%type.string %0)

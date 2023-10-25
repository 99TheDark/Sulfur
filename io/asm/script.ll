; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }
%type.complex = type { float, float }

@.str0 = private unnamed_addr constant [11 x i8] c"it happened", align 1
@.str1 = private unnamed_addr constant [2 x i8] c"no", align 1

define void @main() {
entry:
	%0 = call i32 @mod.add(i32 3, i32 1)
	call void @mod.doSomething()
	br label %exit

exit:
	ret void
}

define private i32 @mod.add(i32 %0, i32 %1) {
entry:
	%.ret = alloca i32
	%2 = add i32 %0, %1
	store i32 %2, i32* %.ret
	br label %exit

exit:
	%3 = load i32, i32* %.ret
	ret i32 %3
}

define private void @mod.doSomething() {
entry:
	br label %while.cond0

exit:
	ret void

while.cond0:
	br i1 true, label %while.body0, label %while.end0

while.body0:
	%0 = getelementptr inbounds [11 x i8], [11 x i8]* @.str0, i32 0, i32 0
	%1 = alloca %type.string, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
	store i32 11, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
	store i32 11, i32* %3, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 2
	store i8* %0, i8** %4, align 8
	%5 = load %type.string, %type.string* %1, align 8
	call void @.println(%type.string %5)
	%6 = getelementptr inbounds [2 x i8], [2 x i8]* @.str1, i32 0, i32 0
	%7 = alloca %type.string, align 8
	%8 = getelementptr inbounds %type.string, %type.string* %7, i32 0, i32 0
	store i32 2, i32* %8, align 8
	%9 = getelementptr inbounds %type.string, %type.string* %7, i32 0, i32 1
	store i32 2, i32* %9, align 8
	%10 = getelementptr inbounds %type.string, %type.string* %7, i32 0, i32 2
	store i8* %6, i8** %10, align 8
	%11 = load %type.string, %type.string* %7, align 8
	call void @.println(%type.string %11)
	br label %exit

while.end0:
	br label %exit
}

declare void @.println(%type.string %0)

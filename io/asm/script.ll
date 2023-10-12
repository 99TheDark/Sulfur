source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [8 x i8] c"It took ", align 1
@.str1 = private unnamed_addr constant [11 x i8] c" iterations", align 1

define void @main() {
entry:
	%num = alloca float
	store float 0x408D266660000000, float* %num
	%i = alloca i32
	store i32 0, i32* %i
	br label %while.cond0

exit:
	ret void

while.cond0:
	%0 = load float, float* %num
	%1 = frem float %0, 1.0
	%2 = fcmp one float %1, 0.0
	br i1 %2, label %while.body0, label %while.end0

while.body0:
	%3 = load float, float* %num
	%4 = fsub float %3, 0x3FB9999980000000
	store float %4, float* %num
	%5 = load i32, i32* %i
	%6 = add i32 %5, 1
	store i32 %6, i32* %i
	br label %while.cond0

while.end0:
	%7 = getelementptr inbounds [8 x i8], [8 x i8]* @.str0, i32 0, i32 0
	%8 = alloca %type.string, align 8
	%9 = getelementptr inbounds %type.string, %type.string* %8, i32 0, i32 0
	store i32 8, i32* %9, align 8
	%10 = getelementptr inbounds %type.string, %type.string* %8, i32 0, i32 1
	store i32 8, i32* %10, align 8
	%11 = getelementptr inbounds %type.string, %type.string* %8, i32 0, i32 2
	store i8* %7, i8** %11, align 8
	%12 = load i32, i32* %i
	%13 = alloca %type.string, align 8
	call void @.conv.int_string(%type.string* %13, i32 %12)
	%14 = alloca %type.string, align 8
	call void @.add.string_string(%type.string* %14, %type.string* %8, %type.string* %13)
	%15 = getelementptr inbounds [11 x i8], [11 x i8]* @.str1, i32 0, i32 0
	%16 = alloca %type.string, align 8
	%17 = getelementptr inbounds %type.string, %type.string* %16, i32 0, i32 0
	store i32 11, i32* %17, align 8
	%18 = getelementptr inbounds %type.string, %type.string* %16, i32 0, i32 1
	store i32 11, i32* %18, align 8
	%19 = getelementptr inbounds %type.string, %type.string* %16, i32 0, i32 2
	store i8* %15, i8** %19, align 8
	%20 = alloca %type.string, align 8
	call void @.add.string_string(%type.string* %20, %type.string* %14, %type.string* %16)
	call void @.println(%type.string* %20)
	br label %exit
}

declare void @.print(%type.string* %0)

declare void @.println(%type.string* %0)

declare void @.add.string_string(%type.string* %ret, %type.string* %0, %type.string* %1)

declare void @.conv.int_string(%type.string* %ret, i32 %0)

declare void @.conv.bool_string(%type.string* %ret, i1 %0)

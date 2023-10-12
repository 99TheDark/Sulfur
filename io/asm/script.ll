source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [1 x i8] c" ", align 1
@.str1 = private unnamed_addr constant [0 x i8] c"", align 1

define void @main() {
entry:
	%i = alloca i32
	store i32 0, i32* %i
	br label %for.cond0

for.cond0:
	%0 = load i32, i32* %i
	%1 = icmp slt i32 %0, 10
	br i1 %1, label %for.body0, label %for.end0

for.body0:
	%2 = load i32, i32* %i
	%3 = alloca %type.string, align 8
	call void @.conv.int_string(%type.string* %3, i32 %2)
	%4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str0, i32 0, i32 0
	%5 = alloca %type.string, align 8
	%6 = getelementptr inbounds %type.string, %type.string* %5, i32 0, i32 0
	store i32 1, i32* %6, align 8
	%7 = getelementptr inbounds %type.string, %type.string* %5, i32 0, i32 1
	store i32 1, i32* %7, align 8
	%8 = getelementptr inbounds %type.string, %type.string* %5, i32 0, i32 2
	store i8* %4, i8** %8, align 8
	%9 = alloca %type.string, align 8
	call void @.add.string_string(%type.string* %9, %type.string* %3, %type.string* %5)
	call void @.print(%type.string* %9)
	br label %for.inc0

for.inc0:
	%10 = load i32, i32* %i
	%11 = add i32 %10, 1
	store i32 %11, i32* %i
	br label %for.cond0

for.end0:
	%12 = getelementptr inbounds [0 x i8], [0 x i8]* @.str1, i32 0, i32 0
	%13 = alloca %type.string, align 8
	%14 = getelementptr inbounds %type.string, %type.string* %13, i32 0, i32 0
	store i32 0, i32* %14, align 8
	%15 = getelementptr inbounds %type.string, %type.string* %13, i32 0, i32 1
	store i32 0, i32* %15, align 8
	%16 = getelementptr inbounds %type.string, %type.string* %13, i32 0, i32 2
	store i8* %12, i8** %16, align 8
	call void @.println(%type.string* %13)
	ret void
}

declare void @.print(%type.string* %0)

declare void @.println(%type.string* %0)

declare void @.add.string_string(%type.string* %ret, %type.string* %0, %type.string* %1)

declare void @.conv.int_string(%type.string* %ret, i32 %0)

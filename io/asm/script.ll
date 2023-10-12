source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [4 x i8] c"1 1 ", align 1
@.str1 = private unnamed_addr constant [1 x i8] c" ", align 1
@.str2 = private unnamed_addr constant [1 x i8] c"\0A", align 1

define void @main() {
entry:
	%0 = getelementptr inbounds [4 x i8], [4 x i8]* @.str0, i32 0, i32 0
	%1 = alloca %type.string, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
	store i32 4, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
	store i32 4, i32* %3, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 2
	store i8* %0, i8** %4, align 8
	%str = alloca %type.string*
	store %type.string* %1, %type.string** %str
	%n1 = alloca i32
	store i32 1, i32* %n1
	%n2 = alloca i32
	store i32 1, i32* %n2
	%i = alloca i32
	store i32 0, i32* %i
	br label %for.cond0

exit:
	ret void

for.cond0:
	%5 = load i32, i32* %i
	%6 = icmp slt i32 %5, 40
	br i1 %6, label %for.body0, label %for.end0

for.body0:
	%7 = load i32, i32* %n1
	%8 = load i32, i32* %n2
	%9 = add i32 %7, %8
	%sum = alloca i32
	store i32 %9, i32* %sum
	%10 = load %type.string*, %type.string** %str
	%11 = load i32, i32* %sum
	%12 = alloca %type.string, align 8
	call void @.conv.int_string(%type.string* %12, i32 %11)
	%13 = getelementptr inbounds [1 x i8], [1 x i8]* @.str1, i32 0, i32 0
	%14 = alloca %type.string, align 8
	%15 = getelementptr inbounds %type.string, %type.string* %14, i32 0, i32 0
	store i32 1, i32* %15, align 8
	%16 = getelementptr inbounds %type.string, %type.string* %14, i32 0, i32 1
	store i32 1, i32* %16, align 8
	%17 = getelementptr inbounds %type.string, %type.string* %14, i32 0, i32 2
	store i8* %13, i8** %17, align 8
	%18 = alloca %type.string, align 8
	call void @.add.string_string(%type.string* %18, %type.string* %12, %type.string* %14)
	%19 = alloca %type.string, align 8
	call void @.add.string_string(%type.string* %19, %type.string* %10, %type.string* %18)
	store %type.string* %19, %type.string** %str
	%20 = load i32, i32* %n2
	store i32 %20, i32* %n1
	%21 = load i32, i32* %sum
	store i32 %21, i32* %n2
	%22 = load i32, i32* %i
	%23 = icmp ne i32 %22, 0
	%24 = load i32, i32* %i
	%25 = srem i32 %24, 10
	%26 = icmp eq i32 %25, 0
	%27 = and i1 %23, %26
	br i1 %27, label %if.then1, label %if.end1

for.inc0:
	%28 = load i32, i32* %i
	%29 = add i32 %28, 1
	store i32 %29, i32* %i
	br label %for.cond0

for.end0:
	%30 = load %type.string*, %type.string** %str
	call void @.println(%type.string* %30)
	br label %exit

if.then1:
	%31 = load %type.string*, %type.string** %str
	%32 = getelementptr inbounds [1 x i8], [1 x i8]* @.str2, i32 0, i32 0
	%33 = alloca %type.string, align 8
	%34 = getelementptr inbounds %type.string, %type.string* %33, i32 0, i32 0
	store i32 1, i32* %34, align 8
	%35 = getelementptr inbounds %type.string, %type.string* %33, i32 0, i32 1
	store i32 1, i32* %35, align 8
	%36 = getelementptr inbounds %type.string, %type.string* %33, i32 0, i32 2
	store i8* %32, i8** %36, align 8
	%37 = alloca %type.string, align 8
	call void @.add.string_string(%type.string* %37, %type.string* %31, %type.string* %33)
	store %type.string* %37, %type.string** %str
	br label %if.end1

if.end1:
	br label %for.inc0
}

declare void @.print(%type.string* %0)

declare void @.println(%type.string* %0)

declare void @.add.string_string(%type.string* %ret, %type.string* %0, %type.string* %1)

declare void @.conv.int_string(%type.string* %ret, i32 %0)

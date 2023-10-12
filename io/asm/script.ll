; ModuleID = 'script.sulfur'
source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [7 x i8] c"Hello, ", align 1
@.str1 = private unnamed_addr constant [5 x i8] c"world", align 1

define void @main() {
entry:
	%0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str0, i32 0, i32 0
	%1 = alloca %type.string, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
	store i32 7, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
	store i32 7, i32* %3, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 2
	store i8* %0, i8** %4, align 8
	%x = alloca %type.string*
	store %type.string* %1, %type.string** %x
	%5 = getelementptr inbounds [5 x i8], [5 x i8]* @.str1, i32 0, i32 0
	%6 = alloca %type.string, align 8
	%7 = getelementptr inbounds %type.string, %type.string* %6, i32 0, i32 0
	store i32 5, i32* %7, align 8
	%8 = getelementptr inbounds %type.string, %type.string* %6, i32 0, i32 1
	store i32 5, i32* %8, align 8
	%9 = getelementptr inbounds %type.string, %type.string* %6, i32 0, i32 2
	store i8* %5, i8** %9, align 8
	%y = alloca %type.string*
	store %type.string* %6, %type.string** %y
	%10 = load %type.string*, %type.string** %x
	%11 = load %type.string*, %type.string** %y
	%12 = alloca %type.string, align 8
	call void @.add.string_string(%type.string* %12, %type.string* %10, %type.string* %11)
	call void @.println(%type.string* %12)
	br label %exit

exit:
	ret void
}

declare void @.print(%type.string* %0)

declare void @.println(%type.string* %0)

declare i32 @.add.int_int(i32 %0, i32 %1)

declare i32 @.sub.int_int(i32 %0, i32 %1)

declare i32 @.mul.int_int(i32 %0, i32 %1)

declare i32 @.div.int_int(i32 %0, i32 %1)

declare i32 @.rem.int_int(i32 %0, i32 %1)

declare i32 @.or.int_int(i32 %0, i32 %1)

declare i32 @.and.int_int(i32 %0, i32 %1)

declare i32 @.nor.int_int(i32 %0, i32 %1)

declare i32 @.nand.int_int(i32 %0, i32 %1)

declare float @.add.float_float(float %0, float %1)

declare float @.sub.float_float(float %0, float %1)

declare float @.mul.float_float(float %0, float %1)

declare float @.div.float_float(float %0, float %1)

declare float @.rem.float_float(float %0, float %1)

declare i1 @.or.bool_bool(i1 %0, i1 %1)

declare i1 @.and.bool_bool(i1 %0, i1 %1)

declare i1 @.nor.bool_bool(i1 %0, i1 %1)

declare i1 @.nand.bool_bool(i1 %0, i1 %1)

declare void @.add.string_string(%type.string* %ret, %type.string* %0, %type.string* %1)

declare void @.conv.int_string(%type.string* %ret, i32 %0)

declare void @.conv.bool_string(%type.string* %ret, i1 %0)

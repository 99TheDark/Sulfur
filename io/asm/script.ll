source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

define void @main() {
entry:
	%0 = icmp ne i32 5, 0
	%1 = icmp ne i32 5, 0
	%2 = zext i1 %1 to i32
	%3 = sitofp i32 %2 to float
	%4 = icmp ne i32 5, 0
	%5 = icmp ne i32 5, 0
	%6 = zext i1 %5 to i32
	%7 = sitofp i32 %6 to float
	%8 = fptosi float %7 to i32
	%9 = mul i32 %8, 3
	%10 = sitofp i32 0 to float
	%11 = sitofp i32 0 to float
	%12 = fptosi float %11 to i32
	%13 = mul i32 %12, 2
	%14 = add i32 %9, %13
	%x = alloca i32
	store i32 %14, i32* %x
	%15 = load i32, i32* %x
	%16 = alloca %type.string, align 8
	call void @.conv.int_string(%type.string* %16, i32 %15)
	call void @.println(%type.string* %16)
	br label %exit

exit:
	ret void
}

declare void @.print(%type.string* %0)

declare void @.println(%type.string* %0)

declare void @.add.string_string(%type.string* %ret, %type.string* %0, %type.string* %1)

declare void @.conv.int_string(%type.string* %ret, i32 %0)

declare void @.conv.bool_string(%type.string* %ret, i1 %0)

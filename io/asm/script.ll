source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

define void @main() {
entry:
	%0 = icmp ne i32 42, 0
	%1 = alloca %type.string, align 8
	call void @.conv.bool_string(%type.string* %1, i1 %0)
	call void @.println(%type.string* %1)
	%2 = icmp ne i32 0, 0
	%3 = alloca %type.string, align 8
	call void @.conv.bool_string(%type.string* %3, i1 %2)
	call void @.println(%type.string* %3)
	%4 = fsub float 0.0, 0x3FF9999980000000
	%5 = fsub float 0.0, 0x3FF9999980000000
	%6 = fcmp one float %5, 0.0
	%7 = alloca %type.string, align 8
	call void @.conv.bool_string(%type.string* %7, i1 %6)
	call void @.println(%type.string* %7)
	%8 = fsub float 0x400B333320000000, 0x400B333320000000
	%9 = fsub float 0x400B333320000000, 0x400B333320000000
	%10 = fcmp one float %9, 0.0
	%11 = alloca %type.string, align 8
	call void @.conv.bool_string(%type.string* %11, i1 %10)
	call void @.println(%type.string* %11)
	br label %exit

exit:
	ret void
}

declare void @.print(%type.string* %0)

declare void @.println(%type.string* %0)

declare void @.add.string_string(%type.string* %ret, %type.string* %0, %type.string* %1)

declare void @.conv.int_string(%type.string* %ret, i32 %0)

declare void @.conv.bool_string(%type.string* %ret, i1 %0)

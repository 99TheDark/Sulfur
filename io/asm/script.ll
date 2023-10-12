; ModuleID = 'script.sulfur'
source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

define void @main() {
entry:
	%x = alloca float
	store float 3.5, float* %x
	%0 = load float, float* %x
	%1 = fadd float %0, 0x4000CCCCC0000000
	store float %1, float* %x
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

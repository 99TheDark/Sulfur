source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [5 x i8] c"Hello", align 1

define void @main() {
entry:
	%0 = alloca %type.string, align 8
  	call void @int_string(%type.string* %0, i32 1443)
	call void @println(%type.string* %0)
	ret void
}

declare void @print(%type.string* %0)
declare void @println(%type.string* %0)
declare void @concat(%type.string* %0, %type.string* %1, %type.string* %2)
declare void @int_string(%type.string* %0, i32 %1)

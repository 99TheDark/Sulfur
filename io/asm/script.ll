source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

define void @main() {
entry:
	ret void
}

declare void @print(%type.string* %0)

declare void @println(%type.string* %0)

declare void @concat(%type.string* %0, %type.string* %1, %type.string* %2)

declare void @int_string(%type.string* %0, i32 %1)

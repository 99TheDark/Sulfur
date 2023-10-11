source_filename = "script.sulfur"

%type.string = type { i32, i32, i8* }

declare void @.print(%type.string*)
declare void @.println(%type.string*)
declare void @.add.string_string(%type.string*, %type.string*, %type.string*)
declare void @.conv.int_string(%type.string*, i32)

define void @main() {
entry:
	%0 = alloca %type.string, align 8
	call void @.conv.int_string(%type.string* %0, i32 -13405426)
	%x = alloca %type.string*
	store %type.string* %0, %type.string** %x
	%1 = load %type.string*, %type.string** %x, align 8
	call void @.println(%type.string* %1)
	ret void
}

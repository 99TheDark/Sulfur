source_filename = "lib/builtin/autofree/free_auto_msg.ll"

%type.string = type { i32, i32* }

@.str0 = private unnamed_addr constant [19 x i32] [i32 65, i32 117, i32 116, i32 111, i32 109, i32 97, i32 116, i32 105, i32 99, i32 97, i32 108, i32 108, i32 121, i32 32, i32 102, i32 114, i32 101, i32 101, i32 100], align 4

declare fastcc %type.string @".copy:string"(%type.string)
declare fastcc void @.println(%type.string)

define fastcc void @freeAutoMsg() {
entry:
	%0 = getelementptr inbounds [19 x i32], [19 x i32]* @.str0, i32 0, i32 0
	%1 = alloca %type.string, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
	store i32 19, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
	store i32* %0, i32** %3, align 8
	%4 = load %type.string, %type.string* %1, align 8
	%5 = call %type.string @".copy:string"(%type.string %4)
	call void @.println(%type.string %5)
	br label %exit

exit:
	ret void
}
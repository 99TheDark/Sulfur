source_filename = "lib/builtin/reference/free_msg.ll"

%type.string = type { i32, i32* }

declare void @.println(%type.string %0)
declare %type.string @".add:string_string"(%type.string %0, %type.string %1)
declare %type.string @".conv:int_string"(i32 %0)

@.strFree = private unnamed_addr constant [17 x i32] [i32 70, i32 114, i32 101, i32 101, i32 100, i32 32, i32 102, i32 114, i32 111, i32 109, i32 32, i32 109, i32 101, i32 109, i32 111, i32 114, i32 121], align 4
@.strCount = private unnamed_addr constant [13 x i32] [i32 32, i32 114, i32 101, i32 102, i32 101, i32 114, i32 101, i32 110, i32 99, i32 101, i32 40, i32 115, i32 41], align 4

define void @freeMsg() {
entry:
	%0 = getelementptr inbounds [17 x i32], [17 x i32]* @.strFree, i32 0, i32 0
	%1 = alloca %type.string, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
	store i32 17, i32* %2, align 4
	%3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
	store i32* %0, i32** %3, align 8
	%4 = load %type.string, %type.string* %1, align 8
	call void @.println(%type.string %4)
	ret void
}

define void @countMsg(i32 %0) {
entry:
	%1 = call %type.string @".conv:int_string"(i32 %0)
	%2 = getelementptr inbounds [13 x i32], [13 x i32]* @.strCount, i32 0, i32 0
	%3 = alloca %type.string, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 0
	store i32 13, i32* %4, align 8
	%5 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 1
	store i32* %2, i32** %5, align 8
	%6 = load %type.string, %type.string* %3, align 8
	%7 = call %type.string @".add:string_string"(%type.string %1, %type.string %6)
	call void @.println(%type.string %7)
	ret void
}
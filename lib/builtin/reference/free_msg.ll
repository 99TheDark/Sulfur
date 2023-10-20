source_filename = "lib/builtin/reference/free_msg"

%type.string = type { i32, i32, i8* }

@.strFree = private unnamed_addr constant [17 x i8] c"Freed from memory", align 1
@.strCount = private unnamed_addr constant [11 x i8] c" references", align 1

declare void @.println(%type.string %0)
declare %type.string @".add:string_string"(%type.string %0, %type.string %1)
declare %type.string @".conv:int_string"(i32 %0)

define void @freeMsg() {
entry:
	%0 = getelementptr inbounds [17 x i8], [17 x i8]* @.strFree, i32 0, i32 0
	%1 = alloca %type.string, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
	store i32 17, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
	store i32 17, i32* %3, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 2
	store i8* %0, i8** %4, align 8
	%5 = load %type.string, %type.string* %1, align 8
	call void @.println(%type.string %5)
	ret void
}

define void @countMsg(i32 %0) {
entry:
	%1 = call %type.string @".conv:int_string"(i32 %0)
	%2 = getelementptr inbounds [11 x i8], [11 x i8]* @.strCount, i32 0, i32 0
	%3 = alloca %type.string, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 0
	store i32 11, i32* %4, align 8
	%5 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 1
	store i32 11, i32* %5, align 8
	%6 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 2
	store i8* %2, i8** %6, align 8
	%7 = load %type.string, %type.string* %3, align 8
	%8 = call %type.string @".add:string_string"(%type.string %1, %type.string %7)
	call void @.println(%type.string %8)
	ret void
}
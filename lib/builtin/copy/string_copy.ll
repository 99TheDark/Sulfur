source_filename = "lib/builtin/copy/string_copy.ll"

%type.string = type { i32, i32, i8* }

declare i8* @malloc(i32)

define %type.string @".copy:string"(%type.string %str) {
entry:
    %ptr.str = alloca %type.string, align 8
	store %type.string %str, %type.string* %ptr.str, align 8
    %0 = getelementptr inbounds %type.string, %type.string* %ptr.str, i32 0, i32 0
    %1 = load i32, i32* %0, align 8
    store i32 %1, i32* %0, align 4
	%2 = getelementptr inbounds %type.string, %type.string* %ptr.str, i32 0, i32 1
    %3 = load i32, i32* %2, align 8
    store i32 %3, i32* %2, align 4
	%4 = getelementptr inbounds %type.string, %type.string* %ptr.str, i32 0, i32 2
    %5 = call i8* @malloc(i32 %3)
    store i8* %5, i8** %4, align 8
    %6 = load %type.string, %type.string* %ptr.str, align 8
    ret %type.string %6
}
source_filename = "lib/builtin/autofree/free_string.ll"

%type.string = type { i32, i32* }

declare void @free(i8*)

define fastcc void @".free:string"(%type.string %str) {
entry:
    %ptr.str = alloca %type.string, align 8
    store %type.string %str, %type.string* %ptr.str, align 8
    %0 = getelementptr inbounds %type.string, %type.string* %ptr.str, i32 0, i32 1
    %1 = load i32*, i32** %0, align 8
    %2 = bitcast i32* %1 to i8*
    call void @free(i8* %2)
    ret void
}
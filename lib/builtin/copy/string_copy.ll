source_filename = "lib/builtin/copy/string_copy.ll"

%type.string = type { i32, i32* }

declare i8* @malloc(i32)

declare void @llvm.memcpy.p0i32.p0i32.i32(i32* noalias nocapture writeonly, i32* noalias nocapture readonly, i32, i1 immarg)

define fastcc %type.string @".copy:string"(%type.string %str) {
entry:
    %.ret = alloca %type.string, align 8
    %ptr.str = alloca %type.string, align 8
	store %type.string %str, %type.string* %ptr.str, align 8
    %0 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
    %1 = getelementptr inbounds %type.string, %type.string* %ptr.str, i32 0, i32 0
    %2 = load i32, i32* %1, align 4
    store i32 %2, i32* %0
    %3 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
    %4 = mul i32 %2, 4
    %5 = call i8* @malloc(i32 %4)
    %6 = bitcast i8* %5 to i32*
    %7 = getelementptr inbounds %type.string, %type.string* %ptr.str, i32 0, i32 1
    %8 = load i32*, i32** %7, align 8
    call void @llvm.memcpy.p0i32.p0i32.i32(i32* %6, i32* %8, i32 %4, i1 false)
    store i32* %6, i32** %3, align 8
    %9 = load %type.string, %type.string* %.ret, align 8
    ret %type.string %9
}
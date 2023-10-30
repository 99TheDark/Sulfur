source_filename = "lib/builtin/operator/string_add.ll"

%type.string = type { i32, i32* }

declare i8* @malloc(i32)

declare void @llvm.memcpy.p0i32.p0i32.i32(i32* noalias nocapture writeonly, i32* noalias nocapture readonly, i32, i1 immarg)

define %type.string @".add:string_string"(%type.string %a, %type.string %b) {
entry:
    %.ret = alloca %type.string, align 8
    %ptr.a = alloca %type.string, align 8
    store %type.string %a, %type.string* %ptr.a, align 8
    %ptr.b = alloca %type.string, align 8
    store %type.string %b, %type.string* %ptr.b, align 8

    ; ret.len = a.len + b.len
    %0 = getelementptr inbounds %type.string, %type.string* %ptr.a, i32 0, i32 0
    %1 = load i32, i32* %0, align 4
    %2 = getelementptr inbounds %type.string, %type.string* %ptr.b, i32 0, i32 0
    %3 = load i32, i32* %2, align 4
    %4 = add i32 %1, %3
	%5 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
	store i32 %4, i32* %5, align 8

    ; ret.chars = malloc(ret.len * sizeof(int))
    %6 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
    %7 = mul i32 %4, 4
    %8 = call i8* @malloc(i32 %7)
    %9 = bitcast i8* %8 to i32*
    store i32* %9, i32** %6, align 4

    ; memcpy(ret.chars, a.chars, a.len * sizeof(int))
    %10 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
    %11 = load i32*, i32** %10, align 8
    %12 = getelementptr inbounds %type.string, %type.string* %ptr.a, i32 0, i32 1
    %13 = load i32*, i32** %12, align 8
    %14 = mul i32 %1, 4
    call void @llvm.memcpy.p0i32.p0i32.i32(i32* %11, i32* %13, i32 %14, i1 false)

    ; memcpy(ret.chars + a.len, b.chars, b.len * sizeof(int))
    %15 = getelementptr inbounds i32, i32* %11, i32 %1
    %16 = getelementptr inbounds %type.string, %type.string* %ptr.b, i32 0, i32 1
    %17 = load i32*, i32** %16, align 8
    %18 = mul i32 %3, 4
    call void @llvm.memcpy.p0i32.p0i32.i32(i32* %15, i32* %17, i32 %18, i1 false)

    %19 = load %type.string, %type.string* %.ret, align 8
    ret %type.string %19
}
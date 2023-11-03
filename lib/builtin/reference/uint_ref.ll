source_filename = "lib/builtin/reference/uint_ref.ll"

%ref.uint = type { i32*, i32 }

declare i8* @malloc(i32)
declare void @free(i8*)

declare void @freeMsg()
declare void @countMsg(i32)

define %ref.uint* @"newref:uint"(i32 %uint) {
entry:
    %uint.addr = alloca i32, align 4
    %ref = alloca %ref.uint*, align 8
    store i32 %uint, i32* %uint.addr, align 4
    %call = call i8* @malloc(i32 16) ; sizeof(&int) = 16
    %0 = bitcast i8* %call to %ref.uint*
    store %ref.uint* %0, %ref.uint** %ref, align 8
    %call1 = call i8* @malloc(i32 4) ; sizeof(int) = 4
    %1 = bitcast i8* %call1 to i32*
    %2 = load %ref.uint*, %ref.uint** %ref, align 8
    %uint2 = getelementptr inbounds %ref.uint, %ref.uint* %2, i32 0, i32 0
    store i32* %1, i32** %uint2, align 8
    %3 = load i32, i32* %uint.addr, align 4
    %4 = load %ref.uint*, %ref.uint** %ref, align 8
    %uint3 = getelementptr inbounds %ref.uint, %ref.uint* %4, i32 0, i32 0
    %5 = load i32*, i32** %uint3, align 8
    store i32 %3, i32* %5, align 4
    %6 = load %ref.uint*, %ref.uint** %ref, align 8
    %count = getelementptr inbounds %ref.uint, %ref.uint* %6, i32 0, i32 1
    store i32 0, i32* %count, align 4
    %7 = load %ref.uint*, %ref.uint** %ref, align 8
    ret %ref.uint* %7
}

define void @"ref:uint"(%ref.uint* %ref) {
entry:
    %0 = getelementptr inbounds %ref.uint, %ref.uint* %ref, i32 0, i32 1
    %1 = load i32, i32* %0, align 4
    %2 = add i32 %1, 1
    call void @countMsg(i32 %2)
    store i32 %2, i32* %0, align 4
    ret void
}

define void @"deref:uint"(%ref.uint* %ref) {
entry:
    %0 = getelementptr inbounds %ref.uint, %ref.uint* %ref, i32 0, i32 1
    %1 = load i32, i32* %0, align 4
    %2 = add i32 %1, -1
    call void @countMsg(i32 %2)
    store i32 %2, i32* %0, align 4
    %3 = icmp eq i32 %2, 0
    br i1 %3, label %if.then, label %exit

if.then:
    %4 = getelementptr inbounds %ref.uint, %ref.uint* %ref, i32 0, i32 0
    %5 = load i32*, i32** %4, align 8
    %6 = bitcast i32* %5 to i8*
    call void @free(i8* %6)
    %7 = bitcast %ref.uint* %ref to i8*
    call void @free(i8* %7)
    call void @freeMsg()
    br label %exit

exit:
    ret void
}
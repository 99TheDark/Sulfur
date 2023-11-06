source_filename = "lib/builtin/reference/int_ref.ll"

%ref.int = type { i32*, i32 }

declare i8* @malloc(i32)
declare void @free(i8*)

declare fastcc void @freeRefMsg()
declare fastcc void @countRefMsg(i32)

define fastcc %ref.int* @"newref:int"(i32 %int) {
entry:
    %int.addr = alloca i32, align 4
    %ref = alloca %ref.int*, align 8
    store i32 %int, i32* %int.addr, align 4
    %call = call i8* @malloc(i32 16) ; sizeof(&int) = 16
    %0 = bitcast i8* %call to %ref.int*
    store %ref.int* %0, %ref.int** %ref, align 8
    %call1 = call i8* @malloc(i32 4) ; sizeof(int) = 4
    %1 = bitcast i8* %call1 to i32*
    %2 = load %ref.int*, %ref.int** %ref, align 8
    %int2 = getelementptr inbounds %ref.int, %ref.int* %2, i32 0, i32 0
    store i32* %1, i32** %int2, align 8
    %3 = load i32, i32* %int.addr, align 4
    %4 = load %ref.int*, %ref.int** %ref, align 8
    %int3 = getelementptr inbounds %ref.int, %ref.int* %4, i32 0, i32 0
    %5 = load i32*, i32** %int3, align 8
    store i32 %3, i32* %5, align 4
    %6 = load %ref.int*, %ref.int** %ref, align 8
    %count = getelementptr inbounds %ref.int, %ref.int* %6, i32 0, i32 1
    store i32 0, i32* %count, align 4
    %7 = load %ref.int*, %ref.int** %ref, align 8
    ret %ref.int* %7
}

define fastcc void @"ref:int"(%ref.int* %ref) {
entry:
    %0 = getelementptr inbounds %ref.int, %ref.int* %ref, i32 0, i32 1
    %1 = load i32, i32* %0, align 4
    %2 = add i32 %1, 1
    call void @countRefMsg(i32 %2)
    store i32 %2, i32* %0, align 4
    ret void
}

define fastcc void @"deref:int"(%ref.int* %ref) {
entry:
    %0 = getelementptr inbounds %ref.int, %ref.int* %ref, i32 0, i32 1
    %1 = load i32, i32* %0, align 4
    %2 = add i32 %1, -1
    call void @countRefMsg(i32 %2)
    store i32 %2, i32* %0, align 4
    %3 = icmp eq i32 %2, 0
    br i1 %3, label %if.then, label %exit

if.then:
    %4 = getelementptr inbounds %ref.int, %ref.int* %ref, i32 0, i32 0
    %5 = load i32*, i32** %4, align 8
    %6 = bitcast i32* %5 to i8*
    call void @free(i8* %6)
    %7 = bitcast %ref.int* %ref to i8*
    call void @free(i8* %7)
    call void @freeRefMsg()
    br label %exit

exit:
    ret void
}
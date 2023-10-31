source_filename = "lib/builtin/reference/float_ref.ll"

%ref.float = type { float*, i32 }

declare i8* @malloc(i32)
declare void @free(i8*)

declare void @freeMsg()
declare void @countMsg(i32)

define %ref.float* @"newref:float"(float %value) {
entry:
    %value.addr = alloca float, align 4
    %ref = alloca %ref.float*, align 8
    store float %value, float* %value.addr, align 4
    %call = call i8* @malloc(i32 16) ; sizeof(&float) = 16
    %0 = bitcast i8* %call to %ref.float*
    store %ref.float* %0, %ref.float** %ref, align 8
    %call1 = call i8* @malloc(i32 4) ; sizeof(float) = 4
    %1 = bitcast i8* %call1 to float*
    %2 = load %ref.float*, %ref.float** %ref, align 8
    %value2 = getelementptr inbounds %ref.float, %ref.float* %2, i32 0, i32 0
    store float* %1, float** %value2, align 8
    %3 = load float, float* %value.addr, align 4
    %4 = load %ref.float*, %ref.float** %ref, align 8
    %value3 = getelementptr inbounds %ref.float, %ref.float* %4, i32 0, i32 0
    %5 = load float*, float** %value3, align 8
    store float %3, float* %5, align 4
    %6 = load %ref.float*, %ref.float** %ref, align 8
    %count = getelementptr inbounds %ref.float, %ref.float* %6, i32 0, i32 1
    store i32 0, i32* %count, align 4
    %7 = load %ref.float*, %ref.float** %ref, align 8
    ret %ref.float* %7
}

define void @"ref:float"(%ref.float* %ref) {
entry:
    %0 = getelementptr inbounds %ref.float, %ref.float* %ref, i32 0, i32 1
    %1 = load i32, i32* %0, align 4
    %2 = add i32 %1, 1
    call void @countMsg(i32 %2)
    store i32 %2, i32* %0, align 4
    ret void
}

define void @"deref:float"(%ref.float* %ref) {
entry:
    %0 = getelementptr inbounds %ref.float, %ref.float* %ref, i32 0, i32 1
    %1 = load i32, i32* %0, align 4
    %2 = add i32 %1, -1
    call void @countMsg(i32 %2)
    store i32 %2, i32* %0, align 4
    %3 = icmp eq i32 %2, 0
    br i1 %3, label %if.then, label %exit

if.then:
    %4 = getelementptr inbounds %ref.float, %ref.float* %ref, i32 0, i32 0
    %5 = load float*, float** %4, align 4
    %6 = bitcast float* %5 to i8*
    call void @free(i8* %6)
    %7 = bitcast %ref.float* %ref to i8*
    call void @free(i8* %7)
    call void @freeMsg()
    br label %exit

exit:
    ret void
}
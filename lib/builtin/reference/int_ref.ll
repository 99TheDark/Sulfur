source_filename = "lib/builtin/reference/int_ref"

%ref.int = type { i32*, i32 }

declare i32* @malloc(i32)
declare void @free(i32*)
declare void @.refMsg(i32, i32)

define %ref.int* @"ref:int"(i32 %value) {
entry:
    %ref = alloca %ref.int, align 8
	%ref.value = getelementptr inbounds %ref.int, %ref.int* %ref, i32 0, i32 0
	%0 = call i32* @malloc(i32 4)
	store i32* %0, i32** %ref.value, align 8
	%ref.value2 = getelementptr inbounds %ref.int, %ref.int* %ref, i32 0, i32 0
  	%1 = load i32*, i32** %ref.value2, align 8
	store i32 %value, i32* %1, align 8
	%ref.count = getelementptr inbounds %ref.int, %ref.int* %ref, i32 0, i32 1
	store i32 1, i32* %ref.count, align 8
    ret %ref.int* %ref
}

define void @"deref:int"(%ref.int* %ref) {
entry:
    %0 = getelementptr inbounds %ref.int, %ref.int* %ref, i32 0, i32 1
    %1 = load i32, i32* %0, align 8
    %2 = add i32 %1, -1
    store i32 %2, i32* %0, align 8
    %3 = icmp eq i32 %2, 0
    br i1 %3, label %if.then, label %exit

if.then:
    %4 = getelementptr inbounds %ref.int, %ref.int* %ref, i32 0, i32 0
    %5 = load i32*, i32** %4, align 8
    call void @free(i32* %5)
    br label %exit

exit:
    %value.adr = getelementptr inbounds %ref.int, %ref.int* %ref, i32 0, i32 0
    %value = load i32*, i32** %value.adr, align 8
    %val = load i32, i32* %value, align 4
    %count.adr = getelementptr inbounds %ref.int, %ref.int* %ref, i32 0, i32 1
    %count = load i32, i32* %count.adr, align 8
    call void @.refMsg(i32 %val, i32 %count) ; 0 noew has ??? references means it was freed
    ret void
}
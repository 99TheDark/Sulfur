source_filename = "lib/builtin/reference/string_ref"

%type.string = type { i32, i32, i8* }
%ref.string = type { %type.string*, i32 }

declare i8* @malloc(i32)
declare void @free(i8*)

define %ref.string* @"ref:string"(%type.string %value) {
entry:
    %ref = alloca %ref.string, align 8
	%ref.value = getelementptr inbounds %ref.string, %ref.string* %ref, i32 0, i32 0
	%0 = call i8* @malloc(i32 4)
    %1 = bitcast i8* %0 to %type.string*
	store %type.string* %1, %type.string** %ref.value, align 8
	%ref.value2 = getelementptr inbounds %ref.string, %ref.string* %ref, i32 0, i32 0
  	%2 = load %type.string*, %type.string** %ref.value2, align 8
	store %type.string %value, %type.string* %2, align 8
	%ref.count = getelementptr inbounds %ref.string, %ref.string* %ref, i32 0, i32 1
	store i32 1, i32* %ref.count, align 8
    ret %ref.string* %ref
}

define void @"deref:string"(%ref.string* %ref) { 
entry:
    %0 = getelementptr inbounds %ref.string, %ref.string* %ref, i32 0, i32 1
    %1 = load i32, i32* %0, align 8
    %2 = sub i32 %1, 1
    store i32 %2, i32* %0, align 8
    %3 = icmp eq i32 %2, 0
    br i1 %3, label %if.then, label %exit

if.then:
    %4 = getelementptr inbounds %ref.string, %ref.string* %ref, i32 0, i32 0
    %5 = load %type.string*, %type.string** %4, align 8
    %6 = bitcast %type.string* %5 to i8*
    call void @free(i8* %6)
    br label %exit

exit:
    ret void
}
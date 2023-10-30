source_filename = "lib/builtin/conversion/bool_string.ll"

%type.utf8_string = type { i32, i32* }

@.strTrue = private unnamed_addr constant [4 x i32] [i32 116, i32 114, i32 117, i32 101], align 4
@.strFalse = private unnamed_addr constant [5 x i32] [i32 102, i32 97, i32 108, i32 115, i32 101], align 4

define %type.utf8_string @".conv:bool_string"(i1 %bool) {
entry:
	%.ret = alloca %type.utf8_string, align 8
    br i1 %bool, label %if.then, label %if.else

if.then:
	%0 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %.ret, i32 0, i32 0
    store i32 4, i32* %0, align 8
    %1 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %.ret, i32 0, i32 1
    %2 = getelementptr inbounds [4 x i32], [4 x i32]* @.strTrue, i32 0, i32 0
    store i32* %2, i32** %1, align 8
    br label %exit

if.else:
    %3 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %.ret, i32 0, i32 0
    store i32 5, i32* %3, align 8
    %4 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %.ret, i32 0, i32 1
    %5 = getelementptr inbounds [5 x i32], [5 x i32]* @.strFalse, i32 0, i32 0
    store i32* %5, i32** %4, align 8
    br label %exit

exit:
	%6 = load %type.utf8_string, %type.utf8_string* %.ret
    ret %type.utf8_string %6
}
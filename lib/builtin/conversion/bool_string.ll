source_filename = "lib/builtin/conversion/bool_string.ll"

%type.string = type { i32, i32, i8* }

@.strTrue = private unnamed_addr constant [4 x i8] c"true", align 1
@.strFalse = private unnamed_addr constant [5 x i8] c"false", align 1

define %type.string @".conv:bool_string"(i1 %bool) {
entry:
	%.ret = alloca %type.string, align 8
    br i1 %bool, label %if.then, label %if.else

if.then:
	%0 = getelementptr inbounds [4 x i8], [4 x i8]* @.strTrue, i32 0, i32 0
	%1 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
	store i32 4, i32* %1, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
	store i32 4, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 2
	store i8* %0, i8** %3, align 8
    br label %exit

if.else:
    %4 = getelementptr inbounds [5 x i8], [5 x i8]* @.strFalse, i32 0, i32 0
	%5 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
	store i32 5, i32* %5, align 8
	%6 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
	store i32 5, i32* %6, align 8
	%7 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 2
	store i8* %4, i8** %7, align 8 
    br label %exit

exit:
	%8 = load %type.string, %type.string* %.ret
    ret %type.string %8
}
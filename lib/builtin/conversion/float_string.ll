source_filename = "lib/builtin/conversion/float_string" ; WIP

%type.string = type { i32, i32, i8* }

@.strNaN = private unnamed_addr constant [3 x i8] c"nan", align 1
@.strPosInf = private unnamed_addr constant [3 x i8] c"inf", align 1
@.strNegInf = private unnamed_addr constant [4 x i8] c"-inf", align 1

declare %type.string @".conv:int_string"(i32)

define %type.string @".conv:float_string"(float %float) {
entry:
	%.ret = alloca %type.string
	%0 = fcmp une float %float, %float
	br i1 %0, label %nan.then, label %nan.exit

nan.then:
	%1 = getelementptr inbounds [3 x i8], [3 x i8]* @.strNaN, i32 0, i32 0
	%2 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
	store i32 3, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
	store i32 3, i32* %3, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 2
	store i8* %1, i8** %4, align 8
	br label %exit

nan.exit:
	%5 = fcmp ueq float %float, 0x7FF0000000000000
	br i1 %5, label %pos_inf.then, label %pos_inf.exit

pos_inf.then:
	%6 = getelementptr inbounds [3 x i8], [3 x i8]* @.strPosInf, i32 0, i32 0
	%7 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
	store i32 3, i32* %7, align 8
	%8 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
	store i32 3, i32* %8, align 8
	%9 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 2
	store i8* %6, i8** %9, align 8
	br label %exit

pos_inf.exit:
	%10 = fcmp ueq float %float, 0xFFF0000000000000
	br i1 %10, label %neg_inf.then, label %neg_inf.exit

neg_inf.then:
	%11 = getelementptr inbounds [4 x i8], [4 x i8]* @.strNegInf, i32 0, i32 0
	%12 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
	store i32 4, i32* %12, align 8
	%13 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
	store i32 4, i32* %13, align 8
	%14 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 2
	store i8* %11, i8** %14, align 8
	br label %exit

neg_inf.exit:
	%15 = fptosi float %float to i32
	br label %exit

exit:
	%final = load %type.string, %type.string* %.ret
	ret %type.string %final
}
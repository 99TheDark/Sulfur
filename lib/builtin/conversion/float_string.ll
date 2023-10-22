source_filename = "lib/builtin/conversion/float_string" ; WIP

%type.string = type { i32, i32, i8* }

@.strNaN = private unnamed_addr constant [3 x i8] c"nan", align 1
@.strPosInf = private unnamed_addr constant [3 x i8] c"inf", align 1
@.strNegInf = private unnamed_addr constant [4 x i8] c"-inf", align 1
@.strPosZero = private unnamed_addr constant [3 x i8] c"0.0", align 1
@.strNegZero = private unnamed_addr constant [4 x i8] c"-0.0", align 1

declare %type.string @".conv:int_string"(i32)
declare %type.string @".conv:bool_string"(i1)
declare void @.println(%type.string)

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
	%15 = fcmp ueq float %float, 0.0
	br i1 %15, label %zero.then, label %zero.exit

zero.then:
	%16 = bitcast float %float to i32 
	%17 = lshr i32 %16, 31
	%18 = icmp eq i32 %17, 0 
	br i1 %18, label %pos_zero.then, label %neg_zero.then

pos_zero.then:
	%19 = getelementptr inbounds [3 x i8], [3 x i8]* @.strPosZero, i32 0, i32 0
	%20 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
	store i32 3, i32* %20, align 8
	%21 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
	store i32 3, i32* %21, align 8
	%22 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 2
	store i8* %19, i8** %22, align 8
	br label %exit

neg_zero.then:
	%23 = getelementptr inbounds [4 x i8], [4 x i8]* @.strNegZero, i32 0, i32 0
	%24 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
	store i32 4, i32* %24, align 8
	%25 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
	store i32 4, i32* %25, align 8
	%26 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 2
	store i8* %23, i8** %26, align 8
	br label %exit

zero.exit:
	%bits = alloca i32
	%sign = alloca i1
	%exp = alloca i32
	%man = alloca i32
	%27 = bitcast float %float to i32 
	store i32 %27, i32* %bits, align 4
	%28 = lshr i32 %27, 31
	%29 = icmp eq i32 %28, 0
	store i1 %29, i1* %sign, align 1
    %30 = and i32 %27, 2139095040
	%31 = lshr i32 %30, 23
	store i32 %31, i32* %exp, align 4
    %32 = and i32 %27, 8388607
	store i32 %32, i32* %man, align 4
	%m2 = alloca i32 
	%e2 = alloca i32 
	%33 = icmp eq i32 %31, 0
	br i1 %33, label %exp_zero.then, label %exp_zero.else

exp_zero.then:
	; len(man) = # of mantissa bits = 23
	; bias = 127
	%34 = load i32, i32* %man, align 4 
	store i32 -149, i32* %e2, align 4 ; 1 - bias - len(man)
	store i32 %34, i32* %m2, align 4 
	br label %exp_zero.exit
	
exp_zero.else:
	%35 = load i32, i32* %exp, align 4
	%36 = add i32 %35, -150 ; - bias - len(man)
	store i32 %36, i32* %e2, align 4
	%37 = load i32, i32* %man, align 4
	%38 = or i32 %37, 8388608 ; 8388608 = 2 ^ len(man)
	store i32 %38, i32* %m2, align 4
	br label %exp_zero.exit

exp_zero.exit:
	%even = alloca i1
	%mv = alloca i32
	%mp = alloca i32
	%mm = alloca i32
	%39 = load i32, i32* %m2, align 4
	%40 = and i32 %39, 1
	%41 = icmp eq i32 %40, 0
	store i1 %41, i1* %even
	%42 = mul i32 4, %39
	store i32 %42, i32* %mv, align 4
	%43 = add i32 %42, 2
	store i32 %43, i32* %mp, align 4
	%44 = load i32, i32* %exp, align 4
	%45 = icmp ne i32 %39, 8388608
	%46 = icmp sle i32 %44, 1
	%47 = or i1 %45, %46
	%48 = select i1 %47, i32 2, i32 1
	%49 = sub i32 %42, %48
	store i32 %49, i32* %mm, align 4
	%50 = load i32, i32* %e2, align 4
	%51 = sub i32 %50, 2
	store i32 %51, i32* %e2, align 4
	%dp = alloca i32
	%dv = alloca i32
	%dm = alloca i32
	%e10 = alloca i32
	%dp_itz = alloca i1
	%dv_itz = alloca i1
	%dm_itz = alloca i1
	%lastRem = alloca i32
	store i32 0, i32* %lastRem, align 4
	%52 = icmp sge i32 %51, 0
	br i1 %52, label %if.then, label %if.else

if.then:
	%q.large = alloca i32
	%k.large = alloca i32
	%i.large = alloca i32
	%53 = load i32, i32* %e2, align 4
	%54 = sitofp i32 %53 to float
	%55 = fmul float %54, 0x3E9A209700000000 ; 0x3E9A209700000000 = 0.3010299 = log10_2_numerator / log10_2_denominator
	%56 = fptosi float %55 to i32
	store i32 %56, i32* %q.large, align 4
	%57 = call i32 @pow5bits(i32 %56)
	%58 = add i32 58, %57 ; pow5_inv_bitcount - 1, pow5_inv_bitcount = 59
	store i32 %58, i32* %k.large, align 4
	%59 = add i32 %56, %58
	%60 = sub i32 %59, %53
	store i32 %60, i32* %i.large, align 4
	%61 = load i32, i32* %mv, align 4
	%62 = call i32 @mulPow5InvDivPow2(i32 %61, i32 %56, i32 %60)
	br label %exit

if.else:
	br label %exit

if.exit:
	br label %exit

exit:
	%final = load %type.string, %type.string* %.ret
	ret %type.string %final
}

define private i32 @pow5bits(i32 %e) {
entry:
	; e == 0 ? 1 : (int) ((e * LOG2_5_NUMERATOR + LOG2_5_DENOMINATOR - 1) / LOG2_5_DENOMINATOR);
	; e == 0 ? 1 : (int) ((e * 23219280 + 9999999) / 10000000)
	; e == 0 ? 1 : (e * 23219280 + 9999999) / 10000000
	%.ret = alloca i32
	%0 = icmp eq i32 %e, 0
	br i1 %0, label %if.then, label %if.else

if.then:
	store i32 1, i32* %.ret, align 4
	br label %exit

if.else:
	%1 = mul i32 %e, 23219280
	%2 = add i32 %1, 9999999
	%3 = sdiv i32 %2, 10000000
	store i32 %3, i32* %.ret, align 4
	br label %exit

exit:
	%4 = load i32, i32* %.ret, align 4
	ret i32 %4
}

define private i32 @mulPow5InvDivPow2(i32 %m, i32 %q, i32 %j) {
entry:
	
}
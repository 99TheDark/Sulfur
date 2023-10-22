source_filename = "lib/builtin/conversion/float_string" ; WIP

%type.string = type { i32, i32, i8* }

@float_pow5_inv_split = private constant [31 x i64] [i64 576460752303423489, i64 461168601842738791, i64 368934881474191033, i64 295147905179352826, i64 472236648286964522, i64 377789318629571618, i64 302231454903657294, i64 483570327845851670, i64 386856262276681336, i64 309485009821345069, i64 495176015714152110, i64 396140812571321688, i64 316912650057057351, i64 507060240091291761, i64 405648192073033409, i64 324518553658426727, i64 519229685853482763, i64 415383748682786211, i64 332306998946228969, i64 531691198313966350, i64 425352958651173080, i64 340282366920938464, i64 544451787073501542, i64 435561429658801234, i64 348449143727040987, i64 557518629963265579, i64 446014903970612463, i64 356811923176489971, i64 570899077082383953, i64 456719261665907162, i64 365375409332725730], align 4

@float_pow5_split = private constant [47 x i64] [i64 1152921504606846976, i64 1441151880758558720, i64 1801439850948198400, i64 2251799813685248000, i64 1407374883553280000, i64 1759218604441600000, i64 2199023255552000000, i64 1374389534720000000, i64 1717986918400000000, i64 2147483648000000000, i64 1342177280000000000, i64 1677721600000000000, i64 2097152000000000000, i64 1310720000000000000, i64 1638400000000000000, i64 2048000000000000000, i64 1280000000000000000, i64 1600000000000000000, i64 2000000000000000000, i64 1250000000000000000, i64 1562500000000000000, i64 1953125000000000000, i64 1220703125000000000, i64 1525878906250000000, i64 1907348632812500000, i64 1192092895507812500, i64 1490116119384765625, i64 1862645149230957031, i64 1164153218269348144, i64 1455191522836685180, i64 1818989403545856475, i64 2273736754432320594, i64 1421085471520200371, i64 1776356839400250464, i64 2220446049250313080, i64 1387778780781445675, i64 1734723475976807094, i64 2168404344971008868, i64 1355252715606880542, i64 1694065894508600678, i64 2117582368135750847, i64 1323488980084844279, i64 1654361225106055349, i64 2067951531382569187, i64 1292469707114105741, i64 1615587133892632177, i64 2019483917365790221], align 4

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
	%mv = alloca i32
	%mp = alloca i32
	%mm = alloca i32
	%39 = load i32, i32* %m2, align 4
	%40 = mul i32 4, %39
	store i32 %40, i32* %mv, align 4
	%41 = add i32 %40, 2
	store i32 %41, i32* %mp, align 4
	%42 = load i32, i32* %exp, align 4
	%43 = icmp ne i32 %39, 8388608
	%44 = icmp sle i32 %42, 1
	%45 = or i1 %43, %44
	%46 = select i1 %45, i32 2, i32 1
	%47 = sub i32 %40, %46
	store i32 %47, i32* %mm, align 4
	%48 = load i32, i32* %e2, align 4
	%49 = sub i32 %48, 2
	store i32 %49, i32* %e2, align 4
	%dp = alloca i32
	%dv = alloca i32
	%dm = alloca i32
	%e10 = alloca i32
	%dp_itz = alloca i1
	%dv_itz = alloca i1
	%dm_itz = alloca i1
	%lastRem = alloca i32
	store i32 0, i32* %lastRem, align 4
	%50 = icmp sge i32 %49, 0
	br i1 %50, label %if.then, label %if.else

if.then:
	%q.large = alloca i32
	%k.large = alloca i32
	%i.large = alloca i32
	%51 = load i32, i32* %e2, align 4
	%52 = sitofp i32 %51 to float
	%53 = fmul float %52, 0x3E9A209700000000 ; 0x3E9A209700000000 = 0.3010299 = log10_2_numerator / log10_2_denominator
	%54 = fptosi float %53 to i32
	store i32 %54, i32* %q.large, align 4
	%55 = call i32 @pow5bits(i32 %54)
	%56 = add i32 58, %55 ; pow5_inv_bitcount - 1, pow5_inv_bitcount = 59
	store i32 %56, i32* %k.large, align 4
	%57 = add i32 %54, %56
	%58 = sub i32 %57, %51
	store i32 %58, i32* %i.large, align 4
	%59 = load i32, i32* %mv, align 4
	%60 = call i32 @mulPow5InvDivPow2(i32 %59, i32 %54, i32 %58)
	store i32 %60, i32* %dv, align 4
	%61 = load i32, i32* %mp, align 4
	%62 = call i32 @mulPow5InvDivPow2(i32 %61, i32 %54, i32 %58)
	store i32 %62, i32* %dp, align 4
	%63 = load i32, i32* %mm, align 4
	%64 = call i32 @mulPow5InvDivPow2(i32 %63, i32 %54, i32 %58)
	store i32 %64, i32* %dm, align 4
	%65 = icmp ne i32 %54, 0 
	%66 = sub i32 %62, 1
	%67 = sdiv i32 %66, 10
	%68 = sdiv i32 %64, 10
	%69 = icmp sle i32 %67, %68
	%70 = and i1 %65, %69
	br i1 %70, label %if.then2, label %if.exit2

if.then2:
	%71 = load i32, i32* %q.large, align 4
	%72 = sub i32 %71, 1
	%73 = call i32 @pow5bits(i32 %72)
	%74 = add i32 %73, 58 ; pow5_inv_bitcount - 1, pow5_inv_bitcount = 59
	%75 = load i32, i32* %mv
	%76 = load i32, i32* %e2, align 4
	%77 = sub i32 %72, %76
	%78 = add i32 %77, %74
	%79 = call i32 @mulPow5InvDivPow2(i32 %75, i32 %72, i32 %78)
	%80 = srem i32 %79, 10
	store i32 %80, i32* %lastRem, align 4
	br label %if.exit2

if.exit2:
	%81 = load i32, i32* %q.large, align 4
	store i32 %81, i32* %e10, align 4
	%82 = load i32, i32* %mv, align 4
	%83 = call i1 @multipleOfPow5(i32 %82, i32 %81)
	store i1 %83, i1* %dv_itz, align 1
	%84 = load i32, i32* %mp, align 4
	%85 = call i1 @multipleOfPow5(i32 %84, i32 %81)
	store i1 %85, i1* %dp_itz, align 1
	%86 = load i32, i32* %mm, align 4
	%87 = call i1 @multipleOfPow5(i32 %86, i32 %81)
	store i1 %87, i1* %dm_itz, align 1
	br label %if.exit

if.else:
	%q.small = alloca i32
	%i.small = alloca i32
	%k.small = alloca i32
	%j = alloca i32
	%88 = load i32, i32* %e2, align 4
	%89 = sitofp i32 %88 to float
	%90 = fmul float %89, 0xBF32EFB300000000; 0xBF32EFB300000000 = -0.69897 = -log10_5_numerator / log10_5_denominator
	%91 = fptosi float %90 to i32
	store i32 %91, i32* %q.small, align 4
	%92 = sub i32 0, %88
	%93 = sub i32 %92, %91
	store i32 %93, i32* %i.small, align 4
	%94 = call i32 @pow5bits(i32 %93)
	%95 = sub i32 %94, 61 ; pow5_bitcount = 61
	store i32 %95, i32* %k.small, align 4
	%96 = sub i32 %91, %95
	store i32 %96, i32* %j, align 4
	%97 = load i32, i32* %mv, align 4
	%98 = call i32 @mulPow5InvDivPow2(i32 %97, i32 %93, i32 %96)
	store i32 %98, i32* %dv, align 4
	%99 = load i32, i32* %mp, align 4
	%100 = call i32 @mulPow5InvDivPow2(i32 %99, i32 %93, i32 %96)
	store i32 %100, i32* %dp, align 4
	%101 = load i32, i32* %mm, align 4
	%102 = call i32 @mulPow5InvDivPow2(i32 %101, i32 %93, i32 %96)
	store i32 %102, i32* %dm, align 4
	%103 = icmp ne i32 %91, 0
	%104 = sub i32 %100, 1
	%105 = sdiv i32 %104, 10
	%106 = sdiv i32 %102, 10
	%107 = icmp sle i32 %105, %106
	%108 = and i1 %103, %107
	br i1 %108, label %if.then3, label %if.exit3

if.then3:
	; q - 1 - (pow5bits(i + 1) - pow5bitcount) = q - 1 - pow5bits(i + 1) + pow5bitcount = q - pow5bits(i + 1) + 60, pow5bitcount = 61
	%109 = load i32, i32* %i.small, align 4
	%110 = add i32 %109, 1
	%111 = call i32 @pow5bits(i32 %110)
	%112 = load i32, i32* %q.small, align 4
	%113 = sub i32 %112, %111
	%114 = add i32 %113, 60
	store i32 %114, i32* %j, align 4
	%115 = load i32, i32* %mv, align 4
	%116 = call i32 @mulPow5DivPow2(i32 %115, i32 %110, i32 %114)
	%117 = srem i32 %116, 10
	br label %if.exit3

if.exit3:
	%118 = load i32, i32* %q.small, align 4
	%119 = load i32, i32* %e2, align 4
	%120 = add i32 %118, %119
	store i32 %120, i32* %e10
	%121 = icmp sge i32 %118, 1
	store i1 %121, i1* %dp_itz, align 4
	%122 = icmp slt i32 %118, 23 ; 23 = len(man)
	%123 = sub i32 %118, 1
	%124 = shl i32 1, %123
	%125 = sub i32 %124, 1
	%126 = load i32, i32* %mv, align 4
	%127 = and i32 %126, %125
	%128 = icmp eq i32 %127, 0
	%129 = and i1 %122, %128
	store i1 %129, i1* %dv_itz, align 1
	%130 = load i32, i32* %mm, align 4
	%131 = srem i32 %130, 2
	%132 = icmp ne i32 %131, 1
	%133 = zext i1 %132 to i32
	%134 = icmp sge i32 %133, %118
	store i1 %134, i1* %dm_itz, align 4
	br label %if.exit

if.exit:
	%dp_len = alloca i32
	%expon = alloca i32
	%sciNot = alloca i1
	%removed = alloca i32
	%135 = load i32, i32* %dp, align 4
	%136 = call i32 @decimalLength(i32 %135)
	store i32 %136, i32* %dp_len, align 4
	%137 = load i32, i32* %e10, align 4
	%138 = add i32 %137, %136
	%139 = sub i32 %138, 1
	store i32 %139, i32* %expon, align 4
	%140 = icmp sge i32 %139, -3
	%141 = icmp slt i32 %139, 7
	%142 = and i1 %140, %141
	%143 = icmp ne i1 %142, 0
	store i1 %143, i1* %sciNot, align 1
	store i32 0, i32* %removed, align 4
	%144 = load i1, i1* %dp_itz, align 1
	br i1 %144, label %if.then4, label %while.cond

if.then4:
	%145 = load i32, i32* %dp, align 4
	%146 = sub i32 %145, 1
	store i32 %146, i32* %dp, align 4
	br label %while.cond

while.cond:
	%147 = load i32, i32* %dp, align 4
	%148 = sdiv i32 %147, 10
	%149 = load i32, i32* %dm, align 4
	%150 = sdiv i32 %149, 10
	%151 = icmp sgt i32 %148, %150
	br i1 %151, label %while.body, label %exit

while.body:
	%152 = load i32, i32* %dp, align 4
	%153 = icmp slt i32 %152, 100
	%154 = load i1, i1* %sciNot, align 1
	%155 = and i1 %153, %154
	br i1 %155, label %while.cond, label %if.exit4

if.exit4:
	%156 = load i32, i32* %dm, align 4
	%157 = srem i32 %156, 10
	%158 = icmp eq i32 %157, 0
	%159 = load i1, i1* %dm_itz, align 1
	%160 = and i1 %158, %159
	store i1 %160, i1* %dm_itz, align 1
	%161 = load i32, i32* %dp, align 4
	%162 = sdiv i32 %161, 10
	store i32 %162, i32* %dp, align 4
	%163 = load i32, i32* %dv, align 4
	%164 = srem i32 %163, 10
	store i32 %164, i32* %lastRem, align 4
	%165 = sdiv i32 %163, 10
	store i32 %165, i32* %dv, align 4
	%166 = sdiv i32 %156, 10
	store i32 %166, i32* %dm, align 4
	%167 = load i32, i32* %removed, align 4
	%168 = add i32 %167, 1
	store i32 %168, i32* %removed, align 4
	br label %while.cond

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
	%0 = getelementptr inbounds [31 x i64], [31 x i64]* @float_pow5_inv_split, i32 0, i32 %q
	%1 = load i64, i64* %0, align 8
	%2 = call i32 @mulShift(i32 %m, i64 %1, i32 %j)
	ret i32 %2
}

define private i32 @mulPow5DivPow2(i32 %m, i32 %i, i32 %j) {
entry:
	%0 = getelementptr inbounds [47 x i64], [47 x i64]* @float_pow5_split, i32 0, i32 %i
	%1 = load i64, i64* %0, align 8
	%2 = call i32 @mulShift(i32 %m, i64 %1, i32 %j)
	ret i32 %2
}

define private i32 @mulShift(i32 %m, i64 %factor, i32 %shift) {
entry:
	%factor_low = trunc i64 %factor to i32
	%0 = lshr i64 %factor, 32
	%factor_high = trunc i64 %0 to i32
	%1 = zext i32 %m to i64
	%2 = zext i32 %factor_low to i64
	%bits0 = mul i64 %1, %2
	%3 = zext i32 %factor_high to i64
	%bits1 = mul i64 %1, %3
	%4 = lshr i64 %bits0, 32
	%sum = add i64 %4, %bits1
	%5 = sub i32 %shift, 32
	%6 = trunc i32 %5 to i6
	%7 = zext i6 %6 to i64
	%8 = lshr i64 %sum, %7
	%9 = trunc i64 %8 to i32
	ret i32 %9
}

define private i1 @multipleOfPow5(i32 %val, i32 %comp) {
entry:
	%0 = call i32 @pow5Factor(i32 %val)
	%1 = icmp sge i32 %0, %comp
	ret i1 %1
}

define private i32 @pow5Factor(i32 %val) {
entry:
	%val.addr = alloca i32
	store i32 %val, i32* %val.addr, align 4
	%i = alloca i32
	store i32 0, i32* %i, align 4
	br label %while.cond

while.cond:
	%0 = load i32, i32* %val.addr, align 4
	%1 = icmp sgt i32 %0, 0
	br i1 %1, label %while.body, label %exit

while.body:
	%2 = load i32, i32* %val.addr, align 4
	%3 = srem i32 %2, 5
	%4 = icmp ne i32 %3, 0
	br i1 %4, label %exit, label %if.exit

if.exit:
	%5 = load i32, i32* %val.addr, align 4
	%6 = sdiv i32 %5, 5
	store i32 %6, i32* %val.addr, align 4
	%7 = load i32, i32* %i, align 4
	%8 = add i32 %7, 1
	store i32 %8, i32* %i, align 4
	br label %while.cond

exit:
	%9 = load i32, i32* %i, align 4
	ret i32 %9
}

define private i32 @decimalLength(i32 %val) {
entry:
	%length = alloca i32
	store i32 10, i32* %length, align 4
	%factor = alloca i32
	store i32 1000000000, i32* %factor, align 4
	br label %for.cond

for.cond:
	%0 = load i32, i32* %length, align 4
	%1 = icmp sgt i32 %0, 0
	br i1 %1, label %for.body, label %exit

for.body:
	%2 = load i32, i32* %factor, align 4
	%3 = icmp sge i32 %val, %2
	br i1 %3, label %for.inc, label %if.exit

if.exit:
	%4 = load i32, i32* %factor, align 4
	%5 = sdiv i32 %4, 10
	store i32 %5, i32* %factor, align 4
	br label %for.inc

for.inc:
	%6 = load i32, i32* %length, align 4
	%7 = sub i32 %6, 1
	store i32 %7, i32* %length, align 4
	br label %for.cond

exit:
	%8 = load i32, i32* %length, align 4
	ret i32 %8
}
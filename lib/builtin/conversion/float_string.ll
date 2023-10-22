source_filename = "lib/builtin/conversion/float_string"

%type.string = type { i32, i32, i8* }
%union.anon = type { float }

@float_pow5_inv_split = private constant [31 x i64] [i64 576460752303423489, i64 461168601842738791, i64 368934881474191033, i64 295147905179352826, i64 472236648286964522, i64 377789318629571618, i64 302231454903657294, i64 483570327845851670, i64 386856262276681336, i64 309485009821345069, i64 495176015714152110, i64 396140812571321688, i64 316912650057057351, i64 507060240091291761, i64 405648192073033409, i64 324518553658426727, i64 519229685853482763, i64 415383748682786211, i64 332306998946228969, i64 531691198313966350, i64 425352958651173080, i64 340282366920938464, i64 544451787073501542, i64 435561429658801234, i64 348449143727040987, i64 557518629963265579, i64 446014903970612463, i64 356811923176489971, i64 570899077082383953, i64 456719261665907162, i64 365375409332725730], align 16
@float_pow5_split = private constant [47 x i64] [i64 1152921504606846976, i64 1441151880758558720, i64 1801439850948198400, i64 2251799813685248000, i64 1407374883553280000, i64 1759218604441600000, i64 2199023255552000000, i64 1374389534720000000, i64 1717986918400000000, i64 2147483648000000000, i64 1342177280000000000, i64 1677721600000000000, i64 2097152000000000000, i64 1310720000000000000, i64 1638400000000000000, i64 2048000000000000000, i64 1280000000000000000, i64 1600000000000000000, i64 2000000000000000000, i64 1250000000000000000, i64 1562500000000000000, i64 1953125000000000000, i64 1220703125000000000, i64 1525878906250000000, i64 1907348632812500000, i64 1192092895507812500, i64 1490116119384765625, i64 1862645149230957031, i64 1164153218269348144, i64 1455191522836685180, i64 1818989403545856475, i64 2273736754432320594, i64 1421085471520200371, i64 1776356839400250464, i64 2220446049250313080, i64 1387778780781445675, i64 1734723475976807094, i64 2168404344971008868, i64 1355252715606880542, i64 1694065894508600678, i64 2117582368135750847, i64 1323488980084844279, i64 1654361225106055349, i64 2067951531382569187, i64 1292469707114105741, i64 1615587133892632177, i64 2019483917365790221], align 16
@.strNaN = private unnamed_addr constant [3 x i8] c"nan", align 1
@.strPosInf = private unnamed_addr constant [3 x i8] c"inf", align 1
@.strNegInf = private unnamed_addr constant [4 x i8] c"-inf", align 1
@.strPosZero = private unnamed_addr constant [3 x i8] c"0.0", align 1
@.strNegZero = private unnamed_addr constant [4 x i8] c"-0.0", align 1

declare void @.println(%type.string)

define private i32 @pow5bits(i32 %e) {
entry:
    %e.addr = alloca i32, align 4
    store i32 %e, i32* %e.addr, align 4
    %0 = load i32, i32* %e.addr, align 4
    %cmp = icmp eq i32 %0, 0
    br i1 %cmp, label %cond.true, label %cond.false

cond.true:
    br label %cond.end

cond.false:
    %1 = load i32, i32* %e.addr, align 4
    %mul = mul nsw i32 %1, 23219280
    %add = add nsw i32 %mul, 9999999
    %div = sdiv i32 %add, 10000000
    br label %cond.end

cond.end:
    %cond = phi i32 [ 1, %cond.true ], [ %div, %cond.false ]
    ret i32 %cond
}

define private i32 @mulShift(i32 %m, i64 %factor, i32 %shift) {
entry:
    %m.addr = alloca i32, align 4
    %factor.addr = alloca i64, align 8
    %shift.addr = alloca i32, align 4
    %factor_low = alloca i32, align 4
    %factor_high = alloca i32, align 4
    %bits0 = alloca i64, align 8
    %bits1 = alloca i64, align 8
    %sum = alloca i64, align 8
    %shiftedSum = alloca i64, align 8
    store i32 %m, i32* %m.addr, align 4
    store i64 %factor, i64* %factor.addr, align 8
    store i32 %shift, i32* %shift.addr, align 4
    %0 = load i64, i64* %factor.addr, align 8
    %conv = trunc i64 %0 to i32
    store i32 %conv, i32* %factor_low, align 4
    %1 = load i64, i64* %factor.addr, align 8
    %shr = ashr i64 %1, 32
    %conv1 = trunc i64 %shr to i32
    store i32 %conv1, i32* %factor_high, align 4
    %2 = load i32, i32* %m.addr, align 4
    %conv2 = sext i32 %2 to i64
    %3 = load i32, i32* %factor_low, align 4
    %conv3 = sext i32 %3 to i64
    %mul = mul nsw i64 %conv2, %conv3
    store i64 %mul, i64* %bits0, align 8
    %4 = load i32, i32* %m.addr, align 4
    %conv4 = sext i32 %4 to i64
    %5 = load i32, i32* %factor_high, align 4
    %conv5 = sext i32 %5 to i64
    %mul6 = mul nsw i64 %conv4, %conv5
    store i64 %mul6, i64* %bits1, align 8
    %6 = load i64, i64* %bits0, align 8
    %shr7 = ashr i64 %6, 32
    %7 = load i64, i64* %bits1, align 8
    %add = add nsw i64 %shr7, %7
    store i64 %add, i64* %sum, align 8
    %8 = load i64, i64* %sum, align 8
    %9 = load i32, i32* %shift.addr, align 4
    %sub = sub nsw i32 %9, 32
    %sh_prom = zext i32 %sub to i64
    %shr8 = ashr i64 %8, %sh_prom
    store i64 %shr8, i64* %shiftedSum, align 8
    %10 = load i64, i64* %shiftedSum, align 8
    %conv9 = trunc i64 %10 to i32
    ret i32 %conv9
}

define private i32 @mulPow5InvDivPow2(i32 %m, i32 %q, i32 %j) {
entry:
    %m.addr = alloca i32, align 4
    %q.addr = alloca i32, align 4
    %j.addr = alloca i32, align 4
    store i32 %m, i32* %m.addr, align 4
    store i32 %q, i32* %q.addr, align 4
    store i32 %j, i32* %j.addr, align 4
    %0 = load i32, i32* %m.addr, align 4
    %1 = load i32, i32* %q.addr, align 4
    %idxprom = sext i32 %1 to i64
    %arrayidx = getelementptr inbounds [31 x i64], [31 x i64]* @float_pow5_inv_split, i64 0, i64 %idxprom
    %2 = load i64, i64* %arrayidx, align 8
    %3 = load i32, i32* %j.addr, align 4
    %call = call i32 @mulShift(i32 %0, i64 %2, i32 %3)
    ret i32 %call
}

define private i32 @mulPow5divPow2(i32 %m, i32 %i, i32 %j) {
entry:
    %m.addr = alloca i32, align 4
    %i.addr = alloca i32, align 4
    %j.addr = alloca i32, align 4
    store i32 %m, i32* %m.addr, align 4
    store i32 %i, i32* %i.addr, align 4
    store i32 %j, i32* %j.addr, align 4
    %0 = load i32, i32* %m.addr, align 4
    %1 = load i32, i32* %i.addr, align 4
    %idxprom = sext i32 %1 to i64
    %arrayidx = getelementptr inbounds [47 x i64], [47 x i64]* @float_pow5_split, i64 0, i64 %idxprom
    %2 = load i64, i64* %arrayidx, align 8
    %3 = load i32, i32* %j.addr, align 4
    %call = call i32 @mulShift(i32 %0, i64 %2, i32 %3)
    ret i32 %call
}

define private i32 @multipleOfPow5(i32 %x, i32 %p) {
entry:
    %x.addr = alloca i32, align 4
    %p.addr = alloca i32, align 4
    store i32 %x, i32* %x.addr, align 4
    store i32 %p, i32* %p.addr, align 4
    %0 = load i32, i32* %x.addr, align 4
    %call = call i32 @pow5Factor(i32 %0)
    %1 = load i32, i32* %p.addr, align 4
    %cmp = icmp sge i32 %call, %1
    %conv = zext i1 %cmp to i32
    ret i32 %conv
}

define private i32 @pow5Factor(i32 %val) {
entry:
    %retval = alloca i32, align 4
    %val.addr = alloca i32, align 4
    %i = alloca i32, align 4
    store i32 %val, i32* %val.addr, align 4
    store i32 0, i32* %i, align 4
    br label %while.cond

while.cond:
    %0 = load i32, i32* %val.addr, align 4
    %cmp = icmp sgt i32 %0, 0
    br i1 %cmp, label %while.body, label %while.end

while.body:
    %1 = load i32, i32* %val.addr, align 4
    %rem = srem i32 %1, 5
    %cmp1 = icmp eq i32 %rem, 0
    br i1 %cmp1, label %if.then, label %if.end

if.then:
    %2 = load i32, i32* %i, align 4
    store i32 %2, i32* %retval, align 4
    br label %return

if.end:
    %3 = load i32, i32* %val.addr, align 4
    %div = sdiv i32 %3, 5
    store i32 %div, i32* %val.addr, align 4
    %4 = load i32, i32* %i, align 4
    %inc = add nsw i32 %4, 1
    store i32 %inc, i32* %i, align 4
    br label %while.cond

while.end:
    store i32 0, i32* %retval, align 4
    br label %return

return:
    %5 = load i32, i32* %retval, align 4
    ret i32 %5
}

define private i32 @decimalLength(i32 %val) {
entry:
    %val.addr = alloca i32, align 4
    %len = alloca i32, align 4
    %factor = alloca i32, align 4
    store i32 %val, i32* %val.addr, align 4
    store i32 10, i32* %len, align 4
    store i32 1000000000, i32* %factor, align 4
    br label %for.cond

for.cond:
    %0 = load i32, i32* %len, align 4
    %cmp = icmp sgt i32 %0, 0
    br i1 %cmp, label %for.body, label %for.end

for.body:
    %1 = load i32, i32* %val.addr, align 4
    %2 = load i32, i32* %factor, align 4
    %cmp1 = icmp sge i32 %1, %2
    br i1 %cmp1, label %if.then, label %if.end

if.then:
    br label %for.end

if.end:
    %3 = load i32, i32* %factor, align 4
    %div = sdiv i32 %3, 10
    store i32 %div, i32* %factor, align 4
    br label %for.inc

for.inc:
    %4 = load i32, i32* %len, align 4
    %dec = add nsw i32 %4, -1
    store i32 %dec, i32* %len, align 4
    br label %for.cond

for.end:
    %5 = load i32, i32* %len, align 4
    ret i32 %5
}

define private { i64, i8* } @normalString(float %num, i32 %bits) {
entry:
    %retval = alloca %type.string, align 8
    %num.addr = alloca float, align 4
    %bits.addr = alloca i32, align 4
    %exponent = alloca i32, align 4
    %mantissa = alloca i32, align 4
    %e2 = alloca i32, align 4
    %m2 = alloca i32, align 4
    %mv = alloca i32, align 4
    %mp = alloca i32, align 4
    %mm = alloca i32, align 4
    %dp = alloca i32, align 4
    %dv = alloca i32, align 4
    %dm = alloca i32, align 4
    %e10 = alloca i32, align 4
    %dp_itz = alloca i8, align 1
    %dv_itz = alloca i8, align 1
    %dm_itz = alloca i8, align 1
    %lastRemDigit = alloca i32, align 4
    %q = alloca i32, align 4
    %k = alloca i32, align 4
    %i = alloca i32, align 4
    %l = alloca i32, align 4
    %q42 = alloca i32, align 4
    %i46 = alloca i32, align 4
    %k49 = alloca i32, align 4
    %j = alloca i32, align 4
    %dpLen = alloca i32, align 4
    %expon = alloca i32, align 4
    %sciNot = alloca i8, align 1
    %removed = alloca i32, align 4
    %output = alloca i32, align 4
    %outLen = alloca i32, align 4
    %result = alloca i8*, align 8
    %idx = alloca i32, align 4
    %i180 = alloca i32, align 4
    %c = alloca i32, align 4
    %i247 = alloca i32, align 4
    %cur = alloca i32, align 4
    %i258 = alloca i32, align 4
    %i281 = alloca i32, align 4
    %i299 = alloca i32, align 4
    %cur318 = alloca i32, align 4
    %i320 = alloca i32, align 4
    store float %num, float* %num.addr, align 4
    store i32 %bits, i32* %bits.addr, align 4
    %0 = load i32, i32* %bits.addr, align 4
    %and = and i32 %0, 2139095040
    %shr = lshr i32 %and, 23
    store i32 %shr, i32* %exponent, align 4
    %1 = load i32, i32* %bits.addr, align 4
    %and1 = and i32 %1, 8388607
    store i32 %and1, i32* %mantissa, align 4
    %2 = load i32, i32* %exponent, align 4
    %cmp = icmp eq i32 %2, 0
    br i1 %cmp, label %if.then, label %if.else

if.then:
    store i32 -149, i32* %e2, align 4
    %3 = load i32, i32* %mantissa, align 4
    store i32 %3, i32* %m2, align 4
    br label %if.end

if.else:
    %4 = load i32, i32* %exponent, align 4
    %sub = sub nsw i32 %4, 150
    store i32 %sub, i32* %e2, align 4
    %5 = load i32, i32* %mantissa, align 4
    %or = or i32 %5, 8388608
    store i32 %or, i32* %m2, align 4
    br label %if.end

if.end:
    %6 = load i32, i32* %m2, align 4
    %mul = mul nsw i32 4, %6
    store i32 %mul, i32* %mv, align 4
    %7 = load i32, i32* %m2, align 4
    %mul2 = mul nsw i32 4, %7
    %add = add nsw i32 %mul2, 2
    store i32 %add, i32* %mp, align 4
    %8 = load i32, i32* %m2, align 4
    %mul3 = mul nsw i32 4, %8
    %9 = load i32, i32* %m2, align 4
    %cmp4 = icmp ne i32 %9, 8388608
    br i1 %cmp4, label %lor.end, label %lor.rhs

lor.rhs:
    %10 = load i32, i32* %exponent, align 4
    %cmp5 = icmp sle i32 %10, 1
    br label %lor.end

lor.end:
    %11 = phi i1 [ true, %if.end ], [ %cmp5, %lor.rhs ]
    %12 = zext i1 %11 to i64
    %cond = select i1 %11, i32 2, i32 1
    %sub6 = sub nsw i32 %mul3, %cond
    store i32 %sub6, i32* %mm, align 4
    %13 = load i32, i32* %e2, align 4
    %sub7 = sub nsw i32 %13, 2
    store i32 %sub7, i32* %e2, align 4
    store i32 0, i32* %lastRemDigit, align 4
    %14 = load i32, i32* %e2, align 4
    %cmp8 = icmp sge i32 %14, 0
    br i1 %cmp8, label %if.then9, label %if.else41

if.then9:
    %15 = load i32, i32* %e2, align 4
    %conv = sitofp i32 %15 to double
    %mul10 = fmul double %conv, 0x3FD34412E9E78FC7
    %conv11 = fptosi double %mul10 to i32
    store i32 %conv11, i32* %q, align 4
    %16 = load i32, i32* %q, align 4
    %call = call i32 @pow5bits(i32 %16)
    %add12 = add nsw i32 58, %call
    store i32 %add12, i32* %k, align 4
    %17 = load i32, i32* %q, align 4
    %18 = load i32, i32* %k, align 4
    %add13 = add nsw i32 %17, %18
    %19 = load i32, i32* %e2, align 4
    %sub14 = sub nsw i32 %add13, %19
    store i32 %sub14, i32* %i, align 4
    %20 = load i32, i32* %mv, align 4
    %21 = load i32, i32* %q, align 4
    %22 = load i32, i32* %i, align 4
    %call15 = call i32 @mulPow5InvDivPow2(i32 %20, i32 %21, i32 %22)
    store i32 %call15, i32* %dv, align 4
    %23 = load i32, i32* %mp, align 4
    %24 = load i32, i32* %q, align 4
    %25 = load i32, i32* %i, align 4
    %call16 = call i32 @mulPow5InvDivPow2(i32 %23, i32 %24, i32 %25)
    store i32 %call16, i32* %dp, align 4
    %26 = load i32, i32* %mm, align 4
    %27 = load i32, i32* %q, align 4
    %28 = load i32, i32* %i, align 4
    %call17 = call i32 @mulPow5InvDivPow2(i32 %26, i32 %27, i32 %28)
    store i32 %call17, i32* %dm, align 4
    %29 = load i32, i32* %q, align 4
    %cmp18 = icmp ne i32 %29, 0
    br i1 %cmp18, label %land.lhs.true, label %if.end33

land.lhs.true:
    %30 = load i32, i32* %dp, align 4
    %sub20 = sub nsw i32 %30, 1
    %div = sdiv i32 %sub20, 10
    %31 = load i32, i32* %dm, align 4
    %div21 = sdiv i32 %31, 10
    %cmp22 = icmp sle i32 %div, %div21
    br i1 %cmp22, label %if.then24, label %if.end33

if.then24:
    %32 = load i32, i32* %q, align 4
    %sub25 = sub nsw i32 %32, 1
    %call26 = call i32 @pow5bits(i32 %sub25)
    %add27 = add nsw i32 58, %call26
    store i32 %add27, i32* %l, align 4
    %33 = load i32, i32* %mv, align 4
    %34 = load i32, i32* %q, align 4
    %sub28 = sub nsw i32 %34, 1
    %35 = load i32, i32* %q, align 4
    %36 = load i32, i32* %e2, align 4
    %sub29 = sub nsw i32 %35, %36
    %sub30 = sub nsw i32 %sub29, 1
    %37 = load i32, i32* %l, align 4
    %add31 = add nsw i32 %sub30, %37
    %call32 = call i32 @mulPow5InvDivPow2(i32 %33, i32 %sub28, i32 %add31)
    %rem = srem i32 %call32, 10
    store i32 %rem, i32* %lastRemDigit, align 4
    br label %if.end33

if.end33:
    %38 = load i32, i32* %q, align 4
    store i32 %38, i32* %e10, align 4
    %39 = load i32, i32* %mp, align 4
    %40 = load i32, i32* %q, align 4
    %call34 = call i32 @multipleOfPow5(i32 %39, i32 %40)
    %tobool = icmp ne i32 %call34, 0
    %frombool = zext i1 %tobool to i8
    store i8 %frombool, i8* %dp_itz, align 1
    %41 = load i32, i32* %mv, align 4
    %42 = load i32, i32* %q, align 4
    %call35 = call i32 @multipleOfPow5(i32 %41, i32 %42)
    %tobool36 = icmp ne i32 %call35, 0
    %frombool37 = zext i1 %tobool36 to i8
    store i8 %frombool37, i8* %dv_itz, align 1
    %43 = load i32, i32* %mm, align 4
    %44 = load i32, i32* %q, align 4
    %call38 = call i32 @multipleOfPow5(i32 %43, i32 %44)
    %tobool39 = icmp ne i32 %call38, 0
    %frombool40 = zext i1 %tobool39 to i8
    store i8 %frombool40, i8* %dm_itz, align 1
    br label %if.end92

if.else41:
    %45 = load i32, i32* %e2, align 4
    %conv43 = sitofp i32 %45 to double
    %mul44 = fmul double %conv43, -6.989700e-01
    %conv45 = fptosi double %mul44 to i32
    store i32 %conv45, i32* %q42, align 4
    %46 = load i32, i32* %e2, align 4
    %sub47 = sub nsw i32 0, %46
    %47 = load i32, i32* %q42, align 4
    %sub48 = sub nsw i32 %sub47, %47
    store i32 %sub48, i32* %i46, align 4
    %48 = load i32, i32* %i46, align 4
    %call50 = call i32 @pow5bits(i32 %48)
    %sub51 = sub nsw i32 %call50, 61
    store i32 %sub51, i32* %k49, align 4
    %49 = load i32, i32* %q42, align 4
    %50 = load i32, i32* %k49, align 4
    %sub52 = sub nsw i32 %49, %50
    store i32 %sub52, i32* %j, align 4
    %51 = load i32, i32* %mv, align 4
    %52 = load i32, i32* %i46, align 4
    %53 = load i32, i32* %j, align 4
    %call53 = call i32 @mulPow5divPow2(i32 %51, i32 %52, i32 %53)
    store i32 %call53, i32* %dv, align 4
    %54 = load i32, i32* %mp, align 4
    %55 = load i32, i32* %i46, align 4
    %56 = load i32, i32* %j, align 4
    %call54 = call i32 @mulPow5divPow2(i32 %54, i32 %55, i32 %56)
    store i32 %call54, i32* %dp, align 4
    %57 = load i32, i32* %mm, align 4
    %58 = load i32, i32* %i46, align 4
    %59 = load i32, i32* %j, align 4
    %call55 = call i32 @mulPow5divPow2(i32 %57, i32 %58, i32 %59)
    store i32 %call55, i32* %dm, align 4
    %60 = load i32, i32* %q42, align 4
    %cmp56 = icmp ne i32 %60, 0
    br i1 %cmp56, label %land.lhs.true58, label %if.end72

land.lhs.true58:
    %61 = load i32, i32* %dp, align 4
    %sub59 = sub nsw i32 %61, 1
    %div60 = sdiv i32 %sub59, 10
    %62 = load i32, i32* %dm, align 4
    %div61 = sdiv i32 %62, 10
    %cmp62 = icmp sle i32 %div60, %div61
    br i1 %cmp62, label %if.then64, label %if.end72

if.then64:
    %63 = load i32, i32* %q42, align 4
    %64 = load i32, i32* %i46, align 4
    %add65 = add nsw i32 %64, 1
    %call66 = call i32 @pow5bits(i32 %add65)
    %sub67 = sub nsw i32 %63, %call66
    %add68 = add nsw i32 %sub67, 60
    store i32 %add68, i32* %j, align 4
    %65 = load i32, i32* %mv, align 4
    %66 = load i32, i32* %i46, align 4
    %add69 = add nsw i32 %66, 1
    %67 = load i32, i32* %j, align 4
    %call70 = call i32 @mulPow5divPow2(i32 %65, i32 %add69, i32 %67)
    %rem71 = srem i32 %call70, 10
    store i32 %rem71, i32* %lastRemDigit, align 4
    br label %if.end72

if.end72:
    %68 = load i32, i32* %q42, align 4
    %69 = load i32, i32* %e2, align 4
    %add73 = add nsw i32 %68, %69
    store i32 %add73, i32* %e10, align 4
    %70 = load i32, i32* %q42, align 4
    %cmp74 = icmp sge i32 1, %70
    %frombool76 = zext i1 %cmp74 to i8
    store i8 %frombool76, i8* %dp_itz, align 1
    %71 = load i32, i32* %q42, align 4
    %cmp77 = icmp slt i32 %71, 23
    br i1 %cmp77, label %land.rhs, label %land.end

land.rhs:
    %72 = load i32, i32* %mv, align 4
    %73 = load i32, i32* %q42, align 4
    %sub79 = sub nsw i32 %73, 1
    %shl = shl i32 1, %sub79
    %sub80 = sub nsw i32 %shl, 1
    %and81 = and i32 %72, %sub80
    %cmp82 = icmp eq i32 %and81, 0
    br label %land.end

land.end:
    %74 = phi i1 [ false, %if.end72 ], [ %cmp82, %land.rhs ]
    %frombool84 = zext i1 %74 to i8
    store i8 %frombool84, i8* %dv_itz, align 1
    %75 = load i32, i32* %mm, align 4
    %rem85 = srem i32 %75, 2
    %cmp86 = icmp ne i32 %rem85, 1
    %76 = zext i1 %cmp86 to i64
    %cond88 = select i1 %cmp86, i32 1, i32 0
    %77 = load i32, i32* %q42, align 4
    %cmp89 = icmp sge i32 %cond88, %77
    %frombool91 = zext i1 %cmp89 to i8
    store i8 %frombool91, i8* %dm_itz, align 1
    br label %if.end92

if.end92:
    %78 = load i32, i32* %dp, align 4
    %call93 = call i32 @decimalLength(i32 %78)
    store i32 %call93, i32* %dpLen, align 4
    %79 = load i32, i32* %e10, align 4
    %80 = load i32, i32* %dpLen, align 4
    %add94 = add nsw i32 %79, %80
    %sub95 = sub nsw i32 %add94, 1
    store i32 %sub95, i32* %expon, align 4
    %81 = load i32, i32* %expon, align 4
    %cmp96 = icmp sge i32 %81, -3
    br i1 %cmp96, label %land.rhs98, label %land.end101

land.rhs98:
    %82 = load i32, i32* %expon, align 4
    %cmp99 = icmp slt i32 %82, 7
    br label %land.end101

land.end101:
    %83 = phi i1 [ false, %if.end92 ], [ %cmp99, %land.rhs98 ]
    %lnot = xor i1 %83, true
    %frombool102 = zext i1 %lnot to i8
    store i8 %frombool102, i8* %sciNot, align 1
    store i32 0, i32* %removed, align 4
    %84 = load i8, i8* %dp_itz, align 1
    %tobool103 = trunc i8 %84 to i1
    br i1 %tobool103, label %if.then104, label %if.end105

if.then104:
    %85 = load i32, i32* %dp, align 4
    %dec = add nsw i32 %85, -1
    store i32 %dec, i32* %dp, align 4
    br label %if.end105

if.end105:
    br label %while.cond

while.cond:
    %86 = load i32, i32* %dp, align 4
    %div106 = sdiv i32 %86, 10
    %87 = load i32, i32* %dm, align 4
    %div107 = sdiv i32 %87, 10
    %cmp108 = icmp sgt i32 %div106, %div107
    br i1 %cmp108, label %while.body, label %while.end

while.body:
    %88 = load i32, i32* %dp, align 4
    %cmp110 = icmp slt i32 %88, 100
    br i1 %cmp110, label %land.lhs.true112, label %if.end116

land.lhs.true112:
    %89 = load i8, i8* %sciNot, align 1
    %tobool113 = trunc i8 %89 to i1
    br i1 %tobool113, label %if.then115, label %if.end116

if.then115:
    br label %while.end

if.end116:
    %90 = load i32, i32* %dm, align 4
    %rem117 = srem i32 %90, 10
    %cmp118 = icmp eq i32 %rem117, 0
    %conv119 = zext i1 %cmp118 to i32
    %91 = load i8, i8* %dm_itz, align 1
    %tobool120 = trunc i8 %91 to i1
    %conv121 = zext i1 %tobool120 to i32
    %and122 = and i32 %conv121, %conv119
    %tobool123 = icmp ne i32 %and122, 0
    %frombool124 = zext i1 %tobool123 to i8
    store i8 %frombool124, i8* %dm_itz, align 1
    %92 = load i32, i32* %dp, align 4
    %div125 = sdiv i32 %92, 10
    store i32 %div125, i32* %dp, align 4
    %93 = load i32, i32* %dv, align 4
    %rem126 = srem i32 %93, 10
    store i32 %rem126, i32* %lastRemDigit, align 4
    %94 = load i32, i32* %dv, align 4
    %div127 = sdiv i32 %94, 10
    store i32 %div127, i32* %dv, align 4
    %95 = load i32, i32* %dm, align 4
    %div128 = sdiv i32 %95, 10
    store i32 %div128, i32* %dm, align 4
    %96 = load i32, i32* %removed, align 4
    %inc = add nsw i32 %96, 1
    store i32 %inc, i32* %removed, align 4
    br label %while.cond

while.end:
    %97 = load i8, i8* %dm_itz, align 1
    %tobool129 = trunc i8 %97 to i1
    br i1 %tobool129, label %if.then130, label %if.end149

if.then130:
    br label %while.cond131

while.cond131:
    %98 = load i32, i32* %dm, align 4
    %rem132 = srem i32 %98, 10
    %cmp133 = icmp eq i32 %rem132, 0
    br i1 %cmp133, label %while.body135, label %while.end148

while.body135:
    %99 = load i32, i32* %dp, align 4
    %cmp136 = icmp slt i32 %99, 100
    br i1 %cmp136, label %land.lhs.true138, label %if.end142

land.lhs.true138:
    %100 = load i8, i8* %sciNot, align 1
    %tobool139 = trunc i8 %100 to i1
    br i1 %tobool139, label %if.then141, label %if.end142

if.then141:
    br label %while.end148

if.end142:
    %101 = load i32, i32* %dp, align 4
    %div143 = sdiv i32 %101, 10
    store i32 %div143, i32* %dp, align 4
    %102 = load i32, i32* %dv, align 4
    %rem144 = srem i32 %102, 10
    store i32 %rem144, i32* %lastRemDigit, align 4
    %103 = load i32, i32* %dv, align 4
    %div145 = sdiv i32 %103, 10
    store i32 %div145, i32* %dv, align 4
    %104 = load i32, i32* %dm, align 4
    %div146 = sdiv i32 %104, 10
    store i32 %div146, i32* %dm, align 4
    %105 = load i32, i32* %removed, align 4
    %inc147 = add nsw i32 %105, 1
    store i32 %inc147, i32* %removed, align 4
    br label %while.cond131

while.end148:
    br label %if.end149

if.end149:
    %106 = load i8, i8* %dv_itz, align 1
    %tobool150 = trunc i8 %106 to i1
    br i1 %tobool150, label %land.lhs.true152, label %if.end160

land.lhs.true152:
    %107 = load i32, i32* %lastRemDigit, align 4
    %cmp153 = icmp eq i32 %107, 5
    br i1 %cmp153, label %land.lhs.true155, label %if.end160

land.lhs.true155:
    %108 = load i32, i32* %dv, align 4
    %rem156 = srem i32 %108, 2
    %cmp157 = icmp eq i32 %rem156, 0
    br i1 %cmp157, label %if.then159, label %if.end160

if.then159:
    store i32 4, i32* %lastRemDigit, align 4
    br label %if.end160

if.end160:
    %109 = load i32, i32* %dv, align 4
    %110 = load i32, i32* %dv, align 4
    %111 = load i32, i32* %dm, align 4
    %cmp161 = icmp eq i32 %110, %111
    br i1 %cmp161, label %land.lhs.true163, label %lor.rhs165

land.lhs.true163:
    %112 = load i8, i8* %dm_itz, align 1
    %tobool164 = trunc i8 %112 to i1
    br i1 %tobool164, label %lor.rhs165, label %lor.end168

lor.rhs165:
    %113 = load i32, i32* %lastRemDigit, align 4
    %cmp166 = icmp sge i32 %113, 5
    br label %lor.end168

lor.end168:
    %114 = phi i1 [ true, %land.lhs.true163 ], [ %cmp166, %lor.rhs165 ]
    %115 = zext i1 %114 to i64
    %cond169 = select i1 %114, i32 1, i32 0
    %add170 = add nsw i32 %109, %cond169
    store i32 %add170, i32* %output, align 4
    %116 = load i32, i32* %dpLen, align 4
    %117 = load i32, i32* %removed, align 4
    %sub171 = sub nsw i32 %116, %117
    store i32 %sub171, i32* %outLen, align 4
    %call172 = call noalias i8* @malloc(i64 15) #5
    store i8* %call172, i8** %result, align 8
    store i32 0, i32* %idx, align 4
    %118 = load float, float* %num.addr, align 4
    %cmp173 = fcmp olt float %118, 0.000000e+00
    br i1 %cmp173, label %if.then175, label %if.end177

if.then175:
    %119 = load i8*, i8** %result, align 8
    %120 = load i32, i32* %idx, align 4
    %inc176 = add nsw i32 %120, 1
    store i32 %inc176, i32* %idx, align 4
    %idxprom = sext i32 %120 to i64
    %arrayidx = getelementptr inbounds i8, i8* %119, i64 %idxprom
    store i8 45, i8* %arrayidx, align 1
    br label %if.end177

if.end177:
    %121 = load i8, i8* %sciNot, align 1
    %tobool178 = trunc i8 %121 to i1
    br i1 %tobool178, label %if.then179, label %if.else237

if.then179:
    store i32 0, i32* %i180, align 4
    br label %for.cond

for.cond:
    %122 = load i32, i32* %i180, align 4
    %123 = load i32, i32* %outLen, align 4
    %sub181 = sub nsw i32 %123, 1
    %cmp182 = icmp slt i32 %122, %sub181
    br i1 %cmp182, label %for.body, label %for.end

for.body:
    %124 = load i32, i32* %output, align 4
    %rem184 = srem i32 %124, 10
    store i32 %rem184, i32* %c, align 4
    %125 = load i32, i32* %output, align 4
    %div185 = sdiv i32 %125, 10
    store i32 %div185, i32* %output, align 4
    %126 = load i32, i32* %c, align 4
    %add186 = add nsw i32 48, %126
    %conv187 = trunc i32 %add186 to i8
    %127 = load i8*, i8** %result, align 8
    %128 = load i32, i32* %idx, align 4
    %129 = load i32, i32* %outLen, align 4
    %add188 = add nsw i32 %128, %129
    %130 = load i32, i32* %i180, align 4
    %sub189 = sub nsw i32 %add188, %130
    %conv190 = sext i32 %sub189 to i64
    %mul191 = mul i64 %conv190, 1
    %arrayidx192 = getelementptr inbounds i8, i8* %127, i64 %mul191
    store i8 %conv187, i8* %arrayidx192, align 1
    br label %for.inc

for.inc:
    %131 = load i32, i32* %i180, align 4
    %inc193 = add nsw i32 %131, 1
    store i32 %inc193, i32* %i180, align 4
    br label %for.cond

for.end:
    %132 = load i32, i32* %output, align 4
    %rem194 = srem i32 %132, 10
    %add195 = add nsw i32 48, %rem194
    %conv196 = trunc i32 %add195 to i8
    %133 = load i8*, i8** %result, align 8
    %134 = load i32, i32* %idx, align 4
    %idxprom197 = sext i32 %134 to i64
    %arrayidx198 = getelementptr inbounds i8, i8* %133, i64 %idxprom197
    store i8 %conv196, i8* %arrayidx198, align 1
    %135 = load i8*, i8** %result, align 8
    %136 = load i32, i32* %idx, align 4
    %inc199 = add nsw i32 %136, 1
    store i32 %inc199, i32* %idx, align 4
    %idxprom200 = sext i32 %inc199 to i64
    %arrayidx201 = getelementptr inbounds i8, i8* %135, i64 %idxprom200
    store i8 46, i8* %arrayidx201, align 1
    %137 = load i32, i32* %outLen, align 4
    %138 = load i32, i32* %idx, align 4
    %add202 = add nsw i32 %138, %137
    store i32 %add202, i32* %idx, align 4
    %139 = load i32, i32* %outLen, align 4
    %cmp203 = icmp eq i32 %139, 1
    br i1 %cmp203, label %if.then205, label %if.end209

if.then205:
    %140 = load i8*, i8** %result, align 8
    %141 = load i32, i32* %idx, align 4
    %inc206 = add nsw i32 %141, 1
    store i32 %inc206, i32* %idx, align 4
    %idxprom207 = sext i32 %141 to i64
    %arrayidx208 = getelementptr inbounds i8, i8* %140, i64 %idxprom207
    store i8 48, i8* %arrayidx208, align 1
    br label %if.end209

if.end209:
    %142 = load i8*, i8** %result, align 8
    %143 = load i32, i32* %idx, align 4
    %inc210 = add nsw i32 %143, 1
    store i32 %inc210, i32* %idx, align 4
    %idxprom211 = sext i32 %143 to i64
    %arrayidx212 = getelementptr inbounds i8, i8* %142, i64 %idxprom211
    store i8 101, i8* %arrayidx212, align 1
    %144 = load i32, i32* %expon, align 4
    %cmp213 = icmp slt i32 %144, 0
    br i1 %cmp213, label %if.then215, label %if.end220

if.then215:
    %145 = load i8*, i8** %result, align 8
    %146 = load i32, i32* %idx, align 4
    %inc216 = add nsw i32 %146, 1
    store i32 %inc216, i32* %idx, align 4
    %idxprom217 = sext i32 %146 to i64
    %arrayidx218 = getelementptr inbounds i8, i8* %145, i64 %idxprom217
    store i8 45, i8* %arrayidx218, align 1
    %147 = load i32, i32* %expon, align 4
    %sub219 = sub nsw i32 0, %147
    store i32 %sub219, i32* %expon, align 4
    br label %if.end220

if.end220:
    %148 = load i32, i32* %expon, align 4
    %cmp221 = icmp sge i32 %148, 10
    br i1 %cmp221, label %if.then223, label %if.end230

if.then223:
    %149 = load i32, i32* %expon, align 4
    %div224 = sdiv i32 %149, 10
    %add225 = add nsw i32 48, %div224
    %conv226 = trunc i32 %add225 to i8
    %150 = load i8*, i8** %result, align 8
    %151 = load i32, i32* %idx, align 4
    %inc227 = add nsw i32 %151, 1
    store i32 %inc227, i32* %idx, align 4
    %idxprom228 = sext i32 %151 to i64
    %arrayidx229 = getelementptr inbounds i8, i8* %150, i64 %idxprom228
    store i8 %conv226, i8* %arrayidx229, align 1
    br label %if.end230

if.end230:
    %152 = load i32, i32* %expon, align 4
    %rem231 = srem i32 %152, 10
    %add232 = add nsw i32 48, %rem231
    %conv233 = trunc i32 %add232 to i8
    %153 = load i8*, i8** %result, align 8
    %154 = load i32, i32* %idx, align 4
    %inc234 = add nsw i32 %154, 1
    store i32 %inc234, i32* %idx, align 4
    %idxprom235 = sext i32 %154 to i64
    %arrayidx236 = getelementptr inbounds i8, i8* %153, i64 %idxprom235
    store i8 %conv233, i8* %arrayidx236, align 1
    br label %if.end353

if.else237:
    %155 = load i32, i32* %expon, align 4
    %cmp238 = icmp slt i32 %155, 0
    br i1 %cmp238, label %if.then240, label %if.else276

if.then240:
    %156 = load i8*, i8** %result, align 8
    %157 = load i32, i32* %idx, align 4
    %inc241 = add nsw i32 %157, 1
    store i32 %inc241, i32* %idx, align 4
    %idxprom242 = sext i32 %157 to i64
    %arrayidx243 = getelementptr inbounds i8, i8* %156, i64 %idxprom242
    store i8 48, i8* %arrayidx243, align 1
    %158 = load i8*, i8** %result, align 8
    %159 = load i32, i32* %idx, align 4
    %inc244 = add nsw i32 %159, 1
    store i32 %inc244, i32* %idx, align 4
    %idxprom245 = sext i32 %159 to i64
    %arrayidx246 = getelementptr inbounds i8, i8* %158, i64 %idxprom245
    store i8 46, i8* %arrayidx246, align 1
    store i32 -1, i32* %i247, align 4
    br label %for.cond248

for.cond248:
    %160 = load i32, i32* %i247, align 4
    %161 = load i32, i32* %expon, align 4
    %cmp249 = icmp sgt i32 %160, %161
    br i1 %cmp249, label %for.body251, label %for.end257

for.body251:
    %162 = load i8*, i8** %result, align 8
    %163 = load i32, i32* %idx, align 4
    %inc252 = add nsw i32 %163, 1
    store i32 %inc252, i32* %idx, align 4
    %idxprom253 = sext i32 %163 to i64
    %arrayidx254 = getelementptr inbounds i8, i8* %162, i64 %idxprom253
    store i8 48, i8* %arrayidx254, align 1
    br label %for.inc255

for.inc255:
    %164 = load i32, i32* %i247, align 4
    %dec256 = add nsw i32 %164, -1
    store i32 %dec256, i32* %i247, align 4
    br label %for.cond248

for.end257:
    %165 = load i32, i32* %idx, align 4
    store i32 %165, i32* %cur, align 4
    store i32 0, i32* %i258, align 4
    br label %for.cond259

for.cond259:
    %166 = load i32, i32* %i258, align 4
    %167 = load i32, i32* %outLen, align 4
    %cmp260 = icmp slt i32 %166, %167
    br i1 %cmp260, label %for.body262, label %for.end275

for.body262:
    %168 = load i32, i32* %output, align 4
    %rem263 = srem i32 %168, 10
    %add264 = add nsw i32 48, %rem263
    %conv265 = trunc i32 %add264 to i8
    %169 = load i8*, i8** %result, align 8
    %170 = load i32, i32* %cur, align 4
    %171 = load i32, i32* %outLen, align 4
    %add266 = add nsw i32 %170, %171
    %172 = load i32, i32* %i258, align 4
    %sub267 = sub nsw i32 %add266, %172
    %sub268 = sub nsw i32 %sub267, 1
    %idxprom269 = sext i32 %sub268 to i64
    %arrayidx270 = getelementptr inbounds i8, i8* %169, i64 %idxprom269
    store i8 %conv265, i8* %arrayidx270, align 1
    %173 = load i32, i32* %output, align 4
    %div271 = sdiv i32 %173, 10
    store i32 %div271, i32* %output, align 4
    %174 = load i32, i32* %idx, align 4
    %inc272 = add nsw i32 %174, 1
    store i32 %inc272, i32* %idx, align 4
    br label %for.inc273

for.inc273:
    %175 = load i32, i32* %i258, align 4
    %inc274 = add nsw i32 %175, 1
    store i32 %inc274, i32* %i258, align 4
    br label %for.cond259

for.end275:
    br label %if.end352

if.else276:
    %176 = load i32, i32* %expon, align 4
    %add277 = add nsw i32 %176, 1
    %177 = load i32, i32* %outLen, align 4
    %cmp278 = icmp sge i32 %add277, %177
    br i1 %cmp278, label %if.then280, label %if.else317

if.then280:
    store i32 0, i32* %i281, align 4
    br label %for.cond282

for.cond282:
    %178 = load i32, i32* %i281, align 4
    %179 = load i32, i32* %outLen, align 4
    %cmp283 = icmp slt i32 %178, %179
    br i1 %cmp283, label %for.body285, label %for.end297

for.body285:
    %180 = load i32, i32* %output, align 4
    %rem286 = srem i32 %180, 10
    %add287 = add nsw i32 48, %rem286
    %conv288 = trunc i32 %add287 to i8
    %181 = load i8*, i8** %result, align 8
    %182 = load i32, i32* %idx, align 4
    %183 = load i32, i32* %outLen, align 4
    %add289 = add nsw i32 %182, %183
    %184 = load i32, i32* %i281, align 4
    %sub290 = sub nsw i32 %add289, %184
    %sub291 = sub nsw i32 %sub290, 1
    %idxprom292 = sext i32 %sub291 to i64
    %arrayidx293 = getelementptr inbounds i8, i8* %181, i64 %idxprom292
    store i8 %conv288, i8* %arrayidx293, align 1
    %185 = load i32, i32* %output, align 4
    %div294 = sdiv i32 %185, 10
    store i32 %div294, i32* %output, align 4
    br label %for.inc295

for.inc295:
    %186 = load i32, i32* %i281, align 4
    %inc296 = add nsw i32 %186, 1
    store i32 %inc296, i32* %i281, align 4
    br label %for.cond282

for.end297:
    %187 = load i32, i32* %outLen, align 4
    %188 = load i32, i32* %idx, align 4
    %add298 = add nsw i32 %188, %187
    store i32 %add298, i32* %idx, align 4
    %189 = load i32, i32* %outLen, align 4
    store i32 %189, i32* %i299, align 4
    br label %for.cond300

for.cond300:
    %190 = load i32, i32* %i299, align 4
    %191 = load i32, i32* %expon, align 4
    %add301 = add nsw i32 %191, 1
    %cmp302 = icmp slt i32 %190, %add301
    br i1 %cmp302, label %for.body304, label %for.end310

for.body304:
    %192 = load i8*, i8** %result, align 8
    %193 = load i32, i32* %idx, align 4
    %inc305 = add nsw i32 %193, 1
    store i32 %inc305, i32* %idx, align 4
    %idxprom306 = sext i32 %193 to i64
    %arrayidx307 = getelementptr inbounds i8, i8* %192, i64 %idxprom306
    store i8 48, i8* %arrayidx307, align 1
    br label %for.inc308

for.inc308:
    %194 = load i32, i32* %i299, align 4
    %inc309 = add nsw i32 %194, 1
    store i32 %inc309, i32* %i299, align 4
    br label %for.cond300

for.end310:
    %195 = load i8*, i8** %result, align 8
    %196 = load i32, i32* %idx, align 4
    %inc311 = add nsw i32 %196, 1
    store i32 %inc311, i32* %idx, align 4
    %idxprom312 = sext i32 %196 to i64
    %arrayidx313 = getelementptr inbounds i8, i8* %195, i64 %idxprom312
    store i8 46, i8* %arrayidx313, align 1
    %197 = load i8*, i8** %result, align 8
    %198 = load i32, i32* %idx, align 4
    %inc314 = add nsw i32 %198, 1
    store i32 %inc314, i32* %idx, align 4
    %idxprom315 = sext i32 %198 to i64
    %arrayidx316 = getelementptr inbounds i8, i8* %197, i64 %idxprom315
    store i8 48, i8* %arrayidx316, align 1
    br label %if.end351

if.else317:
    %199 = load i32, i32* %idx, align 4
    %add319 = add nsw i32 %199, 1
    store i32 %add319, i32* %cur318, align 4
    store i32 0, i32* %i320, align 4
    br label %for.cond321

for.cond321:
    %200 = load i32, i32* %i320, align 4
    %201 = load i32, i32* %outLen, align 4
    %cmp322 = icmp slt i32 %200, %201
    br i1 %cmp322, label %for.body324, label %for.end348

for.body324:
    %202 = load i32, i32* %outLen, align 4
    %203 = load i32, i32* %i320, align 4
    %sub325 = sub nsw i32 %202, %203
    %sub326 = sub nsw i32 %sub325, 1
    %204 = load i32, i32* %expon, align 4
    %cmp327 = icmp eq i32 %sub326, %204
    br i1 %cmp327, label %if.then329, label %if.end336

if.then329:
    %205 = load i8*, i8** %result, align 8
    %206 = load i32, i32* %cur318, align 4
    %207 = load i32, i32* %outLen, align 4
    %add330 = add nsw i32 %206, %207
    %208 = load i32, i32* %i320, align 4
    %sub331 = sub nsw i32 %add330, %208
    %sub332 = sub nsw i32 %sub331, 1
    %idxprom333 = sext i32 %sub332 to i64
    %arrayidx334 = getelementptr inbounds i8, i8* %205, i64 %idxprom333
    store i8 46, i8* %arrayidx334, align 1
    %209 = load i32, i32* %cur318, align 4
    %dec335 = add nsw i32 %209, -1
    store i32 %dec335, i32* %cur318, align 4
    br label %if.end336

if.end336:
    %210 = load i32, i32* %output, align 4
    %rem337 = srem i32 %210, 10
    %add338 = add nsw i32 48, %rem337
    %conv339 = trunc i32 %add338 to i8
    %211 = load i8*, i8** %result, align 8
    %212 = load i32, i32* %cur318, align 4
    %213 = load i32, i32* %outLen, align 4
    %add340 = add nsw i32 %212, %213
    %214 = load i32, i32* %i320, align 4
    %sub341 = sub nsw i32 %add340, %214
    %sub342 = sub nsw i32 %sub341, 1
    %idxprom343 = sext i32 %sub342 to i64
    %arrayidx344 = getelementptr inbounds i8, i8* %211, i64 %idxprom343
    store i8 %conv339, i8* %arrayidx344, align 1
    %215 = load i32, i32* %output, align 4
    %div345 = sdiv i32 %215, 10
    store i32 %div345, i32* %output, align 4
    br label %for.inc346

for.inc346:
    %216 = load i32, i32* %i320, align 4
    %inc347 = add nsw i32 %216, 1
    store i32 %inc347, i32* %i320, align 4
    br label %for.cond321

for.end348:
    %217 = load i32, i32* %outLen, align 4
    %add349 = add nsw i32 %217, 1
    %218 = load i32, i32* %idx, align 4
    %add350 = add nsw i32 %218, %add349
    store i32 %add350, i32* %idx, align 4
    br label %if.end351

if.end351:
    br label %if.end352

if.end352:
    br label %if.end353

if.end353:
    %219 = load i32, i32* %idx, align 4
    %len = getelementptr inbounds %type.string, %type.string* %retval, i32 0, i32 0
    store i32 %219, i32* %len, align 8
    %220 = load i32, i32* %idx, align 4
    %size = getelementptr inbounds %type.string, %type.string* %retval, i32 0, i32 1
    store i32 %220, i32* %size, align 4
    %221 = load i32, i32* %idx, align 4
    %conv354 = sext i32 %221 to i64
    %call355 = call noalias i8* @malloc(i64 %conv354)
    %addr = getelementptr inbounds %type.string, %type.string* %retval, i32 0, i32 2
    store i8* %call355, i8** %addr, align 8
    %addr356 = getelementptr inbounds %type.string, %type.string* %retval, i32 0, i32 2
    %222 = load i8*, i8** %addr356, align 8
    %223 = load i8*, i8** %result, align 8
    %224 = load i32, i32* %idx, align 4
    %conv357 = sext i32 %224 to i64
    %mul358 = mul i64 %conv357, 1
    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %222, i8* align 1 %223, i64 %mul358, i1 false)
    %225 = load i8*, i8** %result, align 8
    call void @free(i8* %225)
    %226 = bitcast %type.string* %retval to { i64, i8* }*
    %227 = load { i64, i8* }, { i64, i8* }* %226, align 8
    ret { i64, i8* } %227
}

declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg)

declare i8* @malloc(i64)
declare void @free(i8*)

define %type.string @".conv:float_string"(float %num) {
entry:
    %retval = alloca %type.string, align 8
    %num.addr = alloca float, align 4
    %bits = alloca i32, align 4
    %.compoundliteral = alloca %union.anon, align 4
    %str = alloca %type.string, align 8
    %sign = alloca i32, align 4
    store float %num, float* %num.addr, align 4
    %f = bitcast %union.anon* %.compoundliteral to float*
    %0 = load float, float* %num.addr, align 4
    store float %0, float* %f, align 4
    %i = bitcast %union.anon* %.compoundliteral to i32*
    %1 = load i32, i32* %i, align 4
    store i32 %1, i32* %bits, align 4
    %2 = load float, float* %num.addr, align 4
    %3 = load float, float* %num.addr, align 4
    %cmp = fcmp une float %2, %3
    br i1 %cmp, label %if.then, label %if.else

if.then:
    %len = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 0
    store i32 3, i32* %len, align 8
    %size = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 1
    store i32 3, i32* %size, align 4
    %addr = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 2
    store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.strNaN, i64 0, i64 0), i8** %addr, align 8
    %4 = bitcast %type.string* %retval to i8*
    %5 = bitcast %type.string* %str to i8*
    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %4, i8* align 8 %5, i64 16, i1 false)
    br label %return

if.else:
    %6 = load float, float* %num.addr, align 4
    %cmp1 = fcmp oeq float %6, 0x7FF0000000000000
    br i1 %cmp1, label %if.then2, label %if.else6

if.then2:
    %len3 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 0
    store i32 3, i32* %len3, align 8
    %size4 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 1
    store i32 3, i32* %size4, align 4
    %addr5 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 2
    store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.strPosInf, i64 0, i64 0), i8** %addr5, align 8
    %7 = bitcast %type.string* %retval to i8*
    %8 = bitcast %type.string* %str to i8*
    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %7, i8* align 8 %8, i64 16, i1 false)
    br label %return

if.else6:
    %9 = load float, float* %num.addr, align 4
    %cmp7 = fcmp oeq float %9, 0xFFF0000000000000
    br i1 %cmp7, label %if.then8, label %if.else12

if.then8:
    %len9 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 0
    store i32 4, i32* %len9, align 8
    %size10 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 1
    store i32 4, i32* %size10, align 4
    %addr11 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 2
    store i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.strNegInf, i64 0, i64 0), i8** %addr11, align 8
    %10 = bitcast %type.string* %retval to i8*
    %11 = bitcast %type.string* %str to i8*
    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %10, i8* align 8 %11, i64 16, i1 false)
    br label %return

if.else12:
    %12 = load float, float* %num.addr, align 4
    %cmp13 = fcmp oeq float %12, 0.000000e+00
    br i1 %cmp13, label %if.then14, label %if.else24

if.then14:
    %13 = load i32, i32* %bits, align 4
    %shr = lshr i32 %13, 31
    store i32 %shr, i32* %sign, align 4
    %14 = load i32, i32* %sign, align 4
    %cmp15 = icmp eq i32 %14, 0
    br i1 %cmp15, label %if.then16, label %if.else20

if.then16:
    %len17 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 0
    store i32 3, i32* %len17, align 8
    %size18 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 1
    store i32 3, i32* %size18, align 4
    %addr19 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 2
    store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.strPosZero, i64 0, i64 0), i8** %addr19, align 8
    br label %if.end

if.else20:
    %len21 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 0
    store i32 4, i32* %len21, align 8
    %size22 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 1
    store i32 4, i32* %size22, align 4
    %addr23 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 2
    store i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.strNegZero, i64 0, i64 0), i8** %addr23, align 8
    br label %if.end

if.end:
    %15 = bitcast %type.string* %retval to i8*
    %16 = bitcast %type.string* %str to i8*
    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %15, i8* align 8 %16, i64 16, i1 false)
    br label %return

if.else24:
    %17 = load float, float* %num.addr, align 4
    %18 = load i32, i32* %bits, align 4
    %call = call { i64, i8* } @normalString(float %17, i32 %18)
    %19 = bitcast %type.string* %retval to { i64, i8* }*
    %20 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %19, i32 0, i32 0
    %21 = extractvalue { i64, i8* } %call, 0
    store i64 %21, i64* %20, align 8
    %22 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %19, i32 0, i32 1
    %23 = extractvalue { i64, i8* } %call, 1
    store i8* %23, i8** %22, align 8
    br label %return

return:
    %24 = load %type.string, %type.string* %retval, align 8
    ret %type.string %24
}
source_filename = "lib/builtin/conversion/float_string.ll"

%type.string = type { i32, i32* }
%union.anon = type { float }

@FLOAT_POW5_INV_SPLIT = private unnamed_addr constant [31 x i64] [i64 576460752303423489, i64 461168601842738791, i64 368934881474191033, i64 295147905179352826, i64 472236648286964522, i64 377789318629571618, i64 302231454903657294, i64 483570327845851670, i64 386856262276681336, i64 309485009821345069, i64 495176015714152110, i64 396140812571321688, i64 316912650057057351, i64 507060240091291761, i64 405648192073033409, i64 324518553658426727, i64 519229685853482763, i64 415383748682786211, i64 332306998946228969, i64 531691198313966350, i64 425352958651173080, i64 340282366920938464, i64 544451787073501542, i64 435561429658801234, i64 348449143727040987, i64 557518629963265579, i64 446014903970612463, i64 356811923176489971, i64 570899077082383953, i64 456719261665907162, i64 365375409332725730], align 16
@FLOAT_POW5_SPLIT = private unnamed_addr constant [47 x i64] [i64 1152921504606846976, i64 1441151880758558720, i64 1801439850948198400, i64 2251799813685248000, i64 1407374883553280000, i64 1759218604441600000, i64 2199023255552000000, i64 1374389534720000000, i64 1717986918400000000, i64 2147483648000000000, i64 1342177280000000000, i64 1677721600000000000, i64 2097152000000000000, i64 1310720000000000000, i64 1638400000000000000, i64 2048000000000000000, i64 1280000000000000000, i64 1600000000000000000, i64 2000000000000000000, i64 1250000000000000000, i64 1562500000000000000, i64 1953125000000000000, i64 1220703125000000000, i64 1525878906250000000, i64 1907348632812500000, i64 1192092895507812500, i64 1490116119384765625, i64 1862645149230957031, i64 1164153218269348144, i64 1455191522836685180, i64 1818989403545856475, i64 2273736754432320594, i64 1421085471520200371, i64 1776356839400250464, i64 2220446049250313080, i64 1387778780781445675, i64 1734723475976807094, i64 2168404344971008868, i64 1355252715606880542, i64 1694065894508600678, i64 2117582368135750847, i64 1323488980084844279, i64 1654361225106055349, i64 2067951531382569187, i64 1292469707114105741, i64 1615587133892632177, i64 2019483917365790221], align 16

@strNaN = private unnamed_addr constant [3 x i32] [i32 110, i32 97, i32 110], align 4
@strPosInf = private unnamed_addr constant [3 x i32] [i32 105, i32 110, i32 102], align 4
@strNegInf = private unnamed_addr constant [4 x i32] [i32 45, i32 105, i32 110, i32 102], align 16
@strPosZero = private unnamed_addr constant [3 x i32] [i32 48, i32 46, i32 48], align 4
@strNegZero = private unnamed_addr constant [4 x i32] [i32 45, i32 48, i32 46, i32 48], align 16

declare i8* @malloc(i64)
declare void @free(i8*)

declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg)

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
    %arrayidx = getelementptr inbounds [31 x i64], [31 x i64]* @FLOAT_POW5_INV_SPLIT, i64 0, i64 %idxprom
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
    %arrayidx = getelementptr inbounds [47 x i64], [47 x i64]* @FLOAT_POW5_SPLIT, i64 0, i64 %idxprom
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
    %.ret = alloca i32, align 4
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
    store i32 %2, i32* %.ret, align 4
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
    store i32 0, i32* %.ret, align 4
    br label %return

return:
    %5 = load i32, i32* %.ret, align 4
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

define private %type.string @normalString(float %num, i32 %bits) {
entry:
    %.ret = alloca %type.string, align 8
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
    %result = alloca i32*, align 8
    %idx = alloca i32, align 4
    %i180 = alloca i32, align 4
    %c = alloca i32, align 4
    %i242 = alloca i32, align 4
    %cur = alloca i32, align 4
    %i253 = alloca i32, align 4
    %i275 = alloca i32, align 4
    %i292 = alloca i32, align 4
    %cur311 = alloca i32, align 4
    %i313 = alloca i32, align 4
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
    %call172 = call noalias i8* @malloc(i64 60)
    %118 = bitcast i8* %call172 to i32*
    store i32* %118, i32** %result, align 8
    store i32 0, i32* %idx, align 4
    %119 = load float, float* %num.addr, align 4
    %cmp173 = fcmp olt float %119, 0.000000e+00
    br i1 %cmp173, label %if.then175, label %if.end177

if.then175:
    %120 = load i32*, i32** %result, align 8
    %121 = load i32, i32* %idx, align 4
    %inc176 = add nsw i32 %121, 1
    store i32 %inc176, i32* %idx, align 4
    %idxprom = sext i32 %121 to i64
    %arrayidx = getelementptr inbounds i32, i32* %120, i64 %idxprom
    store i32 45, i32* %arrayidx, align 4
    br label %if.end177

if.end177:
    %122 = load i8, i8* %sciNot, align 1
    %tobool178 = trunc i8 %122 to i1
    br i1 %tobool178, label %if.then179, label %if.else232

if.then179:
    store i32 0, i32* %i180, align 4
    br label %for.cond

for.cond:
    %123 = load i32, i32* %i180, align 4
    %124 = load i32, i32* %outLen, align 4
    %sub181 = sub nsw i32 %124, 1
    %cmp182 = icmp slt i32 %123, %sub181
    br i1 %cmp182, label %for.body, label %for.end

for.body:
    %125 = load i32, i32* %output, align 4
    %rem184 = srem i32 %125, 10
    store i32 %rem184, i32* %c, align 4
    %126 = load i32, i32* %output, align 4
    %div185 = sdiv i32 %126, 10
    store i32 %div185, i32* %output, align 4
    %127 = load i32, i32* %c, align 4
    %add186 = add nsw i32 48, %127
    %128 = load i32*, i32** %result, align 8
    %129 = load i32, i32* %idx, align 4
    %130 = load i32, i32* %outLen, align 4
    %add187 = add nsw i32 %129, %130
    %131 = load i32, i32* %i180, align 4
    %sub188 = sub nsw i32 %add187, %131
    %idxprom189 = sext i32 %sub188 to i64
    %arrayidx190 = getelementptr inbounds i32, i32* %128, i64 %idxprom189
    store i32 %add186, i32* %arrayidx190, align 4
    br label %for.inc

for.inc:
    %132 = load i32, i32* %i180, align 4
    %inc191 = add nsw i32 %132, 1
    store i32 %inc191, i32* %i180, align 4
    br label %for.cond

for.end:
    %133 = load i32, i32* %output, align 4
    %rem192 = srem i32 %133, 10
    %add193 = add nsw i32 48, %rem192
    %134 = load i32*, i32** %result, align 8
    %135 = load i32, i32* %idx, align 4
    %idxprom194 = sext i32 %135 to i64
    %arrayidx195 = getelementptr inbounds i32, i32* %134, i64 %idxprom194
    store i32 %add193, i32* %arrayidx195, align 4
    %136 = load i32*, i32** %result, align 8
    %137 = load i32, i32* %idx, align 4
    %inc196 = add nsw i32 %137, 1
    store i32 %inc196, i32* %idx, align 4
    %idxprom197 = sext i32 %inc196 to i64
    %arrayidx198 = getelementptr inbounds i32, i32* %136, i64 %idxprom197
    store i32 46, i32* %arrayidx198, align 4
    %138 = load i32, i32* %outLen, align 4
    %139 = load i32, i32* %idx, align 4
    %add199 = add nsw i32 %139, %138
    store i32 %add199, i32* %idx, align 4
    %140 = load i32, i32* %outLen, align 4
    %cmp200 = icmp eq i32 %140, 1
    br i1 %cmp200, label %if.then202, label %if.end206

if.then202:
    %141 = load i32*, i32** %result, align 8
    %142 = load i32, i32* %idx, align 4
    %inc203 = add nsw i32 %142, 1
    store i32 %inc203, i32* %idx, align 4
    %idxprom204 = sext i32 %142 to i64
    %arrayidx205 = getelementptr inbounds i32, i32* %141, i64 %idxprom204
    store i32 48, i32* %arrayidx205, align 4
    br label %if.end206

if.end206:
    %143 = load i32*, i32** %result, align 8
    %144 = load i32, i32* %idx, align 4
    %inc207 = add nsw i32 %144, 1
    store i32 %inc207, i32* %idx, align 4
    %idxprom208 = sext i32 %144 to i64
    %arrayidx209 = getelementptr inbounds i32, i32* %143, i64 %idxprom208
    store i32 101, i32* %arrayidx209, align 4
    %145 = load i32, i32* %expon, align 4
    %cmp210 = icmp slt i32 %145, 0
    br i1 %cmp210, label %if.then212, label %if.end217

if.then212:
    %146 = load i32*, i32** %result, align 8
    %147 = load i32, i32* %idx, align 4
    %inc213 = add nsw i32 %147, 1
    store i32 %inc213, i32* %idx, align 4
    %idxprom214 = sext i32 %147 to i64
    %arrayidx215 = getelementptr inbounds i32, i32* %146, i64 %idxprom214
    store i32 45, i32* %arrayidx215, align 4
    %148 = load i32, i32* %expon, align 4
    %sub216 = sub nsw i32 0, %148
    store i32 %sub216, i32* %expon, align 4
    br label %if.end217

if.end217:
    %149 = load i32, i32* %expon, align 4
    %cmp218 = icmp sge i32 %149, 10
    br i1 %cmp218, label %if.then220, label %if.end226

if.then220:
    %150 = load i32, i32* %expon, align 4
    %div221 = sdiv i32 %150, 10
    %add222 = add nsw i32 48, %div221
    %151 = load i32*, i32** %result, align 8
    %152 = load i32, i32* %idx, align 4
    %inc223 = add nsw i32 %152, 1
    store i32 %inc223, i32* %idx, align 4
    %idxprom224 = sext i32 %152 to i64
    %arrayidx225 = getelementptr inbounds i32, i32* %151, i64 %idxprom224
    store i32 %add222, i32* %arrayidx225, align 4
    br label %if.end226

if.end226:
    %153 = load i32, i32* %expon, align 4
    %rem227 = srem i32 %153, 10
    %add228 = add nsw i32 48, %rem227
    %154 = load i32*, i32** %result, align 8
    %155 = load i32, i32* %idx, align 4
    %inc229 = add nsw i32 %155, 1
    store i32 %inc229, i32* %idx, align 4
    %idxprom230 = sext i32 %155 to i64
    %arrayidx231 = getelementptr inbounds i32, i32* %154, i64 %idxprom230
    store i32 %add228, i32* %arrayidx231, align 4
    br label %if.end345

if.else232:
    %156 = load i32, i32* %expon, align 4
    %cmp233 = icmp slt i32 %156, 0
    br i1 %cmp233, label %if.then235, label %if.else270

if.then235:
    %157 = load i32*, i32** %result, align 8
    %158 = load i32, i32* %idx, align 4
    %inc236 = add nsw i32 %158, 1
    store i32 %inc236, i32* %idx, align 4
    %idxprom237 = sext i32 %158 to i64
    %arrayidx238 = getelementptr inbounds i32, i32* %157, i64 %idxprom237
    store i32 48, i32* %arrayidx238, align 4
    %159 = load i32*, i32** %result, align 8
    %160 = load i32, i32* %idx, align 4
    %inc239 = add nsw i32 %160, 1
    store i32 %inc239, i32* %idx, align 4
    %idxprom240 = sext i32 %160 to i64
    %arrayidx241 = getelementptr inbounds i32, i32* %159, i64 %idxprom240
    store i32 47, i32* %arrayidx241, align 4
    store i32 -1, i32* %i242, align 4
    br label %for.cond243

for.cond243:
    %161 = load i32, i32* %i242, align 4
    %162 = load i32, i32* %expon, align 4
    %cmp244 = icmp sgt i32 %161, %162
    br i1 %cmp244, label %for.body246, label %for.end252

for.body246:
    %163 = load i32*, i32** %result, align 8
    %164 = load i32, i32* %idx, align 4
    %inc247 = add nsw i32 %164, 1
    store i32 %inc247, i32* %idx, align 4
    %idxprom248 = sext i32 %164 to i64
    %arrayidx249 = getelementptr inbounds i32, i32* %163, i64 %idxprom248
    store i32 48, i32* %arrayidx249, align 4
    br label %for.inc250

for.inc250:
    %165 = load i32, i32* %i242, align 4
    %dec251 = add nsw i32 %165, -1
    store i32 %dec251, i32* %i242, align 4
    br label %for.cond243

for.end252:
    %166 = load i32, i32* %idx, align 4
    store i32 %166, i32* %cur, align 4
    store i32 0, i32* %i253, align 4
    br label %for.cond254

for.cond254:
    %167 = load i32, i32* %i253, align 4
    %168 = load i32, i32* %outLen, align 4
    %cmp255 = icmp slt i32 %167, %168
    br i1 %cmp255, label %for.body257, label %for.end269

for.body257:
    %169 = load i32, i32* %output, align 4
    %rem258 = srem i32 %169, 10
    %add259 = add nsw i32 48, %rem258
    %170 = load i32*, i32** %result, align 8
    %171 = load i32, i32* %cur, align 4
    %172 = load i32, i32* %outLen, align 4
    %add260 = add nsw i32 %171, %172
    %173 = load i32, i32* %i253, align 4
    %sub261 = sub nsw i32 %add260, %173
    %sub262 = sub nsw i32 %sub261, 1
    %idxprom263 = sext i32 %sub262 to i64
    %arrayidx264 = getelementptr inbounds i32, i32* %170, i64 %idxprom263
    store i32 %add259, i32* %arrayidx264, align 4
    %174 = load i32, i32* %output, align 4
    %div265 = sdiv i32 %174, 10
    store i32 %div265, i32* %output, align 4
    %175 = load i32, i32* %idx, align 4
    %inc266 = add nsw i32 %175, 1
    store i32 %inc266, i32* %idx, align 4
    br label %for.inc267

for.inc267:
    %176 = load i32, i32* %i253, align 4
    %inc268 = add nsw i32 %176, 1
    store i32 %inc268, i32* %i253, align 4
    br label %for.cond254

for.end269:
    br label %if.end344

if.else270:
    %177 = load i32, i32* %expon, align 4
    %add271 = add nsw i32 %177, 1
    %178 = load i32, i32* %outLen, align 4
    %cmp272 = icmp sge i32 %add271, %178
    br i1 %cmp272, label %if.then274, label %if.else310

if.then274:
    store i32 0, i32* %i275, align 4
    br label %for.cond276

for.cond276:
    %179 = load i32, i32* %i275, align 4
    %180 = load i32, i32* %outLen, align 4
    %cmp277 = icmp slt i32 %179, %180
    br i1 %cmp277, label %for.body279, label %for.end290

for.body279:
    %181 = load i32, i32* %output, align 4
    %rem280 = srem i32 %181, 10
    %add281 = add nsw i32 48, %rem280
    %182 = load i32*, i32** %result, align 8
    %183 = load i32, i32* %idx, align 4
    %184 = load i32, i32* %outLen, align 4
    %add282 = add nsw i32 %183, %184
    %185 = load i32, i32* %i275, align 4
    %sub283 = sub nsw i32 %add282, %185
    %sub284 = sub nsw i32 %sub283, 1
    %idxprom285 = sext i32 %sub284 to i64
    %arrayidx286 = getelementptr inbounds i32, i32* %182, i64 %idxprom285
    store i32 %add281, i32* %arrayidx286, align 4
    %186 = load i32, i32* %output, align 4
    %div287 = sdiv i32 %186, 10
    store i32 %div287, i32* %output, align 4
    br label %for.inc288

for.inc288:
    %187 = load i32, i32* %i275, align 4
    %inc289 = add nsw i32 %187, 1
    store i32 %inc289, i32* %i275, align 4
    br label %for.cond276

for.end290:
    %188 = load i32, i32* %outLen, align 4
    %189 = load i32, i32* %idx, align 4
    %add291 = add nsw i32 %189, %188
    store i32 %add291, i32* %idx, align 4
    %190 = load i32, i32* %outLen, align 4
    store i32 %190, i32* %i292, align 4
    br label %for.cond293

for.cond293:
    %191 = load i32, i32* %i292, align 4
    %192 = load i32, i32* %expon, align 4
    %add294 = add nsw i32 %192, 1
    %cmp295 = icmp slt i32 %191, %add294
    br i1 %cmp295, label %for.body297, label %for.end303

for.body297:
    %193 = load i32*, i32** %result, align 8
    %194 = load i32, i32* %idx, align 4
    %inc298 = add nsw i32 %194, 1
    store i32 %inc298, i32* %idx, align 4
    %idxprom299 = sext i32 %194 to i64
    %arrayidx300 = getelementptr inbounds i32, i32* %193, i64 %idxprom299
    store i32 48, i32* %arrayidx300, align 4
    br label %for.inc301

for.inc301:
    %195 = load i32, i32* %i292, align 4
    %inc302 = add nsw i32 %195, 1
    store i32 %inc302, i32* %i292, align 4
    br label %for.cond293

for.end303:
    %196 = load i32*, i32** %result, align 8
    %197 = load i32, i32* %idx, align 4
    %inc304 = add nsw i32 %197, 1
    store i32 %inc304, i32* %idx, align 4
    %idxprom305 = sext i32 %197 to i64
    %arrayidx306 = getelementptr inbounds i32, i32* %196, i64 %idxprom305
    store i32 46, i32* %arrayidx306, align 4
    %198 = load i32*, i32** %result, align 8
    %199 = load i32, i32* %idx, align 4
    %inc307 = add nsw i32 %199, 1
    store i32 %inc307, i32* %idx, align 4
    %idxprom308 = sext i32 %199 to i64
    %arrayidx309 = getelementptr inbounds i32, i32* %198, i64 %idxprom308
    store i32 48, i32* %arrayidx309, align 4
    br label %if.end343

if.else310:
    %200 = load i32, i32* %idx, align 4
    %add312 = add nsw i32 %200, 1
    store i32 %add312, i32* %cur311, align 4
    store i32 0, i32* %i313, align 4
    br label %for.cond314

for.cond314:
    %201 = load i32, i32* %i313, align 4
    %202 = load i32, i32* %outLen, align 4
    %cmp315 = icmp slt i32 %201, %202
    br i1 %cmp315, label %for.body317, label %for.end340

for.body317:
    %203 = load i32, i32* %outLen, align 4
    %204 = load i32, i32* %i313, align 4
    %sub318 = sub nsw i32 %203, %204
    %sub319 = sub nsw i32 %sub318, 1
    %205 = load i32, i32* %expon, align 4
    %cmp320 = icmp eq i32 %sub319, %205
    br i1 %cmp320, label %if.then322, label %if.end329

if.then322:
    %206 = load i32*, i32** %result, align 8
    %207 = load i32, i32* %cur311, align 4
    %208 = load i32, i32* %outLen, align 4
    %add323 = add nsw i32 %207, %208
    %209 = load i32, i32* %i313, align 4
    %sub324 = sub nsw i32 %add323, %209
    %sub325 = sub nsw i32 %sub324, 1
    %idxprom326 = sext i32 %sub325 to i64
    %arrayidx327 = getelementptr inbounds i32, i32* %206, i64 %idxprom326
    store i32 46, i32* %arrayidx327, align 4
    %210 = load i32, i32* %cur311, align 4
    %dec328 = add nsw i32 %210, -1
    store i32 %dec328, i32* %cur311, align 4
    br label %if.end329

if.end329:
    %211 = load i32, i32* %output, align 4
    %rem330 = srem i32 %211, 10
    %add331 = add nsw i32 48, %rem330
    %212 = load i32*, i32** %result, align 8
    %213 = load i32, i32* %cur311, align 4
    %214 = load i32, i32* %outLen, align 4
    %add332 = add nsw i32 %213, %214
    %215 = load i32, i32* %i313, align 4
    %sub333 = sub nsw i32 %add332, %215
    %sub334 = sub nsw i32 %sub333, 1
    %idxprom335 = sext i32 %sub334 to i64
    %arrayidx336 = getelementptr inbounds i32, i32* %212, i64 %idxprom335
    store i32 %add331, i32* %arrayidx336, align 4
    %216 = load i32, i32* %output, align 4
    %div337 = sdiv i32 %216, 10
    store i32 %div337, i32* %output, align 4
    br label %for.inc338

for.inc338:
    %217 = load i32, i32* %i313, align 4
    %inc339 = add nsw i32 %217, 1
    store i32 %inc339, i32* %i313, align 4
    br label %for.cond314

for.end340:
    %218 = load i32, i32* %outLen, align 4
    %add341 = add nsw i32 %218, 1
    %219 = load i32, i32* %idx, align 4
    %add342 = add nsw i32 %219, %add341
    store i32 %add342, i32* %idx, align 4
    br label %if.end343

if.end343:
    br label %if.end344

if.end344:
    br label %if.end345

if.end345:
    %220 = load i32, i32* %idx, align 4
    %len = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
    store i32 %220, i32* %len, align 8
    %221 = load i32, i32* %idx, align 4
    %conv346 = sext i32 %221 to i64
    %mul347 = mul i64 %conv346, 4
    %call348 = call noalias i8* @malloc(i64 %mul347)
    %222 = bitcast i8* %call348 to i32*
    %chars = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
    store i32* %222, i32** %chars, align 8
    %chars349 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
    %223 = load i32*, i32** %chars349, align 8
    %224 = bitcast i32* %223 to i8*
    %225 = load i32*, i32** %result, align 8
    %226 = bitcast i32* %225 to i8*
    %227 = load i32, i32* %idx, align 4
    %conv350 = sext i32 %227 to i64
    %mul351 = mul i64 %conv350, 4
    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %224, i8* align 4 %226, i64 %mul351, i1 false)
    %228 = load i32*, i32** %result, align 8
    %229 = bitcast i32* %228 to i8*
    call void @free(i8* %229) 
    %230 = load %type.string, %type.string* %.ret, align 8
    ret %type.string %230
}

define %type.string @".conv:float_string"(float %num) {
entry:
    %.ret = alloca %type.string, align 8
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
    %chars = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 1
    store i32* getelementptr inbounds ([3 x i32], [3 x i32]* @strNaN, i64 0, i64 0), i32** %chars, align 8
    %4 = bitcast %type.string* %.ret to i8*
    %5 = bitcast %type.string* %str to i8*
    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %4, i8* align 8 %5, i64 16, i1 false)
    br label %return

if.else:
    %6 = load float, float* %num.addr, align 4
    %cmp1 = fcmp oeq float %6, 0x7FF0000000000000
    br i1 %cmp1, label %if.then2, label %if.else5

if.then2:
    %len3 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 0
    store i32 3, i32* %len3, align 8
    %chars4 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 1
    store i32* getelementptr inbounds ([3 x i32], [3 x i32]* @strPosInf, i64 0, i64 0), i32** %chars4, align 8
    %7 = bitcast %type.string* %.ret to i8*
    %8 = bitcast %type.string* %str to i8*
    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %7, i8* align 8 %8, i64 16, i1 false)
    br label %return

if.else5:
    %9 = load float, float* %num.addr, align 4
    %cmp6 = fcmp oeq float %9, 0xFFF0000000000000
    br i1 %cmp6, label %if.then7, label %if.else10

if.then7:
    %len8 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 0
    store i32 4, i32* %len8, align 8
    %chars9 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 1
    store i32* getelementptr inbounds ([4 x i32], [4 x i32]* @strNegInf, i64 0, i64 0), i32** %chars9, align 8
    %10 = bitcast %type.string* %.ret to i8*
    %11 = bitcast %type.string* %str to i8*
    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %10, i8* align 8 %11, i64 16, i1 false)
    br label %return

if.else10:
    %12 = load float, float* %num.addr, align 4
    %cmp11 = fcmp oeq float %12, 0.000000e+00
    br i1 %cmp11, label %if.then12, label %if.else20

if.then12:
    %13 = load i32, i32* %bits, align 4
    %shr = lshr i32 %13, 31
    store i32 %shr, i32* %sign, align 4
    %14 = load i32, i32* %sign, align 4
    %cmp13 = icmp eq i32 %14, 0
    br i1 %cmp13, label %if.then14, label %if.else17

if.then14:
    %len15 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 0
    store i32 3, i32* %len15, align 8
    %chars16 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 1
    store i32* getelementptr inbounds ([3 x i32], [3 x i32]* @strPosZero, i64 0, i64 0), i32** %chars16, align 8
    br label %if.end

if.else17:
    %len18 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 0
    store i32 4, i32* %len18, align 8
    %chars19 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 1
    store i32* getelementptr inbounds ([4 x i32], [4 x i32]* @strNegZero, i64 0, i64 0), i32** %chars19, align 8
    br label %if.end

if.end:
    %15 = bitcast %type.string* %.ret to i8*
    %16 = bitcast %type.string* %str to i8*
    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %15, i8* align 8 %16, i64 16, i1 false)
    br label %return

if.else20:
    %17 = load float, float* %num.addr, align 4
    %18 = load i32, i32* %bits, align 4
    %call = call %type.string @normalString(float %17, i32 %18)
    store %type.string %call, %type.string* %.ret, align 8
    br label %return

return:
    %19 = load %type.string, %type.string* %.ret, align 8
    ret %type.string %19
}
; ModuleID = 'script-optimized.bc'
source_filename = "llvm-link"

%type.string = type { i32, i32, i8* }
%ref.float = type { float*, i32 }
%ref.int = type { i32*, i32 }
%ref.string = type { %type.string*, i32 }

@.strTrue = private unnamed_addr constant [4 x i8] c"true", align 1
@.strFalse = private unnamed_addr constant [5 x i8] c"false", align 1
@float_pow5_inv_split = private constant [31 x i64] [i64 576460752303423489, i64 461168601842738791, i64 368934881474191033, i64 295147905179352826, i64 472236648286964522, i64 377789318629571618, i64 302231454903657294, i64 483570327845851670, i64 386856262276681336, i64 309485009821345069, i64 495176015714152110, i64 396140812571321688, i64 316912650057057351, i64 507060240091291761, i64 405648192073033409, i64 324518553658426727, i64 519229685853482763, i64 415383748682786211, i64 332306998946228969, i64 531691198313966350, i64 425352958651173080, i64 340282366920938464, i64 544451787073501542, i64 435561429658801234, i64 348449143727040987, i64 557518629963265579, i64 446014903970612463, i64 356811923176489971, i64 570899077082383953, i64 456719261665907162, i64 365375409332725730], align 4
@float_pow5_split = private constant [47 x i64] [i64 1152921504606846976, i64 1441151880758558720, i64 1801439850948198400, i64 2251799813685248000, i64 1407374883553280000, i64 1759218604441600000, i64 2199023255552000000, i64 1374389534720000000, i64 1717986918400000000, i64 2147483648000000000, i64 1342177280000000000, i64 1677721600000000000, i64 2097152000000000000, i64 1310720000000000000, i64 1638400000000000000, i64 2048000000000000000, i64 1280000000000000000, i64 1600000000000000000, i64 2000000000000000000, i64 1250000000000000000, i64 1562500000000000000, i64 1953125000000000000, i64 1220703125000000000, i64 1525878906250000000, i64 1907348632812500000, i64 1192092895507812500, i64 1490116119384765625, i64 1862645149230957031, i64 1164153218269348144, i64 1455191522836685180, i64 1818989403545856475, i64 2273736754432320594, i64 1421085471520200371, i64 1776356839400250464, i64 2220446049250313080, i64 1387778780781445675, i64 1734723475976807094, i64 2168404344971008868, i64 1355252715606880542, i64 1694065894508600678, i64 2117582368135750847, i64 1323488980084844279, i64 1654361225106055349, i64 2067951531382569187, i64 1292469707114105741, i64 1615587133892632177, i64 2019483917365790221], align 4
@.strNaN = private unnamed_addr constant [3 x i8] c"nan", align 1
@.strPosInf = private unnamed_addr constant [3 x i8] c"inf", align 1
@.strNegInf = private unnamed_addr constant [4 x i8] c"-inf", align 1
@.strPosZero = private unnamed_addr constant [3 x i8] c"0.0", align 1
@.strNegZero = private unnamed_addr constant [4 x i8] c"-0.0", align 1
@.strFree = private unnamed_addr constant [17 x i8] c"Freed from memory", align 1
@.strCount = private unnamed_addr constant [11 x i8] c" references", align 1
@.str0 = private unnamed_addr constant [9 x i8] c" now has ", align 1
@.str1 = private unnamed_addr constant [11 x i8] c" references", align 1
@.strZero = private unnamed_addr constant [1 x i8] c"0", align 1

define %type.string @".conv:bool_string"(i1 %bool) {
entry:
  %.ret = alloca %type.string, align 8
  br i1 %bool, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %0 = getelementptr inbounds [4 x i8], [4 x i8]* @.strTrue, i32 0, i32 0
  %1 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
  store i32 4, i32* %1, align 8
  %2 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
  store i32 4, i32* %2, align 8
  %3 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 2
  store i8* %0, i8** %3, align 8
  br label %exit

if.else:                                          ; preds = %entry
  %4 = getelementptr inbounds [5 x i8], [5 x i8]* @.strFalse, i32 0, i32 0
  %5 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
  store i32 5, i32* %5, align 8
  %6 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
  store i32 5, i32* %6, align 8
  %7 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 2
  store i8* %4, i8** %7, align 8
  br label %exit

exit:                                             ; preds = %if.else, %if.then
  %8 = load %type.string, %type.string* %.ret, align 8
  ret %type.string %8
}

define %ref.float* @"newref:float"(float %value) {
entry:
  %value.addr = alloca float, align 4
  %ref = alloca %ref.float*, align 8
  store float %value, float* %value.addr, align 4
  %call = call i8* @malloc(i32 16)
  %0 = bitcast i8* %call to %ref.float*
  store %ref.float* %0, %ref.float** %ref, align 8
  %call1 = call i8* @malloc(i32 4)
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
  store i32 0, i32* %count, align 8
  %7 = load %ref.float*, %ref.float** %ref, align 8
  ret %ref.float* %7
}

declare i8* @malloc(i32)

define void @"ref:float"(%ref.float* %ref) {
entry:
  %0 = getelementptr inbounds %ref.float, %ref.float* %ref, i32 0, i32 1
  %1 = load i32, i32* %0, align 8
  %2 = add i32 %1, 1
  call void @countMsg(i32 %2)
  store i32 %2, i32* %0, align 8
  ret void
}

define void @countMsg(i32 %0) {
entry:
  %1 = call %type.string @".conv:int_string"(i32 %0)
  %2 = getelementptr inbounds [11 x i8], [11 x i8]* @.strCount, i32 0, i32 0
  %3 = alloca %type.string, align 8
  %4 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 0
  store i32 11, i32* %4, align 8
  %5 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 1
  store i32 11, i32* %5, align 8
  %6 = getelementptr inbounds %type.string, %type.string* %3, i32 0, i32 2
  store i8* %2, i8** %6, align 8
  %7 = load %type.string, %type.string* %3, align 8
  %8 = call %type.string @".add:string_string"(%type.string %1, %type.string %7)
  call void @.println(%type.string %8)
  ret void
}

define %type.string @".conv:int_string"(i32 %int) {
entry:
  %.ret = alloca %type.string, align 8
  %0 = icmp eq i32 %int, 0
  br i1 %0, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = getelementptr inbounds [1 x i8], [1 x i8]* @.strZero, i32 0, i32 0
  %2 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
  store i32 1, i32* %2, align 8
  %3 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
  store i32 1, i32* %3, align 8
  %4 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 2
  store i8* %1, i8** %4, align 8
  br label %exit

if.end:                                           ; preds = %entry
  %int.addr = alloca i32, align 4
  store i32 %int, i32* %int.addr, align 4
  %buf = alloca i8*, align 8
  %buf.addr = call i8* @malloc(i32 10)
  store i8* %buf.addr, i8** %buf, align 8
  %i = alloca i32, align 4
  store i32 9, i32* %i, align 4
  %sign = alloca i32, align 4
  store i32 0, i32* %sign, align 4
  %5 = load i32, i32* %int.addr, align 4
  %6 = load i8*, i8** %buf, align 8
  %7 = icmp slt i32 %5, 0
  br i1 %7, label %if.then1, label %if.end1

if.then1:                                         ; preds = %if.end
  %8 = sub i32 0, %5
  store i32 %8, i32* %int.addr, align 4
  store i32 1, i32* %sign, align 4
  br label %if.end1

if.end1:                                          ; preds = %if.then1, %if.end
  br label %while.cond

while.cond:                                       ; preds = %while.body, %if.end1
  %9 = load i32, i32* %int.addr, align 4
  %10 = icmp sgt i32 %9, 0
  br i1 %10, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %11 = srem i32 %9, 10
  %12 = add i32 48, %11
  %13 = trunc i32 %12 to i8
  %14 = load i32, i32* %i, align 4
  %15 = getelementptr inbounds i8, i8* %6, i32 %14
  store i8 %13, i8* %15, align 1
  %16 = sdiv i32 %9, 10
  store i32 %16, i32* %int.addr, align 4
  %17 = add i32 %14, -1
  store i32 %17, i32* %i, align 4
  br label %while.cond

while.end:                                        ; preds = %while.cond
  %size = alloca i32, align 4
  %18 = load i32, i32* %i, align 4
  %19 = sub i32 9, %18
  %20 = load i32, i32* %sign, align 4
  %21 = add i32 %19, %20
  store i32 %21, i32* %size, align 4
  %22 = load i32, i32* %size, align 4
  %.ret.len = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
  store i32 %22, i32* %.ret.len, align 8
  %.ret.size = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
  store i32 %22, i32* %.ret.size, align 8
  %.ret.addr = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 2
  %23 = call i8* @malloc(i32 %22)
  store i8* %23, i8** %.ret.addr, align 8
  %24 = icmp ne i32 %20, 0
  br i1 %24, label %if.then2, label %if.else2

if.then2:                                         ; preds = %while.end
  %25 = load i8*, i8** %.ret.addr, align 8
  %26 = getelementptr inbounds i8, i8* %25, i32 0
  store i8 45, i8* %26, align 1
  br label %if.end2

if.else2:                                         ; preds = %while.end
  %27 = add i32 %18, 1
  store i32 %27, i32* %i, align 4
  br label %if.end2

if.end2:                                          ; preds = %if.else2, %if.then2
  %j = alloca i32, align 4
  store i32 %20, i32* %j, align 4
  %28 = load i32, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end2
  %29 = load i32, i32* %j, align 4
  %30 = icmp slt i32 %29, %22
  br i1 %30, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %31 = add i32 %28, %29
  %32 = getelementptr inbounds i8, i8* %6, i32 %31
  %33 = load i8, i8* %32, align 1
  %.ret.addr2 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 2
  %34 = load i8*, i8** %.ret.addr2, align 8
  %35 = getelementptr inbounds i8, i8* %34, i32 %29
  store i8 %33, i8* %35, align 1
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %36 = add i32 %29, 1
  store i32 %36, i32* %j, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call void @free(i8* %6)
  br label %exit

exit:                                             ; preds = %for.end, %if.then
  %37 = load %type.string, %type.string* %.ret, align 8
  ret %type.string %37
}

define %type.string @".add:string_string"(%type.string %a, %type.string %b) {
entry:
  %.ret = alloca %type.string, align 8
  %ptr.a = alloca %type.string, align 8
  store %type.string %a, %type.string* %ptr.a, align 8
  %ptr.b = alloca %type.string, align 8
  store %type.string %b, %type.string* %ptr.b, align 8
  %0 = getelementptr inbounds %type.string, %type.string* %ptr.a, i32 0, i32 0
  %1 = load i32, i32* %0, align 4
  %2 = getelementptr inbounds %type.string, %type.string* %ptr.b, i32 0, i32 0
  %3 = load i32, i32* %2, align 4
  %4 = add i32 %1, %3
  %5 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
  store i32 %4, i32* %5, align 8
  %6 = getelementptr inbounds %type.string, %type.string* %ptr.a, i32 0, i32 1
  %7 = load i32, i32* %6, align 4
  %8 = getelementptr inbounds %type.string, %type.string* %ptr.b, i32 0, i32 1
  %9 = load i32, i32* %8, align 4
  %10 = add i32 %7, %9
  %11 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
  store i32 %10, i32* %11, align 8
  %12 = call i8* @malloc(i32 %10)
  %13 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 2
  store i8* %12, i8** %13, align 8
  %i = alloca i32, align 4
  store i32 0, i32* %i, align 4
  %j = alloca i32, align 4
  store i32 0, i32* %j, align 4
  %14 = getelementptr inbounds %type.string, %type.string* %ptr.a, i32 0, i32 2
  %15 = getelementptr inbounds %type.string, %type.string* %ptr.b, i32 0, i32 2
  br label %while1.cond

while1.cond:                                      ; preds = %while1.body, %entry
  %16 = load i32, i32* %i, align 4
  %17 = icmp slt i32 %16, %7
  br i1 %17, label %while1.body, label %while1.end

while1.body:                                      ; preds = %while1.cond
  %18 = load i32, i32* %i, align 4
  %19 = load i8*, i8** %13, align 8
  %20 = getelementptr inbounds i8, i8* %19, i32 %18
  %21 = load i8*, i8** %14, align 8
  %22 = getelementptr inbounds i8, i8* %21, i32 %18
  %23 = load i8, i8* %22, align 1
  store i8 %23, i8* %20, align 1
  %24 = load i32, i32* %i, align 4
  %25 = add i32 %24, 1
  store i32 %25, i32* %i, align 4
  br label %while1.cond

while1.end:                                       ; preds = %while1.cond
  br label %while2.cond

while2.cond:                                      ; preds = %while2.body, %while1.end
  %26 = load i32, i32* %i, align 4
  %27 = icmp slt i32 %26, %10
  br i1 %27, label %while2.body, label %while2.end

while2.body:                                      ; preds = %while2.cond
  %28 = load i32, i32* %i, align 4
  %29 = load i32, i32* %j, align 4
  %30 = load i8*, i8** %13, align 8
  %31 = getelementptr inbounds i8, i8* %30, i32 %28
  %32 = load i8*, i8** %15, align 8
  %33 = getelementptr inbounds i8, i8* %32, i32 %29
  %34 = load i8, i8* %33, align 1
  store i8 %34, i8* %31, align 1
  %35 = load i32, i32* %i, align 4
  %36 = add i32 %35, 1
  store i32 %36, i32* %i, align 4
  %37 = load i32, i32* %j, align 4
  %38 = add i32 %37, 1
  store i32 %38, i32* %j, align 4
  br label %while2.cond

while2.end:                                       ; preds = %while2.cond
  %39 = load %type.string, %type.string* %.ret, align 8
  ret %type.string %39
}

define void @.println(%type.string %str) {
entry:
  call void @.print(%type.string %str)
  call void @putchar(i8 10)
  ret void
}

define void @.print(%type.string %str) {
entry:
  %ptr.str = alloca %type.string, align 8
  store %type.string %str, %type.string* %ptr.str, align 8
  %i = alloca i32, align 8
  %0 = getelementptr inbounds %type.string, %type.string* %ptr.str, i32 0, i32 1
  %1 = getelementptr inbounds %type.string, %type.string* %ptr.str, i32 0, i32 2
  %2 = load i32, i32* %0, align 8
  %3 = load i8*, i8** %1, align 8
  store i32 0, i32* %i, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %4 = load i32, i32* %i, align 8
  %ptr.str.len = getelementptr inbounds %type.string, %type.string* %ptr.str, i32 0, i32 1
  %5 = load i32, i32* %ptr.str.len, align 8
  %cmp = icmp slt i32 %4, %5
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %ptr.str.addr = getelementptr inbounds %type.string, %type.string* %ptr.str, i32 0, i32 2
  %6 = load i8*, i8** %ptr.str.addr, align 8
  %7 = load i32, i32* %i, align 8
  %ptr.str.idx = getelementptr inbounds i8, i8* %6, i32 %7
  %8 = load i8, i8* %ptr.str.idx, align 1
  call void @putchar(i8 %8)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %9 = load i32, i32* %i, align 8
  %inc = add nsw i32 %9, 1
  store i32 %inc, i32* %i, align 8
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

declare void @putchar(i8)

declare void @free(i8*)

define void @"deref:float"(%ref.float* %ref) {
entry:
  %0 = getelementptr inbounds %ref.float, %ref.float* %ref, i32 0, i32 1
  %1 = load i32, i32* %0, align 8
  %2 = add i32 %1, -1
  call void @countMsg(i32 %2)
  store i32 %2, i32* %0, align 8
  %3 = icmp eq i32 %2, 0
  br i1 %3, label %if.then, label %exit

if.then:                                          ; preds = %entry
  %4 = getelementptr inbounds %ref.float, %ref.float* %ref, i32 0, i32 0
  %5 = load float*, float** %4, align 8
  %6 = bitcast float* %5 to i8*
  call void @free(i8* %6)
  %7 = bitcast %ref.float* %ref to i8*
  call void @free(i8* %7)
  call void @freeMsg()
  br label %exit

exit:                                             ; preds = %if.then, %entry
  ret void
}

define void @freeMsg() {
entry:
  %0 = getelementptr inbounds [17 x i8], [17 x i8]* @.strFree, i32 0, i32 0
  %1 = alloca %type.string, align 8
  %2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
  store i32 17, i32* %2, align 8
  %3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
  store i32 17, i32* %3, align 8
  %4 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 2
  store i8* %0, i8** %4, align 8
  %5 = load %type.string, %type.string* %1, align 8
  call void @.println(%type.string %5)
  ret void
}

define %type.string @".conv:float_string"(float %float) {
entry:
  %.ret = alloca %type.string, align 8
  %0 = fcmp une float %float, %float
  br i1 %0, label %nan.then, label %nan.exit

nan.then:                                         ; preds = %entry
  %1 = getelementptr inbounds [3 x i8], [3 x i8]* @.strNaN, i32 0, i32 0
  %2 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
  store i32 3, i32* %2, align 8
  %3 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
  store i32 3, i32* %3, align 8
  %4 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 2
  store i8* %1, i8** %4, align 8
  br label %exit

nan.exit:                                         ; preds = %entry
  %5 = fcmp ueq float %float, 0x7FF0000000000000
  br i1 %5, label %pos_inf.then, label %pos_inf.exit

pos_inf.then:                                     ; preds = %nan.exit
  %6 = getelementptr inbounds [3 x i8], [3 x i8]* @.strPosInf, i32 0, i32 0
  %7 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
  store i32 3, i32* %7, align 8
  %8 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
  store i32 3, i32* %8, align 8
  %9 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 2
  store i8* %6, i8** %9, align 8
  br label %exit

pos_inf.exit:                                     ; preds = %nan.exit
  %10 = fcmp ueq float %float, 0xFFF0000000000000
  br i1 %10, label %neg_inf.then, label %neg_inf.exit

neg_inf.then:                                     ; preds = %pos_inf.exit
  %11 = getelementptr inbounds [4 x i8], [4 x i8]* @.strNegInf, i32 0, i32 0
  %12 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
  store i32 4, i32* %12, align 8
  %13 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
  store i32 4, i32* %13, align 8
  %14 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 2
  store i8* %11, i8** %14, align 8
  br label %exit

neg_inf.exit:                                     ; preds = %pos_inf.exit
  %15 = fcmp ueq float %float, 0.000000e+00
  br i1 %15, label %zero.then, label %zero.exit

zero.then:                                        ; preds = %neg_inf.exit
  %16 = bitcast float %float to i32
  %17 = lshr i32 %16, 31
  %18 = icmp eq i32 %17, 0
  br i1 %18, label %pos_zero.then, label %neg_zero.then

pos_zero.then:                                    ; preds = %zero.then
  %19 = getelementptr inbounds [3 x i8], [3 x i8]* @.strPosZero, i32 0, i32 0
  %20 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
  store i32 3, i32* %20, align 8
  %21 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
  store i32 3, i32* %21, align 8
  %22 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 2
  store i8* %19, i8** %22, align 8
  br label %exit

neg_zero.then:                                    ; preds = %zero.then
  %23 = getelementptr inbounds [4 x i8], [4 x i8]* @.strNegZero, i32 0, i32 0
  %24 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
  store i32 4, i32* %24, align 8
  %25 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
  store i32 4, i32* %25, align 8
  %26 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 2
  store i8* %23, i8** %26, align 8
  br label %exit

zero.exit:                                        ; preds = %neg_inf.exit
  %bits = alloca i32, align 4
  %sign = alloca i1, align 1
  %exp = alloca i32, align 4
  %man = alloca i32, align 4
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
  %m2 = alloca i32, align 4
  %e2 = alloca i32, align 4
  %33 = icmp eq i32 %31, 0
  br i1 %33, label %exp_zero.then, label %exp_zero.else

exp_zero.then:                                    ; preds = %zero.exit
  %34 = load i32, i32* %man, align 4
  store i32 -149, i32* %e2, align 4
  store i32 %34, i32* %m2, align 4
  br label %exp_zero.exit

exp_zero.else:                                    ; preds = %zero.exit
  %35 = load i32, i32* %exp, align 4
  %36 = add i32 %35, -150
  store i32 %36, i32* %e2, align 4
  %37 = load i32, i32* %man, align 4
  %38 = or i32 %37, 8388608
  store i32 %38, i32* %m2, align 4
  br label %exp_zero.exit

exp_zero.exit:                                    ; preds = %exp_zero.else, %exp_zero.then
  %mv = alloca i32, align 4
  %mp = alloca i32, align 4
  %mm = alloca i32, align 4
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
  %dp = alloca i32, align 4
  %dv = alloca i32, align 4
  %dm = alloca i32, align 4
  %e10 = alloca i32, align 4
  %dp_itz = alloca i1, align 1
  %dv_itz = alloca i1, align 1
  %dm_itz = alloca i1, align 1
  %lastRem = alloca i32, align 4
  store i32 0, i32* %lastRem, align 4
  %50 = icmp sge i32 %49, 0
  br i1 %50, label %if.then, label %if.else

if.then:                                          ; preds = %exp_zero.exit
  %q.large = alloca i32, align 4
  %k.large = alloca i32, align 4
  %i.large = alloca i32, align 4
  %51 = load i32, i32* %e2, align 4
  %52 = sitofp i32 %51 to float
  %53 = fmul float %52, 0x3E9A209700000000
  %54 = fptosi float %53 to i32
  store i32 %54, i32* %q.large, align 4
  %55 = call i32 @pow5bits(i32 %54)
  %56 = add i32 58, %55
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

if.then2:                                         ; preds = %if.then
  %71 = load i32, i32* %q.large, align 4
  %72 = sub i32 %71, 1
  %73 = call i32 @pow5bits(i32 %72)
  %74 = add i32 %73, 58
  %75 = load i32, i32* %mv, align 4
  %76 = load i32, i32* %e2, align 4
  %77 = sub i32 %72, %76
  %78 = add i32 %77, %74
  %79 = call i32 @mulPow5InvDivPow2(i32 %75, i32 %72, i32 %78)
  %80 = srem i32 %79, 10
  store i32 %80, i32* %lastRem, align 4
  br label %if.exit2

if.exit2:                                         ; preds = %if.then2, %if.then
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

if.else:                                          ; preds = %exp_zero.exit
  %q.small = alloca i32, align 4
  %i.small = alloca i32, align 4
  %k.small = alloca i32, align 4
  %j = alloca i32, align 4
  %88 = load i32, i32* %e2, align 4
  %89 = sitofp i32 %88 to float
  %90 = fmul float %89, 0xBF32EFB300000000
  %91 = fptosi float %90 to i32
  store i32 %91, i32* %q.small, align 4
  %92 = sub i32 0, %88
  %93 = sub i32 %92, %91
  store i32 %93, i32* %i.small, align 4
  %94 = call i32 @pow5bits(i32 %93)
  %95 = sub i32 %94, 61
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

if.then3:                                         ; preds = %if.else
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

if.exit3:                                         ; preds = %if.then3, %if.else
  %118 = load i32, i32* %q.small, align 4
  %119 = load i32, i32* %e2, align 4
  %120 = add i32 %118, %119
  store i32 %120, i32* %e10, align 4
  %121 = icmp sge i32 %118, 1
  store i1 %121, i1* %dp_itz, align 4
  %122 = icmp slt i32 %118, 23
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

if.exit:                                          ; preds = %if.exit3, %if.exit2
  %dp_len = alloca i32, align 4
  %expon = alloca i32, align 4
  %sciNot = alloca i1, align 1
  %removed = alloca i32, align 4
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
  %143 = icmp ne i1 %142, false
  store i1 %143, i1* %sciNot, align 1
  store i32 0, i32* %removed, align 4
  %144 = load i1, i1* %dp_itz, align 1
  %a = call %type.string @".conv:bool_string"(i1 %143)
  call void @.println(%type.string %a)
  br i1 %144, label %if.then4, label %while.cond

if.then4:                                         ; preds = %if.exit
  %145 = load i32, i32* %dp, align 4
  %146 = sub i32 %145, 1
  store i32 %146, i32* %dp, align 4
  br label %while.cond

while.cond:                                       ; preds = %if.exit4, %while.body, %if.then4, %if.exit
  %147 = load i32, i32* %dp, align 4
  %148 = sdiv i32 %147, 10
  %149 = load i32, i32* %dm, align 4
  %150 = sdiv i32 %149, 10
  %151 = icmp sgt i32 %148, %150
  br i1 %151, label %while.body, label %exit

while.body:                                       ; preds = %while.cond
  %152 = load i32, i32* %dp, align 4
  %153 = icmp slt i32 %152, 100
  %154 = load i1, i1* %sciNot, align 1
  %155 = and i1 %153, %154
  br i1 %155, label %while.cond, label %if.exit4

if.exit4:                                         ; preds = %while.body
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

exit:                                             ; preds = %while.cond, %neg_zero.then, %pos_zero.then, %neg_inf.then, %pos_inf.then, %nan.then
  %final = load %type.string, %type.string* %.ret, align 8
  ret %type.string %final
}

define private i32 @pow5bits(i32 %e) {
entry:
  %.ret = alloca i32, align 4
  %0 = icmp eq i32 %e, 0
  br i1 %0, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  store i32 1, i32* %.ret, align 4
  br label %exit

if.else:                                          ; preds = %entry
  %1 = mul i32 %e, 23219280
  %2 = add i32 %1, 9999999
  %3 = sdiv i32 %2, 10000000
  store i32 %3, i32* %.ret, align 4
  br label %exit

exit:                                             ; preds = %if.else, %if.then
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

define private i1 @multipleOfPow5(i32 %val, i32 %comp) {
entry:
  %0 = call i32 @pow5Factor(i32 %val)
  %1 = icmp sge i32 %0, %comp
  ret i1 %1
}

define private i32 @mulPow5DivPow2(i32 %m, i32 %i, i32 %j) {
entry:
  %0 = getelementptr inbounds [47 x i64], [47 x i64]* @float_pow5_split, i32 0, i32 %i
  %1 = load i64, i64* %0, align 8
  %2 = call i32 @mulShift(i32 %m, i64 %1, i32 %j)
  ret i32 %2
}

define private i32 @decimalLength(i32 %val) {
entry:
  %length = alloca i32, align 4
  store i32 10, i32* %length, align 4
  %factor = alloca i32, align 4
  store i32 1000000000, i32* %factor, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %length, align 4
  %1 = icmp sgt i32 %0, 0
  br i1 %1, label %for.body, label %exit

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %factor, align 4
  %3 = icmp sge i32 %val, %2
  br i1 %3, label %for.inc, label %if.exit

if.exit:                                          ; preds = %for.body
  %4 = load i32, i32* %factor, align 4
  %5 = sdiv i32 %4, 10
  store i32 %5, i32* %factor, align 4
  br label %for.inc

for.inc:                                          ; preds = %if.exit, %for.body
  %6 = load i32, i32* %length, align 4
  %7 = sub i32 %6, 1
  store i32 %7, i32* %length, align 4
  br label %for.cond

exit:                                             ; preds = %for.cond
  %8 = load i32, i32* %length, align 4
  ret i32 %8
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

define private i32 @pow5Factor(i32 %val) {
entry:
  %val.addr = alloca i32, align 4
  store i32 %val, i32* %val.addr, align 4
  %i = alloca i32, align 4
  store i32 0, i32* %i, align 4
  br label %while.cond

while.cond:                                       ; preds = %if.exit, %entry
  %0 = load i32, i32* %val.addr, align 4
  %1 = icmp sgt i32 %0, 0
  br i1 %1, label %while.body, label %exit

while.body:                                       ; preds = %while.cond
  %2 = load i32, i32* %val.addr, align 4
  %3 = srem i32 %2, 5
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %exit, label %if.exit

if.exit:                                          ; preds = %while.body
  %5 = load i32, i32* %val.addr, align 4
  %6 = sdiv i32 %5, 5
  store i32 %6, i32* %val.addr, align 4
  %7 = load i32, i32* %i, align 4
  %8 = add i32 %7, 1
  store i32 %8, i32* %i, align 4
  br label %while.cond

exit:                                             ; preds = %while.body, %while.cond
  %9 = load i32, i32* %i, align 4
  ret i32 %9
}

define %ref.int* @"newref:int"(i32 %value) {
entry:
  %value.addr = alloca i32, align 4
  %ref = alloca %ref.int*, align 8
  store i32 %value, i32* %value.addr, align 4
  %call = call i8* @malloc(i32 16)
  %0 = bitcast i8* %call to %ref.int*
  store %ref.int* %0, %ref.int** %ref, align 8
  %call1 = call i8* @malloc(i32 4)
  %1 = bitcast i8* %call1 to i32*
  %2 = load %ref.int*, %ref.int** %ref, align 8
  %value2 = getelementptr inbounds %ref.int, %ref.int* %2, i32 0, i32 0
  store i32* %1, i32** %value2, align 8
  %3 = load i32, i32* %value.addr, align 4
  %4 = load %ref.int*, %ref.int** %ref, align 8
  %value3 = getelementptr inbounds %ref.int, %ref.int* %4, i32 0, i32 0
  %5 = load i32*, i32** %value3, align 8
  store i32 %3, i32* %5, align 4
  %6 = load %ref.int*, %ref.int** %ref, align 8
  %count = getelementptr inbounds %ref.int, %ref.int* %6, i32 0, i32 1
  store i32 0, i32* %count, align 8
  %7 = load %ref.int*, %ref.int** %ref, align 8
  ret %ref.int* %7
}

define void @"ref:int"(%ref.int* %ref) {
entry:
  %0 = getelementptr inbounds %ref.int, %ref.int* %ref, i32 0, i32 1
  %1 = load i32, i32* %0, align 8
  %2 = add i32 %1, 1
  call void @countMsg(i32 %2)
  store i32 %2, i32* %0, align 8
  ret void
}

define void @"deref:int"(%ref.int* %ref) {
entry:
  %0 = getelementptr inbounds %ref.int, %ref.int* %ref, i32 0, i32 1
  %1 = load i32, i32* %0, align 8
  %2 = add i32 %1, -1
  call void @countMsg(i32 %2)
  store i32 %2, i32* %0, align 8
  %3 = icmp eq i32 %2, 0
  br i1 %3, label %if.then, label %exit

if.then:                                          ; preds = %entry
  %4 = getelementptr inbounds %ref.int, %ref.int* %ref, i32 0, i32 0
  %5 = load i32*, i32** %4, align 8
  %6 = bitcast i32* %5 to i8*
  call void @free(i8* %6)
  %7 = bitcast %ref.int* %ref to i8*
  call void @free(i8* %7)
  call void @freeMsg()
  br label %exit

exit:                                             ; preds = %if.then, %entry
  ret void
}

define void @.refMsg(i32 %0, i32 %1) {
entry:
  %2 = call %type.string @".conv:int_string"(i32 %0)
  %3 = getelementptr inbounds [9 x i8], [9 x i8]* @.str0, i32 0, i32 0
  %4 = alloca %type.string, align 8
  %5 = getelementptr inbounds %type.string, %type.string* %4, i32 0, i32 0
  store i32 9, i32* %5, align 8
  %6 = getelementptr inbounds %type.string, %type.string* %4, i32 0, i32 1
  store i32 9, i32* %6, align 8
  %7 = getelementptr inbounds %type.string, %type.string* %4, i32 0, i32 2
  store i8* %3, i8** %7, align 8
  %8 = load %type.string, %type.string* %4, align 8
  %9 = call %type.string @".add:string_string"(%type.string %2, %type.string %8)
  %10 = call %type.string @".conv:int_string"(i32 %1)
  %11 = call %type.string @".add:string_string"(%type.string %9, %type.string %10)
  %12 = getelementptr inbounds [11 x i8], [11 x i8]* @.str1, i32 0, i32 0
  %13 = alloca %type.string, align 8
  %14 = getelementptr inbounds %type.string, %type.string* %13, i32 0, i32 0
  store i32 11, i32* %14, align 8
  %15 = getelementptr inbounds %type.string, %type.string* %13, i32 0, i32 1
  store i32 11, i32* %15, align 8
  %16 = getelementptr inbounds %type.string, %type.string* %13, i32 0, i32 2
  store i8* %12, i8** %16, align 8
  %17 = load %type.string, %type.string* %13, align 8
  %18 = call %type.string @".add:string_string"(%type.string %11, %type.string %17)
  call void @.println(%type.string %18)
  br label %exit

exit:                                             ; preds = %entry
  ret void
}

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

if.then:                                          ; preds = %entry
  %4 = getelementptr inbounds %ref.string, %ref.string* %ref, i32 0, i32 0
  %5 = load %type.string*, %type.string** %4, align 8
  %6 = bitcast %type.string* %5 to i8*
  call void @free(i8* %6)
  br label %exit

exit:                                             ; preds = %if.then, %entry
  ret void
}

define void @main() {
entry:
  %0 = call %type.string @".conv:float_string"(float 0xC1E2B23220000000)
  %x = alloca %type.string, align 8
  store %type.string %0, %type.string* %x, align 8
  br label %exit

exit:                                             ; preds = %entry
  ret void
}

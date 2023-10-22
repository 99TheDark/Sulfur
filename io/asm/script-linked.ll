; ModuleID = 'script-linked.bc'
source_filename = "llvm-link"

%type.string = type { i32, i32, i8* }
%ref.float = type { float*, i32 }
%ref.int = type { i32*, i32 }
%ref.string = type { %type.string*, i32 }

@.strTrue = private unnamed_addr constant [4 x i8] c"true", align 1
@.strFalse = private unnamed_addr constant [5 x i8] c"false", align 1
@float_pow5_inv_split = private constant [31 x i64] [i64 576460752303423489, i64 461168601842738791, i64 368934881474191033, i64 295147905179352826, i64 472236648286964522, i64 377789318629571618, i64 302231454903657294, i64 483570327845851670, i64 386856262276681336, i64 309485009821345069, i64 495176015714152110, i64 396140812571321688, i64 316912650057057351, i64 507060240091291761, i64 405648192073033409, i64 324518553658426727, i64 519229685853482763, i64 415383748682786211, i64 332306998946228969, i64 531691198313966350, i64 425352958651173080, i64 340282366920938464, i64 544451787073501542, i64 435561429658801234, i64 348449143727040987, i64 557518629963265579, i64 446014903970612463, i64 356811923176489971, i64 570899077082383953, i64 456719261665907162, i64 365375409332725730], align 4
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
  %even = alloca i1, align 1
  %mv = alloca i32, align 4
  %mp = alloca i32, align 4
  %mm = alloca i32, align 4
  %39 = load i32, i32* %m2, align 4
  %40 = and i32 %39, 1
  %41 = icmp eq i32 %40, 0
  store i1 %41, i1* %even, align 1
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
  %dp = alloca i32, align 4
  %dv = alloca i32, align 4
  %dm = alloca i32, align 4
  %e10 = alloca i32, align 4
  %dp_itz = alloca i1, align 1
  %dv_itz = alloca i1, align 1
  %dm_itz = alloca i1, align 1
  %lastRem = alloca i32, align 4
  store i32 0, i32* %lastRem, align 4
  %52 = icmp sge i32 %51, 0
  br i1 %52, label %if.then, label %if.else

if.then:                                          ; preds = %exp_zero.exit
  %q.large = alloca i32, align 4
  %k.large = alloca i32, align 4
  %i.large = alloca i32, align 4
  %53 = load i32, i32* %e2, align 4
  %54 = sitofp i32 %53 to float
  %55 = fmul float %54, 0x3E9A209700000000
  %56 = fptosi float %55 to i32
  store i32 %56, i32* %q.large, align 4
  %57 = call i32 @pow5bits(i32 %56)
  %58 = add i32 58, %57
  store i32 %58, i32* %k.large, align 4
  %59 = add i32 %56, %58
  %60 = sub i32 %59, %53
  store i32 %60, i32* %i.large, align 4
  %61 = load i32, i32* %mv, align 4
  %62 = call i32 @mulPow5InvDivPow2(i32 %61, i32 %56, i32 %60)
  store i32 %62, i32* %dv, align 4
  %63 = load i32, i32* %mp, align 4
  %64 = call i32 @mulPow5InvDivPow2(i32 %63, i32 %56, i32 %60)
  store i32 %64, i32* %dp, align 4
  %65 = load i32, i32* %mm, align 4
  %66 = call i32 @mulPow5InvDivPow2(i32 %65, i32 %56, i32 %60)
  store i32 %66, i32* %dm, align 4
  %67 = icmp ne i32 %56, 0
  %68 = sub i32 %64, 1
  %69 = sdiv i32 %68, 10
  %70 = sdiv i32 %66, 10
  %71 = icmp sle i32 %69, %70
  %72 = and i1 %67, %71
  br i1 %72, label %if.then2, label %if.exit2

if.then2:                                         ; preds = %if.then
  %73 = load i32, i32* %q.large, align 4
  %74 = sub i32 %73, 1
  %75 = call i32 @pow5bits(i32 %74)
  %76 = add i32 %75, 58
  %77 = load i32, i32* %mv, align 4
  %78 = load i32, i32* %e2, align 4
  %79 = sub i32 %74, %78
  %80 = add i32 %79, %76
  %81 = call i32 @mulPow5InvDivPow2(i32 %77, i32 %74, i32 %80)
  %82 = srem i32 %81, 10
  store i32 %82, i32* %lastRem, align 4
  br label %if.exit2

if.exit2:                                         ; preds = %if.then2, %if.then
  %83 = load i32, i32* %q.large, align 4
  store i32 %83, i32* %e10, align 4
  %84 = load i32, i32* %mv, align 4
  %85 = call i1 @multipleOfPow5(i32 %84, i32 %83)
  store i1 %85, i1* %dv_itz, align 1
  %86 = load i32, i32* %mp, align 4
  %87 = call i1 @multipleOfPow5(i32 %86, i32 %83)
  store i1 %87, i1* %dp_itz, align 1
  %88 = load i32, i32* %mm, align 4
  %89 = call i1 @multipleOfPow5(i32 %88, i32 %83)
  store i1 %89, i1* %dm_itz, align 1
  br label %if.exit

if.else:                                          ; preds = %exp_zero.exit
  %q.small = alloca i32, align 4
  %i.small = alloca i32, align 4
  %k.small = alloca i32, align 4
  %j = alloca i32, align 4
  %90 = load i32, i32* %e2, align 4
  %91 = sitofp i32 %90 to float
  %92 = fmul float %91, 0xBF32EFB300000000
  %93 = fptosi float %92 to i32
  store i32 %93, i32* %q.small, align 4
  %94 = sub i32 0, %90
  %95 = sub i32 %94, %93
  store i32 %95, i32* %i.small, align 4
  %96 = call i32 @pow5bits(i32 %95)
  %97 = sub i32 %96, 61
  store i32 %97, i32* %k.small, align 4
  %98 = sub i32 %93, %97
  store i32 %98, i32* %j, align 4
  %99 = load i32, i32* %mv, align 4
  %100 = call i32 @mulPow5InvDivPow2(i32 %99, i32 %95, i32 %98)
  store i32 %100, i32* %dv, align 4
  %101 = load i32, i32* %mp, align 4
  %102 = call i32 @mulPow5InvDivPow2(i32 %101, i32 %95, i32 %98)
  store i32 %102, i32* %dp, align 4
  %103 = load i32, i32* %mm, align 4
  %104 = call i32 @mulPow5InvDivPow2(i32 %103, i32 %95, i32 %98)
  store i32 %104, i32* %dm, align 4
  %105 = icmp ne i32 %93, 0
  %106 = sub i32 %102, 1
  %107 = sdiv i32 %106, 10
  %108 = sdiv i32 %104, 10
  %109 = icmp sle i32 %107, %108
  %110 = and i1 %105, %109
  br i1 %110, label %if.then3, label %if.exit3

if.then3:                                         ; preds = %if.else
  %111 = load i32, i32* %i.small, align 4
  %112 = add i32 %111, 1
  %113 = call i32 @pow5bits(i32 %112)
  %114 = load i32, i32* %q.small, align 4
  %115 = sub i32 %114, %113
  %116 = add i32 %115, 60
  store i32 %116, i32* %j, align 4
  %117 = load i32, i32* %mv, align 4
  br label %if.exit3

if.exit3:                                         ; preds = %if.then3, %if.else
  br label %if.exit

if.exit:                                          ; preds = %if.exit3, %if.exit2
  br label %exit

exit:                                             ; preds = %if.exit, %neg_zero.then, %pos_zero.then, %neg_inf.then, %pos_inf.then, %nan.then
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

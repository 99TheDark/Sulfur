; ModuleID = 'script-optimized.bc'
source_filename = "llvm-link"

%type.string = type { i32, i32, i8* }
%ref.int = type { i32*, i32 }
%ref.string = type { %type.string*, i32 }

@.strTrue = private unnamed_addr constant [4 x i8] c"true", align 1
@.strFalse = private unnamed_addr constant [5 x i8] c"false", align 1
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

define %ref.int* @"ref:int"(i32 %value) {
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

declare i8* @malloc(i32)

define void @"deref:int"(%ref.int* %ref) {
entry:
  %0 = getelementptr inbounds %ref.int, %ref.int* %ref, i32 0, i32 1
  %1 = load i32, i32* %0, align 8
  %2 = add i32 %1, -1
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
  br label %exit

exit:                                             ; preds = %if.then, %entry
  ret void
}

declare void @free(i8*)

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
  %x = call %ref.int* @"ref:int"(i32 100)
  %0 = getelementptr inbounds %ref.int, %ref.int* %x, i32 0, i32 0
  %1 = load i32*, i32** %0, align 8
  %2 = load i32, i32* %1, align 4
  call void @mod.byValue(i32 %2)
  call void @mod.byRef(%ref.int* %x)
  %3 = getelementptr inbounds %ref.int, %ref.int* %x, i32 0, i32 0
  %4 = load i32*, i32** %3, align 8
  %5 = load i32, i32* %4, align 4
  %6 = call %type.string @".conv:int_string"(i32 %5)
  call void @.println(%type.string %6)
  br label %exit

exit:                                             ; preds = %entry
  ret void
}

define private void @mod.byValue(i32 %0) {
entry:
  %1 = call %type.string @".conv:int_string"(i32 %0)
  call void @.println(%type.string %1)
  br label %exit

exit:                                             ; preds = %entry
  ret void
}

define private void @mod.byRef(%ref.int* %0) {
entry:
  %1 = getelementptr inbounds %ref.int, %ref.int* %0, i32 0, i32 0
  %2 = load i32*, i32** %1, align 8
  %3 = load i32, i32* %2, align 4
  %4 = mul i32 %3, 2
  %5 = getelementptr inbounds %ref.int, %ref.int* %0, i32 0, i32 0
  %6 = load i32*, i32** %5, align 8
  store i32 %4, i32* %6, align 8
  br label %exit

exit:                                             ; preds = %entry
  ret void
}

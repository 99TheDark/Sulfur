source_filename = "lib/builtin/conversion/int_string.ll"

%type.string = type { i32, i32* }

declare i8* @malloc(i32)
declare void @free(i8*)

@.strZero = private unnamed_addr constant [1 x i32] [i32 48], align 4

define %type.string @".conv:int_string"(i32 %int) {
entry:
    %.ret = alloca %type.string
    %int.addr = alloca i32
    store i32 %int, i32* %int.addr, align 4
    %i = alloca i32
    %sign = alloca i32
    %buf = alloca i32*
    %size = alloca i32
    %0 = icmp eq i32 %int, 0
    br i1 %0, label %if.then1, label %if.end1

if.then1:
    %1 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
    store i32 1, i32* %1, align 8
    %2 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
    %3 = getelementptr inbounds [1 x i32], [1 x i32]* @.strZero, i32 0, i32 0
    store i32* %3, i32** %2, align 8
    br label %exit

if.end1:
    %4 = call i8* @malloc(i32 40) ; 10 * sizeof(4)
    %5 = bitcast i8* %4 to i32*
    store i32* %5, i32** %buf, align 8
    store i32 9, i32* %i, align 4    store i32 0, i32* %sign, align 4
    %6 = icmp slt i32 %int, 0
    br i1 %6, label %if.then2, label %while.cond

if.then2:
    %7 = sub i32 0, %int
    store i32 %7, i32* %int.addr, align 4
    store i32 1, i32* %sign, align 4
    br label %while.cond

while.cond:
    %8 = load i32, i32* %int.addr, align 4
    %9 = icmp sgt i32 %8, 0
    br i1 %9, label %while.body, label %while.end

while.body:
    %10 = load i32, i32* %int.addr, align 4
    %11 = srem i32 %10, 10
    %12 = add i32 %11, 48
    %13 = load i32*, i32** %buf, align 8
    %14 = load i32, i32* %i, align 4
    %15 = getelementptr inbounds i32, i32* %13, i32 %14
    store i32 %12, i32* %15, align 4
    %16 = sdiv i32 %10, 10
    store i32 %16, i32* %int.addr, align 4
    %17 = add i32 %14, -1
    store i32 %17, i32* %i, align 4
    br label %while.cond

while.end:
    %18 = load i32, i32* %i, align 4
    %19 = sub i32 9, %18
    %20 = load i32, i32* %sign, align 4
    %21 = add i32 %19, %20
    store i32 %21, i32* %size, align 4
    %22 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
    store i32 %21, i32* %22, align 8
    %23 = mul i32 %21, 4
    %24 = call i8* @malloc(i32 %23)
    %25 = bitcast i8* %24 to i32*
    %26 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
    store i32* %25, i32** %26, align 8
    %27 = icmp ne i32 %20, 0
    br i1 %27, label %if.then3, label %if.else3

if.then3:
    %28 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
    %29 = load i32*, i32** %28, align 8
    %30 = getelementptr inbounds i32, i32* %29, i32 0
    store i32 45, i32* %30, align 4
    br label %if.end3

if.else3:
    %31 = load i32, i32* %i, align 4
    %32 = add i32 %31, 1
    store i32 %32, i32* %i, align 4
    br label %if.end3

if.end3:
    %33 = load i32, i32* %sign, align 4
    %j = alloca i32
    store i32 %33, i32* %j, align 4
    br label %for.cond

for.cond:
    %34 = load i32, i32* %j, align 4
    %35 = load i32, i32* %size, align 4
    %36 = icmp slt i32 %34, %35
    br i1 %36, label %for.body, label %for.end

for.body:
    %37 = load i32*, i32** %buf, align 8
    %38 = load i32, i32* %i, align 4
    %39 = load i32, i32* %j, align 4
    %40 = add i32 %38, %39
    %41 = getelementptr inbounds i32, i32* %37, i32 %40
    %42 = load i32, i32* %41, align 4
    %43 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
    %44 = load i32*, i32** %43, align 8
    %45 = getelementptr inbounds i32, i32* %44, i32 %39
    store i32 %42, i32* %45, align 4
    br label %for.inc

for.inc:
    %46 = load i32, i32* %j, align 4
    %47 = add i32 %46, 1
    store i32 %47, i32* %j, align 4
    br label %for.cond

for.end:
    %48 = load i32*, i32** %buf, align 8
    %49 = bitcast i32* %48 to i8*
    call void @free(i8* %49)
    br label %exit

exit:
    %50 = load %type.string, %type.string* %.ret, align 8
    ret %type.string %50
}
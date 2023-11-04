source_filename = "lib/builtin/conversion/uint_string.ll"

%type.string = type { i32, i32* }

declare i8* @malloc(i32)
declare void @free(i8*)

@.strZero = private unnamed_addr constant [1 x i32] [i32 48], align 4

define fastcc %type.string @".conv:uint_string"(i32 %uint) {
entry:
    %.ret = alloca %type.string, align 8
    %uint.ptr = alloca i32, align 4
    store i32 %uint, i32* %uint.ptr, align 4
    %buf = alloca i32*, align 4
    %i = alloca i32, align 4
    %size = alloca i32, align 4
    %j = alloca i32, align 4
    %0 = icmp eq i32 %uint, 0
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
    store i32 9, i32* %i, align 4 
    br label %while.cond

while.cond:
    %6 = load i32, i32* %uint.ptr, align 4
    %7 = icmp ugt i32 %6, 0
    br i1 %7, label %while.body, label %while.end

while.body:
    %8 = load i32, i32* %uint.ptr, align 4
    %9 = urem i32 %8, 10
    %10 = add i32 %9, 48
    %11 = load i32*, i32** %buf, align 8
    %12 = load i32, i32* %i, align 4
    %13 = getelementptr inbounds i32, i32* %11, i32 %12
    store i32 %10, i32* %13, align 4
    %14 = udiv i32 %8, 10
    store i32 %14, i32* %uint.ptr, align 4
    %15 = add i32 %12, -1
    store i32 %15, i32* %i, align 4
    br label %while.cond

while.end:
    %16 = load i32, i32* %i, align 4
    %17 = sub i32 9, %16
    store i32 %17, i32* %size, align 4
    %18 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
    store i32 %17, i32* %18, align 8
    %19 = mul i32 %17, 4
    %20 = call i8* @malloc(i32 %19)
    %21 = bitcast i8* %20 to i32*
    %22 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
    store i32* %21, i32** %22, align 4
    %23 = add i32 %16, 1
    store i32 %23, i32* %i, align 4
    store i32 0, i32* %j, align 4
    br label %for.cond

for.cond:
    %24 = load i32, i32* %j, align 4
    %25 = load i32, i32* %size, align 4
    %26 = icmp slt i32 %24, %25
    br i1 %26, label %for.body, label %exit

for.body:
    %27 = load i32, i32* %i, align 4
    %28 = load i32, i32* %j, align 4
    %29 = add i32 %27, %28
    %30 = load i32*, i32** %buf, align 8
    %31 = getelementptr inbounds i32, i32* %30, i32 %29
    %32 = load i32, i32* %31, align 4
    %33 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
    %34 = load i32*, i32** %33, align 8
    %35 = getelementptr inbounds i32, i32* %34, i32 %28
    store i32 %32, i32* %35, align 4
    br label %for.inc

for.inc:
    %36 = load i32, i32* %j, align 4
    %37 = add i32 %36, 1
    store i32 %37, i32* %j, align 4
    br label %for.cond

exit:
    %38 = load i32*, i32** %buf, align 8
    %39 = bitcast i32* %38 to i8*
    call void @free(i8* %39)
    %40 = load %type.string, %type.string* %.ret
    ret %type.string %40
}
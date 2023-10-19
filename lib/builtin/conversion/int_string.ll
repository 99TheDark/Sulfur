source_filename = "lib/builtin/conversion/int_string"

%type.string = type { i32, i32, i8* }

declare i8* @malloc(i32)
declare void @free(i8*)

@.strZero = private unnamed_addr constant [1 x i8] c"0", align 1

define %type.string @".conv:int_string"(i32 %int) {
entry:
    %.ret = alloca %type.string, align 8
    %0 = icmp eq i32 %int, 0
    br i1 %0, label %if.then, label %if.end

if.then:
    %1 = getelementptr inbounds [1 x i8], [1 x i8]* @.strZero, i32 0, i32 0
	%2 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
	store i32 1, i32* %2, align 8
	%3 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
	store i32 1, i32* %3, align 8
	%4 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 2
	store i8* %1, i8** %4, align 8
    br label %exit

if.end:
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

if.then1:
    %8 = sub i32 0, %5
    store i32 %8, i32* %int.addr, align 4
    store i32 1, i32* %sign, align 4
    br label %if.end1

if.end1:
    br label %while.cond

while.cond:
    %9 = load i32, i32* %int.addr, align 4
    %10 = icmp sgt i32 %9, 0
    br i1 %10, label %while.body, label %while.end

while.body:
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

while.end:
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

if.then2:
    %25 = load i8*, i8** %.ret.addr, align 8
    %26 = getelementptr inbounds i8, i8* %25, i32 0
    store i8 45, i8* %26, align 1
    br label %if.end2

if.else2:
    %27 = add i32 %18, 1
    store i32 %27, i32* %i, align 4
    br label %if.end2

if.end2:
    %j = alloca i32, align 4
    store i32 %20, i32* %j, align 4
    %28 = load i32, i32* %i, align 4
    br label %for.cond

for.cond:
    %29 = load i32, i32* %j, align 4
    %30 = icmp slt i32 %29, %22
    br i1 %30, label %for.body, label %for.end

for.body:
    %31 = add i32 %28, %29
    %32 = getelementptr inbounds i8, i8* %6, i32 %31
    %33 = load i8, i8* %32, align 1
    %.ret.addr2 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 2
    %34 = load i8*, i8** %.ret.addr2, align 8
    %35 = getelementptr inbounds i8, i8* %34, i32 %29
    store i8 %33, i8* %35, align 1
    br label %for.inc

for.inc:
    %36 = add i32 %29, 1
    store i32 %36, i32* %j, align 4
    br label %for.cond

for.end:
    call void @free(i8* %6)
    br label %exit

exit:
    %37 = load %type.string, %type.string* %.ret
    ret %type.string %37
}
source_filename = "lib/builtin/int_string"

%type.string = type { i32, i32, i8* }

declare i8* @malloc(i32)
declare void @free(i8*)

define void @.conv.int_string(%type.string* %ret, i32 %num) {
entry:
    %num.adr = alloca i32, align 4
    store i32 %num, i32* %num.adr, align 4
    %buf = alloca i8*, align 8
    %buf.adr = call i8* @malloc(i32 10)
    store i8* %buf.adr, i8** %buf, align 8
    %i = alloca i32, align 4
    store i32 9, i32* %i, align 4
    %sign = alloca i32, align 4
    store i32 0, i32* %sign, align 4
    %0 = load i32, i32* %num.adr, align 4
    %1 = load i8*, i8** %buf, align 8
    %2 = icmp slt i32 %0, 0
    br i1 %2, label %if.then, label %if.end

if.then:
    %3 = sub i32 0, %0
    store i32 %3, i32* %num.adr, align 4
    store i32 1, i32* %sign, align 4
    br label %if.end

if.end:
    br label %while.cond

while.cond:
    %4 = load i32, i32* %num.adr, align 4
    %5 = icmp sgt i32 %4, 0
    br i1 %5, label %while.body, label %while.end

while.body:
    %6 = srem i32 %4, 10
    %7 = add i32 48, %6
    %8 = trunc i32 %7 to i8
    %9 = load i32, i32* %i, align 4
    %10 = getelementptr inbounds i8, i8* %1, i32 %9
    store i8 %8, i8* %10, align 1
    %11 = sdiv i32 %4, 10
    store i32 %11, i32* %num.adr, align 4
    %12 = add i32 %9, -1
    store i32 %12, i32* %i, align 4
    br label %while.cond

while.end:
    %size = alloca i32, align 4
    %13 = load i32, i32* %i, align 4
    %14 = sub i32 9, %13
    %15 = load i32, i32* %sign, align 4
    %16 = add i32 %14, %15
    store i32 %16, i32* %size, align 4
    %17 = load i32, i32* %size, align 4
    %ret.len = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 0
    store i32 %17, i32* %ret.len, align 8
    %ret.size = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 1
    store i32 %17, i32* %ret.size, align 8
    %ret.adr = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 2
    %18 = call i8* @malloc(i32 %17)
    store i8* %18, i8** %ret.adr, align 8
    %19 = icmp ne i32 %15, 0
    br i1 %19, label %if.then2, label %if.else2

if.then2:
    %20 = load i8*, i8** %ret.adr, align 8
    %21 = getelementptr inbounds i8, i8* %20, i32 0
    store i8 45, i8* %21, align 1
    br label %if.end2

if.else2:
    %22 = add i32 %13, 1
    store i32 %22, i32* %i, align 4
    br label %if.end2

if.end2:
    %j = alloca i32, align 4
    store i32 %15, i32* %j, align 4
    %23 = load i32, i32* %i, align 4
    br label %for.cond

for.cond:
    %24 = load i32, i32* %j, align 4
    %25 = icmp slt i32 %24, %17
    br i1 %25, label %for.body, label %for.end

for.body:
    %26 = add i32 %23, %24
    %27 = getelementptr inbounds i8, i8* %1, i32 %26
    %28 = load i8, i8* %27, align 1
    %ret.adr2 = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 2
    %29 = load i8*, i8** %ret.adr2, align 8
    %30 = getelementptr inbounds i8, i8* %29, i32 %24
    store i8 %28, i8* %30, align 1
    br label %for.inc

for.inc:
    %31 = add i32 %24, 1
    store i32 %31, i32* %j, align 4
    br label %for.cond

for.end:
    call void @free(i8* %1)
    ret void
}
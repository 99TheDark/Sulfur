source_filename = "lib/builtin/string_add"

%type.string = type { i32, i32, i8* }

declare i8* @malloc(i32)

define %type.string @".add:string_string"(%type.string %a, %type.string %b) {
entry:
    %.ret = alloca %type.string, align 8
    %ptr.a = alloca %type.string, align 8
    store %type.string %a, %type.string* %ptr.a, align 8
    %ptr.b = alloca %type.string, align 8
    store %type.string %b, %type.string* %ptr.b, align 8

    ; ret.len = a.len + b.len
    %0 = getelementptr inbounds %type.string, %type.string* %ptr.a, i32 0, i32 0
    %1 = load i32, i32* %0, align 4
    %2 = getelementptr inbounds %type.string, %type.string* %ptr.b, i32 0, i32 0
    %3 = load i32, i32* %2, align 4
    %4 = add i32 %1, %3
	%5 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 0
	store i32 %4, i32* %5, align 8

    ; ret.size = a.size + b.size
    %6 = getelementptr inbounds %type.string, %type.string* %ptr.a, i32 0, i32 1
    %7 = load i32, i32* %6, align 4
    %8 = getelementptr inbounds %type.string, %type.string* %ptr.b, i32 0, i32 1
    %9 = load i32, i32* %8, align 4
    %10 = add i32 %7, %9
	%11 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 1
	store i32 %10, i32* %11, align 8

    ; ret.adr = malloc(ret.size)
    %12 = call i8* @malloc(i32 %10)
    %13 = getelementptr inbounds %type.string, %type.string* %.ret, i32 0, i32 2
    store i8* %12, i8** %13, align 8

    ; int i = 0
    %i = alloca i32, align 4
    store i32 0, i32* %i, align 4

    ; int j = 0
    %j = alloca i32, align 4
    store i32 0, i32* %j, align 4

    %14 = getelementptr inbounds %type.string, %type.string* %ptr.a, i32 0, i32 2
    %15 = getelementptr inbounds %type.string, %type.string* %ptr.b, i32 0, i32 2

    ; while i < a.size {
    ;     ret.adr[i] = a.adr[i]
    ;     i++
    ; }
    br label %while1.cond

while1.cond: 
    ; i < a.size
    %16 = load i32, i32* %i, align 4
    %17 = icmp slt i32 %16, %7
    br i1 %17, label %while1.body, label %while1.end

while1.body: 
    ; ret.adr[i] = a.adr[i]
    %18 = load i32, i32* %i, align 4
    %19 = load i8*, i8** %13, align 8
    %20 = getelementptr inbounds i8, i8* %19, i32 %18
    %21 = load i8*, i8** %14, align 8
    %22 = getelementptr inbounds i8, i8* %21, i32 %18
    %23 = load i8, i8* %22, align 1
    store i8 %23, i8* %20, align 1

    ; i++
    %24 = load i32, i32* %i, align 4
    %25 = add i32 %24, 1
    store i32 %25, i32* %i, align 4
    br label %while1.cond

while1.end:
    ; while i < ret.size {
    ;     ret.adr[i] = b.adr[i]
    ;     i++
    ; }
    br label %while2.cond

while2.cond:
    ; i < ret.size
    %26 = load i32, i32* %i, align 4
    %27 = icmp slt i32 %26, %10
    br i1 %27, label %while2.body, label %while2.end

while2.body: 
    ; ret.adr[i] = b.adr[j]
    %28 = load i32, i32* %i, align 4
    %29 = load i32, i32* %j, align 4
    %30 = load i8*, i8** %13, align 8 
    %31 = getelementptr inbounds i8, i8* %30, i32 %28
    %32 = load i8*, i8** %15, align 8 
    %33 = getelementptr inbounds i8, i8* %32, i32 %29
    %34 = load i8, i8* %33, align 1
    store i8 %34, i8* %31, align 1

    ; i++
    %35 = load i32, i32* %i, align 4
    %36 = add i32 %35, 1
    store i32 %36, i32* %i, align 4

    ; j++
    %37 = load i32, i32* %j, align 4
    %38 = add i32 %37, 1
    store i32 %38, i32* %j, align 4
    br label %while2.cond

while2.end:
    %39 = load %type.string, %type.string* %.ret, align 8
    ret %type.string %39
}
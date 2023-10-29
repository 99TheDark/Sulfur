source_filename = "lib/builtin/operator/string_add.ll"

%type.utf8_string = type { i32, i32* }

declare i8* @malloc(i32)

define %type.utf8_string @".add:string_string"(%type.utf8_string %a, %type.utf8_string %b) {
entry:
    %.ret = alloca %type.utf8_string, align 8
    %ptr.a = alloca %type.utf8_string, align 8
    store %type.utf8_string %a, %type.utf8_string* %ptr.a, align 8
    %ptr.b = alloca %type.utf8_string, align 8
    store %type.utf8_string %b, %type.utf8_string* %ptr.b, align 8

    ; ret.len = a.len + b.len
    %0 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %ptr.a, i32 0, i32 0
    %1 = load i32, i32* %0, align 4
    %2 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %ptr.b, i32 0, i32 0
    %3 = load i32, i32* %2, align 4
    %4 = add i32 %1, %3
	%5 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %.ret, i32 0, i32 0
	store i32 %4, i32* %5, align 8

    ; ret.chars = malloc(ret.len * sizeof(int))
    %6 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %.ret, i32 0, i32 1
    %7 = mul i32 %4, 4
    %8 = call i8* @malloc(i32 %7)
    %9 = bitcast i8* %8 to i32*
    store i32* %9, i32** %6, align 4

    ; int i = 0
    %i = alloca i32
    store i32 0, i32* %i, align 4

    ; int j = 0
    %j = alloca i32
    store i32 0, i32* %j, align 4

    ; while i < a.len {
    ;     ret.chars[i] = a.chars[i]
    ;     i++
    ; }
    br label %while.cond1

while.cond1:
    %10 = load i32, i32* %i, align 4
    %11 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %ptr.a, i32 0, i32 0
    %12 = load i32, i32* %11, align 8
    %13 = icmp slt i32 %10, %12
    br i1 %13, label %while.body1, label %while.cond2

while.body1:
    %14 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %ptr.a, i32 0, i32 1
    %15 = load i32*, i32** %14, align 8
    %16 = load i32, i32* %i, align 4
    %17 = getelementptr inbounds i32, i32* %15, i32 %16
    %18 = load i32, i32* %17, align 4
    %19 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %.ret, i32 0, i32 1
    %20 = load i32*, i32** %19, align 8
    %21 = getelementptr inbounds i32, i32* %20, i32 %16
    store i32 %18, i32* %21, align 4
    %22 = add i32 %16, 1
    store i32 %22, i32* %i, align 4
    br label %while.cond1

while.cond2:
    %23 = load i32, i32* %i, align 4
    %24 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %.ret, i32 0, i32 0
    %25 = load i32, i32* %24, align 8
    %26 = icmp slt i32 %23, %25
    br i1 %26, label %while.body2, label %while.end2

while.body2:
    %27 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %ptr.b, i32 0, i32 1
    %28 = load i32*, i32** %27, align 8
    %29 = load i32, i32* %j, align 4
    %30 = getelementptr inbounds i32, i32* %28, i32 %29
    %31 = load i32, i32* %30, align 4
    %32 = getelementptr inbounds %type.utf8_string, %type.utf8_string* %.ret, i32 0, i32 1
    %33 = load i32*, i32** %32, align 8
    %34 = load i32, i32* %i, align 4
    %35 = getelementptr inbounds i32, i32* %33, i32 %34
    store i32 %31, i32* %35, align 4
    %36 = add i32 %34, 1
    store i32 %36, i32* %i, align 4
    %37 = add i32 %29, 1
    store i32 %37, i32* %j, align 4
    br label %while.cond2

while.end2:
    %final = load %type.utf8_string, %type.utf8_string* %.ret, align 8
    ret %type.utf8_string %final
}
source_filename = "lib/builtin/function/print_utf8"

declare void @putchar(i32)

%type.string = type { i32, i32* }

define private void @printChar(i32 %cp) {
entry:
    %cp.addr = alloca i32, align 4
    store i32 %cp, i32* %cp.addr, align 4
    %0 = load i32, i32* %cp.addr, align 4
    %cmp = icmp sle i32 %0, 127
    br i1 %cmp, label %if.then, label %if.else

if.then:
    %1 = load i32, i32* %cp.addr, align 4
    call void @putchar(i32 %1)
    br label %if.end35

if.else:
    %2 = load i32, i32* %cp.addr, align 4
    %cmp1 = icmp sle i32 %2, 2047
    br i1 %cmp1, label %if.then2, label %if.else6

if.then2:
    %3 = load i32, i32* %cp.addr, align 4
    %shr = ashr i32 %3, 6
    %or = or i32 192, %shr
    call void @putchar(i32 %or)
    %4 = load i32, i32* %cp.addr, align 4
    %and = and i32 %4, 63
    %or4 = or i32 128, %and
    call void @putchar(i32 %or4)
    br label %if.end34

if.else6:
    %5 = load i32, i32* %cp.addr, align 4
    %cmp7 = icmp sle i32 %5, 65535
    br i1 %cmp7, label %if.then8, label %if.else19

if.then8:
    %6 = load i32, i32* %cp.addr, align 4
    %shr9 = ashr i32 %6, 12
    %or10 = or i32 224, %shr9
    call void @putchar(i32 %or10)
    %7 = load i32, i32* %cp.addr, align 4
    %shr12 = ashr i32 %7, 6
    %and13 = and i32 %shr12, 63
    %or14 = or i32 128, %and13
    call void @putchar(i32 %or14)
    %8 = load i32, i32* %cp.addr, align 4
    %and16 = and i32 %8, 63
    %or17 = or i32 128, %and16
    call void @putchar(i32 %or17)
    br label %if.end

if.else19:
    %9 = load i32, i32* %cp.addr, align 4
    %shr20 = ashr i32 %9, 18
    %or21 = or i32 240, %shr20
    call void @putchar(i32 %or21)
    %10 = load i32, i32* %cp.addr, align 4
    %shr23 = ashr i32 %10, 12
    %and24 = and i32 %shr23, 63
    %or25 = or i32 128, %and24
    call void @putchar(i32 %or25)
    %11 = load i32, i32* %cp.addr, align 4
    %shr27 = ashr i32 %11, 6
    %and28 = and i32 %shr27, 63
    %or29 = or i32 128, %and28
    call void @putchar(i32 %or29)
    %12 = load i32, i32* %cp.addr, align 4
    %and31 = and i32 %12, 63
    %or32 = or i32 128, %and31
    call void @putchar(i32 %or32)
    br label %if.end

if.end:
    br label %if.end34

if.end34:
    br label %if.end35

if.end35:
    ret void
}

define void @.print_utf8(%type.string %str) {
entry:
    %ptr.str = alloca %type.string, align 8
	store %type.string %str, %type.string* %ptr.str, align 8
    %i = alloca i32
    store i32 0, i32* %i, align 4
    br label %for.cond

for.cond:
    %0 = load i32, i32* %i, align 4
    %1 = getelementptr inbounds %type.string, %type.string* %ptr.str, i32 0, i32 0
    %2 = load i32, i32* %1, align 4
    %3 = icmp slt i32 %0, %2
    br i1 %3, label %for.body, label %for.exit

for.body:
    %4 = getelementptr inbounds %type.string, %type.string* %ptr.str, i32 0, i32 1
    %5 = load i32*, i32** %4, align 4
    %6 = load i32, i32* %i, align 4
    %7 = getelementptr inbounds i32, i32* %5, i32 %6
    %8 = load i32, i32* %7, align 4
    call void @printChar(i32 %8)
    br label %for.inc

for.inc:
    %9 = load i32, i32* %i, align 4
    %10 = add i32 %9, 1
    store i32 %10, i32* %i, align 4
    br label %for.cond

for.exit:
    ret void
}

define void @.println_utf8(%type.string %str) {
entry:
    call void @.print_utf8(%type.string %str)
    call void @putchar(i32 10)
    ret void
}
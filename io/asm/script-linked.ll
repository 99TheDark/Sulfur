; ModuleID = 'script-linked.bc'
source_filename = "llvm-link"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [15 x i8] c"The number is: ", align 1

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

if.then:                                          ; preds = %entry
  %3 = sub i32 0, %0
  store i32 %3, i32* %num.adr, align 4
  store i32 1, i32* %sign, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  br label %while.cond

while.cond:                                       ; preds = %while.body, %if.end
  %4 = load i32, i32* %num.adr, align 4
  %5 = icmp sgt i32 %4, 0
  br i1 %5, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
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

while.end:                                        ; preds = %while.cond
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

if.then2:                                         ; preds = %while.end
  %20 = load i8*, i8** %ret.adr, align 8
  %21 = getelementptr inbounds i8, i8* %20, i32 0
  store i8 45, i8* %21, align 1
  br label %if.end2

if.else2:                                         ; preds = %while.end
  %22 = add i32 %13, 1
  store i32 %22, i32* %i, align 4
  br label %if.end2

if.end2:                                          ; preds = %if.else2, %if.then2
  %j = alloca i32, align 4
  store i32 %15, i32* %j, align 4
  %23 = load i32, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end2
  %24 = load i32, i32* %j, align 4
  %25 = icmp slt i32 %24, %17
  br i1 %25, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %26 = add i32 %23, %24
  %27 = getelementptr inbounds i8, i8* %1, i32 %26
  %28 = load i8, i8* %27, align 1
  %ret.adr2 = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 2
  %29 = load i8*, i8** %ret.adr2, align 8
  %30 = getelementptr inbounds i8, i8* %29, i32 %24
  store i8 %28, i8* %30, align 1
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %31 = add i32 %24, 1
  store i32 %31, i32* %j, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call void @free(i8* %1)
  ret void
}

declare i8* @malloc(i32)

declare void @free(i8*)

define void @.print(%type.string* %str) {
entry:
  %i = alloca i32, align 8
  %0 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 1
  %1 = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 2
  %2 = load i32, i32* %0, align 8
  %3 = load i8*, i8** %1, align 8
  store i32 0, i32* %i, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %4 = load i32, i32* %i, align 8
  %str.len = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 1
  %5 = load i32, i32* %str.len, align 8
  %cmp = icmp slt i32 %4, %5
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %str.adr = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 2
  %6 = load i8*, i8** %str.adr, align 8
  %7 = load i32, i32* %i, align 8
  %str.idx = getelementptr inbounds i8, i8* %6, i32 %7
  %8 = load i8, i8* %str.idx, align 1
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

define void @.println(%type.string* %str) {
entry:
  call void @.print(%type.string* %str)
  call void @putchar(i8 10)
  ret void
}

define void @.add.string_string(%type.string* %ret, %type.string* %a, %type.string* %b) {
entry:
  %0 = getelementptr inbounds %type.string, %type.string* %a, i32 0, i32 0
  %1 = load i32, i32* %0, align 4
  %2 = getelementptr inbounds %type.string, %type.string* %b, i32 0, i32 0
  %3 = load i32, i32* %2, align 4
  %4 = add i32 %1, %3
  %5 = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 0
  store i32 %4, i32* %5, align 8
  %6 = getelementptr inbounds %type.string, %type.string* %a, i32 0, i32 1
  %7 = load i32, i32* %6, align 4
  %8 = getelementptr inbounds %type.string, %type.string* %b, i32 0, i32 1
  %9 = load i32, i32* %8, align 4
  %10 = add i32 %7, %9
  %11 = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 1
  store i32 %10, i32* %11, align 8
  %12 = call i8* @malloc(i32 %10)
  %13 = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 2
  store i8* %12, i8** %13, align 8
  %i = alloca i32, align 4
  store i32 0, i32* %i, align 4
  %j = alloca i32, align 4
  store i32 0, i32* %j, align 4
  %14 = getelementptr inbounds %type.string, %type.string* %a, i32 0, i32 2
  %15 = getelementptr inbounds %type.string, %type.string* %b, i32 0, i32 2
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
  ret void
}

define void @main() {
entry:
  %0 = getelementptr inbounds [15 x i8], [15 x i8]* @.str0, i32 0, i32 0
  %1 = alloca %type.string, align 8
  %2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
  store i32 15, i32* %2, align 8
  %3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
  store i32 15, i32* %3, align 8
  %4 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 2
  store i8* %0, i8** %4, align 8
  %5 = alloca %type.string, align 8
  call void @.conv.int_string(%type.string* %5, i32 7419208)
  %6 = alloca %type.string, align 8
  call void @.add.string_string(%type.string* %6, %type.string* %1, %type.string* %5)
  call void @.println(%type.string* %6)
  ret void
}

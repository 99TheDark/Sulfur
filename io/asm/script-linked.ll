; ModuleID = 'script-linked.bc'
source_filename = "llvm-link"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [1 x i8] c"0", align 1
@.str0.1 = private unnamed_addr constant [24 x i8] c"It is legal to drink at ", align 1
@.str1 = private unnamed_addr constant [10 x i8] c" years old", align 1
@.str2 = private unnamed_addr constant [26 x i8] c"It is illegal to drink at ", align 1
@.str4 = private unnamed_addr constant [26 x i8] c". . . . . . . . . . . . . ", align 1

define void @.conv.int_string(%type.string* %ret, i32 %num) {
entry:
  %0 = icmp eq i32 %num, 0
  br i1 %0, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = getelementptr inbounds [1 x i8], [1 x i8]* @.str0, i32 0, i32 0
  %2 = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 0
  store i32 1, i32* %2, align 8
  %3 = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 1
  store i32 1, i32* %3, align 8
  %4 = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 2
  store i8* %1, i8** %4, align 8
  br label %exit

if.end:                                           ; preds = %entry
  %num.adr = alloca i32, align 4
  store i32 %num, i32* %num.adr, align 4
  %buf = alloca i8*, align 8
  %buf.adr = call i8* @malloc(i32 10)
  store i8* %buf.adr, i8** %buf, align 8
  %i = alloca i32, align 4
  store i32 9, i32* %i, align 4
  %sign = alloca i32, align 4
  store i32 0, i32* %sign, align 4
  %5 = load i32, i32* %num.adr, align 4
  %6 = load i8*, i8** %buf, align 8
  %7 = icmp slt i32 %5, 0
  br i1 %7, label %if.then1, label %if.end1

if.then1:                                         ; preds = %if.end
  %8 = sub i32 0, %5
  store i32 %8, i32* %num.adr, align 4
  store i32 1, i32* %sign, align 4
  br label %if.end1

if.end1:                                          ; preds = %if.then1, %if.end
  br label %while.cond

while.cond:                                       ; preds = %while.body, %if.end1
  %9 = load i32, i32* %num.adr, align 4
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
  store i32 %16, i32* %num.adr, align 4
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
  %ret.len = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 0
  store i32 %22, i32* %ret.len, align 8
  %ret.size = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 1
  store i32 %22, i32* %ret.size, align 8
  %ret.adr = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 2
  %23 = call i8* @malloc(i32 %22)
  store i8* %23, i8** %ret.adr, align 8
  %24 = icmp ne i32 %20, 0
  br i1 %24, label %if.then2, label %if.else2

if.then2:                                         ; preds = %while.end
  %25 = load i8*, i8** %ret.adr, align 8
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
  %ret.adr2 = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 2
  %34 = load i8*, i8** %ret.adr2, align 8
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
  %i = alloca i32, align 4
  store i32 12, i32* %i, align 4
  br label %for.cond0

exit:                                             ; preds = %for.end0
  ret void

for.cond0:                                        ; preds = %for.inc0, %entry
  %0 = load i32, i32* %i, align 4
  %1 = icmp sle i32 %0, 20
  br i1 %1, label %for.body0, label %for.end0

for.body0:                                        ; preds = %for.cond0
  %2 = load i32, i32* %i, align 4
  %3 = alloca %type.string, align 8
  call void @.conv.int_string(%type.string* %3, i32 %2)
  %age = alloca %type.string*, align 8
  store %type.string* %3, %type.string** %age, align 8
  %4 = load i32, i32* %i, align 4
  %5 = icmp sge i32 %4, 18
  br i1 %5, label %if.then0, label %if.else0

if.then0:                                         ; preds = %for.body0
  %6 = getelementptr inbounds [24 x i8], [24 x i8]* @.str0.1, i32 0, i32 0
  %7 = alloca %type.string, align 8
  %8 = getelementptr inbounds %type.string, %type.string* %7, i32 0, i32 0
  store i32 24, i32* %8, align 8
  %9 = getelementptr inbounds %type.string, %type.string* %7, i32 0, i32 1
  store i32 24, i32* %9, align 8
  %10 = getelementptr inbounds %type.string, %type.string* %7, i32 0, i32 2
  store i8* %6, i8** %10, align 8
  %11 = load %type.string*, %type.string** %age, align 8
  %12 = alloca %type.string, align 8
  call void @.add.string_string(%type.string* %12, %type.string* %7, %type.string* %11)
  %13 = getelementptr inbounds [10 x i8], [10 x i8]* @.str1, i32 0, i32 0
  %14 = alloca %type.string, align 8
  %15 = getelementptr inbounds %type.string, %type.string* %14, i32 0, i32 0
  store i32 10, i32* %15, align 8
  %16 = getelementptr inbounds %type.string, %type.string* %14, i32 0, i32 1
  store i32 10, i32* %16, align 8
  %17 = getelementptr inbounds %type.string, %type.string* %14, i32 0, i32 2
  store i8* %13, i8** %17, align 8
  %18 = alloca %type.string, align 8
  call void @.add.string_string(%type.string* %18, %type.string* %12, %type.string* %14)
  call void @.println(%type.string* %18)
  br label %if.end0

if.else0:                                         ; preds = %for.body0
  %19 = getelementptr inbounds [26 x i8], [26 x i8]* @.str2, i32 0, i32 0
  %20 = alloca %type.string, align 8
  %21 = getelementptr inbounds %type.string, %type.string* %20, i32 0, i32 0
  store i32 26, i32* %21, align 8
  %22 = getelementptr inbounds %type.string, %type.string* %20, i32 0, i32 1
  store i32 26, i32* %22, align 8
  %23 = getelementptr inbounds %type.string, %type.string* %20, i32 0, i32 2
  store i8* %19, i8** %23, align 8
  %24 = load %type.string*, %type.string** %age, align 8
  %25 = alloca %type.string, align 8
  call void @.add.string_string(%type.string* %25, %type.string* %20, %type.string* %24)
  %26 = getelementptr inbounds [10 x i8], [10 x i8]* @.str1, i32 0, i32 0
  %27 = alloca %type.string, align 8
  %28 = getelementptr inbounds %type.string, %type.string* %27, i32 0, i32 0
  store i32 10, i32* %28, align 8
  %29 = getelementptr inbounds %type.string, %type.string* %27, i32 0, i32 1
  store i32 10, i32* %29, align 8
  %30 = getelementptr inbounds %type.string, %type.string* %27, i32 0, i32 2
  store i8* %26, i8** %30, align 8
  %31 = alloca %type.string, align 8
  call void @.add.string_string(%type.string* %31, %type.string* %25, %type.string* %27)
  call void @.println(%type.string* %31)
  br label %if.end0

if.end0:                                          ; preds = %if.else0, %if.then0
  br label %for.inc0

for.inc0:                                         ; preds = %if.end0
  %32 = load i32, i32* %i, align 4
  %33 = add i32 %32, 1
  store i32 %33, i32* %i, align 4
  br label %for.cond0

for.end0:                                         ; preds = %for.cond0
  %34 = getelementptr inbounds [26 x i8], [26 x i8]* @.str4, i32 0, i32 0
  %35 = alloca %type.string, align 8
  %36 = getelementptr inbounds %type.string, %type.string* %35, i32 0, i32 0
  store i32 26, i32* %36, align 8
  %37 = getelementptr inbounds %type.string, %type.string* %35, i32 0, i32 1
  store i32 26, i32* %37, align 8
  %38 = getelementptr inbounds %type.string, %type.string* %35, i32 0, i32 2
  store i8* %34, i8** %38, align 8
  call void @.println(%type.string* %35)
  br label %exit
}

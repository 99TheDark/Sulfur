; ModuleID = 'script-linked.bc'
source_filename = "llvm-link"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [4 x i8] c"true", align 1
@.str1 = private unnamed_addr constant [5 x i8] c"false", align 1
@.str0.1 = private unnamed_addr constant [1 x i8] c"0", align 1
@.str0.2 = private unnamed_addr constant [2 x i8] c"th", align 1
@.str1.3 = private unnamed_addr constant [2 x i8] c"st", align 1
@.str2 = private unnamed_addr constant [2 x i8] c"nd", align 1
@.str3 = private unnamed_addr constant [2 x i8] c"rd", align 1
@.str4 = private unnamed_addr constant [2 x i8] c", ", align 1

define void @.conv.bool_string(%type.string* %ret, i1 %bool) {
entry:
  br i1 %bool, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %0 = getelementptr inbounds [4 x i8], [4 x i8]* @.str0, i32 0, i32 0
  %1 = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 0
  store i32 4, i32* %1, align 8
  %2 = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 1
  store i32 4, i32* %2, align 8
  %3 = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 2
  store i8* %0, i8** %3, align 8
  br label %exit

if.else:                                          ; preds = %entry
  %4 = getelementptr inbounds [5 x i8], [5 x i8]* @.str1, i32 0, i32 0
  %5 = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 0
  store i32 5, i32* %5, align 8
  %6 = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 1
  store i32 5, i32* %6, align 8
  %7 = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 2
  store i8* %4, i8** %7, align 8
  br label %exit

exit:                                             ; preds = %if.else, %if.then
  ret void
}

define void @.conv.int_string(%type.string* %ret, i32 %int) {
entry:
  %0 = icmp eq i32 %int, 0
  br i1 %0, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = getelementptr inbounds [1 x i8], [1 x i8]* @.str0.1, i32 0, i32 0
  %2 = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 0
  store i32 1, i32* %2, align 8
  %3 = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 1
  store i32 1, i32* %3, align 8
  %4 = getelementptr inbounds %type.string, %type.string* %ret, i32 0, i32 2
  store i8* %1, i8** %4, align 8
  br label %exit

if.end:                                           ; preds = %entry
  %int.adr = alloca i32, align 4
  store i32 %int, i32* %int.adr, align 4
  %buf = alloca i8*, align 8
  %buf.adr = call i8* @malloc(i32 10)
  store i8* %buf.adr, i8** %buf, align 8
  %i = alloca i32, align 4
  store i32 9, i32* %i, align 4
  %sign = alloca i32, align 4
  store i32 0, i32* %sign, align 4
  %5 = load i32, i32* %int.adr, align 4
  %6 = load i8*, i8** %buf, align 8
  %7 = icmp slt i32 %5, 0
  br i1 %7, label %if.then1, label %if.end1

if.then1:                                         ; preds = %if.end
  %8 = sub i32 0, %5
  store i32 %8, i32* %int.adr, align 4
  store i32 1, i32* %sign, align 4
  br label %if.end1

if.end1:                                          ; preds = %if.then1, %if.end
  br label %while.cond

while.cond:                                       ; preds = %while.body, %if.end1
  %9 = load i32, i32* %int.adr, align 4
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
  store i32 %16, i32* %int.adr, align 4
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
  store i32 1, i32* %i, align 4
  br label %for.cond0

exit:                                             ; preds = %for.end0
  ret void

for.cond0:                                        ; preds = %for.inc0, %entry
  %0 = load i32, i32* %i, align 4
  %1 = icmp sle i32 %0, 100
  br i1 %1, label %for.body0, label %for.end0

for.body0:                                        ; preds = %for.cond0
  %2 = load i32, i32* %i, align 4
  %3 = srem i32 %2, 10
  %end = alloca i32, align 4
  store i32 %3, i32* %end, align 4
  %4 = getelementptr inbounds [2 x i8], [2 x i8]* @.str0.2, i32 0, i32 0
  %5 = alloca %type.string, align 8
  %6 = getelementptr inbounds %type.string, %type.string* %5, i32 0, i32 0
  store i32 2, i32* %6, align 8
  %7 = getelementptr inbounds %type.string, %type.string* %5, i32 0, i32 1
  store i32 2, i32* %7, align 8
  %8 = getelementptr inbounds %type.string, %type.string* %5, i32 0, i32 2
  store i8* %4, i8** %8, align 8
  %suffix = alloca %type.string*, align 8
  store %type.string* %5, %type.string** %suffix, align 8
  %9 = load i32, i32* %i, align 4
  %10 = icmp sle i32 %9, 10
  %11 = load i32, i32* %i, align 4
  %12 = icmp sgt i32 %11, 20
  %13 = or i1 %10, %12
  br i1 %13, label %if.then1, label %if.end1

for.inc0:                                         ; preds = %if.end5
  %14 = load i32, i32* %i, align 4
  %15 = add i32 %14, 1
  store i32 %15, i32* %i, align 4
  br label %for.cond0

for.end0:                                         ; preds = %for.cond0
  br label %exit

if.then1:                                         ; preds = %for.body0
  %16 = load i32, i32* %end, align 4
  %17 = icmp eq i32 %16, 1
  br i1 %17, label %if.then2, label %if.else2

if.end1:                                          ; preds = %if.end2, %for.body0
  %18 = load i32, i32* %i, align 4
  %19 = alloca %type.string, align 8
  call void @.conv.int_string(%type.string* %19, i32 %18)
  %20 = load %type.string*, %type.string** %suffix, align 8
  %21 = alloca %type.string, align 8
  call void @.add.string_string(%type.string* %21, %type.string* %19, %type.string* %20)
  %strNum = alloca %type.string*, align 8
  store %type.string* %21, %type.string** %strNum, align 8
  %22 = load i32, i32* %end, align 4
  %23 = icmp eq i32 %22, 0
  br i1 %23, label %if.then5, label %if.else5

if.then2:                                         ; preds = %if.then1
  %24 = getelementptr inbounds [2 x i8], [2 x i8]* @.str1.3, i32 0, i32 0
  %25 = alloca %type.string, align 8
  %26 = getelementptr inbounds %type.string, %type.string* %25, i32 0, i32 0
  store i32 2, i32* %26, align 8
  %27 = getelementptr inbounds %type.string, %type.string* %25, i32 0, i32 1
  store i32 2, i32* %27, align 8
  %28 = getelementptr inbounds %type.string, %type.string* %25, i32 0, i32 2
  store i8* %24, i8** %28, align 8
  store %type.string* %25, %type.string** %suffix, align 8
  br label %if.end2

if.else2:                                         ; preds = %if.then1
  %29 = load i32, i32* %end, align 4
  %30 = icmp eq i32 %29, 2
  br i1 %30, label %if.then3, label %if.else3

if.end2:                                          ; preds = %if.end3, %if.then2
  br label %if.end1

if.then3:                                         ; preds = %if.else2
  %31 = getelementptr inbounds [2 x i8], [2 x i8]* @.str2, i32 0, i32 0
  %32 = alloca %type.string, align 8
  %33 = getelementptr inbounds %type.string, %type.string* %32, i32 0, i32 0
  store i32 2, i32* %33, align 8
  %34 = getelementptr inbounds %type.string, %type.string* %32, i32 0, i32 1
  store i32 2, i32* %34, align 8
  %35 = getelementptr inbounds %type.string, %type.string* %32, i32 0, i32 2
  store i8* %31, i8** %35, align 8
  store %type.string* %32, %type.string** %suffix, align 8
  br label %if.end3

if.else3:                                         ; preds = %if.else2
  %36 = load i32, i32* %end, align 4
  %37 = icmp eq i32 %36, 3
  br i1 %37, label %if.then4, label %if.end4

if.end3:                                          ; preds = %if.end4, %if.then3
  br label %if.end2

if.then4:                                         ; preds = %if.else3
  %38 = getelementptr inbounds [2 x i8], [2 x i8]* @.str3, i32 0, i32 0
  %39 = alloca %type.string, align 8
  %40 = getelementptr inbounds %type.string, %type.string* %39, i32 0, i32 0
  store i32 2, i32* %40, align 8
  %41 = getelementptr inbounds %type.string, %type.string* %39, i32 0, i32 1
  store i32 2, i32* %41, align 8
  %42 = getelementptr inbounds %type.string, %type.string* %39, i32 0, i32 2
  store i8* %38, i8** %42, align 8
  store %type.string* %39, %type.string** %suffix, align 8
  br label %if.end4

if.end4:                                          ; preds = %if.then4, %if.else3
  br label %if.end3

if.then5:                                         ; preds = %if.end1
  %43 = load %type.string*, %type.string** %strNum, align 8
  call void @.println(%type.string* %43)
  br label %if.end5

if.else5:                                         ; preds = %if.end1
  %44 = load %type.string*, %type.string** %strNum, align 8
  %45 = getelementptr inbounds [2 x i8], [2 x i8]* @.str4, i32 0, i32 0
  %46 = alloca %type.string, align 8
  %47 = getelementptr inbounds %type.string, %type.string* %46, i32 0, i32 0
  store i32 2, i32* %47, align 8
  %48 = getelementptr inbounds %type.string, %type.string* %46, i32 0, i32 1
  store i32 2, i32* %48, align 8
  %49 = getelementptr inbounds %type.string, %type.string* %46, i32 0, i32 2
  store i8* %45, i8** %49, align 8
  %50 = alloca %type.string, align 8
  call void @.add.string_string(%type.string* %50, %type.string* %44, %type.string* %46)
  call void @.print(%type.string* %50)
  br label %if.end5

if.end5:                                          ; preds = %if.else5, %if.then5
  br label %for.inc0
}

; ModuleID = 'script-linked.bc'
source_filename = "llvm-link"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [4 x i8] c"true", align 1
@.str1 = private unnamed_addr constant [5 x i8] c"false", align 1
@.str0.1 = private unnamed_addr constant [1 x i8] c"0", align 1
@.str0.2 = private unnamed_addr constant [0 x i8] zeroinitializer, align 1
@.str1.3 = private unnamed_addr constant [2 x i8] c"th", align 1
@.str2 = private unnamed_addr constant [2 x i8] c"st", align 1
@.str3 = private unnamed_addr constant [2 x i8] c"nd", align 1
@.str4 = private unnamed_addr constant [2 x i8] c"rd", align 1
@.str5 = private unnamed_addr constant [2 x i8] c", ", align 1

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
  %j = alloca i32, align 4
  store i32 0, i32* %j, align 4
  br label %for.cond0

exit:                                             ; preds = %for.end1
  ret void

for.cond0:                                        ; preds = %for.inc0, %entry
  %0 = load i32, i32* %j, align 4
  %1 = icmp slt i32 %0, 20
  br i1 %1, label %for.body0, label %for.end0

for.body0:                                        ; preds = %for.cond0
  %2 = load i32, i32* %j, align 4
  %3 = call i32 @mod.fib(i32 %2)
  %4 = alloca %type.string, align 8
  call void @.conv.int_string(%type.string* %4, i32 %3)
  call void @.println(%type.string* %4)
  br label %for.inc0

for.inc0:                                         ; preds = %for.body0
  %5 = load i32, i32* %j, align 4
  %6 = add i32 %5, 1
  store i32 %6, i32* %j, align 4
  br label %for.cond0

for.end0:                                         ; preds = %for.cond0
  %7 = getelementptr inbounds [0 x i8], [0 x i8]* @.str0.2, i32 0, i32 0
  %8 = alloca %type.string, align 8
  %9 = getelementptr inbounds %type.string, %type.string* %8, i32 0, i32 0
  store i32 0, i32* %9, align 8
  %10 = getelementptr inbounds %type.string, %type.string* %8, i32 0, i32 1
  store i32 0, i32* %10, align 8
  %11 = getelementptr inbounds %type.string, %type.string* %8, i32 0, i32 2
  store i8* %7, i8** %11, align 8
  call void @.println(%type.string* %8)
  %i = alloca i32, align 4
  store i32 1, i32* %i, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc1, %for.end0
  %12 = load i32, i32* %i, align 4
  %13 = icmp sle i32 %12, 100
  br i1 %13, label %for.body1, label %for.end1

for.body1:                                        ; preds = %for.cond1
  %14 = load i32, i32* %i, align 4
  %15 = srem i32 %14, 10
  %end = alloca i32, align 4
  store i32 %15, i32* %end, align 4
  %16 = getelementptr inbounds [2 x i8], [2 x i8]* @.str1.3, i32 0, i32 0
  %17 = alloca %type.string, align 8
  %18 = getelementptr inbounds %type.string, %type.string* %17, i32 0, i32 0
  store i32 2, i32* %18, align 8
  %19 = getelementptr inbounds %type.string, %type.string* %17, i32 0, i32 1
  store i32 2, i32* %19, align 8
  %20 = getelementptr inbounds %type.string, %type.string* %17, i32 0, i32 2
  store i8* %16, i8** %20, align 8
  %suffix = alloca %type.string*, align 8
  store %type.string* %17, %type.string** %suffix, align 8
  %21 = load i32, i32* %i, align 4
  %22 = icmp sle i32 %21, 10
  %23 = load i32, i32* %i, align 4
  %24 = icmp sgt i32 %23, 20
  %25 = or i1 %22, %24
  br i1 %25, label %if.then2, label %if.end2

for.inc1:                                         ; preds = %if.end6
  %26 = load i32, i32* %i, align 4
  %27 = add i32 %26, 1
  store i32 %27, i32* %i, align 4
  br label %for.cond1

for.end1:                                         ; preds = %for.cond1
  br label %exit

if.then2:                                         ; preds = %for.body1
  %28 = load i32, i32* %end, align 4
  %29 = icmp eq i32 %28, 1
  br i1 %29, label %if.then3, label %if.else3

if.end2:                                          ; preds = %if.end3, %for.body1
  %30 = load i32, i32* %i, align 4
  %31 = alloca %type.string, align 8
  call void @.conv.int_string(%type.string* %31, i32 %30)
  %32 = load %type.string*, %type.string** %suffix, align 8
  %33 = alloca %type.string, align 8
  call void @.add.string_string(%type.string* %33, %type.string* %31, %type.string* %32)
  %strNum = alloca %type.string*, align 8
  store %type.string* %33, %type.string** %strNum, align 8
  %34 = load i32, i32* %end, align 4
  %35 = icmp eq i32 %34, 0
  br i1 %35, label %if.then6, label %if.else6

if.then3:                                         ; preds = %if.then2
  %36 = getelementptr inbounds [2 x i8], [2 x i8]* @.str2, i32 0, i32 0
  %37 = alloca %type.string, align 8
  %38 = getelementptr inbounds %type.string, %type.string* %37, i32 0, i32 0
  store i32 2, i32* %38, align 8
  %39 = getelementptr inbounds %type.string, %type.string* %37, i32 0, i32 1
  store i32 2, i32* %39, align 8
  %40 = getelementptr inbounds %type.string, %type.string* %37, i32 0, i32 2
  store i8* %36, i8** %40, align 8
  store %type.string* %37, %type.string** %suffix, align 8
  br label %if.end3

if.else3:                                         ; preds = %if.then2
  %41 = load i32, i32* %end, align 4
  %42 = icmp eq i32 %41, 2
  br i1 %42, label %if.then4, label %if.else4

if.end3:                                          ; preds = %if.end4, %if.then3
  br label %if.end2

if.then4:                                         ; preds = %if.else3
  %43 = getelementptr inbounds [2 x i8], [2 x i8]* @.str3, i32 0, i32 0
  %44 = alloca %type.string, align 8
  %45 = getelementptr inbounds %type.string, %type.string* %44, i32 0, i32 0
  store i32 2, i32* %45, align 8
  %46 = getelementptr inbounds %type.string, %type.string* %44, i32 0, i32 1
  store i32 2, i32* %46, align 8
  %47 = getelementptr inbounds %type.string, %type.string* %44, i32 0, i32 2
  store i8* %43, i8** %47, align 8
  store %type.string* %44, %type.string** %suffix, align 8
  br label %if.end4

if.else4:                                         ; preds = %if.else3
  %48 = load i32, i32* %end, align 4
  %49 = icmp eq i32 %48, 3
  br i1 %49, label %if.then5, label %if.end5

if.end4:                                          ; preds = %if.end5, %if.then4
  br label %if.end3

if.then5:                                         ; preds = %if.else4
  %50 = getelementptr inbounds [2 x i8], [2 x i8]* @.str4, i32 0, i32 0
  %51 = alloca %type.string, align 8
  %52 = getelementptr inbounds %type.string, %type.string* %51, i32 0, i32 0
  store i32 2, i32* %52, align 8
  %53 = getelementptr inbounds %type.string, %type.string* %51, i32 0, i32 1
  store i32 2, i32* %53, align 8
  %54 = getelementptr inbounds %type.string, %type.string* %51, i32 0, i32 2
  store i8* %50, i8** %54, align 8
  store %type.string* %51, %type.string** %suffix, align 8
  br label %if.end5

if.end5:                                          ; preds = %if.then5, %if.else4
  br label %if.end4

if.then6:                                         ; preds = %if.end2
  %55 = load %type.string*, %type.string** %strNum, align 8
  call void @.println(%type.string* %55)
  br label %if.end6

if.else6:                                         ; preds = %if.end2
  %56 = load %type.string*, %type.string** %strNum, align 8
  %57 = getelementptr inbounds [2 x i8], [2 x i8]* @.str5, i32 0, i32 0
  %58 = alloca %type.string, align 8
  %59 = getelementptr inbounds %type.string, %type.string* %58, i32 0, i32 0
  store i32 2, i32* %59, align 8
  %60 = getelementptr inbounds %type.string, %type.string* %58, i32 0, i32 1
  store i32 2, i32* %60, align 8
  %61 = getelementptr inbounds %type.string, %type.string* %58, i32 0, i32 2
  store i8* %57, i8** %61, align 8
  %62 = alloca %type.string, align 8
  call void @.add.string_string(%type.string* %62, %type.string* %56, %type.string* %58)
  call void @.print(%type.string* %62)
  br label %if.end6

if.end6:                                          ; preds = %if.else6, %if.then6
  br label %for.inc1
}

define i32 @mod.fib(i32 %0) {
entry:
  %.ret = alloca i32, align 4
  %1 = icmp sle i32 %0, 1
  br i1 %1, label %if.then0, label %if.else0

exit:                                             ; preds = %if.end0
  %2 = load i32, i32* %.ret, align 4
  ret i32 %2

if.then0:                                         ; preds = %entry
  store i32 1, i32* %.ret, align 4
  br label %if.end0

if.else0:                                         ; preds = %entry
  %3 = sub i32 %0, 2
  %4 = call i32 @mod.fib(i32 %3)
  %5 = sub i32 %0, 1
  %6 = call i32 @mod.fib(i32 %5)
  %7 = add i32 %4, %6
  store i32 %7, i32* %.ret, align 4
  br label %if.end0

if.end0:                                          ; preds = %if.else0, %if.then0
  br label %exit
}

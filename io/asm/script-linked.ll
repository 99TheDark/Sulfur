; ModuleID = 'script-linked.bc'
source_filename = "llvm-link"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [4 x i8] c"John", align 1
@.str1 = private unnamed_addr constant [5 x i8] c"Smith", align 1
@.str2 = private unnamed_addr constant [1 x i8] c" ", align 1
@.str3 = private unnamed_addr constant [2 x i8] c", ", align 1
@.str4 = private unnamed_addr constant [16 x i8] c"x is less than 8", align 1
@.str5 = private unnamed_addr constant [20 x i8] c"x is not less than 8", align 1
@.str6 = private unnamed_addr constant [7 x i8] c"No else", align 1
@.str7 = private unnamed_addr constant [6 x i8] c"1: abc", align 1
@.str8 = private unnamed_addr constant [6 x i8] c"2: def", align 1
@.str9 = private unnamed_addr constant [6 x i8] c"3: ghi", align 1
@.str10 = private unnamed_addr constant [4 x i8] c"true", align 1
@.str11 = private unnamed_addr constant [3 x i8] c"end", align 1

define void @print(%type.string* %str) {
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

define void @println(%type.string* %str) {
entry:
  call void @print(%type.string* %str)
  call void @putchar(i8 10)
  ret void
}

define void @concat(%type.string* %ret, %type.string* %a, %type.string* %b) {
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

declare i8* @malloc(i32)

define void @main() {
entry:
  %0 = getelementptr inbounds [4 x i8], [4 x i8]* @.str0, i32 0, i32 0
  %1 = alloca %type.string, align 8
  %2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
  store i32 4, i32* %2, align 8
  %3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
  store i32 4, i32* %3, align 8
  %4 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 2
  store i8* %0, i8** %4, align 8
  %firstName = alloca %type.string*, align 8
  store %type.string* %1, %type.string** %firstName, align 8
  %5 = getelementptr inbounds [5 x i8], [5 x i8]* @.str1, i32 0, i32 0
  %6 = alloca %type.string, align 8
  %7 = getelementptr inbounds %type.string, %type.string* %6, i32 0, i32 0
  store i32 5, i32* %7, align 8
  %8 = getelementptr inbounds %type.string, %type.string* %6, i32 0, i32 1
  store i32 5, i32* %8, align 8
  %9 = getelementptr inbounds %type.string, %type.string* %6, i32 0, i32 2
  store i8* %5, i8** %9, align 8
  %lastName = alloca %type.string*, align 8
  store %type.string* %6, %type.string** %lastName, align 8
  %10 = load %type.string*, %type.string** %firstName, align 8
  %11 = getelementptr inbounds [1 x i8], [1 x i8]* @.str2, i32 0, i32 0
  %12 = alloca %type.string, align 8
  %13 = getelementptr inbounds %type.string, %type.string* %12, i32 0, i32 0
  store i32 1, i32* %13, align 8
  %14 = getelementptr inbounds %type.string, %type.string* %12, i32 0, i32 1
  store i32 1, i32* %14, align 8
  %15 = getelementptr inbounds %type.string, %type.string* %12, i32 0, i32 2
  store i8* %11, i8** %15, align 8
  %16 = alloca %type.string, align 8
  call void @concat(%type.string* %16, %type.string* %10, %type.string* %12)
  %17 = load %type.string*, %type.string** %lastName, align 8
  %18 = alloca %type.string, align 8
  call void @concat(%type.string* %18, %type.string* %16, %type.string* %17)
  call void @println(%type.string* %18)
  %19 = load %type.string*, %type.string** %lastName, align 8
  %20 = getelementptr inbounds [2 x i8], [2 x i8]* @.str3, i32 0, i32 0
  %21 = alloca %type.string, align 8
  %22 = getelementptr inbounds %type.string, %type.string* %21, i32 0, i32 0
  store i32 2, i32* %22, align 8
  %23 = getelementptr inbounds %type.string, %type.string* %21, i32 0, i32 1
  store i32 2, i32* %23, align 8
  %24 = getelementptr inbounds %type.string, %type.string* %21, i32 0, i32 2
  store i8* %20, i8** %24, align 8
  %25 = alloca %type.string, align 8
  call void @concat(%type.string* %25, %type.string* %19, %type.string* %21)
  %26 = load %type.string*, %type.string** %firstName, align 8
  %27 = alloca %type.string, align 8
  call void @concat(%type.string* %27, %type.string* %25, %type.string* %26)
  call void @println(%type.string* %27)
  %x = alloca i32, align 4
  store i32 7, i32* %x, align 4
  %28 = load i32, i32* %x, align 4
  %29 = icmp slt i32 %28, 8
  br i1 %29, label %if.then0, label %if.else0

if.then0:                                         ; preds = %entry
  %30 = getelementptr inbounds [16 x i8], [16 x i8]* @.str4, i32 0, i32 0
  %31 = alloca %type.string, align 8
  %32 = getelementptr inbounds %type.string, %type.string* %31, i32 0, i32 0
  store i32 16, i32* %32, align 8
  %33 = getelementptr inbounds %type.string, %type.string* %31, i32 0, i32 1
  store i32 16, i32* %33, align 8
  %34 = getelementptr inbounds %type.string, %type.string* %31, i32 0, i32 2
  store i8* %30, i8** %34, align 8
  call void @println(%type.string* %31)
  br label %if.end0

if.else0:                                         ; preds = %entry
  %35 = getelementptr inbounds [20 x i8], [20 x i8]* @.str5, i32 0, i32 0
  %36 = alloca %type.string, align 8
  %37 = getelementptr inbounds %type.string, %type.string* %36, i32 0, i32 0
  store i32 20, i32* %37, align 8
  %38 = getelementptr inbounds %type.string, %type.string* %36, i32 0, i32 1
  store i32 20, i32* %38, align 8
  %39 = getelementptr inbounds %type.string, %type.string* %36, i32 0, i32 2
  store i8* %35, i8** %39, align 8
  call void @println(%type.string* %36)
  br label %if.end0

if.end0:                                          ; preds = %if.else0, %if.then0
  %y = alloca i32, align 4
  store i32 19, i32* %y, align 4
  %40 = load i32, i32* %y, align 4
  %41 = icmp sgt i32 %40, 12
  br i1 %41, label %if.then1, label %if.end1

if.then1:                                         ; preds = %if.end0
  %42 = getelementptr inbounds [7 x i8], [7 x i8]* @.str6, i32 0, i32 0
  %43 = alloca %type.string, align 8
  %44 = getelementptr inbounds %type.string, %type.string* %43, i32 0, i32 0
  store i32 7, i32* %44, align 8
  %45 = getelementptr inbounds %type.string, %type.string* %43, i32 0, i32 1
  store i32 7, i32* %45, align 8
  %46 = getelementptr inbounds %type.string, %type.string* %43, i32 0, i32 2
  store i8* %42, i8** %46, align 8
  call void @println(%type.string* %43)
  br label %if.end1

if.end1:                                          ; preds = %if.then1, %if.end0
  %z = alloca i32, align 4
  store i32 7, i32* %z, align 4
  %47 = load i32, i32* %z, align 4
  %48 = load i32, i32* %x, align 4
  %49 = add i32 %47, %48
  %50 = load i32, i32* %y, align 4
  %51 = icmp sgt i32 %49, %50
  br i1 %51, label %if.then2, label %if.else2

if.then2:                                         ; preds = %if.end1
  %52 = getelementptr inbounds [6 x i8], [6 x i8]* @.str7, i32 0, i32 0
  %53 = alloca %type.string, align 8
  %54 = getelementptr inbounds %type.string, %type.string* %53, i32 0, i32 0
  store i32 6, i32* %54, align 8
  %55 = getelementptr inbounds %type.string, %type.string* %53, i32 0, i32 1
  store i32 6, i32* %55, align 8
  %56 = getelementptr inbounds %type.string, %type.string* %53, i32 0, i32 2
  store i8* %52, i8** %56, align 8
  call void @println(%type.string* %53)
  br label %if.end2

if.else2:                                         ; preds = %if.end1
  %57 = load i32, i32* %z, align 4
  %58 = load i32, i32* %x, align 4
  %59 = icmp slt i32 %57, %58
  br label %if.end2

if.then3:                                         ; No predecessors!
  %60 = getelementptr inbounds [6 x i8], [6 x i8]* @.str8, i32 0, i32 0
  %61 = alloca %type.string, align 8
  %62 = getelementptr inbounds %type.string, %type.string* %61, i32 0, i32 0
  store i32 6, i32* %62, align 8
  %63 = getelementptr inbounds %type.string, %type.string* %61, i32 0, i32 1
  store i32 6, i32* %63, align 8
  %64 = getelementptr inbounds %type.string, %type.string* %61, i32 0, i32 2
  store i8* %60, i8** %64, align 8
  call void @println(%type.string* %61)
  br label %if.end3

if.else3:                                         ; No predecessors!
  %65 = getelementptr inbounds [6 x i8], [6 x i8]* @.str9, i32 0, i32 0
  %66 = alloca %type.string, align 8
  %67 = getelementptr inbounds %type.string, %type.string* %66, i32 0, i32 0
  store i32 6, i32* %67, align 8
  %68 = getelementptr inbounds %type.string, %type.string* %66, i32 0, i32 1
  store i32 6, i32* %68, align 8
  %69 = getelementptr inbounds %type.string, %type.string* %66, i32 0, i32 2
  store i8* %65, i8** %69, align 8
  call void @println(%type.string* %66)
  br label %if.end3

if.end3:                                          ; preds = %if.else3, %if.then3
  br label %if.end2

if.end2:                                          ; preds = %if.end3, %if.else2, %if.then2
  br i1 true, label %if.then4, label %if.end4

if.then4:                                         ; preds = %if.end2
  %70 = getelementptr inbounds [4 x i8], [4 x i8]* @.str10, i32 0, i32 0
  %71 = alloca %type.string, align 8
  %72 = getelementptr inbounds %type.string, %type.string* %71, i32 0, i32 0
  store i32 4, i32* %72, align 8
  %73 = getelementptr inbounds %type.string, %type.string* %71, i32 0, i32 1
  store i32 4, i32* %73, align 8
  %74 = getelementptr inbounds %type.string, %type.string* %71, i32 0, i32 2
  store i8* %70, i8** %74, align 8
  call void @println(%type.string* %71)
  br label %if.end4

if.end4:                                          ; preds = %if.then4, %if.end2
  %75 = getelementptr inbounds [3 x i8], [3 x i8]* @.str11, i32 0, i32 0
  %76 = alloca %type.string, align 8
  %77 = getelementptr inbounds %type.string, %type.string* %76, i32 0, i32 0
  store i32 3, i32* %77, align 8
  %78 = getelementptr inbounds %type.string, %type.string* %76, i32 0, i32 1
  store i32 3, i32* %78, align 8
  %79 = getelementptr inbounds %type.string, %type.string* %76, i32 0, i32 2
  store i8* %75, i8** %79, align 8
  call void @println(%type.string* %76)
  ret void
}

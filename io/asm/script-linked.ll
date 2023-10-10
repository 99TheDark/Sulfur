; ModuleID = 'script-linked.bc'
source_filename = "llvm-link"

%type.string = type { i32, i32, i8* }

@.str0 = private unnamed_addr constant [19 x i8] c"Hello, world! \CE\B5\E2\B1\9E", align 1
@.str1 = private unnamed_addr constant [20 x i8] c"My name is TheDark. ", align 1
@.str2 = private unnamed_addr constant [14 x i8] c"\CF\80 \E2\89\88 3.14159", align 1

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

define void @main() {
entry:
  %0 = getelementptr inbounds [19 x i8], [19 x i8]* @.str0, i32 0, i32 0
  %1 = alloca %type.string, align 8
  %2 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 0
  store i32 16, i32* %2, align 8
  %3 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 1
  store i32 19, i32* %3, align 8
  %4 = getelementptr inbounds %type.string, %type.string* %1, i32 0, i32 2
  store i8* %0, i8** %4, align 8
  call void @println(%type.string* %1)
  %5 = getelementptr inbounds [20 x i8], [20 x i8]* @.str1, i32 0, i32 0
  %6 = alloca %type.string, align 8
  %7 = getelementptr inbounds %type.string, %type.string* %6, i32 0, i32 0
  store i32 20, i32* %7, align 8
  %8 = getelementptr inbounds %type.string, %type.string* %6, i32 0, i32 1
  store i32 20, i32* %8, align 8
  %9 = getelementptr inbounds %type.string, %type.string* %6, i32 0, i32 2
  store i8* %5, i8** %9, align 8
  call void @print(%type.string* %6)
  %10 = getelementptr inbounds [14 x i8], [14 x i8]* @.str2, i32 0, i32 0
  %11 = alloca %type.string, align 8
  %12 = getelementptr inbounds %type.string, %type.string* %11, i32 0, i32 0
  store i32 11, i32* %12, align 8
  %13 = getelementptr inbounds %type.string, %type.string* %11, i32 0, i32 1
  store i32 14, i32* %13, align 8
  %14 = getelementptr inbounds %type.string, %type.string* %11, i32 0, i32 2
  store i8* %10, i8** %14, align 8
  call void @println(%type.string* %11)
  ret void
}

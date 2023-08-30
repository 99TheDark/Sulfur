%type.string = type { i64, i8* }

@.str = private unnamed_addr constant [13 x i8] c"Hello, world!", align 1
@.char = private unnamed_addr constant [3 x i8] c"%c\00", align 1

declare i32 @printf(i8* noundef, ...) #1

define void @println(i64 %str.coerce0, i8* %str.coerce1) {
entry:
  %str = alloca %type.string, align 8
  %i = alloca i32, align 4
  %0 = bitcast %type.string* %str to { i64, i8* }*
  %1 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %0, i32 0, i32 0
  store i64 %str.coerce0, i64* %1, align 8
  %2 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %0, i32 0, i32 1
  store i8* %str.coerce1, i8** %2, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:
  %3 = load i32, i32* %i, align 4
  %conv = sext i32 %3 to i64
  %length = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 0
  %4 = load i64, i64* %length, align 8
  %cmp = icmp slt i64 %conv, %4
  br i1 %cmp, label %for.body, label %for.end

for.body:
  %address = getelementptr inbounds %type.string, %type.string* %str, i32 0, i32 1
  %5 = load i8*, i8** %address, align 8
  %6 = load i32, i32* %i, align 4
  %idxprom = sext i32 %6 to i64
  %arrayidx = getelementptr inbounds i8, i8* %5, i64 %idxprom
  %7 = load i8, i8* %arrayidx, align 1
  %conv2 = sext i8 %7 to i32
  %call = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.char, i64 0, i64 0), i32 noundef %conv2)
  br label %for.inc

for.inc:
  %8 = load i32, i32* %i, align 4
  %inc = add nsw i32 %8, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:
  %call3 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.char, i64 0, i64 0), i32 noundef 10)
  ret void
}

define void @main() {
entry:
	%greeting = alloca %type.string, align 8
	%0 = getelementptr inbounds %type.string, %type.string* %greeting, i32 0, i32 0
	store i64 13, i64* %0, align 8
	%1 = getelementptr inbounds %type.string, %type.string* %greeting, i32 0, i32 1
	%2 = getelementptr inbounds [13 x i8], [13 x i8]* @.str, i32 0, i32 0
	store i8* %2, i8** %1, align 8
	ret void
}

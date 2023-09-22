source_filename = "script.sulfur"

%type.string = type { i64, i8* }

@.str = private unnamed_addr constant [13 x i8] c"Hello, world!", align 1

declare i32 @putchar(i32 %0)

define void @print(i64 %s.len, i8* %s.adr) {
entry:
	%s = alloca %type.string, align 8
	%i = alloca i64, align 8
	%0 = bitcast %type.string* %s to { i64, i8* }*
	%1 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %0, i32 0, i32 0
	store i64 %s.len, i64* %1, align 8
	%2 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %0, i32 0, i32 1
	store i8* %s.adr, i8** %2, align 8
	store i64 0, i64* %i, align 8
	br label %for.cond

for.cond:
	%3 = load i64, i64* %i, align 8
	%len = getelementptr inbounds %type.string, %type.string* %s, i32 0, i32 0
	%4 = load i64, i64* %len, align 8
	%cmp = icmp slt i64 %3, %4
	br i1 %cmp, label %for.body, label %for.end

for.body:
	%adr = getelementptr inbounds %type.string, %type.string* %s, i32 0, i32 1
	%5 = load i8*, i8** %adr, align 8
	%6 = load i64, i64* %i, align 8
	%arrayidx = getelementptr inbounds i8, i8* %5, i64 %6
	%7 = load i8, i8* %arrayidx, align 1
	%conv = sext i8 %7 to i32
	%call = call i32 @putchar(i32 %conv)
	br label %for.inc

for.inc:
	%8 = load i64, i64* %i, align 8
	%inc = add nsw i64 %8, 1
	store i64 %inc, i64* %i, align 8
	br label %for.cond

for.end:
	ret void
}

define void @main() {
entry:
	%0 = getelementptr inbounds [13 x i8], [13 x i8]* @.str, i32 0, i32 0
	%greeting = alloca %type.string, align 8
	%1 = getelementptr inbounds %type.string, %type.string* %greeting, i32 0, i32 0
	store i64 13, i64* %1, align 8
	%2 = getelementptr inbounds %type.string, %type.string* %greeting, i32 0, i32 1
	store i8* %0, i8** %2, align 8
	%3 = load i64, i64* %1, align 8
	%4 = load i8*, i8** %2, align 8
	call void @print(i64 %3, i8* %4)
	ret void
}

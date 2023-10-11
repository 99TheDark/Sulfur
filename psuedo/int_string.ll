%type.string = type { i32, i32, i8* }

declare void @println(%type.string*)

define dso_local { i64, i8* } @int_string(i32 noundef %num) {
entry:
  %retval = alloca %type.string, align 8
  %num.addr = alloca i32, align 4
  %buf = alloca i8*, align 8
  %i = alloca i32, align 4
  %sign = alloca i32, align 4
  %size = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 %num, i32* %num.addr, align 4
  %call = call noalias i8* @malloc(i64 noundef 10) #3
  store i8* %call, i8** %buf, align 8
  store i32 9, i32* %i, align 4
  store i32 0, i32* %sign, align 4
  %0 = load i32, i32* %num.addr, align 4
  %cmp = icmp slt i32 %0, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:
  %1 = load i32, i32* %num.addr, align 4
  %sub = sub nsw i32 0, %1
  store i32 %sub, i32* %num.addr, align 4
  store i32 1, i32* %sign, align 4
  br label %if.end

if.end:
  br label %while.cond

while.cond:
  %2 = load i32, i32* %num.addr, align 4
  %cmp1 = icmp sgt i32 %2, 0
  br i1 %cmp1, label %while.body, label %while.end

while.body:
  %3 = load i32, i32* %num.addr, align 4
  %rem = srem i32 %3, 10
  %add = add nsw i32 48, %rem
  %conv = trunc i32 %add to i8
  %4 = load i8*, i8** %buf, align 8
  %5 = load i32, i32* %i, align 4
  %idxprom = sext i32 %5 to i64
  %arrayidx = getelementptr inbounds i8, i8* %4, i64 %idxprom
  store i8 %conv, i8* %arrayidx, align 1
  %6 = load i32, i32* %num.addr, align 4
  %div = sdiv i32 %6, 10
  store i32 %div, i32* %num.addr, align 4
  %7 = load i32, i32* %i, align 4
  %dec = add nsw i32 %7, -1
  store i32 %dec, i32* %i, align 4
  br label %while.cond

while.end:
  %8 = load i32, i32* %i, align 4
  %sub2 = sub nsw i32 9, %8
  %9 = load i32, i32* %sign, align 4
  %add3 = add nsw i32 %sub2, %9
  store i32 %add3, i32* %size, align 4
  %10 = load i32, i32* %size, align 4
  %len = getelementptr inbounds %type.string, %type.string* %retval, i32 0, i32 0
  store i32 %10, i32* %len, align 8
  %11 = load i32, i32* %size, align 4
  %size4 = getelementptr inbounds %type.string, %type.string* %retval, i32 0, i32 1
  store i32 %11, i32* %size4, align 4
  %12 = load i32, i32* %size, align 4
  %conv5 = sext i32 %12 to i64
  %call6 = call noalias i8* @malloc(i64 noundef %conv5) #3
  %adr = getelementptr inbounds %type.string, %type.string* %retval, i32 0, i32 2
  store i8* %call6, i8** %adr, align 8
  %13 = load i32, i32* %sign, align 4
  %tobool = icmp ne i32 %13, 0
  br i1 %tobool, label %if.then7, label %if.else

if.then7:
  %adr8 = getelementptr inbounds %type.string, %type.string* %retval, i32 0, i32 2
  %14 = load i8*, i8** %adr8, align 8
  %arrayidx9 = getelementptr inbounds i8, i8* %14, i64 0
  store i8 45, i8* %arrayidx9, align 1
  br label %if.end10

if.else:
  %15 = load i32, i32* %i, align 4
  %inc = add nsw i32 %15, 1
  store i32 %inc, i32* %i, align 4
  br label %if.end10

if.end10:
  %16 = load i32, i32* %sign, align 4
  store i32 %16, i32* %j, align 4
  br label %for.cond

for.cond:
  %17 = load i32, i32* %j, align 4
  %18 = load i32, i32* %size, align 4
  %cmp11 = icmp slt i32 %17, %18
  br i1 %cmp11, label %for.body, label %for.end

for.body:
  %19 = load i8*, i8** %buf, align 8
  %20 = load i32, i32* %i, align 4
  %21 = load i32, i32* %j, align 4
  %add13 = add nsw i32 %20, %21
  %idxprom14 = sext i32 %add13 to i64
  %arrayidx15 = getelementptr inbounds i8, i8* %19, i64 %idxprom14
  %22 = load i8, i8* %arrayidx15, align 1
  %adr16 = getelementptr inbounds %type.string, %type.string* %retval, i32 0, i32 2
  %23 = load i8*, i8** %adr16, align 8
  %24 = load i32, i32* %j, align 4
  %idxprom17 = sext i32 %24 to i64
  %arrayidx18 = getelementptr inbounds i8, i8* %23, i64 %idxprom17
  store i8 %22, i8* %arrayidx18, align 1
  br label %for.inc

for.inc:
  %25 = load i32, i32* %j, align 4
  %inc19 = add nsw i32 %25, 1
  store i32 %inc19, i32* %j, align 4
  br label %for.cond

for.end:
  %26 = load i8*, i8** %buf, align 8
  call void @free(i8* noundef %26) #3
  %27 = bitcast %type.string* %retval to { i64, i8* }*
  %28 = load { i64, i8* }, { i64, i8* }* %27, align 8
  ret { i64, i8* } %28
}

declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local noalias i8* @malloc(i64 noundef) #2

declare dso_local void @free(i8* noundef) #2

define dso_local i32 @main() {
entry:
  %retval = alloca i32, align 4
  %s = alloca %type.string, align 8
  store i32 0, i32* %retval, align 4
  %call = call { i64, i8* } @int_string(i32 noundef -42345910)
  %0 = bitcast %type.string* %s to { i64, i8* }*
  %1 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %0, i32 0, i32 0
  %2 = extractvalue { i64, i8* } %call, 0
  store i64 %2, i64* %1, align 8
  %3 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %0, i32 0, i32 1
  %4 = extractvalue { i64, i8* } %call, 1
  store i8* %4, i8** %3, align 8
  call void @println(%type.string* %s)
  ret i32 0
}

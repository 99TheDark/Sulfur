define void @main() {
entry:
	%greeting = alloca [13 x i8]
	store [13 x i8] c"Hello, world!", [13 x i8]* %greeting, align 1
	ret void
}

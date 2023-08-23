define void @main() {
entry:
	%0 = alloca i32
	store i32 504, i32* %0
	%1 = mul i32 2, %0
	%2 = alloca i32
	store i32 %1, i32* %2
	ret void
}

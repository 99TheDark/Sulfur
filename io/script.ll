define void @main() {
entry:
	%0 = mul i32 5, 7
	%1 = add i32 3, %0
	%2 = sdiv i32 4, 2
	%3 = sub i32 %1, %2
	%4 = alloca i32
	store i32 %3, i32* %4
	ret void
}

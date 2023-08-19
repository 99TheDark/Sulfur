define void @main() {
entry:
	%0 = mul i64 5, 7
	%1 = add i64 3, %0
	%2 = sdiv i64 4, 2
	%3 = sub i64 %1, %2
	ret void
}

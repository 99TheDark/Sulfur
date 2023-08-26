define void @main() {
entry:
	%0 = add i32 5, 2
	%a = alloca i32, align 4
	store i32 %0, i32* %a, align 4
	%b = alloca i32, align 4
	store i32 31, i32* %b, align 4
	%1 = load i32, i32* %a, align 4
	%2 = load i32, i32* %b, align 4
	%3 = mul i32 %1, %2
	%c = alloca i32, align 4
	store i32 %3, i32* %c, align 4
	ret void
}

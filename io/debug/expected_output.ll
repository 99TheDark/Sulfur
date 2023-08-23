define void @main() {
entry:
	%0 = mul i32 5, 7
	%1 = add i32 3, %0
	%2 = sdiv i32 4, 2
	%3 = sub i32 %1, %2
	%x = alloca i32, align 4
	store i32 %3, i32* %x, align 4
	%4 = load i32, i32* %x, align 4
	%5 = sub i32 7, %4
	%y = alloca i32, align 4
	store i32 %5, i32* %y, align 4
	ret void
}

define i32 @add(i32 %a, i32 %b) {
entry:
	%1 = add i32 %a, %b
	ret i32 %1
}

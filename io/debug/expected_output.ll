define void @main() {
entry:
	%x = alloca i32, align 4
	store i32 36, i32* %x, align 4
	%0 = load i32, i32* %x, align 4
	%1 = sub i32 7, %0
	%y = alloca i32, align 4
	store i32 %1, i32* %y, align 4
	ret void
}
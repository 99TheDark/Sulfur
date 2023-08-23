; Expected output from 'int x = 504'
define void @main() {
entry:
	%x = alloca i32, align 4
	store i32 504, i32* %x, align 4
	ret void
}

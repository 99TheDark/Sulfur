define void @main() {
entry:
	ret void
}

define i32 @add(i32 %a, i32 %b) {
entry:
	%0 = add i32 %a, %b
	ret i32 %0
}

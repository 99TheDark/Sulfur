define void @main() {
entry:
    %x = alloca i32, align 4
    %y = alloca i1, align 1
    store i32 53, i32* %x, align 4
    store i1 0, i1* %y, align 1
    ret void
}
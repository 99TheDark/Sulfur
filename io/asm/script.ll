; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }
%ref.float = type { float*, i32 }

define void @main() {
entry:
	%x = call %ref.float* @"newref:float"(float 0x401E666660000000)
	call void @"ref:float"(%ref.float* %x)
	call void @mod.floatThing(%ref.float* %x)
	%0 = getelementptr inbounds %ref.float, %ref.float* %x, i32 0, i32 0
	%1 = load float*, float** %0, align 8
	%2 = load float, float* %1, align 4
	%3 = getelementptr inbounds %ref.float, %ref.float* %x, i32 0, i32 0
	%4 = load float*, float** %3, align 8
	%5 = load float, float* %4, align 4
	%6 = fptosi float %5 to i32
	%7 = call %type.string @".conv:int_string"(i32 %6)
	call void @.println(%type.string %7)
	call void @"deref:float"(%ref.float* %x)
	br label %exit

exit:
	ret void
}

declare %ref.float* @"newref:float"(float %0)

declare void @"ref:float"(%ref.float* %0)

declare void @"deref:float"(%ref.float* %0)

define private void @mod.floatThing(%ref.float* %0) {
entry:
	%1 = getelementptr inbounds %ref.float, %ref.float* %0, i32 0, i32 0
	%2 = load float*, float** %1, align 8
	%3 = load float, float* %2, align 4
	%4 = fadd float %3, 0x4023999980000000
	%5 = getelementptr inbounds %ref.float, %ref.float* %0, i32 0, i32 0
	%6 = load float*, float** %5, align 8
	store float %4, float* %6, align 8
	%7 = getelementptr inbounds %ref.float, %ref.float* %0, i32 0, i32 0
	%8 = load float*, float** %7, align 8
	%9 = load float, float* %8, align 4
	%10 = fcmp ule float %9, 30.0
	br i1 %10, label %if.then0, label %if.end0

exit:
	ret void

if.then0:
	call void @"ref:float"(%ref.float* %0)
	call void @mod.floatThing(%ref.float* %0)
	call void @"deref:float"(%ref.float* %0)
	br label %if.end0

if.end0:
	br label %exit
}

declare void @.println(%type.string %0)

declare %type.string @".conv:int_string"(i32 %0)

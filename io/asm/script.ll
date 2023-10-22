; ModuleID = 'script.su'
source_filename = "script.su"

%type.string = type { i32, i32, i8* }

define void @main() {
entry:
	%0 = call %type.string @".conv:float_string"(float 0.0)
	call void @.println(%type.string %0)
	%1 = call %type.string @".conv:float_string"(float -0.0)
	call void @.println(%type.string %1)
	%2 = fdiv float 0.0, 0.0
	%3 = call %type.string @".conv:float_string"(float %2)
	call void @.println(%type.string %3)
	%4 = fdiv float 1.0, 0.0
	%5 = call %type.string @".conv:float_string"(float %4)
	call void @.println(%type.string %5)
	%6 = fdiv float -1.0, 0.0
	%7 = call %type.string @".conv:float_string"(float %6)
	call void @.println(%type.string %7)
	%8 = call %type.string @".conv:float_string"(float 0x419D6BFEE0000000)
	call void @.println(%type.string %8)
	%9 = call %type.string @".conv:float_string"(float 0xBEFDC62B20000000)
	call void @.println(%type.string %9)
	%10 = call %type.string @".conv:float_string"(float 0x40503379A0000000)
	call void @.println(%type.string %10)
	br label %exit

exit:
	ret void
}

declare void @.println(%type.string %0)

declare %type.string @".conv:float_string"(float %0)

source_filename = "lib/builtin/autofree/free_string.ll"

%type.string = type { i32, i32* }

define void @"free:string"(%type.string %str) {
entry:
    %ptr.str = alloca %type.string, align 8
    
}
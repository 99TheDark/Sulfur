source_filename = "lib/builtin/copy/string_copy"

%type.string = type { i32, i32, i8* }

define %type.string ".copy:string"(%type.string %str) {
    
}
package errors

type CompileStep string

const (
	Compiling  CompileStep = "compiling"
	Lexing     CompileStep = "lexing"
	Parsing    CompileStep = "parsing"
	Inferring  CompileStep = "inferring"
	Generating CompileStep = "generating"
)

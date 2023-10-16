package errors

type CompileStep string

const (
	Compiling  CompileStep = "compiling"
	Parsing    CompileStep = "parsing"
	Inferring  CompileStep = "inferring"
	Generating CompileStep = "generating"
)

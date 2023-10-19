package errors

type CompileStep string

const (
	Compiling    CompileStep = "compiling"
	Lexing       CompileStep = "lexing"
	Parsing      CompileStep = "parsing"
	Inferring    CompileStep = "inferring"
	FlowAnalysis CompileStep = "flow analysis"
	Optimizing   CompileStep = "optimizing"
	Generating   CompileStep = "generating"
)

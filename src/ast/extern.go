package ast

type (
	FuncSignature struct {
		Name   string
		Return string
		Params []ParamSignature
	}

	ParamSignature struct {
		Type    string
		Name    string
		Autodef bool
	}
)

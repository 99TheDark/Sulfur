package builtins

import (
	"sulfur/src/lexer"
	"sulfur/src/typing"
)

type (
	FuncSignature struct {
		Name   string
		Return typing.Type
		Params []ParamSignature
	}

	ParamSignature struct {
		Type    typing.Type
		Autodef bool
	}

	BinaryOpSignature struct {
		Left   typing.Type
		Right  typing.Type
		Op     lexer.TokenType
		Return typing.Type
	}

	TypeConvSignature struct {
		From typing.Type
		To   typing.Type
	}
)

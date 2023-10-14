package builtins

import (
	"sulfur/src/lexer"
	"sulfur/src/typing"

	"github.com/llir/llvm/ir"
)

type (
	FuncSignature struct {
		Name   string
		Return typing.Type
		Params []ParamSignature
		Module string
		Ir     *ir.Func
	}

	ParamSignature struct {
		Type    typing.Type
		Autodef bool
		Ir      *ir.Param
	}

	BinaryOpSignature struct {
		Left    typing.Type
		Right   typing.Type
		Op      lexer.TokenType
		Return  typing.Type
		Module  string
		Ir      *ir.Func
		Complex bool
	}

	UnaryOpSignature struct {
		Value   typing.Type
		Op      lexer.TokenType
		Return  typing.Type
		Module  string
		Ir      *ir.Func
		Complex bool
	}

	IncDecSignature struct {
		Var     typing.Type
		Op      lexer.TokenType
		Module  string
		Ir      *ir.Func
		Complex bool
	}

	ComparisonSignature struct {
		Left    typing.Type
		Right   typing.Type
		Comp    lexer.TokenType
		Module  string
		Ir      *ir.Func
		Complex bool
	}

	TypeConvSignature struct {
		From    typing.Type
		To      typing.Type
		Module  string
		Ir      *ir.Func
		Complex bool
	}
)

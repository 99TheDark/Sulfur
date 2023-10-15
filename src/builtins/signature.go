package builtins

import (
	"sulfur/src/lexer"
	"sulfur/src/typing"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/types"
)

type (
	FuncSignature struct {
		Name   string
		Return typing.Type
		Params []ParamSignature
		Module string
		Ir     *ir.Func
		Uses   int
	}

	ParamSignature struct {
		Type    typing.Type
		Autodef bool
		Ir      *ir.Param
	}

	ClassSignature struct {
		Name   string
		Fields []FieldSignature
		Ir     types.Type
	}

	FieldSignature struct {
		Visibility typing.Visibility
		Type       typing.Type
		Name       string
	}

	BinaryOpSignature struct {
		Left    typing.Type
		Right   typing.Type
		Op      lexer.TokenType
		Return  typing.Type
		Module  string
		Ir      *ir.Func
		Uses    int
		Complex bool
	}

	UnaryOpSignature struct {
		Value   typing.Type
		Op      lexer.TokenType
		Return  typing.Type
		Module  string
		Ir      *ir.Func
		Uses    int
		Complex bool
	}

	IncDecSignature struct {
		Var     typing.Type
		Op      lexer.TokenType
		Module  string
		Ir      *ir.Func
		Uses    int
		Complex bool
	}

	ComparisonSignature struct {
		Left    typing.Type
		Right   typing.Type
		Comp    lexer.TokenType
		Module  string
		Ir      *ir.Func
		Uses    int
		Complex bool
	}

	TypeConvSignature struct {
		From    typing.Type
		To      typing.Type
		Module  string
		Ir      *ir.Func
		Uses    int
		Complex bool
	}
)

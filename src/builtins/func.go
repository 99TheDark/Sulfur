package builtins

import (
	"sulfur/src/lexer"
	"sulfur/src/typing"
)

var Funcs = []FuncSignature{
	QuickFunc("print", typing.VoidType, typing.StringType),
	QuickFunc("println", typing.VoidType, typing.StringType),
}

func QuickFunc(name string, ret string, params ...string) FuncSignature {
	paramArr := []ParamSignature{}
	for _, param := range params {
		paramArr = append(paramArr, ParamSignature{typing.Type(param), false})
	}

	return FuncSignature{
		name,
		typing.Type(ret),
		paramArr,
	}
}

func QuickBinOp(left string, right string, op lexer.TokenType, ret string) BinaryOpSignature {
	return BinaryOpSignature{
		typing.Type(left),
		typing.Type(right),
		op,
		typing.Type(ret),
	}
}

func QuickUnOp(value string, op lexer.TokenType, ret string) UnaryOpSignature {
	return UnaryOpSignature{
		typing.Type(value),
		op,
		typing.Type(ret),
	}
}

package builtins

import (
	"sulfur/src/lexer"
	"sulfur/src/typing"
)

func QuickFunc(name string, ret typing.Type, params ...typing.Type) FuncSignature {
	return QuickModFunc("", name, ret, params...)
}

func QuickParam(typ typing.Type) ParamSignature {
	return ParamSignature{
		typ,
		false,
		nil,
	}
}

func QuickBinOp(left, right typing.Type, op lexer.TokenType) BinaryOpSignature {
	return QuickModBinOp("", left, right, op)
}

func QuickUnOp(val typing.Type, op lexer.TokenType) UnaryOpSignature {
	return QuickModUnOp("", val, op)
}

func QuickIncDec(vari typing.Type, op lexer.TokenType) IncDecSignature {
	return QuickModIncDec("", vari, op)
}

func QuickComp(typ typing.Type, comp lexer.TokenType) ComparisonSignature {
	return QuickModComp("", typ, comp)
}

func QuickTypeConv(from, to typing.Type) TypeConvSignature {
	return QuickModTypeConv("", from, to)
}

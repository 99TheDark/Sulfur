package builtins

import (
	"sulfur/src/lexer"
	"sulfur/src/typing"
)

func QuickFunc(name string, ret typing.Type, params ...typing.Type) FuncSignature {
	paramArr := []ParamSignature{}
	for _, param := range params {
		paramArr = append(paramArr, ParamSignature{param, false})
	}

	return FuncSignature{
		name,
		ret,
		paramArr,
	}
}

func QuickBinOp(left, right typing.Type, op lexer.TokenType) BinaryOpSignature {
	return BinaryOpSignature{
		left,
		right,
		op,
		left,
	}
}

func QuickUnOp(val typing.Type, op lexer.TokenType) UnaryOpSignature {
	return UnaryOpSignature{
		val,
		op,
		val,
	}
}

func QuickComp(typ typing.Type, comp lexer.TokenType) ComparisonSignature {
	return ComparisonSignature{
		typ,
		typ,
		comp,
	}
}

func QuickTypeConv(from, to typing.Type) TypeConvSignature {
	return TypeConvSignature{
		from,
		to,
	}
}

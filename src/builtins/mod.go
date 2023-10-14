package builtins

import (
	"sulfur/src/lexer"
	"sulfur/src/typing"
)

func QuickModFunc(mod string, name string, ret typing.Type, params ...typing.Type) FuncSignature {
	paramArr := []ParamSignature{}
	for _, param := range params {
		paramArr = append(paramArr, QuickParam(param, false))
	}

	return FuncSignature{
		name,
		ret,
		paramArr,
		mod,
		nil,
	}
}

func QuickModBinOp(mod string, left, right typing.Type, op lexer.TokenType) BinaryOpSignature {
	return BinaryOpSignature{
		left,
		right,
		op,
		left,
		mod,
		nil,
		false,
	}
}

func QuickModUnOp(mod string, val typing.Type, op lexer.TokenType) UnaryOpSignature {
	return UnaryOpSignature{
		val,
		op,
		val,
		mod,
		nil,
		false,
	}
}

func QuickModIncDec(mod string, vari typing.Type, op lexer.TokenType) IncDecSignature {
	return IncDecSignature{
		vari,
		op,
		mod,
		nil,
		false,
	}
}

func QuickModComp(mod string, typ typing.Type, comp lexer.TokenType) ComparisonSignature {
	return ComparisonSignature{
		typ,
		typ,
		comp,
		mod,
		nil,
		false,
	}
}

func QuickModTypeConv(mod string, from, to typing.Type) TypeConvSignature {
	return TypeConvSignature{
		from,
		to,
		mod,
		nil,
		false,
	}
}

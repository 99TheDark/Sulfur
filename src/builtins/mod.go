package builtins

import (
	"sulfur/src/lexer"
	"sulfur/src/typing"
)

func QuickModFunc(mod string, name string, ret typing.Type, params ...ParamSignature) FuncSignature {
	return FuncSignature{
		name,
		ret,
		params,
		mod,
		nil,
		0,
	}
}

func QuickModParam(typ typing.Type, ref bool) ParamSignature {
	return ParamSignature{
		typ,
		ref,
		nil,
	}
}

func QuickModClass(mod string, name string, fields []FieldSignature) ClassSignature {
	return ClassSignature{
		name,
		fields,
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
		0,
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
		0,
		false,
	}
}

func QuickModIncDec(mod string, vari typing.Type, op lexer.TokenType) IncDecSignature {
	return IncDecSignature{
		vari,
		op,
		mod,
		nil,
		0,
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
		0,
		false,
	}
}

func QuickModTypeConv(mod string, from, to typing.Type) TypeConvSignature {
	return TypeConvSignature{
		from,
		to,
		mod,
		nil,
		0,
		false,
	}
}

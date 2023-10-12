package builtins

import (
	"sulfur/src/lexer"
	"sulfur/src/typing"
)

var Funcs = []FuncSignature{
	QuickFunc("print", typing.Void, typing.String),
	QuickFunc("println", typing.Void, typing.String),
}

var BinaryOps = []BinaryOpSignature{
	QuickBinOp("string", "string", lexer.Addition, "string"),
}

var TypeConvs = []TypeConvSignature{
	QuickTypeConv("int", "string"),
	QuickTypeConv("bool", "string"),
	QuickTypeConv("int", "float"),
	QuickTypeConv("int", "bool"),
	QuickTypeConv("float", "int"),
	QuickTypeConv("float", "bool"),
	QuickTypeConv("bool", "int"),
	QuickTypeConv("bool", "float"),
}

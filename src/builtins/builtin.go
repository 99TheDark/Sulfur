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
	// int
	QuickBinOp("int", "int", lexer.Addition),
	QuickBinOp("int", "int", lexer.Subtraction),
	QuickBinOp("int", "int", lexer.Multiplication),
	QuickBinOp("int", "int", lexer.Division),
	QuickBinOp("int", "int", lexer.Modulus),
	QuickBinOp("int", "int", lexer.Or),
	QuickBinOp("int", "int", lexer.And),
	QuickBinOp("int", "int", lexer.Nor),
	QuickBinOp("int", "int", lexer.Nand),

	// float
	QuickBinOp("float", "float", lexer.Addition),
	QuickBinOp("float", "float", lexer.Subtraction),
	QuickBinOp("float", "float", lexer.Multiplication),
	QuickBinOp("float", "float", lexer.Division),
	QuickBinOp("float", "float", lexer.Modulus),

	// bool
	QuickBinOp("bool", "bool", lexer.Or),
	QuickBinOp("bool", "bool", lexer.And),
	QuickBinOp("bool", "bool", lexer.Nor),
	QuickBinOp("bool", "bool", lexer.Nand),

	// string
	QuickBinOp("string", "string", lexer.Addition),
}

var UnaryOps = []UnaryOpSignature{
	// int
	QuickUnOp("int", lexer.Subtraction),
	QuickUnOp("int", lexer.Not),

	// float
	QuickUnOp("float", lexer.Subtraction),

	// bool
	QuickUnOp("bool", lexer.Not),
}

var Comps = []ComparisonSignature{
	// int
	QuickComp("int", lexer.EqualTo),
	QuickComp("int", lexer.NotEqualTo),
	QuickComp("int", lexer.GreaterThan),
	QuickComp("int", lexer.LessThan),
	QuickComp("int", lexer.GreaterThanOrEqualTo),
	QuickComp("int", lexer.LessThanOrEqualTo),

	// int
	QuickComp("float", lexer.EqualTo),
	QuickComp("float", lexer.NotEqualTo),
	QuickComp("float", lexer.GreaterThan),
	QuickComp("float", lexer.LessThan),
	QuickComp("float", lexer.GreaterThanOrEqualTo),
	QuickComp("float", lexer.LessThanOrEqualTo),

	// bool
	QuickComp("bool", lexer.EqualTo),
	QuickComp("bool", lexer.NotEqualTo),
}

var TypeConvs = []TypeConvSignature{
	// int
	QuickTypeConv("int", "string"),
	QuickTypeConv("int", "float"),
	QuickTypeConv("int", "bool"),

	// float
	QuickTypeConv("float", "int"),
	QuickTypeConv("float", "bool"),

	// bool
	QuickTypeConv("bool", "int"),
	QuickTypeConv("bool", "float"),
	QuickTypeConv("bool", "string"),
}

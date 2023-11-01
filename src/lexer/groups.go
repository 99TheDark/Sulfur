package lexer

var BinaryOperator = []TokenType{
	Addition,
	Subtraction,
	Multiplication,
	Division,
	Exponentiation,
	Modulus,
	Or,
	And,
	Nor,
	Nand,
	RightShift,
	LeftShift,
	ZeroFillRightShift,
	Nullish,
}

var UnaryOperator = []TokenType{
	Subtraction,
	Not,
	CountLeadingZeros,
	CountTrailingZeros,
}

var Comparator = []TokenType{
	EqualTo,
	NotEqualTo,
	GreaterThan,
	LessThan,
	GreaterThanOrEqualTo,
	LessThanOrEqualTo,
	Is,
}

var Logical = []TokenType{
	And,
	Or,
	Nand,
	Nor,
	Is,
}

var Additive = []TokenType{
	Addition,
	Subtraction,
}

var Multiplicative = []TokenType{
	Multiplication,
	Division,
	Modulus,
}

var Exponential = []TokenType{
	Exponentiation,
}

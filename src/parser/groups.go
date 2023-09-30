package parser

import "sulfur/src/lexer"

var BinaryOperator = []lexer.TokenType{
	lexer.Addition,
	lexer.Subtraction,
	lexer.Multiplication,
	lexer.Division,
	lexer.Exponentiation,
	lexer.Modulus,
	lexer.Or,
	lexer.And,
	lexer.Nor,
	lexer.Nand,
}

var UnaryOperator = []lexer.TokenType{
	lexer.Subtraction,
	lexer.Increment,
	lexer.Decrement,
	lexer.Not,
}

var Comparator = []lexer.TokenType{
	lexer.EqualTo,
	lexer.NotEqualTo,
	lexer.GreaterThan,
	lexer.LessThan,
	lexer.GreaterThanOrEqualTo,
	lexer.LessThanOrEqualTo,
}

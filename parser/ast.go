package parser

import "golang/lexer"

type ExpressionValue = BinaryOperation

type Expression interface {
	Children() []Expression
	Location() *lexer.Location
}

type BinaryOperation struct {
	Left     Expression
	Right    Expression
	Operator lexer.Operation
}

package parser

import (
	"golang/lexer"
)

type Expression interface {
	Children() []Expression
	Location() *lexer.Location
}

type (
	Program struct {
		Body []Expression
	}

	Identifier struct {
		Start  *lexer.Location
		Symbol string
	}

	BinaryOperation struct {
		Left     Expression
		Right    Expression
		Operator lexer.Operation
	}
)

func (x Identifier) Children() []Expression      { return nil }
func (x BinaryOperation) Children() []Expression { return []Expression{x.Left, x.Right} }

func (x Identifier) Location() *lexer.Location      { return x.Start }
func (x BinaryOperation) Location() *lexer.Location { return x.Left.Location() }

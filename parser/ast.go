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
		Loc    *lexer.Location `json:"-"`
		Symbol string
	}

	BinaryOperation struct {
		Loc      *lexer.Location `json:"-"`
		Left     Expression
		Right    Expression
		Operator lexer.Operation
	}
)

func (x Identifier) Children() []Expression      { return nil }
func (x BinaryOperation) Children() []Expression { return []Expression{x.Left, x.Right} }

func (x Identifier) Location() *lexer.Location      { return x.Loc }
func (x BinaryOperation) Location() *lexer.Location { return x.Loc }

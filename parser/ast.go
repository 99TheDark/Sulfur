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

	Block struct {
		Loc  *lexer.Location `json:"-"`
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

func (x Block) Children() []Expression           { return x.Body }
func (x Identifier) Children() []Expression      { return nil }
func (x BinaryOperation) Children() []Expression { return []Expression{x.Left, x.Right} }

func (x Block) Location() *lexer.Location           { return x.Loc }
func (x Identifier) Location() *lexer.Location      { return x.Loc }
func (x BinaryOperation) Location() *lexer.Location { return x.Loc }

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

	Datatype struct {
		Type     Identifier
		Variable Identifier
	}

	List struct {
		Values []Expression
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
func (x Datatype) Children() []Expression        { return []Expression{x.Type, x.Variable} }
func (x List) Children() []Expression            { return x.Values }
func (x BinaryOperation) Children() []Expression { return []Expression{x.Left, x.Right} }

func (x Block) Location() *lexer.Location           { return x.Loc }
func (x Identifier) Location() *lexer.Location      { return x.Loc }
func (x Datatype) Location() *lexer.Location        { return x.Type.Loc }
func (x List) Location() *lexer.Location            { return x.Values[0].Location() } // Length always >= 2
func (x BinaryOperation) Location() *lexer.Location { return x.Loc }

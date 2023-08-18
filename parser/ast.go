package parser

import (
	"golang/lexer"
)

type Expression interface {
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

	FunctionLiteral struct {
		Name   Identifier
		Params List
		Body   []Expression
	}

	FunctionCall struct {
		Name   Identifier
		Params List
	}
)

func (x Block) Location() *lexer.Location           { return x.Loc }
func (x Identifier) Location() *lexer.Location      { return x.Loc }
func (x Datatype) Location() *lexer.Location        { return x.Type.Loc }
func (x List) Location() *lexer.Location            { return x.Values[0].Location() } // Length always >= 2
func (x BinaryOperation) Location() *lexer.Location { return x.Loc }
func (x FunctionLiteral) Location() *lexer.Location { return x.Name.Loc }
func (x FunctionCall) Location() *lexer.Location    { return x.Name.Loc }

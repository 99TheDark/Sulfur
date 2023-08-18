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

	Comparison struct {
		Loc        *lexer.Location `json:"-"`
		Left       Expression
		Right      Expression
		Comparator lexer.Comparison
	}

	FunctionLiteral struct {
		Name   Identifier
		Params List
		Return List
		Body   []Expression
	}

	FunctionCall struct {
		Name   Identifier
		Params List
	}

	Return struct {
		Value Expression
	}

	IfStatement struct {
		Loc       *lexer.Location `json:"-"`
		Condition Expression
		Then      Block
		Else      Block
	}
)

func (x Program) Children() []Expression         { return x.Body }
func (x Block) Children() []Expression           { return x.Body }
func (x Identifier) Children() []Expression      { return nil }
func (x Datatype) Children() []Expression        { return nil }
func (x List) Children() []Expression            { return x.Values }
func (x BinaryOperation) Children() []Expression { return []Expression{x.Left, x.Right} }
func (x Comparison) Children() []Expression      { return []Expression{x.Left, x.Right} }
func (x FunctionLiteral) Children() []Expression { return x.Body }
func (x FunctionCall) Children() []Expression    { return nil }
func (x Return) Children() []Expression          { return []Expression{x.Value} }
func (x IfStatement) Children() []Expression     { return []Expression{x.Then, x.Else} }

func (x Program) Location() *lexer.Location         { return lexer.NoLocation }
func (x Block) Location() *lexer.Location           { return x.Loc }
func (x Identifier) Location() *lexer.Location      { return x.Loc }
func (x Datatype) Location() *lexer.Location        { return x.Type.Loc }
func (x List) Location() *lexer.Location            { return x.Values[0].Location() } // Length always >= 2
func (x BinaryOperation) Location() *lexer.Location { return x.Loc }
func (x Comparison) Location() *lexer.Location      { return x.Loc }
func (x FunctionLiteral) Location() *lexer.Location { return x.Name.Loc }
func (x FunctionCall) Location() *lexer.Location    { return x.Name.Loc }
func (x Return) Location() *lexer.Location          { return x.Value.Location() }
func (x IfStatement) Location() *lexer.Location     { return x.Loc }

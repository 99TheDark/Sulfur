package parser

import (
	. "golang/errors"
	"golang/lexer"
	"golang/typing"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/value"
)

type Expression interface {
	Children() []Expression
	Location() *lexer.Location
	InferType() string
	GetType() *Type
	Generate(mod *ir.Module, bl *ir.Block) value.Value
}

type (
	Program struct {
		Functions     *[]*FunctionLiteral           `json:"-"`
		LLVMFunctions map[*FunctionLiteral]*ir.Func `json:"-"`
		Strings       *[]*StringLiteral             `json:"-"`
		Contents      Block
	}

	Block struct {
		Loc   *lexer.Location `json:"-"`
		Body  []Expression
		Scope typing.Scope `json:"-"`
	}

	Identifier struct {
		Loc    *lexer.Location `json:"-"`
		Parent *typing.Scope   `json:"-"`
		Symbol string
		Type   *Type `json:",omitempty"`
	}

	Datatype struct {
		Datatype Identifier
		Variable Identifier
		Type     *Type `json:",omitempty"`
	}

	Declaration struct {
		Datatype Identifier
		Variable Identifier
		Value    Expression
		Type     *Type `json:",omitempty"`
	}

	ImplicitDeclaration struct {
		Variable Identifier
		Value    Expression
		Type     *Type `json:",omitempty"`
	}

	Assignment struct {
		Variable Identifier
		Value    Expression
		Operator lexer.Operation
		Type     *Type `json:",omitempty"`
	}

	List struct {
		Values []Expression
	}

	BinaryOperation struct {
		Loc      *lexer.Location `json:"-"`
		Left     Expression
		Right    Expression
		Operator lexer.Operation
		Type     *Type `json:",omitempty"`
	}

	Comparison struct {
		Loc        *lexer.Location `json:"-"`
		Left       Expression
		Right      Expression
		Comparator lexer.Comparison
		Type       *Type `json:",omitempty"`
	}

	FunctionLiteral struct {
		Locator  *Program `json:"-"`
		Name     Identifier
		Params   List
		Return   List
		Contents Block
		Type     *Type `json:",omitempty"`
	}

	FunctionCall struct {
		Locator *Program `json:"-"`
		Name    Identifier
		Params  List
		Type    *Type `json:",omitempty"`
	}

	IntegerLiteral struct {
		Loc   *lexer.Location `json:"-"`
		Value int64
		Type  *Type `json:",omitempty"`
	}

	FloatLiteral struct {
		Loc   *lexer.Location `json:"-"`
		Value float64
		Type  *Type `json:",omitempty"`
	}

	BoolLiteral struct {
		Loc   *lexer.Location `json:"-"`
		Value bool
		Type  *Type `json:",omitempty"`
	}

	StringLiteral struct {
		Locator *Program        `json:"-"`
		Loc     *lexer.Location `json:"-"`
		Value   string
		Type    *Type `json:",omitempty"`
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

// Children
func (x Program) Children() []Expression             { return x.Contents.Body }
func (x Block) Children() []Expression               { return x.Body }
func (x Identifier) Children() []Expression          { return nil }
func (x Datatype) Children() []Expression            { return nil }
func (x Declaration) Children() []Expression         { return []Expression{x.Datatype, x.Variable, x.Value} }
func (x ImplicitDeclaration) Children() []Expression { return []Expression{x.Variable, x.Value} }
func (x Assignment) Children() []Expression          { return []Expression{x.Variable, x.Value} }
func (x List) Children() []Expression                { return x.Values }
func (x BinaryOperation) Children() []Expression     { return []Expression{x.Left, x.Right} }
func (x Comparison) Children() []Expression          { return []Expression{x.Left, x.Right} }
func (x FunctionLiteral) Children() []Expression     { return []Expression{x.Params, x.Contents} }
func (x FunctionCall) Children() []Expression        { return []Expression{x.Name, x.Params} }
func (x IntegerLiteral) Children() []Expression      { return nil }
func (x FloatLiteral) Children() []Expression        { return nil }
func (x BoolLiteral) Children() []Expression         { return nil }
func (x StringLiteral) Children() []Expression       { return nil }
func (x Return) Children() []Expression              { return []Expression{x.Value} }
func (x IfStatement) Children() []Expression         { return []Expression{x.Then, x.Else} }

// Location
func (x Program) Location() *lexer.Location             { return lexer.NoLocation }
func (x Block) Location() *lexer.Location               { return x.Loc }
func (x Identifier) Location() *lexer.Location          { return x.Loc }
func (x Datatype) Location() *lexer.Location            { return x.Datatype.Loc }
func (x Declaration) Location() *lexer.Location         { return x.Datatype.Loc }
func (x ImplicitDeclaration) Location() *lexer.Location { return x.Variable.Loc }
func (x Assignment) Location() *lexer.Location          { return x.Variable.Loc }
func (x List) Location() *lexer.Location                { return x.Values[0].Location() } // Length always >= 2
func (x BinaryOperation) Location() *lexer.Location     { return x.Loc }
func (x Comparison) Location() *lexer.Location          { return x.Loc }
func (x FunctionLiteral) Location() *lexer.Location     { return x.Name.Loc }
func (x FunctionCall) Location() *lexer.Location        { return x.Name.Loc }
func (x IntegerLiteral) Location() *lexer.Location      { return x.Loc }
func (x FloatLiteral) Location() *lexer.Location        { return x.Loc }
func (x BoolLiteral) Location() *lexer.Location         { return x.Loc }
func (x StringLiteral) Location() *lexer.Location       { return x.Loc }
func (x Return) Location() *lexer.Location              { return x.Value.Location() }
func (x IfStatement) Location() *lexer.Location         { return x.Loc }

// Get Type
func (x Program) GetType() *Type             { return nil }
func (x Block) GetType() *Type               { return nil }
func (x Identifier) GetType() *Type          { return x.Type }
func (x Datatype) GetType() *Type            { return x.Type }
func (x Declaration) GetType() *Type         { return nil }
func (x ImplicitDeclaration) GetType() *Type { return nil }
func (x Assignment) GetType() *Type          { return nil }
func (x List) GetType() *Type                { return nil }
func (x BinaryOperation) GetType() *Type     { return x.Type }
func (x Comparison) GetType() *Type          { return x.Type }
func (x FunctionLiteral) GetType() *Type     { return x.Type }
func (x FunctionCall) GetType() *Type        { return x.Type }
func (x IntegerLiteral) GetType() *Type      { return x.Type }
func (x FloatLiteral) GetType() *Type        { return x.Type }
func (x BoolLiteral) GetType() *Type         { return x.Type }
func (x StringLiteral) GetType() *Type       { return x.Type }
func (x Return) GetType() *Type              { return nil }
func (x IfStatement) GetType() *Type         { return nil }

// Misc
func create(caller Identifier, name string, variable typing.Variable) {
	if _, exists := caller.Parent.Vars[name]; exists {
		Errors.Error("'"+name+"' is already defined", caller.Loc)
	} else {
		caller.Parent.Vars[name] = variable
	}
}

func get(caller Identifier, scope *typing.Scope, name string) *typing.Variable {
	if scope == nil {
		Errors.Error("'"+name+"' is undefined", caller.Loc)
		return nil
	} else if val, exists := scope.Vars[name]; exists {
		return &val
	} else {
		return get(caller, scope.Parent, name)
	}
}

func isLiteral(expr Expression) bool {
	switch expr.(type) {
	case IntegerLiteral, FloatLiteral, BoolLiteral, StringLiteral, FunctionLiteral:
		return true
	default:
		return false
	}
}

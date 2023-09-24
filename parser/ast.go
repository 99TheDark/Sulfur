package parser

import (
	. "sulfur/errors"
	"sulfur/lexer"
	"sulfur/typing"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/value"
)

type Type struct {
	Name       string
	Underlying typing.UnderlyingType
}

func NoType() *Type {
	return &Type{"", typing.Void}
}

func BloatType(ut typing.UnderlyingType) Type {
	return Type{string(ut), ut}
}

type Statement interface {
	Children() []Statement
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

	BadStatement struct{}

	Block struct {
		Loc   *lexer.Location `json:"-"`
		Body  []Statement
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
		Loc      *lexer.Location `json:"-"`
		Datatype Identifier
		Variable Identifier
		Value    Statement
		Type     *Type `json:",omitempty"`
	}

	ImplicitDeclaration struct {
		Loc      *lexer.Location `json:"-"`
		Variable Identifier
		Value    Statement
		Type     *Type `json:",omitempty"`
	}

	Assignment struct {
		Variable Identifier
		Value    Statement
		Operator lexer.TokenType
		Type     *Type `json:",omitempty"`
	}

	List struct {
		Values []Statement
	}

	BinaryOperation struct {
		Loc      *lexer.Location `json:"-"`
		Left     Statement
		Right    Statement
		Operator lexer.TokenType
		Type     *Type `json:",omitempty"`
	}

	Comparison struct {
		Loc        *lexer.Location `json:"-"`
		Left       Statement
		Right      Statement
		Comparator lexer.TokenType
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

	BooleanLiteral struct {
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
		Value Statement
	}

	IfStatement struct {
		Loc  *lexer.Location `json:"-"`
		Cond Statement
		Then Block
		Else Block
	}

	ForLoop struct {
		Loc    *lexer.Location `json:"-"`
		Init   Statement
		Cond   Statement
		Update Statement
		Body   Block
	}

	WhileLoop struct {
		Loc  *lexer.Location `json:"-"`
		Cond Statement
		Body Block
	}
)

// Children
func (x Program) Children() []Statement             { return x.Contents.Body }
func (x BadStatement) Children() []Statement        { return nil }
func (x Block) Children() []Statement               { return x.Body }
func (x Identifier) Children() []Statement          { return nil }
func (x Datatype) Children() []Statement            { return nil }
func (x Declaration) Children() []Statement         { return []Statement{x.Datatype, x.Variable, x.Value} }
func (x ImplicitDeclaration) Children() []Statement { return []Statement{x.Variable, x.Value} }
func (x Assignment) Children() []Statement          { return []Statement{x.Variable, x.Value} }
func (x List) Children() []Statement                { return x.Values }
func (x BinaryOperation) Children() []Statement     { return []Statement{x.Left, x.Right} }
func (x Comparison) Children() []Statement          { return []Statement{x.Left, x.Right} }
func (x FunctionLiteral) Children() []Statement     { return []Statement{x.Params, x.Contents} }
func (x FunctionCall) Children() []Statement        { return []Statement{x.Name, x.Params} }
func (x IntegerLiteral) Children() []Statement      { return nil }
func (x FloatLiteral) Children() []Statement        { return nil }
func (x BooleanLiteral) Children() []Statement      { return nil }
func (x StringLiteral) Children() []Statement       { return nil }
func (x Return) Children() []Statement              { return []Statement{x.Value} }
func (x IfStatement) Children() []Statement         { return []Statement{x.Then, x.Else} }
func (x ForLoop) Children() []Statement             { return []Statement{x.Init, x.Cond, x.Update, x.Body} }
func (x WhileLoop) Children() []Statement           { return []Statement{x.Cond, x.Body} }

// Location
func (x Program) Location() *lexer.Location             { return lexer.NoLocation }
func (x BadStatement) Location() *lexer.Location        { return lexer.NoLocation }
func (x Block) Location() *lexer.Location               { return x.Loc }
func (x Identifier) Location() *lexer.Location          { return x.Loc }
func (x Datatype) Location() *lexer.Location            { return x.Datatype.Loc }
func (x Declaration) Location() *lexer.Location         { return x.Loc }
func (x ImplicitDeclaration) Location() *lexer.Location { return x.Loc }
func (x Assignment) Location() *lexer.Location          { return x.Variable.Loc }
func (x List) Location() *lexer.Location                { return x.Values[0].Location() } // Length always >= 2
func (x BinaryOperation) Location() *lexer.Location     { return x.Loc }
func (x Comparison) Location() *lexer.Location          { return x.Loc }
func (x FunctionLiteral) Location() *lexer.Location     { return x.Name.Loc }
func (x FunctionCall) Location() *lexer.Location        { return x.Name.Loc }
func (x IntegerLiteral) Location() *lexer.Location      { return x.Loc }
func (x FloatLiteral) Location() *lexer.Location        { return x.Loc }
func (x BooleanLiteral) Location() *lexer.Location      { return x.Loc }
func (x StringLiteral) Location() *lexer.Location       { return x.Loc }
func (x Return) Location() *lexer.Location              { return x.Value.Location() }
func (x IfStatement) Location() *lexer.Location         { return x.Loc }
func (x ForLoop) Location() *lexer.Location             { return x.Loc }
func (x WhileLoop) Location() *lexer.Location           { return x.Loc }

// Get Type
func (x Program) GetType() *Type             { return nil }
func (x BadStatement) GetType() *Type        { return nil }
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
func (x BooleanLiteral) GetType() *Type      { return x.Type }
func (x StringLiteral) GetType() *Type       { return x.Type }
func (x Return) GetType() *Type              { return nil }
func (x IfStatement) GetType() *Type         { return nil }
func (x ForLoop) GetType() *Type             { return nil }
func (x WhileLoop) GetType() *Type           { return nil }

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

func isLiteral(expr Statement) bool {
	switch expr.(type) {
	case IntegerLiteral, FloatLiteral, BooleanLiteral, StringLiteral, FunctionLiteral:
		return true
	default:
		return false
	}
}

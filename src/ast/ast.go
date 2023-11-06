package ast

import (
	"sulfur/src/builtins"
	"sulfur/src/lexer"
	"sulfur/src/typing"
	"sulfur/src/utils"
	"sulfur/src/visibility"
)

type Expr interface {
	Loc() *typing.Location
}

type (
	Program struct {
		// TODO: Create & replace strings with StringSignatures
		References  utils.Set[typing.Type]         `json:"-"`
		Functions   []builtins.FuncSignature       `json:"-"`
		BinaryOps   []builtins.BinaryOpSignature   `json:"-"`
		UnaryOps    []builtins.UnaryOpSignature    `json:"-"`
		Comparisons []builtins.ComparisonSignature `json:"-"`
		TypeConvs   []builtins.TypeConvSignature   `json:"-"`
		IncDecs     []builtins.IncDecSignature     `json:"-"`
		Classes     []builtins.ClassSignature      `json:"-"`
		Strings     []String                       `json:"-"`
		FuncScope   *FuncScope                     `json:"-"`
		Contents    Block
	}

	NoExpr struct {
		Pos *typing.Location `json:"-"`
	}

	Block struct {
		Pos   *typing.Location `json:"-"`
		Body  []Expr
		Scope *Scope `json:"-"`
	}

	Identifier struct {
		Pos  *typing.Location `json:"-"`
		Name string
	}

	Integer struct {
		Pos   *typing.Location `json:"-"`
		Value int64
	}

	UnsignedInteger struct {
		Pos   *typing.Location `json:"-"`
		Value uint64
	}

	Float struct {
		Pos   *typing.Location `json:"-"`
		Value float64
	}

	Boolean struct {
		Pos   *typing.Location `json:"-"`
		Value bool
	}

	String struct {
		Pos   *typing.Location `json:"-"`
		Value string
	}

	Array struct {
		Type  Identifier
		Items *[]Expr
	}

	Function struct {
		Pos       *typing.Location `json:"-"`
		Name      Identifier
		Params    []Param
		Return    Identifier
		FuncScope *FuncScope `json:"-"`
		Body      Block
	}

	Class struct {
		Pos         *typing.Location `json:"-"`
		Name        Identifier
		Extends     []Identifier `json:",omitempty"`
		Fields      []Field
		Constuctors []Method `json:",omitempty"`
		Destructors []Method `json:",omitempty"`
		Methods     []Method
		Conversions []To
		Operations  []Operation
	}

	Enum struct {
		Pos   *typing.Location `json:"-"`
		Name  Identifier
		From  Identifier `json:",omitempty"`
		Elems []Identifier
	}

	Param struct {
		Pos        *typing.Location `json:"-"`
		Type       Identifier
		Name       Identifier
		Referenced bool
	}

	Method struct {
		Function
		Status visibility.Visibility
	}

	Field struct {
		Pos    *typing.Location `json:"-"`
		Status visibility.Visibility
		Type   Identifier
		Name   Identifier
	}

	To struct {
		Pos  *typing.Location `json:"-"`
		Type Identifier
		Body Block
	}

	Operation struct {
		Pos    *typing.Location `json:"-"`
		Op     *lexer.Token
		Params []Param
		Return []Identifier
		Body   Block
	}

	Access struct {
		Parent Expr
		Access lexer.Token
		Child  Identifier
	}

	New struct {
		Pos    *typing.Location `json:"-"`
		Class  Identifier
		Params *[]Expr
	}

	BinaryOp struct {
		Left  Expr
		Right Expr
		Op    lexer.Token
	}

	UnaryOp struct {
		Value Expr
		Op    lexer.Token
	}

	Reference struct {
		Pos      *typing.Location `json:"-"`
		Variable Identifier
	}

	Pipe struct {
		Left  FuncCall
		Right FuncCall
	}

	Comparison struct {
		Left  Expr
		Right Expr
		Comp  lexer.Token
	}

	Property struct {
		Parent Expr
		Prop   Expr
	}

	Declaration struct {
		Pos        *typing.Location `json:"-"`
		Prefix     lexer.TokenType
		Name       Identifier
		Annotation Identifier
		Value      Expr
	}

	Assignment struct {
		Name  Identifier
		Value Expr
		Op    lexer.Token
	}

	IncDec struct {
		Name Identifier
		Op   lexer.Token
	}

	FuncCall struct {
		Func   Identifier
		Params *[]Expr
	}

	TypeConv struct {
		Type  Identifier
		Value Expr
	}

	IfStatement struct {
		Pos  *typing.Location `json:"-"`
		Cond Expr
		Body Block
		Else Block
	}

	ForLoop struct {
		Pos  *typing.Location `json:"-"`
		Init Expr
		Cond Expr
		Inc  Expr
		Body Block
	}

	WhileLoop struct {
		Pos  *typing.Location `json:"-"`
		Cond Expr
		Body Block
	}

	DoWhileLoop struct {
		Pos  *typing.Location `json:"-"`
		Body Block
		Cond Expr
	}

	Loop struct {
		Pos  *typing.Location `json:"-"`
		Body Block
	}

	Return struct {
		Pos   *typing.Location `json:"-"`
		Value Expr
	}

	Break struct {
		Pos *typing.Location `json:"-"`
	}

	Continue struct {
		Pos *typing.Location `json:"-"`
	}
)

func (x Program) Loc() *typing.Location         { return typing.NoLocation }
func (x NoExpr) Loc() *typing.Location          { return x.Pos }
func (x Block) Loc() *typing.Location           { return x.Pos }
func (x Identifier) Loc() *typing.Location      { return x.Pos }
func (x Integer) Loc() *typing.Location         { return x.Pos }
func (x UnsignedInteger) Loc() *typing.Location { return x.Pos }
func (x Float) Loc() *typing.Location           { return x.Pos }
func (x Boolean) Loc() *typing.Location         { return x.Pos }
func (x String) Loc() *typing.Location          { return x.Pos }
func (x Array) Loc() *typing.Location           { return x.Type.Loc() }
func (x Function) Loc() *typing.Location        { return x.Pos }
func (x Class) Loc() *typing.Location           { return x.Pos }
func (x Enum) Loc() *typing.Location            { return x.Pos }
func (x Param) Loc() *typing.Location           { return x.Pos }
func (x Method) Loc() *typing.Location          { return x.Pos }
func (x Field) Loc() *typing.Location           { return x.Pos }
func (x To) Loc() *typing.Location              { return x.Pos }
func (x Operation) Loc() *typing.Location       { return x.Pos }
func (x Access) Loc() *typing.Location          { return x.Parent.Loc() }
func (x New) Loc() *typing.Location             { return x.Pos }
func (x BinaryOp) Loc() *typing.Location        { return x.Left.Loc() }
func (x UnaryOp) Loc() *typing.Location         { return x.Value.Loc() }
func (x Reference) Loc() *typing.Location       { return x.Pos }
func (x Pipe) Loc() *typing.Location            { return x.Left.Func.Loc() }
func (x Comparison) Loc() *typing.Location      { return x.Left.Loc() }
func (x Declaration) Loc() *typing.Location     { return x.Pos }
func (x Assignment) Loc() *typing.Location      { return x.Name.Loc() }
func (x IncDec) Loc() *typing.Location          { return x.Name.Loc() }
func (x FuncCall) Loc() *typing.Location        { return x.Func.Loc() }
func (x TypeConv) Loc() *typing.Location        { return x.Type.Loc() }
func (x IfStatement) Loc() *typing.Location     { return x.Pos }
func (x ForLoop) Loc() *typing.Location         { return x.Pos }
func (x WhileLoop) Loc() *typing.Location       { return x.Pos }
func (x DoWhileLoop) Loc() *typing.Location     { return x.Pos }
func (x Loop) Loc() *typing.Location            { return x.Pos }
func (x Return) Loc() *typing.Location          { return x.Pos }
func (x Break) Loc() *typing.Location           { return x.Pos }
func (x Continue) Loc() *typing.Location        { return x.Pos }

func Valid(expr Expr) bool {
	if _, ok := expr.(*NoExpr); ok {
		return false
	}
	return true
}

func Empty(expr Expr) bool {
	if expr.Loc() == (*typing.Location)(nil) {
		return true
	}
	return false
}

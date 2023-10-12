package ast

import (
	"sulfur/src/builtins"
	"sulfur/src/lexer"
)

type Expr interface {
	Loc() *lexer.Location
}

type (
	Program struct {
		// TODO: Create & replace classes and strings with ClassSignatures and StringSignatures
		Functions   []builtins.FuncSignature       `json:"-"`
		BinaryOps   []builtins.BinaryOpSignature   `json:"-"`
		UnaryOps    []builtins.UnaryOpSignature    `json:"-"`
		Comparisons []builtins.ComparisonSignature `json:"-"`
		TypeConvs   []builtins.TypeConvSignature   `json:"-"`
		Classes     []Class                        `json:"-"`
		Strings     []String
		Contents    Block
	}

	BadExpr struct {
		Pos *lexer.Location `json:"-"`
	}

	Block struct {
		Pos   *lexer.Location `json:"-"`
		Body  []Expr
		Scope Scope // `json:"-"`
	}

	Identifier struct {
		Pos  *lexer.Location `json:"-"`
		Name string
	}

	Integer struct {
		Pos   *lexer.Location `json:"-"`
		Value int64
	}

	Float struct {
		Pos   *lexer.Location `json:"-"`
		Value float64
	}

	Boolean struct {
		Pos   *lexer.Location `json:"-"`
		Value bool
	}

	String struct {
		Pos   *lexer.Location `json:"-"`
		Value string
	}

	Array struct {
		Type  Identifier
		Items *[]Expr
	}

	Function struct {
		Pos    *lexer.Location `json:"-"`
		Name   Identifier
		Params []Param
		Return Identifier
		Body   Block
	}

	Class struct {
		Pos         *lexer.Location `json:"-"`
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
		Pos   *lexer.Location `json:"-"`
		Name  Identifier
		From  Identifier `json:",omitempty"`
		Elems []Identifier
	}

	Param struct {
		Type    Identifier
		Name    Identifier
		Autodef bool
	}

	Method struct {
		Function
		Status Visibility
	}

	Field struct {
		Pos    *lexer.Location `json:"-"`
		Status Visibility
		Type   Identifier
		Name   Identifier
	}

	To struct {
		Pos  *lexer.Location `json:"-"`
		Type Identifier
		Body Block
	}

	Operation struct {
		Pos    *lexer.Location `josn:"-"`
		Op     *lexer.Token
		Params []Param
		Return []Identifier
		Body   Block
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
		Type  Identifier
		Name  Identifier
		Value Expr
	}

	ImplicitDecl struct {
		Name  Identifier
		Value Expr
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
		Pos  *lexer.Location `json:"-"`
		Cond Expr
		Body Block
		Else Block
	}

	ForLoop struct {
		Pos  *lexer.Location `json:"-"`
		Init Expr
		Cond Expr
		Inc  Expr
		Body Block
	}

	WhileLoop struct {
		Pos  *lexer.Location `json:"-"`
		Cond Expr
		Body Block
	}

	DoWhileLoop struct {
		Pos  *lexer.Location `json:"-"`
		Body Block
		Cond Expr
	}

	Return struct {
		Pos   *lexer.Location `json:"-"`
		Value Expr
	}
)

func (x Program) Loc() *lexer.Location      { return lexer.NoLocation }
func (x BadExpr) Loc() *lexer.Location      { return x.Pos }
func (x Block) Loc() *lexer.Location        { return x.Pos }
func (x Identifier) Loc() *lexer.Location   { return x.Pos }
func (x Integer) Loc() *lexer.Location      { return x.Pos }
func (x Float) Loc() *lexer.Location        { return x.Pos }
func (x Boolean) Loc() *lexer.Location      { return x.Pos }
func (x String) Loc() *lexer.Location       { return x.Pos }
func (x Array) Loc() *lexer.Location        { return x.Type.Pos }
func (x Function) Loc() *lexer.Location     { return x.Pos }
func (x Class) Loc() *lexer.Location        { return x.Pos }
func (x Enum) Loc() *lexer.Location         { return x.Pos }
func (x Param) Loc() *lexer.Location        { return x.Type.Pos }
func (x Method) Loc() *lexer.Location       { return x.Pos }
func (x Field) Loc() *lexer.Location        { return x.Pos }
func (x To) Loc() *lexer.Location           { return x.Pos }
func (x Operation) Loc() *lexer.Location    { return x.Pos }
func (x BinaryOp) Loc() *lexer.Location     { return x.Left.Loc() }
func (x UnaryOp) Loc() *lexer.Location      { return x.Value.Loc() }
func (x Pipe) Loc() *lexer.Location         { return x.Left.Func.Pos }
func (x Comparison) Loc() *lexer.Location   { return x.Left.Loc() }
func (x Declaration) Loc() *lexer.Location  { return x.Type.Pos }
func (x ImplicitDecl) Loc() *lexer.Location { return x.Name.Pos }
func (x Assignment) Loc() *lexer.Location   { return x.Name.Pos }
func (x IncDec) Loc() *lexer.Location       { return x.Name.Pos }
func (x FuncCall) Loc() *lexer.Location     { return x.Func.Pos }
func (x TypeConv) Loc() *lexer.Location     { return x.Type.Pos }
func (x IfStatement) Loc() *lexer.Location  { return x.Pos }
func (x ForLoop) Loc() *lexer.Location      { return x.Pos }
func (x WhileLoop) Loc() *lexer.Location    { return x.Pos }
func (x DoWhileLoop) Loc() *lexer.Location  { return x.Pos }
func (x Return) Loc() *lexer.Location       { return x.Pos }

func Valid(expr Expr) bool {
	if _, ok := expr.(*BadExpr); ok {
		return false
	}
	return true
}

func Empty(expr Expr) bool {
	if expr.Loc() == (*lexer.Location)(nil) {
		return true
	}
	return false
}

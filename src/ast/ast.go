package ast

import (
	"sulfur/src/lexer"
)

type Expr interface {
	Loc() *lexer.Location
}

type (
	Program struct {
		Functions []*Function `json:"-"`
		Classes   []*Class    `json:"-"`
		Strings   []*String   `json:"-"`
		Scope     Scope       `json:"-"`
		Body      []Expr
	}

	BadExpr struct {
		Pos *lexer.Location `json:"-"`
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
		Items []Expr
	}

	Function struct {
		Pos    *lexer.Location `json:"-"`
		Name   string
		Return Identifier
		Params []Param
		Body   []Expr
		// Decls possibly
	}

	Class struct {
		Pos         *lexer.Location `json:"-"`
		Name        string
		Extends     []Identifier `json:",omitempty"`
		Fields      []Field
		Constuctor  Function `json:",omitempty"`
		Destructor  Function `json:",omitempty"`
		Methods     []Function
		Conversions []Function
	}

	Enum struct {
		Pos   *lexer.Location `json:"-"`
		Name  string
		From  Identifier `json:",omitempty"`
		Elems []string
	}

	Param struct {
		Type Identifier
		Name Identifier
	}

	Field struct {
		Read  bool
		Write bool
		Type  Identifier
		Name  Identifier
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
		Left  FunctionCall
		Right FunctionCall
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
		Op    *lexer.Token
	}

	IncDec struct {
		Name Identifier
		Op   lexer.Token
	}

	FunctionCall struct {
		Func   Identifier
		Params []Expr
	}

	TypeCast struct {
		Type  Identifier
		Value Expr
	}

	IfStatement struct {
		Pos  *lexer.Location `json:"-"`
		Cond Expr
		Body []Expr
		Else []Expr
	}

	ForLoop struct {
		Pos  *lexer.Location `json:"-"`
		Init Expr
		Cond Expr
		Inc  Expr
		Body []Expr
	}

	ForInLoop struct {
		Pos      *lexer.Location `json:"-"`
		Vals     []Expr
		Iterable Expr
		Body     []Expr
	}

	WhileLoop struct {
		Pos  *lexer.Location `json:"-"`
		Cond Expr
		Body []Expr
	}

	DoWhileLoop struct {
		Pos  *lexer.Location `json:"-"`
		Body []Expr
		Cond Expr
	}

	Return struct {
		Pos   *lexer.Location `json:"-"`
		Value Expr
	}
)

func (x Program) Loc() *lexer.Location      { return lexer.NoLocation }
func (x BadExpr) Loc() *lexer.Location      { return x.Pos }
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
func (x Field) Loc() *lexer.Location        { return x.Type.Pos }
func (x BinaryOp) Loc() *lexer.Location     { return x.Left.Loc() }
func (x UnaryOp) Loc() *lexer.Location      { return x.Value.Loc() }
func (x Pipe) Loc() *lexer.Location         { return x.Left.Func.Pos }
func (x Comparison) Loc() *lexer.Location   { return x.Left.Loc() }
func (x Declaration) Loc() *lexer.Location  { return x.Type.Pos }
func (x ImplicitDecl) Loc() *lexer.Location { return x.Name.Pos }
func (x Assignment) Loc() *lexer.Location   { return x.Name.Pos }
func (x IncDec) Loc() *lexer.Location       { return x.Name.Pos }
func (x FunctionCall) Loc() *lexer.Location { return x.Func.Pos }
func (x TypeCast) Loc() *lexer.Location     { return x.Type.Pos }
func (x IfStatement) Loc() *lexer.Location  { return x.Pos }
func (x ForLoop) Loc() *lexer.Location      { return x.Pos }
func (x ForInLoop) Loc() *lexer.Location    { return x.Pos }
func (x WhileLoop) Loc() *lexer.Location    { return x.Pos }
func (x DoWhileLoop) Loc() *lexer.Location  { return x.Pos }
func (x Return) Loc() *lexer.Location       { return x.Pos }

func Valid(expr Expr) bool {
	if _, ok := expr.(*BadExpr); ok {
		return false
	}
	return true
}

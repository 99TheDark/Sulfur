package ast

import (
	"sulfur/src/builtins"
	"sulfur/src/lexer"
	"sulfur/src/location"
	"sulfur/src/typing"
	"sulfur/src/utils"
)

type Expr interface {
	Loc() *location.Location
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
		Pos *location.Location `json:"-"`
	}

	Block struct {
		Pos   *location.Location `json:"-"`
		Body  []Expr
		Scope *Scope `json:"-"`
	}

	Identifier struct {
		Pos  *location.Location `json:"-"`
		Name string
	}

	Integer struct {
		Pos   *location.Location `json:"-"`
		Value int64
	}

	UnsignedInteger struct {
		Pos   *location.Location `json:"-"`
		Value uint64
	}

	Float struct {
		Pos   *location.Location `json:"-"`
		Value float64
	}

	Boolean struct {
		Pos   *location.Location `json:"-"`
		Value bool
	}

	String struct {
		Pos   *location.Location `json:"-"`
		Value string
	}

	Array struct {
		Type  Identifier
		Items *[]Expr
	}

	Function struct {
		Pos       *location.Location `json:"-"`
		Name      Identifier
		Params    []Param
		Return    Identifier
		FuncScope *FuncScope `json:"-"`
		Body      Block
	}

	Class struct {
		Pos  *location.Location `json:"-"`
		Name Identifier
	}

	Enum struct {
		Pos   *location.Location `json:"-"`
		Name  Identifier
		From  Identifier `json:",omitempty"`
		Elems []Identifier
	}

	Param struct {
		Pos        *location.Location `json:"-"`
		Type       Identifier
		Name       Identifier
		Referenced bool
	}

	Field struct {
		Visibility lexer.Token
		Type       Identifier
		Name       Identifier
	}

	Method struct {
		Visibility lexer.Token
		Name       Identifier
		Params     []Param
		Return     Identifier
		Body       Block
	}

	To struct {
		Pos  *location.Location `json:"-"`
		Type Identifier
		Body Block
	}

	Operation struct {
		Pos    *location.Location `json:"-"`
		Op     *lexer.Token
		Params []Param
		Return []Identifier
		Body   Block
	}

	Access struct {
		Pos    *location.Location `json:"-"`
		Parent Expr
		Access lexer.Token
		Child  Identifier
	}

	New struct {
		Pos    *location.Location `json:"-"`
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
		Pos      *location.Location `json:"-"`
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
		Pos        *location.Location `json:"-"`
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
		Pos  *location.Location `json:"-"`
		Cond Expr
		Body Block
		Else Block
	}

	ForLoop struct {
		Pos  *location.Location `json:"-"`
		Init Expr
		Cond Expr
		Inc  Expr
		Body Block
	}

	WhileLoop struct {
		Pos  *location.Location `json:"-"`
		Cond Expr
		Body Block
	}

	DoWhileLoop struct {
		Pos  *location.Location `json:"-"`
		Body Block
		Cond Expr
	}

	Loop struct {
		Pos  *location.Location `json:"-"`
		Body Block
	}

	Return struct {
		Pos   *location.Location `json:"-"`
		Value Expr
	}

	Break struct {
		Pos *location.Location `json:"-"`
	}

	Continue struct {
		Pos *location.Location `json:"-"`
	}
)

func (x Program) Loc() *location.Location         { return location.NoLocation }
func (x NoExpr) Loc() *location.Location          { return x.Pos }
func (x Block) Loc() *location.Location           { return x.Pos }
func (x Identifier) Loc() *location.Location      { return x.Pos }
func (x Integer) Loc() *location.Location         { return x.Pos }
func (x UnsignedInteger) Loc() *location.Location { return x.Pos }
func (x Float) Loc() *location.Location           { return x.Pos }
func (x Boolean) Loc() *location.Location         { return x.Pos }
func (x String) Loc() *location.Location          { return x.Pos }
func (x Array) Loc() *location.Location           { return x.Type.Loc() }
func (x Function) Loc() *location.Location        { return x.Pos }
func (x Class) Loc() *location.Location           { return x.Pos }
func (x Enum) Loc() *location.Location            { return x.Pos }
func (x Param) Loc() *location.Location           { return x.Pos }
func (x Field) Loc() *location.Location           { return x.Visibility.Location }
func (x Method) Loc() *location.Location          { return x.Visibility.Location }
func (x To) Loc() *location.Location              { return x.Pos }
func (x Operation) Loc() *location.Location       { return x.Pos }
func (x Access) Loc() *location.Location          { return x.Pos }
func (x New) Loc() *location.Location             { return x.Pos }
func (x BinaryOp) Loc() *location.Location        { return x.Left.Loc() }
func (x UnaryOp) Loc() *location.Location         { return x.Value.Loc() }
func (x Reference) Loc() *location.Location       { return x.Pos }
func (x Pipe) Loc() *location.Location            { return x.Left.Func.Loc() }
func (x Comparison) Loc() *location.Location      { return x.Left.Loc() }
func (x Declaration) Loc() *location.Location     { return x.Pos }
func (x Assignment) Loc() *location.Location      { return x.Name.Loc() }
func (x IncDec) Loc() *location.Location          { return x.Name.Loc() }
func (x FuncCall) Loc() *location.Location        { return x.Func.Loc() }
func (x TypeConv) Loc() *location.Location        { return x.Type.Loc() }
func (x IfStatement) Loc() *location.Location     { return x.Pos }
func (x ForLoop) Loc() *location.Location         { return x.Pos }
func (x WhileLoop) Loc() *location.Location       { return x.Pos }
func (x DoWhileLoop) Loc() *location.Location     { return x.Pos }
func (x Loop) Loc() *location.Location            { return x.Pos }
func (x Return) Loc() *location.Location          { return x.Pos }
func (x Break) Loc() *location.Location           { return x.Pos }
func (x Continue) Loc() *location.Location        { return x.Pos }

func Valid(expr Expr) bool {
	if _, ok := expr.(*NoExpr); ok {
		return false
	}
	return true
}

func Empty(expr Expr) bool {
	if expr.Loc() == (*location.Location)(nil) {
		return true
	}
	return false
}

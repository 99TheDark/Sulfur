package parser

import (
	. "golang/errors"
	"golang/lexer"
	"golang/typing"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/constant"
	"github.com/llir/llvm/ir/types"
	"github.com/llir/llvm/ir/value"
)

type Expression interface {
	Children() []Expression
	Location() *lexer.Location
	InferType() string
	GetType() *Type
	Generate(mod *ir.Module, bl *ir.Block) value.Value
}

type Type struct {
	Name       string
	Underlying typing.UnderlyingType
}

func NoType() *Type {
	return &Type{"", typing.Void}
}

type (
	Program struct {
		Contents Block
	}

	Block struct {
		Loc   *lexer.Location `json:"-"`
		Body  []Expression
		Scope typing.Scope
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
		Name     Identifier
		Params   List
		Return   List
		Contents Block
		Type     *Type `json:",omitempty"`
	}

	FunctionCall struct {
		Name   Identifier
		Params List
		Type   *Type `json:",omitempty"`
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
func (x Program) Children() []Expression         { return x.Contents.Body }
func (x Block) Children() []Expression           { return x.Body }
func (x Identifier) Children() []Expression      { return nil }
func (x Datatype) Children() []Expression        { return nil }
func (x Declaration) Children() []Expression     { return []Expression{x.Datatype, x.Variable, x.Value} }
func (x Assignment) Children() []Expression      { return []Expression{x.Variable, x.Value} }
func (x List) Children() []Expression            { return x.Values }
func (x BinaryOperation) Children() []Expression { return []Expression{x.Left, x.Right} }
func (x Comparison) Children() []Expression      { return []Expression{x.Left, x.Right} }
func (x FunctionLiteral) Children() []Expression { return []Expression{x.Params, x.Contents} }
func (x FunctionCall) Children() []Expression    { return []Expression{x.Name, x.Params} }
func (x IntegerLiteral) Children() []Expression  { return nil }
func (x FloatLiteral) Children() []Expression    { return nil }
func (x BoolLiteral) Children() []Expression     { return nil }
func (x Return) Children() []Expression          { return []Expression{x.Value} }
func (x IfStatement) Children() []Expression     { return []Expression{x.Then, x.Else} }

// Location
func (x Program) Location() *lexer.Location         { return lexer.NoLocation }
func (x Block) Location() *lexer.Location           { return x.Loc }
func (x Identifier) Location() *lexer.Location      { return x.Loc }
func (x Datatype) Location() *lexer.Location        { return x.Datatype.Loc }
func (x Declaration) Location() *lexer.Location     { return x.Datatype.Loc }
func (x Assignment) Location() *lexer.Location      { return x.Variable.Loc }
func (x List) Location() *lexer.Location            { return x.Values[0].Location() } // Length always >= 2
func (x BinaryOperation) Location() *lexer.Location { return x.Loc }
func (x Comparison) Location() *lexer.Location      { return x.Loc }
func (x FunctionLiteral) Location() *lexer.Location { return x.Name.Loc }
func (x FunctionCall) Location() *lexer.Location    { return x.Name.Loc }
func (x IntegerLiteral) Location() *lexer.Location  { return x.Loc }
func (x FloatLiteral) Location() *lexer.Location    { return x.Loc }
func (x BoolLiteral) Location() *lexer.Location     { return x.Loc }
func (x Return) Location() *lexer.Location          { return x.Value.Location() }
func (x IfStatement) Location() *lexer.Location     { return x.Loc }

// Infer Type
func (x Program) InferType() string {
	x.Contents.InferType()
	return ""
}
func (x Block) InferType() string {
	for _, child := range x.Body {
		child.InferType()
	}
	return ""
}
func (x Identifier) InferType() string {
	v := get(x, x.Parent, x.Symbol)
	x.Type.Name, x.Type.Underlying = v.Type, v.Underlying
	return v.Type
}
func (x Datatype) InferType() string {
	dt := x.Datatype.Symbol
	x.Type.Name, x.Type.Underlying = dt, typing.Underlying(dt)
	return dt
}
func (x Declaration) InferType() string {
	typ := confirm(x, x.Datatype.Symbol, x.Value.InferType())
	x.Type.Name, x.Type.Underlying = typ, typing.Underlying(typ)

	variable := typing.NewVar(x.Type.Name, x.Type.Underlying)
	create(x.Variable, x.Variable.Symbol, *variable)

	return typ
}
func (x Assignment) InferType() string {
	return ""
}
func (x List) InferType() string {
	for _, child := range x.Values {
		child.InferType()
	}
	return ""
}
func (x BinaryOperation) InferType() string {
	typ := confirm(x, x.Left.InferType(), x.Right.InferType())
	x.Type.Name, x.Type.Underlying = typ, typing.Underlying(typ)
	return typ
}
func (x Comparison) InferType() string {
	confirm(x, x.Left.InferType(), x.Right.InferType())

	x.Type.Name, x.Type.Underlying = "bool", typing.Bool
	return "bool"
}
func (x FunctionLiteral) InferType() string {
	for _, parameter := range x.Params.Values {
		if param, ok := parameter.(Datatype); ok {
			param.InferType()

			variable := typing.NewVar(
				param.Type.Name,
				param.Type.Underlying,
			)
			x.Contents.Scope.Vars[param.Variable.Symbol] = *variable
		} else {
			Errors.Error("Non-parameter in function parameters", parameter.Location())
		}
	}
	x.Contents.InferType()

	x.Type.Name, x.Type.Underlying = "func", typing.Func
	return "func"
}
func (x FunctionCall) InferType() string { // tricky
	return ""
}
func (x IntegerLiteral) InferType() string {
	x.Type.Name, x.Type.Underlying = "int", typing.Int
	return "int"
}
func (x FloatLiteral) InferType() string {
	x.Type.Name, x.Type.Underlying = "float", typing.Float
	return "float"
}
func (x BoolLiteral) InferType() string {
	x.Type.Name, x.Type.Underlying = "bool", typing.Bool
	return "bool"
}
func (x Return) InferType() string { // tricky
	x.Value.InferType()
	return ""
}
func (x IfStatement) InferType() string {
	cond := x.Condition.InferType()
	if cond != "bool" {
		Errors.Error("Condition must be a boolean", x.Condition.Location())
	}

	x.Then.InferType()
	x.Else.InferType()
	return ""
}

// Get Type
func (x Program) GetType() *Type         { return nil }
func (x Block) GetType() *Type           { return nil }
func (x Identifier) GetType() *Type      { return x.Type }
func (x Datatype) GetType() *Type        { return x.Type }
func (x Declaration) GetType() *Type     { return nil }
func (x Assignment) GetType() *Type      { return nil }
func (x List) GetType() *Type            { return nil }
func (x BinaryOperation) GetType() *Type { return x.Type }
func (x Comparison) GetType() *Type      { return x.Type }
func (x FunctionLiteral) GetType() *Type { return x.Type }
func (x FunctionCall) GetType() *Type    { return x.Type }
func (x IntegerLiteral) GetType() *Type  { return x.Type }
func (x FloatLiteral) GetType() *Type    { return x.Type }
func (x BoolLiteral) GetType() *Type     { return x.Type }
func (x Return) GetType() *Type          { return nil }
func (x IfStatement) GetType() *Type     { return nil }

// Generate
func (x Program) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	x.Contents.Generate(mod, bl)
	return nil
}
func (x Block) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	for _, expr := range x.Body {
		expr.Generate(mod, bl)
	}
	return nil
}
func (x Identifier) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	variable := x.Parent.Vars[x.Symbol]
	return *variable.Value
}
func (x Datatype) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	return nil
}
func (x Declaration) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	src := x.Value.Generate(mod, bl)
	dst := bl.NewAlloca(types.I32)
	store := bl.NewStore(src, dst)

	store.Align, dst.Align = 4, 4 // size in bytes, i32 = 4 * 8 bits = 4 bytes
	dst.LocalName = x.Variable.Symbol

	variable := x.Variable.Parent.Vars[x.Variable.Symbol]
	*variable.Value = dst
	return nil
}
func (x Assignment) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	return nil
}
func (x List) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	return nil
}
func (x BinaryOperation) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	switch x.Operator {
	case lexer.Add:
		return bl.NewAdd(x.Left.Generate(mod, bl), x.Right.Generate(mod, bl))
	case lexer.Subtract:
		return bl.NewSub(x.Left.Generate(mod, bl), x.Right.Generate(mod, bl))
	case lexer.Multiply:
		return bl.NewMul(x.Left.Generate(mod, bl), x.Right.Generate(mod, bl))
	case lexer.Divide:
		return bl.NewSDiv(x.Left.Generate(mod, bl), x.Right.Generate(mod, bl))
	case lexer.Modulo:
		return bl.NewSRem(x.Left.Generate(mod, bl), x.Right.Generate(mod, bl))
	default:
		return nil
	}
}
func (x Comparison) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	return nil
}
func (x FunctionLiteral) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	params := []*ir.Param{}
	for _, parameter := range x.Params.Values {
		param := parameter.(Datatype) // Already confirmed to be datatype in typechecker
		p := ir.NewParam(param.Variable.Symbol, types.I32)

		params = append(params, p)
	}

	fun := mod.NewFunc(x.Name.Symbol, types.I32, params...)
	x.Contents.Generate(mod, fun.NewBlock(""))

	return fun
}
func (x FunctionCall) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	return nil
}
func (x IntegerLiteral) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	return constant.NewInt(types.I32, x.Value)
}
func (x FloatLiteral) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	return nil
}
func (x BoolLiteral) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	return nil
}
func (x Return) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	bl.NewRet(x.Value.Generate(mod, bl))
	return nil
}
func (x IfStatement) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	return nil
}

// Misc
func confirm(Expression Expression, types ...string) string {
	f := types[0]
	if len(types) < 2 {
		return f
	}

	for _, el := range types {
		if el != f {
			Errors.Error("Mismatch of '"+el+"' to '"+f+"'", Expression.Location())
		}
	}
	return f
}

func link(expr Expression, parent typing.Scope) {
	if iden, ok := expr.(Identifier); ok {
		*iden.Parent = parent
	} else {
		newParent := parent
		if block, ok := expr.(Block); ok {
			*block.Scope.Parent = parent
			newParent = block.Scope
		}

		for _, child := range expr.Children() {
			link(child, newParent)
		}
	}
}

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

func TypeCheck(ast Program) Program {
	link(ast, ast.Contents.Scope)
	ast.InferType()
	return ast
}

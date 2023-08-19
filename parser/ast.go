package parser

import (
	. "golang/errors"
	"golang/lexer"
	"golang/typing"
	"golang/utils"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/constant"
	"github.com/llir/llvm/ir/types"
	"github.com/llir/llvm/ir/value"
)

type Expression interface {
	Children() []Expression
	Location() *lexer.Location
	InferType() TypedExpression
	Generate(bl *ir.Block) value.Value
}

type TypedExpression struct {
	Expression Expression
	Type       string
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
		Symbol string
	}

	Datatype struct {
		Type     Identifier
		Variable Identifier
	}

	Declaration struct {
		Type     Identifier
		Variable Identifier
		Value    Expression
	}

	Assignment struct {
		Variable Identifier
		Value    Expression
		Operator lexer.Operation
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

	IntegerLiteral struct {
		Loc   *lexer.Location `json:"-"`
		Value int64
	}

	FloatLiteral struct {
		Loc   *lexer.Location `json:"-"`
		Value float64
	}

	BoolLiteral struct {
		Loc   *lexer.Location `json:"-"`
		Value bool
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
func (x Declaration) Children() []Expression     { return nil }
func (x Assignment) Children() []Expression      { return nil }
func (x List) Children() []Expression            { return x.Values }
func (x BinaryOperation) Children() []Expression { return []Expression{x.Left, x.Right} }
func (x Comparison) Children() []Expression      { return []Expression{x.Left, x.Right} }
func (x FunctionLiteral) Children() []Expression { return x.Body }
func (x FunctionCall) Children() []Expression    { return nil }
func (x IntegerLiteral) Children() []Expression  { return nil }
func (x FloatLiteral) Children() []Expression    { return nil }
func (x BoolLiteral) Children() []Expression     { return nil }
func (x Return) Children() []Expression          { return []Expression{x.Value} }
func (x IfStatement) Children() []Expression     { return []Expression{x.Then, x.Else} }

// Location
func (x Program) Location() *lexer.Location         { return lexer.NoLocation }
func (x Block) Location() *lexer.Location           { return x.Loc }
func (x Identifier) Location() *lexer.Location      { return x.Loc }
func (x Datatype) Location() *lexer.Location        { return x.Type.Loc }
func (x Declaration) Location() *lexer.Location     { return x.Type.Loc }
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
func (x Program) InferType() TypedExpression {
	types := utils.Apply(x.Contents.Body, func(expr Expression) string {
		return expr.InferType().Type
	})
	confirm(x, types...)

	return TypedExpression{x, ""}
}
func (x Block) InferType() TypedExpression {
	return TypedExpression{x, ""}
}
func (x Identifier) InferType() TypedExpression {
	return TypedExpression{x, ""}
}
func (x Datatype) InferType() TypedExpression {
	return TypedExpression{x, ""}
}
func (x Declaration) InferType() TypedExpression {
	typ := confirm(x, x.Type.Symbol, x.Value.InferType().Type)
	return TypedExpression{x, typ}
}
func (x Assignment) InferType() TypedExpression {
	return TypedExpression{x, ""}
}
func (x List) InferType() TypedExpression {
	return TypedExpression{x, ""}
}
func (x BinaryOperation) InferType() TypedExpression {
	return TypedExpression{x, ""}
}
func (x Comparison) InferType() TypedExpression {
	return TypedExpression{x, ""}
}
func (x FunctionLiteral) InferType() TypedExpression {
	return TypedExpression{x, ""}
}
func (x FunctionCall) InferType() TypedExpression {
	return TypedExpression{x, ""}
}
func (x IntegerLiteral) InferType() TypedExpression {
	return TypedExpression{x, ""}
}
func (x FloatLiteral) InferType() TypedExpression {
	return TypedExpression{x, ""}
}
func (x BoolLiteral) InferType() TypedExpression {
	return TypedExpression{x, ""}
}
func (x Return) InferType() TypedExpression {
	return TypedExpression{x, ""}
}
func (x IfStatement) InferType() TypedExpression {
	return TypedExpression{x, ""}
}

// Generate
func (x Program) Generate(bl *ir.Block) value.Value {
	x.Contents.Generate(bl)
	return nil
}
func (x Block) Generate(bl *ir.Block) value.Value {
	for _, expr := range x.Body {
		expr.Generate(bl)
	}
	return nil
}
func (x Identifier) Generate(bl *ir.Block) value.Value {
	return nil
}
func (x Datatype) Generate(bl *ir.Block) value.Value {
	return nil
}
func (x Declaration) Generate(bl *ir.Block) value.Value {
	return nil
}
func (x Assignment) Generate(bl *ir.Block) value.Value {
	return nil
}
func (x List) Generate(bl *ir.Block) value.Value {
	return nil
}
func (x BinaryOperation) Generate(bl *ir.Block) value.Value {
	switch x.Operator {
	case lexer.Add:
		return bl.NewAdd(x.Left.Generate(bl), x.Right.Generate(bl))
	case lexer.Subtract:
		return bl.NewSub(x.Left.Generate(bl), x.Right.Generate(bl))
	case lexer.Multiply:
		return bl.NewMul(x.Left.Generate(bl), x.Right.Generate(bl))
	case lexer.Divide:
		return bl.NewSDiv(x.Left.Generate(bl), x.Right.Generate(bl))
	case lexer.Modulo:
		return bl.NewSRem(x.Left.Generate(bl), x.Right.Generate(bl))
	default:
		return nil
	}
}
func (x Comparison) Generate(bl *ir.Block) value.Value {
	return nil
}
func (x FunctionLiteral) Generate(bl *ir.Block) value.Value {
	return nil
}
func (x FunctionCall) Generate(bl *ir.Block) value.Value {
	return nil
}
func (x IntegerLiteral) Generate(bl *ir.Block) value.Value {
	return constant.NewInt(types.I64, x.Value)
}
func (x FloatLiteral) Generate(bl *ir.Block) value.Value {
	return nil
}
func (x BoolLiteral) Generate(bl *ir.Block) value.Value {
	return nil
}
func (x Return) Generate(bl *ir.Block) value.Value {
	return nil
}
func (x IfStatement) Generate(bl *ir.Block) value.Value {
	return nil
}

// Misc
func Type(ast Program) TypedExpression {
	return ast.InferType()
}

func confirm(expr Expression, types ...string) string {
	f := types[0]
	if len(types) < 2 {
		return f
	}

	for _, el := range types {
		if el != f {
			Errors.Error("Type mismatch: '"+el+"' to '"+f+"'", expr.Location())
		}
	}
	return f
}

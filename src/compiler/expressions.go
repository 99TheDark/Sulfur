package compiler

import (
	"sulfur/src/ast"
	"sulfur/src/lexer"
	"sulfur/src/typing"
	"unicode/utf8"

	. "sulfur/src/errors"

	"github.com/llir/llvm/ir/constant"
	"github.com/llir/llvm/ir/enum"
	"github.com/llir/llvm/ir/types"
	"github.com/llir/llvm/ir/value"
)

func (g *generator) genExpr(expr ast.Expr) value.Value {
	switch x := expr.(type) {
	case ast.Identifier:
		return g.autoCast(g.genIdentifier(x), x, "variable")
	case ast.Integer:
		return g.autoCast(constant.NewInt(types.I32, x.Value), x, "integer")
	case ast.Float:
		return g.autoCast(constant.NewFloat(types.Float, x.Value), x, "float")
	case ast.Boolean:
		return g.autoCast(constant.NewBool(x.Value), x, "boolean")
	case ast.String:
		return g.genString(x)
	case ast.BinaryOp:
		return g.autoCast(g.genBinaryOp(x), x, "binary operation")
	case ast.UnaryOp:
		return g.autoCast(g.genUnaryOp(x), x, "unary operation")
	case ast.Comparison:
		return g.autoCast(g.genComparison(x), x, "comparison")
	case ast.TypeConv:
		return g.genTypeConv(x)
	case ast.FuncCall:
		return g.autoCast(g.genFuncCall(x), x, "function call")
	case ast.Reference:
		return g.genReference(x)
	}

	Errors.Error("Expression cannot be generated", expr.Loc())
	return constant.NewInt(types.I32, 0)
}

func (g *generator) genIdentifier(x ast.Identifier) value.Value {
	vari := g.top.Lookup(x.Name, x.Pos)
	return g.genBasicIden(vari)
}

func (g *generator) genString(x ast.String) value.Value {
	bl := g.bl

	strGlob := g.strs[x.Value]
	glob, arr := strGlob.glob, strGlob.typ

	str := bl.NewGetElementPtr(
		arr,
		glob,
		Zero,
		Zero,
	)
	str.InBounds = true

	return g.genBasicStruct(
		g.str,
		constant.NewInt(types.I32, int64(utf8.RuneCountInString(x.Value))),
		str,
	)
}

func (g *generator) genBinaryOp(x ast.BinaryOp) value.Value {
	val := g.genBasicBinaryOp(g.genExpr(x.Left), g.genExpr(x.Right), x.Op.Type, g.Types[x])
	if val == Zero {
		Errors.Error("Unexpected generating error during binary operation", x.Op.Location)
	}

	return val
}

// TODO: Move to basic
func (g *generator) genUnaryOp(x ast.UnaryOp) value.Value {
	bl := g.bl
	val := g.genExpr(x.Value)
	typ := g.Types[x]
	switch x.Op.Type {
	case lexer.Subtraction:
		switch typ {
		case typing.Integer: // = -int
			return bl.NewSub(Zero, val)
		case typing.Float: // = -float
			return bl.NewFSub(FZero, val)
		}
	case lexer.Not:
		switch typ {
		case typing.Integer: // = !int
			return bl.NewXor(val, NegOne)
		case typing.Boolean: // = !bool
			return bl.NewICmp(enum.IPredEQ, val, Zero)
		}
	}

	Errors.Error("Unexpected generating error during unary operation", x.Op.Location)
	return Zero
}

func (g *generator) genComparison(x ast.Comparison) value.Value {
	bl := g.bl
	left := g.genExpr(x.Left)
	right := g.genExpr(x.Right)
	comp := x.Comp
	typ := g.Types[x.Left] // or x.Right

	switch comp.Type {
	case lexer.LessThan:
		switch typ {
		case typing.Integer:
			return bl.NewICmp(enum.IPredSLT, left, right)
		case typing.Float:
			return bl.NewFCmp(enum.FPredULT, left, right)
		}
	case lexer.GreaterThan:
		switch typ {
		case typing.Integer:
			return bl.NewICmp(enum.IPredSGT, left, right)
		case typing.Float:
			return bl.NewFCmp(enum.FPredUGT, left, right)
		}
	case lexer.LessThanOrEqualTo:
		switch typ {
		case typing.Integer:
			return bl.NewICmp(enum.IPredSLE, left, right)
		case typing.Float:
			return bl.NewFCmp(enum.FPredULE, left, right)
		}
	case lexer.GreaterThanOrEqualTo:
		switch typ {
		case typing.Integer:
			return bl.NewICmp(enum.IPredSGE, left, right)
		case typing.Float:
			return bl.NewFCmp(enum.FPredUGE, left, right)
		}
	case lexer.EqualTo:
		switch typ {
		case typing.Integer, typing.Boolean:
			return bl.NewICmp(enum.IPredEQ, left, right)
		case typing.Float:
			return bl.NewFCmp(enum.FPredUEQ, left, right)
		}
	case lexer.NotEqualTo:
		switch typ {
		case typing.Integer, typing.Boolean:
			return bl.NewICmp(enum.IPredNE, left, right)
		case typing.Float:
			return bl.NewFCmp(enum.FPredUNE, left, right)
		}
	}

	Errors.Error("Unexpected generating error during comparison", x.Comp.Location)
	return Zero
}

func (g *generator) genTypeConv(x ast.TypeConv) value.Value {
	val := g.genExpr(x.Value)

	g.genBasicTypeConv(val, g.Types[x.Value], g.Types[x])

	Errors.Error("Unexpected generating error during type conversion", x.Loc())
	return Zero
}

func (g *generator) genFuncCall(x ast.FuncCall) value.Value {
	// TODO: Make operator overloading work
	bl := g.bl

	for _, fun := range g.program.Functions {
		if fun.Name == x.Func.Name {
			params := []value.Value{}
			for _, param := range *x.Params {
				params = append(params, g.genExpr(param))
			}

			return bl.NewCall(fun.Ir, params...)
		}
	}

	Errors.Error("The function "+x.Func.Name+" is undefined", x.Func.Pos)
	return nil
}

func (g *generator) genReference(x ast.Reference) value.Value {
	bl := g.bl
	vari := g.top.Lookup(x.Variable.Name, x.Variable.Loc())
	if !vari.Referenced {
		Errors.Error(vari.Name+" is never referenced", x.Variable.Loc())
	}

	bundle := g.refs[vari.Type]

	load := bl.NewLoad(bundle.ptr, vari.Value)
	load.Align = 8
	bl.NewCall(bundle.ref, load)

	return load
}

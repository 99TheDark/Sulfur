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
		return g.genIdentifier(x)
	case ast.Integer:
		return constant.NewInt(types.I32, x.Value)
	case ast.Float:
		return constant.NewFloat(types.Float, x.Value)
	case ast.Boolean:
		return constant.NewBool(x.Value)
	case ast.String:
		return g.genString(x)
	case ast.TypeConv:
		return g.genTypeConv(x)
	case ast.BinaryOp:
		return g.genBinaryOp(x)
	case ast.UnaryOp:
		return g.genUnaryOp(x)
	case ast.Comparison:
		return g.genComparison(x)
	}

	Errors.Error("Expression cannot be generated", expr.Loc())
	return constant.NewInt(types.I32, 0)
}

func (g *generator) genIdentifier(x ast.Identifier) value.Value {
	bl := g.bl
	vari := g.top.Lookup(x.Name, x.Pos)
	val := *vari.Value
	load := bl.NewLoad(g.typ(x), val)
	return load
}

// TODO: Simplify
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

	alloca := bl.NewAlloca(g.str)
	alloca.Align = 8

	lenPtr := bl.NewGetElementPtr(
		g.str,
		alloca,
		Zero,
		Zero,
	)
	lenPtr.InBounds = true

	lenStore := bl.NewStore(
		constant.NewInt(types.I32, int64(utf8.RuneCountInString(x.Value))),
		lenPtr,
	)
	lenStore.Align = 8

	sizePtr := bl.NewGetElementPtr(
		g.str,
		alloca,
		Zero,
		One,
	)
	sizePtr.InBounds = true

	sizeStore := bl.NewStore(
		constant.NewInt(types.I32, int64(len(x.Value))),
		sizePtr,
	)
	sizeStore.Align = 8

	adrPtr := bl.NewGetElementPtr(
		g.str,
		alloca,
		Zero,
		Two,
	)
	adrPtr.InBounds = true

	adrStore := bl.NewStore(
		str,
		adrPtr,
	)
	adrStore.Align = 8

	return alloca
}

func (g *generator) genTypeConv(x ast.TypeConv) value.Value {
	bl := g.bl
	val := g.genExpr(x.Value)

	alloca := bl.NewAlloca(g.lltyp(typing.Type(x.Type.Name)))
	alloca.Align = 8

	bl.NewCall(g.biConv(string(g.types[x.Value]), x.Type.Name), alloca, val)
	return alloca
}

func (g *generator) genBinaryOp(x ast.BinaryOp) value.Value {
	val := g.genBasicBinaryOp(g.genExpr(x.Left), g.genExpr(x.Right), x.Op.Type, g.types[x])
	if val == Zero {
		Errors.Error("Unexpected generating error during binary operation", x.Loc())
	}

	return val
}

// TODO: Move to basic
func (g *generator) genUnaryOp(x ast.UnaryOp) value.Value {
	bl := g.bl
	val := g.genExpr(x.Value)
	typ := g.types[x]
	switch x.Op.Type {
	case lexer.Subtraction:
		switch typ {
		case typing.Integer: // -int
			return bl.NewSub(Zero, val)
		case typing.Float: // -float
			return bl.NewFSub(FZero, val)
		}
	}

	Errors.Error("Unexpected generating error during unary operation", x.Loc())
	return Zero
}

func (g *generator) genComparison(x ast.Comparison) value.Value {
	bl := g.bl
	left := g.genExpr(x.Left)
	right := g.genExpr(x.Right)
	comp := x.Comp
	typ := g.types[x.Left] // or x.Right

	switch comp.Type {
	case lexer.LessThan:
		switch typ {
		case typing.Integer:
			return bl.NewICmp(enum.IPredSLT, left, right)
		case typing.Float:
			return bl.NewFCmp(enum.FPredOLT, left, right)
		}
	case lexer.GreaterThan:
		switch typ {
		case typing.Integer:
			return bl.NewICmp(enum.IPredSGT, left, right)
		case typing.Float:
			return bl.NewFCmp(enum.FPredOGT, left, right)
		}
	case lexer.LessThanOrEqualTo:
		switch typ {
		case typing.Integer:
			return bl.NewICmp(enum.IPredSLE, left, right)
		case typing.Float:
			return bl.NewFCmp(enum.FPredOLE, left, right)
		}
	case lexer.GreaterThanOrEqualTo:
		switch typ {
		case typing.Integer:
			return bl.NewICmp(enum.IPredSGE, left, right)
		case typing.Float:
			return bl.NewFCmp(enum.FPredOGE, left, right)
		}
	}

	Errors.Error("Unexpected generating error during comparison", x.Loc())
	return Zero
}

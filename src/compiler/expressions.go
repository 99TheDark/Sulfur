package compiler

import (
	"sulfur/src/ast"
	"sulfur/src/typing"
	"unicode/utf8"

	. "sulfur/src/errors"

	"github.com/llir/llvm/ir/constant"
	"github.com/llir/llvm/ir/types"
	"github.com/llir/llvm/ir/value"
)

func (g *generator) genExpr(expr ast.Expr) value.Value {
	switch x := expr.(type) {
	case ast.Identifier:
		return g.autoCast(g.genIdentifier(x), x, "variable")
	case ast.Integer:
		return g.autoCast(constant.NewInt(types.I32, x.Value), x, "integer")
	case ast.UnsignedInteger:
		return g.autoCast(constant.NewInt(types.I32, int64(x.Value)), x, "unsigned integer")
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
		return g.autoCast(g.genTypeConv(x), x, "type conversion")
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

	strStruct := g.genBasicStruct(
		g.str,
		constant.NewInt(types.I32, int64(utf8.RuneCountInString(x.Value))),
		str,
	)
	copy := g.copys[typing.String]

	copied := bl.NewCall(copy, strStruct)
	g.top.Strings[copied] = typing.String

	return copied
}

func (g *generator) genBinaryOp(x ast.BinaryOp) value.Value {
	val := g.genBasicBinaryOp(g.genExpr(x.Left), g.genExpr(x.Right), x.Op.Type, g.Types[x])
	if val == Zero {
		Errors.Error("Unexpected generating error during binary operation", x.Op.Location)
	}

	return val
}

func (g *generator) genUnaryOp(x ast.UnaryOp) value.Value {
	val := g.genBasicUnaryOp(g.genExpr(x.Value), x.Op.Type, g.Types[x])
	if val == Zero {
		Errors.Error("Unexpected generating error during unary operation", x.Op.Location)
	}

	return val
}

func (g *generator) genComparison(x ast.Comparison) value.Value {
	val := g.genBasicComparison(g.genExpr(x.Left), g.genExpr(x.Right), x.Comp.Type, g.Types[x.Left])
	if val == Zero {
		Errors.Error("Unexpected generating error during comparison", x.Comp.Location)
	}

	return val
}

func (g *generator) genTypeConv(x ast.TypeConv) value.Value {
	conv := g.genBasicTypeConv(g.genExpr(x.Value), g.Types[x.Value], g.Types[x])
	if conv == Zero {
		Errors.Error("Unexpected generating error during type conversion", x.Loc())
	}

	return conv
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

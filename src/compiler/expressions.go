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
	case ast.FuncCall:
		return g.genFuncCall(x)
	}

	Errors.Error("Expression cannot be generated", expr.Loc())
	return constant.NewInt(types.I32, 0)
}

func (g *generator) genIdentifier(x ast.Identifier) value.Value {
	bl := g.bl
	vari := g.top.Lookup(x.Name, x.Pos)
	val := *vari.Value

	if vari.Status == ast.Parameter {
		return val
	} else {
		load := bl.NewLoad(g.typ(x), val)
		return load
	}
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
		constant.NewInt(types.I32, int64(len(x.Value))),
		str,
	)
}

func (g *generator) genTypeConv(x ast.TypeConv) value.Value {
	bl := g.bl
	conv := g.srcConv(string(g.types[x.Value]), x.Type.Name)
	val := g.genExpr(x.Value)

	if conv.Complex {
		alloca := bl.NewAlloca(g.lltyp(typing.Type(x.Type.Name)))
		alloca.Align = 8

		bl.NewCall(conv.Ir, alloca, val)
		return alloca
	} else {
		from, to := conv.From, conv.To
		typ := g.llraw(conv.To)
		val := g.genExpr(x.Value)

		switch from {
		case typing.Integer:
			switch to {
			case typing.Float:
				return bl.NewSIToFP(val, typ)
			case typing.Boolean:
				return bl.NewICmp(enum.IPredNE, val, Zero)
			}
		case typing.Float:
			switch to {
			case typing.Integer:
				return bl.NewFPToSI(val, typ)
			case typing.Boolean:
				return bl.NewFCmp(enum.FPredONE, val, FZero)
			}
		case typing.Boolean:
			switch to {
			case typing.Integer:
				return bl.NewZExt(val, typ)
			case typing.Float:
				return bl.NewSIToFP(bl.NewZExt(val, types.I32), typ)
			}
		}
	}

	Errors.Error("Unexpected generating error during type conversion", x.Loc())
	return Zero
}

func (g *generator) genBinaryOp(x ast.BinaryOp) value.Value {
	val := g.genBasicBinaryOp(g.genExpr(x.Left), g.genExpr(x.Right), x.Op.Type, g.types[x])
	if val == Zero {
		Errors.Error("Unexpected generating error during binary operation", x.Op.Location)
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
	typ := g.types[x.Left] // or x.Right

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

func (g *generator) genFuncCall(x ast.FuncCall) value.Value {
	// TODO: Include return value in parameter as pointer if a struct
	// TODO: Make operator overloading work
	// TODO: Make this actually work
	bl := g.bl

	for _, fun := range g.program.Functions {
		if fun.Name == x.Func.Name {
			params := []value.Value{}
			for _, param := range *x.Params {
				params = append(params, g.genExpr(param))
			}

			// No ir
			return bl.NewCall(g.builtins.funcs[x.Func.Name].Ir, params...)
		}
	}

	Errors.Error("The function "+x.Func.Name+" is undefined", x.Func.Pos)
	return nil
}

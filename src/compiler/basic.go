package compiler

import (
	"sulfur/src/ast"
	"sulfur/src/lexer"
	"sulfur/src/typing"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/constant"
	"github.com/llir/llvm/ir/types"
	"github.com/llir/llvm/ir/value"
)

func (g *generator) genBasicRawIden(vari *ast.Variable) value.Value {
	bl := g.bl
	if vari.Referenced {
		bundle := g.refs[vari.Type]
		ref := *vari.Value

		ptr := bl.NewGetElementPtr(bundle.typ, ref, Zero, Zero)
		ptr.InBounds = true

		valptr := bl.NewLoad(g.llptr(vari.Type), ptr)
		valptr.Align = 8
		return valptr
	} else {
		return *vari.Value
	}
}

func (g *generator) genBasicIden(vari *ast.Variable) value.Value {
	bl := g.bl

	val := g.genBasicRawIden(vari)

	if !vari.Referenced && vari.Status == ast.Parameter {
		return val
	}

	load := bl.NewLoad(g.lltyp(vari.Type), val)
	load.Align = ir.Align(g.size(vari.Type))
	return load
}

func (g *generator) genBasicDecl(name string, typ types.Type, val value.Value, loc *typing.Location) {
	bl := g.bl

	vari := g.top.Lookup(name, loc)

	if vari.Referenced {
		bundle := g.refs[vari.Type]

		call := bl.NewCall(bundle.newref, val)
		call.LocalName = vari.LLName()
		*vari.Value = call
	} else {
		alloca := bl.NewAlloca(typ)
		alloca.LocalName = vari.LLName()

		bl.NewStore(val, alloca)
		*vari.Value = alloca
	}
}

func (g *generator) genBasicAssign(name string, val value.Value, loc *typing.Location) {
	bl := g.bl
	vari := g.top.Lookup(name, loc)
	if vari.Referenced {
		iden := g.genBasicRawIden(vari)

		store := bl.NewStore(val, iden)
		store.Align = 8
	} else {
		bl.NewStore(val, *vari.Value)
	}
}

func (g *generator) genBasicBinaryOp(left, right value.Value, op lexer.TokenType, typ typing.Type) value.Value {
	bl := g.bl
	switch op {
	case lexer.Addition:
		switch typ {
		case typing.String: // = string + string
			call := bl.NewCall(g.srcBinop(lexer.Addition, typing.String, typing.String).Ir, left, right)
			return call
		case typing.Integer: // = int + int
			return bl.NewAdd(left, right)
		case typing.Float: // = float + float
			return bl.NewFAdd(left, right)
		}
	case lexer.Subtraction:
		switch typ {
		case typing.Integer: // = int - int
			return bl.NewSub(left, right)
		case typing.Float: // = float - float
			return bl.NewFSub(left, right)
		}
	case lexer.Multiplication:
		switch typ {
		case typing.Integer: // = int * int
			return bl.NewMul(left, right)
		case typing.Float: // = float * float
			return bl.NewFMul(left, right)
		}
	case lexer.Division:
		switch typ {
		case typing.Integer: // = int / int
			return bl.NewSDiv(left, right)
		case typing.Float: // = float / float
			return bl.NewFDiv(left, right)
		}
	case lexer.Modulus:
		switch typ {
		case typing.Integer: // = int % int
			return bl.NewSRem(left, right)
		case typing.Float: // = float % float
			return bl.NewFRem(left, right)
		}
	case lexer.Or:
		switch typ {
		case typing.Integer, typing.Boolean:
			return bl.NewOr(left, right)
		}
	case lexer.And:
		switch typ {
		case typing.Integer, typing.Boolean:
			return bl.NewAnd(left, right)
		}
	}

	return Zero
}

func (g *generator) genBasicStruct(typ types.Type, fields ...value.Value) value.Value {
	bl := g.bl

	alloca := bl.NewAlloca(typ)
	alloca.Align = 8
	for i, field := range fields {
		ptr := bl.NewGetElementPtr(
			typ,
			alloca,
			Zero,
			constant.NewInt(types.I32, int64(i)),
		)
		ptr.InBounds = true

		store := bl.NewStore(
			field,
			ptr,
		)
		store.Align = 8
	}

	load := bl.NewLoad(typ, alloca)
	load.Align = 8

	return load
}

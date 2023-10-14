package compiler

import (
	"sulfur/src/lexer"
	"sulfur/src/typing"

	"github.com/llir/llvm/ir/constant"
	"github.com/llir/llvm/ir/types"
	"github.com/llir/llvm/ir/value"
)

func (g *generator) genBasicDecl(name string, typ types.Type, val value.Value, loc *lexer.Location) {
	bl := g.bl

	alloca := bl.NewAlloca(typ)
	alloca.LocalName = name

	bl.NewStore(val, alloca)

	vari := g.top.Lookup(name, loc)
	*vari.Value = alloca
}

func (g *generator) genBasicAssign(name string, src value.Value, loc *lexer.Location) {
	bl := g.bl
	vari := g.top.Lookup(name, loc)
	bl.NewStore(src, *vari.Value)
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

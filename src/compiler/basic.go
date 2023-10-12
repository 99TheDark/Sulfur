package compiler

import (
	"sulfur/src/lexer"
	"sulfur/src/typing"

	"github.com/llir/llvm/ir/value"
)

func (g *generator) genBasicDecl(name string, val value.Value, loc *lexer.Location) {
	bl := g.bl

	alloca := bl.NewAlloca(val.Type())
	alloca.LocalName = name

	bl.NewStore(val, alloca)

	vari := g.top.Lookup(name, loc)
	*vari.Value = alloca
}

func (g *generator) genBasicAssign(name string, val value.Value, loc *lexer.Location) {
	bl := g.bl
	vari := g.top.Lookup(name, loc)
	bl.NewStore(val, *vari.Value)
}

func (g *generator) genBasicBinaryOp(left, right value.Value, op lexer.TokenType, typ typing.Type) value.Value {
	bl := g.bl
	ll := g.lltyp(typ)
	switch op {
	case lexer.Addition:
		switch typ {
		case typing.String: // = string + string
			alloca := bl.NewAlloca(ll)
			alloca.Align = 8
			bl.NewCall(g.biBinop(lexer.Addition, typing.String, typing.String), alloca, left, right)
			return alloca
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

package compiler

import (
	"sulfur/src/lexer"
	"sulfur/src/typing"

	"github.com/llir/llvm/ir/value"
)

func (g *generator) genBasicDecl(name string, val value.Value) {
	bl := g.bl

	alloca := bl.NewAlloca(val.Type())
	alloca.LocalName = name

	bl.NewStore(val, alloca)

	vari := g.top.Vars[name]
	*vari.Value = alloca
}

func (g *generator) genBasicAssign(name string, val value.Value) {
	bl := g.bl
	bl.NewStore(val, *g.top.Vars[name].Value)
}

func (g *generator) genBasicBinaryOp(left, right value.Value, op lexer.TokenType, typ typing.Type) value.Value {
	bl := g.bl
	ll := g.lltyp(typ)
	switch op {
	case lexer.Addition:
		switch typ {
		case typing.String: // string + string
			alloca := bl.NewAlloca(ll)
			alloca.Align = 8
			bl.NewCall(g.biBinop(lexer.Addition, typing.String, typing.String), alloca, left, right)
			return alloca
		case typing.Integer: // int + int
			return bl.NewAdd(left, right)
		case typing.Float: // float + float
			return bl.NewFAdd(left, right)
		}
	case lexer.Subtraction:
		switch typ {
		case typing.Integer: // int - int
			return bl.NewSub(left, right)
		case typing.Float: // float - float
			return bl.NewFSub(left, right)
		}
	case lexer.Multiplication:
		switch typ {
		case typing.Integer: // int * int
			return bl.NewMul(left, right)
		case typing.Float: // float * float
			return bl.NewFMul(left, right)
		}
	case lexer.Division:
		switch typ {
		case typing.Integer: // int / int
			return bl.NewSDiv(left, right)
		case typing.Float: // float / float
			return bl.NewFDiv(left, right)
		}
	case lexer.Modulus:
		switch typ {
		case typing.Integer: // int % int
			return bl.NewSRem(left, right)
		case typing.Float: // float % float
			return bl.NewFRem(left, right)
		}
	}

	return Zero
}

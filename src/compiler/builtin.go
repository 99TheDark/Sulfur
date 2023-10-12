package compiler

import (
	"sulfur/src/lexer"

	"github.com/llir/llvm/ir"
)

func (g *generator) biFunc(name string) *ir.Func {
	return g.builtins.funcs[name]
}

func (g *generator) biBinop(op lexer.TokenType, left, right string) *ir.Func {
	return g.builtins.binops[op.OperatorName()+" "+left+" "+right]
}

func (g *generator) biConv(from, to string) *ir.Func {
	return g.builtins.convs["conv "+from+" "+to]
}

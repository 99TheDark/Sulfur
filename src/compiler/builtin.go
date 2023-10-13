package compiler

import (
	"sulfur/src/builtins"
	"sulfur/src/lexer"

	"github.com/llir/llvm/ir"
)

type bi_func struct {
	sig builtins.FuncSignature
	ir  *ir.Func
}

type bi_binop struct {
	sig     builtins.BinaryOpSignature
	ir      *ir.Func
	complex bool
}

type bi_unop struct {
	sig     builtins.UnaryOpSignature
	ir      *ir.Func
	complex bool
}

type bi_incdec struct {
	sig     builtins.IncDecSignature
	ir      *ir.Func
	complex bool
}

type bi_comp struct {
	sig     builtins.ComparisonSignature
	ir      *ir.Func
	complex bool
}

type bi_conv struct {
	sig     builtins.TypeConvSignature
	ir      *ir.Func
	complex bool
}

type llvm_builtins struct {
	funcs   map[string]bi_func
	binops  map[string]bi_binop
	unops   map[string]bi_unop
	incdecs map[string]bi_incdec
	comps   map[string]bi_comp
	convs   map[string]bi_conv
}

func (g *generator) biFunc(name string) bi_func {
	return g.builtins.funcs[name]
}

func (g *generator) biBinop(op lexer.TokenType, left, right string) bi_binop {
	return g.builtins.binops[op.OperatorName()+" "+left+" "+right]
}

func (g *generator) biConv(from, to string) bi_conv {
	return g.builtins.convs["conv "+from+" "+to]
}

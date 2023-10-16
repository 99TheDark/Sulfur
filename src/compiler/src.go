package compiler

import (
	"sulfur/src/builtins"
	"sulfur/src/lexer"
)

type llvm_builtins struct {
	funcs   map[string]*builtins.FuncSignature
	classes map[string]*builtins.ClassSignature
	binops  map[string]*builtins.BinaryOpSignature
	unops   map[string]*builtins.UnaryOpSignature
	incdecs map[string]*builtins.IncDecSignature
	comps   map[string]*builtins.ComparisonSignature
	convs   map[string]*builtins.TypeConvSignature
}

func (g *generator) srcFunc(name string) *builtins.FuncSignature {
	return g.builtins.funcs[name]
}

func (g *generator) srcBinop(op lexer.TokenType, left, right string) *builtins.BinaryOpSignature {
	return g.builtins.binops[op.OperatorName()+" "+left+" "+right]
}

func (g *generator) srcUnop(op lexer.TokenType, val string) *builtins.UnaryOpSignature {
	return g.builtins.unops[op.OperatorName()+" "+val]
}

func (g *generator) srcIncDec(op lexer.TokenType, vari string) *builtins.IncDecSignature {
	return g.builtins.incdecs[op.OperatorName()+" "+vari]
}

func (g *generator) srcComp(op lexer.TokenType, left, right string) *builtins.ComparisonSignature {
	return g.builtins.comps[op.OperatorName()+" "+left+" "+right]
}

func (g *generator) srcConv(from, to string) *builtins.TypeConvSignature {
	return g.builtins.convs["conv "+from+" "+to]
}

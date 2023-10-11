package compiler

import (
	"sulfur/src/ast"
)

func (g *generator) genBasicDecl(name string, value ast.Expr) {
	bl := g.bl
	val := g.genExpr(value)

	alloca := bl.NewAlloca(val.Type())
	alloca.LocalName = name

	bl.NewStore(val, alloca)

	vari := g.top.Vars[name]
	*vari.Value = alloca
}

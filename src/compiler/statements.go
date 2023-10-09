package compiler

import (
	"fmt"
	"sulfur/src/ast"

	"github.com/llir/llvm/ir/value"
)

func (g *generator) genStmt(expr ast.Expr) {
	switch x := expr.(type) {
	case ast.Declaration:
		g.genDecl(x)
	case ast.FuncCall:
		g.genFuncCall(x)
	default:
		fmt.Println("Ignored generating statement")
	}
}

func (g *generator) genDecl(x ast.Declaration) {
	g.genExpr(x.Value)
}

func (g *generator) genFuncCall(x ast.FuncCall) {
	// TODO: Make work with non-builtins
	bl := g.bl()

	params := []value.Value{}
	for _, param := range x.Params {
		params = append(params, g.genExpr(param))
	}

	bl.NewCall(g.builtins[x.Func.Name], params...)
}

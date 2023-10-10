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
	bl := g.bl()
	val := g.genExpr(x.Value)

	alloca := bl.NewAlloca(val.Type())
	alloca.LocalName = x.Name.Name

	bl.NewStore(val, alloca)

	vari := g.top.Vars[x.Name.Name]
	*vari.Value = alloca
}

func (g *generator) genFuncCall(x ast.FuncCall) {
	// TODO: Make work with non-builtins
	// TODO: Include return value in parameter as pointer if a struct
	bl := g.bl()

	params := []value.Value{}
	for _, param := range x.Params {
		params = append(params, g.genExpr(param))
	}

	bl.NewCall(g.builtins[x.Func.Name], params...)
}

package compiler

import (
	"fmt"
	"sulfur/src/ast"
)

func (g *generator) genStmt(expr ast.Expr) {
	switch x := expr.(type) {
	case ast.Declaration:
		g.genDecl(x)
	default:
		fmt.Println("Ignored generating statement")
	}
}

func (g *generator) genDecl(x ast.Declaration) {
	g.typ(x.Value)
}

func (g *generator) typ(x ast.Expr) {
	fmt.Println(g.types[x])
}

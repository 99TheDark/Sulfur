package compiler

import (
	"fmt"
	"sulfur/src/ast"

	"github.com/llir/llvm/ir/types"
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
	g.genExpr(x.Value)
}

func (g *generator) typ(x ast.Expr) types.Type {
	if typ, ok := g.types[x]; ok {
		switch typ {
		case ast.IntegerType:
			return types.I32
		case ast.BooleanType:
			return types.I1
		case ast.StringType:
			return g.str
		}
	}
	return types.Void
}

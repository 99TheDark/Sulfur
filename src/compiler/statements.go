package compiler

import (
	"fmt"
	"sulfur/src/ast"

	"github.com/llir/llvm/ir/value"
)

func (g *generator) genStmt(expr ast.Expr) {
	switch x := expr.(type) {
	case ast.Declaration:
		g.genBasicDecl(x.Name.Name, x.Value)
	case ast.ImplicitDecl:
		g.genBasicDecl(x.Name.Name, x.Value)
	case ast.FuncCall:
		g.genFuncCall(x)
	case ast.IfStatement:
		g.genIfStmt(x)
	default:
		fmt.Println("Ignored generating statement")
	}
}

func (g *generator) genBlock(x ast.Block) {
	for _, stmt := range x.Body {
		g.genStmt(stmt)
	}
}

func (g *generator) genFuncCall(x ast.FuncCall) {
	// TODO: Make work with non-builtins
	// TODO: Include return value in parameter as pointer if a struct
	bl := g.bl

	params := []value.Value{}
	for _, param := range x.Params {
		params = append(params, g.genExpr(param))
	}

	bl.NewCall(g.builtins[x.Func.Name], params...)
}

func (g *generator) genIfStmt(x ast.IfStatement) {
	id := fmt.Sprint(g.top.BlockCount)
	g.top.BlockCount++

	main := g.bl

	cond := g.genExpr(x.Cond)

	thenBl := g.topfunc.NewBlock("if.then" + id)
	main.NewBr(thenBl)

	if ast.Empty(x.Else) {
		/*endBl := g.topfunc.NewBlock("if.end" + id)
		thenBl.NewBr(endBl)

		g.bl = thenBl
		g.genBlock(x.Body)

		if g.bl == thenBl {
			g.bl = endBl
		}
		main.NewCondBr(cond, thenBl, endBl)*/
	} else {
		elseBl := g.topfunc.NewBlock("if.else" + id)

		g.bl = thenBl
		g.genBlock(x.Body)

		g.bl = elseBl
		g.genBlock(x.Else)

		main.NewCondBr(cond, thenBl, elseBl)

		endBl := g.topfunc.NewBlock("if.end" + id)
		thenBl.NewBr(endBl)
		elseBl.NewBr(endBl)

		if g.bl != elseBl {
			g.bl.NewBr(endBl)
		}
		g.bl = endBl
	}

	/*
		entry
		if cond {

		} else {
			if cond {

			} else {

			}
			end
		}
		end

		entry -> if.cond1
		if.then1
		if.else1 -> if.cond2
		if.then2
		if.else2
		if.end1
		if.end2
	*/
}

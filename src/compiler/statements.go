package compiler

import (
	"fmt"
	"sulfur/src/ast"
	"sulfur/src/lexer"

	"github.com/llir/llvm/ir/value"
)

func (g *generator) genStmt(expr ast.Expr) {
	switch x := expr.(type) {
	case ast.Declaration:
		g.genBasicDecl(x.Name.Name, g.genExpr(x.Value))
	case ast.ImplicitDecl:
		g.genBasicDecl(x.Name.Name, g.genExpr(x.Value))
	case ast.Assignment:
		g.genAssignment(x)
	case ast.IncDec:
		g.genIncDec(x)
	case ast.FuncCall:
		g.genFuncCall(x)
	case ast.IfStatement:
		g.genIfStmt(x)
	case ast.ForLoop:
		g.genForLoop(x)
	default:
		fmt.Println("Ignored generating statement")
	}
}

func (g *generator) genBlock(x ast.Block) {
	for _, stmt := range x.Body {
		g.genStmt(stmt)
	}
}

func (g *generator) genAssignment(x ast.Assignment) {
	if lexer.Empty(x.Op) {
		g.genBasicAssign(x.Name.Name, g.genExpr(x.Value))
	} else {
		bl := g.bl
		iden := *g.top.Lookup(x.Name.Name, x.Loc()).Value
		load := bl.NewLoad(g.typ(x.Value), iden)

		val := g.genBasicBinaryOp(load, g.genExpr(x.Value), x.Op.Type, g.types[x.Value])
		g.genBasicAssign(x.Name.Name, val)
	}
}

func (g *generator) genIncDec(x ast.IncDec) {
	bl := g.bl
	vari := g.top.Lookup(x.Name.Name, x.Loc())
	iden := *vari.Value
	typ := g.llraw(vari.Type)

	load := bl.NewLoad(typ, iden)

	var op lexer.TokenType
	switch x.Op.Type {
	case lexer.Increment:
		op = lexer.Addition
	case lexer.Decrement:
		op = lexer.Subtraction
	}

	val := g.genBasicBinaryOp(load, One, op, vari.Type)
	g.genBasicAssign(x.Name.Name, val)
}

func (g *generator) genFuncCall(x ast.FuncCall) {
	// TODO: Make work with non-builtins
	// TODO: Include return value in parameter as pointer if a struct
	bl := g.bl

	params := []value.Value{}
	for _, param := range *x.Params {
		params = append(params, g.genExpr(param))
	}

	bl.NewCall(g.builtins.funcs[x.Func.Name], params...)
}

func (g *generator) genIfStmt(x ast.IfStatement) {
	id := fmt.Sprint(g.top.BlockCount)
	g.top.BlockCount++

	main := g.bl

	cond := g.genExpr(x.Cond)

	thenBl := g.topfunc.NewBlock("if.then" + id)
	main.NewBr(thenBl)

	if ast.Empty(x.Else) {
		// TODO: Make if statements without else statements work
		g.bl = thenBl
		g.genBlock(x.Body)

		endBl := g.topfunc.NewBlock("if.end" + id)
		thenBl.NewBr(endBl)

		main.NewCondBr(cond, thenBl, endBl)

		if g.bl != endBl {
			g.bl.NewBr(endBl)
		}
		g.bl = endBl
	} else {
		elseBl := g.topfunc.NewBlock("if.else" + id)

		g.bl = thenBl
		g.genBlock(x.Body)

		g.bl = elseBl
		g.genBlock(x.Else)

		endBl := g.topfunc.NewBlock("if.end" + id)
		thenBl.NewBr(endBl)
		elseBl.NewBr(endBl)

		main.NewCondBr(cond, thenBl, elseBl)

		if g.bl != elseBl {
			g.bl.NewBr(endBl)
		}
		g.bl = endBl
	}
}

func (g *generator) genForLoop(x ast.ForLoop) {
	id := fmt.Sprint(g.top.BlockCount)
	g.top.BlockCount++

	main := g.bl

	condBl := g.topfunc.NewBlock("for.cond" + id)
	bodyBl := g.topfunc.NewBlock("for.body" + id)
	incBl := g.topfunc.NewBlock("for.inc" + id)
	endBl := g.topfunc.NewBlock("for.end" + id)

	g.scope(&x.Body.Scope, func() {
		g.genStmt(x.Init)

		g.bl = condBl
		cond := g.genExpr(x.Cond)
		condBl.NewCondBr(cond, bodyBl, endBl)

		g.bl = bodyBl
		g.genBlock(x.Body)
		bodyBl.NewBr(incBl)

		g.bl = incBl
		g.genStmt(x.Inc)
		incBl.NewBr(condBl)
	})

	main.NewBr(condBl)
	g.bl = endBl
}

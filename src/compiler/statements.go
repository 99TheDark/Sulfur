package compiler

import (
	"fmt"
	"strings"
	"sulfur/src/ast"
	"sulfur/src/lexer"
	"sulfur/src/typing"
	"sulfur/src/utils"

	. "sulfur/src/errors"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/enum"
	"github.com/llir/llvm/ir/value"
)

func (g *generator) genStmt(expr ast.Expr) {
	switch x := expr.(type) {
	case ast.Declaration:
		g.genBasicDecl(x.Name.Name, g.typ(x.Value), g.genExpr(x.Value), x.Name.Loc())
	case ast.ImplicitDecl:
		g.genBasicDecl(x.Name.Name, g.typ(x.Value), g.genExpr(x.Value), x.Name.Loc())
	case ast.Assignment:
		g.genAssignment(x)
	case ast.IncDec:
		g.genIncDec(x)
	case ast.Function:
		g.genFunction(x)
	case ast.FuncCall:
		g.genFuncCall(x)
	case ast.IfStatement:
		g.genIfStmt(x)
	case ast.ForLoop:
		g.genForLoop(x)
	case ast.WhileLoop:
		g.genWhileLoop(x)
	case ast.DoWhileLoop:
		g.genDoWhileLoop(x)
	case ast.Return:
		g.genReturn(x)
	case ast.Break:
		g.genBreak(x)
	case ast.Continue:
		g.genContinue(x)
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
		g.genBasicAssign(x.Name.Name, g.genExpr(x.Value), x.Name.Loc())
	} else {
		vari := g.top.Lookup(x.Name.Name, x.Loc())
		iden := g.genBasicIden(vari)

		val := g.genBasicBinaryOp(iden, g.genExpr(x.Value), x.Op.Type, g.Types[x.Value])

		g.genBasicAssign(x.Name.Name, val, x.Name.Loc())
	}
}

func (g *generator) genIncDec(x ast.IncDec) {
	vari := g.top.Lookup(x.Name.Name, x.Loc())
	iden := g.genBasicIden(vari)

	var op lexer.TokenType
	switch x.Op.Type {
	case lexer.Increment:
		op = lexer.Addition
	case lexer.Decrement:
		op = lexer.Subtraction
	}

	var val value.Value
	switch vari.Type {
	case typing.Integer:
		val = g.genBasicBinaryOp(iden, One, op, vari.Type)
	case typing.Float:
		val = g.genBasicBinaryOp(iden, FOne, op, vari.Type)
	default:
		Errors.Error("Unexpected generating error during "+strings.ToLower(x.Op.Type.String()), x.Loc())
	}
	g.genBasicAssign(x.Name.Name, val, x.Loc())
}

func (g *generator) genFunction(x ast.Function) {
	src := g.srcFunc(x.Name.Name)
	if src == nil {
		return
	}

	complex := g.complex(src.Return)
	rettyp := g.lltyp(src.Return)

	src.Ir.Linkage = enum.LinkagePrivate

	entry := src.Ir.NewBlock("entry")
	exit := src.Ir.NewBlock("exit")

	exits := utils.NewStack[*ir.Block]()
	exits.Push(exit)

	var ret value.Value
	if src.Return != typing.Void {
		alloca := entry.NewAlloca(rettyp)
		alloca.LocalName = ".ret"
		ret = alloca
	} else {
		ret = nil
	}

	for i, param := range x.Params {
		vari := x.Body.Scope.Vars[param.Name.Name]
		vari.Value = src.Params[i].Ir
	}

	g.ctx = &context{
		g.ctx,
		src.Ir,
		ret,
		complex,
		exits,
		0,
	}

	bl := g.bl
	g.bl = entry
	g.top = x.Body.Scope
	g.topfun = x.FuncScope

	g.genAllocas(g.topfun)

	for _, expr := range x.Body.Body {
		g.genStmt(expr)
	}
	g.exit()

	if src.Return == typing.Void {
		exit.NewRet(nil)
	} else {
		load := exit.NewLoad(rettyp, ret)
		exit.NewRet(load)
	}

	g.ctx = g.ctx.parent
	g.bl = bl
	g.top = x.Body.Scope.Parent
	g.topfun = x.FuncScope.Parent
}

func (g *generator) genIfStmt(x ast.IfStatement) {
	main := g.bl
	top := g.ctx.fun
	id := g.id()

	cond := g.genExpr(x.Cond)

	thenBl := top.NewBlock("if.then" + id)
	if ast.Empty(x.Else) {
		endBl := top.NewBlock("if.end" + id)

		g.scope(x.Body.Scope, func() {
			g.enter(endBl)
			g.bl = thenBl
			g.genBlock(x.Body)
		})
		g.exit()

		main.NewCondBr(cond, thenBl, endBl)
		g.bl = endBl
	} else {
		elseBl := top.NewBlock("if.else" + id)
		endBl := top.NewBlock("if.end" + id)

		g.scope(x.Body.Scope, func() {
			g.enter(endBl)
			g.bl = thenBl
			g.genBlock(x.Body)
		})
		g.exit()

		g.scope(x.Else.Scope, func() {
			g.enter(endBl)
			g.bl = elseBl
			g.genBlock(x.Else)
		})
		g.exit()

		main.NewCondBr(cond, thenBl, elseBl)
		g.bl = endBl
	}
}

func (g *generator) genForLoop(x ast.ForLoop) {
	main := g.bl
	top := g.ctx.fun
	id := g.id()

	g.scope(x.Body.Scope, func() {
		condBl := top.NewBlock("for.cond" + id)
		bodyBl := top.NewBlock("for.body" + id)
		incBl := top.NewBlock("for.inc" + id)
		endBl := top.NewBlock("for.end" + id)

		x.Body.Scope.Entrance = incBl
		x.Body.Scope.Exit = endBl

		g.genStmt(x.Init)

		g.bl = condBl
		cond := g.genExpr(x.Cond)

		g.bl = bodyBl
		g.genBlock(x.Body)

		g.bl.NewBr(incBl)

		g.bl = incBl
		g.genStmt(x.Inc)
		incBl.NewBr(condBl)

		condBl.NewCondBr(cond, bodyBl, endBl)

		main.NewBr(condBl)
		g.bl = endBl
	})
}

func (g *generator) genWhileLoop(x ast.WhileLoop) {
	main := g.bl
	top := g.ctx.fun
	id := g.id()

	g.scope(x.Body.Scope, func() {
		condBl := top.NewBlock("while.cond" + id)
		bodyBl := top.NewBlock("while.body" + id)
		endBl := top.NewBlock("while.end" + id)

		x.Body.Scope.Entrance = condBl
		x.Body.Scope.Exit = endBl

		g.bl = condBl
		cond := g.genExpr(x.Cond)

		g.enter(condBl)
		g.bl = bodyBl
		g.genBlock(x.Body)
		g.exit()

		condBl.NewCondBr(cond, bodyBl, endBl)

		main.NewBr(condBl)
		g.bl = endBl
	})
}

func (g *generator) genDoWhileLoop(x ast.DoWhileLoop) {
	main := g.bl
	top := g.ctx.fun
	id := g.id()

	g.scope(x.Body.Scope, func() {
		condBl := top.NewBlock("while.cond" + id)
		bodyBl := top.NewBlock("while.body" + id)
		endBl := top.NewBlock("while.end" + id)

		x.Body.Scope.Entrance = condBl
		x.Body.Scope.Exit = endBl

		g.bl = condBl
		cond := g.genExpr(x.Cond)

		g.enter(condBl)
		g.bl = bodyBl
		g.genBlock(x.Body)
		g.exit()

		condBl.NewCondBr(cond, bodyBl, endBl)

		main.NewBr(bodyBl)
		g.bl = endBl
	})
}

func (g *generator) genReturn(x ast.Return) {
	bl := g.bl

	if g.ctx.ret != nil {
		val := g.genExpr(x.Value)
		if g.ctx.complex {
			store := bl.NewStore(val, g.ctx.ret)
			store.Align = 8
		} else {
			bl.NewStore(val, g.ctx.ret)
		}
	}

	g.breaks[g.bl] = true
	bl.NewBr(g.ctx.exits.Final())
}

func (g *generator) genBreak(x ast.Break) {
	bl := g.bl
	exit := g.top.FindExit(x.Loc())

	g.breaks[g.bl] = true
	bl.NewBr(exit)
}

func (g *generator) genContinue(x ast.Continue) {
	bl := g.bl
	entrance := g.top.FindEntrance(x.Loc())

	g.breaks[g.bl] = true
	bl.NewBr(entrance)
}

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
	case ast.FuncCall:
		g.genFuncCall(x)
	case ast.Return:
		g.genReturn(x)
	case ast.Function:
		g.genFunction(x)
	case ast.IfStatement:
		g.genIfStmt(x)
	case ast.ForLoop:
		g.genForLoop(x)
	case ast.WhileLoop:
		g.genWhileLoop(x)
	case ast.DoWhileLoop:
		g.genDoWhileLoop(x)
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
		bl := g.bl
		iden := *g.top.Lookup(x.Name.Name, x.Loc()).Value
		load := bl.NewLoad(g.typ(x.Value), iden)

		val := g.genBasicBinaryOp(load, g.genExpr(x.Value), x.Op.Type, g.types[x.Value])
		g.genBasicAssign(x.Name.Name, val, x.Name.Loc())
	}
}

func (g *generator) genIncDec(x ast.IncDec) {
	bl := g.bl
	vari := g.top.Lookup(x.Name.Name, x.Loc())
	iden := *vari.Value
	typ := g.lltyp(vari.Type)

	load := bl.NewLoad(typ, iden)

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
		val = g.genBasicBinaryOp(load, One, op, vari.Type)
	case typing.Float:
		val = g.genBasicBinaryOp(load, FOne, op, vari.Type)
	default:
		Errors.Error("Unexpected generating error during "+strings.ToLower(x.Op.Type.String()), x.Loc())
	}
	g.genBasicAssign(x.Name.Name, val, x.Loc())
}

func (g *generator) genReturn(x ast.Return) {
	bl := g.bl
	val := g.genExpr(x.Value)

	if g.ctx.ret != nil {
		if g.ctx.complex {
			store := bl.NewStore(val, g.ctx.ret)
			store.Align = 8
		} else {
			bl.NewStore(val, g.ctx.ret)
		}
	}
	bl.NewBr(g.ctx.exits.Final())
}

func (g *generator) genFunction(x ast.Function) {
	src := g.srcFunc(x.Name.Name)
	complex := g.complex(src.Return)

	for i, param := range x.Params {
		vari := x.Body.Scope.Vars[param.Name.Name]
		*vari.Value = src.Params[i].Ir
	}

	entry := src.Ir.NewBlock("entry")
	exit := src.Ir.NewBlock("exit")

	exits := utils.NewStack[*ir.Block]()
	exits.Push(exit)

	rettyp := g.lltyp(src.Return)
	alloca := entry.NewAlloca(rettyp)
	alloca.LocalName = ".ret"

	g.ctx = &context{
		g.ctx,
		src.Ir,
		alloca,
		complex,
		exits,
		0,
	}

	bl := g.bl
	g.bl = entry
	g.top = &x.Body.Scope
	for _, expr := range x.Body.Body {
		g.genStmt(expr)
	}
	g.exit()

	if src.Return == typing.Void {
		exit.NewRet(nil)
	} else {
		load := exit.NewLoad(src.Ir.Sig.RetType, alloca) // TODO: Switch to rettyp
		exit.NewRet(load)
	}

	g.ctx = g.ctx.parent
	g.bl = bl
	g.top = x.Body.Scope.Parent
}

func (g *generator) genIfStmt(x ast.IfStatement) {
	main := g.bl
	top := g.ctx.fun
	id := g.id()

	cond := g.genExpr(x.Cond)

	thenBl := top.NewBlock("if.then" + id)
	if ast.Empty(x.Else) {
		endBl := top.NewBlock("if.end" + id)

		g.scope(&x.Body.Scope, func() {
			g.enter(endBl)
			g.bl = thenBl
			g.genBlock(x.Body)
			g.exit()
		})

		main.NewCondBr(cond, thenBl, endBl)
		g.bl = endBl
	} else {
		elseBl := top.NewBlock("if.else" + id)
		endBl := top.NewBlock("if.end" + id)

		g.scope(&x.Body.Scope, func() {
			g.enter(endBl)
			g.bl = thenBl
			g.genBlock(x.Body)
			g.exit()
		})

		g.scope(&x.Else.Scope, func() {
			g.enter(endBl)
			g.bl = elseBl
			g.genBlock(x.Else)
			g.exit()
		})

		main.NewCondBr(cond, thenBl, elseBl)
		g.bl = endBl
	}
}

func (g *generator) genForLoop(x ast.ForLoop) {
	main := g.bl
	top := g.ctx.fun
	id := g.id()

	g.scope(&x.Body.Scope, func() {
		condBl := top.NewBlock("for.cond" + id)
		bodyBl := top.NewBlock("for.body" + id)
		incBl := top.NewBlock("for.inc" + id)
		endBl := top.NewBlock("for.end" + id)

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

	g.scope(&x.Body.Scope, func() {
		condBl := top.NewBlock("while.cond" + id)
		bodyBl := top.NewBlock("while.body" + id)
		endBl := top.NewBlock("while.end" + id)

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

	g.scope(&x.Body.Scope, func() {
		condBl := top.NewBlock("while.cond" + id)
		bodyBl := top.NewBlock("while.body" + id)
		endBl := top.NewBlock("while.end" + id)

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

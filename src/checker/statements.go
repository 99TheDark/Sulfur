package checker

import (
	"fmt"
	"sulfur/src/ast"
	. "sulfur/src/errors"
	"sulfur/src/lexer"
	"sulfur/src/typing"
)

func (c *checker) inferStmt(expr ast.Expr) {
	switch x := expr.(type) {
	case ast.Declaration:
		c.inferDeclaration(x)
	case ast.ImplicitDecl:
		c.inferImplicitDecl(x)
	case ast.Assignment:
		c.inferAssignment(x)
	case ast.IncDec:
		c.inferIncDec(x)
	case ast.Function:
		c.inferFunction(x)
	case ast.FuncCall:
		c.inferFuncCall(x)
	case ast.IfStatement:
		c.inferIfStmt(x)
	case ast.ForLoop:
		c.inferForLoop(x)
	case ast.WhileLoop:
		c.inferWhileLoop(x)
	case ast.DoWhileLoop:
		c.inferDoWhileLoop(x)
	case ast.Return:
		c.inferReturn(x)
	case ast.Break:
		c.inferBreak(x)
	case ast.Continue:
		c.inferContinue(x)
	default:
		fmt.Println("Ignored type inferring statement")
	}
}

func (c *checker) inferBlock(x ast.Block, header func()) {
	c.top = x.Scope
	if header != nil {
		header()
	}
	for _, x := range x.Body {
		c.inferStmt(x)
	}
	c.top = x.Scope.Parent
}

func (c *checker) inferDeclaration(x ast.Declaration) {
	if c.top.Has(x.Name.Name) {
		Errors.Error(x.Name.Name+" is already defined", x.Name.Loc())
	}

	val := c.inferExpr(x.Value)
	if val == typing.Void {
		Errors.Error("Cannot declare a variable to have no type", x.Value.Loc())
	}

	if typing.Type(x.Type.Name) != val {
		Errors.Error("Expected "+x.Type.Name+", but got "+val.String()+" instead", x.Loc())
	}

	c.top.Vars[x.Name.Name] = ast.NewVariable(c.topfun, x.Name.Name, c.Refs.Has(x.Value), val, ast.Local)
}

func (c *checker) inferImplicitDecl(x ast.ImplicitDecl) {
	if c.top.Has(x.Name.Name) {
		Errors.Error(x.Name.Name+" is already defined", x.Name.Loc())
	}

	val := c.inferExpr(x.Value)
	if val == typing.Void {
		Errors.Error("Cannot declare a variable to have no type", x.Value.Loc())
	}

	c.top.Vars[x.Name.Name] = ast.NewVariable(c.topfun, x.Name.Name, c.Refs.Has(x.Value), val, ast.Local)
}

func (c *checker) inferAssignment(x ast.Assignment) {
	vari := c.top.Lookup(x.Name.Name, x.Name.Pos)
	if vari.Status == ast.Parameter && !vari.References {
		Errors.Error("Illegal modification of a parameter", x.Value.Loc())
	}

	val := c.inferExpr(x.Value)
	if vari.Type != val {
		conv, ok := c.AutoSingleInfer(val, vari.Type, x.Value)
		if ok {
			val, _ = AutoSwitch(val, vari.Type, conv)
		} else {
			Errors.Error("Expected "+vari.Type.String()+", but got "+val.String()+" instead", x.Loc())
		}
	}

	if lexer.Empty(x.Op) {
		return
	}

	for i, binop := range c.program.BinaryOps {
		if binop.Op != x.Op.Type {
			continue
		}

		if binop.Left == vari.Type && binop.Right == val {
			binop.Uses++
			c.program.BinaryOps[i] = binop

			return
		}
	}

	Errors.Error("No operation "+x.Op.Value+" exists for "+vari.Type.String()+" and "+val.String(), x.Op.Location)
}

func (c *checker) inferIncDec(x ast.IncDec) {
	vari := c.top.Lookup(x.Name.Name, x.Name.Pos)
	if vari.Status == ast.Parameter && !vari.Referenced {
		Errors.Error("Illegal modification of a parameter", x.Name.Loc())
	}

	for _, id := range c.program.IncDecs {
		if id.Op != x.Op.Type {
			continue
		}

		if id.Var == vari.Type {
			return
		}
	}

	Errors.Error("No operation "+x.Op.Value+" exists for "+vari.Type.String(), x.Op.Location)
}

func (c *checker) inferFunction(x ast.Function) {
	c.topfun = &ast.FuncScope{
		Parent: c.topfun,
		Return: typing.Type(x.Return.Name),
		Counts: make(map[string]int),
	}
	c.inferBlock(x.Body, func() {
		for _, param := range x.Params {
			if param.Referenced {
				c.program.References.Add(typing.Type(param.Type.Name))
			}

			c.top.Vars[param.Name.Name] = ast.NewVariable(
				c.topfun,
				param.Name.Name,
				param.Referenced,
				typing.Type(param.Type.Name),
				ast.Parameter,
			)
		}
	})
	c.topfun = c.topfun.Parent
}

func (c *checker) inferIfStmt(x ast.IfStatement) {
	cond := c.inferExpr(x.Cond)
	if cond != typing.Boolean {
		Errors.Error("Expected "+typing.Boolean+", but got "+cond.String()+" instead", x.Cond.Loc())
	}

	c.inferBlock(x.Body, nil)
	if !ast.Empty(x.Else) {
		c.inferBlock(x.Else, nil)
	}
}

func (c *checker) inferForLoop(x ast.ForLoop) {
	x.Body.Scope.Loop = true

	c.inferBlock(x.Body, func() {
		c.inferStmt(x.Init)
		cond := c.inferExpr(x.Cond)
		if cond != typing.Boolean {
			Errors.Error("Expected "+typing.Boolean+", but got "+cond.String()+" instead", x.Cond.Loc())
		}
		c.inferStmt(x.Inc)
	})
}

func (c *checker) inferWhileLoop(x ast.WhileLoop) {
	x.Body.Scope.Loop = true

	cond := c.inferExpr(x.Cond)
	if cond != typing.Boolean {
		Errors.Error("Expected "+typing.Boolean+", but got "+cond.String()+" instead", x.Cond.Loc())
	}

	c.inferBlock(x.Body, nil)
}

func (c *checker) inferDoWhileLoop(x ast.DoWhileLoop) {
	x.Body.Scope.Loop = true

	cond := c.inferExpr(x.Cond)
	if cond != typing.Boolean {
		Errors.Error("Expected "+typing.Boolean+", but got "+cond.String()+" instead", x.Cond.Loc())
	}

	c.inferBlock(x.Body, nil)
}

func (c *checker) inferReturn(x ast.Return) {
	if c.topfun.Parent == nil {
		Errors.Error("Cannot use a return statement outside of a function", x.Pos)
	}
	val := c.inferExpr(x.Value)
	ret := c.topfun.Return
	if ret != val {
		Errors.Error("Expected "+ret.String()+", but got "+val.String()+" instead", x.Loc())
	}
}

func (c *checker) inferBreak(x ast.Break) {
	if !c.top.InLoop() {
		Errors.Error("Can only use a break statement inside a loop", x.Loc())
	}
}

func (c *checker) inferContinue(x ast.Continue) {
	if !c.top.InLoop() {
		Errors.Error("Can only use a continue statement inside a loop", x.Loc())
	}
}

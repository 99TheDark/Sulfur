package checker

import (
	"fmt"
	"sulfur/src/ast"
	. "sulfur/src/errors"
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
	case ast.FuncCall:
		c.inferFuncCall(x)
	default:
		fmt.Println("Ignored type inferring statement")
	}
}

func (c *checker) inferBlock(x ast.Block, header func()) {
	c.top = &x.Scope
	if header != nil {
		header()
	}
	for _, x := range x.Body {
		c.inferStmt(x)
	}
	c.top = x.Scope.Parent
}

func (c *checker) inferDeclaration(x ast.Declaration) {
	val := c.inferExpr(x.Value)
	if typing.Type(x.Type.Name) != val {
		Errors.Error("Expected "+x.Type.Name+", but got "+val.String()+" instead", x.Loc())
	}
	c.top.Vars[x.Name.Name] = ast.NewVariable(typing.Type(x.Type.Name), ast.Local)
}

func (c *checker) inferImplicitDecl(x ast.ImplicitDecl) {
	val := c.inferExpr(x.Value)
	c.top.Vars[x.Name.Name] = ast.NewVariable(val, ast.Local)
}

func (c *checker) inferAssignment(x ast.Assignment) {
	// TODO: Check if operator is legal
	vari := c.top.Lookup(x.Name.Name, x.Name.Pos)
	val := c.inferExpr(x.Value)
	if vari.Type != val {
		Errors.Error("Expected "+vari.Type.String()+", but got "+val.String()+" instead", x.Loc())
	}
}

func (c *checker) inferIncDec(x ast.IncDec) {
	// TODO: Check if operator is legal
	c.top.Lookup(x.Name.Name, x.Name.Pos)
}

func (c *checker) inferFunction(x ast.Function) {
	// TODO: Check if function already exists
	c.program.Functions = append(c.program.Functions, x)

	c.ret = &ast.Func{
		Parent: c.ret,
		Return: typing.Type(x.Return.Name),
	}
	c.inferBlock(x.Body, func() {
		for _, param := range x.Params {
			c.top.Vars[param.Name.Name] = ast.NewVariable(typing.Type(param.Type.Name), ast.Parameter)
		}
	})
	c.ret = c.ret.Parent
}

func (c *checker) inferIfStmt(x ast.IfStatement) {
	cond := c.inferExpr(x.Cond)
	if cond != typing.BooleanType {
		Errors.Error("Expected "+typing.BooleanType+", but got "+cond.String()+" instead", x.Cond.Loc())
	}

	c.inferBlock(x.Body, nil)
	if !ast.Empty(x.Else) {
		c.inferBlock(x.Else, nil)
	}
}

func (c *checker) inferForLoop(x ast.ForLoop) {
	c.inferBlock(x.Body, func() {
		c.inferStmt(x.Init)
		cond := c.inferExpr(x.Cond)
		if cond != typing.BooleanType {
			Errors.Error("Expected "+typing.BooleanType+", but got "+cond.String()+" instead", x.Cond.Loc())
		}
		c.inferStmt(x.Inc)
	})
}

func (c *checker) inferWhileLoop(x ast.WhileLoop) {
	cond := c.inferExpr(x.Cond)
	if cond != typing.BooleanType {
		Errors.Error("Expected "+typing.BooleanType+", but got "+cond.String()+" instead", x.Cond.Loc())
	}

	c.inferBlock(x.Body, nil)
}

func (c *checker) inferDoWhileLoop(x ast.DoWhileLoop) {
	cond := c.inferExpr(x.Cond)
	if cond != typing.BooleanType {
		Errors.Error("Expected "+typing.BooleanType+", but got "+cond.String()+" instead", x.Cond.Loc())
	}

	c.inferBlock(x.Body, nil)
}

func (c *checker) inferReturn(x ast.Return) {
	if c.ret == nil {
		Errors.Error("Cannot use a return statement outside of a function", x.Pos)
	}
	val := c.inferExpr(x.Value)
	ret := c.ret.Return
	if ret != val {
		Errors.Error("Expected "+ret.String()+", but got "+val.String()+" instead", x.Loc())
	}
}

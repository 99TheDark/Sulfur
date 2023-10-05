package checker

import (
	"fmt"
	"sulfur/src/ast"
	. "sulfur/src/errors"
)

func (c *checker) inferStmt(expr ast.Expr) {
	switch x := expr.(type) {
	case ast.Declaration:
		c.inferDeclaration(x)
	case ast.ImplicitDecl:
		c.inferImplicitDecl(x)
	case ast.Assignment:
		c.inferAssignment(x)
	case ast.IfStatement:
		c.inferIfStmt(x)
	default:
		fmt.Println("Ignored type inferring statement")
	}
}

func (c *checker) inferBlock(x ast.Block) {
	c.top = &x.Scope
	for _, x := range x.Body {
		c.inferStmt(x)
	}
	c.top = x.Scope.Parent
}

func (c *checker) inferIfStmt(x ast.IfStatement) {
	cond := c.inferExpr(x.Cond)
	if cond != ast.BooleanType {
		Errors.Error("Expected "+ast.BooleanType+", but got "+cond.String()+" instead", x.Cond.Loc())
	}

	c.inferBlock(x.Body)
	if !ast.Empty(x.Else) {
		c.inferBlock(x.Else)
	}
}

func (c *checker) inferDeclaration(x ast.Declaration) {
	val := c.inferExpr(x.Value)
	if ast.Type(x.Type.Name) != val {
		Errors.Error("Expected "+x.Type.Name+", but got "+val.String()+" instead", x.Loc())
	}
	c.top.Vars[x.Name.Name] = ast.NewVariable(ast.Type(x.Type.Name), ast.Local)
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

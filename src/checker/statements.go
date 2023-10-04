package checker

import (
	"fmt"
	"sulfur/src/ast"
	. "sulfur/src/errors"
)

func (c *checker) inferStmt(expr ast.Expr) {
	switch x := expr.(type) {
	case ast.IfStatement:
		c.inferIfStmt(x)
	default:
		fmt.Println(x, "Ignored type inferring")
	}
}

func (c *checker) inferBlock(x ast.Block) {
	for _, x := range x.Body {
		c.inferStmt(x)
	}
}

func (c *checker) inferIfStmt(x ast.IfStatement) {
	cond := c.inferExpr(x.Cond)
	if cond != Boolean {
		Errors.Error("Expected "+string(Boolean)+", instead got "+string(cond), x.Cond.Loc())
	}

	c.inferBlock(x.Body)
	c.inferBlock(x.Else)
}

func (c *checker) inferDeclaration(x ast.Declaration) {
	// TODO: Assign variable type
	val := c.inferExpr(x.Value)
	if Type(x.Type.Name) == val {
		Errors.Error("Expected "+x.Type.Name+", instead got "+string(val), x.Loc())
	}
}

func (c *checker) inferImplicitDecl(x ast.ImplicitDecl) {
	// TODO: Assign variable type
	c.inferExpr(x.Value)
}

func (c *checker) inferAssignment(x ast.Assignment) {
	// TODO: Check variable type
	// TODO: Check if operator is legal
	c.inferExpr(x.Value)
}

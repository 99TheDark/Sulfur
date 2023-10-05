package checker

import (
	"fmt"
	"sulfur/src/ast"
	. "sulfur/src/errors"
)

func (c *checker) inferExpr(expr ast.Expr) ast.Type {
	switch x := expr.(type) {
	case ast.Identifier:
		return c.inferIdentifier(x)
	case ast.Integer:
		return ast.IntegerType
	case ast.Float:
		return ast.FloatType
	case ast.Boolean:
		return ast.BooleanType
	case ast.String:
		return ast.StringType
	case ast.BinaryOp:
		return c.inferBinaryOp(x)
	case ast.UnaryOp:
		return c.inferUnaryOp(x)
	case ast.Comparison:
		return c.inferComparison(x)
	case ast.TypeCast:
		return c.inferTypeCast(x)
	default:
		fmt.Println("Ignored type inferring expression")
		return ast.VoidType
	}
}

func (c *checker) inferIdentifier(x ast.Identifier) ast.Type {
	return c.top.Lookup(x.Name, x.Pos).Type
}

func (c *checker) inferBinaryOp(x ast.BinaryOp) ast.Type {
	// TODO: Check if operator exists
	left := c.inferExpr(x.Left)
	right := c.inferExpr(x.Right)
	if left != right {
		Errors.Error("Expected "+left.String()+", but got "+right.String()+" instead", x.Loc())
	}
	return left
}

func (c *checker) inferUnaryOp(x ast.UnaryOp) ast.Type {
	// TODO: Check if operator exists
	return c.inferExpr(x.Value)
}

func (c *checker) inferComparison(x ast.Comparison) ast.Type {
	// TODO: Check if operator exists
	left := c.inferExpr(x.Left)
	right := c.inferExpr(x.Right)
	if left != right {
		Errors.Error("Expected "+left.String()+", but got "+right.String()+" instead", x.Loc())
	}
	return ast.BooleanType
}

func (c *checker) inferTypeCast(x ast.TypeCast) ast.Type {
	// TODO: Check if ast.Type can be casted
	c.inferExpr(x.Value)
	return ast.Type(x.Type.Name)
}

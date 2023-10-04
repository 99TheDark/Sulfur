package checker

import (
	"fmt"
	"sulfur/src/ast"
	. "sulfur/src/errors"
)

func (c *checker) inferExpr(expr ast.Expr) Type {
	switch x := expr.(type) {
	case ast.Identifier:
		return c.inferIdentifier(x)
	case ast.Integer:
		return Integer
	case ast.Float:
		return Float
	case ast.Boolean:
		return Boolean
	case ast.String:
		return String
	case ast.BinaryOp:
		return c.inferBinaryOp(x)
	case ast.UnaryOp:
		return c.inferUnaryOp(x)
	case ast.Comparison:
		return c.inferComparison(x)
	case ast.TypeCast:
		return c.inferTypeCast(x)
	default:
		fmt.Println(x, "Ignored type inferring")
		return Void
	}
}

func (c *checker) inferIdentifier(x ast.Identifier) Type {
	// TODO: Access variable type
	return Void
}

func (c *checker) inferBinaryOp(x ast.BinaryOp) Type {
	// TODO: Check if operator exists
	left := c.inferExpr(x.Left)
	right := c.inferExpr(x.Right)
	if left != right {
		Errors.Error("Expected "+string(left)+", instead got "+string(right), x.Loc())
	}
	return left
}

func (c *checker) inferUnaryOp(x ast.UnaryOp) Type {
	// TODO: Check if operator exists
	return c.inferExpr(x.Value)
}

func (c *checker) inferComparison(x ast.Comparison) Type {
	// TODO: Check if operator exists
	left := c.inferExpr(x.Left)
	right := c.inferExpr(x.Right)
	if left != right {
		Errors.Error("Expected "+string(left)+", instead got "+string(right), x.Loc())
	}
	return Boolean
}

func (c *checker) inferTypeCast(x ast.TypeCast) Type {
	// TODO: Check if type can be casted
	c.inferExpr(x.Value)
	return Type(x.Type.Name)
}

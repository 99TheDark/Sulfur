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
		return c.typ(x, ast.IntegerType)
	case ast.Float:
		return c.typ(x, ast.FloatType)
	case ast.Boolean:
		return c.typ(x, ast.BooleanType)
	case ast.String:
		c.program.Strings = append(c.program.Strings, x)
		return c.typ(x, ast.StringType)
	case ast.BinaryOp:
		return c.inferBinaryOp(x)
	case ast.UnaryOp:
		return c.inferUnaryOp(x)
	case ast.Comparison:
		return c.inferComparison(x)
	case ast.TypeCast:
		return c.inferTypeCast(x)
	case ast.FuncCall:
		return c.inferFuncCall(x)
	default:
		fmt.Println("Ignored type inferring expression")
		return c.typ(x, ast.VoidType)
	}
}

func (c *checker) inferIdentifier(x ast.Identifier) ast.Type {
	return c.typ(x, c.top.Lookup(x.Name, x.Pos).Type)
}

func (c *checker) inferBinaryOp(x ast.BinaryOp) ast.Type {
	// TODO: Check if operator exists
	left := c.inferExpr(x.Left)
	right := c.inferExpr(x.Right)
	if left != right {
		Errors.Error("Expected "+left.String()+", but got "+right.String()+" instead", x.Right.Loc())
	}
	return c.typ(x, left)
}

func (c *checker) inferUnaryOp(x ast.UnaryOp) ast.Type {
	// TODO: Check if operator exists
	return c.typ(x, c.inferExpr(x.Value))
}

func (c *checker) inferComparison(x ast.Comparison) ast.Type {
	// TODO: Check if operator exists
	left := c.inferExpr(x.Left)
	right := c.inferExpr(x.Right)
	if left != right {
		Errors.Error("Expected "+left.String()+", but got "+right.String()+" instead", x.Loc())
	}
	return c.typ(x, ast.BooleanType)
}

func (c *checker) inferTypeCast(x ast.TypeCast) ast.Type {
	// TODO: Check if type can be casted
	c.inferExpr(x.Value)
	return c.typ(x, ast.Type(x.Type.Name))
}

func (c *checker) inferFuncCall(x ast.FuncCall) ast.Type {
	for _, fun := range c.program.Functions {
		if fun.Name.Name == x.Func.Name {
			// TODO: Check if parameters are correct
			return ast.Type(fun.Return.Name)
		}
	}
	return c.typ(x, ast.VoidType)
}

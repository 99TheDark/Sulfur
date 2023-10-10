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
	// TODO: Error if type is casted to itself
	c.inferExpr(x.Value)
	return c.typ(x, ast.Type(x.Type.Name))
}

func (c *checker) inferFuncCall(x ast.FuncCall) ast.Type {
	// TODO: Allow builtins
	for _, fun := range c.program.Functions {
		// TODO: Allow function overloading
		if fun.Name.Name == x.Func.Name {
			l1, l2 := len(fun.Params), len(x.Params)
			if l1 != l2 {
				Errors.Error("Only "+fmt.Sprint(l1)+" parameters given, but "+fmt.Sprint(l2)+" expected", x.Func.Pos)
			}

			for i, param := range x.Params {
				typ := c.inferExpr(param)
				paramTyp := ast.Type(fun.Params[i].Type.Name)
				if typ != paramTyp {
					Errors.Error("Expected "+paramTyp.String()+", but got "+typ.String()+" instead", param.Loc())
				}
			}

			return ast.Type(fun.Return.Name)
		}
	}
	Errors.Error("The function "+x.Func.Name+" is undefined", x.Func.Pos)
	return c.typ(x, ast.VoidType)
}

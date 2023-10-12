package checker

import (
	"fmt"
	"sulfur/src/ast"
	. "sulfur/src/errors"
	"sulfur/src/typing"
)

func (c *checker) inferExpr(expr ast.Expr) typing.Type {
	switch x := expr.(type) {
	case ast.Identifier:
		return c.inferIdentifier(x)
	case ast.Integer:
		return c.typ(x, typing.Integer)
	case ast.Float:
		return c.typ(x, typing.Float)
	case ast.Boolean:
		return c.typ(x, typing.Boolean)
	case ast.String:
		c.program.Strings = append(c.program.Strings, x)
		return c.typ(x, typing.String)
	case ast.BinaryOp:
		return c.inferBinaryOp(x)
	case ast.UnaryOp:
		return c.inferUnaryOp(x)
	case ast.Comparison:
		return c.inferComparison(x)
	case ast.TypeConv:
		return c.inferTypeConv(x)
	case ast.FuncCall:
		return c.inferFuncCall(x)
	default:
		fmt.Println("Ignored type inferring expression")
		return c.typ(x, typing.Void)
	}
}

func (c *checker) inferIdentifier(x ast.Identifier) typing.Type {
	return c.typ(x, c.top.Lookup(x.Name, x.Pos).Type)
}

func (c *checker) inferBinaryOp(x ast.BinaryOp) typing.Type {
	left := c.inferExpr(x.Left)
	right := c.inferExpr(x.Right)
	if left != right {
		Errors.Error("Expected "+left.String()+", but got "+right.String()+" instead", x.Right.Loc())
	}

	for _, binop := range c.program.BinaryOps {
		if binop.Op != x.Op.Type {
			continue
		}

		if binop.Left == left && binop.Right == right {
			return c.typ(x, binop.Return)
		}
	}

	Errors.Error("No operation "+x.Op.Value+" exists for "+left.String()+" and "+right.String(), x.Op.Location)
	return c.typ(x, typing.Void)
}

func (c *checker) inferUnaryOp(x ast.UnaryOp) typing.Type {
	val := c.inferExpr(x.Value)
	for _, unop := range c.program.UnaryOps {
		if unop.Op != x.Op.Type {
			continue
		}

		if unop.Value == val {
			return c.typ(x, unop.Return)
		}
	}

	Errors.Error("No operation "+x.Op.Value+" exists for "+val.String(), x.Op.Location)
	return c.typ(x, typing.Void)
}

func (c *checker) inferComparison(x ast.Comparison) typing.Type {
	// TODO: Check if comparison exists
	left := c.inferExpr(x.Left)
	right := c.inferExpr(x.Right)
	if left != right {
		Errors.Error("Expected "+left.String()+", but got "+right.String()+" instead", x.Loc())
	}
	return c.typ(x, typing.Boolean)
}

func (c *checker) inferTypeConv(x ast.TypeConv) typing.Type {
	typ := c.inferExpr(x.Value)
	if typ == typing.Type(x.Type.Name) {
		Errors.Error("Cannot convert type to itself", x.Loc())
	}

	for _, conv := range c.program.TypeConvs {
		if conv.From == typ && conv.To == typing.Type(x.Type.Name) {
			return c.typ(x, conv.To)
		}
	}

	Errors.Error("Cannot convert from "+typ.String()+" to "+x.Type.Name, x.Loc())
	return c.typ(x, typing.Void)
}

func (c *checker) inferFuncCall(x ast.FuncCall) typing.Type {
	for _, fun := range c.program.Functions {
		if fun.Name == x.Func.Name {
			l1, l2 := len(fun.Params), len(*x.Params)
			if l1 != l2 {
				var param ast.Expr
				if l1 > l2 {
					param = (*x.Params)[l2-1]
				} else {
					param = (*x.Params)[l1]
				}
				Errors.Error(fmt.Sprint(l2)+" parameters given, but "+fmt.Sprint(l1)+" expected", param.Loc())
			}

			for i, param := range *x.Params {
				typ := c.inferExpr(param)
				paramTyp := fun.Params[i].Type
				if typ != paramTyp {
					Errors.Error("Expected "+paramTyp.String()+", but got "+typ.String()+" instead", param.Loc())
				}
			}

			return c.typ(x, fun.Return)
		}
	}

	Errors.Error("The function "+x.Func.Name+" is undefined", x.Func.Pos)
	return c.typ(x, typing.Void)
}

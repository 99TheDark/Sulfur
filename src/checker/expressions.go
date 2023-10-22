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
	case ast.Reference:
		return c.inferReference(x)
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
		conv, ok := c.AutoInfer(left, right, x.Left, x.Right)
		if ok {
			left, right = AutoSwitch(left, right, conv)
		} else {
			Errors.Error("Expected "+left.String()+", but got "+right.String()+" instead", x.Right.Loc())
		}
	}

	for i, binop := range c.program.BinaryOps {
		if binop.Op != x.Op.Type {
			continue
		}

		if binop.Left == left && binop.Right == right {
			binop.Uses++
			c.program.BinaryOps[i] = binop

			return c.typ(x, binop.Return)
		}
	}

	Errors.Error("No operation "+x.Op.Value+" exists for "+left.String()+" and "+right.String(), x.Op.Location)
	return c.typ(x, typing.Void)
}

func (c *checker) inferUnaryOp(x ast.UnaryOp) typing.Type {
	val := c.inferExpr(x.Value)
	for i, unop := range c.program.UnaryOps {
		if unop.Op != x.Op.Type {
			continue
		}

		if unop.Value == val {
			unop.Uses++
			c.program.UnaryOps[i] = unop

			return c.typ(x, unop.Return)
		}
	}

	Errors.Error("No operation "+x.Op.Value+" exists for "+val.String(), x.Op.Location)
	return c.typ(x, typing.Void)
}

func (c *checker) inferComparison(x ast.Comparison) typing.Type {
	left := c.inferExpr(x.Left)
	right := c.inferExpr(x.Right)

	if left != right {
		Errors.Error("Expected "+left.String()+", but got "+right.String()+" instead", x.Right.Loc())
	}

	for i, comp := range c.program.Comparisons {
		if comp.Comp != x.Comp.Type {
			continue
		}

		if comp.Left == left && comp.Right == right {
			comp.Uses++
			c.program.Comparisons[i] = comp

			return c.typ(x, typing.Boolean)
		}
	}

	Errors.Error("No comparison "+x.Comp.Value+" exists for "+left.String()+" and "+right.String(), x.Comp.Location)
	return c.typ(x, typing.Void)
}

func (c *checker) inferTypeConv(x ast.TypeConv) typing.Type {
	typ := c.inferExpr(x.Value)
	if typ == typing.Type(x.Type.Name) {
		Errors.Warn("Unnecessary type conversion from "+string(typ)+" to "+string(typ), x.Loc())
		return c.typ(x, typ)
	}

	for i, conv := range c.program.TypeConvs {
		if conv.From == typ && conv.To == typing.Type(x.Type.Name) {
			conv.Uses++
			c.program.TypeConvs[i] = conv

			return c.typ(x, conv.To)
		}
	}

	Errors.Error("Cannot convert from "+typ.String()+" to "+x.Type.Name, x.Loc())
	return c.typ(x, typing.Void)
}

func (c *checker) inferFuncCall(x ast.FuncCall) typing.Type {
	for i, fun := range c.program.Functions {
		if fun.Name == x.Func.Name {
			l1, l2 := len(*x.Params), len(fun.Params)
			if l1 != l2 {
				if l1 == 0 {
					Errors.Error("No parameters given, but "+fmt.Sprint(l2)+" expected", x.Loc())
				} else {
					var param ast.Expr
					if l1 < l2 {
						param = (*x.Params)[l1-1]
					} else {
						param = (*x.Params)[l1-1]
					}
					Errors.Error(fmt.Sprint(l1)+" parameters given, but "+fmt.Sprint(l2)+" expected", param.Loc())
				}
			}

			for i, param := range *x.Params {
				typ := c.inferExpr(param)
				paramTyp := fun.Params[i].Type

				if fun.Params[i].Reference {
					if _, ok := param.(ast.Reference); !ok {
						Errors.Error("Expected &"+string(paramTyp)+", but got "+string(typ)+" instead", param.Loc())
					}
				}

				if typ != paramTyp {
					conv, ok := c.AutoSingleInfer(typ, paramTyp, param)
					if ok {
						typ, paramTyp = AutoSwitch(typ, paramTyp, conv)
					} else {
						Errors.Error("Expected "+paramTyp.String()+", but got "+typ.String()+" instead", param.Loc())
					}
				}
			}

			fun.Uses++
			c.program.Functions[i] = fun

			return c.typ(x, fun.Return)
		}
	}

	Errors.Error("The function "+x.Func.Name+" is undefined", x.Func.Pos)
	return c.typ(x, typing.Void)
}

func (c *checker) inferReference(x ast.Reference) typing.Type {
	vari := c.top.Lookup(x.Variable.Name, x.Variable.Loc())
	vari.Referenced = true
	c.program.References.Add(vari.Type)
	c.top.ActiveRefs = append(c.top.ActiveRefs, vari)
	return c.typ(x, vari.Type)
}

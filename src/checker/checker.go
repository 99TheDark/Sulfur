package checker

import (
	"sulfur/src/ast"
)

type checker struct {
	program *ast.Program
	typ     map[*ast.Expr]Type
}

func (c *checker) get(x *ast.Expr) Type {
	if typ, ok := c.typ[x]; ok {
		return typ
	}
	return Void
}

func (c *checker) set(x *ast.Expr, typ Type) {
	c.typ[x] = typ
}

func TypeCheck(program *ast.Program) map[*ast.Expr]Type {
	c := checker{
		program,
		make(map[*ast.Expr]Type),
	}
	c.inferBlock(program.Contents)
	return c.typ
}

package checker

import (
	"sulfur/src/ast"
)

type checker struct {
	program *ast.Program
	top     *ast.Scope
	typ     map[*ast.Expr]ast.Type
}

func (c *checker) get(x *ast.Expr) ast.Type {
	if typ, ok := c.typ[x]; ok {
		return typ
	}
	return ast.VoidType
}

func (c *checker) set(x *ast.Expr, typ ast.Type) {
	c.typ[x] = typ
}

func TypeCheck(program *ast.Program) map[*ast.Expr]ast.Type {
	c := checker{
		program,
		&program.Contents.Scope,
		make(map[*ast.Expr]ast.Type),
	}
	for _, x := range program.Contents.Body {
		c.inferStmt(x)
	}
	return c.typ
}

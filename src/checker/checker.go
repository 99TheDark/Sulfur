package checker

import (
	"sulfur/src/ast"
)

type checker struct {
	program *ast.Program
	top     *ast.Scope
	ret     *ast.Func
	types   map[ast.Expr]ast.Type
}

func (c *checker) typ(x ast.Expr, typ ast.Type) ast.Type {
	c.types[x] = typ
	return typ
}

func TypeCheck(program *ast.Program) map[ast.Expr]ast.Type {
	c := checker{
		program,
		&program.Contents.Scope,
		nil,
		make(map[ast.Expr]ast.Type),
	}
	for _, x := range program.Contents.Body {
		c.inferStmt(x)
	}
	return c.types
}

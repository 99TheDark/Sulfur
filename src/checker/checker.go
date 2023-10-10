package checker

import (
	"sulfur/src/ast"
	"sulfur/src/typing"
)

type TypeMap map[ast.Expr]typing.Type

type checker struct {
	program *ast.Program
	top     *ast.Scope
	ret     *ast.Func
	types   TypeMap
}

func (c *checker) typ(x ast.Expr, typ typing.Type) typing.Type {
	c.types[x] = typ
	return typ
}

func TypeCheck(program *ast.Program) TypeMap {
	c := checker{
		program,
		&program.Contents.Scope,
		nil,
		make(TypeMap),
	}
	for _, x := range program.Contents.Body {
		c.inferStmt(x)
	}
	return c.types
}

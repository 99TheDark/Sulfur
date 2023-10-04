package checker

import (
	"fmt"
	"sulfur/src/ast"
)

type checker struct {
	program *ast.Program
	typ     map[*ast.Expr]string
}

func TypeCheck(program *ast.Program) {
	c := checker{
		program,
		make(map[*ast.Expr]string),
	}
	fmt.Println(c)
}

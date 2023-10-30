package checker

import (
	"sulfur/src/ast"
	"sulfur/src/builtins"
	"sulfur/src/typing"
	"sulfur/src/utils"
)

type checker struct {
	program *ast.Program
	top     *ast.Scope
	topfun  *ast.FuncScope
	*VariableProperties
}

func (c *checker) typ(x ast.Expr, typ typing.Type) typing.Type {
	c.Types[x] = typ
	return typ
}

func TypeCheck(program *ast.Program) *VariableProperties {
	program.Functions = append(program.Functions, builtins.Funcs...)
	program.BinaryOps = append(program.BinaryOps, builtins.BinaryOps...)
	program.UnaryOps = append(program.UnaryOps, builtins.UnaryOps...)
	program.Comparisons = append(program.Comparisons, builtins.Comps...)
	program.TypeConvs = append(program.TypeConvs, builtins.TypeConvs...)
	program.IncDecs = append(program.IncDecs, builtins.IncDecs...)

	c := checker{
		program,
		program.Contents.Scope,
		ast.NewFuncScope(nil, typing.Void),
		&VariableProperties{
			make(TypeMap),
			make(AutoTypeConvMap),
			utils.NewSet[ast.Expr](),
		},
	}

	for _, x := range program.Contents.Body {
		c.inferStmt(x)
	}
	return c.VariableProperties
}

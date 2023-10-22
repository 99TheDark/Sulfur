package checker

import (
	"sulfur/src/ast"
	"sulfur/src/builtins"
	"sulfur/src/typing"
)

type TypeMap map[ast.Expr]typing.Type
type AutoTypeConvMap map[ast.Expr]builtins.TypeConvSignature

type checker struct {
	program   *ast.Program
	top       *ast.Scope
	topfun    *ast.FuncScope
	types     TypeMap
	autoconvs AutoTypeConvMap
}

func (c *checker) typ(x ast.Expr, typ typing.Type) typing.Type {
	c.types[x] = typ
	return typ
}

func TypeCheck(program *ast.Program) (TypeMap, AutoTypeConvMap) {
	program.Functions = append(program.Functions, builtins.Funcs...)
	program.BinaryOps = append(program.BinaryOps, builtins.BinaryOps...)
	program.UnaryOps = append(program.UnaryOps, builtins.UnaryOps...)
	program.Comparisons = append(program.Comparisons, builtins.Comps...)
	program.TypeConvs = append(program.TypeConvs, builtins.TypeConvs...)
	program.IncDecs = append(program.IncDecs, builtins.IncDecs...)

	c := checker{
		program,
		program.Contents.Scope,
		&ast.FuncScope{
			Parent: nil,
			Return: typing.Void,
			Counts: make(map[string]int),
		},
		make(TypeMap),
		make(AutoTypeConvMap),
	}

	for _, x := range program.Contents.Body {
		c.inferStmt(x)
	}
	return c.types, c.autoconvs
}

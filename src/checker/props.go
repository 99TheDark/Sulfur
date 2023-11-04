package checker

import (
	"sulfur/src/ast"
	"sulfur/src/builtins"
	"sulfur/src/typing"
	"sulfur/src/utils"
)

type TypeMap map[ast.Expr]typing.Type
type AutoTypeConvMap map[ast.Expr]builtins.TypeConvSignature

type VariableProperties struct {
	Types     TypeMap
	AutoConvs AutoTypeConvMap
	Refs      utils.Set[ast.Expr]
}

package compiler

import (
	"sulfur/src/ast"
	. "sulfur/src/errors"

	"github.com/llir/llvm/ir/value"
)

func (g *generator) autoCast(val value.Value, expr ast.Expr, step string) value.Value {
	if conv, ok := g.autoconvs[expr]; ok {
		new := g.genBasicTypeConv(val, conv.From, conv.To)
		if new == Zero {
			Errors.Error("Unexpected generating error during "+step+" creation", expr.Loc())
		}

		return new
	}
	return val
}

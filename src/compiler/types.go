package compiler

import (
	"sulfur/src/ast"
	"sulfur/src/typing"

	"github.com/llir/llvm/ir/types"
)

func (g *generator) complex(typ typing.Type) bool {
	ll := g.lltyp(typ)
	_, ok := ll.(*types.StructType)
	return ok
}

func (g *generator) lltyp(typ typing.Type) types.Type {
	switch typ {
	case typing.Integer, typing.Unsigned:
		return types.I32
	case typing.Float:
		return types.Float
	case typing.Boolean:
		return types.I1
	case typing.Byte:
		return types.I8
	case typing.String:
		return g.str
	}
	return types.Void
}

func (g *generator) typ(x ast.Expr) types.Type {
	if typ, ok := g.types[x]; ok {
		return g.lltyp(typ)
	}
	return types.Void
}

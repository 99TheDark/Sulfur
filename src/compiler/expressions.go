package compiler

import (
	"sulfur/src/ast"
	"unicode/utf8"

	. "sulfur/src/errors"

	"github.com/llir/llvm/ir/constant"
	"github.com/llir/llvm/ir/types"
	"github.com/llir/llvm/ir/value"
)

func (g *generator) genExpr(expr ast.Expr) value.Value {
	switch x := expr.(type) {
	case ast.String:
		return g.genString(x)
	}

	Errors.Error("Expression cannot be generated", expr.Loc())
	return constant.NewInt(types.I32, 0)
}

func (g *generator) genString(x ast.String) value.Value {
	bl := g.bl()

	str := bl.NewGetElementPtr(
		g.strArrs[0].Typ,
		g.strGlobs[0],
		constant.NewInt(types.I32, int64(0)),
		constant.NewInt(types.I32, int64(0)),
	)
	str.InBounds = true

	alloca := bl.NewAlloca(g.str)
	alloca.Align = 8

	lenPtr := bl.NewGetElementPtr(
		g.str,
		alloca,
		constant.NewInt(types.I32, int64(0)),
		constant.NewInt(types.I32, int64(0)),
	)
	lenPtr.InBounds = true

	lenStore := bl.NewStore(
		constant.NewInt(types.I32, int64(utf8.RuneCountInString(x.Value))),
		lenPtr,
	)
	lenStore.Align = 8

	sizePtr := bl.NewGetElementPtr(
		g.str,
		alloca,
		constant.NewInt(types.I32, int64(0)),
		constant.NewInt(types.I32, int64(1)),
	)
	sizePtr.InBounds = true

	sizeStore := bl.NewStore(
		constant.NewInt(types.I32, int64(len(x.Value))),
		sizePtr,
	)
	sizeStore.Align = 8

	adrPtr := bl.NewGetElementPtr(
		g.str,
		alloca,
		constant.NewInt(types.I32, int64(0)),
		constant.NewInt(types.I32, int64(2)),
	)
	adrPtr.InBounds = true

	adrStore := bl.NewStore(
		str,
		adrPtr,
	)
	adrStore.Align = 8

	return alloca
}

package compiler

import (
	"sulfur/src/ast"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/types"
)

func (g *generator) genAllocas(fnscope *ast.FuncScope) {
	bl := g.bl
	for decl := range fnscope.Decls {
		var typ types.Type
		var align ir.Align
		if decl.References || decl.Referenced {
			bundle := g.refs[decl.Type]
			typ = bundle.ptr
			align = 8
		} else {
			typ = g.lltyp(decl.Type)
			align = g.align(decl.Type)
		}

		alloca := bl.NewAlloca(typ)
		alloca.LocalName = decl.LLName()
		alloca.Align = align
		g.topfun.Decls[decl] = alloca
	}
}

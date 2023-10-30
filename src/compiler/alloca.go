package compiler

import (
	"sulfur/src/ast"

	"github.com/llir/llvm/ir/types"
)

func (g *generator) genAllocas(fnscope *ast.FuncScope) {
	bl := g.bl
	for decl := range fnscope.Decls {
		var typ types.Type
		if decl.References || decl.Referenced {
			bundle := g.refs[decl.Type]
			typ = bundle.ptr
		} else {
			typ = g.lltyp(decl.Type)
		}

		alloca := bl.NewAlloca(typ)
		alloca.LocalName = decl.LLName()
		g.topfun.Decls[decl] = alloca
	}
}

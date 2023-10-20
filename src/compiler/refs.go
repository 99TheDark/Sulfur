package compiler

import (
	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/types"
)

type ref_bundle struct {
	typ   types.Type
	ptr   *types.PointerType
	ref   *ir.Func
	deref *ir.Func
}

func (g *generator) deref() {
	bl := g.bl
	for _, vari := range g.top.Vars {
		if vari.Referenced {
			bundle := g.refs[vari.Type]
			bl.NewCall(bundle.deref, *vari.Value)
		}
	}
}

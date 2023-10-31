package compiler

import (
	"sulfur/src/typing"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/types"
)

func (g *generator) autoFree() {
	bl := g.bl
	for cmplx, typ := range g.top.Strings {
		free := g.autofrees[typ]
		bl.NewCall(free, cmplx)
	}
}

func (g *generator) genHiddens() {
	g.genCopy(typing.String)
	g.genAutofree(typing.String)
}

func (g *generator) genCopy(typ typing.Type) {
	mod := g.mod
	lltyp := g.lltyp(typ)
	fun := mod.NewFunc(".copy:"+typ.String(), lltyp, ir.NewParam("", lltyp))
	g.copys[typ] = fun
}

func (g *generator) genAutofree(typ typing.Type) {
	mod := g.mod
	fun := mod.NewFunc(".free:"+typ.String(), types.Void, ir.NewParam("", g.lltyp(typ)))
	g.autofrees[typ] = fun
}

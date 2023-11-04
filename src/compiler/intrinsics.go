package compiler

import (
	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/enum"
	"github.com/llir/llvm/ir/types"
)

func (g *generator) genIntrinsics() {
	mod := g.mod

	poison := ir.NewParam("", types.I1)
	poison.Attrs = append(poison.Attrs, enum.ParamAttrImmArg)

	g.intrinsics["clz"] = mod.NewFunc("llvm.ctlz.i32", types.I32, ir.NewParam("", types.I32), poison)
	g.intrinsics["ctz"] = mod.NewFunc("llvm.cttz.i32", types.I32, ir.NewParam("", types.I32), poison)
}

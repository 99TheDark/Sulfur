package compiler

import (
	"fmt"

	"github.com/llir/llvm/ir/constant"
	"github.com/llir/llvm/ir/enum"
)

func (g *generator) genStrings() {
	for i, str := range g.program.Strings {
		arr := constant.NewCharArrayFromString(str.Value)
		strGlob := g.mod.NewGlobalDef(".str"+fmt.Sprint(i), arr)
		strGlob.Linkage = enum.LinkagePrivate
		strGlob.UnnamedAddr = enum.UnnamedAddrUnnamedAddr
		strGlob.Immutable = true
		strGlob.Align = 1
		g.strGlobs = append(g.strGlobs, strGlob)
		g.strArrs = append(g.strArrs, arr)
	}
}

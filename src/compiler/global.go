package compiler

import (
	"fmt"
	"sulfur/src/builtins"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/constant"
	"github.com/llir/llvm/ir/enum"
	"github.com/llir/llvm/ir/types"
)

type (
	StringGlobal struct {
		glob *ir.Global
		typ  *types.ArrayType
	}
)

func (g *generator) genStrings() {
	for i, str := range g.program.Strings {
		val := str.Value
		if _, ok := g.strs[val]; ok {
			continue
		}

		arr := constant.NewCharArrayFromString(val)
		strGlob := g.mod.NewGlobalDef(".str"+fmt.Sprint(i), arr)
		strGlob.Linkage = enum.LinkagePrivate
		strGlob.UnnamedAddr = enum.UnnamedAddrUnnamedAddr
		strGlob.Immutable = true
		strGlob.Align = 1

		g.strs[val] = StringGlobal{
			strGlob,
			arr.Typ,
		}
	}
}

func (g *generator) genFuncs() {
	for _, fun := range builtins.Funcs {
		params := []*ir.Param{}
		for _, param := range fun.Params {
			params = append(params, ir.NewParam("", g.llraw(param.Type)))
		}

		builtin := g.mod.NewFunc(
			fun.Name,
			g.llraw(fun.Return),
			params...,
		)

		g.builtins[fun.Name] = builtin
	}
}

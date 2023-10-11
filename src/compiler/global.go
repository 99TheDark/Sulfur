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
			"."+fun.Name,
			g.llraw(fun.Return),
			params...,
		)

		g.builtins.funcs[fun.Name] = builtin
	}
}

func (g *generator) genBinOps() {
	for _, binop := range builtins.BinaryOps {
		var builtin *ir.Func
		name := "." + binop.Op.OperatorName() + "." + binop.Left.String() + "_" + binop.Right.String()
		if g.complex(binop.Return) {
			builtin = g.mod.NewFunc(
				name,
				types.Void,
				ir.NewParam("ret", g.llraw(binop.Return)),
				ir.NewParam("", g.llraw(binop.Left)),
				ir.NewParam("", g.llraw(binop.Right)),
			)
		} else {
			builtin = g.mod.NewFunc(
				name,
				g.llraw(binop.Return),
				ir.NewParam("", g.llraw(binop.Left)),
				ir.NewParam("", g.llraw(binop.Right)),
			)
		}

		hash := binop.Op.OperatorName() + " " + binop.Left.String() + " " + binop.Right.String()
		g.builtins.binops[hash] = builtin
	}
}

func (g *generator) genConvs() {
	for _, conv := range builtins.TypeConvs {
		var builtin *ir.Func
		name := ".conv." + string(conv.From) + "_" + string(conv.To)
		if g.complex(conv.To) {
			builtin = g.mod.NewFunc(
				name,
				types.Void,
				ir.NewParam("ret", g.llraw(conv.To)),
				ir.NewParam("", g.llraw(conv.From)),
			)
		} else {
			builtin = g.mod.NewFunc(
				name,
				g.llraw(conv.To),
				ir.NewParam("", g.llraw(conv.From)),
			)
		}

		hash := "conv " + string(conv.From) + " " + string(conv.To)
		g.builtins.convs[hash] = builtin
	}
}

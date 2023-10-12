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

		bi := bi_func{
			fun,
			g.mod.NewFunc(
				"."+fun.Name,
				g.llraw(fun.Return),
				params...,
			),
		}

		g.builtins.funcs[fun.Name] = bi
	}
}

func (g *generator) genBinOps() {
	for _, binop := range builtins.BinaryOps {
		var bi bi_binop
		name := "." + binop.Op.OperatorName() + "." + binop.Left.String() + "_" + binop.Right.String()
		if g.complex(binop.Return) {
			bi = bi_binop{
				binop, g.mod.NewFunc(
					name,
					types.Void,
					ir.NewParam("ret", g.llraw(binop.Return)),
					ir.NewParam("", g.llraw(binop.Left)),
					ir.NewParam("", g.llraw(binop.Right)),
				),
				true,
			}
		} else {
			bi = bi_binop{
				binop, g.mod.NewFunc(
					name,
					g.llraw(binop.Return),
					ir.NewParam("", g.llraw(binop.Left)),
					ir.NewParam("", g.llraw(binop.Right)),
				),
				false,
			}
		}

		hash := binop.Op.OperatorName() + " " + binop.Left.String() + " " + binop.Right.String()
		g.builtins.binops[hash] = bi
	}
}

func (g *generator) genConvs() {
	for _, conv := range builtins.TypeConvs {
		var bi bi_conv
		name := ".conv." + string(conv.From) + "_" + string(conv.To)
		if g.complex(conv.To) {
			bi = bi_conv{
				conv,
				g.mod.NewFunc(
					name,
					types.Void,
					ir.NewParam("ret", g.llraw(conv.To)),
					ir.NewParam("", g.llraw(conv.From)),
				),
				true,
			}
		} else {
			bi = bi_conv{
				conv,
				nil,
				false,
			}
		}

		hash := "conv " + string(conv.From) + " " + string(conv.To)
		g.builtins.convs[hash] = bi
	}
}

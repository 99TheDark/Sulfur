package compiler

import (
	"fmt"

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
	for _, fun := range g.program.Functions {
		name := fun.Module + "." + fun.Name

		params := []*ir.Param{}
		for i, param := range fun.Params {
			p := ir.NewParam("", g.llraw(param.Type))
			fun.Params[i].Ir = p
			params = append(params, p)
		}

		// TODO: Add complex functions
		fun.Ir = g.mod.NewFunc(
			name,
			g.llraw(fun.Return),
			params...,
		)

		g.builtins.funcs[fun.Name] = fun
	}
}

func (g *generator) genBinOps() {
	for _, binop := range g.program.BinaryOps {
		name := binop.Module + "." + binop.Op.OperatorName() + "." + binop.Left.String() + "_" + binop.Right.String()
		if g.complex(binop.Return) {
			binop.Ir = g.mod.NewFunc(
				name,
				types.Void,
				ir.NewParam(".ret", g.llraw(binop.Return)),
				ir.NewParam("", g.llraw(binop.Left)),
				ir.NewParam("", g.llraw(binop.Right)),
			)
			binop.Complex = true
		}

		hash := binop.Op.OperatorName() + " " + binop.Left.String() + " " + binop.Right.String()
		g.builtins.binops[hash] = binop
	}
}

func (g *generator) genUnOps() {
	for _, unop := range g.program.UnaryOps {
		name := unop.Module + "." + unop.Op.OperatorName() + "." + unop.Value.String()
		if g.complex(unop.Return) {
			unop.Ir = g.mod.NewFunc(
				name,
				types.Void,
				ir.NewParam(".ret", g.llraw(unop.Return)),
				ir.NewParam("", g.llraw(unop.Value)),
			)
			unop.Complex = true
		}

		hash := unop.Op.OperatorName() + " " + unop.Value.String()
		g.builtins.unops[hash] = unop
	}
}

func (g *generator) genIncDecs() {
	for _, incdec := range g.program.IncDecs {
		name := incdec.Module + "." + incdec.Op.OperatorName() + "." + incdec.Var.String()
		if g.complex(incdec.Var) {
			incdec.Ir = g.mod.NewFunc(
				name,
				types.Void,
				ir.NewParam(".ret", g.llraw(incdec.Var)),
			)
			incdec.Complex = true
		}

		hash := incdec.Op.OperatorName() + " " + incdec.Var.String()
		g.builtins.incdecs[hash] = incdec
	}
}

func (g *generator) genComps() {
	for _, comp := range g.program.Comparisons {
		// TODO: Complex comparisons

		hash := comp.Comp.OperatorName() + " " + comp.Left.String() + " " + comp.Right.String()
		g.builtins.comps[hash] = comp
	}
}

func (g *generator) genTypeConvs() {
	for _, conv := range g.program.TypeConvs {
		name := conv.Module + ".conv." + string(conv.From) + "_" + string(conv.To)
		if g.complex(conv.To) {
			conv.Ir = g.mod.NewFunc(
				name,
				types.Void,
				ir.NewParam(".ret", g.llraw(conv.To)),
				ir.NewParam("", g.llraw(conv.From)),
			)
			conv.Complex = true
		}

		hash := "conv " + string(conv.From) + " " + string(conv.To)
		g.builtins.convs[hash] = conv
	}
}

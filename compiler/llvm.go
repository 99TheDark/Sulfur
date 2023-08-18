package compiler

import (
	"fmt"
	"golang/parser"
	"golang/typing"
	"golang/utils"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/constant"
	"github.com/llir/llvm/ir/types"
)

func search(m *ir.Module, expr parser.Expression) {
	children := expr.Children()
	if len(children) == 0 {
		switch e := expr.(type) {
		case parser.FunctionLiteral:
			params := []*ir.Param{}
			fmt.Println(e.Params.Values)
			for _, param := range e.Params.Values {
				if new, ok := param.(parser.Datatype); ok {
					llvmparam := ir.NewParam(
						new.Variable.Symbol,
						typing.UnderlyingType(new.Type.Symbol).LLVMType(),
					)
					params = append(params, llvmparam)
				} else {
					panic("Not a datatype, typer not yet made")
				}
			}

			fun := m.NewFunc(
				e.Name.Symbol,
				types.I32,
				params...,
			)
			bl := fun.NewBlock("")
			bl.NewRet(constant.NewInt(types.I32, 0))
		}
	} else {
		for _, child := range expr.Children() {
			search(m, child)
		}
	}
}

func Assemble(ast parser.Program) string {
	mod := ir.NewModule()
	search(mod, ast)

	return mod.String()
}

func Save(code, location string) error {
	return utils.SaveFile([]byte(code), location)
}

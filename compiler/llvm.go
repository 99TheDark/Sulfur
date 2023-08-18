package compiler

import (
	"golang/parser"
	"golang/utils"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/types"
)

func Assemble(ast parser.Program) string {
	m := ir.NewModule()
	funcAdd := m.NewFunc(
		"add",
		types.I32,
		ir.NewParam("a", types.I32),
		ir.NewParam("b", types.I32),
	)
	bl := funcAdd.NewBlock("")
	bl.NewRet(bl.NewAdd(funcAdd.Params[0], funcAdd.Params[1]))

	return m.String()
}

func Save(code, location string) error {
	return utils.SaveFile([]byte(code), location)
}

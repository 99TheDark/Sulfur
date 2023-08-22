package compiler

import (
	"golang/parser"
	"golang/utils"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/types"
)

func Assemble(ast parser.Program) string {
	mod := ir.NewModule()

	main := mod.NewFunc("main", types.Void)
	bl := main.NewBlock("entry")
	ast.Generate(mod, bl)
	bl.NewRet(nil)

	return mod.String()
}

func Save(code, location string) error {
	return utils.SaveFile([]byte(code), location)
}

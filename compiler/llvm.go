package compiler

import (
	"golang/parser"
	"golang/utils"

	"github.com/llir/llvm/ir"
)

func Assemble(ast parser.Program) string {
	mod := ir.NewModule()
	// todo: gen for each Expression

	return mod.String()
}

func Save(code, location string) error {
	return utils.SaveFile([]byte(code), location)
}

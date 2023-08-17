package compiler

import (
	"golang/parser"

	"github.com/llir/llvm/ir"
)

func Assemble(ast parser.Program) string {
	m := ir.NewModule()
	return m.String()
}

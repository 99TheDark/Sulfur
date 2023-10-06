package compiler

import (
	"sulfur/src/ast"
	"sulfur/src/parser"
	"sulfur/src/utils"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/types"
)

func Assemble(ast ast.Program) string {
	mod := ir.NewModule()

	parser.String = mod.NewTypeDef("type.string", types.NewStruct(
		types.I64,   // length
		types.I8Ptr, // address of first character
	))

	mod.SourceFilename = "script.sulfur"

	main := mod.NewFunc("main", types.Void)
	bl := main.NewBlock("entry")
	ast.Generate(mod, bl)
	bl.NewRet(nil)

	return mod.String()
}

func Save(code, location string) error {
	return utils.SaveFile([]byte(code), location)
}
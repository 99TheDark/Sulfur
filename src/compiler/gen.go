package compiler

import (
	"sulfur/src/ast"
	"sulfur/src/utils"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/types"
)

type generator struct {
	program *ast.Program
	types   map[ast.Expr]ast.Type
	mod     *ir.Module
	top     *ast.Scope
	str     types.Type
}

func (g *generator) bl() *ir.Block {
	return g.top.Block
}

func Generate(program *ast.Program, typ map[ast.Expr]ast.Type) string {
	mod := ir.NewModule()
	mod.SourceFilename = "script.sulfur"

	str := mod.NewTypeDef("type.string", types.NewStruct(
		types.I32,   // length
		types.I32,   // size
		types.I8Ptr, // address
	))

	g := generator{
		program,
		typ,
		mod,
		&program.Contents.Scope,
		str,
	}

	g.genStrings()

	main := mod.NewFunc("main", types.Void)
	bl := main.NewBlock("entry")
	program.Contents.Scope.Block = bl
	for _, x := range program.Contents.Body {
		g.genStmt(x)
	}
	bl.NewRet(nil)

	return mod.String()
}

func Save(code, location string) error {
	return utils.SaveFile([]byte(code), location)
}

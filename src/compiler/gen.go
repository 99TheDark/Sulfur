package compiler

import (
	"sulfur/src/ast"
	"sulfur/src/checker"
	"sulfur/src/typing"
	"sulfur/src/utils"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/types"
)

type generator struct {
	program  *ast.Program
	types    checker.TypeMap
	mod      *ir.Module
	top      *ast.Scope
	str      types.Type
	strs     map[string]StringGlobal
	builtins map[string]*ir.Func
}

func (g *generator) bl() *ir.Block {
	return g.top.Block
}

func (g *generator) lltyp(typ typing.Type) types.Type {
	switch typ {
	case typing.IntegerType, typing.UnsignedType:
		return types.I32
	case typing.FloatType:
		return types.Float
	case typing.BooleanType:
		return types.I1
	case typing.ByteType:
		return types.I8
	case typing.StringType:
		return g.str
	}
	return types.Void
}

func (g *generator) llraw(typ typing.Type) types.Type {
	ll := g.lltyp(typ)
	if _, ok := ll.(*types.StructType); ok {
		return types.NewPointer(ll)
	}
	return ll
}

func (g *generator) typ(x ast.Expr) types.Type {
	if typ, ok := g.types[x]; ok {
		return g.lltyp(typ)
	}
	return types.Void
}

func Generate(program *ast.Program, typ checker.TypeMap) string {
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
		make(map[string]StringGlobal),
		make(map[string]*ir.Func),
	}

	g.genStrings()
	g.genFuncs()

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

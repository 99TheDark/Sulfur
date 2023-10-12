package compiler

import (
	"sulfur/src/ast"
	"sulfur/src/checker"
	"sulfur/src/lexer"
	"sulfur/src/typing"
	"sulfur/src/utils"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/types"
)

type llvm_builtins struct {
	funcs  map[string]*ir.Func
	binops map[string]*ir.Func
	convs  map[string]*ir.Func
}

type generator struct {
	program  *ast.Program
	types    checker.TypeMap
	mod      *ir.Module
	top      *ast.Scope
	topfunc  *ir.Func
	bl       *ir.Block
	str      types.Type
	strs     map[string]StringGlobal
	builtins llvm_builtins
}

func (g *generator) complex(typ typing.Type) bool {
	ll := g.lltyp(typ)
	_, ok := ll.(*types.StructType)
	return ok
}

func (g *generator) lltyp(typ typing.Type) types.Type {
	switch typ {
	case typing.Integer, typing.Unsigned:
		return types.I32
	case typing.Float:
		return types.Float
	case typing.Boolean:
		return types.I1
	case typing.Byte:
		return types.I8
	case typing.String:
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
		return g.llraw(typ)
	}
	return types.Void
}

func (g *generator) scope(scope *ast.Scope, body func()) {
	g.top = scope
	body()
	g.top = scope.Parent
}

func (g *generator) biFunc(name string) *ir.Func {
	return g.builtins.funcs[name]
}

func (g *generator) biBinop(op lexer.TokenType, left, right string) *ir.Func {
	return g.builtins.binops[op.OperatorName()+" "+left+" "+right]
}

func (g *generator) biConv(from, to string) *ir.Func {
	return g.builtins.convs["conv "+from+" "+to]
}

func Generate(program *ast.Program, typ checker.TypeMap) string {
	mod := ir.NewModule()
	mod.SourceFilename = "script.sulfur"

	str := mod.NewTypeDef("type.string", types.NewStruct(
		types.I32,   // length
		types.I32,   // size
		types.I8Ptr, // address
	))

	main := mod.NewFunc("main", types.Void)
	bl := main.NewBlock("entry")

	g := generator{
		program,
		typ,
		mod,
		&program.Contents.Scope,
		main,
		bl,
		str,
		make(map[string]StringGlobal),
		llvm_builtins{
			make(map[string]*ir.Func),
			make(map[string]*ir.Func),
			make(map[string]*ir.Func),
		},
	}

	g.genStrings()
	g.genFuncs()
	g.genBinOps()
	g.genConvs()

	for _, x := range program.Contents.Body {
		g.genStmt(x)
	}

	g.bl.NewRet(nil)

	return mod.String()
}

func Save(code, location string) error {
	return utils.SaveFile([]byte(code), location)
}

package compiler

import (
	"sulfur/src/ast"
	"sulfur/src/checker"
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
	program    *ast.Program
	types      checker.TypeMap
	mod        *ir.Module
	top        *ast.Scope
	topfunc    *ir.Func
	bl         *ir.Block
	blockcount int
	exits      utils.Stack[*ir.Block]
	str        types.Type
	strs       map[string]StringGlobal
	builtins   llvm_builtins
}

func (g *generator) scope(scope *ast.Scope, body func()) {
	g.top = scope
	body()
	g.top = scope.Parent
}

func (g *generator) enter(bl *ir.Block) {
	g.bl.NewBr(bl)
	g.exits.Push(bl)
}

func (g *generator) exit() {
	exit := g.exits.Pop()
	g.bl.NewBr(exit)
	g.bl = exit
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
	exit := main.NewBlock("exit")

	stack := utils.NewStack[*ir.Block]()
	stack.Push(exit)

	g := generator{
		program,
		typ,
		mod,
		&program.Contents.Scope,
		main,
		bl,
		0,
		stack,
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

	g.exit()
	exit.NewRet(nil)

	return mod.String()
}

func Save(code, location string) error {
	return utils.SaveFile([]byte(code), location)
}

package compiler

import (
	"fmt"
	"sulfur/src/ast"
	"sulfur/src/builtins"
	"sulfur/src/checker"
	"sulfur/src/typing"
	"sulfur/src/utils"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/types"
)

type generator struct {
	program *ast.Program
	*checker.VariableProperties
	mod      *ir.Module
	ctx      *context
	top      *ast.Scope
	bl       *ir.Block // TODO: Move bl to context
	breaks   map[*ir.Block]bool
	str      types.Type
	refs     map[typing.Type]ref_bundle
	strs     map[string]StringGlobal
	builtins llvm_builtins
}

func (g *generator) scope(scope *ast.Scope, body func()) {
	g.top = scope
	body()
	g.leaveRefs()
	g.top = scope.Parent
}

func (g *generator) id() string {
	id := fmt.Sprint(g.ctx.blockcount)
	g.ctx.blockcount++
	return id
}

func (g *generator) enter(bl *ir.Block) {
	g.bl.NewBr(bl)
	g.ctx.exits.Push(bl)
}

func (g *generator) exit() {
	exit := g.ctx.exits.Pop()
	if !g.breaks[g.bl] {
		g.bl.NewBr(exit)
	}
	g.bl = exit
}

func Generate(program *ast.Program, props *checker.VariableProperties) string {
	mod := ir.NewModule()
	mod.SourceFilename = "script.su"

	str := mod.NewTypeDef("type.utf8_string", types.NewStruct(
		types.I32,    // length
		types.I32Ptr, // address
	))

	main := mod.NewFunc("main", types.Void)
	bl := main.NewBlock("entry")
	exit := main.NewBlock("exit")

	stack := utils.NewStack[*ir.Block]()
	stack.Push(exit)

	g := generator{
		program,
		props,
		mod,
		&context{
			nil,
			main,
			nil,
			false,
			stack,
			0,
		},
		program.Contents.Scope,
		bl,
		make(map[*ir.Block]bool),
		str,
		make(map[typing.Type]ref_bundle),
		make(map[string]StringGlobal),
		llvm_builtins{
			make(map[string]*builtins.FuncSignature),
			make(map[string]*builtins.ClassSignature),
			make(map[string]*builtins.BinaryOpSignature),
			make(map[string]*builtins.UnaryOpSignature),
			make(map[string]*builtins.IncDecSignature),
			make(map[string]*builtins.ComparisonSignature),
			make(map[string]*builtins.TypeConvSignature),
		},
	}

	g.genStrings()
	g.genReferences()
	g.genFuncs()
	g.genClasses()
	g.genBinOps()
	g.genUnOps()
	g.genIncDecs()
	g.genComps()
	g.genTypeConvs()

	for _, x := range program.Contents.Body {
		g.genStmt(x)
	}
	g.leaveRefs()

	g.exit()
	exit.NewRet(nil)

	return mod.String()
}

func Save(code, location string) error {
	return utils.SaveFile([]byte(code), location)
}

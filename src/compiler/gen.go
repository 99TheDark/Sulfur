package compiler

import (
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
	mod        *ir.Module
	ctx        *context
	top        *ast.Scope
	topfun     *ast.FuncScope
	bl         *ir.Block // TODO: Move bl to context
	breaks     map[*ir.Block]bool
	str        types.Type
	refs       map[typing.Type]ref_bundle
	strs       map[string]StringGlobal
	builtins   llvm_builtins
	copys      map[typing.Type]*ir.Func
	autofrees  map[typing.Type]*ir.Func
	intrinsics map[string]*ir.Func
}

func Generate(program *ast.Program, props *checker.VariableProperties, path string) string {
	mod := ir.NewModule()
	mod.SourceFilename = path

	str := mod.NewTypeDef("type.string", types.NewStruct(
		types.I32,    // length
		types.I32Ptr, // address
	))

	main := mod.NewFunc("main", types.I32)
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
		program.FuncScope,
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
		make(map[typing.Type]*ir.Func),
		make(map[typing.Type]*ir.Func),
		make(map[string]*ir.Func),
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
	g.genIntrinsics()
	g.genHiddens()

	g.genAllocas(g.topfun)

	for _, x := range program.Contents.Body {
		g.genStmt(x)
	}
	g.leaveRefs()
	g.autoFree()

	g.exit()
	exit.NewRet(Zero)

	return mod.String()
}

func Save(code, location string) error {
	return utils.SaveFile([]byte(code), location)
}

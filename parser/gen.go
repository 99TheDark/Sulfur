package parser

import (
	"fmt"
	. "golang/errors"
	"golang/lexer"
	"golang/typing"
	"math/rand"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/constant"
	"github.com/llir/llvm/ir/enum"
	"github.com/llir/llvm/ir/types"
	"github.com/llir/llvm/ir/value"
)

// TODO: Next add bools & strings

// Generate
func (x Program) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	x.Contents.Generate(mod, bl)
	return nil
}
func (x Block) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	for name, variable := range x.Scope.Vars {
		if variable.Underlying != typing.String {
			dst := bl.NewAlloca(variable.Underlying.LLVMType())
			dst.Align = 4
			dst.LocalName = name

			*variable.Value = dst
		}
	}
	for _, expr := range x.Body {
		expr.Generate(mod, bl)
	}
	return nil
}
func (x Identifier) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	variable := x.Parent.Vars[x.Symbol]
	val := *variable.Value
	switch typ := variable.VarType; typ {
	case typing.Local:
		load := bl.NewLoad(variable.Underlying.LLVMType(), val)
		load.Align = 4
		return load
	case typing.Param:
		return ir.NewParam(x.Symbol, types.I32)
	default:
		Errors.Error("Invalid variable type '"+string(typ)+"'", x.Loc)
		return nil
	}
}
func (x Datatype) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	return nil
}
func (x Declaration) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	x.Variable.InferType()
	variable := x.Variable.Parent.Vars[x.Variable.Symbol]

	if typ := x.Variable.Type.Underlying; typ == typing.String {
		lit := x.Value.(StringLiteral)

		val, len := lit.Value, len(lit.Value)

		arr := constant.NewCharArrayFromString(val)
		strGlob := mod.NewGlobalDef(".str", arr)
		strGlob.Linkage = enum.LinkagePrivate
		strGlob.UnnamedAddr = enum.UnnamedAddrUnnamedAddr
		strGlob.Immutable = true
		strGlob.Align = 1

		str := bl.NewAlloca(String)
		str.Align = 8
		str.LocalName = x.Variable.Symbol

		lenPtr := bl.NewGetElementPtr(
			String,
			str,
			constant.NewInt(types.I32, int64(0)),
			constant.NewInt(types.I32, int64(0)),
		)
		lenPtr.InBounds = true

		lenStore := bl.NewStore(
			constant.NewInt(types.I64, int64(len)),
			lenPtr,
		)
		lenStore.Align = 8

		adrPtr := bl.NewGetElementPtr(
			String,
			str,
			constant.NewInt(types.I32, int64(0)),
			constant.NewInt(types.I32, int64(1)),
		)
		adrPtr.InBounds = true

		elPtr := bl.NewGetElementPtr(
			arr.Typ,
			strGlob,
			constant.NewInt(types.I32, int64(0)),
			constant.NewInt(types.I32, int64(0)),
		)
		elPtr.InBounds = true

		adrStore := bl.NewStore(
			elPtr,
			adrPtr,
		)
		adrStore.Align = 8
	} else {
		src := x.Value.Generate(mod, bl)
		store := bl.NewStore(src, *variable.Value)
		store.Align = 4 // size in bytes, i32 = 4 * 8 bits = 4 bytes
	}
	return nil
}
func (x Assignment) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	return nil
}
func (x List) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	return nil
}
func (x BinaryOperation) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	switch x.Operator {
	case lexer.Add:
		return bl.NewAdd(x.Left.Generate(mod, bl), x.Right.Generate(mod, bl))
	case lexer.Subtract:
		return bl.NewSub(x.Left.Generate(mod, bl), x.Right.Generate(mod, bl))
	case lexer.Multiply:
		return bl.NewMul(x.Left.Generate(mod, bl), x.Right.Generate(mod, bl))
	case lexer.Divide:
		return bl.NewSDiv(x.Left.Generate(mod, bl), x.Right.Generate(mod, bl))
	case lexer.Modulo:
		return bl.NewSRem(x.Left.Generate(mod, bl), x.Right.Generate(mod, bl))
	default:
		return nil
	}
}
func (x Comparison) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	return nil
}
func (x FunctionLiteral) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	params := []*ir.Param{}
	for _, parameter := range x.Params.Values {
		param := parameter.(Datatype) // Already confirmed to be datatype in typechecker
		p := ir.NewParam(param.Variable.Symbol, types.I32)

		params = append(params, p)
	}

	fun := mod.NewFunc(x.Name.Symbol, types.I32, params...)
	block := fun.NewBlock("entry")
	x.Contents.Generate(mod, block)
	block.NewRet(nil)

	// No pointer reciever
	for _, fn := range *x.Locator.Functions {
		if fn.Name.Symbol == x.Name.Symbol {
			x.Locator.LLVMFunctions[fn] = fun
		}
	}

	return fun
}
func (x FunctionCall) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	callee := x.Locator.LLVMFunctions[find(x)]
	params := []value.Value{}
	for _, param := range x.Params.Values {
		params = append(params, param.Generate(mod, bl))
	}

	call := bl.NewCall(callee, params...)
	return call
}
func (x IntegerLiteral) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	return constant.NewInt(types.I32, x.Value)
}
func (x FloatLiteral) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	return nil
}
func (x BoolLiteral) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	return constant.NewBool(x.Value)
}
func (x StringLiteral) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	glob := mod.NewGlobalDef(
		"_string"+fmt.Sprint(rand.Int31n(1000000000)), // Change with ID when added
		constant.NewCharArray([]byte(x.Value)),
	)
	glob.Align = 1
	return glob
}
func (x Return) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	bl.NewRet(x.Value.Generate(mod, bl))
	return nil
}
func (x IfStatement) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	return nil
}

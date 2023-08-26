package parser

import (
	"fmt"
	. "golang/errors"
	"golang/lexer"
	"golang/typing"
	"math/rand"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/constant"
	"github.com/llir/llvm/ir/types"
	"github.com/llir/llvm/ir/value"
)

// TODO: Next add bools & strings
/*
str, _ := x.Value.(StringLiteral)
glob := mod.NewGlobalDef(x.Variable.Symbol, constant.NewCharArray([]byte(str.Value)))
glob.Align = 1
*/

// Generate
func (x Program) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	// TODO: Also generate functions here
	for _, str := range *x.Strings {
		glob := mod.NewGlobalDef("__const.anonymous"+fmt.Sprint(rand.Int31n(1000000000)), constant.NewCharArray([]byte(str.Value)))
		glob.Align = 1
	}

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

	if typ := x.Variable.Type.Underlying; typ != typing.String {
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
	x.Contents.Generate(mod, fun.NewBlock("entry"))

	return fun
}
func (x FunctionCall) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	return nil
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
	return constant.NewCharArray([]byte(x.Value))
}
func (x Return) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	bl.NewRet(x.Value.Generate(mod, bl))
	return nil
}
func (x IfStatement) Generate(mod *ir.Module, bl *ir.Block) value.Value {
	return nil
}

package typing

import (
	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/constant"
	"github.com/llir/llvm/ir/types"
	"github.com/llir/llvm/ir/value"
)

type UnderlyingType string

const (
	Void   UnderlyingType = ""
	Int    UnderlyingType = "int"
	Float  UnderlyingType = "float"
	Bool   UnderlyingType = "bool"
	String UnderlyingType = "string"
	Class  UnderlyingType = "class"
	Func   UnderlyingType = "func"
)

func (ut UnderlyingType) LLVMType() types.Type {
	switch ut {
	case Void:
		return types.Void
	case Int:
		return types.I32
	case Float:
		return types.Float
	default:
		return nil
	}
}

func Underlying(str string) UnderlyingType {
	typ := UnderlyingType(str)
	switch typ {
	case Void, Int, Float, Bool, String, Class, Func:
		return typ
	default:
		return Class
	}
}

func FillStruct(bl *ir.Block, size int, name string, typ types.Type, fields ...value.Value) {
	structure := bl.NewAlloca(typ)
	structure.Align = ir.Align(size)
	structure.LocalName = name

	for idx, field := range fields {
		ptr := bl.NewGetElementPtr(
			typ,
			structure,
			constant.NewInt(types.I32, int64(0)),
			constant.NewInt(types.I32, int64(idx)),
		)
		ptr.InBounds = true

		store := bl.NewStore(
			field,
			ptr,
		)
		store.Align = ir.Align(size)
	}
}

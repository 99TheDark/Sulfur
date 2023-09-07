package typing

import (
	"golang/utils"

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

func FillPointer(bl *ir.Block, typ types.Type, val value.Value) *ir.InstGetElementPtr {
	ptr := bl.NewGetElementPtr(
		typ,
		val,
		constant.NewInt(types.I32, int64(0)),
		constant.NewInt(types.I32, int64(0)),
	)
	ptr.InBounds = true

	return ptr
}

func FillStruct(bl *ir.Block, name string, typ types.Type, fields ...value.Value) *ir.InstAlloca {
	structure := bl.NewAlloca(typ)
	structure.LocalName = name

	stores := []*ir.InstStore{}
	size := 0
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
		stores = append(stores, store)

		size += utils.BitCeiling(ByteSize(field))
	}

	for _, store := range stores {
		store.Align = ir.Align(size)
	}
	structure.Align = ir.Align(size)

	return structure
}

func BitSize(val value.Value) int {
	switch val.Type() {
	case types.I1: // bool
		return 1
	case types.I8: // char
		return 8
	case types.I32: // int
		return 32
	case types.I64: // long
		return 64
	case types.I1Ptr, types.I8Ptr, types.I32Ptr, types.I64Ptr: // pointer
		return 8
	default:
		return 0
	}
}

func ByteSize(val value.Value) int {
	return BitSize(val) / 8
}

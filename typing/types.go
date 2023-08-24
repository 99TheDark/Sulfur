package typing

import (
	"github.com/llir/llvm/ir/types"
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

func (ut UnderlyingType) LLVMType(val any) types.Type {
	switch ut {
	case Void:
		return types.Void
	case Int:
		return types.I32
	case Float:
		return types.Float
	case String:
		return types.NewArray(uint64(len(val.(string))), types.I8)
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

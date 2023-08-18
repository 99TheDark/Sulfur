package typing

import "github.com/llir/llvm/ir/types"

type UnderlyingType string

const (
	Void  UnderlyingType = ""
	Int   UnderlyingType = "int"
	Float UnderlyingType = "float"
	Bool  UnderlyingType = "bool"
	Class UnderlyingType = "class"
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

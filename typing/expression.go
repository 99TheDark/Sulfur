package typing

import (
	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/value"
)

type Variable struct {
	// TODO: ids in each block, example variable name: func_add.if_130956.name
	Type       string
	Underlying UnderlyingType
	Value      value.Value
}

type Scope struct {
	Block  *ir.Block
	Parent *Scope `json:"-"`
	Vars   map[string]value.Value
}

func NewScope() *Scope {
	return &Scope{nil, nil, make(map[string]value.Value)}
}

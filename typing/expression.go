package typing

import (
	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/value"
)

type Scope struct {
	Block  *ir.Block
	Parent *Scope `json:"-"`
	Vars   map[string]value.Value
}

func NewScope() *Scope {
	return &Scope{nil, nil, make(map[string]value.Value)}
}

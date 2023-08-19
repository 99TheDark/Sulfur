package typing

import (
	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/value"
)

type Scope struct {
	*ir.Block
	parent *Scope
	vars   map[string]value.Value
}

func NewScope() Scope {
	return Scope{nil, nil, make(map[string]value.Value)}
}

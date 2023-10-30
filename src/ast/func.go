package ast

import (
	"sulfur/src/typing"

	"github.com/llir/llvm/ir"
)

type FuncScope struct {
	Parent *FuncScope
	Return typing.Type
	Decls  map[*Variable]*ir.InstAlloca
	Counts map[string]int
}

func NewFuncScope(parent *FuncScope, ret typing.Type) *FuncScope {
	return &FuncScope{
		parent,
		ret,
		make(map[*Variable]*ir.InstAlloca),
		make(map[string]int),
	}
}

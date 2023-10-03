package ast

import (
	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/value"
)

type VariableType int

const (
	Local VariableType = iota
	Global
	Parameter
)

type Variable struct {
	// TODO: ids in each block, example variable name: func_add.if_130956.name
	Type   string
	Status VariableType
	Value  *value.Value
}

type Scope struct {
	Block  *ir.Block `json:"-"`
	Parent *Scope
	Vars   map[string]Variable
}

func NewScope() *Scope {
	return &Scope{
		new(ir.Block),
		new(Scope),
		make(map[string]Variable),
	}
}

func NewVariable(typ string, status VariableType) *Variable {
	return &Variable{typ, status, new(value.Value)}
}

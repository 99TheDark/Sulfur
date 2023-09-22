package typing

import (
	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/value"
)

type VariableType string

const (
	Local  VariableType = "local"
	Global VariableType = "global"
	Param  VariableType = "param"
)

type Variable struct {
	// TODO: ids in each block, example variable name: func_add.if_130956.name
	Type       string
	Underlying UnderlyingType
	VarType    VariableType
	Value      *value.Value
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

func NewVar(typ string, under UnderlyingType, vtyp VariableType) *Variable {
	return &Variable{typ, under, vtyp, new(value.Value)}
}

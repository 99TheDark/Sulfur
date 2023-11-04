package ast

import (
	"fmt"
	"sulfur/src/typing"

	"github.com/llir/llvm/ir/value"
)

type VariableType int

const (
	Local VariableType = iota
	Global
	Parameter
)

type Variable struct {
	Name       string
	Id         int
	Referenced bool
	References bool
	Type       typing.Type
	Status     VariableType
	Value      value.Value
}

func (v *Variable) LLName() string {
	if v.Id == 0 {
		return v.Name
	} else {
		return v.Name + "." + fmt.Sprint(v.Id)
	}
}

func NewVariable(fscope *FuncScope, name string, refs bool, typ typing.Type, status VariableType) *Variable {
	vari := &Variable{
		name,
		fscope.Counts[name],
		false,
		refs,
		typ,
		status,
		nil,
	}
	fscope.Counts[name]++
	return vari
}

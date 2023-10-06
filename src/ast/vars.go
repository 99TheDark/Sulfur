package ast

import (
	. "sulfur/src/errors"
	"sulfur/src/lexer"

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
	Type   Type
	Status VariableType
	Value  *value.Value
}

type Scope struct {
	Block  *ir.Block `json:"-"`
	Parent *Scope
	Vars   map[string]Variable
}

type Func struct {
	Parent *Func
	Return Type
}

func (s *Scope) Lookup(name string, loc *lexer.Location) Variable {
	if val, ok := s.Vars[name]; ok {
		return val
	}
	if s.Parent == nil {
		Errors.Error("'"+name+"' is not defined", loc)
	}
	return s.Parent.Lookup(name, loc)
}

func NewScope() Scope {
	return Scope{
		new(ir.Block),
		nil,
		make(map[string]Variable),
	}
}

func NewVariable(typ Type, status VariableType) Variable {
	return Variable{typ, status, new(value.Value)}
}

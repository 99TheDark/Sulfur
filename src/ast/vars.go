package ast

import (
	"fmt"
	. "sulfur/src/errors"
	"sulfur/src/lexer"
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
	Name   string
	Count  int
	Type   typing.Type
	Status VariableType
	Value  *value.Value
}

type Scope struct {
	Parent *Scope
	Vars   map[string]Variable
}

type Func struct {
	Parent *Func
	Return typing.Type
}

func (s *Scope) Lookup(name string, loc *lexer.Location) Variable {
	if vari, ok := s.Vars[name]; ok {
		return vari
	}
	if s.Parent == nil {
		Errors.Error("'"+name+"' is not defined", loc)
	}
	return s.Parent.Lookup(name, loc)
}

func (s *Scope) Count(name string) int {
	if vari, ok := s.Vars[name]; ok {
		vari.Count++
		return vari.Count
	}
	if s.Parent == nil {
		return 0
	}
	return s.Parent.Count(name)
}

func (v *Variable) LLName() string {
	if v.Count == 0 {
		return v.Name
	} else {
		return v.Name + "." + fmt.Sprint(v.Count)
	}
}

func NewScope() Scope {
	return Scope{
		nil,
		make(map[string]Variable),
	}
}

func NewVariable(scope *Scope, name string, typ typing.Type, status VariableType) Variable {
	return Variable{name, scope.Count(name), typ, status, new(value.Value)}
}

package compiler

import (
	"sulfur/src/typing"

	"github.com/llir/llvm/ir"
)

func (g *generator) size(typ typing.Type) int {
	switch typ {
	case typing.Integer, typing.Unsigned, typing.Float:
		return 4
	case typing.Boolean:
		return 1
	case typing.String:
		return 16
	default:
		return 0
	}
}

func (g *generator) align(typ typing.Type) ir.Align {
	switch typ {
	case typing.Integer, typing.Unsigned, typing.Float:
		return 4
	case typing.Boolean:
		return 1
	default:
		return 8
	}
}

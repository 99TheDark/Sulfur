package compiler

import "sulfur/src/typing"

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

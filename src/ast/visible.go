package ast

import "sulfur/src/lexer"

type Visibility int

const (
	Public Visibility = iota
	Private
	Value
)

func TokenVisibility(t lexer.Token) Visibility {
	switch t.Type {
	case lexer.Public:
		return Public
	case lexer.Private:
		return Private
	case lexer.Value:
		return Value
	}

	return -1
}

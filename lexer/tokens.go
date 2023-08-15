package lexer

import (
	"fmt"
	"strings"
)

type TokenType int

type Token struct {
	Type     TokenType
	Value    string
	Location *Location
}

const (
	None TokenType = iota
	Identifier
	Space
	NewLine
	LeftParen
	RightParen
	EOF
)

func formatValue(value string) string {
	return strings.ReplaceAll(value, "\n", "\\n")
}

func CreateToken(tokentype TokenType, value string, row, col, idx int) *Token {
	return &Token{
		tokentype,
		value,
		CreateLocation(row, col, idx),
	}
}

func (tt TokenType) String() string {
	switch tt {
	case Identifier:
		return "Identifier"
	case Space:
		return "Space"
	case NewLine:
		return "NewLine"
	case LeftParen:
		return "LeftParen"
	case RightParen:
		return "RightParen"
	case EOF:
		return "EOF"
	default:
		return "Unknown"
	}
}

func (t Token) String() string {
	row, col, idx := t.Location.Get()

	return "Token{" + t.Type.String() + " '" + formatValue(t.Value) + "' at " +
		fmt.Sprint(row) + ":" + fmt.Sprint(col) + ", #" + fmt.Sprint(idx) + "}"
}

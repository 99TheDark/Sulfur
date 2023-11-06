package lexer

import (
	"fmt"
	"sulfur/src/typing"
)

type Token struct {
	Type     TokenType
	Value    string
	Location *typing.Location `json:"-"`
}

func (t Token) String() string {
	row, col, idx := t.Location.Get()

	return "Token{" + t.Type.String() + " '" + formatValue(t.Value) + "' at " +
		fmt.Sprint(row) + ":" + fmt.Sprint(col) + ", #" + fmt.Sprint(idx) + "}"
}

func Empty(tok Token) bool {
	if tok.Location == (*typing.Location)(nil) {
		return true
	}
	return false
}

package lexer

import (
	"unicode"
)

func decimal(ch rune) bool {
	return unicode.IsDigit(ch) || ch == '.'
}

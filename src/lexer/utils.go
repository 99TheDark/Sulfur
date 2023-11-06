package lexer

import (
	"strings"
	"unicode"
)

func decimal(ch rune) bool {
	return unicode.IsDigit(ch) || ch == '.'
}

func formatValue(value string) string {
	return strings.ReplaceAll(value, "\n", "\\n")
}

package lexer

import (
	"regexp"
	"unicode/utf8"
)

var Escape = map[string]string{
	"a":  "\a",
	"b":  "\b",
	"f":  "\f",
	"n":  "\n",
	"r":  "\r",
	"t":  "\t",
	"v":  "\v",
	"0":  "\x00",
	"\"": "\"",
	"\\": "\\",
}

var UnicodeFour = regexp.MustCompile("[\\]u[0-F]{4}")
var UnicodeEight = regexp.MustCompile("[\\]U[0-F]{8}")

var escapeReplace = func(str string) string {
	char, _ := utf8.DecodeLastRuneInString(str)
	return string(char)
}

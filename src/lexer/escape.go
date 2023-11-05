package lexer

import (
	"regexp"
	"strconv"
	"sulfur/src/utils"
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

var UnicodeFour = regexp.MustCompile("[\\\\]u[0-F]{4}")
var UnicodeEight = regexp.MustCompile("[\\\\]U[0-F]{8}")

func escapeReplace(str string) string {
	used := str[2:]
	val, _ := strconv.ParseInt(used, 16, 64)

	ch := rune(val)
	strch := string(ch)
	if !utf8.ValidRune(ch) {
		utils.Panic("U+" + used + " is not a valid unicode character")
	}

	return strch
}

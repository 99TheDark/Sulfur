package lexer

import (
	"regexp"
	"strconv"
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
	// TODO: Add errors for invalid utf-8 ranges
	val, _ := strconv.ParseInt(str[2:], 16, 64)
	return string(rune(val))
}

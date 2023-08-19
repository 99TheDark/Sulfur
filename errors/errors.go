package errors

import (
	"fmt"
	"golang/lexer"
	"golang/utils"
	"log"
	"strings"
)

const CodeBuffer int = 4

var Errors ErrorGenerator

type ErrorGenerator struct {
	source []rune
	tokens []lexer.Token
}

func (gen *ErrorGenerator) final() lexer.Token {
	return gen.tokens[len(gen.tokens)-1]
}

func (gen *ErrorGenerator) rowStart(row int) int {
	if row < 0 {
		return 0
	}

	for _, token := range gen.tokens {
		if token.Location.Row == row {
			return token.Location.Idx
		}
	}

	return gen.final().Location.Idx
}

func (gen *ErrorGenerator) rowEnd(row int) int {
	idx := gen.rowStart(row+1) - 1
	if gen.source[idx] == '\n' {
		return idx - 1
	} else {
		return idx
	}
}

func (gen *ErrorGenerator) Error(msg string, loc *lexer.Location) string {
	row, col, _ := loc.Get()

	start, end := gen.rowStart(row-4), gen.rowEnd(row)
	err := "\n" + string(gen.source[start:end+1]) + "\n"

	sidebuf := strings.Repeat(" ", utils.Max(0, col-1))
	err += sidebuf + "^\n"

	err += msg + " (" + fmt.Sprint(row+1) + ":" + fmt.Sprint(col+1) + ")\n"

	log.Fatalln(err)
	return err
}

func New(source string, tokens []lexer.Token) ErrorGenerator {
	return ErrorGenerator{[]rune(source), tokens}
}

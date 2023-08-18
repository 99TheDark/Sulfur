package errors

import (
	"fmt"
	"golang/lexer"
	"golang/utils"
	"log"
	"strings"
)

const CodeBuffer int = 4

type ErrorGenerator struct {
	source []rune
	tokens *[]lexer.Token
}

func (gen *ErrorGenerator) rowStart(row int) int {
	if row < 0 {
		return 0
	}

	tokens := *gen.tokens
	for _, token := range tokens {
		if token.Location.Row == row {
			return token.Location.Idx
		}
	}

	return tokens[len(tokens)-1].Location.Idx
}

func (gen *ErrorGenerator) rowEnd(row int) int {
	return gen.rowStart(row+1) - 1
}

func (gen *ErrorGenerator) Error(msg string, loc *lexer.Location) string {
	row, col, _ := loc.Get()

	start, end := gen.rowStart(row-4), gen.rowEnd(row)
	err := "\n" + string(gen.source[start:end+1])

	sidebuf := strings.Repeat(" ", utils.Max(0, col-1))
	err += sidebuf + "^\n"

	err += msg + " (" + fmt.Sprint(row+1) + ":" + fmt.Sprint(col+1) + ")\n"

	log.Fatalln(err)
	return err
}

func New(source string, tokens *[]lexer.Token) ErrorGenerator {
	return ErrorGenerator{[]rune(source), tokens}
}

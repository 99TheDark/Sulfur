package errors

import (
	"fmt"
	"log"
	"strings"
	"sulfur/src/lexer"
	"sulfur/src/utils"
)

const DebugErrors = true
const CodeBuffer int = 4

var Errors ErrorGenerator

type ErrorGenerator struct {
	lines []string
}

func size(num int) int {
	return len(fmt.Sprint(num))
}

func (gen *ErrorGenerator) Error(msg string, loc *lexer.Location) {
	row, col, _ := loc.Get()

	numSize := size(row + 1)

	err := "\n"
	for i := utils.Max(row-4, 0); i <= row; i++ {
		err += fmt.Sprint(i+1) + ". " + strings.Repeat(" ", numSize-size(i+1))
		err += gen.lines[i] + "\n"
	}

	sidebuf := strings.Repeat(" ", utils.Max(0, numSize+col+2))
	err += sidebuf + "^\n"

	err += msg + " (" + fmt.Sprint(row+1) + ":" + fmt.Sprint(col+1) + ")\n"

	if DebugErrors {
		panic(err)
	} else {
		log.Fatalln(err)
	}
}

func New(source string) ErrorGenerator {
	return ErrorGenerator{strings.Split(source, "\n")}
}

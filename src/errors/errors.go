package errors

import (
	"fmt"
	"os"
	"strings"
	"sulfur/src/lexer"
	"sulfur/src/utils"
)

const Debug = false
const Color = false
const CodeBuffer = 4

var Errors ErrorGenerator
var Step = Compiling

type ErrorGenerator struct {
	lines []string
}

func size(num int) int {
	return len(fmt.Sprint(num))
}

func (gen *ErrorGenerator) message(msg, typ, colorStart, colorEnd string, loc *lexer.Location) string {
	row, col, _ := loc.Get()

	numSize := size(row + 1)

	if !Color {
		colorStart, colorEnd = "", ""
	}

	err := ""
	if Debug {
		err += "\n"
	}

	err += colorStart + typ + " while " + string(Step) + ":" + colorEnd + "\n"
	for i := utils.Max(row-4, 0); i <= row; i++ {
		err += fmt.Sprint(i+1) + ". " + strings.Repeat(" ", numSize-size(i+1))
		err += gen.lines[i] + "\n"
	}

	sidebuf := strings.Repeat(" ", utils.Max(0, numSize+col+2))
	err += sidebuf + "^\n"

	err += colorStart + msg + " (" + fmt.Sprint(row+1) + ":" + fmt.Sprint(col+1) + ")" + colorEnd + "\n"
	return err
}

func (gen *ErrorGenerator) Error(msg string, loc *lexer.Location) {
	err := gen.message(msg, "Error", "\033[31m", "\033[0m", loc)

	if Debug {
		panic(err)
	} else {
		fmt.Println(err)
		os.Exit(1)
	}
}

func (gen *ErrorGenerator) Warn(msg string, loc *lexer.Location) {
	err := gen.message(msg, "Warning", "\033[33m", "\033[0m", loc)
	fmt.Println(err)
}

func New(source string) ErrorGenerator {
	return ErrorGenerator{strings.Split(source, "\n")}
}

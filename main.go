package main

import (
	"fmt"
	"log"
	"os"
	"sulfur/src/checker"
	"sulfur/src/compiler"
	"sulfur/src/errors"
	"sulfur/src/lexer"
	"sulfur/src/parser"
	"sulfur/src/settings"
	"sulfur/src/utils"
	"time"
)

func main() {
	start := time.Now()
	args := utils.NewQueue(os.Args[1:])

	var input string
	if arg, ok := args.Next(); ok {
		input = *arg
	} else {
		log.Fatalln("No file given")
	}

	for !args.Empty() {
		name := *args.Consume()

		if name[0] == '-' { // Is a flag
			switch name[1:] {
			case "trace":
				settings.Stacktrace = true
			case "debug":
				settings.Debug = true
			case "colorless":
				settings.Colored = false
			}
		}
	}

	build(input)

	fmt.Println("Compile time:", time.Since(start))
}

func build(path string) {
	name := utils.FileName(path)

	code, err := lexer.GetSourceCode(path)
	if err != nil {
		log.Fatalln(err)
	}

	errors.Errors = errors.NewErrorGenerator(code)

	errors.Step = errors.Lexing
	unfiltered := lexer.Lex(code)
	utils.AttemptSave(func() error {
		return lexer.Save(unfiltered, "cli/debug/unfiltered.txt")
	})

	tokens := lexer.Filter(unfiltered)
	utils.AttemptSave(func() error {
		return lexer.Save(tokens, "cli/debug/tokens.txt")
	})

	errors.Step = errors.Parsing
	ast := parser.Parse(code, tokens)
	utils.AttemptSave(func() error {
		return parser.Save(ast, 1, "cli/debug/ast.json")
	})

	errors.Step = errors.Inferring
	props := checker.TypeCheck(ast)

	errors.Step = errors.Generating
	llcode := compiler.Generate(ast, props, path)
	utils.AttemptSave(func() error {
		return compiler.Save("; ModuleID = '"+path+"'\n"+llcode, "cli/tmp/"+name+".ll")
	})
}

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
	"sulfur/src/utils"
	"time"
)

func main() {
	start := time.Now()
	args := os.Args[1:]

	build(args[1])

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
	if err := lexer.Save(unfiltered, "cli/debug/unfiltered.txt"); err != nil { // TODO: Only work in Debug mode
		log.Fatalln(err)
	}

	tokens := lexer.Filter(unfiltered)
	if err := lexer.Save(tokens, "cli/debug/tokens.txt"); err != nil { // TODO: Only work in Debug mode
		log.Fatalln(err)
	}

	errors.Step = errors.Parsing
	ast := parser.Parse(code, tokens)
	if err := parser.Save(ast, 1, "cli/debug/ast.json"); err != nil { // TODO: Only work in Debug mode
		log.Fatalln(err)
	}

	errors.Step = errors.Inferring
	props := checker.TypeCheck(ast)

	errors.Step = errors.Generating
	llcode := compiler.Generate(ast, props, path)
	if err := compiler.Save("; ModuleID = '"+path+"'\n"+llcode, "cli/tmp/"+name+".ll"); err != nil {
		log.Fatalln(err)
	}
}

package main

import (
	"fmt"
	"log"
	"sulfur/src/checker"
	"sulfur/src/compiler"
	"sulfur/src/errors"
	"sulfur/src/lexer"
	"sulfur/src/parser"
	"time"
)

func main() {
	start := time.Now()

	code, err := lexer.GetSourceCode("io/script.su")
	if err != nil {
		log.Fatalln(err)
	}

	unfiltered := lexer.Lex(code)
	if err := lexer.Save(unfiltered, "io/unfiltered.txt"); err != nil {
		log.Fatalln(err)
	}

	tokens := lexer.Filter(unfiltered)
	if err := lexer.Save(tokens, "io/tokens.txt"); err != nil {
		log.Fatalln(err)
	}

	errors.Errors = errors.New(code)

	errors.Step = errors.Parsing
	ast := parser.Parse(code, tokens)
	if err := parser.Save(ast, 1, "io/ast.json"); err != nil {
		log.Fatalln(err)
	}

	errors.Step = errors.Inferring
	types := checker.TypeCheck(ast)

	errors.Step = errors.Generating
	llcode := compiler.Generate(ast, types)
	if err := compiler.Save("; ModuleID = 'script.su'\n"+llcode, "io/asm/script.ll"); err != nil {
		log.Fatalln(err)
	}

	fmt.Println("Compile time:", time.Since(start))
}

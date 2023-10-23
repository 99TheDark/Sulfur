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
	if !errors.Build {
		start := time.Now()

		code, err := lexer.GetSourceCode("io/script.su")
		if err != nil {
			log.Fatalln(err)
		}

		errors.Errors = errors.NewErrorGenerator(code)

		errors.Step = errors.Lexing
		unfiltered := lexer.Lex(code)
		if err := lexer.Save(unfiltered, "io/unfiltered.txt"); err != nil {
			log.Fatalln(err)
		}

		tokens := lexer.Filter(unfiltered)
		if err := lexer.Save(tokens, "io/tokens.txt"); err != nil {
			log.Fatalln(err)
		}

		errors.Step = errors.Parsing
		ast := parser.Parse(code, tokens)
		if err := parser.Save(ast, 1, "io/ast.json"); err != nil {
			log.Fatalln(err)
		}

		errors.Step = errors.Inferring
		props := checker.TypeCheck(ast)

		errors.Step = errors.Generating
		llcode := compiler.Generate(ast, props)
		if err := compiler.Save("; ModuleID = 'script.su'\n"+llcode, "io/asm/script.ll"); err != nil {
			log.Fatalln(err)
		}

		fmt.Println("Compile time:", time.Since(start))
	} else {
		code, err := lexer.GetSourceCode("io/script.su")
		if err != nil {
			log.Fatalln(err)
		}

		errors.Errors = errors.NewErrorGenerator(code)

		errors.Step = errors.Lexing
		unfiltered := lexer.Lex(code)
		tokens := lexer.Filter(unfiltered)

		errors.Step = errors.Parsing
		ast := parser.Parse(code, tokens)

		errors.Step = errors.Inferring
		props := checker.TypeCheck(ast)

		errors.Step = errors.Generating
		llcode := compiler.Generate(ast, props)

		fmt.Print(llcode)
	}
}

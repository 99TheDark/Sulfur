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

	code, err := lexer.GetSourceCode("io/script.sulfur")
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

	ast := parser.Parse(code, tokens)
	if err := parser.Save(ast, 1, "io/ast.json"); err != nil {
		log.Fatalln(err)
	}

	types := checker.TypeCheck(ast)

	llcode := compiler.Generate(ast, types)
	if err := compiler.Save(llcode, "io/asm/script.ll"); err != nil {
		log.Fatalln(err)
	}

	fmt.Println("Compile time:", time.Since(start))
}

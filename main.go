package main

import (
	"log"
	"sulfur/src/checker"
	"sulfur/src/errors"
	"sulfur/src/lexer"
	"sulfur/src/parser"
)

func main() {
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

	errors.Errors = errors.New(code, *unfiltered)

	ast := parser.Parse(code, tokens)
	if err := parser.Save(ast, 1, "io/ast.json"); err != nil {
		log.Fatalln(err)
	}

	checker.TypeCheck(ast)
}

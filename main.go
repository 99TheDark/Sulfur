package main

import (
	"golang/compiler"
	"golang/errors"
	"golang/lexer"
	"golang/parser"
	"log"
)

func main() {
	code, err := lexer.GetSourceCode("io/script.lv4")
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

	typed := parser.Type(ast)
	if err := parser.Save(typed, 1, "io/typed.json"); err != nil {
		log.Fatalln(err)
	}

	llvm := compiler.Assemble(ast)
	if err := compiler.Save(llvm, "io/script.ll"); err != nil {
		log.Fatalln(err)
	}
}

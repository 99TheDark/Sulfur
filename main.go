package main

import (
	"golang/compiler"
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
	tokens := lexer.Filter(unfiltered)
	if err := lexer.Save(tokens, "io/tokens.txt"); err != nil {
		log.Fatalln(err)
	}

	ast := parser.Parse(code, unfiltered, tokens)
	if err := parser.Save(ast, 1, "io/ast.json"); err != nil {
		log.Fatalln(err)
	}

	llvm := compiler.Assemble(ast)
	if err := compiler.Save(llvm, "io/script.ll"); err != nil {
		log.Fatalln(err)
	}
}

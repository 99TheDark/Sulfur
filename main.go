package main

import (
	"fmt"
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

	tokens := lexer.Lex(code)
	lexer.Filter(tokens)
	if err := lexer.Save(tokens, "io/tokens.txt"); err != nil {
		log.Fatalln(err)
	}

	ast := parser.Parse(tokens)
	if err := parser.Save(ast, 1, "io/ast.json"); err != nil {
		log.Fatalln(err)
	}

	llvm := compiler.Assemble(ast)
	fmt.Println(llvm)
}

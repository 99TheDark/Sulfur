package main

import (
	"log"
	"sulfur/errors"
	"sulfur/lexer"
)

func main() {
	code, err := lexer.GetSourceCode("io/script.sulfur")
	if err != nil {
		log.Fatalln(err)
	}

	tokens := lexer.Lex(code)
	if err := lexer.Save(tokens, "io/tokens.txt"); err != nil {
		log.Fatalln(err)
	}

	errors.Errors = errors.New(code, *tokens)

	/*
		ast := parser.Parse(code, tokens)
		if err := parser.Save(ast, 1, "io/ast.json"); err != nil {
			log.Fatalln(err)
		}
	*/

	/*
		typed := parser.TypeCheck(ast)
		if err := parser.Save(typed, 1, "io/typed.json"); err != nil {
			log.Fatalln(err)
		}

		llvm := compiler.Assemble(ast)
		if err := compiler.Save(llvm, "io/asm/script.ll"); err != nil {
			log.Fatalln(err)
		}
	*/
}

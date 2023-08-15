package main

import (
	"fmt"
	"golang/lexer"
	"golang/parser"
)

func main() {
	code := "int x = 5 + 3 - 2 * (1 + 4/3)"

	tokens := lexer.Lex(code)
	lexer.Filter(tokens)

	// fmt.Println(lexer.Stringify(tokens))
	ast := parser.Parse(tokens)

	fmt.Println(parser.Stringify(ast))
}

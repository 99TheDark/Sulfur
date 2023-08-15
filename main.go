package main

import (
	"fmt"
	"golang/lexer"
)

func main() {
	code := "1 abc Eeo(n)++ {  [}]\nab +\n-%"

	tokens := lexer.Lex(code)
	lexer.Filter(tokens)

	fmt.Println(lexer.Stringify(tokens))
}

package main

import (
	"fmt"
	"golang/lexer"
)

func main() {
	code := "1 abc Eeo(n)++ {  }"
	tokens := lexer.Lex(code)

	str := "[]Token{\n"
	for _, token := range *tokens {
		str += "    " + fmt.Sprintln(token)
	}
	str += "}"

	fmt.Println(str)
}

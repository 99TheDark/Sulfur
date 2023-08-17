package main

import (
	"encoding/json"
	"golang/lexer"
	"golang/parser"
	"os"
)

func main() {
	code := "5 + 3 * (6 - 2)"

	tokens := lexer.Lex(code)
	lexer.Filter(tokens)

	// fmt.Println(lexer.Stringify(tokens))
	ast := parser.Parse(tokens)

	json, err := json.MarshalIndent(ast, "", "    ")
	if err != nil {
		panic(err)
	}

	file, err2 := os.Create("io/ast.json")
	if err2 != nil {
		panic(err2)
	}

	_, err3 := file.Write(json)
	if err3 != nil {
		file.Close()
		panic(err3)
	}

	err4 := file.Close()
	if err4 != nil {
		panic(err4)
	}
}

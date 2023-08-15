package parser

import (
	"golang/lexer"
	"reflect"
)

type parser struct {
	tokens []lexer.Token
	idx    int
}

func (p *parser) at() lexer.Token {
	return p.tokens[p.idx]
}

func (p *parser) eat() lexer.Token {
	el := p.at()
	p.idx++
	return el
}

func (p *parser) parsePrimary() Expression {
	token := p.eat()
	switch token.Type {
	case lexer.Identifier:
		return Identifier{token.Location, token.Value}
	default:
		return Identifier{token.Location, "Error"}
	}
}

func Parse(tokens *[]lexer.Token) Program {
	parser := parser{*tokens, 0}
	statements := []Expression{}
	for parser.at().Type != lexer.EOF {
		statements = append(statements, parser.parsePrimary())
	}
	return Program{statements}
}

func Stringify(ast Program) string {
	str := "Program{\n"
	for _, expr := range ast.Body {
		str += "    " + reflect.TypeOf(expr).String() + "{\n" + /* children joined with 8 spaces before */ "    }\n"
	}

	return str + "}"
}

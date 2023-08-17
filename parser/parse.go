package parser

import (
	"golang/lexer"
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

func (p *parser) parseAdditive() Expression {
	left := p.parsePrimary()
	// todo: clean up
	for lexer.Operation(p.at().Value) == lexer.Add || lexer.Operation(p.at().Value) == lexer.Subtract {
		token := p.eat()
		right := p.parsePrimary()

		left = BinaryOperation{token.Location, left, right, lexer.Operation(token.Value)}
	}
	return left
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
		statements = append(statements, parser.parseAdditive())
	}
	return Program{statements}
}

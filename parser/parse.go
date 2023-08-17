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

func (p *parser) expect(tokentype lexer.TokenType) {
	token := p.eat()
	if token.Type != tokentype {
		panic("Expected " + tokentype.String() + ", but got " + token.Type.String() + " instead")
	}
}

func (p *parser) op() lexer.Operation {
	return lexer.Operation(p.at().Value)
}

func (p *parser) parseGroup() Expression {
	expr := p.parseAdditive()
	p.expect(lexer.RightParen)
	return expr
}

func (p *parser) parseAdditive() Expression {
	left := p.parseMultiplicative()
	for p.op() == lexer.Add || p.op() == lexer.Subtract {
		token := p.eat()
		right := p.parseMultiplicative()

		left = BinaryOperation{token.Location, left, right, lexer.Operation(token.Value)}
	}
	return left
}

func (p *parser) parseMultiplicative() Expression {
	left := p.parsePrimary()
	for p.op() == lexer.Multiply || p.op() == lexer.Divide {
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
	case lexer.LeftParen:
		return p.parseGroup()
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

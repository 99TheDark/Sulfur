package parser

import (
	"encoding/json"
	"golang/lexer"
	"os"
	"strings"
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

func (p *parser) parseBlock() []Expression {
	block := []Expression{}
	for p.at().Type != lexer.RightBrace {
		block = append(block, p.parseAdditive())
	}
	p.eat()
	return block
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
	case lexer.LeftBrace:
		return Block{token.Location, p.parseBlock()}
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

func SaveAST(ast Program, spaces int, location string) error {
	var file *os.File

	json, err := json.MarshalIndent(ast, "", strings.Repeat(" ", spaces))
	if err != nil {
		return err
	}

	file, err = os.Create(location)
	if err != nil {
		return err
	}

	_, err = file.Write(json)
	if err != nil {
		file.Close()
		return err
	}

	err = file.Close()
	if err != nil {
		return err
	}

	return nil
}

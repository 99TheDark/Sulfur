package parser

import (
	"bytes"
	"encoding/json"
	"fmt"
	"strings"
	. "sulfur/errors"
	"sulfur/lexer"
	"sulfur/typing"
	"sulfur/utils"

	"github.com/llir/llvm/ir"
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

func (p *parser) expect(typ lexer.TokenType) lexer.Token {
	token := p.eat()
	if token.Type != typ {
		Errors.Error(
			"Expected "+typ.String()+", but got "+token.Type.String()+" '"+token.Value+"' instead",
			token.Location,
		)
	}
	return token
}

func (p *parser) optional(typ lexer.TokenType) {
	if p.at().Type == typ {
		p.eat()
	}
}

func (p *parser) is(catagory []lexer.TokenType) bool {
	return utils.Contains(catagory, p.at().Type)
}

// Statements
func (p *parser) parseStatement() (stmt Statement) {
	switch p.at().Type {
	case lexer.NewLine:
		p.eat()
		return
	case lexer.If:
		return p.parseIfStatement()
	default:
		Errors.Error("Unknown token '"+p.at().Value+"'", p.at().Location)
		return
	}
}

func (p *parser) parseBlock() Block {
	loc := p.expect(lexer.OpenBrace)
	body := []Statement{}
	for p.at().Type != lexer.CloseBrace {
		if stmt := p.parseStatement(); stmt != nil {
			body = append(body, stmt)
		}
	}
	p.expect(lexer.CloseBrace)

	return Block{
		loc.Location,
		body,
		*typing.NewScope(),
	}
}

func (p *parser) parseIfStatement() IfStatement {
	loc := p.expect(lexer.If)
	cond := p.parseExpression()
	body := p.parseBlock()
	return IfStatement{
		loc.Location,
		cond,
		body,
		Block{},
	}
}

// Expressions (part of a statement, but not a statement)
func (p *parser) parseExpression() Statement {
	return p.parseComparison()
}

func (p *parser) parseComparison() Statement {
	left := p.parseAdditive()
	if p.is(Comparator) {
		token := p.eat()
		return Comparison{
			token.Location,
			left,
			p.parseAdditive(),
			token.Type,
			NoType(),
		}
	}
	return left
}

func (p *parser) parseAdditive() Statement {
	left := p.parseMultiplicative()
	for p.at().Type == lexer.Addition || p.at().Type == lexer.Subtraction {
		token := p.eat()
		right := p.parseMultiplicative()

		left = BinaryOperation{
			token.Location,
			left,
			right,
			token.Type,
			NoType(),
		}
	}
	return left
}

func (p *parser) parseMultiplicative() Statement {
	left := p.parsePrimary()
	for p.at().Type == lexer.Multiplication || p.at().Type == lexer.Division {
		token := p.eat()
		right := p.parsePrimary()

		left = BinaryOperation{
			token.Location,
			left,
			right,
			token.Type,
			NoType(),
		}
	}
	return left
}

func (p *parser) parsePrimary() Statement {
	switch p.at().Type {
	case lexer.Boolean:
		return p.parseBoolean()
	case lexer.String:
		return p.parseString()
	case lexer.Identifier:
		return p.parseIdentifier()
	}

	Errors.Error("Unknown token '"+p.at().Value+"'", p.at().Location)
	return BadStatement{}
}

func (p *parser) parseBoolean() BooleanLiteral {
	token := p.eat()

	val := false
	if token.Value == "true" {
		val = true
	}

	return BooleanLiteral{
		token.Location,
		val,
		NoType(),
	}
}

func (p *parser) parseString() StringLiteral {
	token := p.eat()
	return StringLiteral{
		new(Program),
		token.Location,
		token.Value,
		NoType(),
	}
}

func (p *parser) parseIdentifier() Identifier {
	fmt.Println(p.at())
	token := p.eat()
	return Identifier{
		token.Location,
		typing.NewScope(),
		token.Value,
		NoType(),
	}
}

func Parse(source string, tokens *[]lexer.Token) Program {
	parser := parser{*tokens, 0}
	statements := []Statement{}
	for parser.at().Type != lexer.EOF {
		if stmt := parser.parseStatement(); stmt != nil {
			statements = append(statements, stmt)
		}
	}

	prog := Program{
		&[]*FunctionLiteral{},
		make(map[*FunctionLiteral]*ir.Func),
		&[]*StringLiteral{},
		Block{
			lexer.NoLocation,
			statements,
			*typing.NewScope(),
		},
	}

	return prog
}

func Save(ast any, spaces int, location string) error {
	buf := new(bytes.Buffer)
	enc := json.NewEncoder(buf)

	enc.SetEscapeHTML(false)
	if spaces > 0 {
		enc.SetIndent("", strings.Repeat(" ", spaces))
	}

	err := enc.Encode(ast)
	if err != nil {
		return err
	}

	return utils.SaveFile(buf.Bytes(), location)
}

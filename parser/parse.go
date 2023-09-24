package parser

import (
	"bytes"
	"encoding/json"
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

func (p *parser) parseSimpleStatement() Statement {
	return Block{}
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
	/*loc := p.expect(lexer.If)
	cond := p.parseSimpleStatement()
	body := p.parseBlock()
	return IfStatement{
		loc.Location,
		cond,
		body,
		Block{},
	}*/
	p.expect(lexer.If)
	return IfStatement{}
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

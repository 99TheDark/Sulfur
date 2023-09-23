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

func (p *parser) peek() lexer.Token {
	return p.tokens[p.idx+1]
}

func (p *parser) eat() lexer.Token {
	el := p.at()
	p.idx++
	return el
}

func (p *parser) expect(tokentype lexer.TokenType) lexer.Token {
	token := p.eat()
	if token.Type != tokentype {
		Errors.Error(
			"Expected "+tokentype.String()+", but got "+token.Type.String()+" '"+token.Value+"' instead",
			token.Location,
		)
	}
	return token
}

func (p *parser) parseStatement() Expression {
	return IfStatement{}
}

func Parse(source string, tokens *[]lexer.Token) Program {
	// parser := parser{*tokens, 0}
	statements := []Expression{}
	/*for parser.at().Type != lexer.EOF {
		statements = append(statements, parser.parseStatement())
	}*/

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

package parser

import (
	"bytes"
	"encoding/json"
	"strings"
	"sulfur/src/ast"
	"sulfur/src/builtins"
	. "sulfur/src/errors"
	"sulfur/src/lexer"
	"sulfur/src/utils"
)

type parser struct {
	source  []lexer.Token
	program *ast.Program
	size    int
	top     *ast.Scope
	idx     int
}

func (p *parser) at() lexer.Token {
	return p.source[p.idx]
}

func (p *parser) tt() lexer.TokenType {
	// Shorthand
	return p.at().Type
}

func (p *parser) peek(ahead int) lexer.Token {
	if p.idx+ahead >= p.size {
		return p.source[p.size-1]
	}
	return p.source[p.idx+ahead]
}

func (p *parser) next() lexer.Token {
	return p.peek(1)
}

func (p *parser) eat() lexer.Token {
	token := p.source[p.idx]
	p.idx++
	return token
}

func (p *parser) expect(symbols ...lexer.TokenType) lexer.Token {
	tok := p.eat()
	if !utils.Contains(symbols, tok.Type) {
		length := len(symbols)
		expected := symbols[0].String()
		for i := 1; i < length-1; i++ {
			expected += ", " + symbols[i].String()
		}
		if length > 1 {
			expected += " or " + symbols[length-1].String()
		}

		Errors.Error("Expected "+expected+", but got "+tok.Type.String()+" instead", tok.Location)
	}
	return tok
}

func (p *parser) prefix(symbols ...lexer.TokenType) lexer.Token {
	if utils.Contains(symbols, p.tt()) {
		return p.eat()
	}
	return lexer.Token{}
}

func (p *parser) is(catagory []lexer.TokenType) bool {
	return utils.Contains(catagory, p.tt())
}

func Parse(source string, tokens *[]lexer.Token) *ast.Program {
	prog := ast.Program{
		Functions:   []builtins.FuncSignature{},
		BinaryOps:   []builtins.BinaryOpSignature{},
		UnaryOps:    []builtins.UnaryOpSignature{},
		Comparisons: []builtins.ComparisonSignature{},
		TypeConvs:   []builtins.TypeConvSignature{},
		IncDecs:     []builtins.IncDecSignature{},
		Classes:     []ast.Class{},
		Strings:     []ast.String{},
		Contents:    ast.Block{},
	}

	scope := ast.NewScope()
	p := parser{
		*tokens,
		&prog,
		len(*tokens),
		&scope,
		0,
	}

	body := []ast.Expr{}
	p.parseStmts(
		func() {
			body = append(body, p.parseStmt())
		},
		[]lexer.TokenType{},
		[]lexer.TokenType{lexer.NewLine, lexer.Semicolon},
	)

	prog.Contents = ast.Block{
		Pos:   lexer.NoLocation,
		Body:  body,
		Scope: &scope,
	}

	return &prog
}

func Save(prog *ast.Program, spaces int, path string) error {
	buf := new(bytes.Buffer)
	enc := json.NewEncoder(buf)

	enc.SetEscapeHTML(false)
	if spaces > 0 {
		enc.SetIndent("", strings.Repeat(" ", spaces))
	}

	err := enc.Encode(prog)
	if err != nil {
		return err
	}

	return utils.SaveFile(buf.Bytes(), path)
}

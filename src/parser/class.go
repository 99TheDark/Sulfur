package parser

import (
	"sulfur/src/ast"
	. "sulfur/src/errors"
	"sulfur/src/lexer"
)

func (p *parser) parseClass() ast.Class {
	tok := p.expect(lexer.Class)
	name := p.parseIdentifier()
	p.expect(lexer.OpenBrace)
	fields := []ast.Field{}
	methods := []ast.Function{}
	news := []ast.Function{}
	dels := []ast.Function{}
	convs := []ast.To{}
	opers := []ast.Operation{}
	p.parseStmts(
		func() {
			tok := p.at()
			switch tok.Type {
			case lexer.Public, lexer.Private, lexer.Value:
				fields = append(fields, p.parseField())
				return
			case lexer.Identifier:
				methods = append(methods, p.parseMethod())
				return
			case lexer.New:
				news = append(news, p.parseNewDel())
				return
			case lexer.Delete:
				dels = append(dels, p.parseNewDel())
				return
			case lexer.To:
				convs = append(convs, p.parseTo())
				return
			case lexer.Operator:
				opers = append(opers, p.parseOperation())
				return
			}

			Errors.Error("Invalid statement in class", tok.Location)
		},
		[]lexer.TokenType{lexer.CloseBrace},
		[]lexer.TokenType{lexer.NewLine, lexer.Semicolon},
	)

	return ast.Class{
		Pos:         tok.Location,
		Name:        name,
		Extends:     []ast.Identifier{},
		Fields:      fields,
		Constuctors: news,
		Destructors: dels,
		Methods:     methods,
		Conversions: convs,
		Operations:  opers,
	}
}

func (p *parser) parseField() ast.Field {
	status := p.eat()
	typ := p.parseIdentifier()
	val := p.parseIdentifier()
	var read, write bool
	switch status.Type {
	case lexer.Public:
		read, write = true, true
	case lexer.Private:
		read, write = false, false
	case lexer.Value:
		read, write = true, false
	}

	return ast.Field{
		Read:  read,
		Write: write,
		Type:  typ,
		Name:  val,
	}
}

func (p *parser) parseMethod() ast.Function {
	name := p.parseIdentifier()
	p.expect(lexer.OpenParen)
	params := []ast.Param{}
	p.parseStmts(
		func() {
			params = append(params, p.parseParam())
		},
		[]lexer.TokenType{lexer.CloseParen},
		[]lexer.TokenType{lexer.Delimiter},
	)

	ret := ast.Identifier{}
	if p.at().Type == lexer.OpenParen {
		p.expect(lexer.OpenParen)
		ret = p.parseIdentifier()
		p.expect(lexer.CloseParen)
	}

	body := p.parseBlock()

	return ast.Function{
		Pos:    name.Pos,
		Name:   name,
		Params: params,
		Return: ret,
		Body:   body,
	}
}

func (p *parser) parseNewDel() ast.Function {
	tok := p.eat()
	params := []ast.Param{}
	p.expect(lexer.OpenParen)
	p.parseStmts(
		func() {
			params = append(params, p.parseParam())
		},
		[]lexer.TokenType{lexer.CloseParen},
		[]lexer.TokenType{lexer.Delimiter},
	)

	body := p.parseBlock()

	return ast.Function{
		Pos: tok.Location,
		Name: ast.Identifier{
			Pos:  tok.Location,
			Name: tok.Value,
		},
		Params: params,
		Return: ast.Identifier{},
		Body:   body,
	}
}

func (p *parser) parseTo() ast.To {
	tok := p.eat()
	typ := p.parseIdentifier()
	body := p.parseBlock()

	return ast.To{
		Pos:  tok.Location,
		Type: typ,
		Body: body,
	}
}

func (p *parser) parseOperation() ast.Operation {
	tok := p.eat()
	op := p.eat()
	params := []ast.Param{}
	p.expect(lexer.OpenParen)
	p.parseStmts(
		func() {
			params = append(params, p.parseParam())
		},
		[]lexer.TokenType{lexer.CloseParen},
		[]lexer.TokenType{lexer.Delimiter},
	)

	ret := ast.Identifier{}
	if p.at().Type == lexer.OpenParen {
		p.expect(lexer.OpenParen)
		ret = p.parseIdentifier()
		p.expect(lexer.CloseParen)
	}

	body := p.parseBlock()

	return ast.Operation{
		Pos:    tok.Location,
		Op:     &op,
		Params: params,
		Return: []ast.Identifier{ret},
		Body:   body,
	}
}

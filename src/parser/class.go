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
	methods := []ast.Method{}
	news := []ast.Method{}
	dels := []ast.Method{}
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

	return ast.Field{
		Status: ast.TokenVisibility(status),
		Type:   typ,
		Name:   val,
	}
}

func (p *parser) parseMethod() ast.Method {
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

	// TODO: Parse status
	return ast.Method{
		Function: ast.Function{
			Pos:    name.Pos,
			Name:   name,
			Params: params,
			Return: ret,
			Body:   body,
		},
		Status: -1,
	}
}

func (p *parser) parseNewDel() ast.Method {
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

	// TODO: Don't require body on constructor
	body := p.parseBlock()

	// TODO: Parse status
	return ast.Method{
		Function: ast.Function{
			Pos: tok.Location,
			Name: ast.Identifier{
				Pos:  tok.Location,
				Name: tok.Value,
			},
			Params: params,
			Return: ast.Identifier{},
			Body:   body,
		},
		Status: -1,
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

package parser

import (
	"sulfur/src/ast"
	. "sulfur/src/errors"
	"sulfur/src/lexer"
)

func (p *parser) parseClass() ast.Class {
	tok := p.eat()
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
			prefix := lexer.Token{}
			tok := p.at()
			if ast.IsVisibility(tok) {
				prefix = p.eat()
				tok = p.at()
			}

			switch tok.Type {
			case lexer.Identifier:
				if p.next().Type == lexer.OpenParen {
					methods = append(methods, p.parseMethod(prefix))
				} else {
					fields = append(fields, p.parseField(prefix))
				}
				return
			case lexer.New:
				news = append(news, p.parseNew(prefix))
				return
			case lexer.Delete:
				dels = append(dels, p.parseDel(prefix))
				return
			case lexer.To:
				if !lexer.Empty(prefix) {
					Errors.Error("Type conversions cannot have visibility modifiers", prefix.Location)
				}
				convs = append(convs, p.parseTo())
				return
			case lexer.Operator:
				if !lexer.Empty(prefix) {
					Errors.Error("Operator overloading cannot have visibility modifiers", prefix.Location)
				}
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

func (p *parser) parseField(prefix lexer.Token) ast.Field {
	typ := p.parseIdentifier()
	val := p.parseIdentifier()

	vis, loc := ast.TokenVis(prefix, ast.Public, typ.Pos)
	return ast.Field{
		Pos:    loc,
		Status: vis,
		Type:   typ,
		Name:   val,
	}
}

func (p *parser) parseMethod(prefix lexer.Token) ast.Method {
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
	if p.tt() == lexer.OpenParen {
		p.expect(lexer.OpenParen)
		ret = p.parseIdentifier()
		p.expect(lexer.CloseParen)
	}

	body := p.parseBlock()

	vis, loc := ast.TokenVis(prefix, ast.Public, name.Pos)
	return ast.Method{
		Function: ast.Function{
			Pos:    loc,
			Name:   name,
			Params: params,
			Return: ret,
			Body:   body,
		},
		Status: vis,
	}
}

func (p *parser) parseNew(prefix lexer.Token) ast.Method {
	tok := p.eat()
	params := []ast.Param{}
	p.expect(lexer.OpenParen)
	p.parseStmts(
		func() {
			params = append(params, p.parseNewParam())
		},
		[]lexer.TokenType{lexer.CloseParen},
		[]lexer.TokenType{lexer.Delimiter},
	)

	body := p.parseBlock()

	vis, loc := ast.TokenVis(prefix, ast.Public, tok.Location)
	return ast.Method{
		Function: ast.Function{
			Pos: loc,
			Name: ast.Identifier{
				Pos:  tok.Location,
				Name: tok.Value,
			},
			Params: params,
			Return: ast.Identifier{},
			Body:   body,
		},
		Status: vis,
	}
}

func (p *parser) parseDel(prefix lexer.Token) ast.Method {
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

	vis, loc := ast.TokenVis(prefix, ast.Public, tok.Location)
	return ast.Method{
		Function: ast.Function{
			Pos: loc,
			Name: ast.Identifier{
				Pos:  tok.Location,
				Name: tok.Value,
			},
			Params: params,
			Return: ast.Identifier{},
			Body:   body,
		},
		Status: vis,
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
	if p.tt() == lexer.OpenParen {
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

func (p *parser) parseNewParam() ast.Param {
	typ := p.parseIdentifier()
	auto := p.prefix(lexer.Autodef)
	name := p.parseIdentifier()
	if lexer.Empty(auto) {
		return ast.Param{
			Type:    typ,
			Name:    name,
			Autodef: false,
		}
	} else {
		return ast.Param{
			Type:    typ,
			Name:    name,
			Autodef: true,
		}
	}
}

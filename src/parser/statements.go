package parser

import (
	"sulfur/src/ast"
	"sulfur/src/builtins"
	. "sulfur/src/errors"
	"sulfur/src/lexer"
	"sulfur/src/typing"
)

func (p *parser) parseStmt() ast.Expr {
	tok := p.at()
	switch tok.Type {
	case lexer.Identifier:
		return p.parseHybridStmt()
	case lexer.Func:
		return p.parseFunction()
	case lexer.Class:
		return p.parseClass()
	case lexer.Enum:
		return p.parseEnum()
	case lexer.If:
		return p.parseIfStmt()
	case lexer.For:
		return p.parseForLoop()
	case lexer.While:
		return p.parseWhileLoop()
	case lexer.Do:
		return p.parseDoWhileLoop()
	case lexer.Return:
		return p.parseReturn()
	case lexer.Break:
		return p.parseBreak()
	case lexer.Continue:
		return p.parseContinue()
	}

	Errors.Error("Invalid statement", tok.Location)
	return &ast.BadExpr{
		Pos: tok.Location,
	}
}

func (p *parser) parseStmts(stmtgen func(), ending []lexer.TokenType, delim []lexer.TokenType) {
	for !p.is(ending) {
		if p.tt() == lexer.NewLine {
			p.eat()
			continue
		}
		if p.tt() == lexer.EOF {
			return
		}

		stmtgen()

		if p.tt() == lexer.EOF {
			return
		}
		if !p.is(ending) {
			p.expect(delim...)
		}
	}
	p.eat()
}

func (p *parser) parseBlock() ast.Block {
	tok := p.expect(lexer.OpenBrace, lexer.Arrow)
	if tok.Type == lexer.Arrow {
		scope := ast.NewScope()
		scope.Parent = p.top
		return ast.Block{
			Pos:   tok.Location,
			Body:  []ast.Expr{p.parseStmt()},
			Scope: scope,
		}
	} else {
		scope := ast.NewScope()
		scope.Parent = p.top
		p.top = scope

		stmts := []ast.Expr{}
		p.parseStmts(
			func() {
				stmts = append(stmts, p.parseStmt())
			},
			[]lexer.TokenType{lexer.CloseBrace},
			[]lexer.TokenType{lexer.NewLine, lexer.Semicolon},
		)

		p.top = scope.Parent
		return ast.Block{
			Pos:   tok.Location,
			Body:  stmts,
			Scope: scope,
		}
	}
}

func (p *parser) parseFunction() ast.Function {
	tok := p.expect(lexer.Func)
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
	body.Scope.Seperate = true

	// TODO: Check if function already exists
	ptypes := []typing.Type{}
	for _, param := range params {
		ptypes = append(ptypes, typing.Type(param.Type.Name))
	}

	sig := builtins.QuickModFunc(
		"mod",
		name.Name,
		typing.Type(ret.Name),
		ptypes...,
	)
	p.program.Functions = append(p.program.Functions, sig)

	return ast.Function{
		Pos:    tok.Location,
		Name:   name,
		Params: params,
		Return: ret,
		Body:   body,
	}
}

func (p *parser) parseEnum() ast.Enum {
	tok := p.expect(lexer.Enum)
	name := p.parseIdentifier()
	from := ast.Identifier{}
	if p.tt() == lexer.From {
		p.eat()
		from = p.parseIdentifier()
	}

	p.expect(lexer.OpenBrace)
	elems := []ast.Identifier{}
	p.parseStmts(
		func() {
			elems = append(elems, p.parseIdentifier())
		},
		[]lexer.TokenType{lexer.CloseBrace, lexer.EOF},
		[]lexer.TokenType{lexer.NewLine, lexer.Semicolon},
	)

	return ast.Enum{
		Pos:   tok.Location,
		Name:  name,
		From:  from,
		Elems: elems,
	}
}

func (p *parser) parseIfStmt() ast.IfStatement {
	tok := p.expect(lexer.If)
	cond := p.parseExpr()
	body := p.parseBlock()
	elseBody := ast.Block{}
	if p.tt() == lexer.Else {
		elsePos := p.eat()
		if p.tt() == lexer.If {
			scope := ast.NewScope()
			scope.Parent = p.top
			p.top = scope
			stmt := p.parseIfStmt()
			p.top = scope.Parent

			elseBody = ast.Block{
				Pos:   elsePos.Location,
				Body:  []ast.Expr{stmt},
				Scope: scope,
			}
		} else {
			elseBody = p.parseBlock()
		}
	}

	return ast.IfStatement{
		Pos:  tok.Location,
		Cond: cond,
		Body: body,
		Else: elseBody,
	}
}

func (p *parser) parseForLoop() ast.ForLoop {
	tok := p.expect(lexer.For)
	init := p.parseHybridStmt()
	p.expect(lexer.NewLine, lexer.Semicolon)
	comp := p.parseComparison()
	p.expect(lexer.NewLine, lexer.Semicolon)
	inc := p.parseHybridStmt()
	body := p.parseBlock()
	return ast.ForLoop{
		Pos:  tok.Location,
		Init: init,
		Cond: comp,
		Inc:  inc,
		Body: body,
	}
}

func (p *parser) parseWhileLoop() ast.WhileLoop {
	tok := p.expect(lexer.While)
	cond := p.parseExpr()
	body := p.parseBlock()
	return ast.WhileLoop{
		Pos:  tok.Location,
		Cond: cond,
		Body: body,
	}
}

func (p *parser) parseDoWhileLoop() ast.DoWhileLoop {
	tok := p.expect(lexer.Do)
	body := p.parseBlock()
	p.expect(lexer.While)
	cond := p.parseExpr()
	return ast.DoWhileLoop{
		Pos:  tok.Location,
		Body: body,
		Cond: cond,
	}
}

func (p *parser) parseParam() ast.Param {
	typ := p.parseIdentifier()
	name := p.parseIdentifier()
	return ast.Param{
		Type: typ,
		Name: name,
	}
}

func (p *parser) parseReturn() ast.Return {
	tok := p.expect(lexer.Return)
	val := p.parseExpr()
	return ast.Return{
		Pos:   tok.Location,
		Value: val,
	}
}

func (p *parser) parseBreak() ast.Break {
	tok := p.expect(lexer.Break)
	return ast.Break{
		Pos: tok.Location,
	}
}

func (p *parser) parseContinue() ast.Continue {
	tok := p.expect(lexer.Continue)
	return ast.Continue{
		Pos: tok.Location,
	}
}

package parser

import (
	"fmt"
	"sulfur/src/ast"
	. "sulfur/src/errors"
	"sulfur/src/lexer"
)

func (p *parser) parseClass() ast.Class {
	tok := p.expect(lexer.Class)
	name := p.parseIdentifier()

	body := []ast.Expr{}
	p.expect(lexer.OpenBrace)
	p.parseList(
		func() {
			body = append(body, p.parseClassStmt())
		},
		[]lexer.TokenType{lexer.CloseBrace},
		[]lexer.TokenType{lexer.NewLine, lexer.Semicolon},
	)

	fmt.Println(ast.Class{
		Pos:  tok.Location,
		Name: name,
	})

	Errors.Error("Classes have not yet been implemented", p.at().Location)
	return ast.Class{}
}

func (p *parser) parseClassStmt() ast.Expr {
	if p.is(lexer.Visibility) {
		return p.parseVisibleStmt()
	}

	return ast.NoExpr{}
}

func (p *parser) parseVisibleStmt() ast.Expr {
	vis := p.eat()
	if p.tt() == lexer.Identifier {
		if p.ptt(1) == lexer.OpenParen {
			name := p.parseIdentifier()
			p.expect(lexer.OpenParen)
			params := []ast.Param{}
			p.parseList(
				func() {
					p := p.parseParam()
					params = append(params, p)
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

			// TODO: Scope & signature
			return ast.Method{
				Visibility: vis,
				Name:       name,
				Params:     params,
				Return:     ret,
				Body:       body,
			}
		} else {
			typ := p.parseIdentifier()
			name := p.parseIdentifier()
			return ast.Field{
				Visibility: vis,
				Type:       typ,
				Name:       name,
			}
		}
	}

	Errors.Error("No visiblility-togglable statement has been implemented similar to this", vis.Location)
	return ast.NoExpr{}
}

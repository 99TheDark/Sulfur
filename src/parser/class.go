package parser

import (
	"sulfur/src/ast"
	"sulfur/src/builtins"
	. "sulfur/src/errors"
	"sulfur/src/lexer"
	"sulfur/src/typing"
)

func (p *parser) parseClass() ast.Class {
	tok := p.expect(lexer.Class)
	name := p.parseIdentifier()

	fields := []ast.Field{}
	p.expect(lexer.OpenBrace)
	p.parseList(
		func() {
			stmt := p.parseClassStmt()
			switch x := stmt.(type) {
			case ast.Field:
				fields = append(fields, x)
			}
		},
		[]lexer.TokenType{lexer.CloseBrace},
		[]lexer.TokenType{lexer.NewLine, lexer.Semicolon},
	)

	class := ast.Class{
		Pos:    tok.Location,
		Fields: fields,
		Name:   name,
	}

	fieldSigs := []builtins.FieldSignature{}
	for _, field := range class.Fields {
		fieldSigs = append(fieldSigs, builtins.QuickField(
			field.Visibility.Type,
			typing.Type(field.Type.Name),
			field.Name.Name,
		))
	}
	sig := builtins.QuickClass(class.Name.Name, fieldSigs)
	p.program.Classes = append(p.program.Classes, sig)

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
	} else if p.tt() == lexer.New || p.tt() == lexer.Delete {
		which := p.expect(lexer.New, lexer.Delete)

		p.expect(lexer.OpenParen)
		params := []ast.Param{}
		p.parseList(
			func() {
				params = append(params, p.parseParam())
			},
			[]lexer.TokenType{lexer.CloseParen},
			[]lexer.TokenType{lexer.Delimiter},
		)

		body := p.parseBlock()

		return ast.NewDel{
			Visibility: vis,
			Which:      which.Type,
			Params:     params,
			Body:       body,
		}
	}

	Errors.Error("No visiblility-togglable statement has been implemented similar to this", vis.Location)
	return ast.NoExpr{}
}

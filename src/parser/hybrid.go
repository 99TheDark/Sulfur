package parser

import (
	"sulfur/src/ast"
	. "sulfur/src/errors"
	"sulfur/src/lexer"
	"sulfur/src/utils"
)

func (p *parser) parseHybrid() ast.Expr {
	return p.parseDeclaration()
}

func (p *parser) parseDeclaration() ast.Expr {
	if p.is(lexer.Prefix) {
		prefix := p.eat()
		name := p.parseIdentifier()

		var annotation ast.Identifier
		if p.tt() == lexer.Colon {
			p.eat()
			annotation = p.parseIdentifier()
		} else {
			annotation = ast.Identifier{}
		}

		p.expect(lexer.Assignment)
		val := p.parseExpr()
		return ast.Declaration{
			Pos:        prefix.Location,
			Prefix:     prefix.Type,
			Name:       name,
			Annotation: annotation,
			Value:      val,
		}
	}

	return p.parseAssignment()
}

func (p *parser) parseAssignment() ast.Expr {
	if p.tt() == lexer.Identifier {
		if p.ptt(1) == lexer.Assignment {
			iden := p.parseIdentifier()
			p.eat()
			val := p.parseExpr()
			return ast.Assignment{
				Name:  iden,
				Value: val,
				Op:    lexer.Token{},
			}
		} else if p.ptt(2) == lexer.Assignment && utils.Contains(lexer.BinaryOperator, p.ptt(1)) {
			iden := p.parseIdentifier()
			op := p.eat()
			p.expect(lexer.Assignment)
			val := p.parseExpr()
			return ast.Assignment{
				Name:  iden,
				Value: val,
				Op:    op,
			}
		}
	}

	return p.parseIncDec()
}

func (p *parser) parseIncDec() ast.Expr {
	if p.tt() == lexer.Identifier && p.ptt(1) == lexer.Increment || p.ptt(1) == lexer.Decrement {
		iden := p.parseIdentifier()
		op := p.eat()
		return ast.IncDec{
			Name: iden,
			Op:   op,
		}
	}

	return p.parseFuncCall()
}

func (p *parser) parseFuncCall() ast.Expr {
	if p.tt() == lexer.Identifier {
		iden := p.parseIdentifier()
		if p.tt() == lexer.OpenParen {
			p.eat()
			params := []ast.Expr{}
			p.parseList(
				func() {
					params = append(params, p.parseExpr())
				},
				[]lexer.TokenType{lexer.CloseParen},
				[]lexer.TokenType{lexer.Delimiter},
			)
			return ast.FuncCall{
				Func:   iden,
				Params: &params,
			}
		} else {
			return iden
		}
	}

	Errors.Error("Incomplete statement", p.at().Location)
	return &ast.NoExpr{}
}

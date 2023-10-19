package parser

import (
	"sulfur/src/ast"
	. "sulfur/src/errors"
	"sulfur/src/lexer"
	"sulfur/src/utils"
)

func (p *parser) parseHybridStmt() ast.Expr {
	hybrid := p.parseHybrid()
	if iden, ok := hybrid.(ast.Identifier); ok {
		Errors.Error("Incomplete statement", iden.Pos)
		return &ast.BadExpr{
			Pos: iden.Pos,
		}
	}

	return hybrid
}

func (p *parser) parseHybrid() ast.Expr {
	iden := p.parseIdentifier()
	return p.parseDeclaration(iden)
}

func (p *parser) parseDeclaration(iden ast.Identifier) ast.Expr {
	if p.tt() == lexer.Identifier {
		name := p.parseIdentifier()
		p.expect(lexer.Assignment)
		val := p.parseExpr()
		return ast.Declaration{
			Type:  iden,
			Name:  name,
			Value: val,
		}
	}

	return p.parseImplicitDecl(iden)
}

func (p *parser) parseImplicitDecl(iden ast.Identifier) ast.Expr {
	if p.tt() == lexer.ImplicitDeclaration {
		p.eat()
		val := p.parseExpr()
		return ast.ImplicitDecl{
			Name:  iden,
			Value: val,
		}
	}

	return p.parseAssignment(iden)
}

func (p *parser) parseAssignment(iden ast.Identifier) ast.Expr {
	if p.tt() == lexer.Assignment {
		p.eat()
		val := p.parseExpr()
		return ast.Assignment{
			Name:  iden,
			Value: val,
			Op:    lexer.Token{},
		}
	}

	return p.parseOpAssign(iden)
}

func (p *parser) parseOpAssign(iden ast.Identifier) ast.Expr {
	if utils.Contains(lexer.BinaryOperator, p.tt()) && p.peek(1).Type == lexer.Assignment {
		op := p.eat()
		p.expect(lexer.Assignment)
		val := p.parseExpr()
		return ast.Assignment{
			Name:  iden,
			Value: val,
			Op:    op,
		}
	}

	return p.parseIncDec(iden)
}

func (p *parser) parseIncDec(iden ast.Identifier) ast.Expr {
	if p.tt() == lexer.Increment || p.tt() == lexer.Decrement {
		op := p.eat()
		return ast.IncDec{
			Name: iden,
			Op:   op,
		}
	}

	return p.parseFuncCall(iden)
}

func (p *parser) parseFuncCall(iden ast.Identifier) ast.Expr {
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
	}

	return iden
}

package parser

import (
	"strings"
	"sulfur/src/ast"
	. "sulfur/src/errors"
	"sulfur/src/lexer"
)

func (p *parser) parsePossibleExpr() ast.Expr {
	if p.tt() == lexer.NewLine || p.tt() == lexer.Semicolon {
		return ast.NoExpr{}
	}
	return p.parseExpr()
}

func (p *parser) parseExpr() ast.Expr {
	return p.parseLogical()
}

func (p *parser) parseLogical() ast.Expr {
	left := p.parseComparison()
	for p.is(lexer.Logical) {
		tok := p.eat()
		right := p.parseComparison()

		left = ast.BinaryOp{
			Left:  left,
			Right: right,
			Op:    tok,
		}
	}
	return left
}

func (p *parser) parseComparison() ast.Expr {
	left := p.parseAdditive()
	if p.is(lexer.Comparator) {
		tok := p.expect(lexer.Comparator...)
		return ast.Comparison{
			Left:  left,
			Right: p.parseAdditive(),
			Comp:  tok,
		}
	}
	return left
}

func (p *parser) parseAdditive() ast.Expr {
	left := p.parseMultiplicative()
	for p.is(lexer.Additive) {
		tok := p.eat()
		right := p.parseMultiplicative()

		left = ast.BinaryOp{
			Left:  left,
			Right: right,
			Op:    tok,
		}
	}
	return left
}

func (p *parser) parseMultiplicative() ast.Expr {
	left := p.parseExponential()
	for p.is(lexer.Multiplicative) {
		tok := p.eat()
		right := p.parseExponential()

		left = ast.BinaryOp{
			Left:  left,
			Right: right,
			Op:    tok,
		}
	}
	return left
}

func (p *parser) parseExponential() ast.Expr {
	left := p.parseUnary()
	for p.is(lexer.Exponential) {
		tok := p.eat()
		right := p.parseUnary()

		left = ast.BinaryOp{
			Left:  left,
			Right: right,
			Op:    tok,
		}
	}
	return left
}

func (p *parser) parseUnary() ast.Expr {
	if p.is(lexer.UnaryOperator) {
		tok := p.eat()
		val := p.parseTypeConv()
		return ast.UnaryOp{
			Value: val,
			Op:    tok,
		}
	}
	return p.parseTypeConv()
}

func (p *parser) parseTypeConv() ast.Expr {
	if p.tt() == lexer.Identifier && p.peek(1).Type == lexer.Not {
		typ := p.parseIdentifier()
		p.expect(lexer.Not)
		val := p.parseGroup()
		return ast.TypeConv{
			Type:  typ,
			Value: val,
		}
	}
	return p.parseNew()
}

func (p *parser) parseNew() ast.Expr {
	if p.tt() == lexer.New {
		new := p.eat()
		class := p.parseIdentifier()
		p.expect(lexer.OpenParen)
		params := []ast.Expr{}
		p.parseList(
			func() {
				params = append(params, p.parseExpr())
			},
			[]lexer.TokenType{lexer.CloseParen},
			[]lexer.TokenType{lexer.Delimiter},
		)
		return ast.New{
			Pos:    new.Location,
			Class:  class,
			Params: &params,
		}
	}
	return p.parseReference()
}

func (p *parser) parseReference() ast.Expr {
	if p.tt() == lexer.And {
		tok := p.eat()
		iden := p.parseIdentifier()
		return ast.Reference{
			Pos:      tok.Location,
			Variable: iden,
		}
	}
	return p.parsePrimary()
}

func (p *parser) parsePrimary() ast.Expr {
	tok := p.at()
	switch tok.Type {
	case lexer.Boolean:
		return p.parseBoolean()
	case lexer.Number:
		return p.parseNumber()
	case lexer.String:
		return p.parseString()
	case lexer.OpenParen:
		return p.parseGroup()
	default:
		hybrid := p.parseHybrid()
		if !ast.Empty(hybrid) {
			return hybrid
		} else if p.tt() == lexer.Identifier {
			return p.parseIdentifier()
		}
	}

	Errors.Error("Unknown token '"+strings.ReplaceAll(p.at().Value, "\n", "\\n")+"'", p.at().Location)
	return ast.NoExpr{
		Pos: tok.Location,
	}
}

func (p *parser) parseBoolean() ast.Boolean {
	token := p.expect(lexer.Boolean)
	val := false
	if token.Value == "true" {
		val = true
	}

	return ast.Boolean{
		Pos:   token.Location,
		Value: val,
	}
}

func (p *parser) parseNumber() ast.Expr {
	tok := p.expect(lexer.Number)
	val, loc := tok.Value, tok.Location
	if p.at().Type == lexer.NumericalSuffix {
		suf := p.eat()
		switch suf.Value {
		case "f":
			if f, ok := parseFloat(val, loc); ok {
				return f
			} else {
				Errors.Error("Invalid float literal", loc)
			}
		case "u":
			if u, ok := parseUnsignedInt(val, loc); ok {
				return u
			} else {
				Errors.Error("Invalid unsigned integer literal", loc)
			}
		default:
			Errors.Error("Invalid numerical suffix", suf.Location)
		}
	} else if i, ok := parseInteger(val, loc); ok {
		return i
	} else if f, ok := parseFloat(val, loc); ok {
		return f
	}

	Errors.Error("Invalid number", tok.Location)
	return ast.NoExpr{
		Pos: tok.Location,
	}
}

func (p *parser) parseString() ast.String {
	tok := p.expect(lexer.String)
	return ast.String{
		Pos:   tok.Location,
		Value: tok.Value,
	}
}

func (p *parser) parseIdentifier() ast.Identifier {
	tok := p.expect(lexer.Identifier)
	return ast.Identifier{
		Pos:  tok.Location,
		Name: tok.Value,
	}
}

func (p *parser) parseGroup() ast.Expr {
	p.expect(lexer.OpenParen)
	body := p.parseExpr()
	p.expect(lexer.CloseParen)
	return body
}

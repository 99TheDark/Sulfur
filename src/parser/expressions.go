package parser

import (
	"math"
	"strconv"
	"strings"
	"sulfur/src/ast"
	. "sulfur/src/errors"
	"sulfur/src/lexer"
)

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
		val := p.parsePrimary()
		return ast.UnaryOp{
			Value: val,
			Op:    tok,
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
	case lexer.Identifier:
		return p.parseHybrid()
	}

	Errors.Error("Unknown token '"+strings.ReplaceAll(p.at().Value, "\n", "\\n")+"'", p.at().Location)
	return ast.BadExpr{
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
	// TODO: Make 2.0 a float, not an int
	if f64, err := strconv.ParseFloat(tok.Value, 64); err == nil {
		if math.Mod(f64, 1) == 0 {
			return ast.Integer{
				Pos:   tok.Location,
				Value: int64(f64),
			}
		} else {
			return ast.Float{
				Pos:   tok.Location,
				Value: f64,
			}
		}
	}

	Errors.Error("Invalid number", tok.Location)
	return ast.BadExpr{
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

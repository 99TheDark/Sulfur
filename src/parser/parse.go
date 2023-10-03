package parser

import (
	"bytes"
	"encoding/json"
	"math"
	"strconv"
	"strings"
	"sulfur/src/ast"
	. "sulfur/src/errors"
	"sulfur/src/lexer"
	"sulfur/src/utils"
)

type parser struct {
	source []lexer.Token
	size   int
	idx    int
}

func (p *parser) at() lexer.Token {
	return p.source[p.idx]
}

func (p *parser) peek(ahead int) lexer.Token {
	if p.idx+ahead > p.size {
		return p.source[p.size-1]
	}
	return p.source[p.idx+ahead]
}

func (p *parser) eat() lexer.Token {
	token := p.source[p.idx]
	p.idx++
	return token
}

func (p *parser) expect(symbols ...lexer.TokenType) lexer.Token {
	tok := p.eat()
	if !utils.Contains(symbols, tok.Type) {
		length := len(symbols)
		expected := symbols[0].String()
		for i := 1; i < length-1; i++ {
			expected += ", " + symbols[i].String()
		}
		if length > 1 {
			expected += " or " + symbols[length-1].String()
		}

		Errors.Error("Expected "+expected+", but got "+tok.Type.String()+" instead", tok.Location)
	}
	return tok
}

func (p *parser) is(catagory []lexer.TokenType) bool {
	return utils.Contains(catagory, p.at().Type)
}

// Statements
func (p *parser) parseStmt() ast.Expr {
	tok := p.at()
	switch tok.Type {
	case lexer.Identifier:
		return p.parseHybrid(true)
	case lexer.If:
		return p.parseIfStmt()
	case lexer.For:
		// TODO: For in
		return p.parseForLoop()
	case lexer.While:
		return p.parseWhileLoop()
	case lexer.Do:
		return p.parseDoWhileLoop()
	}

	Errors.Error("Invalid statement", tok.Location)
	return &ast.BadExpr{
		Pos: tok.Location,
	}
}

func (p *parser) parseHybrid(errors bool) ast.Expr {
	iden := p.parseIdentifier()
	tok := p.at()
	switch tok.Type {
	case lexer.Identifier:
		name := p.parseIdentifier()
		p.expect(lexer.Assignment)
		val := p.parseExpr()
		return ast.Declaration{
			Type:  iden,
			Name:  name,
			Value: val,
		}
	case lexer.ImplicitDeclaration:
		p.eat()
		val := p.parseExpr()
		return ast.ImplicitDecl{
			Name:  iden,
			Value: val,
		}
	case lexer.Assignment:
		p.eat()
		val := p.parseExpr()
		return ast.Assignment{
			Name:  iden,
			Value: val,
			Op:    nil,
		}
	case lexer.Increment, lexer.Decrement:
		p.eat()
		return ast.IncDec{
			Name: iden,
			Op:   tok,
		}
	case lexer.OpenParen:
		return p.parseGroup()
	default:
		p.eat()
		if utils.Contains(lexer.BinaryOperator, tok.Type) {
			op := p.eat()
			val := p.parseExpr()
			return ast.Assignment{
				Name:  iden,
				Value: val,
				Op:    &op,
			}
		}
	}

	if errors {
		Errors.Error("Incomplete statement", tok.Location)
	}
	return &ast.BadExpr{
		Pos: tok.Location,
	}
}

func (p *parser) parseStmts(ending ...lexer.TokenType) []ast.Expr {
	ending = append(ending, lexer.EOF)
	stmts := []ast.Expr{}
	for !p.is(ending) {
		if p.at().Type == lexer.NewLine {
			p.eat()
			continue
		}
		stmts = append(stmts, p.parseStmt())

		if !p.is(ending) {
			p.expect(lexer.NewLine, lexer.Semicolon)
		}
	}
	p.eat()
	return stmts
}

func (p *parser) parseBlock() []ast.Expr {
	tok := p.expect(lexer.OpenBrace, lexer.Arrow)
	if tok.Type == lexer.Arrow {
		return []ast.Expr{p.parseStmt()}
	} else {
		return p.parseStmts(lexer.CloseBrace)
	}
}

func (p *parser) parseIfStmt() ast.IfStatement {
	tok := p.expect(lexer.If)
	cond := p.parseExpr()
	body := p.parseBlock()
	elseBody := []ast.Expr{}
	if p.at().Type == lexer.Else {
		p.eat()
		if p.at().Type == lexer.If {
			elseBody = []ast.Expr{p.parseIfStmt()}
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
	init := p.parseHybrid(true)
	p.expect(lexer.NewLine, lexer.Semicolon)
	comp := p.parseComparison()
	p.expect(lexer.NewLine, lexer.Semicolon)
	inc := p.parseHybrid(true)
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

// Expressions
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
	// TODO: Add
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
		oldIdx := p.idx
		hyrbid := p.parseHybrid(false)
		if ast.Valid(hyrbid) {
			return hyrbid
		}
		p.idx = oldIdx

		return p.parseIdentifier()
	}

	Errors.Error("Unknown token '"+p.at().Value+"'", p.at().Location)
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

func Parse(source string, tokens *[]lexer.Token) *ast.Program {
	p := parser{
		*tokens,
		len(*tokens),
		0,
	}

	prog := ast.Program{
		Functions: []*ast.Function{},
		Classes:   []*ast.Class{},
		Strings:   []*ast.String{},
		Scope:     *ast.NewScope(),
		Body:      p.parseStmts(),
	}
	return &prog
}

func Save(prog *ast.Program, spaces int, path string) error {
	buf := new(bytes.Buffer)
	enc := json.NewEncoder(buf)

	enc.SetEscapeHTML(false)
	if spaces > 0 {
		enc.SetIndent("", strings.Repeat(" ", spaces))
	}

	err := enc.Encode(prog)
	if err != nil {
		return err
	}

	return utils.SaveFile(buf.Bytes(), path)
}

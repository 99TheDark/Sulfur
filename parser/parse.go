package parser

import (
	"bytes"
	"encoding/json"
	"golang/lexer"
	"golang/utils"
	"log"
	"strings"
)

type parser struct {
	tokens []lexer.Token
	idx    int
}

func (p *parser) at() lexer.Token {
	return p.tokens[p.idx]
}

func (p *parser) peek() lexer.Token {
	return p.tokens[p.idx+1]
}

func (p *parser) eat() lexer.Token {
	el := p.at()
	p.idx++
	return el
}

func (p *parser) expect(tokentype lexer.TokenType) {
	token := p.eat()
	if token.Type != tokentype {
		log.Fatalln("Expected " + tokentype.String() + ", but got " + token.Type.String() + " '" + token.Value + "' instead")
	}
}

func (p *parser) op() lexer.Operation {
	return lexer.Operation(p.at().Value)
}

func (p *parser) cmp() lexer.Comparison {
	return lexer.Comparison(p.at().Value)
}

func (p *parser) key() lexer.Keywords {
	return lexer.Keywords(p.at().Value)
}

func (p *parser) listify() List {
	p.eat()
	group := p.parseGroup()

	if list, ok := group.(List); ok {
		return list
	}

	return List{[]Expression{group}}
}

func (p *parser) parseGroup() Expression {
	if p.at().Type == lexer.RightParen {
		p.eat()
		return List{[]Expression{}}
	}
	expr := p.parseExpression()
	p.expect(lexer.RightParen)
	return expr
}

func (p *parser) parseBlock() []Expression {
	block := []Expression{}
	for p.at().Type != lexer.RightBrace {
		block = append(block, p.parseExpression())
	}
	p.eat()
	return block
}

func (p *parser) parseIfStatement(token lexer.Token) Expression {
	condition := p.parseReturn()

	p.expect(lexer.LeftBrace)

	body := p.parseBlock()
	if p.key() == lexer.ElseIf {
		next := p.eat()
		return IfStatement{token.Location, condition, body, []Expression{p.parseIfStatement(next)}}
	} else if p.key() == lexer.Else {
		p.eat()
		p.expect(lexer.LeftBrace)
		return IfStatement{token.Location, condition, body, p.parseBlock()}
	} else {
		return IfStatement{token.Location, condition, body, []Expression{}}
	}
}

func (p *parser) parseExpression() Expression {
	return p.parseControl()
}

func (p *parser) parseControl() Expression {
	if p.key() == lexer.If {
		return p.parseIfStatement(p.eat())
	}
	return p.parseReturn()
}

func (p *parser) parseReturn() Expression {
	if p.key() == lexer.Return {
		p.eat()
		return Return{p.parseFunction()}
	}
	return p.parseFunction()
}

func (p *parser) parseFunction() Expression {
	left := p.parseList()
	if name, ok := left.(Identifier); ok && p.at().Type == lexer.LeftParen {
		params, ret := p.listify(), p.listify()
		if len(ret.Values) > 1 {
			log.Fatalln("More than 1 return value is not yet supported")
		}

		if p.at().Type == lexer.LeftBrace {
			p.eat()
			return FunctionLiteral{name, params, ret, p.parseBlock()}
		} else {
			return FunctionCall{name, params}
		}
	}

	return left
}

func (p *parser) parseList() Expression {
	list := []Expression{p.parseComparison()}
	for p.at().Type == lexer.Delimiter {
		p.eat()
		list = append(list, p.parseComparison())
	}

	if len(list) == 1 {
		return list[0]
	}
	return List{list}
}

func (p *parser) parseComparison() Expression {
	left := p.parseAdditive()
	if p.at().Type == lexer.Comparator {
		token := p.eat()
		return Comparison{token.Location, left, p.parseAdditive(), lexer.Comparison(token.Value)}
	}
	return left
}

func (p *parser) parseAdditive() Expression {
	left := p.parseMultiplicative()
	for p.op() == lexer.Add || p.op() == lexer.Subtract {
		token := p.eat()
		right := p.parseMultiplicative()

		left = BinaryOperation{token.Location, left, right, lexer.Operation(token.Value)}
	}
	return left
}

func (p *parser) parseMultiplicative() Expression {
	left := p.parseFunctionCall()
	for p.op() == lexer.Multiply || p.op() == lexer.Divide {
		token := p.eat()
		right := p.parseFunctionCall()

		left = BinaryOperation{token.Location, left, right, lexer.Operation(token.Value)}
	}
	return left
}

func (p *parser) parseFunctionCall() Expression {
	left := p.parseDatatype()
	if name, ok := left.(Identifier); ok && p.at().Type == lexer.LeftParen {
		p.eat()
		params := p.listify()

		return FunctionCall{name, params}
	}
	return left
}

func (p *parser) parseDatatype() Expression {
	if p.at().Type == lexer.Identifier && p.peek().Type == lexer.Identifier {
		dt, val := p.eat(), p.eat()
		return Datatype{
			Identifier{dt.Location, dt.Value},
			Identifier{val.Location, val.Value},
		}
	}
	return p.parsePrimary()
}

func (p *parser) parsePrimary() Expression {
	token := p.eat()
	switch token.Type {
	case lexer.Identifier:
		return Identifier{token.Location, token.Value}
	case lexer.LeftParen:
		return p.parseGroup()
	case lexer.LeftBrace:
		return Block{token.Location, p.parseBlock()}
	default:
		return Identifier{token.Location, "Error: '" + token.Value + "'"}
	}
}

func Parse(tokens *[]lexer.Token) Program {
	parser := parser{*tokens, 0}
	statements := []Expression{}
	for parser.at().Type != lexer.EOF {
		statements = append(statements, parser.parseExpression())
	}
	return Program{statements}
}

func Save(ast Program, spaces int, location string) error {
	buf := new(bytes.Buffer)
	enc := json.NewEncoder(buf)

	enc.SetEscapeHTML(false)
	if spaces > 0 {
		enc.SetIndent("", strings.Repeat(" ", spaces))
	}

	err := enc.Encode(ast)
	if err != nil {
		return err
	}

	return utils.SaveFile(buf.Bytes(), location)
}

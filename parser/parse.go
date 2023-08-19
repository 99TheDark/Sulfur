package parser

import (
	"bytes"
	"encoding/json"
	. "golang/errors"
	"golang/lexer"
	"golang/typing"
	"golang/utils"
	"strconv"
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

func (p *parser) expect(tokentype lexer.TokenType) lexer.Token {
	token := p.eat()
	if token.Type != tokentype {
		Errors.Error(
			"Expected "+tokentype.String()+", but got "+token.Type.String()+" '"+token.Value+"' instead",
			token.Location,
		)
	}
	return token
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

func (p *parser) parseBlock(hook lexer.Token) Block {
	loc := hook.Location
	body := []Expression{}
	for p.at().Type != lexer.RightBrace {
		body = append(body, p.parseExpression())
	}
	p.eat()

	return Block{
		loc,
		body,
		typing.NewScope(),
	}
}

func (p *parser) parseIfStatement(token lexer.Token) Expression {
	condition := p.parseReturn()

	lbrace := p.expect(lexer.LeftBrace)
	body := p.parseBlock(lbrace)
	if p.key() == lexer.ElseIf {
		next := p.eat()
		ifstmt := []Expression{p.parseIfStatement(next)}
		bl := Block{
			next.Location,
			ifstmt,
			typing.NewScope(),
		}
		return IfStatement{
			token.Location,
			condition,
			body,
			bl,
		}
	} else if p.key() == lexer.Else {
		p.eat()
		brace := p.expect(lexer.LeftBrace)
		return IfStatement{
			token.Location,
			condition,
			body,
			p.parseBlock(brace),
		}
	} else {
		loc := p.at().Location
		bl := Block{loc, []Expression{}, typing.NewScope()}
		return IfStatement{
			token.Location,
			condition,
			body,
			bl,
		}
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
		return Return{p.parseDeclaration()}
	}
	return p.parseDeclaration()
}

func (p *parser) parseDeclaration() Expression {
	left := p.parseFunction()
	if datatype, ok := left.(Datatype); ok && p.at().Type == lexer.Assignment {
		p.eat()
		value := p.parseFunction()
		return Declaration{
			datatype.Datatype,
			datatype.Variable,
			value,
		}
	}
	return left
}

// TODO: add assignment

func (p *parser) parseFunction() Expression {
	if p.at().Type == lexer.Identifier && p.peek().Type == lexer.LeftParen {
		token := p.eat()
		name := Identifier{
			token.Location,
			token.Value,
		}
		params := p.listify()

		if p.at().Type == lexer.LeftParen {
			ret := p.listify()
			if len(ret.Values) > 1 {
				Errors.Error(
					"More than 1 return value is not yet supported",
					ret.Location(),
				)
			}

			lbrace := p.expect(lexer.LeftBrace)
			return FunctionLiteral{
				name,
				params,
				ret,
				p.parseBlock(lbrace).Body,
			}
		} else if p.at().Type == lexer.LeftBrace {
			lbrace := p.expect(lexer.LeftBrace)
			return FunctionLiteral{
				name,
				params,
				List{[]Expression{}},
				p.parseBlock(lbrace).Body,
			}
		} else {
			return FunctionCall{
				name,
				params,
			}
		}
	}

	return p.parseList()

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
		return Comparison{
			token.Location,
			left,
			p.parseAdditive(),
			lexer.Comparison(token.Value),
		}
	}
	return left
}

func (p *parser) parseAdditive() Expression {
	left := p.parseMultiplicative()
	for p.op() == lexer.Add || p.op() == lexer.Subtract {
		token := p.eat()
		right := p.parseMultiplicative()

		left = BinaryOperation{
			token.Location,
			left,
			right,
			lexer.Operation(token.Value),
		}
	}
	return left
}

func (p *parser) parseMultiplicative() Expression {
	left := p.parseDatatype()
	for p.op() == lexer.Multiply || p.op() == lexer.Divide {
		token := p.eat()
		right := p.parseDatatype()

		left = BinaryOperation{
			token.Location,
			left,
			right,
			lexer.Operation(token.Value),
		}
	}
	return left
}

func (p *parser) parseDatatype() Expression {
	if p.at().Type == lexer.Identifier && p.peek().Type == lexer.Identifier {
		dt, val := p.eat(), p.eat()
		return Datatype{
			Identifier{
				dt.Location,
				dt.Value,
			},
			Identifier{
				val.Location,
				val.Value,
			},
		}
	}
	return p.parsePrimary()
}

func (p *parser) parsePrimary() Expression {
	token := p.eat()
	switch token.Type {
	case lexer.Identifier:
		return Identifier{
			token.Location,
			token.Value,
		}
	case lexer.Number:
		// TODO: clean this up
		if val, err := strconv.ParseInt(token.Value, 10, 64); err == nil {
			return IntegerLiteral{
				token.Location,
				val,
			}
		} else {
			Errors.Error("Numeric parser failed, something went wrong in the lexer", token.Location)
			return Identifier{
				token.Location,
				"Numerical Error '" + token.Value + "'",
			}
		}
	case lexer.Boolean:
		val := true
		if token.Value == "false" {
			val = false
		}

		return BoolLiteral{
			token.Location,
			val,
		}
	case lexer.LeftParen:
		return p.parseGroup()
	case lexer.LeftBrace:
		return p.parseBlock(token)
	default:
		return Identifier{
			token.Location,
			"Error: '" + token.Value + "'",
		}
	}
}

func Parse(source string, tokens *[]lexer.Token) Program {
	parser := parser{*tokens, 0}
	statements := []Expression{}
	for parser.at().Type != lexer.EOF {
		statements = append(statements, parser.parseExpression())
	}
	return Program{
		Block{
			lexer.NoLocation,
			statements,
			typing.NewScope(),
		},
	}
}

func Save(ast any, spaces int, location string) error {
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

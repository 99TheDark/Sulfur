package lexer

import (
	"fmt"
	"golang/utils"
	"os"
)

type lexer struct {
	source []rune
	tokens []Token
	loc    *Location
	mode   TokenType
	begin  *Location
	eof    bool
}

func (l *lexer) at() rune {
	return l.source[l.loc.Idx]
}

func (l lexer) peek() rune {
	return l.source[l.loc.Idx+1]
}

func (l *lexer) eat() rune {
	ch := l.source[l.loc.Idx]

	// todo, move
	l.loc.Idx++
	l.loc.Col++
	if ch == '\n' {
		l.loc.Col = 0
		l.loc.Row++
	}

	if l.loc.Idx >= len(l.source) {
		l.eof = true
	}
	return ch
}

func (l lexer) all(start, end int) string {
	return string(l.source[start:(end + 1)])
}

func (l lexer) ahead(ahead int) string {
	return l.all(l.loc.Idx, l.loc.Idx)
}

func (l *lexer) start(mode TokenType) {
	l.mode = mode
	*l.begin = *l.loc
	l.eat()
}

func (l *lexer) end() *Token {
	token := CreateToken(
		l.mode,
		l.all(l.begin.Idx, l.loc.Idx-1),
		l.begin.Row,
		l.begin.Col,
		l.begin.Idx,
	)

	l.mode = None

	return token
}

func (l *lexer) add(token *Token) {
	l.tokens = append(l.tokens, *token)
}

func (l *lexer) singleToken(tokentype TokenType) *Token {
	return CreateToken(
		tokentype,
		string(l.at()),
		l.loc.Row,
		l.loc.Col,
		l.loc.Idx,
	)
}

func (l *lexer) splitAdd(token *Token, endings ...TokenType) {
	if utils.Contains(endings, l.mode) {
		l.add(l.end())
	}
	l.add(token)

	l.eat()
}

func Lex(source string) *[]Token {
	l := &lexer{
		[]rune(source),
		[]Token{},
		CreateLocation(0, 0, 0),
		None,
		CreateLocation(0, 0, 0),
		false,
	}

	for !l.eof {
		switch l.at() {
		case ' ':
			l.splitAdd(l.singleToken(Space), Identifier)
		case '\n':
			l.splitAdd(l.singleToken(NewLine), Identifier)
		case '(':
			l.splitAdd(l.singleToken(LeftParen), Identifier)
		case ')':
			l.splitAdd(l.singleToken(RightParen), Identifier)
		case '[':
			l.splitAdd(l.singleToken(LeftBracket), Identifier)
		case ']':
			l.splitAdd(l.singleToken(RightBracket), Identifier)
		case '{':
			l.splitAdd(l.singleToken(LeftBrace), Identifier)
		case '}':
			l.splitAdd(l.singleToken(RightBrace), Identifier)
		case '+', '-', '*', '/', '%':
			l.splitAdd(l.singleToken(Operator), Identifier)
		default:
			if l.mode == None {
				l.start(Identifier)
			} else {
				l.eat()
			}
		}
	}
	if l.mode != None {
		l.add(l.end())
	}
	l.add(CreateToken(EOF, "EOF", l.loc.Row, l.loc.Col, l.loc.Idx))

	return &l.tokens
}

func Filter(tokens *[]Token) {
	filter := func(item Token) bool {
		return item.Type != Space && item.Type != NewLine
	}
	*tokens = utils.Filter(*tokens, filter)
}

func Stringify(tokens *[]Token) string {
	str := "[]Token{\n"
	for _, token := range *tokens {
		str += "    " + fmt.Sprintln(token)
	}

	return str + "}"
}

func GetSourceCode(location string) (string, error) {
	content, err := os.ReadFile(location)
	if err != nil {
		return "", err
	}

	return string(content), nil
}

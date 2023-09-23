package lexer

import (
	"fmt"
	"os"
	"sulfur/utils"
)

type lexer struct {
	source []rune
	tokens []Token
	iden   Location
	loc    *Location
}

func (l *lexer) at() rune {
	return l.source[l.loc.Idx]
}

func (l *lexer) get(loc Location, count int) string {
	return string(l.source[loc.Idx : loc.Idx+count])
}

func (l *lexer) next(count int) string {
	return l.get(*l.loc, count)
}

func (l *lexer) add(tt TokenType, value string) {
	token := CreateToken(
		tt,
		value,
		l.loc.Row,
		l.loc.Col,
		l.loc.Idx,
	)
	l.tokens = append(l.tokens, *token)
}

func (l *lexer) identifier() {
	if l.loc.Idx != l.iden.Idx {
		iden := l.get(l.iden, l.loc.Idx-l.iden.Idx)
		if typ, ok := Keywords[iden]; ok {
			l.add(typ, iden)
		} else {
			l.add(Identifier, iden)
		}
	}
}

func (l *lexer) symbol() bool {
	longest := ""
	length := 0
	for symbol := range Symbols {
		size := len(symbol)
		if size < length {
			continue
		}
		if l.loc.Idx+size > len(l.source) {
			continue
		}

		if l.next(size) == symbol {
			longest, length = symbol, size
		}
	}

	if length > 0 {
		l.identifier()

		l.add(
			Symbols[longest],
			longest,
		)
		l.loc.Row += length
		l.loc.Idx += length
		return true
	}

	return false
}

func Lex(source string) *[]Token {
	l := lexer{
		[]rune(source),
		[]Token{},
		*CreateLocation(0, 0, 0),
		CreateLocation(0, 0, 0),
	}

	for l.loc.Idx != len(l.source) {
		if l.symbol() {
			l.iden = *l.loc
		} else {
			l.loc.Idx++
			l.loc.Row++
		}
	}
	l.identifier()

	return &l.tokens
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

func Save(tokens *[]Token, location string) error {
	return utils.SaveFile([]byte(Stringify(tokens)), location)
}

package lexer

import (
	"fmt"
	"os"
	"sulfur/utils"
	"unicode"
)

type lexer struct {
	source []rune
	tokens []Token
	iden   Location
	begin  Location
	mode   TokenType
	loc    Location
}

func (l *lexer) at() rune {
	if l.loc.Idx == len(l.source) {
		return '\x00'
	}
	return l.source[l.loc.Idx]
}

func (l *lexer) step() {
	l.loc.Col++
	l.loc.Idx++

	if l.at() == '\n' {
		l.loc.Col = 0
		l.loc.Row++
	}
}

func (l *lexer) get(loc Location, count int) string {
	return string(l.source[loc.Idx : loc.Idx+count])
}

func (l *lexer) next(count int) string {
	return l.get(l.loc, count)
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

func (l *lexer) new(tt TokenType, value string) {
	l.add(tt, value)
	l.loc.Col += len(value)
	l.loc.Idx += len(value)
}

func (l *lexer) match(value string) bool {
	size := len(value)
	if l.loc.Idx+size <= len(l.source) {
		return l.next(size) == value
	}
	return false
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
		l.new(
			Symbols[longest],
			longest,
		)

		return true
	}

	return false
}

func (l *lexer) start(mode TokenType, starting string) bool {
	if l.match(starting) {
		l.identifier()

		size := len(starting)
		l.loc.Col += size
		l.loc.Idx += size

		l.begin = l.loc
		l.mode = mode
		return true
	}
	return false
}

func (l *lexer) end(ending string) bool {
	if l.match(ending) {
		v := l.get(l.begin, l.loc.Idx-l.begin.Idx)
		l.add(l.mode, v)

		size := len(ending)
		l.loc.Col += size
		l.loc.Idx += size

		l.mode = None
		return true
	}

	l.step()
	return false
}

func Lex(source string) *[]Token {
	l := lexer{
		[]rune(source),
		[]Token{},
		*NoLocation,
		*NoLocation,
		None,
		*NoLocation,
	}

	for l.loc.Idx != len(l.source) {
		if l.mode == None {
			if l.start(SingleLineComment, "//") ||
				l.start(MultiLineComment, "/*") ||
				l.start(String, "\"") {
				continue
			}

			pass := true
			if l.at() == '\n' {
				l.new(NewLine, string(l.at()))
			} else if unicode.IsSpace(l.at()) {
				l.identifier()
				l.new(WhiteSpace, string(l.at()))
			} else if !l.symbol() {
				pass = false
			}

			if pass {
				l.iden = l.loc
			} else {
				l.step()
			}
		} else {
			if l.mode == String {
				l.end("\"")
			} else if l.mode == SingleLineComment {
				if l.end("\n") {
					l.add(NewLine, "\n")
				}
			} else if l.mode == MultiLineComment {
				l.end("*/")
			}

			l.iden = l.loc
		}
	}
	l.identifier()

	l.new(EOF, "EOF")

	return &l.tokens
}

func Filter(tokens *[]Token) *[]Token {
	filter := func(item Token) bool {
		return item.Type != WhiteSpace && item.Type != SingleLineComment && item.Type != MultiLineComment
	}
	filtered := utils.Filter(*tokens, filter)
	return &filtered
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

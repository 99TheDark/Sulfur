package lexer

import (
	"fmt"
	"os"
	"strings"
	. "sulfur/src/errors"
	"sulfur/src/location"
	"sulfur/src/utils"
	"unicode"
)

type lexer struct {
	source []rune
	tokens []Token
	iden   location.Location
	begin  location.Location
	mode   TokenType
	loc    location.Location
}

func (l *lexer) at() rune {
	if l.loc.Idx == len(l.source) {
		return '\x00'
	}
	return l.source[l.loc.Idx]
}

func (l *lexer) peek() rune {
	if l.loc.Idx+1 == len(l.source) {
		return '\x00'
	}
	return l.source[l.loc.Idx+1]
}

func (l *lexer) step() {
	if l.at() == '\n' {
		l.loc.Col = 0
		l.loc.Row++
	} else {
		l.loc.Col++
	}
	l.loc.Idx++
}

func (l *lexer) move(str string) {
	for i := 0; i < len(str); i++ {
		if l.loc.Idx < len(l.source) {
			l.step()
		}
	}
}

func (l *lexer) pop() {
	l.tokens = l.tokens[:len(l.tokens)-1]
}

func (l *lexer) get(loc location.Location, count int) string {
	return string(l.source[loc.Idx : loc.Idx+count])
}

func (l *lexer) next(count int) string {
	return l.get(l.loc, count)
}

func (l *lexer) addAt(tt TokenType, value string, loc location.Location) {
	token := NewToken(
		tt,
		value,
		loc.Row,
		loc.Col,
		loc.Idx,
	)
	l.tokens = append(l.tokens, *token)
}

func (l *lexer) add(tt TokenType, value string) {
	l.addAt(tt, value, l.loc)
}

func (l *lexer) new(tt TokenType, value string) {
	l.add(tt, value)
	l.move(value)
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
			l.addAt(typ, iden, l.iden)
		} else {
			l.addAt(Identifier, iden, l.iden)
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

		l.move(starting)
		l.begin = l.loc
		l.mode = mode
		return true
	}
	return false
}

func (l *lexer) end(ending string) bool {
	if l.match(ending) {
		v := l.get(l.begin, l.loc.Idx-l.begin.Idx)
		l.addAt(l.mode, v, l.begin)

		l.move(ending)

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
		*location.NoLocation,
		*location.NoLocation,
		None,
		*location.NoLocation,
	}

	for l.loc.Idx != len(l.source) {
		if l.mode == None {
			if l.start(SingleLineComment, "//") ||
				l.start(MultiLineComment, "/*") ||
				l.start(String, "\"") {
				continue
			}
			if l.iden == l.loc && decimal(l.at()) {
				l.start(Number, "")
				continue
			}

			pass := true
			if l.at() == '\n' {
				l.identifier()
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
				if l.at() == '\\' && (l.peek() == '"' || l.peek() == '\\') {
					l.step()
					l.step()
				} else if l.end("\"") {
					tok := &l.tokens[len(l.tokens)-1]
					val := tok.Value
					for escape, value := range Escape {
						val = strings.ReplaceAll(val, "\\"+escape, value)
					}
					val = UnicodeFour.ReplaceAllStringFunc(val, escapeReplace)
					val = UnicodeEight.ReplaceAllStringFunc(val, escapeReplace)

					tok.Value = val
				}
			} else if l.mode == SingleLineComment {
				if l.end("\n") {
					l.add(NewLine, "\n")
				}
			} else if l.mode == MultiLineComment {
				l.end("*/")
			} else if l.mode == Number {
				if !decimal(l.at()) {
					num := l.get(l.begin, l.loc.Idx-l.begin.Idx)
					prev := l.source[l.begin.Idx-1]

					if prev == '-' {
						l.pop()
						l.addAt(Number, "-"+num, l.begin)
					} else {
						if prev == '+' {
							l.pop()
						}
						l.addAt(Number, num, l.begin)
					}

					if utils.Contains(NumericalSuffixes, l.at()) {
						l.add(NumericalSuffix, string(l.at()))
						l.step()
					}

					l.mode = None
				} else {
					l.step()
				}
			}

			l.iden = l.loc
		}
	}
	if l.mode == None {
		l.identifier()
	} else if l.mode == String {
		Errors.Error("Missing \" at the end of string", &l.loc)
	} else if l.mode == MultiLineComment {
		Errors.Error("Missing */ at the end of multiline comment", &l.loc)
	} else {
		remaining := l.get(l.begin, l.loc.Idx-l.begin.Idx)
		l.addAt(l.mode, remaining, l.begin)
	}

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

func GetSourceCode(path string) (string, error) {
	content, err := os.ReadFile(path)
	if err != nil {
		return "", err
	}

	return string(content), nil
}

func Save(tokens *[]Token, path string) error {
	return utils.SaveFile([]byte(Stringify(tokens)), path)
}

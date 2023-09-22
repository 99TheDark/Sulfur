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
	loc    *Location
	mode   TokenType
	begin  *Location
	eof    bool
}

func (l *lexer) at() rune {
	return l.source[l.loc.Idx]
}

func (l *lexer) peek() rune {
	return l.source[l.loc.Idx+1]
}

func (l *lexer) eat() rune {
	ch := l.source[l.loc.Idx]

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

func (l *lexer) all(start, end int) string {
	s, e := utils.Min(start, len(l.source)-1), utils.Min(end, len(l.source)-1)
	return string(l.source[s:(e + 1)])
}

func (l *lexer) ahead(ahead int) string {
	return l.all(l.loc.Idx, l.loc.Idx+ahead-1)
}

func (l *lexer) start(mode TokenType) {
	l.mode = mode
	*l.begin = *l.loc
	l.eat()
}

func (l *lexer) end() *Token {
	value := l.all(l.begin.Idx, l.loc.Idx-1)

	var tt TokenType
	if l.mode == Identifier && IsKeyword(value) {
		tt = Keyword
	} else {
		tt = l.mode
	}

	token := CreateToken(
		tt,
		value,
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

func (l *lexer) multiToken(tokentype TokenType, count int) {
	if l.mode != Identifier && l.mode != None {
		l.eat()
	} else {
		if l.mode == Identifier {
			l.add(l.end())
		}
		l.add(CreateToken(
			tokentype,
			l.ahead(count),
			l.loc.Row,
			l.loc.Col,
			l.loc.Idx,
		))

		for i := 0; i < count; i++ {
			l.eat()
		}
	}
}

func (l *lexer) singleToken(tokentype TokenType) {
	l.multiToken(tokentype, 1)
}

func parseKeys[T ~string](l *lexer, keys []T) *T {
	finalKey := (*T)(nil)
	keyLen := 0
	for _, key := range keys {
		if len(key) > keyLen && string(key) == l.ahead(len(key)) {
			finalKey = &key
			keyLen = len(key)
		}
	}
	return finalKey
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
		// TODO: add multiline comments
		if l.mode == None && unicode.IsDigit(l.at()) {
			l.start(Number)
			continue
		} else if l.mode == Number && !unicode.IsDigit(l.at()) {
			l.add(l.end())
		} else if l.ahead(2) == "//" {
			l.start(Comment)
		} else if l.ahead(2) == ":=" {
			l.multiToken(ImplicitAssignment, 2)
		} else {
			switch l.at() {
			case ' ':
				l.singleToken(Space)
			case '\n':
				if l.mode == Comment {
					l.add(l.end())
				}
				l.singleToken(NewLine)
			case '"':
				if l.mode != Comment {
					if l.mode == String {
						l.add(l.end())
						l.eat()
					} else {
						l.eat()
						l.start(String)
					}
				} else {
					l.eat()
				}
			case '(':
				l.singleToken(LeftParen)
			case ')':
				l.singleToken(RightParen)
			case '[':
				l.singleToken(LeftBracket)
			case ']':
				l.singleToken(RightBracket)
			case '{':
				l.singleToken(LeftBrace)
			case '}':
				l.singleToken(RightBrace)
			case ',':
				l.singleToken(Delimiter)
			case '=':
				l.singleToken(Assignment)
			default:
				if tf := parseKeys(l, Booleans); tf != nil {
					l.multiToken(Boolean, len(*tf))
				} else if op := parseKeys(l, Operators); op != nil {
					l.multiToken(Operator, len(*op))
				} else if cmp := parseKeys(l, Comparators); cmp != nil {
					l.multiToken(Comparator, len(*cmp))
				} else if l.mode == None {
					l.start(Identifier)
				} else {
					l.eat()
				}
			}
		}
	}
	if l.mode != None {
		l.add(l.end())
	}
	l.add(CreateToken(EOF, "EOF", l.loc.Row, l.loc.Col, l.loc.Idx))

	return &l.tokens
}

func Filter(tokens *[]Token) *[]Token {
	filter := func(item Token) bool {
		return item.Type != Space && item.Type != NewLine && item.Type != Comment
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

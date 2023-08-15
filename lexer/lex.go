package lexer

import "golang/utils"

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

	if !l.eof {
		l.eat()
	}
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
			l.splitAdd(
				l.singleToken(Space),
				Identifier,
			)
			break
		case '\n':
			l.splitAdd(
				l.singleToken(NewLine),
				Identifier,
			)
			break
		case '(':
			l.splitAdd(
				l.singleToken(LeftParen),
				Identifier,
			)
			break
		case ')':
			l.splitAdd(
				l.singleToken(RightParen),
				Identifier,
			)
			break
		default:
			if l.mode == None {
				l.start(Identifier)
			} else {
				l.eat()
			}
			break
		}
	}
	if l.mode != None {
		l.add(l.end())
	}

	return &l.tokens
}

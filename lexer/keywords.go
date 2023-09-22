package lexer

type Keywords string

const (
	Return Keywords = "return"
	If     Keywords = "if"
	ElseIf Keywords = "elseif"
	Else   Keywords = "else"
)

type Bool string

const (
	True  Bool = "true"
	False Bool = "false"
)

var Booleans = []Bool{True, False}

func IsKeyword(str string) bool {
	switch Keywords(str) {
	case Return:
		return true
	default:
		return false
	}
}

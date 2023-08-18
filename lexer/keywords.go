package lexer

type Keywords string

const (
	True   Keywords = "true"
	False  Keywords = "false"
	Return Keywords = "return"
	If     Keywords = "if"
	ElseIf Keywords = "elseif"
	Else   Keywords = "else"
)

func IsKeyword(str string) bool {
	switch Keywords(str) {
	case Return:
		return true
	default:
		return false
	}
}

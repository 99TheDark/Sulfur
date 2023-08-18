package lexer

type Keywords string

const (
	Return Keywords = "return"
)

func IsKeyword(str string) bool {
	switch Keywords(str) {
	case Return:
		return true
	default:
		return false
	}
}

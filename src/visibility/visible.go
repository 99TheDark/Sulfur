package visibility

import (
	"encoding/json"
	"sulfur/src/lexer"
	"sulfur/src/typing"
)

type Visibility int

const (
	Public Visibility = iota
	Private
	Value
)

func (v Visibility) String() string {
	switch v {
	case Public:
		return "Public"
	case Private:
		return "Private"
	case Value:
		return "Value"
	}

	return "Invalid"
}

func (v Visibility) MarshalJSON() ([]byte, error) {
	return json.Marshal(v.String())
}

func TokenVis(tok lexer.Token, auto Visibility, next *typing.Location) (Visibility, *typing.Location) {
	switch tok.Type {
	case lexer.Public:
		return Public, tok.Location
	case lexer.Private:
		return Private, tok.Location
	case lexer.Value:
		return Value, tok.Location
	}

	return auto, next
}

func IsVisibility(tok lexer.Token) bool {
	vis, _ := TokenVis(tok, -1, nil)
	return vis != -1
}

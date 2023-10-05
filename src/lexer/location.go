package lexer

import "fmt"

type Location struct {
	Row int
	Col int
	Idx int
}

func (loc Location) Get() (row, col, idx int) {
	return loc.Row, loc.Col, loc.Idx
}

func (loc *Location) MarshalJSON() ([]byte, error) {
	return []byte("\"" + fmt.Sprint(loc.Row) + ":" + fmt.Sprint(loc.Col) + " #" + fmt.Sprint(loc.Idx) + "\""), nil
}

func NewLocation(row, col, idx int) *Location {
	return &Location{
		row,
		col,
		idx,
	}
}

var NoLocation = NewLocation(0, 0, 0)

package lexer

type Location struct {
	Row int
	Col int
	Idx int
}

func (loc Location) Get() (int, int, int) {
	return loc.Row, loc.Col, loc.Idx
}

func CreateLocation(row, col, idx int) *Location {
	return &Location{
		row,
		col,
		idx,
	}
}

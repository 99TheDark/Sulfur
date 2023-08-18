package lexer

type Comparison string

const (
	LessThan           Comparison = "<"
	GreaterThan        Comparison = ">"
	LessThanOrEqual    Comparison = "<="
	GreaterThanOrEqual Comparison = ">="
	Equal              Comparison = "=="
	NotEqual           Comparison = "!="
)

var Comparators = []Comparison{
	LessThan,
	GreaterThan,
	LessThanOrEqual,
	GreaterThanOrEqual,
	Equal,
	NotEqual,
}

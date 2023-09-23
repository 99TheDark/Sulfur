package lexer

type Comparison string

const (
	IsLessThan           Comparison = "<"
	IsGreaterThan        Comparison = ">"
	IsLessThanOrEqual    Comparison = "<="
	IsGreaterThanOrEqual Comparison = ">="
	IsEqual              Comparison = "=="
	IsNotEqual           Comparison = "!="
)

var Comparators = []Comparison{
	IsLessThan,
	IsGreaterThan,
	IsLessThanOrEqual,
	IsGreaterThanOrEqual,
	IsEqual,
	IsNotEqual,
}

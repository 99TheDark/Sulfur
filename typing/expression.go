package typing

import "golang/parser"

type TypedExpression struct {
	Expression parser.Expression
	Type       string
}

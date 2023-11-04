package parser

import (
	"strconv"
	"sulfur/src/ast"
	"sulfur/src/typing"
)

func parseInteger(val string, loc *typing.Location) (ast.Integer, bool) {
	if i64, err := strconv.ParseInt(val, 10, 64); err == nil {
		return ast.Integer{
			Pos:   loc,
			Value: i64,
		}, true
	}
	return ast.Integer{}, false
}

func parseUnsignedInt(val string, loc *typing.Location) (ast.UnsignedInteger, bool) {
	if u64, err := strconv.ParseUint(val, 10, 64); err == nil {
		return ast.UnsignedInteger{
			Pos:   loc,
			Value: u64,
		}, true
	}
	return ast.UnsignedInteger{}, false
}

func parseFloat(val string, loc *typing.Location) (ast.Float, bool) {
	if f64, err := strconv.ParseFloat(val, 64); err == nil {
		return ast.Float{
			Pos:   loc,
			Value: f64,
		}, true
	}
	return ast.Float{}, false
}

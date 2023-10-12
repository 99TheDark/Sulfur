package lexer

var NoName = "none"

func (tt TokenType) OperatorName() string {
	switch tt {
	case Addition:
		return "add"
	case Subtraction:
		return "sub"
	case Multiplication:
		return "mul"
	case Division:
		return "div"
	case Exponentiation:
		return "pow"
	case Modulus:
		return "rem"
	case Or:
		return "or"
	case And:
		return "and"
	case Nor:
		return "nor"
	case Nand:
		return "nand"
	default:
		return NoName
	}
}

func (tt TokenType) ComparisonName() string {
	switch tt {
	case EqualTo:
		return "eq"
	case GreaterThan:
		return "gt"
	case LessThan:
		return "lt"
	case Index:
		return "idx"
	default:
		return NoName
	}
}

func (tt TokenType) IsOperator() bool {
	return tt.OperatorName() != NoName
}

func (tt TokenType) IsComparison() bool {
	return tt.ComparisonName() != NoName
}

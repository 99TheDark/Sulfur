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
	case Increment:
		return "inc"
	case Decrement:
		return "dec"
	case Or:
		return "or"
	case And:
		return "and"
	case Nor:
		return "nor"
	case Nand:
		return "nand"
	case Not:
		return "not"
	case RightShift:
		return "shr"
	case LeftShift:
		return "shl"
	case ZeroFillRightShift:
		return "zshr"
	case CountLeadingZeros:
		return "clz"
	case CountTrailingZeros:
		return "ctz"
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

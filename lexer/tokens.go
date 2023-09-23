package lexer

import (
	"fmt"
	"strings"
)

type TokenType int

type Token struct {
	Type     TokenType
	Value    string
	Location *Location
}

const (
	None                 TokenType = iota
	Identifier                     // identifier
	WhiteSpace                     // ' '
	NewLine                        // '\n'
	SingleLineComment              // '//'
	MultiLineComment               // '/*' -> '*/'
	OpenBrace                      // '{'
	CloseBrace                     // '}'
	OpenParen                      // '('
	CloseParen                     // ')'
	OpenBracket                    // '['
	CloseBracket                   // ']'
	Number                         // '3.5', '7', '-2'
	Boolean                        // 'true', 'false'
	String                         // '"' -> some text -> '"'
	Assignment                     // operator? -> '='
	ImplicitDeclaration            // ':='
	Increment                      // '++'
	Decrement                      // '--'
	Addition                       // '+'
	Subtraction                    // '-'
	Multiplication                 // '*'
	Division                       // '/'
	Exponentiation                 // '^'
	Modulus                        // '%'
	Or                             // '|'
	And                            // '&'
	Nor                            // '!|'
	Nand                           // '!&'
	Not                            // '!'
	EqualTo                        // '=='
	NotEqualTo                     // '!='
	GreaterThan                    // '>'
	LessThan                       // '<'
	GreaterThanOrEqualTo           // '>='
	LessThanOrEqualTo              // '<='
	Delimiter                      // ','
	Return                         // 'return'
	Break                          // 'break'
	Continue                       // 'continue'
	My                             // 'my'
	Class                          // 'class'
	New                            // 'new'
	Operator                       // 'operator'
	To                             // 'to'
	Extends                        // 'extends'
	From                           // 'from'
	Enum                           // 'enum'
	For                            // 'for'
	In                             // 'in'
	While                          // 'while'
	Do                             // 'do'
	If                             // 'if'
	Else                           // 'else'
	QuestionMark                   // '?'
	Colon                          // ':'
	Null                           // 'null'
	Spread                         // '...'
	Semicolon                      // ';'
)

var Keywords = map[string]TokenType{
	"true":     Boolean,
	"false":    Boolean,
	"return":   Return,
	"break":    Break,
	"continue": Continue,
	"my":       My,
	"class":    Class,
	"new":      New,
	"operator": Operator,
	"to":       To,
	"extends":  Extends,
	"from":     From,
	"enum":     Enum,
	"for":      For,
	"in":       In,
	"while":    While,
	"do":       Do,
	"if":       If,
	"else":     Else,
	"null":     Null,
}

var Symbols = map[string]TokenType{
	"{":   OpenBrace,
	"}":   CloseBrace,
	"(":   OpenParen,
	")":   CloseParen,
	"[":   OpenBracket,
	"]":   CloseBracket,
	":=":  ImplicitDeclaration,
	"+":   Addition,
	"-":   Subtraction,
	"*":   Multiplication,
	"/":   Division,
	"^":   Exponentiation,
	"%":   Modulus,
	"++":  Increment,
	"--":  Decrement,
	"|":   Or,
	"&":   And,
	"!|":  Nor,
	"!&":  Nand,
	"!":   Not,
	"==":  EqualTo,
	"!=":  NotEqualTo,
	">":   GreaterThan,
	"<":   LessThan,
	">=":  GreaterThanOrEqualTo,
	"<=":  LessThanOrEqualTo,
	",":   Delimiter,
	"?":   QuestionMark,
	":":   Colon,
	"...": Spread,
	";":   Semicolon,
}

func formatValue(value string) string {
	return strings.ReplaceAll(value, "\n", "\\n")
}

func CreateToken(tokentype TokenType, value string, row, col, idx int) *Token {
	return &Token{
		tokentype,
		value,
		CreateLocation(row, col, idx),
	}
}

func (tt TokenType) String() string {
	switch tt {
	case Identifier:
		return "Identifier"
	case WhiteSpace:
		return "WhiteSpace"
	case NewLine:
		return "NewLine"
	case SingleLineComment:
		return "SingleLineComment"
	case MultiLineComment:
		return "MultiLineComment"
	case OpenBrace:
		return "OpenBrace"
	case CloseBrace:
		return "CloseBrace"
	case OpenParen:
		return "OpenParen"
	case CloseParen:
		return "CloseParen"
	case OpenBracket:
		return "OpenBracket"
	case CloseBracket:
		return "CloseBracket"
	case Number:
		return "Number"
	case Boolean:
		return "Boolean"
	case String:
		return "String"
	case Assignment:
		return "Assignment"
	case ImplicitDeclaration:
		return "ImplicitDeclaration"
	case Increment:
		return "Increment"
	case Decrement:
		return "Decrement"
	case Addition:
		return "Addition"
	case Subtraction:
		return "Subtraction"
	case Multiplication:
		return "Multiplication"
	case Division:
		return "Division"
	case Exponentiation:
		return "Exponentiation"
	case Modulus:
		return "Modulus"
	case Or:
		return "Or"
	case And:
		return "And"
	case Nor:
		return "Nor"
	case Nand:
		return "Nand"
	case Not:
		return "Not"
	case EqualTo:
		return "EqualTo"
	case NotEqualTo:
		return "NotEqualTo"
	case GreaterThan:
		return "GreaterThan"
	case LessThan:
		return "LessThan"
	case GreaterThanOrEqualTo:
		return "GreaterThanOrEqualTo"
	case LessThanOrEqualTo:
		return "LessThanOrEqualTo"
	case Delimiter:
		return "Delimiter"
	case Return:
		return "Return"
	case Break:
		return "Break"
	case Continue:
		return "Continue"
	case My:
		return "My"
	case Class:
		return "Class"
	case New:
		return "New"
	case Operator:
		return "Operator"
	case To:
		return "To"
	case Extends:
		return "Extends"
	case From:
		return "From"
	case Enum:
		return "Enum"
	case For:
		return "For"
	case In:
		return "In"
	case While:
		return "While"
	case Do:
		return "Do"
	case If:
		return "If"
	case Else:
		return "Else"
	case QuestionMark:
		return "QuestionMark"
	case Colon:
		return "Colon"
	case Null:
		return "Null"
	case Spread:
		return "Spread"
	case Semicolon:
		return "Semicolon"
	default:
		return "Unknown"
	}
}

func (t Token) String() string {
	row, col, idx := t.Location.Get()

	return "Token{" + t.Type.String() + " '" + formatValue(t.Value) + "' at " +
		fmt.Sprint(row) + ":" + fmt.Sprint(col) + ", #" + fmt.Sprint(idx) + "}"
}

package lexer

import (
	"encoding/json"
	"fmt"
	"strings"
)

type TokenType int

type Token struct {
	Type     TokenType
	Value    string
	Location *Location `json:"-"`
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
	Number                         // '3',  '.15', '-2', '-6.2'
	Boolean                        // 'true', 'false'
	String                         // '"' -> some text -> '"'
	Assignment                     // '='
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
	Is                             // 'is'
	EqualTo                        // '=='
	NotEqualTo                     // '!='
	GreaterThan                    // '>'
	LessThan                       // '<'
	GreaterThanOrEqualTo           // '>='
	LessThanOrEqualTo              // '<='
	Delimiter                      // ','
	Access                         // '.'
	Index                          // '[]'
	Module                         // 'mod'
	Return                         // 'return'
	Pipe                           // '|>'
	Break                          // 'break'
	Continue                       // 'continue'
	Fallthrough                    // 'fallthrough'
	Func                           // 'func'
	Defer                          // 'defer'
	My                             // 'my'
	Class                          // 'class'
	New                            // 'new'
	Delete                         // 'del'
	Operator                       // 'operator'
	To                             // 'to'
	Extends                        // 'extends'
	Public                         // 'pub'
	Private                        // 'pri'
	Value                          // 'val'
	Static                         // 'stat'
	From                           // 'from'
	Enum                           // 'enum'
	For                            // 'for'
	In                             // 'in'
	While                          // 'while'
	Do                             // 'do'
	If                             // 'if'
	Else                           // 'else'
	Match                          // 'match'
	Yield                          // 'yield'
	QuestionMark                   // '?'
	Colon                          // ':'
	Null                           // 'null'
	Nullish                        // '??'
	Spread                         // '...'
	Semicolon                      // ';'
	Import                         // 'import'
	Export                         // 'export'
	Test                           // 'test'
	Assert                         // 'assert'
	Throws                         // 'throws'
	Catch                          // 'catch'
	Okay                           // 'okay'
	Arrow                          // '=>'
	Atsign                         // '@'
	Autodef                        // '~'
	EOF
)

var Keywords = map[string]TokenType{
	"true":        Boolean,
	"false":       Boolean,
	"is":          Is,
	"mod":         Module,
	"return":      Return,
	"break":       Break,
	"continue":    Continue,
	"fallthrough": Fallthrough,
	"func":        Func,
	"defer":       Defer,
	"my":          My,
	"class":       Class,
	"new":         New,
	"del":         Delete,
	"operator":    Operator,
	"to":          To,
	"extends":     Extends,
	"pub":         Public,
	"pri":         Private,
	"val":         Value,
	"stat":        Static,
	"from":        From,
	"enum":        Enum,
	"for":         For,
	"in":          In,
	"while":       While,
	"do":          Do,
	"if":          If,
	"else":        Else,
	"match":       Match,
	"yield":       Yield,
	"null":        Null,
	"import":      Import,
	"export":      Export,
	"test":        Test,
	"assert":      Assert,
	"throws":      Throws,
	"catch":       Catch,
	"okay":        Okay,
}

var Symbols = map[string]TokenType{
	"\n":  NewLine,
	"{":   OpenBrace,
	"}":   CloseBrace,
	"(":   OpenParen,
	")":   CloseParen,
	"[":   OpenBracket,
	"]":   CloseBracket,
	"=":   Assignment,
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
	".":   Access,
	"[]":  Index,
	"|>":  Pipe,
	"?":   QuestionMark,
	":":   Colon,
	"??":  Nullish,
	"...": Spread,
	";":   Semicolon,
	"=>":  Arrow,
	"@":   Atsign,
	"~":   Autodef,
}

func formatValue(value string) string {
	return strings.ReplaceAll(value, "\n", "\\n")
}

func NewToken(tokentype TokenType, value string, row, col, idx int) *Token {
	return &Token{
		tokentype,
		value,
		NewLocation(row, col, idx),
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
	case Is:
		return "Is"
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
	case Access:
		return "Access"
	case Module:
		return "Module"
	case Return:
		return "Return"
	case Pipe:
		return "Pipe"
	case Break:
		return "Break"
	case Continue:
		return "Continue"
	case Fallthrough:
		return "Fallthrough"
	case Func:
		return "Func"
	case Defer:
		return "Defer"
	case My:
		return "My"
	case Class:
		return "Class"
	case New:
		return "New"
	case Delete:
		return "Delete"
	case Operator:
		return "Operator"
	case To:
		return "To"
	case Extends:
		return "Extends"
	case Public:
		return "Public"
	case Private:
		return "Private"
	case Value:
		return "Value"
	case Static:
		return "Static"
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
	case Match:
		return "Match"
	case Yield:
		return "Yield"
	case QuestionMark:
		return "QuestionMark"
	case Colon:
		return "Colon"
	case Null:
		return "Null"
	case Nullish:
		return "Nullish"
	case Spread:
		return "Spread"
	case Semicolon:
		return "Semicolon"
	case Import:
		return "Import"
	case Export:
		return "Export"
	case Test:
		return "Test"
	case Assert:
		return "Assert"
	case Throws:
		return "Throws"
	case Catch:
		return "Catch"
	case Okay:
		return "Okay"
	case Arrow:
		return "Arrow"
	case Atsign:
		return "Atsign"
	case Autodef:
		return "Autodef"
	case EOF:
		return "EOF"
	default:
		return "Unknown"
	}
}

func (tt TokenType) MarshalJSON() ([]byte, error) {
	return json.Marshal(tt.String())
}

func (t Token) String() string {
	row, col, idx := t.Location.Get()

	return "Token{" + t.Type.String() + " '" + formatValue(t.Value) + "' at " +
		fmt.Sprint(row) + ":" + fmt.Sprint(col) + ", #" + fmt.Sprint(idx) + "}"
}

func Empty(tok Token) bool {
	if tok.Location == (*Location)(nil) {
		return true
	}
	return false
}

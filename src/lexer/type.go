package lexer

import (
	"encoding/json"
	"strings"
	"sulfur/src/typing"
)

type TokenType int

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
	Number                         // '3', '.15', '-2', '-6.2'
	NumericalSuffix                // 'u', 'f'
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
	RightShift                     // '>>'
	LeftShift                      // '<<'
	CountLeadingZeros              // '<..'
	CountTrailingZeros             // '>..'
	NaN                            // 'nan'
	Infinity                       // 'inf'
	Is                             // 'is'
	EqualTo                        // '=='
	NotEqualTo                     // '!='
	GreaterThan                    // '>'
	LessThan                       // '<'
	GreaterThanOrEqualTo           // '>='
	LessThanOrEqualTo              // '<='
	Delimiter                      // ','
	Access                         // '.'
	SafeAccess                     // '?.'
	Index                          // '[]'
	Module                         // 'mod'
	Return                         // 'return'
	Pipe                           // '|>'
	Break                          // 'break'
	Continue                       // 'continue'
	Fallthrough                    // 'fallthrough'
	Func                           // 'func'
	Defer                          // 'defer'
	Struct                         // 'struct'
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
	Loop                           // 'loop'
	If                             // 'if'
	Else                           // 'else'
	Match                          // 'match'
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
	Arrow                          // '=>'
	Atsign                         // '@'
	Sizeof                         // 'sizeof'
	EOF
)

var Keywords = map[string]TokenType{
	"true":        Boolean,
	"false":       Boolean,
	"nan":         NaN,
	"inf":         Infinity,
	"is":          Is,
	"mod":         Module,
	"return":      Return,
	"break":       Break,
	"continue":    Continue,
	"fallthrough": Fallthrough,
	"func":        Func,
	"defer":       Defer,
	"struct":      Struct,
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
	"loop":        Loop,
	"if":          If,
	"else":        Else,
	"match":       Match,
	"null":        Null,
	"import":      Import,
	"export":      Export,
	"test":        Test,
	"assert":      Assert,
	"throws":      Throws,
	"catch":       Catch,
	"sizeof":      Sizeof,
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
	">>":  RightShift,
	"<<":  LeftShift,
	"<..": CountLeadingZeros,
	">..": CountTrailingZeros,
	"==":  EqualTo,
	"!=":  NotEqualTo,
	">":   GreaterThan,
	"<":   LessThan,
	">=":  GreaterThanOrEqualTo,
	"<=":  LessThanOrEqualTo,
	",":   Delimiter,
	".":   Access,
	"?.":  SafeAccess,
	"[]":  Index,
	"|>":  Pipe,
	"?":   QuestionMark,
	":":   Colon,
	"??":  Nullish,
	"...": Spread,
	";":   Semicolon,
	"=>":  Arrow,
	"@":   Atsign,
}

func formatValue(value string) string {
	return strings.ReplaceAll(value, "\n", "\\n")
}

func NewToken(tokentype TokenType, value string, row, col, idx int) *Token {
	return &Token{
		tokentype,
		value,
		typing.NewLocation(row, col, idx),
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
	case NumericalSuffix:
		return "NumericalSuffix"
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
	case RightShift:
		return "RightShift"
	case LeftShift:
		return "LeftShift"
	case CountLeadingZeros:
		return "CountLeadingZeros"
	case CountTrailingZeros:
		return "CountTrailingZeros"
	case NaN:
		return "NaN"
	case Infinity:
		return "Infinity"
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
	case SafeAccess:
		return "SafeAccess"
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
	case Struct:
		return "Struct"
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
	case Loop:
		return "Loop"
	case If:
		return "If"
	case Else:
		return "Else"
	case Match:
		return "Match"
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
	case Arrow:
		return "Arrow"
	case Atsign:
		return "Atsign"
	case Sizeof:
		return "Sizeof"
	case EOF:
		return "EOF"
	default:
		return "Unknown"
	}
}

func (tt TokenType) MarshalJSON() ([]byte, error) {
	return json.Marshal(tt.String())
}

// New version:
type TokenCatagory int

// TODO: Remove Cat prefix
const (
	CatNone TokenCatagory = iota
	CatKeyword
	CatSymbol
)

// TODO: Change from TokenMetadata to TokenType
type TokenMetadata struct {
	Name     string
	String   string
	Catagory TokenCatagory
}

type TokenList struct {
	Identifier           TokenMetadata
	WhiteSpace           TokenMetadata
	NewLine              TokenMetadata
	SingleLineComment    TokenMetadata
	MultiLineComment     TokenMetadata
	OpenBrace            TokenMetadata
	CloseBrace           TokenMetadata
	OpenParen            TokenMetadata
	CloseParen           TokenMetadata
	OpenBracket          TokenMetadata
	CloseBracket         TokenMetadata
	Number               TokenMetadata
	NumericalSuffix      TokenMetadata
	Boolean              TokenMetadata
	String               TokenMetadata
	Assignment           TokenMetadata
	ImplicitDeclaration  TokenMetadata
	Increment            TokenMetadata
	Decrement            TokenMetadata
	Addition             TokenMetadata
	Subtraction          TokenMetadata
	Multiplication       TokenMetadata
	Division             TokenMetadata
	Exponentiation       TokenMetadata
	Modulus              TokenMetadata
	Or                   TokenMetadata
	And                  TokenMetadata
	Nor                  TokenMetadata
	Nand                 TokenMetadata
	Not                  TokenMetadata
	RightShift           TokenMetadata
	LeftShift            TokenMetadata
	CountLeadingZeros    TokenMetadata
	CountTrailingZeros   TokenMetadata
	NaN                  TokenMetadata
	Infinity             TokenMetadata
	Is                   TokenMetadata
	EqualTo              TokenMetadata
	NotEqualTo           TokenMetadata
	GreaterThan          TokenMetadata
	LessThan             TokenMetadata
	GreaterThanOrEqualTo TokenMetadata
	LessThanOrEqualTo    TokenMetadata
	Delimiter            TokenMetadata
	Access               TokenMetadata
	SafeAccess           TokenMetadata
	Index                TokenMetadata
	Module               TokenMetadata
	Return               TokenMetadata
	Pipe                 TokenMetadata
	Break                TokenMetadata
	Continue             TokenMetadata
	Fallthrough          TokenMetadata
	Function             TokenMetadata
	Defer                TokenMetadata
	Struct               TokenMetadata
	Class                TokenMetadata
	New                  TokenMetadata
	Delete               TokenMetadata
	Operator             TokenMetadata
	To                   TokenMetadata
	Extends              TokenMetadata
	Public               TokenMetadata
	Private              TokenMetadata
	Value                TokenMetadata
	Static               TokenMetadata
	From                 TokenMetadata
	Enum                 TokenMetadata
	For                  TokenMetadata
	While                TokenMetadata
	Do                   TokenMetadata
	Loop                 TokenMetadata
	If                   TokenMetadata
	Else                 TokenMetadata
	Match                TokenMetadata
	QuestionMark         TokenMetadata
	Colon                TokenMetadata
	Null                 TokenMetadata
	Nullish              TokenMetadata
	Spread               TokenMetadata
	Semicolon            TokenMetadata
	Import               TokenMetadata
	Export               TokenMetadata
	Test                 TokenMetadata
	Assert               TokenMetadata
	Throws               TokenMetadata
	Throw                TokenMetadata
	Try                  TokenMetadata
	Catch                TokenMetadata
	Arrow                TokenMetadata
	Atsign               TokenMetadata
	EOF                  TokenMetadata
}

var Tokens = TokenList{
	Identifier: TokenMetadata{
		"Identifier",
		"identifier",
		CatNone,
	},
	WhiteSpace: TokenMetadata{
		"WhiteSpace",
		"whitespace",
		CatNone,
	},
	NewLine: TokenMetadata{
		"NewLine",
		"\\n",
		CatSymbol,
	},
	SingleLineComment: TokenMetadata{
		"SingleLineComment",
		"//",
		CatNone,
	},
	MultiLineComment: TokenMetadata{
		"MultiLineComment",
		"/* */",
		CatNone,
	},
	OpenBrace: TokenMetadata{
		"OpenBrace",
		"{",
		CatSymbol,
	},
	CloseBrace: TokenMetadata{
		"CloseBrace",
		"}",
		CatSymbol,
	},
	OpenParen: TokenMetadata{
		"OpenParen",
		"(",
		CatSymbol,
	},
	CloseParen: TokenMetadata{
		"CloseParen",
		")",
		CatSymbol,
	},
	OpenBracket: TokenMetadata{
		"OpenBracket",
		"[",
		CatSymbol,
	},
	CloseBracket: TokenMetadata{
		"CloseBracket",
		"]",
		CatSymbol,
	},
	Number: TokenMetadata{
		"Number",
		"number",
		CatNone,
	},
	NumericalSuffix: TokenMetadata{
		"NumericalSuffix",
		"numerical suffix",
		CatNone,
	},
	Boolean: TokenMetadata{
		"Boolean",
		"bool", // TODO: Make true / false
		CatKeyword,
	},
	String: TokenMetadata{
		"String",
		"string",
		CatKeyword,
	},
	Assignment: TokenMetadata{
		"Assignment",
		"=",
		CatSymbol,
	},
	ImplicitDeclaration: TokenMetadata{
		"ImplicitDeclaration",
		":=",
		CatSymbol,
	},
	Increment: TokenMetadata{
		"Increment",
		"++",
		CatSymbol,
	},
	Decrement: TokenMetadata{
		"Decrement",
		"--",
		CatSymbol,
	},
	Addition: TokenMetadata{
		"Addition",
		"+",
		CatSymbol,
	},
	Subtraction: TokenMetadata{
		"Subtraction",
		"-",
		CatSymbol,
	},
	Multiplication: TokenMetadata{
		"Multiplication",
		"*",
		CatSymbol,
	},
	Division: TokenMetadata{
		"Division",
		"/",
		CatSymbol,
	},
	Exponentiation: TokenMetadata{
		"Exponentiation",
		"^",
		CatSymbol,
	},
	Modulus: TokenMetadata{
		"Modulus",
		"%",
		CatSymbol,
	},
	Or: TokenMetadata{
		"Or",
		"|",
		CatSymbol,
	},
	And: TokenMetadata{
		"And",
		"&",
		CatSymbol,
	},
	Nor: TokenMetadata{
		"Nor",
		"!|",
		CatSymbol,
	},
	Nand: TokenMetadata{
		"Nand",
		"!&",
		CatSymbol,
	},
	Not: TokenMetadata{
		"Not",
		"!",
		CatSymbol,
	},
	RightShift: TokenMetadata{
		"RightShift",
		">>",
		CatSymbol,
	},
	LeftShift: TokenMetadata{
		"LeftShift",
		"<<",
		CatSymbol,
	},
	CountLeadingZeros: TokenMetadata{
		"CountLeadingZeros",
		"<..",
		CatSymbol,
	},
	CountTrailingZeros: TokenMetadata{
		"CountTrailingZeros",
		">..",
		CatSymbol,
	},
	NaN: TokenMetadata{
		"NaN",
		"nan",
		CatKeyword,
	},
	Infinity: TokenMetadata{
		"Infinity",
		"inf",
		CatKeyword,
	},
	Is: TokenMetadata{
		"Is",
		"is",
		CatKeyword,
	},
	EqualTo: TokenMetadata{
		"EqualTo",
		"==",
		CatSymbol,
	},
	NotEqualTo: TokenMetadata{
		"NotEqualTo",
		"!=",
		CatSymbol,
	},
	GreaterThan: TokenMetadata{
		"GreaterThan",
		">",
		CatSymbol,
	},
	LessThan: TokenMetadata{
		"LessThan",
		"<",
		CatSymbol,
	},
	GreaterThanOrEqualTo: TokenMetadata{
		"GreaterThanOrEqualTo",
		">=",
		CatSymbol,
	},
	LessThanOrEqualTo: TokenMetadata{
		"LessThanOrEqualTo",
		"<=",
		CatSymbol,
	},
	Delimiter: TokenMetadata{
		"Delimiter",
		",",
		CatSymbol,
	},
	Access: TokenMetadata{
		"Access",
		".",
		CatSymbol,
	},
	SafeAccess: TokenMetadata{
		"SaveAccess",
		"?.",
		CatSymbol,
	},
	Index: TokenMetadata{
		"Index",
		"[]",
		CatSymbol,
	},
	Module: TokenMetadata{
		"Module",
		"mod",
		CatKeyword,
	},
	Return: TokenMetadata{
		"Return",
		"return",
		CatKeyword,
	},
	Pipe: TokenMetadata{
		"Pipe",
		"|>",
		CatSymbol,
	},
	Break: TokenMetadata{
		"Break",
		"break",
		CatKeyword,
	},
	Continue: TokenMetadata{
		"Continue",
		"continue",
		CatKeyword,
	},
	Fallthrough: TokenMetadata{
		"Fallthrough",
		"fallthrough",
		CatKeyword,
	},
	Function: TokenMetadata{
		"Function",
		"func",
		CatKeyword,
	},
	Defer: TokenMetadata{
		"Defer",
		"defer",
		CatKeyword,
	},
	Struct: TokenMetadata{
		"Struct",
		"struct",
		CatKeyword,
	},
	Class: TokenMetadata{
		"Class",
		"class",
		CatKeyword,
	},
	New: TokenMetadata{
		"New",
		"new",
		CatKeyword,
	},
	Delete: TokenMetadata{
		"Delete",
		"del",
		CatKeyword,
	},
	Operator: TokenMetadata{
		"Operator",
		"operator",
		CatKeyword,
	},
	To: TokenMetadata{
		"To",
		"to",
		CatKeyword,
	},
	Extends: TokenMetadata{
		"Extends",
		"extends",
		CatKeyword,
	},
	Public: TokenMetadata{
		"Public",
		"pub",
		CatKeyword,
	},
	Private: TokenMetadata{
		"Private",
		"pri",
		CatKeyword,
	},
	Value: TokenMetadata{
		"Value",
		"val",
		CatKeyword,
	},
	Static: TokenMetadata{
		"Static",
		"stat",
		CatKeyword,
	},
	From: TokenMetadata{
		"From",
		"from",
		CatKeyword,
	},
	Enum: TokenMetadata{
		"Enum",
		"enum",
		CatKeyword,
	},
	For: TokenMetadata{
		"For",
		"for",
		CatKeyword,
	},
	While: TokenMetadata{
		"While",
		"while",
		CatKeyword,
	},
	Do: TokenMetadata{
		"Do",
		"do",
		CatKeyword,
	},
	Loop: TokenMetadata{
		"Loop",
		"loop",
		CatKeyword,
	},
	If: TokenMetadata{
		"If",
		"if",
		CatKeyword,
	},
	Else: TokenMetadata{
		"Else",
		"else",
		CatKeyword,
	},
	Match: TokenMetadata{
		"Match",
		"match",
		CatKeyword,
	},
	QuestionMark: TokenMetadata{
		"QuestionMark",
		"?",
		CatSymbol,
	},
	Colon: TokenMetadata{
		"Colon",
		":",
		CatSymbol,
	},
	Null: TokenMetadata{
		"Null",
		"null",
		CatKeyword,
	},
	Nullish: TokenMetadata{
		"Nullish",
		"??",
		CatSymbol,
	},
	Spread: TokenMetadata{
		"Spread",
		"...",
		CatSymbol,
	},
	Semicolon: TokenMetadata{
		"Semicolon",
		";",
		CatSymbol,
	},
	Import: TokenMetadata{
		"Import",
		"import",
		CatKeyword,
	},
	Export: TokenMetadata{
		"Export",
		"export",
		CatKeyword,
	},
	Test: TokenMetadata{
		"Test",
		"test",
		CatKeyword,
	},
	Assert: TokenMetadata{
		"Assert",
		"assert",
		CatKeyword,
	},
	Throws: TokenMetadata{
		"Throws",
		"throws",
		CatKeyword,
	},
	Throw: TokenMetadata{
		"Throw",
		"throw",
		CatKeyword,
	},
	Try: TokenMetadata{
		"Try",
		"try",
		CatKeyword,
	},
	Catch: TokenMetadata{
		"Catch",
		"catch",
		CatKeyword,
	},
	Arrow: TokenMetadata{
		"Arrow",
		"=>",
		CatSymbol,
	},
	Atsign: TokenMetadata{
		"Atsign",
		"@",
		CatSymbol,
	},
	EOF: TokenMetadata{
		"EOF",
		"end of file",
		CatNone,
	},
}

package lexer

type Operation string

const (
	Add      Operation = "+"
	Subtract Operation = "-"
	Multiply Operation = "*"
	Divide   Operation = "/"
	Modulo   Operation = "%"
)
